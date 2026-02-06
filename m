Return-Path: <linux-rdma+bounces-16607-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA1INz9IhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16607-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB95F9066
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB773046523
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E724728F;
	Fri,  6 Feb 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cw2NR8rM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A723A9B0
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342351; cv=fail; b=ZlBlQL3EGUmdkNDuk0DW4DJ7GkuZ3UI5MBQQr7fTf3Ob2ywzZt72qlRw2znOXkWEhZ6tPZy4120wzn/GzGYJQhnOMNRgGxh3MPnIDfLtD1quWqA3C6xtsQSnL6Lj48sPAnGmCtkTGRUXZq7ygLOS4g21ztxMIF/0fAlGjakAzZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342351; c=relaxed/simple;
	bh=L5qYhyuQ2P6ZeBRSD7Z2KmDt18wuNKLQdsKjXRybg0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WXQZR5RRHPzAHte3YbZWeI26fK72ACc2yJGNr2/dMn/JJYE8yN1UtKAdjefPe64+0TsOPI1rMpwNcsN/ysulnW5AB4n5vDbP9RsoPJJoq9VPyfWHNDiZv9VL82fh2H9pfaCjCNMdNxKYuZ3dFQmUZVZWZWhwIVXrVzqJKPiMewg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cw2NR8rM; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr2QM3gcbGK4IyWFO3eUU+bVLzogV0CQUj64y0Cv9qtXg/VjfjFNUHrR/M0Dvbq5y8hwRJi+buVl/EhQCbSjld1tD5ewEQ4BnRJnkpHJkLGFbqbPqr/d844vpeYBccqD74+noPEnSN469hfjbJeznVwR0YXQqla0vSvhMLhcctrJMrGyst/rhN+2BA9RQcIL8CjEa679UZ6B7vSPi5DMcTdRQX3MFu6qHX6/H3aA6g1ScCL8StoUnt+spcN+EL7czm/f1KbSG+8CyxB9fw1/UzxA/O0rHmerpnz2r+p3wX38QuKACCJ/CQ3giAyyzYrOwdx+d3WbuXWuwzWcSJkNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOMW6JCiijyQW7DEFckc3ZBj1SdXD7pERHh82qxCMCQ=;
 b=wvp+nqwyNfZB+q0gygJKoqlQetOj0bmOVO1KdmpZE9jGLCCz0NcU0YekR8Lb4LPuEOdPRwCHK9gEmczEneAcLCjSCtbTs0hhiQoiN4fK7lW9TbbfEDmzpHRvq29zTsesTjcN7ez4PIwdjfu0ct2ENkMlTUlV/AY673LMZ1vZmoZo3GWkiM19a7SRnGOIj2lsca0v4QZvnuul33s5q7BpalYm+7piIsWQsMxjWdCau2k7oNQN65XYwU2rSkwMn03Wsvarj8lNkm/St/r+tgBFJ/u6E5MWwshf5mUonviyxLDZlxsa99zsKX3rf98FC206fzqjOEOyXuolKzYiohVWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOMW6JCiijyQW7DEFckc3ZBj1SdXD7pERHh82qxCMCQ=;
 b=cw2NR8rM4rD9SHoJTo2O93YS9jrdqDlaPWRbhGUyUIz0yQNrJuVwMRsOxdXPMWPwGKhSrH94B/qeuLj4KZ/+JrZxJoaldkKPIoHW4yW5VttlxkkoW+52q7tmOM5prtpt/XdOIcFOCE2kJK1bQcAY1FHnsHRr1ISjrPBGlSewMR89WxRaeMUMdAhCOwWrWhaM/P1PHm3Jao0FYG+t3u0Y2novr2L2Uy+ysd4cSF9vWFFnu7leDvUyHRVyMbMb+UY3DlZ0uMzJnmcPltuIdYEFk14zBG9Hh+jULLn8llsDl5xbBnaIH0znizTovsEvhonzgFPYFXiXH9M+CMwAYjnapA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 06/10] RDMA/bnxt_re: Add compatibility checks to the uapi path
Date: Thu,  5 Feb 2026 21:45:40 -0400
Message-ID: <6-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0032.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6e3dff-0872-414f-b46c-08de652171ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?KymIUngKdwSrUDH0g/IXSIagyCc22FearbkOLEhvWLsp7rOIm3eTm8k/olAQ?=
 =?us-ascii?Q?Ymosqg4+m7SmNIFJ7h0t6sGjhFohr4LPoTfIThQefXbiA3BIXexewl2K6VfS?=
 =?us-ascii?Q?OMTlIX8YGgy6dQwLdDEoahZ6ZmGBOSeR8znZhF1qTQBqo5S9Ef6vAAVijqqh?=
 =?us-ascii?Q?xjEoMg4oilRbvhisouxBTSFb6BntWcmqB0omIv8sNexXJ1awKrohBueX7ZaK?=
 =?us-ascii?Q?tIUiUV55IcHRep1FHd0LcKQvDknd8AflR+KW67bRrd+SrqqEieCqTW+fzIkc?=
 =?us-ascii?Q?piEVQ9fCaWnGMIyIk/sOE+wdlkvkfz2JdbU3nHetQ/+gOr4bw5Eh1IPmr42X?=
 =?us-ascii?Q?pfXJjxTdIKFQCjaJ96A5SGLnY+I8Lllwc0KgtdFRy2Ckh+jMBHz8RYNZ83B5?=
 =?us-ascii?Q?p1haVB9cUirNC75zXF51zoaO/dJkpG8XWLVE1DN43gdN4IuJUYb0KVuVF+mQ?=
 =?us-ascii?Q?HNhbiOI13GR19AsVTCjiie/aWfrNimr5NNHuOVpstPGDHMWEA0QtmLuEoPwK?=
 =?us-ascii?Q?bAW0rGFnxPLaE2kI2dOCAdxjc2aIWQfqMhoi9ZNTp0PoIBPcAsPMvIKk3Zr1?=
 =?us-ascii?Q?9alxUbAAQCea9gv6LtMr6tzOjipxJ8S5GvUM3XOWv/BJvHEtiYUwtvSrMMRp?=
 =?us-ascii?Q?tsKTc98BGpxB/fx8zi2y9rH/TyWf/lz7Pq1fKUtJbbMvTnwUdFwnUm8RJL9G?=
 =?us-ascii?Q?j/yZA+7BugkcuS4h3kzzNRmhxJnlauHQWefvuZGcbx5Dykka2LLBOvdRgHOt?=
 =?us-ascii?Q?Aq/GRTDnlmBfyOJmmlyQmtLRs2v68Fg91tp/MKrtq749kS+pa8KUIvUKAO9v?=
 =?us-ascii?Q?dPYFIrtG2OH7h//IXFykGcznkSnGdk0rp/21QPFcGtgj1m8fYUs/jVuQrv7H?=
 =?us-ascii?Q?Y5aXri3jUZ0IL6pM7NLrANhyyt9H9T8vTHUEjj81O2Ic5GGdkWKaWu/sG5qA?=
 =?us-ascii?Q?VqjW43XiRajWsGaYcoxkoiE6CP8XdQf8Ve+L8Dkd+CV5bBnLmIIaKnIkp20U?=
 =?us-ascii?Q?ksW+NulvH4aNBCIL/VcswREh/FgFU/ACEBDh1E1do44KBH8Vqlm2m5uIV2+4?=
 =?us-ascii?Q?3TNdE5oHioTEN//z2+h58B/t3X83sBqJV/eoB8nu+/O/+f3Em7K2F3dzhu74?=
 =?us-ascii?Q?reBMbNkq5QaB8TtvkCJ6sTO7jchjeja/0KvPIVx3wk12xmYLKkoHJw6woum/?=
 =?us-ascii?Q?0jfJQLI6ndlQLQqU68E7XyMrY+XvOiQV7PTMjluuXYVn4flQdBSsy1cqVrvn?=
 =?us-ascii?Q?ABnkI4MpLKF1CNHOQZcZsxCpWKmZBAz1kqkynNupjz0MfDf0cHtbQd7wmxnK?=
 =?us-ascii?Q?cMQWJEvefEBwyCE7pom7Z0k0JHyhlfTXlu1zfI+cbHvcrYuUQTLFGnkXlEs+?=
 =?us-ascii?Q?uLPVl9qYamWamdZnpL7ct9xS0j5bEoEJ5ViBc5V675U35nsa0f4ccenECN/+?=
 =?us-ascii?Q?m6hKUtuWmvClYHJyL6V1AO4UENHvu0Y3uadmcJlPSqJCtPNoO/IeyvlTVL4/?=
 =?us-ascii?Q?CvT7SsEkJiHB9PV/ajRl3T7rQNlxGVgvr7etuKhR6RN4ih4ts2hg0nxIIzUD?=
 =?us-ascii?Q?ju/Jgc10RC39B8bJ7GE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?zRHzKxPWukjHeVfKmrsrF/qc9nDJOicqYn31q5UeCakwXlY32DyFLvgA9/EG?=
 =?us-ascii?Q?7pHBXUIWRDrbryvrJYHrcLBX6UkvMGclceQh0IScHRijmzu7fmtt/K7ccBHD?=
 =?us-ascii?Q?cnSV+3uRGN6MYvK56vEhuHPtWI4R1D+fntzO6Ml4piYf+h39FtjLrARqWgHd?=
 =?us-ascii?Q?MbYblB6iBNuuc34GkSoO5AN9tpAn1DSNpopvAMnCpsSUU3YtA/E06x93/J8i?=
 =?us-ascii?Q?d+hhlRrMFdeignOJsGCMYPxFPdXyt3brWl+5uG/5WOilgm1Gh12mV6WurQPx?=
 =?us-ascii?Q?4xsFD20ouMlJu+fGgUCGbry3FPQTZU+35oEx2ZJlvkvvy8IxlcX9jLVCIxFP?=
 =?us-ascii?Q?G7hl6qSGLjAX6owRhrbuAN6gGc5G4I037jrSZOAvaVltS58KeIalKfgb8Prj?=
 =?us-ascii?Q?rsmjdKb9lIiyspop+WXuAVx1E1OF9emqpzTSdwDfNKe2ISuI4MRs50puyvTG?=
 =?us-ascii?Q?2rpudFc0clrF62VIzPZy5esg+xi9FBGKpC8q0Z6Oup+rPBKh1O+4oqYD7AgE?=
 =?us-ascii?Q?S/8vKUrqpxxrG3052/utVKFfISKij4uvitYjsSJ3XFwUSm7KSiXu9HznbMd1?=
 =?us-ascii?Q?m6CIUlTHCeWBBnSGdSqlNwCvJJubjxM6uLDKAjb9y4DvVlW8oA5nRVoPTvAT?=
 =?us-ascii?Q?tRmx+BzzpKmm2zxoVh6clwRVv7m1wwK7rdWhrQs1RlpRzQtPx6gHd1KxneD1?=
 =?us-ascii?Q?RDrun26t5Nx8aMXP1cv/bFpiraY+JimjqLcc3D12IrYC7mCEePXapxUSY6dg?=
 =?us-ascii?Q?/5TjO6SWd8u83oLdBGWnHW+OdH5X829i90g6KRVtDpPRv8i6EJoRp7phcdtK?=
 =?us-ascii?Q?UlXHr6HP/2i9Rglle9qYu84njeRkCIMOaHyBSgof1ev+cysUlrDL0rcp33yQ?=
 =?us-ascii?Q?03Lu2AAiQgtlaDeZvZpT4PzHyuUWFRVhbfbGRTTQAjue7ZPzXKQsYd58SYGE?=
 =?us-ascii?Q?CJH7nWzDb28CCX04sjkL6ZYyxyM+BNbHoMI+Rg0giYr2Gn9oVHjtk8JRy6Un?=
 =?us-ascii?Q?56dMAz58OO+Q9uwZu7dO8Zk/f/fjj2ALCn0FGi+wzEgIDJ39KX6jOzLOUYee?=
 =?us-ascii?Q?mIcbHY8GFOx/w7XjirZow8L8WJgafsG3vKYRu1Rf15s8Fn1eh+1+vK7UWVfU?=
 =?us-ascii?Q?27JaJvzySLH1oNCBCJUETu61NpjY5q1jToHM6nwmEN/lboZtxNRzIsY++Zdc?=
 =?us-ascii?Q?MMlLXMRs2IEtFXCJk2bixeNwUXQ9YZLcn79Zmx3D/PUxO7hn/JHLCwwEIlPG?=
 =?us-ascii?Q?NFKaPP3CHgjYitESwYwwK9VdobzBgUuzTWIpZiE15K3I5eq8mo58ia1wWf2G?=
 =?us-ascii?Q?slSVa9uiCPL7EVECyU1Hx1fT2tlET16MTBmdKw4Vn29SCBFb0CFSt0R9v1YM?=
 =?us-ascii?Q?/RV7bMSKbn3Rxs/sU6kx2xhX6Cw1Sv6ekollCLszzxhk0NTpbgPWojobxV4g?=
 =?us-ascii?Q?JyCIDl3nP66plD7a/78q0s14H+Hqdlf/Z9KtjOdrgDVJ6Y9PSZnGoYi9fmbn?=
 =?us-ascii?Q?UuXGU/I7xAx5GfGw3O7HzFVth9Km/yDtpeDA2Rg/8eQuDIoLmBLdk5yHUUFO?=
 =?us-ascii?Q?O/Zh/yUUsAP46KGXeB9Ax5pjDBG29O3p80RZ33OTdUqNSfBN7YeyKiUY3r5N?=
 =?us-ascii?Q?YOGzoVWx77bil+Gh7pB/PfVac5+RuWlYazc63hLbpsDfCsvIbEXzDEVH6BqV?=
 =?us-ascii?Q?uFpyZuDV4SFVkBYm1e2VwWziukwLZ18Zx989t8jWIPI0O41dfg6GVkL0e0be?=
 =?us-ascii?Q?FJjpeSc4RQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6e3dff-0872-414f-b46c-08de652171ce
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:45.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC4gZqUv+P2DNGfmPXI1J9iHOBo1JWmCIJDJvlxOTLwTlGtmWA5TSWKSz3z2xpjg
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
	TAGGED_FROM(0.00)[bounces-16607-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 8AB95F9066
X-Rspamd-Action: no action

Check that the driver data is properly sized and properly zeroed by
calling ib_copy_validate_udata_in().

Use git history to find the commit introducing each req struct and use
that to select the end member.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f19b55c13d5809..2942ff44f6a547 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1655,9 +1655,11 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	if (udata)
-		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
-			return -EFAULT;
+	if (udata) {
+		rc = ib_copy_validate_udata_in(udata, ureq, qp_handle);
+		if (rc)
+			return rc;
+	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
 	if (!rc) {
@@ -1847,9 +1849,11 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 	int bytes = 0;
 	struct bnxt_re_ucontext *cntx = rdma_udata_to_drv_context(
 		udata, struct bnxt_re_ucontext, ib_uctx);
+	int rc;
 
-	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-		return -EFAULT;
+	rc = ib_copy_validate_udata_in(udata, ureq, srq_handle);
+	if (rc)
+		return rc;
 
 	bytes = (qplib_srq->max_wqe * qplib_srq->wqe_size);
 	bytes = PAGE_ALIGN(bytes);
@@ -3156,10 +3160,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
 		struct bnxt_re_cq_req req;
-		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-			rc = -EFAULT;
+
+		rc = ib_copy_validate_udata_in(udata, req, cq_handle);
+		if (rc)
 			goto fail;
-		}
 
 		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				       entries * sizeof(struct cq_base),
@@ -3289,10 +3293,9 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 		entries = dev_attr->max_cq_wqes + 1;
 
 	/* uverbs consumer */
-	if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-		rc = -EFAULT;
+	rc = ib_copy_validate_udata_in(udata, req, cq_va);
+	if (rc)
 		goto fail;
-	}
 
 	cq->resize_umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				      entries * sizeof(struct cq_base),
@@ -4391,8 +4394,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED;
 
-	if (udata->inlen >= sizeof(ureq)) {
-		rc = ib_copy_from_udata(&ureq, udata, min(udata->inlen, sizeof(ureq)));
+	if (udata->inlen) {
+		rc = ib_copy_validate_udata_in(udata, ureq, comp_mask);
 		if (rc)
 			goto cfail;
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
-- 
2.43.0


