Return-Path: <linux-rdma+bounces-20104-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LOnAjfp+2nEHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20104-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:21:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F854E1E90
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 03:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD46630054C9
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA2236453;
	Thu,  7 May 2026 01:21:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A71E1C11
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116914; cv=none; b=aDDj5MTwiqeDZHrBvViEccWMif/SjVD+5A0oiXRFeprthIk/Zqr5ZQWPQlSxHxI5vEq/7L4Pozn6qjt7zeOlP9HiaT5A/VwQYaD4Ai3dquOq1gJbnRxkrtdKtd8QEpa85rXBz5ICmfMwU/Jw6Cqo4Mymf5S/rCubPe4JT18NAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116914; c=relaxed/simple;
	bh=OQRo/k6/4K8m4S9WCJaZFgg+7mCo/cMzfNC4EQazlkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kbbQCqVNjVIBpMb6Ufy3FCnZKy2QPBw7Jl2dJ++9psLyZgYUtEdIuGpEKmHme2SdYgYlIBSU2l4fXyc69HZRlM1nmMWIHPuSqXgYFNsftnrQz1qartjtI+Ig9vl1vCwT2eiT4TvlyFhfh3d8PcrpHxPd1WM4/4LHD3i2XoZZQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4g9vSM1gZxz1prLr;
	Thu,  7 May 2026 09:15:15 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E2A240569;
	Thu,  7 May 2026 09:21:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 09:21:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 0/3] RDMA/hns: Support congestion control algorithm parameter configuration by debugfs
Date: Thu, 7 May 2026 09:21:45 +0800
Message-ID: <20260507012148.1079712-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Queue-Id: 68F854E1E90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20104-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hisilicon.com:mid]
X-Rspamd-Action: no action

This series adds support for congestion control algorithm parameter
configuration by debugfs.

v2:
* Inline init_debugfs_seqfile()
* Remove delayed_work and related logic
* Add usage example to the commit log of patch 3
v1: https://lore.kernel.org/linux-rdma/20260206103110.3414311-1-huangjunxian6@hisilicon.com/

Chengchang Tang (1):
  RDMA/hns: Support congestion control algorithm parameter configuration

Junxian Huang (2):
  RDMA/hns: Initialize seqfile before creating file
  RDMA/hns: Add write support to debugfs

 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 288 ++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  26 ++
 drivers/infiniband/hw/hns/hns_roce_device.h  |  21 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  54 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h   | 125 ++++++++
 5 files changed, 501 insertions(+), 13 deletions(-)

--
2.33.0


