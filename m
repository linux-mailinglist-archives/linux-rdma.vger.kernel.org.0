Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8548382D86
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhEQNhC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhEQNhB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 09:37:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646EEC061573
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 06:35:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q2so4926305pfh.13
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=yoEZnSL7onC6LOX2IBkeKuGuzdMQip9XAvavJHHOJnQ=;
        b=CMkiukyRJHIYC6lPn9EEiGkI/oreSi8Q5/RicXApx+5aiOhsanUY1E9hEoAbpTHihS
         CGzEaQP97qmq5+B2Us2vfNDBw0JJ0x1iv913NZvstTdX+8J/NqlRYWs3/TUGFsiti5AR
         JVUbTFbbExNqjdaias/G3xB8ufw/nrr2j86ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=yoEZnSL7onC6LOX2IBkeKuGuzdMQip9XAvavJHHOJnQ=;
        b=o7R+CyyjbAUOPyt0V+z0zX3rOD6CJ71dwSOkszoe9eYFtKDxUkzDrKFfpx5GHHmucC
         5ee4A/eUrI8IIuKIakjj7Nd18UeMrvi2WFqYksMMK7fUJvkteTwNwOWPdIm7+oCWAilL
         sZw3Ke4J1+Vki7fJ/mro2tWzJ6l6DmMH5nkRAzdy9Rn6giOWBGkjVfJRQ80nLJStwqq9
         QhqvGEGy+IY9HyWgGfcLU63/+voy+d3J4jew1V/p8/C4MbCHm1gla4ICtN3PI1pcIta2
         yrYJL7ninjtSUILpdx6gfwdPiJY2714E30DgiyJYprCa9s2C1IThrPW39qOGthlIr4/8
         4yRg==
X-Gm-Message-State: AOAM530DIsj8dUw79KunNITpPkJskULL9jw2GHPrHwYNhfTROSwvC+C0
        ZNQGIQdLQmHUgs0FFjlvGTrHvFsdZSYZD6PG//aiv+4EvG5j0k9UifDvq9N/kX3aQkm41WCalPU
        GXEdHwBlHLpqCFw0Rr4HPBfYcLe/rVsvkWkMwDYojzNcxi8GCpPxbWbJkZXXLqOCXJgmTTZuZpE
        Y3Xm4Ne5ye
X-Google-Smtp-Source: ABdhPJzKt4KVxajsTgJ46vdX9oqsuyJmsjyh9+coA5+VAo2ZN37ELv3Zu5FadslDq2wFEyC0LwRbcw==
X-Received: by 2002:a05:6a00:2163:b029:216:deaa:e386 with SMTP id r3-20020a056a002163b0290216deaae386mr59981770pff.72.1621258544212;
        Mon, 17 May 2021 06:35:44 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b6sm10953618pjk.13.2021.05.17.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:35:43 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V2 INTERNAL 1/4] bnxt_re/lib: Read wqe mode from the driver
Date:   Mon, 17 May 2021 19:05:29 +0530
Message-Id: <20210517133532.774998-2-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517133532.774998-1-devesh.sharma@broadcom.com>
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a9001805c286ab72"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000a9001805c286ab72
Content-Transfer-Encoding: 8bit

During bnxt_re device context creation, read the
wqe mode and store it in context structure and
in the QP context structure. wqe mode would be
required to change between fixed size wqe and
non-fixed sized wqe modes of SQ/RQ in gen-p5
or newer devices.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 kernel-headers/rdma/bnxt_re-abi.h | 5 ++++-
 providers/bnxt_re/bnxt_re-abi.h   | 5 +++++
 providers/bnxt_re/main.c          | 4 ++++
 providers/bnxt_re/main.h          | 2 ++
 providers/bnxt_re/verbs.c         | 1 +
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel-headers/rdma/bnxt_re-abi.h b/kernel-headers/rdma/bnxt_re-abi.h
index dc52e3cf..0234763e 100644
--- a/kernel-headers/rdma/bnxt_re-abi.h
+++ b/kernel-headers/rdma/bnxt_re-abi.h
@@ -49,7 +49,8 @@
 #define BNXT_RE_CHIP_ID0_CHIP_MET_SFT		0x18
 
 enum {
-	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL
+	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL,
+	BNXT_RE_UCNTX_CMASK_HAVE_MODE = 0x02ULL
 };
 
 struct bnxt_re_uctx_resp {
@@ -62,6 +63,8 @@ struct bnxt_re_uctx_resp {
 	__aligned_u64 comp_mask;
 	__u32 chip_id0;
 	__u32 chip_id1;
+	__u32 wqe_mode;
+	__u32 rsvd1;
 };
 
 /*
diff --git a/providers/bnxt_re/bnxt_re-abi.h b/providers/bnxt_re/bnxt_re-abi.h
index c82019e8..d138cd9c 100644
--- a/providers/bnxt_re/bnxt_re-abi.h
+++ b/providers/bnxt_re/bnxt_re-abi.h
@@ -196,6 +196,11 @@ enum bnxt_re_ud_cqe_mask {
 	BNXT_RE_UD_CQE_SRCQPLO_SHIFT	= 0x30
 };
 
+enum bnxt_re_modes {
+	BNXT_RE_WQE_MODE_STATIC =	0x00,
+	BNXT_RE_WQE_MODE_VARIABLE =	0x01
+};
+
 struct bnxt_re_db_hdr {
 	__le32 indx;
 	__le32 typ_qid; /* typ: 4, qid:20*/
diff --git a/providers/bnxt_re/main.c b/providers/bnxt_re/main.c
index 1779e1ec..428affc7 100644
--- a/providers/bnxt_re/main.c
+++ b/providers/bnxt_re/main.c
@@ -158,6 +158,10 @@ static struct verbs_context *bnxt_re_alloc_context(struct ibv_device *vdev,
 					 BNXT_RE_CHIP_ID0_CHIP_MET_SFT) &
 					 0xFF;
 	}
+
+	if (resp.comp_mask & BNXT_RE_UCNTX_CMASK_HAVE_MODE)
+		cntx->wqe_mode = resp.wqe_mode;
+
 	pthread_spin_init(&cntx->fqlock, PTHREAD_PROCESS_PRIVATE);
 	/* mmap shared page. */
 	cntx->shpg = mmap(NULL, rdev->pg_size, PROT_READ | PROT_WRITE,
diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
index a63719e8..dc8166f2 100644
--- a/providers/bnxt_re/main.h
+++ b/providers/bnxt_re/main.h
@@ -146,6 +146,7 @@ struct bnxt_re_qp {
 	uint64_t wqe_cnt;
 	uint16_t mtu;
 	uint16_t qpst;
+	uint32_t qpmode;
 	uint8_t qptyp;
 	/* irdord? */
 };
@@ -178,6 +179,7 @@ struct bnxt_re_context {
 	uint32_t max_srq;
 	struct bnxt_re_dpi udpi;
 	void *shpg;
+	uint32_t wqe_mode;
 	pthread_mutex_t shlock;
 	pthread_spinlock_t fqlock;
 };
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index fb2cf5ac..11c01574 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -952,6 +952,7 @@ struct ibv_qp *bnxt_re_create_qp(struct ibv_pd *ibvpd,
 		goto fail;
 	/* alloc queues */
 	qp->cctx = &cntx->cctx;
+	qp->qpmode = cntx->wqe_mode & BNXT_RE_WQE_MODE_VARIABLE;
 	if (bnxt_re_alloc_queues(qp, attr, dev->pg_size))
 		goto failq;
 	/* Fill ibv_cmd */
-- 
2.25.1


--000000000000a9001805c286ab72
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPAwUfDX+tP2prU3lXT5a2rgqcbf
kmp+nMKTNLAmSKX+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxNzEzMzU0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQADYX2UX9IC6LczO1cfXGnU2uZY//5U7BlLOCEVPGAbGtkL
+iX9jGYuzli2AkTUvG3+Sk+oDuvitKbspOaSSDh1I5ZpKDK5jR5MSp35g+3gVIV843oeESxK+M/6
sQEkmZbmhMBFaEr1wvDw2J/CbAIm1u4nihQ49Y7qIAfe+VwCuBPAxFfmnL79vFsv4yIXy2z6P8A6
B3kVw8pJOKdnGpfWlWCwtu0PMcTK2DR9XAyKPK98E465ya/iJI5JYF0lGpox2M7m1OvEL5fw9DN5
PhO+ruRUGfw6ulU7mZEMnFwKxM2ekZyJj6dauY159fve6ZhMfXYBD4Ou2w3vhqGOtJ8q
--000000000000a9001805c286ab72--
