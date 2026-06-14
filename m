Return-Path: <linux-rdma+bounces-22213-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aiD1HOmmLmpX1gQAu9opvQ
	(envelope-from <linux-rdma+bounces-22213-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 15:04:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA5D681100
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 15:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=XHjZOrxb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22213-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22213-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB3F3300889D
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F64355F22;
	Sun, 14 Jun 2026 13:04:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781B23A562;
	Sun, 14 Jun 2026 13:04:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442278; cv=fail; b=KlQqjxyio4jPa+ZRdxm32G9m/jZymSCLk6JTj7/1ZBuMX7LkuVTGX5bLWEB/c3AiPfdV7G71AccvBH33Sc/7kZg5rqlF4MMd5pdffSFFIPMdiRmB3lh7S/O3YTauSgHtcuBIyir/ajso2hUM3mi+66TEsjHbdMG72GSY6ciZMeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442278; c=relaxed/simple;
	bh=SO4IErw3P6J6uBsrZxj6b4tERiWyoOv4miWmXl9qo9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IcVP11fygeQhWMykAqebR56Scl0Zqo8LgOjikX539CcASpcB0FA4QdPQxMz2bbLRA2f/TLQub4Bg4veBU0+QMkfsPqKnWHZa69Ng0vQW0cGds9MM5wsUDEjbbGhsquroCvbZ22oUppYyIRQCTKKGTv2ObbrDIheNwOF5B3VN8R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XHjZOrxb; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvjfV4qngusA2fS5VGSOECn5Pa+UefH4jHMSXQGWABQho2uFHXOCHL3PAuNgHxk2E+oAZlclpsYPgRkiMYpbrcKPlJSDELsKbSBp/VawQFLxR+aPNfDJy5Ltk3ZAEhwhivfsjgVQh/upuK2nVYG/1MsHTEtSjzC4MFolCVC//gqwKzpQJhd3ntWjywW5vJ/VPJ12nHOrRexA737VE0YN2fFOkADPBFrNLEDPH2jpkN00EPVtinkryfFhFLeAeOtuZWDJUp0gq+rH2i77ZwU0P+xSJBi6zf7edDAxl8zrugtJ9BZtHJNcACHfetAuetz1zSrLaw2wlO4pZ+ORjVd76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbUEnmTsaqmLt/Tv32gEuCm07Y3XwTpw9yk/hfRyZNI=;
 b=iTOF4MJ83ArID9QUkBpi9W821P2t3W5xqS0DM1PsSKXVqCbB2KAmepSTXzyTUizJiq8H/ccWcpXxTNKvLpbMa4nQspiaLSY4wQuD0+29Qdsms2i68/7qHFUxLh5geunCCyQUOEXJC2WM+Mg3UYjhQjYJJmisu/ICb4o2u8DRxO2JNfo2dk1Wgr0wS9NbSFWidGTUdlVjr4PvRwB0qKr4W3tiplzE5T0EJIr0lGSCnAFVkSOR+8LcgIDimpqoUZJedDU0ZZLEHu1TknjG99QmaELbtcVcorbAyEt+6i2YObZLB8UprfHQTHbh9nx4n8UYoBV4NPYuw18O4RARqnwuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbUEnmTsaqmLt/Tv32gEuCm07Y3XwTpw9yk/hfRyZNI=;
 b=XHjZOrxbtRJOolqlW8yWRoe2PZ6iX7Y/0lHRAtAjwPEbrMkVv5PhSWwJb2Sd5RSPXDzeBk6EI9Pk8O4QkBkgtiIuQUzvE2XplH9LopFJRMet1E6JlduC8eYgrbQqQBYnieKtVeqH/OnRVKLILCTKQPCjEHLnbvf9CPPSb0uoWeOLFwXUAfjsX5s5Xuoj9JCgWVK/64ItLx+myXjD9zshQqVRIGP4UtObXxaq9XqObTOyL/bvf0qKdT2JhLIEGiHWuZEWvVfhFr+85sYuYtBk4Boy73xr9gAlPSIvn3LxisIpt0KbMhmPivf1ilFAk7qlhlcYX+85YJvInuvmc+clnw==
Received: from PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 13:04:32 +0000
Received: from PH0PR12MB7095.namprd12.prod.outlook.com
 ([fe80::a1a2:8f39:886b:30d4]) by PH0PR12MB7095.namprd12.prod.outlook.com
 ([fe80::a1a2:8f39:886b:30d4%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 13:04:32 +0000
Message-ID: <451aef3a-dafd-4754-8b43-066a1f204d2b@nvidia.com>
Date: Sun, 14 Jun 2026 16:04:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 0/6] RDMA: Fix restrack UAF in QP/CQ/SRQ destroy
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Chiara Meiohas <cmeiohas@nvidia.com>, Maor Gottlieb <maorg@mellanox.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Gal Pressman <galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>,
 Mark Bloch <markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>,
 Neta Ostrovsky <netao@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
 <20260611191104.GA1501742@nvidia.com>
 <5760fd46-247b-494f-9fbf-fbb520c829cd@nvidia.com>
 <20260612115205.GE1962447@nvidia.com>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20260612115205.GE1962447@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To PH0PR12MB7095.namprd12.prod.outlook.com
 (2603:10b6:510:21d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7095:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: d8018a07-bea2-4e8c-9142-08deca1579ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	RzYZgrdGgLJPom7VV9hjv8KURny4lvQtIkmWE9vNyU0h5E0Lbcztp1WbB78EZiza1q3NFXwarFvyQSpZ3yyHLUwDod4OIXcJFRc0wlHHpuI1M31gmhtlbomEopSLvRbG6vqHLhhqu2xUW6ouoOjcD9KgG/pZctyg2XubINrAkBTjXumbREzehFv93F9KNDIPGwOxY0IcGgOFpyRdtaVI3qmwJaC8Jgn0n3h2hK2PIxzpLNHbovqZQYjRcq/+vg3KavMXgWQY/Z6ZnO17CWMhrCUs+rYSg+keJAJ3sXRGIqt3plbvO2n3k31lK99ZbMeaoXlTPTaLisAdIoPd2INAwMkQQzxnuz5DY/tidKuVcylZYe+qt2bYbPeLBwCa0eCGkqKYrSFujfLnq2qtDSsQcQ/ymmkurt8XBtjBlSwaKgwMJ8Jz6mYvWJbQneGS4NSMVdOlkpWjwRhOtAftheFsH8I7O9HwrlMIeI/lymR9g8/DkysNkREIJZknrPRMEe4S11nybTBVyPrTuZ5CQ3+FTfiL7R7ucGJOq6hHWLmlqi9bgvXiaXCcLP0iz/GFwQe6v4BvLpJZMwsrsv2aCPWAr4C23cf9q0Vc/iPXM0HsA19ZZ0kn9W+Zbn31iHPX3mVfD00jmAFzg7qFvB3iNnpEwdgeqIp7WCN69rgDG4zjarDc5H0JjTNRTqIRqhzYRKc4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGhSbGIyWE9rNGxMdzY2N3RQOGdPc3ZManlRUTVZN2YrVExZVUVXOSs2c2RF?=
 =?utf-8?B?eFN1ZjZDSEw4Zm9PU3g1a0JPUWhta2xnSDBJUDBGZmw3aDR1ZG4yWVp1RTBv?=
 =?utf-8?B?SGNDeUE1ZGZZRE4rR3ZGUTBFWDgwRkhCKzUzTUhYWmRZL20rck5uQzcxb3hp?=
 =?utf-8?B?eUprcmxYYWtlL0lvYys0R0FXeU1la2o0YzZhMWw2QlZ1Snp1V3dtRTZmYzJq?=
 =?utf-8?B?UlhWV1BVZ3B5OVpGeTU1NDhidDBqbVN4MHJqNTlabGFFbnVJQW50UnNiSXhB?=
 =?utf-8?B?OGtHMm12amxITmVQY29NQTNvU0tIaEVBeFVWMDV0aEJSaUdEZTNxSlhxMlF6?=
 =?utf-8?B?THNCOGdIdiswK0t0bG9qTCtraEkwWlpTQ1JZQmdmTGJPZnBHSmJxYnp6a1U0?=
 =?utf-8?B?RnVmRG90Z2lyd3dhWXppUXd5cmx5N2ZjVTlmb1M4OUZiYXFackVxVVpYTGI4?=
 =?utf-8?B?WXZOTS80UEtreklZamtQUENGZ0o5U1B3NVRUa1NoODhMSlJpREtmT2x2c1Vw?=
 =?utf-8?B?dXpSbjBjUDgxVHYvWTJZKzhKVGRBdS8vcjFJbmZ6WXpJN1VRWG1GWFk0TEVX?=
 =?utf-8?B?OUJqNXd0S3ZVRXF5bXVtMUV5ZjRCdVFob1psa2d4azNxa2hXUjFuZ0xoQU11?=
 =?utf-8?B?alFCb2MxT011Zk9sVUZLcnB5L0RIT3BmTnVld0NuOUlPOW9yY0NHcFhlU0Yr?=
 =?utf-8?B?THlvbDN4QWM1RERsNS9nb2RjMmhVTUUxMEhaNDQ3LzBqWjVPSytJZW9BSjZO?=
 =?utf-8?B?YjczY0phK1ppYXVhWFFrbkdhZTU1WmhPSXVmNkxUM1dhVUVqdU83RzdudXdR?=
 =?utf-8?B?aENyanh5dllqQjZXbkZNSmw1dnBtNHUzRm80Tzh1RmJMN3JUVGx3ZC9HeG5R?=
 =?utf-8?B?RUtIWUROWHVSUlIzbUIwOTlYOVQrdmJ4WXNQc2ZKNFY0V0ttVHRPemIzVWE4?=
 =?utf-8?B?Sml6V1ppVll3eTNHWWk4ckgrYjlFSmw0eitFR1dOZVB3RmRLd3JyTWk2b015?=
 =?utf-8?B?WVFvVC8zUmgxdmZNaVZ4YXR2NzBabjBKczdPLzI2ZkM1ejU2Qmg2amQ5UjVP?=
 =?utf-8?B?UFFIS05LaXNDUkdGQWIvajNUS3VSMU1oUWVyNmVUNjFSdEV5aDZUQlZGbGs5?=
 =?utf-8?B?cmFOSWdXSlk0dFlvU3hSSFlIQUJWRkdMcFpGMlE1eXozUXl6YklkaVAxS2kx?=
 =?utf-8?B?dzcydDZYMnl4L2RkQ3dZQTEvdnI3SWgxaXpaRUI0QXFRZWJUODhmcytwK3I0?=
 =?utf-8?B?K2pRcklLTWZ6cXZNbDByU0JWaFBSZHdYREdZaGVZU2FXQUdDdFRmWFpoYXNN?=
 =?utf-8?B?dkNuRXh0YWdiUy9kVXd5NG9JS0luWFBJSk0xRjNtSHh3NmVzN2FXQjVqWmxY?=
 =?utf-8?B?NVhTZ2o3aFgwRDUzZzFoek5QelNDcWxRZEVYRVM5TDlwNEpqRlMwV2g2dEdk?=
 =?utf-8?B?NFYvcDIyZlFYNDRnSW10Y3ErNk9MVzVjTndjSmxWYVRkREl2aUIvSFZMUVBX?=
 =?utf-8?B?MmtoTjRvRlJlVnNyRWJ0akd3OGNoSjF1NXV2R0lqUVlHcXBpQURkM003THJT?=
 =?utf-8?B?ajdGMEsrTkNkQ3hhK3BsLzFzeUpZeEQwZ1Z6aXNEZitGVWJFV0NySlYvalNF?=
 =?utf-8?B?Z0dxRnFaTEJsajJwKzNFVllob2hmdTIvZmgveldocXhzS0JjM28zMlBLWjBw?=
 =?utf-8?B?eXZpTlRaaHppaTdDUkxtSGowOUNOaDkrMzk3dmZaZVBEZ3E3d281WUduclFY?=
 =?utf-8?B?UXlHbjY2NlFoVTEvZDIwYXF5ZWZRaU1xOWdoNStCampiTjBOc3gxanQyUmpQ?=
 =?utf-8?B?c3pXNHVWVzd3QW9kWjBMRUJSVU9mcmNDcnFWNUFlTzY0dFE2c0RuUURBcVBH?=
 =?utf-8?B?YzFVQ1hQMm1pSkhhQ0wvMEt4cGtKNEc3bnZNM1JFYkdCOG4vcU4yYXR1MDZ4?=
 =?utf-8?B?NUV5bzZUQU01OW9qRGhqZUxsb0FDOVZZZTF4LzIxR25PVVd3Tm1XLy9lSUVR?=
 =?utf-8?B?UlNwWTZxNittRDV3aDh5OENGaWUrWVlEWFhSUDY5ck9ZbU8zU1o2bFpXVzda?=
 =?utf-8?B?MEowbjFNVmlFak95QWV0UHlsYlpEWi9jM3FFMnNZcW5Gc0NjQnRwMFBPSFVF?=
 =?utf-8?B?TVQ4UTBmWUJwYlJCZVBFK0hHTVpydERtT09Ycy84SFM4OHBrL2Z5QjBJSkpD?=
 =?utf-8?B?VmpxWUxmSFhOSStUUytMTDF5WVFMR0dzTnlmQ05DMnloSUlZMmRFL0FjMkVQ?=
 =?utf-8?B?cjB4S2twWng0RHhuRVZ5cFAzRkljdjFUcTR6dEVQWnVacXRwbmVxYjVLOW1n?=
 =?utf-8?B?Tk9DR3hRYzREQnVBK2ZIZUxUYXlvRmM2R1k4WVVUNmZ0MHRJUE41UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8018a07-bea2-4e8c-9142-08deca1579ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 13:04:32.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e01Us9fnfEjVPEaJuHLZ+GmhwdM9C4D+0Qn4swRN/Sa4Cbv+l/CmcXB50nQxZGfe9xCR4pIqgtEGfqwe4wP8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22213-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:edwards@nvidia.com,m:leon@kernel.org,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[phaddad@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phaddad@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBA5D681100


On 6/12/2026 2:52 PM, Jason Gunthorpe wrote:
> On Fri, Jun 12, 2026 at 11:53:23AM +0300, Patrisious Haddad wrote:
>> On 6/11/2026 10:11 PM, Jason Gunthorpe wrote:
>>> On Sun, Jun 07, 2026 at 09:18:07PM +0300, Edward Srouji wrote:
>>>> The resource-tracking (restrack) database is the back-end for the netlink
>>>> "rdma resource show" interface which pins objects with
>>>> rdma_restrack_get().
>>>> The QP/CQ/SRQ destroy flows call rdma_restrack_del() at the end of
>>>> ib_destroy_*_user(), after device->ops.destroy_*() had already freed the
>>>> vendor object. Therefore, a concurrent netlink dump could look the
>>>> object up and touch freed memory, causing a use-after-free via
>>>> ib_query_qp() for instance.
>>>>
>>>> Fix this by splitting the delete into a begin/commit/abort sequence:
>>>> begin_del() parks the entry as XA_ZERO_ENTRY (so lookups return NULL),
>>>> drops the birth reference and waits for in-flight readers to drain,
>>>> while keeping the index reserved. The destroy paths run begin_del()
>>>> first, then commit_del() on success or abort_del() on error.
>>>> abort_del() re-inserts into the reserved slot, so it needs no allocation
>>>> and cannot fail.
>>>>
>>>> The first two patches remove DCT and raw RSS QP restrack tracking as
>>>> they have never worked (their ID is unset/reserved at create time).
>>>>
>>>> Signed-off-by: Edward Srouji <edwards@nvidia.com>
>>>> ---
>>>> Patrisious Haddad (6):
>>>>         RDMA/mlx5: Remove DCT restrack tracking
>>>>         RDMA/mlx5: Remove raw RSS QP restrack tracking
>>>>         RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
>>>>         RDMA/core: Fix use after free in ib_query_qp()
>>>>         RDMA/core: Fix potential use after free in ib_destroy_cq_user()
>>>>         RDMA/core: Fix potential use after free in ib_destroy_srq_user()
>>> The pre-existing sashiko issues look real too, can you fix them also:
>> Sure but one of them is a false-positive though:
>> Before destroy_qp() is called, the counter is unconditionally unbound:
>>          rdma_counter_unbind_qp(qp, qp->port, true);
>>          ret = qp->device->ops.destroy_qp(qp, udata);
>> If destroy_qp() fails and we abort destruction here, the kref on the
>> counter was dropped in rdma_counter_unbind_qp(), but qp->counter is never
>> set to NULL.
>>
>> This is actually wrong the qp->counter is actually set to NULL(inside the
>> driver though not the core) so subsequent calls will hit the NULL check and
>> return safely.
> That doesn't sound very good why is it like that, why is a driver
> making any permanent change on destroy failure?
No idea but thats totally unrelated issue so not fixing it with this series.
will follow up on it separately.
>
>> I wonder what about places where switching to commit/abort doesnt fix an
>> actual bug.
> I would change them all.
Will do and resend in next kernel cycle.
>
>> and ib_dereg_mr_user() actually calls the delete at start so it doesnt have
>> this issue (but it also doesnt readd it to restrack when driver OP fails) -
>> but here I think thats by design since the MR would be in weird state and we
>> dont want to track it ?
> That doesn't sound right either.
>
>>> I don't think this should NULL the task on abort either, it doesn't
>>> seem necessary.
>> I dont NULL the task on abort(I do NULL it on commit_del() though , or were
>> you talking about the restrack_sync() ?
> Since begin_del calls rdma_restrack_put() which calls through
> rdma_restrack_del it NULL's it.
Oh okay you mean rdma_restrack_put calls release() not del , but yeah I 
resolved that by checking if the resource is still valid to not 
release/null the task.
I'll refactor my code on top of restrack_sync to use same shared 
functions and add few other places I missed and resend.
>
> Jason

