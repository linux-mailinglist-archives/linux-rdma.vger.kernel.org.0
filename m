Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ADA1B4CD1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 20:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgDVSpS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 14:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVSpR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Apr 2020 14:45:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749BDC03C1A9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 11:45:16 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z90so2568650qtd.10
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YAeA4fJ/9qVwPfVOWwvxJiwnfVq/NjXBKtVn8ARmZoA=;
        b=VwvpSJF1LJ//KSh9AJ5kIpVXxQYoV4OzvgigphMxVoDjLup1mlSt6f6sGgcNsQEjGa
         yy16AEyZ9mlpQtJJtI9GrPHGkToMgbqFmY4WPdW0izVSGBAVKj1kikWcD4jNVrITr0Co
         tjx8o6mhF4ocLnLL0XJDsZ0npCEHKWvxIfu3BjLFTBcE5VlDgBZzNR6Vy/2sesoFSkuN
         yFOrhKY5AXAityWJ4jnKYFKINyEMvRfZfZShudY3xtDXlET3yH8bahipaeO6EjPOCvT9
         qTlx1W4Cx2xz76xnEsqDBHnVUCk4ltyVT9XgTu9tDJfJAyhW+V+3vOQRCDCEmzNt5BPv
         I6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YAeA4fJ/9qVwPfVOWwvxJiwnfVq/NjXBKtVn8ARmZoA=;
        b=B0SBOM8bhSJWDfN/7qLIZhNbJ93WscgMpHmUnyYjs5+cmBTQ0OznOc5qsamlFGZur1
         iidiSTsUjUFXSye3Pw3ldpbPB+B/Mej7pGUazJwnbjkkK903NaTJqj0m2/Qc5+lWeUAo
         sYK8DlgJr6D3W+tNno0Quy8YTmSWTLaQMhEnIxsSyDSKtq1y9P4OSpo2VfvSRFiP1TTF
         7Xn998fCv7s3pgK4F5FGd4eAtbHiSvY4a9Om+GvRB0OB/rj6W4DMfKEa47Fe5a9ebCDP
         CnFK2+V3tnilFAs+oaZMRzW1lPv2f+ZjoSKAtCzHfWewtyaqAAIJPxec3s7rI44pJqhJ
         LuNg==
X-Gm-Message-State: AGi0PuYdnp9mU0YUtEqT5zTbc07XNLT+2mKxnANT4nmHJgHlr4ofnNL/
        2aTvW3xDWs98VCyTvcgv2zMQEw==
X-Google-Smtp-Source: APiQypLS1KfxFyFrti0epfxMMAO4XY7ZSw0OI4Yzn5wf4PoMRIrM1kmmz9eN2Zj7SrnK7SQeBDcf7Q==
X-Received: by 2002:ac8:7683:: with SMTP id g3mr16444qtr.166.1587581115716;
        Wed, 22 Apr 2020 11:45:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k2sm50454qte.16.2020.04.22.11.45.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 11:45:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jRKN0-0003LS-Ob; Wed, 22 Apr 2020 15:45:14 -0300
Date:   Wed, 22 Apr 2020 15:45:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        linux-rdma@vger.kernel.org,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/uverbs: Fix a race with disassociate and
 exit_mmap()
Message-ID: <20200422184514.GB12730@ziepe.ca>
References: <20200413132136.930388-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413132136.930388-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 04:21:36PM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> If uverbs_user_mmap_disassociate() is called while the mmap is
> concurrently doing exit_mmap then the ordering of the
> rdma_user_mmap_entry_put() is not reliable.
> 
> The put must be done before uvers_user_mmap_disassociate() returns,
> otherwise there can be a use after free on the ucontext, and a left over
> entry in the xarray. If the put is not done here then it is done during
> rdma_umap_close() later.
 
> Add the missing put to the error exit path.
> 
> Fixes: c043ff2cfb7f ("RDMA: Connect between the mmap entry and the umap_priv structure")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to for-next, thanks

Jason
