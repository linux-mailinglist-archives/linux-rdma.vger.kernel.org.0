Return-Path: <linux-rdma+bounces-18193-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JIbIC9PuGlHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18193-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:42:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354B29F29B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E67533041155
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E563E1CFE;
	Mon, 16 Mar 2026 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBouRQun"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F693DFC89
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686455; cv=none; b=WdCLJU1AYSPY+o0cKELXHKXQrR28Voupoy4QCKaRcOmBvomQeSk7SY0Yu03E4/MTkuEVbYi2wZ5b9t6NtY+yyztW4S+zNMaxp46FX8xtaDwaWZe58INdKPGEZF3Uy+RKkyYeWzBWr4VhW49TkgtjLnlpOgD8RJ/jUZvQZiGnUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686455; c=relaxed/simple;
	bh=mI05hdIowl65pq2vZf87TtzkxdfhiIWfx1ht9ygal00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/ZfBfbKzMVWttTqFb++SzYkyA5f4aqzRjIg1d4WJaIGMFOFaweIfJucUJwnAy1TUUJDs2BU/OVp4WNuQoD0N/xXwvCLWPvGwij4YJqA726cgumhxYXT/PpRRHa1d8RF5w+tai8XFVvgG3vRFqgeenFU8UPlclo8yxwoHRoTxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBouRQun; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686447; x=1805222447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mI05hdIowl65pq2vZf87TtzkxdfhiIWfx1ht9ygal00=;
  b=jBouRQunUfksuYl6yVcn8S2reQlxwuoda9c8CrJ+wsaZKcUPiX3OlzBO
   pl+BctEBr1NcgpyGYzOJbLIJUVy0hF7rMHV3xKDOKIOZxNKHCvk5V+6Fr
   J1+MPYuQWzJhVqYSe7u6fK9i0C7jp+NrvXnX0W5y8dicuz66N+tX2C3KQ
   EECfA6/y27EzVa+kGOq+TYS3Ip7aUuXcz9w0myUL74/4Kyo7JHaLft0BN
   AJZGLOznLJ4LiKY9abKMsrAdQJ6mOt5pH7zZ0KrPrex4FCpZLTPmWf4FG
   xuJRZDJuO3HrrM5uMSqFeOVRPom8/PCzBYwc4THVi/1ESxQWmxBrUddPd
   Q==;
X-CSE-ConnectionGUID: 4KxzzkjSS5KsNhXTAoJcHQ==
X-CSE-MsgGUID: 84VEbx7YQ7mYz6JsgsmtwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86067591"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86067591"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:46 -0700
X-CSE-ConnectionGUID: brFfyRrlQqS3AYw+8yYUkQ==
X-CSE-MsgGUID: M4rqeZIcSpmsgGD6M92xIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252520405"
Received: from soc-pf51ragt.clients.intel.com ([10.122.184.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:43 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	Jacob Moroni <jmoroni@google.com>
Subject: [for-next 01/12] RDMA/irdma: Initialize free_qp completion before using it
Date: Mon, 16 Mar 2026 13:39:38 -0500
Message-ID: <20260316183949.261-2-tatyana.e.nikolova@intel.com>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18193-lists,linux-rdma=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:?];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	DMARC_DNSFAIL(0.00)[intel.com : SPF/DKIM temp error,none];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_SPAM(0.00)[0.950];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	R_DKIM_TEMPFAIL(0.00)[intel.com:s=Intel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 8354B29F29B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jacob Moroni <jmoroni@google.com>

In irdma_create_qp, if ib_copy_to_udata fails, it will call
irdma_destroy_qp to clean up which will attempt to wait on
the free_qp completion, which is not initialized yet. Fix this
by initializing the completion before the ib_copy_to_udata call.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1d0c2d8453a8..38bc0e656ecf 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1105,6 +1105,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	spin_lock_init(&iwqp->sc_qp.pfpdu.lock);
 	iwqp->sig_all = init_attr->sq_sig_type == IB_SIGNAL_ALL_WR;
 	rf->qp_table[qp_num] = iwqp;
+	init_completion(&iwqp->free_qp);
 
 	if (udata) {
 		/* GEN_1 legacy support with libi40iw does not have expanded uresp struct */
@@ -1129,7 +1130,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		}
 	}
 
-	init_completion(&iwqp->free_qp);
 	return 0;
 
 error:
-- 
2.31.1


