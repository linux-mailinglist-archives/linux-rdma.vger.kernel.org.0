Return-Path: <linux-rdma+bounces-21719-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c1LzKdHUIGos8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21719-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E946163C323
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SIxZ+xwn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21719-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21719-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6CE430277E2
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C85261B9C;
	Thu,  4 Jun 2026 01:27:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419E25B098
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:27:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536479; cv=fail; b=i5gzGrpZdzThcuzuz+dYnJgljj+mrY9OTSYxexfcBaUy7UW5XMq0fY5lau8QQEq68SZL83CBt2UNJh9JS6lkytxudALbhM9E+mLU4d9TKpGO2tO5baZ6DN23cmls26Rg3bP8r9dwkmSgdUw4rhKdziSvHVn8xCmEMvGMA7UnY7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536479; c=relaxed/simple;
	bh=T2Y8gwfqz6EQ1bZHXrt5+flIJ/dFqU9Dhx8gbCQniUY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H+6cvcwLb7j+KgWFG4CWqaDjLvw/VYs77TvnAI1eDZjBauCYjLgXWqik8f186BpCiCwUeIrnIFwgmXc//f+Vd6R6sX4eS4LdWzRngWG4p5zQKVreD56nfslAk6L8ueft1AfwV7WoR46+OlixPFdsXvjAwnNhWvZi7f3qB4Yp8rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SIxZ+xwn; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSJeLA1oU/j0W4sLdD2udzBkd3Nu24kFyjdlUT7xFPsFuY20pHHP00gryAwtjGYqZ20AJH3oFTVZROz4AkNJq4ORQo7KHLw8SHc3z31S4nyhJmHm2l9rzGFN0GfQfz5FauA3tnkZF5ArzcLi0lOCQyhsTmr8W1NC9DuF2QKW6QwPsqzmpjb7ymLI2jzqhiuSR72Mpi4er0hNEyU8tRaPEziszUT5tgdPwSjwyyPdzh1ByUL0vK3Z9fwPreo7XBJsiyNKPWqBQb5nlTvMwdxloMQ3+VLbtFnrIF7Q3yB1M2cpfCNi89HYfCD02w+tpnFRvMpYwq3ppb3iH4yBgUmXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDCPco2J+1fhPxqS6+ou5+CprFvxJU++36+VtRBbCJY=;
 b=NbgPPmWi0U+4JxmeWR4pHpKHQh50FIYz/UBsPr3mtCs2VrJCflOjyUUDDvB0rNo+BO8g/w2pNXL3jjMgR65D8UlvR+2DfwN0VcHup2mSFUxX354JM5q9KZi2g7nfW6yvubfhRqiXrtIG0dbFwBn7lsKuga4daTX0I+vXiR2SssPQBj2t8jzqouaJCs/6tnPLxSkpVanBKpLmiXZIrgjWXBY16QZGsvQl7LExrkzK07Y3PJgkwIqhdfkxsM6Zk7eqr2IEodX5bKujSoGiys71NYUXSqQwJsbCTpWfGeLMVn7algSMtspgF298M3uXBsUzD9w2FXclrEJj3bWWliqyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDCPco2J+1fhPxqS6+ou5+CprFvxJU++36+VtRBbCJY=;
 b=SIxZ+xwnLXWEHl3UErfqolL4+JPJNVyI40MVPGYGi83dAbeRZPVWciD5ymsWoaurUIverR0fmRNX00doFsk6iXIDepEeZpFaM4r4kGGvW9cAQfRwxUIop6aoDTaMBkR12frSQchUMmEXw3kPezku05Cavbysggdlz6R83+3iNynvsXH7r0Ay+iBNWGKg3Vi/fZn3Z63rozFq4bYONRX+7vdYUn2hgeb0DvIQ+l8AFAi0V9f1Xsc9aozzhIQhT6LZ/R2IJ/U/cFOXNBfPqYzTlvPLT9TIScgQCP1pdIInQT62XVbq/gtX7XFGgaQ7FHyYUG16fbuffiVzFstmeOgGFw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>,
	patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 00/10] Fix races around IB_MR_REREG_PD and mr->pd
Date: Wed,  3 Jun 2026 22:27:39 -0300
Message-ID: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: bfaf53b0-e50d-47b4-601d-08dec1d87e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|6133799003|18002099003|56012099006|11063799006|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	DafYxwwSOg4EyBQj8ERkhoZJ3MRe07Zz/YJbCy5Bji/vbhShllOiYwtZSpOBRaiHapBcCs49E9IugVWxK0eoE6kMqwheaTJzB3pGlwO2Xj1yxX4QT1aY5yImgKgAZJIq6Y8kzj2otNXBRO7iB8mMgyr/uw9pftgegWpv+/kgQ3Y5EHhu/ZXDtYtYr9tvldDHATD/28tL27YkblRgWmA+OcIZwddbdzvOavAnM3CnJswhZqeIKb8tQ1xNCV2AcoTYcXq02xUoa2zImK9st/8wTesT+AcZ7uJuehCBUuvlpcoto1//ESKWXW87I3cCepqMPowHUvTBbNnrG0y3dvvb/OCr7qdfXGzXlSeg82mXGEzqAGuwvnw29YB0PbQ0VCxy9hJvv3t0PFY1hAZZnqrfVTaRyPmwdwder2Zi8HLkNFEEvt15J91ZUphziSmUfrXez5ScwBkanLplnJoKOjpofn4c9T2nMKF+bRZP72If4F6HBLRMjfUxMKlpSRdSzhUBkyJ3mFBGxXf03XsPaecBUnw5vWJ1UZ5o07d1XId16vNOxI4h0LqTpWplB79egXJjNYSNmikGhj+Qznpq66kpOE5VB3nqT8Wix6mQXeVA0ifxPw+EReQXEDDze4MZmNAB5FGFqbsmBaSNyhkUskD5FtU8TCOrLn82fSV+L2EDceYHxqPMiR1f3Ie1z/AgIUJq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(18002099003)(56012099006)(11063799006)(5023799004)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2WPafIkXIsiJFxh1094SFKabYM17Zjx2/P3UOOKE5dUH/KlX3uwP2CZvIuA?=
 =?us-ascii?Q?nxnO9R9yag+RKM8eCXaOvIvNs/2YTb7NF7/kgsneULoqJmVQWZ7jreej+bMU?=
 =?us-ascii?Q?WJGBflB1klj3PMjtKUdAoQq4zbYDxfO1tMLkbx3s5Z753dWdUxiKXV/jvmia?=
 =?us-ascii?Q?v6sSAHaTlzQGvoHwGQDl1TyubpMNvtoHRdYoMtz/3Yus5COnnNN832QbV4za?=
 =?us-ascii?Q?shTpnIl63labNzd6Vn8457grDoSirLQlplTRPU+KFUiN7bVnBAR2ahya9Q1X?=
 =?us-ascii?Q?U4+yVjlTJmbk+4pPbb86ByFUHDl8VXKY+ybQ1ejgYA7oaapYCekGVLIzlVjC?=
 =?us-ascii?Q?+EUj+kcTswAoiS626jzqPVMm046qN1/9F/rZhsVdOoQX9Lb1QpM2UsRlqPeb?=
 =?us-ascii?Q?dAEP47DKLA8cIeHU1mrRvOWfTYQ3g0jL4bHlX9fPhcKvA947g8k4H2mmHEks?=
 =?us-ascii?Q?sKlW2okX1UAB7/hY0GE1Fv6+ViOe7x0ujCBT8Stk1qs4+oUMu+Ss4JQuwodX?=
 =?us-ascii?Q?VBfW8IOXVVNyGygMfi9n0ay8Y9kbglmhbvC+REjm8eXkdUagzZrWNBHCEetY?=
 =?us-ascii?Q?tbtiMxd/SxKuwkPoiXIb5uYyx7GpBv2k7O4MGQN6RARITQsdBA507rfVp5je?=
 =?us-ascii?Q?1DKGZJUhbdThH60DVdKRKFAjMAwFalOsGtqsdOZos2z4BEtV2Y7JsdVEUab0?=
 =?us-ascii?Q?30Nlez4uFDBmjcZ8sArpK5ycCjHce7LW8bYoa4DrXz8+3CzFze/6y2/dUf1H?=
 =?us-ascii?Q?WTKR/K3IP3KoSk4PCAfTdzPTSX3X43/gYEjOy3Jp++9sgic0JcwWZBVZZJ5s?=
 =?us-ascii?Q?TQQzXN3HmRpkSB2pfXxWWxPGjhyk+mv56MplHuE3tDs6W4mTHh5gTv05ZHJb?=
 =?us-ascii?Q?M5dV/QJf0I35uRZ1iTi3/gFO3OdPlhFMcLn9m1b+pXYZzlTQhuLPzEUMtYRw?=
 =?us-ascii?Q?VlUScgQ9Q0Pny6vDOEmao1Pcgj2ZGlYkUu3Zb+BErgnq0TzS6QS18mRLKFrl?=
 =?us-ascii?Q?WCBz21gW4VDCY/bdiiIrZj3e7jSJQ1HtCMbkUJzcW3lqToJTBitAeFKnmIIK?=
 =?us-ascii?Q?zZ74W8IxeDp16md3bvH5H2hZ1FmwUINqjOAAlhYw7dZOAXiU3t5q6iBX29lM?=
 =?us-ascii?Q?NInmWxQ+7xB9IT9wyFOZul0waSuoSsGLbkB7EBtj+sGOZbd16km/lwNYZOKO?=
 =?us-ascii?Q?rGrf+727zrwSlBsEACBzEKT7sANhO0kLvXywbtXlHTS75xQfDf2b8taWpXeq?=
 =?us-ascii?Q?ueHsMuEKJNTnugnMZiEJAbs6jATFy5wse64Fu+sCgO2mbsEt7Ly3yqWLrJeM?=
 =?us-ascii?Q?NzKektb8WQD0p9EezhpKX6daYlcnIeVkb+6wWbe2/Way/QeHum4mn+RcohXL?=
 =?us-ascii?Q?jlP1W4HkSq4EXRDWqNUECr9BSazR53m58Nuojn/yE8RacfAVrmkrcoZ7nT6Q?=
 =?us-ascii?Q?alHrMVuQbaSZn120KzmremeEqYf4RvVFVMXPdbp85qTVCYgk5/eQ1saO/kN+?=
 =?us-ascii?Q?gPyRJ/yONsjx6T7QeO9W9jHz3edydOVKRO75ZSh4We6q529jumcX3DiCov7K?=
 =?us-ascii?Q?8NGI6IJi/MY+ipraxXFyYXPhuES2xuGyIW+xW28wS2VWILB3/Fgq4DC6b5fv?=
 =?us-ascii?Q?JdXlSRHnCVTkyxO7QH2mgPBoJ5+MQJwD0UDUTy2IcMrfqVizelQ7oZtnbrGz?=
 =?us-ascii?Q?YV/i8LuZ3y8cHTu/7tMUTvQV7+C81hQ6qwA17AF07k4ahqlK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaf53b0-e50d-47b4-601d-08dec1d87e3e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:51.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upIhBzQ7ACwJ2jp1DMSbQf2s9bu6y4KNBDj/g/8n06Co1zGlLeQbEPxj1aQZVmFp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21719-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E946163C323

Sashiko pointed out an existing bug related to mr->pd: when IB_MR_REREG_PD
is used the mr->pd is changed while only holding the write side of the
MR's uobject lock.

Effectively, because IB_MR_REREG_PD is usually implemented by changing the
MR in-place, the mr->pd becomes unreadable outside an MR-specific system
call that holds the uobject lock. All the readers in this series could
race with an IB_MR_REREG_PD and potentially UAF the mr->pd.

 https://sashiko.dev/#/patchset/20260427-security-bug-fixes-v3-0-4621fa52de0e%40nvidia.com?part=4

This was presented as a simple 'oh look it can race with nldev' which is
correct. However, asking AI to fully audit mr->pd touches also revealed a
much more convoluted issue inside mlx5 ODP that is also using mr->pd from
the page fault work queue, advise mr work queue and advise mr system call
without any locking.

It turns out this mlx5 problem is entirely unnecessary since outside
implicit mr there are only three cases where the UMR actually flags the
PDN to be read by HW, umr_rereg_pas(), mlx5_ib_init_odp_mr() and
mlx5_ib_init_dmabuf_mr(). umr_rereg_pas() is particularly tricky because
it illegaly updates mr->pd inside the driver.  Reorganize the giant call
chain from mlx5r_umr_set_update_xlt_mkey_seg() upward so that pdn is
passed down from those three functions instead of unconditionally picked
out at the bottom.

nldev however is trickier to fix. To avoid disurbing the happy paths build
a synchronize barrier by removing the mr from the xarray and then putting
it right back. The kref completion acts as a positive signal that the
mr->pd is no longer being used.

Jason Gunthorpe (10):
  IB/mlx5: Don't take the rereg_mr fallback without a new translation
  RDMA/mlx5: Create ODP EQ for non-pinned dmabuf MRs
  IB/mlx5: Properly support implicit ODP rereg_mr
  RDMA/nldev: Fix locking when accessing mr->pd
  IB/mlx5: Remove unused mkc bits in mlx5r_umr_update_mr_page_shift()
  IB/mlx5: Pull the pdn out of the depths of the umr machinery
  IB/mlx5: Don't mangle the mr->pd inside the rereg callback
  IB/mlx5: Push pdn above mlx5r_umr_update_xlt()
  IB/mlx5: Push pdn above pagfault_real_mr()
  IB/mlx5: Push pdn above pagefault_dmabuf_mr()

 drivers/infiniband/core/nldev.c      | 15 +++--
 drivers/infiniband/core/restrack.c   | 49 +++++++++++++++
 drivers/infiniband/core/restrack.h   |  1 +
 drivers/infiniband/core/uverbs_cmd.c | 10 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 12 ++--
 drivers/infiniband/hw/mlx5/mr.c      | 37 ++++++++---
 drivers/infiniband/hw/mlx5/odp.c     | 82 +++++++++++++++----------
 drivers/infiniband/hw/mlx5/umr.c     | 92 +++++++++++++---------------
 drivers/infiniband/hw/mlx5/umr.h     | 11 ++--
 include/rdma/ib_verbs.h              |  5 ++
 10 files changed, 203 insertions(+), 111 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.43.0


