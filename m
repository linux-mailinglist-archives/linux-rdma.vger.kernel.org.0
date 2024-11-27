Return-Path: <linux-rdma+bounces-6121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4079DA50C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 10:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C3165708
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE3194AD6;
	Wed, 27 Nov 2024 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RC1C2GIw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220E18C34B;
	Wed, 27 Nov 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700757; cv=none; b=lkklMDXoCvHmeE/CJH8ANZdburms+Mibc3lP8e0+u6jk2Ez4iRhqnikXh8B76Od16vChZsVIOqOrS0ulXnfobZySLj2/0vehZU/oh//jsVDwPEcflD9tabG/HknnaNsubJfpfPPdTfK2ZqrftfTWToJNx/DaVqXOqNFieuoaBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700757; c=relaxed/simple;
	bh=gu2vZT/2iRMabaUOTrjqjCQrKwKaTtHMaSx1ts+anNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SChTYGVAq7Uv4WvRwlL0YNmnenbzfPQrX/IMHpIzv2+NImRTi/tN1gqpGBt9aNdRVjhNOF8DAKDZNSeapGDplVqIOhIZ+DCtuNl6dNIlhTOrDPhZo3cccBUGtAtP3CqGtEdFNNGIqKAJVwXEl0ej3GhinzSU+gKjs1hK1y18BaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RC1C2GIw; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732700747; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4Caqb99WZwC0Qyt+fqAndTSCbi4GCwA/ttLovCUg0Cs=;
	b=RC1C2GIwN7f28odRFKqD5d8GX1zmHyIvPnoVFAG7E17Z8CoHKJtirECcSA+1L1yL/xa+kz2Ol74yl+0b09/2waOizFJLbgTvwTXPdoOLDOXP1kdPitplsb3Skg5VmkHwul8+gvuT75Vs/GHH3K732g4H1+7iVd9qGowc1KhRUes=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKMBIea_1732700746 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 17:45:46 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next 2/2] net/smc: support ipv4 mapped ipv6 addr client for smc-r v2
Date: Wed, 27 Nov 2024 17:45:33 +0800
Message-Id: <20241127094533.18459-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241127094533.18459-1-guangguan.wang@linux.alibaba.com>
References: <20241127094533.18459-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_INET6 is not supported for smc-r v2 client before, event if the
ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
will fallback to tcp, especially for java applications running smc-r.
This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
using real global ipv6 addr is still not supported yet.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..41923e0a6e33 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1116,7 +1116,8 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
 	ini->check_smcrv2 = true;
 	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
 	if (!(ini->smcr_version & SMC_V2) ||
-	    smc->clcsock->sk->sk_family != AF_INET ||
+	    (smc->clcsock->sk->sk_family != AF_INET &&
+	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
 	    !smc_clc_ueid_count() ||
 	    smc_find_rdma_device(smc, ini))
 		ini->smcr_version &= ~SMC_V2;
-- 
2.24.3 (Apple Git-128)


