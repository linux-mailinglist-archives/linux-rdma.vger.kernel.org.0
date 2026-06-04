Return-Path: <linux-rdma+bounces-21773-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nih6O6l2IWqjGwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21773-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:59:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE06401ED
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:59:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="R8/MNnUd";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21773-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21773-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F8C1308D914
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091847CC71;
	Thu,  4 Jun 2026 12:58:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCB47D955
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 12:58:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577896; cv=none; b=n8RZIVsUajPNbFSUrAJ4ATBYbhMjnNzU0WNFcW+NcCobM/2iUC6PO69p5s1n6JR6jyb9s9xE6TyA45FTjY4N+nP71yUXc0+cmU/9eNGSBQ+/jYmoOmCj/u1uZaysXEL1LwueIYzhXFmVScjVDbbdt4n84cWlq1iyzy+wZsLWVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577896; c=relaxed/simple;
	bh=79Mdp1AOyEnseQ6YciyHtVOQDkgA3tpWYMzYOqm3TB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdV4OQuB5/H1JY2F/QUymAnkWh4aHOKdOWKpOPmaZa0o/VPFeZHV8GEQMfLmuGZS8wGVUVNqUl9PR4/kLyWXvrkNJJRQI0meoN/E77ks+C4d+QbjqHYjCbjG/VhmsJNmNOw5F4Iq7XVyhC1IEKKq/yRlioCjEIsPYNHhjSS0QTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8/MNnUd; arc=none smtp.client-ip=91.218.175.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780577882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlSixzpVPe58sKtClq15cLtWL0cPTKiwPec4PU8Bn4o=;
	b=R8/MNnUdp7U9NmYIomXbeTYl81HJaA8cfrOUNgwObKtfaTD2c5B8Y2OjGRiVP1lccHLQbp
	Wbt+F87UWjO8nbZ2a8bqQUaExGBCBuqnV94hIzrFGoaFWcNWnM7T7YTlwPPZCDLEFjWCg9
	CPb4TqLDTsutvPatFBRBWeQdJw9J+sw=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shayd@nvidia.com,
	parav@nvidia.com,
	moshe@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH v2 1/2] net/mlx5: Simplify cpumask operations in comp_irq_request_sf()
Date: Thu,  4 Jun 2026 20:57:04 +0800
Message-Id: <20260604125705.21241-2-fushuai.wang@linux.dev>
In-Reply-To: <20260604125705.21241-1-fushuai.wang@linux.dev>
References: <20260604125705.21241-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21773-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shayd@nvidia.com,m:parav@nvidia.com,m:moshe@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fushuai.wang@linux.dev,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fushuai.wang@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81DE06401ED

From: Fushuai Wang <wangfushuai@baidu.com>

Combine cpumask_copy() and cpumask_andnot() into a single
cpumask_andnot() since the function can take cpu_online_mask
directly as the source.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 22a637111aa2..d11ec263d53c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -886,8 +886,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 		return -ENOMEM;
 
 	af_desc->is_managed = false;
-	cpumask_copy(&af_desc->mask, cpu_online_mask);
-	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
+	cpumask_andnot(&af_desc->mask, cpu_online_mask, &table->used_cpus);
 	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
 	if (IS_ERR(irq)) {
 		kvfree(af_desc);
-- 
2.36.1


