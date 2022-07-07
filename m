Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD8156A543
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 16:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiGGOV6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiGGOV5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 10:21:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638AB1F2C9
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 07:21:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j22so6454250ejs.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jul 2022 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkVm6Tj567au41lZbQzHU6rDunPtyf325TXT17WpCBw=;
        b=Ke2+5ceqRO+8rY9vXF2EzKFnGZ2MSmhb5570R36Q7imz63bhgZvucZ6jS7KiNzd/Mf
         e3kd9L4dhMDqVeDi2DP6GK1ABwdEHHuE2a6qXLbsrKOBx7+/p8qFTo6L4ySF3fe/kJOD
         W6Jc4G+k0TZ4vUmp6QZAZT8YzMf2VsmEHtAIUcqpBnsQ0o2ST1iN7O2D/lIuhOO/2Jh0
         pxOLQBdn+HQg310MAO1IlGEEW9B5Nbn2ZrmHmDoTaQtUTA2FDSRzLEnZHHqOoKShGOrM
         RIDHwMK1riDeIxZ5Vl14dv2nHePhdSk8WEcVZ710N91H3HaUKEm80osB+wEA56pjzGhx
         t8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkVm6Tj567au41lZbQzHU6rDunPtyf325TXT17WpCBw=;
        b=fHsLym5SsX8uLW+bs/5rI5pPG8cW29sz9k+/uTXMNNwxpUynpuvFFRbHm0bVWG1dDE
         1M73PMdjaov5UkuaHGBMuRiRI5AMqRIGf0MRQGSsh3/mNFsayybZEzLQnGGspoGc8l/w
         bpur3KuygqtIoUJeV891uWC6ZMhoV+TJ9SbqcLS6H9Au74KeDo2se4AGrijumXid7n3g
         yHr+JkW1aSv3KlBeAW1FLg/AJxUbaTKMQNxlJxvqlWA90i4ml49N5NA5yDZ3/MTy/3BW
         W2sosXTVIvekh9kpKFwfRR7h5Vxms10B4my+DZ6yfXkQBdUoTrnRHy92R4cwzoYxSOKB
         lQ4Q==
X-Gm-Message-State: AJIora9ljJufDeHlWerK2bpn+m5AX6+N+9ZsoFCYLHJrE26ILDZtGeu8
        O6Iux0xbwxnAPFercsiL4TJpDxWtanFCtA==
X-Google-Smtp-Source: AGRyM1tYhigiRpJwSHJbGo7Or9jdVhqArLu69WZ2wsdwE8Cu4bWv4WKiDlBQUh0VkosqcIMmWPbd2A==
X-Received: by 2002:a17:907:3da2:b0:718:c108:663c with SMTP id he34-20020a1709073da200b00718c108663cmr44543961ejc.252.1657203714911;
        Thu, 07 Jul 2022 07:21:54 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b0072b13fa5e4csm693807ejo.58.2022.07.07.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:21:54 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 1/5] RDMA/rtrs-srv: Fix modinfo output for stringify
Date:   Thu,  7 Jul 2022 16:21:40 +0200
Message-Id: <20220707142144.459751-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707142144.459751-1-haris.iqbal@ionos.com>
References: <20220707142144.459751-1-haris.iqbal@ionos.com>
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

