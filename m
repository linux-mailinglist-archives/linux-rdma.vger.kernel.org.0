Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1006B3711B7
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 08:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhECGtM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 02:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhECGtM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 02:49:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89432C06174A
        for <linux-rdma@vger.kernel.org>; Sun,  2 May 2021 23:48:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e15so3466750pfv.10
        for <linux-rdma@vger.kernel.org>; Sun, 02 May 2021 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=R179ARZvIjln9KCXhLhDanQPTgK4VzAROYHU4eEaVTQ=;
        b=fZasdJyvar9LzV0TUHIM/ubz6i+lmo+IDCRKRqH1RB3moAWtcQuK9p5mOdtOKLiCVh
         72iYqCmYdc8NzacGrxcICTIdeoH3aJoGHxhPRd+4gfdMJDmPTZOSeBz8/Q2fDYuC9/mn
         m5fpF7uyBUYXpNONlPINKp02PW3qNSCM1Zvxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=R179ARZvIjln9KCXhLhDanQPTgK4VzAROYHU4eEaVTQ=;
        b=MwAR0a/QCPJwSZUIuUWfrE1jWw39rmKp/SfA9oYLryAE9DQMMntY7b6YU35uFQbAp4
         kzzhEexuH532wuLQdRzEPZ7+DMx3F3dRpqtkJqBHQ5HlC1YM39dljeyUOuPeo/JQSS/b
         MGH1Hlfzq3A9Y91fxgdqf1gxnAiW+OLxkYsUu/xiLkvzrlKEWtPhTiU7SASmRZltJFmf
         G8+xXehXggnanX+OdT/2o/Tuz+LU1+JO2h+ccIv7cRmvLMm3YvgO1/4Sk4aG8n/C4qhG
         OZXGDuJMD16kczNd2XIQC5Vqx0d0phe92jA0PEdJJtnL0Ksgnq7dhanF0BhmN0ugAd2N
         /LTw==
X-Gm-Message-State: AOAM533sfnJTksVzYnd2hBu42cmy7mOBJX+KD9Fe+0iR/24qpK/IL9IO
        JXYx1cd81TCtQ2HrrgX3vCuM6qR8F9fAGsy7eVsSQ70qjpKS1Asatk3PsC+k5Ta9QW8ptp4TFDf
        vbX6WlCElqC4kMoDzbkN/QoZeaFFmr86OvqIBE24P1w4+zkaLslc2NEop6pQD/ggasoUJfI19TS
        FO6DqJ1Nn3
X-Google-Smtp-Source: ABdhPJy5jF192fNmgTi8Jq3VjTjwOdP1usTt41QsdKnOjk/cH66u5peKEfTQkkrPIKrxykYQAJVBSw==
X-Received: by 2002:a63:575b:: with SMTP id h27mr17382550pgm.180.1620024498478;
        Sun, 02 May 2021 23:48:18 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i9sm19585389pjh.9.2021.05.02.23.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 23:48:18 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [rdma-core 2/4] bnxt_re/lib: align base sq entry structure to 16B
Date:   Mon,  3 May 2021 12:18:00 +0530
Message-Id: <20210503064802.457482-3-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503064802.457482-1-devesh.sharma@broadcom.com>
References: <20210503064802.457482-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000cba77205c1675803"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000cba77205c1675803
Content-Transfer-Encoding: 8bit

The base SQ entry structure needs to be aligned to
16B boundary to support new method of SQE/RQE posting.
Changing the same.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/bnxt_re-abi.h | 24 ++++++++++--------------
 providers/bnxt_re/verbs.c       | 26 ++++++++++++--------------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/providers/bnxt_re/bnxt_re-abi.h b/providers/bnxt_re/bnxt_re-abi.h
index c6998e85..c82019e8 100644
--- a/providers/bnxt_re/bnxt_re-abi.h
+++ b/providers/bnxt_re/bnxt_re-abi.h
@@ -234,9 +234,16 @@ struct bnxt_re_term_cqe {
 	__le64 rsvd1;
 };
 
+union lower_shdr {
+	__le64 qkey_len;
+	__le64 lkey_plkey;
+	__le64 rva;
+};
+
 struct bnxt_re_bsqe {
 	__le32 rsv_ws_fl_wt;
 	__le32 key_immd;
+	union lower_shdr lhdr;
 };
 
 struct bnxt_re_psns {
@@ -262,42 +269,33 @@ struct bnxt_re_sge {
 #define BNXT_RE_MAX_INLINE_SIZE		0x60
 
 struct bnxt_re_send {
-	__le32 length;
-	__le32 qkey;
 	__le32 dst_qp;
 	__le32 avid;
 	__le64 rsvd;
 };
 
 struct bnxt_re_raw {
-	__le32 length;
-	__le32 rsvd1;
 	__le32 cfa_meta;
 	__le32 rsvd2;
 	__le64 rsvd3;
 };
 
 struct bnxt_re_rdma {
-	__le32 length;
-	__le32 rsvd1;
 	__le64 rva;
 	__le32 rkey;
 	__le32 rsvd2;
 };
 
 struct bnxt_re_atomic {
-	__le64 rva;
 	__le64 swp_dt;
 	__le64 cmp_dt;
 };
 
 struct bnxt_re_inval {
-	__le64 rsvd[3];
+	__le64 rsvd[2];
 };
 
 struct bnxt_re_bind {
-	__le32 plkey;
-	__le32 lkey;
 	__le64 va;
 	__le64 len; /* only 40 bits are valid */
 };
@@ -305,17 +303,15 @@ struct bnxt_re_bind {
 struct bnxt_re_brqe {
 	__le32 rsv_ws_fl_wt;
 	__le32 rsvd;
+	__le32 wrid;
+	__le32 rsvd1;
 };
 
 struct bnxt_re_rqe {
-	__le32 wrid;
-	__le32 rsvd1;
 	__le64 rsvd[2];
 };
 
 struct bnxt_re_srqe {
-	__le32 srq_tag; /* 20 bits are valid */
-	__le32 rsvd1;
 	__le64 rsvd[2];
 };
 #endif
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index a015bed7..760e840a 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -1150,17 +1150,16 @@ static void bnxt_re_fill_wrid(struct bnxt_re_wrid *wrid, struct ibv_send_wr *wr,
 static int bnxt_re_build_send_sqe(struct bnxt_re_qp *qp, void *wqe,
 				  struct ibv_send_wr *wr, uint8_t is_inline)
 {
-	struct bnxt_re_bsqe *hdr = wqe;
-	struct bnxt_re_send *sqe = ((void *)wqe + sizeof(struct bnxt_re_bsqe));
 	struct bnxt_re_sge *sge = ((void *)wqe + bnxt_re_get_sqe_hdr_sz());
+	struct bnxt_re_bsqe *hdr = wqe;
 	uint32_t wrlen, hdrval = 0;
-	int len;
 	uint8_t opcode, qesize;
+	int len;
 
 	len = bnxt_re_build_sge(sge, wr->sg_list, wr->num_sge, is_inline);
 	if (len < 0)
 		return len;
-	sqe->length = htole32(len);
+	hdr->lhdr.qkey_len = htole64((uint64_t)len);
 
 	/* Fill Header */
 	opcode = bnxt_re_ibv_to_bnxt_wr_opcd(wr->opcode);
@@ -1189,7 +1188,9 @@ static int bnxt_re_build_ud_sqe(struct bnxt_re_qp *qp, void *wqe,
 				struct ibv_send_wr *wr, uint8_t is_inline)
 {
 	struct bnxt_re_send *sqe = ((void *)wqe + sizeof(struct bnxt_re_bsqe));
+	struct bnxt_re_bsqe *hdr = wqe;
 	struct bnxt_re_ah *ah;
+	uint64_t qkey;
 	int len;
 
 	len = bnxt_re_build_send_sqe(qp, wqe, wr, is_inline);
@@ -1198,7 +1199,8 @@ static int bnxt_re_build_ud_sqe(struct bnxt_re_qp *qp, void *wqe,
 		goto bail;
 	}
 	ah = to_bnxt_re_ah(wr->wr.ud.ah);
-	sqe->qkey = htole32(wr->wr.ud.remote_qkey);
+	qkey = wr->wr.ud.remote_qkey;
+	hdr->lhdr.qkey_len |= htole64(qkey << 32);
 	sqe->dst_qp = htole32(wr->wr.ud.remote_qpn);
 	sqe->avid = htole32(ah->avid & 0xFFFFF);
 bail:
@@ -1228,7 +1230,7 @@ static int bnxt_re_build_cns_sqe(struct bnxt_re_qp *qp, void *wqe,
 
 	len = bnxt_re_build_send_sqe(qp, wqe, wr, false);
 	hdr->key_immd = htole32(wr->wr.atomic.rkey);
-	sqe->rva = htole64(wr->wr.atomic.remote_addr);
+	hdr->lhdr.rva = htole64(wr->wr.atomic.remote_addr);
 	sqe->cmp_dt = htole64(wr->wr.atomic.compare_add);
 	sqe->swp_dt = htole64(wr->wr.atomic.swap);
 
@@ -1245,7 +1247,7 @@ static int bnxt_re_build_fna_sqe(struct bnxt_re_qp *qp, void *wqe,
 
 	len = bnxt_re_build_send_sqe(qp, wqe, wr, false);
 	hdr->key_immd = htole32(wr->wr.atomic.rkey);
-	sqe->rva = htole64(wr->wr.atomic.remote_addr);
+	hdr->lhdr.rva = htole64(wr->wr.atomic.remote_addr);
 	sqe->cmp_dt = htole64(wr->wr.atomic.compare_add);
 
 	return len;
@@ -1368,13 +1370,11 @@ static int bnxt_re_build_rqe(struct bnxt_re_qp *qp, struct ibv_recv_wr *wr,
 			     void *rqe)
 {
 	struct bnxt_re_brqe *hdr = rqe;
-	struct bnxt_re_rqe *rwr;
-	struct bnxt_re_sge *sge;
 	struct bnxt_re_wrid *wrid;
+	struct bnxt_re_sge *sge;
 	int wqe_sz, len;
 	uint32_t hdrval;
 
-	rwr = (rqe + sizeof(struct bnxt_re_brqe));
 	sge = (rqe + bnxt_re_get_rqe_hdr_sz());
 	wrid = &qp->rwrid[qp->rqq->tail];
 
@@ -1388,7 +1388,7 @@ static int bnxt_re_build_rqe(struct bnxt_re_qp *qp, struct ibv_recv_wr *wr,
 	hdrval = BNXT_RE_WR_OPCD_RECV;
 	hdrval |= ((wqe_sz & BNXT_RE_HDR_WS_MASK) << BNXT_RE_HDR_WS_SHIFT);
 	hdr->rsv_ws_fl_wt = htole32(hdrval);
-	rwr->wrid = htole32(qp->rqq->tail);
+	hdr->wrid = htole32(qp->rqq->tail);
 
 	/* Fill wrid */
 	wrid->wrid = wr->wr_id;
@@ -1586,13 +1586,11 @@ static int bnxt_re_build_srqe(struct bnxt_re_srq *srq,
 			      struct ibv_recv_wr *wr, void *srqe)
 {
 	struct bnxt_re_brqe *hdr = srqe;
-	struct bnxt_re_rqe *rwr;
 	struct bnxt_re_sge *sge;
 	struct bnxt_re_wrid *wrid;
 	int wqe_sz, len, next;
 	uint32_t hdrval = 0;
 
-	rwr = (srqe + sizeof(struct bnxt_re_brqe));
 	sge = (srqe + bnxt_re_get_srqe_hdr_sz());
 	next = srq->start_idx;
 	wrid = &srq->srwrid[next];
@@ -1602,7 +1600,7 @@ static int bnxt_re_build_srqe(struct bnxt_re_srq *srq,
 	wqe_sz = wr->num_sge + (bnxt_re_get_srqe_hdr_sz() >> 4); /* 16B align */
 	hdrval |= ((wqe_sz & BNXT_RE_HDR_WS_MASK) << BNXT_RE_HDR_WS_SHIFT);
 	hdr->rsv_ws_fl_wt = htole32(hdrval);
-	rwr->wrid = htole32((uint32_t)next);
+	hdr->wrid = htole32((uint32_t)next);
 
 	/* Fill wrid */
 	wrid->wrid = wr->wr_id;
-- 
2.25.1


--000000000000cba77205c1675803
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDnQjHXg++GP7qp/seAVU0o8lR+s
JczrgJduu1bevL9JMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUwMzA2NDgxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCDgaopIGvToe2YEeKeodI2CFXhklxvAkTc6NZGQ/YTfaAG
bxjyOJGLUvmRWueK++58tjpb/9OqkT2juoAbI2YeGlSou0GcksUJ0MT4D9iBCxqtLzwmPSDsNg7+
3IuKjhXMezfIm1DOUfhACNZjzxfg0Mgu58q/d70LI9O6dlQxM/iZPItFyIlJ9jfcN0nrcerva15F
+b/sMJzp8urMURNKgLBk0GWyluTdEE9CdjXyHH8uV6mSHjGABwV9FP731X1iqF2oPruiKBOZKaHA
svf+hf4b0GprEVvKYfwBMEe6E/+LVmjRTOX4Brh1eYHjsnVikT1V8OIwxCDvCjFlUN9I
--000000000000cba77205c1675803--
