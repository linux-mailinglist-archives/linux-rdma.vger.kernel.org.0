Return-Path: <linux-rdma+bounces-18754-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOrzMsqUyGmSngUAu9opvQ
	(envelope-from <linux-rdma+bounces-18754-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 04:56:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55192350776
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 04:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA691301D68E
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262EA1DDC3F;
	Sun, 29 Mar 2026 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HPZdzFCu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDC1448E0
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774752966; cv=none; b=gxQB7tDHQhGeUkpodeKbPLaHtlMl/Hhti5pztJf1+cXejPF4vaPi2NN4k+EJVLRltXw72lw0TPqRv0Q4D/uAaNzPLQSBLJDLPpG2aYj8IlFJIM3nhrCj4yxHvoeI3lDxWAGmwo++jP516bmzTdG/wl7GD+JR4ITMvxcTQu92gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774752966; c=relaxed/simple;
	bh=qZrsOUI0XeodSCNcTnnZAjAQqnW1mDDWRHJ8VGXmUgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVNFyIr9AdzQTIQV0KtKWpYnCHy8x8EwTx5sRkVRCQhJJPpuGk5TJGUFGLcDaELjLXz2BTkNH33HTI8hROpa7txDnB/thZy+8zN40JO5YqnOFSNfCCDFlk+M7tHJpt8LZoOUQTmgmkAjgq6KIqOJ86M0SzXGpDtbRIZrN6KfE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HPZdzFCu; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774752963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ky9IIDojgDL0Gu0ljsL8aDU8xiFNvJZ/9e7GE1gwc4=;
	b=HPZdzFCuoipq0xfzWgrxMJ73By5jQeheasmIFW6R1HMMx6jVpifoeCqA9wITNOL730VtiF
	yF8jWYYVlaMr9kYewhkwwrO2Idqd8ndqhC1jxBEMb2aWyBcJ/e1TLKKEClfzFQ4VCeaIyO
	kYvBVsWn240tpCge+2D7mcuR0c2pmgg=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v2 0/4] Support PERF MGMT for RXE
Date: Sun, 29 Mar 2026 10:55:48 +0800
Message-ID: <20260329025552.122946-1-zhenwei.pi@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18754-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 55192350776
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2:
- Fix overflow for PMA counter *link_downed_counter*
- Use *rxe_counter_get* instead of *atomic64_read* for hw-counters

v1:
Support PERF MGMT for RXE, add sent/received bytes for RXE counters,
also improve coding style.

zhenwei pi (4):
  RDMA/rxe: use RXE_PORT instead of magic number 1
  RDMA/rxe: add SENT/RCVD bytes
  RDMA/rxe: support perf mgmt GET method
  RDMA/rxe: use rxe_counter_get

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


