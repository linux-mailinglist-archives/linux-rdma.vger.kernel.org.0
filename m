Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF1C3752
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbfJAO3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:29:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45589 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfJAO3b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:29:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so11369739qkb.12
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBar1LOBbFYL7aAp1O7Td+764yneSO71RuUf2bSZwA0=;
        b=kLzlb/eXJkrwAiJ4KmwnkiEIIJ3lgPAD4URbzWgmfCIb55KVGjFo1N5ZQ7yTiucJP7
         U4TTjyllz2jsHo58XermOaDZ3QYZeL7QXqYEMAPl/uRjDXr2yzgvX5QzOS9oBNGLwShQ
         yKAFiHGDGlEIpGbJaaUb7qZhvXK3kwrLxAnC4tR1o04hziY79N3HPsfaY/n82TJH/HrN
         SDaHUZxfzwsd4+S45wSFGq1akpvv8LuUVwg6KzektmFCV3pofQv6Iv7GcMQvg6WB/cAP
         Ttw7S4g/Bi6UpTdRkIJViCfxuNMnV7ZGfJURg6YacDf8qDezqOJxS5E62u6y57q9gzdB
         ugMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBar1LOBbFYL7aAp1O7Td+764yneSO71RuUf2bSZwA0=;
        b=OITWBAt3M1r4GLbTFC6gfDgMNd8l5Aixby9PjwVdY5B9YqxiAnCzj+doRXRST3u3RB
         o6x6uEXAFMSJBQLFpgrnf3qa3/CgZPKTI6i4ZTuCAEbwVOsBWdF5finnpGjQlSp/elNb
         6v/qpHUg5wnO+VdkK7jEysJj4cnyO13UFBE7x4EHB4dp4mphif0l1mmkeqOXWQcDH2Gw
         X0L7L4bpd4oNh4DP3M31V5LDDrdPcU8JqDF98UANOdeXecpfazUpMcJNP1x8ZfwMyEXW
         XsyPksVx3cYJMDfEjEBgXz0YY+0VLw/kRUs75/gQe7XNRnfr9WCAGScWM1CLTQFLNqaD
         vg0g==
X-Gm-Message-State: APjAAAU5a3aOP4yDv4i7YWBozBpwLycFeINBk5E1WT5ODuKYxLZ/MA1U
        VSyHbmj4wzhGFpPvMxRAtHdlAA==
X-Google-Smtp-Source: APXvYqxrLFQkx8xhgulK4JXA/3zlWfT5zexzBlYADsQ+NKATSrVgWOngK3rgJJX4FtqL7i0E99Th5Q==
X-Received: by 2002:a37:9a13:: with SMTP id c19mr6344898qke.378.1569940170985;
        Tue, 01 Oct 2019 07:29:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g19sm12305104qtb.2.2019.10.01.07.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:29:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJ9d-0002yY-PJ; Tue, 01 Oct 2019 11:29:29 -0300
Date:   Tue, 1 Oct 2019 11:29:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com, sagi@grimberg.me
Subject: Re: [PATCH 1/1] IB/iser: add unlikely checks in the fast path
Message-ID: <20191001142929.GA11407@ziepe.ca>
References: <1569274369-29217-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569274369-29217-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 24, 2019 at 12:32:49AM +0300, Max Gurtovoy wrote:
> ib_post_send, ib_post_recv and ib_dma_map_sg  operations should succeed
> unless something unusual happened to the ib device.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/iser/iser_memory.c | 2 +-
>  drivers/infiniband/ulp/iser/iser_verbs.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
