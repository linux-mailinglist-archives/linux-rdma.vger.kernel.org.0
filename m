Return-Path: <linux-rdma+bounces-10157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA6AAF9DC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21B94C6D2A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA822541C;
	Thu,  8 May 2025 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTMBHg7M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC714A4C7;
	Thu,  8 May 2025 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707246; cv=none; b=msWbITtU2s73NARQ+5/CfivSEs1uZDNO7ysBCR6SfqRoBjF+xBr50F52lxxRYL9fQhbzsfb83ebXn6yrceEw5oaaR5HKv46Nh4yOtLJDtxbtsac+/Wr0sDoaigCKRP6PAlBicBovISy5dzo/xIL6leZE0R8yb2iRE076lMSvKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707246; c=relaxed/simple;
	bh=6GjyiTfn5SI4PebBO0uNWjR6eASjOV4bUgJNv0Jed3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RYeJFwj7kk4ZzISeUakvDU1LiWzWoYbHPqZv/M2akaQsd+Eg3oxVE4hnsV8ng2IuqFHmFcBbKehuusVgwfmelVbRh+24svGQD3wD4+cAV2gt672rM892f5N3kKngceRTlI/msl1C49E5lWfsa3yPFy6Iow8iL55gklz3cPPsY84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTMBHg7M; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746707245; x=1778243245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6GjyiTfn5SI4PebBO0uNWjR6eASjOV4bUgJNv0Jed3A=;
  b=VTMBHg7M6pffPze0+emr06uAUjZG8/KntYsoEEF6FSlNyWoC4hywLHMR
   lWyO+pw1NxlETUeYzuqj+1OCZZa5QmJlXgsIXsJWlVq1dZVf9IEhK2oXO
   zNGLi5kSl+bf4R5RgH7To9WHHgtMzsk2CqWQdOezQIY3WapMpyVSYjaLF
   6jfK0y9b4B8NZgvI1gtpz3lYAJlb3GgyGBxOl2OmA/+81a54c2ALND6gP
   EXFr8tyT6o4Y1OcuxR2GKOUL+QoWyoxXsDVaz6VRzC56BjscHdPKVOyLT
   57SOrw/oH92JM8xJMetDGKVFG7YyMdaIYwppgWvT7wC4hpEtpe3LB6UUn
   w==;
X-CSE-ConnectionGUID: Nw0o8fcMQUePT2Gr5uknRg==
X-CSE-MsgGUID: q2nApTZASEWdUgoPlVOVUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="36115102"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="36115102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:27:25 -0700
X-CSE-ConnectionGUID: 65W7j38jRyO6Pv3w4+EBiA==
X-CSE-MsgGUID: fsyGWW4PQO+5/tmgOs6e+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136772854"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa010.fm.intel.com with ESMTP; 08 May 2025 05:27:19 -0700
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
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	jonathan.lemon@gmail.com,
	richardcochran@gmail.com,
	aleksandr.loktionov@intel.com,
	milena.olech@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v3 0/3]  dpll: add all inputs phase offset monitor
Date: Thu,  8 May 2025 14:21:25 +0200
Message-Id: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dpll device level feature: phase offset monitor.

Phase offset measurement is typically performed against the current active
source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
the capability to monitor phase offsets across all available inputs.
The attribute and current feature state shall be included in the response
message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
In such cases, users can also control the feature using the
``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
values for the attribute.

Implement feature support in ice driver for dpll-enabled devices.

Verify capability:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --dump device-get
[{'clock-id': 4658613174691613800,
  'id': 0,
  'lock-status': 'locked-ho-acq',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'type': 'eec'},
 {'clock-id': 4658613174691613800,
  'id': 1,
  'lock-status': 'locked-ho-acq',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'phase-offset-monitor': 'disable',
  'type': 'pps'}]

Enable the feature:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do device-set --json '{"id":1, "phase-offset-monitor":"enable"}'

Verify feature is enabled:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --dump device-get
[
 [...]
 {'capabilities': {'all-inputs-phase-offset-monitor'},
  'clock-id': 4658613174691613800,
  'id': 1,
 [...]
  'phase-offset-monitor': 'enable',
 [...]]

v3:
- removed patch 1/4:
  "dpll: use struct dpll_device_info for dpll registration"


Arkadiusz Kubalewski (3):
  dpll: add phase-offset-monitor feature to netlink spec
  dpll: add phase_offset_monitor_get/set callbacks
  ice: add phase offset monitor for all PPS dpll inputs

 Documentation/driver-api/dpll.rst             |  16 ++
 Documentation/netlink/specs/dpll.yaml         |  24 +++
 drivers/dpll/dpll_netlink.c                   |  76 ++++++-
 drivers/dpll/dpll_nl.c                        |   5 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  20 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  26 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 191 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +
 include/linux/dpll.h                          |   8 +
 include/uapi/linux/dpll.h                     |  12 ++
 12 files changed, 386 insertions(+), 5 deletions(-)


base-commit: 46431fd5224f7f3bab2823992ae1cf6f2700f1ce
-- 
2.38.1


