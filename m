Return-Path: <linux-rdma+bounces-573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D70828442
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 11:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD6A1C23D87
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EFD364DF;
	Tue,  9 Jan 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f1qZ6EaM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6312364CC;
	Tue,  9 Jan 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 20A3920AEC89; Tue,  9 Jan 2024 02:51:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20A3920AEC89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704797487;
	bh=r6Ddqc6DwsgTW4CdwH0T4dXEMiELjME4L4edzD42zIc=;
	h=From:To:Cc:Subject:Date:From;
	b=f1qZ6EaMyi32bimT4ayV09Mljr1bCjD+bGf0LkKQU9arxlLq6c4GAh+8Yg+k8A4eL
	 MYxuTkscI5wY05igr0OdIpaRF2zCEmaQhWk5gayhP0KPl+BolJ5ATfT44SjSolH7ip
	 Ixt1ZF3VzSSK9FlYTI4wt5nZkdNcMFZLFj+OwI/E=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH 0/4 net-next] net: mana: Assigning IRQ affinity on HT cores
Date: Tue,  9 Jan 2024 02:51:14 -0800
Message-Id: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

This patch set introduces a new helper function irq_setup(),
to optimize IRQ distribution for MANA network devices.
The patch set makes the driver working 15% faster than
with cpumask_local_spread().

Souradeep Chakrabarti (1):
  net: mana: Assigning IRQ affinity on HT cores

Yury Norov (3):
  cpumask: add cpumask_weight_andnot()
  cpumask: define cleanup function for cpumasks
  net: mana: add a function to spread IRQs per CPUs

 .../net/ethernet/microsoft/mana/gdma_main.c   | 87 ++++++++++++++++---
 include/linux/bitmap.h                        | 12 +++
 include/linux/cpumask.h                       | 16 ++++
 lib/bitmap.c                                  |  7 ++
 4 files changed, 112 insertions(+), 10 deletions(-)

-- 
2.34.1


