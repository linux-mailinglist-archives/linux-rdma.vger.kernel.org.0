Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC74B765CC3
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjG0UCM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjG0UCL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:11 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871562D7B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:10 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bb29b9044dso1187195a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488130; x=1691092930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f8pycM7F39+X1O6TV8CFPhwmYOkSEU3KgWwk/S3UeSU=;
        b=Ix94ktlU/n8E+zzqJvljjuof3GqaL1qGmf4LwZNIH80nZg9SjNadmU9GkmrtQ+Autb
         mRilL55w8Huv75QXPUAd7m6fCFN0waIYw2z7Qusa0tq27JTrnCEZ2bIJZQqQLZJEKrPt
         Oxxo5hi6cdSgNP51TnSsymZhbvPv9MZNEll83b3IAujCZ7AQCQkyCTik/puDTrGhfxk+
         ne+mgi0YM7UNjjFhBBKwzRH6oTcIUc55QGTuS7F2u67FoE/KSKhikoNS8soJDvfh0eqn
         VFZ8aaHyAAnx2qx/wqrhQGD/sxhmuEw9NpdM6Km3LsAy95EHJbGYFiAghVchTJVjmbws
         mbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488130; x=1691092930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8pycM7F39+X1O6TV8CFPhwmYOkSEU3KgWwk/S3UeSU=;
        b=QDLS0tBqTi5x2Q7718KZr0J91yAx089dRPMfZpNf6DZM9qH/Ro1wJBQpqkjFaQFB/q
         Q1jEsrniWco66PvmunhzhV06RjkuXdgwEUaQNFplmFCt7WK+v79R2/bARAjwRMqxlBZX
         Ng5tQoJ+izviit81hTSxqobFt3mONKvJNYQwRpfNDkVjPQtLZUsULt1LZr0K9sv17AdH
         kIOUTCVh6eyqK1KwmDJlYm4XMH1fFdYz71DnKO0bF/2DHMZMI7R/E8TWV70ux/P10Znx
         PT9+eiY5K9NmG5jciz0CAYsCwmhoe8k7sCuM56Pl1BN3xgwdaI63aS/jGm8s4fBI9Zqq
         MPkA==
X-Gm-Message-State: ABy/qLZ12TFwPtZOt1bsmAeEE53cUTNlVygiA0NmaeQahgV85r34cKpg
        zi835VVAZ5PU5xfDIgAGMS2sYfqwM+E=
X-Google-Smtp-Source: APBJJlFYWunlCODceyD6YDS2wox5oyNnmEDwCt2TetO5gFgurLxq2TA+ALtIjh0/tiNG1gDzsyH5bg==
X-Received: by 2002:a9d:5c10:0:b0:6bc:3133:6aef with SMTP id o16-20020a9d5c10000000b006bc31336aefmr170801otk.26.1690488129789;
        Thu, 27 Jul 2023 13:02:09 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 00/10] RDMA/rxe: Implement support for nonlinear packets
Date:   Thu, 27 Jul 2023 15:01:19 -0500
Message-Id: <20230727200128.65947-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set is a revised version of an older set which implements 
support for nonlinear or fragmented packets. This avoids extra copies
in both the send and receive paths and gives significant performance
improvement for large messages such as are used in storage applications.

This patch set has been heavily tested at large system scale and
demonstrated a 2X improvement in file system read performance on
a 200 Gb/sec network.

The patch set is rebased to the current for-next branch with the
following previous patch sets applied:
	RDMA/rxe: Fix incomplete state save in rxe_requester
	RDMA/rxe: Misc fixes and cleanups
	Enable rcu locking of verbs objects
	RDMA/rxe: Misc cleanups

Bob Pearson (10):
  RDMA/rxe: Add sg fragment ops
  RDMA/rxe: Extend rxe_mr_copy to support skb frags
  RDMA/rxe: Extend copy_data to support skb frags
  RDMA/rxe: Extend rxe_init_packet() to support frags
  RDMA/rxe: Extend rxe_icrc.c to support frags
  RDMA/rxe: Extend rxe_init_req_packet() for frags
  RDMA/rxe: Extend response packets for frags
  RDMA/rxe: Extend send/write_data_in() for frags
  RDMA/rxe: Extend do_read() in rxe_comp.c for frags
  RDMA/rxe: Enable sg code in rxe

 drivers/infiniband/sw/rxe/rxe.c        |   5 +
 drivers/infiniband/sw/rxe/rxe.h        |   3 +
 drivers/infiniband/sw/rxe/rxe_comp.c   |  46 +++-
 drivers/infiniband/sw/rxe/rxe_icrc.c   |  65 ++++-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  27 +-
 drivers/infiniband/sw/rxe/rxe_mr.c     | 348 +++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_net.c    | 109 +++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c |   2 +
 drivers/infiniband/sw/rxe/rxe_recv.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_req.c    |  88 ++++++-
 drivers/infiniband/sw/rxe/rxe_resp.c   | 172 +++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h  |   8 +-
 12 files changed, 672 insertions(+), 202 deletions(-)


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
prerequisite-patch-id: 41b0e4150794dd914d9fcb4cd106fe4cf4227611
prerequisite-patch-id: 02b08ec037bc35b9c7771640c89c66504cdf38a6
prerequisite-patch-id: dfccc06c16454d7fe8e6fcba064d4e471d314666
prerequisite-patch-id: 7459a6e5cdd46efd53ba27f9b3e9028af6e0863b
prerequisite-patch-id: 36d49f9303f5cb276a5601c1ab568eea6eca7d3a
prerequisite-patch-id: 6359a681e40832694f81ca003c10e5327996bf7d
prerequisite-patch-id: 558175db657f374dbd3e0a57ac4c5fb77a56b6c6
prerequisite-patch-id: d6b811de06c8900be5840dd29715161d26db66cf
-- 
2.39.2

