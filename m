Return-Path: <linux-rdma+bounces-10121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6598CAAE5C4
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F0718890F7
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A328B7EF;
	Wed,  7 May 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J832e/1f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C028B509;
	Wed,  7 May 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633547; cv=none; b=F9dvwykX0uZNqTEYVtrlU++iCh5c1wWVdc704bYnC33JaIrGRd5IQ44cu55Tn6CuXse41L1pcoDBYf5xfORBvv6VU75+Txs80oVgjMY5gBpfl39iSj0v9lKjQfT1TRCW/BIoBLHA9kX+2R1cC3rI77UmUgctGBrJb9eU8rmeBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633547; c=relaxed/simple;
	bh=9LXhD+2vhDKKSLAhFNemE77DPRi7sVuaJaYgABOlYAs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fs6dZgVJH7kuz8vwmC9ySBOMyDxgH+BI16UkljV6iYmjjJHQKpHa5Hn0LLHNNwZCiAYf4R7pNWTxMCrWGr09nE6KrAYdUM2zdxmOlcyGQIWBlr580YZbcNkp/Q7bHVBxY5Gs9FZP75+Yg5iOZRPB6BePPtL7W296WRHcC84N+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J832e/1f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 2DD2021180CC; Wed,  7 May 2025 08:59:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DD2021180CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746633545;
	bh=5KXFCZ2x1knV4BT2iU8q8mIItJczMnow9Q3vIolibAA=;
	h=From:To:Cc:Subject:Date:From;
	b=J832e/1fvgil29e7QbjZ60on5dGSIshvD41gAR7aGulLtl92WNM52wF48rDzxermp
	 vpArDoyzCnOILEGfNRr3nVFHIExmVL9QkmzebB00M5sRxb92oymG9nPfOB0Pd0ZBd/
	 iQT4xlVkbX0zd/vggA9HjN8U31MO5zzo9UP2pXEM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next v4 0/4] RDMA/mana_ib: allow separate mana_ib for each mana client
Date: Wed,  7 May 2025 08:59:01 -0700
Message-Id: <1746633545-17653-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Microsoft mana adapter has 2 devices in the HW: mana ethernet device and RNIC device.
Both devices can implement RDMA drivers and, so far, they have been sharing
one ib device context. However, they are different devices with different
capabilities in the HW and have different lifetime model.

This series allows us to model the aforementioned two devices as separate ib devices.
The mana_ib will continue supporting two devices but as individual ib devices.
It enables the driver to dynamically destroy and create the auxiliary device over
RNIC, when the HW reboots the RNIC module. Without this separation, the reboot
would cause destruction of the ib device serving DPDK clients from the uninterrupted
ethernet HW module.

v2:
- renamed aux device from mana.dpdk to mana.eth (patch 1 and 2)
- Fixed a possible race between servicing and pci threads (patch 4)

v3:
- Added vendorid and partid in mana_ib_query_device (patch 2)

v4:
- rabased on latest rdma-next

Konstantin Taranov (3):
  net: mana: Probe rdma device in mana driver
  RDMA/mana_ib: Add support of mana_ib for RNIC and ETH nic
  RDMA/mana_ib: unify mana_ib functions to support any gdma device

Shiraz Saleem (1):
  net: mana: Add support for auxiliary device servicing events

 drivers/infiniband/hw/mana/cq.c               |   4 +-
 drivers/infiniband/hw/mana/device.c           | 174 +++++++++---------
 drivers/infiniband/hw/mana/main.c             |  82 +++++++--
 drivers/infiniband/hw/mana/mana_ib.h          |   6 +
 drivers/infiniband/hw/mana/qp.c               |   5 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   |  26 ++-
 .../net/ethernet/microsoft/mana/hw_channel.c  |  20 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 108 ++++++++++-
 include/net/mana/gdma.h                       |  19 ++
 include/net/mana/hw_channel.h                 |   9 +
 include/net/mana/mana.h                       |   3 +
 11 files changed, 333 insertions(+), 123 deletions(-)

-- 
2.43.0


