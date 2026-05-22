Return-Path: <linux-rdma+bounces-21169-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CvuAd3lEGqOfAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21169-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 01:25:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E665BB74A
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 01:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 846B43007F66
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB33876C1;
	Fri, 22 May 2026 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t6qQbYAu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1B22157B;
	Fri, 22 May 2026 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492309; cv=fail; b=GEwojgD48CnAebjYT4qGxCIRdH271ITHkZS6BM/9TKLFINGH2nihYS8qqDF5N0WRKPB76m3skHzbJ0KS7sT2coVXMiAYTZ7FngVdrF4c2+8i4PhcD/R965dkYEYEwaT3rUJCV5Sq2QLyZw1L+xiB3nFwDi7HY9kZF3VpR3CdJfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492309; c=relaxed/simple;
	bh=M1NKzTlT9USo8X1bNCQKJtSpNZ7s83wL14WLxp1BZlg=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=k93HYZ2vMYBYo88ponizUUMzKApyVjx0qJwoKJFfwXef8+GAsUrbg1GXwS3SiUx19HkeozBIxq6jHoVWrz9RGH6hPaU2ULH0Hy60YnOQTblsTTbrUMI/LaRu1VRA5yEcVJJj8VgubStNQMzeR9AlXsINxfzJy/xIPBZlrCvWtqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t6qQbYAu; arc=fail smtp.client-ip=40.107.209.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFQ6gzX8d8mAi/RCZaw9NmDrve01n8RfIXx0cCgdE3L4TZco+eJLNHUU6ZjKKZQ4aXR4hJQuRUAWAwgmvUxmMMH+SB7MX/nJ7VxUzxHR6YW+NqoSkH8E+HWJt7FU6V776lXZ7tCnmVXt0uDyrVbUJuZPav4Lb9NWK0s6Qoid3tboSzvPEzjGjK0UIv0VnLATtp5m0ycbfxHvX+OrkE9ls3OxbwSum726/whTxdtcoVBs24hMmsM7Jxbb+s08QfOVwFuAiO1zgXZqZCZjwzNxofTn5arV5vXqXzpQbVOvkU/edJlwqHWTwFX+ZRfHQqirDXre4POF+lKxYq9kWXhAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvNc+vwWD1AjIj6DjEf8OS8L4fq/8wNw8sUnEwm1nSk=;
 b=X/nWHyiGfI0gs8YzLB4PQXbhwtQyZQar0T9h4/tP8palif5esDpJKD+gV7BTW/pm5TVycCE9xjqcgWwa277om26pcc88r+bMCPGlz5AMk7Ha3yS+HCjWODuDk5OEeEccvn9iDPe95Cy8W1Mj4yp0sLWwA31NACJhdVHrDupHd6Vnm3l3jHc0hPpxuiiI2zQF6ms6Wy4eZ9popE041/XidQT4wI3h8SZTGmaye0K43Kw4DVYiBGrCbrXaYbSGxLVXuMwgPo6YKqMyW6uAMu3SBbomLs0OWtEULphOtaLrE88WcUG8udPkOPcFPQv3FcebdXT414rNG9sGmEuycMocrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvNc+vwWD1AjIj6DjEf8OS8L4fq/8wNw8sUnEwm1nSk=;
 b=t6qQbYAuugRTdup49D0zJQMWeMwYC51PqZBy+dr8YnKRtyapTEEQjHppbLW9/YKUspAAoJeHuFoRPY7EH2/LLr0VOLs2ALndljnuv90uhv4h3+C5AJLjxe0WuHct6T1FgZRtJrI66pz0sSD8CVyq6fR8OcIPsibFNegPF01GQ2Wn1Gk1xAFCQMGhAnTbb4Hpg5dfYYMi/nzaRdGqRExui8VIpD0pfcQD+TT1i3VjaMdYsfI9DwXD9Seyq0kZhjNQNcs2IM0Ctok2H02wP6Dd6PCXZ1m+4OO1li+V1uLmlQ9MZLgPP2VCg0z20cb7kRaoxVpJOqBewBmcMF9QBDvq2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 23:25:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 23:25:03 +0000
Date: Fri, 22 May 2026 20:25:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [GIT PULL] Please pull FWCTL subsystem changes
Message-ID: <20260522232501.GA1168039@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrweTSVcj2CEpzrR"
Content-Disposition: inline
X-ClientProxiedBy: YT4PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b3c7e9-bdcc-410b-7809-08deb85959e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4VS1bPRYJx1i0ZynFxGiENNL6t/417tdZ3d4TxxJZoeBOwy01GcUnlTkHRoyjAEquF/JZQUb4EvkYvOjMRie+frFL8oq7vuDUJYCF0KDpVt2YeLp/8ZGWQxyTMIuCjgp9V9UDM1pEUA1LV4E3Rp27TLM/AOMpqQmp6LoKOzB0xebO+OvrOFsDHadtGKHByWuR51jzHKxZuUWMjwiJlHsg0OE4eCRv7/kk280TBsdkOKi5/ye8z1Ul18pYexiKbm1EW6otUCdIXBtHQfS//wecjRBMw9vj+dTwOhUurWXAverwg/MQ/OafFt4DDpjlvG88i+0nbC+td8d/q/+2gvfzn+ZgnwU9WUC+u1XpxUzlyVkozarl5YmLLH3RkVg7EPjEq014ozQf4YST8IKeZayZ1NELRrT+ku8LPBHe/BYqnQ0lL5BBwd+wRTDbjsHFUjnrtPafA6gFG6NdFhT9JBA31u9z4ggKduwL8REMC6pmDAZWAPOpOMCxjdjQGoYooZAMNjRWopy7gSUnSRjaS8yjDSQ924Xwm25eJMoA4nHXbacuobkRIT+jZRYHRVG6ugP8FrRpZ1xSxrfYkntaAfV+iZR7nhtn/YWibQhCuruU7QjMNEI6/MvejmUEk28atlB30j7bX0lQQa7JBXRfmZhZc0VePNVS1OVNqCRobDWD9OeUjObKT24BJ8NHscf7q+v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y7KtJ9smbeB/dp5pVJe7FN3KE/NnaNo3uD8x/r7ZnZ+vTGwCZ0XS1qTtWX0W?=
 =?us-ascii?Q?Bo1n1f7rXsQlMrTUaP5Y6p0qumu+cOjebRTlQ2CX0YBeHnbjyrRCn9Mm/o0V?=
 =?us-ascii?Q?1mF0lQuJqR+vS2xBtyPS4QuBSomMSP1FxKiReHH/H6GxkbGtY+nEitBow0eT?=
 =?us-ascii?Q?A7cPrBORDfLVRLlI3AcxmljSKQVfs/9CWbTU6t5/P0/3LchQTDF9wfJH8LH7?=
 =?us-ascii?Q?SkCO+kyZR2/wpsCF+gwhMx2RkSQvyiuJ7spAeDhBZ7JlWaRwMdXdjCbpZE24?=
 =?us-ascii?Q?PfBwFPhEkW/xHrPbJiVS0lXK0ax8r5t5UaEFHzr7/XoKDVyPYyEVoKENt8SR?=
 =?us-ascii?Q?zXZQrE1G1wG8U/Zokcm/5UnC81aYCT+vIhl5SUbm7uhpFieuJa0PWb1l2PLx?=
 =?us-ascii?Q?PI7nIf5j9aWTUq4wU1wkGQ191HQaVCFmJiAjXNI19PuXgnzfq8ji7Y0/Qi5W?=
 =?us-ascii?Q?n6nn1X1zN8GkArmKeVVmhondkjIjYYCccxatcD2zb5Jo0xNj9QyDnHYSRHU/?=
 =?us-ascii?Q?KYg1P0zHt08bK0VZjGbz4OvB7OE4Ys/iWHXv+0DR6aeau9gwFYg28Wl4CGCa?=
 =?us-ascii?Q?HtETFdAs27nq/ViAAQCFXu74Ed3SLJWCM3t3WO7yQhZ2s2tLYcj8HeRA0dQ9?=
 =?us-ascii?Q?TTRunsWwvO6sguVf9xG5qRf9ATAO3DJXLZ+uFzjWiyfrstllZFt960fCdR1E?=
 =?us-ascii?Q?LVb3K8jdQ6YV8acFMefrrY8ld58M3asv+0ck/d7trlF0AfRLfJ6gUgQhlBbo?=
 =?us-ascii?Q?/KY31mEcq9xZgqBpRhbjJVyMGeCYN0hSSg9QaR6V94DUeSbPGhi+DP+P1Qex?=
 =?us-ascii?Q?5+8sjRokT2avCIEh2oO1Y9CN9lclYIyhZtiG7kcZKU/Qv6jcpp+NQR2NsmrL?=
 =?us-ascii?Q?Ry3iuGnk4epn2fTq4PUoMt8Txj5b2sytVQQKpUkaRPAPTRRCnSWstXuw2Ayd?=
 =?us-ascii?Q?8ZuWLVNndAuPENSDmlirkRT0ddr8tGRdMZ53WQtJwuuScFKnNPThMxKH4g50?=
 =?us-ascii?Q?nlmOlFD2B2qZE7gmf5ncVwSEodfAszketsNWL8NWJss0BKBbVk5aRQda9r2m?=
 =?us-ascii?Q?cSs0oVvSIhhltCciQohWs8DhaJHG6xDgpPohE0fW47EcqNMAvPC94CBi+pX9?=
 =?us-ascii?Q?5YnBlpOTmzPN4O7btfduHoiXyCWCcXRhAOeQoYWMdzzMYssCB0BcBeplemjU?=
 =?us-ascii?Q?YxIHmlH88bk9Gumckwpfbz5L2L2r5nZ3f8u1azFxCHnXMcIZgFeDvMwQFlkX?=
 =?us-ascii?Q?wtM8exaYmGvMNW0j2z1hfq/+oSXk2x6Z+BmDJ1ScTo1eSHH6NN30YGhMoI8X?=
 =?us-ascii?Q?ZpxCodbvdHi4W/K6JS0gVaNJnoQN4VEtFd5aw8fL1VdNEO/QeW3tmYcP7aKh?=
 =?us-ascii?Q?PWMNyrKrMC49ddrHdAmHSWx6Vkl1ZKhjvabvoj+5pvM2w3TaX3aA3gmGqLqZ?=
 =?us-ascii?Q?oBENlNpV0jTOPhqU8ZUBYUNHMkNko7juLPIzuYDKjejkfKMnLsSzJuGYV1Dk?=
 =?us-ascii?Q?619W4ZYohIIhYDwvCrFyRfwbIVH16ax/3MC9uV6/KOYS8klYoiAzh0Pxynmy?=
 =?us-ascii?Q?TX5D2si9CISMSVv7ZaoGuf2TLLDQ+FrpCyO909TdOH+UuHBnP0pYtDWCNbYs?=
 =?us-ascii?Q?fe4/yONlUxeNK0AayD15RgevYpji86zZhrLvQQU2vmDRSkyPQr+HZgocgDkG?=
 =?us-ascii?Q?ixEStt2LfEKsZ321G1lRRh18/QYTycSMkynw3ZOJJC57373N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b3c7e9-bdcc-410b-7809-08deb85959e4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 23:25:03.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YW1XaftjNF5hs09Q9Ddw4fKjfmtXU5ZzNhfM+c0tbFqxaIdbcJV5DHJPjVxpLQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21169-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 55E665BB74A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--vrweTSVcj2CEpzrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

One fairly bad bug for PDS

Thanks,
Jason

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-linus-fwctl

for you to fetch changes up to e7537735028c3ad4b0bfc02ff8fa2a1a28aa04fe:

  fwctl: pds: Validate RPC input size before parsing (2026-05-19 10:44:32 -0300)

----------------------------------------------------------------
fwctl 7.1 first rc pull request

- Buffer overflow due to missing input validation in pds

----------------------------------------------------------------
Heechan Kang (1):
      fwctl: pds: Validate RPC input size before parsing

 drivers/fwctl/pds/main.c | 3 +++
 1 file changed, 3 insertions(+)

--vrweTSVcj2CEpzrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCahDlzAAKCRCFwuHvBreF
YYpfAQDjRu2WSx/ej/hVxC/80uqDc3ppTgBOytrcLfWMUBgSNAEAizC9nHXJtUaN
CtZtlm07Cyoq/kGDOfAs/svsozucqQ8=
=xduo
-----END PGP SIGNATURE-----

--vrweTSVcj2CEpzrR--

