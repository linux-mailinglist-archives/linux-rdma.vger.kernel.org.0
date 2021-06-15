Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623413A88A6
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jun 2021 20:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFOSeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Jun 2021 14:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhFOSeL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Jun 2021 14:34:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FF1C061574
        for <linux-rdma@vger.kernel.org>; Tue, 15 Jun 2021 11:32:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e1so8909084pld.13
        for <linux-rdma@vger.kernel.org>; Tue, 15 Jun 2021 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=7bTY5xpEWMmzT80HcFQslEC986NYpK1Kqp4NGiKWwME=;
        b=EEGbZvpKMIUMjIO1O4G3O+eTYlvr8ILwawB7pErzHqIH/CV5ZAEBC4Z1gjrgdEJzmm
         ngNFhdzHsY+fvhSW+OO5A8Ugvl7uSYsMYEmq4JiZDOQplyQZO5wtCaG7YgijgS3sZvFw
         3vOHhTbEEHUq/h4Tb7yUHEabMgXi56zsiK6BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=7bTY5xpEWMmzT80HcFQslEC986NYpK1Kqp4NGiKWwME=;
        b=I61lb0nivHmVobhpo7C/jwGHcLveiUe2EUXcCqfr3dMDle5QYwJDYQ3T28M9zRFd9P
         TT8MkPOmciUJcv7KcpAvROmxxR6/PcShYc8/+THc5LGtIKYIMdbWZ+HlX0r3fcId6vK5
         vnjnobiLwaHg1vyP2z2sQ+SC8OrWCROeM1lxJ04MNedPB9NUDyNb67Pgr43guRL2ppFe
         ANAD+KArkYUabt1la/t7FsaPbb0DY/wULR+rcyVSzAT4br5GhIovfU88XiE+kg5gZqgA
         pByPAnoHkVXdvmsF29QzwkKtAs58SfMzlL9Wwn6M+HmMGjP/hJOcaqtPtdlk4xzIpA7d
         CusQ==
X-Gm-Message-State: AOAM533LAghL9RrI9ZxltpHTBSqtgAJVAHHev4oKBTutqlb4z7InwESo
        bJQ9pvoVCovSu449d1x9sBD4O20RkcFfTu6alqLGsEtUZ8W8lJAqhsRJuifUwxBlhPlvRZHBG8R
        kE2CCINclzZHO7tSsWhA9kSzCGDBqwtdwWuLLyoMrOwHFPxDmsLAy9iBKXR83qd+54wwD0PiqSl
        NuCUlChA==
X-Google-Smtp-Source: ABdhPJzQluRJpJX19B1Ntw1dSXSDDuipDyRQvZMg5NkHk0akn4jFsW8dRrZj3THES6TywjfxXDGh2w==
X-Received: by 2002:a17:902:f283:b029:10d:e7f3:725 with SMTP id k3-20020a170902f283b029010de7f30725mr3802501plc.45.1623781924830;
        Tue, 15 Jun 2021 11:32:04 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i125sm3803823pfc.7.2021.06.15.11.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:32:04 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V5 rdma-core 3/5] bnxt_re/lib: add a function to initialize software queue
Date:   Wed, 16 Jun 2021 00:01:46 +0530
Message-Id: <20210615183148.1179042-4-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615183148.1179042-1-devesh.sharma@broadcom.com>
References: <20210615183148.1179042-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e21c8605c4d23048"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000e21c8605c4d23048
Content-Transfer-Encoding: 8bit

Splitting the shadow software queue initialization into
a separate function. Same is being called for both RQ and
SQ during create QP.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/main.h  |  2 ++
 providers/bnxt_re/verbs.c | 65 ++++++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
index dc8166f2..71a449e3 100644
--- a/providers/bnxt_re/main.h
+++ b/providers/bnxt_re/main.h
@@ -96,6 +96,8 @@ struct bnxt_re_wrid {
 	uint64_t wrid;
 	uint32_t bytes;
 	int next_idx;
+	uint32_t st_slot_idx;
+	uint8_t slots;
 	uint8_t sig;
 };
 
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index 11c01574..b07628bb 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -847,9 +847,27 @@ static void bnxt_re_free_queues(struct bnxt_re_qp *qp)
 	bnxt_re_free_aligned(qp->jsqq->hwque);
 }
 
+static int bnxt_re_alloc_init_swque(struct bnxt_re_joint_queue *jqq, int nwr)
+{
+	int indx;
+
+	jqq->swque = calloc(nwr, sizeof(struct bnxt_re_wrid));
+	if (!jqq->swque)
+		return -ENOMEM;
+	jqq->start_idx = 0;
+	jqq->last_idx = nwr - 1;
+	for (indx = 0; indx < nwr; indx++)
+		jqq->swque[indx].next_idx = indx + 1;
+	jqq->swque[jqq->last_idx].next_idx = 0;
+	jqq->last_idx = 0;
+
+	return 0;
+}
+
 static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 				struct ibv_qp_init_attr *attr,
-				uint32_t pg_size) {
+				uint32_t pg_size)
+{
 	struct bnxt_re_psns_ext *psns_ext;
 	struct bnxt_re_wrid *swque;
 	struct bnxt_re_queue *que;
@@ -857,22 +875,23 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 	uint32_t psn_depth;
 	uint32_t psn_size;
 	int ret, indx;
+	uint32_t nswr;
 
 	que = qp->jsqq->hwque;
 	que->stride = bnxt_re_get_sqe_sz();
 	/* 8916 adjustment */
-	que->depth = roundup_pow_of_two(attr->cap.max_send_wr + 1 +
-					BNXT_RE_FULL_FLAG_DELTA);
-	que->diff = que->depth - attr->cap.max_send_wr;
+	nswr  = roundup_pow_of_two(attr->cap.max_send_wr + 1 +
+				   BNXT_RE_FULL_FLAG_DELTA);
+	que->diff = nswr - attr->cap.max_send_wr;
 
 	/* psn_depth extra entries of size que->stride */
 	psn_size = bnxt_re_is_chip_gen_p5(qp->cctx) ?
 					sizeof(struct bnxt_re_psns_ext) :
 					sizeof(struct bnxt_re_psns);
-	psn_depth = (que->depth * psn_size) / que->stride;
-	if ((que->depth * psn_size) % que->stride)
+	psn_depth = (nswr * psn_size) / que->stride;
+	if ((nswr * psn_size) % que->stride)
 		psn_depth++;
-	que->depth += psn_depth;
+	que->depth = nswr + psn_depth;
 	/* PSN-search memory is allocated without checking for
 	 * QP-Type. Kenrel driver do not map this memory if it
 	 * is UD-qp. UD-qp use this memory to maintain WC-opcode.
@@ -884,44 +903,42 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 	/* exclude psns depth*/
 	que->depth -= psn_depth;
 	/* start of spsn space sizeof(struct bnxt_re_psns) each. */
-	psns = (que->va + que->stride * que->depth);
+	psns = (que->va + que->stride * nswr);
 	psns_ext = (struct bnxt_re_psns_ext *)psns;
-	swque = calloc(que->depth, sizeof(struct bnxt_re_wrid));
-	if (!swque) {
+
+	ret = bnxt_re_alloc_init_swque(qp->jsqq, nswr);
+	if (ret) {
 		ret = -ENOMEM;
 		goto fail;
 	}
 
-	for (indx = 0 ; indx < que->depth; indx++, psns++)
+	swque = qp->jsqq->swque;
+	for (indx = 0; indx < nswr; indx++, psns++)
 		swque[indx].psns = psns;
 	if (bnxt_re_is_chip_gen_p5(qp->cctx)) {
-		for (indx = 0 ; indx < que->depth; indx++, psns_ext++) {
+		for (indx = 0; indx < nswr; indx++, psns_ext++) {
 			swque[indx].psns_ext = psns_ext;
 			swque[indx].psns = (struct bnxt_re_psns *)psns_ext;
 		}
 	}
-	qp->jsqq->swque = swque;
-
-	qp->cap.max_swr = que->depth;
+	qp->cap.max_swr = nswr;
 	pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
 
 	if (qp->jrqq) {
 		que = qp->jrqq->hwque;
 		que->stride = bnxt_re_get_rqe_sz();
-		que->depth = roundup_pow_of_two(attr->cap.max_recv_wr + 1);
-		que->diff = que->depth - attr->cap.max_recv_wr;
+		nswr = roundup_pow_of_two(attr->cap.max_recv_wr + 1);
+		que->depth = nswr;
+		que->diff = nswr - attr->cap.max_recv_wr;
 		ret = bnxt_re_alloc_aligned(que, pg_size);
 		if (ret)
 			goto fail;
-		pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
 		/* For RQ only bnxt_re_wri.wrid is used. */
-		qp->jrqq->swque = calloc(que->depth,
-					 sizeof(struct bnxt_re_wrid));
-		if (!qp->jrqq->swque) {
-			ret = -ENOMEM;
+		ret = bnxt_re_alloc_init_swque(qp->jrqq, nswr);
+		if (ret)
 			goto fail;
-		}
-		qp->cap.max_rwr = que->depth;
+		pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
+		qp->cap.max_rwr = nswr;
 	}
 
 	return 0;
-- 
2.25.1


--000000000000e21c8605c4d23048
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIH34H8JscSnYjB6K70pBp0TD21Nq
XEAu6MrQpgVPm30rMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYxNTE4MzIwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCEWRIVCV0o4MlLjxiPqXKYIE/+sW/4NX2JR4rDIFtJneZw
OTNSoIAfukZIKGhenamaUwkA5h3GMhyS1zCYA0Xk4+2l0bt3fH4ytD1GwsIYYSzCVufAfw87Q38O
uUnvqUGojRDpeQVBnME26lTSAFSIh+XaGSIwOa4QvmH9e5Yn08OphU/t/fvk3UdP8YYjroosLo74
Xm8SaNM2FVhYbfdesUNYOeqdJk45aYNS82L/eakHfxSimr7mV7wBiH6HOBvhnnxXmA4AUN0v6e9O
+EfIuCetNaHrqfQzBDpIIFten5uTWkLH95trVaVQI+zfFk5eNobtBrqPvQ+xe3FN+5sw
--000000000000e21c8605c4d23048--
