Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF4E7749
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 18:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404023AbfJ1RHe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 13:07:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33342 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfJ1RHd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 13:07:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id 71so9197920qkl.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IN7x0hiFXqyQYUwYDLeUiDxKVsIP6hFICx2nFLfvGsM=;
        b=o61LF9quMUiEwwpHrdt9CIW5Ea014D3onjM16SG49Ss7EgCHk+Fj1Bo9sPHQ8UWTlI
         E0hk1hClLmAXFK19WSyHz/acLgGEgpiWGKCF8zNrB08723zylLnnFF1bLQVfgPkfyo51
         is5DKFpMtxIosP9g0Pzn31wP/nrWp1AW8dcayXLXN8hnkr2hIVijUK+ZYvvUjlZoxVqb
         bNTyBn3G5xZ+oQ/bYIvfi52AtxopOP8AErFDCKQFPxfFGun8ohs/wdQ7rJRq22maUlpa
         88Qc5WtMyIPtAOkPHe3KBRsKM3ZJHZ2kbffa9olhy4IrZkxu0YcjuC3Lb9kvnKwS8qxv
         qexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IN7x0hiFXqyQYUwYDLeUiDxKVsIP6hFICx2nFLfvGsM=;
        b=DCnr142rODhS42YsDiQSlUi5BoT2Kmm75kGXt0k/ntK0C8Z6ywhSzet1V/InRiISvz
         erJM2mXNdAc3Vu/a9+MCAof5jmbEbJpnfvhDuO3+wXXrQ3k23NLInLarqdKWmcnCCPRf
         d4Rpnwe5zmKLJmgOEMLnnL8mgwtoWG6rOY1X9P/RdP9x07vpIL5aNd0bEDafH8yF5g3L
         nJAlDMctjRt81sMk6LFpWMs2iAp/qzEIfwhKktzQItA4vOjXRAyoQE4juY6uazneX3ue
         Gg9pbTYz/PehUc60LuHkxxPQIqiSbAPzXugYqV9mD1mFtSZk2eODxZQkGgJSCMUQNnSW
         wz3g==
X-Gm-Message-State: APjAAAU64khalcDKSaF8P9oqLu50F8N4zpQ8C76TwhbLlr8hoql7X1Sa
        fv18HuEo7tYy+O+Id9/rLygf7A==
X-Google-Smtp-Source: APXvYqyiUOOttKoBpgcTyQ2HLtEUOIGocxCuD133G/wSxMKy2Uyr/hkFlOWaZ8W59SZhuw7akQRgRQ==
X-Received: by 2002:a05:620a:b12:: with SMTP id t18mr201557qkg.129.1572282452856;
        Mon, 28 Oct 2019 10:07:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j63sm6023141qkc.113.2019.10.28.10.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:07:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP8UO-0008Og-1H; Mon, 28 Oct 2019 14:07:32 -0300
Date:   Mon, 28 Oct 2019 14:07:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v4 rdma-next 0/4] RDMA/qedr: Fix memory leaks and
 synchronization
Message-ID: <20191028170732.GA32173@ziepe.ca>
References: <20191027200451.28187-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027200451.28187-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 27, 2019 at 10:04:47PM +0200, Michal Kalderon wrote:
> Several leaks and issues were found when running iWARP with kmemleak.
> some apply to RoCE as well.
> 
> This series fixes some memory leaks and some wrong methods of
> synchronization which were used to wait for iWARP CM related events.
> 
> Changes from V3
> - call xa_init for the qpids xarray.
> - add another patch that calls xa_init_flags for srqs xarray.
> 
> Changes from V2
> - Add a new separate patch that fixes the xarray api that was used
>   for the qps xarray, there was no need to use the _irq version of
>   the api.
> 
> - Move xa_erase of qp_id to be right before the qp resources are
>   released. This fixes a race where the qp-id can be reassigned
>   before removed from the xarray.
> 
> - Modify places that call kref_get_unless_zero to kref_get since we
>   already hold a valid pointer.
> 
> - Comment about the usage of the same completion structure for two
>   different completions.
> 
> - Add Fixes tag
> 
> Changes from v1
> - When removing the qp from the xarray xa_erase should be used and
>   not xa_erase_irq as this can't be called from irq context.
> 
> - Add xa_lock around loading a qp from the xarray and increase the
>   refcnt only under the xa_lock and only if not zero. This is to make
>   qedr more robust and not rely on the core/iwcm implementation to
>   assure correctness.
> 
> - Complete the iwarp_cm_comp event only if the bit was turned on and
>   the destroy qp flow will attempt to look at the completion
> 
> 
> Michal Kalderon (4):
>   RDMA/qedr: Fix srqs xarray initialization
>   RDMA/qedr: Fix qpids xarray api used
>   RDMA/qedr: Fix synchronization methods and memory leaks in qedr
>   RDMA/qedr: Fix memory leak in user qp and mr

Applied to for-next, thanks

Jason
