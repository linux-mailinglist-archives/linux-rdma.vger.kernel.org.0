Return-Path: <linux-rdma+bounces-22985-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zrfRNYdpUGrjyQIAu9opvQ
	(envelope-from <linux-rdma+bounces-22985-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 05:39:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECE737061
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 05:39:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=qGS+xEDl;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22985-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22985-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD39304568C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 03:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302B35B657;
	Fri, 10 Jul 2026 03:34:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8435E95C;
	Fri, 10 Jul 2026 03:34:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654452; cv=none; b=ekvuKX95jNfcSn8dw9hkERpJD0tYl5KDfSlNK/AIFE45mO1qINE1w2R8Hk7kH+mj4jlfydcHApGFyEAJH2IWMxAp8zXVKOqHfoOSly99Pf3/erlrpWXg7xJoGwrI63wFVS/F091IPsLPPLFQLGwJxCG+t98pS4QJMo0J0GqU/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654452; c=relaxed/simple;
	bh=4XW8A4/bhU/l0n2A2mVESVBFBZHJcKiViicPlcMOPFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hALBNjIo6BfSemD2NAHe6MEkAaij860grjpNEO/LuORQshDgcE9oOVCpQEEItAzMp4yQVUGNizMZ/qYR5RKpk0qh0tWb1LJ73xNd4Z9Cmw6WPJftXwcmfLZAWUyMj6G1SiRQzSiiHox/SSKXesi3dmhKZlf/6MqYfgf/iK1/M58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qGS+xEDl; arc=none smtp.client-ip=115.124.30.132
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783654442; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wZp3SDNMhMcixAufm65TuZRozT66qpaOyktDEsVoLdY=;
	b=qGS+xEDlq/bj/GvqwYGoqBiJGYs8wj0/IN4tGYen4seJXzGVXQ2mHbQWiGl9PEqSGrgdCA8Inw/cYjJEjIUlPoT/D88Eh4jMQa1TnGUfT1OgEYqDl5dytu8bS0rkaSzI7di/XH6nWnFigGCVPNHPswBMwv8wjpcNdvFjSNAMumU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X6mSWcu_1783654436;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X6mSWcu_1783654436 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jul 2026 11:34:01 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: [PATCH net-next v3 0/3] net/smc: transition to RDMA core CQ pooling
Date: Fri, 10 Jul 2026 11:33:53 +0800
Message-ID: <20260710033356.16460-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22985-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mjambigi@linux.ibm.com,m:wenjia@linux.ibm.com,m:wintera@linux.ibm.com,m:dust.li@linux.alibaba.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:sidraya@linux.ibm.com,m:jaka@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CECE737061

This series transitions SMC-R completion handling to RDMA core CQ pooling
via the ib_cqe API. The new completion model improves scalability by
allowing per-link completion processing across multiple cores and enables
DIM-based interrupt moderation.

As a side effect, the increased concurrency can amplify contention for TX
slots on the shared wait queue. Patch 3 addresses this by switching TX slot
allocation from non-exclusive wait_event() to prepare_to_wait_exclusive(),
which avoids thundering-herd wakeups under contention.

Patch 1 fixes smc_wr_tx_put_slot() to clear the v2 pending slot and buffer
structures instead of the pointer variables.
Patch 2 replaces the global per-device CQ and manual tasklet polling model
with RDMA core CQ pooling.
Patch 3 reduces TX slot contention by using exclusive wait queue entries
during allocation.

Link: https://lore.kernel.org/netdev/20260305022323.96125-1-alibuda@linux.alibaba.com/

---
Changes v1 -> v2:
https://lore.kernel.org/netdev/20260508063718.101622-1-alibuda@linux.alibaba.com/
1. remove unnecessary inline from static CQE init helpers.
2. Use ib_drain_qp() with +1 max_send_wr; 
3. Fix v2 state clearing.
4. Add re-check after schedule_timeout() to fix timeout/signal races.

Changes v2 -> v3:
https://lore.kernel.org/netdev/20260528084819.6059-1-alibuda@linux.alibaba.com/
1. Reserve +3 instead of +1 for the SQ to cover the drain, FastReg and
   SMC-Rv2 SEND WRs, avoiding SQ exhaustion that breaks ib_drain_sq().
2. Guard the recv WR repost with a per-link percpu_ref so no WR is
   reposted after ib_drain_qp(), fixing the RX repost/drain use-after-free.
3. Split the smc_wr_tx_put_slot() v2 clearing fix into a separate patch
   (1/3) with a Fixes: tag and reworded to the verifiable root cause.

D. Wythe (3):
  net/smc: clear the correct v2 slot and buffer in smc_wr_tx_put_slot()
  net/smc: transition to RDMA core CQ pooling
  net/smc: reduce TX slot contention with exclusive wait

 net/smc/smc_core.c |  10 +-
 net/smc/smc_core.h |  32 +++-
 net/smc/smc_ib.c   | 115 ++++---------
 net/smc/smc_ib.h   |   7 -
 net/smc/smc_tx.c   |   1 -
 net/smc/smc_wr.c   | 420 ++++++++++++++++++++++-----------------------
 net/smc/smc_wr.h   |  48 ++----
 7 files changed, 285 insertions(+), 348 deletions(-)

-- 
2.45.0


