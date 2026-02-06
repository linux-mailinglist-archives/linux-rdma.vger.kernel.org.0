Return-Path: <linux-rdma+bounces-16642-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB1KO//ChWltGAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16642-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 11:31:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0613AFCA99
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 11:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81D4C3009837
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE7374753;
	Fri,  6 Feb 2026 10:31:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D7350A10
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770373880; cv=none; b=qiomTnjmoMvjluSPEh72vKZJcr1La7iqpGBeULKZnnFaKfkyWCLFuS3Jclf0h1wX6mTv21svQyM9L9kg6+lzbpGWNKTsbrYylxn1617c1rqsCbSo0zTNrsu4+lbgeLgbQxX42L9M9J9AYmQxRv7+TdbYAv4CoplkFdo0gaLD9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770373880; c=relaxed/simple;
	bh=ehr/Vm6MM23VImKjLDEGmML/pfsrTVdrUlsiiMpYrVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULao6u+N9OjR3JMx2UJ6JnDs/DdWQL1k2F1d2Cw34C1CUkZpEXrLJlhlFFwqbMgsJsYXzn1MNk/sx2j9GSneyzv6rO5WMKg1sin1SGwJm1z8LzBribCnysa4TCJhZ1j6P9WWeTWD+Y8xpyk7L6wFy/myuZw2I6ASEHcay0qjGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f6qyF51jXzcb2y;
	Fri,  6 Feb 2026 18:26:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id EBB1F40567;
	Fri,  6 Feb 2026 18:31:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 6 Feb 2026 18:31:11 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Support congestion control algorithm parameter configuration by debugfs
Date: Fri, 6 Feb 2026 18:31:07 +0800
Message-ID: <20260206103110.3414311-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16642-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.981];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0613AFCA99
X-Rspamd-Action: no action

This series adds support for congestion control algorithm parameter
configuration by debugfs.

Chengchang Tang (1):
  RDMA/hns: Support congestion control algorithm parameter configuration

Junxian Huang (2):
  RDMA/hns: Initialize seqfile before creating file
  RDMA/hns: Add write support to debugfs

 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 318 ++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  26 ++
 drivers/infiniband/hw/hns/hns_roce_device.h  |  25 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  66 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h   | 140 ++++++++
 5 files changed, 570 insertions(+), 5 deletions(-)

--
2.33.0


