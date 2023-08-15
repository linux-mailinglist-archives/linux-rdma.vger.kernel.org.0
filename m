Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E877C862
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 09:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbjHOHOR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 03:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjHOHNf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 03:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC61FC3
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 00:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF7C61462
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 07:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D952DC433C8;
        Tue, 15 Aug 2023 07:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692083590;
        bh=i1KPXV4pn+K3x9Hh+ikyP03jgvCUaA4Eo11CSMNa9m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQYVHSU8sVuO7NUhtQt2Pu9+a0/fEVDiAfs+/HS/Z/tEcUhxTZH3ZN5IIAXrqzu+Z
         uA7SZqcHSgTj5fUfiB7kAnBN5msRcnm0JZw/OPrhJ1Shr+gz0qVEEbwITMpYl/tkLl
         mBB5PMtqe5+SHg6Tt2Co9zdU7Ie0DlaDg3uRcMYeG/8/5CzdImcz7oHtMkYIU7P9Mw
         946CJq26zHcJ/qQ0mFD6FbrXzDcyNniclJs1AGrIQkayznEOIEzRPdo8CIf0+whDrF
         o15O0ne+Aql2vuIG+q8OS0sF6Dd3QBZi8ynDlNQ0RYeLwY2dePWa+dt7rc2OtDHRXB
         eDrc7q18fvH1Q==
Date:   Tue, 15 Aug 2023 09:13:05 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        borisp@nvidia.com, tariqt@nvidia.com, lkayal@nvidia.com,
        msanalla@nvidia.com, kliteyn@nvidia.com, valex@nvidia.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Remove unused declaration
Message-ID: <ZNslgQSTPHh4Ab5M@vergenet.net>
References: <20230814140804.47660-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814140804.47660-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 14, 2023 at 10:08:04PM +0800, Yue Haibing wrote:
> Commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> declared mlx5e_ipsec_inverse_table_init() but never implemented it.
> Commit f52f2faee581 ("net/mlx5e: Introduce flow steering API")
> declared mlx5e_fs_set_tc() but never implemented it.
> Commit f2f3df550139 ("net/mlx5: EQ, Privatize eq_table and friends")
> declared mlx5_eq_comp_cpumask() but never implemented it.
> Commit cac1eb2cf2e3 ("net/mlx5: Lag, properly lock eswitch if needed")
> removed mlx5_lag_update() but not its declaration.
> Commit 35ba005d820b ("net/mlx5: DR, Set flex parser for TNL_MPLS dynamically")
> removed mlx5dr_ste_build_tnl_mpls() but not its declaration.
> 
> Commit e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> declared but never implemented mlx5_alloc_cmd_mailbox_chain() and mlx5_free_cmd_mailbox_chain().
> Commit 0cf53c124756 ("net/mlx5: FWPage, Use async events chain")
> removed mlx5_core_req_pages_handler() but not its declaration.
> Commit 938fe83c8dcb ("net/mlx5_core: New device capabilities handling")
> removed mlx5_query_odp_caps() but not its declaration.
> Commit f6a8a19bb11b ("RDMA/netdev: Hoist alloc_netdev_mqs out of the driver")
> removed mlx5_rdma_netdev_alloc() but not its declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks Yue Haibing,

I appreciate you grouping these into a single patch.

Reviewed-by: Simon Horman <horms@kernel.org>

