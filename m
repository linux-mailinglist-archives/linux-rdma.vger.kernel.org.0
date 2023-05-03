Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E546F568C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 May 2023 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjECKsC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 May 2023 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjECKrl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 May 2023 06:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EC59C9;
        Wed,  3 May 2023 03:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF7762CA3;
        Wed,  3 May 2023 10:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E774DC433D2;
        Wed,  3 May 2023 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683110848;
        bh=xhuxd6ARMk4mr+aQe6ypkrkfvy4IYArr8gIrni8JIT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGNyOhbjeAGC2KAB3X9MBPsAUUrvI6jDad+G8yRZTGZJa+WchQCZ2pqtRHgjRLgN5
         OXVTxkmRKCZpis6kd7gg15yB1Z2CssCHNZo8YJ+gQSLlfRJ6vJXXV4dRzuJFyhFBCb
         ymYVx156Rfpq+w2jgg0/swfMep0Bg7nmzLJD0Hc9yLxoFWdbz+gCE+NbRNufkT2IM0
         kF5wSmrOS02QT5+tfAtEyyMtiA5gHw8LI+un7YynS1Ma2RXk/94eWkAR4pwmexPmW5
         LU3qm2VUvMRDRaGfbDDWCKbzkaYOhPgDDjAYV34J/sSgOgtK+kdG4H97b2MqVgibK8
         5f8z3UR/BpwZA==
Date:   Wed, 3 May 2023 13:47:24 +0300
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
Subject: Re: [PATCH net 2/4] Documentation: net/mlx5: Use bullet and
 definition lists for vnic counters description
Message-ID: <20230503104724.GL525452@unreal>
References: <20230503094248.28931-1-bagasdotme@gmail.com>
 <20230503094248.28931-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503094248.28931-3-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 03, 2023 at 04:42:47PM +0700, Bagas Sanjaya wrote:
> "vnic reporter" section contains unformatted description for vnic
> counters, which is rendered as one long paragraph instead of list.
> 
> Use bullet and definition lists to match other lists.
> 
> Fixes: b0bc615df488ab ("net/mlx5: Add vnic devlink health reporter to PFs/VFs")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  .../ethernet/mellanox/mlx5/devlink.rst        | 36 ++++++++++---------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
