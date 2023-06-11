Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1270572B11C
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjFKJTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 05:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjFKJTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 05:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDBA2139;
        Sun, 11 Jun 2023 02:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B956660C6C;
        Sun, 11 Jun 2023 09:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ED6C433D2;
        Sun, 11 Jun 2023 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686475190;
        bh=AZYx4+6AZpYpOskdFVIWBDbgGw4M55BanHGx4ndhFDE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bdBKjkkiloTMS4mCzOOYfi4Qa1r3NmiHEHcnWzFbqXt0er0H1j9kMW41ILIKLkBOw
         S+7wUC3l7UHak2i3jYqcwk1iUZJSsNsfemcZ+xFXmeA70r8FtnP12ErIKeHf+VoOiC
         I8iJi1XK8M4es3tUJj68W+Sbia7Wz0k+UMbZRI3dItCWyrNiDGb/ZN4MOFitGslhu+
         dVdwY1NUFCdtsSJoCX1AoXFqr5gy0XkSsJx5VAdJZXByHdTSzGM9HaYDrZKoelE7KF
         BCE5RFMxHow6xIWVhZJM7x+yGUAqEvWmQ72xzovtm0vCsK3vPUNCPDeIMRsiB6AkMq
         uYMBMSOCP4/yQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1685953497.git.leon@kernel.org>
References: <cover.1685953497.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v2 0/4] Handle FW failures to destroy QP/RQ objects
Message-Id: <168647518603.116598.4329507797128349123.b4-ty@kernel.org>
Date:   Sun, 11 Jun 2023 12:19:46 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 05 Jun 2023 13:14:03 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v2:
>  * Reworked DCT patch
> v1: https://lore.kernel.org/all/cover.1678973858.git.leon@kernel.org
>  * Dropped EQ changes
> v0: https://lore.kernel.org/all/cover.1649139915.git.leonro@nvidia.com
> -----------------------------------------------------------------------
> 
> [...]

Applied, thanks!

[1/4] net/mlx5: Nullify qp->dbg pointer post destruction
      https://git.kernel.org/rdma/rdma/c/c023b61ac8285d
[2/4] RDMA/mlx5: Reduce QP table exposure
      https://git.kernel.org/rdma/rdma/c/2ecfd946169e7f
[3/4] RDMA/mlx5: Handle DCT QP logic separately from low level QP interface
      https://git.kernel.org/rdma/rdma/c/afff24899846ff
[4/4] RDMA/mlx5: Return the firmware result upon destroying QP/RQ
      https://git.kernel.org/rdma/rdma/c/22664c06e99708

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
