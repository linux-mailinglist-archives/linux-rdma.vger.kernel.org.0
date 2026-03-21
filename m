Return-Path: <linux-rdma+bounces-18494-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDU1M0h6vmnpQgMAu9opvQ
	(envelope-from <linux-rdma+bounces-18494-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 12:00:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060B2E4E0E
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 12:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B04B302E0EF
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03A836BCD7;
	Sat, 21 Mar 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="vQBgVry4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A62989B5;
	Sat, 21 Mar 2026 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090773; cv=none; b=fwC4CCY/vHGv+tJTGPxnoECyEet908lOOq3jxGpEQSu7F0oBN0Z0nfV7NU6HHMX+1/jx2ODnj8vHx4kqjZ9VMF3w7EauuoqdesiMsB043S8SY2aByHzO0TUZVqtP8RVuaSR9omqBefXCbGYm8I831euUeVHQaEhymtC+Mu60VOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090773; c=relaxed/simple;
	bh=jLGFA096pr7L8kYIZGN/qpeymkO4ExHNSv+skBpHCuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQitvRu+mMH/9g6M0qvyMCqUMBgzifhYHugwTMMZxSjdLCXKSZKMTO6grZfvgblvwNQ1nK6XMNvIgM7ulBRYGNVYb/jED0ZSgEnVm9nazHTbqZjzz7UeePAbqi2NCHXL77WlkX+py3gEtkwtVoOdubOqp4wfQB9HSEZJsVTIIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=vQBgVry4; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090749;
	bh=20WrShzWEBnS4436wuWG2SCAwaReR/8pnGN7qsVGxag=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=vQBgVry4jBUDLO6YIof+OxwW0steLBeGfy6tezFh/6kzsijOuZtpwIkeZbpTA2g7p
	 PMpGV/Jl1Jr9me9MgZqy6Faq2SKsGyUL8qEFYNMdcMBaCgVH9uKA6Mvl4j1R3Rl4bT
	 /IH2+9n+oJ5/R5HwAeYpnJHS2n3RFSKBaxKdg6fc=
X-QQ-mid: esmtpsz17t1774090742t9e9b5043
X-QQ-Originating-IP: yYr8GI5Hkrbc3QxH7nRqk9gIMIuRZm5/2YQQjAa5k6I=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:58:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11977306639843108955
EX-QQ-RecipientCnt: 12
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	yishaih@nvidia.com,
	parav@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] RDMA/uverbs: update outdated reference to remove_commit_idr_uobject()
Date: Sat, 21 Mar 2026 18:58:59 +0800
Message-Id: <20260321105859.7642-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MD9gZYskqmkEBZsu5e0KYFjcFAZrptAVvAzOBM0sAWWINpnXFW5BvjkV
	2yL1LBHbRoM8RUsQzMNC2mf8pGFOXUBnDqMIMjd3gkNFsnkjkRogKXhz+AVN2Hrwuj7gjVZ
	c5U5fWZda6bVu500Lb0VwGUqze6hQ4FlIsYO0fqrFRjyi0q/07MQixhKDSxw+JDsc2E6ZQQ
	PzhPnwxj/snvxm3hcegFkF6C6sxQ49j9pP/iBiHyXatl9HjHqqhf6Hw14amPvragqZuvt+Z
	OzVCZkUiZinMx8Idv0JOddcjwje7tICwVUSK+FgShdh3nMFMReI5ByUzoyEXWtuefY92A4D
	bxR4lbFoGbfBiUDm6pwQwYx25b+YgwDX9Rnk6Hjck/OCd4ILoix+ijUHGw2DOxD0iTo3m4y
	SmEKSxHrRl8ZV7FQIKf8Q6yzpWnR6V2R2KPm4wzGSCV/2Fp8AxkGxgeY3rgGAenWnVoQEsw
	93MP3s1XPSChEeimK6/v3uNFmgEy+o2ZD7zgZaJpnOAtgTuIlIYSyXPxJkpuLnKaPGkipwl
	1o5e3Kjhol8yY5MksJHyHqKsWFR/vgQIYgJpHmF/53ENae4rAu26EgY7ZfqPa/f482trB6X
	JlKfhsztc39+Lq6kCcLGNOKz+Dznizzd2Lx18rvwQwMK6OyvGy8Dxptmk3FsCwV256lVHjP
	7FL6JOY4ip6TChd57ieNlEdXdnc12gEvnY7K4550bXByWnvt04Y+GMb622kuLkNHTD3ILSK
	9G9kBHqcsDTuNWGXG+vMPTHRqPAHOnndtMAaeCv3Mtnqj2cRMPgg8AZ4R1yPoqlz6IHN7bp
	Hg+2h5VFc9Ccz1u/UGI+dfUKYPs3iWN3c8/zjLXxV3Qw+wicoY1DO6yFLwKHe4XvSHwZ9dR
	BnmRT+ngvVASMvGxrhj/16nbvk7oVxCc5UgHhCXJHmsODq/ohtFW6C1aDT4bZh2b3XRpJH7
	2n/++kEvhevQG7r7m0xlLMFpopEZv5BLb8YLLi8RyrcQDg5fasx7MtvwqPSy3xfcoWCu0OJ
	B5NgTL1VO8v0jf+I2K5s6KndIAdWXwGsy10ws/yJjJaAnov2pnLiUcpdUSSLRvLgK983v+p
	k793oMTt8GKs+3BefVIEdk=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18494-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nju.edu.cn:email,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid]
X-Rspamd-Queue-Id: 9060B2E4E0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function remove_commit_idr_uobject() was split into
destroy_hw_idr_uobject() and remove_handle_idr_uobject() by
commit 0f50d88a6e9a ("IB/uverbs: Allow all DESTROY commands
to succeed after disassociate").  The kref put that the
comment refers to now lives in remove_handle_idr_uobject().
Update the stale reference.

Also update "allocated this IDR with a NULL object" to
"allocated this XArray entry with a NULL pointer" to match
the actual data structure (xa_store) and the wording already
used two lines below ("transfers our kref on uobj to the
XArray").

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/infiniband/core/rdma_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 3e0a8b9cd288..5018ec837056 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -590,11 +590,11 @@ static void alloc_commit_idr_uobject(struct ib_uobject *uobj)
 	void *old;
 
 	/*
-	 * We already allocated this IDR with a NULL object, so
+	 * We already allocated this XArray entry with a NULL pointer, so
 	 * this shouldn't fail.
 	 *
 	 * NOTE: Storing the uobj transfers our kref on uobj to the XArray.
-	 * It will be put by remove_commit_idr_uobject()
+	 * It will be put by remove_handle_idr_uobject()
 	 */
 	old = xa_store(&ufile->idr, uobj->id, uobj, GFP_KERNEL);
 	WARN_ON(old != NULL);
-- 
2.25.1


