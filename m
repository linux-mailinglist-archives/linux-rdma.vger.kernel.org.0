Return-Path: <linux-rdma+bounces-13989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C1BFEE32
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5BC3A806D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 02:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4802116F4;
	Thu, 23 Oct 2025 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rEb1SiRT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD0202F93;
	Thu, 23 Oct 2025 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184819; cv=none; b=f88g1ea76zmX5B5LWs9vbHREBpzipsZc/GMnY9MGzkTL91ZIU3k5mrlmNs/AdfkqBhvOZScVEdu2sz8yzQPr9/FjeEXvMYuZzilChEDpLXiYEwAXkDzFr5a5ceemlcIJAGp/fIGkLfrjBx2xpXMyLhW/CYts13Pvcf/PX0PNc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184819; c=relaxed/simple;
	bh=nSOdYARV1fl6f0IsjQaaNY5QNXu/ZeoZLFVTrpywUgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXDSaXmq4HGaLQIIOHpzb347E5njmeo8GPmcGA1J22RuG/gUkJ/1xQHo0x7xLSlz5VL+eAWlPlz7x3r1kzrlqbM7NE4M+g5BnSWQYjYicxB/5iyxImDSGkSaqOotqgfEoyFP4yfwXduTkb4BH87BPbYJa2e0HAnsxiRgdQLUooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rEb1SiRT; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761184813; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=iZU0942UNkcVX/iydgsHp6D5fQSAZxQ09eg0+hPpWvY=;
	b=rEb1SiRT2JNb/5BICpqCUzMna5M8+jlcCZRY5+yYgN8wvah4a5olEEVnNNBV56vkTnSXLjUSU/mAA+K4FiVtevK+4rM1u8nKHsaYq02BYkAisaK0EEddR7z3RoB756Xvtjx8CIUHO4eAb5bzLEUSNekwGzTC1knbNyk0qe5HTDc=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WqoxsMN_1761184812 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 10:00:12 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] smc: rename smc_find_ism_store_rc to reflect broader usage
Date: Thu, 23 Oct 2025 10:00:12 +0800
Message-Id: <20251023020012.69609-1-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function smc_find_ism_store_rc() is used to record the reason
why a suitable device (either ISM or RDMA) could not be found.
However, its name suggests it is ISM-specific, which is misleading.

Rename it to better reflect its actual usage.

No functional changes.

Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/af_smc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 77b99e8ef35a..e9d0e62e0b1b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2140,7 +2140,7 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
 	}
 }
 
-static void smc_find_ism_store_rc(u32 rc, struct smc_init_info *ini)
+static void smc_init_info_store_rc(u32 rc, struct smc_init_info *ini)
 {
 	if (!ini->rc)
 		ini->rc = rc;
@@ -2203,7 +2203,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	mutex_unlock(&smcd_dev_list.mutex);
 
 	if (!ini->ism_dev[0]) {
-		smc_find_ism_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
+		smc_init_info_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
 		goto not_found;
 	}
 
@@ -2220,7 +2220,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 		ini->ism_selected = i;
 		rc = smc_listen_ism_init(new_smc, ini);
 		if (rc) {
-			smc_find_ism_store_rc(rc, ini);
+			smc_init_info_store_rc(rc, ini);
 			/* try next active ISM device */
 			continue;
 		}
@@ -2260,7 +2260,7 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
 		return;		/* V1 ISM device found */
 
 not_found:
-	smc_find_ism_store_rc(rc, ini);
+	smc_init_info_store_rc(rc, ini);
 	ini->smcd_version &= ~SMC_V1;
 	ini->ism_dev[0] = NULL;
 	ini->is_smcd = false;
@@ -2311,7 +2311,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
 	rc = smc_find_rdma_device(new_smc, ini);
 	if (rc) {
-		smc_find_ism_store_rc(rc, ini);
+		smc_init_info_store_rc(rc, ini);
 		goto not_found;
 	}
 	if (!ini->smcrv2.uses_gateway)
@@ -2328,7 +2328,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 	if (!rc)
 		return;
 	ini->smcr_version = smcr_version;
-	smc_find_ism_store_rc(rc, ini);
+	smc_init_info_store_rc(rc, ini);
 
 not_found:
 	ini->smcr_version &= ~SMC_V2;
@@ -2375,7 +2375,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
 	/* check for matching IP prefix and subnet length (V1) */
 	prfx_rc = smc_listen_prfx_check(new_smc, pclc);
 	if (prfx_rc)
-		smc_find_ism_store_rc(prfx_rc, ini);
+		smc_init_info_store_rc(prfx_rc, ini);
 
 	/* get vlan id from IP device */
 	if (smc_vlan_by_tcpsk(new_smc->clcsock, ini))
@@ -2402,7 +2402,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
 		int rc;
 
 		rc = smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
-		smc_find_ism_store_rc(rc, ini);
+		smc_init_info_store_rc(rc, ini);
 		return (!rc) ? 0 : ini->rc;
 	}
 	return prfx_rc;
-- 
2.32.0.3.g01195cf9f


