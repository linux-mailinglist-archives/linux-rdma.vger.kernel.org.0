Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD822AF696
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Nov 2020 17:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKKQd2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Nov 2020 11:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKQd2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Nov 2020 11:33:28 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F69BC0613D1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Nov 2020 08:33:28 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so3088158wrc.11
        for <linux-rdma@vger.kernel.org>; Wed, 11 Nov 2020 08:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ga1fyMAmNUTSAvvb86TLuTih6D60seEP1BnyyhlHnYY=;
        b=VI4UXpTiZEN7+z8Qsv+0gCYkKZSww1tSQBsYAMTn9aZ7M4Tb81ahQaNnpGcqmshf+K
         8vJ0own2MMoy57ODOpq6SRaIs7ySMgIz+lKmFFbsfxytru7SQLeMGkCYCTr3aNTDXLqU
         5YAL3Y72T2gPzTHtH4AUS8xraIsFgCbe/jX0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ga1fyMAmNUTSAvvb86TLuTih6D60seEP1BnyyhlHnYY=;
        b=KIQfmNXNoLNTjMy6bKauidXXW5w+PP1GXrHHvtqvIxuW/J+2B8Yf12i+JbBtJsfsUl
         8z3I5t6NL4pVP3UHmbP2VQ8v7O2WOgFi6K1M5GFUd3JprdOcEC/9iJrCkikM4gAzPVU7
         OY/SwwqGGq8LQ2zNZCS23QFUje/Vg69AklwGz2Sr0+iE+gy7L1OJBsCPUwJBGfVr9vGa
         dcN707c9ayOX6hL7xnCQfiqNVJzJ9hybqnMuIGchxWdl/gHxY3/YfiSKGH7gknUKzCTI
         eKqiCuKVwEZGgzoEx/ybiqygjPGEex7FbcF3+5YNkWGRJipcX7AZXU7XKV9FMXV0pHnq
         KBlA==
X-Gm-Message-State: AOAM530C8sr/YbeB56mpqx+nnip5g9p6vnecwORV8hP7GK4ZyOT8EQbv
        LvYunlcBGdK4yRpcHkjuqT69eQ==
X-Google-Smtp-Source: ABdhPJwVnaxroRTsLEh40OxFCTehh6Vn65sqL0FGpXCgNjn6gajinA4J5yHz8TCOoRmujGffihQ/8A==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr32746496wre.229.1605112406900;
        Wed, 11 Nov 2020 08:33:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f19sm3030443wml.21.2020.11.11.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:33:25 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:33:23 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v10 6/6] dma-buf: Document that dma-buf size is fixed
Message-ID: <20201111163323.GP401619@phenom.ffwll.local>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
 <1605044477-51833-7-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605044477-51833-7-git-send-email-jianxin.xiong@intel.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 01:41:17PM -0800, Jianxin Xiong wrote:
> The fact that the size of dma-buf is invariant over the lifetime of the
> buffer is mentioned in the comment of 'dma_buf_ops.mmap', but is not
> documented at where the info is defined. Add the missing documentation.
> 
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>

Applied to drm-misc-next, thanks for your patch. For the preceeding
dma-buf patch I'll wait for more review/acks before I apply it. Ack from
Jason might also be good, since looks like this dma_virt_ops is only used
in rdma.
-Daniel

> ---
>  include/linux/dma-buf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 9dcd569..92da98b 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -272,7 +272,7 @@ struct dma_buf_ops {
>  
>  /**
>   * struct dma_buf - shared buffer object
> - * @size: size of the buffer
> + * @size: size of the buffer; invariant over the lifetime of the buffer.
>   * @file: file pointer used for sharing buffers across, and for refcounting.
>   * @attachments: list of dma_buf_attachment that denotes all devices attached,
>   *               protected by dma_resv lock.
> @@ -404,7 +404,7 @@ struct dma_buf_attachment {
>   * @exp_name:	name of the exporter - useful for debugging.
>   * @owner:	pointer to exporter module - used for refcounting kernel module
>   * @ops:	Attach allocator-defined dma buf ops to the new buffer
> - * @size:	Size of the buffer
> + * @size:	Size of the buffer - invariant over the lifetime of the buffer
>   * @flags:	mode flags for the file
>   * @resv:	reservation-object, NULL to allocate default one
>   * @priv:	Attach private data of allocator to this buffer
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
