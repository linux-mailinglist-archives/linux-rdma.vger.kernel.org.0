Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3AD28B5EC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbgJLNSa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNSa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:30 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F64C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so16922798edk.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N98xLNwIrHPVMGn4TFLYhEJS7NXRDPuaQTkSD4Kdyco=;
        b=IjP2zpHQWmvdGFbagsbBGR15q910enEHydFvMuGrm5M6BOVTkgcpDvliviHQxe6HTP
         LbpCc+lYjJJiMyiobS3N55fz/4O8RpVaJ9drgN50Wa8aHqhF+5+CefTC41cELecvnQag
         uNz6vtLGFGbI2gvL+rUm4w/yAoVPqMMORBVvE8LSEfsV+9FQwjI1Cp7uCswvB7Brmwb1
         b1RE8zmUbjyQqbPcH9N+UmXsJCTjt22iNxSPPfVUk0iTH6N6RWwXJ7ZQmSD0NcnrXygc
         eiLZAnkGWQfScoBejeUjQGDHs1h1BJl/Mn+0G60x9lPanMg04Rl7TxPjGSuwB8v7I7rS
         JX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N98xLNwIrHPVMGn4TFLYhEJS7NXRDPuaQTkSD4Kdyco=;
        b=E/WMByrGA+FobO3ZdRXC5ZRCN/nHdOk3I0forYaxXLVlNDXwodqZjw99K29ILaLOgE
         7ZTto4wzBK+X8KKWS8Zk/GxWoTJB+xAnYQTAVrZCZ+AvWoLio/091g4KJvW1isSnrNbG
         5m8PLAKX1ypZ/gGw2rr3fecIaXFPkUmCcDqsoUDQXrHzMylWMTtTENqN2dElFbc3v69P
         m+gIf6Q6d7fgpsTFHP7quoO7Z+b2Ocm5f01e0o8/0PyZzV1dkJUU8B9LDZMvUSBUcQNn
         hE47o2E2ZiptRaFZXG11142vPnP3InfbwnbeBpXMRh57+96CIUCjaAJsA2wEY8rOj+3n
         q40A==
X-Gm-Message-State: AOAM533OA7cP5S7WyDR4+vdgH6fBgJOmjJfXwIBMKu+iCniTBKVjkAaU
        nDWpci+SCXZ81dEdTpXJ0nEhJJUiOMd3Xg==
X-Google-Smtp-Source: ABdhPJwAutl8VLiciwpVFHGTmuP6FTWxQ16FRgROlaW0Iq7msdF3T/Ao/HaEa8+95FbV0qTFlyn/6w==
X-Received: by 2002:aa7:d143:: with SMTP id r3mr12518069edo.103.1602508707931;
        Mon, 12 Oct 2020 06:18:27 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:27 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 12/13] RDMA/rtrs: introduce rtrs_post_send
Date:   Mon, 12 Oct 2020 15:18:13 +0200
Message-Id: <20201012131814.121096-13-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since the three functions share the similar logic, let's introduce one
common function for it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 52 +++++++++++-------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 48f648f573b6..2e3a849e0a77 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -104,6 +104,22 @@ int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe)
 }
 EXPORT_SYMBOL_GPL(rtrs_post_recv_empty);
 
+static int rtrs_post_send(struct ib_qp *qp, struct ib_send_wr *head,
+			     struct ib_send_wr *wr)
+{
+	if (head) {
+		struct ib_send_wr *tail = head;
+
+		while (tail->next)
+			tail = tail->next;
+		tail->next = wr;
+	} else {
+		head = wr;
+	}
+
+	return ib_post_send(qp, head, NULL);
+}
+
 int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		       struct ib_send_wr *head)
 {
@@ -126,17 +142,7 @@ int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
 		.send_flags = IB_SEND_SIGNALED,
 	};
 
-	if (head) {
-		struct ib_send_wr *tail = head;
-
-		while (tail->next)
-			tail = tail->next;
-		tail->next = &wr;
-	} else {
-		head = &wr;
-	}
-
-	return ib_post_send(con->qp, head, NULL);
+	return rtrs_post_send(con->qp, head, &wr);
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_post_send);
 
@@ -168,17 +174,7 @@ int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
 		if (WARN_ON(sge[i].length == 0))
 			return -EINVAL;
 
-	if (head) {
-		struct ib_send_wr *tail = head;
-
-		while (tail->next)
-			tail = tail->next;
-		tail->next = &wr.wr;
-	} else {
-		head = &wr.wr;
-	}
-
-	return ib_post_send(con->qp, head, NULL);
+	return rtrs_post_send(con->qp, head, &wr.wr);
 }
 EXPORT_SYMBOL_GPL(rtrs_iu_post_rdma_write_imm);
 
@@ -195,17 +191,7 @@ int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
 		.ex.imm_data	= cpu_to_be32(imm_data),
 	};
 
-	if (head) {
-		struct ib_send_wr *tail = head;
-
-		while (tail->next)
-			tail = tail->next;
-		tail->next = &wr;
-	} else {
-		head = &wr;
-	}
-
-	return ib_post_send(con->qp, head, NULL);
+	return rtrs_post_send(con->qp, head, &wr);
 }
 EXPORT_SYMBOL_GPL(rtrs_post_rdma_write_imm_empty);
 
-- 
2.25.1

