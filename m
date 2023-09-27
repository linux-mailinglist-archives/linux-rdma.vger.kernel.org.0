Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0202A7B0B53
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjI0RyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 13:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0RyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 13:54:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BA8A1
        for <linux-rdma@vger.kernel.org>; Wed, 27 Sep 2023 10:54:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD6EC433C7;
        Wed, 27 Sep 2023 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695837240;
        bh=d0gV61FJBDuKOniX44ax4golFbseNuGM7DcGerXVwpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mq3PV8QbL41gtAqmtZHlh/0D0Cy9nn99Tz6iOUO01HtiCPAQ/pSRikS7D2VNQMR6W
         L5qSG8T30KAqouO0uALYVgf9MNsSDYCIRfPgJzEhHFW25RttH9qXzhTDTxjQYKcLgI
         ks6eKDOLyyf/+WHHMmXK6r/ojYvBW5MiSnWSfooCrHetUKKsw/ANOo2iNH6ixxeiGu
         wlnsvNoAMd7LoOis1WxxXk91whO8HQiJpHpKt6f/xxMVGGCQXImKSSY1+Sgj2plETG
         hwM2YBuJaJULVyav1y23ZBrPYWs0lAL9luisT8M3h6YTS/uhFNFz1y50zShjcbEbGM
         leEi65E8kYuxg==
Date:   Wed, 27 Sep 2023 20:53:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Maxim Samoylov <max7255@meta.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH] IB: fix memlock limit handling code
Message-ID: <20230927175355.GQ1642130@unreal>
References: <20230915200353.1238097-1-max7255@meta.com>
 <20230918120932.GC103601@unreal>
 <f83fcbe0-308c-4485-ad96-ede52608e141@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f83fcbe0-308c-4485-ad96-ede52608e141@meta.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 21, 2023 at 04:31:44PM +0000, Maxim Samoylov wrote:
> On 18/09/2023 14:09, Leon Romanovsky wrote:
> > On Fri, Sep 15, 2023 at 01:03:53PM -0700, Maxim Samoylov wrote:
> >> This patch fixes handling for RLIM_INFINITY value uniformly across
> >> the infiniband/rdma subsystem.
> >>
> >> Currently infinity constant is treated as actual limit
> >> value, which can trigger unexpected ENOMEM errors in
> >> corner-case configurations
> > 
> > Can you please provide an example and why these corner cases are
> > important?
> > 
> 
> Actually, I’ve come up with proposing this minor patch to avoid
> confusion I got while investigating production case with
> ib_reg_user_mr() returning ENOMEM for (presumably) no particular reason.
> 
> Along with that I came across some curious repro.
> Consider the following code:
> 
> 
> addr = mmap(... , PROT_READ | PROT_WRITE,
>              MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, ... )
> 
> /* IB objects initialisation */
> 
> while (1) {
> 
> ibv_reg_mr_iova(pd, (void*)addr, LENGTH, (uint64_t)addr,
>      IBV_ACCESS_LOCAL_WRITE|IBV_ACCESS_REMOTE_WRITE|
>      IBV_ACCESS_REMOTE_READ|IBV_ACCESS_RELAXED_ORDERING);
> 
> }
> 
> 
> This cycle can work almost eternally without triggering any errors
> - until the kernel will run out of memory or we finally bail out after
> comparison against thread memlock rlimit.
> 
> As far as I understand, this means we can continuously register the same
> memory region for a single device over and over, bloating number of
> per-device MRs. Don't know for sure if it's wrong, but
> I assume it constitutes some at least logical pitfall.
> 
> Furthermore, it also bumps per-mm VmPin counter over and over without
> increasing any other memory usage metric,
> which is probably misguiding from the memory accounting perspective.
> 
> > BTW, The patch looks good to me, just need more information in commit message.
> >
> Thanks for your quick response!
> And I apologise that my answer took so long.

Please improve your commit message, remove "fix" word as this patch
doesn't really fix anything and send v2.

Thanks

> 
> > Thanks
> > 
> > 
> >>
> 
