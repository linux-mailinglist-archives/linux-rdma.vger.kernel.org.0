Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE528F65A
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbgJOQDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389539AbgJOQDw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 12:03:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92582C0613D2
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 09:03:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d81so3728285wmc.1
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DbRyVIR2jUJWgBTF659QP8SY1vAxnN7ExneR3zyZD7o=;
        b=UPZ3hvPLTlXmhC8krIzkANQBFOV7zqrdoR6Fe7UlmT0cANShHVycdvBxmLUvXiyRIe
         Co4WdaFgeSbnNz2VfojqOtcRY3LHLu2NTO2jtx8Pxz3YtW+DEz7oxBESx2kltqVKdVHm
         AygMOfTDbWW4g/dCDV5ASow9sXqRCMvKG8Vkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DbRyVIR2jUJWgBTF659QP8SY1vAxnN7ExneR3zyZD7o=;
        b=khJ2/Js6EDQJGKJZD2j29AEfxIU9Gocvo8bZjpjWcYRMh2pDPWlU0Jbsjo8hqJXNVL
         u68+0gYNHF7IMIRqnhem5xUxcs277kNws2XMX67LEMtt8fQzmrxYbT8+b+uyR5E73EkH
         cmTQAonZX0Mv12KGFWR1dYVCdLt0sz6v2oQodROHvRQaT09VuJcfwZR/VACdpUI/+QHk
         D19j0/H2fd9erlhWld7GR4RmmIKq8IyFUCEzghP56DvHghoQVQZv05gTdfmdeBLcucNd
         TJ9Vr6W/YsGYL6Vzh5FNPj7ORL0+NHKEVpX/Cz7GLSxPcwf17+k1xWZMYG1jqTOHCriI
         lWTw==
X-Gm-Message-State: AOAM533hgycCvEH5f9xV3YxBSOCDNfypswRDl5L3GCHVKbtLzR6dpDut
        ZbqZSgT3y0Mll1eymj/x+PJunojtVXiYWh5K
X-Google-Smtp-Source: ABdhPJw+VHwW09aRmuNanGKHGz+vL0Ww3co+chUob9D38zTudXVAwzdJco8FucmxzOZX1GLH21V0Lg==
X-Received: by 2002:a1c:4856:: with SMTP id v83mr4957083wma.118.1602777831187;
        Thu, 15 Oct 2020 09:03:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n9sm5512439wrq.72.2020.10.15.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 09:03:50 -0700 (PDT)
Date:   Thu, 15 Oct 2020 18:03:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v4 5/5] dma-buf: Clarify that dma-buf sg lists are page
 aligned
Message-ID: <20201015160344.GA401619@phenom.ffwll.local>
References: <1602692161-107096-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602692161-107096-1-git-send-email-jianxin.xiong@intel.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 14, 2020 at 09:16:01AM -0700, Jianxin Xiong wrote:
> The dma-buf API have been used under the assumption that the sg lists
> returned from dma_buf_map_attachment() are fully page aligned. Lots of
> stuff can break otherwise all over the place. Clarify this in the
> documentation and add a check when DMA API debug is enabled.
> 
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>

lgtm, thanks for creating this and giving it a spin.

I'll queue this up in drm-misc-next for 5.11, should show up in linux-next
after the merge window is closed.

Cheers, Daniel

> ---
>  drivers/dma-buf/dma-buf.c | 21 +++++++++++++++++++++
>  include/linux/dma-buf.h   |  3 ++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 844967f..7309c83 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -851,6 +851,9 @@ void dma_buf_unpin(struct dma_buf_attachment *attach)
>   * Returns sg_table containing the scatterlist to be returned; returns ERR_PTR
>   * on error. May return -EINTR if it is interrupted by a signal.
>   *
> + * On success, the DMA addresses and lengths in the returned scatterlist are
> + * PAGE_SIZE aligned.
> + *
>   * A mapping must be unmapped by using dma_buf_unmap_attachment(). Note that
>   * the underlying backing storage is pinned for as long as a mapping exists,
>   * therefore users/importers should not hold onto a mapping for undue amounts of
> @@ -904,6 +907,24 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
>  		attach->dir = direction;
>  	}
>  
> +#ifdef CONFIG_DMA_API_DEBUG
> +	{
> +		struct scatterlist *sg;
> +		u64 addr;
> +		int len;
> +		int i;
> +
> +		for_each_sgtable_dma_sg(sg_table, sg, i) {
> +			addr = sg_dma_address(sg);
> +			len = sg_dma_len(sg);
> +			if (!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(len)) {
> +				pr_debug("%s: addr %llx or len %x is not page aligned!\n",
> +					 __func__, addr, len);
> +			}
> +		}
> +	}
> +#endif /* CONFIG_DMA_API_DEBUG */
> +
>  	return sg_table;
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_map_attachment);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index a2ca294e..4a5fa70 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -145,7 +145,8 @@ struct dma_buf_ops {
>  	 *
>  	 * A &sg_table scatter list of or the backing storage of the DMA buffer,
>  	 * already mapped into the device address space of the &device attached
> -	 * with the provided &dma_buf_attachment.
> +	 * with the provided &dma_buf_attachment. The addresses and lengths in
> +	 * the scatter list are PAGE_SIZE aligned.
>  	 *
>  	 * On failure, returns a negative error value wrapped into a pointer.
>  	 * May also return -EINTR when a signal was received while being
> -- 
> 1.8.3.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
