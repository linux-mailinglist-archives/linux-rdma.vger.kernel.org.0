Return-Path: <linux-rdma+bounces-21746-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kz/6CQ1mIWoVFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21746-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:48:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B1963F8E6
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:48:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=M1jNZ3kk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21746-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21746-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FD4B30AD5CD
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D5426D39;
	Thu,  4 Jun 2026 11:45:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E48426D16;
	Thu,  4 Jun 2026 11:45:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573536; cv=none; b=nULr839S66Cex0SoOhqQ3gcV+yTc7zKnwxJkvr9CXnHz6BTo0U7wjvhlrItasbaVUm8WRBsZ+ZDCVFselTUiM/HlorctBeqyz7hy90kg1ITF5uuwMLefeUWrqk+ApQJ4rigjjzzrz9X0CYHOIi0kLbjxk+sz+dsjVGWq1Lp5Z4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573536; c=relaxed/simple;
	bh=Y2EG4aOxO040LBpGxzCAh1VuYkFd1xkARY/Fvs7+ZWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q86kj+pTHAelZj9IEH3zLNq2a0pzrk+8MYhaZy1T/JSq6cMbZ+scp27Z7diFQgf7KMvgK7BzwxsKf02RxVFYxwDWKh/Z0M/EjWA9tCxyLqjFfpZn/eaSUBFBo867pSmxME5VhjyYPa7EO/OEcd+DH8DDneq7oqDjFqTFUZkbVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M1jNZ3kk; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=A7
	ZV5UyuVvyiqz1npEjK5bSRrlubam+AGqOWOLPx6yY=; b=M1jNZ3kkcVHCkh1p2I
	UOy/bU+qw5Es2fJ55NxvR8wuM5UOvYnG+oyD58GEZ9xIA/A5U2mWoH1oBO//oKoO
	fLoH3MF8LnCtGk12daYNzulsZCcfgVajNVFVyLJ/8FLZD0Ed8PXFWDVkPnfKS2y8
	h2kmqmNUBOq7OMoqm2S41yyaE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA320NHZSFqPEN8AQ--.47837S4;
	Thu, 04 Jun 2026 19:45:13 +0800 (CST)
From: hginjgerx@163.com
To: huangjunxian6@hisilicon.com,
	hginjgerx@qq.com
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:HISILICON ROCE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for-next 2/3] RDMA/hns: Fix missing CQE when UD QP use different SL
Date: Thu,  4 Jun 2026 19:45:09 +0800
Message-Id: <20260604114510.2955010-3-hginjgerx@163.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260604114510.2955010-1-hginjgerx@163.com>
References: <20260604114510.2955010-1-hginjgerx@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgA320NHZSFqPEN8AQ--.47837S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry3ArWDuF45Cw4kCw1xXwb_yoW5Ary7pF
	W5AasIkrW5G3Wj9a129a17Zr9xtasrKw1DGFyvkasI9F1aka98KF1vyryUJFykJrykGr13
	Xr45Jrnxua4xuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jEHqcUUUUU=
X-CM-SenderInfo: hkjl0yhjhu5qqrwthudrp/xtbC-wlOIWohZUmflgAA33
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21746-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,hisilicon.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85B1963F8E6

From: Chengchang Tang <tangchengchang@huawei.com>

Due to the HW issue, CQE may be dropped if UD QP use multiple SLs.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index eb7b1865e4c7..686610642c0a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -654,6 +654,7 @@ struct hns_roce_qp {
 	u8			priority;
 	spinlock_t flush_lock;
 	struct hns_roce_dip *dip;
+	bool			ud_sl_set;
 };
 
 struct hns_roce_ib_iboe {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fe3c658d8c08..6dd56a85d890 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -431,7 +431,8 @@ static int set_ud_opcode(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 	return 0;
 }
 
-static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
+static int fill_ud_av(struct hns_roce_qp *qp,
+		      struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 		      struct hns_roce_ah *ah)
 {
 	struct ib_device *ib_dev = ah->ibah.device;
@@ -441,7 +442,12 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_HOPLIMIT, ah->av.hop_limit);
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_TCLASS, ah->av.tclass);
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_FLOW_LABEL, ah->av.flowlabel);
-	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_SL, ah->av.sl);
+	if (!qp->ud_sl_set) {
+		qp->sl = ah->av.sl;
+		qp->ud_sl_set = true;
+	}
+
+	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_SL, qp->sl);
 
 	ud_sq_wqe->sgid_index = ah->av.gid_index;
 
@@ -491,12 +497,10 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 			  qp->qkey : ud_wr(wr)->remote_qkey);
 	hr_reg_write(ud_sq_wqe, UD_SEND_WQE_DQPN, ud_wr(wr)->remote_qpn);
 
-	ret = fill_ud_av(ud_sq_wqe, ah);
+	ret = fill_ud_av(qp, ud_sq_wqe, ah);
 	if (ret)
 		return ret;
 
-	qp->sl = to_hr_ah(ud_wr(wr)->ah)->av.sl;
-
 	set_extend_sge(qp, wr->sg_list, &curr_idx, valid_num_sge);
 
 	/*
@@ -5606,6 +5610,7 @@ static void v2_set_flushed_fields(struct ib_qp *ibqp,
 	hr_reg_write(context, QPC_SQ_PRODUCER_IDX, hr_qp->sq.head);
 	hr_reg_clear(qpc_mask, QPC_SQ_PRODUCER_IDX);
 	hr_qp->state = IB_QPS_ERR;
+	hr_qp->ud_sl_set = false;
 	spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flag);
 
 	if (ibqp->srq || ibqp->qp_type == IB_QPT_XRC_INI) /* no RQ */
-- 
2.33.0


