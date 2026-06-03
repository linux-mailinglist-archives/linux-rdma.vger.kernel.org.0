Return-Path: <linux-rdma+bounces-21670-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PnbpDJvbH2oKrQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21670-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 09:45:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A11635595
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 09:45:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=UiC7Kb7d;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21670-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21670-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F2F530561E3
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 07:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EAC407CD8;
	Wed,  3 Jun 2026 07:28:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F3405859
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 07:28:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471727; cv=none; b=bPdEclZBEI1KRiYf0SlQqHozb4QUomWX+qAbCiZWaIjuM1ddbLuKxF2Hx7pIl0trFb7jyK7F0q9o4BmGfbrbKjVq8eC/ONJb/BFreWNRxghI9PFoeLPHRbEeFkJgB9V3hx82AcwdfT0ZTHpG3j2Q1av6G+swSiq6uIeDXNIjp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471727; c=relaxed/simple;
	bh=7klY1QUhcL+4MShkBnX6NQVk+G2YKNZtoaFNBtswftQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6C6339QcztbTldrlWuj6DgbsDk32UshdSom6TQJdvkVeHoQ5qSD04lkbWdiVzi4vECt1TIXU2uYBo6RPATFxSeHtWebekjAG6lzHFUwbfyJxycOBmvcVTyoaEAAJ0SjqQ0CLvVwYRXTMnnD/+xl3aQuGWaDmTeTFOsIIDVIqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UiC7Kb7d; arc=none smtp.client-ip=95.215.58.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780471713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H2eg9VVkZ9LKkV74LTCeL970klMGkJd/dvEy2RVfl6g=;
	b=UiC7Kb7dj0p+jovFsVML/VK1s0MCXab8+NY/xGsjFN/4Mq9KNLA164PKDShL7DDrvfJbx0
	8eVMmZ0Su0ZB0rIxpM88L5kbpPtA4tqRfaomGj8neSDh679NnY/QK1691E0PRSOyqLpzoE
	jgehy1VsLdZMCKj5/ykiKpyV3oiCPxQ=
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
Subject: [PATCH 0/2] net/mlx5: Only consider online CPUs in affinity subset check
Date: Wed,  3 Jun 2026 15:26:55 +0800
Message-Id: <20260603072657.10868-1-fushuai.wang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21670-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90A11635595

From: Fushuai Wang <wangfushuai@baidu.com>

Hi all,

When an SF is created after a CPU has been taken offline, the IRQ affinity
check fails because existing IRQs in the pool may have affinity masks that
include the now-offline CPU. This causes SF creation to fail even though
suitable online CPUs are available.

This series fixes this issue and includes a small cleanup:

Patch 1 folds cpumask_copy() into cpumask_andnot() for better code clarity
in comp_irq_request_sf().

Patch 2 filters affinity masks to only consider online CPUs before the subset
check, ensuring SF creation succeeds when CPUs have been taken offline.

--WANG

Fushuai Wang (2):
  net/mlx5: Simplify cpumask operations in comp_irq_request_sf()
  net/mlx5: Only consider online CPUs in affinity subset check

 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |  3 +--
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.36.1


