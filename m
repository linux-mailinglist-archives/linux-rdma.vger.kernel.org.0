Return-Path: <linux-rdma+bounces-10631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C304AC2815
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 19:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A6C7AFE1A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD2297134;
	Fri, 23 May 2025 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qwz9grti"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF4296FA6;
	Fri, 23 May 2025 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019962; cv=none; b=KdDlgx+7UWnDpMRWyNbEoP5h8hxnCGdPiXK4eNcxgfQ5swRqUq9aJf8dhb+qXhm592o/TmX4G8zRYR+pzxMBjLpLaMne269PspQM+jEIRMOxj2hkXntjqogtD3EarRg+Tf3fivYULYdhJCfYNX/iV5ig/xzuF7bSxWxyCW1eg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019962; c=relaxed/simple;
	bh=GwH5EQqeA1kYy7kbiPpZ6eaEDgz5rff8/jLIjUHdyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThAvUE4MBColp8yZXiSqQNzr8uGORSPoI8XTf8YC4WRKmB8f+jftPYb2Rw4pXxS72IfRqtQMhHOZ4WvW1BjfDXb32o+azHDHcAeDXle3Hg+99KdujyNUU7AV4Zd5m181YbE+oXffZO2sm/6YIdNGdGQJtICM5GN3+wjnBK+AIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qwz9grti; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748019961; x=1779555961;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GwH5EQqeA1kYy7kbiPpZ6eaEDgz5rff8/jLIjUHdyVc=;
  b=Qwz9grtiaZU3n0BZY7ez9ZMq6uQ5REgJI7YF/mZHbWKLTqeA0jWYyMOD
   8MVFz0DNEdG3lMfSOYn0qhyJICY7xqphvh5LyKJgHXQjeAg2YAGN+cbp5
   HgIuqdDzFYFLKVuje9tP+XnKnAPsjhiROre+QLz6G/xAxbK9xBDUf2yGH
   EEm5BoLi4cg5oqpTqMQZol9XDxaSV/r2toWYWiB/t7JI9LiGsmpdZmR/F
   21yLmsyr/J5W9+/d5IcVi3fh5AErmjb6EfduXR+lDL0SD4S1m/WL6grfl
   XP+r8RRCShUapWSXyJAPHE4UoKJtEq45yGh6ehuICzhN7L2kZAz57LNow
   Q==;
X-CSE-ConnectionGUID: FIwnVxORSxWHDg3/owqnFw==
X-CSE-MsgGUID: yGh8g6FdSCKKoYdlXz+bfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60738374"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="60738374"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:06:00 -0700
X-CSE-ConnectionGUID: QJUtUc19R5WI37SD/xrM1A==
X-CSE-MsgGUID: 0eFFd0u0RQ6eytnK7PAJXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="164457417"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:05:59 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jgg@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	anthony.l.nguyen@intel.com,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next 0/6] Add RDMA support for Intel IPU E2000 in idpf
Date: Fri, 23 May 2025 12:04:29 -0500
Message-ID: <20250523170435.668-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This idpf patch series is the second part of the staged submission
for introducing RDMA RoCEv2 support for the IPU E2000 line of products,
referred to as GEN3.

To support RDMA GEN3 devices, the idpf driver uses
common definitions of the IIDC interface and implements
specific device functionality in iidc_rdma_idpf.h.

The IPU model can host one or more logical network endpoints called
vPorts per PCI function that are flexibly associated with a physical
port or an internal communication port.

Other features as it pertains to GEN3 devices include:
* MMIO learning
* RDMA capability negotiation
* RDMA vectors discovery between idpf and control plane

These patches are split from the submission
"Add RDMA support for Intel IPU E2000 (GEN3)" [1]
and are based on 6.15-rc1 + "Prepare for Intel IPU E2000 (GEN3)" [4]. 
A shared pull request will be sent following review.

Changelog:

Changes since split:
* Replace core dev_ops with exported symbols
* Align with new header split scheme (iidc_rdma.h common header
and iidc_rdma_idpf.h specific header)
* Align with new naming scheme (idc_rdma -> iidc_rdma)
* The idpf patches are submitted separately from the ice and
irdma changes.

At [3]:
* Reduce required minimum RDMA vectors to 2

At [2]:
* RDMA vector number adjustment
* Fix unplugging vport auxiliary device twice
* General cleanup and minor improvements

[1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
[2] https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
[3] https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
[4] https://lore.kernel.org/all/20250509200712.2911060-1-anthony.l.nguyen@intel.com/

Joshua Hay (6):
  idpf: use reserved RDMA vectors from control plane
  idpf: implement core RDMA auxiliary dev create, init, and destroy
  idpf: implement RDMA vport auxiliary dev create, init, and destroy
  idpf: implement remaining IDC RDMA core callbacks and handlers
  idpf: implement IDC vport aux driver MTU change handler
  idpf: implement get LAN MMIO memory regions

 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        | 117 ++++-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  14 +-
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  19 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  49 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 496 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  93 +++-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  32 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  45 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 190 ++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  52 +-
 include/linux/net/intel/iidc_rdma_idpf.h      |  55 ++
 15 files changed, 1104 insertions(+), 71 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
 create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h

-- 
2.37.3


