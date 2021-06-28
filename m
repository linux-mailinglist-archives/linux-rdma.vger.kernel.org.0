Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960B73B6AC1
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbhF1WE5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbhF1WEB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 18:04:01 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474BDC0617AE
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:33 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id v11-20020a4a8c4b0000b029024be8350c45so5134418ooj.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kneSU+FCYQQzfxYvj6GYx0NWFJrVtEMFTDXc/C6eRjk=;
        b=A/jafmVrT4/14UuJOxu3gEPLRQGoCqaptL+SJOSsvUzYKsottbvjL1PhPsk3xtOfI2
         2TB9SUtD0fVqL9wGqvs3y2U2fL5rAe3T9GTEoEjsow2r2grqwV0ydWkyiIdmXB4v3w+3
         7Gc1TctYAWS1H0ahQjU03cFNoxOlkAXzka+XqPSiEnOUU8G0kXgKmaqsoXrYPwQ87AGg
         sqnoK0tC5n/23kAmIfmxpaxcUlKXJveTtl5LWQPwv5HFKvLxj9Im5sQEWpaSEstxFQFu
         FFSqgi/gHbfJTLafMUjBtpPsaq1CvCeRThlnNmoSW/IKF8akUNDpX2Z/FM72nDCswtxt
         CqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kneSU+FCYQQzfxYvj6GYx0NWFJrVtEMFTDXc/C6eRjk=;
        b=PnIXEliPS4sj1qPUaefQXIC74drX+wu86zd/buu/iQWtexDhNN4Y1JZQRqujalMalR
         AtMNfH6CVkoXIa3r4fJi2lYQzOlgB/3R14kCJIcYEf0OGtcoCUKajI81RgJ4Bu3n5bh2
         4b+p4aKPUSRncwzh94lNuvBwR/Q0KS8rULP91Fhbx0Jv6io1kScfDo2G82mNJxctdZuO
         Xsd0FkHr0mBqlvFw6H/b0TQmAUx9XGnUFid4SCCnCMxVdvSMRhf8ocCPiR7tmpaT5xYS
         MS+L4vPw/Ho565tZD/fy60qqIkCK8EtnvgoPV4+wv+23/BFZiB7TvAI+vc+4TMo20GJb
         7iRw==
X-Gm-Message-State: AOAM5306eRU2r45u0avnTfYXufbN0blhqZ7v0H/DCCMopPRQDwudPFRA
        cUxNNBzOp6e3HLWesy+5ZoM=
X-Google-Smtp-Source: ABdhPJxTq0v/E9Ru3J1g0oi4Co7LBzsXkb/gNShqpMtkt4hcUan4oaTDQGGvPb75RjRL8BdCqtCVMA==
X-Received: by 2002:a05:6820:168:: with SMTP id k8mr1261735ood.76.1624917693039;
        Mon, 28 Jun 2021 15:01:33 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id a76sm1390985oii.26.2021.06.28.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:01:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 1/5] RDMA/rxe: Change user/kernel API to allow indexing AH
Date:   Mon, 28 Jun 2021 17:00:40 -0500
Message-Id: <20210628220043.9851-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210628220043.9851-1-rpearsonhpe@gmail.com>
References: <20210628220043.9851-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make changes to rdma_user_rxe.h to allow indexing AH objects, passing
the index in UD send WRs to the driver and returning the index to the rxe
provider. This change will allow removing handling of the AV in the user
space provider. This change is backwards compatible with the current API
so new or old providers and drivers can work together.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index e283c2220aba..e544832ed073 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -98,6 +98,8 @@ struct rxe_send_wr {
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
+			__u16	reserved;
+			__u32	ah_num;
 		} ud;
 		struct {
 			__aligned_u64	addr;
@@ -148,7 +150,12 @@ struct rxe_dma_info {
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
+	union {
+		struct rxe_av av;
+		struct {
+			__u32		reserved[0];
+		} ex;
+	};
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
@@ -168,6 +175,11 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+struct rxe_create_ah_resp {
+	__u32 ah_num;
+	__u32 reserved;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.30.2

