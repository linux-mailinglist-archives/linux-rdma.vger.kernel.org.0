Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822964940E
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Dec 2022 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLKMA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Dec 2022 07:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLKMA5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Dec 2022 07:00:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC2DED7
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 04:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD2760DE2
        for <linux-rdma@vger.kernel.org>; Sun, 11 Dec 2022 12:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9FDC433F0;
        Sun, 11 Dec 2022 12:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670760056;
        bh=gjQx4MwWn1DdqDtuQBsuTW17WL4MgGvtwVgDnVoqXPs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GEnKtjb73UvB3IBfnE8wNbp306HOIx45Xd6TdVMturDrCTIcw4Mcb0cVXYfojjk5/
         qTv5S0FBdJ11G5KuVlvP83tGchv+QklzA+99f3Ycs8Ff4Vivb8SZuBCJBWNyrg0I4F
         PHbivDKxGMG9Fa5NSL5hP1Z9imzm5nH8Y2Ds42x7nUHbo98UvR7T5OmrajXyy8s96a
         Kx4VpaEQsHbjZa2eMzZsGZfaNPD5f7hXmbl2PNKChvg8RhWjy6dw/Ai84bylle795P
         CinGmETsqU5U+mf4VchJBEirAoBUVvLiuc0vFpeg2ne9EqbABE44h0FFwJL3ZlOw7A
         8gWPwGoRYOezw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org,
        Erez Shitrit <erezsh@mellanox.co.il>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
In-Reply-To: <f4a42c8aa43c02d5ae5559a60c3e5e0f18c82531.1670485816.git.leonro@nvidia.com>
References: <f4a42c8aa43c02d5ae5559a60c3e5e0f18c82531.1670485816.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces
Message-Id: <167076005203.139282.9856295116413140573.b4-ty@kernel.org>
Date:   Sun, 11 Dec 2022 14:00:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 8 Dec 2022 09:52:54 +0200, Leon Romanovsky wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> There are 2 ways to create IPoIB PKEY child interfaces:
> 1) Writing a PKEY to /sys/class/net/<ib parent interface>/create_child.
> 2) Using netlink with iproute.
> 
> While with sysfs the child interface has the same number of tx and
> rx queues as the parent, with netlink there will always be 1 tx
> and 1 rx queue for the child interface. That's because the
> get_num_tx/rx_queues() netlink ops are missing and the default value
> of 1 is taken for the number of queues (in rtnl_create_link()).
> 
> [...]

Applied, thanks!

[1/1] IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces
      https://git.kernel.org/rdma/rdma/c/dbc94a0fb81771

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
