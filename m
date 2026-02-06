Return-Path: <linux-rdma+bounces-16609-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLwpFklIhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16609-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF7F908E
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFBE430484E6
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DBC24A046;
	Fri,  6 Feb 2026 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qA/CcIg8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591718DF80
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342352; cv=fail; b=EKLOavbokT7WgHdekwCdj/lykr7Azn0wRqy279gc4exd+BsZCIdNzsudRW3wMlaq3EJEVUmATyCcbEPhpnXo/1EJkoxmfvrFlTH/ik3nsHXjvh+jU2N8GMKhrg+peWLrrWQrJ5TJxJ/A/XnvxTKnOmBk/GSQ0tjik1aRTJuIoa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342352; c=relaxed/simple;
	bh=GL652WlZ9v1KdFvdGl8rL7fZKXNB4qp25fJAeHx8eSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVcLbqP6qtKUDTH/VM7wXcMDPZ/I+CsCq9MYkXrZ0kwYe/Zrf9qrnxloPrSswr3hurx76zmvE6u+ur/SFxgQvdj2qKLKjxgztj1dBqL9g9UGm3dNo/EPWrNuF5J6Ds16fISJjx5jtlFbxh3n0Btp1636wMIIvaNAGwCO/biCGp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qA/CcIg8; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he8MSzhYXR6dRedAuLr+V4WARNU+0k6jY1ZCuYD0GYMch9uxGLhtdH9IWkmqsaIMmmEp4xredbFuvCEkMTXdT6XDPpb4ysihn3K97i6w//eYJoUuM/rEKWXqWhsynRsFQkiSuoistdnXb4aeRxohXy4VfjrUw9ty4bJyptrK5Pmda73nj3opbXJ1jhbuGKtxOod+oF+Mc/c1+DG/aDtQPM0mvQNVVIJdNlDjEIcGDviRM2SmeT9liSdrZ9x42siWDPUiZ4KMmmtEi7//UddjUc4GzdfD8GaggihhXJSgw9HK3d059TwudYR1POEPVgdOId1UwDpLCCWeHY2lNEDyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNYz9OksjxntLrdfOuQHqKFUQUMnCBG57Vz1P7XQIC8=;
 b=A6z9sIhthcQBfVZ6Rljs9+lTeSFp4dsaOH+zodEnxaLzQMYCpPvqYro336QagDV6k4yYnxp+nyPLNRCQnfpPTsECp6kWRt5DLQCJpe09Dc0d0ISXSLZexR9mQwJNaNMjkJLNFwXOb9vyfRxwbAVZ3uqcLTFtRjo5P9OZDnAJKpFsTn6sSmXhcTMErk+VE0U+ynNLGwL0pb1L0eDVPbwSvCgM7KwcFnUhu2y5/p30By3NoVUFrCUwqi7Wx3C4aZ+cUux4fzJjJtmV8SgGVJTrF8uPeeZ0O17Tt1Zd6I0ucTPj/fRfCUWKwIzNL4hoI2FWodMylQuEm0ufJNXZaVGIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNYz9OksjxntLrdfOuQHqKFUQUMnCBG57Vz1P7XQIC8=;
 b=qA/CcIg8X6zPJw4rWSfznXNzM9ofYpP6s97gZQIJFYmj+4Vt8A2YZI7felgg38J+JWxW2ZdOyTmcwAC2BMZMXK5x1RfQ9oyO6rgfL4ec8ioXs601l8vbOQo4MbGSIZtvA2os7ovWtbf42YkgLemsbgyTEnKs9q63KjIs2gWR8hOS9xlkHbdQb1dSJRvvsjqu5DRj/3WnRcQY8J7GkvMj4OJhSJ3XSMRtrWvjvOPFjGXWgd395IEXGDwlnVaSXTUl1HB8Ew1a3wU9JQzi+hGO2zy/rdAiKRrzj1lIUojYzownzAUaftwFT3mnJB4llfUDLzSKwwBAhukVEC5/hrrt/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 08/10] RDMA/bnxt_re: Add missing comp_mask validation
Date: Thu,  5 Feb 2026 21:45:42 -0400
Message-ID: <8-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0038.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eda7c96-8814-4aec-394a-08de652172a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbaWCVA3QMZmdvSjmUfrDcDHsm4gc4NY56wsZqqnlh5FDrAjDm3Hd2YX0BgL?=
 =?us-ascii?Q?2jKtbv2aChGqM5/VJvPavR/l3L4kyEm3lEk1mqEs6qSoKMekbp1WUO3tL78u?=
 =?us-ascii?Q?LlkGo4WMCm7thn95X7pzicLrH/9wHCsYLZU5iYb38IgvqyVQJt9PovFUyhqP?=
 =?us-ascii?Q?qdaUH3KOsn+ISZNaomJuKAdWUoQ8dWjvvENo3iK/E/5cn9Ra8X/IicTj6U9Q?=
 =?us-ascii?Q?o71BWdrz5TDQQ4YT0bSxcPR1UFxvV7Ff1Tj5mmDjrOh3RUGYJqix5LpQWcXw?=
 =?us-ascii?Q?zZQY3LaTKePG5mP2VgZ/ZgUhNbFLzW7kNgagOJytbZmAZ5eZJOJIEZGR0ig4?=
 =?us-ascii?Q?CA6gFXjX9i1kJAmOnRVXH47FkcaFM8Xa5XB2sZ89tg/IZEpr7dVFSq1IQ9Nx?=
 =?us-ascii?Q?ovpwopIZVX23Dhkl36ZJ0kkZHUXMaKE4/Zs7ZqGj4GN2h5k2Gt8OhZQ9AULV?=
 =?us-ascii?Q?+kW5Zis5fXJnzFN3h+Pdo+qmXJfXslEAsRuyvYTIAOVccUcbailRByG1W9m/?=
 =?us-ascii?Q?ENYsrUY4THMkJaFLKy8SaXmcGCSYj3viIz/U4VnU0v+UIb9OB5jO0pqF6SI9?=
 =?us-ascii?Q?5MvtbcutkngSU605NIHu92EVkZE1MClf6h9BFwfTSoORUxhPmDqMRVQ0tGUg?=
 =?us-ascii?Q?XxmydL5PzawR385/1T/Ko0icpzhG9vz7SodfkkOvuAHtjp5iJVXa7x38XZH9?=
 =?us-ascii?Q?aCgk8v59A60zQE86CTXsh3haekPTik5dWIILCJk3qEivNeJEwFEZJ2Z4pxVI?=
 =?us-ascii?Q?uvr3CLUSEpoDtfKRbomUPLmFIWB2E8BoFJP+7COGd3P+beqkoFvw94IZQHPS?=
 =?us-ascii?Q?El1GxVD/x9bPjSicJcip0LaXokSl7QlaJjSRwFGRKYI16ADqleW5mBx+eO+q?=
 =?us-ascii?Q?JGnZp80tzAbpdzXdOHm1x9uS2DFPWM66ghKfGX6PtILv34D8YUCP59TeynVG?=
 =?us-ascii?Q?Vx/ZKjyInjxGzoyZqK1zkduYB0HLfIZN/yQ7bUNMam/8kWmXMbawVrQEL9GG?=
 =?us-ascii?Q?kKRzQuwbbJV6ppzrc7ycF/cKSZtsAOct7KOo6QhB2HJ0nuC9YuVKJedpnY2c?=
 =?us-ascii?Q?t1PnvWR2gYiLTcq2UAEjnAekD0AbO4zMVT3v7es0XRS3jcwTfa8Pm8Af0pP1?=
 =?us-ascii?Q?jglQwu0WuCvHEKMPB6pUn1L9rEQZ31bFY9CxM9cWnL1eSfKkuW0VpPsiCB+t?=
 =?us-ascii?Q?pAUa0AP+TCC7FFP7Qa70/MuLRerzvghenvQQ69AsKP+C+W85kCq3nHVWFCKd?=
 =?us-ascii?Q?OeVh+45T0dzD/xTxh6c447dFqD6xj+pevpUz+IbjZ0Wq2kQ5mmyxlWPQ+zzp?=
 =?us-ascii?Q?YzXcEK3q+Hrgmm8cXPg/mB7IL+53iXF4fCuywrcq16snbaKzNptd6g72mLfy?=
 =?us-ascii?Q?gqjLwcP36jEkXF2JYseV7lXaT6JbXq6k5fd9eY0aM5KGuZgazfajwSW0Kzp1?=
 =?us-ascii?Q?FS3BUtbPgJJ2W8hMt3tIsY8r5YA5N79X6EEuLSxpVzmuQzLe8HkZWCbaHkPY?=
 =?us-ascii?Q?9wcFvEja/x77iJgg9sWLc+4HkWNoqzUAB4CcMYguLmqlQ1vnJm1v4IbIWcUJ?=
 =?us-ascii?Q?dsWFBo2f8HZyaoYB8CY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ybdSxBkFmwQL07dpwbHG8YXm6m7W5Jhw4bo8Qqt43pCCkMQ2CcfBM4nXkzNv?=
 =?us-ascii?Q?jf6HKwFiyBcA6mTI+RRYpaSMnbKZWDDPZfYIjm27EPJjKX56PitK9E/Gt//5?=
 =?us-ascii?Q?shQ/W5FSwCQbQX5vu6+uLLTA3fUkt2QltTYjifAl6sPR6gPebHfuTrx5I8kQ?=
 =?us-ascii?Q?eGoNxz9eViVZy9qesI8U7eSW02okLfeGKQoBoSNUULkVmgQAbikrZTguGLPT?=
 =?us-ascii?Q?xa3xoHKBuNug337wnRcpW7oHfHIDSO2fExKyVwwXF7g+37APuZrYw05g0I/I?=
 =?us-ascii?Q?YRAh/gNg7I397BP2NwFs7EcHSU27LQHi2qQ6mhRiH3ZQVVY2zfFZFmfAj6SK?=
 =?us-ascii?Q?1CNls6W8VqLC2fFa939b47qOzMKnU6bMt/3ncmFg24bimjwZgbwCImghZT+x?=
 =?us-ascii?Q?+bELVKTeD7p/b1kXadJN4tj+4vLYvN4birahUv1zUL1nl9LdiLTHzW3wPpWo?=
 =?us-ascii?Q?NQ7yCquIOE2G+WG8b6C4SQEWNWsNZnPqQph5w068NhRkpVrC39eCRn++A6kG?=
 =?us-ascii?Q?5nJebsTBD8vvseA9EhRNg8e7SrnbcWCbPT1atVkR/9VToN2bLgKoA7UHSZWk?=
 =?us-ascii?Q?vGUru/RauEYJ4KojK2nEnBxvjcDF9JBrSUMMEnBow9uk7jJWytBt6bdFJM3I?=
 =?us-ascii?Q?4WZiVqlDna80B/t1/0uH1035HF7K4IBfhK80p5Uv5GsshUp76C5y18pw8Sid?=
 =?us-ascii?Q?LpuK4iGVreyeMphy837+jz4kNbMHWoM2SvXSeEqKe8uCRE4xgWOvgwRVK99p?=
 =?us-ascii?Q?IIShiiTpE1Wll2BuLTZXiCAHqL23lu6QCzle2y7zDvxr4SbYr2gxjX+0KZoK?=
 =?us-ascii?Q?4rOhLOb9kklUgf4v5h4ksa3476zRm13I1OJPIXvnLGyKnfrckpvRn9ZMcYcE?=
 =?us-ascii?Q?9gxxvs7dUNsfp7Cg2VXuw3CGGf7CwCFNZWQvyHsjFGsxnatgLHP5FvNCRKdd?=
 =?us-ascii?Q?loOOtuzxqQzvNFND1GI76yhbcmWgcDhh7utuhNITWusPD/tHqy3hS9OB/wnK?=
 =?us-ascii?Q?PDtABLA6qIa2gn+39nLQ+57q1nl+QIyrUfFdXc5GHqEAjMN/BbufOpT82vrl?=
 =?us-ascii?Q?LhLVVEQB5F3/R2nG9B/LaPe7NE+m4CNySMVZ7TIlVN4sQddJ8+S2P+sy6Mb+?=
 =?us-ascii?Q?BlxXhIdKgKFBGOVtCYtnD6uIkvjm1oNgD6xFkE1LhlM5n8IHipEyARTAyo4p?=
 =?us-ascii?Q?8gO0UrHTQcRa99aGrIlQ1GFLWdkAa49tlgAsE3FaFh+wkjnguyYRAqNx7FKK?=
 =?us-ascii?Q?QvZrfDqnvYiMuh/fCfiPUGqCrkT8S/PVkbBTnBVoDIgchBhb3ES+ZDvHd1D3?=
 =?us-ascii?Q?KTVii4ait/9kPk7gRBjZSi41ozC3dom5NZoUAXuAqHFkVKpFB1eUmvh+C7pe?=
 =?us-ascii?Q?SOArz0LT4g6znkr9B4bpUmxjbbXucqnVkIMC85T2hX2Z7JaldCjGgN44ILaS?=
 =?us-ascii?Q?HWb97wRoPus0LDwUdSPCYzaaeqxn1qfmS18077SBkV359oxmnvn+dokrBogs?=
 =?us-ascii?Q?5kBt2GMUxrIihHO/tvORze/pqebY5vvKGJ6755LKJmTIhLIUFAR6xXy20Vt3?=
 =?us-ascii?Q?H6Z4jYN6KQQOFRcQ+w3NJQQsgQOe0yew1t1JPMPrczehOIBs1SMNXwPrXSWm?=
 =?us-ascii?Q?GL2Oj4JOMNchZlXQgY7px0jl+307RU/v+2C0q80WiYRXrcZDnqPR/50EjwTY?=
 =?us-ascii?Q?uUHP8ZWIFglbUYodFlR5zcoF8dsnYUyGeoFioWxkVGtG7L/G57B8j2A8hqP4?=
 =?us-ascii?Q?6ILREV02Pw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eda7c96-8814-4aec-394a-08de652172a1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:46.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjEaHx3uEq74Jatnmzyb0TY5yig8AumKosizZfMxbIknLkqjRBiAihv5EbmtqybD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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
	TAGGED_FROM(0.00)[bounces-16609-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEAF7F908E
X-Rspamd-Action: no action

Two existing req driver data structures have comp_mask but nothing
checks them for valid contents. Add the missing checks.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 485785fad1df63..6ea03e1f6c23dd 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1671,7 +1671,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
-		rc = ib_copy_validate_udata_in(udata, ureq, qp_handle);
+		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
 		if (rc)
 			return rc;
 	}
@@ -4431,7 +4431,10 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED;
 
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


