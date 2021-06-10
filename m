Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1333A29A2
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJKw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 06:52:27 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:35362 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJKwX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 06:52:23 -0400
Received: by mail-pj1-f50.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso3527362pjb.0
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jun 2021 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=lMQ8sv4TL1wbz/E6lqgzXkL11ehoYXE1UPkQt9tdE/Y=;
        b=DyTruwq5ECr62xvmYCOJZuPQKUvATuVQfPDxPpzugu5An/3297S5xX8fATXwNNPhVg
         yeuW3DaoOrvsZ6d1ElWfGyXdhOvgw+e97cYecOv86F0OkZG/AZt5OfXU6gHpsR7wpio0
         XxDEfCBVihOfynANTq34CFPrB7hMVff3b794M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=lMQ8sv4TL1wbz/E6lqgzXkL11ehoYXE1UPkQt9tdE/Y=;
        b=Np67DiZcNMlJwqUDNqc1AnmWmNPIb85RDbQdz5tg7geqQma7SZhnQkNLPeAnTx3hsH
         hmgyvjxNuUomZpL7m7PmekQjGCT9gyhfwac4esXsNX7E/AE7/vQbtZcCf9DlW1AKnw9K
         JvpMAu4ZYPLF/mhB0yOzp1kDv6WoSPScmo2/8r7PBaB7e0FoXYVdCdJcrrVpUcPJp8Sp
         4PEmNqpD9N+i8Z8BeNBeWTW8oGWTYat/r5Z2JSw04mHqDbpsbBONVkTkvgMHV7HSOU4J
         FiIILRgIYfs1wBOgLkOMb4L3+bJUbMDfCNGYCqR6KBZ3sz58NdDLOEvHGGTtouH7MmP5
         Crmg==
X-Gm-Message-State: AOAM530dVC53ZiTklZfdle2H7HPzA/gxe2/WH9awlKwSPDhyXVHsZiSI
        kLx3QYmfLJEOXd4815db9LIIbtsu9f1QhQHS6pJ+QqUNVFyjbOsZ4Z8pX0SW6RFMo5+3f1iqVYs
        pNSKYd99y25lAeJjMTSKGz2utOV1Rv49oAO55k7Xgo6XzAa+2AB1jGICcRYvkIxDXoqy6eQhj3N
        VR6oyNjA==
X-Google-Smtp-Source: ABdhPJywxHuD6cDKJgAYahFKVcISHdX6CgPF2qMb+ufyJ7laWpBg8osqTWBogPMwMl1oO3LvhP0YSQ==
X-Received: by 2002:a17:90b:318:: with SMTP id ay24mr2631663pjb.150.1623322167145;
        Thu, 10 Jun 2021 03:49:27 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r6sm7362564pjm.12.2021.06.10.03.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:49:26 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V4 rdma-core 2/5] bnxt_re/lib: Read wqe mode from the driver
Date:   Thu, 10 Jun 2021 16:19:07 +0530
Message-Id: <20210610104910.1147756-3-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610104910.1147756-1-devesh.sharma@broadcom.com>
References: <20210610104910.1147756-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002978af05c467254b"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000002978af05c467254b
Content-Transfer-Encoding: 8bit

During bnxt_re device context creation, read the
wqe mode and store it in context structure and
in the QP context structure. wqe mode would be
required to change between fixed size wqe and
non-fixed sized wqe modes of SQ/RQ in gen-p5
or newer devices.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/bnxt_re-abi.h | 5 +++++
 providers/bnxt_re/main.c        | 4 ++++
 providers/bnxt_re/main.h        | 2 ++
 providers/bnxt_re/verbs.c       | 1 +
 4 files changed, 12 insertions(+)

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
index 1779e1ec..ee9edd7d 100644
--- a/providers/bnxt_re/main.c
+++ b/providers/bnxt_re/main.c
@@ -158,6 +158,10 @@ static struct verbs_context *bnxt_re_alloc_context(struct ibv_device *vdev,
 					 BNXT_RE_CHIP_ID0_CHIP_MET_SFT) &
 					 0xFF;
 	}
+
+	if (resp.comp_mask & BNXT_RE_UCNTX_CMASK_HAVE_MODE)
+		cntx->wqe_mode = resp.mode;
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


--0000000000002978af05c467254b
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIiMzCivFU4tVTC0n8iPTKDZouct
qWxXXDARdYfZQQq8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYxMDEwNDkyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBkXudOP6me858zHX7r8MP2edA+cVZWiFGE+BCjPlYZHHNg
cZpcBBAN4FpPAHWTxtEtOIaejeR2/+N8DPK2RkdKXQFDXCdT9lE+2CI8ZUU/XgRv9F65APS7gSfQ
2z507grWVf5VnwSqzeEdX0TlSmLbvM09dvR9Mlo7Iv5Ql5+jVl+PfyRAcJHnccQUpZfAnIM04Li+
aMUnLGzBE1YaffwvkCVxr7SKm358M0D22UzV+xRIKmhANJN4I2VNPiqww5JeXqt1mH73uncjyd1r
AYBM/2GZgCV09/eP5HH0ZT606D3T2+d0tvE4rR55u36xbEFds6VF483NM6TwPR8U6NMo
--0000000000002978af05c467254b--
