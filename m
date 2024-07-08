Return-Path: <linux-rdma+bounces-3701-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56098929BBA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 07:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFB61F21635
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C526125C9;
	Mon,  8 Jul 2024 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua/eAVb3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343711171D;
	Mon,  8 Jul 2024 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720417135; cv=none; b=lutE5W/kDnjMJNRJcl9y3xpD4R2Q4X+41114Oi8J53V/zUII+GNCYddmdBlIOGqj7v7BMIoJDvI4eBZsqUyVuqn9zj1373MaTX/6kRSOBd8L++P6D7jek8qF0eMzl7Xsea1eFuoZ25RScmoJDS94zDw2vB9I5mKZeGprfYu1pyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720417135; c=relaxed/simple;
	bh=XaxsjptBXuiC1ZskjgvasAVnY1pY/HQs37wr55JsqEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxPKHoP2OIzPmPUXBtJpK/GG7LyID0BLP/R15e0cCb1b0LHA/1WVeFnTzl27uWC6L+2jk0lxvbv1ZxaQe0mWamlubm1mEZ/aLPZ+hEH/G0hz9j7RkC7WoDkqoYxQ0iJTtBdlTIL/HXNYMdW4dJAAvhmlCCs2RtS/2jTJdTa51aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua/eAVb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55795C32786;
	Mon,  8 Jul 2024 05:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720417134;
	bh=XaxsjptBXuiC1ZskjgvasAVnY1pY/HQs37wr55JsqEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ua/eAVb37Fd5p/5x2U6PJhzj41jG41YZ0PvUUHPeQH4gilF1+Ul+sQG2HdFD48vjP
	 8uEd/7Xxzpsl1XvQVBRHsYD008rCRX71t19n/Wulu4XBbP/FPeMcKQ9qH6T0xFVe6E
	 ueGJ+c5lYelEivGZSMJA7xkJuGywTdFwWJ54JgQrrFXBdTRerXfSgokpDz1kabbHK0
	 45jcXJlwAmq3FH1OdVPbnL+CHDd5AQfmqhxdLQQXlrUdZcJrQepY8LqRFiFGCpobc7
	 p6OBpsw48pWu5JJaBfmToQMPZKPqWHlB2M7U52XlFDv6Hwcm0b4MmFyZOhDG0f2eJR
	 cW4XCE9ZUtRfA==
Date: Mon, 8 Jul 2024 08:38:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 2/9] RDMA/hns: Fix a long wait for cmdq event
 during reset
Message-ID: <20240708053850.GA6788@unreal>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-3-huangjunxian6@hisilicon.com>
 <20240707083007.GE6695@unreal>
 <42e9f7dd-05bd-176f-c5c0-02e200b3f58c@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e9f7dd-05bd-176f-c5c0-02e200b3f58c@hisilicon.com>

On Mon, Jul 08, 2024 at 10:29:54AM +0800, Junxian Huang wrote:
> 
> 
> On 2024/7/7 16:30, Leon Romanovsky wrote:
> > On Fri, Jul 05, 2024 at 04:59:30PM +0800, Junxian Huang wrote:
> >> From: wenglianfa <wenglianfa@huawei.com>
> >>
> >> During reset, cmdq events won't be reported, leading to a long and
> >> unnecessary wait. Notify all the cmdqs to stop waiting at the beginning
> >> of reset.
> >>
> >> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> >> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index a5d746a5cc68..ff135df1a761 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -6977,6 +6977,21 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
> >>  
> >>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
> >>  }
> >> +
> >> +static void hns_roce_v2_reset_notify_cmd(struct hns_roce_dev *hr_dev)
> >> +{
> >> +	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
> >> +	int i;
> >> +
> >> +	if (!hr_dev->cmd_mod)
> > 
> > What prevents cmd_mod from being changed?
> > 
> 
> It's set when the device is being initialized, and won't be changed after that.

This is exactly the point, you are assuming that the device is already
ininitialized or not initialized at all. What prevents hns_roce_v2_reset_notify_cmd()
from being called in the middle of initialization?

Thanks

> 
> Junxian
> 
> >> +		return;
> >> +
> >> +	for (i = 0; i < hr_cmd->max_cmds; i++) {
> >> +		hr_cmd->context[i].result = -EBUSY;
> >> +		complete(&hr_cmd->context[i].done);
> >> +	}
> >> +}
> >> +
> >>  static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
> >>  {
> >>  	struct hns_roce_dev *hr_dev;
> >> @@ -6997,6 +7012,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
> >>  	hr_dev->dis_db = true;
> >>  	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
> >>  
> >> +	/* Complete the CMDQ event in advance during the reset. */
> >> +	hns_roce_v2_reset_notify_cmd(hr_dev);
> >> +
> >>  	return 0;
> >>  }
> >>  
> >> -- 
> >> 2.33.0
> >>
> 

