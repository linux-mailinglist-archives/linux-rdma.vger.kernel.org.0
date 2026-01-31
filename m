Return-Path: <linux-rdma+bounces-16276-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMYGHA1afWmBRgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16276-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:25:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0FBBFFA3
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924033033AAF
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617C328B7D;
	Sat, 31 Jan 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr5LRyNL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE4325709;
	Sat, 31 Jan 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822710; cv=none; b=kW8q8mG61Encjnc9i66Sq9580z+YA3DoQaETxaEzN136yruSokTT7odtnQsyd6iCR5fok9lUdhuvmmvyF+/t26o97wZPBD5YkJmNM20odaWZWcEQdDoWA722hzaU/rWzCz6deawNVC975YJeEMIa/wSVTEg0nmhhO+16QxjlwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822710; c=relaxed/simple;
	bh=E3KRQNG8/cl36qhG8BGoJYbuWmCWZJ1rJP94aypsvVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjezahbuJWoLjtj/hUJAsDigfrQMKEbnapunKaQKioQ1xOB4FD6SIVIUr3/uvcmZt6J3HDDfd1WO4+Ka2WvWYbAOZ4Ry45e0ulWlLwCplyGFH4PdI1cgfZrcHXmPmkssQITUs5cA15jH8umor/fsYYB/Nm2JRnOcRzNfjG20fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr5LRyNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8961FC19421;
	Sat, 31 Jan 2026 01:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822710;
	bh=E3KRQNG8/cl36qhG8BGoJYbuWmCWZJ1rJP94aypsvVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rr5LRyNLfKrKAORwjQm7+nMrfkU2DYk8VrTxjlF25X5O44sodjPShjIPDShJqJWsR
	 y0u+QcVToDbn/IrcTRw1HH3KAEYrT/r4mUkpgNd/+cKy4hwDdfVvICDPlGrnzJR8E6
	 H84a35OyuU2Zu58dOQg+6GXcHPCOmX08pVBJDNQmPdRZ3gTgh1GpZOS0BzrIOkXkLM
	 PTvv51+tMqImPf2DkRLuoIiS45vSnY1sF7sQdDQEZZHscm0rky3+icSFA+1SvSMcb2
	 2NoxtcBZFVDdzpcMNPDJx/qVo8F77klX0wuWAQHpvMiiogtAHRn5dkAoo6GB13V/4T
	 qyIGnsrYg2PFg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v4 1/8] net/rds: new extension header: rdma bytes
Date: Fri, 30 Jan 2026 18:25:00 -0700
Message-ID: <20260131012507.814119-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260131012507.814119-1-achender@kernel.org>
References: <20260131012507.814119-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16276-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1A0FBBFFA3
X-Rspamd-Action: no action

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

Introduce a new extension header type RDSV3_EXTHDR_RDMA_BYTES for
an RDMA initiator to exchange rdma byte counts to its target.
Currently, RDMA operations cannot precisely account how many bytes a
peer just transferred via RDMA, which limits per-connection statistics
and future policy (e.g., monitoring or rate/cgroup accounting of RDMA
traffic).

In this patch we expand rds_message_add_extension to accept multiple
extensions, and add new flag to RDS header: RDS_FLAG_EXTHDR_EXTENSION,
along with a new extension to RDS header: rds_ext_header_rdma_bytes.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Guangyu Sun <guangyu.sun@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/ib_send.c | 40 ++++++++++++++++++++++++-----
 net/rds/message.c | 65 +++++++++++++++++++++++++++++++++++++----------
 net/rds/rds.h     | 25 ++++++++++++++----
 net/rds/send.c    |  6 ++---
 4 files changed, 107 insertions(+), 29 deletions(-)

diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index f9d28ddd168d..fcd04c29f543 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -577,16 +577,42 @@ int rds_ib_xmit(struct rds_connection *conn, struct rds_message *rm,
 		/* If it has a RDMA op, tell the peer we did it. This is
 		 * used by the peer to release use-once RDMA MRs. */
 		if (rm->rdma.op_active) {
-			struct rds_ext_header_rdma ext_hdr;
+			struct rds_ext_header_rdma ext_hdr = {};
+			struct rds_ext_header_rdma_bytes
+				rdma_bytes_ext_hdr = {};
 
 			ext_hdr.h_rdma_rkey = cpu_to_be32(rm->rdma.op_rkey);
-			rds_message_add_extension(&rm->m_inc.i_hdr,
-					RDS_EXTHDR_RDMA, &ext_hdr, sizeof(ext_hdr));
+			if (rds_message_add_extension(&rm->m_inc.i_hdr,
+						      RDS_EXTHDR_RDMA,
+						      &ext_hdr)) {
+				/* prepare the rdma bytes ext header */
+				rdma_bytes_ext_hdr.h_rflags =
+					rm->rdma.op_write ?
+					RDS_FLAG_RDMA_WR_BYTES :
+					RDS_FLAG_RDMA_RD_BYTES;
+				rdma_bytes_ext_hdr.h_rdma_bytes =
+					cpu_to_be32(rm->rdma.op_bytes);
+			} else {
+				rdsdebug("RDS_EXTHDR_RDMA dropped");
+			}
+
+			if (rds_message_add_extension(&rm->m_inc.i_hdr,
+						      RDS_EXTHDR_RDMA_BYTES,
+						      &rdma_bytes_ext_hdr)) {
+				/* rdma bytes ext header was added successfully,
+				 * notify the remote side via flag in header
+				 */
+				rm->m_inc.i_hdr.h_flags |=
+					RDS_FLAG_EXTHDR_EXTENSION;
+			} else {
+				rdsdebug("RDS_EXTHDR_RDMA_BYTES dropped");
+			}
 		}
-		if (rm->m_rdma_cookie) {
-			rds_message_add_rdma_dest_extension(&rm->m_inc.i_hdr,
-					rds_rdma_cookie_key(rm->m_rdma_cookie),
-					rds_rdma_cookie_offset(rm->m_rdma_cookie));
+		if (rm->m_rdma_cookie &&
+		    !rds_message_add_rdma_dest_extension(&rm->m_inc.i_hdr,
+				rds_rdma_cookie_key(rm->m_rdma_cookie),
+				rds_rdma_cookie_offset(rm->m_rdma_cookie))) {
+			rdsdebug("RDS_EXTHDR_RDMA_DEST dropped\n");
 		}
 
 		/* Note - rds_ib_piggyb_ack clears the ACK_REQUIRED bit, so
diff --git a/net/rds/message.c b/net/rds/message.c
index 199a899a43e9..591a27c9c62f 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -44,6 +44,7 @@ static unsigned int	rds_exthdr_size[__RDS_EXTHDR_MAX] = {
 [RDS_EXTHDR_VERSION]	= sizeof(struct rds_ext_header_version),
 [RDS_EXTHDR_RDMA]	= sizeof(struct rds_ext_header_rdma),
 [RDS_EXTHDR_RDMA_DEST]	= sizeof(struct rds_ext_header_rdma_dest),
+[RDS_EXTHDR_RDMA_BYTES] = sizeof(struct rds_ext_header_rdma_bytes),
 [RDS_EXTHDR_NPATHS]	= sizeof(__be16),
 [RDS_EXTHDR_GEN_NUM]	= sizeof(__be32),
 };
@@ -191,31 +192,69 @@ void rds_message_populate_header(struct rds_header *hdr, __be16 sport,
 	hdr->h_sport = sport;
 	hdr->h_dport = dport;
 	hdr->h_sequence = cpu_to_be64(seq);
-	hdr->h_exthdr[0] = RDS_EXTHDR_NONE;
+	/* see rds_find_next_ext_space for reason why we memset the
+	 * ext header
+	 */
+	memset(hdr->h_exthdr, RDS_EXTHDR_NONE, RDS_HEADER_EXT_SPACE);
 }
 EXPORT_SYMBOL_GPL(rds_message_populate_header);
 
-int rds_message_add_extension(struct rds_header *hdr, unsigned int type,
-			      const void *data, unsigned int len)
+/*
+ * Find the next place we can add an RDS header extension with
+ * specific length. Extension headers are pushed one after the
+ * other. In the following, the number after the colon is the number
+ * of bytes:
+ *
+ * [ type1:1 dta1:len1 [ type2:1 dta2:len2 ] ... ] RDS_EXTHDR_NONE
+ *
+ * If the extension headers fill the complete extension header space
+ * (16 bytes), the trailing RDS_EXTHDR_NONE is omitted.
+ */
+static int rds_find_next_ext_space(struct rds_header *hdr, unsigned int len,
+				   u8 **ext_start)
 {
-	unsigned int ext_len = sizeof(u8) + len;
-	unsigned char *dst;
+	unsigned int ext_len;
+	unsigned int type;
+	int ind = 0;
+
+	while ((ind + 1 + len) <= RDS_HEADER_EXT_SPACE) {
+		if (hdr->h_exthdr[ind] == RDS_EXTHDR_NONE) {
+			*ext_start = hdr->h_exthdr + ind;
+			return 0;
+		}
 
-	/* For now, refuse to add more than one extension header */
-	if (hdr->h_exthdr[0] != RDS_EXTHDR_NONE)
-		return 0;
+		type = hdr->h_exthdr[ind];
+
+		ext_len = (type < __RDS_EXTHDR_MAX) ? rds_exthdr_size[type] : 0;
+		WARN_ONCE(!ext_len, "Unknown ext hdr type %d\n", type);
+		if (!ext_len)
+			return -EINVAL;
+
+		/* ind points to a valid ext hdr with known length */
+		ind += 1 + ext_len;
+	}
+
+	/* no room for extension */
+	return -ENOSPC;
+}
+
+/* The ext hdr space is prefilled with zero from the kzalloc() */
+int rds_message_add_extension(struct rds_header *hdr,
+			      unsigned int type, const void *data)
+{
+	unsigned char *dst;
+	unsigned int len;
 
-	if (type >= __RDS_EXTHDR_MAX || len != rds_exthdr_size[type])
+	len = (type < __RDS_EXTHDR_MAX) ? rds_exthdr_size[type] : 0;
+	if (!len)
 		return 0;
 
-	if (ext_len >= RDS_HEADER_EXT_SPACE)
+	if (rds_find_next_ext_space(hdr, len, &dst))
 		return 0;
-	dst = hdr->h_exthdr;
 
 	*dst++ = type;
 	memcpy(dst, data, len);
 
-	dst[len] = RDS_EXTHDR_NONE;
 	return 1;
 }
 EXPORT_SYMBOL_GPL(rds_message_add_extension);
@@ -272,7 +311,7 @@ int rds_message_add_rdma_dest_extension(struct rds_header *hdr, u32 r_key, u32 o
 
 	ext_hdr.h_rdma_rkey = cpu_to_be32(r_key);
 	ext_hdr.h_rdma_offset = cpu_to_be32(offset);
-	return rds_message_add_extension(hdr, RDS_EXTHDR_RDMA_DEST, &ext_hdr, sizeof(ext_hdr));
+	return rds_message_add_extension(hdr, RDS_EXTHDR_RDMA_DEST, &ext_hdr);
 }
 EXPORT_SYMBOL_GPL(rds_message_add_rdma_dest_extension);
 
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 8a549fe687ac..4b6bf523b412 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -183,10 +183,11 @@ void rds_conn_net_set(struct rds_connection *conn, struct net *net)
 	write_pnet(&conn->c_net, net);
 }
 
-#define RDS_FLAG_CONG_BITMAP	0x01
-#define RDS_FLAG_ACK_REQUIRED	0x02
-#define RDS_FLAG_RETRANSMITTED	0x04
-#define RDS_MAX_ADV_CREDIT	255
+#define RDS_FLAG_CONG_BITMAP		0x01
+#define RDS_FLAG_ACK_REQUIRED		0x02
+#define RDS_FLAG_RETRANSMITTED		0x04
+#define RDS_FLAG_EXTHDR_EXTENSION	0x20
+#define RDS_MAX_ADV_CREDIT		255
 
 /* RDS_FLAG_PROBE_PORT is the reserved sport used for sending a ping
  * probe to exchange control information before establishing a connection.
@@ -258,6 +259,20 @@ struct rds_ext_header_rdma_dest {
 	__be32			h_rdma_offset;
 };
 
+/*
+ * This extension header tells the peer about delivered RDMA byte count.
+ */
+#define RDS_EXTHDR_RDMA_BYTES	4
+
+struct rds_ext_header_rdma_bytes {
+	__be32		h_rdma_bytes;	/* byte count */
+	u8		h_rflags;	/* direction of RDMA, write or read */
+	u8		h_pad[3];
+};
+
+#define RDS_FLAG_RDMA_WR_BYTES	0x01
+#define RDS_FLAG_RDMA_RD_BYTES	0x02
+
 /* Extension header announcing number of paths.
  * Implicit length = 2 bytes.
  */
@@ -871,7 +886,7 @@ struct rds_message *rds_message_map_pages(unsigned long *page_addrs, unsigned in
 void rds_message_populate_header(struct rds_header *hdr, __be16 sport,
 				 __be16 dport, u64 seq);
 int rds_message_add_extension(struct rds_header *hdr,
-			      unsigned int type, const void *data, unsigned int len);
+			      unsigned int type, const void *data);
 int rds_message_next_extension(struct rds_header *hdr,
 			       unsigned int *pos, void *buf, unsigned int *buflen);
 int rds_message_add_rdma_dest_extension(struct rds_header *hdr, u32 r_key, u32 offset);
diff --git a/net/rds/send.c b/net/rds/send.c
index 3e3d028bc21e..306785fa7065 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1459,12 +1459,10 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 		__be32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
 
 		rds_message_add_extension(&rm->m_inc.i_hdr,
-					  RDS_EXTHDR_NPATHS, &npaths,
-					  sizeof(npaths));
+					  RDS_EXTHDR_NPATHS, &npaths);
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_GEN_NUM,
-					  &my_gen_num,
-					  sizeof(u32));
+					  &my_gen_num);
 	}
 	spin_unlock_irqrestore(&cp->cp_lock, flags);
 
-- 
2.43.0


