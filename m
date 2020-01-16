Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA1813F718
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgAPTJW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:09:22 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41984 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbgAPRAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 12:00:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so19399590qtq.9
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 09:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nn/Ez0Q6O2BFBa/MAL0WJl6l0h/Lk6sHECx9PnZNXyg=;
        b=OJTJ9mmoYHWOhIKGOu47PxmwT9mggRj9zr3uxSaMBifDJq5wn5hS7RD57WJwXh59xP
         LQRnHsHj7fHBamRuEfY+cfpvdiXKw4Qq2J09+rnex532EedLd1CXjatKX3ObaoBGh+4a
         CMqSeKEhxpAa43hh1PAVrrZdPuIqPr3eFkLPftjBVXdAJw+xW9EV/emv03lV0ycY5/sC
         MPlbtQWDwsubu86r7TVfTJ7Uhns215cOmx6gUfP/KTThHFj58iw2Sx3mOpicpIpDWnbz
         iB6+yOTbv19gbBMzfmdvMiZR3ep2h4q4NMtblo1DeXMlKxL6Ji11mX+QxjOLRRE0cIXi
         0m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nn/Ez0Q6O2BFBa/MAL0WJl6l0h/Lk6sHECx9PnZNXyg=;
        b=JN8BM3zRnF9iuzsoL75hKcNUMoUQYZ8KK9hIv7FJD2KBOFYTP2YdqS0LczXsuT5pXp
         ECzp/kKi8tV82XgoVQCcmkwSkqb+EMpCTpO1pSjHaWgA/vOga3MIgd5mVJL+vXB8JXw9
         GDn0myjExdL/s+bgZoZ0HykHt1/8A97YUJqp3inEX+6CetT6cB8iezw/XOONG9qlPper
         QCQXUj/mzRT5HgSmgHvceLjvoahVVH0jFcezHpTbWqXV5oOfRAtfOcTLbQqvy21iQsNK
         lkhlo2KJIEAc1OUvmuyfrZrtqW1Pq7dPhgXhSblyqGPRBrIzRQgNTdVJNFdSp0+kkyy1
         gHtg==
X-Gm-Message-State: APjAAAXROkqKaxLpwvfGzS+5lNZaYyBNbuWQPmHHSFqDp9uhnSzkj/ov
        aAaxlNShcT9sVJshe14ab1Z/mHX1spU=
X-Google-Smtp-Source: APXvYqwAb9Q5QeK3hEFttfZu6Z17KmxsanaxZmvnWCQ9iL2/nxBeGnIg5ag0j1hj9Dj9dMT/qY9tBQ==
X-Received: by 2002:ac8:2afb:: with SMTP id c56mr3461579qta.112.1579194045510;
        Thu, 16 Jan 2020 09:00:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h32sm11763601qth.2.2020.01.16.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 09:00:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8Vc-0007tI-1E; Thu, 16 Jan 2020 13:00:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 2/7] RDMA/cm: Add SET/GET implementations to hide IBA wire format
Date:   Thu, 16 Jan 2020 13:00:32 -0400
Message-Id: <20200116170037.30109-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116170037.30109-1-jgg@ziepe.ca>
References: <20200116170037.30109-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no separation between RDMA-CM wire format as it is declared in
IBTA and kernel logic which implements needed support. Such situation
causes to many mistakes in conversion between big-endian (wire format)
and CPU format used by kernel. It also mixes RDMA core code with
combination of uXX and beXX variables.

The idea that all accesses to IBA definitions will go through special
GET/SET macros to ensure that no conversion mistakes are made. The
shifting and masking required to read the value is automatically deduced
using the field offset description from the tables in the IBA
specification.

This starts with the CM MADs described in IBTA release 1.3 volume 1.

To confirm that the new macros behave the same as the old accessors a
self-test is included in this patch.

Each macro replacing a straightforward struct field compile-time tests
that the new field has the same offsetof() and width as the old field.

For the fields with accessor functions a runtime test, the 'all ones'
value is placed in a dummy message and read back in several ways to
confirm that both approaches give identical results.

Later patches in this series delete the self test.

This creates a tested table of new field name, old field name(s) and some
meta information like BE coding for the functions which will be used in
the next patches.

Link: https://lore.kernel.org/r/20191212093830.316934-5-leon@kernel.org
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 267 ++++++++++++++++++++++++++++++
 drivers/infiniband/core/cm_msgs.h |   1 +
 include/rdma/iba.h                | 146 ++++++++++++++++
 include/rdma/ibta_vol1_c12.h      | 208 +++++++++++++++++++++++
 4 files changed, 622 insertions(+)
 create mode 100644 include/rdma/iba.h
 create mode 100644 include/rdma/ibta_vol1_c12.h

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d396b987b0f2d4..7f609979e4debf 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4253,10 +4253,277 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 	kfree(cm_dev);
 }
 
+/*
+ * Check at compile time that the byte offset and length of field old_name in
+ * the struct matches the byte offset and length in the new macro.
+ */
+#define _IBA_CHECK_OFF(old_name, field_struct, field_offset, mask, bits) \
+	static_assert(offsetof(field_struct, old_name) == (field_offset));     \
+	static_assert(bits == sizeof(((field_struct *)0)->old_name) * 8)
+#define IBA_CHECK_OFF(field, old_name) _IBA_CHECK_OFF(old_name, field)
+
+IBA_CHECK_OFF(CM_REQ_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_REQ_SERVICE_ID, service_id);
+IBA_CHECK_OFF(CM_REQ_LOCAL_CA_GUID, local_ca_guid);
+IBA_CHECK_OFF(CM_REQ_LOCAL_Q_KEY, local_qkey);
+IBA_CHECK_OFF(CM_REQ_PARTITION_KEY, pkey);
+IBA_CHECK_OFF(CM_REQ_PRIMARY_LOCAL_PORT_LID, primary_local_lid);
+IBA_CHECK_OFF(CM_REQ_PRIMARY_REMOTE_PORT_LID, primary_remote_lid);
+IBA_CHECK_OFF(CM_REQ_PRIMARY_LOCAL_PORT_GID, primary_local_gid);
+IBA_CHECK_OFF(CM_REQ_PRIMARY_REMOTE_PORT_GID, primary_remote_gid);
+IBA_CHECK_OFF(CM_REQ_PRIMARY_TRAFFIC_CLASS, primary_traffic_class);
+IBA_CHECK_OFF(CM_REQ_PRIMARY_HOP_LIMIT, primary_hop_limit);
+IBA_CHECK_OFF(CM_REQ_ALTERNATE_LOCAL_PORT_LID, alt_local_lid);
+IBA_CHECK_OFF(CM_REQ_ALTERNATE_REMOTE_PORT_LID, alt_remote_lid);
+IBA_CHECK_OFF(CM_REQ_ALTERNATE_LOCAL_PORT_GID, alt_local_gid);
+IBA_CHECK_OFF(CM_REQ_ALTERNATE_REMOTE_PORT_GID, alt_remote_gid);
+IBA_CHECK_OFF(CM_REQ_ALTERNATE_TRAFFIC_CLASS, alt_traffic_class);
+IBA_CHECK_OFF(CM_REQ_ALTERNATE_HOP_LIMIT, alt_hop_limit);
+IBA_CHECK_OFF(CM_REQ_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_MRA_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_MRA_REMOTE_COMM_ID, remote_comm_id);
+IBA_CHECK_OFF(CM_MRA_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_REJ_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_REJ_REMOTE_COMM_ID, remote_comm_id);
+IBA_CHECK_OFF(CM_REJ_REASON, reason);
+IBA_CHECK_OFF(CM_REJ_ARI, ari);
+IBA_CHECK_OFF(CM_REJ_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_REP_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_REP_REMOTE_COMM_ID, remote_comm_id);
+IBA_CHECK_OFF(CM_REP_LOCAL_Q_KEY, local_qkey);
+IBA_CHECK_OFF(CM_REP_RESPONDER_RESOURCES, resp_resources);
+IBA_CHECK_OFF(CM_REP_INITIATOR_DEPTH, initiator_depth);
+IBA_CHECK_OFF(CM_REP_LOCAL_CA_GUID, local_ca_guid);
+IBA_CHECK_OFF(CM_REP_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_RTU_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_RTU_REMOTE_COMM_ID, remote_comm_id);
+IBA_CHECK_OFF(CM_RTU_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_DREQ_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_DREQ_REMOTE_COMM_ID, remote_comm_id);
+IBA_CHECK_OFF(CM_DREQ_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_DREP_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_DREP_REMOTE_COMM_ID, remote_comm_id);
+IBA_CHECK_OFF(CM_DREP_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_LAP_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_LAP_REMOTE_COMM_ID, remote_comm_id);
+IBA_CHECK_OFF(CM_LAP_ALTERNATE_LOCAL_PORT_LID, alt_local_lid);
+IBA_CHECK_OFF(CM_LAP_ALTERNATE_REMOTE_PORT_LID, alt_remote_lid);
+IBA_CHECK_OFF(CM_LAP_ALTERNATE_LOCAL_PORT_GID, alt_local_gid);
+IBA_CHECK_OFF(CM_LAP_ALTERNATE_REMOTE_PORT_GID, alt_remote_gid);
+IBA_CHECK_OFF(CM_LAP_ALTERNATE_HOP_LIMIT, alt_hop_limit);
+IBA_CHECK_OFF(CM_LAP_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_APR_LOCAL_COMM_ID, local_comm_id);
+IBA_CHECK_OFF(CM_APR_REMOTE_COMM_ID, remote_comm_id);
+IBA_CHECK_OFF(CM_APR_ADDITIONAL_INFORMATION_LENGTH, info_length);
+IBA_CHECK_OFF(CM_APR_AR_STATUS, ap_status);
+IBA_CHECK_OFF(CM_APR_ADDITIONAL_INFORMATION, info);
+IBA_CHECK_OFF(CM_APR_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_SIDR_REQ_REQUESTID, request_id);
+IBA_CHECK_OFF(CM_SIDR_REQ_PARTITION_KEY, pkey);
+IBA_CHECK_OFF(CM_SIDR_REQ_SERVICEID, service_id);
+IBA_CHECK_OFF(CM_SIDR_REQ_PRIVATE_DATA, private_data);
+IBA_CHECK_OFF(CM_SIDR_REP_REQUESTID, request_id);
+IBA_CHECK_OFF(CM_SIDR_REP_STATUS, status);
+IBA_CHECK_OFF(CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH, info_length);
+IBA_CHECK_OFF(CM_SIDR_REP_SERVICEID, service_id);
+IBA_CHECK_OFF(CM_SIDR_REP_Q_KEY, qkey);
+IBA_CHECK_OFF(CM_SIDR_REP_ADDITIONAL_INFORMATION, info);
+IBA_CHECK_OFF(CM_SIDR_REP_PRIVATE_DATA, private_data);
+
+/*
+ * Check that the new macro gets the same bits as the old get function.
+ *  - IBA_SET() IBA_GET and old get_fn all agree on the field width.
+ *    The field width should match what IBA_SET truncates to
+ *  - Reading from an all ones data should not return extra bits
+ *  - Setting '1' should be the same (ie no endian problems)
+ */
+/* defeat builtin_constant checks */
+u64 cm_global_all_ones = 0xffffffffffffffffULL;
+#define _IBA_CHECK_GET(fn, field_struct, field_offset, mask, bits)             \
+	({                                                                     \
+		field_struct *lmsg = (field_struct *)msg;                      \
+		unsigned long long all_ones;                                   \
+		static_assert(sizeof(*lmsg) <= sizeof(msg));                   \
+                                                                               \
+		bitmap_zero(msg, nbits);                                       \
+		_IBA_SET(field_struct, field_offset, mask, bits, lmsg,         \
+			 cm_global_all_ones);                                  \
+		all_ones = (1ULL << bitmap_weight(msg, nbits)) - 1;            \
+		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
+		    all_ones) {                                                \
+			printk("Failed #1 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+		if (fn != all_ones) {                                          \
+			printk("Failed #2 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+                                                                               \
+		bitmap_fill(msg, nbits);                                       \
+		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
+		    all_ones) {                                                \
+			printk("Failed #3 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+		if (fn != all_ones) {                                          \
+			printk("Failed #4 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+                                                                               \
+		_IBA_SET(field_struct, field_offset, mask, bits, lmsg, 0);     \
+		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
+		    0) {                                                       \
+			printk("Failed #5 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+		if (fn != 0) {                                                 \
+			printk("Failed #6 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+		_IBA_SET(field_struct, field_offset, mask, bits, lmsg, 1);     \
+		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
+		    1) {                                                       \
+			printk("Failed #7 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+		if (fn != 1) {                                                 \
+			printk("Failed #8 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+	})
+#define IBA_CHECK_GET(field, fn_name) _IBA_CHECK_GET(fn_name(lmsg), field)
+#define IBA_CHECK_GET_BE(field, fn_name) _IBA_CHECK_GET(be32_to_cpu(fn_name(lmsg)), field)
+
+/*
+ * Write the all ones value using the old setter and check that the new getter
+ * reads it back.
+ */
+#define _IBA_CHECK_SET(fn, field_struct, field_offset, mask, bits)             \
+	({                                                                     \
+		field_struct *lmsg = (field_struct *)msg;                      \
+		unsigned long long all_ones;                                   \
+		static_assert(sizeof(*lmsg) <= sizeof(msg));                   \
+                                                                               \
+		bitmap_zero(msg, nbits);                                       \
+		_IBA_SET(field_struct, field_offset, mask, bits, lmsg,         \
+			 cm_global_all_ones);                                  \
+		all_ones = (1ULL << bitmap_weight(msg, nbits)) - 1;            \
+		bitmap_zero(msg, nbits);                                       \
+		fn;                                                            \
+		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
+		    all_ones) {                                                \
+			printk("Failed #9 line=%u\n", __LINE__);               \
+			return;                                                \
+		}                                                              \
+		all_ones = 1;                                                  \
+		fn;                                                            \
+		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
+		    1) {                                                       \
+			printk("Failed #10 line=%u\n", __LINE__);              \
+			return;                                                \
+		}                                                              \
+	})
+
+#define IBA_CHECK_SET(field, fn_name) _IBA_CHECK_SET(fn_name(lmsg, all_ones), field)
+#define IBA_CHECK_SET_BE(field, fn_name)                                       \
+	_IBA_CHECK_SET(fn_name(lmsg, cpu_to_be32(all_ones)), field)
+
+static void self_test(void)
+{
+	unsigned long msg[256/4];
+	const unsigned int nbits = sizeof(msg) * 8;
+
+	printk("Running CM extractor self test\n");
+	IBA_CHECK_GET_BE(CM_REQ_LOCAL_QPN, cm_req_get_local_qpn);
+	IBA_CHECK_SET_BE(CM_REQ_LOCAL_QPN, cm_req_set_local_qpn);
+	IBA_CHECK_GET(CM_REQ_RESPONDER_RESOURCES, cm_req_get_resp_res);
+	IBA_CHECK_SET(CM_REQ_RESPONDER_RESOURCES, cm_req_set_resp_res);
+	IBA_CHECK_GET(CM_REQ_INITIATOR_DEPTH, cm_req_get_init_depth);
+	IBA_CHECK_SET(CM_REQ_INITIATOR_DEPTH, cm_req_set_init_depth);
+	IBA_CHECK_GET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, cm_req_get_remote_resp_timeout);
+	IBA_CHECK_SET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, cm_req_set_remote_resp_timeout);
+	IBA_CHECK_GET(CM_REQ_TRANSPORT_SERVICE_TYPE, cm_req_get_transport_type);
+	IBA_CHECK_SET(CM_REQ_TRANSPORT_SERVICE_TYPE, cm_req_set_transport_type);
+	IBA_CHECK_GET(CM_REQ_END_TO_END_FLOW_CONTROL, cm_req_get_flow_ctrl);
+	IBA_CHECK_SET(CM_REQ_END_TO_END_FLOW_CONTROL, cm_req_set_flow_ctrl);
+	IBA_CHECK_GET_BE(CM_REQ_STARTING_PSN, cm_req_get_starting_psn);
+	IBA_CHECK_SET_BE(CM_REQ_STARTING_PSN, cm_req_set_starting_psn);
+	IBA_CHECK_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, cm_req_get_local_resp_timeout);
+	IBA_CHECK_SET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, cm_req_set_local_resp_timeout);
+	IBA_CHECK_GET(CM_REQ_RETRY_COUNT, cm_req_get_retry_count);
+	IBA_CHECK_SET(CM_REQ_RETRY_COUNT, cm_req_set_retry_count);
+	IBA_CHECK_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, cm_req_get_path_mtu);
+	IBA_CHECK_SET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, cm_req_set_path_mtu);
+	IBA_CHECK_GET(CM_REQ_RNR_RETRY_COUNT, cm_req_get_rnr_retry_count);
+	IBA_CHECK_SET(CM_REQ_RNR_RETRY_COUNT, cm_req_set_rnr_retry_count);
+	IBA_CHECK_GET(CM_REQ_MAX_CM_RETRIES, cm_req_get_max_cm_retries);
+	IBA_CHECK_SET(CM_REQ_MAX_CM_RETRIES, cm_req_set_max_cm_retries);
+	IBA_CHECK_GET(CM_REQ_SRQ, cm_req_get_srq);
+	IBA_CHECK_SET(CM_REQ_SRQ, cm_req_set_srq);
+	IBA_CHECK_GET(CM_REQ_EXTENDED_TRANSPORT_TYPE, cm_req_get_transport_type_ex);
+	IBA_CHECK_SET(CM_REQ_EXTENDED_TRANSPORT_TYPE, cm_req_set_transport_type_ex);
+	IBA_CHECK_GET_BE(CM_REQ_PRIMARY_FLOW_LABEL, cm_req_get_primary_flow_label);
+	IBA_CHECK_SET_BE(CM_REQ_PRIMARY_FLOW_LABEL, cm_req_set_primary_flow_label);
+	IBA_CHECK_GET(CM_REQ_PRIMARY_PACKET_RATE, cm_req_get_primary_packet_rate);
+	IBA_CHECK_SET(CM_REQ_PRIMARY_PACKET_RATE, cm_req_set_primary_packet_rate);
+	IBA_CHECK_GET(CM_REQ_PRIMARY_SL, cm_req_get_primary_sl);
+	IBA_CHECK_SET(CM_REQ_PRIMARY_SL, cm_req_set_primary_sl);
+	IBA_CHECK_GET(CM_REQ_PRIMARY_SUBNET_LOCAL, cm_req_get_primary_subnet_local);
+	IBA_CHECK_SET(CM_REQ_PRIMARY_SUBNET_LOCAL, cm_req_set_primary_subnet_local);
+	IBA_CHECK_GET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, cm_req_get_primary_local_ack_timeout);
+	IBA_CHECK_SET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, cm_req_set_primary_local_ack_timeout);
+	IBA_CHECK_GET_BE(CM_REQ_ALTERNATE_FLOW_LABEL, cm_req_get_alt_flow_label);
+	IBA_CHECK_SET_BE(CM_REQ_ALTERNATE_FLOW_LABEL, cm_req_set_alt_flow_label);
+	IBA_CHECK_GET(CM_REQ_ALTERNATE_PACKET_RATE, cm_req_get_alt_packet_rate);
+	IBA_CHECK_SET(CM_REQ_ALTERNATE_PACKET_RATE, cm_req_set_alt_packet_rate);
+	IBA_CHECK_GET(CM_REQ_ALTERNATE_SL, cm_req_get_alt_sl);
+	IBA_CHECK_SET(CM_REQ_ALTERNATE_SL, cm_req_set_alt_sl);
+	IBA_CHECK_GET(CM_REQ_ALTERNATE_SUBNET_LOCAL, cm_req_get_alt_subnet_local);
+	IBA_CHECK_SET(CM_REQ_ALTERNATE_SUBNET_LOCAL, cm_req_set_alt_subnet_local);
+	IBA_CHECK_GET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, cm_req_get_alt_local_ack_timeout);
+	IBA_CHECK_SET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, cm_req_set_alt_local_ack_timeout);
+	IBA_CHECK_GET(CM_MRA_MESSAGE_MRAED, cm_mra_get_msg_mraed);
+	IBA_CHECK_SET(CM_MRA_MESSAGE_MRAED, cm_mra_set_msg_mraed);
+	IBA_CHECK_GET(CM_MRA_SERVICE_TIMEOUT, cm_mra_get_service_timeout);
+	IBA_CHECK_SET(CM_MRA_SERVICE_TIMEOUT, cm_mra_set_service_timeout);
+	IBA_CHECK_GET(CM_REJ_MESSAGE_REJECTED, cm_rej_get_msg_rejected);
+	IBA_CHECK_SET(CM_REJ_MESSAGE_REJECTED, cm_rej_set_msg_rejected);
+	IBA_CHECK_GET(CM_REJ_REJECTED_INFO_LENGTH, cm_rej_get_reject_info_len);
+	IBA_CHECK_SET(CM_REJ_REJECTED_INFO_LENGTH, cm_rej_set_reject_info_len);
+	IBA_CHECK_GET_BE(CM_REP_LOCAL_QPN, cm_rep_get_local_qpn);
+	IBA_CHECK_SET_BE(CM_REP_LOCAL_QPN, cm_rep_set_local_qpn);
+	IBA_CHECK_GET_BE(CM_REP_LOCAL_EE_CONTEXT_NUMBER, cm_rep_get_local_eecn);
+	IBA_CHECK_SET_BE(CM_REP_LOCAL_EE_CONTEXT_NUMBER, cm_rep_set_local_eecn);
+	IBA_CHECK_GET_BE(CM_REP_STARTING_PSN, cm_rep_get_starting_psn);
+	IBA_CHECK_SET_BE(CM_REP_STARTING_PSN, cm_rep_set_starting_psn);
+	IBA_CHECK_GET(CM_REP_TARGET_ACK_DELAY, cm_rep_get_target_ack_delay);
+	IBA_CHECK_SET(CM_REP_TARGET_ACK_DELAY, cm_rep_set_target_ack_delay);
+	IBA_CHECK_GET(CM_REP_FAILOVER_ACCEPTED, cm_rep_get_failover);
+	IBA_CHECK_SET(CM_REP_FAILOVER_ACCEPTED, cm_rep_set_failover);
+	IBA_CHECK_GET(CM_REP_END_TO_END_FLOW_CONTROL, cm_rep_get_flow_ctrl);
+	IBA_CHECK_SET(CM_REP_END_TO_END_FLOW_CONTROL, cm_rep_set_flow_ctrl);
+	IBA_CHECK_GET(CM_REP_RNR_RETRY_COUNT, cm_rep_get_rnr_retry_count);
+	IBA_CHECK_SET(CM_REP_RNR_RETRY_COUNT, cm_rep_set_rnr_retry_count);
+	IBA_CHECK_GET(CM_REP_SRQ, cm_rep_get_srq);
+	IBA_CHECK_SET(CM_REP_SRQ, cm_rep_set_srq);
+	IBA_CHECK_GET_BE(CM_DREQ_REMOTE_QPN_EECN, cm_dreq_get_remote_qpn);
+	IBA_CHECK_SET_BE(CM_DREQ_REMOTE_QPN_EECN, cm_dreq_set_remote_qpn);
+	IBA_CHECK_GET_BE(CM_LAP_ALTERNATE_FLOW_LABEL, cm_lap_get_flow_label);
+	IBA_CHECK_GET(CM_LAP_ALTERNATE_TRAFFIC_CLASS, cm_lap_get_traffic_class);
+	IBA_CHECK_GET(CM_LAP_ALTERNATE_PACKET_RATE, cm_lap_get_packet_rate);
+	IBA_CHECK_GET(CM_LAP_ALTERNATE_SL, cm_lap_get_sl);
+	IBA_CHECK_GET(CM_LAP_ALTERNATE_LOCAL_ACK_TIMEOUT, cm_lap_get_local_ack_timeout);
+	IBA_CHECK_GET_BE(CM_SIDR_REP_QPN, cm_sidr_rep_get_qpn);
+	IBA_CHECK_SET_BE(CM_SIDR_REP_QPN, cm_sidr_rep_set_qpn);
+	printk("Success!\n");
+}
+
 static int __init ib_cm_init(void)
 {
 	int ret;
 
+	self_test();
+
 	INIT_LIST_HEAD(&cm.device_list);
 	rwlock_init(&cm.device_lock);
 	spin_lock_init(&cm.lock);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 9af9a321207423..bf62461d801fa3 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -8,6 +8,7 @@
 #ifndef CM_MSGS_H
 #define CM_MSGS_H
 
+#include <rdma/ibta_vol1_c12.h>
 #include <rdma/ib_mad.h>
 #include <rdma/ib_cm.h>
 
diff --git a/include/rdma/iba.h b/include/rdma/iba.h
new file mode 100644
index 00000000000000..6a1115b02a0db8
--- /dev/null
+++ b/include/rdma/iba.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2020, Mellanox Technologies inc.  All rights reserved.
+ */
+#ifndef _IBA_DEFS_H_
+#define _IBA_DEFS_H_
+
+#include <linux/kernel.h>
+#include <linux/bitfield.h>
+#include <asm/unaligned.h>
+
+static inline u32 _iba_get8(const u8 *ptr)
+{
+	return *ptr;
+}
+
+static inline void _iba_set8(u8 *ptr, u32 mask, u32 prep_value)
+{
+	*ptr = (*ptr & ~mask) | prep_value;
+}
+
+static inline u16 _iba_get16(const __be16 *ptr)
+{
+	return be16_to_cpu(*ptr);
+}
+
+static inline void _iba_set16(__be16 *ptr, u16 mask, u16 prep_value)
+{
+	*ptr = cpu_to_be16((be16_to_cpu(*ptr) & ~mask) | prep_value);
+}
+
+static inline u32 _iba_get32(const __be32 *ptr)
+{
+	return be32_to_cpu(*ptr);
+}
+
+static inline void _iba_set32(__be32 *ptr, u32 mask, u32 prep_value)
+{
+	*ptr = cpu_to_be32((be32_to_cpu(*ptr) & ~mask) | prep_value);
+}
+
+static inline u64 _iba_get64(const __be64 *ptr)
+{
+	/*
+	 * The mads are constructed so that 32 bit and smaller are naturally
+	 * aligned, everything larger has a max alignment of 4 bytes.
+	 */
+	return be64_to_cpu(get_unaligned(ptr));
+}
+
+static inline void _iba_set64(__be64 *ptr, u64 mask, u64 prep_value)
+{
+	put_unaligned(cpu_to_be64((_iba_get64(ptr) & ~mask) | prep_value), ptr);
+}
+
+#define _IBA_SET(field_struct, field_offset, field_mask, num_bits, ptr, value) \
+	({                                                                     \
+		field_struct *_ptr = ptr;                                      \
+		_iba_set##num_bits((void *)_ptr + (field_offset), field_mask,  \
+				   FIELD_PREP(field_mask, value));             \
+	})
+#define IBA_SET(field, ptr, value) _IBA_SET(field, ptr, value)
+
+#define _IBA_GET_MEM_PTR(field_struct, field_offset, type, num_bits, ptr)      \
+	({                                                                     \
+		field_struct *_ptr = ptr;                                      \
+		(type *)((void *)_ptr + (field_offset));                       \
+	})
+#define IBA_GET_MEM_PTR(field, ptr) _IBA_GET_MEM_PTR(field, ptr)
+
+/* FIXME: A set should always set the entire field, meaning we should zero the trailing bytes */
+#define _IBA_SET_MEM(field_struct, field_offset, type, num_bits, ptr, in,      \
+		     bytes)                                                    \
+	({                                                                     \
+		const type *_in_ptr = in;                                      \
+		WARN_ON(bytes * 8 > num_bits);                                 \
+		if (in && bytes)                                               \
+			memcpy(_IBA_GET_MEM_PTR(field_struct, field_offset,    \
+						type, num_bits, ptr),          \
+			       _in_ptr, bytes);                                \
+	})
+#define IBA_SET_MEM(field, ptr, in, bytes) _IBA_SET_MEM(field, ptr, in, bytes)
+
+#define _IBA_GET(field_struct, field_offset, field_mask, num_bits, ptr)        \
+	({                                                                     \
+		const field_struct *_ptr = ptr;                                \
+		(u##num_bits) FIELD_GET(                                       \
+			field_mask, _iba_get##num_bits((const void *)_ptr +    \
+						       (field_offset)));       \
+	})
+#define IBA_GET(field, ptr) _IBA_GET(field, ptr)
+
+#define _IBA_GET_MEM(field_struct, field_offset, type, num_bits, ptr, out,     \
+		     bytes)                                                    \
+	({                                                                     \
+		type *_out_ptr = out;                                          \
+		WARN_ON(bytes * 8 > num_bits);                                 \
+		if (out && bytes)                                              \
+			memcpy(_out_ptr,                                       \
+			       _IBA_GET_MEM_PTR(field_struct, field_offset,    \
+						type, num_bits, ptr),          \
+			       bytes);                                         \
+	})
+#define IBA_GET_MEM(field, ptr, out, bytes) _IBA_GET_MEM(field, ptr, out, bytes)
+
+/*
+ * The generated list becomes the parameters to the macros, the order is:
+ *  - struct this applies to
+ *  - starting offset of the max
+ *  - GENMASK or GENMASK_ULL in CPU order
+ *  - The width of data the mask operations should work on, in bits
+ */
+
+/*
+ * Extraction using a tabular description like table 106. bit_offset is from
+ * the Byte[Bit] notation.
+ */
+#define IBA_FIELD_BLOC(field_struct, byte_offset, bit_offset, num_bits)        \
+	field_struct, byte_offset,                                             \
+		GENMASK(7 - (bit_offset), 7 - (bit_offset) - (num_bits - 1)),  \
+		8
+#define IBA_FIELD8_LOC(field_struct, byte_offset, num_bits)                    \
+	IBA_FIELD_BLOC(field_struct, byte_offset, 0, num_bits)
+
+#define IBA_FIELD16_LOC(field_struct, byte_offset, num_bits)                   \
+	field_struct, (byte_offset)&0xFFFE,                                    \
+		GENMASK(15 - (((byte_offset) % 2) * 8),                        \
+			15 - (((byte_offset) % 2) * 8) - (num_bits - 1)),      \
+		16
+
+#define IBA_FIELD32_LOC(field_struct, byte_offset, num_bits)                   \
+	field_struct, (byte_offset)&0xFFFC,                                    \
+		GENMASK(31 - (((byte_offset) % 4) * 8),                        \
+			31 - (((byte_offset) % 4) * 8) - (num_bits - 1)),      \
+		32
+
+#define IBA_FIELD64_LOC(field_struct, byte_offset)                             \
+	field_struct, byte_offset, GENMASK_ULL(63, 0), 64
+/*
+ * In IBTA spec, everything that is more than 64bits is multiple
+ * of bytes without leftover bits.
+ */
+#define IBA_FIELD_MLOC(field_struct, byte_offset, num_bits, type)              \
+	field_struct, byte_offset, type, num_bits
+
+#endif /* _IBA_DEFS_H_ */
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
new file mode 100644
index 00000000000000..916db5c27dc5d2
--- /dev/null
+++ b/include/rdma/ibta_vol1_c12.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2020, Mellanox Technologies inc. All rights reserved.
+ *
+ * This file is IBTA volume 1, chapter 12 declarations:
+ *  CHAPTER 12: COMMUNICATION MANAGEMENT
+ */
+#ifndef _IBTA_VOL1_C12_H_
+#define _IBTA_VOL1_C12_H_
+
+#include <rdma/iba.h>
+
+#define CM_FIELD_BLOC(field_struct, byte_offset, bits_offset, width)           \
+	IBA_FIELD_BLOC(field_struct,                                           \
+		       (byte_offset + sizeof(struct ib_mad_hdr)), bits_offset, \
+		       width)
+#define CM_FIELD8_LOC(field_struct, byte_offset, width)                        \
+	IBA_FIELD8_LOC(field_struct,                                           \
+		       (byte_offset + sizeof(struct ib_mad_hdr)), width)
+#define CM_FIELD16_LOC(field_struct, byte_offset, width)                       \
+	IBA_FIELD16_LOC(field_struct,                                          \
+			(byte_offset + sizeof(struct ib_mad_hdr)), width)
+#define CM_FIELD32_LOC(field_struct, byte_offset, width)                       \
+	IBA_FIELD32_LOC(field_struct,                                          \
+			(byte_offset + sizeof(struct ib_mad_hdr)), width)
+#define CM_FIELD64_LOC(field_struct, byte_offset)                              \
+	IBA_FIELD64_LOC(field_struct, (byte_offset + sizeof(struct ib_mad_hdr)))
+#define CM_FIELD_MLOC(field_struct, byte_offset, width, type)                  \
+	IBA_FIELD_MLOC(field_struct,                                           \
+		       (byte_offset + sizeof(struct ib_mad_hdr)), width, type)
+#define CM_STRUCT(field_struct, total_len)                                     \
+	static_assert((total_len) % 32 == 0);
+
+/* Table 106 REQ Message Contents */
+#define CM_REQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_req_msg, 0, 32)
+#define CM_REQ_SERVICE_ID CM_FIELD64_LOC(struct cm_req_msg, 8)
+#define CM_REQ_LOCAL_CA_GUID CM_FIELD64_LOC(struct cm_req_msg, 16)
+#define CM_REQ_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_req_msg, 28, 32)
+#define CM_REQ_LOCAL_QPN CM_FIELD32_LOC(struct cm_req_msg, 32, 24)
+#define CM_REQ_RESPONDER_RESOURCES CM_FIELD8_LOC(struct cm_req_msg, 35, 8)
+#define CM_REQ_LOCAL_EECN CM_FIELD32_LOC(struct cm_req_msg, 36, 24)
+#define CM_REQ_INITIATOR_DEPTH CM_FIELD8_LOC(struct cm_req_msg, 39, 8)
+#define CM_REQ_REMOTE_EECN CM_FIELD32_LOC(struct cm_req_msg, 40, 24)
+#define CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT                                      \
+	CM_FIELD8_LOC(struct cm_req_msg, 43, 5)
+#define CM_REQ_TRANSPORT_SERVICE_TYPE CM_FIELD_BLOC(struct cm_req_msg, 43, 5, 2)
+#define CM_REQ_END_TO_END_FLOW_CONTROL                                         \
+	CM_FIELD_BLOC(struct cm_req_msg, 43, 7, 1)
+#define CM_REQ_STARTING_PSN CM_FIELD32_LOC(struct cm_req_msg, 44, 24)
+#define CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT CM_FIELD8_LOC(struct cm_req_msg, 47, 5)
+#define CM_REQ_RETRY_COUNT CM_FIELD_BLOC(struct cm_req_msg, 47, 5, 3)
+#define CM_REQ_PARTITION_KEY CM_FIELD16_LOC(struct cm_req_msg, 48, 16)
+#define CM_REQ_PATH_PACKET_PAYLOAD_MTU CM_FIELD8_LOC(struct cm_req_msg, 50, 4)
+#define CM_REQ_RDC_EXISTS CM_FIELD_BLOC(struct cm_req_msg, 50, 4, 1)
+#define CM_REQ_RNR_RETRY_COUNT CM_FIELD_BLOC(struct cm_req_msg, 50, 5, 3)
+#define CM_REQ_MAX_CM_RETRIES CM_FIELD8_LOC(struct cm_req_msg, 51, 4)
+#define CM_REQ_SRQ CM_FIELD_BLOC(struct cm_req_msg, 51, 4, 1)
+#define CM_REQ_EXTENDED_TRANSPORT_TYPE                                         \
+	CM_FIELD_BLOC(struct cm_req_msg, 51, 5, 3)
+#define CM_REQ_PRIMARY_LOCAL_PORT_LID CM_FIELD16_LOC(struct cm_req_msg, 52, 16)
+#define CM_REQ_PRIMARY_REMOTE_PORT_LID CM_FIELD16_LOC(struct cm_req_msg, 54, 16)
+#define CM_REQ_PRIMARY_LOCAL_PORT_GID                                          \
+	CM_FIELD_MLOC(struct cm_req_msg, 56, 128, union ib_gid)
+#define CM_REQ_PRIMARY_REMOTE_PORT_GID                                         \
+	CM_FIELD_MLOC(struct cm_req_msg, 72, 128, union ib_gid)
+#define CM_REQ_PRIMARY_FLOW_LABEL CM_FIELD32_LOC(struct cm_req_msg, 88, 20)
+#define CM_REQ_PRIMARY_PACKET_RATE CM_FIELD_BLOC(struct cm_req_msg, 91, 2, 6)
+#define CM_REQ_PRIMARY_TRAFFIC_CLASS CM_FIELD8_LOC(struct cm_req_msg, 92, 8)
+#define CM_REQ_PRIMARY_HOP_LIMIT CM_FIELD8_LOC(struct cm_req_msg, 93, 8)
+#define CM_REQ_PRIMARY_SL CM_FIELD8_LOC(struct cm_req_msg, 94, 4)
+#define CM_REQ_PRIMARY_SUBNET_LOCAL CM_FIELD_BLOC(struct cm_req_msg, 94, 4, 1)
+#define CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT CM_FIELD8_LOC(struct cm_req_msg, 95, 5)
+#define CM_REQ_ALTERNATE_LOCAL_PORT_LID                                        \
+	CM_FIELD16_LOC(struct cm_req_msg, 96, 16)
+#define CM_REQ_ALTERNATE_REMOTE_PORT_LID                                       \
+	CM_FIELD16_LOC(struct cm_req_msg, 98, 16)
+#define CM_REQ_ALTERNATE_LOCAL_PORT_GID                                        \
+	CM_FIELD_MLOC(struct cm_req_msg, 100, 128, union ib_gid)
+#define CM_REQ_ALTERNATE_REMOTE_PORT_GID                                       \
+	CM_FIELD_MLOC(struct cm_req_msg, 116, 128, union ib_gid)
+#define CM_REQ_ALTERNATE_FLOW_LABEL CM_FIELD32_LOC(struct cm_req_msg, 132, 20)
+#define CM_REQ_ALTERNATE_PACKET_RATE CM_FIELD_BLOC(struct cm_req_msg, 135, 2, 6)
+#define CM_REQ_ALTERNATE_TRAFFIC_CLASS CM_FIELD8_LOC(struct cm_req_msg, 136, 8)
+#define CM_REQ_ALTERNATE_HOP_LIMIT CM_FIELD8_LOC(struct cm_req_msg, 137, 8)
+#define CM_REQ_ALTERNATE_SL CM_FIELD8_LOC(struct cm_req_msg, 138, 4)
+#define CM_REQ_ALTERNATE_SUBNET_LOCAL                                          \
+	CM_FIELD_BLOC(struct cm_req_msg, 138, 4, 1)
+#define CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT                                     \
+	CM_FIELD8_LOC(struct cm_req_msg, 139, 5)
+#define CM_REQ_SAP_SUPPORTED CM_FIELD_BLOC(struct cm_req_msg, 139, 5, 1)
+#define CM_REQ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_req_msg, 140, 736, void)
+CM_STRUCT(struct cm_req_msg, 140 * 8 + 736);
+
+/* Table 107 MRA Message Contents */
+#define CM_MRA_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_mra_msg, 0, 32)
+#define CM_MRA_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_mra_msg, 4, 32)
+#define CM_MRA_MESSAGE_MRAED CM_FIELD8_LOC(struct cm_mra_msg, 8, 2)
+#define CM_MRA_SERVICE_TIMEOUT CM_FIELD8_LOC(struct cm_mra_msg, 9, 5)
+#define CM_MRA_PRIVATE_DATA CM_FIELD_MLOC(struct cm_mra_msg, 10, 1776, void)
+CM_STRUCT(struct cm_mra_msg, 10 * 8 + 1776);
+
+/* Table 108 REJ Message Contents */
+#define CM_REJ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_rej_msg, 0, 32)
+#define CM_REJ_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_rej_msg, 4, 32)
+#define CM_REJ_MESSAGE_REJECTED CM_FIELD8_LOC(struct cm_rej_msg, 8, 2)
+#define CM_REJ_REJECTED_INFO_LENGTH CM_FIELD8_LOC(struct cm_rej_msg, 9, 7)
+#define CM_REJ_REASON CM_FIELD16_LOC(struct cm_rej_msg, 10, 16)
+#define CM_REJ_ARI CM_FIELD_MLOC(struct cm_rej_msg, 12, 576, void)
+#define CM_REJ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rej_msg, 84, 1184, void)
+CM_STRUCT(struct cm_rej_msg, 84 * 8 + 1184);
+
+/* Table 110 REP Message Contents */
+#define CM_REP_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_rep_msg, 0, 32)
+#define CM_REP_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_rep_msg, 4, 32)
+#define CM_REP_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_rep_msg, 8, 32)
+#define CM_REP_LOCAL_QPN CM_FIELD32_LOC(struct cm_rep_msg, 12, 24)
+#define CM_REP_LOCAL_EE_CONTEXT_NUMBER CM_FIELD32_LOC(struct cm_rep_msg, 16, 24)
+#define CM_REP_STARTING_PSN CM_FIELD32_LOC(struct cm_rep_msg, 20, 24)
+#define CM_REP_RESPONDER_RESOURCES CM_FIELD8_LOC(struct cm_rep_msg, 24, 8)
+#define CM_REP_INITIATOR_DEPTH CM_FIELD8_LOC(struct cm_rep_msg, 25, 8)
+#define CM_REP_TARGET_ACK_DELAY CM_FIELD8_LOC(struct cm_rep_msg, 26, 5)
+#define CM_REP_FAILOVER_ACCEPTED CM_FIELD_BLOC(struct cm_rep_msg, 26, 5, 2)
+#define CM_REP_END_TO_END_FLOW_CONTROL                                         \
+	CM_FIELD_BLOC(struct cm_rep_msg, 26, 7, 1)
+#define CM_REP_RNR_RETRY_COUNT CM_FIELD8_LOC(struct cm_rep_msg, 27, 3)
+#define CM_REP_SRQ CM_FIELD_BLOC(struct cm_rep_msg, 27, 3, 1)
+#define CM_REP_LOCAL_CA_GUID CM_FIELD64_LOC(struct cm_rep_msg, 28)
+#define CM_REP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rep_msg, 36, 1568, void)
+CM_STRUCT(struct cm_rep_msg, 36 * 8 + 1568);
+
+/* Table 111 RTU Message Contents */
+#define CM_RTU_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_rtu_msg, 0, 32)
+#define CM_RTU_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_rtu_msg, 4, 32)
+#define CM_RTU_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rtu_msg, 8, 1792, void)
+CM_STRUCT(struct cm_rtu_msg, 8 * 8 + 1792);
+
+/* Table 112 DREQ Message Contents */
+#define CM_DREQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_dreq_msg, 0, 32)
+#define CM_DREQ_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_dreq_msg, 4, 32)
+#define CM_DREQ_REMOTE_QPN_EECN CM_FIELD32_LOC(struct cm_dreq_msg, 8, 24)
+#define CM_DREQ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_dreq_msg, 12, 1760, void)
+CM_STRUCT(struct cm_dreq_msg, 12 * 8 + 1760);
+
+/* Table 113 DREP Message Contents */
+#define CM_DREP_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_drep_msg, 0, 32)
+#define CM_DREP_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_drep_msg, 4, 32)
+#define CM_DREP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_drep_msg, 8, 1792, void)
+CM_STRUCT(struct cm_drep_msg, 8 * 8 + 1792);
+
+/* Table 115 LAP Message Contents */
+#define CM_LAP_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_lap_msg, 0, 32)
+#define CM_LAP_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_lap_msg, 4, 32)
+#define CM_LAP_REMOTE_QPN_EECN CM_FIELD32_LOC(struct cm_lap_msg, 12, 24)
+#define CM_LAP_REMOTE_CM_RESPONSE_TIMEOUT                                      \
+	CM_FIELD8_LOC(struct cm_lap_msg, 15, 5)
+#define CM_LAP_ALTERNATE_LOCAL_PORT_LID                                        \
+	CM_FIELD16_LOC(struct cm_lap_msg, 20, 16)
+#define CM_LAP_ALTERNATE_REMOTE_PORT_LID                                       \
+	CM_FIELD16_LOC(struct cm_lap_msg, 22, 16)
+#define CM_LAP_ALTERNATE_LOCAL_PORT_GID                                        \
+	CM_FIELD_MLOC(struct cm_lap_msg, 24, 128, union ib_gid)
+#define CM_LAP_ALTERNATE_REMOTE_PORT_GID                                       \
+	CM_FIELD_MLOC(struct cm_lap_msg, 40, 128, union ib_gid)
+#define CM_LAP_ALTERNATE_FLOW_LABEL CM_FIELD32_LOC(struct cm_lap_msg, 56, 20)
+#define CM_LAP_ALTERNATE_TRAFFIC_CLASS CM_FIELD8_LOC(struct cm_lap_msg, 59, 8)
+#define CM_LAP_ALTERNATE_HOP_LIMIT CM_FIELD8_LOC(struct cm_lap_msg, 60, 8)
+#define CM_LAP_ALTERNATE_PACKET_RATE CM_FIELD_BLOC(struct cm_lap_msg, 61, 2, 6)
+#define CM_LAP_ALTERNATE_SL CM_FIELD8_LOC(struct cm_lap_msg, 62, 4)
+#define CM_LAP_ALTERNATE_SUBNET_LOCAL CM_FIELD_BLOC(struct cm_lap_msg, 62, 4, 1)
+#define CM_LAP_ALTERNATE_LOCAL_ACK_TIMEOUT                                     \
+	CM_FIELD8_LOC(struct cm_lap_msg, 63, 5)
+#define CM_LAP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_lap_msg, 64, 1344, void)
+CM_STRUCT(struct cm_lap_msg, 64 * 8 + 1344);
+
+/* Table 116 APR Message Contents */
+#define CM_APR_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_apr_msg, 0, 32)
+#define CM_APR_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_apr_msg, 4, 32)
+#define CM_APR_ADDITIONAL_INFORMATION_LENGTH                                   \
+	CM_FIELD8_LOC(struct cm_apr_msg, 8, 8)
+#define CM_APR_AR_STATUS CM_FIELD8_LOC(struct cm_apr_msg, 9, 8)
+#define CM_APR_ADDITIONAL_INFORMATION                                          \
+	CM_FIELD_MLOC(struct cm_apr_msg, 12, 576, void)
+#define CM_APR_PRIVATE_DATA CM_FIELD_MLOC(struct cm_apr_msg, 84, 1184, void)
+CM_STRUCT(struct cm_apr_msg, 84 * 8 + 1184);
+
+/* Table 119 SIDR_REQ Message Contents */
+#define CM_SIDR_REQ_REQUESTID CM_FIELD32_LOC(struct cm_sidr_req_msg, 0, 32)
+#define CM_SIDR_REQ_PARTITION_KEY CM_FIELD16_LOC(struct cm_sidr_req_msg, 4, 16)
+#define CM_SIDR_REQ_SERVICEID CM_FIELD64_LOC(struct cm_sidr_req_msg, 8)
+#define CM_SIDR_REQ_PRIVATE_DATA                                               \
+	CM_FIELD_MLOC(struct cm_sidr_req_msg, 16, 1728, void)
+CM_STRUCT(struct cm_sidr_req_msg, 16 * 8 + 1728);
+
+/* Table 120 SIDR_REP Message Contents */
+#define CM_SIDR_REP_REQUESTID CM_FIELD32_LOC(struct cm_sidr_rep_msg, 0, 32)
+#define CM_SIDR_REP_STATUS CM_FIELD8_LOC(struct cm_sidr_rep_msg, 4, 8)
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH                              \
+	CM_FIELD8_LOC(struct cm_sidr_rep_msg, 5, 8)
+#define CM_SIDR_REP_QPN CM_FIELD32_LOC(struct cm_sidr_rep_msg, 8, 24)
+#define CM_SIDR_REP_SERVICEID CM_FIELD64_LOC(struct cm_sidr_rep_msg, 12)
+#define CM_SIDR_REP_Q_KEY CM_FIELD32_LOC(struct cm_sidr_rep_msg, 20, 32)
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION                                     \
+	CM_FIELD_MLOC(struct cm_sidr_rep_msg, 24, 576, void)
+#define CM_SIDR_REP_PRIVATE_DATA                                               \
+	CM_FIELD_MLOC(struct cm_sidr_rep_msg, 96, 1088, void)
+CM_STRUCT(struct cm_sidr_rep_msg, 96 * 8 + 1088);
+
+#endif /* _IBTA_VOL1_C12_H_ */
-- 
2.24.1

