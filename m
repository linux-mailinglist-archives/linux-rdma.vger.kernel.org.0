Return-Path: <linux-rdma+bounces-21260-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC1fC+z1FGr2RwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21260-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:22:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994825CF6BC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A7B0301AA8C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E25280318;
	Tue, 26 May 2026 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WAGPXR3P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8CD282F12
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758569; cv=fail; b=ppJb2ddUEUrEA0FOkR1s89fsAq+tqLlhtODAr3em8QKI4GOVaWDUFP2wLYOdo1uJ6rpO4fBkcZYvhfa52tfetulBCtfyKg2hrWJVQExJRC5wajt6+IBWVCjOENpKoARQbKovWZhZyYlco5tC2mhrmBiinbxt5sObHCp3z2DRPNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758569; c=relaxed/simple;
	bh=bSreWAeWDOwY+QYiXZrYcRQEIgin2EC0/0Mj6b4vFVA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l2zrdt9vSDebXqFxrAVQx7P/wqANrnL6tYqIVyDOylrdsn0BD8TmsYxfu0AqZSiYmydE0npW92zl8iSe7CfTwglacDBmymfuGNz4IrlUX5t0q50I/JjvIkJadrNdwr4t2d3bIWETmx5QeA+R8O4AJ6Kpr3h3fx60ColXIbEm8UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WAGPXR3P; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ldj4YBvzHlLDoZDu1G7sC5K1rX+MykjlKOD7caDdSNksiZGNXej/jEBnmXH6KgF687qH82LrFgwdxGZBwPQ7U3DlVOCiZlafiUPGQG37AkdOAg/g28hNjlI41Vf+Xift6pMeuf/1Td/phzWBtT1/YhiNf6Bwu3GjrgRU6XU7YWFEPPyic2lxXsbFZ7XsdXaobRPuDfpc7WOX4u5S8NTQAY2nhS6NG2tGAjPRQocYriOtyty0N02jYtqmfy2gcAWzj+RyIHFaABKZCAAdgqo4hTId/cI8cI/muBsq6GYswdbGwlaOQS7PDGwei0T4u5xtvbVj1QtYYoH0z6/+o4Wi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JClH2ifYKtpN/mXI72ytnpLGLyr1Gdv+UgyUWhP8gw0=;
 b=H37LXQXJr1+adlQmFZSds0kewXEyqsMo24RKsHOzL0hevYb7meFzcIPY2kbQG2rYEKH4143JMD1Jt/oupgIc4nHum7sb1u3hfSylMnNzefLOogQwJS3yH5rhULgfFaVlaATC+7spxgNLI9uQYZnjkM0o6b71SIXIpXwYVObX+bZqDr02xA+xQrhdxlpG4WpG2viV8dLepPnB4m/w5Bz936vZ4BwdVNMsQQf67/wrEwHcSesLYmiMTNR8bGTzx3kNMhsk2blIQ+Q3KLrq1Ixk+jsWK5vjAZXWlfFcev1T/UcOZXUYHax07Mb0SVujhww1sp1SA63RCl4ZgFxZBIOrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JClH2ifYKtpN/mXI72ytnpLGLyr1Gdv+UgyUWhP8gw0=;
 b=WAGPXR3PtNO/rlg5cehudv1PAHUYQ4ywj+vSUM4P56Nyvm3XmyslwoeDF0BMa2X+F49xsvT+OSR3fllcVtdt2P1UeqVIVK7EUgBJB4HP8BRESKFSd+FTrROUpl6iPgwZyMv483m5VY2Jx/dBiEF0WxmTB5Uywecp4eNziX6j0Pw4aKidDYAP2F/rugolWXBH5FWm3g7SvYfpgipW43LaOrcE4ocLeE1swwotIx3axEZkHPezO/elds62Iu4LjTdpd1d0AOhm3qsQ/ou4r78yyBXtZp0GpS3l0icbTktzhzueP514PcaH2a3Fz9pLkuraQlfVmkCQ26AuPjvnMvPrgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:22:44 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:22:44 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v3 0/6] Remove driver dependencies on ib_uverbs.ko
Date: Mon, 25 May 2026 22:22:36 -0300
Message-ID: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:52f::19) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e35ccd-86ed-4a04-049e-08debac549be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	WxglyTZ31YFusjRiCL1gvZpu0AkWxKOUliHMgRkX9eJmYDQDHyWBET0aqIZ6pvg/IqXsA6O3JaGEK4aqWw5duzQFWx7KDZ59GZUnEIwgp92V2soLAv4FPE13f6an7zcSF/mh+bOjTe36+uYhRhbL5+6tsOwEWO9CikJ2xn1lEn+Ox+q2YUh35oY+HXnjmPCSdApHy8TpF0aTB2nNjXb/sPMHuTW0aHNnvNROJbUmAQdze/0Xq2Am24BdDWjTH0fZGFOQo7FG5a5HvEI1ahFluCC4jnA8SWs3bCvCRdkmIuf927lGYFdTZzA8B5Eh212YoPPAOT14CXgP/9XbxjlxZitwR2lSTvvjS0OIL7fk4i43KtRkXZ4z8dc4HgsW9fJEheb298zvoxjFPh5HjkLS8x3OFGMky+yE1bl/ThErVFApQgVRNZk2ARJ16RTCst2C0brzDeR9oNi22xWy/C+cd2j33DOmxTwUGP401dDRlWY8zmsXrniSzUICEAPW8V3Gsm+yCIzo4e/RQ31kLqEMdpnUtTrDFTNpaISq5L6u3RONO99UYq2pwIvBBax1wpzFQ2LpRBNl79QaNk5BLg74Cfy5BnLS9v6ej1d6QVJRWzw3aEhdPg40Q75f9/Xtg+HCnREI5FPQvJWusCWrI3fIGFqeNZ0ypupA+O9cQ8SXtp6RDVqe8CadVfapnlFlhI5pI8DyUwl4Oxy0XihJvyRsVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ozgHPPClRoVj+X6PPPEaT6wDux4yNiiwKewRkg3OiU6iLoziMjoSWAUSUgtC?=
 =?us-ascii?Q?4I6ygDOcx2ExDqwczCQsqw5l9fbIO9K/5X1Ae4kJBDrwKXsW+d7kOoEY4LKG?=
 =?us-ascii?Q?vlt1zrYNxHLTCZrqbJMwx+ewmGWIopLrYJFCYCUOOmPP+F1yrIp0nv/j0qrS?=
 =?us-ascii?Q?KH1nZHAo2aC4t7a/6ogC0MHQ5oWfZ6rz+R8lJkL4mOSNAU7qAnG2v50OJ7oT?=
 =?us-ascii?Q?qPDBZT2y0tWsZ8ZmmbhZf4aX++BUbZcTbvdwJFCN0KOaObRNaZJANPXSR6Jo?=
 =?us-ascii?Q?gQObqvg/4f3HVJm/4ytlhci7fIIqQww0eTE2CMnZLNg95PDah3vBVYD3E+BQ?=
 =?us-ascii?Q?rkBZoTxKhSUFQi4QwxUhBIOaJ8rDL6n3ev+O0FcllhFOGqe20kWGjNqG0oom?=
 =?us-ascii?Q?M3AaVMLbENt5NKXKAVXHG5VyOzIdjwTl9T0hp8AJbWw6TgwI/X+792rYsx6f?=
 =?us-ascii?Q?1pXzGSwMhn0MATzja7vOsCEsDpzloSgksVlKRMbL5eMQgH9UGFTu1Dcwkf5+?=
 =?us-ascii?Q?LGaaT5GCy20jdCil9yVv4/udh4hsz1m1fagoMFDo+emZ3dOCwcw6K0mNCJFw?=
 =?us-ascii?Q?rT7/x9JIqI1CpAWDuMVZTMasIrw3/TL2HBjK7dHw8jLezPp+ClTQV2DqZq1Z?=
 =?us-ascii?Q?rkILNw7+5kShlxR5vmFG1UcHTmeoRpq2UXsbMQb53jbkVDu1lLgK8+Y5ayiZ?=
 =?us-ascii?Q?kOUCeBSbotnvxsEEr+WY1AuNpfia+XQJEYyfMGLSlSmg5RXzlAd2KpFtwBLF?=
 =?us-ascii?Q?UTNj45s8l43oYVXNkE+1a+jX6xfm+5bA87zEdWGjSPWsUdZTifXAhFmREXUi?=
 =?us-ascii?Q?p+sFiDXW24Bq9mtxUM5MWXOGd7PAWbJTlnJ5/joagxoyC8YseJbNcutSpEdO?=
 =?us-ascii?Q?F05xE92WqbLc30AZZwmM3Nmupe+cz07j+caeq1qJf9RkcjNjk29IjXOglGv6?=
 =?us-ascii?Q?GwSqMv1JeMXXeXWBlcfQWtO+aXyFCj3EEvDSbiM4qo+5l8ewnvtaNRDO62cB?=
 =?us-ascii?Q?Z9ZaSr4ZnvwL3hAQxrMjn2XDMfIpdVUgMA2FhJ713rf6UY47b8dk04N/lIPE?=
 =?us-ascii?Q?ECG5awheAOeHnlJfb3jcK6rHCJ1sG5mmgxNB+ZUoPH1Y3XanCrIl3ZQoDP8O?=
 =?us-ascii?Q?RWdH/yaqhemGWH7dFNI51BEAkphoiBv+BCDU0HT6kLQLycdj/0qg9nAYp3lo?=
 =?us-ascii?Q?VUSYwSjvAeQ6pgLQ8Rl1taP6DlM/Kttwpfqy7WzPXeuWcE04B79NZhTJUhT7?=
 =?us-ascii?Q?Hjb+beb0wlgqyLb3T+El8NLeZjlf7l/03Cnb9MQ2lbNfS7S2ilNDuZsX0CXP?=
 =?us-ascii?Q?uNm4mFere+C93iPInE9Gkwi7C84RI55zB6nqKGFfTiBwiZw+P8vEwbueyKmo?=
 =?us-ascii?Q?nfjZ7x9KPf0Jsd7ltZ3YZHkV1BmKrvwmPrR4WwEGwvlAcRevxMJw0iixZXs/?=
 =?us-ascii?Q?dRBZK2O0Af0uRdUSICh9l+szf0eG/MnByPL7ygRBVDboBio3F/5O06wHT6NU?=
 =?us-ascii?Q?KrWZLZzffY21lscgaqElzt1ckp03IdY660mlhSWAWPqqYG1FDUs4RWayCHkO?=
 =?us-ascii?Q?GGj4B9b1elodJhSwTZSOfhjd0BoxM9qXeYN+gim7m0W7A7oRJ/VpNsqSLJ7u?=
 =?us-ascii?Q?4bke7LobwFgeJRubnFkJw2wJ7O6Nre8Ps9LWuBHR/k0Wwhk5dOKBrair2J4c?=
 =?us-ascii?Q?hP6WzCJ4b7otOhMry5LmE85fHQLq7flxm6402HHL2uwequw4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e35ccd-86ed-4a04-049e-08debac549be
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:22:44.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gcs/ZFlZuWYFXB8nAU3nkXXUD1gW32sgCsYtGFN3Jp2o4AsDmYHUct+cRScAr05k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21260-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 994825CF6BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The original design was for user facing modules like ib_uverbs to be
independently loadable, if the user didn't want to have those char devs
then they could block the module.

This has slowly gotten degraded over time and right now every driver is
depending on ib_uverbs.ko. Fixup everything except
rdma_user_mmap_disassociate() in hns by moving code around and adding a
new module ib_uverbs_support.ko to hold the driver functions without any
of the uverbs cdev code.

After this series mlx5_ib and bnxt_re will use ib_uverbs_support.ko.

v3:
  - Handle core=y uverbs=m cases using a new kconfig
  - Remove doubled rdma_user_mmap_disassociate() inline
  - Add missing _exit
v2: https://patch.msgid.link/r/0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com
  - Rebase on the rc branch
  - Fix ucaps module mistakes
  - Add a patch to not build ib_core_uverbs.o without
    CONFIG_INFINIBAND_USER_ACCESS
v1: https://patch.msgid.link/r/0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com

Jason Gunthorpe (6):
  RDMA/core: Do not compile ib_core_uverbs without USER_ACCESS
  RDMA/core: Move many of the little EXPORTs from uverbs_ioctl into
    ib_core_uverbs
  RDMA/core: Remove uverbs_async_event_release()
  RDMA/core: Make a new module for the uverbs components needed by
    drivers
  RDMA/core: Move ucaps into ib_uverbs_support.ko
  RDMA/core: Move flow related functions to ib_uverbs_support.ko

 drivers/infiniband/Kconfig                    |   4 +
 drivers/infiniband/core/Makefile              |  16 +-
 drivers/infiniband/core/ib_core_uverbs.c      | 226 +++++++++++++++++-
 drivers/infiniband/core/rdma_core.c           | 150 ++++++------
 drivers/infiniband/core/rdma_core.h           |   4 -
 drivers/infiniband/core/ucaps.c               |   5 +-
 drivers/infiniband/core/uverbs.h              |  25 +-
 drivers/infiniband/core/uverbs_cmd.c          |  76 ------
 drivers/infiniband/core/uverbs_flow.c         |  78 ++++++
 drivers/infiniband/core/uverbs_ioctl.c        | 204 ----------------
 drivers/infiniband/core/uverbs_main.c         | 127 +++++-----
 drivers/infiniband/core/uverbs_std_types.c    |   6 -
 .../core/uverbs_std_types_async_fd.c          |  22 +-
 drivers/infiniband/core/uverbs_uapi.c         |  13 +
 include/rdma/ib_ucaps.h                       |   1 -
 include/rdma/ib_verbs.h                       |  67 +++++-
 include/rdma/uverbs_ioctl.h                   |  13 +-
 include/rdma/uverbs_types.h                   |   8 +-
 18 files changed, 583 insertions(+), 462 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_flow.c


base-commit: e312f0ff9e180e8ebfdab2419898e82cf5408944
-- 
2.43.0


