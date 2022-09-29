Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9410F5EFB9E
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiI2RJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiI2RJM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:12 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B271CEDDE
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:07 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v130so2256753oie.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=v4RBfrqAq/dSETEHEufwaXWqzWiQjf9sNEmhJ2CEW50=;
        b=EGl7aVFMtoE/ho0i2uITKiStEbcVehauw2RcSRNxLi/o6AxphOmGGIPb1NBer4h15I
         N/GXpTYZHAWAruwfVtpZeFCrfqPT5MG9WaTPMmuugEe1QfY3czVLN4WSivx4iVnpgdGw
         RNnpwtuyjzL108tFgdfN1LlLQsg5xtcMad5KOlcupLAe6Sc5Xv++MUvSWyZ75Ca40Yp1
         wcE+08RihdLvFmdiMXUIa8+DpDueOeh9XDWTuRHmH696QB439EHqEIPAvCKLb4tOhTRw
         ZAtV1G7HkzfbrzbN3/pfZAiMdoRI9W3dh6jw2TiBexI89zK1Pl4lVpgsm1RPNIoXmqYV
         F8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=v4RBfrqAq/dSETEHEufwaXWqzWiQjf9sNEmhJ2CEW50=;
        b=ghQn1tJvKm0WqkVMYeEGvoNV1vXEpVJwJwZymI0vyqTN3++ecr5EEzuecCn+0rvdRx
         360o/AadCT83BBrwg+3q9A+IflLYJduqypH14FQFJOm0QNsdx552l+ghWmLPZBgS9wAB
         F18HcENw8ugdhVTMMDe+78CK2ADsaarLCj4LK4169SA4PKpUPFsWhCP6h+mwxlT1vtqc
         EMoER0HBTRzNXTZ+0LmAb/0QztIjMVEga5dN0vpemS+DQfXLRFV32R3+X7/MKf7DITHm
         N9o8FVoxEo6Tnwt4Fed4iWgnI2+8XI+9s26+YkyGb9jUW7N9zZZ10IOI4P7/EJKaXGeI
         A5Dg==
X-Gm-Message-State: ACrzQf3gwLGxOGo8o3XBA9D11fP7Z4lICfhz3lYdx2KrgnjhQDj0l/NZ
        Q3TdLd8+vbv6/0aSIENDrfg=
X-Google-Smtp-Source: AMsMyM47J1Pkj1dij6hgyop5Eaiq0HsHqnO2WzHWJkqnmwsWjvmfCyDqXMjwHwaNXHwytfpaMPS4DQ==
X-Received: by 2002:a05:6808:118c:b0:34f:9fc9:ce15 with SMTP id j12-20020a056808118c00b0034f9fc9ce15mr7279136oil.220.1664471346476;
        Thu, 29 Sep 2022 10:09:06 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 00/13] Implement the xrc transport
Date:   Thu, 29 Sep 2022 12:08:24 -0500
Message-Id: <20220929170836.17838-1-rpearsonhpe@gmail.com>
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

This patch series implements the xrc transport for the rdma_rxe driver.
It is based on the current for-next branch of rdma-linux.
The first two patches in the series do some cleanup which is helpful
for this effort. The remaining patches implement the xrc functionality.
There is a matching patch set for the user space rxe provider driver.
The communications between these is accomplished without making an
ABI change by taking advantage of the space freed up by a recent
patch called "Remove redundant num_sge fields" which is a reprequisite
for this patch series.

The two patch sets have been tested with the pyverbs regression test
suite with and without each set installed. This series enables 5 of
the 6 xrc test cases in pyverbs. The ODP case does is currently skipped
but should work once the ODP patch series is accepted.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Rebased to current for-next

Bob Pearson (13):
  RDMA/rxe: Replace START->FIRST, END->LAST
  RDMA/rxe: Move next_opcode() to rxe_opcode.c
  RDMA: Add xrc opcodes to ib_pack.h
  RDMA/rxe: Extend opcodes and headers to support xrc
  RDMA/rxe: Add xrc opcodes to next_opcode()
  RDMA/rxe: Implement open_xrcd and close_xrcd
  RDMA/rxe: Extend srq verbs to support xrcd
  RDMA/rxe: Extend rxe_qp.c to support xrc qps
  RDMA/rxe: Extend rxe_recv.c to support xrc
  RDMA/rxe: Extend rxe_comp.c to support xrc qps
  RDMA/rxe: Extend rxe_req.c to support xrc qps
  RDMA/rxe: Extend rxe_net.c to support xrc qps
  RDMA/rxe: Extend rxe_resp.c to support xrc qps

 drivers/infiniband/sw/rxe/rxe.c        |   2 +
 drivers/infiniband/sw/rxe/rxe_av.c     |   3 +-
 drivers/infiniband/sw/rxe/rxe_comp.c   |  51 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h    |  41 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  13 +-
 drivers/infiniband/sw/rxe/rxe_mw.c     |  14 +-
 drivers/infiniband/sw/rxe/rxe_net.c    |  23 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c | 766 +++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_opcode.h |   9 +-
 drivers/infiniband/sw/rxe/rxe_param.h  |   3 +
 drivers/infiniband/sw/rxe/rxe_pool.c   |   8 +
 drivers/infiniband/sw/rxe/rxe_pool.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_qp.c     | 308 ++++++----
 drivers/infiniband/sw/rxe/rxe_recv.c   |  79 ++-
 drivers/infiniband/sw/rxe/rxe_req.c    | 204 +------
 drivers/infiniband/sw/rxe/rxe_resp.c   | 168 ++++--
 drivers/infiniband/sw/rxe/rxe_srq.c    | 131 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c  |  57 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  20 +-
 include/rdma/ib_pack.h                 |  32 +-
 include/uapi/rdma/rdma_user_rxe.h      |   4 +-
 21 files changed, 1341 insertions(+), 596 deletions(-)


base-commit: cbdae01d8b517b81ed271981395fee8ebd08ba7d
-- 
2.34.1

