Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490DA4193C9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhI0MEP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbhI0MEP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 08:04:15 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D8C061604
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 05:02:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x9so4759955qvn.12
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qLGMzgcPQFDHN83z8jWEK1bxNWkGjHVB+skJQt3mBYM=;
        b=SZY2ZrwPe20b6a9vWLqE0BRLWU5FDF9P5daqr8K7SurQjxhf296eJQASmtduozOVqI
         l0oP1W18sDA45eA36zvQgku5Xn07XBeiQGWpll4l+Qntgc8RGrNB6CQhJ3W/JHBtjWER
         UatI4ehAV1GLfODmmvipXAH/XJ3cCnXlK+zvdFzyemLARSvJFBHJKRitjHQxDD92HNIv
         sBsMtEK+erfKRxztQU9F32Z0NDOqrN7Zslgw+zhbDRODvemvO3WeVzXAJArXNsNIMPDc
         UGxR1xXfJcQCHSu7NTcpI79Tmn3CdyJbt+c9tgpQz4mtJ/MjZa6iaZfSF5g3O3g/B9WO
         hDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qLGMzgcPQFDHN83z8jWEK1bxNWkGjHVB+skJQt3mBYM=;
        b=HBDEwSvntAHCSzdD45wqMgM9t+316u8ajINBl7/ePpI7wEaXcCZoopGQAGfOeuoTNF
         7swfquaWM+jSO10PPEcfCN1uvDw2SroPavvDbqciRTBnUZQnk+8qcJm5QxHTFazsUEOn
         +wntPijMbV6qf/kvFGUIrc9syPEMUgIjqytorM1nII6ieIL1mZ6AXQ+LYXp4WdnmZxZe
         Vdn6cQ7x/fbhz2YUxzb7R5dIvNzX08/EOQTrQCEG0JTIlnyPEtGd+7YO7vK9T9jtP3GZ
         5MnD3Aolhiohp88rOIOU1J/srVdlvnuoKRY7yWKC6M2dOdlPGLthdDsDmUtYzlX81twa
         bqxA==
X-Gm-Message-State: AOAM533j3LLNhPOSw6hsgjkr7kb6Nl38JbCUkRJ+gjjSgDXwTlE+BHfw
        qVX3OZgD7blhkB/vA4vv1ly5wg==
X-Google-Smtp-Source: ABdhPJxDIMtDdHCzcVRtCFxWjXnJfMaqGwzWsg1D2Tgx4f3IlNpWU5MAwUf8p+lirgxXUkPHWpzv+A==
X-Received: by 2002:ad4:568f:: with SMTP id bc15mr658137qvb.44.1632744156813;
        Mon, 27 Sep 2021 05:02:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s12sm12065144qkm.116.2021.09.27.05.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:02:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mUpL9-006J0p-OP; Mon, 27 Sep 2021 09:02:35 -0300
Date:   Mon, 27 Sep 2021 09:02:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Use dma_alloc_coherent() instead of
 kmalloc/dma_map_single()
Message-ID: <20210927120235.GB3544071@ziepe.ca>
References: <20210926061124.335-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926061124.335-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 26, 2021 at 02:11:23PM +0800, Cai Huoqing wrote:
> Replacing kmalloc/kfree/dma_map_single/dma_unmap_single()
> with dma_alloc_coherent/dma_free_coherent() helps to reduce
> code size, and simplify the code, and coherent DMA will not
> clear the cache every time.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/infiniband/hw/irdma/puda.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)

This I'm not sure about, I see lots of calls to dma_sync_single_* for
this memory and it is not unconditionally true that using coherent
memory is better than doing the cache flushes. It depends very much
on the access pattern.

At the very least if you convert to coherent memory I expect to see
the sync's removed too..

Jason
