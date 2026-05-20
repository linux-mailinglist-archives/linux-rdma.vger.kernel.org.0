Return-Path: <linux-rdma+bounces-21018-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG9WHnFNDWoNvwUAu9opvQ
	(envelope-from <linux-rdma+bounces-21018-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:58:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5185587F3F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58EF301E209
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373AF36BCF2;
	Wed, 20 May 2026 05:58:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DC370ADF
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256687; cv=none; b=Ust1M4Oxj314eMQr6Qx9qvbNrFWhFhAGqFdGrnnB1JxO2wkTYaFVbpk7YD6vBFNvdPR1+hipMAuFAij0yWwVmxFC0YzvHS+ZwpiB7HSTa8i+V8ehmf/kWvWiIaQYspvHuGZkgOTiyexvgIyidF8hLo0crPEQAw4+70vPNIkeXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256687; c=relaxed/simple;
	bh=XCfdwYKzONHQwRI3T+N3ykHlnHY9V7a/UOsI5b3pwqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X5LJKlrZh1LUw7vrYz7JgMwGkS6FoBjLSeobq402RP5wq2/+0pP9n+Jc7WcXObO2WwXmkyR5jdFWzu2R7pxky0k+QklF6FHWJgEtwCln+Xo1nDpCmrgCcfkF2em1Xn8kWeI5rofgVBsqhsmRLzLudZcgM7MHdXvLIA7EDIH6mTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gL0xY5sjjz1T4GV;
	Wed, 20 May 2026 13:50:09 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DB2164056E;
	Wed, 20 May 2026 13:58:00 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 20 May 2026 13:58:00 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 0/3] RDMA/hns: Misc fixes
Date: Wed, 20 May 2026 13:57:56 +0800
Message-ID: <20260520055759.2354037-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21018-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hisilicon.com:mid]
X-Rspamd-Queue-Id: D5185587F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset contains servral fixes for hns.

Junxian Huang (1):
  RDMA/hns: Fix memory leak of bonding resource

Lianfa Weng (2):
  RDMA/hns: Fix warning in poll cq direct mode
  RDMA/hns: Fix log flood after cmd_mbox failure

 drivers/infiniband/hw/hns/hns_roce_cq.c    |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 +++++++++---------
 drivers/infiniband/hw/hns/hns_roce_main.c  |  6 ++++--
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
 5 files changed, 20 insertions(+), 18 deletions(-)

--
2.33.0


