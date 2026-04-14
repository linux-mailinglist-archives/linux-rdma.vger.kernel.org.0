Return-Path: <linux-rdma+bounces-19319-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD9wNkbf3WkYkgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19319-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:31:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 433B03F5F4D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A32F3073D50
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93BB36403B;
	Tue, 14 Apr 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q+XgoP7n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EF2BDC13
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148216; cv=none; b=Zrln5ocsgLRvxmIQzB1q1l8kPOKgLsJza35lTp3iMcM3o7FeDhFaynbRAVWVrko52Yno7IuSRqb6gJoIBJL7mtOdoDnZkuwrXxHr0dRwJhrrXZCVxPH63qPV2l7WQ47YVImVBKLgN3g18YkcxwMLZvIvYsCbbc2NkHIGPNB3pwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148216; c=relaxed/simple;
	bh=qofAOlkwMnWmGd2rSs2+CKTMO/bDyAzTz7t8Dr0qxJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cu573ymHtTBfO/3O3tKGOQP8gaBIXSg68JqBaGlLznh8vEFWbWDnFaOByd/8pSVJCZ/UO9PKI+irg8QQKHULTwQsUgKtGhVXTgGX+kIAV7/nuY05bABuQ+xu/q5P2uE6V4K8danmRwEg5nAM7hHsyMCsEpcSvg7jv4YFgIz5jNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q+XgoP7n; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776148211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d/QcWfrjHz6qj3A8wgzahMIO7QNgKL/Rl2m/uVoUcz8=;
	b=Q+XgoP7nKAiimPPoCpT45B9n2efDhgG9Va4shMHTW+RIolB+/hQOuyOHy6gLtI8sqpeoDd
	uE1BdTzu+dJWTTM4drGLZfdLLC7xyk9wBtwD7tC2Yn1qMSx9FYNLDcaZJGnRZR3VgLDKcz
	vBcKC6rtdpayPACNbYmyIUc51lo6eRo=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v7 0/4] Support PERF MGMT for RXE
Date: Tue, 14 Apr 2026 14:29:44 +0800
Message-ID: <20260414062948.671658-1-zhenwei.pi@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-19319-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 433B03F5F4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v7:
- use 'counters/port_xmit_data' & 'counters/port_rcv_data' instead of
  'hw_counters/sent_bytes' & 'hw_counters/rcvd_bytes'

v6:
- return IB_MAD_RESULT_SUCCESS instead of 'IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY'
  on unsupported method
- add a script to verify the sent/rcvd bytes which is wrotten by Yanjun

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

Zhu Yanjun (1):
  selftest/rxe: Add selftests for perf

zhenwei pi (3):
  RDMA/rxe: remove rxe_ib_device_get_netdev() and RXE_PORT
  RDMA/rxe: add SENT/RCVD bytes
  RDMA/rxe: support perf mgmt GET method

 drivers/infiniband/sw/rxe/Makefile            |   1 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.c   |   2 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h           |   6 ++
 drivers/infiniband/sw/rxe/rxe_mad.c           | 101 ++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_mcast.c         |   4 +-
 drivers/infiniband/sw/rxe/rxe_net.c           |   9 +-
 drivers/infiniband/sw/rxe/rxe_recv.c          |   2 +
 drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h         |  10 +-
 tools/testing/selftests/rdma/Makefile         |   3 +-
 .../selftests/rdma/rxe_sent_rcvd_bytes.sh     |  75 +++++++++++++
 12 files changed, 206 insertions(+), 14 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c
 create mode 100755 tools/testing/selftests/rdma/rxe_sent_rcvd_bytes.sh

-- 
2.43.0


