Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7337609B4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 07:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGYFsL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 01:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGYFsB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 01:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392ECB6;
        Mon, 24 Jul 2023 22:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEDAD61526;
        Tue, 25 Jul 2023 05:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546E1C433C7;
        Tue, 25 Jul 2023 05:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690264074;
        bh=2ca9JplLXij4jA9NIpNDNheHd1cWOBerRKQ46qKuQrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKno2qrXd33o/1tfIB9PkikcvEm1HDORPf/3Y5ePAOW4f+SyNI4tZPEIkYQkTPC2v
         p3mWuH7BcuSYEhCu+hE0dBSnV6zoyct6uRi1r9mwnucpgbYfcHLQOlJ3GuwcbHQcxL
         5OJlVtKlxuGeDYFQySZ7Jw4TWXrQyx1pkKIeDo3ajbPfkj+MZRmY6NE9rbbUt2nBZ9
         4Y1VLhApzMboGvbYGIiNwvWXJNX3awEpMqdGCJxPOFM/Wxjd2usX4wivNXKyRJ0zIN
         jdCL1QuwSLMADUbXgHY28nnsv8Hd1BNu4ZA2D8OTRqJLea5XLqjGleHUQx5e+AW7dV
         2UrNu12T6yffw==
Date:   Tue, 25 Jul 2023 08:47:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx4: clean up a type issue
Message-ID: <20230725054749.GL11388@unreal>
References: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 25, 2023 at 08:39:47AM +0300, Dan Carpenter wrote:
> These functions returns type bool, not pointers, so return false instead
> of NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Not a bug.  Targetting net-next.
> 
>  drivers/net/ethernet/mellanox/mlx4/mcg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
