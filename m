Return-Path: <linux-rdma+bounces-14747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD25C8325C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBF6D349E73
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE341EF09B;
	Tue, 25 Nov 2025 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG1lSMJx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9A1E5018
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039302; cv=none; b=oq5+uK9d7/Qtafa3AsymFQuMItUzF81FMX5DLGAJQP5sdUO9/pjXGTIN4FDGRMlk0vjav7SKbQagTDdeU/pKW5BZLY2XoBZMrFOKomrYNdUFWCG0GKpiR4XPlLsE6wDKLIQBUV+58WiaOzGf7Z/hYpZhj7fauZsm3NuWpmZgQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039302; c=relaxed/simple;
	bh=U7ooH7M23aJweJK4quEOrEL782UMS3ynvj6lOknI6Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn/55k2Rx8MYQPup51Prom03n4JWSXwzyD9v7ki3LsAjzAbZGVzcKyCYid8/O3PLse5irzSDfcW7waeXMJ/Gn2LFvN31PZcl2Kpv5UZFEEl6X7KR1TJ0JNOf7pxgsQ+NWRuDnjr8OVwztsW4AjC8vaHTDlQLiG+wJOy0OG5to+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG1lSMJx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039301; x=1795575301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7ooH7M23aJweJK4quEOrEL782UMS3ynvj6lOknI6Kk=;
  b=mG1lSMJxa4ghGcQ5Jj1bpfhT6bqQVRQc6rro9RbapoHJQI7mSTH6CokA
   iquk2b4NlSUHVsddy+3wqlwLuEyy4oEQ6u6nuZXs11zenyj/gpzDx0MJE
   6EE1ZC2I+JTtOXFhsxBwXbwek8+IWzVhckJEaQnQhCa0smKau0yCTGApA
   YYa6Vu8cmtUFqzj5MlWxs7z3179A9Nconix321FF7OjaY4bpiN62AV3Ey
   h58x7Cmb8ulSA3TtU8uuXrRLEhUNkY1tuImyWMmYMhK7w7VLWOAXNuB4B
   1xzNgtolO4I36syXjkeFRCeFNWAlYp2JMftcrKCV+saYvzaT97H0e/Xd9
   w==;
X-CSE-ConnectionGUID: V4ESYwBcRuWhfEzqJARTgA==
X-CSE-MsgGUID: LkH0CkfrQN67r2goLYc6Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942222"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942222"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:55:00 -0800
X-CSE-ConnectionGUID: Vfew7+SLQKOQcB1xLDybyQ==
X-CSE-MsgGUID: d1vVy3JNSBGqDroNbZHZcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800313"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:59 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com
Subject: [PATCH 7/9] RDMA/irdma: Do not set IBK_LOCAL_DMA_LKEY for GEN3+
Date: Mon, 24 Nov 2025 20:53:48 -0600
Message-ID: <20251125025350.180-8-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
References: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Moroni <jmoroni@google.com>

The GEN3 hardware does not appear to support IBK_LOCAL_DMA_LKEY. Attempts
to use it will result in an AE.

Fixes: eb31dfc2b41a ("RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 695ff459e7ab..8ff63fc55507 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -27,7 +27,8 @@ static int irdma_query_device(struct ib_device *ibdev,
 			irdma_fw_minor_ver(&rf->sc_dev);
 	props->device_cap_flags = IB_DEVICE_MEM_WINDOW |
 				  IB_DEVICE_MEM_MGT_EXTENSIONS;
-	props->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
+	if (hw_attrs->uk_attrs.hw_rev < IRDMA_GEN_3)
+		props->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
 	props->vendor_id = pcidev->vendor;
 	props->vendor_part_id = pcidev->device;
 
-- 
2.31.1


