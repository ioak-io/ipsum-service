defmodule Ipsum.MockTest do
  use Ipsum.DataCase

  alias Ipsum.Mock

  describe "domains" do
    alias Ipsum.Mock.Domain

    @valid_attrs %{description: "some description", name: "some name", stub: %{}}
    @update_attrs %{description: "some updated description", name: "some updated name", stub: %{}}
    @invalid_attrs %{description: nil, name: nil, stub: nil}

    def domain_fixture(attrs \\ %{}) do
      {:ok, domain} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mock.create_domain()

      domain
    end

    test "list_domains/0 returns all domains" do
      domain = domain_fixture()
      assert Mock.list_domains() == [domain]
    end

    test "get_domain!/1 returns the domain with given id" do
      domain = domain_fixture()
      assert Mock.get_domain!(domain.id) == domain
    end

    test "create_domain/1 with valid data creates a domain" do
      assert {:ok, %Domain{} = domain} = Mock.create_domain(@valid_attrs)
      assert domain.description == "some description"
      assert domain.name == "some name"
      assert domain.stub == %{}
    end

    test "create_domain/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mock.create_domain(@invalid_attrs)
    end

    test "update_domain/2 with valid data updates the domain" do
      domain = domain_fixture()
      assert {:ok, %Domain{} = domain} = Mock.update_domain(domain, @update_attrs)
      assert domain.description == "some updated description"
      assert domain.name == "some updated name"
      assert domain.stub == %{}
    end

    test "update_domain/2 with invalid data returns error changeset" do
      domain = domain_fixture()
      assert {:error, %Ecto.Changeset{}} = Mock.update_domain(domain, @invalid_attrs)
      assert domain == Mock.get_domain!(domain.id)
    end

    test "delete_domain/1 deletes the domain" do
      domain = domain_fixture()
      assert {:ok, %Domain{}} = Mock.delete_domain(domain)
      assert_raise Ecto.NoResultsError, fn -> Mock.get_domain!(domain.id) end
    end

    test "change_domain/1 returns a domain changeset" do
      domain = domain_fixture()
      assert %Ecto.Changeset{} = Mock.change_domain(domain)
    end
  end
end
