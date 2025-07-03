Return-Path: <linux-rdma+bounces-11871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A482AAF7EC9
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1B43A7022
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1847289349;
	Thu,  3 Jul 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="xbvEnwO0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F2288C92
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563615; cv=none; b=q1OP1e94ifpvzdheeyTdoeQKimVGjnAgCZkhj81SS8MmH6RyN9xkTlJRcvkpO1RBzl0UwofY1AMrJF/x8vAcJNqNbKBSxkXx4jVSBLMUT4YpEHpgaXpHgasVkSb+b3WlVAxYiuipIJAmZYAIjhUmjlqZ0N4zWCSrhPGlm869dXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563615; c=relaxed/simple;
	bh=MV26OPjigZAQEcK0FNBuKbhBVnHLI+skx8oKXwraq/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgBfwfUORt3Zq/Y2yAPMlRgnQAb4E+Y/XRzq2JombCEYD/783GmhM/cQvakK9gnsdxeHkHtka5ruO5hcviNfIkrxkMYIoCXH7TJzzcBoBSwpMyp6iXSzwbOm5m9uJOlISO0HEx7a1WtaIzq6aFxLJ4ulqykcdAI4H7ab4tD84cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=xbvEnwO0; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=jRoiqZMbHV/lgkJH62v6jyQvD1dBtdQg1RB0jc5R8gI=; b=xbvEnwO0tSolcRfJjp6uonF/bd
	WijLzwJ+yYPRBdEfrGcUlZxPU7fMP8loBFjH3+nO6DUIihsScPfkrxxV53+lXp8HAKsMaPq6qeamP
	hOcLZjCpU8Vji6/2Fcat2IVr/zStlXx5dAlhZh5fuQ0Qs3HQzv7TDrOTOOOP9gdkDLRaeIumN8qUi
	O1TW93q4mEAen/tDVBenQyMFtabcN4chOFlFLJ7g0NZJcrHBtZo4Zr67reDJyvjXHeFESEN9QuWW+
	pkuIRu6b3E/qGjY/hjFLSKAUYEoek35t97vbW7tqk2ekiV9cFHagrffCvIfC12IcnRsYXNMPFOC12
	ga53Xe91gaZFwXMXSCI32yMm03yeoKJfsmJWGn72RguE0d1KyxGY+5agU4eCbHZmArVo2PHDkJgyo
	VutNW2Y5f2XkcLolUpDPKzIj3lG28lFyIl/q4777Nusfen9CYcD/5TURmOzFriztPwRFgWBGGJ1eQ
	DvppDFV4wnfyQKdntd7JU1zr;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNhz-00Dp2G-0b;
	Thu, 03 Jul 2025 17:26:51 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 1/8] RDMA/siw: make mpa_version = MPA_REVISION_2 const
Date: Thu,  3 Jul 2025 19:26:12 +0200
Message-Id: <2a39c54001a3019ee0dba00eeedc2a5c136805eb.1751561826.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1751561826.git.metze@samba.org>
References: <cover.1751561826.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's currently no way to change that value at runtime.

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/siw.h      | 2 +-
 drivers/infiniband/sw/siw/siw_cm.c   | 6 ------
 drivers/infiniband/sw/siw/siw_main.c | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f5fd71717b80..3e04357ab197 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -494,7 +494,7 @@ extern const bool loopback_enabled;
 extern const bool mpa_crc_required;
 extern const bool mpa_crc_strict;
 extern const bool siw_tcp_nagle;
-extern u_char mpa_version;
+extern const u_char mpa_version;
 extern const bool peer_to_peer;
 extern struct task_struct *siw_tx_thread[];
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 708b13993fdf..aba97d674402 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1454,12 +1454,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	 * MPA Rev. according to module parameter 'mpa_version', Key 'Request'.
 	 */
 	cep->mpa.hdr.params.bits = 0;
-	if (version > MPA_REVISION_2) {
-		pr_warn("Setting MPA version to %u\n", MPA_REVISION_2);
-		version = MPA_REVISION_2;
-		/* Adjust also module parameter */
-		mpa_version = MPA_REVISION_2;
-	}
 	__mpa_rr_set_revision(&cep->mpa.hdr.params.bits, version);
 
 	if (try_gso)
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 5168307229a9..4e1d29832ac8 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -51,7 +51,7 @@ const bool mpa_crc_strict;
 const bool siw_tcp_nagle;
 
 /* Select MPA version to be used during connection setup */
-u_char mpa_version = MPA_REVISION_2;
+const u_char mpa_version = MPA_REVISION_2;
 
 /* Selects MPA P2P mode (additional handshake during connection
  * setup, if true.
-- 
2.34.1


