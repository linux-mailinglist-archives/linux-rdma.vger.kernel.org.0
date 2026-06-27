Return-Path: <linux-rdma+bounces-22499-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zkj3BIssP2rpPgkAu9opvQ
	(envelope-from <linux-rdma+bounces-22499-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 03:51:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2296D0BF8
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 03:51:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hisilicon.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22499-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22499-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E05B53010496
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AAB255F28;
	Sat, 27 Jun 2026 01:51:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1D1D5CD1;
	Sat, 27 Jun 2026 01:50:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525061; cv=none; b=SIEAuBHABnDeYiOdTZNa53B3aGEgo4UM4WrnP651bijOCrbhdxo6We27VjqkgNcaW9j9VdYPri51yV+woAe8a7gJgTMxlkq4dJlZ6Yff3FD7T3nPsL+9gAodbujvbdMSxvvYDNf7bMF7KQLmiv3C+p6R9UJ2dlKtaIG4lWHRqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525061; c=relaxed/simple;
	bh=iTeuEAI6PwKoeJS4CBgt8i9Kyy3fK+k0UWwbsuLUdkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KUNGZ/5Xm9Ov5K1WKh364l/GBVG6xxdVUJKvaCXtbL3sebYzWoFcqKTWDXLor+9/Q88mAQFCku6KKsrQ+mqTvDWrsF7zOBbKXZw8DztQoNKUXDcUT5etBs1MmaXsjKlPS7ORtL8qSXzoupv1zOfDNt7bc6k4RXKhB8/2Y4Ji21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gnFdS6pwFzLlxW;
	Sat, 27 Jun 2026 09:41:48 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id EBD7940565;
	Sat, 27 Jun 2026 09:50:55 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 27 Jun 2026 09:50:54 +0800
Message-ID: <22248145-9a17-daab-bc2c-827ee67c1cf4@hisilicon.com>
Date: Sat, 27 Jun 2026 09:50:54 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rdma v1 0/2] Add ZTE DingHai Ethernet Protocol Driver for
 RDMA
Content-Language: en-US
To: <zhang.yanze@zte.com.cn>, <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<wei.quan@zte.com.cn>, <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
	<han.chengfei@zte.com.cn>
References: <202606241644572798vwNbZEAtt3c2IHcJUtCs@zte.com.cn>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <202606241644572798vwNbZEAtt3c2IHcJUtCs@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhang.yanze@zte.com.cn,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:wei.quan@zte.com.cn,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22499-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zte.com.cn:email,hisilicon.com:mid,hisilicon.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E2296D0BF8



On 2026/6/24 16:44, zhang.yanze@zte.com.cn wrote:
> From: Yanze Zhang <zhang.yanze@zte.com.cn>
> 
> This series adds initial RoCEv2 support for the ZTE ZXDH RNIC,
> a PCIe Gen5 adapter.
> 
> The driver implements core IB verbs (QP/CQ/MR/SRQ/AH) with async CQP
> command path and DCQCN congestion control, using the auxiliary bus
> framework following hns/bnxt_re patterns. It does not include Ethernet

Well..actually hns is not using auxiliary bus, so please modify
the description here

> network data plane support. Perftest shows ~395 Gb/s write bandwidth at
> 4KB message size over RoCEv2 RC/UD QPs.
> 
> Yanze Zhang (2):
> RDMA/zrdma: Add ZTE Dinghai Ethernet Protocol Driver for RDMA
> RDMA/zrdma: Add hardware config code and improve driver init flow

It seems this whole patchset violates the rule that indentations
should be 8 characters. Please see:
Documentation/process/coding-style.rst 1) Indentation

Junxian

> 
> MAINTAINERS | 6 +
> drivers/infiniband/Kconfig | 1 +
> drivers/infiniband/hw/Makefile | 1 +
> drivers/infiniband/hw/zrdma/Kconfig | 10 +
> drivers/infiniband/hw/zrdma/Makefile | 6 +
> drivers/infiniband/hw/zrdma/zrdma_ctrl.h | 248 +++++++++++++++++++++++
> drivers/infiniband/hw/zrdma/zrdma_defs.h | 37 ++++
> drivers/infiniband/hw/zrdma/zrdma_hw.c | 135 ++++++++++++
> drivers/infiniband/hw/zrdma/zrdma_hw.h | 156 ++++++++++++++
> drivers/infiniband/hw/zrdma/zrdma_main.c | 156 ++++++++++++++
> drivers/infiniband/hw/zrdma/zrdma_main.h | 140 +++++++++++++
> drivers/infiniband/hw/zrdma/zrdma_mem.h | 105 ++++++++++
> drivers/infiniband/hw/zrdma/zrdma_type.h | 110 ++++++++++
> drivers/infiniband/hw/zrdma/zrdma_uk.h | 18 ++
> 14 files changed, 1129 insertions(+)
> create mode 100644 drivers/infiniband/hw/zrdma/Kconfig
> create mode 100644 drivers/infiniband/hw/zrdma/Makefile
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_ctrl.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_defs.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_hw.c
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_hw.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_main.c
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_main.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_mem.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_type.h
> create mode 100644 drivers/infiniband/hw/zrdma/zrdma_uk.h
> 
> --
> 2.27.0
> 
> 

