Return-Path: <linux-rdma+bounces-12149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B568B0473E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE697AB49B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968826AA8F;
	Mon, 14 Jul 2025 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbaO0EWn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7026C396;
	Mon, 14 Jul 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516611; cv=none; b=L+0rInQ1c4uSjqvAmY3TDEFVjVry3Qa5UPvPJyUPjDZs+on/Kn0qBwPHPajfyFZJo4EtZBQssGdRewBCxSFMipR1LA8Lvoy8CS6jTXwNNot24Cxv2Gn5iKEDV2e2UtOoTyoQKIfoAyVHJ5ZqjYbuxaeRiEdEzL6imuCtZa6MfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516611; c=relaxed/simple;
	bh=JxsxUXkiMCMjk9nm61G78vWYC5AgFudXYtFZ9qdhnBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kW2Z7GqJNKa6N+jxde5LwSXB7KuU+0+3W67vOVKj70JNCT/mk9ucU8IvGnagzRbWgCDnJ97QTT1Ro9Aa4DjHVHtcQMztPjsE2n5qF7vnB6aviSHLmYxBHnfZjRjvY53+FkOc4udJrjF3O7k3KZFgs3zLNly9mTi93ALE6XJCqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbaO0EWn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752516609; x=1784052609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JxsxUXkiMCMjk9nm61G78vWYC5AgFudXYtFZ9qdhnBM=;
  b=LbaO0EWnjazpAhFfLtM3VMr1ceR8n9XNjA6D+hvHI1QJWZaDpI3W3pEX
   B2YIydKvCbEqs4cCbNBUFjY+TKP7Aqy0j7Srnjf9P+Ch91bb4D6Z3JXw/
   9J/KKzCl0XIpDW/2PdLUclzccKWTcNRLsYdsxg+TvEC3EwTt0mcgYA3K2
   GWZOonARVNXfk0inghNSm5T0tSQJrjP28Fw0FefP/YckWekj3wJbHo5dV
   oRZZD6E6SCkY51OrCS1gTZmuxEyXipoQggWNBIa5JhMYG5AIcYsLWmuOT
   sbK68bWqbeNNYfTz37mQ0JAsZS9LTieqDgrRcwj0zU/o49dwZjflbc3WE
   A==;
X-CSE-ConnectionGUID: T1TfNDJxT1uumnr/VgT6Uw==
X-CSE-MsgGUID: BYVGvruiSRWJYOdknYyitw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54592332"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54592332"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:10:09 -0700
X-CSE-ConnectionGUID: QmT5aa8+QF6kuybdJSjZ7w==
X-CSE-MsgGUID: 6N4Ht3ydRkWM8IlevzuLKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="162553761"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jul 2025 11:10:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	tatyana.e.nikolova@intel.com,
	joshua.a.hay@intel.com
Subject: [PATCH net-next,rdma-next 0/6][pull request] Add RDMA support for Intel IPU E2000 in idpf
Date: Mon, 14 Jul 2025 11:09:55 -0700
Message-ID: <20250714181002.2865694-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is part two in adding RDMA support for idpf.
This shared pull request targets both net-next and rdma-next branches
and is based on tag v6.16-rc1.

IWL reviews:
v3: https://lore.kernel.org/all/20250708210554.1662-1-tatyana.e.nikolova@intel.com/
v2: https://lore.kernel.org/all/20250612220002.1120-1-tatyana.e.nikolova@intel.com/
v1 (split from previous series):
    https://lore.kernel.org/all/20250523170435.668-1-tatyana.e.nikolova@intel.com/

v3: https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
RFC v2: https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
RFC: https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/

----------------------------------------------------------------
Tatyana Nikolova says:

This idpf patch series is the second part of the staged submission for
introducing RDMA RoCEv2 support for the IPU E2000 line of products,
referred to as GEN3.

To support RDMA GEN3 devices, the idpf driver uses common definitions
of the IIDC interface and implements specific device functionality in
iidc_rdma_idpf.h.

The IPU model can host one or more logical network endpoints called
vPorts per PCI function that are flexibly associated with a physical
port or an internal communication port.

Other features as it pertains to GEN3 devices include:
* MMIO learning
* RDMA capability negotiation
* RDMA vectors discovery between idpf and control plane

These patches are split from the submission "Add RDMA support for Intel
IPU E2000 (GEN3)" [1]. The patches have been tested on a range of hosts
and platforms with a variety of general RDMA applications which include
standalone verbs (rping, perftest, etc.), storage and HPC applications.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

[1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/

----------------------------------------------------------------
The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/linux.git for-next

for you to fetch changes up to 6aa53e861c1a0c042690c9b7c5c153088ae61079:

  idpf: implement get LAN MMIO memory regions (2025-07-14 10:57:51 -0700)

----------------------------------------------------------------
Joshua Hay (6):
      idpf: use reserved RDMA vectors from control plane
      idpf: implement core RDMA auxiliary dev create, init, and destroy
      idpf: implement RDMA vport auxiliary dev create, init, and destroy
      idpf: implement remaining IDC RDMA core callbacks and handlers
      idpf: implement IDC vport aux driver MTU change handler
      idpf: implement get LAN MMIO memory regions

 drivers/net/ethernet/intel/idpf/Makefile        |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h          | 116 +++++-
 drivers/net/ethernet/intel/idpf/idpf_controlq.c |  14 +-
 drivers/net/ethernet/intel/idpf/idpf_controlq.h |  18 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c      |  49 ++-
 drivers/net/ethernet/intel/idpf/idpf_idc.c      | 503 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c      | 104 ++++-
 drivers/net/ethernet/intel/idpf/idpf_main.c     |  32 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h      |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h     |   1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c   |  45 ++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 191 ++++++++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h |   3 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h     |  41 +-
 include/linux/net/intel/iidc_rdma_idpf.h        |  55 +++
 15 files changed, 1107 insertions(+), 74 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
 create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h


