Return-Path: <linux-rdma+bounces-16949-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFrHE7BPlGktCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16949-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 12:23:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C510214B4B7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 12:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE256300E257
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5813331A49;
	Tue, 17 Feb 2026 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="oKQ4xVYM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B31331A63
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327400; cv=none; b=eq0rYMWrQmvWuDCnBe01oHNbsew/FgydlWttZg9q6s+fas+1l7G5bl+sCz9hvTkkH/W+j74lRjNaKj1MpmRfQGlTxWmGPNXiuzKb1bjlkAlJatDqF9POR2q1I2f9fFOxSfo69EZNRxvgr5m2TotqwK5SJEpNz8ooQ+j6I3gtxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327400; c=relaxed/simple;
	bh=FRmdaMTEiF5Hohno96tGdopNG3fPxHliShxXqGhQ6Fo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IShrlut77aXVb29gNRX3SV54vKmTFq+Ev5X3fkXhM2pKaFIAjevwUbct6Ey5QGAJl9z8ihTp80AtZXj+qPvtPCiuXkV9+hPPJGU/gAtWjM2JV4cy15Vqkq4DNYEEY+L0XSW7dVxRBPhI5Qz44L52umQQ/TrmOONkm1OuQt5XQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oKQ4xVYM; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771327398; x=1802863398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JSXY+TsWGd1dSfDd4+UHyO7vPpeSq/VfxZWxlv8vt50=;
  b=oKQ4xVYM7v/a+JSXtsWvGo/ew7UAGxoAa9xv23dzKOoHUsYrM8n6CNZ2
   4c43Hg/GhiU9GoinKxwienvLHAs7sl4ezRAGRrtDE9H49i453L+1UCz9z
   3016ZdT+ud0UiYdj1N3qvFjh4PseTppSFgngT9ar1mS4XvXuZcyizRTtV
   o0lb1a/ApI9kEl7G/ROwRzkMrb5MotrvDZAhRDsblE2HquGbPV4qGc2lf
   Ek/Ym3XcfyUxTiyHeINX5+DNF+xck7F1OQZPBEylP+BA6bmhyvbqq01fk
   5QIvd/HLjiNaBlFrwAmsTFU/soTtQPEMVm1jgQdHFnAeZYO3Hu3k0DLnj
   A==;
X-CSE-ConnectionGUID: NS4BwILjTImo+43u6fRi8g==
X-CSE-MsgGUID: NLwQQJi9QNuDIlwFG/BEPQ==
X-IronPort-AV: E=Sophos;i="6.21,296,1763424000"; 
   d="scan'208";a="12987887"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 11:23:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:4098]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.96:2525] with esmtp (Farcaster)
 id 2a053285-4398-4078-86e9-028c33d4ea61; Tue, 17 Feb 2026 11:23:15 +0000 (UTC)
X-Farcaster-Flow-ID: 2a053285-4398-4078-86e9-028c33d4ea61
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 17 Feb 2026 11:23:15 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Tue, 17 Feb 2026
 11:23:13 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v3 0/3] RDMA/efa: Expose extended max inline buffer size
Date: Tue, 17 Feb 2026 11:23:01 +0000
Message-ID: <20260217112304.36849-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16949-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C510214B4B7
X-Rspamd-Action: no action

Changelog:
v3:
 * Use right enum value for new device query.
v2: https://lore.kernel.org/all/20260216133351.14896-1-ynachum@amazon.com/
 * Added patch 3 to use the extended inline buffer size for validation
   in QP creation.
v1: https://lore.kernel.org/all/20260215120451.18053-1-ynachum@amazon.com/

-------------------------------------------------------------------------
This series adds support for querying an extended max inline buffer size
from the EFA device.

The first patch renames the existing queue attributes structure to prepare
for adding a second queue attributes query.

The second patch introduces the new extended max inline buffer size query
and exposes this value to userspace.

The third patch updates the inline validation to use the extended inline
buffer size.

Yonatan Nachum (3):
  RDMA/efa: Rename admin queue attributes struct name for extendability
  RDMA/efa: Expose new extended max inline buff size
  RDMA/efa: Use extended inline buff size for inline validation

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 23 ++++++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 55 ++++++++++++-------
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  3 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  7 ++-
 include/uapi/rdma/efa-abi.h                   |  5 +-
 5 files changed, 62 insertions(+), 31 deletions(-)

-- 
2.47.3


