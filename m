Return-Path: <linux-rdma+bounces-4964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852FE979E10
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CBE1C22AAC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304A81494A0;
	Mon, 16 Sep 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb23xell"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B541C62;
	Mon, 16 Sep 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478009; cv=none; b=GjyIH57m2yz+a935KBLHN6M5l3reulFdnWazqBctWyIXqSugipNqkWzpQgO9a9ubBjCjwl6dghdNqThjMFDPj9XOfI6OjSU+XEuBgkSrxZgrz7XCVtsHDL4nvgfk7ySEgNb2ra8FlPl7roxWCRVPjFCjzJ1UzxzPPvEZUPxi6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478009; c=relaxed/simple;
	bh=6sVXcxnsKD5MARXwwHudhQw0IAw2eEJr68HonO55PlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIX2WGUYq+fGQXW0b7CTScHozDWlDheQWzCjc0QMdGv675e1zYGsaAmSl+nZ7avNaB4HtYKamRF8F3ip8iFeXTv139Sw+HwSzH/C+A3zaiLrqLtqAG1Esw+knWFBGhRrju3259IH/8f3Ky83G1HpEN2eflxyjoKVACQc7RlnEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb23xell; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB959C4CEC4;
	Mon, 16 Sep 2024 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478008;
	bh=6sVXcxnsKD5MARXwwHudhQw0IAw2eEJr68HonO55PlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rb23xellkWCUnryl+HIe7VRT+uziI7vqdcI0RhcGkCSK0lJPg/xG2kK0+S9tCxSU+
	 yOrOkrApqId/zODjWqAkytr6IuF8m+CO8fxxJyeWcIqOydAl9iab2a6OSh/KvvBi2C
	 UC+6qtMb0MQvHEm+hJHyhbUFYoo5rLc1lLXe7njrvVx7bKvbhYz3QDiB7HFlU5lR/1
	 Fq5TO2nC77/hhJcXQt6hMnk7cT4BmiFBhGyvCUMuaGLPdOMFf/RjbFRgRq+h1exVuX
	 QJkLnWj506SP0x8DRpW3GX/6GlELYYc8hB/zfDU20MAs4XZ++AYcbLjNLnyItSZaWs
	 XlDWGOKFfLMdA==
Date: Mon, 16 Sep 2024 12:13:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 for-next 2/2] RDMA/hns: Disassociate mmap pages for
 all uctx when HW is being reset
Message-ID: <20240916091323.GM4026@unreal>
References: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
 <20240913122955.1283597-3-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913122955.1283597-3-huangjunxian6@hisilicon.com>

On Fri, Sep 13, 2024 at 08:29:55PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> When HW is being reset, userspace should not ring doorbell otherwise
> it may lead to abnormal consequence such as RAS.
> 
> Disassociate mmap pages for all uctx to prevent userspace from ringing
> doorbell to HW. Since all resources will be destroyed during HW reset,
> no new mmap is allowed after HW reset is completed.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++++++++
>  drivers/infiniband/hw/hns/hns_roce_main.c  | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 24e906b9d3ae..4e374b2da101 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -7017,6 +7017,12 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
>  
>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
>  }
> +
> +static void hns_roce_v2_reset_notify_user(struct hns_roce_dev *hr_dev)
> +{
> +	rdma_user_mmap_disassociate(&hr_dev->ib_dev);
> +}

There is no need in one line function, please inline it.

> +
>  static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>  {
>  	struct hns_roce_dev *hr_dev;
> @@ -7035,6 +7041,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>  
>  	hr_dev->active = false;
>  	hr_dev->dis_db = true;
> +
> +	hns_roce_v2_reset_notify_user(hr_dev);
> +
>  	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
>  
>  	return 0;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 4cb0af733587..49315f39361d 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -466,6 +466,11 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>  	pgprot_t prot;
>  	int ret;
>  
> +	if (hr_dev->dis_db) {

How do you clear dis_db after calling to hns_roce_hw_v2_reset_notify_down()? Does it have any locking protection?

> +		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MMAP_ERR_CNT]);
> +		return -EPERM;
> +	}
> +
>  	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
>  	if (!rdma_entry) {
>  		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MMAP_ERR_CNT]);
> -- 
> 2.33.0
> 

