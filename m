Return-Path: <linux-rdma+bounces-21497-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOYKDBGPGWpTxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21497-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:05:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F116602A3D
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F12C6306197D
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E81EEA54;
	Fri, 29 May 2026 13:02:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD041E7C12;
	Fri, 29 May 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059733; cv=none; b=UunginIIpIeiyRvn/6zNK3wSChZrA6tw2bNi4aPayXzf+6qN/MXRCaVOjli/eQ9LUAgH3tuwPWmqcqxHsWWffH/AqAvvK8wsltzMUBxsMtJHvKFQGrbX0OnBOl+MFnLyxz7RYwF6CXDkJwUUcCUwA9eEpfDWDi//KDSsIefs/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059733; c=relaxed/simple;
	bh=LukTOanwzR6Wr1bleanXRdsWVsb7HblPMSLowdokg/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkFw8CbJ0aChcHDpVXpM7U2IMPv4Wnq6AX68yv1Qz1wmAAMO4uvO+00BVyzERpZ0EoYehEdtROdeRvF4bBkL4lkg6W5exYBXpONExkZx6njP8kmbnSP0OSD1KCbeZ2XCtWso5uZIqftzJmzI52hCn5mzpKvTyq6uPuKDJKtx3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAC31L47jhlqzRE9AA--.23852S3;
	Fri, 29 May 2026 21:01:50 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: achender@kernel.org,
	yanjun.zhu@oracle.com,
	guanglei.li@oracle.com,
	davem@davemloft.net,
	santosh.shilimkar@oracle.com,
	junxiao.bi@oracle.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	xuyq21@lenovo.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: rds: clear i_sends on setup unwind
Date: Fri, 29 May 2026 21:01:44 +0800
Message-ID: <5a0f7624bb9845a7b67d26166a150b59e7f394ce.1779632468.git.xuyq21@lenovo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779632468.git.xuyq21@lenovo.com>
References: <cover.1779632468.git.xuyq21@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAC31L47jhlqzRE9AA--.23852S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW5JFW8Gr18AF48Cw13CFg_yoW8Gw17pr
	Za9rsrKFZrtryjka1DAF1I9F129ws3GrW7GrZF9ay29w4DJr92qryv9rWY9anY9rsxWFWY
	qr1qvrnxZ345ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0CCWoZTE8FRwAAs1
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21497-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,davemloft.net,gmail.com,lzu.edu.cn,lenovo.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lenovo.com:mid,lenovo.com:email]
X-Rspamd-Queue-Id: 9F116602A3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuqi Xu <xuyq21@lenovo.com>

The RDS IB connection teardown path is written so it can run during
partial startup and on repeated shutdown attempts. It uses NULL
pointers to distinguish resources that are still owned from resources
that have already been released.

When rds_ib_setup_qp() fails after allocating i_sends but before
allocating i_recvs, the sends_out path frees i_sends without clearing
the pointer. A later shutdown pass can still treat that stale pointer
as a live send ring allocation.

Clear i_sends after vfree() in the error unwind path so the existing
shutdown logic continues to use the correct ownership state.

Fixes: 3b12f73a5c29 ("rds: ib: add error handle")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/rds/ib_cm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 0c64c504f79d..4001de0c4959 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -656,6 +656,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 
 sends_out:
 	vfree(ic->i_sends);
+	ic->i_sends = NULL;
 
 ack_dma_out:
 	rds_dma_hdr_free(rds_ibdev->dev, ic->i_ack, ic->i_ack_dma,
-- 
2.54.0


