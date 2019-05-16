Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308F42045A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEPLQK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 07:16:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38134 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfEPLQK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 07:16:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so3356088qth.5
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dgG827h4xHr7z365VN3FGwrSU2zh6E/LrTDEofMaaKE=;
        b=cVVwz2TyFNZS5i00t4HDbj5w16ojHP0lAlyDRvpAjTe4oLhrENzEAwpaaXAOa+arbY
         myXKRLKzHTOzHugKGp5/UspYUrfk/r6ZENPnkJGFJoFH5YNp/88jwLUKGtupg/yg1yna
         tVyVgdp5E9zLVPFJSC//Spg36lbNk6KDEtx8biJzpQQ6SqXDKf9JOh7wXcbXRIPzyFae
         yJazleARAcE68C9k94rPII41rStsjepL4ynxKMQM6QucOkD/TD7Vej+V31MnQxzHNn0q
         DJ9eFO9lGS9lGOc7SFAzQKWpVg8q3GYMujwVBzcx3xCN2iNOBVao0pWHA80dpnZ49D5O
         0GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dgG827h4xHr7z365VN3FGwrSU2zh6E/LrTDEofMaaKE=;
        b=ECP5Vuqv5DUQD8vk+bPTNdPVcyPk7tiboAgZTvRZfVHE1qd/K9qZGnmWFj1rYLmufq
         gihLQLICt4PWEydZYV5LDUeF9ZbDmpwyw6rxXDKsOHPXa6HRm/1v+iyAoYeTFf3xAQZn
         I5jwaxqggF+Npzr+nHHZP89/FBa5+kIzqgBHJPila0H32+apfxIozawVPTPLKXFp+ULo
         q7XTmnB4/1a1keVAc0qnQLckECUsbxYHC6Q1fKzm7ijoxJQRbRfTOPU9Nj/kwGo5Khu5
         d6TlFUgOKkkk/onHDD6YdYluS97qKRtxxfq3w/QPa16g96DORdiZV/08Mxt489da4Hyd
         GRaw==
X-Gm-Message-State: APjAAAVITGF4CF8IutcCNfuROYJJutqbGhFuZeOqVoMUnLTKcVRUels7
        SB9YjYRIcXWINyHmWjB8Hgt3+CLwwIA=
X-Google-Smtp-Source: APXvYqzHQMn2SX3hWJbmmP3JAuIm5wmkj9J+uRVk4hHEzL4nCheBh1ZKTcl5KmbU5IR2f4TrjeOvPg==
X-Received: by 2002:aed:224e:: with SMTP id o14mr41074733qtc.271.1558005369248;
        Thu, 16 May 2019 04:16:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id a51sm3419908qta.85.2019.05.16.04.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 04:16:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hREMp-0006B3-Vz; Thu, 16 May 2019 08:16:07 -0300
Date:   Thu, 16 May 2019 08:16:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
Message-ID: <20190516111607.GA22587@ziepe.ca>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516105308.29450-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 01:53:08PM +0300, Kamal Heib wrote:
> For RoCE ports the call for ib_modify_port is not meaningful, so
> simplify the providers of RoCE by return OK in ib_core.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/device.c              | 23 ++++++-----
>  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
>  drivers/infiniband/hw/mlx4/main.c             |  8 ----
>  drivers/infiniband/hw/mlx5/main.c             |  6 ---
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
>  drivers/infiniband/hw/qedr/main.c             |  1 -
>  drivers/infiniband/hw/qedr/verbs.c            |  6 ---
>  drivers/infiniband/hw/qedr/verbs.h            |  2 -
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 -------------------
>  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
>  drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---------
>  14 files changed, 14 insertions(+), 107 deletions(-)

We have more roce only drivers than this, why isn't everything
changed?

Jason
