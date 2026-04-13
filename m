Return-Path: <linux-rdma+bounces-19266-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKKJAHSP3GkmTAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19266-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 08:38:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1453E7CF4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 08:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86E1A3004DD2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112F636213E;
	Mon, 13 Apr 2026 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pul6Srm9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363F221F24
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062319; cv=none; b=d7SNTDt5GHW/OmO37gbLXlTJamT3yHMWKNi/0IkxlaX2pBmvTugJ0o5FAmUXwrYG3GZVhMC1FHt0EG2nsf74AxEvTQCBIErkBC4/ECQRCMUAsd4WLuMw2vRRU6FlGm+iXR1j0w4mbt/mNjkZTdx39hEqMKc9KcRSbkqJvG8uk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062319; c=relaxed/simple;
	bh=hZy2BOsv7OzLC7RD+O2bH2Nc45A7UK4XrayutxrO6ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j01ccBLwVzJoREWQTUDw5DxpBCYRGzgY7MSVIAKULCCo+/f0m1gmA+YBykgpwtWgkNvlz254V5DwN8C28bhKIBFFEMRWgLqDkyKEWHrGfUGjCiCFMfqPTXy5l8/6sp4bPOtLiL4ow5OeH99yIbSz7HwLx03cr9u3YknW5J4MWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pul6Srm9; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776062314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lkbAARHTe/Lqb2fBSdysiadGIi+DBkHtOz4zzvWoqiA=;
	b=Pul6Srm9Xevwu8BZX+P/090fdPvUGDeBqFNaAqfXjwpxxjEji9HDvm+g6O83Nj0IPbsB5D
	NLZvCvPZJ0RRNXZrwiRITCN6Ba91M2Hqn18SyqSr8sbeCXrDydCJR7HZc931SQrqs4uAk6
	5zsN6i+vHpwmD8lYvD4e+13uJNK1DNs=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v6 0/4] Support PERF MGMT for RXE
Date: Mon, 13 Apr 2026 14:38:13 +0800
Message-ID: <20260413063817.636423-1-zhenwei.pi@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19266-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F1453E7CF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


