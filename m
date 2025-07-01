Return-Path: <linux-rdma+bounces-11810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F8AF06D4
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 01:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED811BC1A88
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 23:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141426AA82;
	Tue,  1 Jul 2025 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tz5+fHR/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5C27055F
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411758; cv=none; b=lJiL/K1q6CSO+i2epnOBiwAHgTibwKFk4+oVgMtsi7f375j2lhmZPgu4ybS319pUqDHq9fpiq1l99Pgc00KNkFHZjPg0hzM1VoS34tGFiQAKyP3kuVA/JqNUL7Svw3UJUG4YqFGH40PruGngU9j/DvLjXbqW225du/rCG13O+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411758; c=relaxed/simple;
	bh=bl0k2hx9cy1AOUkHCyB7/zRQnMPhx8VbbxnjRbcAuiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J04n/Kcfw5ixHN6TVHDtXla8Lz4mtgvup3HI4eJZqLZ1ABwG4Ua+QYH6cR113h+uqXA0/xRduswpEOFbX7lNKf+ES3P2sbuVCZUmfZ4Xh19lehD3CGvmd/2ZrI9yQAaMrrFpwuxiC6qQ/7m1js4R5SDdL6+lxi6+9FMR2Qz45L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tz5+fHR/; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751411758; x=1782947758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/G/OseHhp6HIByzSa9OsqNphHS+ta+mYGREdbP6qn1Y=;
  b=tz5+fHR/O1TS9she0bcx/zVVPb2YqHhpyXFCVMWEnGfWCL+iwXr3Xakp
   rWTyGmRidcNVdNrxTM5p25cY8ruKEPf7+VRrVtUxxs7IZwLuAHDwV5Is2
   kFKpdoNMmA1oQVSjrZ0oJbTHEqt8IXw+tLsgsLts7S+xhBkpFihYQRhL4
   v6z61BzobVw4dmbJ/BZ0fClNHD7rWkf/xEkNV0P/CKedQRebDszGDLvRg
   GJPIBoTZOYyqTMKIYli/FdFpQsYhfUYtmibyFL5zfqIrPkjZW8sIr/g4D
   SGjcAx/dkFUd3mPTSHjDWMf5QTMaUfrS1kBgD/S9ek8GZmP8+A0l0pNkE
   w==;
X-IronPort-AV: E=Sophos;i="6.16,280,1744070400"; 
   d="scan'208";a="514791109"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 23:15:53 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:57332]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.47.53:2525] with esmtp (Farcaster)
 id 4cdb41e1-61c8-46a8-89d6-5fc04987d4f1; Tue, 1 Jul 2025 23:15:51 +0000 (UTC)
X-Farcaster-Flow-ID: 4cdb41e1-61c8-46a8-89d6-5fc04987d4f1
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Jul 2025 23:15:51 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Tue, 1 Jul 2025
 23:15:49 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next 0/2] RDMA: Support CQs with user memory
Date: Tue, 1 Jul 2025 23:15:43 +0000
Message-ID: <20250701231545.14282-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

This series is adding a common way for creating CQs on top of
preallocated memory supplied by userspace. The memory buffer can be
provided as a virtual address or by dmabuf, in both cases a umem object
is created for driver's use.
EFA is the first to support this new interface, new drivers or existing
drivers that want/need to get the memory from userspace are expected to
use this flow.

It's follow-up of this discussion:
https://lore.kernel.org/all/c7d312ac-19a0-45e3-9f40-3e6f81500f83@amazon.com/

Thanks

Michael Margolin (2):
  RDMA/uverbs: Add a common way to create CQ with umem
  RDMA/efa: Add CQ with external memory support

 drivers/infiniband/core/device.c              |  3 +
 drivers/infiniband/core/uverbs_std_types_cq.c | 82 ++++++++++++++++++-
 drivers/infiniband/hw/efa/efa_main.c          |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 47 ++++++++---
 include/rdma/ib_verbs.h                       |  6 ++
 include/uapi/rdma/efa-abi.h                   |  3 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  4 +
 7 files changed, 129 insertions(+), 17 deletions(-)

-- 
2.47.1


