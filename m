Return-Path: <linux-rdma+bounces-22756-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E4rbE1U5SWqszQAAu9opvQ
	(envelope-from <linux-rdma+bounces-22756-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Jul 2026 18:48:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B907708000
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Jul 2026 18:48:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=MjuSO8p6;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22756-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22756-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D6F63007A6C
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jul 2026 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E0372EE2;
	Sat,  4 Jul 2026 16:48:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D4246788
	for <linux-rdma@vger.kernel.org>; Sat,  4 Jul 2026 16:48:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183684; cv=none; b=euyjsGkUADkGjlnAbPnmmBoGUobSU2M2K3RNyYwtiU8hlHsG853yMVvfWm0AGtGz26+fIkA/0zkhDW4MeADAXqCUbMUJmJjoVy1qEdBfzOc+t3bfypPc+Isu3DR0osjbLw48jeYlNcf3DDhT1MUKezQA5OWdl0trRCrCq9ZTabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183684; c=relaxed/simple;
	bh=rDGfRdNNDY0hTRSTPLAsaF4zbBkAbYxChNGjQ28uCN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFOJmyWa7sF5+E5SdRCrS4vfnXJZcdJejpuZsCRxLHHBbY+elFzD/gTi+lc2+/0SALLJE56fSmFdoI7DtpgkbJGUB3bT1OQfFvUh/wdcaRpU+WpLnwYOXn4QIuogICg7olvxblAq8VVuJmj4Bq+DV/YUMUDYQP3YNOtaTmoJTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MjuSO8p6; arc=none smtp.client-ip=209.85.214.226
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2caea3f742bso17074875ad.0
        for <linux-rdma@vger.kernel.org>; Sat, 04 Jul 2026 09:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783183681; x=1783788481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7MpfKqWFP/eSYac/g1Pj5/S183YqsoiVeJj9FJV8vk=;
        b=gvU3PJhjn7eilEx7UDy74Ls7+zxAfOK7fS6EN6pUvCOHZqXPQeLT8q9FvT1+jSHVDg
         ZPm9twmTLfKNXRpX9uKzZHt8Bb0qhrqELsCb+nle/+8V9i0pOphYXZdg22kdsdI4gA/H
         cqArih0q2HBVIdcB3V2MoOISXgobK4RgBmcZJlp5iN2sadgMo0bVZQAvZ64T4FofBHzj
         cL+F6DgNIOe1waRRWaPg+mhptBenwrjGU/+gBTCynVFyEEOyrvzXj7LOxG+/eLqK39e2
         w3DyMlcGZaH9Pu4dy0EIKUke82wh5KvDze9oeUGHsE664qTx6HFMR3TbWHaFOAIglKfV
         XAng==
X-Forwarded-Encrypted: i=1; AHgh+RplAMBVCXwVmXmAZtQox4KncH4I3Th9q1UOuLGhPyok1Bvg47gib7cfkhbizs2stYZUht7jutKNVHQ8@vger.kernel.org
X-Gm-Message-State: AOJu0YztuHx9wdDHMMRJsrqwbi2OTWoPAFAjEHp07Zw0Ac9CiFLIwKPR
	9N+BQhERjx6MA7L9sIUiYtyJ8Estizys61g6TbsnLk4E+SGh2CzssDDDA8wOvJrNVO2RH/xRWFI
	sf5cjoZ2SB4yRnGaQeaxdHX0uwOuYixTdmaPF5wFu6camBd3o9cZdfTnNcj8k00O0yNd7ZKTKbE
	5XG+wgdkKbpIs6zDKa5pdbYewrlhBUhWUa+vMbEiCn4zfnHdXvS/LU/Obq0FSw2CBZtASv2WrFP
	0fcq1jWnUZchYw=
X-Gm-Gg: AfdE7ck3HS6cSJ2+FKPuwF+krXLnJqpUzT1uXNBWkth5PDdXA5y86/fPYcXciS61pcs
	3OVAlnqp6LfNcdtc34x0KkkIkyMffw2Q/ZctY/g2BWQ3sJdo/hUYhJDTRdlyGGIWm5lbiN4z8Y1
	aaOSceDuxFs0qP1cd1WOy5395xh0aAcmB1Do9n97BxANaS6AU93Pnn62N9XWACS6ccKfKeOpvie
	E59zI455PrHl5PusHJhCARclJmY9octq1K0KJAN/hZhneFfKH9lp5/wzi2tWcRmZZ6ajUgn5pYY
	2/pHeXAnD5Z2Q6WarbCx5cw+ZqL7T7HOTPZKPZGITtV3gEPpVJ877aTBlYIjuY5AnFtigQbeLLn
	v2ATw8izij+DSrxWGeADIA7/xdgHgZGaliPJZMMNhatj0CX82VRZauaodlMOF7ciNVXGDyy+qoC
	OtnMweM9UmxGAbR6tK7HODaVblQu87RmxWkrC6Ab6nBT1hYx4=
X-Received: by 2002:a17:903:244b:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2cbb76fc981mr36253795ad.17.1783183680788;
        Sat, 04 Jul 2026 09:48:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cad6f130e3sm4667455ad.23.2026.07.04.09.48.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2026 09:48:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so2136913a12.0
        for <linux-rdma@vger.kernel.org>; Sat, 04 Jul 2026 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783183679; x=1783788479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7MpfKqWFP/eSYac/g1Pj5/S183YqsoiVeJj9FJV8vk=;
        b=MjuSO8p6ETUQdTgK+MI7vCYm8loblAFsRNYAwnuqHcExb8Ds+WIdiYD1Arcc3WKBEV
         BWk0XszaqEyNNVQTrS3vAUObZCTu1E4PNlWJKtmjt+DjvknSkpOFBkS0bkk3S39Xl4G9
         u7a0YbPCL9AeUv1dB0cCa2JMivFQYB63talCA=
X-Forwarded-Encrypted: i=1; AFNElJ811KCjWF8r9Bu7W6+fnSrQowY2J3xqTjPAMb5CwGjr9YDrJaW/Vh2eL8doFOHqOWNXQx376B92NIjx@vger.kernel.org
X-Received: by 2002:a05:6300:85:b0:3b2:8675:4866 with SMTP id adf61e73a8af0-3c03e498517mr3885539637.31.1783183678637;
        Sat, 04 Jul 2026 09:47:58 -0700 (PDT)
X-Received: by 2002:a05:6300:85:b0:3b2:8675:4866 with SMTP id adf61e73a8af0-3c03e498517mr3885496637.31.1783183678052;
        Sat, 04 Jul 2026 09:47:58 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef188sm32062761c88.2.2026.07.04.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:47:57 -0700 (PDT)
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
Subject: [PATCH net v2] bnge/bng_re: fix ring ID widths
Date: Sat,  4 Jul 2026 22:17:47 +0530
Message-ID: <20260704164747.1995227-1-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22756-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[vikas.gupta@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:vikas.gupta@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B907708000

Firmware requires more than 16 bits to address TX ring IDs for its
internal QP management. Widen the associated HSI ring ID fields to
32 bits. The values firmware assigns remain within 24 bits, bounded
by the hardware doorbell XID field.

RX, completion, and NQ ring IDs are unaffected and remain 16-bit.

Fixes: 42d1c54d6248 ("bnge/bng_re: Add a new HSI")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
V2:
Sashiko review: 
- Updated commit message only, no code change.
- Sashiko's concern about XID overflow is valid in theory but is
  handled by firmware, which guarantees TX ring IDs stay within the
  24-bit hardware doorbell XID field.
- Backward compatibility with older firmware is not a concern.

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


