Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D334877EF16
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 04:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjHQC3u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 22:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjHQC3S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 22:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAC426A8
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 19:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6636C64C4C
        for <linux-rdma@vger.kernel.org>; Thu, 17 Aug 2023 02:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A01C433C8;
        Thu, 17 Aug 2023 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692239356;
        bh=MU/nBpIEM5zOGcfZKwamin6GRaWleLDz+5CUYP7mSGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cdurCLhpKtLZoGwX5GMSknQNngnVJ4b4ptD7EFr1+Xgz7zMAOHe2YuDntOfSrC9KZ
         1nn5pnmFHbo0avtQ11QOUmjdsSxcSOUcq+fuwx9ssjl3A7WguUaGDnorq72qgfsgHn
         2aTge8LuuIB+MuFA7huLjIp42NWDSoNX0ti/P4YTuGhAUJoqYDiTU/DEwQb0Vs/BYx
         fNr+iJVDDoVn9PojuQ5qwAdn1BtjoJjI8rurqM0DapRW53HY5mh5CPx00z+gEiB5P2
         3hJbdZrVgyZe8gPQHIXXBdLIvMJ5lioto+WjgrUTR/2CAPkiU1a5dyhVJaZbwBKND4
         BtEOaYNWycZlw==
Date:   Wed, 16 Aug 2023 19:29:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20230816192915.7286828c@kernel.org>
In-Reply-To: <ZN1N6WOpHUkhQspA@x130>
References: <20230813064703.574082-1-leon@kernel.org>
        <ZN1N6WOpHUkhQspA@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 16 Aug 2023 15:30:01 -0700 Saeed Mahameed wrote:
> Are you planing to pull this into net-next? 
> 
> There's a very minor conflict as described below and I a would like to
> avoid this on merge window.

I'm not planning not to pull it.
It's just a matter of trying to work down the queue from the highest
priority stuff. I have to limit the time I spent on ML & patch mgmt,
because it can easily consume 24h a day. And then stuff that's not 
the highest priority gets stuck for a little longer than it would 
in an ideal world :(
