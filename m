Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16E86B9219
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Mar 2023 12:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCNLv3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 07:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjCNLvZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 07:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08839FBFD;
        Tue, 14 Mar 2023 04:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B016173E;
        Tue, 14 Mar 2023 11:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1046EC43443;
        Tue, 14 Mar 2023 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678794665;
        bh=JAGoo2SgIY4kQe/DowCGQHuyh5Fpt75CcZrOFP7yelI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JwGKxtg5us41CJNA77pobrV92L4EWU67jkSnaQudPOdjmX7Kyz9EzctB8n7N3CXAa
         xT4gEgpQpHD4485KaY5i6NFqem/MeKKTj3rdD/9h+rIhiN65cMCwRQWxoy/pjXRKPa
         GqVz7IrJGorHarrlqMrl8Yc/ZYyFMKahiPuyOxDI63+2VBKHRW430XNyQPtdbI+Lfl
         3NzYxM9du9G/2t+l8TvCW+r2mWXkPlKt8yuw9xdzOM3VDuwb7yKQdnjTHCQCkrpGRF
         BnxU4amRMZr0RMyweyq2xS2hwnI4/ovGmc6MXh4WfEGcxKe8j8S0NnrW4lHt+C1Xtm
         2Vrd1dFBx65ug==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Dan Carpenter <error27@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Roland Dreier <rolandd@cisco.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <a8dfbd1d-c019-4556-930b-bab1ded73b10@kili.mountain>
References: <a8dfbd1d-c019-4556-930b-bab1ded73b10@kili.mountain>
Subject: Re: [PATCH] RDMA/mlx: prevent shift wrapping in set_user_sq_size()
Message-Id: <167879465887.235555.12153701745715660360.b4-ty@kernel.org>
Date:   Tue, 14 Mar 2023 13:50:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 07 Mar 2023 12:51:27 +0300, Dan Carpenter wrote:
> The ucmd->log_sq_bb_count variable is controlled by the user so this
> shift can wrap.  Fix it by using check_shl_overflow() in the same way
> that it was done in commit 515f60004ed9 ("RDMA/hns: Prevent undefined
> behavior in hns_roce_set_user_sq_size()").
> 
> 

Applied, thanks!

[1/1] RDMA/mlx: prevent shift wrapping in set_user_sq_size()
      https://git.kernel.org/rdma/rdma/c/9b88b0fcab7461

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
