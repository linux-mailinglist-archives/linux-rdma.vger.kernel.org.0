Return-Path: <linux-rdma+bounces-18192-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEpRGi9PuGlHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18192-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:42:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0CF29F29A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C8943040F83
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1413E1CFD;
	Mon, 16 Mar 2026 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOSKNGuO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109F3DFC6E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686455; cv=none; b=GHl8f3w2YR8xsfy4Usy2XfbGvdR6pM8+l+OZZ6JgFUAxcE9BH5nvuSSN4BQww6YM+imHvz73b9ZXbrRzCkJ1t2s1txYYhfyUrjney4mud7ypW1BuquXLArrzxEqvf9FSPxUJ7v7CCobROerKcevDd+iIAOSjmL13D5eV2CdmbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686455; c=relaxed/simple;
	bh=el41HRONOrD+s1DEefkvDFf+kw5O9U7/+CJEMNwE7XY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcwFxyKYcvJCt2FmKJ3Sv+YOkYSuxD3Xriu5UA6soA2yyvpWRVtc+WgV1c7fmHT+0QAtc77yt+ihHBKfsXS3X0xp/KuHwLre8Ebs+QQqhZeZhv+0FzRIiNYVZ1cGpAVtVYB7gqwWCr607UrJyVrIVi8i3V2plzYEYuq49UGDa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOSKNGuO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686447; x=1805222447;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=el41HRONOrD+s1DEefkvDFf+kw5O9U7/+CJEMNwE7XY=;
  b=LOSKNGuO2GRoYuuyZ0SkWgi6CBpd2pa+fB+TLOP2LH7nttPIkkrWCGla
   E6mA0eDzm9v4taHADwDSqSFGVEYCvoGrNpyuNxasup79zKNEFYnTlZBkL
   M/eEtapjU1gCsiVbTvGenZZ6VBhdqXTZueiggHzfUzcGTruiiQ7EQk+FL
   wtXpBDKFFLUEYqJoKNLyLOesQheV4qAnnqv9WcrrVGnevR/Pg7aPNOwQm
   hcVZ13WDqcTw8N6BPYcDfRBzf44/c4dpd/iAE++d9BSsCT4VfnioSpibY
   jqrI/bir0rwX6haV9+yCcdYs3WNulWKy3OqZzkTHfyBjAoNArs/ydgjlN
   Q==;
X-CSE-ConnectionGUID: 33KGwc2lR5KN9SHksqh/lA==
X-CSE-MsgGUID: 41PCYMX2ReWV/YGUBNQxvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86067585"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86067585"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:45 -0700
X-CSE-ConnectionGUID: 3Y2P9dVmSDqlHHHrQvavKg==
X-CSE-MsgGUID: QPzI+kNyRMGYrw81iJLSvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252520398"
Received: from soc-pf51ragt.clients.intel.com ([10.122.184.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:40:42 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 00/12] RDMA/irdma: A few fixes for irdma
Date: Mon, 16 Mar 2026 13:39:37 -0500
Message-ID: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[intel.com:?];
	TAGGED_FROM(0.00)[bounces-18192-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.949];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tatyana.e.nikolova@intel.com,linux-rdma@vger.kernel.org];
	DMARC_DNSFAIL(0.00)[intel.com : query timed out];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	R_DKIM_TEMPFAIL(0.00)[intel.com:s=Intel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid]
X-Rspamd-Queue-Id: 2F0CF29F29A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series includes a few irdma fixes:

 - Change request_done type to atomic
 - Change ah_valid type to atomic
 - Clean up unnecessary dereference of event->cm_node
 - Initialize free_qp completion before using it
 - Harden SQ/RQ depth calculation functions
 - Update ibqp state to error if QP is already in error state
 - Fix deadlock during netdev reset with active connections
 - Return EINVAL for invalid arp index error
 - Remove a NOP wait_event() in irdma_modify_qp_roce()
 - Remove reset check from irdma_modify_qp_to_err() to ensure disconnect

The series also include the following additions:

 - Add support for GEN4 hardware
 - Provide scratch buffers to firmware for internal use

Anil Samal (1):
  RDMA/irdma: Fix deadlock during netdev reset with active connections

Ivan Barrera (1):
  RDMA/irdma: Clean up unnecessary dereference of event->cm_node

Jacob Moroni (2):
  RDMA/irdma: Initialize free_qp completion before using it
  RDMA/irdma: Add support for GEN4 hardware

Jay Bhat (1):
  RDMA/irdma: Provide scratch buffers to firmware for internal use

Krzysztof Czurylo (2):
  RDMA/irdma: Fix data race on cqp_request->request_done
  RDMA/irdma: Change ah_valid type to atomic

Shiraz Saleem (1):
  RDMA/irdma: Harden depth calculation functions

Tatyana Nikolova (4):
  RDMA/irdma: Update ibqp state to error if QP is already in error state
  RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
  RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
  RDMA/irdma: Return EINVAL for invalid arp index error

 drivers/infiniband/hw/irdma/cm.c         | 31 +++++++++--------
 drivers/infiniband/hw/irdma/ctrl.c       | 44 +++++++++++++++++++++++-
 drivers/infiniband/hw/irdma/defs.h       |  4 +++
 drivers/infiniband/hw/irdma/hw.c         | 27 ++++++++++++---
 drivers/infiniband/hw/irdma/ig3rdma_hw.c |  1 -
 drivers/infiniband/hw/irdma/irdma.h      |  1 +
 drivers/infiniband/hw/irdma/main.h       |  2 +-
 drivers/infiniband/hw/irdma/puda.c       |  2 +-
 drivers/infiniband/hw/irdma/type.h       |  2 ++
 drivers/infiniband/hw/irdma/uda.h        |  2 +-
 drivers/infiniband/hw/irdma/uk.c         | 39 ++++++++++++---------
 drivers/infiniband/hw/irdma/user.h       |  4 +--
 drivers/infiniband/hw/irdma/utils.c      | 24 ++++++-------
 drivers/infiniband/hw/irdma/verbs.c      | 16 +++++----
 14 files changed, 137 insertions(+), 62 deletions(-)

-- 
2.31.1


