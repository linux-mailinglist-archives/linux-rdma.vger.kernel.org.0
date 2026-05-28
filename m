Return-Path: <linux-rdma+bounces-21422-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ynLoMt0CGGqdZggAu9opvQ
	(envelope-from <linux-rdma+bounces-21422-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 10:54:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E59005EF026
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84A7F3056CBC
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6DE388865;
	Thu, 28 May 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MgWXD1r3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C21388366;
	Thu, 28 May 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958110; cv=none; b=DDhH/CnC9Ppjklwck/Rb3uImDkPNPRENWH4BP6bhGLKUu401+7w/hJ8f5+wpc50GShGCAvfTSwQmwOKzg+A+W/1C0xmLz4G0g/Q6AKnX1/ENtyEPEMn3YXvgubQnlw9XgX3SGdVJFY1+29FJ9wLkZUkVqdO147eYiLGfN3KHf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958110; c=relaxed/simple;
	bh=SHCRnHGL6mMAk0Biy3dMCezeGVl/nZP6tmScKa9PsQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8OR2Qruu+QHSQJv+9nJ6uNLjJmQ5o1PVnsx+UBt5xHj9xxCBGf2yS4Va9xFBFgEJYHW6UDxMUNKv90MbQ8ub3qJnRvN4RUoI++0M+1q02VResiwkKvOUWjOfKZtMzoEPGOCr3qFLt+gc2xLVPHYdL2dMeTADQo1Mja+FdEXPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MgWXD1r3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779958104; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RcUR/VFXnxPtP+q4Hidrg5oDfoem09IeciCVFtsVjnY=;
	b=MgWXD1r3ZYl4yl98a/2bYCBakRGlYD0MFGS3aRigSvh69xkpK0QMAo1nUjjuNnh4Xs4f3tMwa/zHTPaRv/S97zEKp9rCD8xDU+42YMra8Ggx9ZLbEu7vcqN/G7092PojKJjENOjI46lgwZU9FxLWDJ+qVt4MTu9xosPFaeA/HCk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X3lvM0y_1779958100;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X3lvM0y_1779958100 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 May 2026 16:48:23 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: [PATCH net-next 0/2] net/smc: transition to RDMA core CQ pooling
Date: Thu, 28 May 2026 16:48:17 +0800
Message-ID: <20260528084819.6059-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21422-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E59005EF026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series transitions SMC-R completion handling to RDMA core CQ pooling
via the ib_cqe API. The new completion model improves scalability by
allowing per-link completion processing across multiple cores and enables
DIM-based interrupt moderation.

As a side effect, the increased concurrency can amplify contention for TX
slots on the shared wait queue. Patch 2 addresses this by switching TX slot
allocation from non-exclusive wait_event() to prepare_to_wait_exclusive(),
which avoids thundering-herd wakeups under contention.

Patch 1 replaces the global per-device CQ and manual tasklet polling model
with RDMA core CQ pooling.
Patch 2 reduces TX slot contention by using exclusive wait queue entries
during allocation.

Link: https://lore.kernel.org/netdev/20260305022323.96125-1-alibuda@linux.alibaba.com/

---
Changes v1 -> v2:
https://lore.kernel.org/netdev/20260508063718.101622-1-alibuda@linux.alibaba.com/
1. remove unnecessary inline from static CQE init helpers.
2. Use ib_drain_qp() with +1 max_send_wr; 
3. Fix v2 state clearing.
4. Add re-check after schedule_timeout() to fix timeout/signal races.

D. Wythe (2):
  net/smc: transition to RDMA core CQ pooling
  net/smc: reduce TX slot contention with exclusive wait

 net/smc/smc_core.c |   9 +-
 net/smc/smc_core.h |  28 ++--
 net/smc/smc_ib.c   | 113 +++++----------
 net/smc/smc_ib.h   |   7 -
 net/smc/smc_tx.c   |   1 -
 net/smc/smc_wr.c   | 344 ++++++++++++++++++++-------------------------
 net/smc/smc_wr.h   |  40 ++----
 7 files changed, 215 insertions(+), 327 deletions(-)

-- 
2.45.0


