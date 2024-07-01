Return-Path: <linux-rdma+bounces-3591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8791E00D
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA68D1C223A8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FDB15AAC2;
	Mon,  1 Jul 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hRVUXR67"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4CF1494C4;
	Mon,  1 Jul 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838812; cv=none; b=js4HINOig4Z/fwPTi1Jnjq7Fzu+frnhHpqCPML3UeZUL70OOcOA4nJGqSdUKW7W4enCk4+ZedCyYZQWzSPGX7Z/IMQJiHCYBBeAiiQx134ydiVgTKgnpSjJrWfJw+I6S/jM3nt2gzwhUNXPsqbATuVBwC9kJZG5R6KW/HX7VLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838812; c=relaxed/simple;
	bh=ITGX7Stlw8dzd9bmuhRa3MyV3QI/GXD46NJenfRsj6s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TOikn6BRX7YE4BNIxo8spcfyZO8p08IDg8J9mdFTNwQQsjcqCbN4dwWiP4IAwxHJzlmAHrC40I00Jnl56pm4pLP3wVvwCeX2Lq3GuKIB4ij8nlzf6Vvyvpmc2mn679fSs6xkuBqVWNTjflNdbApXPELV0RJ5kPYOBGeIdDL6oL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hRVUXR67; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1EFCA20B7001;
	Mon,  1 Jul 2024 06:00:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EFCA20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1719838805;
	bh=FHqAa907jkzY7G6B8Oe34LyCXVloQKb7sP0mxWAiaJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=hRVUXR67abHQ0+QLXCCCNtj6WuxQRr1HpAKrF8RjN8+YJg6i7ZZ6L1lKCzxIu9Jou
	 sMAQpgvSqdXJooIJg6BGo9o1jrm9Cxv4jn8t1PsiipasiDN7gwa4aWy5HBK5Llj3gR
	 69MNb7nqTDhhfoc6lUbt323Y8EuF+8/Jnvz5IOXs=
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
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/2] Provide master netdev to mana_ib
Date: Mon,  1 Jul 2024 05:58:54 -0700
Message-Id: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series aims to allow mana_ib to get master netdev
from mana. In the netvsc deployment, the VF netdev is enslaved
by netvsc and the upper device should be considered for the network
state. In the baremetal case, the VF netdev is a master device.

I would appreciate if I could get Acks on it from:
* netvsc maintainers (e.g., Haiyang)
* net maintainers (e.g., Jakub, David, Eric, Paolo)

v1 -> v2:
Leon Romanovsky asked to make a helper in the net/mana and get
acks from net maintainers.

Konstantin Taranov (2):
  net: mana: introduce helper to get a master netdev
  RDMA/mana_ib: Set correct device into ib

 drivers/infiniband/hw/mana/device.c           | 16 ++++++++--------
 drivers/net/ethernet/microsoft/mana/mana_en.c | 18 ++++++++++++++++++
 include/net/mana/mana.h                       |  2 ++
 3 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.43.0


