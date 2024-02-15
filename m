Return-Path: <linux-rdma+bounces-1026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D77C8564AE
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 14:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D35B2CC69
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3756130AE4;
	Thu, 15 Feb 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGbE+k79"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572CD130ACA;
	Thu, 15 Feb 2024 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003931; cv=none; b=O30jorAmf5HdZXKNUlV/vGpOGNktyuvMFl0fqGCb07m3AwcAtJhdzYRmx44VqWKUe6j0+Rgpyqz+q0N9kpbahWEtjjPENclcP+mL4rPtl/HoiCOyLLiUB1+12ECn79ozWqoXbXu/pvnzJb99SS9sEsBYl2BzZPLmoLRLanTjZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003931; c=relaxed/simple;
	bh=xP2x+0oCU2VUeBJg+acvjjGA26vEwKMDv8882I1yP2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QBPd4llGO8a6ybra+X6sxElKlxhikKF2ZHm/hONOeX+C2y2TSxXfasv5qVloCknkGqG99X986TcpgQWyjR+FExS8tPRNAhPZcuwg8mX8VP7n5xaWBUEyRfUSq1RRaiRst+jhFZbCmaMyUMSpuWEcaXvN42c/82rFPNzg13rb4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGbE+k79; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708003931; x=1739539931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xP2x+0oCU2VUeBJg+acvjjGA26vEwKMDv8882I1yP2E=;
  b=lGbE+k79nWmScRnYJNW4RCLDE4hwxz9s/yRkjA6yhfqw9Z8M232rj5ru
   CHDupxg6iI1JBkmhlj+i2svKlZaB886t52rXEWxLpGTxkSZDxHN4OV/+L
   W1/z01pYn5FRFniVlLo1S9oVpBJnNEbk6WYvc3d0JIXTh2Z62vV9rWYNi
   QQt4sY43vgiua74EMQogqPEmh/ZOf/crDvDa2f8ozrQrvW0PgSGOr3Fk3
   EYCisicUo+T2AfVwwn3G2+Z7VvQeXbrKBfRRnfHqaGBDLQWNFYExL70iF
   nSjPDmpd53FVxyVKQwwx+XGV0RCap/JZ4dVVGHpzsOedy4U9JOTWL4mLj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2000321"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2000321"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:32:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3489788"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.150])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:32:05 -0800
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
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI LNKCTL2 RMW Accessor Cleanup
Date: Thu, 15 Feb 2024 15:31:52 +0200
Message-Id: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series converts open-coded LNKCTL2 RMW accesses to use RMW
accessor. These patches used to be part of PCIe BW controller series
[1] which will require RMW ops to LNKCTL2 be properly locked.

However, since these RMW accessor patches are useful as cleanups on
their own I chose to send them now separately to reduce the size of the
BW controller series.

[1] https://lore.kernel.org/linux-pci/20240105112547.7301-1-ilpo.jarvinen@linux.intel.com/

Ilpo Järvinen (3):
  drm/radeon: Use RMW accessors for changing LNKCTL2
  drm/amdgpu: Use RMW accessors for changing LNKCTL2
  RDMA/hfi1: Use RMW accessors for changing LNKCTL2

 drivers/gpu/drm/amd/amdgpu/cik.c  | 41 +++++++++++--------------------
 drivers/gpu/drm/amd/amdgpu/si.c   | 41 +++++++++++--------------------
 drivers/gpu/drm/radeon/cik.c      | 40 +++++++++++-------------------
 drivers/gpu/drm/radeon/si.c       | 40 +++++++++++-------------------
 drivers/infiniband/hw/hfi1/pcie.c | 30 ++++++----------------
 5 files changed, 68 insertions(+), 124 deletions(-)

-- 
2.39.2


