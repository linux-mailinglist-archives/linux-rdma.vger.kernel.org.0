Return-Path: <linux-rdma+bounces-21744-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 24eANl5lIWreFgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21744-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:45:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA163F873
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:45:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=jv5xlL44;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21744-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21744-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3915D30896B6
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7938D425CF0;
	Thu,  4 Jun 2026 11:45:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E822306774;
	Thu,  4 Jun 2026 11:45:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573528; cv=none; b=FrNiKCCMgzS4+ruEsQ0ab6mU2LgeOG148YDgeNr+C1yDRjaCBETEwYAqgM5ItGSXPauw1sPaZ2OJiMMxIlk6mJNrKY0Nns2ANviI5IuruMV4ITEo60UEnhGLSkTNq1UqTpW42u1/DmuXjSIABOjRi35xG9PKBRxY3yDOWsUKedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573528; c=relaxed/simple;
	bh=VZ82ZYCxBiCIazNhUQjIAJUSKMGnR+4WZZI1ZuaOEm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZAwj74PzS8uTuClN4NiPizZLqiJ8MNq4WN/sVoe9Ey+jJ14F2VDh4RdPu4Fw0rZYs3gPajQ5KLZ1rpi9vpuf+Iqnbeeod60zNRFVfA/tesqFYA5QWSPlpPq9DIK2qN4w1PWMKb+R1ay/7d6Yu3ZlQpY/rwY95IJ6U2vZAuwNcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jv5xlL44; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YD
	r5r5v4XOuPSTaoI+oJp0cXrqG4Vm9WPOf0AQ1VbYg=; b=jv5xlL44Wz4Za0cNuD
	zHu6QB9EuHNvzCTNBnSCA8i2eMS1koGQe+VVgWZvu7lubiZ6Ypu+vkCHpvK9vll1
	+qK9VrxHo5tBgsjPGhdaxBozf+AAMMWColSnK0meU3fsMU2eSHCGFcRSkVV+WI9b
	3TiaAxtCK8ckkdMcE6j7C1YZ8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA320NHZSFqPEN8AQ--.47837S2;
	Thu, 04 Jun 2026 19:45:12 +0800 (CST)
From: hginjgerx@163.com
To: huangjunxian6@hisilicon.com,
	hginjgerx@qq.com
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:HISILICON ROCE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for-next 0/3] RDMA/hns: Misc patches
Date: Thu,  4 Jun 2026 19:45:07 +0800
Message-Id: <20260604114510.2955010-1-hginjgerx@163.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgA320NHZSFqPEN8AQ--.47837S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU31CGUUUUU
X-CM-SenderInfo: hkjl0yhjhu5qqrwthudrp/xtbC5AhOIWohZUhmAgAA3B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21744-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[hginjgerx@163.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:huangjunxian6@hisilicon.com,m:hginjgerx@qq.com,m:tangchengchang@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hisilicon.com,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hginjgerx@163.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hisilicon.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52FA163F873

From: Junxian Huang <huangjunxian6@hisilicon.com>

This patchset includes changes for RDMA/hns: Misc patches.

Chengchang Tang (3):
  RDMA/hns: Fix hung task when drain qp failed.
  RDMA/hns: Fix missing CQE when UD QP use different SL
  RDMA/hns: Support setting GSI QP SL

 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 30 ++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_device.h  |  2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   | 23 ++++++++++-----
 4 files changed, 49 insertions(+), 7 deletions(-)

-- 
2.33.0


