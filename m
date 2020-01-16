Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0213E33B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbgAPRAv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 12:00:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33576 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387924AbgAPRAv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 12:00:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id d71so19800518qkc.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=23vqqNJ4RwvOyOTUiR6u3MwV+H1hO+4SoCgbpxBqDL4=;
        b=dtaKWJnF1NMtYYNZGBStKU1xejqXQI78OtqOOzlycM9nrTLWSXMXiFTV9pksZPfZuJ
         Adj/h2sItkdoYnhivZyDzQw8Ai3BgFI1Dqv2QkYYclEO3tLUNDo95r66HQwPwhufyEuq
         bsj2UwOlD65p5YPbZIW+mmhuRs5pgRj0CgToaxwbh4+VE2chhPDCHhvwu9zjMAkknvpv
         8pZq972UEvORmL8EomzT9lhJHi2l63lFFxFXPZUicf+rRjROOXBJqPuG3lne01t6A912
         dqZ58yjK37j+SuJa+1FOxTlfUO1yVsZwpyo7VSHriwlMC/gOuSqlaYtSo6VS0nA+XCgg
         1V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23vqqNJ4RwvOyOTUiR6u3MwV+H1hO+4SoCgbpxBqDL4=;
        b=h8/q2p79SdDR6WCjRu+smqL5ZJmDAes0HsS819HXNFXlq1jM10gcl3UJQdyCZQzlUb
         nNKonN7tYHuY5MDV4p0Y1QHJxanPPwi9M6eZDexdvrQ7xLdwUQaHRvYXrptuOrSbd9Gi
         qHoTIJT7P8LLddrCqcIgkrDqMGjRAlwFO46QMnfRJyhOa04T/R3iDsY5+5DFC/yHjV3w
         OFWQXPcgIMLXCECDHoGe0qFayBJwFRzcrG8+ZlJQurvlN1sPsiq19lCGCN3B+rEphWBe
         TgBZzUF8FgMIok5lVqSsmqM9ziuYFUOFRuR3mqBh0NLPAPFiWu3pUM8FI+MT/AV5LXjg
         rXCQ==
X-Gm-Message-State: APjAAAUMjJbaBB5qeXNccAgJzdLj7Dz2fwqjK9r3cwvkdwgQM8ru1m0l
        3mBYpj4ynxZ6jlMsEQcBbNtnPO2HCbE=
X-Google-Smtp-Source: APXvYqy3CZ1rSmq0P1g58CKOAYaRpxJROZERrlvryGbyz9TZ7SopLbTTCU8aow9lnTB9/hiBdbZ2xg==
X-Received: by 2002:a37:6fc4:: with SMTP id k187mr32529342qkc.21.1579194049334;
        Thu, 16 Jan 2020 09:00:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j4sm11055184qtv.53.2020.01.16.09.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 09:00:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8Vc-0007tm-9w; Thu, 16 Jan 2020 13:00:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 7/7] RDMA/cm: Remove CM message structs
Date:   Thu, 16 Jan 2020 13:00:37 -0400
Message-Id: <20200116170037.30109-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116170037.30109-1-jgg@ziepe.ca>
References: <20200116170037.30109-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

All accesses now use the new IBA acessor scheme, so delete the structs
entirely and generate the structures from the schema file.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  77 -----------
 drivers/infiniband/core/cm_msgs.h | 211 ------------------------------
 include/rdma/ibta_vol1_c12.h      |   7 +-
 3 files changed, 6 insertions(+), 289 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 5ccd59f1ebb874..68cc1b2d68240d 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4426,83 +4426,6 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 	kfree(cm_dev);
 }
 
-/*
- * Check at compile time that the byte offset and length of field old_name in
- * the struct matches the byte offset and length in the new macro.
- */
-#define _IBA_CHECK_OFF(old_name, field_struct, field_offset, mask, bits) \
-	static_assert(offsetof(field_struct, old_name) == (field_offset));     \
-	static_assert(bits == sizeof(((field_struct *)0)->old_name) * 8)
-#define IBA_CHECK_OFF(field, old_name) _IBA_CHECK_OFF(old_name, field)
-
-IBA_CHECK_OFF(CM_REQ_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_REQ_SERVICE_ID, service_id);
-IBA_CHECK_OFF(CM_REQ_LOCAL_CA_GUID, local_ca_guid);
-IBA_CHECK_OFF(CM_REQ_LOCAL_Q_KEY, local_qkey);
-IBA_CHECK_OFF(CM_REQ_PARTITION_KEY, pkey);
-IBA_CHECK_OFF(CM_REQ_PRIMARY_LOCAL_PORT_LID, primary_local_lid);
-IBA_CHECK_OFF(CM_REQ_PRIMARY_REMOTE_PORT_LID, primary_remote_lid);
-IBA_CHECK_OFF(CM_REQ_PRIMARY_LOCAL_PORT_GID, primary_local_gid);
-IBA_CHECK_OFF(CM_REQ_PRIMARY_REMOTE_PORT_GID, primary_remote_gid);
-IBA_CHECK_OFF(CM_REQ_PRIMARY_TRAFFIC_CLASS, primary_traffic_class);
-IBA_CHECK_OFF(CM_REQ_PRIMARY_HOP_LIMIT, primary_hop_limit);
-IBA_CHECK_OFF(CM_REQ_ALTERNATE_LOCAL_PORT_LID, alt_local_lid);
-IBA_CHECK_OFF(CM_REQ_ALTERNATE_REMOTE_PORT_LID, alt_remote_lid);
-IBA_CHECK_OFF(CM_REQ_ALTERNATE_LOCAL_PORT_GID, alt_local_gid);
-IBA_CHECK_OFF(CM_REQ_ALTERNATE_REMOTE_PORT_GID, alt_remote_gid);
-IBA_CHECK_OFF(CM_REQ_ALTERNATE_TRAFFIC_CLASS, alt_traffic_class);
-IBA_CHECK_OFF(CM_REQ_ALTERNATE_HOP_LIMIT, alt_hop_limit);
-IBA_CHECK_OFF(CM_REQ_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_MRA_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_MRA_REMOTE_COMM_ID, remote_comm_id);
-IBA_CHECK_OFF(CM_MRA_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_REJ_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_REJ_REMOTE_COMM_ID, remote_comm_id);
-IBA_CHECK_OFF(CM_REJ_REASON, reason);
-IBA_CHECK_OFF(CM_REJ_ARI, ari);
-IBA_CHECK_OFF(CM_REJ_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_REP_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_REP_REMOTE_COMM_ID, remote_comm_id);
-IBA_CHECK_OFF(CM_REP_LOCAL_Q_KEY, local_qkey);
-IBA_CHECK_OFF(CM_REP_RESPONDER_RESOURCES, resp_resources);
-IBA_CHECK_OFF(CM_REP_INITIATOR_DEPTH, initiator_depth);
-IBA_CHECK_OFF(CM_REP_LOCAL_CA_GUID, local_ca_guid);
-IBA_CHECK_OFF(CM_REP_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_RTU_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_RTU_REMOTE_COMM_ID, remote_comm_id);
-IBA_CHECK_OFF(CM_RTU_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_DREQ_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_DREQ_REMOTE_COMM_ID, remote_comm_id);
-IBA_CHECK_OFF(CM_DREQ_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_DREP_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_DREP_REMOTE_COMM_ID, remote_comm_id);
-IBA_CHECK_OFF(CM_DREP_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_LAP_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_LAP_REMOTE_COMM_ID, remote_comm_id);
-IBA_CHECK_OFF(CM_LAP_ALTERNATE_LOCAL_PORT_LID, alt_local_lid);
-IBA_CHECK_OFF(CM_LAP_ALTERNATE_REMOTE_PORT_LID, alt_remote_lid);
-IBA_CHECK_OFF(CM_LAP_ALTERNATE_LOCAL_PORT_GID, alt_local_gid);
-IBA_CHECK_OFF(CM_LAP_ALTERNATE_REMOTE_PORT_GID, alt_remote_gid);
-IBA_CHECK_OFF(CM_LAP_ALTERNATE_HOP_LIMIT, alt_hop_limit);
-IBA_CHECK_OFF(CM_LAP_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_APR_LOCAL_COMM_ID, local_comm_id);
-IBA_CHECK_OFF(CM_APR_REMOTE_COMM_ID, remote_comm_id);
-IBA_CHECK_OFF(CM_APR_ADDITIONAL_INFORMATION_LENGTH, info_length);
-IBA_CHECK_OFF(CM_APR_AR_STATUS, ap_status);
-IBA_CHECK_OFF(CM_APR_ADDITIONAL_INFORMATION, info);
-IBA_CHECK_OFF(CM_APR_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_SIDR_REQ_REQUESTID, request_id);
-IBA_CHECK_OFF(CM_SIDR_REQ_PARTITION_KEY, pkey);
-IBA_CHECK_OFF(CM_SIDR_REQ_SERVICEID, service_id);
-IBA_CHECK_OFF(CM_SIDR_REQ_PRIVATE_DATA, private_data);
-IBA_CHECK_OFF(CM_SIDR_REP_REQUESTID, request_id);
-IBA_CHECK_OFF(CM_SIDR_REP_STATUS, status);
-IBA_CHECK_OFF(CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH, info_length);
-IBA_CHECK_OFF(CM_SIDR_REP_SERVICEID, service_id);
-IBA_CHECK_OFF(CM_SIDR_REP_Q_KEY, qkey);
-IBA_CHECK_OFF(CM_SIDR_REP_ADDITIONAL_INFORMATION, info);
-IBA_CHECK_OFF(CM_SIDR_REP_PRIVATE_DATA, private_data);
-
 static int __init ib_cm_init(void)
 {
 	int ret;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 86ab6952d5d80a..0cc40656b5c5f3 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -19,62 +19,6 @@
 
 #define IB_CM_CLASS_VERSION	2 /* IB specification 1.2 */
 
-struct cm_req_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 rsvd4;
-	__be64 service_id;
-	__be64 local_ca_guid;
-	__be32 rsvd24;
-	__be32 local_qkey;
-	/* local QPN:24, responder resources:8 */
-	__be32 offset32;
-	/* local EECN:24, initiator depth:8 */
-	__be32 offset36;
-	/*
-	 * remote EECN:24, remote CM response timeout:5,
-	 * transport service type:2, end-to-end flow control:1
-	 */
-	__be32 offset40;
-	/* starting PSN:24, local CM response timeout:5, retry count:3 */
-	__be32 offset44;
-	__be16 pkey;
-	/* path MTU:4, RDC exists:1, RNR retry count:3. */
-	u8 offset50;
-	/* max CM Retries:4, SRQ:1, extended transport type:3 */
-	u8 offset51;
-
-	__be16 primary_local_lid;
-	__be16 primary_remote_lid;
-	union ib_gid primary_local_gid;
-	union ib_gid primary_remote_gid;
-	/* flow label:20, rsvd:6, packet rate:6 */
-	__be32 primary_offset88;
-	u8 primary_traffic_class;
-	u8 primary_hop_limit;
-	/* SL:4, subnet local:1, rsvd:3 */
-	u8 primary_offset94;
-	/* local ACK timeout:5, rsvd:3 */
-	u8 primary_offset95;
-
-	__be16 alt_local_lid;
-	__be16 alt_remote_lid;
-	union ib_gid alt_local_gid;
-	union ib_gid alt_remote_gid;
-	/* flow label:20, rsvd:6, packet rate:6 */
-	__be32 alt_offset132;
-	u8 alt_traffic_class;
-	u8 alt_hop_limit;
-	/* SL:4, subnet local:1, rsvd:3 */
-	u8 alt_offset138;
-	/* local ACK timeout:5, rsvd:3 */
-	u8 alt_offset139;
-
-	u32 private_data[IB_CM_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
-
-} __packed;
-
 static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
 {
 	u8 transport_type = IBA_GET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg);
@@ -113,60 +57,6 @@ enum cm_msg_response {
 	CM_MSG_RESPONSE_OTHER = 0x2
 };
 
- struct cm_mra_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 remote_comm_id;
-	/* message MRAed:2, rsvd:6 */
-	u8 offset8;
-	/* service timeout:5, rsvd:3 */
-	u8 offset9;
-
-	u8 private_data[IB_CM_MRA_PRIVATE_DATA_SIZE];
-
-} __packed;
-
-struct cm_rej_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 remote_comm_id;
-	/* message REJected:2, rsvd:6 */
-	u8 offset8;
-	/* reject info length:7, rsvd:1. */
-	u8 offset9;
-	__be16 reason;
-	u8 ari[IB_CM_REJ_ARI_LENGTH];
-
-	u8 private_data[IB_CM_REJ_PRIVATE_DATA_SIZE];
-
-} __packed;
-
-struct cm_rep_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 remote_comm_id;
-	__be32 local_qkey;
-	/* local QPN:24, rsvd:8 */
-	__be32 offset12;
-	/* local EECN:24, rsvd:8 */
-	__be32 offset16;
-	/* starting PSN:24 rsvd:8 */
-	__be32 offset20;
-	u8 resp_resources;
-	u8 initiator_depth;
-	/* target ACK delay:5, failover accepted:2, end-to-end flow control:1 */
-	u8 offset26;
-	/* RNR retry count:3, SRQ:1, rsvd:5 */
-	u8 offset27;
-	__be64 local_ca_guid;
-
-	u8 private_data[IB_CM_REP_PRIVATE_DATA_SIZE];
-
-} __packed;
-
 static inline __be32 cm_rep_get_qpn(struct cm_rep_msg *rep_msg, enum ib_qp_type qp_type)
 {
 	return (qp_type == IB_QPT_XRC_INI) ?
@@ -175,105 +65,4 @@ static inline __be32 cm_rep_get_qpn(struct cm_rep_msg *rep_msg, enum ib_qp_type
 		       cpu_to_be32(IBA_GET(CM_REP_LOCAL_QPN, rep_msg));
 }
 
-struct cm_rtu_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 remote_comm_id;
-
-	u8 private_data[IB_CM_RTU_PRIVATE_DATA_SIZE];
-
-} __packed;
-
-struct cm_dreq_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 remote_comm_id;
-	/* remote QPN/EECN:24, rsvd:8 */
-	__be32 offset8;
-
-	u8 private_data[IB_CM_DREQ_PRIVATE_DATA_SIZE];
-
-} __packed;
-
-struct cm_drep_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 remote_comm_id;
-
-	u8 private_data[IB_CM_DREP_PRIVATE_DATA_SIZE];
-
-} __packed;
-
-struct cm_lap_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 remote_comm_id;
-
-	__be32 rsvd8;
-	/* remote QPN/EECN:24, remote CM response timeout:5, rsvd:3 */
-	__be32 offset12;
-	__be32 rsvd16;
-
-	__be16 alt_local_lid;
-	__be16 alt_remote_lid;
-	union ib_gid alt_local_gid;
-	union ib_gid alt_remote_gid;
-	/* flow label:20, rsvd:4, traffic class:8 */
-	__be32 offset56;
-	u8 alt_hop_limit;
-	/* rsvd:2, packet rate:6 */
-	u8 offset61;
-	/* SL:4, subnet local:1, rsvd:3 */
-	u8 offset62;
-	/* local ACK timeout:5, rsvd:3 */
-	u8 offset63;
-
-	u8 private_data[IB_CM_LAP_PRIVATE_DATA_SIZE];
-} __packed;
-
-struct cm_apr_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 local_comm_id;
-	__be32 remote_comm_id;
-
-	u8 info_length;
-	u8 ap_status;
-	__be16 rsvd;
-	u8 info[IB_CM_APR_INFO_LENGTH];
-
-	u8 private_data[IB_CM_APR_PRIVATE_DATA_SIZE];
-} __packed;
-
-struct cm_sidr_req_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 request_id;
-	__be16 pkey;
-	__be16 rsvd;
-	__be64 service_id;
-
-	u32 private_data[IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
-} __packed;
-
-struct cm_sidr_rep_msg {
-	struct ib_mad_hdr hdr;
-
-	__be32 request_id;
-	u8 status;
-	u8 info_length;
-	__be16 rsvd;
-	/* QPN:24, rsvd:8 */
-	__be32 offset8;
-	__be64 service_id;
-	__be32 qkey;
-	u8 info[IB_CM_SIDR_REP_INFO_LENGTH];
-
-	u8 private_data[IB_CM_SIDR_REP_PRIVATE_DATA_SIZE];
-} __packed;
-
 #endif /* CM_MSGS_H */
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 916db5c27dc5d2..e5009933da824b 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -29,7 +29,12 @@
 	IBA_FIELD_MLOC(field_struct,                                           \
 		       (byte_offset + sizeof(struct ib_mad_hdr)), width, type)
 #define CM_STRUCT(field_struct, total_len)                                     \
-	static_assert((total_len) % 32 == 0);
+	static_assert((total_len) % 32 == 0);                                  \
+	field_struct                                                           \
+	{                                                                      \
+		struct ib_mad_hdr hdr;                                         \
+		u32 _data[(total_len) / 32];                                   \
+	}
 
 /* Table 106 REQ Message Contents */
 #define CM_REQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_req_msg, 0, 32)
-- 
2.24.1

