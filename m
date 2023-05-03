Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4926F5692
	for <lists+linux-rdma@lfdr.de>; Wed,  3 May 2023 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjECKtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 May 2023 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjECKtK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 May 2023 06:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2650B5262;
        Wed,  3 May 2023 03:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE7161722;
        Wed,  3 May 2023 10:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C4FC433D2;
        Wed,  3 May 2023 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683110945;
        bh=O6gtshbx4awDaMiv1K5cJt8mAutAe5Ox7GEBujKkMe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9qxWFrSC89cTLKzT6KKMMwRfsX+ZlzdG+7/nFWlRr0A54rKSFpRGza8h+XdvyS0f
         lGFYXkj6MIEXD0eTEFty/TPyigMPHut1SxVDsWJ5J2pX159PUkiktpoMHAKhlUNv6b
         rSTllVDq00uSLfTFcfWLehXVnblz1wI5GXw4IqWfblJ6DY75ArYOXOGpyokfUms4iD
         x+7zEo/0orrImMDO/6IDBvm/Vy/A87d0EYuJbTt1pZNCP2W3VkvFtaKExiOBWtGMH1
         TsrwilODnH7WMu96WHzFHTpz8XtZWFJjYTxLPtiZ2OSUCcJqslpGggYKjvRHCnEvRc
         clQu05GY9TGkQ==
Date:   Wed, 3 May 2023 13:49:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Networking <netdev@vger.kernel.org>,
        Linux Random Direct Memory Access 
        <linux-rdma@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Networking <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net 0/4] Documentation fixes for Mellanox mlx5 devlink
 info
Message-ID: <20230503104900.GM525452@unreal>
References: <20230503094248.28931-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503094248.28931-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 03, 2023 at 04:42:45PM +0700, Bagas Sanjaya wrote:
> Here is fixes for mlx5 devlink info documentation. The first fixes
> htmldocs warnings on the mainline, while the rest is formatting fixes.
> 
> Bagas Sanjaya (4):
>   Documentation: net/mlx5: Wrap vnic reporter devlink commands in code
>     blocks
>   Documentation: net/mlx5: Use bullet and definition lists for vnic
>     counters description
>   Documentation: net/mlx5: Add blank line separator before numbered
>     lists
>   Documentation: net/mlx5: Wrap notes in admonition blocks
> 
>  .../ethernet/mellanox/mlx5/devlink.rst        | 60 ++++++++++++-------
>  1 file changed, 37 insertions(+), 23 deletions(-)

RDMA means "Remote Direct Memory Access" and not "Random Direct Memory Access"
Linux Random Direct Memory Access <linux-rdma@vger.kernel.org>

Thanks

> 
> 
> base-commit: c6d96df9fa2c1d19525239d4262889cce594ce6c
> -- 
> An old man doll... just what I always wanted! - Clara
> 
