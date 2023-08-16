Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28977ED1C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 00:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346920AbjHPWaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 18:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346930AbjHPWaF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 18:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F216E56
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 15:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06CB67041
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 22:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FEBC433C8;
        Wed, 16 Aug 2023 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692225003;
        bh=cI0wR0k/pE6mpn6vcPcsB8A+gD0Y69OMZw94nASdR/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxM6RusMtyman576DD9+urb0FXEzE6v6cTZfAwlB42x6j/ZOcYWi5fcTdjpvCu3mC
         HZ+XCZ6ydwoUg7vJBZzVr8/FzoNJpWYCjho9Cs8/IKx4tVQmU3Q3uji1gAKASla2TB
         83dhzQv/iBGW4QIKoQg01ObadooEHIExXURWxfIfPnuGQujuwFcE0I/17U0apNcUld
         x9Ek6IrMy5WmHMRFiB2SvyC2gL88dq9BSrEQzNy54FxOoXbEGMvb7Wi/GAp5Dw5OVs
         HqWS+ZpiHQ8fNqbNojYoJMqtzRygmpTBczeWpHTOHhk4aQXqQ3AyYO2Xk4HPBcLZyG
         na/6g/JlH5S3A==
Date:   Wed, 16 Aug 2023 15:30:01 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZN1N6WOpHUkhQspA@x130>
References: <20230813064703.574082-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230813064703.574082-1-leon@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 13 Aug 09:47, Leon Romanovsky wrote:
>Hi,
>
>This PR is collected from https://lore.kernel.org/all/cover.1691569414.git.leon@kernel.org
>and contains patches to support mlx5 MACsec RoCEv2.
>
>It is based on -rc4 and such has minor conflict with net-next due to existance of IPsec packet offlosd
>in eswitch code and the resolution is to take both hunks.

Hi Jakub, 

Are you planing to pull this into net-next? 

There's a very minor conflict as described below and I a would like to
avoid this on merge window.

Thanks,
Saeed.


>
>diff --cc include/linux/mlx5/driver.h
>index 25d0528f9219,3ec8155c405d..000000000000
>--- a/include/linux/mlx5/driver.h
>+++ b/include/linux/mlx5/driver.h
>@@@ -805,6 -806,11 +805,14 @@@ struct mlx5_core_dev
>  	u32                      vsc_addr;
>  	struct mlx5_hv_vhca	*hv_vhca;
>  	struct mlx5_thermal	*thermal;
>+ 	u64			num_block_tc;
>+ 	u64			num_block_ipsec;
>+ #ifdef CONFIG_MLX5_MACSEC
>+ 	struct mlx5_macsec_fs *macsec_fs;
>+ #endif

