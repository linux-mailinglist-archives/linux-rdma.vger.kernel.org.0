Return-Path: <linux-rdma+bounces-9452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B63A8A61C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 19:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E663B7874
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EEC221F03;
	Tue, 15 Apr 2025 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzYIbW/Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730C20DF4;
	Tue, 15 Apr 2025 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739834; cv=none; b=FOZNeMTAnAeXuPMbizXC80vd5DBgWwH6vhkuXc8eIsAo3zBtGCVBitxlv8LZ+a4OIIZMPjfPwNeU96phrYxgRztGybkDQjH/E9eDQR0lVDOUQkvkjKR2PHxD733zKNIrkLdoyIF7uM0s5/JWtUELN3vTav90Sm4kQ9ovcPT0JJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739834; c=relaxed/simple;
	bh=LkjYzFPBTOFgIp6/N6gKViQpronUbr8w7O5lyHYgdS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zfh3X3JsaQIRX0mPjqJ4ZoiXg/+P6tEky04h5tl6HFc9GQJeqIXtY2dH6oswE2/xxvmAdfcwaCUR/icxPsJZjxnFXYNnpwFVvRScLW79dpUZS6dgnBpip/ov7yzR5NraKpmIksYJcTzotbSXpPjGBd9IICVZsMrqyuxtAZHY6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzYIbW/Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744739833; x=1776275833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LkjYzFPBTOFgIp6/N6gKViQpronUbr8w7O5lyHYgdS0=;
  b=PzYIbW/Qzwy0p5uCJI7+eNrTlaTrPeiU1nKh30je6xk9xPp2kDSBiNaW
   IwUOkmQfkdcgqpIbzs/rgARys9HYUZlnsX33ytFNbItKf7pPCl9wBPbwp
   Dm960NAylhEbYTKoMk9eA22OxeCqqkl8K78C0VEWG6un5c7gs8BOjNmDe
   XK8v2KZQurV0Du8WAi0bxE00xAIttsAsieLsz7gONC82wGRM9of51hqp4
   NKJGwtcgclAlqI2pKt/V3cJXVfffyMTMpNnV5ntfZlorwBcpsnTMDF3FU
   TOa7sgzb1oSLpBmiPtLKaOFAohztZySRQVUpNm3EdPnfLZnoNnBahWDge
   g==;
X-CSE-ConnectionGUID: bbfln7MdT0aOmmSg/WzYRg==
X-CSE-MsgGUID: E0vXpaxnQuCOAzgZ6MMYBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57650407"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="57650407"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:57:12 -0700
X-CSE-ConnectionGUID: lAuP0HNSSGmgEJmHMoj02A==
X-CSE-MsgGUID: 5bEefThrTfWE8815NKIprA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="167364086"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa001.jf.intel.com with ESMTP; 15 Apr 2025 10:57:08 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v1 0/3] dpll: add ref-sync pins feature
Date: Tue, 15 Apr 2025 19:51:12 +0200
Message-Id: <20250415175115.1066641-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to bind two pins and become a single source of clock signal, where
first of the pins is carring the base frequency and second provides SYNC
pulses.

Verify pins bind state/capabilities:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do pin-get \
 --json '{"id":0}'
{'board-label': 'CVL-SDP22',
 'id': 0,
 [...]
 'reference-sync': [{'id': 1, 'state': 'disconnected'}],
 [...]}

Bind the pins by setting connected state between them:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do pin-set \
 --json '{"id":0, "reference-sync":{"id":1, "state":"connected"}}'

Verify pins bind state:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do pin-get \
 --json '{"id":0}'
{'board-label': 'CVL-SDP22',
 'id': 0,
 [...]
 'reference-sync': [{'id': 1, 'state': 'connected'}],
 [...]}

Unbind the pins by setting disconnected state between them:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do pin-set \
 --json '{"id":0, "reference-sync":{"id":1, "state":"disconnected"}}'


Arkadiusz Kubalewski (3):
  dpll: add reference-sync netlink attribute
  dpll: add reference sync get/set
  ice: add ref-sync dpll pins

 Documentation/netlink/specs/dpll.yaml         |  19 ++
 drivers/dpll/dpll_core.c                      |  27 +++
 drivers/dpll/dpll_core.h                      |   1 +
 drivers/dpll/dpll_netlink.c                   | 188 ++++++++++++++++--
 drivers/dpll/dpll_nl.c                        |  10 +-
 drivers/dpll/dpll_nl.h                        |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 186 +++++++++++++++++
 include/linux/dpll.h                          |  10 +
 include/uapi/linux/dpll.h                     |   1 +
 10 files changed, 425 insertions(+), 20 deletions(-)


base-commit: 420aabef3ab5fa743afb4d3d391f03ef0e777ca8
-- 
2.38.1


