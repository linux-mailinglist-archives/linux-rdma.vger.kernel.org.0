Return-Path: <linux-rdma+bounces-16583-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ax7FtWmhGmI3wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16583-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:19:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F1F3DF6
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B212F3027944
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A549D3EFD09;
	Thu,  5 Feb 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kbs0/JOw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDD283FFB;
	Thu,  5 Feb 2026 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301049; cv=fail; b=deUseXnBZtD5GbYim++gsstYpa227FZgBAUPoH8cwUhy+Qu1lkLYVOZ5Odr2zfGl6yP+rqACpQBi2jG4WHlZYJ4PBwaW7dA9S+tzeOxm5kTGLfKPn/v8k2Y0IUpfL7pdwMyABIR3JXMy/UDb//w0j+qptS9fr0RK0Y/DQ0GH7P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301049; c=relaxed/simple;
	bh=LbOVx5Yh5TL34HuVG3erqqyRyoDtXfAbSpblhud8NB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTDQE6mp1CF0Q+rf/amFZ51VpgwAo1DD+n0U2VyCUPfMqRTMDBAP3OTaLuZ1MmSNLM8J8AX0BXblIXbWx1GjiwRQEJBU0OxZr3jE0aEF1sj/0ky0NIObWJ4RqVJ9EL8OYA9zQv3U2P6TfxB7cxDSdIakm8hhu/PU3ZzdsC0g8y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kbs0/JOw; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLNLxAwhumlE+0i9XnAdFm8Pz1YfADi2YJnoGntZub/LYje46WxIW08+kyieXYtaPPGAMQ/t7Xsvcw8+pggG71waDZzE2XbfFYpYogEaBJluMm+l7hwmUY6QCt88kUyD0uz/l6zpoJVZ74uelMmYxkaTRWzHxOZkojFoNQkR+yeoxrnV4yUnSF2lwZWNBdrpjS5jlMKSFqZmoD6dK2fhKT68vReUWGAc3D2MFwCh4lpkWQpOLYUvYGzVc/ozHAHSzktNTrJAJskmO2TgDq9YYFSLBrOuaIs9QYQf5HwdZWv0T/8iKNUgvxFGAcfovDfdy2rWr5jqtb+D8HcZPgknUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkVONcNgY5WYYfS9KvHzgOZEjvlK0zYwkG1e4J0/bdU=;
 b=NbFzOxbYv4imlnEhk7s36VykmHwAlg9w8FT5IbK5szdUK7Oj/bd24SmMnR0hbMg1H4A/4PuhQRt/+4m1WtQBiNZ1+6/cj+eKLPFspDT2SGLN8pDFPZy5E4Z26B7816e+9VEtySOS8kQHdlPmZpP4mUacMu+whLhNxTb0B7FIz65n9GPDZ28leFBtmjw2Gp3bAqxE/hPQc45hlxSOlHDKIgabPQDMzf6TPFIvgUVkOVlsuWsUF45TBWTwWbeO2JP4nWpyL61lSln1gCZEaqVcqihrOlFcq+j2TTdxxrG1UedgsSZP33kbV8s0iQ2KzDutsb+lLfTQRNKHVVx3KycN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkVONcNgY5WYYfS9KvHzgOZEjvlK0zYwkG1e4J0/bdU=;
 b=kbs0/JOwTmNrwDgxyU44y13JjaN0MRXFuGu/IK6Cs4V15hXriLeXCoFuOpDkYAMdM4vf0p5OWs3U81AjyxJd3ORISY6Pz4sFxILUQR9WRPOO1k41tjAH0tKfYCGuqZL4HyPRPKMDNDFeoN4aLPdsijUmiNOdCJwaqbt9TNxzOu3uLtpBA9kiQ22djtGm8YXMa/JMsZAU5cyJuz8CWiTul9UMjp1jNMBar0CjX9cNEnNzy4boZDQxb4mREMO7JVvDWLynnGVSWoQX/PIR2eOCnuGMLZG42F2Yu2RxUAF5qlO9Xh6Uc8qCL3rK21cn9PaaKpTRXXq+tcig0RmRrCc19g==
Received: from AM0P309CA0016.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::14)
 by AM7PR07MB7010.eurprd07.prod.outlook.com (2603:10a6:20b:1bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 14:17:22 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::e8) by AM0P309CA0016.outlook.office365.com
 (2603:10a6:20b:28f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.9 via Frontend Transport; Thu, 5
 Feb 2026 14:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Thu, 5 Feb 2026 14:17:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 165BC238F7;
	Thu,  5 Feb 2026 16:17:20 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: linyunsheng@huawei.com,
	andrew+netdev@lunn.ch,
	parav@nvidia.com,
	jasowang@redhat.com,
	mst@redhat.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net 2/2] net: hns3/mlx5e: fix CWR handling in drivers to preserve ACE signal
Date: Thu,  5 Feb 2026 15:17:10 +0100
Message-Id: <20260205141710.12609-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205141710.12609-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260205141710.12609-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|AM7PR07MB7010:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 366d14bf-f17f-4c60-4a18-08de64c147a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/Ez5jE2YbQAhU/koQwNeYdasyzRVenamfjzdAKVCpJT2OgaHeuJnvpVervU?=
 =?us-ascii?Q?eCxjL+qift4MEZvESUpi4Oos5RYZO/B3hOUZ3Khc6t3iefHj1wI4DR3tcMPX?=
 =?us-ascii?Q?k6DbP13ImX53vRbBfXSjrTfxAoLJDR1eMrKVfFSSKLNkSIN5p3Id3T9ZT8OQ?=
 =?us-ascii?Q?R7HFQ4oMMLncNJHqaa/FBXoYcLLHG9ZvB3I8IzbdVcktnMrbxvFdSk4VPTjg?=
 =?us-ascii?Q?+RmTW9NZloXNoGsUpOVd02lx/1oV31juOBn0FNS8hDgYoGGqow7MLh2Jc+RE?=
 =?us-ascii?Q?UI8H4UNPHFqrPrhxGC1f32RbrR8nP7hm8Pw7rohsDUmfqq31XeHiWEFiJ8Uf?=
 =?us-ascii?Q?P6SHIdIxRNP+5ecCrqM64JWc12zaIiQtFmZh+mUtqu+bRJhtciHtKEROrWJS?=
 =?us-ascii?Q?I5KkB9G3kfak6VvmWKCfmMJGgPblHu5Fk+iDmv/3pizo53Ay2vaJtkD+g+yV?=
 =?us-ascii?Q?6vBE52lBwoE+wAP3F/eF/rIQkTQY32nZaXSA03GVY6srjOhJRkGLf/6uUeT8?=
 =?us-ascii?Q?6h/6MzFBg1Ts75tHfUb15VFy5j+/yJuCAx87nJcyCdZoYV5UtQb/RbwgybNP?=
 =?us-ascii?Q?zN9+OySdKeJ4PQsAcGIG7cXTHM9YdvxoB5Z5ax6EUuaoSlCQXoCPqPDZAZh/?=
 =?us-ascii?Q?VRrCi5iQ0EsoulSM9ldn+NDE+Gqf52i+7K94/InTTdcQlqdD1TRP2y5nQZ4F?=
 =?us-ascii?Q?Oy2OiEgrO5+frs0PLmRRZwAijYCLji0MinzZitLBrHgPiL36u2WfbPkSNSAO?=
 =?us-ascii?Q?E5motK/YYQYMqbeKXo8Nnt0iKkjmp4DdXx6fDS6tquf9k4++keAQC/x5ne/s?=
 =?us-ascii?Q?EIxAxvXWJJ7X3VlUJLmse9tcO9bs8+qfGAbyyrCThff+66UTpWgRZjmWG0mR?=
 =?us-ascii?Q?XzYpMvECO7DrGI3+rEyg/y79DwcZRq4bLBq3qX80xzxiZyoOxYHKDNvEid8K?=
 =?us-ascii?Q?FEFgDlh9AKhXSzmTEQ85sQhwuB0z0s5/4MB2XAt30vYFJUJQQBmr8v0wNXfi?=
 =?us-ascii?Q?vUDIgw5qsJeB6IFSmgxfUTz5LdMIlyU45dvjigQokvKduJkFCOWv1PCYiRpj?=
 =?us-ascii?Q?YBa0xDRwqbaomv1dVQTSMGfxioi2ZUBVuqD9WPyZaEayj2LpzbRbfsijxgxr?=
 =?us-ascii?Q?mhn3eZ4MmZhEq4MK/z2dcfcHiXj0+sOhqZDWbVRpBdlfe84V+vV7fFHEzsim?=
 =?us-ascii?Q?a9ncjLqXEfVXO9lkrpvdXI5NXPNfqXVKO1NPSgWJQ0SaKXj/4jzoiKDSkgmZ?=
 =?us-ascii?Q?k0Bci9EnYo0cIuTSv2U5Qm7qOqJZFyokqhINd5RoDn1fLJYKh3NJEdd+Qitc?=
 =?us-ascii?Q?uGls005VTcXc9W6VjC+kFP4UaoNWJr2oWPAjLi0x375TFA3xFmZl2+6gL+bX?=
 =?us-ascii?Q?Yq84deG0hVJNg+YgUZQlZGGS2MOw1AMz7ulKU+4Cqx1HUJvcioe13YKclLm6?=
 =?us-ascii?Q?QwWZXbmlZyR/8O0cwpTetF4FOuW2lfj4AgiRIQgSesUYLxg2Np3AMfda2ABX?=
 =?us-ascii?Q?LBNbJ/ZU7FB/daqAdf+BhSW3O6wx5/arAV2r3OTg4wx7TJeCf6R8mUjUOjz5?=
 =?us-ascii?Q?SMY1sMUxwXCZAb2/7sGZXNZuSeIUK/PgSKLMd8li7r8omjO5QGBW1iXPi6BU?=
 =?us-ascii?Q?LHs8E7ttTqccIaGlVhPizdy+hAIg8o86KeBjkeziXCoU2mU6iHB/A8iM9/GH?=
 =?us-ascii?Q?F+/nz/0JLrOmEdN3Vdkhem3VMY4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6jmFp+q2GyTjUYfWNLBihCB7LnGbhvEBwzJzhBnyN0rLIWQMl70LZdEwMkYcOc2EopcOzfKWctoEkgVcYXQRvfz3Q4O91dBee0OnJjXc1b6HoVpOg61fbSQUTeDADDff9YIAiwAQ+H46F50rKYCfV9OgB7+D/LJ/aRE8o/INLIx2NOZgOakJ+Knf0GURFsJ4wti07oHqsoW480WsfGieUQHDnOvO+9GeF20ibKAIlzOFzIZhSNctiCkAPVCjPZ+qK7Ag0MPrZXMOu4yKzIZx1CnsGu6YQ0AW+Hz4eV+zvs2BtbqA/qxt8WUlY59lDNAX8FF8Cg9DYcYa8KAV38VN3v5afsYDgr/adNuR82WlMLcYwxWnvXnY3vKf2Mgs8oHfgAfMuyEjlMA+Kf/wGjSvXYg1oZxn7vFZNkE2JGsd9acov/h9Lk9Qy4wtUkjh71r6
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:17:22.5395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366d14bf-f17f-4c60-4a18-08de64c147a0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB7010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16583-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C28F1F3DF6
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, hns3 and mlx5 Rx paths use SKB_GSO_TCP_ECN flag when a TCP
segment with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN
is only valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168
ECN offload to clear the CWR flag. As a result, incoming TCP segments
lose their ACE signal integrity required for AccECN (RFC9768),
especially when the packet is forwarded and later re-segmented by GSO.

Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
not clear the CWR flag, therefore preserving the ACE signal.

Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO process")
Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7a9573dcab74..32993652efa2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3899,7 +3899,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
 
 	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 	if (th->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 
 	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1f6930c77437..a2ab97d721d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1307,7 +1307,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
@@ -1328,7 +1328,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
 	skb->csum_offset = offsetof(struct tcphdr, check);
 
 	if (tcp->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 
 static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
-- 
2.34.1


