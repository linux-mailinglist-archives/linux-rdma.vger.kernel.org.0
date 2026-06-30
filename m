Return-Path: <linux-rdma+bounces-22580-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UQwGB5CXQ2pUcwoAu9opvQ
	(envelope-from <linux-rdma+bounces-22580-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 12:16:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB896E2B5C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 12:16:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=PLxCSZOX;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22580-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22580-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35894300C0CE
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 10:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A13EDE70;
	Tue, 30 Jun 2026 10:16:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D23EFD09
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 10:16:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814578; cv=none; b=StWeuntm5KrdpVQJDqH7mo8JpilfGP9OunaM/HrwibrizRhsZ0wxs7X4tCXJOnihFLf4WOHHwDKWGlPI7S395xemoeu06KV0T6b20mFwHt7YzlS5yN1eBchY1fmGuFpM8W5KyJY5nS4rd+54UT5axohRayuGpgq9lfLged2VItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814578; c=relaxed/simple;
	bh=7QRlMSlJEAnmUbqzc1AhGSH/vMxcNkAIQpis4UCBQR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFwJWaMEgHGM7rs3E4iwPJ5uk5puV0eJ9YktQ/OtmJjsGO9OTaOkahzKO34SI6BjDnlNYx49FZAWqL+NNZdjsu1ML3onoNe9cbkUGh/j015xf1Y6IXdLMP8FD4QI2je+k0if43Cof/n7eskjYNq4M1Fw0IsFJy9bQBQlctLUz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PLxCSZOX; arc=none smtp.client-ip=209.85.160.227
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-51a14efe25fso46387751cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 03:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814572; x=1783419372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cHSNaGKZk6aVvixu0uRQxpR3n67x1/Z/j/uVrv17ig=;
        b=FfZbQYySenoq4cW6GOKH3KyQNqQzHBJCQzInTzEbJlKPch+QqSn9dMxP26XFTDu/qu
         9entUmZ90i3C+D9gcgZ1YZ6Zib6Gro7BCffaxs1ihB6IriFyPYaUqr62/BwDFoBFJxBQ
         43OVCsqMUkE15L78A91DNlbJPTGptPMGNuDgfWuhqzk1uGa8R1ZBq2/Z3P41iC4oCA8H
         nh8aMrvhUBO7Lz/j9vzLcKQ7eMQXWhqNr5nWytkIHoLogQVlGbs77DuBCg6rOeGkEqeh
         K5PL2uU0j22AQgVCNBxFUB14o05qsPYgbNS/UtGhQSCqCLKzx4B8LiIcmbIDm5f8mK1a
         1xeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LY5lBL3Msm+8yoGWyJYbky4PwTPCwDWo07XrTiip0glli8nJwWTAQ4L3NUSNFIefJa9wV4/GBbsiD@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOf0Nhe7vNeDK7Ew1kkACjaoG/oAOPn6Da7idNJX5aiNM6Qh9
	XsPM6BSU+d6o1n7LIlbFSNhMud8hjlHPk15MPCeS2b3+NFKi2l76r2YrK1rTViKOWz+E4Ihrmte
	g+so/ztEGcMcMEvC8xThvJT/7tA32ORbF6DsLrWYj0TQzasbWn6H3FAye4OhOmkGFaEIMyI9Hw9
	GtqnuhAQy1pJlhLqhC1HNjakPivqeVHOezCe/htCyd+yKlE133OJ+AIoBq+3/WtByj0cjiXrb+W
	Pqoyw3AuI+4Vy4=
X-Gm-Gg: AfdE7ckJmhOl9WVaEmqk1WggBuQDsVcIjzx67xMi9MxQjuufDSxXKRa22U8M1jpdNJv
	7iqgkoovbbZXV5Z1NhnupOKXo5ndos5Ev8uw0Rg5xt1B1/10dHQzijT2KM+mTFV0uDOa7zSweQj
	RLx5choBq/H+q9bjr+Zu/UJ7+9KLddZ7caZJIemNIxcEm39CU2dg/aMtJMtpAjjD+JI3EiNh2uI
	X8pIO7/mVoZr+zw5QYK2fmPvvkyMWuZoEi+Y2fQKAAoJRKJ+KvlETzjEbfRLS5IQU+i+kohJxv+
	AYZmnbRzKjHt+fm68MaTBQwxylq/wYxzXIIYUuyyNzjz3Xct9YnBkfNgRPrOOs1kNKxS/fhb8RH
	jH7IjJWbgCN35X9gnEp+Au+iG1a0wLgOOJ4IU+O59XRUADTja8YTtWptI+CIfpsog1Pf1lPlBLR
	2wH2Lwqtoi9g2qQs1dHai2FUNruVwn/daJirsN+RrhPCFP
X-Received: by 2002:ac8:590c:0:b0:51a:329:e802 with SMTP id d75a77b69052e-51c108b8187mr38324201cf.41.1782814571950;
        Tue, 30 Jun 2026 03:16:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8f1a29d83c7sm2193776d6.5.2026.06.30.03.16.10
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:16:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30e773699d6so3020962eec.0
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782814570; x=1783419370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cHSNaGKZk6aVvixu0uRQxpR3n67x1/Z/j/uVrv17ig=;
        b=PLxCSZOXWjyR/y0tRMFE2GSncix4vtAM2f3ggFHFr7OHPdGa1iuVPiIXdXvhgepRHL
         PC+KLlirEj593mgfZZZkq93+oBiMEL/SO+lop2uHwJ2q0smXlSVV5EEV5rgRVwUn6oEz
         3QwsqmCx62eNkgGEBJU6oWud7vNFMZnvmoS8A=
X-Forwarded-Encrypted: i=1; AHgh+RqC6ul9HwhPNQx2qpWWOH+li3GhR6FHnQwQHrtdEk9TEaEEPNOegAc/HTNHpEBt/SORVDYQ0phdFqqu@vger.kernel.org
X-Received: by 2002:a05:7301:e8d:b0:30c:2af0:1cc with SMTP id 5a478bee46e88-30ee14c4090mr2258097eec.34.1782814569524;
        Tue, 30 Jun 2026 03:16:09 -0700 (PDT)
X-Received: by 2002:a05:7301:e8d:b0:30c:2af0:1cc with SMTP id 5a478bee46e88-30ee14c4090mr2258074eec.34.1782814568798;
        Tue, 30 Jun 2026 03:16:08 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee31da63asm6686720eec.21.2026.06.30.03.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:16:07 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leonro@nvidia.com,
	jgg@nvidia.com,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH net] bnge/bng_re: fix ring ID widths
Date: Tue, 30 Jun 2026 15:45:54 +0530
Message-ID: <20260630101554.1221733-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22580-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[vikas.gupta@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:vikas.gupta@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAB896E2B5C

Firmware extended the TX ring ID from 16 to 32 bits to accommodate its
internal QP management. Update the HSI and the ring ID fields in the
ring alloc/free calls accordingly.
Only the TX ring ID managed by firmware is widened but RX, completion
and NQ ring IDs remain within the 16-bit range.

Fixes: 42d1c54d6248 ("bnge/bng_re: Add a new HSI")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c        |  6 +--
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  1 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  8 +--
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  2 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 50 +++++++++----------
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  4 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |  2 +-
 include/linux/bnge/hsi.h                      |  7 ++-
 8 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 71a7ca2196ad..311c8bc93160 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -113,7 +113,7 @@ static void bng_re_fill_fw_msg(struct bnge_fw_msg *fw_msg, void *msg,
 }
 
 static int bng_re_net_ring_free(struct bng_re_dev *rdev,
-				u16 fw_ring_id, int type)
+				u32 fw_ring_id, int type)
 {
 	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
 	struct hwrm_ring_free_input req = {};
@@ -123,7 +123,7 @@ static int bng_re_net_ring_free(struct bng_re_dev *rdev,
 
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_FREE);
 	req.ring_type = type;
-	req.ring_id = cpu_to_le16(fw_ring_id);
+	req.ring_id = cpu_to_le32(fw_ring_id);
 	bng_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
 			    sizeof(resp), BNGE_DFLT_HWRM_CMD_TIMEOUT);
 	rc = bnge_send_msg(aux_dev, &fw_msg);
@@ -161,7 +161,7 @@ static int bng_re_net_ring_alloc(struct bng_re_dev *rdev,
 			   sizeof(resp), BNGE_DFLT_HWRM_CMD_TIMEOUT);
 	rc = bnge_send_msg(aux_dev, &fw_msg);
 	if (!rc)
-		*fw_ring_id = le16_to_cpu(resp.ring_id);
+		*fw_ring_id = (u16)le32_to_cpu(resp.ring_id);
 
 	return rc;
 }
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index f21cff651fd4..4479ccd071f5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -36,6 +36,7 @@ struct bnge_pf_info {
 };
 
 #define INVALID_HW_RING_ID      ((u16)-1)
+#define INVALID_HW_RING_ID_32BIT	(U32_MAX)
 
 enum {
 	BNGE_FW_CAP_SHORT_CMD				= BIT_ULL(0),
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 1c9cfec1b633..651c5e783516 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -1283,7 +1283,7 @@ int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn)
 
 int hwrm_ring_free_send_msg(struct bnge_net *bn,
 			    struct bnge_ring_struct *ring,
-			    u32 ring_type, int cmpl_ring_id)
+			    u32 ring_type, u32 cmpl_ring_id)
 {
 	struct hwrm_ring_free_input *req;
 	struct bnge_dev *bd = bn->bd;
@@ -1295,7 +1295,7 @@ int hwrm_ring_free_send_msg(struct bnge_net *bn,
 
 	req->cmpl_ring = cpu_to_le16(cmpl_ring_id);
 	req->ring_type = ring_type;
-	req->ring_id = cpu_to_le16(ring->fw_ring_id);
+	req->ring_id = cpu_to_le32(ring->fw_ring_id);
 
 	bnge_hwrm_req_hold(bd, req);
 	rc = bnge_hwrm_req_send(bd, req);
@@ -1317,7 +1317,7 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 	struct hwrm_ring_alloc_output *resp;
 	struct hwrm_ring_alloc_input *req;
 	struct bnge_dev *bd = bn->bd;
-	u16 ring_id, flags = 0;
+	u32 ring_id, flags = 0;
 	int rc;
 
 	rc = bnge_hwrm_req_init(bd, req, HWRM_RING_ALLOC);
@@ -1401,7 +1401,7 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 
 	resp = bnge_hwrm_req_hold(bd, req);
 	rc = bnge_hwrm_req_send(bd, req);
-	ring_id = le16_to_cpu(resp->ring_id);
+	ring_id = le32_to_cpu(resp->ring_id);
 	bnge_hwrm_req_drop(bd, req);
 
 exit:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 3501de7a89b9..bf452e390d5b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -50,7 +50,7 @@ int bnge_hwrm_cfa_l2_set_rx_mask(struct bnge_dev *bd,
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
 int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
 int hwrm_ring_free_send_msg(struct bnge_net *bn, struct bnge_ring_struct *ring,
-			    u32 ring_type, int cmpl_ring_id);
+			    u32 ring_type, u32 cmpl_ring_id);
 int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 			     struct bnge_ring_struct *ring,
 			     u32 ring_type, u32 map_index);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 70768193004c..6f7ef506d4e1 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1327,12 +1327,12 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	return rc;
 }
 
-u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr)
+u32 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr)
 {
 	return rxr->rx_cpr->ring_struct.fw_ring_id;
 }
 
-u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
+u32 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
 {
 	return txr->tx_cpr->ring_struct.fw_ring_id;
 }
@@ -1375,12 +1375,12 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
 		struct bnge_ring_struct *ring = &nqr->ring_struct;
 
-		ring->fw_ring_id = INVALID_HW_RING_ID;
+		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 		for (j = 0; j < nqr->cp_ring_count; j++) {
 			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
 
 			ring = &cpr->ring_struct;
-			ring->fw_ring_id = INVALID_HW_RING_ID;
+			ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 		}
 	}
 }
@@ -1637,7 +1637,7 @@ static void bnge_init_one_rx_ring_rxbd(struct bnge_net *bn,
 
 	ring = &rxr->rx_ring_struct;
 	bnge_init_rxbd_pages(ring, type);
-	ring->fw_ring_id = INVALID_HW_RING_ID;
+	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 }
 
 static void bnge_init_one_agg_ring_rxbd(struct bnge_net *bn,
@@ -1647,7 +1647,7 @@ static void bnge_init_one_agg_ring_rxbd(struct bnge_net *bn,
 	u32 type;
 
 	ring = &rxr->rx_agg_ring_struct;
-	ring->fw_ring_id = INVALID_HW_RING_ID;
+	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 	if (bnge_is_agg_reqd(bn->bd)) {
 		type = ((u32)BNGE_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
@@ -1708,7 +1708,7 @@ static void bnge_init_tx_rings(struct bnge_net *bn)
 		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
 		struct bnge_ring_struct *ring = &txr->tx_ring_struct;
 
-		ring->fw_ring_id = INVALID_HW_RING_ID;
+		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 
 		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX,
 				     &txr->bnapi->napi);
@@ -1867,7 +1867,7 @@ static int bnge_hwrm_rx_agg_ring_alloc(struct bnge_net *bn,
 		    ring->fw_ring_id);
 	bnge_db_write(bn->bd, &rxr->rx_agg_db, rxr->rx_agg_prod);
 	bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
-	bn->grp_info[grp_idx].agg_fw_ring_id = ring->fw_ring_id;
+	bn->grp_info[grp_idx].agg_fw_ring_id = (u16)ring->fw_ring_id;
 
 	return 0;
 }
@@ -1886,7 +1886,7 @@ static int bnge_hwrm_rx_ring_alloc(struct bnge_net *bn,
 		return rc;
 
 	bnge_set_db(bn, &rxr->rx_db, type, map_idx, ring->fw_ring_id);
-	bn->grp_info[map_idx].rx_fw_ring_id = ring->fw_ring_id;
+	bn->grp_info[map_idx].rx_fw_ring_id = (u16)ring->fw_ring_id;
 
 	return 0;
 }
@@ -1916,7 +1916,7 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 		bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
 		bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
 		enable_irq(vector);
-		bn->grp_info[i].nq_fw_ring_id = ring->fw_ring_id;
+		bn->grp_info[i].nq_fw_ring_id = (u16)ring->fw_ring_id;
 
 		if (!i) {
 			rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
@@ -1986,15 +1986,13 @@ void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic)
 	tbl_size = bnge_get_rxfh_indir_size(bd);
 
 	for (i = 0; i < tbl_size; i++) {
-		u16 ring_id, j;
+		u32 j;
 
 		j = bd->rss_indir_tbl[i];
 		rxr = &bn->rx_ring[j];
 
-		ring_id = rxr->rx_ring_struct.fw_ring_id;
-		*ring_tbl++ = cpu_to_le16(ring_id);
-		ring_id = bnge_cp_ring_for_rx(rxr);
-		*ring_tbl++ = cpu_to_le16(ring_id);
+		*ring_tbl++ = cpu_to_le16(rxr->rx_ring_struct.fw_ring_id);
+		*ring_tbl++ = cpu_to_le16(bnge_cp_ring_for_rx(rxr));
 	}
 }
 
@@ -2285,7 +2283,7 @@ static void bnge_disable_int(struct bnge_net *bn)
 		nqr = &bnapi->nq_ring;
 		ring = &nqr->ring_struct;
 
-		if (ring->fw_ring_id != INVALID_HW_RING_ID)
+		if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT)
 			bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
 	}
 }
@@ -2401,7 +2399,7 @@ static void bnge_hwrm_rx_ring_free(struct bnge_net *bn,
 	u32 grp_idx = rxr->bnapi->index;
 	u32 cmpl_ring_id;
 
-	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+	if (ring->fw_ring_id == INVALID_HW_RING_ID_32BIT)
 		return;
 
 	cmpl_ring_id = bnge_cp_ring_for_rx(rxr);
@@ -2409,7 +2407,7 @@ static void bnge_hwrm_rx_ring_free(struct bnge_net *bn,
 				RING_FREE_REQ_RING_TYPE_RX,
 				close_path ? cmpl_ring_id :
 				INVALID_HW_RING_ID);
-	ring->fw_ring_id = INVALID_HW_RING_ID;
+	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 	bn->grp_info[grp_idx].rx_fw_ring_id = INVALID_HW_RING_ID;
 }
 
@@ -2421,14 +2419,14 @@ static void bnge_hwrm_rx_agg_ring_free(struct bnge_net *bn,
 	u32 grp_idx = rxr->bnapi->index;
 	u32 cmpl_ring_id;
 
-	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+	if (ring->fw_ring_id == INVALID_HW_RING_ID_32BIT)
 		return;
 
 	cmpl_ring_id = bnge_cp_ring_for_rx(rxr);
 	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_RX_AGG,
 				close_path ? cmpl_ring_id :
 				INVALID_HW_RING_ID);
-	ring->fw_ring_id = INVALID_HW_RING_ID;
+	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 	bn->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
@@ -2439,14 +2437,14 @@ static void bnge_hwrm_tx_ring_free(struct bnge_net *bn,
 	struct bnge_ring_struct *ring = &txr->tx_ring_struct;
 	u32 cmpl_ring_id;
 
-	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+	if (ring->fw_ring_id == INVALID_HW_RING_ID_32BIT)
 		return;
 
 	cmpl_ring_id = close_path ? bnge_cp_ring_for_tx(txr) :
 		       INVALID_HW_RING_ID;
 	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_TX,
 				cmpl_ring_id);
-	ring->fw_ring_id = INVALID_HW_RING_ID;
+	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 }
 
 static void bnge_hwrm_cp_ring_free(struct bnge_net *bn,
@@ -2455,12 +2453,12 @@ static void bnge_hwrm_cp_ring_free(struct bnge_net *bn,
 	struct bnge_ring_struct *ring;
 
 	ring = &cpr->ring_struct;
-	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+	if (ring->fw_ring_id == INVALID_HW_RING_ID_32BIT)
 		return;
 
 	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
 				INVALID_HW_RING_ID);
-	ring->fw_ring_id = INVALID_HW_RING_ID;
+	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 }
 
 static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
@@ -2496,11 +2494,11 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
 
 		ring = &nqr->ring_struct;
-		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
+		if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT) {
 			hwrm_ring_free_send_msg(bn, ring,
 						RING_FREE_REQ_RING_TYPE_NQ,
 						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID;
+			ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 			bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index f4636b5b0cf3..d177919c2e11 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -630,8 +630,8 @@ struct bnge_l2_filter {
 	refcount_t		refcnt;
 };
 
-u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
-u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
+u32 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
+u32 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index 341c7f81ed09..bb0c79a1ee60 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -184,7 +184,7 @@ struct bnge_ctx_mem_info {
 struct bnge_ring_struct {
 	struct bnge_ring_mem_info	ring_mem;
 
-	u16			fw_ring_id;
+	u32			fw_ring_id;
 	union {
 		u16		grp_idx;
 		u16		map_idx; /* Used by NQs */
diff --git a/include/linux/bnge/hsi.h b/include/linux/bnge/hsi.h
index 8ea13d5407ee..1f7bd96415a5 100644
--- a/include/linux/bnge/hsi.h
+++ b/include/linux/bnge/hsi.h
@@ -8317,8 +8317,7 @@ struct hwrm_ring_alloc_output {
 	__le16	req_type;
 	__le16	seq_id;
 	__le16	resp_len;
-	__le16	ring_id;
-	__le16	logical_ring_id;
+	__le32	ring_id;
 	u8	push_buffer_index;
 	#define RING_ALLOC_RESP_PUSH_BUFFER_INDEX_PING_BUFFER 0x0UL
 	#define RING_ALLOC_RESP_PUSH_BUFFER_INDEX_PONG_BUFFER 0x1UL
@@ -8345,10 +8344,10 @@ struct hwrm_ring_free_input {
 	u8	flags;
 	#define RING_FREE_REQ_FLAGS_VIRTIO_RING_VALID 0x1UL
 	#define RING_FREE_REQ_FLAGS_LAST             RING_FREE_REQ_FLAGS_VIRTIO_RING_VALID
-	__le16	ring_id;
+	__le16	unused_1;
 	__le32	prod_idx;
 	__le32	opaque;
-	__le32	unused_1;
+	__le32	ring_id;
 };
 
 /* hwrm_ring_free_output (size:128b/16B) */
-- 
2.47.1


