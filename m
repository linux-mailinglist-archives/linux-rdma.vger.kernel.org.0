Return-Path: <linux-rdma+bounces-11975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B78CAFD934
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952A91BC4E11
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE30245008;
	Tue,  8 Jul 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8NXFs21"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919E242D62;
	Tue,  8 Jul 2025 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008815; cv=none; b=q8hSnOGTOWFsnSOB8LWeoZ2VQKoYuBqVrRViVqa2Xwk8Z5wP/YPw7XpXhw2+Zyow3jYEQYiXYzKFSjb3OmkNPzjTMJwXrxQFwaMT4ejhvHNkyXDUppN9TxMCcU12CwvD7zKI/SKan8zQ/Z50ujin/bEDU35YwadAXNwFA5VqJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008815; c=relaxed/simple;
	bh=AVwBQylNK2PncxFUdAgKzpOfnswfruxyvv7gs/YAeDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=In5M+v0iDDOOJ/sJBH034Jfd9uJmxFktFrHg6wGZi6GA/8jyY1hjrgdJLPS9rMyYtpDXuhuHLyesacTxXQvyFQr4/YND0UZ5oE0GtCQ6jmTiwtsTPvQ9We4rIFXccgmKo47Qz2U7/dOVhDphRQa6ZBPRDjyr/jhGd01UpoHcgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8NXFs21; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752008814; x=1783544814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AVwBQylNK2PncxFUdAgKzpOfnswfruxyvv7gs/YAeDw=;
  b=C8NXFs21i/reKl6V3TpNnXa5zDzTYXJ5lFRwBkbjsJ9ogDIUZUxX8EUl
   fiZ4Y41bFfWUIHOYxFWwEUx2qyfq3KCWMsTfNKiIHeFSoZv/EcYzMjeKT
   WHyBcqHm0hGX5TVhoC1xsVq5eHRTsspBXu51GNxDAyCl52SuFvge/75vU
   hGhgvXIjviV2VlEiwO01yX7hvwFKldPN2MTwh1o22wp835O5LYDq3Y9Fd
   NT+KsMJdkB50H0tRLYBHNZLG8uFOaCoXUT4djxSOwPgjftVc7NXveh2tM
   mjgLoTwoij0apLDu7w2Wos7eyNtV6f8IdNMVVzCbon7Ha3e3F2hL8Cip4
   w==;
X-CSE-ConnectionGUID: 3UCU4Jp2QzaYPclD00jT4A==
X-CSE-MsgGUID: H5yE+XmnStOH5g/7mDTfXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54391705"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54391705"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:06:53 -0700
X-CSE-ConnectionGUID: I0N5iFn5RCK6VEwOZgZskg==
X-CSE-MsgGUID: T8vPMygtSNKhpCW2su6wtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="179276523"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:06:52 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jgg@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next v3 0/6] Add RDMA support for Intel IPU E2000 in idpf
Date: Tue,  8 Jul 2025 16:05:48 -0500
Message-ID: <20250708210554.1662-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This idpf patch series is the second part of the staged submission for
introducing RDMA RoCEv2 support for the IPU E2000 line of products,
referred to as GEN3.

To support RDMA GEN3 devices, the idpf driver uses common definitions of
the IIDC interface and implements specific device functionality in
iidc_rdma_idpf.h.

The IPU model can host one or more logical network endpoints called vPorts
per PCI function that are flexibly associated with a physical port or an
internal communication port.

Other features as it pertains to GEN3 devices include:
* MMIO learning
* RDMA capability negotiation
* RDMA vectors discovery between idpf and control plane

These patches are split from the submission "Add RDMA support for Intel
IPU E2000 (GEN3)" [1] and are based on 6.16-rc1. The patches have been
tested on a range of hosts and platforms with a variety of general RDMA
applications which include standalone verbs (rping, perftest, etc.),
storage and HPC applications.

A shared pull request for net-next and rdma-next will be sent following review.

Changelog:

v3:
* Include export.h header file
* Use managed version of pci_request_region API

v2 at [5]:
* Minor improvements like variable rename, logging,
remove a redundant variable, etc.
* A couple of cdev_info fixes to properly free it in
error path and not to dereference it before NULL check.

Changes since split (v1) at [4]:
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
[4] https://lore.kernel.org/all/20250523170435.668-1-tatyana.e.nikolova@intel.com/ 
[5] https://lore.kernel.org/all/20250612220002.1120-1-tatyana.e.nikolova@intel.com/


Joshua Hay (6):
  idpf: use reserved RDMA vectors from control plane
  idpf: implement core RDMA auxiliary dev create, init, and destroy
  idpf: implement RDMA vport auxiliary dev create, init, and destroy
  idpf: implement remaining IDC RDMA core callbacks and handlers
  idpf: implement IDC vport aux driver MTU change handler
  idpf: implement get LAN MMIO memory regions

 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        | 117 +++-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  14 +-
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  19 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  49 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    | 499 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 102 +++-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  32 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  45 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 191 ++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  42 +-
 include/linux/net/intel/iidc_rdma_idpf.h      |  55 ++
 15 files changed, 1105 insertions(+), 73 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
 create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h

-- 
2.37.3


