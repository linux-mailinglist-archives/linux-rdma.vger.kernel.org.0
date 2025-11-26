Return-Path: <linux-rdma+bounces-14784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC105C88976
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6748835432E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E0248F4D;
	Wed, 26 Nov 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9kKBnlw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210E30E85C
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144918; cv=none; b=PCggMjwz8hZhYR/TMA8dmnP3hsGoLsWFWmytFv1AABIamviEFrpz90kLjKwm/aBcFZh3dLhEtsuliIqIFEMSx6Rgg8hV97T5kbvrv/Sd5l4pKZeKKIAKcHYAyfFAKyeE6y2xzyOPt2Mt6JIgcUU275ckQLgjtBghSa3dwI1lfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144918; c=relaxed/simple;
	bh=UImK2JQDnmdICZlUi5Djf6yBb2Ae9UfWLT/9x7cnvug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELpBDIlK39k4YQAisDJe6/svM10HVKhOyBxAdekUsm1KJJc2+kFz2zRowOaR1XEdLfPEQbStwTdfHLNRb5YgfxdbU1C/hb/TYxA6ykiG0bCyJiNScEr9aMv77/PKIusx+/dSgxuwf4QE6GnqAzaAlRE1SvJN5k1XlKN0GKHRekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9kKBnlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1C2C116D0;
	Wed, 26 Nov 2025 08:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764144917;
	bh=UImK2JQDnmdICZlUi5Djf6yBb2Ae9UfWLT/9x7cnvug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9kKBnlwPW/LNAke+rqnARNhSl0AUDv9OVgtkh1n/XKJm2UQDfP/GY5C9Ren13p1z
	 LIBGE5t7uo92ImmH9ElDsNMMSiIecNZsPHPMgZQUL8yoNU10FoRD877gps7yEiCQDi
	 ySxFW+YlcQFabE87it/wxogV6nRPFmgil/OTsbDg+KDiVb4LwRgJrhIp9rxd1Ln1DN
	 r839ff3hQ+G/qP/0OxeNBsanP/548S8vSoFj3NF2IJ+f27kWRRplVgFvo3kfcjigVg
	 QvSlQ9Bd/Wuy/b/I5+v2gyC1HhSLnabWFqHSJNgyp08q3zIszS0kYAT2f9SoNoYFD/
	 sp67LjgfmKFfA==
Date: Wed, 26 Nov 2025 10:15:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, huangjunxian6@hisilicon.com,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Reduce cond_resched() frequency in
 __ib_umem_release
Message-ID: <20251126081512.GG12483@unreal>
References: <20251126025147.2627-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126025147.2627-1-lirongqing@baidu.com>

On Wed, Nov 26, 2025 at 10:51:47AM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The current implementation calls cond_resched() for every SG entry
> in __ib_umem_release(), which can increase needless overhead.
> 
> This patch introduces RESCHED_LOOP_CNT_THRESHOLD (0x1000) to limit
> how often cond_resched() is called. The function now yields the CPU
> once every 4096 iterations, and yield at the very first iteration
> for lots of small umem case, to reduce scheduling overhead.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/infiniband/core/umem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 8fd84aa..ff540a2 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -45,6 +45,8 @@
>  
>  #include "uverbs.h"
>  
> +#define RESCHED_LOOP_CNT_THRESHOLD 0x1000
> +
>  static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>  {
>  	bool make_dirty = umem->writable && dirty;
> @@ -58,7 +60,9 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i) {
>  		unpin_user_page_range_dirty_lock(sg_page(sg),
>  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
> -		cond_resched();
> +
> +		if (!(i % RESCHED_LOOP_CNT_THRESHOLD))
> +			cond_resched();


I applied it, but added a fix to skip the initial cond_resched() call on the
first iteration.

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index ff540a230297..8137031c2a65 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -61,7 +61,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
                unpin_user_page_range_dirty_lock(sg_page(sg),
                        DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);

-               if (!(i % RESCHED_LOOP_CNT_THRESHOLD))
+               if (i && !(i % RESCHED_LOOP_CNT_THRESHOLD))
                        cond_resched();
        }



>  	}
>  
>  	sg_free_append_table(&umem->sgt_append);
> -- 
> 2.9.4
> 

