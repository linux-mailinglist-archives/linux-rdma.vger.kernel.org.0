Return-Path: <linux-rdma+bounces-18520-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKYsFj1GwWnpRwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18520-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 14:55:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1B12F3686
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 14:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90F6A3012C8B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F11B21ADCB;
	Mon, 23 Mar 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="mcUvdgAL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87F1FE44A;
	Mon, 23 Mar 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273555; cv=none; b=DQ6kGK6Jvi4SNNxsc6D6haEJfW4+mbR6N/IVVEPkko54f5WCHDUPXXyV8oRXClw6EqCo6RBSShAcI+uw6VIkBWTZ6qPvP/y5FajcLJ/46Lw6BCaaGYGWskkNxSwqSWadBUXnoPkE8FMrYjaeTAkjVskW3oz2PKSNLgAh9Qg2Wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273555; c=relaxed/simple;
	bh=CQE6ayJukjP0BwdxrTw6grosfpTbeAcz1sgZqWZfm/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LM3eHVRruQ2L0kYU16zYhrLnnZuusmYgSqQ/GFBAKega2+bQzrPxLfnzyzFMWCvC4YolwrGbK+vH2pnRUcq2I8v8gKRlcI5lu33/SC9MYp+wSuVR1S4UrclWvSS4MVs6UIqmArbJeg5iY+RySQglzcHS3OBfk9/fNwDqWLEsCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=mcUvdgAL; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774273494;
	bh=R3PT1D/VX3WIYCIz2QdulOFFB30ft8CGfOiz7AyaFl8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mcUvdgALcla0Lver4ym4wt9DpfDXaAtGuX7tPHPzRKhqjyP4lQUMoPWG/bNphmIGZ
	 d+I+WJM+88cxoCzNDQtCPNlDRduK5hJrR/YnVJHxLaB0MI3yUZbMKGvAabHKN2B6xT
	 WE5Wlc5hWdMt5hroD8wPkRtlluG6NbORuGEjK7gA=
X-QQ-mid: zesmtpgz1t1774273493t866b6a72
X-QQ-Originating-IP: ePVhYdxluygeXJFd4cAw+b+4u91k8P9eYe+Ffo4Cz00=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Mar 2026 21:44:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9209896757183036920
EX-QQ-RecipientCnt: 10
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: leon@kernel.org
Cc: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH v2] RDMA: remove outdated comments referencing hfi1_destroy_qp()
Date: Mon, 23 Mar 2026 21:44:50 +0800
Message-Id: <20260323134450.2478-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260322185927.GE814676@unreal>
References: <20260322185927.GE814676@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: M4ATcDSFOIBzl2aBvaY7995z0mtJpHkFJlQ5i0BdlZ2uMtH72y2sKyV8
	eyrU+/6+fY8tQ1hCbVT7Orm6DetuEzmxcCL/6EKQPOjoixR7z2RVXXLfFtnX8Oe2NJCb7uJ
	2b+mcUmF2KxygW27CVedp6Uc16XiFR6tWMW1b+OomMfR8EYolD8gC18FrKKVgv9ozJER/YE
	EwuTO5CzV478688QEEO1iXko6IDoeeHG4/NqG0LqHTSXQusmtUX8cm9sWXXbRvB1MawMNsq
	A1fK1nxJY2ICAe36IGzFdkHh1nWtV4eUaCcwLrGeUGRizSya/zjAYpH6Wj51f0DTmwZ0X2M
	I6+ACNA7TiL0gGnVFpdNq1UE2nxGNxYBB6SpdqYKOSUYrBSWFWpIRDE8U3Pbwm2VQQQ7BNE
	fqQD5ZPnKWTPRTIbObYkpMzBdk4x7AeBy55Wlyhf7T68gaTcnMifWMiU4YRgLXg5EjMYD/1
	6ShyTwp8Ppe1HFHnywMdqIgYRb0Flc7YQjcTQ+UGIV0wLqFa3jLAztG8JBa7RngVpVPpYem
	4mnw1+zar4d888WMapQRSwiILeiFCBhmoh5SDnEHu0ZP83Kt5jOXBXrnVrdH1YWZX4mDII2
	AYa2AINjoajzF+Trq1FOEdPRIDRf3lG0kQaPBgCuhg49OWRAeqdLLcGwA6pv35h1qEwuJMM
	+T1ls8RmDvk8YZivDU9ssl+KbAd7oUFF/zrRGa1pIP2gOZyxTW7vt8M8z3SkQIdX/Z1fBim
	+bBETRjNP9V4zxuj77A9DmT1sWq2Mr2ejsaBUAOKi1wG97WcjbwDLpl1IJne1I9jRJdaI9m
	lX8yENtBcDbMN7OGj1tmNcyOGV+AHguR2lTI50E3QnxgaShse2JR31IAuFbDNs2kjmOQ8Cg
	jVRUjv1+65T9Rwdq6GrUiT2LumA4xixQfZk7Fqs1JDLdABxEZscHk8pAAT1KLDbNtZ1dD8p
	e4akSU/Zc0cjsc36VtdbYxE0WAlYGxWVMbEiLS8HGu3lQwXgsboYTQuAVwj6OuWcQoGeelk
	76SSDCdqb+NZWscGmYP4+mRj0ToNYR48DQ4YgEYz2RGOdGpekPudXeTvoJgYLMi3u9Ukvvg
	nHWe5Yq3VJcHBUSng4BfDL3vf435m+HbC+KHQQDyNN5ZJKa/lGRFjxq2Dle4xT0WVn0EEyh
	Q1mU
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18520-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF1B12F3686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function hfi1_destroy_qp() was removed in commit
75261cc6ab66 ("staging/rdma/hfi1: Remove destroy qp verb") in
favor of the rdmavt generic rvt_destroy_qp().  Two comments
still reference hfi1_destroy_qp() as the waiter that
rvt_put_qp() will wake up.  As Leon Romanovsky noted, these
comments add no value.  Remove them.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/infiniband/hw/hfi1/qp.c      | 1 -
 drivers/infiniband/sw/rdmavt/mcast.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index f3d8c0c193ac..3a0caee95607 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -404,7 +404,6 @@ void hfi1_qp_wakeup(struct rvt_qp *qp, u32 flag)
 		hfi1_qp_schedule(qp);
 	}
 	spin_unlock_irqrestore(&qp->s_lock, flags);
-	/* Notify hfi1_destroy_qp() if it is waiting. */
 	rvt_put_qp(qp);
 }
 
diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index 1fda344d2056..b41fe4c069dd 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -49,7 +49,6 @@ static void rvt_mcast_qp_free(struct rvt_mcast_qp *mqp)
 {
 	struct rvt_qp *qp = mqp->qp;
 
-	/* Notify hfi1_destroy_qp() if it is waiting. */
 	rvt_put_qp(qp);
 
 	kfree(mqp);
-- 
2.25.1


