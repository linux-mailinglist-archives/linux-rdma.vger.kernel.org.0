Return-Path: <linux-rdma+bounces-3707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A1929D29
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4521C20D3F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ADA20DE8;
	Mon,  8 Jul 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmhTwr41"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841B28DA0;
	Mon,  8 Jul 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423999; cv=none; b=ucnTEkLUi8G5gTlW1LZzvhsjA8dcoRDNsT83WSGGTW1UVqHfFNsIQFU5E7MthLisvrITr94UwqofsqxAXQNi5ScTRBOeeHDj/+3hzvXUhi7OMYzqzyqDo4ZP+ioCJJHX8CIEa5HOQcQBkUKflHYCQILsDAa9zJa1zKbLHwdqkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423999; c=relaxed/simple;
	bh=PypY3E4hh0xD50ZTH6n84G/tDDeBnP9IbwO0FmW6t5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9DnN/fIX2hxWG0wNucRpyLHRM3MG1EJeGTo4YQUyGT360SkEcJXLdhVkP72/5Fc5LCfZHWQWe0ibYKvg0yev7/yfq+5AEKDIVpN9Z0quX1HsbdkxH/1Kojax/qQioncYltpXBxWiFfvFu+cEl9rN+S2anB4tEsrM/FIPbIap5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmhTwr41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4310C116B1;
	Mon,  8 Jul 2024 07:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720423999;
	bh=PypY3E4hh0xD50ZTH6n84G/tDDeBnP9IbwO0FmW6t5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmhTwr41+lDbQi5ZuunitXqieUljlLAt7J8TDftoGbjFPIdKQbDl7NwNeS/tVQTh7
	 07RXVIbgpxY4HbDbYRYr/dsawXDfHMt1GjiffTou8+0Yihkcg4hUvuTgSLK3M1tf70
	 NpQOg66482QRFbga+8p/GtRdFGo9TROWuSl1gljN+mA8TJXhqYPefGZns+4GyGwWEB
	 Z1mr3zzn9U3IueQNsH72o8XcTQvDBkA0dB8eOmDV/umW9F4VghV4BIy9yN/nYlZ9A8
	 o1qby7XD5rHV9rOGYwjmBR6jGh9s5GpaYEIVF/qZI34RV4PdNp2N3llszLvyQVDaek
	 9TmpOnp1N+DWw==
Date: Mon, 8 Jul 2024 10:33:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 2/9] RDMA/hns: Fix a long wait for cmdq event
 during reset
Message-ID: <20240708073315.GC6788@unreal>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-3-huangjunxian6@hisilicon.com>
 <20240707083007.GE6695@unreal>
 <42e9f7dd-05bd-176f-c5c0-02e200b3f58c@hisilicon.com>
 <20240708053850.GA6788@unreal>
 <7cae577b-e469-9357-8375-d14746a7787b@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cae577b-e469-9357-8375-d14746a7787b@hisilicon.com>

On Mon, Jul 08, 2024 at 02:50:50PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/7/8 13:38, Leon Romanovsky wrote:
> > On Mon, Jul 08, 2024 at 10:29:54AM +0800, Junxian Huang wrote:
> >>
> >>
> >> On 2024/7/7 16:30, Leon Romanovsky wrote:
> >>> On Fri, Jul 05, 2024 at 04:59:30PM +0800, Junxian Huang wrote:
> >>>> From: wenglianfa <wenglianfa@huawei.com>
> >>>>
> >>>> During reset, cmdq events won't be reported, leading to a long and
> >>>> unnecessary wait. Notify all the cmdqs to stop waiting at the beginning
> >>>> of reset.
> >>>>
> >>>> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> >>>> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> >>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >>>> ---
> >>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++++++++
> >>>>  1 file changed, 18 insertions(+)
> >>>>
> >>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>> index a5d746a5cc68..ff135df1a761 100644
> >>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>> @@ -6977,6 +6977,21 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
> >>>>  
> >>>>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
> >>>>  }
> >>>> +
> >>>> +static void hns_roce_v2_reset_notify_cmd(struct hns_roce_dev *hr_dev)
> >>>> +{
> >>>> +	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
> >>>> +	int i;
> >>>> +
> >>>> +	if (!hr_dev->cmd_mod)
> >>>
> >>> What prevents cmd_mod from being changed?
> >>>
> >>
> >> It's set when the device is being initialized, and won't be changed after that.
> > 
> > This is exactly the point, you are assuming that the device is already
> > ininitialized or not initialized at all. What prevents hns_roce_v2_reset_notify_cmd()
> > from being called in the middle of initialization?
> > 
> > Thanks
> > 
> 
> This is ensured by hns3 NIC driver.
> 
> Initialization and reset of hns RoCE are both called by hns3. It will check the state
> of RoCE device (see line 3798), and notify RoCE device to reset (hns_roce_v2_reset_notify_cmd()
> is called) only if the RoCE device has been already initialized:

So why do you have "if (!hr_dev->cmd_mod)" check in the code?

Thanks

> 
>  3791 static int hclge_notify_roce_client(struct hclge_dev *hdev,
>  3792                                     enum hnae3_reset_notify_type type)
>  3793 {
>  3794         struct hnae3_handle *handle = &hdev->vport[0].roce;
>  3795         struct hnae3_client *client = hdev->roce_client;
>  3796         int ret;
>  3797
>  3798         if (!test_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state) || !client)
>  3799                 return 0;
>  3800
>  3801         if (!client->ops->reset_notify)
>  3802                 return -EOPNOTSUPP;
>  3803
>  3804         ret = client->ops->reset_notify(handle, type);
>  3805         if (ret)
>  3806                 dev_err(&hdev->pdev->dev, "notify roce client failed %d(%d)",
>  3807                         type, ret);
>  3808
>  3809         return ret;
>  3810 }
> 
> And the bit is set (see line 11246) after the initialization has been done (line 11242):
> 
> 11224 static int hclge_init_roce_client_instance(struct hnae3_ae_dev *ae_dev,
> 11225                                            struct hclge_vport *vport)
> 11226 {
> 11227         struct hclge_dev *hdev = ae_dev->priv;
> 11228         struct hnae3_client *client;
> 11229         int rst_cnt;
> 11230         int ret;
> 11231
> 11232         if (!hnae3_dev_roce_supported(hdev) || !hdev->roce_client ||
> 11233             !hdev->nic_client)
> 11234                 return 0;
> 11235
> 11236         client = hdev->roce_client;
> 11237         ret = hclge_init_roce_base_info(vport);
> 11238         if (ret)
> 11239                 return ret;
> 11240
> 11241         rst_cnt = hdev->rst_stats.reset_cnt;
> 11242         ret = client->ops->init_instance(&vport->roce);
> 11243         if (ret)
> 11244                 return ret;
> 11245
> 11246         set_bit(HCLGE_STATE_ROCE_REGISTERED, &hdev->state);
> 11247         if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
> 11248             rst_cnt != hdev->rst_stats.reset_cnt) {
> 11249                 ret = -EBUSY;
> 11250                 goto init_roce_err;
> 11251         }
> 
> Junxian
> 
> >>
> >> Junxian
> >>
> >>>> +		return;
> >>>> +
> >>>> +	for (i = 0; i < hr_cmd->max_cmds; i++) {
> >>>> +		hr_cmd->context[i].result = -EBUSY;
> >>>> +		complete(&hr_cmd->context[i].done);
> >>>> +	}
> >>>> +}
> >>>> +
> >>>>  static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
> >>>>  {
> >>>>  	struct hns_roce_dev *hr_dev;
> >>>> @@ -6997,6 +7012,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
> >>>>  	hr_dev->dis_db = true;
> >>>>  	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
> >>>>  
> >>>> +	/* Complete the CMDQ event in advance during the reset. */
> >>>> +	hns_roce_v2_reset_notify_cmd(hr_dev);
> >>>> +
> >>>>  	return 0;
> >>>>  }
> >>>>  
> >>>> -- 
> >>>> 2.33.0
> >>>>
> >>
> 

