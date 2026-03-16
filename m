Return-Path: <linux-rdma+bounces-18201-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFH3CFhQuGlHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18201-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:47:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30529F399
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE4A8309415C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87AB3E4C9F;
	Mon, 16 Mar 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+7ZJzuL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F13E4C85
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686472; cv=none; b=tEHaqBU7Az29y+qn3WR7W8VvnqfDVYIUan7p2cYbJzJi2d4gYROMdFeWY/zzTzjZsTavk8q9fIQFPAQHoG42MhmMlErTXnau+nwO18gndTxniYWCLO1tu++As3wI+tu7VhMbyGCECbw3YvGy8faSaxk2wWxgpN4s3/gEdzqQdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686472; c=relaxed/simple;
	bh=mnzlCxEk3JalcJk7G53bPfdDZdVFfszP0N7VVjZEGAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVZMoSQhVrjiifufMk06mEdyCeqk9t2OaGEah/oSbYOKEaZwD3oD5eOgxOVifV2v045W5Y+LAz3J4Q/Z8y4poUpycyrt477NdsVNKNeyvdVz/jsbGKQT6RxlgE/5uaWaTMYf6Hc/Q9Xr4Qi05IN7g2NjLnz+pK8JppPknDS72TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+7ZJzuL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686468; x=1805222468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mnzlCxEk3JalcJk7G53bPfdDZdVFfszP0N7VVjZEGAk=;
  b=T+7ZJzuL5LlgkCmUQgjGBOKnbOIeFAOszINUWPoA+mAa9NjsHUtmsmPC
   T9VKLeJhbfyRwTkeWqxkABEpUYOry0bz5c1siPzGq/Fs7zoQx7RcRjRZJ
   YFwg19JCGfbJTQH1I17451VXDuNRcpp0Hyz3sRMnTLWiMyKV4IF+SLj4s
   rhNDromH0msTd4z3HYGfC0wH7fHyJNhYkIPbRy6OZYrpxStbdftRw3pJv
   HOWIO5OfR5JfEi4qM6AHuU8oj9WM4s6bPjdjan3o7ieavTSVTJRizyFhq
   WU3qSJDa3Jo1+KyPt9t+LUQaj0YG2wVXgvMObexGYvOsrpfGrfW2Qw8+5
   A==;
X-CSE-ConnectionGUID: uJS8c7Q0R96mIQx5gYZPjQ==
X-CSE-MsgGUID: LRfn9pWGRRm/6ym3v1fS2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86067624"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86067624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:52 -0700
X-CSE-ConnectionGUID: m0twXoDGRROPeAAlGFJrKA==
X-CSE-MsgGUID: 437zMdokRfybhRCpqlS+4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252520437"
Received: from soc-pf51ragt.clients.intel.com ([10.122.184.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:50 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 09/12] RDMA/irdma: Return EINVAL for invalid arp index error
Date: Mon, 16 Mar 2026 13:39:46 -0500
Message-ID: <20260316183949.261-10-tatyana.e.nikolova@intel.com>
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
	TAGGED_FROM(0.00)[bounces-18201-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA30529F399
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When rdma_connect() fails due to an invalid arp index, user space rdma core
reports ENOMEM which is confusing. Modify irdma_make_cm_node() to return the
correct error code.

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 6557e1299a47..c952b735e187 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -2241,11 +2241,12 @@ irdma_make_cm_node(struct irdma_cm_core *cm_core, struct irdma_device *iwdev,
 	int oldarpindex;
 	int arpindex;
 	struct net_device *netdev = iwdev->netdev;
+	int ret;
 
 	/* create an hte and cm_node for this instance */
 	cm_node = kzalloc_obj(*cm_node, GFP_ATOMIC);
 	if (!cm_node)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	/* set our node specific transport info */
 	cm_node->ipv4 = cm_info->ipv4;
@@ -2348,8 +2349,10 @@ irdma_make_cm_node(struct irdma_cm_core *cm_core, struct irdma_device *iwdev,
 			arpindex = -EINVAL;
 	}
 
-	if (arpindex < 0)
+	if (arpindex < 0) {
+		ret = -EINVAL;
 		goto err;
+	}
 
 	ether_addr_copy(cm_node->rem_mac,
 			iwdev->rf->arp_table[arpindex].mac_addr);
@@ -2360,7 +2363,7 @@ irdma_make_cm_node(struct irdma_cm_core *cm_core, struct irdma_device *iwdev,
 err:
 	kfree(cm_node);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static void irdma_destroy_connection(struct irdma_cm_node *cm_node)
@@ -3021,8 +3024,8 @@ static int irdma_create_cm_node(struct irdma_cm_core *cm_core,
 
 	/* create a CM connection node */
 	cm_node = irdma_make_cm_node(cm_core, iwdev, cm_info, NULL);
-	if (!cm_node)
-		return -ENOMEM;
+	if (IS_ERR(cm_node))
+		return PTR_ERR(cm_node);
 
 	/* set our node side to client (active) side */
 	cm_node->tcp_cntxt.client = 1;
@@ -3219,9 +3222,9 @@ void irdma_receive_ilq(struct irdma_sc_vsi *vsi, struct irdma_puda_buf *rbuf)
 		cm_info.cm_id = listener->cm_id;
 		cm_node = irdma_make_cm_node(cm_core, iwdev, &cm_info,
 					     listener);
-		if (!cm_node) {
+		if (IS_ERR(cm_node)) {
 			ibdev_dbg(&cm_core->iwdev->ibdev,
-				  "CM: allocate node failed\n");
+				  "CM: allocate node failed ret=%ld\n", PTR_ERR(cm_node));
 			refcount_dec(&listener->refcnt);
 			return;
 		}
-- 
2.31.1


