Return-Path: <linux-rdma+bounces-3706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0BA929C79
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 08:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690E71C208CC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 06:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45CA14267;
	Mon,  8 Jul 2024 06:51:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E8111A8;
	Mon,  8 Jul 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421463; cv=none; b=B7HNNRRuOOeXACEmRDBapx5YDXPKEHg6VIz1HOF5YJUT93xOzDUdxq4FFMhGAmQOI6uRe+E4adjpwpZWCMv3g9YJJLTd7A8tE6zB/7eim3/NxLn7j+gtXOM5oZSz7TJUay4L7hZ9I496tyoItQO08Lqr/QawGR7yTndw5iJ9lQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421463; c=relaxed/simple;
	bh=tQ4cVw023QVbagybtz4d0LSOHsP4hjFekX/2sc2cLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N0dGLWlIVXSXIYQbSc+/S9bXguyJ7xGpELpGqjhyDOopvLlsaPKSqdF3YJe+HofwX+gr8l/c6PRbnAnZ/9C1ysDJcUhI4R6kDU00TKSpQB52JGD3l0hjqsMwOH9GaGa/YXfBdHz6IisdRPcwCgvdthrO1XqpGWB7wPNoLQeLk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WHZR50msQz1X4bn;
	Mon,  8 Jul 2024 14:46:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E93CB14037D;
	Mon,  8 Jul 2024 14:50:51 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jul 2024 14:50:51 +0800
Message-ID: <7cae577b-e469-9357-8375-d14746a7787b@hisilicon.com>
Date: Mon, 8 Jul 2024 14:50:50 +0800
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
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-3-huangjunxian6@hisilicon.com>
 <20240707083007.GE6695@unreal>
 <42e9f7dd-05bd-176f-c5c0-02e200b3f58c@hisilicon.com>
 <20240708053850.GA6788@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240708053850.GA6788@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/7/8 13:38, Leon Romanovsky wrote:
> On Mon, Jul 08, 2024 at 10:29:54AM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/7/7 16:30, Leon Romanovsky wrote:
>>> On Fri, Jul 05, 2024 at 04:59:30PM +0800, Junxian Huang wrote:
>>>> From: wenglianfa <wenglianfa@huawei.com>
>>>>
>>>> During reset, cmdq events won't be reported, leading to a long and
>>>> unnecessary wait. Notify all the cmdqs to stop waiting at the beginning
>>>> of reset.
>>>>
>>>> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
>>>> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++++++++
>>>>  1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> index a5d746a5cc68..ff135df1a761 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> @@ -6977,6 +6977,21 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
>>>>  
>>>>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
>>>>  }
>>>> +
>>>> +static void hns_roce_v2_reset_notify_cmd(struct hns_roce_dev *hr_dev)
>>>> +{
>>>> +	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
>>>> +	int i;
>>>> +
>>>> +	if (!hr_dev->cmd_mod)
>>>
>>> What prevents cmd_mod from being changed?
>>>
>>
>> It's set when the device is being initialized, and won't be changed after that.
> 
> This is exactly the point, you are assuming that the device is already
> ininitialized or not initialized at all. What prevents hns_roce_v2_reset_notify_cmd()
> from being called in the middle of initialization?
> 
> Thanks
> 

This is ensured by hns3 NIC driver.

Initialization and reset of hns RoCE are both called by hns3. It will check the state
of RoCE device (see line 3798), and notify RoCE device to reset (hns_roce_v2_reset_notify_cmd()
is called) only if the RoCE device has been already initialized:

 3791 static int hclge_notify_roce_client(struct hclge_dev *hdev,
 3792                                     enum hnae3_reset_notify_type type)
 3793 {
 3794         struct hnae3_handle *handle = &hdev->vport[0].roce;
 3795         struct hnae3_client *client = hdev->roce_client;
 3796         int ret;
 3797
 3798         if (!test_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state) || !client)
 3799                 return 0;
 3800
 3801         if (!client->ops->reset_notify)
 3802                 return -EOPNOTSUPP;
 3803
 3804         ret = client->ops->reset_notify(handle, type);
 3805         if (ret)
 3806                 dev_err(&hdev->pdev->dev, "notify roce client failed %d(%d)",
 3807                         type, ret);
 3808
 3809         return ret;
 3810 }

And the bit is set (see line 11246) after the initialization has been done (line 11242):

11224 static int hclge_init_roce_client_instance(struct hnae3_ae_dev *ae_dev,
11225                                            struct hclge_vport *vport)
11226 {
11227         struct hclge_dev *hdev = ae_dev->priv;
11228         struct hnae3_client *client;
11229         int rst_cnt;
11230         int ret;
11231
11232         if (!hnae3_dev_roce_supported(hdev) || !hdev->roce_client ||
11233             !hdev->nic_client)
11234                 return 0;
11235
11236         client = hdev->roce_client;
11237         ret = hclge_init_roce_base_info(vport);
11238         if (ret)
11239                 return ret;
11240
11241         rst_cnt = hdev->rst_stats.reset_cnt;
11242         ret = client->ops->init_instance(&vport->roce);
11243         if (ret)
11244                 return ret;
11245
11246         set_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state);
11247         if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
11248             rst_cnt != hdev->rst_stats.reset_cnt) {
11249                 ret = -EBUSY;
11250                 goto init_roce_err;
11251         }

Junxian

>>
>> Junxian
>>
>>>> +		return;
>>>> +
>>>> +	for (i = 0; i < hr_cmd->max_cmds; i++) {
>>>> +		hr_cmd->context[i].result = -EBUSY;
>>>> +		complete(&hr_cmd->context[i].done);
>>>> +	}
>>>> +}
>>>> +
>>>>  static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>>>>  {
>>>>  	struct hns_roce_dev *hr_dev;
>>>> @@ -6997,6 +7012,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>>>>  	hr_dev->dis_db = true;
>>>>  	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
>>>>  
>>>> +	/* Complete the CMDQ event in advance during the reset. */
>>>> +	hns_roce_v2_reset_notify_cmd(hr_dev);
>>>> +
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -- 
>>>> 2.33.0
>>>>
>>

