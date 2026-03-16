Return-Path: <linux-rdma+bounces-18197-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALRFLjRQuGlHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18197-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:47:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 700E229F35C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C30C830406BF
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579C03DFC9D;
	Mon, 16 Mar 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAw6VNYf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D73E3C46
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686463; cv=none; b=Q9g38VDpci4WCkBYqvZiHej1UpgNVRNr0NbneBvbv29eN6xbt7EV1cdcjwjbJOpu6afq+ISYdHgLV1GX9qEzJMW4B65l9KXNxFmwXmnwjUZJT3e/XkD6puOoG+qDcV1mv1ez6o8pdUUF4vPXwlUAATQVxXzhY+SUPBTYuH4gMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686463; c=relaxed/simple;
	bh=gsjF2pphCEvXwhvGhGXJBIq90QJnIL6smihb26tMcBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iErrcviSiL/V49H3zASc6hGbEKxbhz1XRD8Jt6RGCAHqGYejl0jfQRefnjDPVhjNoay30iW2UYXhtwkgWXD6oFv+U22ia55nk80UHmvnVbeyyue2FqnY5repwQ5YxoBSDBiscvMy5vwwjimgAEkQIyNTA0cVLYaHa/hgxa/HFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAw6VNYf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686459; x=1805222459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gsjF2pphCEvXwhvGhGXJBIq90QJnIL6smihb26tMcBY=;
  b=TAw6VNYfJNBPd6FMd+5v0lCoppDya+M0TXBOFJLVz1GXVRzprLUTyw+S
   Q4RQhHFwHb63FDy8f2F+HR/km8UdICXxc6VwslUlOYrgdv0MJDx0xIuRk
   XqUW2K41akV25fgnOglyUyWYDXh250D0jhSA1IhjKRDSmjEUdP3jtOSV7
   8NEAey6iX8wv9UhMrl1/B7IO90rnVfU45ZxgMuGQT9K7SNOjPj7ebeZ8O
   HIH7eAe6XvYXFYnGZPgQMtna4ti3tDVwJdUulnElDRcV3d2sVpw46E74v
   YDAZE7A4bzrDZVkG1YNXFMhbwu/A0WtlzeA8j1bcowOwgVwuAlG5Eu6Jo
   Q==;
X-CSE-ConnectionGUID: 5KtGnvwKRWe3ZltgUSxkKA==
X-CSE-MsgGUID: gAF+8qTiTxWPpoCyFeZ0PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86067607"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86067607"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:49 -0700
X-CSE-ConnectionGUID: 9LAoDjkYTMujB8f87uM86Q==
X-CSE-MsgGUID: 9kNHy5n5R2Gx0jjhd8NFXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252520418"
Received: from soc-pf51ragt.clients.intel.com ([10.122.184.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:46 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 05/12] RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
Date: Mon, 16 Mar 2026 13:39:42 -0500
Message-ID: <20260316183949.261-6-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18197-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 700E229F35C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove a NOP wait_event() in irdma_modify_qp_roce() which is relevant
for iWARP and likely a copy and paste artifact for RoCEv2. The wait event
is for sending a reset on a TCP connection, after the reset has been
requested in irdma_modify_qp(), which occurs only in iWarp mode.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8de09cda7884..41c75f79500d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1462,8 +1462,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				ctx_info->remote_atomics_en = true;
 	}
 
-	wait_event(iwqp->mod_qp_waitq, !atomic_read(&iwqp->hw_mod_qp_pend));
-
 	ibdev_dbg(&iwdev->ibdev,
 		  "VERBS: caller: %pS qp_id=%d to_ibqpstate=%d ibqpstate=%d irdma_qpstate=%d attr_mask=0x%x\n",
 		  __builtin_return_address(0), ibqp->qp_num, attr->qp_state,
-- 
2.31.1


