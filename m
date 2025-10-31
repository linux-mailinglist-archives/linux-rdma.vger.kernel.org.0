Return-Path: <linux-rdma+bounces-14159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A680C23260
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 04:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7804EFE94
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 03:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF41254841;
	Fri, 31 Oct 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wnbInXFi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15C223311;
	Fri, 31 Oct 2025 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880733; cv=none; b=dFVSsJbKU/zw28MigCub/WdAO4thq/Bwa+RqhvRlh+QmPUoodWMxWm6Dmx6PNVQyGwaqZKxcaI+NEQJHvwfvLFQTeaS5pDSPsFn7sCjzv83Yu5K93Eag1uDY4JTrJ2XM2QUBPi5ZC3NhZZTuBX4ahX89dbUg7q+CeU2QjA3fiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880733; c=relaxed/simple;
	bh=GgihVl+uBsyPu7qZtoEFNChRo3uWJ78xi8wguId8kH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZUHLBizQ5x3TLJCROeEmwlbYqjxvd98z6r0YVs9KrDDxUfsO/F6oj6qph7BKHmFqi7ExkClpf++4Ktms5KqhvXfwBb1fs94k86incTcXzpW6lsOhOKIpaIkG3T3AypYO6dXZq0PdN3B6HVK44IgKwpfw1LpZzbJQSCzhpKLw+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wnbInXFi; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761880721; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=/PhDBJxwxzmVHtJmdwo2JNVrwmuvABBk+lIBUXeVPL8=;
	b=wnbInXFin1h/DCJEFsfkLnYcBw54ULZetq8aefsiMAASBXhWZqSBO29ZXu3r/bPPd19A9yR/1q3oKUrbOq1OOuNk2NHlJu32gAWbV+YJPz3IcWlpfRmn0iRm+czAtUSvP4WY/Iuw7xoIqAaDhPBDffQncd440pc1cocdGBueLtw=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrNZpdm_1761880708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 11:18:41 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: [PATCH net] net/smc: fix mismatch between CLC header and proposal extensions
Date: Fri, 31 Oct 2025 11:18:28 +0800
Message-ID: <20251031031828.111364-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current CLC proposal message construction uses a mix of
`ini->smc_type_v1/v2` and `pclc_base->hdr.typev1/v2` to decide whether
to include optional extensions (IPv6 prefix extension for v1, and v2
extension). This leads to a critical inconsistency: when
`smc_clc_prfx_set()` fails - for example, in IPv6-only environments with
only link-local addresses, or when the local IP address and the outgoing
interface’s network address are not in the same subnet.

As a result, the proposal message is assembled using the stale
`ini->smc_type_v1` value—causing the IPv6 prefix extension to be
included even though the header indicates v1 is not supported.
The peer then receives a malformed CLC proposal where the header type
does not match the payload, and immediately resets the connection.

Fix this by consistently using `pclc_base->hdr.typev1` and
`pclc_base->hdr.typev2`—the authoritative fields that reflect the
actual capabilities advertised in the CLC header—when deciding whether
to include optional extensions, as required by the SMC-R v2
specification ("V1 IP Subnet Extension and V2 Extension only present if
applicable").

Fixes: 8c3dca341aea ("net/smc: build and send V2 CLC proposal")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc_clc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 157aace169d4..d9ff5f433720 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -922,7 +922,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 				htons(smc_ism_get_chid(ini->ism_dev[0]));
 		}
 	}
-	if (ini->smc_type_v2 == SMC_TYPE_N) {
+	if (pclc_base->hdr.typev2 == SMC_TYPE_N) {
 		pclc_smcd->v2_ext_offset = 0;
 	} else {
 		struct smc_clc_eid_entry *ueident;
@@ -931,7 +931,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		v2_ext->hdr.flag.release = SMC_RELEASE;
 		v2_ext_offset = sizeof(*pclc_smcd) -
 			offsetofend(struct smc_clc_msg_smcd, v2_ext_offset);
-		if (ini->smc_type_v1 != SMC_TYPE_N)
+		if (pclc_base->hdr.typev1 != SMC_TYPE_N)
 			v2_ext_offset += sizeof(*pclc_prfx) +
 						pclc_prfx->ipv6_prefixes_cnt *
 						sizeof(ipv6_prfx[0]);
@@ -949,7 +949,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		}
 		read_unlock(&smc_clc_eid_table.lock);
 	}
-	if (smcd_indicated(ini->smc_type_v2)) {
+	if (smcd_indicated(pclc_base->hdr.typev2)) {
 		struct smcd_gid smcd_gid;
 		u8 *eid = NULL;
 		int entry = 0;
@@ -987,7 +987,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		}
 		v2_ext->hdr.ism_gid_cnt = entry;
 	}
-	if (smcr_indicated(ini->smc_type_v2)) {
+	if (smcr_indicated(pclc_base->hdr.typev2)) {
 		memcpy(v2_ext->roce, ini->smcrv2.ib_gid_v2, SMC_GID_SIZE);
 		v2_ext->max_conns = net->smc.sysctl_max_conns_per_lgr;
 		v2_ext->max_links = net->smc.sysctl_max_links_per_lgr;
@@ -1003,7 +1003,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 	vec[i++].iov_len = sizeof(*pclc_base);
 	vec[i].iov_base = pclc_smcd;
 	vec[i++].iov_len = sizeof(*pclc_smcd);
-	if (ini->smc_type_v1 != SMC_TYPE_N) {
+	if (pclc_base->hdr.typev1 != SMC_TYPE_N) {
 		vec[i].iov_base = pclc_prfx;
 		vec[i++].iov_len = sizeof(*pclc_prfx);
 		if (pclc_prfx->ipv6_prefixes_cnt > 0) {
@@ -1012,11 +1012,11 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 					   sizeof(ipv6_prfx[0]);
 		}
 	}
-	if (ini->smc_type_v2 != SMC_TYPE_N) {
+	if (pclc_base->hdr.typev2 != SMC_TYPE_N) {
 		vec[i].iov_base = v2_ext;
 		vec[i++].iov_len = sizeof(*v2_ext) +
 				   (v2_ext->hdr.eid_cnt * SMC_MAX_EID_LEN);
-		if (smcd_indicated(ini->smc_type_v2)) {
+		if (smcd_indicated(pclc_base->hdr.typev2)) {
 			vec[i].iov_base = smcd_v2_ext;
 			vec[i++].iov_len = sizeof(*smcd_v2_ext);
 			if (ini->ism_offered_cnt) {
-- 
2.45.0


