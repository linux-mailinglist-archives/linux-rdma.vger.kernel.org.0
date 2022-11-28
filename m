Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED263A750
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 12:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiK1Log (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 06:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiK1Lo2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 06:44:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAF015FE7
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 03:44:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33D20B80ABE
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 11:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4686FC433D6;
        Mon, 28 Nov 2022 11:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669635863;
        bh=OYyIaHMB+MkJwmO9p0WDvZzYEVguD+VMEKB4JzVtpIQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=BHbn28U7rc3gtP9898isBeqfLON0WdKUdN9RcypEPIwOIolzjj0M2qRbS/bGAJZwn
         pDL4WkSOai1l0lhHAfMg3ePn6f9fHWUbz8g54LRJwe1UnoCmISTPlAOQ9R8H/gb6gN
         mEalizLpWooPvsJ83gBOQ/lGwMZ6dj1OzVG6TOCQ731MUwMhmECyhY4pW+ZHAqIt+S
         33kVPvUTAWi2DXC9251o9ukeY22C+yjZAUfWWQVc7UBhD/UmiDYFdaJtm+kGd0jnGo
         8ticLzF8TZWC9L48GbEchKv6FUpEsuiE4SfepyBVhouBuVegnvt/qrnss/uEPnN7z8
         4N3W78VH1hvjA==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, markz@mellanox.com, error27@gmail.com,
        Yuan Can <yuancan@huawei.com>, majd@mellanox.com, jgg@ziepe.ca,
        mgurtovoy@nvidia.com, chenzhongjin@huawei.com
In-Reply-To: <20221126043410.85632-1-yuancan@huawei.com>
References: <20221126043410.85632-1-yuancan@huawei.com>
Subject: Re: [PATCH] RDMA/nldev: Add checks for nla_nest_start() in fill_stat_counter_qps()
Message-Id: <166963585886.603559.6551564096488151896.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 13:44:18 +0200
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

On Sat, 26 Nov 2022 04:34:10 +0000, Yuan Can wrote:
> As the nla_nest_start() may fail with NULL returned, the return value needs
> to be checked.
> 
> 

Applied, thanks!

[1/1] RDMA/nldev: Add checks for nla_nest_start() in fill_stat_counter_qps()
      https://git.kernel.org/rdma/rdma/c/ea5ef136e215fd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
