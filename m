Return-Path: <linux-rdma+bounces-303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C829808654
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 12:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C563BB21C3B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647E35299;
	Thu,  7 Dec 2023 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cxTJQM0C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64535E9
	for <linux-rdma@vger.kernel.org>; Thu,  7 Dec 2023 03:04:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ceb27ec331so310888b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 Dec 2023 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701947072; x=1702551872; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zzCQeHLuoeLY5ZfB67n9INmQOtUGRlDHsW9mPBULmz8=;
        b=cxTJQM0CWkJ4nGLuCdrlaJtB/18EpzzVOJ9O6/U34t7Huj+E2OhWSv++x66JG32JGu
         XCvWQCsztDJGcfbA0wnXnM+gwuEcM3YTpdiNickwlgMLyiYRxhlZ6f/rA5Stj76vq42K
         QcW2+eoGlWf1/TMivYy6iI17kzNhq1AGwhMYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947072; x=1702551872;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzCQeHLuoeLY5ZfB67n9INmQOtUGRlDHsW9mPBULmz8=;
        b=lrpzgbN9rJgElq5Y514/cHKW3JOLAvg23rznVM4IxL4kzZBSZALAdAwsQtYX3aU9uA
         J5TLiEd3se4PL5HM6uqbTQyyeCu1gnSCu+/fedWe8tQp8TPDPHZmhyNLq76jxx2g2pCM
         8K5Wi7XK5JTVOaozTWVBeseWJadij9mMmPOhmx6DhdxrXL8AaPhHQCsQbJgRk2BUo07e
         rlGa1F9pn6LkglqFppyEpUGK/X1jeXg9xXvBcEF+C+Mz577adpB8NhnZSjeFRqo92LVF
         c7d2SqfhVDrAOpI4SK/EoxhX0Msc61L8Mw9g+B5BmKLqmdOLM8Pfu0jExRFs4t8fioKK
         flxg==
X-Gm-Message-State: AOJu0YxOLN7UUF2QIcT1SZFQRvq2ChdLnVg3Q79674jkN4+PZKPESzVX
	qu+snp6K1cE5KhxlYSi5ttKI5g==
X-Google-Smtp-Source: AGHT+IE+/gopdCeRqX2ZLTiEmHD7EyIZA7Be3leEJNgA57snVIb7lSjmSVBIiwYaqPEsVcNn/g1Isg==
X-Received: by 2002:a05:6a20:42aa:b0:18f:97c:b9e9 with SMTP id o42-20020a056a2042aa00b0018f097cb9e9mr2313051pzj.67.1701947071778;
        Thu, 07 Dec 2023 03:04:31 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id pm2-20020a17090b3c4200b00285db538b17sm1034254pjb.41.2023.12.07.03.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:04:31 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/6] RDMA/bnxt_re: Update the HW interface definitions
Date: Thu,  7 Dec 2023 02:47:37 -0800
Message-Id: <1701946060-13931-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
References: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a9cea6060be96e95"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--000000000000a9cea6060be96e95

Adds HW interface definitions to support the new
chip revision.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/roce_hsi.h | 67 +++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 84b5acd..605c946 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -555,7 +555,12 @@ struct cmdq_modify_qp {
 	__le16	flags;
 	__le16	cookie;
 	u8	resp_size;
-	u8	reserved8;
+	u8	qp_type;
+	#define CMDQ_MODIFY_QP_QP_TYPE_RC            0x2UL
+	#define CMDQ_MODIFY_QP_QP_TYPE_UD            0x4UL
+	#define CMDQ_MODIFY_QP_QP_TYPE_RAW_ETHERTYPE 0x6UL
+	#define CMDQ_MODIFY_QP_QP_TYPE_GSI           0x7UL
+	#define CMDQ_MODIFY_QP_QP_TYPE_LAST         CMDQ_MODIFY_QP_QP_TYPE_GSI
 	__le64	resp_addr;
 	__le32	modify_mask;
 	#define CMDQ_MODIFY_QP_MODIFY_MASK_STATE                   0x1UL
@@ -611,14 +616,12 @@ struct cmdq_modify_qp {
 	#define CMDQ_MODIFY_QP_NETWORK_TYPE_ROCEV2_IPV6  (0x3UL << 6)
 	#define CMDQ_MODIFY_QP_NETWORK_TYPE_LAST        CMDQ_MODIFY_QP_NETWORK_TYPE_ROCEV2_IPV6
 	u8	access;
-	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC_REMOTE_READ_REMOTE_WRITE_LOCAL_WRITE_MASK \
-		0xffUL
-	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC_REMOTE_READ_REMOTE_WRITE_LOCAL_WRITE_SFT	\
-		0
-	#define CMDQ_MODIFY_QP_ACCESS_LOCAL_WRITE	0x1UL
-	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_WRITE	0x2UL
-	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_READ	0x4UL
-	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC	0x8UL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC_REMOTE_READ_REMOTE_WRITE_LOCAL_WRITE_MASK 0xffUL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC_REMOTE_READ_REMOTE_WRITE_LOCAL_WRITE_SFT 0
+	#define CMDQ_MODIFY_QP_ACCESS_LOCAL_WRITE   0x1UL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_WRITE  0x2UL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_READ   0x4UL
+	#define CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC 0x8UL
 	__le16	pkey;
 	__le32	qkey;
 	__le32	dgid[4];
@@ -673,6 +676,13 @@ struct cmdq_modify_qp {
 	#define CMDQ_MODIFY_QP_VLAN_PCP_SFT 13
 	__le64	irrq_addr;
 	__le64	orrq_addr;
+	__le32	ext_modify_mask;
+	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_EXT_STATS_CTX     0x1UL
+	#define CMDQ_MODIFY_QP_EXT_MODIFY_MASK_SCHQ_ID_VALID     0x2UL
+	__le32	ext_stats_ctx_id;
+	__le16	schq_id;
+	__le16	unused_0;
+	__le32	reserved32;
 };
 
 /* creq_modify_qp_resp (size:128b/16B) */
@@ -3075,6 +3085,17 @@ struct sq_psn_search_ext {
 	__le32	reserved32;
 };
 
+/* sq_msn_search (size:64b/8B) */
+struct sq_msn_search {
+	__le64	start_idx_next_psn_start_psn;
+	#define SQ_MSN_SEARCH_START_PSN_MASK 0xffffffUL
+	#define SQ_MSN_SEARCH_START_PSN_SFT 0
+	#define SQ_MSN_SEARCH_NEXT_PSN_MASK 0xffffff000000ULL
+	#define SQ_MSN_SEARCH_NEXT_PSN_SFT  24
+	#define SQ_MSN_SEARCH_START_IDX_MASK 0xffff000000000000ULL
+	#define SQ_MSN_SEARCH_START_IDX_SFT 48
+};
+
 /* sq_send (size:1024b/128B) */
 struct sq_send {
 	u8	wqe_type;
@@ -3763,13 +3784,35 @@ struct cq_base {
 	#define CQ_BASE_CQE_TYPE_RES_UD          (0x2UL << 1)
 	#define CQ_BASE_CQE_TYPE_RES_RAWETH_QP1  (0x3UL << 1)
 	#define CQ_BASE_CQE_TYPE_RES_UD_CFA      (0x4UL << 1)
+	#define CQ_BASE_CQE_TYPE_REQ_V3             (0x8UL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_RC_V3          (0x9UL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_UD_V3          (0xaUL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_RAWETH_QP1_V3  (0xbUL << 1)
+	#define CQ_BASE_CQE_TYPE_RES_UD_CFA_V3      (0xcUL << 1)
 	#define CQ_BASE_CQE_TYPE_NO_OP           (0xdUL << 1)
 	#define CQ_BASE_CQE_TYPE_TERMINAL        (0xeUL << 1)
 	#define CQ_BASE_CQE_TYPE_CUT_OFF         (0xfUL << 1)
 	#define CQ_BASE_CQE_TYPE_LAST           CQ_BASE_CQE_TYPE_CUT_OFF
 	u8	status;
+	#define CQ_BASE_STATUS_OK                         0x0UL
+	#define CQ_BASE_STATUS_BAD_RESPONSE_ERR           0x1UL
+	#define CQ_BASE_STATUS_LOCAL_LENGTH_ERR           0x2UL
+	#define CQ_BASE_STATUS_HW_LOCAL_LENGTH_ERR        0x3UL
+	#define CQ_BASE_STATUS_LOCAL_QP_OPERATION_ERR     0x4UL
+	#define CQ_BASE_STATUS_LOCAL_PROTECTION_ERR       0x5UL
+	#define CQ_BASE_STATUS_LOCAL_ACCESS_ERROR         0x6UL
+	#define CQ_BASE_STATUS_MEMORY_MGT_OPERATION_ERR   0x7UL
+	#define CQ_BASE_STATUS_REMOTE_INVALID_REQUEST_ERR 0x8UL
+	#define CQ_BASE_STATUS_REMOTE_ACCESS_ERR          0x9UL
+	#define CQ_BASE_STATUS_REMOTE_OPERATION_ERR       0xaUL
+	#define CQ_BASE_STATUS_RNR_NAK_RETRY_CNT_ERR      0xbUL
+	#define CQ_BASE_STATUS_TRANSPORT_RETRY_CNT_ERR    0xcUL
+	#define CQ_BASE_STATUS_WORK_REQUEST_FLUSHED_ERR   0xdUL
+	#define CQ_BASE_STATUS_HW_FLUSH_ERR               0xeUL
+	#define CQ_BASE_STATUS_OVERFLOW_ERR               0xfUL
+	#define CQ_BASE_STATUS_LAST                      CQ_BASE_STATUS_OVERFLOW_ERR
 	__le16	reserved16;
-	__le32	reserved32;
+	__le32	opaque;
 };
 
 /* cq_req (size:256b/32B) */
@@ -4384,6 +4427,8 @@ struct cq_cutoff {
 	#define CQ_CUTOFF_CQE_TYPE_SFT    1
 	#define CQ_CUTOFF_CQE_TYPE_CUT_OFF  (0xfUL << 1)
 	#define CQ_CUTOFF_CQE_TYPE_LAST    CQ_CUTOFF_CQE_TYPE_CUT_OFF
+	#define CQ_CUTOFF_RESIZE_TOGGLE_MASK 0x60UL
+	#define CQ_CUTOFF_RESIZE_TOGGLE_SFT 5
 	u8	status;
 	#define CQ_CUTOFF_STATUS_OK 0x0UL
 	#define CQ_CUTOFF_STATUS_LAST CQ_CUTOFF_STATUS_OK
@@ -4435,6 +4480,8 @@ struct nq_srq_event {
 	#define NQ_SRQ_EVENT_TYPE_SFT      0
 	#define NQ_SRQ_EVENT_TYPE_SRQ_EVENT  0x32UL
 	#define NQ_SRQ_EVENT_TYPE_LAST      NQ_SRQ_EVENT_TYPE_SRQ_EVENT
+	#define NQ_SRQ_EVENT_TOGGLE_MASK   0xc0UL
+	#define NQ_SRQ_EVENT_TOGGLE_SFT    6
 	u8	event;
 	#define NQ_SRQ_EVENT_EVENT_SRQ_THRESHOLD_EVENT 0x1UL
 	#define NQ_SRQ_EVENT_EVENT_LAST               NQ_SRQ_EVENT_EVENT_SRQ_THRESHOLD_EVENT
-- 
2.5.5


--000000000000a9cea6060be96e95
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPN0nJYRjbS1
MCDBi/dRMjNKcVb6wNVU+eQyaCEIPAyTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTIwNzExMDQzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBu0U1jeO6bLMADmy5K4eWSpd0tOAS4
Z6Vj5kg/AK7NfpxKyKWWYiuBfAVhTTs+ki+z5KkgM5uERjmOLR97HSjOMQJVwLjKRzn8eI8jr7tA
iRZJggELHWyUBcjcJxxFNSaG15BB6cYvjscBN90tMfNjRJ3ZFCQXhdoq7zOIte+Am7aXprjJNfgf
5WeYJBnwldiOf6mNe86H5iwuowCc+MWP1/5RVt8lPcKU3vEJZG9VykIVXoRGHfCBd9INoSe0p0Pb
HnC4oQjG+TYn0Aku2gAt6hLlbhT5VJ1NhV4fpKVn+ZZtX8w5SQxGzrDmeJPzuojlWNyH8OP/gYgf
fJWdsnlk
--000000000000a9cea6060be96e95--

