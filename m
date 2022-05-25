Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05BF5336A8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 08:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiEYGK1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 02:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiEYGKZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 02:10:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB46EB38
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 23:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E03D3B8172B
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 06:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2966CC385B8;
        Wed, 25 May 2022 06:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653459020;
        bh=ErBOykNRjfTy0nNY+gAscNbc4sXmHKb211mDR3SRUG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kmc2JW9KuDBPe8ZX13COLPrN3bgW0GqZkrtTFiYvdOS9sf4dB8Jk5EeQfcVx2tE0j
         f/hcPmievBUhaCDN7YpjtloSLW2yr5bqIhPCLpnC+qssnaPx4Vn5VLTaiC3dSn/px9
         PM/FPit5QcqQjLE7G/WtvsIUKYoUyR7Y+mdICobT/24cbloNgd79U/yIc9k87dyR6U
         y0VE0QZ2GIgqDPSwXCmBepHKE4VfniTzwnp0VSWTEpNa2kY4XFRhw5MGjjRDe3VOdo
         C6iSr6ALkt3G4pBP0oktXxhWfO5oT2TIXLUSc5PfYZXVyT23tFYgFyiU21LooWc3Ld
         +BE05z+GWSvcw==
Date:   Wed, 25 May 2022 09:10:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ryan Stone <rysto32@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Possible bug in ipoib_reap_dead_ahs in datagram mode
Message-ID: <Yo3ISBaM3awcm1o6@unreal>
References: <CAFMmRNyHUSg6_+af9W39e36aCx2a=_9WC8MB08W9XfnMKoYXAQ@mail.gmail.com>
 <YoyEPnFpd7/mI1Mm@unreal>
 <CAFMmRNxS56xWoZ_-Sz4yBrZvK95vdpQR9xrxjDhkAAGi3krK=A@mail.gmail.com>
 <Yo0tJPKOCHkqF5Gl@unreal>
 <CAFMmRNx0wgPQRhMpHz+9h9fXv-bPbzPDRmwtZrHqYSc5WHmfHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFMmRNx0wgPQRhMpHz+9h9fXv-bPbzPDRmwtZrHqYSc5WHmfHQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 03:18:53PM -0400, Ryan Stone wrote:
> I believe that if we never enter that if statement, then we will leak
> the entries that are supposed to be cleaned up.  That's better than
> the use-after-free that I feared but still not good.

I don't know, we are running enhanced IPoIB all the time and I never got
any reports about kmemleaks/KASAN in that area.

Thanks

> 
> On Tue, May 24, 2022 at 3:08 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, May 24, 2022 at 09:33:52AM -0400, Ryan Stone wrote:
> > > On Tue, May 24, 2022 at 3:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > IPoIB in mlx5 is HW offloaded version of ulp/ipoib one. AFAIK, it doesn't
> > > > change "tx_tail" and we won't enter into this if (...).
> > > >
> > > > Thanks
> > >
> > > I don't quite follow this response.  Is this the if statement that you
> > > mean that we won't fall into?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/infiniband/ulp/ipoib/ipoib_ib.c#n682
> >
> > Yes, I think so, maybe wrong here.
