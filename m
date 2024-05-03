Return-Path: <linux-rdma+bounces-2244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAFF8BADCE
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D2D283ACA
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08D153BCD;
	Fri,  3 May 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQ89anbO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10823153815;
	Fri,  3 May 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743413; cv=none; b=oJ6vBd2kEE3lsEdlLx6yer/R3MwNfLE4nGbNlybEKH3bsQ3ou/yOkaGD0xUu/NFoECMb89MuYflVM8JnuFshm5gZEU2nMhwajNGOGJMi/W7GrCo9yfrAkJgR8BJI7Y4dV1xc16ejQ2NeZYpubpKoJVcEnDeZBzKjz+EsP5yhoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743413; c=relaxed/simple;
	bh=7pJ5q5LbH0iJOm0Bg/dm21/xbfIlw7Cm0hnQW91qbDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cRDMsj3Atk083rCvY62y3lxgZ67PK5cuxg5dFocsTb2VTaxoSdDU7UN3e8G8bqTRbgcfm5hJPaneKK1sxQWAcmheSREV1VERcgtB9tOY8bD9jlbAJ9kqG46fI+NqztozYkZY4OLrj7KE79KjStVVOlXMIR9gQcaqZBYTjMKIFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQ89anbO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714743412; x=1746279412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7pJ5q5LbH0iJOm0Bg/dm21/xbfIlw7Cm0hnQW91qbDE=;
  b=cQ89anbOmjFFd9MWTcWVqiXLGMbJzawC0SHKVHq/OqNkX8RQrzEzJ+/1
   AnQlBen8FIIIDs4kXxSb4s4C1ju1ngYgWloyDp2rEpJ97VXia1BYrcBSd
   Xb4c9CQk7jA6JM7xxiRM4s3ui42r+4gHJ3z2dfXuIwtGfixLcX5cGKNzL
   vDPYQLaJwR6DJFQOm8lhIA9ST6qgfAEEQX8q6G2JNLisEIzQ0Kb2jGV50
   S5EsBzOiXkeSk+G6ktDkBqG4Bd8UA+P+n+sGumKh7sx3H6yy3Gns0WjyP
   utYEIjMcrlHTkQ70scEsjqcLRACiKa38mskSBO3eJLDO4XyE6TzBvBtkA
   w==;
X-CSE-ConnectionGUID: 5SOiyjFNRSO9urPQKaj1Ag==
X-CSE-MsgGUID: X01JBy5dQByaUBb0/WD7Jg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10479389"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10479389"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 06:36:51 -0700
X-CSE-ConnectionGUID: F9ytbLenQra98K6ky2IBQg==
X-CSE-MsgGUID: AJz3CST7Q0yDfmFyt0FbFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27963572"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.56])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 06:36:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dean Luick <dean.luick@cornelisnetworks.com>
Subject: [PATCH v2 1/1] RDMA/hfi1: Use RMW accessors for changing LNKCTL2
Date: Fri,  3 May 2024 16:36:40 +0300
Message-Id: <20240503133640.15899-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert open coded RMW accesses for LNKCTL2 to use
pcie_capability_clear_and_set_word() which makes its easier to
understand what the code tries to do.

In addition, this futureproofs the code. LNKCTL2 is not really owned by
any driver because it is a collection of control bits that PCI core
might need to touch. RMW accessors already have support for proper
locking for a selected set of registers to avoid losing concurrent
updates (LNKCTL2 is not yet among the registers that need protection
but likely will be in the future).

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
---

This was part of other series earlier but sending this indenpendent now
to not appear to be part of a cross subsystem series.

v2:
- Small improvements into the commit message

 drivers/infiniband/hw/hfi1/pcie.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 119ec2f1382b..7133964749f8 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -1207,14 +1207,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 		    (u32)lnkctl2);
 	/* only write to parent if target is not as high as ours */
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= target_vector;
-		dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-			    (u32)lnkctl2);
-		ret = pcie_capability_write_word(parent,
-						 PCI_EXP_LNKCTL2, lnkctl2);
+		ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
+							 PCI_EXP_LNKCTL2_TLS,
+							 target_vector);
 		if (ret) {
-			dd_dev_err(dd, "Unable to write to PCI config\n");
+			dd_dev_err(dd, "Unable to change parent PCI target speed\n");
 			return_error = 1;
 			goto done;
 		}
@@ -1223,22 +1220,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 	}
 
 	dd_dev_info(dd, "%s: setting target link speed\n", __func__);
-	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKCTL2, &lnkctl2);
+	ret = pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_TLS,
+						 target_vector);
 	if (ret) {
-		dd_dev_err(dd, "Unable to read from PCI config\n");
-		return_error = 1;
-		goto done;
-	}
-
-	dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
-		    (u32)lnkctl2);
-	lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-	lnkctl2 |= target_vector;
-	dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-		    (u32)lnkctl2);
-	ret = pcie_capability_write_word(dd->pcidev, PCI_EXP_LNKCTL2, lnkctl2);
-	if (ret) {
-		dd_dev_err(dd, "Unable to write to PCI config\n");
+		dd_dev_err(dd, "Unable to change device PCI target speed\n");
 		return_error = 1;
 		goto done;
 	}
-- 
2.39.2


