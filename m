Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB355B0B9B
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 19:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIGRje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIGRjc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 13:39:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060659FE8
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 10:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFBB3B81E45
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 17:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E20C433D6;
        Wed,  7 Sep 2022 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662572369;
        bh=BuzOleT2JzdxhmQ2iPJzJbkbvehTEvIDTkiuAiHbr40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmAjL9X7za88Y3VCddS4VeZ7xGe6Q6ijs4zMeCI0lYZiirewuGpE7bcP7iWV76UBT
         iLemnhHrKU1qcllSmiHX/o+a1gExgUlicJCqka2UnsiukSQ17XDmQ6hWypajVCYawV
         rPEyHbh9xrJ+VKG9LlU1jjZyI2cPcymQ/ajrSvrrLonZQV7m0oodeBzh54Y8O5Coal
         UwDzVWyPsa87aKJtZR1dGIED9FcoUziMjmG0fyeuYhiv7l7prFlddCNypVJg1MSwZK
         TvulHaHktrV3caL1/6rqMuWm9q6t+FtNERW4EVGMICSpYbl4Ort6hMJkzT0kLFDV21
         ursfr7VYycsRA==
Date:   Wed, 7 Sep 2022 20:39:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <YxjXTZY6aihDV2FO@unreal>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
 <YxiTxJvDWPaB9iMf@unreal>
 <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
 <20220907151818.GA26822@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907151818.GA26822@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 05:18:18PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
> >>>
> >>> This entire code needs to move to the rdma core instead
> >>> of being leaked to ulps.
> >>
> >> We can move, but you will lose connection between queue number,
> >> caller and error itself.
> >
> > That still doesn't explain why nvme-rdma is special.
> >
> > In any event, the ulp can log the qpn so the context can be interrogated
> > if that is important.
> 
> I also don't see why the QP event handler can't be called
> from user context to start with.  I see absolutely no reason to
> add boilerplate code to drivers for reporting slighly more verbose
> errors on one specific piece of hrdware.  I'd say clean up the mess
> that is the QP event handler first, and then once error reporting
> becomes trivial we can just do it.

I don't know, Chuck documented it in 2018:
eb93c82ed8c7 ("RDMA/core: Document QP @event_handler function")

  1164 struct ib_qp_init_attr {
  1165         /* Consumer's event_handler callback must not block */
  1166         void                  (*event_handler)(struct ib_event *, void *);

Thanks
