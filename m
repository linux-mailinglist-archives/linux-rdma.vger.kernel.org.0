Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF22D3712
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 00:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbgLHXmY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 18:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXmS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Dec 2020 18:42:18 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258FC0617A6
        for <linux-rdma@vger.kernel.org>; Tue,  8 Dec 2020 15:41:32 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so108101qtp.7
        for <linux-rdma@vger.kernel.org>; Tue, 08 Dec 2020 15:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rPNigW+nYiMVFpS2HNpPz+E34HVn3r2r0I5yXJefsg0=;
        b=INvPDUjmBQg/XN/s94mwe+p9VTcHDyg24OIgi8usg+LPtqCKJ/yLY3fOZv/k1QJfmk
         ghsp/Lj9V5tu7Dy2VE/ajVWjzMyKghABF3dcRxHo33vLciJkdAtH9PbnfGnIaGtoEHb6
         hdXwuYBNOQ4S7ifBs8upiX3auZc/7iLC5oRZHDlarJHur4kCSgbMWeBYs4iDV7q1FIOr
         sw8TyZFDjFwpHqkfpV/1K3XVVOYlw56mXOz+MPLpCGPVeFSukrmigdP6jNpAtQRNN4Gf
         AUAAAxGpEwTz3p+YkIlMCCa7nUDgA4eb4lLDXqmv/i3lkkuaRJ855iiPgnmAtKN8M2D0
         VZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPNigW+nYiMVFpS2HNpPz+E34HVn3r2r0I5yXJefsg0=;
        b=eMj1QLQs/dyej3TyvPMsE1vn6j98+6IP7/zSdm0pKrRm0oSYR41BQpxT0iaj2POTIJ
         PdJX2VJaZgLDdrzs14TIq8ET2ueyVHhG2eEL42d8Zq2rKr8mdTLrvjrfP2WnEPx4yCDE
         pCD0YBFLUA78i0jBqF4c89Ro7qOxKMnKZ25gKOcpxFwF0hyHhbd4LetMdi/81nNCmd5i
         gnzmnDgqyttvFVvq4wZgh3+ZZHQhlLsuzwjVTOWZfN2uDshHHz434xwm9C9du4hLTWNz
         xKuzgnIn65nwH2bMybLJVN67xjZPGnALqhE8nYcRbX6cMDtRb7pTKBgxlBghD1iLwPIo
         k/vQ==
X-Gm-Message-State: AOAM530b3bCXc6qX6TLZIaua2bVOjwzy62anV0pRtYAK3qFdgfG1rrLS
        A9wJ0faKhfWBk6Yc1Hx2c75tjw==
X-Google-Smtp-Source: ABdhPJzH06GR1oL/I8np/AXOA+PRONtRyvvr67W9LuNjviB7kkzJ7iR5hHdRJNdVVeoz687VjkhPCg==
X-Received: by 2002:ac8:5a03:: with SMTP id n3mr677650qta.240.1607470892118;
        Tue, 08 Dec 2020 15:41:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id o68sm200168qkf.84.2020.12.08.15.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:41:31 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kmmbq-0083ZD-Vj; Tue, 08 Dec 2020 19:41:30 -0400
Date:   Tue, 8 Dec 2020 19:41:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v14 0/4] RDMA: Add dma-buf support
Message-ID: <20201208234130.GS5487@ziepe.ca>
References: <1607467155-92725-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607467155-92725-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 08, 2020 at 02:39:11PM -0800, Jianxin Xiong wrote:
> This is the fourteenth version of the patch set. Changelog:
> 
> v14:
> * Check return value of dma_fence_wait()
> * Fix a dma-buf leak in ib_umem_dmabuf_get()
> * Fix return value type cast for ib_umem_dmabuf_get()
> * Return -EOPNOTSUPP instead of -EINVAL for unimplemented functions
> * Remove an unnecessary use of unlikely()
> * Remove left-over commit message resulted from rebase

You should probably slow down a bit, v13 needed rebasing too.

Jason
