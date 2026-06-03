Return-Path: <linux-rdma+bounces-21671-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3fM2O4HaH2qprAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21671-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 09:40:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4A635507
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 09:40:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=OeNMOhBG;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21671-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21671-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BFC8319D140
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D94403EBA;
	Wed,  3 Jun 2026 07:28:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D8401A16
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 07:28:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471734; cv=none; b=g3pZYoXMjAr0dif92xhAigPTh1RlajfmGz+tDWIHbi5qqr7UFOYqEZ/ciQPXkq1rNK0ZdkwOSF6CKCQwzdMqY7Zu4D6EhMwABjKMV+mDy2S1g55In4aA5JsQBs6dcjcjpUFKsvsqAQ68VRvsGRGjNm2IILctdWEfGP+WODNiE3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471734; c=relaxed/simple;
	bh=u6F/2C+fvBzquIXPlmU/3j5rjS4sBgawX1rb11MeljM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTTVG1eiDw2WE0jReGHicP1IsE/z3xwiIyJKNDyDY05PVtNIwzqT7yPw/B+kWubVJjbZ58dF+uN0ulcK2zwDI5V3jmvHozFOZF5M9BfU2Cfab3T140plMwQ7Dri5ep950XySnXSKzYfban2vz4ocxKX6tRlqhDlLenFaCwOY9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OeNMOhBG; arc=none smtp.client-ip=95.215.58.177
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780471729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbOdb5ayEdhtH6yD3DNTe0xKjBwdKK62mPaH1TFHgak=;
	b=OeNMOhBGJqIjbiZIKthmLgw+5Il6LKUo0dcmPR1dzBbD8H+Js2nFq3Ay1dDPfbpf9til3s
	tUnLRquTGzzLGphpHl8IzZlcuVPPCm6Gz9QJYauVovHPLRPdsbZ+neQD3wHgkzgroL5Cfe
	iK0+sPgC+3g24EjqfI/auwnChrp1bJg=
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
Subject: [PATCH 2/2] net/mlx5: Only consider online CPUs in affinity subset check
Date: Wed,  3 Jun 2026 15:26:57 +0800
Message-Id: <20260603072657.10868-3-fushuai.wang@linux.dev>
In-Reply-To: <20260603072657.10868-1-fushuai.wang@linux.dev>
References: <20260603072657.10868-1-fushuai.wang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21671-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85F4A635507

From: Fushuai Wang <wangfushuai@baidu.com>

When an SF is created after a CPU has been taken offline, the IRQ pool may
contain IRQs with affinity masks that include the offline CPU. Since only
online CPUs should be considered for IRQ placement, cpumask_subset() check
would fail because the iter_mask contains offline CPUs that are not present
in req_mask, causing SF creation to fail.

Filter the affinity mask to only include online CPUs before checking if it's
a subset of the requested mask, ensuring SF creation succeeds in this scenario.

Fixes: 061f5b23588a ("net/mlx5: SF, Use all available cpu for setting cpu affinity")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 994fe83da4be..8c0df240b888 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -102,18 +102,26 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
 	struct mlx5_irq *iter;
 	int irq_refcount = 0;
 	unsigned long index;
+	cpumask_var_t tmp;
 
 	lockdep_assert_held(&pool->lock);
+
+	if (!alloc_cpumask_var(&tmp, GFP_ATOMIC))
+		return NULL;
+
 	xa_for_each_range(&pool->irqs, index, iter, start, end) {
 		struct cpumask *iter_mask = mlx5_irq_get_affinity_mask(iter);
 		int iter_refcount = mlx5_irq_read_locked(iter);
 
-		if (!cpumask_subset(iter_mask, req_mask))
+		cpumask_and(tmp, iter_mask, cpu_online_mask);
+		if (!cpumask_subset(tmp, req_mask))
 			/* skip IRQs with a mask which is not subset of req_mask */
 			continue;
-		if (iter_refcount < pool->min_threshold)
+		if (iter_refcount < pool->min_threshold) {
 			/* If we found an IRQ with less than min_thres, return it */
+			free_cpumask_var(tmp);
 			return iter;
+		}
 		if (!irq || iter_refcount < irq_refcount) {
 			/* In case we won't find an IRQ with less than min_thres,
 			 * keep a pointer to the least used IRQ
@@ -122,6 +130,8 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
 			irq = iter;
 		}
 	}
+
+	free_cpumask_var(tmp);
 	return irq;
 }
 
-- 
2.36.1


