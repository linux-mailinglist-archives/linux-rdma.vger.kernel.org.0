Return-Path: <linux-rdma+bounces-22868-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6h+cI0qNTWoc2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-22868-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 01:35:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B97AF7206EC
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 01:35:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=BnhjEmXP;
	dmarc=pass (policy=reject) header.from=oracle.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22868-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22868-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BF443009F12
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 23:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B2379C32;
	Tue,  7 Jul 2026 23:35:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CC329C6D;
	Tue,  7 Jul 2026 23:35:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467327; cv=none; b=ug4KGN3c1dS2V5EjKHxiIKAJWiJGAUb1S9YAWRAD/3iriEiYtiIghl+a4inlYKFq85/TTC3iVAXvszYxHF2tlpwTszWajT+AIEotMMdB4ecxLT7FbFw0AeZ0haJLZfosNqiFD6jiRL3i1RzXoWhjOSMz55htACoyBwI5XHhVMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467327; c=relaxed/simple;
	bh=bIH2CqlB8Srl7aKBQXLAj7Q1MF7wYMAjLpbQT1UEK5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnoYL1NJU53ql3q5Kbj0BakPF9cmiuVPfdaXrlklE4K2AvobgFyMcfoOEksjeGbsP3/Pe76e44i1Zsl3fKC3BxKQmdTnWA7wuC8CXMbVWfFD6CvYgbDS/8flhc9Jr1kX9E/DCunrKZorsvepQOhJfD9lpYTWvz6cPPbYyjS4Chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BnhjEmXP; arc=none smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667JBawH1634982;
	Tue, 7 Jul 2026 23:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=XXcm5
	+cu/Q9i2/PTx3ezB3Xqg+Mx56nxnywyJSiVBrk=; b=BnhjEmXPJ7+/xtjs27VL6
	kr6IzOwl/gVvyEKOjC/4QXGVP9yCUj4B4lAiuhcGedxe16pspKs6yStRwW4H9w5d
	FRHCZRGcYY0xYJKnaJcmh06Ps8ebUdlHP5Brw/dSONjCL+/bYe//PhSssSp+1nFN
	nhYnoXF6wEioMTje4IowGdaL2MJPtBjM8QQAXLvohEGcXfV2C5oZWquLUYCjQRsi
	BUuJmBvTBvCZlXDjHFzKLVhzGD8FwmM/OFarguc+MBxV6Z83oKqghnkqOZ5k/oxU
	z5ea6RHKJN526enQA5VxqrZnw7y8nuYvtlGJAxFGHGV7dA6c4xp9J5p0xO5M/8cl
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6t7cpq57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jul 2026 23:35:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 667NX8IH027441;
	Tue, 7 Jul 2026 23:35:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f8wuxvg1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jul 2026 23:35:14 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 667NZD68032808;
	Tue, 7 Jul 2026 23:35:13 GMT
Received: from mbpatil-ws.osdevelopmeniad.oraclevcn.com (mbpatil-ol10-ws.webad1iad.osdevelopmeniad.oraclevcn.com [100.100.228.95])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4f8wuxvg12-1;
	Tue, 07 Jul 2026 23:35:13 +0000 (GMT)
From: Manjunath Patil <manjunath.b.patil@oracle.com>
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org
Cc: Manjunath Patil <manjunath.b.patil@oracle.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5e: Use sender devcom for MPV master-up
Date: Tue,  7 Jul 2026 16:35:12 -0700
Message-ID: <20260707233512.3650406-1-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
References: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxlogscore=889 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607070231
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMSBTYWx0ZWRfX/V8CrlYbggAR
 fc7vXNkvCVCe7xAIL5kpUl+XlelEu3IreC7oT8eVZYvgbF3V5KrTsaHqW2nRJOoJFbGq7YFxFwU
 N+kT9/rtgFTh9cFMyxClQo30MEB1BrkHXgVu4f/sYVD3+ImN4Q6jiEWRy3KAjN3Ll8mqa+8WbN/
 zyxjnDKaf+awSAcAqN+aeFnRbL76WyzLApqS7PiGZbUp7iAQ/L9QA5GkGk3anzKe/H85RM3ZqqZ
 ifpfuDqm2hxPLW2rf49PH5mreBBdheTsouq61YnaN43t7QXN+M9M4NMFDBQ2KAwmdErOXhzjV7u
 VV5A2EIDW/HcH+WBGhg5JlSA3zEbzuBBUVUznG7AHDnzT1pSMIHgOkqGfjMoM7JRMw4z78bJC/g
 RmoEsvGD7tIHw6RAif7Fw9Q+vIhDKIi/V6mOgnuNBB5qyZfrcy1K+zpC3k5JIhKgJTY1Wc9y57b
 wgk0ZhtwNIw3coWp//Q==
X-Authority-Analysis: v=2.4 cv=P+QKQCAu c=1 sm=1 tr=0 ts=6a4d8d33 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=AMRCNjAxEI7RdWKJrAQA:9
 a=w8a1T8f1T5UA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: 2Fokue6usvQR9RJ89X6QdduGrckf_tb_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMSBTYWx0ZWRfX1fSt9fOuUpvx
 Jmb3E0yPOXgCF4raJqbrXnxharhoCO4/OqxAUc1lekxPoyVKuAoLuGPRaQV/c1TPXlyR5K934s8
 PizCeeeaK1NC5URVwyJ5yg92cx8tEpo/jOWhIza/294tOb/w46xz
X-Proofpoint-ORIG-GUID: 2Fokue6usvQR9RJ89X6QdduGrckf_tb_
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22868-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:netdev@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:from_mime,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B97AF7206EC

I sent v2 with the defensive master_priv/master_priv->devcom check
dropped as suggested:

  Message-ID: <20260707233337.3650025-1-manjunath.b.patil@oracle.com>

Please proceed with v2.

Thanks,
Manjunath

