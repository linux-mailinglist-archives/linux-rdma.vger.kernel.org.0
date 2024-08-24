Return-Path: <linux-rdma+bounces-4537-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719EE95DADF
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D381C2148F
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491024437C;
	Sat, 24 Aug 2024 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7VCi5qs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838453A1C9;
	Sat, 24 Aug 2024 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469646; cv=none; b=DVUO4igHYsk8boVhsjDkmRRUMOIsxMXHpsE/8A9CZiMJkJ3pCwDydEbNVFRfl9VDElJbicwd6l+a2g/X9f0j0iJAFQOKxH2ZPIuOToumVBciUoExyoQ1N5UzYUB2T4T9+iuVS/gB6POW2EI5XWNJWFy9AFxR1OEA+pWUK5Zlf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469646; c=relaxed/simple;
	bh=0C/mXMYUaWsQaA5qG6O1xbnW+L6fYJXrXOmaRpz+/Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQKJwm4hLQdfuN+AcLKyHG9MU2P1NiVqSOShb8T7tt0DP86TSD4KX0/g2kNCYbFi0xwW7wqMtAv55j3zcEgOGbEi+OBWSTVvEVH8Nv69e7uEs7OcyBCVoBLpT7f69HTHsSIwFRAIkRiT+zSUELKnx66xUGFGLKBJVcRFkS8nY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7VCi5qs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469644; x=1756005644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0C/mXMYUaWsQaA5qG6O1xbnW+L6fYJXrXOmaRpz+/Co=;
  b=Z7VCi5qsYsh2jAPe3rpw8jEmdk4KjulXLjulrddvHxf088SAVp3S1EWE
   5LrrXs4hthoKA8hBIJxinE0ogTbbvWBWWQ0dE/VvigQQd3XuwOyircY/g
   PnpW5omug26OTSBXq1gxVBRtSepwhZO65uvEMOlrmKY/LSQ1Vz58LXP58
   TkuMow2/3ibFsRmlfsEecc2FGEiNz//Ps/NKffutqNmb7O/bedYr42wLo
   ebmDQVCV4h2eHkmk7kXgV/usOdZV2RqB4Ymn6F3XVNs5XY5hQgt8Jfvet
   jAxSOTbSIa7NDQcYENE0AYiOjdG3gV5PrLAeZIt6J3sAiU24Gyh3ztMTw
   A==;
X-CSE-ConnectionGUID: x3C1U1ZiRBuqR2wgRgR0xw==
X-CSE-MsgGUID: yGeBN9kHS3ucaZNzUxQV8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187785"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:42 -0700
X-CSE-ConnectionGUID: ri/fKwGnSuiX3uduyxa9Kw==
X-CSE-MsgGUID: sj5SERKbSi2HQQdvulmGFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492090"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:41 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 07/25] idpf: use actual mbx receive payload length
Date: Fri, 23 Aug 2024 22:19:06 -0500
Message-Id: <20240824031924.421-8-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
References: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
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
index 6b7ead2d4cf2..2a9669017b2e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -666,7 +666,7 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 
 	if (ctlq_msg->data_len) {
 		payload = ctlq_msg->ctx.indirect.payload->va;
-		payload_size = ctlq_msg->ctx.indirect.payload->size;
+		payload_size = ctlq_msg->data_len;
 	}
 
 	xn->reply_sz = payload_size;
@@ -1296,10 +1296,6 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 		err = reply_sz;
 		goto free_vport_params;
 	}
-	if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN) {
-		err = -EIO;
-		goto free_vport_params;
-	}
 
 	return 0;
 
@@ -2603,9 +2599,6 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 		if (reply_sz < 0)
 			return reply_sz;
 
-		if (reply_sz < IDPF_CTLQ_MAX_BUF_LEN)
-			return -EIO;
-
 		ptypes_recvd += le16_to_cpu(ptype_info->num_ptypes);
 		if (ptypes_recvd > max_ptype)
 			return -EINVAL;
-- 
2.42.0


