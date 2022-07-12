Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDC571759
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 12:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiGLKbU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 06:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGLKbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 06:31:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDBBACF7B
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b11so13476399eju.10
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkIHH2Ahbid+FYB44EYLzMTMDtkpdayGc6PenViyfVM=;
        b=ivpzQvpxny/dw6aIY3BWhSy0Pjb2v8yPpJUWiXp/tUEO8CgSVhJU1r/wSGxM3OXuJu
         N2DIr/RopwhQvr3uaVXwyXwp3vjEz1SuYuQwf+5iDzEAd4sTdfiK3dEPKbdrago36sZp
         9VlXlQJSWLSBwEUzeCw9wZzzAVjIMIBX4QW0Dhem/OOAKZKt3YJPTACI2uavABkvr4nN
         GGzvUt/SsJUIFnYem+K/SQ/+Wo+HEARPPIbeRI2wgfFaJ0T2PF9vXi7lpRZndaKQCakV
         tT3huOYuU+G8njX12ZK9kQlZogiTNuesAvldVRuwpszVEpQFjPYqZKGidYXWuNHGAWzF
         PLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkIHH2Ahbid+FYB44EYLzMTMDtkpdayGc6PenViyfVM=;
        b=L9Ggs8mkSgysK9H1UCrlckKbAgoa6CO7qYqaVzAFAXG4hwAVrgarTJjObnxKpJTscP
         dAKQaY/WbSMHSUdBlNStYJ9QKxLSTcXfBXd1Khq/Q5XyEaXO68FyDZj1S/riLuWofMqK
         nAvJv04uGV3ZO9z20RW0xk/H26APbNZ3st8BiJ1g5qMl07cBrI3CZCRPYqTKHab23CFA
         Eu6nGr6sdoFPF+dlZ86+4lSFiq6gh4C+HS1J4HhHx4tevt475R/0w5IK6ti0QqJv3mBR
         cQG6QzarkG90h9HlbZkNxbCfh3o78MRdB42E+GeRXRwRssHkHm1Tfz4cG/ZtqL32gVyb
         lfbw==
X-Gm-Message-State: AJIora9U3sSXSR4gjIB2flNTZKNZvGw/V+Q1azLP9qCVLeQIFS+CRjLW
        3opLFJjpGYg84SELYqNwjdCKaRmqX+JYYA==
X-Google-Smtp-Source: AGRyM1saiqwusGhPjaHKsNRFC1p0n7UaucK22iMykVZ+IwB51ds/qOg9FCNKhEflJxmGYeeLfXk7TA==
X-Received: by 2002:a17:907:734a:b0:72b:7c72:e6b3 with SMTP id dq10-20020a170907734a00b0072b7c72e6b3mr3266834ejc.608.1657621876448;
        Tue, 12 Jul 2022 03:31:16 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c452000000b004355d27799fsm5763419edr.96.2022.07.12.03.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:31:15 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH v2 for-next 1/5] RDMA/rtrs-srv: Fix modinfo output for stringify
Date:   Tue, 12 Jul 2022 12:31:09 +0200
Message-Id: <20220712103113.617754-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712103113.617754-1-haris.iqbal@ionos.com>
References: <20220712103113.617754-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

stringify works with define, not enum.

Fixes: 91fddedd439c ("RDMA/rtrs: private headers with rtrs protocol structs and helpers")
Cc: jinpu.wang@ionos.com
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
---
v1 -> v2: No change

 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 9a1e5c2ae55c..ac0df734eba8 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -23,6 +23,17 @@
 #define RTRS_PROTO_VER_STRING __stringify(RTRS_PROTO_VER_MAJOR) "." \
 			       __stringify(RTRS_PROTO_VER_MINOR)
 
+/*
+ * Max IB immediate data size is 2^28 (MAX_IMM_PAYL_BITS)
+ * and the minimum chunk size is 4096 (2^12).
+ * So the maximum sess_queue_depth is 65536 (2^16) in theory.
+ * But mempool_create, create_qp and ib_post_send fail with
+ * "cannot allocate memory" error if sess_queue_depth is too big.
+ * Therefore the pratical max value of sess_queue_depth is
+ * somewhere between 1 and 65534 and it depends on the system.
+ */
+#define MAX_SESS_QUEUE_DEPTH 65535
+
 enum rtrs_imm_const {
 	MAX_IMM_TYPE_BITS = 4,
 	MAX_IMM_TYPE_MASK = ((1 << MAX_IMM_TYPE_BITS) - 1),
@@ -46,16 +57,6 @@ enum {
 
 	MAX_PATHS_NUM = 128,
 
-	/*
-	 * Max IB immediate data size is 2^28 (MAX_IMM_PAYL_BITS)
-	 * and the minimum chunk size is 4096 (2^12).
-	 * So the maximum sess_queue_depth is 65536 (2^16) in theory.
-	 * But mempool_create, create_qp and ib_post_send fail with
-	 * "cannot allocate memory" error if sess_queue_depth is too big.
-	 * Therefore the pratical max value of sess_queue_depth is
-	 * somewhere between 1 and 65534 and it depends on the system.
-	 */
-	MAX_SESS_QUEUE_DEPTH = 65535,
 	MIN_CHUNK_SIZE = 8192,
 
 	RTRS_HB_INTERVAL_MS = 5000,
-- 
2.25.1

