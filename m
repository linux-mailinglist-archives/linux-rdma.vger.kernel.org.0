Return-Path: <linux-rdma+bounces-22753-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+EPIlvESGp+tgAAu9opvQ
	(envelope-from <linux-rdma+bounces-22753-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Jul 2026 10:29:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C40707180
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Jul 2026 10:29:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=zte.com.cn (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22753-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22753-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D74C6300A74A
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jul 2026 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B662D387378;
	Sat,  4 Jul 2026 08:28:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BB38F659;
	Sat,  4 Jul 2026 08:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783153714; cv=none; b=pERLjYMGvkE8A6jY+3YVEsQ/omZce+T01XPA6DTC2h1g8I3h61Rm6m4WTQ043swSXhlDaR0mskEjm8nqmL6miXgytK0zjSPK0GxU0I8Oyp3p+WpJ8MXirlBlsgNGNZBTurhbsfwAuc9r06sqSzIrKMT8kwo8E5j90LaTygrH2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783153714; c=relaxed/simple;
	bh=PjDNkH8eoFBuylPeDe62oalJHB5zr0PIJq/TEM+0ntA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qvcu0JxPWVlmzfZxdlsgfiIFeUHrOKazSgUjj6WA3DfmoFDtIPTfsXMdlq3aTazFZWOg/pnuBJMlpe6TwqHYfUwIEAZaXSpMa+01LavPxEMZU54u2kTdqQ6BNBv38Kxu8F86T7yvKU7RxWLAwqbl/cX/qfFIG4R1gduBk/c4Bms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gskKW591Sz5B101;
	Sat, 04 Jul 2026 16:28:31 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 6648SJg2046534;
	Sat, 4 Jul 2026 16:28:19 +0800 (+08)
	(envelope-from zhang.yanze@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
	by smtp (Zmail) with SMTP;
	Sat, 4 Jul 2026 16:28:21 +0800
X-Zmail-TransId: 3e816a48c40b008-bf8b0
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.yanze@zte.com.cn
From: Yanze Zhang <zhang.yanze@zte.com.cn>
To: jgg@ziepe.ca, leon@kernel.org, julianbraha@gmail.com,
        huangjunxian6@hisilicon.com
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        wei.quan@zte.com.cn, han.junyang@zte.com.cn, ran.ming@zte.com.cn,
        han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: [PATCH rdma v4 0/2] Add ZTE DingHai Ethernet Protocol Driver for RDMA
Date: Sat,  4 Jul 2026 16:26:38 +0800
Message-ID: <20260704082640.664061-1-zhang.yanze@zte.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 6648SJg2046534
X-TLS: YES
X-ENVELOPE-SENDER: zhang.yanze@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 04 Jul 2026 16:28:31 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A48C42F.000/4gskKW591Sz5B101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-22753-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:julianbraha@gmail.com,m:huangjunxian6@hisilicon.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:wei.quan@zte.com.cn,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,hisilicon.com];
	FORGED_SENDER(0.00)[zhang.yanze@zte.com.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[zhang.yanze@zte.com.cn,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:mid,zte.com.cn:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4C40707180

The driver provides RoCEv2 support for ZTE DingHai network adapters and has
been tested with perftest and rping utilities.

Changes in v4:
- Fixed Kconfig help text indentation (Julian Braha).
- Self-correction: Updated SPDX license tag and fixed Makefile
  indentation to strictly follow subsystem standards.

Changes in v3:
- Fixed missing handle release in zxdh_remove() as pointed out by Junxian
  on v1.
- Removed outdated reference to "auxiliary bus following hns pattern" from
  cover letter description (this was already corrected in v2; re-stating
  here since Junxian's comment was on v1).
- Addressed Junxian's indentation concern on v1: I verified the code against
  checkpatch.pl --strict and confirmed 8-character indentation is used
  throughout. This v3 was sent using a different email client/format to rule
  out MUA-induced formatting corruption. If the indentation still appears
  incorrect in your viewer, please review the updated series and let me know
  if the issue persists.

Changes in v2:
- Removed redundant 'depends on INFINIBAND' from Kconfig as it is already
  wrapped by the parent if-block (Julian Braha, v1 review).

Yanze Zhang (2):
  RDMA/zrdma: Add ZTE Dinghai Ethernet Protocol Driver for RDMA
  RDMA/zrdma: Add hardware config code and improve driver init flow

 MAINTAINERS                              |   6 +
 drivers/infiniband/Kconfig               |   1 +
 drivers/infiniband/hw/Makefile           |   1 +
 drivers/infiniband/hw/zrdma/Kconfig      |   9 +
 drivers/infiniband/hw/zrdma/Makefile     |   6 +
 drivers/infiniband/hw/zrdma/zrdma_ctrl.h | 248 +++++++++++++++++++++++
 drivers/infiniband/hw/zrdma/zrdma_defs.h |  37 ++++
 drivers/infiniband/hw/zrdma/zrdma_hw.c   | 135 ++++++++++++
 drivers/infiniband/hw/zrdma/zrdma_hw.h   | 156 ++++++++++++++
 drivers/infiniband/hw/zrdma/zrdma_main.c | 157 ++++++++++++++
 drivers/infiniband/hw/zrdma/zrdma_main.h | 140 +++++++++++++
 drivers/infiniband/hw/zrdma/zrdma_mem.h  | 105 ++++++++++
 drivers/infiniband/hw/zrdma/zrdma_type.h | 110 ++++++++++
 drivers/infiniband/hw/zrdma/zrdma_uk.h   |  18 ++
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


