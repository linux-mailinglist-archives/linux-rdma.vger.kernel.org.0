Return-Path: <linux-rdma+bounces-11970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E48AFD857
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 22:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996F15438E6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 20:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA053241690;
	Tue,  8 Jul 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="duDFYba8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427A23DEAD
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006200; cv=none; b=LjZzT0Oyu8yHIbA+yUVQLMQY97dyjWSDr6WRp4zp4qbJD3FeHMw3FIh30UR4J6pIJ81YLaZJSpM6sjoxhHK11GkSR31x25bkr1+lFA6INgly+Z2RLQdHxQhI2UOnHelv0w3Hd+3QeCQ+wpGBJUw7oNhXJWcfUMH8SxunjqPNuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006200; c=relaxed/simple;
	bh=hulUcl972KGxGhJdRohJ/BSCu7HMY+uhVh8Mk6BIVLU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XISniqoY6BMBA0SdxKyd2mQpFP32zZhY5+bJ09HfHQNdVAYc534r5QzHei368kVS2yZZZi04Uh4T9dBtKj+FLmKT4+ziUqsLyq6k5zJzUeGkQji2srRJsitVkdgKcw67YD9vDeDuvUAfScserlYAH9WFCeysptRPWT/oUe18A+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=duDFYba8; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1752006199; x=1783542199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q4h+K6HwtByjRs1AntGTEzPiCSYWPjdfuvNtBLKjDOQ=;
  b=duDFYba8IfW66D+h4ybqJiZnaE0W3W6hoxuWt0zexzCVCUZ0IFw2Ymrh
   anj8yOOOnqObSXC6lT+41AiwhEL+mrW1Vy4U7F0MQujFHoc60LcHY8ex4
   mzqYdm7Doe4faXjLhexk5aiETfAbbgaEilFVeVzqHD4KZBBxcj32+cWKS
   yTexHvIUrvcoakoUJVwSxf9t9Jw6R9PpA5Tk3SGtbMWLYWGwzOJDP2vew
   1vhTKdu0wtVeop4Q9PXBUupeZq1B2otLRKk8iWm+cYx0a5DbH0MJ3nlLR
   MchhyiAJ2I6DlXu9gSosZZLwtIb4KCT5Gw6TE8X4GI41duwPeNAQiR08J
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,298,1744070400"; 
   d="scan'208";a="213413782"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:23:16 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:42026]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.121:2525] with esmtp (Farcaster)
 id 4008f039-b9db-4486-b87e-87c80906eee7; Tue, 8 Jul 2025 20:23:15 +0000 (UTC)
X-Farcaster-Flow-ID: 4008f039-b9db-4486-b87e-87c80906eee7
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Jul 2025 20:23:15 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Tue, 8 Jul 2025
 20:23:12 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next v2 0/3] RDMA: Support CQs with user memory
Date: Tue, 8 Jul 2025 20:23:05 +0000
Message-ID: <20250708202308.24783-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

This series is adding a common way for creating CQs on top of
preallocated memory supplied by userspace. The memory buffer can be
provided as a virtual address or by dmabuf, in both cases a umem object
is created for driver's use.
EFA is the first to support this new interface, new drivers or existing
drivers that want/need to get the memory from userspace are expected to
use this flow.

It's follow-up of the discussion in [1].

Changelog
=========
Changes from v1 [2]:
- Added a new "create_cq_umem" driver op instead of a flag set by
  supporting drivers
- Added ib_umem_is_contiguous() and ib_umem_start_dma_addr() helpers in
  a new patch
- Dropped references to umem scatter-gather list in EFA implementation
  and using the new helpers that hide the details instead

References
==========
[1] https://lore.kernel.org/all/c7d312ac-19a0-45e3-9f40-3e6f81500f83@amazon.com/
[2] https://lore.kernel.org/all/20250701231545.14282-1-mrgolin@amazon.com/

Thanks

Michael Margolin (3):
  RDMA/uverbs: Add a common way to create CQ with umem
  RDMA/core: Add umem "is_contiguous" and "start_dma_addr" helpers
  RDMA/efa: Add CQ with external memory support

 drivers/infiniband/core/device.c              |  1 +
 drivers/infiniband/core/uverbs_std_types_cq.c | 87 +++++++++++++++++--
 drivers/infiniband/hw/efa/efa.h               |  3 +
 drivers/infiniband/hw/efa/efa_main.c          |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 61 ++++++++++---
 include/rdma/ib_umem.h                        | 25 +++++-
 include/rdma/ib_verbs.h                       |  4 +
 include/uapi/rdma/efa-abi.h                   |  3 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  4 +
 9 files changed, 164 insertions(+), 25 deletions(-)

-- 
2.47.1


