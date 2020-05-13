Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3276D1D1D2A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbgEMSOh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733070AbgEMSOg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 14:14:36 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED3C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 11:14:36 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h26so596921qtu.8
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RT/e8SW0jsnxeM5AgBgEFQX4DlArJymp2FEkRyATaY0=;
        b=CV+ompwT/AYaO8OX8frm+p3y3ZXVVdCoLRw7VEmUNxtkGNbpiXWDL/+ir82OtMfppV
         7fEuIPq2J06c/FoXgskjkVD2r61F/d/bTvQNEpq34e9Y1oMuXqZtGhty0rKj8RdWVGYd
         SUamFe42wSX6Ho18QXBP/tsvTbXy1gFLuGEN8QUmjfDts8ZlCmj2sLEZQ+uEJL+89eV5
         o8MeVoRMVwHgAgRU4AKujkSGUGLEy0z/Ai9Rl5Xs01hRO3vn0w+tmG04QfFvBExIgkV3
         xOfeiadEqOY38GpNReduOBBnfGUfKgFG3WhQffh4vefyH8hMSiMyl3N/W+Tdqy2JYjjt
         kPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RT/e8SW0jsnxeM5AgBgEFQX4DlArJymp2FEkRyATaY0=;
        b=arRzmg3MzX1NnYrIuQR3qU61so1AmbnwoyhEcoYNQ06iFABJSLmXxfiTb4NGvcBmGZ
         BZLTBSJ7Cw1pQhlFcfqJTnD56FCSpoS5fdwjmVdarZJzA2eKwWlboN29m3XhGU1pKIvC
         icEky94/mYa1hpfE3jk7TuBvhBr4xEvK8w6z8Pw9H7Go0Fz/Fzxzh6KAxuqy+jjaKjaR
         1e4wD6i++Sg1Pz0qgHnLZWrBO0CKT/OTxs0fwmRmOz94I3p+8AMULZO2SNG2tKv74ALE
         YF+9vkQy1zffUd89nRmuoYghW3ZacUi6Is/O1122q9OLC1hjCUqbWaWTOLO+oYQUW6n+
         5fLw==
X-Gm-Message-State: AOAM533oigk6ydSs2PYBjEQAHpX0vi+/RZM/ZKMsJ7T6CSc6T3k/UB1r
        b/M7iQTo0HIJR3I+Oueg08yxig==
X-Google-Smtp-Source: ABdhPJzMSJv1jEVbvGtMlLeIDbfFW+8i2/ZvWB85DxkVPFSPcuUNZOSxsECxpxLRMVZD6z3neyugxw==
X-Received: by 2002:ac8:302e:: with SMTP id f43mr402156qte.366.1589393675412;
        Wed, 13 May 2020 11:14:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o67sm523845qkc.2.2020.05.13.11.14.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 11:14:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYvtq-0007Fg-EJ; Wed, 13 May 2020 15:14:34 -0300
Date:   Wed, 13 May 2020 15:14:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     bvanassche@acm.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, leon@kernel.org, sagi@grimberg.me,
        israelr@mellanox.com
Subject: Re: [PATCH 1/1] IB/srp: remove support for FMR memory registration
Message-ID: <20200513181434.GG29989@ziepe.ca>
References: <20200513144930.150601-1-maxg@mellanox.com>
 <20200513145722.GH19158@mellanox.com>
 <221e0bb5-31d8-c0ba-207e-67119cc39070@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221e0bb5-31d8-c0ba-207e-67119cc39070@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 07:11:59PM +0300, Max Gurtovoy wrote:
> 
> On 5/13/2020 5:57 PM, Jason Gunthorpe wrote:
> > On Wed, May 13, 2020 at 05:49:30PM +0300, Max Gurtovoy wrote:
> > > FMR is not supported on most recent RDMA devices (that use fast memory
> > > registration mechanism). Also, FMR was recently removed from NFS/RDMA
> > > ULP.
> > > 
> > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > Reviewed-by: Israel Rukshin <israelr@mellanox.com>
> > >   drivers/infiniband/ulp/srp/ib_srp.c | 221 +++---------------------------------
> > >   drivers/infiniband/ulp/srp/ib_srp.h |  27 +----
> > >   2 files changed, 24 insertions(+), 224 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> > > index cd1181c..73ffb00 100644
> > > +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> > > @@ -71,7 +71,7 @@
> > >   static unsigned int cmd_sg_entries;
> > >   static unsigned int indirect_sg_entries;
> > >   static bool allow_ext_sg;
> > > -static bool prefer_fr = true;
> > > +static bool prefer_fr;
> > >   static bool register_always = true;
> > >   static bool never_register;
> > >   static int topspin_workarounds = 1;
> > > @@ -97,7 +97,7 @@
> > >   module_param(prefer_fr, bool, 0444);
> > >   MODULE_PARM_DESC(prefer_fr,
> > > -"Whether to use fast registration if both FMR and fast registration are supported");
> > > +"Whether to use fast registration if both FMR and fast registration are supported [deprecated]");
> > Why are we not just deleting this?
> 
> Are you talking about the module param ?
> 
> Usually we deprecate it since we don't want to break existing APIs.

Well, you just basically borke the bevaior of the flag, so you should
delete it as setting it won't do what it is supposed to anymore.

Jason
