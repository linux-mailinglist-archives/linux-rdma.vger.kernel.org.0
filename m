Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA502FCC81
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 09:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbhATIN6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 03:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730769AbhATILK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 03:11:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28F1223131;
        Wed, 20 Jan 2021 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611130229;
        bh=VK/3WnHnCQDRUsKhBb3/kv0y45Ig0eq1LuiXg5V+mlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUMhwg7TdOm+uNwKrpZ9IFnSnDmky+wQivOLQJYur7bpTjJJzA8c9pGGqG3xEBJuE
         bPR/HtnSSARxhlJINOMVYbil54aPoRlxR5+eEWAoniEty/E0jaPPqKVqZzC1DBXRyk
         ACGgs/3VPhGSGm6l9fv7oUkDUfEcJv0FwgSgid4VFI8vpK9kOLLueL5lBi7imJOxCS
         DiaqcDwcW8XY1or0MOw67KywnnXKFjbsnbVVGTVrXOZuN6PCyS51udh9yIZDE0RHV4
         0MbYwUsyYnEpfbxs+7ol5AOuglUxslxJ5W3aAPVpfsxbL0cH+lCRBDY+ZVPQs//lhf
         JBoqeU4yrak4g==
Date:   Wed, 20 Jan 2021 10:10:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH RFC 1/7] RDMA/hns: Introduce DCA for RC QP
Message-ID: <20210120081025.GA225873@unreal>
References: <1610706138-4219-1-git-send-email-liweihang@huawei.com>
 <1610706138-4219-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610706138-4219-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 15, 2021 at 06:22:12PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
>
> The hip09 introduces the DCA(Dynamic context attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool, this will
> reduce the memory consumption when there are too many QPs are inactive.
>
> If a QP enables DCA feature, the WQE's buffer will not be allocated when
> creating. But when the users start to post WRs, the hns driver will
> allocate a buffer from the memory pool and then fill WQEs which tagged with
> this QP's number.
>
> The hns ROCEE will stop accessing the WQE buffer when the user polled all
> of the CQEs for a DCA QP, then the driver will recycle this WQE's buffer
> to the memory pool.
>
> This patch adds a group of methods to support the user space register
> buffers to a memory pool which belongs to the user context. The hns kernel
> driver will update the pages state in this pool when the user calling the
> post/poll methods and the user driver can get the QP's WQE buffer address
> by the key and offset which queried from kernel.
>
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/Makefile          |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_dca.c    | 381 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_dca.h    |  22 ++
>  drivers/infiniband/hw/hns/hns_roce_device.h |  10 +
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  27 +-
>  include/uapi/rdma/hns-abi.h                 |  23 ++
>  6 files changed, 462 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h

<...>

> +static struct dca_mem *alloc_dca_mem(struct hns_roce_dca_ctx *ctx)
> +{
> +	struct dca_mem *mem, *tmp, *found = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctx->pool_lock, flags);
> +	list_for_each_entry_safe(mem, tmp, &ctx->pool, list) {
> +		spin_lock(&mem->lock);
> +		if (dca_mem_is_free(mem)) {
> +			found = mem;
> +			set_dca_mem_alloced(mem);
> +			spin_unlock(&mem->lock);
> +			goto done;
> +		}
> +		spin_unlock(&mem->lock);
> +	}
> +
> +done:
> +	spin_unlock_irqrestore(&ctx->pool_lock, flags);
> +
> +	if (found)
> +		return found;
> +
> +	mem = kzalloc(sizeof(*mem), GFP_ATOMIC);

Should it be ATOMIC?

> +	if (!mem)
> +		return NULL;
> +
> +	spin_lock_init(&mem->lock);
> +	INIT_LIST_HEAD(&mem->list);
> +
> +	set_dca_mem_alloced(mem);
> +
> +	spin_lock_irqsave(&ctx->pool_lock, flags);
> +	list_add(&mem->list, &ctx->pool);
> +	spin_unlock_irqrestore(&ctx->pool_lock, flags);
> +	return mem;
> +}

<...>

>  /**
>   * hns_get_gid_index - Get gid index.
> @@ -306,15 +308,16 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
>  static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>  				   struct ib_udata *udata)
>  {
> -	int ret;
>  	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
> -	struct hns_roce_ib_alloc_ucontext_resp resp = {};
>  	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
> +	struct hns_roce_ib_alloc_ucontext_resp resp = {};
> +	int ret;
>
>  	if (!hr_dev->active)
>  		return -EAGAIN;
>
>  	resp.qp_tab_size = hr_dev->caps.num_qps;
> +	resp.cap_flags = (u32)hr_dev->caps.flags;

This is prone to errors, flags is u64.

<...>

> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index 90b739d..f59abc4 100644
> --- a/include/uapi/rdma/hns-abi.h
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -86,10 +86,33 @@ struct hns_roce_ib_create_qp_resp {
>  struct hns_roce_ib_alloc_ucontext_resp {
>  	__u32	qp_tab_size;
>  	__u32	cqe_size;
> +	__u32	cap_flags;
>  };

This struct should be padded to 64bits,

Thanks
