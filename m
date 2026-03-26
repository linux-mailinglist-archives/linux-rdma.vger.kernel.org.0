Return-Path: <linux-rdma+bounces-18679-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N2hEtbExGmu3QQAu9opvQ
	(envelope-from <linux-rdma+bounces-18679-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 06:32:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E032F695
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 06:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B5B302AD3F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 05:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EA32E8882;
	Thu, 26 Mar 2026 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iWCfnFyH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33449331A6D
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502881; cv=none; b=Qyqxx/c9Ly6+xpp70PP376vXB6ifKfUI70nH4aLIZ6tfpJcHMYgzDAaF/pZ27M1fDU/cSPzow/uLNDbP54GNLdT9Wc+zH6JljWGNZImfo8wpEtN0Y1eUls+pws1zzGsmwZcr+n5rOYOGfuNKg1jd0pd+rOgnZFcjxxXVWDxESgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502881; c=relaxed/simple;
	bh=WT/fYtyEYj45+gDAyMqPQDc2mnrVQi6jFOebj7IsXjI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iw8R0EwV7uRXVmvfsCzTpWR8leUi1LijnAoh7iZIAr3RUpfdCx0Rg1PvoAiZ6G9bblMLAKBU9JZWKQS1vFXNMcXt/uIFYDQ//OkOBek4RV+F3psfV3nkiUvpUmOyDF+o2j1+KoOnCiID4dG9za8XE2kmcgyl7o8cYLG2ocCcpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iWCfnFyH; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774502877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F+Qam07c9pVtUz6TL2pUyQIgJng9H+3zk5X4WM4M1EY=;
	b=iWCfnFyHxLX0wJz86K4IjyC2WAR6wf01GYYWWpVZk/oenO0SPX1TnfnCD2weTRXQkkbNwV
	gK3M0S0xnVt+/qFjfAidx6PXgfd35BX9OV73cljjm2nYRZOZx82NOnlLIGUEY0wpXzLZlG
	xDoYUW4SfV8jt73uEmbli/6FCnt7HuI=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	linux-rdma@vger.kernel.org,
	yanjun.zhu@linux.dev,
	mie@igel.co.jp
Subject: [PATCH 0/2] RDMA/rxe: Add dma-buf support for Soft-RoCE
Date: Wed, 25 Mar 2026 22:27:37 -0700
Message-ID: <20260326052739.3778-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18679-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org,linux.dev,igel.co.jp];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E3E032F695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset introduces dma-buf support for the Soft-RoCE (RXE) driver.
By enabling dma-buf, RXE can now participate in zero-copy data transfers
with other providers (such as GPUs) that export memory via dma-buf fds.

Traditionally, RXE only supported user-space memory regions (UMEM) based
on system RAM. This change extends RXE’s capability to handle peer-to-peer
(P2P) like workflows in a software-defined RDMA environment.

This patchset pass the rdma-core tests with the following link for the
rdma-core:

https://github.com/linux-rdma/rdma-core/pull/1055

Zhu Yanjun (2):
  RDMA/umem: Change for rdma devices has not dma device
  RDMA/rxe: Add dma-buf support

 drivers/infiniband/core/umem_dmabuf.c | 35 ++++++++++-
 drivers/infiniband/sw/rxe/rxe.c       |  2 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 89 ++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_odp.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 40 ++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 include/rdma/ib_umem.h                |  1 +
 8 files changed, 161 insertions(+), 12 deletions(-)

-- 
2.53.0


