Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63DF374709
	for <lists+linux-rdma@lfdr.de>; Wed,  5 May 2021 19:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhEERlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 May 2021 13:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbhEERiZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 May 2021 13:38:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E1FC0612B2
        for <linux-rdma@vger.kernel.org>; Wed,  5 May 2021 10:11:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so1214029pjb.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 May 2021 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=n+Jrar4SyoBmqCVW6l1CGFiThnPRsymsVuNaX6THJQI=;
        b=YRB9aG44vLy2/4871dZCdnQyGcYuXDC+BXDHphVt92uqa0KbOCPX9jx8t25c1ClzZ7
         0I7rd2nBRbHKDiuKTa0j90ZDSifrkjxZACbIERWjH1FaDJfj6FM1ZsW9LYOhUlZQ30og
         E66E2DN0DuVyd9kbLfuh/zpfYM2JauYRyT6VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=n+Jrar4SyoBmqCVW6l1CGFiThnPRsymsVuNaX6THJQI=;
        b=eG2+C4jDTiNNbaAa/N6hTS05PMunUyPOBux9eJaOrOPOGCknXfcZ8teIsTH5w2Nn33
         9uhFi5k2gJZVZrXOuDzhgvYFBlLR3ydMwsKIJq8UIeP8X9mxLeI93IfMquPHu1oDY7jS
         41b9i6qFXBfjb0+rJY731c25PYULEnVO2tEsi34qPHSoB8QhqDNAEDX/CfdAy/6EBH/l
         +HS+uPvfl5+lIx54pEVia/5cM/7bUO1mAe7PwmzJmmCCIhMPuVdDNPzc60d4DXQuLjjH
         993tbJRJwLfu9MjJCIcxyCmeCS1i+T9srQcYaFE687TirU5RybXiN+cI0Sic/IHdIidP
         hGwg==
X-Gm-Message-State: AOAM5317+oYaG/fflM2cLpOioLWYEMI36vra5+5omGFf3ogC/TU4XNPz
        DFF8x39nZqXAIWClKRRAdwUyZBic/J3ZryRrewldCE2zRxb6q9lv3tL+A/bncwpvwS7BnEeT7wS
        vwSOmeW6cn5vWeJLEccsuKLto0vYRdsj8L8wAP+8wszIXE20XapFXzO/Gz0tS3ULK2nugSbaKVJ
        uKUDiSu3Kk
X-Google-Smtp-Source: ABdhPJxHdNmhMVpiSpfCecPoHR+C5y3MWwFpP0VdXZ+Is+ClncclJnVZxpBGtaBPOZ8CoQZkClssZA==
X-Received: by 2002:a17:90a:bc8:: with SMTP id x8mr12326551pjd.224.1620234675620;
        Wed, 05 May 2021 10:11:15 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u21sm15381614pfm.89.2021.05.05.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:11:15 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [V2 rdma-core 2/4] bnxt_re/lib: align base sq entry structure to 16B boundary
Date:   Wed,  5 May 2021 22:40:54 +0530
Message-Id: <20210505171056.514204-3-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505171056.514204-1-devesh.sharma@broadcom.com>
References: <20210505171056.514204-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000057cdea05c1984841"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000057cdea05c1984841
Content-Transfer-Encoding: 8bit

Breaking the send_wqe and recv_wqe hardware
specific interface into smaller chunk size instead of
fixed 128B chunks. This make both post-send and post-recv
flexible.

Fixes: d2745fe2ab86 ("Add support for posting and polling")
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


--00000000000057cdea05c1984841
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIH2DMUTNF05L8m36lu9iXXdMIJ90
Va/0CWP3uFXi0IV3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUwNTE3MTExNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAVaNlSzZtRQKlp6z7iaPWloPO3uwDDmqA6wnszkOCxVgJi
AxDsp9nG0QvNYjAbND8o9IfzFJKGNVi5ohRIAh9MS9FLQDH4QyqOOqMg/xM6oTik9cH+vSDd4F00
7PXVMaXOyM7J/aK/YRQ0/cHt5rpUIwaE5/7o3BT1np9hZl1acI/t22ytK76Cis6GNpJ6Rq3YdxHT
Vp1wImiyLjOjAJNndMFngXfMhyJt8/8iJLW1917xrRnk1HJPzhoHXAcR0kJPdcov/0mK/9pbPNlr
lHQPojSVXS8VSjLR/x9Lyy7LNy3XyxObYchLs9QJlcwVUVg+jMAPmp0kggMyEgHOkbqk
--00000000000057cdea05c1984841--
