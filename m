Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE719394037
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhE1Jlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbhE1Jli (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:41:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16382C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 02:40:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u7so1374360plq.4
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=O6tJu82LqiIvd31XcQdSUYATxFdhZ+bx362Ug0ZSZ9k=;
        b=XWeJSdbyQPzrFDETGcp9lN7Qd6kxhv5D11SdngwtDjabWwgBlMX4/io74OxUF9DFFh
         +4/vC99xj6j88Ro7wDXlXG0c7JuPXhlLMWErHyfShk2wmyAR4sExYvR+ixc54dXLc6l6
         zouUg8ILr/Q79I0gu0NtJbQyIHtyJJQ7B2evM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=O6tJu82LqiIvd31XcQdSUYATxFdhZ+bx362Ug0ZSZ9k=;
        b=PH4+4HFMuDfO5aDq9khx7XIA0WItdQXunJk/B4JlbnJT8WTvgRT9kvI0FAYiv00ukJ
         4Ad6S1peYLF2BgTK+wvjymCGLo4/7tnag+6W+A/QkmJ/Yyo5AAqRP4wKRDZXFUk6iHMz
         hFS293XoDQR0NFGUIqR4DvUa18EA9pjGutxw0U94eCJpUWXNUFKO5SVQQ419SHQp+ptk
         o6zwUCnBdASwcp3AVN9H362f3GtI5SL5iZec7FNQ1Gzd5hNj/7L+nDAlFXi7PvIY793T
         K8QG0viQtryPBYymoCif6DTXf8+o+rV6vsxXkMhi5GVAyEKRMUewqHFmjsGuWe9nxt2X
         Z1LQ==
X-Gm-Message-State: AOAM530+tA7mQ1LGanFlAFiEqXkSLAMFSowYSkjCN6jvJrerVVUEiz4q
        ArL6g0uwCEzhcOAHdzeSi5QWcTcbhj40hGMI2YWk9fCeZes/w/p9hn5e2HDh6jIUMaHrH0DjgJi
        JC7fRXOrTFk8fQQvAXe/VvCzuSWRC0OIr4lGBoih/LAHaNjCz/JJodhjV4uO+HBT4AHQxipABXA
        CZidrxdS2t
X-Google-Smtp-Source: ABdhPJy7jGNfuip8T6tkQ0qPMMoBur+jJj518L5wQiBSVtbVb2uZOrILkUS/a2H4MlnSWTBCBHNRHg==
X-Received: by 2002:a17:902:8645:b029:fd:25ef:3df7 with SMTP id y5-20020a1709028645b02900fd25ef3df7mr7267334plt.48.1622194802964;
        Fri, 28 May 2021 02:40:02 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s140sm3913216pfs.73.2021.05.28.02.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:40:02 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V3 rdma-core 3/5] bnxt_re/lib: add a function to initialize software queue
Date:   Fri, 28 May 2021 15:09:44 +0530
Message-Id: <20210528093946.900940-4-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528093946.900940-1-devesh.sharma@broadcom.com>
References: <20210528093946.900940-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000005e91305c360a953"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000005e91305c360a953
Content-Transfer-Encoding: 8bit

Splitting the shadow software queue initialization into
a separate function. Same is being called for both RQ and
SQ during create QP.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/main.h  |  3 ++
 providers/bnxt_re/verbs.c | 62 ++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
index dc8166f2..94d42958 100644
--- a/providers/bnxt_re/main.h
+++ b/providers/bnxt_re/main.h
@@ -96,7 +96,10 @@ struct bnxt_re_wrid {
 	uint64_t wrid;
 	uint32_t bytes;
 	int next_idx;
+	uint32_t st_slot_idx;
+	uint8_t slots;
 	uint8_t sig;
+
 };
 
 struct bnxt_re_qpcap {
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index 11c01574..8507617b 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -847,6 +847,23 @@ static void bnxt_re_free_queues(struct bnxt_re_qp *qp)
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
 				uint32_t pg_size) {
@@ -857,22 +874,23 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
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
@@ -884,44 +902,42 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
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
+	for (indx = 0 ; indx < nswr; indx++, psns++)
 		swque[indx].psns = psns;
 	if (bnxt_re_is_chip_gen_p5(qp->cctx)) {
-		for (indx = 0 ; indx < que->depth; indx++, psns_ext++) {
+		for (indx = 0 ; indx < nswr; indx++, psns_ext++) {
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


--00000000000005e91305c360a953
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGUzRqSN4oZ+S4MaVZAjE/s2A016
+0mWp74nVF+0uWeOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUyODA5NDAwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBDcp9H0D1PCl4YQuKLkGeiRqyVfpBN/yhSG7jX7cd2+ANP
Kpc3zUSQAzTRL7vQMoF35NzgQm/QBZyj0CFzIzDTzw3m653NQ4yY7zrH4SLxd7sSqnx9LUmpw+Fg
vVpBooIo6TSTwtwSTVVJ/Q/SoPaynRHq8jLg00Cv2/6pl4UfSZRvS7888CeleGpc0YJk3lcRTBlB
fYW+bfQO1M6x9+qpys1rUxx6qm78SEQVahoAfvkYH+JNMakpv2fGY/rrLlv2xOBZ2ZCJrD1LjGTo
Y4P3h4ivJp2ER/wvj7kaeov2f37Qp6+myQKsv4VSR/1hM/xE4ceO5ZnjtiUtdWY/8Igi
--00000000000005e91305c360a953--
