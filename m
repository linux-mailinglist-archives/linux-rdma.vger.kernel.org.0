Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF9C610B0E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 09:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJ1HM2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 03:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJ1HM1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 03:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626DC1956F2
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 00:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB6562573
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 07:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC568C433D6;
        Fri, 28 Oct 2022 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666941145;
        bh=aD1PCzuLyp7hOdX9qBWejSQgm7cSU0Ax9zmXyl4qi7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFaLRbKfvSmksK7eCNWy50VWY5ZwMPXr97XE3Yd3XASo+LD3ZDAX57ICH/oaSojNd
         fZ1dFAC0qLXhdmyjikCObNwpna54MgBF0PMVvef0VssxzAda0ZRF8wL9MlyQ8O/BTI
         DX6OzlKhTLs+wUfIbReXBJiLMDzxykVt96oKVFDcr94SUl//a1+VcIvWLCAbSLxWOs
         gm6x0LUDCP8iWhee+fqVlOSrH1+uULJuSq6rpI0xLFz8xFtFA8ivo2mhGhy9K2+tNj
         TTVn0d62bw2NH89mDbdOYGvYXRBMXGilOu3RP+9ZZwP4hDMOvg3LMBtUJln41Cj6aO
         atj4IhgBdaHjQ==
Date:   Fri, 28 Oct 2022 10:12:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Fix section mismatch warning for
 nldev
Message-ID: <Y1uA1aCsZ2jQvkP6@unreal>
References: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 09:58:56AM +0300, Leon Romanovsky wrote:
> ppc64_defconfig) produced this warning:
> 
> WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in reference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.text)
> 
> Fix it by removing __init/__exit markers as nldev is part of ib_core.ko
> and as such doesn't require any special notations for entry/exit functions.
> 
> Fixes: 6c80b41abe22 ("RDMA/netlink: Add nldev initialization flows")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/infiniband/core/nldev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

BTW, this was reported for rdma-rc and should go there.

Thanks
