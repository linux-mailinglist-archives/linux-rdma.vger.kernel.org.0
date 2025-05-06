Return-Path: <linux-rdma+bounces-10103-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D537AACD7A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D2E1BA6BE2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C9928689B;
	Tue,  6 May 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ozhomk+e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269B4286404;
	Tue,  6 May 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557543; cv=none; b=PqWXPFqEhjc74eU3bmA7HDA8OlmFOZxgxya9TsmYxtEOw/1lkYYBq1CEv77zEnfR/YenmnrOsokMdLDk3IGBjA3DiyqgHqAgEkXePR+45lbbUslXI+bBrwhXCOIlD6ik2mAaedZYCREth39WHFbigJsSpSIwvNLdhbCpQGIP4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557543; c=relaxed/simple;
	bh=KUJduQ2vsQa+Ov9/yQbSLfr8nj0gtSfAeQ/mF+RRIoM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=An+5BJRkOnB+/yCSjL9kJYyn+T29JlgUwN9blV7zp/+AxEhTWNTC3gQzXo4SAtPbcwKbgywSHmx+TOHZ7tiMkfjqgOxbGBwV+lm5R8l2Ro1kk5u84fTG7+D2KuQtlXK11KuwyAnXQKxbZpq/C8ARrrKZ4b82rgM4umzhRGxJ2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ozhomk+e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id A86BF2115DD2; Tue,  6 May 2025 11:52:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A86BF2115DD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746557541;
	bh=FINroussaWJ1aXWM/XZWn0Q04kq+1Sr8fSUhtF3rb+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Ozhomk+eYTCo8EI3gutYKclkIKb9ydNsuBAjAGTzuzqXUQ9h8GlLR/bX26uMDBos8
	 DZlUUf97wYZIc2tqri1HHy0Yg45tdr9CnVVNc4cIadLnj1xuR/jM4JmqYE1E0zSHq4
	 rIacrj0jHQ2Q4yuuxjeDkn37JzJj1dBEJt+D0/d4=
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
Subject: [PATCH rdma-next v3 0/4] RDMA/mana_ib: allow separate mana_ib for each mana client
Date: Tue,  6 May 2025 11:52:17 -0700
Message-Id: <1746557541-3617-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

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

Konstantin Taranov (3):
  net: mana: Probe rdma device in mana driver
  RDMA/mana_ib: Add support of mana_ib for RNIC and ETH nic
  RDMA/mana_ib: unify mana_ib functions to support any gdma device

Shiraz Saleem (1):
  net: mana: Add support for auxiliary device servicing events

 drivers/infiniband/hw/mana/cq.c                  |   4 +-
 drivers/infiniband/hw/mana/device.c              | 174 +++++++++++------------
 drivers/infiniband/hw/mana/main.c                |  82 ++++++++---
 drivers/infiniband/hw/mana/mana_ib.h             |   6 +
 drivers/infiniband/hw/mana/qp.c                  |   5 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c  |  27 +++-
 drivers/net/ethernet/microsoft/mana/hw_channel.c |  19 +++
 drivers/net/ethernet/microsoft/mana/mana_en.c    | 108 +++++++++++++-
 include/net/mana/gdma.h                          |  19 +++
 include/net/mana/hw_channel.h                    |   9 ++
 include/net/mana/mana.h                          |   3 +
 11 files changed, 333 insertions(+), 123 deletions(-)

-- 
1.8.3.1


