Return-Path: <linux-rdma+bounces-14821-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D811CC93696
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 03:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05C9D3477A2
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0C185955;
	Sat, 29 Nov 2025 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Juq7kA9r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B69443;
	Sat, 29 Nov 2025 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764382912; cv=none; b=n8LnB2SKHGgLOQMw/mBFwIhabUmNvGNZBs0jTqUjS8REFlixiGXEceuKb6mS4wpPbyl2qg74ltQKnGhjn6PTzscv26Rp0/5t2aKS1hBb2kMUjbjmQMXEtlTAjME58tB/fNEcXeR21FXGSGweDe5V9Un0dwN4Q2d52xOtaLkS0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764382912; c=relaxed/simple;
	bh=3d2xHMrTc1PHy+U5d1UlTBoq0ASGh1ZlsavDXYZD0p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oiIdHxS1qojKVoXRY6HGXINNftVvI2UshNW2xhDMjuthSajnvsTnFmbGkIqKXWiBVSUl+/Yl2Rl4TjEVVToMGNjqy87zrJKKxsjUTMFCTKOUJhtzFdd8LL7NVaGLgaRjOQn4qFM6RjTprYKiCT+v/mStXaFl8xprY+XPigKDyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Juq7kA9r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tppLXCmUU85+SVDKZ/T10MBOSK7gbVfqLaIDYlXlyTU=; b=Juq7kA9rhmQrvY1ObBVrUMTghd
	ID8siey7MNFUvqN5LCtn17qdWvaHa/LR6AvEHwyg/iWK2Wxp6CqO/cdgQEahNN9wOJfoa4cPBWwVo
	94TBBbvNZbQAQ/T6h+lojorqf1udcDUIj0v6EMyToxZFJ4zbe+y9dAi8iDpACMVcFcy3b2rzAFYrq
	A+lc2LOZJGo8D0vHzioPyCrYkz81QCM7fCFxOyHEmThS/QoxrVP3EE2j9LVvTKPtysD9oq83lY25V
	B7mEyqh1ZQvjKow+C4KNzUWLY2WUGfDD5EHMyvXBVDSyuB7632+Tdhw6WN7w1Mn4K6YJ5/5KCYryG
	Y6r4LR5Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPAap-00000001AoN-11Ek;
	Sat, 29 Nov 2025 02:21:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RTRS/rtrs: clean up rtrs headers kernel-doc
Date: Fri, 28 Nov 2025 18:21:46 -0800
Message-ID: <20251129022146.1498273-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix all (30+) kernel-doc warnings in rtrs.h and rtrs-pri.h.
The changes are:

- add ending ':' to enum member names
- change enum description separators from '-' to ':'
- add "struct" keyword to kernel-doc for structs where missing
- fix enum names in enum rtrs_clt_con_type
- add a '-' separator and drop the "()" in enum rtrs_clt_con_type
- convert struct rtrs_addr to kernel-doc format
- add missing struct member descriptions for struct rtrs_attrs

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |   32 +++++++++++++++--------
 drivers/infiniband/ulp/rtrs/rtrs.h     |   24 ++++++++++-------
 2 files changed, 36 insertions(+), 20 deletions(-)

--- linux-next-20251128.orig/drivers/infiniband/ulp/rtrs/rtrs.h
+++ linux-next-20251128/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -24,8 +24,8 @@ struct rtrs_srv_op;
 
 /**
  * enum rtrs_clt_link_ev - Events about connectivity state of a client
- * @RTRS_CLT_LINK_EV_RECONNECTED	Client was reconnected.
- * @RTRS_CLT_LINK_EV_DISCONNECTED	Client was disconnected.
+ * @RTRS_CLT_LINK_EV_RECONNECTED:	Client was reconnected.
+ * @RTRS_CLT_LINK_EV_DISCONNECTED:	Client was disconnected.
  */
 enum rtrs_clt_link_ev {
 	RTRS_CLT_LINK_EV_RECONNECTED,
@@ -33,7 +33,9 @@ enum rtrs_clt_link_ev {
 };
 
 /**
- * Source and destination address of a path to be established
+ * struct rtrs_addr - Source and destination address of a path to be established
+ * @src:	source address
+ * @dst:	destination address
  */
 struct rtrs_addr {
 	struct sockaddr_storage *src;
@@ -41,7 +43,7 @@ struct rtrs_addr {
 };
 
 /**
- * rtrs_clt_ops - it holds the link event callback and private pointer.
+ * struct rtrs_clt_ops - it holds the link event callback and private pointer.
  * @priv: User supplied private data.
  * @link_ev: Event notification callback function for connection state changes
  *	@priv: User supplied data that was passed to rtrs_clt_open()
@@ -67,10 +69,10 @@ enum wait_type {
 };
 
 /**
- * enum rtrs_clt_con_type() type of ib connection to use with a given
+ * enum rtrs_clt_con_type - type of ib connection to use with a given
  * rtrs_permit
- * @ADMIN_CON - use connection reserved for "service" messages
- * @IO_CON - use a connection reserved for IO
+ * @RTRS_ADMIN_CON: use connection reserved for "service" messages
+ * @RTRS_IO_CON: use a connection reserved for IO
  */
 enum rtrs_clt_con_type {
 	RTRS_ADMIN_CON,
@@ -85,7 +87,7 @@ void rtrs_clt_put_permit(struct rtrs_clt
 			 struct rtrs_permit *permit);
 
 /**
- * rtrs_clt_req_ops - it holds the request confirmation callback
+ * struct rtrs_clt_req_ops - it holds the request confirmation callback
  * and a private pointer.
  * @priv: User supplied private data.
  * @conf_fn:	callback function to be called as confirmation
@@ -105,7 +107,11 @@ int rtrs_clt_request(int dir, struct rtr
 int rtrs_clt_rdma_cq_direct(struct rtrs_clt_sess *clt, unsigned int index);
 
 /**
- * rtrs_attrs - RTRS session attributes
+ * struct rtrs_attrs - RTRS session attributes
+ * @queue_depth:	queue_depth saved from rtrs_clt_sess message
+ * @max_io_size:	max_io_size from rtrs_clt_sess message, capped to
+ *			  @max_segments * %SZ_4K
+ * @max_segments:	max_segments saved from rtrs_clt_sess message
  */
 struct rtrs_attrs {
 	u32		queue_depth;
--- linux-next-20251128.orig/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ linux-next-20251128/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -150,7 +150,7 @@ enum rtrs_msg_types {
 
 /**
  * enum rtrs_msg_flags - RTRS message flags.
- * @RTRS_NEED_INVAL:	Send invalidation in response.
+ * @RTRS_MSG_NEED_INVAL_F: Send invalidation in response.
  * @RTRS_MSG_NEW_RKEY_F: Send refreshed rkey in response.
  */
 enum rtrs_msg_flags {
@@ -179,16 +179,19 @@ struct rtrs_sg_desc {
  * @recon_cnt:	   Reconnections counter
  * @sess_uuid:	   UUID of a session (path)
  * @paths_uuid:	   UUID of a group of sessions (paths)
- *
+ * @first_conn:    %1 if the connection request is the first for that session,
+ *			otherwise %0
  * NOTE: max size 56 bytes, see man rdma_connect().
  */
 struct rtrs_msg_conn_req {
-	/* Is set to 0 by cma.c in case of AF_IB, do not touch that.
-	 * see https://www.spinics.net/lists/linux-rdma/msg22397.html
+	/**
+	 * @__cma_version: Is set to 0 by cma.c in case of AF_IB, do not touch
+	 * that. See https://www.spinics.net/lists/linux-rdma/msg22397.html
 	 */
 	u8		__cma_version;
-	/* On sender side that should be set to 0, or cma_save_ip_info()
-	 * extract garbage and will fail.
+	/**
+	 * @__ip_version: On sender side that should be set to 0, or
+	 * cma_save_ip_info() extract garbage and will fail.
 	 */
 	u8		__ip_version;
 	__le16		magic;
@@ -199,6 +202,7 @@ struct rtrs_msg_conn_req {
 	uuid_t		sess_uuid;
 	uuid_t		paths_uuid;
 	u8		first_conn : 1;
+	/* private: */
 	u8		reserved_bits : 7;
 	u8		reserved[11];
 };
@@ -211,6 +215,7 @@ struct rtrs_msg_conn_req {
  * @queue_depth:   max inflight messages (queue-depth) in this session
  * @max_io_size:   max io size server supports
  * @max_hdr_size:  max msg header size server supports
+ * @flags:	   RTRS message flags for this message
  *
  * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accept().
  */
@@ -222,22 +227,24 @@ struct rtrs_msg_conn_rsp {
 	__le32		max_io_size;
 	__le32		max_hdr_size;
 	__le32		flags;
+	/* private: */
 	u8		reserved[36];
 };
 
 /**
- * struct rtrs_msg_info_req
+ * struct rtrs_msg_info_req - client additional info request
  * @type:		@RTRS_MSG_INFO_REQ
  * @pathname:		Path name chosen by client
  */
 struct rtrs_msg_info_req {
 	__le16		type;
 	u8		pathname[NAME_MAX];
+	/* private: */
 	u8		reserved[15];
 };
 
 /**
- * struct rtrs_msg_info_rsp
+ * struct rtrs_msg_info_rsp - server additional info response
  * @type:		@RTRS_MSG_INFO_RSP
  * @sg_cnt:		Number of @desc entries
  * @desc:		RDMA buffers where the client can write to server
@@ -245,12 +252,14 @@ struct rtrs_msg_info_req {
 struct rtrs_msg_info_rsp {
 	__le16		type;
 	__le16          sg_cnt;
+	/* private: */
 	u8              reserved[4];
+	/* public: */
 	struct rtrs_sg_desc desc[];
 };
 
 /**
- * struct rtrs_msg_rkey_rsp
+ * struct rtrs_msg_rkey_rsp - server refreshed rkey response
  * @type:		@RTRS_MSG_RKEY_RSP
  * @buf_id:		RDMA buf_id of the new rkey
  * @rkey:		new remote key for RDMA buffers id from server
@@ -264,6 +273,7 @@ struct rtrs_msg_rkey_rsp {
 /**
  * struct rtrs_msg_rdma_read - RDMA data transfer request from client
  * @type:		always @RTRS_MSG_READ
+ * @flags:		RTRS message flags (enum rtrs_msg_flags)
  * @usr_len:		length of user payload
  * @sg_cnt:		number of @desc entries
  * @desc:		RDMA buffers where the server can write the result to
@@ -277,7 +287,7 @@ struct rtrs_msg_rdma_read {
 };
 
 /**
- * struct_msg_rdma_write - Message transferred to server with RDMA-Write
+ * struct rtrs_msg_rdma_write - Message transferred to server with RDMA-Write
  * @type:		always @RTRS_MSG_WRITE
  * @usr_len:		length of user payload
  */
@@ -287,7 +297,7 @@ struct rtrs_msg_rdma_write {
 };
 
 /**
- * struct_msg_rdma_hdr - header for read or write request
+ * struct rtrs_msg_rdma_hdr - header for read or write request
  * @type:		@RTRS_MSG_WRITE | @RTRS_MSG_READ
  */
 struct rtrs_msg_rdma_hdr {

