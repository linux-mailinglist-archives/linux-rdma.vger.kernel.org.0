Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5796FED04
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjEKHis (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 03:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbjEKHiq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 03:38:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86AC1BF7
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 00:38:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115e652eeso55914326b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1683790723; x=1686382723;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E3hH59MOIbYxXSSFjigJPmSVSlo7zo/7UuOz9yEwtXA=;
        b=Sx1xEuo8Jmzt5a4PqhCWfCUadzy3qfHentvksO+hB/KeIV65cezO5dtssKJuDfViFq
         bVyGird1QMMIgx9anhc26tH9wHU2ydn7ktlJXSQhldz4dyy8+M2f2EP4WjEMYRAekHvm
         9mnW+xjQNjkyj67rc15p4XYtxiI7F/CPTrFOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683790723; x=1686382723;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3hH59MOIbYxXSSFjigJPmSVSlo7zo/7UuOz9yEwtXA=;
        b=HWzgwCUMOLZaVcDzhQAR15hE92w1s7v0TO+6p6yycOVHwLox4YMuJRK5qCsFofwyBx
         S6WFLx8QTBWqJvo+MBUBILDKmgDV/oGzbn2fp/+d2wDL5w4vEMwZeTMTLWTZDBaD2h+K
         7fsKVEwKrA8KkjdoB0quNo7+nnN+PAOyUIqAU3kc7zIV8zeThbMeB8K1xYo4IwHshodH
         tkYiKr6sCucbefT8mjmkicUJRwx0NsrB+FewF8Ke5qveh6fRFFE50ynvzr67Y4IEVcQE
         B8CMwZG+oTqvjSF7A3ggCrKQAqW6YuF7EIm3T0UeuoJTXrylrR43N4gnrKBdOY8oswJn
         qpXA==
X-Gm-Message-State: AC+VfDxE3OlDmcRQrrWjLtAmzEuBqC04yb5Y7jY0YpU/58Yrn6V+LH+a
        rqtzEWG5lGgM+b2RGnqu1+158Q==
X-Google-Smtp-Source: ACHHUZ5ZXXHKLqjXzQcdJv4x1gYlu8eK0yXjSlyph2muaodszVVFCNPUTkRCm70fYlp6p6d//HSBXg==
X-Received: by 2002:a17:90b:198f:b0:246:5787:6f5d with SMTP id mv15-20020a17090b198f00b0024657876f5dmr28865099pjb.10.1683790723206;
        Thu, 11 May 2023 00:38:43 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n14-20020a65488e000000b00502f4c62fd3sm4174332pgs.33.2023.05.11.00.38.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2023 00:38:42 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 09/10] RDMA/bnxt_re: Return directly without goto jumps
Date:   Thu, 11 May 2023 00:26:24 -0700
Message-Id: <1683789985-22917-10-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1683789985-22917-1-git-send-email-selvin.xavier@broadcom.com>
References: <1683789985-22917-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f4558005fb66135d"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000f4558005fb66135d

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

When there is no cleanup to be done, return directly.
This will help eliminating unnecessary local variables
and goto labels.
This patch fixes such occurrences in qplib_fp.c file.

Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
Fixes: 159fb4ceacd7 ("RDMA/bnxt_re: introduce a function to allocate swq")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 60 ++++++++++++--------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 55f092c..5140129 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -483,7 +483,6 @@ static int bnxt_qplib_map_nq_db(struct bnxt_qplib_nq *nq,  u32 reg_offt)
 	resource_size_t reg_base;
 	struct bnxt_qplib_nq_db *nq_db;
 	struct pci_dev *pdev;
-	int rc = 0;
 
 	pdev = nq->pdev;
 	nq_db = &nq->nq_db;
@@ -493,8 +492,7 @@ static int bnxt_qplib_map_nq_db(struct bnxt_qplib_nq *nq,  u32 reg_offt)
 	if (!nq_db->reg.bar_base) {
 		dev_err(&pdev->dev, "QPLIB: NQ BAR region %d resc start is 0!",
 			nq_db->reg.bar_id);
-		rc = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 
 	reg_base = nq_db->reg.bar_base + reg_offt;
@@ -504,15 +502,14 @@ static int bnxt_qplib_map_nq_db(struct bnxt_qplib_nq *nq,  u32 reg_offt)
 	if (!nq_db->reg.bar_reg) {
 		dev_err(&pdev->dev, "QPLIB: NQ BAR region %d mapping failed",
 			nq_db->reg.bar_id);
-		rc = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 
 	nq_db->dbinfo.db = nq_db->reg.bar_reg;
 	nq_db->dbinfo.hwq = &nq->hwq;
 	nq_db->dbinfo.xid = nq->ring_id;
-fail:
-	return rc;
+
+	return 0;
 }
 
 int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
@@ -626,7 +623,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&srq->hwq, &hwq_attr);
 	if (rc)
-		goto exit;
+		return rc;
 
 	srq->swq = kcalloc(srq->hwq.max_elements, sizeof(*srq->swq),
 			   GFP_KERNEL);
@@ -680,7 +677,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 fail:
 	bnxt_qplib_free_hwq(res, &srq->hwq);
 	kfree(srq->swq);
-exit:
+
 	return rc;
 }
 
@@ -744,15 +741,14 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	struct rq_wqe *srqe;
 	struct sq_sge *hw_sge;
 	u32 sw_prod, sw_cons, count = 0;
-	int i, rc = 0, next;
+	int i, next;
 
 	spin_lock(&srq_hwq->lock);
 	if (srq->start_idx == srq->last_idx) {
 		dev_err(&srq_hwq->pdev->dev,
 			"FP: SRQ (0x%x) is full!\n", srq->id);
-		rc = -EINVAL;
 		spin_unlock(&srq_hwq->lock);
-		goto done;
+		return -EINVAL;
 	}
 	next = srq->start_idx;
 	srq->start_idx = srq->swq[next].next_idx;
@@ -793,22 +789,19 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 		srq->arm_req = false;
 		bnxt_qplib_srq_arm_db(&srq->dbinfo, srq->threshold);
 	}
-done:
-	return rc;
+
+	return 0;
 }
 
 /* QP */
 
 static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 {
-	int rc = 0;
 	int indx;
 
 	que->swq = kcalloc(que->max_wqe, sizeof(*que->swq), GFP_KERNEL);
-	if (!que->swq) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!que->swq)
+		return -ENOMEM;
 
 	que->swq_start = 0;
 	que->swq_last = que->max_wqe - 1;
@@ -816,8 +809,8 @@ static int bnxt_qplib_alloc_init_swq(struct bnxt_qplib_q *que)
 		que->swq[indx].next_idx = indx + 1;
 	que->swq[que->swq_last].next_idx = 0; /* Make it circular */
 	que->swq_last = 0;
-out:
-	return rc;
+
+	return 0;
 }
 
 int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
@@ -851,7 +844,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
-		goto exit;
+		return rc;
 
 	rc = bnxt_qplib_alloc_init_swq(sq);
 	if (rc)
@@ -939,7 +932,6 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	kfree(sq->swq);
 fail_sq:
 	bnxt_qplib_free_hwq(res, &sq->hwq);
-exit:
 	return rc;
 }
 
@@ -1004,7 +996,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
-		goto exit;
+		return rc;
 
 	rc = bnxt_qplib_alloc_init_swq(sq);
 	if (rc)
@@ -1152,7 +1144,6 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	kfree(sq->swq);
 fail_sq:
 	bnxt_qplib_free_hwq(res, &sq->hwq);
-exit:
 	return rc;
 }
 
@@ -2514,7 +2505,6 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_qplib_cq *cq,
 	struct bnxt_qplib_qp *qp;
 	struct bnxt_qplib_q *rq;
 	u32 wr_id_idx;
-	int rc = 0;
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
 				      le64_to_cpu(hwcqe->qp_handle));
@@ -2525,7 +2515,7 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_qplib_cq *cq,
 	if (qp->rq.flushed) {
 		dev_dbg(&cq->hwq.pdev->dev,
 			"%s: QP in Flush QP = %p\n", __func__, qp);
-		goto done;
+		return 0;
 	}
 
 	cqe = *pcqe;
@@ -2581,8 +2571,7 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_qplib_cq *cq,
 		}
 	}
 
-done:
-	return rc;
+	return 0;
 }
 
 static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
@@ -2595,7 +2584,6 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 	struct bnxt_qplib_qp *qp;
 	struct bnxt_qplib_q *rq;
 	u32 wr_id_idx;
-	int rc = 0;
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
 				      le64_to_cpu(hwcqe->qp_handle));
@@ -2606,7 +2594,7 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 	if (qp->rq.flushed) {
 		dev_dbg(&cq->hwq.pdev->dev,
 			"%s: QP in Flush QP = %p\n", __func__, qp);
-		goto done;
+		return 0;
 	}
 	cqe = *pcqe;
 	cqe->opcode = hwcqe->cqe_type_toggle & CQ_BASE_CQE_TYPE_MASK;
@@ -2668,8 +2656,8 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 			bnxt_qplib_add_flush_qp(qp);
 		}
 	}
-done:
-	return rc;
+
+	return 0;
 }
 
 bool bnxt_qplib_is_cq_empty(struct bnxt_qplib_cq *cq)
@@ -2696,7 +2684,6 @@ static int bnxt_qplib_cq_process_res_raweth_qp1(struct bnxt_qplib_cq *cq,
 	struct bnxt_qplib_srq *srq;
 	struct bnxt_qplib_cqe *cqe;
 	u32 wr_id_idx;
-	int rc = 0;
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
 				      le64_to_cpu(hwcqe->qp_handle));
@@ -2707,7 +2694,7 @@ static int bnxt_qplib_cq_process_res_raweth_qp1(struct bnxt_qplib_cq *cq,
 	if (qp->rq.flushed) {
 		dev_dbg(&cq->hwq.pdev->dev,
 			"%s: QP in Flush QP = %p\n", __func__, qp);
-		goto done;
+		return 0;
 	}
 	cqe = *pcqe;
 	cqe->opcode = hwcqe->cqe_type_toggle & CQ_BASE_CQE_TYPE_MASK;
@@ -2776,8 +2763,7 @@ static int bnxt_qplib_cq_process_res_raweth_qp1(struct bnxt_qplib_cq *cq,
 		}
 	}
 
-done:
-	return rc;
+	return 0;
 }
 
 static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
-- 
2.5.5


--000000000000f4558005fb66135d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIL8gz3BzbIln
aLfj+1OIFwX65B/HKvIaQS/T9VeGdLY5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDUxMTA3Mzg0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA3AhE7WeIqFcP2y9bwsy/oMwfieZIA
fXvHDWvXNxnEUseogemA1fy/m5ZmtzKaKxicOC4o2d1UkbjqsXGUy3gnqtU0D6OrQHG0JQYD5SBg
mSr7O6cfqYueVyk5ln31GWgRg2hxT6JqpVaJI8qneTqLwMxxjfTbm1TJ/z3zgUdMmsMFO3Z9saby
/0mkWrCKyC2EpcZHHiLMJOPZlf7iEYZOEWzldWeRi1kJ4kHl1ctc0k9sDTxUvPJMU3jNFx246Ih1
IUEkYY/al27MLkJP74pkGKMQK9NjYV7VMWuCysBXH0XPoo6vS3RCgjnGHsYg1xTMz5OG+2C9IIuV
Tctp/m3U
--000000000000f4558005fb66135d--
