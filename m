Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCB653318F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiEXTIg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 15:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbiEXTIc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 15:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23DF37AB9
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 12:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD4E615CA
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 19:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D79C34100;
        Tue, 24 May 2022 19:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653419304;
        bh=1x0vjZbu9k1vEgkUxM8Y0LIZUsxy5Fmjrcim68Q+2c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5G4aUBmLzX5rIsR2u1O1ucVpRtulBYrj7lrb9RaFh2MsyO7egCUaDZXEwXiFzeIW
         ej1FxaXUl2YOufB9x+EN5I3nEKhP+HfG2zEaIijEDY2xi0yImhBBZdgkJH4GWrE6kp
         F1yVtRAfsbh+kQtKSZFfMHRRcr+ilrSTDdrjUIp6QSFhw6sh+jMzQOoZnltc+Vvvll
         4nvoViNYTcs67Le/PYRpvpanDEgjFYPoeZ+lb6vKX+lfjL9RhBXkSxXVCbelbO33Sm
         vjAxhXjjJBIiaOoUIdbFVY688BHZ6cXkTFzShkQMNKGtLNLAxMLbBIBnTJy/b0gG+1
         sfrgbR8tE5KPw==
Date:   Tue, 24 May 2022 22:08:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ryan Stone <rysto32@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Possible bug in ipoib_reap_dead_ahs in datagram mode
Message-ID: <Yo0tJPKOCHkqF5Gl@unreal>
References: <CAFMmRNyHUSg6_+af9W39e36aCx2a=_9WC8MB08W9XfnMKoYXAQ@mail.gmail.com>
 <YoyEPnFpd7/mI1Mm@unreal>
 <CAFMmRNxS56xWoZ_-Sz4yBrZvK95vdpQR9xrxjDhkAAGi3krK=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFMmRNxS56xWoZ_-Sz4yBrZvK95vdpQR9xrxjDhkAAGi3krK=A@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 09:33:52AM -0400, Ryan Stone wrote:
> On Tue, May 24, 2022 at 3:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> > IPoIB in mlx5 is HW offloaded version of ulp/ipoib one. AFAIK, it doesn't
> > change "tx_tail" and we won't enter into this if (...).
> >
> > Thanks
> 
> I don't quite follow this response.  Is this the if statement that you
> mean that we won't fall into?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/infiniband/ulp/ipoib/ipoib_ib.c#n682

Yes, I think so, maybe wrong here.
