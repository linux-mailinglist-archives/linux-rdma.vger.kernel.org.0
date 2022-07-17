Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9655777C5
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Jul 2022 20:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiGQSeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Jul 2022 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGQSeZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Jul 2022 14:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C5512746
        for <linux-rdma@vger.kernel.org>; Sun, 17 Jul 2022 11:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BCC3612BB
        for <linux-rdma@vger.kernel.org>; Sun, 17 Jul 2022 18:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD13C3411E;
        Sun, 17 Jul 2022 18:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658082863;
        bh=RSFRdx326NGAjyAiUC5iKtSzqW9Y+/m+mIhSKgAAAFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfS3ouf1g6Jl6HoAUZEMeBqRgwfpXq0ZO6O2UXxkcAxTE3Zflx2GBpsROG3lV7k6X
         dH1sob3MZgyl1HMvQeDheqqrmTSyDXqD/B3FpsVvM+62UIdD/wNRHgSulpB4qpU46g
         aGB+JE0NIOWLFeTbTC/0yRZ9CgdHuWMhDKFDB5MOheCkm9lI5k+F1cL/6//GYZHz6/
         MeHsgg3zi9vRU12XgyseBugQEwwZDD+qDHzXx6iTt/9hHw8VzHtfg/TX8N5yIRJMXl
         NqzqkYEl75A9wZE9r2sBFxP9oXIbD4heaT3D9Dcn1B/kAQNxzSCAdjOad3moNdn3o9
         UZ72gxqAQwdPQ==
Date:   Sun, 17 Jul 2022 21:34:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/3] rdma: move to the new NAPI helpers
Message-ID: <YtRWKoCAD5ErYnEE@unreal>
References: <20220705230208.924408-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705230208.924408-1-kuba@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 05, 2022 at 04:02:05PM -0700, Jakub Kicinski wrote:
> I'm dropping the wight argument from netif_napi_add()
> because most callers just want the default. This is
> prep taking care of the few callers in RDMA.
> 
> Jakub Kicinski (3):
>   IB/hfi1: switch to netif_napi_add_tx()
>   IB/hfi1: switch to netif_napi_add_weight()
>   ipoib: switch to netif_napi_add_weight()
> 
>  drivers/infiniband/hw/hfi1/ipoib_tx.c     | 4 +---
>  drivers/infiniband/hw/hfi1/netdev_rx.c    | 2 +-
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 6 ++++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Thanks, applied.

> 
> -- 
> 2.36.1
> 
