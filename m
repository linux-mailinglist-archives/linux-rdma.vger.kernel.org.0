Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB6675AA5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjATRAe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 12:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjATRAe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 12:00:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7FA24F
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 09:00:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D626B82941
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 17:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F7DC433EF;
        Fri, 20 Jan 2023 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674234029;
        bh=NcbzoMt0dpDxcJ/l/3JJ+/zLqVcU8MvRjXtHk51GC1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTVwMpxZbo9LHvmjxlJz6/U40LRRu5wGwKA8En3yqvb1JoX2QdCLmNGYkVV1nEKm8
         YdrEdy+VEwyjl/XKE8E22NF0GJ6yWNloZxNmzphyoleqCiGXjv+VKVfdeCqTebP8vM
         tO4fHmc7WWRlCyU3W/RT4p9Cgh3p6dw07IHixlIaGI/4OdlVOM46iwc6WzCjxvHUY0
         qoyRZd+hGIO7lrQtfE0MA0vhB1SCl5pyYetNh4lLuXLxDZdwmwJTB423pnTzDH052r
         sByw9rbA8FeqaX6KzUvzSNxSpscdn3XxdRs0vm3mWpfoeRUIq+35q9WkTMsL73qMJL
         kp6SeARq3rbtA==
Date:   Fri, 20 Jan 2023 19:00:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-rc] IB/IPoIB: Fix legacy IPoIB due to wrong number
 of queues
Message-ID: <Y8rIqFV/iPdjKKMH@unreal>
References: <4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 19, 2023 at 04:06:13PM +0200, Leon Romanovsky wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>

<...>

> +	err = netif_set_real_num_tx_queues(dev, pdev->real_num_tx_queues);
> +	if (err) {
> +		ipoib_warn(ppriv, "failed setting the child tx queue count based on parent\n");
> +		return err;
> +	}
> +
> +	err = netif_set_real_num_rx_queues(dev, pdev->real_num_rx_queues);
> +	if (err) {
> +		ipoib_warn(ppriv, "failed setting the child rx queue count based on parent\m");
                                                                                          ^^^^
strange, I thought what I fixed it prior sending. I'll resend.


> +		return err;
> +	}
> +
>  	err = ipoib_intf_init(ppriv->ca, ppriv->port, dev->name, dev);
>  	if (err) {
>  		ipoib_warn(ppriv, "failed to initialize pkey device\n");
> -- 
> 2.39.0
> 
