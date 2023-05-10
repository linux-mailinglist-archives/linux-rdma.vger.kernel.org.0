Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15BA6FDB82
	for <lists+linux-rdma@lfdr.de>; Wed, 10 May 2023 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjEJKVG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 May 2023 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjEJKVF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 May 2023 06:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34703213B
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 03:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84A4F63008
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 10:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E6CC433EF;
        Wed, 10 May 2023 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683714062;
        bh=PeThsWlr8cFpa/kNEF0zKl3ZNnMw52MreVRfRen/6OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MnPHJb+FU0iJr+0xfR09a/94ocM16Urg26MuwXqYCJk+bx84RlXJsSjFD6vE2xyw0
         a8wH1IvttiRLaGysJh0FqFctcEAuRL4NaFd2t8FOLuGL+KOQXlPt22oZLTxZITJbTs
         Po3cQg4fw1VD/F2Jv9WBKlCijpXnQ/yUvQTHL6uzr6Sbt7780IM91wdsov/DcyFlKJ
         G7QlIZtE2Rwv7PPw5xJ03K7Vk8T2ETnkLfH9bcl6HaWKPgzIEQhhF5hdp+WAETmnzH
         njHt/nf4wtrKnGgfRUrzlvvt5guTMruxchz8Y9RuahnKSB8da3g0WBbM4lLoxXQzq4
         IEpvFxgARdq9g==
Date:   Wed, 10 May 2023 13:20:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Animesh Kishore <animesh.kishore@gmail.com>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com
Subject: Re: [PATCH] verbs: Add RDMA write RC pingpong test
Message-ID: <20230510102058.GR38143@unreal>
References: <20230509095016.112453-1-animesh.kishore@gmail.com>
 <20230509133727.GJ38143@unreal>
 <CALNrABWfN0sszDNNv0YwQ5VS0Yv07PW5no=aZSxZOCFUu7N7cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALNrABWfN0sszDNNv0YwQ5VS0Yv07PW5no=aZSxZOCFUu7N7cg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 10, 2023 at 03:30:00PM +0530, Animesh Kishore wrote:
> On Tue, May 9, 2023 at 7:07 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, May 09, 2023 at 12:50:16PM +0300, Animesh Kishore wrote:
> > > - The test pingpongs data between server and client
> > > instance using RC QPs with RDMA write BTH opcode.
> > > - For RDMA write, there's no completion at responder. Hence,
> > > we send a sideband ACK(using socket) from requester side
> > > on completion. This indicates to responder that it has
> > > received data.
> > >
> > > Check available test arguments and help:
> > > ./build/bin/ibv_rc_wr_pingpong -h
> > >
> > > e.g.
> > > Run server instance:
> > > ./build/bin/ibv_rc_wr_pingpong -g 0 -d <ib_dev> -c -s 8192
> > >
> > > Run client instance:
> > > ./build/bin/ibv_rc_wr_pingpong -g 0 -d <ib_dev> -c -s 8192 <server IP>
> > >
> > > Signed-off-by: Animesh Kishore <animesh.kishore@gmail.com>
> > > ---
> > >  debian/ibverbs-utils.install         |   2 +
> > >  libibverbs/examples/CMakeLists.txt   |   3 +
> > >  libibverbs/examples/rc_wr_pingpong.c | 782 +++++++++++++++++++++++++++
> > >  libibverbs/man/CMakeLists.txt        |   1 +
> > >  libibverbs/man/ibv_rc_wr_pingpong.1  |  63 +++
> > >  5 files changed, 851 insertions(+)
> > >  create mode 100644 libibverbs/examples/rc_wr_pingpong.c
> > >  create mode 100644 libibverbs/man/ibv_rc_wr_pingpong.1
> >
> > Like I said in relevant PR https://github.com/linux-rdma/rdma-core/pull/1325#issuecomment-1531194836
> > This new ibv_rc_wr_pingpong is unlikely to be merged.
> >
> > Thanks
> 
> Hi Leon,
> 
> Do you suggest to wait for more comments or close the PR at once ?

You need to find more people who think that such application must be
included in rdma-core.

> 
> I think it's helpful for new users for below reasons.
> Helps demonstrate complete flow and API usages. Works as a reference
> to build IBverbs production applications which are typically in C/C++.
> 
> Also note, it's an overkill to extend existing example/rc_pingpong.c
> (uses send/recv) to support RDMA write.

It is unlikely to be accepted either.

> 
> Thanks
> Animesh
