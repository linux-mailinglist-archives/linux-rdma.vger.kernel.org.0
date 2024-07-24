Return-Path: <linux-rdma+bounces-3956-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D627593B982
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2BE1F222F0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F76146A6F;
	Wed, 24 Jul 2024 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoSzC5Kl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AB1442F6
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864442; cv=none; b=BR/HeUymv8zxourejUiZvEA1LBDWoNFlJlmYTwbg4gfp6D3wYwVGbVlrWZp17AGUybCCubGNEfbwffZfvw3PTkfPnDYpU1AFw5uLNdQb9D/jsPQN5g9DHox2jqsGUv2wTMi0aoV7/9SvURvnGQBnGEF5QejrgF9bCtlu2tPOA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864442; c=relaxed/simple;
	bh=x1ttufVCCe5VokzfLpW4b4aQqaAncqWVczouQHx2jqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0BM+N82syPtZzkXo3POEmVgD6RmTNnK4/x3NcNUBvNunElxP4lR6ZvNiOxK036BuTiBPHts1TTMik8SUgLWX1M0/AwNIpZgqoro5OFu9uLSSS+sp/K7Hw4/Vg0JG66gY35Jf4J4yMBEVZBfIhzpNDdawST1M8b/XciVERdwUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoSzC5Kl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864441; x=1753400441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x1ttufVCCe5VokzfLpW4b4aQqaAncqWVczouQHx2jqM=;
  b=QoSzC5KleheDoyzXbsK77ilGmRcuJQcgKl42Y8zJBQTXRFbHxe9sfHJ8
   OVxQmeA2GNTtuUul6M66ZFEqxvujnT/kopqcCcq3SWgl/7esi3UzCpLiF
   q56zfoL5lo7yDJm52mNsW6UmGveIRNg0kV+qtUFg1lV1oLPC8l3lnrgui
   +LXXhRzH3u5GlvVfDRuZZl0QAAalh+QLL3/Mri6zxIzLEzTaTazRnvMS5
   pQdLZUywYzM6AWqax0bPYQjhQvA8TmHNxKnk5ry3C54OL5YbzOamG3oDQ
   MdYyz4VIdDN7JpZjRw/BQ3MKp9lMbOaYjLbSq4e3Fmxl9u6msZUHWrezi
   w==;
X-CSE-ConnectionGUID: EstEit7YS2+Wn7sNZR7HiA==
X-CSE-MsgGUID: RzeKf6WpQ12DeaSi8wMcpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999754"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999754"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:39 -0700
X-CSE-ConnectionGUID: wFmo0l6TSea/xMloW5OTOQ==
X-CSE-MsgGUID: zYRH75ZrQiGRGz0d61hVyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426023"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:37 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 07/25] idpf: use actual mbx receive payload length
Date: Wed, 24 Jul 2024 18:38:59 -0500
Message-Id: <20240724233917.704-8-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

When a mailbox message is received, the driver is checking for a non 0
datalen in the controlq descriptor. If it is valid, the payload is
attached to the ctlq message to give to the upper layer.  However, the
payload response size given to the upper layer was taken from the buffer
metadata which is _always_ the max buffer size. This meant the API was
returning 4K as the payload size for all messages.  This went unnoticed
since the virtchnl exchange response logic was checking for a response
size less than 0 (error), not less than exact size, or not greater than
or equal to the max mailbox buffer size (4K). All of these checks will
pass in the success case since the size provided is always 4K.

Fetch the actual payload length from the value provided in the
descriptor data_len field (instead of the buffer metadata).

Unfortunately, this means we lose some extra error parsing for variable
sized virtchnl responses such as create vport and get ptypes.  However,
the original checks weren't really helping anyways since the size was
_always_ 4K.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 65936de..e9a71d3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -664,7 +664,7 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 
 	if (ctlq_msg->data_len) {
 		payload = ctlq_msg->ctx.indirect.payload->va;
-		payload_size = ctlq_msg->ctx.indirect.payload->size;
+		payload_size = ctlq_msg->data_len;
 	}
 
 	xn->reply_sz = payload_size;
@@ -1291,10 +1291,6 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 		err = reply_sz;
 		goto free_vport_params;
 	}
-	if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN) {
-		err = -EIO;
-		goto free_vport_params;
-	}
 
 	return 0;
 
@@ -2557,9 +2553,6 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 		if (reply_sz < 0)
 			return reply_sz;
 
-		if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN)
-			return -EIO;
-
 		ptypes_recvd += le16_to_cpu(ptype_info->num_ptypes);
 		if (ptypes_recvd > max_ptype)
 			return -EINVAL;
-- 
1.8.3.1


