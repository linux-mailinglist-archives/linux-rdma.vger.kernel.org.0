Return-Path: <linux-rdma+bounces-22443-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i04IMCKZO2q3aAgAu9opvQ
	(envelope-from <linux-rdma+bounces-22443-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 10:45:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 107746BCA6D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 10:45:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=zte.com.cn (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22443-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22443-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34DE3046502
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5713905E7;
	Wed, 24 Jun 2026 08:45:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B743911B6;
	Wed, 24 Jun 2026 08:45:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290706; cv=none; b=HrnmVhVWCGo8uCvWlkYD8oSJtb6n1gSQXj+HLq/B3wd2CaNoi5Uvo8ooQPBN7x3BgQ7lJPoYcbpeOSFV7AjVcvGBcZgnTHSRVpCugboRIlnMGzGFGE0scHZdAt9htcMq9inru1t6/lZhlLO0XV5qEI4t4IAXCUNGWXClvdqrf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290706; c=relaxed/simple;
	bh=6zJo2iIEkBCBtH4ceqs7lOHIhU4Y1WzDlV9siifn1wk=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=q0/3H2NsWjWk6suDkOam1A5+Gxb1TYGFpOGkilkRAn4Q5FXO4Cqc2gcw7nacfeK9q+oOE92PD8tGrI63Y/jyeFP7JClYhsdEN+7Su8WlilmMSyBX+kyGwhumm0epjuygF3hE+VxBzfbLmhhfaJA8+UmdhkIhuHnVRaiNgEWOgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4glb9B3mtMz5B0ny;
	Wed, 24 Jun 2026 16:45:02 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl2.zte.com.cn with SMTP id 65O8it8D063385;
	Wed, 24 Jun 2026 16:44:55 +0800 (+08)
	(envelope-from zhang.yanze@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
	by mapi (Zmail) with MAPI id mid14;
	Wed, 24 Jun 2026 16:44:57 +0800 (CST)
X-Zmail-TransId: 2b046a3b99091da-83b6b
X-Mailer: Zmail v1.0
Message-ID: <202606241644572798vwNbZEAtt3c2IHcJUtCs@zte.com.cn>
Date: Wed, 24 Jun 2026 16:44:57 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.yanze@zte.com.cn>
To: <jgg@ziepe.ca>, <leon@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <zhang.yanze@zte.com.cn>, <wei.quan@zte.com.cn>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHJkbWEgdjEgMC8yXSBBZGQgWlRFIERpbmdIYWkgRXRoZXJuZXQgUHJvdG9jb2wgRHJpdmVyIGZvciBSRE1B?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 65O8it8D063385
X-TLS: YES
X-ENVELOPE-SENDER: zhang.yanze@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 24 Jun 2026 16:45:02 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3B990E.002/4glb9B3mtMz5B0ny
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:zhang.yanze@zte.com.cn,m:wei.quan@zte.com.cn,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22443-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[zhang.yanze@zte.com.cn,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.yanze@zte.com.cn,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 107746BCA6D

From: Yanze Zhang <zhang.yanze@zte.com.cn>

This series adds initial RoCEv2 support for the ZTE ZXDH RNIC,
a PCIe Gen5 adapter.

The driver implements core IB verbs (QP/CQ/MR/SRQ/AH) with async CQP
command path and DCQCN congestion control, using the auxiliary bus
framework following hns/bnxt_re patterns. It does not include Ethernet
network data plane support. Perftest shows ~395 Gb/s write bandwidth at
4KB message size over RoCEv2 RC/UD QPs.

Yanze Zhang (2):
RDMA/zrdma: Add ZTE Dinghai Ethernet Protocol Driver for RDMA
RDMA/zrdma: Add hardware config code and improve driver init flow

MAINTAINERS | 6 +
drivers/infiniband/Kconfig | 1 +
drivers/infiniband/hw/Makefile | 1 +
drivers/infiniband/hw/zrdma/Kconfig | 10 +
drivers/infiniband/hw/zrdma/Makefile | 6 +
drivers/infiniband/hw/zrdma/zrdma_ctrl.h | 248 +++++++++++++++++++++++
drivers/infiniband/hw/zrdma/zrdma_defs.h | 37 ++++
drivers/infiniband/hw/zrdma/zrdma_hw.c | 135 ++++++++++++
drivers/infiniband/hw/zrdma/zrdma_hw.h | 156 ++++++++++++++
drivers/infiniband/hw/zrdma/zrdma_main.c | 156 ++++++++++++++
drivers/infiniband/hw/zrdma/zrdma_main.h | 140 +++++++++++++
drivers/infiniband/hw/zrdma/zrdma_mem.h | 105 ++++++++++
drivers/infiniband/hw/zrdma/zrdma_type.h | 110 ++++++++++
drivers/infiniband/hw/zrdma/zrdma_uk.h | 18 ++
14 files changed, 1129 insertions(+)
create mode 100644 drivers/infiniband/hw/zrdma/Kconfig
create mode 100644 drivers/infiniband/hw/zrdma/Makefile
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_ctrl.h
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_defs.h
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_hw.c
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_hw.h
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_main.c
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_main.h
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_mem.h
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_type.h
create mode 100644 drivers/infiniband/hw/zrdma/zrdma_uk.h

--
2.27.0

