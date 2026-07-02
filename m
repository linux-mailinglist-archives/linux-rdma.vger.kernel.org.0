Return-Path: <linux-rdma+bounces-22685-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fvk6BFRcRmquRgsAu9opvQ
	(envelope-from <linux-rdma+bounces-22685-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 14:40:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5792C6F7C06
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 14:40:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=zte.com.cn (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22685-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22685-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F363313723B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B647ECE6;
	Thu,  2 Jul 2026 12:24:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825F47DD51;
	Thu,  2 Jul 2026 12:24:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995092; cv=none; b=rq+mYetJXH+aPplwZ1iZb7TwGkJFdpDXXvO/CRPgMJdMB2v3I1fvFw+FIf3x76Ab/K7wMdCKdvlm2tMnyOu3rmQINZFYRfP/YSMkU8KPv0//VO8yJ1bOkXe8DRSBE1RU7snZ/he5H+XJW6jWUM+IMiDD05W4wn5Kwx5wUm6fQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995092; c=relaxed/simple;
	bh=8r/SwSBZtYe941TCkdHunOWp2NN3MYXQ8zomCQ56WpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WgPWx3J5Tmsi1SquaUsHc2Z1WfZyoNEXKQ5qb7PuCRVfGPtmNgs8RnkZY19aoClfU5HPGZ19vPJXe+1z/04/CPKjooj7/ANnu0LCJJWrBsPijZYup4pkoXSk12Ad9gKloodxTPqULHOwk3EmVJ4oON+owX2+jmpgfpIQaJxSzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4grbfx6Rldz8XrrM;
	Thu, 02 Jul 2026 20:24:41 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl2.zte.com.cn with SMTP id 662COUD9077439;
	Thu, 2 Jul 2026 20:24:30 +0800 (+08)
	(envelope-from zhang.yanze@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
	by smtp (Zmail) with SMTP;
	Thu, 2 Jul 2026 20:24:33 +0800
X-Zmail-TransId: 3e816a46585b008-5811f
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: zhang.yanze@zte.com.cn
From: Yanze Zhang <zhang.yanze@zte.com.cn>
To: jgg@ziepe.ca, leon@kernel.org, julianbraha@gmail.com,
        huangjunxian6@hisilicon.com
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        wei.quan@zte.com.cn, han.junyang@zte.com.cn, ran.ming@zte.com.cn,
        han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: [PATCH rdma v3 0/2] Add ZTE DingHai Ethernet Protocol Driver for RDMA
Date: Thu,  2 Jul 2026 20:22:54 +0800
Message-ID: <20260702122256.569952-1-zhang.yanze@zte.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 662COUD9077439
X-TLS: YES
X-ENVELOPE-SENDER: zhang.yanze@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 02 Jul 2026 20:24:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A465889.000/4grbfx6Rldz8XrrM
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
	TAGGED_FROM(0.00)[bounces-22685-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:julianbraha@gmail.com,m:huangjunxian6@hisilicon.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:wei.quan@zte.com.cn,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,hisilicon.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[zhang.yanze@zte.com.cn,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhang.yanze@zte.com.cn,linux-rdma@vger.kernel.org];
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
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5792C6F7C06

Hi maintainers and reviewers,

This is v3 of the ZTE DingHai (ZXDH) RDMA driver submission.
Thank you Junxian Zhuang and Julian Braha for your reviews on v1.

Note: Both reviewers provided feedback exclusively on v1. Since v2 received
no additional comments, this v3 applies all v1 feedback directly onto the
v2 codebase. The changes below are relative to v2.

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

The driver provides RoCEv2 support for ZTE DingHai network adapters and has
been tested with perftest and rping utilities.

Best regards,
Yanze Zhang

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


