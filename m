Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339427639EA
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjGZPDW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjGZPDR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 11:03:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548511B
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 08:03:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66c729f5618so6373488b3a.1
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690383785; x=1690988585;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z+RPQP/qVbJ5oRcoVfRB2hvpzaJ21+HlaV2KcJo9QwA=;
        b=g/f9CRhaO6c/pkcCpzjNOxeoUJEVawxtvhHAiFbTpraqvFO2WObrWXBhtxWxobnX5C
         y6qaZSr9hU7LDVxbC7NUw+RKYjHtowTOSWqbkiiOSkQ8jBF1e1VXBEhokmf3FAl115cS
         t4HmTV7Kp5MnFy7moVEMSmLjyQChM3lXgXqKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383785; x=1690988585;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+RPQP/qVbJ5oRcoVfRB2hvpzaJ21+HlaV2KcJo9QwA=;
        b=FSgf2CmTBBzA1VThf8XyEpd+yCdUTHx9G1zPPVaWOieBd72NHn7AcJB5Zj7izOvQre
         U49TGJu7R41X4OVhOl8TaLM9Gt06T8RKIdKT3LhKt2nrgb8ZYjy+3LTWI8QN0lZWPy85
         RazC9u3W6XpHaVdUpffAucqQJgzUVrhRTZkmn4cpmNV0uzjFPGaz3bZstajTfyWFbT5n
         jzDwIyAbQXv0Cb4PEWCxyL+mntfcJGpMLQZ6yemlG9kfUkiOv6vA9LYzRbs1PsMOMl5k
         X/2pgy+nm6hgFUf34SO+Oky+p44dEcpcCYS5eQbD8d9TFoX/rxVuAuzmEcUunD9/Ejrl
         Nlvw==
X-Gm-Message-State: ABy/qLbhJ7hICNHmklEy9TJyE6o+4Ms3+xhXdaC1ypQ2NhBXajSOHjhR
        mPCj4jAXCiudrgZpFPUZhznKhA==
X-Google-Smtp-Source: APBJJlGDbSm0ZgQMSOI1rBDagvy0Hp+cvlRqjVXhE6kvmErtEhls7dACoYgX0lrZC7v27e6nO2ZVpw==
X-Received: by 2002:a05:6a21:78a8:b0:138:1c5b:24c3 with SMTP id bf40-20020a056a2178a800b001381c5b24c3mr3147912pzc.49.1690383785030;
        Wed, 26 Jul 2023 08:03:05 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y4-20020a63ad44000000b0055fd10306a2sm12772846pgo.75.2023.07.26.08.03.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jul 2023 08:03:04 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/4] bnxt_re: Reorganize the resource stats
Date:   Wed, 26 Jul 2023 07:51:18 -0700
Message-Id: <1690383081-15033-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000010ee370601652505"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000010ee370601652505

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Move the resource stats to a separate stats structure.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  7 -----
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 17 ++++++------
 drivers/infiniband/hw/bnxt_re/hw_counters.h | 11 ++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 40 ++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/main.c        | 14 +++++-----
 5 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 2175103..03a1325 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -175,16 +175,9 @@ struct bnxt_re_dev {
 	struct bnxt_qplib_res		qplib_res;
 	struct bnxt_qplib_dpi		dpi_privileged;
 
-	atomic_t			qp_count;
 	struct mutex			qp_lock;	/* protect qp list */
 	struct list_head		qp_list;
 
-	atomic_t			cq_count;
-	atomic_t			srq_count;
-	atomic_t			mr_count;
-	atomic_t			mw_count;
-	atomic_t			ah_count;
-	atomic_t			pd_count;
 	/* Max of 2 lossless traffic class supported per port */
 	u16				cosq[2];
 
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 825d512..8310e9a 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -254,21 +254,22 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			    u32 port, int index)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct ctx_hw_stats *hw_stats = NULL;
+	struct bnxt_re_res_cntrs *res_s = &rdev->stats.res;
 	struct bnxt_qplib_roce_stats *err_s = NULL;
+	struct ctx_hw_stats *hw_stats = NULL;
 	int rc  = 0;
 
 	hw_stats = rdev->qplib_ctx.stats.dma;
 	if (!port || !stats)
 		return -EINVAL;
 
-	stats->value[BNXT_RE_ACTIVE_QP] = atomic_read(&rdev->qp_count);
-	stats->value[BNXT_RE_ACTIVE_SRQ] = atomic_read(&rdev->srq_count);
-	stats->value[BNXT_RE_ACTIVE_CQ] = atomic_read(&rdev->cq_count);
-	stats->value[BNXT_RE_ACTIVE_MR] = atomic_read(&rdev->mr_count);
-	stats->value[BNXT_RE_ACTIVE_MW] = atomic_read(&rdev->mw_count);
-	stats->value[BNXT_RE_ACTIVE_PD] = atomic_read(&rdev->pd_count);
-	stats->value[BNXT_RE_ACTIVE_AH] = atomic_read(&rdev->ah_count);
+	stats->value[BNXT_RE_ACTIVE_QP] = atomic_read(&res_s->qp_count);
+	stats->value[BNXT_RE_ACTIVE_SRQ] = atomic_read(&res_s->srq_count);
+	stats->value[BNXT_RE_ACTIVE_CQ] = atomic_read(&res_s->cq_count);
+	stats->value[BNXT_RE_ACTIVE_MR] = atomic_read(&res_s->mr_count);
+	stats->value[BNXT_RE_ACTIVE_MW] = atomic_read(&res_s->mw_count);
+	stats->value[BNXT_RE_ACTIVE_PD] = atomic_read(&res_s->pd_count);
+	stats->value[BNXT_RE_ACTIVE_AH] = atomic_read(&res_s->ah_count);
 
 	if (hw_stats) {
 		stats->value[BNXT_RE_RECOVERABLE_ERRORS] =
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index 7943b2c..4aa6e31 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -113,6 +113,16 @@ enum bnxt_re_hw_stats {
 
 #define BNXT_RE_NUM_STD_COUNTERS (BNXT_RE_OUT_OF_SEQ_ERR + 1)
 
+struct bnxt_re_res_cntrs {
+	atomic_t qp_count;
+	atomic_t cq_count;
+	atomic_t srq_count;
+	atomic_t mr_count;
+	atomic_t mw_count;
+	atomic_t ah_count;
+	atomic_t pd_count;
+};
+
 struct bnxt_re_rstat {
 	struct bnxt_qplib_roce_stats    errs;
 	struct bnxt_qplib_ext_stat      ext_stat;
@@ -120,6 +130,7 @@ struct bnxt_re_rstat {
 
 struct bnxt_re_stats {
 	struct bnxt_re_rstat            rstat;
+	struct bnxt_re_res_cntrs        res;
 };
 
 struct rdma_hw_stats *bnxt_re_ib_alloc_hw_port_stats(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ec4d163..b28c869 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -602,7 +602,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 		if (!bnxt_qplib_dealloc_pd(&rdev->qplib_res,
 					   &rdev->qplib_res.pd_tbl,
 					   &pd->qplib_pd))
-			atomic_dec(&rdev->pd_count);
+			atomic_dec(&rdev->stats.res.pd_count);
 	}
 	return 0;
 }
@@ -665,7 +665,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		if (bnxt_re_create_fence_mr(pd))
 			ibdev_warn(&rdev->ibdev,
 				   "Failed to create Fence-MR\n");
-	atomic_inc(&rdev->pd_count);
+	atomic_inc(&rdev->stats.res.pd_count);
 
 	return 0;
 dbfail:
@@ -691,7 +691,7 @@ int bnxt_re_destroy_ah(struct ib_ah *ib_ah, u32 flags)
 		else
 			goto fail;
 	}
-	atomic_dec(&rdev->ah_count);
+	atomic_dec(&rdev->stats.res.ah_count);
 fail:
 	return rc;
 }
@@ -777,7 +777,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 		wmb(); /* make sure cache is updated. */
 		spin_unlock_irqrestore(&uctx->sh_lock, flag);
 	}
-	atomic_inc(&rdev->ah_count);
+	atomic_inc(&rdev->stats.res.ah_count);
 
 	return 0;
 }
@@ -838,7 +838,7 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	bnxt_qplib_destroy_ah(&rdev->qplib_res,
 			      &gsi_sah->qplib_ah,
 			      true);
-	atomic_dec(&rdev->ah_count);
+	atomic_dec(&rdev->stats.res.ah_count);
 	bnxt_qplib_clean_qp(&qp->qplib_qp);
 
 	ibdev_dbg(&rdev->ibdev, "Destroy the shadow QP\n");
@@ -853,7 +853,7 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	mutex_lock(&rdev->qp_lock);
 	list_del(&gsi_sqp->list);
 	mutex_unlock(&rdev->qp_lock);
-	atomic_dec(&rdev->qp_count);
+	atomic_dec(&rdev->stats.res.qp_count);
 
 	kfree(rdev->gsi_ctx.sqp_tbl);
 	kfree(gsi_sah);
@@ -900,7 +900,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	mutex_lock(&rdev->qp_lock);
 	list_del(&qp->list);
 	mutex_unlock(&rdev->qp_lock);
-	atomic_dec(&rdev->qp_count);
+	atomic_dec(&rdev->stats.res.qp_count);
 
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
@@ -1085,7 +1085,7 @@ static struct bnxt_re_ah *bnxt_re_create_shadow_qp_ah
 			  "Failed to allocate HW AH for Shadow QP");
 		goto fail;
 	}
-	atomic_inc(&rdev->ah_count);
+	atomic_inc(&rdev->stats.res.ah_count);
 
 	return ah;
 
@@ -1153,7 +1153,7 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 	INIT_LIST_HEAD(&qp->list);
 	mutex_lock(&rdev->qp_lock);
 	list_add_tail(&qp->list, &rdev->qp_list);
-	atomic_inc(&rdev->qp_count);
+	atomic_inc(&rdev->stats.res.qp_count);
 	mutex_unlock(&rdev->qp_lock);
 	return qp;
 fail:
@@ -1535,7 +1535,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	mutex_lock(&rdev->qp_lock);
 	list_add_tail(&qp->list, &rdev->qp_list);
 	mutex_unlock(&rdev->qp_lock);
-	atomic_inc(&rdev->qp_count);
+	atomic_inc(&rdev->stats.res.qp_count);
 
 	return 0;
 qp_destroy:
@@ -1638,7 +1638,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 		nq = qplib_srq->cq->nq;
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
 	ib_umem_release(srq->umem);
-	atomic_dec(&rdev->srq_count);
+	atomic_dec(&rdev->stats.res.srq_count);
 	if (nq)
 		nq->budget--;
 	return 0;
@@ -1750,7 +1750,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	}
 	if (nq)
 		nq->budget++;
-	atomic_inc(&rdev->srq_count);
+	atomic_inc(&rdev->stats.res.srq_count);
 	spin_lock_init(&srq->lock);
 
 	return 0;
@@ -2876,7 +2876,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 	ib_umem_release(cq->umem);
 
-	atomic_dec(&rdev->cq_count);
+	atomic_dec(&rdev->stats.res.cq_count);
 	nq->budget--;
 	kfree(cq->cql);
 	return 0;
@@ -2960,7 +2960,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->cq_period = cq->qplib_cq.period;
 	nq->budget++;
 
-	atomic_inc(&rdev->cq_count);
+	atomic_inc(&rdev->stats.res.cq_count);
 	spin_lock_init(&cq->cq_lock);
 
 	if (udata) {
@@ -3785,7 +3785,7 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 	if (mr_access_flags & (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |
 			       IB_ACCESS_REMOTE_ATOMIC))
 		mr->ib_mr.rkey = mr->ib_mr.lkey;
-	atomic_inc(&rdev->mr_count);
+	atomic_inc(&rdev->stats.res.mr_count);
 
 	return &mr->ib_mr;
 
@@ -3818,7 +3818,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	ib_umem_release(mr->ib_umem);
 
 	kfree(mr);
-	atomic_dec(&rdev->mr_count);
+	atomic_dec(&rdev->stats.res.mr_count);
 	return rc;
 }
 
@@ -3886,7 +3886,7 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
 		goto fail_mr;
 	}
 
-	atomic_inc(&rdev->mr_count);
+	atomic_inc(&rdev->stats.res.mr_count);
 	return &mr->ib_mr;
 
 fail_mr:
@@ -3922,7 +3922,7 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 	}
 	mw->ib_mw.rkey = mw->qplib_mw.rkey;
 
-	atomic_inc(&rdev->mw_count);
+	atomic_inc(&rdev->stats.res.mw_count);
 	return &mw->ib_mw;
 
 fail:
@@ -3943,7 +3943,7 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
 	}
 
 	kfree(mw);
-	atomic_dec(&rdev->mw_count);
+	atomic_dec(&rdev->stats.res.mw_count);
 	return rc;
 }
 
@@ -4010,7 +4010,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 
 	mr->ib_mr.lkey = mr->qplib_mr.lkey;
 	mr->ib_mr.rkey = mr->qplib_mr.lkey;
-	atomic_inc(&rdev->mr_count);
+	atomic_inc(&rdev->stats.res.mr_count);
 
 	return &mr->ib_mr;
 free_umem:
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 6469811..91efa04 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -918,13 +918,13 @@ static struct bnxt_re_dev *bnxt_re_dev_add(struct bnxt_aux_priv *aux_priv,
 	rdev->id = rdev->en_dev->pdev->devfn;
 	INIT_LIST_HEAD(&rdev->qp_list);
 	mutex_init(&rdev->qp_lock);
-	atomic_set(&rdev->qp_count, 0);
-	atomic_set(&rdev->cq_count, 0);
-	atomic_set(&rdev->srq_count, 0);
-	atomic_set(&rdev->mr_count, 0);
-	atomic_set(&rdev->mw_count, 0);
-	atomic_set(&rdev->ah_count, 0);
-	atomic_set(&rdev->pd_count, 0);
+	atomic_set(&rdev->stats.res.qp_count, 0);
+	atomic_set(&rdev->stats.res.cq_count, 0);
+	atomic_set(&rdev->stats.res.srq_count, 0);
+	atomic_set(&rdev->stats.res.mr_count, 0);
+	atomic_set(&rdev->stats.res.mw_count, 0);
+	atomic_set(&rdev->stats.res.ah_count, 0);
+	atomic_set(&rdev->stats.res.pd_count, 0);
 	rdev->cosq[0] = 0xFFFF;
 	rdev->cosq[1] = 0xFFFF;
 
-- 
2.5.5


--00000000000010ee370601652505
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILr+dASmde0i
FzVHYktTnvL5T0atqeRb5/58xC3hfv0OMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDcyNjE1MDMwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDJoWr16K6ZpRsb3/XVRDJm0GDJVi+m
z8ZhkKApwhYKmLEnf9BTMwKfWrrgTodg1dwKSqxvUjplAcLOOQ5iBnnELR/Qj7owA+tgRZnv5vOh
bYxEUoPbSW/hljWXyM+QbKWb9stUHBEU3L6873gFm+n/fZ+F066KfLvIZxUNiZbRj+7bavQGFJIa
KYYmTCW+WG9q1JhGO8CSHkXBd0DQVyCj2qxl1pTOBZ9mtGOj7pRk18cGcT185FnzPJuLnzoCgFsh
7+oWHTQCFrXELbX5AMR4ZsXOcQVET6LlUnDqwZKquDhFHJjw8vtMfiX9EvdO41T7AWC3zbEsmlD6
RopHFoqP
--00000000000010ee370601652505--
