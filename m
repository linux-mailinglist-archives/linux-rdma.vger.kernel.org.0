Return-Path: <linux-rdma+bounces-19119-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fv5M+6c1Wks8AcAu9opvQ
	(envelope-from <linux-rdma+bounces-19119-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 02:10:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3F3B5993
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 02:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E6F5302E0CE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2026 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D334A883F;
	Wed,  8 Apr 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jZrOm8gj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643664A35
	for <linux-rdma@vger.kernel.org>; Wed,  8 Apr 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607017; cv=none; b=e88JYzqwAgFwaL4JnPfl6icj0FuolQhmboTKkXiRI0As6QtLLAiphbo//Q4HBcGuXoXHMvhXuVcIdUSFzKSUADekkgsVNn8mTT69BW5uiV5u3eZU7OWxgIK6jJymAPnI124BA+EQFAA47YCJwxzUy+3dx1ogwLJgzb8bPgpTCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607017; c=relaxed/simple;
	bh=tmyJRCYNGd8dt9swtikiDxXHO1KNGuB5c3YX9eHIvKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvV4DRW7XyKhFLsIDsNR2dKV5moi3ih7ykEoYWtnyCBr1/ij184Jccz22rN7Heh9mYNM94sOPJNZINFU+QxZ9Ei9+DS6QHAM45u/ME2YOMi4+ziQgqRCSJf5DW2bJuLzkMI4NUbHUGJsOpWye/fQ39JRL1yx68m7uwBN9W3vpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jZrOm8gj; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775607011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kFFzLvq7ZvG1uGtLa8Rm+ALcKcE4RreLa1Aw0/kdtxc=;
	b=jZrOm8gjvk6NxzHhMfsIJeaCWZEKPuEZcLa//fqt1Bo/ANktiBhsvP2Fr5TNO3gZs9NwRh
	nznxzfdXBwvvewnsz5Ypn/wYhQRTT2b2MBiT4YyxS9XA26QECVyd+2W6SZg/sHytvNsPiY
	AmA+C66B8kPhQ0D9faJXK/MmUZuCtJQ=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v5 0/3] Support PERF MGMT for RXE
Date: Wed,  8 Apr 2026 08:09:53 +0800
Message-ID: <20260408000956.486522-1-zhenwei.pi@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19119-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 4AE3F3B5993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v5:
- remove patch "RDMA/core: Fix memory free for GID table", it was
  applied by Jason separately.
- suggested by Yanjun, use 'skb_network_offset' to calculate the
  length of received packets.

v4:
- drop rxe_ib_device_get_netdev and RXE_PORT, use 1 instead
- avoid UAF to get skb length
- remove one-line wrapper rxe_counter_get, use atomic64_read instead
- fix memory free for GID table, this is a new patch in this series.

v3:
- merge 'RDMA/rxe: use rxe_counter_get' into previous commit
- zero *out* MAD memory
- return success with error status rather than failure to avoid
  uplayer hang

v2:
- Fix overflow for PMA counter *link_downed_counter*
- Use *rxe_counter_get* instead of *atomic64_read* for hw-counters

v1:
Support PERF MGMT for RXE, add sent/received bytes for RXE counters,
also improve coding style.

zhenwei pi (3):
  RDMA/rxe: remove rxe_ib_device_get_netdev() and RXE_PORT
  RDMA/rxe: add SENT/RCVD bytes
  RDMA/rxe: support perf mgmt GET method

 drivers/infiniband/sw/rxe/Makefile          |   1 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |   2 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h         |   6 ++
 drivers/infiniband/sw/rxe/rxe_mad.c         | 101 ++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_mcast.c       |   4 +-
 drivers/infiniband/sw/rxe/rxe_net.c         |   9 +-
 drivers/infiniband/sw/rxe/rxe_recv.c        |   2 +
 drivers/infiniband/sw/rxe/rxe_verbs.c       |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  10 +-
 10 files changed, 129 insertions(+), 13 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c

-- 
2.43.0


