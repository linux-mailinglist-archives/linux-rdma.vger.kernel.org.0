Return-Path: <linux-rdma+bounces-11757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E10CAEDA47
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457E23B2C2E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5688E248F55;
	Mon, 30 Jun 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7tH87e9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC884A2B
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280766; cv=none; b=q4FODp0vCbWFDCDQC3xA8zK4YvSoAcpU3ODxVBUJldMRS8c8qfqnKHk8WA2TvAy6vKABzHNLwMYnuqzk0tKE9flO53+WADHH1gusvcMhptXpaQia4d2OcGt7PfVmbjKZMS1qEsgKrpi4C3wlYd6pEpZbNchjmBi6Nn4RrQcKFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280766; c=relaxed/simple;
	bh=B6ehNfPVrYCNCvx+3xfnJY7sAvgX72HBX9l/sj2fk2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRENFkPYXPyTdapnn9B+JY+gALXnLFRzYXhKHzvaxcq3XsHAOn9wfX3muEWmwAdWyXM0AohWhW7ZehVB7weRsVSrDGNTLCVuQdz8WP1z1llaper/qXguqMx3R4G6IIhR5Se/lc9EFoKDEfDHOkVNgsju+5aZTVzoaEuwxYJ2A6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7tH87e9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC5DC4CEE3;
	Mon, 30 Jun 2025 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751280765;
	bh=B6ehNfPVrYCNCvx+3xfnJY7sAvgX72HBX9l/sj2fk2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7tH87e98/h7e9zuDWrhLGR/qDLh2pGaaW6sWgReifisiEqrqe3lWi54uy6Apx87w
	 1uRtyxDZsEzfIvGt7lp5q/psywvWDHQwXpr2delssyGyLsFXsWjiVJ1sbinGZlNih/
	 PgkaBlVDCgaSw+wBioSFnvho7SFBHC7pcxwcaqrtv37EBfdZYkTTE7pOeyFom0opdk
	 gkvQaPNXAjuFk7po9c5Kym8GligW+kSsY2rfXHjV6RSZLxMAafbu3SFwNdzSLNSLyi
	 Poc7qeSo8xll8LsIIczGgJ0K07Pg4g/oMY7ZCR37nE6vKu1MpneQdvtlwo7ZmlVGUG
	 ISAYlSnb2RQzQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 2/5] RDMA/sa_query: Support IB service records resolution
Date: Mon, 30 Jun 2025 13:52:32 +0300
Message-ID: <9af6c82f3a3a9d975115a33235fb4ffc7c8edb21.1751279793.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751279793.git.leonro@nvidia.com>
References: <cover.1751279793.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Add an SA query API ib_sa_service_rec_get() to support building and
sending SA query MADs that ask for service records with a specific
name or ID, and receiving and parsing responses from the SM.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sa_query.c | 238 +++++++++++++++++++++++++++++
 include/rdma/ib_mad.h              |   1 +
 include/rdma/ib_sa.h               |  37 +++++
 3 files changed, 276 insertions(+)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 770e9f18349b..c0a7af1b4fe4 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -152,6 +152,13 @@ struct ib_sa_mcmember_query {
 	struct ib_sa_query sa_query;
 };
 
+struct ib_sa_service_query {
+	void (*callback)(int status, struct sa_service_rec *rec,
+			 unsigned int num_services, void *context);
+	void *context;
+	struct ib_sa_query sa_query;
+};
+
 static LIST_HEAD(ib_nl_request_list);
 static DEFINE_SPINLOCK(ib_nl_request_lock);
 static atomic_t ib_nl_sa_request_seq;
@@ -686,6 +693,58 @@ static const struct ib_field guidinfo_rec_table[] = {
 	  .size_bits    = 512 },
 };
 
+#define SERVICE_REC_FIELD(field) \
+	.struct_offset_bytes = offsetof(struct sa_service_rec, field),     \
+	.struct_size_bytes   = sizeof_field(struct sa_service_rec, field), \
+	.field_name          = "sa_service_rec:" #field
+
+static const struct ib_field service_rec_table[] = {
+	{ SERVICE_REC_FIELD(id),
+	  .offset_words = 0,
+	  .offset_bits  = 0,
+	  .size_bits    = 64 },
+	{ SERVICE_REC_FIELD(gid),
+	  .offset_words = 2,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+	{ SERVICE_REC_FIELD(pkey),
+	  .offset_words = 6,
+	  .offset_bits  = 0,
+	  .size_bits    = 16 },
+	{ RESERVED,
+	  .offset_words = 6,
+	  .offset_bits  = 16,
+	  .size_bits    = 16 },
+	{ SERVICE_REC_FIELD(lease),
+	  .offset_words = 7,
+	  .offset_bits  = 0,
+	  .size_bits    = 32 },
+	{ SERVICE_REC_FIELD(key),
+	  .offset_words = 8,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+	{ SERVICE_REC_FIELD(name),
+	  .offset_words = 12,
+	  .offset_bits  = 0,
+	  .size_bits    = 512 },
+	{ SERVICE_REC_FIELD(data_8),
+	  .offset_words = 28,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+	{ SERVICE_REC_FIELD(data_16),
+	  .offset_words = 32,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+	{ SERVICE_REC_FIELD(data_32),
+	  .offset_words = 36,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+	{ SERVICE_REC_FIELD(data_64),
+	  .offset_words = 40,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+};
+
 #define RDMA_PRIMARY_PATH_MAX_REC_NUM 3
 
 static inline void ib_sa_disable_local_svc(struct ib_sa_query *query)
@@ -1392,6 +1451,20 @@ void ib_sa_pack_path(struct sa_path_rec *rec, void *attribute)
 }
 EXPORT_SYMBOL(ib_sa_pack_path);
 
+void ib_sa_pack_service(struct sa_service_rec *rec, void *attribute)
+{
+	ib_pack(service_rec_table, ARRAY_SIZE(service_rec_table), rec,
+		attribute);
+}
+EXPORT_SYMBOL(ib_sa_pack_service);
+
+void ib_sa_unpack_service(void *attribute, struct sa_service_rec *rec)
+{
+	ib_unpack(service_rec_table, ARRAY_SIZE(service_rec_table), attribute,
+		  rec);
+}
+EXPORT_SYMBOL(ib_sa_unpack_service);
+
 static bool ib_sa_opa_pathrecord_support(struct ib_sa_client *client,
 					 struct ib_sa_device *sa_dev,
 					 u32 port_num)
@@ -1481,6 +1554,68 @@ static void ib_sa_path_rec_callback(struct ib_sa_query *sa_query,
 	}
 }
 
+#define IB_SA_DATA_OFFS 56
+#define IB_SERVICE_REC_SZ 176
+
+static void ib_unpack_service_rmpp(struct sa_service_rec *rec,
+				   struct ib_mad_recv_wc *mad_wc,
+				   int num_services)
+{
+	unsigned int cp_sz, data_i, data_size, rec_i = 0, buf_i = 0;
+	struct ib_mad_recv_buf *mad_buf;
+	u8 buf[IB_SERVICE_REC_SZ];
+	u8 *data;
+
+	data_size = sizeof(((struct ib_sa_mad *) mad_buf->mad)->data);
+
+	list_for_each_entry(mad_buf, &mad_wc->rmpp_list, list) {
+		data = ((struct ib_sa_mad *) mad_buf->mad)->data;
+		data_i = 0;
+		while (data_i < data_size && rec_i < num_services) {
+			cp_sz = min(IB_SERVICE_REC_SZ - buf_i,
+				    data_size - data_i);
+			memcpy(buf + buf_i, data + data_i, cp_sz);
+			data_i += cp_sz;
+			buf_i += cp_sz;
+			if (buf_i == IB_SERVICE_REC_SZ) {
+				ib_sa_unpack_service(buf, rec + rec_i);
+				buf_i = 0;
+				rec_i++;
+			}
+		}
+	}
+}
+
+static void ib_sa_service_rec_callback(struct ib_sa_query *sa_query, int status,
+				       struct ib_mad_recv_wc *mad_wc)
+{
+	struct ib_sa_service_query *query =
+		container_of(sa_query, struct ib_sa_service_query, sa_query);
+	struct sa_service_rec *rec;
+	int num_services;
+
+	if (!mad_wc || !mad_wc->recv_buf.mad) {
+		query->callback(status, NULL, 0, query->context);
+		return;
+	}
+
+	num_services = (mad_wc->mad_len - IB_SA_DATA_OFFS) / IB_SERVICE_REC_SZ;
+	if (!num_services) {
+		query->callback(-ENODATA, NULL, 0, query->context);
+		return;
+	}
+
+	rec = kmalloc_array(num_services, sizeof(*rec), GFP_KERNEL);
+	if (!rec) {
+		query->callback(-ENOMEM, NULL, 0, query->context);
+		return;
+	}
+
+	ib_unpack_service_rmpp(rec, mad_wc, num_services);
+	query->callback(status, rec, num_services, query->context);
+	kfree(rec);
+}
+
 static void ib_sa_path_rec_release(struct ib_sa_query *sa_query)
 {
 	struct ib_sa_path_query *query =
@@ -1490,6 +1625,14 @@ static void ib_sa_path_rec_release(struct ib_sa_query *sa_query)
 	kfree(query);
 }
 
+static void ib_sa_service_rec_release(struct ib_sa_query *sa_query)
+{
+	struct ib_sa_service_query *query =
+		container_of(sa_query, struct ib_sa_service_query, sa_query);
+
+	kfree(query);
+}
+
 /**
  * ib_sa_path_rec_get - Start a Path get query
  * @client:SA client
@@ -1620,6 +1763,101 @@ int ib_sa_path_rec_get(struct ib_sa_client *client,
 }
 EXPORT_SYMBOL(ib_sa_path_rec_get);
 
+/**
+ * ib_sa_service_rec_get - Start a Service get query
+ * @client: SA client
+ * @device: device to send query on
+ * @port_num: port number to send query on
+ * @rec: Service Record to send in query
+ * @comp_mask: component mask to send in query
+ * @timeout_ms: time to wait for response
+ * @gfp_mask: GFP mask to use for internal allocations
+ * @callback: function called when query completes, times out or is
+ * canceled
+ * @context: opaque user context passed to callback
+ * @sa_query: query context, used to cancel query
+ *
+ * Send a Service Record Get query to the SA to look up a path.  The
+ * callback function will be called when the query completes (or
+ * fails); status is 0 for a successful response, -EINTR if the query
+ * is canceled, -ETIMEDOUT is the query timed out, or -EIO if an error
+ * occurred sending the query.  The resp parameter of the callback is
+ * only valid if status is 0.
+ *
+ * If the return value of ib_sa_service_rec_get() is negative, it is an
+ * error code. Otherwise it is a query ID that can be used to cancel
+ * the query.
+ */
+int ib_sa_service_rec_get(struct ib_sa_client *client,
+			  struct ib_device *device, u32 port_num,
+			  struct sa_service_rec *rec,
+			  ib_sa_comp_mask comp_mask,
+			  unsigned long timeout_ms, gfp_t gfp_mask,
+			  void (*callback)(int status,
+					   struct sa_service_rec *resp,
+					   unsigned int num_services,
+					   void *context),
+			  void *context, struct ib_sa_query **sa_query)
+{
+	struct ib_sa_device *sa_dev = ib_get_client_data(device, &sa_client);
+	struct ib_sa_service_query *query;
+	struct ib_mad_agent *agent;
+	struct ib_sa_port   *port;
+	struct ib_sa_mad *mad;
+	int ret;
+
+	if (!sa_dev)
+		return -ENODEV;
+
+	port = &sa_dev->port[port_num - sa_dev->start_port];
+	agent = port->agent;
+
+	query = kzalloc(sizeof(*query), gfp_mask);
+	if (!query)
+		return -ENOMEM;
+
+	query->sa_query.port = port;
+
+	ret = alloc_mad(&query->sa_query, gfp_mask);
+	if (ret)
+		goto err1;
+
+	ib_sa_client_get(client);
+	query->sa_query.client = client;
+	query->callback        = callback;
+	query->context         = context;
+
+	mad = query->sa_query.mad_buf->mad;
+	init_mad(&query->sa_query, agent);
+
+	query->sa_query.rmpp_callback = callback ? ib_sa_service_rec_callback :
+		NULL;
+	query->sa_query.release = ib_sa_service_rec_release;
+	mad->mad_hdr.method	= IB_MGMT_METHOD_GET_TABLE;
+	mad->mad_hdr.attr_id	= cpu_to_be16(IB_SA_ATTR_SERVICE_REC);
+	mad->sa_hdr.comp_mask	= comp_mask;
+
+	ib_sa_pack_service(rec, mad->data);
+
+	*sa_query = &query->sa_query;
+	query->sa_query.mad_buf->context[1] = rec;
+
+	ret = send_mad(&query->sa_query, timeout_ms, gfp_mask);
+	if (ret < 0)
+		goto err2;
+
+	return ret;
+
+err2:
+	*sa_query = NULL;
+	ib_sa_client_put(query->sa_query.client);
+	free_mad(&query->sa_query);
+err1:
+	kfree(query);
+	return ret;
+}
+EXPORT_SYMBOL(ib_sa_service_rec_get);
+
 static void ib_sa_mcmember_rec_callback(struct ib_sa_query *sa_query,
 					int status, struct ib_sa_mad *mad)
 {
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 3f1b58d8b4bf..8bd0e1eb393b 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -48,6 +48,7 @@
 #define IB_MGMT_METHOD_REPORT			0x06
 #define IB_MGMT_METHOD_REPORT_RESP		0x86
 #define IB_MGMT_METHOD_TRAP_REPRESS		0x07
+#define IB_MGMT_METHOD_GET_TABLE		0x12
 
 #define IB_MGMT_METHOD_RESP			0x80
 #define IB_BM_ATTR_MOD_RESP			cpu_to_be32(1)
diff --git a/include/rdma/ib_sa.h b/include/rdma/ib_sa.h
index b46353fc53bf..95e8924ad563 100644
--- a/include/rdma/ib_sa.h
+++ b/include/rdma/ib_sa.h
@@ -189,6 +189,20 @@ struct sa_path_rec {
 	u32 flags;
 };
 
+struct sa_service_rec {
+	__be64 id;
+	__u8 gid[16];
+	__be16 pkey;
+	__u8 reserved[2];
+	__be32 lease;
+	__u8 key[16];
+	__u8 name[64];
+	__u8 data_8[16];
+	__be16 data_16[8];
+	__be32 data_32[4];
+	__be64 data_64[2];
+};
+
 static inline enum ib_gid_type
 		sa_conv_pathrec_to_gid_type(struct sa_path_rec *rec)
 {
@@ -417,6 +431,17 @@ int ib_sa_path_rec_get(struct ib_sa_client *client, struct ib_device *device,
 					unsigned int num_prs, void *context),
 		       void *context, struct ib_sa_query **query);
 
+int ib_sa_service_rec_get(struct ib_sa_client *client,
+			  struct ib_device *device, u32 port_num,
+			  struct sa_service_rec *rec,
+			  ib_sa_comp_mask comp_mask,
+			  unsigned long timeout_ms, gfp_t gfp_mask,
+			  void (*callback)(int status,
+					   struct sa_service_rec *resp,
+					   unsigned int num_services,
+					   void *context),
+			  void *context, struct ib_sa_query **sa_query);
+
 struct ib_sa_multicast {
 	struct ib_sa_mcmember_rec rec;
 	ib_sa_comp_mask		comp_mask;
@@ -508,6 +533,18 @@ int ib_init_ah_attr_from_path(struct ib_device *device, u32 port_num,
  */
 void ib_sa_pack_path(struct sa_path_rec *rec, void *attribute);
 
+/**
+ * ib_sa_pack_service - Convert a service record from struct ib_sa_service_rec
+ * to IB MAD wire format.
+ */
+void ib_sa_pack_service(struct sa_service_rec *rec, void *attribute);
+
+/**
+ * ib_sa_unpack_service - Convert a service record from MAD format to struct
+ * ib_sa_service_rec.
+ */
+void ib_sa_unpack_service(void *attribute, struct sa_service_rec *rec);
+
 /**
  * ib_sa_unpack_path - Convert a path record from MAD format to struct
  * ib_sa_path_rec.
-- 
2.50.0


