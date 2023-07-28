Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130817660CD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 02:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjG1AkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 20:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG1AkN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 20:40:13 -0400
Received: from out-87.mta0.migadu.com (out-87.mta0.migadu.com [IPv6:2001:41d0:1004:224b::57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C62D40
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 17:40:11 -0700 (PDT)
Message-ID: <d2b1f434-4b49-d7af-6260-2194ef67731d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690504810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMu7dsQwYL2QGsmdhgPEj8+A1ZNGg8OK+qs/yacVyvk=;
        b=R+09nTQy4+fEs9DnbZBO1dnC3DJB6z8mv6ahP6uQKqEKAhkDEIg04cr5mB/39Com3i5gU6
        gxPIZvx2j5pcHQcQBbzpGbSR7CO89ONgV/RhZ/S7ejQfM6MFmouR/iFmWACI8hBi9KkZ7G
        plMqkOYF+H72nfvWTyPXZd7axtjTBWs=
Date:   Fri, 28 Jul 2023 08:40:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3 00/10] RDMA/rxe: Implement support for
 nonlinear packets
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/7/28 4:01, Bob Pearson 写道:
> This patch set is a revised version of an older set which implements
> support for nonlinear or fragmented packets. This avoids extra copies
> in both the send and receive paths and gives significant performance
> improvement for large messages such as are used in storage applications.
> 
> This patch set has been heavily tested at large system scale and
> demonstrated a 2X improvement in file system read performance on
> a 200 Gb/sec network.
> 
> The patch set is rebased to the current for-next branch with the
> following previous patch sets applied:
> 	RDMA/rxe: Fix incomplete state save in rxe_requester
> 	RDMA/rxe: Misc fixes and cleanups
> 	Enable rcu locking of verbs objects
> 	RDMA/rxe: Misc cleanups
> 
> Bob Pearson (10):
>    RDMA/rxe: Add sg fragment ops
>    RDMA/rxe: Extend rxe_mr_copy to support skb frags
>    RDMA/rxe: Extend copy_data to support skb frags
>    RDMA/rxe: Extend rxe_init_packet() to support frags
>    RDMA/rxe: Extend rxe_icrc.c to support frags
>    RDMA/rxe: Extend rxe_init_req_packet() for frags
>    RDMA/rxe: Extend response packets for frags
>    RDMA/rxe: Extend send/write_data_in() for frags
>    RDMA/rxe: Extend do_read() in rxe_comp.c for frags
>    RDMA/rxe: Enable sg code in rxe
> 
>   drivers/infiniband/sw/rxe/rxe.c        |   5 +
>   drivers/infiniband/sw/rxe/rxe.h        |   3 +
>   drivers/infiniband/sw/rxe/rxe_comp.c   |  46 +++-
>   drivers/infiniband/sw/rxe/rxe_icrc.c   |  65 ++++-
>   drivers/infiniband/sw/rxe/rxe_loc.h    |  27 +-
>   drivers/infiniband/sw/rxe/rxe_mr.c     | 348 +++++++++++++++++++------
>   drivers/infiniband/sw/rxe/rxe_net.c    | 109 +++++++-
>   drivers/infiniband/sw/rxe/rxe_opcode.c |   2 +
>   drivers/infiniband/sw/rxe/rxe_recv.c   |   1 +
>   drivers/infiniband/sw/rxe/rxe_req.c    |  88 ++++++-
>   drivers/infiniband/sw/rxe/rxe_resp.c   | 172 +++++++-----
>   drivers/infiniband/sw/rxe/rxe_verbs.h  |   8 +-
>   12 files changed, 672 insertions(+), 202 deletions(-)
> 
> 

What are the following? This is the new format in linux kernel community?

Zhu Yanjun

> base-commit: 693e1cdebb50d2aa67406411ca6d5be195d62771
> prerequisite-patch-id: c3994e7a93e37e0ce4f50e0c768f3c1a0059a02f
> prerequisite-patch-id: 48e13f6ccb560fdeacbd20aaf6696782c23d1190
> prerequisite-patch-id: da75fb8eaa863df840e7b392b5048fcc72b0bef3
> prerequisite-patch-id: d0877649e2edaf00585a0a6a80391fe0d7bbc13b
> prerequisite-patch-id: 6495b1d1f664f8ab91ed9ef9d2ca5b3b27d7df35
> prerequisite-patch-id: a6367b8fedd0d8999139c8b857ebbd3ce5c72245
> prerequisite-patch-id: 78c95e90a5e49b15b7af8ef57130739c143e88b5
> prerequisite-patch-id: 7c65a01066c0418de6897bc8b5f44d078d21b0ec
> prerequisite-patch-id: 8ab09f93c23c7875e56c597e69236c30464723b6
> prerequisite-patch-id: ca9d84b34873b49048e42fb4c13a2a097c215c46
> prerequisite-patch-id: 0f6a587501c8246e1185dfd0cbf5e2044c5f9b13
> prerequisite-patch-id: 5246df93137429916d76e75b9a13a4ad5ceb0bad
> prerequisite-patch-id: 41b0e4150794dd914d9fcb4cd106fe4cf4227611
> prerequisite-patch-id: 02b08ec037bc35b9c7771640c89c66504cdf38a6
> prerequisite-patch-id: dfccc06c16454d7fe8e6fcba064d4e471d314666
> prerequisite-patch-id: 7459a6e5cdd46efd53ba27f9b3e9028af6e0863b
> prerequisite-patch-id: 36d49f9303f5cb276a5601c1ab568eea6eca7d3a
> prerequisite-patch-id: 6359a681e40832694f81ca003c10e5327996bf7d
> prerequisite-patch-id: 558175db657f374dbd3e0a57ac4c5fb77a56b6c6
> prerequisite-patch-id: d6b811de06c8900be5840dd29715161d26db66cf

