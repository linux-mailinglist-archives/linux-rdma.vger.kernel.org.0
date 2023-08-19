Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966907816F2
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Aug 2023 05:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbjHSDD1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 23:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244486AbjHSDC5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 23:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B8F3C34
        for <linux-rdma@vger.kernel.org>; Fri, 18 Aug 2023 20:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9400062A04
        for <linux-rdma@vger.kernel.org>; Sat, 19 Aug 2023 03:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F5AC433C8;
        Sat, 19 Aug 2023 03:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692414175;
        bh=4Mp3u6LMy61z+v290yHzzI8KmbqFO+7XDpQP/RnnSSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IfnAzvNaVSySms6rMDMsU+CaA5rykzLxrIJ2mzfL5QMa62WkRlTe7l5E2bV83TgfB
         DAoJlVFv5xM2JlGLmK+rfGyPqNqgLScCg4mWZ0uj+oLwv6ob0ucb+xFPLB7LbwaPby
         B24iwf36RCOpNsZOEJ/b14F7Hxak2IO6JA7p2CZLTW1VB+T0fAMJnntmf/YCP4Kh+s
         hyUYQjcULDXjSY5T+KcmLH6i/SWuPyVN6idOXJ6sh/WW2ixYHJmq/HWB5nwCUOtgw6
         n2a7pZXa+lc0rWkTEFXkkhNRJZ7Zzelw/araDrduuhcDugpDLCzTUaY+ShQcOy4oVC
         4IlpGPFqRH9rA==
Date:   Fri, 18 Aug 2023 20:02:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [GIT PULL] Please pull mlx5 MACsec RoCEv2 support
Message-ID: <20230818200253.0901a66d@kernel.org>
In-Reply-To: <20230813064703.574082-1-leon@kernel.org>
References: <20230813064703.574082-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 13 Aug 2023 09:47:03 +0300 Leon Romanovsky wrote:
> This PR is collected from https://lore.kernel.org/all/cover.1691569414.git.leon@kernel.org
> and contains patches to support mlx5 MACsec RoCEv2.

+bool macsec_netdev_is_offloaded(struct net_device *dev)
+{
+       if (!dev)
+               return false;
+
+       return macsec_is_offloaded(macsec_priv(dev));
+}
+EXPORT_SYMBOL_GPL(macsec_netdev_is_offloaded);

No defensive programming, please, why are you checking that dev is NULL?

> It is based on -rc4 and such has minor conflict with net-next due to
> existance of IPsec packet offlosd in eswitch code and the resolution
> is to take both hunks.
> 
> diff --cc include/linux/mlx5/driver.h
> index 25d0528f9219,3ec8155c405d..000000000000
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@@ -805,6 -806,11 +805,14 @@@ struct mlx5_core_dev 
>   	u32                      vsc_addr;
>   	struct mlx5_hv_vhca	*hv_vhca;
>   	struct mlx5_thermal	*thermal;
> + 	u64			num_block_tc;
> + 	u64			num_block_ipsec;
> + #ifdef CONFIG_MLX5_MACSEC
> + 	struct mlx5_macsec_fs *macsec_fs;
> + #endif
>   };
>   
>   struct mlx5_db {

That's not how the resolution looks. Do the merge yourself, then show
the actual 3-way resolution.
-- 
pw-bot: cr
