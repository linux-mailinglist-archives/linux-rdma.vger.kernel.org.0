Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C727C5B7A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 20:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjJKSnY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjJKSnY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 14:43:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4EC9D
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 11:43:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5890aa0573aso101522a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697049801; x=1697654601; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vg/xjbrnQlXQaNfVawYRQ/bp6zjEMWaCsv6j7nmAoxA=;
        b=R38dRf9uX6XO1IDDBfI8UMHWqV2a1/PXrnt4OliXaZaKwuqITSkvyXwh+C1jkb3YTa
         6GX1dKfmfJNcSUiOoTHPeTAie9MHHAVzTfhllHMT1wmvC/JQEXSNT5qzl/z+SBucoVhe
         4P1YMJaOeTyoaxUMkZAt0dC/0R+gESJFWPJB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697049801; x=1697654601;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg/xjbrnQlXQaNfVawYRQ/bp6zjEMWaCsv6j7nmAoxA=;
        b=vGAnJKk2UjRVU7jHuLuZFbk4AzckTgcDKxy3I+GHx3Lw59ZEojtDw52WwRBzVdp1m/
         V4IJVisG+Npn+Ra41UD1TxlLsKcIkaNQjbgW7mc6yoRYoayA00egjS5bgSReru8w61JV
         vFrZHZd8uwWfbyhcHHGz/LNYW/HzzO0k+TCc6na4qA8eJlL625AnRAgmpS9dubFP8JAj
         0Hv7D7jyWr34Klot4IlFYQHqhz3YHF5FtTX+2pQQgnaAo+o0iyuFE9qcvKI7RKVGCHoj
         6OvZ29zAS+mOTUJYw7p/Lgil6eOiLnPulpjYt6Zc1WCKdFpu3BVZNZGp5jo+B6TVGZGI
         dUMw==
X-Gm-Message-State: AOJu0Yw2m1gTxca2K4YEWALW6uYgUinOtoqodca6duhAqmpotKcHchN7
        fIql86dHfmqe08szzrHoJxXYxA==
X-Google-Smtp-Source: AGHT+IEkSzI4R8dSCjKV1sGqA0M645jLv9yIcCB9eXi+Gv1fWe48h2lCD2Ka0feo8bJ/vRjfOfmooA==
X-Received: by 2002:a05:6a21:9986:b0:160:cf09:8019 with SMTP id ve6-20020a056a21998600b00160cf098019mr22166536pzb.32.1697049801536;
        Wed, 11 Oct 2023 11:43:21 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902ed0400b001b89466a5f4sm178887pld.105.2023.10.11.11.43.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2023 11:43:20 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 2/3] RDMA/bnxt_re: Report async events and errors
Date:   Wed, 11 Oct 2023 11:31:36 -0700
Message-Id: <1697049097-31992-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1697049097-31992-1-git-send-email-selvin.xavier@broadcom.com>
References: <1697049097-31992-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009b521006077532b3"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_TVD_MIME_NO_HEADERS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000009b521006077532b3

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Report QP, SRQ and CQ async events and errors.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 165 +++++++++++++++++++++++++++++++++--
 1 file changed, 156 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c9066aa..ae72207 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -970,6 +970,9 @@ static int bnxt_re_handle_unaffi_async_event(struct creq_func_event
 static int bnxt_re_handle_qp_async_event(struct creq_qp_event *qp_event,
 					 struct bnxt_re_qp *qp)
 {
+	struct bnxt_re_srq *srq = container_of(qp->qplib_qp.srq, struct bnxt_re_srq,
+					       qplib_srq);
+	struct creq_qp_error_notification *err_event;
 	struct ib_event event = {};
 	unsigned int flags;
 
@@ -980,14 +983,146 @@ static int bnxt_re_handle_qp_async_event(struct creq_qp_event *qp_event,
 		bnxt_re_unlock_cqs(qp, flags);
 	}
 
-	if (qp->qplib_qp.srq) {
-		event.device = &qp->rdev->ibdev;
-		event.element.qp = &qp->ib_qp;
-		event.event = IB_EVENT_QP_LAST_WQE_REACHED;
+	event.device = &qp->rdev->ibdev;
+	event.element.qp = &qp->ib_qp;
+	event.event = IB_EVENT_QP_FATAL;
+
+	err_event = (struct creq_qp_error_notification *)qp_event;
+
+	switch (err_event->req_err_state_reason) {
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_OPCODE_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_TIMEOUT_RETRY_LIMIT:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RNR_TIMEOUT_RETRY_LIMIT:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_NAK_ARRIVAL_2:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_NAK_ARRIVAL_3:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_INVALID_READ_RESP:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_ILLEGAL_BIND:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_ILLEGAL_FAST_REG:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_ILLEGAL_INVALIDATE:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RETRAN_LOCAL_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_AV_DOMAIN_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_PROD_WQE_MSMTCH_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_PSN_RANGE_CHECK_ERROR:
+		event.event = IB_EVENT_QP_ACCESS_ERR;
+		break;
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_NAK_ARRIVAL_1:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_NAK_ARRIVAL_4:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_READ_RESP_LENGTH:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_WQE_FORMAT_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_ORRQ_FORMAT_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_INVALID_AVID_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_SERV_TYPE_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_INVALID_OP_ERROR:
+		event.event = IB_EVENT_QP_REQ_ERR;
+		break;
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RX_MEMORY_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_TX_MEMORY_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_CMP_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_CQ_LOAD_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_TX_PCI_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RX_PCI_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_REQ_ERR_STATE_REASON_REQ_RETX_SETUP_ERROR:
+		event.event = IB_EVENT_QP_FATAL;
+		break;
+
+	default:
+		break;
 	}
 
-	if (event.device && qp->ib_qp.event_handler)
+	switch (err_event->res_err_state_reason) {
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_EXCEED_MAX:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_PAYLOAD_LENGTH_MISMATCH:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_PSN_SEQ_ERROR_RETRY_LIMIT:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_INVALID_R_KEY:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_DOMAIN_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_NO_PERMISSION:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_RANGE_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_INVALID_R_KEY:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_DOMAIN_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_NO_PERMISSION:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_RANGE_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_UNALIGN_ATOMIC:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_PSN_NOT_FOUND:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_INVALID_DUP_RKEY:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_IRRQ_FORMAT_ERROR:
+		event.event = IB_EVENT_QP_ACCESS_ERR;
+		break;
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_EXCEEDS_WQE:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_WQE_FORMAT_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_UNSUPPORTED_OPCODE:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_REM_INVALIDATE:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_OPCODE_ERROR:
+		event.event = IB_EVENT_QP_REQ_ERR;
+		break;
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_IRRQ_OFLOW:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_CMP_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_CQ_LOAD_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_TX_PCI_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_RX_PCI_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_MEMORY_ERROR:
+		event.event = IB_EVENT_QP_FATAL;
+		break;
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_SRQ_LOAD_ERROR:
+	case CREQ_QP_ERROR_NOTIFICATION_RES_ERR_STATE_REASON_RES_SRQ_ERROR:
+		if (srq)
+			event.event = IB_EVENT_SRQ_ERR;
+		break;
+	default:
+		break;
+	}
+
+	if (err_event->res_err_state_reason || err_event->req_err_state_reason) {
+		ibdev_dbg(&qp->rdev->ibdev,
+			  "%s %s qp_id: %d cons (%d %d) req (%d %d) res (%d %d)\n",
+			   __func__, rdma_is_kernel_res(&qp->ib_qp.res) ? "kernel" : "user",
+			   qp->qplib_qp.id,
+			   err_event->sq_cons_idx,
+			   err_event->rq_cons_idx,
+			   err_event->req_slow_path_state,
+			   err_event->req_err_state_reason,
+			   err_event->res_slow_path_state,
+			   err_event->res_err_state_reason);
+	} else {
+		if (srq)
+			event.event = IB_EVENT_QP_LAST_WQE_REACHED;
+	}
+
+	if (event.event == IB_EVENT_SRQ_ERR && srq->ib_srq.event_handler)  {
+		(*srq->ib_srq.event_handler)(&event,
+				srq->ib_srq.srq_context);
+	} else if (event.device && qp->ib_qp.event_handler) {
 		qp->ib_qp.event_handler(&event, qp->ib_qp.qp_context);
+	}
+
+	return 0;
+}
+
+static int bnxt_re_handle_cq_async_error(void *event, struct bnxt_re_cq *cq)
+{
+	struct creq_cq_error_notification *cqerr;
+	struct ib_event ibevent = {};
+
+	cqerr = event;
+	switch (cqerr->cq_err_reason) {
+	case CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_REQ_CQ_INVALID_ERROR:
+	case CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_REQ_CQ_OVERFLOW_ERROR:
+	case CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_REQ_CQ_LOAD_ERROR:
+	case CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_INVALID_ERROR:
+	case CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_OVERFLOW_ERROR:
+	case CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_LOAD_ERROR:
+		ibevent.event = IB_EVENT_CQ_ERR;
+	default:
+		break;
+	}
+
+	if (ibevent.event == IB_EVENT_CQ_ERR && cq->ib_cq.event_handler) {
+		ibevent.element.cq = &cq->ib_cq;
+		ibevent.device = &cq->rdev->ibdev;
+
+		ibdev_dbg(&cq->rdev->ibdev,
+			  "%s err reason %d\n", __func__, cqerr->cq_err_reason);
+		cq->ib_cq.event_handler(&ibevent, cq->ib_cq.cq_context);
+	}
 
 	return 0;
 }
@@ -995,6 +1130,10 @@ static int bnxt_re_handle_qp_async_event(struct creq_qp_event *qp_event,
 static int bnxt_re_handle_affi_async_event(struct creq_qp_event *affi_async,
 					   void *obj)
 {
+	struct bnxt_qplib_qp *lib_qp;
+	struct bnxt_qplib_cq *lib_cq;
+	struct bnxt_re_qp *qp;
+	struct bnxt_re_cq *cq;
 	int rc = 0;
 	u8 event;
 
@@ -1002,11 +1141,19 @@ static int bnxt_re_handle_affi_async_event(struct creq_qp_event *affi_async,
 		return rc; /* QP was already dead, still return success */
 
 	event = affi_async->event;
-	if (event == CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION) {
-		struct bnxt_qplib_qp *lib_qp = obj;
-		struct bnxt_re_qp *qp = container_of(lib_qp, struct bnxt_re_qp,
-						     qplib_qp);
+	switch (event) {
+	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
+		lib_qp = obj;
+		qp = container_of(lib_qp, struct bnxt_re_qp, qplib_qp);
 		rc = bnxt_re_handle_qp_async_event(affi_async, qp);
+		break;
+	case CREQ_QP_EVENT_EVENT_CQ_ERROR_NOTIFICATION:
+		lib_cq = obj;
+		cq = container_of(lib_cq, struct bnxt_re_cq, qplib_cq);
+		rc = bnxt_re_handle_cq_async_error(affi_async, cq);
+		break;
+	default:
+		rc = -EINVAL;
 	}
 	return rc;
 }
-- 
2.5.5


--0000000000009b521006077532b3
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII5xATZDZvPe
x2rHdU8XF+RFy9+r5SBmR71frhbzM2z3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTAxMTE4NDMyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA7kBxiUMppUM6ifegDiAldZs7yX0IE
NWlNQQs2uYyxYfnLExjwFQqWIoGv0oU/DIHDwSXvXi4DNadrM/ydAPbsAHqY91zRHmEyUlqkfMEd
rn4OUfxDoadw4cjb0tq6hy52rE8Gf3QZzYhN+PU6dRjhZBmHl5WvhwQxyfonPR3PqP6mW41fx3zl
W1JuafInA9zTU3N3AznMe/InBuVDKbrYpairDZMG98QLVeTi7O1O85w4c/RZpTgZyPWcFHiDNSIK
/wUMO+Gew6B0ECV7TgrRVBzItCWqIza2ANos9S0yS1o1ammr0Gtg5mvpvoXgYIFj74JaGP/0br0c
Dj5lNTu0
--0000000000009b521006077532b3--
