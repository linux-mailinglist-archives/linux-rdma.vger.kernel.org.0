Return-Path: <linux-rdma+bounces-10643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589BAC28C8
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 19:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B98E4E76E5
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088C298CA4;
	Fri, 23 May 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3MIHNu+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDF29899F;
	Fri, 23 May 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021674; cv=none; b=eL04Jmw+th0Y0dciGRKbfbxmvi9F7xhDlE1MbVIN4ko+asqKN955eSmvgHcg5+o7nnDLrBOc/XrgOUp1os6I2M+qS90ucUIKiGonGxRWEKdA7Dy4UuIW/wsw311hZKEACgmVOeP74pOknohswbnEBfJ5uj1zeQR4gG++TT6c7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021674; c=relaxed/simple;
	bh=gYYx1l/Pn+n5FEnkn32ZPkxnX8faGzxv7Jv7CihnuCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ng3T06bOtpgmcTI38DyAPhB11Qbg4pbsluYFLfK3AD/VBHEUIRww5cP6T/KW+H83vw8hsNJqEZjsQE8NfccPBwPGLnnL6r6f95EC8YdzjA2ECTneCkRTyVlxj/4nx7Nros9CTptkptoM02JQ+lBHvAx1jJsY8sDtGzFMRL7Zik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3MIHNu+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748021672; x=1779557672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gYYx1l/Pn+n5FEnkn32ZPkxnX8faGzxv7Jv7CihnuCw=;
  b=Q3MIHNu+1sfFWzJuZ+pv4schB1evsFemu0Qna20T7KJOqdwy48BFmVQL
   nhhfaxgJ269OQKtA6wOlcZXTjv8wDVKqYKqk034NCINFSkomVYqaif6l5
   c6fVYnCxJk7RhJ7e3BDRRRoQCOi5StjYUJDoX9HYErwY77yInJnP26+Ko
   6a0vYzEEj1hTdD8i+q+XkRZSWsWXj12FqVhA/7Nbjn9PD/X+f8j7WkZzV
   AWftZ7ic3ZDJ0J2S2mXEML6Y7i6XYAx2vpeMBvBDTaLOSt2q3B8cXnxkB
   BdC86fEwUPab4yY5xT9f3euiFVw8z8KOmuwwnkwx0X8rQvSZpnTTkz36F
   w==;
X-CSE-ConnectionGUID: aGcZZObgS1GoROfCPsWDDw==
X-CSE-MsgGUID: MWxP+PcAS5qjS/y9QNzfvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60343210"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="60343210"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:34:29 -0700
X-CSE-ConnectionGUID: AiGkHfu6Rrmy5vk/yzVusA==
X-CSE-MsgGUID: NH/AlwqpTr2K5UL3z9bQ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="142178952"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa008.jf.intel.com with ESMTP; 23 May 2025 10:32:57 -0700
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
	aleksandr.loktionov@intel.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v4 0/3] dpll: add Reference SYNC feature
Date: Fri, 23 May 2025 19:26:47 +0200
Message-Id: <20250523172650.1517164-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device may support the Reference SYNC feature, which allows the
combination of two inputs into a Reference SYNC pair. In this
configuration, clock signals from both inputs are used to synchronize
the dpll device. The higher frequency signal is utilized for the loop
bandwidth of the DPLL, while the lower frequency signal is used to
syntonize the output signal of the DPLL device. This feature enables
the provision of a high-quality loop bandwidth signal from an external
source.

A capable input provides a list of inputs that can be paired to create
a Reference SYNC pair. To control this feature, the user must request a
desired state for a target pin: use ``DPLL_PIN_STATE_CONNECTED`` to
enable or ``DPLL_PIN_STATE_DISCONNECTED`` to disable the feature. Only
two pins can be bound to form a Reference SYNC pair at any given time.

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

v4:
- no change.

Arkadiusz Kubalewski (3):
  dpll: add reference-sync netlink attribute
  dpll: add reference sync get/set
  ice: add ref-sync dpll pins

 Documentation/driver-api/dpll.rst             |  25 +++
 Documentation/netlink/specs/dpll.yaml         |  19 ++
 drivers/dpll/dpll_core.c                      |  45 +++++
 drivers/dpll/dpll_core.h                      |   2 +
 drivers/dpll/dpll_netlink.c                   | 190 ++++++++++++++++--
 drivers/dpll/dpll_netlink.h                   |   2 +
 drivers/dpll/dpll_nl.c                        |  10 +-
 drivers/dpll/dpll_nl.h                        |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 186 +++++++++++++++++
 include/linux/dpll.h                          |  13 ++
 include/uapi/linux/dpll.h                     |   1 +
 12 files changed, 475 insertions(+), 21 deletions(-)


base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
-- 
2.38.1


