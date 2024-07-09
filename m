Return-Path: <linux-rdma+bounces-3762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197892B180
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517A41C211E5
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7E147C82;
	Tue,  9 Jul 2024 07:49:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C26C148;
	Tue,  9 Jul 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511375; cv=none; b=E0njekvXV8Rc4gWol0i6iLqtC7lVSikCi2R8DUT1CHtzLKifQzMDkPQGJjq1KvYbxF5zVfOlSpnsQSYA8jrBFtT/uz5GUpRXl3JUWvzxWUvS5ht4IFHLJ+6D5R6nE2MiUvohQBdB5nXcVUlP/FopEcw14MqCemEqt6y0T84Jr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511375; c=relaxed/simple;
	bh=QOA9P/hX3/L1HSZjaMT+kMTYQ84x2txVmaCQHHidneU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TwZ+7AlqIyeanqixpp9rYevZjTBPHXKUKPXo7Vpt4fpBSDAdMKMT4+X4YitiE7a92VkmOzLGyz76aOF6lyD/Lmzp+8xEu48znQWTavT69ywwSLEQfJqbDcjPpbSQU2KEaE6xfWmtUeqitD+JSbyjoApNoE6ShgYZXxEdixG+mP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJCgp745tzxSCl;
	Tue,  9 Jul 2024 15:44:54 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E84D718007E;
	Tue,  9 Jul 2024 15:49:28 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jul 2024 15:49:28 +0800
Message-ID: <86c1136a-b81f-fb3d-824d-efb61f50f899@hisilicon.com>
Date: Tue, 9 Jul 2024 15:49:27 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-rc 2/9] RDMA/hns: Fix a long wait for cmdq event
 during reset
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240708053850.GA6788@unreal>
 <7cae577b-e469-9357-8375-d14746a7787b@hisilicon.com>
 <20240708073315.GC6788@unreal>
 <0bac285b-c8ae-8c9f-7c42-ee345f8682d1@hisilicon.com>
 <20240708082755.GD6788@unreal>
 <26c02b2b-4232-2049-5c9f-f757fef759a0@hisilicon.com>
 <20240708085902.GF6788@unreal>
 <188e9f5d-b66c-9318-601c-ed3aab96115d@hisilicon.com>
 <20240708111626.GG6788@unreal>
 <0d877e06-a4af-d3af-7dbb-98135219367f@hisilicon.com>
 <20240709072225.GB6668@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240709072225.GB6668@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/7/9 15:22, Leon Romanovsky wrote:
> On Tue, Jul 09, 2024 at 02:21:31PM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/7/8 19:16, Leon Romanovsky wrote:
>>> On Mon, Jul 08, 2024 at 05:30:58PM +0800, Junxian Huang wrote:
>>>>
>>>>
>>>> On 2024/7/8 16:59, Leon Romanovsky wrote:
>>>>> On Mon, Jul 08, 2024 at 04:45:34PM +0800, Junxian Huang wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/7/8 16:27, Leon Romanovsky wrote:
>>>>>>> On Mon, Jul 08, 2024 at 03:46:26PM +0800, Junxian Huang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2024/7/8 15:33, Leon Romanovsky wrote:
>>>>>>>>> On Mon, Jul 08, 2024 at 02:50:50PM +0800, Junxian Huang wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2024/7/8 13:38, Leon Romanovsky wrote:
>>>>>>>>>>> On Mon, Jul 08, 2024 at 10:29:54AM +0800, Junxian Huang wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2024/7/7 16:30, Leon Romanovsky wrote:
>>>>>>>>>>>>> On Fri, Jul 05, 2024 at 04:59:30PM +0800, Junxian Huang wrote:
>>>>>>>>>>>>>> From: wenglianfa <wenglianfa@huawei.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> During reset, cmdq events won't be reported, leading to a long and
>>>>>>>>>>>>>> unnecessary wait. Notify all the cmdqs to stop waiting at the beginning
>>>>>>>>>>>>>> of reset.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
>>>>>>>>>>>>>> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
>>>>>>>>>>>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++++++++
>>>>>>>>>>>>>>  1 file changed, 18 insertions(+)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>>>>>>>>>>>> index a5d746a5cc68..ff135df1a761 100644
>>>>>>>>>>>>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>>>>>>>>>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>>>>>>>>>>>> @@ -6977,6 +6977,21 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +static void hns_roce_v2_reset_notify_cmd(struct hns_roce_dev *hr_dev)
>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>> +	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
>>>>>>>>>>>>>> +	int i;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +	if (!hr_dev->cmd_mod)
>>>>>>>>>>>>>
>>>>>>>>>>>>> What prevents cmd_mod from being changed?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> It's set when the device is being initialized, and won't be changed after that.
>>>>>>>>>>>
>>>>>>>>>>> This is exactly the point, you are assuming that the device is already
>>>>>>>>>>> ininitialized or not initialized at all. What prevents hns_roce_v2_reset_notify_cmd()
>>>>>>>>>>> from being called in the middle of initialization?
>>>>>>>>>>>
>>>>>>>>>>> Thanks
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This is ensured by hns3 NIC driver.
>>>>>>>>>>
>>>>>>>>>> Initialization and reset of hns RoCE are both called by hns3. It will check the state
>>>>>>>>>> of RoCE device (see line 3798), and notify RoCE device to reset (hns_roce_v2_reset_notify_cmd()
>>>>>>>>>> is called) only if the RoCE device has been already initialized:
>>>>>>>>>
>>>>>>>>> So why do you have "if (!hr_dev->cmd_mod)" check in the code?
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>
>>>>>>>> cmd_mod indicates the mode of cmdq (0: poll mode, 1: event mode).
>>>>>>>> This patch only affects event mode because HW won't report events during reset.
>>>>>>>
>>>>>>> You set cmd_mod to 1 in hns_roce_hw_v2_init_instance() without any
>>>>>>> condition, I don't see when hns v2 IB device is created and continue
>>>>>>> to operate in polling mode. 
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>
>>>>>> Event mode is the default. In hns_roce_cmd_use_events(), if kcalloc() fails
>>>>>> then it'll be set to polling mode instead.
>>>>>
>>>>> 1. Awesome, and we are returning back to the question. What prevents
>>>>>    hns_roce_v2_reset_notify_cmd() from being called in the middle of
>>>>>    changing cmd_mod from 1 to 0 and from 0 to 1?
>>>>
>>>> The changing of cmd_mod is during the initialization of a device. The call
>>>> of hns_roce_v2_reset_notify_cmd() is during reset. As I said previously,
>>>> the hns3 NIC driver ensures that there will be no concurrency between
>>>> initialization and reset, and therefore hns_roce_v2_reset_notify_cmd() won't
>>>> be called in the middle of changing cmd_mod.
>>>>
>>>>> 2. This cmd_mode swtich from 1 to 0 should be removed. Failure to
>>>>>    allocate memory is not a reason to switch to polling mode. The reason
>>>>>    can be HW limitation, but not OS limitation.
>>>>>
>>>>
>>>> But event mode relies on the allocated resource. If the allocation fails and
>>>> we don't switch to polling mode, the driver won't work any more. Are you suggesting
>>>> we should return an error and fail the initialization in this case?
>>>
>>> Yes, please.
>>
>> The reason of switching cmd_mod is that we try to keep the driver available,
>> even if the allocation of event mode resources fails. We don't consider this
>> as a critical error that should lead to an initialization failure. The driver
>> can still post mailbox and provide normal functionality in this case.
> 
> Driver that failed to allocate memory in the middle of initialization
> can't be considered as "normal".
> 
>>
>> Our discussion seems to have strayed a bit away？This patch doesn't involve
>> polling mode.
> 
> As long as patch has this line "if (!hr_dev->cmd_mod)", this discussion
> is related to polling mode.
> 
> Thanks
> 

Okay, I'll drop this patch from this patchset in v2 and fix the cmd_mod issues
in another patchset later.

Thanks,
Junxian

>>
>> Junxian
>>
>>>
>>> Thanks
>>>
>>>>
>>>> Junxian
>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>> Junxian
>>>>>>
>>>>>>>>
>>>>>>>> Junxian
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>  3791 static int hclge_notify_roce_client(struct hclge_dev *hdev,
>>>>>>>>>>  3792                                     enum hnae3_reset_notify_type type)
>>>>>>>>>>  3793 {
>>>>>>>>>>  3794         struct hnae3_handle *handle = &hdev->vport[0].roce;
>>>>>>>>>>  3795         struct hnae3_client *client = hdev->roce_client;
>>>>>>>>>>  3796         int ret;
>>>>>>>>>>  3797
>>>>>>>>>>  3798         if (!test_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state) || !client)
>>>>>>>>>>  3799                 return 0;
>>>>>>>>>>  3800
>>>>>>>>>>  3801         if (!client->ops->reset_notify)
>>>>>>>>>>  3802                 return -EOPNOTSUPP;
>>>>>>>>>>  3803
>>>>>>>>>>  3804         ret = client->ops->reset_notify(handle, type);
>>>>>>>>>>  3805         if (ret)
>>>>>>>>>>  3806                 dev_err(&hdev->pdev->dev, "notify roce client failed %d(%d)",
>>>>>>>>>>  3807                         type, ret);
>>>>>>>>>>  3808
>>>>>>>>>>  3809         return ret;
>>>>>>>>>>  3810 }
>>>>>>>>>>
>>>>>>>>>> And the bit is set (see line 11246) after the initialization has been done (line 11242):
>>>>>>>>>>
>>>>>>>>>> 11224 static int hclge_init_roce_client_instance(struct hnae3_ae_dev *ae_dev,
>>>>>>>>>> 11225                                            struct hclge_vport *vport)
>>>>>>>>>> 11226 {
>>>>>>>>>> 11227         struct hclge_dev *hdev = ae_dev->priv;
>>>>>>>>>> 11228         struct hnae3_client *client;
>>>>>>>>>> 11229         int rst_cnt;
>>>>>>>>>> 11230         int ret;
>>>>>>>>>> 11231
>>>>>>>>>> 11232         if (!hnae3_dev_roce_supported(hdev) || !hdev->roce_client ||
>>>>>>>>>> 11233             !hdev->nic_client)
>>>>>>>>>> 11234                 return 0;
>>>>>>>>>> 11235
>>>>>>>>>> 11236         client = hdev->roce_client;
>>>>>>>>>> 11237         ret = hclge_init_roce_base_info(vport);
>>>>>>>>>> 11238         if (ret)
>>>>>>>>>> 11239                 return ret;
>>>>>>>>>> 11240
>>>>>>>>>> 11241         rst_cnt = hdev->rst_stats.reset_cnt;
>>>>>>>>>> 11242         ret = client->ops->init_instance(&vport->roce);
>>>>>>>>>> 11243         if (ret)
>>>>>>>>>> 11244                 return ret;
>>>>>>>>>> 11245
>>>>>>>>>> 11246         set_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state);
>>>>>>>>>> 11247         if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
>>>>>>>>>> 11248             rst_cnt != hdev->rst_stats.reset_cnt) {
>>>>>>>>>> 11249                 ret = -EBUSY;
>>>>>>>>>> 11250                 goto init_roce_err;
>>>>>>>>>> 11251         }
>>>>>>>>>>
>>>>>>>>>> Junxian
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Junxian
>>>>>>>>>>>>
>>>>>>>>>>>>>> +		return;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +	for (i = 0; i < hr_cmd->max_cmds; i++) {
>>>>>>>>>>>>>> +		hr_cmd->context[i].result = -EBUSY;
>>>>>>>>>>>>>> +		complete(&hr_cmd->context[i].done);
>>>>>>>>>>>>>> +	}
>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>  static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>  	struct hns_roce_dev *hr_dev;
>>>>>>>>>>>>>> @@ -6997,6 +7012,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>>>>>>>>>>>>>>  	hr_dev->dis_db = true;
>>>>>>>>>>>>>>  	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> +	/* Complete the CMDQ event in advance during the reset. */
>>>>>>>>>>>>>> +	hns_roce_v2_reset_notify_cmd(hr_dev);
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>  	return 0;
>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>> -- 
>>>>>>>>>>>>>> 2.33.0
>>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
> 

