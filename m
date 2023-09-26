Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731037AE96E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjIZJj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjIZJjV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 05:39:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96696120;
        Tue, 26 Sep 2023 02:39:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FBDC433C7;
        Tue, 26 Sep 2023 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695721155;
        bh=AnTJXPiJiPV4M7FfzIw4U1feaoScrcoS51aixAIgF3w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DP4/3ICboAtuex0rLt47pvfLL3/RpYL6P55AKFzcXmVGZnH0i6TjpWMJrlhHiYn9k
         MhAXJZRWAp9kThHiH/VTOGUh5AskLNX4OMUIOUStCAqYAJ/tQuLHukGzMdqgpbayHR
         zmReRYdRUWY18/wvTO9lm8rsdEzMPn6Feb4r06u9zm7pmBgPHy4Ax7zrlY7GDPiV03
         IMDkQMwDydoyY33amfyXPO9eMuD3bxS9UxxZl1cfLcK6FNpKmuZ1lB7UShYo5P725S
         ZO1IfpRmkWfsLGQREkgTfxuiqzUkJys4aG4nec+fY6NHcDv/52mBXOZbGdimMUETzh
         LBUzEWnj+nhkA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        netdev@vger.kernel.org, Or Har-Toov <ohartoov@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
References: <cover.1695204156.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/6] Add 800Gb (XDR) speed support
Message-Id: <169572115099.2612409.2085687465811625783.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 12:39:10 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 20 Sep 2023 13:07:39 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series extends RDMA subsystem and mlx5_ib driver to support 800Gb
> (XDR) speed which was added to IBTA v1.7 specification.
> 
> [...]

Applied, thanks!

[1/6] IB/core: Add support for XDR link speed
      https://git.kernel.org/rdma/rdma/c/703289ce43f740
[2/6] IB/mlx5: Expose XDR speed through MAD
      https://git.kernel.org/rdma/rdma/c/561b4a3ac65597
[3/6] IB/mlx5: Add support for 800G_8X lane speed
      https://git.kernel.org/rdma/rdma/c/948f0bf5ad6ac1
[4/6] IB/mlx5: Rename 400G_8X speed to comply to naming convention
      https://git.kernel.org/rdma/rdma/c/b28ad32442bec2
[5/6] IB/mlx5: Adjust mlx5 rate mapping to support 800Gb
      https://git.kernel.org/rdma/rdma/c/4f4db190893fb8
[6/6] RDMA/ipoib: Add support for XDR speed in ethtool
      https://git.kernel.org/rdma/rdma/c/8dc0fd2f5693ab

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
