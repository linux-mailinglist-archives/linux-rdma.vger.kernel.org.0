Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA55D489CAF
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 16:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiAJPug (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 10:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiAJPud (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 10:50:33 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B252BC061751
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 07:50:33 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l17so14817248qtk.7
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 07:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=taJK4990Hf5ggLF7x5d/tJzG7fwO4y08TUkbCKMXkXM=;
        b=SU3mKDe+NFt3ELa2q1426sexnDWTv18yKIPDP2du70kd2dvXb52pbMprOX3r4vXwnT
         RbL/u0D3fPqnhE75Zta7ky5PgQl+H7WlhwgI11Y9Dz1SlLlNyp1vZelvZQfiKOIBLikl
         9VdKprbwittxaamxOVCN3EL4GuHf/srjHctuYUzkQ2alUkCvKBgXraQVXsc11RTekBnu
         iacR1txVlA/jNx6GNjsFWSQwvPhSc/uJHfJ/mKUmnB7DVKYliIoB4dEZciKewszMijkI
         vO1LhdxWqyO0YGpmagOxmsqhoVMgkRSsEN7ww+ni+rjYhOHFPPU2YpgW1eD0xXLut+sY
         VFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=taJK4990Hf5ggLF7x5d/tJzG7fwO4y08TUkbCKMXkXM=;
        b=m5kQBf79KbQXuOGW42ZnwWHMvbfEfEnzz0hDNeeOC6U9rGMLwQP0U6wwWdVX+3aVsI
         fAkAAP4CGmUiU+4LX8wWED7be0ZML299Emzn+ojj3nhfw3RFNOUTY2nUja1tHAfs6+tV
         mX7KyNecN8XagptTl2w6O7P/x29y5D3gkT+vXK5xV/piKTCgXRihK6Hfg5lJy1J97Eg+
         oFr2C1SbSY25ZJDMNoU43LHcygIMY4/CQzozk9nfSX3dzCfrcMOMjuOUPzsqmb5t770M
         eP+ukCPiMwS/XCLw0NnHlsT6qjjvCnQTrb/fNpX4BS0hs2Zk3K2D74iL+hgjeeNGpZbf
         WIRg==
X-Gm-Message-State: AOAM532sL2tJL8ke7Z2ZUSs/HbuAAoRmj1rnKwkgODYvMASE/DUpfeXo
        dk1INWoaoCCN+IHtZ7KQlVQseQ==
X-Google-Smtp-Source: ABdhPJxBj0ZyPgNVhc4jPK7tenIAOTO7n8CuI533poIMXs6L4y67rXu3AheljFk+wuxJDExcGtdWCQ==
X-Received: by 2002:ac8:74c6:: with SMTP id j6mr229936qtr.557.1641829832895;
        Mon, 10 Jan 2022 07:50:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id r4sm900398qta.51.2022.01.10.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:50:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n6wwJ-00DpQ8-Ir; Mon, 10 Jan 2022 11:50:31 -0400
Date:   Mon, 10 Jan 2022 11:50:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/mthca: Remove useless DMA-32 fallback configuration
Message-ID: <20220110155031.GI6467@ziepe.ca>
References: <4aeb3dcf39490334acf583e723a08ea7262b0912.1641716983.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aeb3dcf39490334acf583e723a08ea7262b0912.1641716983.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 09, 2022 at 09:30:09AM +0100, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398

Can you use lore links please?

Jason
