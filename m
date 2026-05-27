Return-Path: <linux-rdma+bounces-21399-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJoYB20/F2qg9wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21399-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 21:01:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56F5E953F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21186302570E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8C3101D0;
	Wed, 27 May 2026 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="M/oq2HzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ji8XVn7J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4233630A0;
	Wed, 27 May 2026 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908451; cv=none; b=UuDWt0iSyYT4t5mGsqJDzCKzvuXyXFN/DvNLbQoNlDb76uaSQH9BAhJq9jsIwf4WWneLMNJmL4pgEOdamHhwf/BR4Nm3G85dhgTCGkFb0z1SlI9pdVFJlNGby4bmYBe4vdMinLS8aVEggdRh2orsCtJW6Pvuv7RGLaOEwnE6CPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908451; c=relaxed/simple;
	bh=zVYumL1TQMBjpa94qtturgLFdRZdyaHrxiIPuQWN0Po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP24bTmypHl6zd4wIBPdxWA1dJUePAJTP9KTza2Q+NMWRJ/3yup6qiGSFWjNaDhaXDmmwx0g4tdIyHgMMSi7rnLmynjgho+IViZTlOcdXLKIbXeopERdD0tPFUzTvPICiZA6GfVHZKiQWwvm0CyVMncVXrHg+SBOibUEa03QtUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=M/oq2HzD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ji8XVn7J; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AD614EC01CD;
	Wed, 27 May 2026 15:00:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 15:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779908447;
	 x=1779994847; bh=dWbmHmsFhL1JO+fiI5q5drCmWA2QA+KCJc5JMtUlBmM=; b=
	M/oq2HzDusPURhX3PIJQvFC8elfwFPJblxkoLAsvhV+5zowU6LCrF/RayghKfENS
	n39TYd0JXcGOoGdYcwejVM9s7oN4VV7R7b8MFrRSaLXzGlKiXihojunP6epKfxMN
	i9nYUZ/qg/Sxlq0xQzecX1sbbri8ULBozPIz/am7O3684p3VONsIERy2cB6qw83g
	sJ0mdVsmsdeKAP14g672QEQAnjRsL0/incTsSFEbhPDGYXbyaR0aqqHFNf7kFt3Q
	xCOKukR1nRtTR64hzEGxql2j1Fr7QIafGxoj2lbJVkOa9hqzoLbua78Fz1HTQfJa
	UkLrAFTc0KLfC14JACS2hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779908447; x=
	1779994847; bh=dWbmHmsFhL1JO+fiI5q5drCmWA2QA+KCJc5JMtUlBmM=; b=j
	i8XVn7JYwhv53sC0PHW/A/GYHCDOuzw6RS1mDqkKrnbgrx8YIbaXEK25T5ILq5He
	CG0U9A6997j8+I1lfIolQRgGAy0K6qSqtKRlTY7gKCGtfR4tesdKx2QL+pibpSgq
	Zt9YGLuqw4uxw+MRprBvo1vkHzb9/DlswUOFe00SiAgwDss0lc+sMSRCH3kpMUQV
	98wfZvvv3UUtJYz+18EU1UWuLKa/4E63PtO2CJBqQefdJjZWy4w/TNrbTAWtP6+2
	DdZoDC45yGkAnRqu92du188czVZOdKbq40f3eeINIxUOmPbZbBKMnKTAMZKCljCg
	Ptmd5Ni4G0kWM0AetkLiQ==
X-ME-Sender: <xms:Xz8XarMOxMVYc8P7wGikv_5Skw5e_5UVYl1q0Y0F_fiIV6i5s5QXqw>
    <xme:Xz8XatjjRHfD-SDnIxDxc_GiTQGU5RRsN9U_eIN3ApEu7RZeeeIVze8wEQknkzR1y
    U1xWjY_qQMcomzZfrbKEKgiOK-G9ywjFJpsgsBaqdHGsnnYqHNZUQ>
X-ME-Received: <xmr:Xz8Xap4d1CKb0fT04S8_EbsVfRNfmzwM0neIUzlbIEv3g2nb4EIcrWdA4Qg>
X-ME-Proxy-Cause: dmFkZTE5WtTqMLkQXWrOLoLo7pE4j0s8oEtY8S5EKw1HdzVXgTrDfWP6Czu+t/MsztoF8+
    crha1tfirvoCetGitPp1eWqmDGW+r/VUAROv464BItTXNIQReEVPlSbXtNbu1N/fI0E1nk
    ujXyyLb9/htjvVvAvOKyuVGrqCso38H6hnJbYOUHe0Sh7FNhdlaHC3u6VRV2hNxPPUKAQi
    FJJ0bUnKultMtPpcL5NORMRvE90xqPQVC8tvb09OD1a6VXD6SP8IXC9Cj9YF9AwMdZD/uF
    NOLX/dNjjRu1tqXw4n5gXZ8ieR5dVxmzP1OMLXD44+iGeSjwE2F6fQpdpQzTjD8MIkyuXw
    rJETSR72SLRFlIfjMxopSf3ILBynVZVBuIMeLLdnj65PcpK6djQTtpg4pJFpCcKLMHJVzG
    X34OxntDhM6t/Blwh8QrNzSKmROlkl3ANkDbRfxmM8ULgwt6xWDAkGtdRIvSKjP3aMVlqK
    hF5mjqO+T0bVSbIiDe+rP0MviTqH+N4yBsjjzFKnykSnioV8jIYBfKioSCyDB6MMIZIk7V
    Q/Pf2SXPK1PUdPoNuEqAkWbWCq7SMe292XJJ7mUS+KZK24UJJhXaVi9wk02yhLWL7vBCpV
    8ldj8DEX0ndddiSdITV8r6W2S6oqynyosbniib4xPJIjkWFldrif4Aq9K1VQ
X-ME-Proxy: <xmx:Xz8XasfvR2ynvW8tkCdbOdxuSYAYoq3reazvIpLaW8MqAtk1yfFwQw>
    <xmx:Xz8XaqBp0206C-vByNU_CcKsGhFZrWsNwLB44bywICdDFslBMZKo0Q>
    <xmx:Xz8XajD377KiwNhqz0AtxqDeb0QL6b8sKY70D4NAlgpGLyDwqYaiBw>
    <xmx:Xz8XakZ7fb6HYf1LWcJ_o5pZFOpDQepVweIh43Giquz05XhkFSkQVA>
    <xmx:Xz8Xah3EVrvET6SjEVcfY8519Kvq8W1HTr4dxiaxNjvqJ7Jx3sjp7NKs>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 15:00:46 -0400 (EDT)
Date: Wed, 27 May 2026 13:00:45 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Konig
 <christian.koenig@amd.com>, Bjorn Helgaas <helgaas@kernel.org>,
 <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 alex@shazbot.org
Subject: Re: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Message-ID: <20260527130045.704a4502@shazbot.org>
In-Reply-To: <20260526144401.1485788-5-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
	<20260526144401.1485788-5-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21399-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,shazbot.org:mid,shazbot.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Queue-Id: AB56F5E953F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 07:43:56 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> peer access and translate the returned steering tag into an mlx5 ST
> index. Keep the DMAH path as the first priority and only fall back to
> DMA-buf metadata when no DMAH is supplied.
> 
> Track per-MR ownership of the allocated ST index and release it on MR
> setup failure, destroy, and FRMR-pool reuse. Release the ST index before
> the MR is pushed back into the FRMR pool, and free mlx5_st_idx_data when
> its refcount reaches zero so repeated allocation/deallocation does not
> leak memory.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
>  drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
>  include/linux/mlx5/driver.h                   |  7 ++
>  4 files changed, 115 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index e156dc4d7529..4ab867392267 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -721,6 +721,12 @@ struct mlx5_ib_mr {
>  			u8 revoked :1;
>  			/* Indicates previous dmabuf page fault occurred */
>  			u8 dmabuf_faulted:1;
> +			/* Set when the MR owns dmabuf_st_index and must
> +			 * release it via mlx5_st_dealloc_index() once the
> +			 * firmware mkey is no longer referencing it.
> +			 */
> +			u8 dmabuf_st_owned:1;
> +			u16 dmabuf_st_index;
>  			struct mlx5_ib_mkey null_mmkey;
>  		};
>  	};
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 3b6da45061a5..8059b5e4da97 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -38,6 +38,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-resv.h>
> +#include <linux/pci-tph.h>
>  #include <rdma/frmr_pools.h>
>  #include <rdma/ib_umem_odp.h>
>  #include "dm.h"
> @@ -46,6 +47,8 @@
>  #include "data_direct.h"
>  #include "dmah.h"
>  
> +MODULE_IMPORT_NS("DMA_BUF");
> +

This doesn't appear to add any dma-buf namespace dependencies.

>  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
>  {
>  	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> @@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_attach_ops = {
>  	.invalidate_mappings = mlx5_ib_dmabuf_invalidate_cb,
>  };
>  
> +/*
> + * Query TPH metadata from @dmabuf and translate the raw steering tag into
> + * an mlx5 ST index. On success, returns 0 and the caller becomes the
> + * owner of *@st_index (must be released with mlx5_st_dealloc_index()
> + * once the firmware mkey no longer references it). On any failure
> + * *@st_index and *@ph are left as the no-TPH defaults set by the caller.
> + *
> + * @dmabuf must already be referenced by the caller (e.g. via the umem's
> + * attachment) so we don't re-resolve the user's fd here and avoid a
> + * dup2() TOCTOU between umem creation and TPH lookup.
> + */
> +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf *dmabuf,
> +			      u16 *st_index, u8 *ph)
> +{
> +	u8 req_type;
> +	u16 steering_tag;
> +	u8 st_width;
> +	int ret;
> +
> +	if (!dmabuf->ops->get_tph)
> +		return;
> +
> +	req_type = pcie_tph_enabled_req_type(dev->mdev->pdev);
> +	switch (req_type) {
> +	case PCI_TPH_REQ_TPH_ONLY:
> +		st_width = 8;
> +		break;
> +	case PCI_TPH_REQ_EXT_TPH:
> +		st_width = 16;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	ret = dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
> +	if (ret) {
> +		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
> +		*ph = MLX5_IB_NO_PH;
> +		return;
> +	}
> +
> +	ret = mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_index);
> +	if (ret) {
> +		*ph = MLX5_IB_NO_PH;
> +		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
> +	}
> +}

ph handling is inconsistent, why not use a local variable and only set
the caller's pointer on success?

> +
> +static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
> +{
> +	if (mr->umem && mr->dmabuf_st_owned) {
> +		mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
> +				      mr->dmabuf_st_index);
> +		mr->dmabuf_st_owned = 0;
> +	}
> +}
> +
>  static struct ib_mr *
>  reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
>  		   u64 offset, u64 length, u64 virt_addr,
> @@ -941,16 +1001,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
>  		ph = dmah->ph;
>  		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
>  			st_index = mdmah->st_index;
> +	} else {
> +		get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
> +				  &st_index, &ph);
>  	}
>  
>  	mr = alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
>  				access_flags, access_mode,
>  				st_index, ph);
>  	if (IS_ERR(mr)) {
> +		if (!dmah && st_index != MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> +			mlx5_st_dealloc_index(dev->mdev, st_index);
>  		ib_umem_release(&umem_dmabuf->umem);
>  		return ERR_CAST(mr);
>  	}
>  
> +	if (!dmah && st_index != MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX) {
> +		mr->dmabuf_st_index = st_index;
> +		mr->dmabuf_st_owned = 1;
> +	}
> +
>  	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
>  
>  	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
> @@ -1377,9 +1447,17 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
>  	bool is_odp = is_odp_mr(mr);
>  	int ret;
>  
> -	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
> -	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> -		return 0;
> +	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
> +		/*
> +		 * The mkey has been revoked: firmware no longer references
> +		 * dmabuf_st_index, so release it before this mr can re-enter
> +		 * the FRMR cache for reuse by another registration.
> +		 */
> +		mlx5_ib_mr_put_dmabuf_st(mr);
> +
> +		if (!ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> +			return 0;
> +	}
>  
>  	if (is_odp)
>  		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
> @@ -1400,6 +1478,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
>  		dma_resv_unlock(
>  			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
>  	}
> +	if (!ret)
> +		mlx5_ib_mr_put_dmabuf_st(mr);
>  	return ret;
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a13..8929c17c88bc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> @@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *dev)
>  	u8 direct_mode = 0;
>  	u16 num_entries;
>  	u32 tbl_loc;
> -	int ret;
> +	int ret = 0;

Unnecessary change.

>  
>  	if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
>  		return NULL;
> @@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
>  	kfree(st);
>  }
>  
> -int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
> -			unsigned int cpu_uid, u16 *st_index)
> +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> +			       u16 *st_index)
>  {
>  	struct mlx5_st_idx_data *idx_data;
>  	struct mlx5_st *st = dev->st;
>  	unsigned long index;
>  	u32 xa_id;
> -	u16 tag;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!st)
>  		return -EOPNOTSUPP;
>  
> -	ret = pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> -	if (ret)
> -		return ret;
> -
>  	if (st->direct_mode) {
>  		*st_index = tag;
>  		return 0;
> @@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
>  	mutex_unlock(&st->lock);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
> +
> +int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
> +			unsigned int cpu_uid, u16 *st_index)
> +{
> +	u16 tag;
> +	int ret;
> +
> +	ret = pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> +	if (ret)
> +		return ret;
> +
> +	return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
> +}
>  EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
>  
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
> @@ -175,6 +184,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
>  
>  	if (refcount_dec_and_test(&idx_data->usecount)) {
>  		xa_erase(&st->idx_xa, st_index);
> +		kfree(idx_data);
>  		/* We leave PCI config space as was before, no mkey will refer to it */
>  	}

Should this be pulled out as a fix separate from the feature added
here?  Thanks,

Alex

>  
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index 04b96c5abb57..523a9ab0ae1e 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -1166,10 +1166,17 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type
>  			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
>  
>  #ifdef CONFIG_PCIE_TPH
> +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> +			       u16 *st_index);
>  int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
>  			unsigned int cpu_uid, u16 *st_index);
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
>  #else
> +static inline int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev,
> +					     u16 tag, u16 *st_index)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
>  				      enum tph_mem_type mem_type,
>  				      unsigned int cpu_uid, u16 *st_index)


