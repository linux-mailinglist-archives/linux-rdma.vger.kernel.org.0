Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3B2C41E5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 15:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgKYOMr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 09:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgKYOMr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Nov 2020 09:12:47 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AADC0613D4
        for <linux-rdma@vger.kernel.org>; Wed, 25 Nov 2020 06:12:46 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so1625655qtb.10
        for <linux-rdma@vger.kernel.org>; Wed, 25 Nov 2020 06:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2m9DC+TbVxZpxmRbjSlmcBQirDZa4fZfdvPGxT1eWog=;
        b=f56rDruwzJbLVe+DzWANSAFhymVcwr8bCGkFkxHqDTbH7tYEFjJUCjNxH3dS8qln42
         h3Qsclr942mG1kxkiI7my4GKsO0iGfxISM9RsJfUr/d3F4toLK/ihiOtiad9DpbajqI2
         eYkncyQ7kPvta19ia7Q5oBO4DTjqnbEYpLGn/pCVsOmOROig8jzG5waB43GuKMVJsHND
         pel9WJVR1/R5jL3PNJVmH/cqDz+2y91Rp8NDNSqdtuL+GwAS9IVplISR4fv6+SMe8WHG
         f3x85rEmyOgS2mmPKYaPYtuOnsvfckfzzo0Y1upHoouN2DEIHH5+43PP8Mo4N1tixVQc
         /M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2m9DC+TbVxZpxmRbjSlmcBQirDZa4fZfdvPGxT1eWog=;
        b=VzFgVxYbjyXw3eAGkv9YVNyFTsVxQkUyBO2+yX+0PjhE2dKXXauitVd7Y4xP+zbiOY
         yaItVqVOwSfFB/dCTVicPn/3H21aUYaFrjDt6LnKo0RfY7PCmRHcIncTiHqC/DgLthll
         ka67U3G6flDRpLxaKB+NDh+O6RNG62ko6QMEn9bUW3hV3zhjRMDu7cDOVE0Rs5UiyJZw
         ruo2+Z/1U7WJfnozIjyMbZ4+T6+2f2ujqHASuLWis2Bfp8N8MKTL3Sk9twxbDr4DZRRL
         Ty4iEOfA6++AVwkooTI5N6tC4NPPn8a/I0mmmUEYpOJfDgkoa+roCjGswa6hw24tSoDo
         pY/A==
X-Gm-Message-State: AOAM5308OCYyXVhyzwtOqSP2trkML6+uFyZqtyScwj3021vzMOp3mbkz
        GNPLoWHMa/SSgqev4VVHPhVSpA==
X-Google-Smtp-Source: ABdhPJy+Hc1+XSQ5Ki4YDwpHS2sjBkxDuLqOllk/dPYFMN72kkviHvHFz+Rf7m8lIkwUiNTpaVEjzg==
X-Received: by 2002:aed:2393:: with SMTP id j19mr3239141qtc.23.1606313566133;
        Wed, 25 Nov 2020 06:12:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h13sm2722429qtc.4.2020.11.25.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 06:12:45 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khvXI-001C7G-26; Wed, 25 Nov 2020 10:12:44 -0400
Date:   Wed, 25 Nov 2020 10:12:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH rdma-core v2 2/6] verbs: Support dma-buf based memory
 region
Message-ID: <20201125141244.GN5487@ziepe.ca>
References: <1606253934-67181-1-git-send-email-jianxin.xiong@intel.com>
 <1606253934-67181-3-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606253934-67181-3-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 01:38:50PM -0800, Jianxin Xiong wrote:
> +/**
> + * ibv_reg_dmabuf_mr - Register a dambuf-based memory region
> + */
> +struct ibv_mr *ibv_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
> +				 int fd, int access);

Please include the iova in addition to the offset for this API

Similar to ibv_reg_mr_iova

Jason
