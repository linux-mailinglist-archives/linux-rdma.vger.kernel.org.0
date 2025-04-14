Return-Path: <linux-rdma+bounces-9422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC820A88B09
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0931899A7C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B028DEEC;
	Mon, 14 Apr 2025 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oKfDH9fl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61928BAB9;
	Mon, 14 Apr 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655331; cv=none; b=Pr4Uny87bYgd6DtIPQx0q31jb9dKB+r9ik9ofwrG7iKZj1v6N5Gi79G14CCuoBcKwQPZXi/79UMGDhikgBrVZsqpA+8B2E1NG0BdbppqWMW09BlXTA6HW5ekNKPGJRXFafg4cYFUiJphQelreieAMRCmK0vyIsEW5ejICZGBDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655331; c=relaxed/simple;
	bh=GUZrM/gdUGyjSCF2bN+e1qHecMw+fYf9BJ/6gwIUOpg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DYDCaqgwAP7cAewIOyrBxX/SLy9GrL6euK+g8BZ3Cbfu56EeHKadaLMOORIcF8zEzFjTSD+jESb8HQNAnM4eBUTp4gvf5B9KmSjdynZKY/ZRe8Qovd6MEHiLRFq0LeCQKZbxPpfSgGsq1KWxxKwJrWMAyhY67KqElKTuqgHGt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oKfDH9fl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 985E5205250D; Mon, 14 Apr 2025 11:28:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 985E5205250D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744655329;
	bh=B3MjI9fBqzthXDIdn806nAoFz5EQfFyuSOPJv1O45LE=;
	h=From:To:Cc:Subject:Date:From;
	b=oKfDH9flg3BZ2mufWwrCHvdBGboF0z2FW3psS58sBntYGXkw73MmkKr3sDo11vJ/A
	 Rf2EZK0MHtFJ17oaecF149YsU4IWuCob2sMJpfpJG0E8+oJPrnzJ6Ev+vs87oWIJnM
	 N2DRh982eYwydMsf3G1/IR0+3Logv9FV+vvoxc+k=
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
Subject: [PATCH rdma-next 0/4] RDMA/mana_ib: allow separate mana_ib for each mana client
Date: Mon, 14 Apr 2025 11:28:45 -0700
Message-Id: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
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

This patch series depend on the patch "RDMA/mana_ib: Add support of 4M, 1G, and 2G pages".

Konstantin Taranov (3):
  net: mana: Probe rdma device in mana driver
  RDMA/mana_ib: Add support of mana_ib for RNIC and ETH nic
  RDMA/mana_ib: unify mana_ib functions to support any gdma device

Shiraz Saleem (1):
  net: mana: Add support for auxiliary device servicing events

 drivers/infiniband/hw/mana/cq.c               |   4 +-
 drivers/infiniband/hw/mana/device.c           | 174 +++++++++---------
 drivers/infiniband/hw/mana/main.c             |  77 ++++++--
 drivers/infiniband/hw/mana/mana_ib.h          |   6 +
 drivers/infiniband/hw/mana/qp.c               |   5 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   |  27 ++-
 .../net/ethernet/microsoft/mana/hw_channel.c  |  19 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c |  99 +++++++++-
 include/net/mana/gdma.h                       |  18 ++
 include/net/mana/hw_channel.h                 |   9 +
 include/net/mana/mana.h                       |   3 +
 11 files changed, 320 insertions(+), 121 deletions(-)

-- 
2.43.0


