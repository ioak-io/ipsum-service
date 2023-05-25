import * as Helper from "./helper";

const selfRealm = 100;

export const updatePreset = async (req: any, res: any) => {
  const userId = req.user.user_id;
  const preset: any = await Helper.updatePreset(req.body, userId);
  res.status(200);
  res.send(preset);
  res.end();
};

export const getPreset = async (req: any, res: any) => {
  const userId = req.user?.user_id;
  const presetList: any = await Helper.getPreset(userId);
  res.status(200);
  res.send(presetList);
  res.end();
};


export const deletePreset = async (req: any, res: any) => {
  const userId = req.user.user_id;
  const outcome: any = await Helper.deletePreset(req.params.id);
  res.status(200);
  res.send(outcome);
  res.end();
};
