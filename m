Return-Path: <linux-rdma+bounces-17089-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAAQFCUInWk7MgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17089-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 03:08:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A979D180D5E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 03:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BDD330E1010
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 02:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540E423C8A0;
	Tue, 24 Feb 2026 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="MK44GgvB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819F207A20;
	Tue, 24 Feb 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898870; cv=none; b=nb3beG434/LPAVtMTbTES3INqs1zlnuFCW76HTae/SRyMXSIWzuuAGNosZVWBFvGy14hHtJ4MGq4aAcal0IGEUSiWF+4bZ2S3zXfdD0erWyfJQsT0O/1iniXssiyYeGG5t7bFxTKkudD4tkUpKx/v4Pc43jXqlJJxiZ+KU/N3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898870; c=relaxed/simple;
	bh=FtO3wZJ5gAFHP8d/P/PrXYh9573Wu71WSSIUXMIaLLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VPdH75kLfrAH7B80tU1Udeuy1Kq8OmJuw7sEW8DOOKof8MpTPyHUjB0vp01/TipCShYZjTp+Tmvk0BiucCtTRDhp8Sa0q3Y9kA2gmdKOA+W5qDAtKnq77+sU1TXsMbZqlDN2/vyYmjfQ0izJGJB+05WLCoPEZyJJDiclTjv5lMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=MK44GgvB; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1771898847;
	bh=Afjeq0ABeVA/DVRS8ujIoUHECLl6nZzPpxDRLT+NXAA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=MK44GgvB5salxVt6QnPqNWCnaqpvPG7j/WCWYpx+sq5Fl2dDmo3qEIvr6kfk2ItES
	 dq9YtU4iy3SzzZW9o+V5vBSLNWHPoOsAJWVR4ewaOvUHBYibFQOsoADzlgvkGvDiJz
	 XQT4ZJAmDB2ysPDj+LS3BjiOIC/M5oMMQvFgwdR8=
X-QQ-mid: esmtpgz12t1771898846t75042e3c
X-QQ-Originating-IP: AbaLvVooqE/aIP9HU58kycqEnEw8vz43/Z8waCUGLQM=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 10:07:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5859754316398555003
EX-QQ-RecipientCnt: 15
From: kexinsun <kexinsun@smail.nju.edu.cn>
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
Subject: [PATCH] rds: update outdated comment
Date: Tue, 24 Feb 2026 10:07:20 +0800
Message-Id: <20260224020720.1174-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NDx3ZVsnQVLdeRcqJlgsdUu35W6y2ycEkAr6WvjXd4nMrqOqUfn4q3t2
	qWliTXnccFWMNkZAuiAq+Fh79+kfZFTtk6Rl+7yb5CEs4dIyBTD2UFocbTX45NQIhkXkwJ6
	zxYBK10llxFw7bw/nqB8vwWb+u9ovrQRgo/u/AWgLfV1Bv0rxraZOPZs0QcNjbJllymvX1y
	RuOU/ZpkPxbxuYPMZf0tCgNHuRx2IRTnzVKA+cxdAeWLXlTigzbfnA/Py0elWGdVHgQ7vP0
	6cRpFb+enoWjTrvu3E2KjQwABQiTOyIxA8GpQdsWrxyvQZMUHisb7V/m9WBbpXRtey6Fr8Y
	XRAUkPbkQFGFVkdulwL9P9uFkHnRlLQXJRkvH7l1n9O/68He3zjhqwUdOyfMBukN0KpnRiC
	5JH66gcZVFbmVSamHiRd/2bvK9zqNdIXIAK+bPs0WCXacKgtypMkoaYs0vTe8Rb1Ts4ldnP
	xPll+rDVsYAMjvCAjTwbQ0a/HWJTpyWp2WOeqtvyVIApD9ZksjqI4c52K/hGH7AiZLVO8ik
	LTo98mbHtypD2PZ0AoO6onf4TAf3G780lHlSXxktYI/4VG+ZdffB91ocidJlZSHTB6FDek3
	Uw49t7bd5mVU495/8yYkzureOusiZyIPW709LAZlCs5CiJRiYgpWCTTm+zHvBzUZe+T449D
	WftKswWbHzqVEfYReO/Ck3sXecd+YRNY/Rm4//wLWeMEvA2jVQCSq95Rwm8pBDRqyatjJ+X
	kgP82ODxIS/XOvXn4KQPH2uUFxGZNfcnslnbeZ4p8wA99GX5Ly/wnrmO0IobmxHqG5q9TKl
	/I/629b9jN8r/OLTRW4pGi0o00xdOj/uMh7kKnN49/QQMYXnTs3w5gH+/C5SO9oQ9Hda+f3
	wP5A4C99CN3g2fFfr+4LM10glB/0Q1ch82Vc/HxZgkCx5j/EMUH9vlJcRUicPdJ1UaIdQ2d
	PlUJHC0Hq6irfAg6jQqEH/tSo6vJPcO1npXr51ZuizyeLzHA0t+iatGuCetQWSCIT73O1m4
	G+XisIrucB6QAO8AHzcIpk+aKCajmE90TbL1cYCyqWbz3ckTthXw29K6O+yCqNoEWuAGQzZ
	egvCy3AKkKvNFLPCyC9z4MPr/uuwwd8Tgko5bq2SyAKwk++lrX6PO1xfzDeYxbj6A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17089-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nju.edu.cn:email]
X-Rspamd-Queue-Id: A979D180D5E
X-Rspamd-Action: no action

The function rds_send_reset() was subsumed by rds_send_path_reset()
by commit d769ef81d5b5 ("RDS: Update rds_conn_shutdown to work with
rds_conn_path").  Update the comment accordingly.

Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>
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


