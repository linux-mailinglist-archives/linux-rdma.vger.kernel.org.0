Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D477C702
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 07:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjHOFVE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 01:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjHOFSw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 01:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172151BF6
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 22:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB5F062F0B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 05:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800D9C433C8;
        Tue, 15 Aug 2023 05:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692076694;
        bh=PPgfEcefMYr1Cpwsy6bs5VSfnfwLQXlmPcbRNjHpSVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3trjYt98L+QvSM2jepPl9qnP9pA+U6xhmYB+ivkBk6Rhr7BejzOdjpqkaMzYZuXa
         Bc1ixnSpAyE7IsLSDewUDfxTetGIGF/W+FcJuvJ+fSvO2g3kfimh+gBOUs8GCD0RsJ
         XtcIdWyTjRprc2hdGg6PSUbv96WHMvtabEWRWxMX6U9MwuhloXwBWEprADkeTyqJ6/
         ZFvAiseVXJEL2hNiwKyteT6SJyjkY9qUMyN3PPImjEWH1z9NwtWIDI5Y1kngMkKLcb
         fueApWZu0PYyLOJgyOXi4+1oW4jKx+jW2oGwtqxpHUDaorFV3pO7g8jaD+HMlEMIPU
         5ttzwDkxySAkQ==
Date:   Tue, 15 Aug 2023 08:18:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Ruan Jinjie <ruanjinjie@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH -next] RDMA/irdma: Silence the warnings in
 irdma_uk_rdma_write()
Message-ID: <20230815051809.GB22185@unreal>
References: <20230811062215.2301099-1-ruanjinjie@huawei.com>
 <20230813092235.GI7707@unreal>
 <MWHPR11MB002969B2763A53C37368615BE917A@MWHPR11MB0029.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB002969B2763A53C37368615BE917A@MWHPR11MB0029.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 14, 2023 at 08:55:44PM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH -next] RDMA/irdma: Silence the warnings in
> > irdma_uk_rdma_write()
> > 
> > On Fri, Aug 11, 2023 at 02:22:15PM +0800, Ruan Jinjie wrote:
> > > Remove sparse warnings introduced by commit 272bba19d631 ("RDMA:
> > > Remove unnecessary ternary operators"):
> > >
> > > drivers/infiniband/hw/irdma/uk.c:285:24: sparse: sparse: incorrect type in
> > assignment (different base types) @@     expected bool [usertype] push_wqe:1
> > @@     got restricted __le32 [usertype] *push_db @@
> > > drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     expected bool [usertype]
> > push_wqe:1
> > > drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     got restricted __le32
> > [usertype] *push_db
> > > drivers/infiniband/hw/irdma/uk.c:386:24: sparse: sparse: incorrect type in
> > assignment (different base types) @@     expected bool [usertype] push_wqe:1
> > @@     got restricted __le32 [usertype] *push_db @@
> > > drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     expected bool [usertype]
> > push_wqe:1
> > > drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     got restricted __le32
> > [usertype] *push_db
> > > drivers/infiniband/hw/irdma/uk.c:471:24: sparse: sparse: incorrect type in
> > assignment (different base types) @@     expected bool [usertype] push_wqe:1
> > @@     got restricted __le32 [usertype] *push_db @@
> > > drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     expected bool [usertype]
> > push_wqe:1
> > > drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     got restricted __le32
> > [usertype] *push_db
> > > drivers/infiniband/hw/irdma/uk.c:723:24: sparse: sparse: incorrect type in
> > assignment (different base types) @@     expected bool [usertype] push_wqe:1
> > @@     got restricted __le32 [usertype] *push_db @@
> > > drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     expected bool [usertype]
> > push_wqe:1
> > > drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     got restricted __le32
> > [usertype] *push_db
> > > drivers/infiniband/hw/irdma/uk.c:797:24: sparse: sparse: incorrect type in
> > assignment (different base types) @@     expected bool [usertype] push_wqe:1
> > @@     got restricted __le32 [usertype] *push_db @@
> > > drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     expected bool [usertype]
> > push_wqe:1
> > > drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     got restricted __le32
> > [usertype] *push_db
> > > drivers/infiniband/hw/irdma/uk.c:875:24: sparse: sparse: incorrect type in
> > assignment (different base types) @@     expected bool [usertype] push_wqe:1
> > @@     got restricted __le32 [usertype] *push_db @@
> > > drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     expected bool [usertype]
> > push_wqe:1
> > > drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     got restricted __le32
> > [usertype] *push_db
> > >
> > > Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202308110251.BV6BcwUR-lkp@intel.
> > > com/
> > > ---
> > >  drivers/infiniband/hw/irdma/uk.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/irdma/uk.c
> > > b/drivers/infiniband/hw/irdma/uk.c
> > > index a0739503140d..363c67c18924 100644
> > > --- a/drivers/infiniband/hw/irdma/uk.c
> > > +++ b/drivers/infiniband/hw/irdma/uk.c
> > > @@ -282,7 +282,7 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct
> > irdma_post_sq_info *info,
> > >  	bool read_fence = false;
> > >  	u16 quanta;
> > >
> > > -	info->push_wqe = qp->push_db;
> > > +	info->push_wqe = !!qp->push_db;
> > 
> > Shiraz, push_db is declared as pointer, but I don't see where it is allocated. Current
> > code works because push_db is always 1 entry.
> > 
> >   316 struct irdma_qp_uk {
> >   ...
> >   324         __le32 *push_db;
> > 
> > and
> > 
> >    156         set_32bit_val(qp->push_db, 0,
> >    157                       FIELD_PREP(IRDMA_WQEALLOC_WQE_DESC_INDEX,
> > wqe_idx >> 3) | qp->qp_id);
> > 
> > Such variable use is not great. can you please fix it?
> > Can Ruan use "qp->push_mode" check instead of "qp->push_db"?
> > 
> 
> Hi Leon - Thanks for bring this to my attention.
> 
> Seems we don't have all aspects of kernel push implementation and yes
> the push DB not mapped renders it void. And this code is also in kernel fast path :/
> 
> kernel push is not plan of record at this point and the patch (below) cleans it up. I can send this to the mailing list.
> 
> I am fine if we want to spot fix the sparse issue through Ruan's patch here.
> qp->push_mode and qp->push_db are not really equivalent.
> The latter is constant once db is mapped. The former is transient per qp, comes and goes.
> But its all mute anyway as it stands now.
>  
> Or we can just use my removal patch to fix the sparse issue as well.

If we have an option to remove, it is always preferable solution to me.
Please send your removal patch to the ML.

Thanks
