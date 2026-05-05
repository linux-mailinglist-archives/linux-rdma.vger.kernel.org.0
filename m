Return-Path: <linux-rdma+bounces-20037-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qjx8AViC+mngPQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20037-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 01:50:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6C4D4CD9
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 01:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D760300BEAD
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 23:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1FD33A02B;
	Tue,  5 May 2026 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJFbQ1GA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B613090C6
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025040; cv=none; b=hYD6tB/QDEmX2HTqfWkE0U4P7NybAYYIGS1Hz7B6f3Tm3ykF4ldaOwCNXQFiU6a6rim41x08AaV7efIalZ0sdGA7ia1zYshcVPUA8eum8yrgVGGTUAzw1iVIvjYOzIB7OCt1QVedKqmgGYHKOnpjrmXbQQC8VdOx535/SssxwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025040; c=relaxed/simple;
	bh=b0+sikzvNYfNWiv4eEBKwYdzayPztWTMNL7LUGw6qpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ue746+rBaWRH//Os8cSEMfDKUmF9JckA7jOuFR9Bw6v0FnY2hNDYFp5VN2XUq6Km5go82KwjUNII+p7U+wQ+vJ2KPn9YX8oK9ZZdtd6qJ/nBMJ4wQXAjmhlNxmyijyAtOSRpWW4Vs573RJcImL114c8AuqRqWZFyyw5czbo3+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJFbQ1GA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d73422431so5451472f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778025037; x=1778629837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jviD8hPEm7lughBQuX/QL6NEuZ/mYGqrq0e4z3+1mUw=;
        b=MJFbQ1GA9RwDz6psrHMElWReazbqsemnUFwYBbLkcj6jumOTII06pMc2yhU99IhKEL
         z0rGwgR4MIJwfj6C0a36+Bm5rcuiIFKm5bYi8EOEz+zHDnVIpVvuTlIZXrvPqK6mo0z9
         p7MunXN5y/BHoqxrqFG+TQuzIvHUouW9ilB2GNRvk8Y6+ArRJ3DnNoWCHx+5RUXlAgiV
         BTCBGrb8V7iwNjgzZGDoRU6994/JZVPNupI+K17gzU+CxFc8fYiKIa+EHYC4aSWF8JXL
         /7oigQ9ADLkliLRAG3QoilYthRRi+EKXVXBmYBV/vubVP7Mxdm82sKMWNJ07f/PMIR0S
         VD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778025037; x=1778629837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jviD8hPEm7lughBQuX/QL6NEuZ/mYGqrq0e4z3+1mUw=;
        b=EETU6C9/5qTItbvq0XIwEfxnHIPY8jGEFdoBRBZ8ODFp+n1TQdhLJceE+E3VNPgFv4
         Z7Q9k+JKPxuAEFMw54ztU2mpvgkipSvvaFDFYIUuuCmzvsuBH04Lgqml51FVf5oH1JF1
         VKjM3efj03lcpm2/FiA48W/UcVfH410z8f5mQ17xJFoQW34ac8jXEFuvHG4MGFoZ0m4c
         F0HQbI1Ungb00MaVao6fePE5s6Mz8QWl20I+ehPDpsI38YGO8OJvGsn+Pne/Qu/wwof3
         ZJT1VNu0OoVBDcq22HJ2IWWRujMyJSd7TLOcegs/E1nr1wFzUGfQBKkZz8dnoxd9XPIB
         +gqA==
X-Forwarded-Encrypted: i=1; AFNElJ8hA1B7MJX8klV3nsR377TAmF2gKhXuP+AOKplFeT9Bo2uDnnqRBUYvp55wEj4GFO45AViEvpHfAiUJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHEY9TCPQaOrOMqzGL/2RXJzTxKv/uNffxD8IA5sGxsC83HRH
	BCmzyxBBx39Mom8LEQjingbzZ/P551MeuDn8j4gSwSJBnUR3Hg7Kokro
X-Gm-Gg: AeBDietDzEORn1VOFkplbh8OP5geBSXx4pLqA6xtP3G8YThtozewX8zr3S9MJB6y4KK
	wxtIoQn1j7fG9kmoZP4vdgYf2MqPFu5hWq5tkJy/K6+/2wldIzm47vMhuzZVTeMjMDveJzXORKJ
	VYWabrCSuOKEv0AI5ZDbtRh2FNHpXTZMDclvBXDUIyPrJhHpzhbWJfVp362Ju0KSlRFJulwCBwC
	yH1fYt1q0PG3egAeoOqwkZqxkaKFuamSRDkluC+Sq55uwS2XEH/qIbIFv6xkywAs/Z1gRWuz64v
	53Fa3BKvRqXyZY9RgKvdCn39p1TcLivqj7TrVcKRjMFreQ7Y0knZVvA+jdwwBVMJfl9tGfkkyQD
	D195V+wZHJ2NNWPQYlECkAlwwt68Aws/CwjZ0y9MZ+amnk5y9MlduAgUTHMY4dj/gPisVUvbGDz
	oRjZHHaTW8kGhpzyR/nCQy7YSO0j+oZVLShmJUDIxUNF/Jssd2WvalwLS59afJlYmFBslmjgxAQ
	naDXgdZHgAPsRKhDs6T/T8JPDj7QNYm+CyzBD1dXAxM873Fi9BR
X-Received: by 2002:a05:6000:2386:b0:43f:e938:1e67 with SMTP id ffacd0b85a97d-4515d99fff7mr1670239f8f.38.1778025037016;
        Tue, 05 May 2026 16:50:37 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055e2d3d0sm7658839f8f.34.2026.05.05.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 16:50:35 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5e: CT: Fix NAT miss rule cleanup on init failure
Date: Wed,  6 May 2026 00:48:33 +0100
Message-ID: <20260505235029.51045-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0A6C4D4CD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20037-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

mlx5_tc_ct_init() creates the CT-NAT miss rule before initializing the
conntrack hash tables, workqueue and flow-steering state.

If one of those later initialization steps fails, the error path destroys
the CT-NAT table but does not delete the miss rule and flow group created
in that table.

Add a dedicated unwind step to delete the CT-NAT miss rule before
destroying the CT-NAT table.

Fixes: 49d37d05f216 ("net/mlx5: CT: Separate CT and CT-NAT tuple entries")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 6c87a1c7db09..15e406d29004 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -2349,7 +2349,7 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 					   &ct_priv->ct_nat_miss_group,
 					   &ct_priv->ct_nat_miss_rule);
 	if (err)
-		goto err_ct_zone_ht;
+		goto err_ct_nat_miss_rule;
 
 	ct_priv->post_act = post_act;
 	mutex_init(&ct_priv->control_lock);
@@ -2382,6 +2382,9 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 err_ct_tuples_ht:
 	rhashtable_destroy(&ct_priv->zone_ht);
 err_ct_zone_ht:
+	tc_ct_del_ct_table_miss_rule(ct_priv->ct_nat_miss_group,
+				     ct_priv->ct_nat_miss_rule);
+err_ct_nat_miss_rule:
 	mlx5_chains_destroy_global_table(chains, ct_priv->ct_nat);
 err_ct_nat_tbl:
 	mlx5_chains_destroy_global_table(chains, ct_priv->ct);
-- 
2.43.0


