Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695002805CE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbgJARs4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARsz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:48:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B94C0613D0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:48:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id m12so6352346otr.0
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKuGkVq4yoLDSpXwZuQSVYM/8Zy9KCtXCZW/DY9+1Ao=;
        b=SncjLYjvsAB5Iu6TNzrgd3VKTg5wIg2/YlRylS2jVxwRnLuhK2V+8SSUEWiAGjt7Y+
         e+EziI2aRPrP/BKxujZMSecJ9fEwOJxYiZEVygSz3o0JjE4o+saiFFnxsJCqtfNVqys/
         HcrgvBYHEcbMSjitmhC8wfU359mxayTDUGg4ocHmAE3J1a9lGed8Rp5p9XacrP4gZFd8
         Fi9XoDIvRA2AyvJoitM3P5LifXXSeK1UZ+Bo2X21/0sq1GSagaO1ADLJ4ku2PgDLWceB
         As8mFTfo3YpbiFsYcE15jNCrlFvoW9A9uYi5h5GyzATeDv+Ubba6A0uyBfa1uTICxpPC
         a/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKuGkVq4yoLDSpXwZuQSVYM/8Zy9KCtXCZW/DY9+1Ao=;
        b=NpM0uFkZUz7pFL7pOHRAzjhtGtixe/+6AAXPENsSZI2oUDJR+Ki+4eZWllKsjVWmyh
         3WhRgiDZEHiQ9Ksr7qnuvKDu0mi+GodqBKLx28lqf8tHUz8jnQBNon2J9tRxB+rOAJ2w
         U3s0CkiDmJOjzUXn/qTn9IupZ89ChT7pcX+yy8FRBX0LuBvGqo2JjXpBVFQj/9E9kdQQ
         g2CuJYs6GWnc51mkOkXewg/DQhOiUYwt2cjz+8d+E2V8h7O2U5yOLskxMh7cezfYRNFg
         x+C7/L5sDMaZ0AfcACfzeuKK5Yj9hXd/bsazQe8KkzaMeWL/Fr/sTkdlEFxnhR4wAm/C
         hDBQ==
X-Gm-Message-State: AOAM533c+kHmadmRdln8YUDD9kBDpSuI979EgUy6E/2tVAVtSheSHNU6
        3yBrZQHKsBJ8ay1qFD02QV55Syjn8lw=
X-Google-Smtp-Source: ABdhPJzt+XjiLpFC0FptAaCJi7IjFTXlcNXkgJLy0oSggIqGqSzmccZK6NcTRIp81ejo92PnNspZpg==
X-Received: by 2002:a05:6830:1bc2:: with SMTP id v2mr5770061ota.67.1601574534574;
        Thu, 01 Oct 2020 10:48:54 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id g18sm1358531otg.58.2020.10.01.10.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:48:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 00/19] rdma_rxe: API extensions
Date:   Thu,  1 Oct 2020 12:48:28 -0500
Message-Id: <20201001174847.4268-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V7:
   Ported this patch series forward to the current state of for-next.

   MW now being allocated in core.

   Split up rxe_pool changes into patches as requested by Jason.
   Added some better comments.
   Added error returns via ERR_PTR for APIs that return pointers.

   Added some additional validation for rkeys in rxe_resp based on
   chapter 9 of IBA.

   Minor cleanup to rxe_mr which had duplicate entries.

V6:
   Fixed two issues raised by Jason and Zhu.

   Undid the replacement of rwlocks by spinlocks in patch 10/12. On further
   reading it turns out rwlocks were the better choice.

   Missing prototype for rxe_invalidate_mr. This was caused by a regression in
   patch 05/12 which had dropped the actual use of the routine as well as the
   prototype. Fixed.

V5:
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

Bob Pearson (19):
  rdma_rxe: Separat MEM into MR and MW objects.
  rdma_rxe: Enable MW objects
  rdma_rxe: Let pools support both keys and indices
  rdma_rxe: make pool return values position independent
  rdma_rxe: remove void * parameters in pool APIs
  rdma_rxe: add alloc_mw and dealloc_mw verbs
  rdma_rxe: Add bind_mw and invalidate_mw verbs
  rdma_rxe: Add memory access through MWs
  rdma_rxe: Add locked and unlocked pool APIs
  rdma_rxe: Add support for ibv_query_device_ex
  rdma_rxe: Add support for extended CQ operations
  rdma_rxe: Add support for extended QP operations
  rdma_rxe: Fix mcast group allocation bug
  rdma_rxe: Fix bugs in the multicast receive path
  rdma_rxe: handle ERR_PTR returns from pool
  rdma_rxe: remove duplicate entries in struct rxe_mr
  rdma_rme: removed unused RXE_MR_TYPE_FMR
  rdma_rxe: add rkey validation checks for MR and MW
  rdma_rxe: moved rxe_xmit_packet to rxe_net.c

 drivers/infiniband/sw/rxe/Makefile     |   1 +
 drivers/infiniband/sw/rxe/rxe.c        | 100 ++--
 drivers/infiniband/sw/rxe/rxe_comp.c   |  12 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  91 ++--
 drivers/infiniband/sw/rxe/rxe_mcast.c  | 118 +++--
 drivers/infiniband/sw/rxe/rxe_mr.c     | 396 ++++++++-------
 drivers/infiniband/sw/rxe/rxe_mw.c     | 420 ++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_net.c    |  47 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   1 -
 drivers/infiniband/sw/rxe/rxe_param.h  |  10 +-
 drivers/infiniband/sw/rxe/rxe_pool.c   | 653 ++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.h   | 148 +++---
 drivers/infiniband/sw/rxe/rxe_recv.c   |  67 ++-
 drivers/infiniband/sw/rxe/rxe_req.c    | 145 ++++--
 drivers/infiniband/sw/rxe/rxe_resp.c   | 188 +++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c  | 118 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  71 ++-
 include/uapi/rdma/rdma_user_rxe.h      |  68 ++-
 19 files changed, 1930 insertions(+), 735 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c

-- 
2.25.1

