Return-Path: <linux-rdma+bounces-21771-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1WbtIBh4IWoSHAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21771-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 15:05:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C16402BD
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 15:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ksLpH5NC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21771-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21771-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C28304F2FB
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449547DD48;
	Thu,  4 Jun 2026 12:57:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712234B1A4
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 12:57:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577875; cv=none; b=EftKIMe9imi7tcV7xoIdEluxJYFieNZJfxWq++FCMchzJWT7b6ZV6Z2hfkQgbm7MBaZpEM5HNGyHL33LbMB1mkBXbn8fIIo6alS9gSuxmRGP9xyUw6WCocGCMtcaSkUiKcdfHEmvorxeqOTjC7OWjd2U0Xy+8uMu+bOULsaeJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577875; c=relaxed/simple;
	bh=zCcG0zycEcF5opS5BvS+8tk5FTqTS7tRZZEpnxTN1NA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cnfvIDhPJa1s5BT0IqNYEWbAN+EptmCZCBG/rOkAeAFnrAc0FnDdrcy288VHwm74YtlEFlWpcB9tQOq0eB4cjjL8ifnGOMlHYLcO4iaW1ceVmU0ECvWDtrUV5BsyDk6fX8bst8RHuUh+dlgvlhAlttKLRfztBssiUOccznq6V9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ksLpH5NC; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780577870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lxRMjpY6moeDrrxQnEZS/RUp5ZNpLvWccvW6bQxni0o=;
	b=ksLpH5NCEd2T2f8kbHPojy9FHxBQ9VDML4cjofnyEePgSaxiNx2w36t91jNGIkJcVevJb5
	LzndYgTuomGqblFC5H3NKsJMnIN8OumwDOejclp0X5oHXrmOLL/USlF6Bgpmh+2vDHK9Jn
	ZvNfI6KGF3doAwDuY2ZbCWq4yLTfTTw=
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
Subject: [PATCH v2 0/2] net/mlx5: Only consider online CPUs in affinity subset check
Date: Thu,  4 Jun 2026 20:57:03 +0800
Message-Id: <20260604125705.21241-1-fushuai.wang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-21771-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: D42C16402BD

From: Fushuai Wang <wangfushuai@baidu.com>

Hi all,

When an SF is created after a CPU has been taken offline, the IRQ affinity
check fails because existing IRQs in the pool may have affinity masks that
include the now-offline CPU. This causes SF creation to fail even though
suitable online CPUs are available.

This series fixes this issue and includes a small cleanup:

Patch 1 folds cpumask_copy() into cpumask_andnot() for better code clarity
in comp_irq_request_sf().

Patch 2 filters affinity masks to only consider effective CPUs before the
subset check, ensuring SF creation succeeds when CPUs have been taken offline.

--WANG

Fushuai Wang (2):
  net/mlx5: Simplify cpumask operations in comp_irq_request_sf()
  net/mlx5: Use effective affinity mask for IRQ selection

 drivers/net/ethernet/mellanox/mlx5/core/eq.c           | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.36.1


