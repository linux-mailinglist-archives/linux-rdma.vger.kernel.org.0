Return-Path: <linux-rdma+bounces-18746-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PFlLtqfx2m0ZwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18746-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 10:31:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6234DE9C
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 10:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90101303AAB9
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B95372B5A;
	Sat, 28 Mar 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q/FHGFyk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14218233149
	for <linux-rdma@vger.kernel.org>; Sat, 28 Mar 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774690136; cv=none; b=Lj+a/jNSvwr5XMfihH0kxTc7eWVZkY5Hfv1pu0N2YrUAabE53RMT6KKG72+NA863ofKSDJMdYq7t05T995T3EHwvbFtygQ4h6EJxj6KDaZk+YJCtdjasYQmZ1qfRMGeFDg/8z+AnQzTzcDG7pPvYEkqKpqMUweaftXzJTyFYJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774690136; c=relaxed/simple;
	bh=MwToWGGwAJxd4I07E76R9RLeAr7fUhYHdBo/93lT+dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCQXgrKSy5239f03lT1GPEL57solfN+UmI2wrsWRNudWnlowQSuKxuuHgwfrTQcWp+PaQhTJ254+wpgjkjCaxxbv/6Mmgthb+LTNrQuVkkHwkWBXjLY/1CwjUnYHhrcsk0ZgzLYIUInRQXEfYqKt/6RoqqIjqrLjjC1ep7RmXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q/FHGFyk; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774690133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ROJjKsrBGyUGnqrwClopQY/AxLgW8yrz9t0NfMUC7s=;
	b=Q/FHGFykyz/2wZkOaiokTkkB682snIof1/fknL7cnZl1Hag2c6w/LrSE2d67ETs6wuW9+w
	ZHc0vK49T495wCe3O4B0frCdKgFuWrQw92YhSZEhbbKOYsKdROJa01IZ2APZ8kY+Q8PTOK
	XiWxvQC3vcpiV5L8Ol6LXE1RGEmnZKA=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH 0/3] Support PERF MGMT for RXE
Date: Sat, 28 Mar 2026 17:28:35 +0800
Message-ID: <20260328092839.111499-1-zhenwei.pi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18746-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13F6234DE9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Support PERF MGMT for RXE, add sent/received bytes for RXE counters,
also improve coding style.

zhenwei pi (3):
  RDMA/rxe: use RXE_PORT instead of magic number 1
  RDMA/rxe: add SENT/RCVD bytes
  RDMA/rxe: support perf mgmt

 drivers/infiniband/sw/rxe/Makefile          |  1 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  2 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  2 +
 drivers/infiniband/sw/rxe/rxe_loc.h         |  6 ++
 drivers/infiniband/sw/rxe/rxe_mad.c         | 86 +++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_net.c         |  7 +-
 drivers/infiniband/sw/rxe/rxe_recv.c        |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c       |  9 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.h       | 11 +++
 9 files changed, 118 insertions(+), 7 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c

-- 
2.43.0


