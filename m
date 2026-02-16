Return-Path: <linux-rdma+bounces-16926-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HfWGpA1k2mV2gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16926-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:19:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D1145676
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0F503106521
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7F318EE5;
	Mon, 16 Feb 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tsJMqY8U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B1318BAD;
	Mon, 16 Feb 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254184; cv=fail; b=BfxjD00vD2nmZwp1/M2Giy/SPEs3d9nEZ9v39HUkngqnQ72QIFYF9oFRUIZulYEKtjfS+tsAEO9jKXmstQ9NQl8xbU86/vcIZ49F9BtBiKVr7o/GLEjqPSdAFEXrOcvI7/U202E1m8pLMFwCVsOG8ra0wcdejiPHcRQdeI0y98c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254184; c=relaxed/simple;
	bh=VA1sox1S5oRKoozzHuOzTaeCK6lZLmdSjw13J/c39L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KWwQzv3rWoDDdoz+jjkYKR48UT3bMZNxL4+8tYcLe+NjgAHWGS4BxKbyhoook9gzmTHAXCZiQvjw+gtnMeLv32BnHlq0YQTIci/Cluff8l2/6iv/p5HVPBycNg0UF3XRPvqpZtS69umkOmf0/gUibttdZDCbKIoZYgb2RM4oEBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tsJMqY8U; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZruNVOb53NgZZqiiJt5HvweM0pSzfDNXdx8livHVqUho4nkn+hMToi8EjJ3W5SFl3VDAWxiNgSenI+SovT8X/1FdoztPcXy7zxe22X7UE9Wwn8KuTvlMZ7O838UoP94/kx7qsaJsiV5WaUaD+h6kIaKgYI6kCbmYE46+Z8EaDumVD0S1Vfa+liwG751JExNmZZOVuEjIzs/J4LvKyaJGV9Pgp/gBUt8NCU+EXbA700lDvnEXsb/TKhSCrjytFPGIEEIB3zrTSsclECa9A0d8riysuvbPu/oFXmLou24X/bl5v/O7/ttuLpTwR2wvRVuuRLfmdKZMuwwgchqmbFi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvyp5yeg3DgdSALNHkjvckeVhhDvWhEBBzlNDoO+SKc=;
 b=r8XgZPzS4Iwcd5N5qiGDUEI/M83m/jJmZXuHkKj+TdHlYjMj1589luKs7UwnOgDthk/e56DWNI1+pI5KjYC4Vti7nMTG5PeDBMOwgRwekjO8PRpTFv1cO3jw/log6V01K/wNEdmupZNx/IKf+XQ/MVDAJrDydVO74CWkzZjmbbY743tLt9F8jwaduLXw7CfhU3ZQI5yTBj6qk8dmcrlcUFLeX/J4/80QO3ejL3sNd63cG5yXl2mH0l4zoQJWKnM+AXjZ+0P9QlOJZwLYvRMfygb4AGIrLrdL72Iq7tqdZ2zmBPlGsgh9Ag515byST7G65o/XmY5tvhiSM7Xkj3DFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvyp5yeg3DgdSALNHkjvckeVhhDvWhEBBzlNDoO+SKc=;
 b=tsJMqY8UxgYeuL4nYQySud5VWUkFXfhg6wo2/fy/e2d8i3BddH2Qdu9CNAOQCqhH7x1r8Kj85u3bxdi3T+dSC224kmt9xh/bCyM6qrrbIJONsZjG1JEmqaJ/iNAyyR5KD3l9BhYiP8WxNekz7OOt3sH216BwTCnkJK5UIWoKR60a/yXJPmtFmafWGNswPBktYe8tJE53sbJmxBsXJoF9lC1TVDQMgGHr+WAuW/uwsUgu0uKw9hPs3kH0FN7c5Cl5NxmPBdJ+1SfExkT75rIcL5pzTI2qxjFcE0Z8Rpu2Nm5ryLxkd99HJtRyOjQsS+Qc2QMfZynX9YH/Mw+nnEtu2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:02:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 15:02:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Gal Pressman <gal.pressman@linux.dev>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Michael Margolin <mrgolin@amazon.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Gal Pressman <galpress@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	patches@lists.linux.dev,
	Roland Dreier <rolandd@cisco.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rc 2/4] IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
Date: Mon, 16 Feb 2026 11:02:48 -0400
Message-ID: <2-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
In-Reply-To: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:208:51::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6f3809-ae7d-4c4e-3ce6-08de6d6c756d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ot044C84eVSwo0wXix180ucATs6aXgSep5wOZwQkVURxEyVBdYtLVn7CTYNG?=
 =?us-ascii?Q?IjdaZdJeY2FcKXu0Uthe99S6BA2lVfmATQFZQ0DxbVqPpp5V08aAI876kDXt?=
 =?us-ascii?Q?0YC6UWoWTkamCnl3rSAg/QQ7IOPVr5z0k7Ory+vIRnKm/ZrWkRa2NPTKsJG0?=
 =?us-ascii?Q?5LJlNUkVnB2qxAhfUj9qSSnO5JSY+Bma3o7P/0DuKnrFtwpJt1uIpO3FamiI?=
 =?us-ascii?Q?Z4EMHxVhokX7yM0K5N/x6E5dAydBh/FpYaY/USX3J6mMe3msXGTZ+j4OLWWo?=
 =?us-ascii?Q?GNpWW7vU5teMGvQVzc+SvSmSpRvjp2KdBnBsaGeqGjsFMClZUUnKCYJcMtsl?=
 =?us-ascii?Q?IpGSKsqq0d40mqZlLvwK5pnKr1xUEXEPn1brI36OixKuqPKRnaIKcnDuhDO9?=
 =?us-ascii?Q?tyoo8TKojRfyUmh94l72gEQrx51QcTl81DSII5pzAP6rvaBMY8vKge2opKSr?=
 =?us-ascii?Q?F75LwgjaKyJjws8Y6ilHKnQkQnrRjjCzfUXtUGemDACZ/lDbhsoeGAAbdN15?=
 =?us-ascii?Q?fZy5NiGsxQho820+QZuoCIVED1SF4Np+2+k2OVTEBkw5fFfBYA6zpVC06M6t?=
 =?us-ascii?Q?Jb9F9xPnnNry7FGiC5TqSxvP3FB9IxYrppgDHaLe18NYEgo1fQpmQ5pvnzJT?=
 =?us-ascii?Q?RCRhX31RMUaZtFNRaq9AbELmWgxtiH52yUYbWtuds6YSYdVaEjLOTY5By5ss?=
 =?us-ascii?Q?K7F6fHyiNS8xQ2jSg1b2VLk8d5Kl0lehPZ0GEmsNctb7a97i73ZfiUhGxbvw?=
 =?us-ascii?Q?L9QxXuOZtaoxeWCMx1OnCJwIbUaDmABHMXksmxO3bgAqFNIDY71i/gz0pzzZ?=
 =?us-ascii?Q?Q/cR7kS3dLFM0nEzq7gaWS9yz2UeZ9Wtd8vDdOdsbKsMLTJqW5VvGlqBztWx?=
 =?us-ascii?Q?SlPGzCjTnfts1hYhoTnxNL5dawEqHTCeGH6pVMLE29ZP4RL7wfjdyswIGhIw?=
 =?us-ascii?Q?PDBJ4N+qDCmTixz4aeO0elSxzPklNbdXLa68LA7ePu/1BIFpaJKiAvNSBqTc?=
 =?us-ascii?Q?y/oIYTYHCL7AhJmaHWhNF1ZEXA/BkWIHEUW7UDKLkqSdE/GAcPp3RMJZsJdC?=
 =?us-ascii?Q?AXGJiL49I/jRnLjC6bTbk+Enzn95gU6gEitmK4OLuVmMthopCxEoOnxJKIEl?=
 =?us-ascii?Q?bATZNH06hVTQWH1PHOBS6dWH0C80xliffqReHdnIVvanHmXE/hw577tO/JOI?=
 =?us-ascii?Q?jnSpV4N0gNdnjMnefpYGuVoIox2AaObviB6NvoofQojPF8WEsc+f3HhVX0S9?=
 =?us-ascii?Q?muxS7sYiY5LuGDUkGWC+TK4uOqwpMfKWZCUBGYncrkd94h4KdaCX+1Yk4B01?=
 =?us-ascii?Q?Jy4NQh5crihTk5hUPeSgZg+8/M3pDUbDVp5wN/cjOH71MHnb8XvoBP/jNvpN?=
 =?us-ascii?Q?BQnx2RZ09w8T3j5PC/PVLKNfk1r0qKCHoSrAKgudT3hju/Z8Iz1TDba/dQe4?=
 =?us-ascii?Q?W/sjG8o/p9w/KypGHrGUdaDOOs+HasYJCPe34Ezmznl6DDw8Ext37yeL/ayR?=
 =?us-ascii?Q?EdIrNsJL4rJne49myLhcc7H21uD23M0Yn0J1exJWhOccxRQCMIJbOs/LqzLT?=
 =?us-ascii?Q?UmwKEDA7K2522V18/QI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vf4FNjPv293d6osErPfYvNoN+0Yxn0lvu6iGDsAQ7E/MnR9BZNlFjjzhL9UE?=
 =?us-ascii?Q?9yKeAZer9c7LeXHrCKsp0dKi4OUvOUCGNtwrsZ0JSiNTXGQXW6dYu7V6MdBv?=
 =?us-ascii?Q?ydfSqbPfMCGgbVvQw/QAKK6W92iXSHFwYUZeLGioGwhXAiZ1aI1OgN5aLxR2?=
 =?us-ascii?Q?C88+TpXMolz6BVCMNgrBgTAPOYhyBTU5+uiyxWusUt5UepGEuIl/YlTn5TNH?=
 =?us-ascii?Q?IyMmTkk/joAWaCXfx40nW6SC8jPzohg97rgBn7a1PXaNra8uiBP5+YVXYXR0?=
 =?us-ascii?Q?aVbnCdFtr1/eVJMv9SvGVJvsUP4j8KcEdkzZSHk8A1FebmeWxyRzeHG0ao5q?=
 =?us-ascii?Q?+8iYlVJRjefkUN1efatB8JCQBCbS42c+kSegzDjfMb2DZjUN0kIaFsp2W35k?=
 =?us-ascii?Q?5aIhctUgDnYVSJWiGaUzB8soGV+7Ww/sZrqX8jupaVqt+zofMAA0msFte15T?=
 =?us-ascii?Q?2zbWAva9p7lxfS6NbkS0yElUJmAXWxY/HT0YhHb88QWhy1aZKkjnuzBPJm1U?=
 =?us-ascii?Q?If97z0ydfCk96tQgkHPOxM4IR1MZhvgTtwSPG6uV3SDLA81jE1wfz1NyCUXM?=
 =?us-ascii?Q?61QNHwAsLwfZMcbGDyOdTIGh7HPI33NW74+RHf72y8AbhtF3RM2KUO4YSmpy?=
 =?us-ascii?Q?NhY2/VOAxEKOW55vyFvryDT9j1BYU1EJz65ew5RPpDVe9zuS54LYi//iEgxn?=
 =?us-ascii?Q?0r5qRVw5wf0Ibwa6PxzwpP8tJaf9Lz9S9p2maazW7kvxxQveBsjv/iBYm3ce?=
 =?us-ascii?Q?+XAxBSBrbTpgwQll+QuY1Wp+WCrtmQRKU9bsuXUfdAYPPOgxdF7u9uIz7qta?=
 =?us-ascii?Q?DiIYfM/eMdCJiKno6VzXlMIm1SdzYzYcSPPPDI1XVm2f9UvqgaRMJsbaLUcr?=
 =?us-ascii?Q?+usXHuTxEfqy9t0x55KX85dE5uZ8/eVzU9xTEMwmmZ2rS6/p06io2HQODhk3?=
 =?us-ascii?Q?hexdTeqMhncr3/Uxm6+W8dg+7TjrgkhnnbFmKf6QL66/4jXWFXtJ7dw53N4i?=
 =?us-ascii?Q?r/FSm9K8YHTyFYcf8Pu5biWjRIB8/+rroB8Z7tbmTGprhgrzx2fpGclM59gB?=
 =?us-ascii?Q?2K2n8ZK08Fw/EPp7Rmo8UXhHgoziUqUmXh9dzNxtBmZt4F6KATe6GsgBbl21?=
 =?us-ascii?Q?fmxLM6f7rI1773w5aSG2mTVoeBox+HmTpTBTO3FKrDAMkvEtvy6iGy+P9pmP?=
 =?us-ascii?Q?e/KuV8bhJdJTNsPUyIIlC25bf429UfbwSw2F3v+VEhO0Dez+jzSnZF2JAONX?=
 =?us-ascii?Q?R1FlgYC43mHStXqwfvp8tv0WFfwy/6ubV+in2uxuN8eJ3thd4AGkfOAK2GkV?=
 =?us-ascii?Q?eyu5XT2btT7d+lpbz+3XzOLRQdM1k5L5gZZBOSGkNlI9Mf9beJQ7DzhMdArV?=
 =?us-ascii?Q?2RwCY518pfUYudo/pUXiNGMVKepyDOVKz80gpq1HK12al/ZNOvteZonlj/Kt?=
 =?us-ascii?Q?711cQ2C29D6k2eMX+i1lxB6TXKroJz5QpRO09L2LsLRg3PlLt/LzwP48xPBh?=
 =?us-ascii?Q?c0iAaGWZ5PIUZuziJ+AbUunq6G7bizN0LFzIwe0UCZHkTd7tFFwNET57iBCM?=
 =?us-ascii?Q?wqo2PDlWjMJijYOGUG3LHUNEqrCQM5gz8y6yAaZ/jdMppVIv6VgboZCkm5Cj?=
 =?us-ascii?Q?O9DrqMXsy+/gH7K2IfsJAu/P5cr5eYjKG1VogxDQOYHhPiCV083qQJSzn9VJ?=
 =?us-ascii?Q?iL8q7g+7rRWXLEmnvyZhrKqfdoO+hHiglRSc3QsokP8zIddp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6f3809-ae7d-4c4e-3ce6-08de6d6c756d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:02:52.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrFTPOHNB9W715CevBJY96scp5jM6BqtkHY6WP6Xju19yT4ij3ZO1nv0oVZxTO0m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16926-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: ED3D1145676
X-Rspamd-Action: no action

Fix a user triggerable leak on the system call failure path.

Cc: stable@vger.kernel.org
Fixes: ec34a922d243 ("[PATCH] IB/mthca: Add SRQ implementation")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mthca/mthca_provider.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index dd572d76866c2e..ae0c8024ad2310 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -428,6 +428,8 @@ static int mthca_create_srq(struct ib_srq *ibsrq,
 
 	if (context && ib_copy_to_udata(udata, &srq->srqn, sizeof(__u32))) {
 		mthca_free_srq(to_mdev(ibsrq->device), srq);
+		mthca_unmap_user_db(to_mdev(ibsrq->device), &context->uar,
+				    context->db_tab, ucmd.db_index);
 		return -EFAULT;
 	}
 
-- 
2.43.0


