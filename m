Return-Path: <linux-rdma+bounces-18761-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JUtLMO7yGltpwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18761-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 07:42:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D128F350D58
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 07:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D49453003BEA
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 05:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF427A92D;
	Sun, 29 Mar 2026 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IYHiURiE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02431A6800
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774762934; cv=none; b=Ij7XKgqIwSpNok7hm8QUQekJ2IbwcOEFRUMP0BTaxYZp6Exu/B0x873SPaHhqNv9bwKRCW1V8/xyO/clruv4lJYaypyANGXFYE3NC1Xr2ImNOuA6bcRJeOc3CNjIxdHA0OLdbU/86XIiKbnDWTHruve1CfP3D1IEKYxvUIEj/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774762934; c=relaxed/simple;
	bh=10uSlXO7IkCEjMKG9u3rDSEgvNkEYEqS/Um72migEH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIwBn4Qxulu8H49p4ywqFObfoRB6I342L0TGycgqQybzbgb0txkqSl9CiaqZEMnEUuImvhd6L9cE2bMKtEHvnNfQJzY7hhXRFtwBYnU6BXK7VMsx4vHSNhgkcusV5owMmmk9Y/v5xjMTdR3Us7K7+/5AHl20Ga+ziAFonYGqkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IYHiURiE; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774762931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PSpvIs+Y2VC39j0YfgwKxOGlIE0SV+BCSEa3+7qKcKo=;
	b=IYHiURiEiq6Ht5ElOXR7mvVdiH6H4TmQhm2TO15F4v8zwcfOifM6b0y0SlHSbnxVJ6w13r
	ffehAynmH2uI5uViFbeubNefb+6Pi5dtgzdM93oK3GdILb31x70FuztkwA9SWM2cCMTCQ2
	HkXIno/a3+4iYHINEAlkzVnVCqlbJOs=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v3 0/3] Support PERF MGMT for RXE
Date: Sun, 29 Mar 2026 13:41:53 +0800
Message-ID: <20260329054156.125362-1-zhenwei.pi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-18761-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:?];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DMARC_DNSFAIL(0.00)[linux.dev : SPF/DKIM temp error,none];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.907];
	R_DKIM_TEMPFAIL(0.00)[linux.dev:s=key1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid]
X-Rspamd-Queue-Id: D128F350D58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
  RDMA/rxe: use RXE_PORT instead of magic number 1
  RDMA/rxe: add SENT/RCVD bytes
  RDMA/rxe: support perf mgmt GET method

 drivers/infiniband/sw/rxe/Makefile          |  1 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  4 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  2 +
 drivers/infiniband/sw/rxe/rxe_loc.h         |  6 ++
 drivers/infiniband/sw/rxe/rxe_mad.c         | 93 +++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_net.c         |  7 +-
 drivers/infiniband/sw/rxe/rxe_recv.c        |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c       |  9 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h       | 11 +++
 9 files changed, 126 insertions(+), 8 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c

-- 
2.43.0


