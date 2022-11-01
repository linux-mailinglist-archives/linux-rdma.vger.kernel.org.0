Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38357615321
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiKAUX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKAUX3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:29 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA9A65F6
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:27 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l5so17141677oif.7
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krQgfTKQLdXH23FkuBktlS88j7IlSFq/WxRFpbwxXBc=;
        b=Mfe0zYG/wlrk4h0BHQbFwgnH1Glza3DuUXyMOKBBHZn+CxJlwABuYzvWOLKek1FP2y
         HjT1Hm+8L3P2YNn9ZAxtOz7mDBGmEvc5vNCjX/xG9BW//0oDYy5RJw1BKI/emQYk+KtI
         S04Ax0E1e6V+/uWUQr4swgq7Mo1oBIcQxVaGmkKpF8n2aiztc2QH6UJ0SWW5v6wH10eB
         HSBC61FP5+RfdsyAWA7MrdEasIMxGd5Pz+SpwwckBmRahXWIMCGBCDWAj2ph2WRYNgWF
         xZS/VB07FWeh9uwSq2O7DmZdOxG4+wXUOEuG8o1hqa8VSefgbBhq6Gvw02FJY/JbePf5
         Rtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krQgfTKQLdXH23FkuBktlS88j7IlSFq/WxRFpbwxXBc=;
        b=u8ICUEksuH3JYEsgxlifY9KCioPWu+p7M6ImEOdw9/ObHRsMikaU32uhF4ejYAYyLQ
         qNwkWn36gAb5LvzgJgKMcrU0euggYBo1mEytlDAv5YXAyUj51/+Dy3JnyJRzuOn++vPV
         VIarndgLJVMbogut/K61EGYbXxlW5PlHW2a4sz4mmmzoteEkrEeG1BlA87R2eotdcZYF
         rFNdrhcxNByBV+gAB27Wllqb6gqdNzzKK1GekAJi9IaBxFzGnUdykcLidpk4RaIAB58h
         h494IJp7yRethNjU2wrWU2TG3B4WLt5UfF+7oJJbSgLz9xjKeTGj5I3fTxghfTcTld4U
         VQDA==
X-Gm-Message-State: ACrzQf1y/prdvDfIg0qjL1KTyyFspUe/rz6YKmoNAjrdOpLvJGCLAdfR
        zVdMiCwjc6tOdFUTGECNl9Q=
X-Google-Smtp-Source: AMsMyM5wrDNFU/kZtZw5Lt1Rjzr7emqYX/sp2QCSc9tOHOuRfYbxT1dmEaljCa2oqci034Mglc27ng==
X-Received: by 2002:a05:6808:e87:b0:353:f1e2:e16f with SMTP id k7-20020a0568080e8700b00353f1e2e16fmr18966371oil.258.1667334206826;
        Tue, 01 Nov 2022 13:23:26 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 00/16] Use ibdev_dbg instead of pr_xxx
Date:   Tue,  1 Nov 2022 15:22:23 -0500
Message-Id: <20221101202238.32836-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series replaces calls to pr_xxx with calls to ibdev_dbg
using macros for rxe objects adapted from similar macros from siw,
except in situations where the rdma device is not in scope.

This patch series is based on the current for-next branch.

Bob Pearson (16):
  RDMA/rxe: Add ibdev_dbg macros for rxe
  RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_comp.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_cq in rxe_cq.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_mr in rxe_mr.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_mw in rxe_mw.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_net.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_qp.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_req.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_resp.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_srq in rxe_srq.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg in rxe_verbs.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_av.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_task.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg in rxe.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg in rxe_icrc.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg in rxe_mmap.c

 drivers/infiniband/sw/rxe/rxe.c       |  4 +-
 drivers/infiniband/sw/rxe/rxe.h       | 19 ++++++++
 drivers/infiniband/sw/rxe/rxe_av.c    | 43 ++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 12 ++---
 drivers/infiniband/sw/rxe/rxe_cq.c    |  8 ++--
 drivers/infiniband/sw/rxe/rxe_icrc.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  8 +---
 drivers/infiniband/sw/rxe/rxe_mmap.c  |  6 +--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 40 +++++++---------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 20 ++++----
 drivers/infiniband/sw/rxe/rxe_net.c   | 35 +++++++-------
 drivers/infiniband/sw/rxe/rxe_qp.c    | 69 +++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_req.c   | 10 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 17 +++----
 drivers/infiniband/sw/rxe/rxe_srq.c   | 20 ++++----
 drivers/infiniband/sw/rxe/rxe_task.c  |  7 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 18 ++++---
 17 files changed, 188 insertions(+), 152 deletions(-)


base-commit: 692373d186205dfb1b56f35f22702412d94d9420
-- 
2.34.1

