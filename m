Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57A27336E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIUUEJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUUEI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 16:04:08 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD37C061755
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q21so13502629ota.8
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkDHLqaBnIotj/EdcMr0D89sjI8qKFZeg64GDh3bLvw=;
        b=qyfTfxbmYDR3v0whKqTr0s6s8r2k6hLjzu8ahXnB0F56XKsUs+6f7YrtXkGWXCw9FM
         Bp/eWIzrNO/EYRggOy87dzj2xNhZUL7wQ8dvbmFVJJHwQJy5sD2/E4gaLduOEsBBrizi
         ssW6aAz3Hq/83WNUMEIc0e095z+G6WjsJi/OToQBZM2YiDbLjL1t0QHFaPl5AlICn9xk
         xsIunfLiDCgJx+3ZZigIVKku7gn31p621eusDW839cOusp1/EeH768gcsXAd9qUSLHVM
         CXJVa2gFOwnqCnx6X95W0WtHfm8jNwjtdYv/xKx8os+OlOhpqvJb2gxlty96DbcNc1OV
         c0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkDHLqaBnIotj/EdcMr0D89sjI8qKFZeg64GDh3bLvw=;
        b=lJJAGq+ZKqPj1EDC/r2L9lJ+mRMHo5VXX63TUXm//SrSI95PM/NHHQqlHfMfmDcVlR
         Q6CuzjW1N62jitUcR1AQK56oGMHkhDSKYuU0VhbF9TUw3Enf+vaPnSphJnZrChEl3TCe
         QnwCrkQ2EjBSigaywlBaGXOkz083U5/+etpsyGyeHqswi38VGrg7e/1DHijLn6lxlmHH
         wBJDlvglou8Ff74GbN0++Q7Yg/7lYPS3xPkW4UQmhSgYTlnMIaFY46Fo2xsNQawoLyia
         2WuiuAbHQCiDiUDK8JUkRu+cE/V5zJUMGnvDW5E3GTSE43HiGs14GkdcyLJtdV7ktZdN
         w8yQ==
X-Gm-Message-State: AOAM533U3PYFEjGbHZCPG0PK71kG2yI7bpMVbw3ZblHdVOLdAS4UMu7j
        hQY1XNMl/im4NIzqfWZVJzM=
X-Google-Smtp-Source: ABdhPJxq26AdXej/08R3YHkHvl02mhCK+UQHaG9yLXdIqWD60P9wd9vw9+pQMRECf4AleGJRM22SkQ==
X-Received: by 2002:a9d:709a:: with SMTP id l26mr667975otj.115.1600718647350;
        Mon, 21 Sep 2020 13:04:07 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:9211:f781:8595:d131])
        by smtp.gmail.com with ESMTPSA id a5sm6278333oti.30.2020.09.21.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:04:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 00/12] rdma_rxe: API extensions
Date:   Mon, 21 Sep 2020 15:03:44 -0500
Message-Id: <20200921200356.8627-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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

Bob Pearson (12):
  rdma_rxe: Separat MEM into MR and MW objects.
  rdma_rxe: Enable MW objects
  rdma_rxe: Let pools support both keys and indices
  rdma_rxe: Add alloc_mw and dealloc_mw verbs
  rdma_rxe: Add bind_mw and invalidate_mw verbs
  Add memory access through MWs
  rdma_rxe: Add support for ibv_query_device_ex
  rdma_rxe: Add support for extended CQ operations
  rdma_rxe: Add support for extended QP operations
  rdma_rxe: Fix pool related bugs
  rdma_rxe: Fix mcast group allocation bug
  rdma_rxe: Fix bugs in the multicast receive path

 drivers/infiniband/sw/rxe/Makefile     |   1 +
 drivers/infiniband/sw/rxe/rxe.c        | 100 ++++--
 drivers/infiniband/sw/rxe/rxe_comp.c   |  12 +-
 drivers/infiniband/sw/rxe/rxe_cq.c     |  12 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  45 ++-
 drivers/infiniband/sw/rxe/rxe_mcast.c  | 110 ++++---
 drivers/infiniband/sw/rxe/rxe_mr.c     | 354 +++++++++++----------
 drivers/infiniband/sw/rxe/rxe_mw.c     | 416 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   1 -
 drivers/infiniband/sw/rxe/rxe_param.h  |  10 +-
 drivers/infiniband/sw/rxe/rxe_pool.c   | 320 ++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.h   | 107 +++++--
 drivers/infiniband/sw/rxe/rxe_recv.c   |  64 ++--
 drivers/infiniband/sw/rxe/rxe_req.c    | 145 ++++++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 188 ++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c  | 101 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  64 ++--
 include/uapi/rdma/rdma_user_rxe.h      |  68 +++-
 19 files changed, 1532 insertions(+), 597 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c

-- 
2.25.1

