Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756102707F2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRVPw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:15:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24962C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:52 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n2so8714237oij.1
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rxD7ngtE2B6yjT4J6Wtgxcz9cTP1TljJyUfIFPuZ/g=;
        b=b97EA+wZc4ODCfPkZrIvnegugQSXy9ozWUjLDazahgNA8c8jQR2y7tzhT9yaVC9ra6
         R+TwGnd/iXUOVZ4KxDQu9MvrILkZ23rHuYJdhYQAH0UdhSH2LxwmumphVV97FjuHxDrE
         CpWWuEwYDPuSyv4feZtzs/3d/UGlC+G+MII4Bmwmc7MZEXAeirr+Vof/RLCShyOFu3tR
         CRWjTfdjcsHx3ADchOXd1AHbyE8tLknA3QnNgrbSEqTvoKRQiJ0+0RnZDYx/qbfH0qDm
         5v4k32lp+Fm4sot1i9P2OYcT/sDz448mbbOt0TgjBvAUTv3qTe01g6lesa4OJ2PdwNJe
         UewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rxD7ngtE2B6yjT4J6Wtgxcz9cTP1TljJyUfIFPuZ/g=;
        b=AQROtrHJhxALXf2c2sLkZzypWVbgI/BXbZhzqJFSrmSp8+S/kIpfAdSoM8AnVoYrfj
         nUqJAtkHHjh3i+RM6V0F1+aBTcF2AjYNGWH4bFG5/NyeO8Q3Ky8gON/EaWomMR90Q59L
         FYaxDk8Kf8/fzUW/wKeqKxI0Ma+QkBlhVeGGqZlQGgFdtPXcZ/tqNUWgkyVpfqk3bpb6
         1Mottd8FrxswAqmu8k1up0dt+wXeVbcApfXKvTVLZhIw7hV+K/jiuoE0RI5mk58f7P5G
         /Od49p/mjBu6s25P0XLGA0CekhJodeBX6l3ydNg81wuy8n/6aQeKCU839GmTa0tJM7We
         oIMA==
X-Gm-Message-State: AOAM530X1T7lytO/D0os9pKGUI95m9hu8vMiBCLxcf/cLsxa4HvQFivd
        VGXjiwrhT0U9bdM6kf59wKI=
X-Google-Smtp-Source: ABdhPJzpLrAEv2rXJX5OEvmloP8AV/qxsUOPtLF2exwIy0OXPKqEnAvjdztVJl/WcinSGACFBhTa4g==
X-Received: by 2002:aca:ec53:: with SMTP id k80mr10286934oih.92.1600463751561;
        Fri, 18 Sep 2020 14:15:51 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id m12sm3150419otq.8.2020.09.18.14.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:15:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 00/12] rdma_rxe: API extensions
Date:   Fri, 18 Sep 2020 16:15:05 -0500
Message-Id: <20200918211517.5295-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series is a collection of API extensions for the rdma_rxe driver.
With this patch set installed there are no errors in pyverbs run-tests and
31 tests are skipped down from 56. The remaining skipped test cases include
	- XRC tests
	- ODP tests
	- Parent device tests
	- Import tests
	- Device memory
	- MLX5 specific tests
	- EFA tests

It continues from the previous (v4) set which implemented memory windows and
has had a number of individual patches picked up in for-next.

This set (v5) includes:
	Ported to current head of tree
	Memory windows patches not yet picked up
	kernel support for the extended user space APIs:
	  - ibv_query_device_ex
	  - ibv_create_cq_ex
	  - ibv_create_qp_ex
	Fixes for multicast which is not currently working

This patch set depends on a matching rdma-core user space library patch set.

In order to run correctly it is necessary to configure by hand the EUI64 link
local IPV6 address on systems which use a random link local address (like
Ubuntu).

Bob Pearson (12):
  rdma_rxe: Separate MEM into MR and MW objects.
  rdma_rxe: Enable MW objects
  rdma_rxe: Let pools support both keys and indices
  rdma_rxe: Add alloc_mw and dealloc_mw verbs
  rdma_rxe: Add bind_mw and invalidate_mw verbs
  rdma_rxe: Add memory access through MWs
  rdma_rxe: Add support for ibv_query_device_ex
  rdma_rxe: Add support for extended CQ operations
  rdma_rxe: Add support for extended QP operations
  rdma_rxe: Fix pool related bugs for multicast
  rdma_rxe: Fix multicast group allocation bug
  rdma_rxe: Fix bugs in the multicast receive path

 drivers/infiniband/sw/rxe/Makefile     |   1 +
 drivers/infiniband/sw/rxe/rxe.c        | 100 ++++--
 drivers/infiniband/sw/rxe/rxe_comp.c   |  12 +-
 drivers/infiniband/sw/rxe/rxe_cq.c     |  12 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  43 ++-
 drivers/infiniband/sw/rxe/rxe_mcast.c  | 110 ++++---
 drivers/infiniband/sw/rxe/rxe_mr.c     | 350 +++++++++++----------
 drivers/infiniband/sw/rxe/rxe_mw.c     | 416 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   1 -
 drivers/infiniband/sw/rxe/rxe_param.h  |  10 +-
 drivers/infiniband/sw/rxe/rxe_pool.c   | 330 +++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.h   | 109 +++++--
 drivers/infiniband/sw/rxe/rxe_recv.c   |  64 ++--
 drivers/infiniband/sw/rxe/rxe_req.c    | 113 ++++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 125 +++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c  | 101 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  64 ++--
 include/uapi/rdma/rdma_user_rxe.h      |  68 +++-
 19 files changed, 1448 insertions(+), 592 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c

-- 
2.25.1

