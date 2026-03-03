Return-Path: <linux-rdma+bounces-17440-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK7EK08/p2kNgAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17440-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 21:06:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 182AD1F6995
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 21:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9472530817F6
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7790374E71;
	Tue,  3 Mar 2026 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNQQtw3X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C686386575
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568295; cv=fail; b=ibQRIaC/pzQmmzrl3PLTp7rRj1J2dSBuR5SMJRX+fsCL/8jX77YSakUJCSecVDuj/0uymalz+nIfXdgboJv+q3G7cnVWF6gZ5FJhCnQ7R0Awbyb10Iq+p3rW54iumu0iMVjHV9jFpwbjW7rkJ3X5uGRCuTmHelksazuulxDME14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568295; c=relaxed/simple;
	bh=DuSno1RMkd/GQKS2VF2VR2JUC6zIAjrsqzunUo77Xts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MgU+M9dY0fBsCJ01tmRNoaLoLwINTdPmLS16RBFuAWrYG+Mw43cl9Q2oQUumvLAJtDd1rr7LzayEOUMRfUa1t04WNpS+bI3Fl4XoprM6yUkIuzUau3jaCsl8MdYJfPMq5ZYc7aVe8X8hyKIGle06mVuo9NKX9WoqdU7NKIMIOwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tNQQtw3X; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGb8XU7lrwcghUoyrJF0zCQiHRgiY81toa3Kg3DNeAoPBFWbn2ZyAiwYefVzuiUmnl8U0TK+TRJw0l24b2Jj7Ym+S0zodfBoJVE127OYi9Ejo6u/bXE1OVXVT/z/pZ1fzVSN8JMbEb5fPEzyWlbvab4m72GWRkysVYLYQ7gnv0Lqz2PL5dhh7XXeyD65GqJJfuy8fDGK8/l2qR8A3yRQbEfTCPHy46vKLtftUGyXReX8toGoNoJ9GWRfb08S05JWN+4cAOlPAiqLhDHk9XQztj/tEw8fDSkblIWdABKob3wIDK5tPyb5V3CopVVfc90j0jGvuPyYwbZeCDi0qth0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1RncbuCeN4eYS8YRmtmbYdUkWksMZU04tCz4eJnLwk=;
 b=cc1sKYICY7PxeY0xwW+Xhv2psfcYGUXe25bgNTmSGSre/Lkt4Kr+wnxxJHqvGZWXt0FUDVUSQjxvxIEWFpm2Ko5mTVZvunCAZ7Sk7wpPCGORlhro/WSPRODdL2NfaAPKtlDaKu3oSMmzJICn6nkVCZk+9dzP4aMzKXvRJZNd9RB4laM/SOmHW9p6k/R9+JpSkLUh6fB3Kz7Ib5NH2pEWihoHR5O4J818qrU0arm6u+WR42RY9FYn9Qytlx6qc4Q8W73c4nW6Q8nU6Y2uYL9I7fv/mdSRnhHg4M5qsZWEd9dERAdJjoIhVq+6hrkWencrSzwQNaSDyHjqA861i5id2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1RncbuCeN4eYS8YRmtmbYdUkWksMZU04tCz4eJnLwk=;
 b=tNQQtw3XyIvDWOoOwWRD2pfdc2FlkMrXB4Cnpj2D+6EeVQs8T+DBw8DUkfWcHVcAnfGG1O6ALaX8uznRddbdFvmrAGQt5VyiLxiY9z6Z33CyxiqDSoPb7r16Wx0ulKPN0BK4s9lxxkye6jnK59UrNMnOwq+a4/v1SjqWHHtxH0p+W+gMCH+9vnIyCNmYOJGIRcnamdNoa7CtDKlVBxEewSV5hHzkg6E8CJFFilhq2LMThS4CyWvvMdXZegxQjqsEoDVlaAOqW8+hy0SvVgnTstNaNHRa+qOP2Eme9m7n623fOiT8uShKH7ks4nKonlPVW3rZELza1oGr2nq/wqG6JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:04:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 20:04:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 10/13] RDMA/bnxt_re: Add missing comp_mask validation
Date: Tue,  3 Mar 2026 15:50:07 -0400
Message-ID: <10-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f1058c-b1fd-4fee-932d-08de79602117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	N9nd6Xx7vVOBjn91o2Af6Gc22/4MX9QZU4FC9bKJg29V2UzkopXre/eIu8Bdgdj7ha2yW5Xm0jBcsqQ0pywRnc85dMXMaWjNzgrASLF9NmnkgF5p2qGNauMLbPveGwlcUFzqPbQZPUZ5GZbX3dMZ7GHEliL7nYilMoB7Ztjao9tE8CzhhRlITZ9HgjJ8NejEQTf/gE7gk9F+HoowHnO5OajDJ6fkR0zPWFHno/0FxApfTpx1XetFAyZQGwB8BYePnX3+U4B7xofLBA7ITgSauRseKs7egRV8VnBsnwCSt0G3ymRBjISCBVjtt7bdG9effHhvtVT1QUy6fQp6vPDhcq1ZabU4E0dFexlgDAIqlkk1vcg+rMK4M5FqNyZhTU8OsoAB/kYdYL/iCJ5J1Ih9v7suUlxd4SSkE19T4dyX6pxvQxV6sD8BFrmwN2/qqH83kKq5SCmCye6u/ii2PRmNLGdbVCB4zgNG9HaBO5MsDDDGRvS7YrcWzyfaT5S0/8/Vspvwrn51aYmvxertbrH1TtNuEIpjHsroXC35xH3I/eddF//9g5Rn2cVluROmRI4muu7KCIGQnyoEckV/jnXZgEoJ0FsGFRaGcpcdAfNx0N9WcgylN21SMngJOK1DeFcIsfExwoxaPd8Y3NxufJ/5Zq2Cah1NfsoVoe5GtI3VuDlbJX0dnL1WBgHc2H2BB7qUOFwgyHkICDkIVa71Bg+OGzf6nzY1hHlP9rrGavlj+cg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rbhSchc2K5MYc69SDXYbTXdw/FxLNvpAgx41NITh4Z3vHWE3uVUlxOiGc5gv?=
 =?us-ascii?Q?9ROXYQop7o5V3glVyRtOVRWJpGx9myHZXw/mjXQiUcWhq0wcNiqd6w//+HFP?=
 =?us-ascii?Q?hCHywhtK+iF5FUulkfvgxO53zcciPVBIAsxUsKaVQ0l+gryOJFiGfDyUi7Fx?=
 =?us-ascii?Q?2eJaHVlidN1jKm9vcRGAF8hBZoZlihfiSu3RF3fCeFSr5SkNDUtmDg6yyysK?=
 =?us-ascii?Q?ikugbUMFnHdkfTrdKman1VmqCVgcucWe+LkRkKFr5f9auiUc0ilOIfWIBOpa?=
 =?us-ascii?Q?H6vF08G9QFPkYv5+Vhj533Le/BQ6cen7Uh3MfYNEiBdfgT6lDQ3+P8g5JveZ?=
 =?us-ascii?Q?EKTBX3aaHjgJ+O8jPe3c3NOLfeXU4IHXzql4pKBSP1o1RHPGwmJ+ftVO9X5F?=
 =?us-ascii?Q?WDUISl93017Zyq8sDFBRvXC5wT7uvmmiyTh7/bZdHyTj6GYYjG62PNcIx3WP?=
 =?us-ascii?Q?KJcHH8WK4neng8uL2Ac/Al0RKpLb4A5h169hMGNJdoXxjucEJfoAVgMawHZs?=
 =?us-ascii?Q?tbJ4DGh+Yy5SpDzMzYlm1j0hgHyZnZ0AMe7hmtyEBbcLKZIC7zPgq2bXx2Jh?=
 =?us-ascii?Q?VXfxHyYd4od9E16iVhPkKsOz2FY4wzFN6PU3YHphNyEPOYYzU3WHTYBDBSpa?=
 =?us-ascii?Q?Nb7OpYPdPr1sUAOnSqY+a6qlbVGlGLoddsiLyzAaivH8Ni53yBHPoxF41QOo?=
 =?us-ascii?Q?6KGwCodEsGTI51K0pIgaFS3pGc6gfhVxDWB4T6vhqtVB8teI3DzOFwBmDuQy?=
 =?us-ascii?Q?meV/FchC+CAaWh2fNPVWpbl3tIKkEZ9RTXm6tXEQARKjxanNKOaHll7NymJm?=
 =?us-ascii?Q?aUInkCnOW5KFtB15At//XvDDmLmOSy09MtzZNdUQXEmO5tFwXazQbweymPGJ?=
 =?us-ascii?Q?Ki8mHmfOG3zBYyJC6vqWrTaMfazI+R1QAnZqZMbvtrGVIKC92u1cb2TzgEKM?=
 =?us-ascii?Q?whuGWUVMOSOyoHSVm2FzQWBWym68ikULXMb4nKdI4OLQW1mL1ABUDZKJu6kU?=
 =?us-ascii?Q?icUo+bupGqs4yJqPVN60bQFXsHjGCoAwTfjJKXaMogryU469q24RUq9E5EoG?=
 =?us-ascii?Q?GoNi3d8Vc64le8TOS5aT6fzDbp9YN7JRoUSRGnudnAKLabRjQWvs8zOELbw0?=
 =?us-ascii?Q?s12mPyxoBKUHWita6q/CB0RW5bwYiouwKIb2aLB1hu0+GRMoPBjSaTAjJown?=
 =?us-ascii?Q?fuUFfA/LlLs9GYePzuTrI1WG3iI237n6Okft4mQuaDkSKfJ9CIPa0IZN/Be5?=
 =?us-ascii?Q?6rc4X5xvnqgZDlSQre+4IM82qZtwlIGwxgE7TPoxZ28SjjflJRR0md7CcuAA?=
 =?us-ascii?Q?cO5ci8hmAJ9rPMRPOf7fKY1R3vaWIy+jIfV8QefSpkGXKua2OUxO+D2vAcJs?=
 =?us-ascii?Q?HIC7LPKPLxw/GhpNfQtvrM85Jja11FTK+tSUbc3Gp1PLEx3t1BMo+5QdAHhq?=
 =?us-ascii?Q?THX3KR1ce6hIBNgqWpvYXUJoQSJdiQhhQN801HPCYVYUrUfBm5GNevpyNcbG?=
 =?us-ascii?Q?u0FaoSEomn9X1jxP5Y6NIm7XJVGjh/WV6mORnxH98qqbAuqduXMKRbCeV5Fm?=
 =?us-ascii?Q?K1+XYlGCZZlCPh3rob5ncWaddq2E3O/O4IbHLzVNB7CUe7xuLC9lERWFTDHG?=
 =?us-ascii?Q?KzN0M5ZmzGz3nPuXfoKL1E3WMPYgA9pluPNxpc7iSfGXk2ETV3SpNOj21fvO?=
 =?us-ascii?Q?sdai9m/wHMxQRwNv3cz6XUuNA+96nWkUDyu8m9V01kWdm96IdQTp3BONcWpA?=
 =?us-ascii?Q?p1jSiX5sQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f1058c-b1fd-4fee-932d-08de79602117
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:04:51.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFUPassOhmDNpJCgaohorreeDMVp+IbRMpjXjxOXLYuomlSUOumCYAJ5kBl6fSuC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
X-Rspamd-Queue-Id: 182AD1F6995
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17440-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,broadcom.com:email]
X-Rspamd-Action: no action

Two existing req driver data structures have comp_mask but nothing
checks them for valid contents. Add the missing checks.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 6d751febb28c8b..412b99658d9073 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1693,7 +1693,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
-		rc = ib_copy_validate_udata_in(udata, ureq, qp_handle);
+		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
 		if (rc)
 			return rc;
 	}
@@ -4471,7 +4471,10 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED;
 
 	if (udata->inlen) {
-		rc = ib_copy_validate_udata_in(udata, ureq, comp_mask);
+		rc = ib_copy_validate_udata_in_cm(
+			udata, ureq, comp_mask,
+			BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT |
+				BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT);
 		if (rc)
 			goto cfail;
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
-- 
2.43.0


