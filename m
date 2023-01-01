Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E395A65A965
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Jan 2023 09:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjAAI7W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Jan 2023 03:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAI7W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Jan 2023 03:59:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1926C6
        for <linux-rdma@vger.kernel.org>; Sun,  1 Jan 2023 00:59:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D99F60D57
        for <linux-rdma@vger.kernel.org>; Sun,  1 Jan 2023 08:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD240C433D2;
        Sun,  1 Jan 2023 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672563560;
        bh=xMbfLXNJ0wSTINZTvazbLCFm3Vzji6fR76M9QsCtz4Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m6E5n859jkvrL6oQTdyBChqtt6bjeMPlJVa6btsbARv9bTJydVA8a8u/FeNGtkuRZ
         vXOBfnyA3nhFQHkUFpMQ7pOOgNRLClhAH1nrxjTDvF5rr/I2pNKVIJkgZtePiUHFJx
         Tz5ryOwfoDqqGwfB5ahjfxZPS4HR2th/JjE5CjhAysl3MW2iOl/GYuKQUtg7H7GMnx
         ZsMlhnvYn3Irk52PSaEobjsMYPPRtr1asqkmAK+dlOJQ2LVhLEoumO0FlHcU49qmEt
         bj4/28Ae4NB1UJtvaCTYOP4FSJ+cc3ICr9mSUIXGajpigm8pQnV4dpo7CX8aGyDvXJ
         3KHzTbz5zfiZA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Shay Drory <shayd@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
In-Reply-To: <cover.1672231736.git.leonro@nvidia.com>
References: <cover.1672231736.git.leonro@nvidia.com>
Subject: Re: [PATCH RESEND rdma-next 0/2] Two mlx5_ib fixes
Message-Id: <167256355614.625625.17576771181417882532.b4-ty@kernel.org>
Date:   Sun, 01 Jan 2023 10:59:16 +0200
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

On Wed, 28 Dec 2022 14:56:08 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This was already posted to ML, but too late to be included in last pull
> request to Linus, so simply resending them.
> 
> [...]

Applied, thanks!

[1/2] RDMA/mlx5: Fix mlx5_ib_get_hw_stats when used for device
      (no commit info)
[2/2] RDMA/mlx5: Fix validation of max_rd_atomic caps for DC
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
