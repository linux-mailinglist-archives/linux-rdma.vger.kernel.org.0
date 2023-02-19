Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07569C03D
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Feb 2023 13:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBSM4Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Feb 2023 07:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBSM4Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Feb 2023 07:56:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A40CDDD
        for <linux-rdma@vger.kernel.org>; Sun, 19 Feb 2023 04:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EDCBB80966
        for <linux-rdma@vger.kernel.org>; Sun, 19 Feb 2023 12:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A17CC433EF;
        Sun, 19 Feb 2023 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676811379;
        bh=Bhy+we2HbgwY5dFgvmReIa39HI3UKcgv0vgpQVZviOI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WWp7/Pa+VBixTZo++Ry3QJQ7FOn6KgEglwMj3YQ5kzXA8HQz1FXnFc66Gf5vhuABE
         m3JV/UHiuUWwlJTX5IZ8iDsm0T5dxwiHx2rHR25qjS9ltUkx9UEvj9TY7CGnaSP6Kk
         FtEX8aDuDo93wxn+Uwpi99POTBCVlqG7YmJCeJnRpmxb7ID9RanPD7GJ8k2MazSbRS
         u9LtsAnWyF4TXglwPCUKTU5QU/3gyniayz9eyvRBvKE86fU298cBLpJKUZxG6cPgGz
         nkVaLM+b8sinK0C4P3Me/uaj4V3NbGwFnZwHUqVbZEfIPqY0JcYnqNshxdHDH+3tu3
         3WCuf32rozxDA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
In-Reply-To: <1dcc3440ee53c688f19f579a051ded81a2aaa70a.1676538714.git.leon@kernel.org>
References: <1dcc3440ee53c688f19f579a051ded81a2aaa70a.1676538714.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] IB/mlx5: Extend debug control for CC parameters
Message-Id: <167681137540.318121.11475618056162785227.b4-ty@kernel.org>
Date:   Sun, 19 Feb 2023 14:56:15 +0200
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


On Thu, 16 Feb 2023 11:13:45 +0200, Leon Romanovsky wrote:
> This patch adds rtt_resp_dscp to the current debug controllability of
> congestion control (CC) parameters.
> rtt_resp_dscp can be read or written through debugfs.
> If set, its value overwrites the DSCP of the generated RTT response.
> 
> 

Applied, thanks!

[1/1] IB/mlx5: Extend debug control for CC parameters
      https://git.kernel.org/rdma/rdma/c/66fb1d5df6ace3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
