Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68D7B5166
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 13:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjJBLdB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLdA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 07:33:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF586BF
        for <linux-rdma@vger.kernel.org>; Mon,  2 Oct 2023 04:32:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD14C433C8;
        Mon,  2 Oct 2023 11:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696246377;
        bh=7BXLFXlqni+CBGU5A+BuLEQ2RL/JPn7x4crUsgXA9YY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h4NWtPgF2yN0gBXNv0JldCrZiEwo9joQDA24UTDzs2Ib6fez/WsCjSbRC9TqYFj86
         WkvBuHv2ihaAXoHEah1TMrinBKcoqW3JqMG43gX3P1HxioPePgzze2VX2cUPwszWWa
         GhQ0XUckRs59aotlSQcBkZyZwdzi9ZXqLDk9OezNuiWWSJKSjSfeeaC8Wv+D3uXptk
         n/azXhR6JrXCwDfSWhQPfT9kllAymrPRq67mSQALkkC9llSIBnBpHo7AnbnP9GNfRt
         GLoIaS8uUpkM8HfQ3bq0ltp7du03Mf3dJDIBbqAx0R2c5ot8QVg7zV+OR1aS+ZOqQp
         puXUwiYcUh0fQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <c7e9c9f98c8ae4a7413d97d9349b29f5b0a23dbe.1695921626.git.leon@kernel.org>
References: <c7e9c9f98c8ae4a7413d97d9349b29f5b0a23dbe.1695921626.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Remove not-used cache disable flag
Message-Id: <169624637299.125593.14253478652081211934.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 14:32:52 +0300
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


On Thu, 28 Sep 2023 20:20:47 +0300, Leon Romanovsky wrote:
> During execution of mlx5_mkey_cache_cleanup(), there is a guarantee
> that MR are not registered and/or destroyed. It means that we don't
> need newly introduced cache disable flag.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Remove not-used cache disable flag
      https://git.kernel.org/rdma/rdma/c/c99a7457e5bb87

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
