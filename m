Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8813A774838
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 21:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjHHT2q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 15:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjHHT20 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 15:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B2463D42;
        Tue,  8 Aug 2023 11:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDEB962A68;
        Tue,  8 Aug 2023 18:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77698C433C8;
        Tue,  8 Aug 2023 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691520941;
        bh=xdoAQE4gvzbaXW7o5SJ9HdR0FcwDH36dp+qmn+f4fo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq4NafKKliHvETbjjE8/CokMXDjhlDKsd+DZt2GFBq4oCaFlOfSbY4n/YZWvrpQXo
         F1usTtCvSybe8lcgahbjyVlTxBz/rpZjfWoTkLBdTMx7KDC3wQK2gIePqEg9XI8TPv
         Af8diQebYZb4p6jNbBE7XdrGDblaqa2lIO1jwqkVHKzpf42BH1E6f3tQuD5QzMsRiO
         vA+8CyFpu9maED4iiI9lBeNwBmnil/mA2WKi8cLs5olS10arMvC+RPGU1PJCQ4QOvg
         FMbBQjA0lYN0kFLXmtPNlqeyv1Aa9/NoqxLnkM5Llk7MCUzERIWa3hOVT+f/o0gO3F
         7/fek79Q79nRw==
Date:   Tue, 8 Aug 2023 21:55:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/10] mlx4: Rename member mlx4_en_dev.nb to
 netdev_nb
Message-ID: <20230808185534.GH94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-3-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-3-petr.pavlu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:19PM +0200, Petr Pavlu wrote:
> Rename the mlx4_en_dev.nb notifier_block member to netdev_nb in
> preparation to add a mlx4 core notifier_block.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_main.c   | 14 +++++++-------
>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
