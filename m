Return-Path: <linux-rdma+bounces-3685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599F929721
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 10:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E4428197A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D711725;
	Sun,  7 Jul 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+gU56lq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F637F9F5;
	Sun,  7 Jul 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720341012; cv=none; b=RbktyoxlHpwj3sTmcSbo6z+qb2hwlwZjtTOx2oOboIA+U+MvFEoIJmgms9Z2b/EDO01DP//Dqdvk/dstk6u1W0Al81SoiLUrsbFVfjel3DAPEbv8jh+1D5JngJq2w2PixKb/HXVqfjvg8NO/d3kFpjZRtyvjCjBayud0h/nrV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720341012; c=relaxed/simple;
	bh=Vh8TFzc59yfBw7szW67QjrvrQN/XSyaf8Bs5aoIYs2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFEEBP9Wnm512F8xjd7Apot1OXqVF6y1iiOI3LIFBl+Q8B7Z8DETqWBznM4ThJvjks/XRFuv+6QXuOTHDwtxZOkHOfrJBe4L4gmc9t7MVcjbcuavrglHdgV2/Cq4BNywKgBiF2mdBrkZy6/5vG6k+ffLoK5B1xVYf+9IeIkW7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+gU56lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B09C3277B;
	Sun,  7 Jul 2024 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720341012;
	bh=Vh8TFzc59yfBw7szW67QjrvrQN/XSyaf8Bs5aoIYs2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+gU56lqIrDYzeCZ8vUuYcuUoVh2dv0XV8/jrHUtfgjdfeKW5Yb85EgJ4PTTdTOhg
	 5e4R1Hry+5EkiNW7+JQ/CymfY8aFUe9EnGFOKzRwz1ChP7u2k6nSyrkQGhjst+0fYP
	 tyoFGrpzp9h+i51ZeP5t15CN++wdlWzrpOH1PDSBWrIcFzh1saLJ6v0ztl4H4h6rcw
	 Yn8dJAoFf7YqJKKRjdOrsHtuls50g5wpGsTmgsvD3601DW/jhX7Q40pgcR45U2syeX
	 KJ955JR3zOQ6Ytaz+xiGI/NT/cjIrE3e8+ZqTaV+i40Yrz9dhybuW8j1IZDcb9Oba8
	 y9uA2sIxJ5WtA==
Date: Sun, 7 Jul 2024 11:30:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 2/9] RDMA/hns: Fix a long wait for cmdq event
 during reset
Message-ID: <20240707083007.GE6695@unreal>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-3-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705085937.1644229-3-huangjunxian6@hisilicon.com>

On Fri, Jul 05, 2024 at 04:59:30PM +0800, Junxian Huang wrote:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> During reset, cmdq events won't be reported, leading to a long and
> unnecessary wait. Notify all the cmdqs to stop waiting at the beginning
> of reset.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index a5d746a5cc68..ff135df1a761 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -6977,6 +6977,21 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
>  
>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
>  }
> +
> +static void hns_roce_v2_reset_notify_cmd(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
> +	int i;
> +
> +	if (!hr_dev->cmd_mod)

What prevents cmd_mod from being changed?

> +		return;
> +
> +	for (i = 0; i < hr_cmd->max_cmds; i++) {
> +		hr_cmd->context[i].result = -EBUSY;
> +		complete(&hr_cmd->context[i].done);
> +	}
> +}
> +
>  static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>  {
>  	struct hns_roce_dev *hr_dev;
> @@ -6997,6 +7012,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>  	hr_dev->dis_db = true;
>  	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
>  
> +	/* Complete the CMDQ event in advance during the reset. */
> +	hns_roce_v2_reset_notify_cmd(hr_dev);
> +
>  	return 0;
>  }
>  
> -- 
> 2.33.0
> 

