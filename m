Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A644149C5
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhIVMzT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbhIVMzQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:55:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD5C061760
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t18so6679668wrb.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8fqFcUdXM0mw2Oj6jRNvBtR9RrzATj3ICpSKMfB0SU=;
        b=RN85SmZFlOqvGitOlSzORDmWvAEq9F6TIa5H2ET6lC6+n2SbzRiQqxLKOMm3bRg1Sp
         qcmRtd1NogQ+IITlnQJ7rQPRb8da1XQ1sR42ihYA/8kCaZ1kroI6DBbFeul0Jq+A7l6K
         OwyQhoMkFyT56Ivo4fW74EH8pl7lxOZBehCMfdsli6Lsr1EGWfTrl9cdyFEzirNoGruI
         AqhlL8cV+nZaaVlovaMihePZPg70LfjqzD8Orof1AyuYa6M1OxvqDY8+zSKIPzwFBvxX
         zqYxSN4KbHfL5ErF0PcgIDC4qzAKRzwtGTtlNvsu+CW0obnn0dVC2KafZMD/DwDzwAzN
         VdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8fqFcUdXM0mw2Oj6jRNvBtR9RrzATj3ICpSKMfB0SU=;
        b=YGbKKzCRlA23S7G3vUsd6h0ldf45cYylLCLf16bA0fhUBFngYqEmSHaKNG/2XjkQDM
         T+71r9XulRZz0htAicMHrA9ylSvynqoxUk5sY0UsPMaLzYEcOCr8pf/KwOvOTmkfNgSb
         8YvkKpPOavWS0/SJp7TlO3YGRa5+Gel3S1LoOKcav2Kxkn26Ff0bt9E+36kFSoqzFAHT
         Se9x5JLsU4SOYnGstKyVv3DXBv0N0KGDXeASwGGgq+6dFPTOtjPkiz5LRqu2nuaHaj3A
         lXsd1xlTyLGH2PAkE9besb6YzUUl5FcV8kULJD4l4DtJfLbf74TvBGBDXYqglBjkIUUQ
         jz3Q==
X-Gm-Message-State: AOAM532GFpSy/rUSvvF7hmXb3ikcwCrLAGbNV49kBevtqVJn9jmbCzCU
        /RFONOSU/2d1Img48ZaFeUtWUbQTgarDRw==
X-Google-Smtp-Source: ABdhPJwouu+gjQkBSrAS1hSTqqdkqgshPbTW8fvxLX2sQBlMSXHT0zpfJ8fAgiUOHKx1Q0e/f1k8mg==
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr10245973wmc.181.1632315224898;
        Wed, 22 Sep 2021 05:53:44 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:40a5:9868:5a83:f3b9])
        by smtp.gmail.com with ESMTPSA id j20sm2173685wrb.5.2021.09.22.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:53:44 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 5/7] RDMA/rtrs: Introduce destroy_cq helper
Date:   Wed, 22 Sep 2021 14:53:31 +0200
Message-Id: <20210922125333.351454-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922125333.351454-1-haris.iqbal@ionos.com>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The same code snip used twice, to avoid duplicate, replace
it with a destroy_cq helper.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index ac83cd97f838..37952c8e768c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -279,6 +279,17 @@ static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 	return ret;
 }
 
+static void destroy_cq(struct rtrs_con *con)
+{
+	if (con->cq) {
+		if (is_pollqueue(con))
+			ib_free_cq(con->cq);
+		else
+			ib_cq_pool_put(con->cq, con->nr_cqe);
+	}
+	con->cq = NULL;
+}
+
 int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 		       u32 max_send_sge, int cq_vector, int nr_cqe,
 		       u32 max_send_wr, u32 max_recv_wr,
@@ -293,11 +304,7 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
 	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
 			max_send_sge);
 	if (err) {
-		if (is_pollqueue(con))
-			ib_free_cq(con->cq);
-		else
-			ib_cq_pool_put(con->cq, con->nr_cqe);
-		con->cq = NULL;
+		destroy_cq(con);
 		return err;
 	}
 	con->sess = sess;
@@ -312,13 +319,7 @@ void rtrs_cq_qp_destroy(struct rtrs_con *con)
 		rdma_destroy_qp(con->cm_id);
 		con->qp = NULL;
 	}
-	if (con->cq) {
-		if (is_pollqueue(con))
-			ib_free_cq(con->cq);
-		else
-			ib_cq_pool_put(con->cq, con->nr_cqe);
-		con->cq = NULL;
-	}
+	destroy_cq(con);
 }
 EXPORT_SYMBOL_GPL(rtrs_cq_qp_destroy);
 
-- 
2.25.1

