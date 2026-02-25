Return-Path: <linux-rdma+bounces-17140-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKm9C3KKnmk/WAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17140-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 06:36:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1AF1920A7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 06:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D17304C96D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B62D9EC4;
	Wed, 25 Feb 2026 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="LPvcbWBw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6231ADC97;
	Wed, 25 Feb 2026 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771997790; cv=none; b=LoqVoGvlFUyT+KIteoHr1NEOannmyKeahDSAGo1wZV9iYw8i29RTbZPXlePDAabtwLlkqlSrAlkuBEWMH1kasN4qoC4yEbnNXdazSjFbEensKWveoj8OJzmeNN5iYp+uZFt6lcW+iPwti9O1y/ZGyXdtEeaj6ueB9hdDoLcNJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771997790; c=relaxed/simple;
	bh=tiuQ6d45/bX/uXxTGQp6H5GtLQwaM8Af6+CJCaDqjt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHooyefCRnsngS9SrmoebD9j5ljo27ONJvZsG0pS8c42vEFchItEUlWYFvtIFB+DwE/NMBoZ7uZsMfjFUQA1ow2Q8LQHaLIiW+lOq3Rh3CxBeDp5Z5MabZT4B9uFBDHBCPfPp+pP4pLUBceBinWLkXHNGVvzR9466NzTjBaHnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=LPvcbWBw; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1771997751;
	bh=4bOmPEz9VQNFEVz5c5X2EEFMXItCmxdEg/FM8gKj62Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LPvcbWBwVHsYLjU70dfpoWGMqMRv5ZKAy/pyMl54gN/MWquY95uXTFkFYbIwfWzP9
	 rjBTckUrFvtwfeqdznT19/j0ICZWrlLe17+hL0fEdCyy2w9YaBO8d1KxmpjJJgvvM0
	 MOQq+FN4HN81kc6tyyPhoJmb5AlPT8STYMDeAe3k=
X-QQ-mid: zesmtpgz6t1771997750tf57985f4
X-QQ-Originating-IP: JYnr3CLUDf7WMbYL2Yvw19yEEQ4XTwF3HKT+l+cRm6c=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Feb 2026 13:35:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11280732268684263456
EX-QQ-RecipientCnt: 15
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: allison.henderson@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	kexinsun@smail.nju.edu.cn
Subject: [PATCH net-next v2] net/rds: update outdated comment in rds_send_xmit
Date: Wed, 25 Feb 2026 13:35:44 +0800
Message-Id: <20260225053544.1971-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: OaEjz/uFifOeD0gDD9qAYZgxNQOZzOFxM44v7jMxQ38Qf3gkVY7GPpsW
	daoyjuwedjbKfiA8LxhfftaVT90vbkOIE03Chy2KzK2hdn5KSF4gAqoeac1d40GdTcJK5fo
	wHOLeN3ZIXyW3V6RWCQZN7motN1zoXJ0NAfe0S2zrR+lmkFCIRWnPyrC5OVDqXhxWGhSrtu
	KDhVtNjtng1CsJNyw0a9wVEW9DRxUvo4lmoi8cmuhB9QEKzMkEbtQQD9FBh8+01BiNtRzXq
	5AMHIZiU4Y2paOLJUaRsn+7nyaKPt+yGpvs3o8oiWV803yfu/vHcou2ZvyOYvc6ZTAOfn/o
	/H1e2mN1W6hovNZGy5UXdn5VDAMfCCNbsNKdmwZYBoFhdc6YCb3tnkdCK0FRlwj4AQALKZ/
	9nlpKZaYfpNFmB2xq2Qu6WeHA0k1zIg4WJM53B+0U9jp1HzGioW8cUKooaKdzOFUgt02dFB
	vDYeiEWvDqm1K4ELBTQafNn6YOFuzp1/n9Pks/Ir+JgF1aDInHLkwrIcQcr7yC4J0S3Papx
	wzILL+G8e5u72zwHtZKPUq6ikM4kVf+lJW4P+EakGM5wAii70dYGYVu/GQNbbvUEx787v3i
	Q1E6HhdEkPaaMPUBU1RYLTl/kr2Cd/pUIeaS76j+0sFeRgyBkD0VJoJUne4+OF55YwKNMm3
	jiuwA5l3MeTvt1LuN0gikGpOXAFbLTzG/5VPyne5M65igvMnMD43UO6bB99En9qPNC0z5Yw
	lAu1PZvk+J7s9VEjQX34Q1YPeyM4YYK9Ke61MW+3bl8sSg4TkhS1VPUM4rACKNKbP6iw4dD
	r3aVgEW9IebbF70A23GnGeWG1QhCHfjaC8cmlyN3h8LgmQq/KfCBGOQb/YaknRlh7a24Vzq
	dH8GnNnhYWoMqzAvIKd6BtXJoO+hkwV8U/JiFXUSj7aAhRhl4i9TFXzPR7SY+gTc/GJx9IP
	mzJOkIW2WVrfeqa/BKmzulJsRFcy1AkgOhoaZtwl/ag6Q/nsIWVmf4vIN7i66vZkGW9cApa
	YJz+o+pOOT/EsxWsErynOYAfJe0l1wn8XHrYWfjxvMLLFRc/CmQ2A5oSmhqtHvriTjvr0Gz
	pTIT6bDTOM1ryKhoEFulmQUBzOHPanTiBG9s+xFEUzES1ylzafFkHC0afs9YqctCw4sfQHn
	nlPSJSvTLGAz23Y=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17140-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BB1AF1920A7
X-Rspamd-Action: no action

The function rds_send_reset() was subsumed by rds_send_path_reset()
by commit d769ef81d5b5 ("RDS: Update rds_conn_shutdown to work with
rds_conn_path").  Update the comment accordingly.

Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 net/rds/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index a1039e422a38..d8b14ff9d366 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -284,7 +284,7 @@ int rds_send_xmit(struct rds_conn_path *cp)
 		 *
 		 * cp_xmit_rm holds a ref while we're sending this message down
 		 * the connection.  We can use this ref while holding the
-		 * send_sem.. rds_send_reset() is serialized with it.
+		 * send_sem.. rds_send_path_reset() is serialized with it.
 		 */
 		if (!rm) {
 			unsigned int len;
-- 
2.25.1


