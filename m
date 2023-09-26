Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63387AE95D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 11:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjIZJhg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjIZJhd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 05:37:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC53EB
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 02:37:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC58FC433CB;
        Tue, 26 Sep 2023 09:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695721045;
        bh=8lEQMrCMRdFJYgvuWIqE+sWLb4fAQDEDAdT6LpaNlL4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LHqI4ASqlFPJn2y8C+iuW3iP0Voe4EJufp5pebLfGZDrX+i2sKnktFeWbC9vfBz/d
         lF8PfCyqJTHpTbZ5hoara+KVyrHIRW8FHdjDRHOXxb4OQUHvPkQhVEs3QTK80Q6kNG
         L0vSH//KTreP8bPVd9UwvvlDMlNKJPBBYhm05QvrungFtzrqW+h9zcEuJtCSFbNtY3
         /f7BWjW9TOo05MFOJalwLsiW2qbY3pxfbDokG7+5hSiaBUOwVQbGnMLyWcja5AFrCz
         124wjMqydGxi9qt2bG3cA7XzvDmwFaouAUz6SG+D4Pl1xhXmHKxJ4zowhjjBbVkK/X
         mPVya795BFulw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <fde3d4cfab0f32f0ccb231cd113298256e1502c5.1695283384.git.leon@kernel.org>
References: <fde3d4cfab0f32f0ccb231cd113298256e1502c5.1695283384.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Implement mkeys management via LIFO queue
Message-Id: <169572104113.2610313.15955631436623118024.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 12:37:21 +0300
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


On Thu, 21 Sep 2023 11:07:16 +0300, Leon Romanovsky wrote:
> Currently, mkeys are managed via xarray. This implementation leads to
> a degradation in cases many MRs are unregistered in parallel, due to xarray
> internal implementation, for example: deregistration 1M MRs via 64 threads
> is taking ~15% more time[1].
> 
> Hence, implement mkeys management via LIFO queue, which solved the
> degradation.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Implement mkeys management via LIFO queue
      https://git.kernel.org/rdma/rdma/c/57e7071683ef61

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
