Return-Path: <linux-rdma+bounces-9791-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA23EA9CA5A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF644C293A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8C255E33;
	Fri, 25 Apr 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y9j75Nv5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A85253939;
	Fri, 25 Apr 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587779; cv=none; b=EJW0VAWRz0KhBoIuHA83yrYsYV7LMZKu6ERE4Bk/10OzUGgK6CojyBCM5cCc7NUZBL7IsZDEuni+y8YcTby5Ck2WTeaGpjmAKySIGsc0f4weoljnW04gc85flZlFS5Xjf0lWrXAVe3sHKEt3LwIjc8LeGUjE3e0z4x8RoPNSR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587779; c=relaxed/simple;
	bh=2m+TXCLzGmVwV/D8lFdkppJgu5O7zNl3hHFf3Jz5L0A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Fvu3D93sj9ZaEeOshEcOQf1v8F9vBC/SU6zkRRNeKcoKB8qjsGxbgRcemphJTsSHwf1Ns/rmYAAziSqi8bjvHheBp5uT0bq5HAYuIkibSTDDFuYMEwWi7qhbso1JjGCFnO501AlcdBByp0kTgB8k0Vggxg+IPwKRvCKAsMwbfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y9j75Nv5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 91EA820BCAD1; Fri, 25 Apr 2025 06:29:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91EA820BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745587777;
	bh=NsDvqhQJb+De3iM0WfHS/+yYk4aovZXsfudU+S60050=;
	h=From:To:Cc:Subject:Date:From;
	b=Y9j75Nv5iXn2ZqeBqHM69XvpMn9Dr+efvJZi7EJZy6iZYwm6/vIJmDEBWfCz3X0Jl
	 vRj0aXIkYsPuZglk4ibqahEZsttOeAQxkPz088aeGwGtOyULgj5hrzh9d3EZjgRyax
	 HXZE5VUn1CX5BxtXv0dgDqfDVr5faBpIItGcg9tU=
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
Subject: [PATCH rdma-next v2 0/4] RDMA/mana_ib: allow separate mana_ib for each mana client
Date: Fri, 25 Apr 2025 06:29:33 -0700
Message-Id: <1745587777-15716-1-git-send-email-kotaranov@linux.microsoft.com>
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

Konstantin Taranov (3):
  net: mana: Probe rdma device in mana driver
  RDMA/mana_ib: Add support of mana_ib for RNIC and ETH nic
  RDMA/mana_ib: unify mana_ib functions to support any gdma device

Shiraz Saleem (1):
  net: mana: Add support for auxiliary device servicing events

 drivers/infiniband/hw/mana/cq.c                  |   4 +-
 drivers/infiniband/hw/mana/device.c              | 174 +++++++++++------------
 drivers/infiniband/hw/mana/main.c                |  77 +++++++---
 drivers/infiniband/hw/mana/mana_ib.h             |   6 +
 drivers/infiniband/hw/mana/qp.c                  |   5 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c  |  27 +++-
 drivers/net/ethernet/microsoft/mana/hw_channel.c |  19 +++
 drivers/net/ethernet/microsoft/mana/mana_en.c    | 108 +++++++++++++-
 include/net/mana/gdma.h                          |  19 +++
 include/net/mana/hw_channel.h                    |   9 ++
 include/net/mana/mana.h                          |   3 +
 11 files changed, 330 insertions(+), 121 deletions(-)

-- 
1.8.3.1


