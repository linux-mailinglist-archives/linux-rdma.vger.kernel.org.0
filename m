Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D5765C17
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjG0T3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjG0T3X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:23 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674392D68
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:22 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bb31245130so1097480a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486161; x=1691090961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qGmoLFS06TY8DgM/oyLqPkKOhwB3a74S+DgaIV/Rpo=;
        b=iTfaTEKV/30pVok07KOQB1UOf8OYhg4lC77YNluB0Mx/Vi+LwVpsgpuAyT0gLuFGu4
         GgzpehUGrt6DzXsXKLwbCOR5PJZyDs+b8ejoD7SrKEf3goh7ld4cCF6m+2HyZewuDkkQ
         k3PWYpcS22HlbtaAmlxDVcvhGEXZ55yFIU2ti1/rJspWzDYIMpv/Gc2feXBBy7+/PrZU
         MXcv2CwQ+xLa4GflvGqU6ffNwWurJC6Vs689KVcxSJc6kbX+9LPxNHcyhCBtgA2oD9S5
         YKte6vYPcxNDtxmqte/e17aAQsvYW9VmXAsf5FGVI6qIT7AFaFU7a+C4/5oCDNx6cbZ+
         wFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486161; x=1691090961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qGmoLFS06TY8DgM/oyLqPkKOhwB3a74S+DgaIV/Rpo=;
        b=Hl6c5VH0ImStKZtPCsvrZZSqeYhJKaSoJRWesqO5XLKOZJKcSTzwoH6XBy5McaT0HA
         0ArT7d32WmTA0JCyKi1fGDjfIxl4mpszCkHnLa7eLvRT2nowwAX6xZC6peGRIZu5WNPC
         r0CUYYbT8w3HCM6X2DKuOJSwlXi57fvJepBkHZSbeI4g86rbczPnCmPzrijeJOR3RKcg
         nguC1gxnDoGGemgjC82kawvw3tCSBpxWLKM37FpqQI54O4zTcs5yMHNOejumjQMCOQe8
         OUvnFro+eEqCe3ehXq5v0jY7JmMPq3pEzmBY99mJHeUjDcJIuV86Sz0KA1wZTWv1Bzwe
         z0ZA==
X-Gm-Message-State: ABy/qLZVlVImNoOlryRgR+d08Asoyerr68m3KrjkcUD/RxQnyQ6bVZlS
        1XGzwiC5k7hEV1rqyOlGr0g=
X-Google-Smtp-Source: APBJJlHW5sS1CziC37A/LtQRZKLqvn8a9hfScMj2BTEV4X15f/KeaVdId+ASg8Scr3Wdb8sOCw2jjg==
X-Received: by 2002:a05:6870:5246:b0:1ba:cc76:a266 with SMTP id o6-20020a056870524600b001bacc76a266mr478367oai.35.1690486161691;
        Thu, 27 Jul 2023 12:29:21 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 0/7] RDMA/rxe: Misc cleanups
Date:   Thu, 27 Jul 2023 14:28:24 -0500
Message-Id: <20230727192831.65495-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set is a collection of cleanup patches previously
posted as part of a larger set that included support for
nonlinear or fragmented packets. It has been rebased to the
current for-next branch after the application of three previous
patch sets:
	RDMA/rxe: Fix incomplete state save in rxe_requester
	RDMA/rxe: Misc fixes and cleanups
	Enable rcu locking of verbs objects

These changes are a pre-requisite for a patch set to follow
which implemements support for nonlinear packets. They are
mainly a code cleanup of rxe_req.c.

Bob Pearson (8):
  RDMA/rxe: Add pad size to struct rxe_pkt_info
  RDMA/rxe: Isolate code to fill request roce headers
  RDMA/rxe: Isolate request payload code in a subroutine
  RDMA/rxe: Remove paylen parameter from rxe_init_packet
  RDMA/rxe: Isolate code to build request packet
  RDMA/rxe: Put fake udp send code in a subroutine
  RDMA/rxe: Combine setting pkt info
  RDMA/rxe: Move next_opcode to rxe_opcode.c

 drivers/infiniband/sw/rxe/rxe_hdr.h    |   1 +
 drivers/infiniband/sw/rxe/rxe_icrc.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c    |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c | 176 +++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   4 +
 drivers/infiniband/sw/rxe/rxe_recv.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_req.c    | 451 ++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_resp.c   |  36 +-
 9 files changed, 354 insertions(+), 332 deletions(-)


base-commit: 693e1cdebb50d2aa67406411ca6d5be195d62771
prerequisite-patch-id: c3994e7a93e37e0ce4f50e0c768f3c1a0059a02f
prerequisite-patch-id: 48e13f6ccb560fdeacbd20aaf6696782c23d1190
prerequisite-patch-id: da75fb8eaa863df840e7b392b5048fcc72b0bef3
prerequisite-patch-id: d0877649e2edaf00585a0a6a80391fe0d7bbc13b
prerequisite-patch-id: 6495b1d1f664f8ab91ed9ef9d2ca5b3b27d7df35
prerequisite-patch-id: a6367b8fedd0d8999139c8b857ebbd3ce5c72245
prerequisite-patch-id: 78c95e90a5e49b15b7af8ef57130739c143e88b5
prerequisite-patch-id: 7c65a01066c0418de6897bc8b5f44d078d21b0ec
prerequisite-patch-id: 8ab09f93c23c7875e56c597e69236c30464723b6
prerequisite-patch-id: ca9d84b34873b49048e42fb4c13a2a097c215c46
prerequisite-patch-id: 0f6a587501c8246e1185dfd0cbf5e2044c5f9b13
prerequisite-patch-id: 5246df93137429916d76e75b9a13a4ad5ceb0bad
-- 
2.39.2

