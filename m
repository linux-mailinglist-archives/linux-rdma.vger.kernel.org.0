Return-Path: <linux-rdma+bounces-1027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A42856485
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C090B2EA3D
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F37130AEF;
	Thu, 15 Feb 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2M6HA2+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC5130AD3;
	Thu, 15 Feb 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003943; cv=none; b=aBr0nmPyJVCD/NcWgNJJeM1iipZi9CF9i/acOQ3DB3KxJX/9XDYmMe8tMTbwnDByheiAo2vGStDWoLxYgWvCJUo8EZDKKIo7S0dg7J4nLPrNQKHCV7b32Sh9mZh28dyoedDXytxF4ipLOSv18LmT7ptPETcGkHed2R+lwQEGbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003943; c=relaxed/simple;
	bh=O4jJ8i/gK8Pis+sDOmjDFyNSBQ1DPWMyPahef8wSofw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPVfZFmahOjTOCx2j0Az2+SAkFr+XOTOVWOoBjcOeiyNGATogt5MOGoUSvw6Gk/+JxBIph4mVThxTn71JeglCHnV2kUitIuHLri9qRjHVW2nI+m6tjt6IAUbVEqerCoRUhonDSnK7aB3tEljeuFyzsjZBNgDqLEPobWEqikZJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2M6HA2+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708003942; x=1739539942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4jJ8i/gK8Pis+sDOmjDFyNSBQ1DPWMyPahef8wSofw=;
  b=Q2M6HA2+ec7G4Q7L1VzHX8jukkN4GWCrtgcQ8QGo6r/lmZZw7lFhDsR5
   YVW7Drt4nyejCrC6+3iTGrTMo7qnaiJ7hqJqiwL3E/nq9tS7B6SmhN5GM
   dIjWHMTgoPW4p5UfWVv0IEYGLh8CA0HpMdXD6E09yeO2JVYW+ZGT4eVMa
   VlfZixEhJZ822lGbWLnShIAS+6qyvZvu3GMVZxb3WrNJv/fx51hjTD2NS
   0l2/IaC8L8VteVCtdrAiDwBilVLweiDLaUuLyn3XxxWye2w3JDZpoMsty
   /5vgnBhREp2rw8NXzT5Hvu8wfAOTwEyKIGMEr/ukGHZyoMI1O9qgEkZsW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1943626"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1943626"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="26690872"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.150])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:32:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	dri-devel@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/3] drm/radeon: Use RMW accessors for changing LNKCTL2
Date: Thu, 15 Feb 2024 15:31:53 +0200
Message-Id: <20240215133155.9198-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com>
References: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com>
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

LNKCTL2 is not really owned by any driver because it is a collection of
control bits that PCI core might need to touch. RMW accessors already
have support for proper locking for a selected set of registers
(LNKCTL2 is not yet among them but likely will be in the future) to
avoid losing concurrent updates.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/radeon/cik.c | 40 ++++++++++++++----------------------
 drivers/gpu/drm/radeon/si.c  | 40 ++++++++++++++----------------------
 2 files changed, 30 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 10be30366c2b..b5e96a8fc2c1 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9592,28 +9592,18 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
-							  &tmp16);
-				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN);
-				tmp16 |= (bridge_cfg2 &
-					  (PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pcie_capability_write_word(root,
-							   PCI_EXP_LNKCTL2,
-							   tmp16);
-
-				pcie_capability_read_word(rdev->pdev,
-							  PCI_EXP_LNKCTL2,
-							  &tmp16);
-				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN);
-				tmp16 |= (gpu_cfg2 &
-					  (PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pcie_capability_write_word(rdev->pdev,
-							   PCI_EXP_LNKCTL2,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL2,
+								   PCI_EXP_LNKCTL2_ENTER_COMP |
+								   PCI_EXP_LNKCTL2_TX_MARGIN,
+								   bridge_cfg2 |
+								   (PCI_EXP_LNKCTL2_ENTER_COMP |
+								    PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL2,
+								   PCI_EXP_LNKCTL2_ENTER_COMP |
+								   PCI_EXP_LNKCTL2_TX_MARGIN,
+								   gpu_cfg2 |
+								   (PCI_EXP_LNKCTL2_ENTER_COMP |
+								    PCI_EXP_LNKCTL2_TX_MARGIN));
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp &= ~LC_SET_QUIESCE;
@@ -9627,15 +9617,15 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 	speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
+	tmp16 = 0;
 	if (speed_cap == PCIE_SPEED_8_0GT)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (speed_cap == PCIE_SPEED_5_0GT)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
-	pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL2, tmp16);
+	pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL2,
+					   PCI_EXP_LNKCTL2_TLS, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
 	speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 85e9cba49cec..8eeaea64c75d 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -7193,28 +7193,18 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
-							  &tmp16);
-				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN);
-				tmp16 |= (bridge_cfg2 &
-					  (PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pcie_capability_write_word(root,
-							   PCI_EXP_LNKCTL2,
-							   tmp16);
-
-				pcie_capability_read_word(rdev->pdev,
-							  PCI_EXP_LNKCTL2,
-							  &tmp16);
-				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN);
-				tmp16 |= (gpu_cfg2 &
-					  (PCI_EXP_LNKCTL2_ENTER_COMP |
-					   PCI_EXP_LNKCTL2_TX_MARGIN));
-				pcie_capability_write_word(rdev->pdev,
-							   PCI_EXP_LNKCTL2,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL2,
+								   PCI_EXP_LNKCTL2_ENTER_COMP |
+								   PCI_EXP_LNKCTL2_TX_MARGIN,
+								   bridge_cfg2 &
+								   (PCI_EXP_LNKCTL2_ENTER_COMP |
+								    PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL2,
+								   PCI_EXP_LNKCTL2_ENTER_COMP |
+								   PCI_EXP_LNKCTL2_TX_MARGIN,
+								   gpu_cfg2 &
+								   (PCI_EXP_LNKCTL2_ENTER_COMP |
+								    PCI_EXP_LNKCTL2_TX_MARGIN));
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp &= ~LC_SET_QUIESCE;
@@ -7228,15 +7218,15 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 	speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
+	tmp16 = 0;
 	if (speed_cap == PCIE_SPEED_8_0GT)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (speed_cap == PCIE_SPEED_5_0GT)
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
 		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
-	pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL2, tmp16);
+	pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL2,
+					   PCI_EXP_LNKCTL2_TLS, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
 	speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
-- 
2.39.2


