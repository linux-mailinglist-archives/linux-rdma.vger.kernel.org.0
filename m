Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4C77DA7D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbjHPGc7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbjHPGcg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 02:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68591FE6;
        Tue, 15 Aug 2023 23:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5412B63909;
        Wed, 16 Aug 2023 06:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39C0C433C7;
        Wed, 16 Aug 2023 06:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692167554;
        bh=4C7hmNUEzoSY6ll+R3hCEyiSVy1EjMg5kCs8oKOrzRs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SZ7Cytm4OaQDzwGY4WhJvJyy+clKCtC4BKWX53ctAECQhhnhpdc7A/gcSpGTi2qYZ
         zQYoqJ0FNkihN+69B8d147mBrZr7X7cxyb4kZwP/xT3coJLHHbNlZUAdMUA1LAGFdx
         vyIPJ7+YtycT+UnrVA0WTtGhA6+h3L+H+HQfZFyFc/mPTii1yxwLQZ/Q1mmYLBMvlH
         Dx5J8Q+BhgcNPv1daYMqTO5QafAghBlpPJdqWBUtwcBpXZR8L0OH4+VFiWX4DuZhku
         TuQ+h06q0EPkusnH9H0CYSLuupctV3ox1g/ZB1oXrfPHPkh3J8WERgBZ9zKO16exS0
         OK974DtLC9sMg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <ZNvimeRAPkJ24zRG@work>
References: <ZNvimeRAPkJ24zRG@work>
Subject: Re: [PATCH][next] RDMA/mlx4: Copy union directly
Message-Id: <169216755001.1947971.13071516719161593963.b4-ty@kernel.org>
Date:   Wed, 16 Aug 2023 09:32:30 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 15 Aug 2023 14:39:53 -0600, Gustavo A. R. Silva wrote:
> Copy union directly instead of using memcpy().
> 
> Note that in this case, a direct assignment is more readable and
> consistent with the subsequent assignments.
> 
> This addresses the following -Wstringop-overflow warning seen in s390
> with defconfig:
> drivers/infiniband/hw/mlx4/main.c:296:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
>   296 |                                 memcpy(&port_gid_table->gids[free].gid,
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   297 |                                        &attr->gid, sizeof(attr->gid));
>       |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx4: Copy union directly
      https://git.kernel.org/rdma/rdma/c/18ddaeb03bdb65

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
