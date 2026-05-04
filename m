Return-Path: <linux-rdma+bounces-19903-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCQiNVBM+GmQsQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19903-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 09:35:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3950D4B968E
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 09:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6612B3016C96
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67962C11E8;
	Mon,  4 May 2026 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AdMaM5Ig"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2441D63F3
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880059; cv=fail; b=TV64KCJ+8AT8h47wEBrekOpvbPMiBhznE7h5Fts7dLcgOHyhOAjqePoEUMpZaWPiXTTzixn7AGXS3O8ejrzrSjSh3nwViIvEbAypE1rTlGvkyYtd/4YAAfDEjfGlzcn2/iz4IlEJpJf1cC+NYy/rxAzkY0dw61Pf7RtwYTFTkWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880059; c=relaxed/simple;
	bh=i1FuwhtP906exgG9eUScHolRX+KNzb9LfXDYAv23mnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5zozIAILN9aLZTQm1yQElD9bewwu5bVvlQ9mi1234itjCc3yGvqw/3J3uyTwHMo2uAvBy2+Yjzs8WbjjcLTazd0lzhHgM006Yr2RhgkDKYirm9OXfD/ziipjNsUUW5SNjFrN7IZMMcSvVFmPnaFWL8dMvtPtjAMaIzz0sK+kbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AdMaM5Ig; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifYnyVt8i8rT+eSxb1PiGv2mNAsBt7ZOv6JFRuYx6dutLkxYO5SIP65MvUS18t3Io6U6DWHTcGCrjDoFd0n+G96W66VG2GpOdU4Pd3Y5TWXb/ias9tiORu5iWPkyrJBGIP6/krunTNVl37ToOh9zNXHJdEyZ46q10Cd378p8bTsfReKAjban94nXEKFn03RIDq+XNOpZQcwwORyLjuiyE0PyGQ9c6GQ28Qmi5E8uXYsfbjBLu+1hdWjVOTDrj370Z+lJ3oOtXD3j7aUYwAigUf4QyHYVABUdJVetlCcWaoijMWTcVpxha8GLyeTE1H4QWiQLxmheqF7+pxg9oapoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1FuwhtP906exgG9eUScHolRX+KNzb9LfXDYAv23mnA=;
 b=PYT4s84Vmrlugk/YjQajuYl11w0UqjMtklIwdMJ9HnuORGtym+nO29MRPa40rdZ06oBND/T3w/c3yGeKmLu1DL4FyJmms7DL0nnmsRxhWt6L+Nb9NSX6v+Q61N3wPID9Y7dW6ZT1vXcxig2fhlKiOljLIT9ByB8ljirohmdYXIabIy4neVMwqQ2uslQ8vb2+Faq6VixI3heztrKf1eGA+NkWChydvjBqxCcSx5uqoGSNXzsJRuxuknipkFpgS0JfqCz1oPLul1QT3zExa4D111kz4zf8tdir1aQHiba4oVZPwA58PGO7oOW5FRp3SNhf294CvcupQqG6Pl5rr7ja7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1FuwhtP906exgG9eUScHolRX+KNzb9LfXDYAv23mnA=;
 b=AdMaM5IgkCig1I+re2WnikUnB7+KSOG8TcHmIYmQa/G7B3bByAAqhlx+lU4mUJfN+6W3pLXMzo1y8MPcLpeeOJdo5i9UKQ6ud1ftfwgwjPZl/4FCP+J0V2bB9Be6Y4UklRlD6W11LeGQjiFZNCqtqmRgeacL9nsMHGATIUYFs6HSAkldczoJ5n1xDKlE3y8FaGe+CZbzAxwif16vEsiTsBMX3WIEhc0Lyvkr6mpB0BjRewtBzhalKgwtHq0A9s2aSOhr41mtwg/7I1TDSQI8ocqdxWtO0WDdf8imaT6VxXBZDJGcuJJIcjIgkyja0qdo3g8s/DlcR3sf41N68S16ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:34:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:34:15 +0000
Date: Mon, 4 May 2026 04:34:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Yehuda Yitschak <yehuday@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Expose device P2P DMA support via
 device query
Message-ID: <afhL9DLUVhnVyzZu@nvidia.com>
References: <20260503150246.2349679-1-ynachum@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503150246.2349679-1-ynachum@amazon.com>
X-ClientProxiedBy: VI6PEPF00000206.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::90f) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 465764e2-bbb5-4850-72f7-08dea9af8aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OxQtq+8gNycZotXtaZcmJ4lKUDYQ4a2o4Cou6+EEVtZhSU3RL7PDAR3mDWDGXS4Q7j3VSsbJQ/ZdN1XKw64nXyg7dGh6xoj/PpPr4DeBPBkG8bRurSZT0NCqNZ9qrStjKlPyweBG0fT2DERgAsXmZ6SJLy9fHBTpIldQ8vYexkXsWxjrSEzge6eOlJFCr/xfVub5RjkCmEck9Av6FqOKhMfaSclgsntlzQY4GSwTaO5dOeqPwMQ3tirkqeJdpHSEYpszU2RSNV1k9cG6PVsI2LzqIOwORZGSqFpv89K6wS2drd646qs2j+a2CwUZc7q/fjzveETggsSzkcnSW0zOD5zfXS2rNmk23HN6JU/CISBgMiP50V/chMUYbkJvfBoGbIzKFz+zi/ZLymKEKkyUuiZfyW1E+yps7xPsMFq1NY9elJ95T4P04p2U7LWumGQaO8N9ZAjJSJzr/hnv7OMPOuSFL7f+O7bmGFUif0rXUkTj3Kfvs2ILydldHOTUB0KwffMtihAL9GfApz/p1vu9UhSA9Dxz/9qZMgpAxADMWeJz5IsjoEcQu1xRgHEI843ROSt18/IaDWSMhz+U1NGA4Od+Y9GgarnYDA9zJ0IYfTEZDkh4GQPta+rLeJtd/qEUcCTCnpqr5NYrGFHk/2qTsqFhATC318G+PLX69Kx+8/Jk+lNCfeSYM8MKgqkKdAuI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UJM/ZnKbbwLyzxKrk/fLP/ozR8OKrEn5MXLSL58HJF5kkHp05Yk5Y0Ko1ZiD?=
 =?us-ascii?Q?mu2+PxoibHpcmCVWoRsC9JazSi78yoEuRjNebA07YQEF8Qv0qjqMJQ3iIqDp?=
 =?us-ascii?Q?TbyJta4GqDY5ZPquhdGBiiEkIjGrRweTIIbHpK5aTdc9AQQEX6hIOWbsLwzy?=
 =?us-ascii?Q?YSDzZ+8JAxGPym8ljYfm6Wzp2nbh2UGer4uO2s1g0ECxq+g30Lb3xJfX6QaR?=
 =?us-ascii?Q?EhYVihZsOIxUJhwduO3UKiM1JeDbQHVLNq4M0yUlgI8CvA8//p6ifIaa6AGE?=
 =?us-ascii?Q?rATkv/LcF6T0mmYmlp85yFVpyR+YU9thdYmuPZ65Jd002mH3mXxKyt9j8uoc?=
 =?us-ascii?Q?A/FGw5yWU7sFlcmnI1YU0nmiJ28uti6cQ+bT+clSmBMpGbDDOVsBbDoOHn3G?=
 =?us-ascii?Q?R+wkUUHzRfqKlRXiN8R5iwhDwgYF6injlyXYVoGSs212N0JReaC7OoIxHrHE?=
 =?us-ascii?Q?FGOqLb1EN+mcoeWN5c22RMDOzGadILVXWDxn0GwC/wB2wIvmWAEjExW7IL5X?=
 =?us-ascii?Q?a85k3BrS6fLUHIVkADengQnSZZnw+MS2NtkJkxPBXj2WQTXuECzjmKKT2J8W?=
 =?us-ascii?Q?Av5mBAbn/ljmkNdAj11Gdlj+oOd4s86ambiUrB8Oi02Pyoa5fVlHUQFwyteY?=
 =?us-ascii?Q?03i3qW5s/LPu+hG8Yr+qGObfdlDJcKp1aQ1OzAVuK7acQJJWrIwl5vFv2/dh?=
 =?us-ascii?Q?HL8RJqtqW8PVHdr8QfxAsQ79xI47mEgAqPNQEdkUt5zFAsa7gE1LvHYwsU61?=
 =?us-ascii?Q?IMP1dEdrxMBEZ0ilqsuE9rNU2f/k/XgQqidzfjYQZ7AX/sCr4QFfcwQNB4/o?=
 =?us-ascii?Q?7UVIV/9na9vw2wQFiTsccPXWywBtMd9u69kb174ecMoLigtnTW6dpmqTRvHu?=
 =?us-ascii?Q?53BY8Fi6gAlG1MryUD7xC01snZ9nNMIHo+EQEjb+KD2AWYpuE4D0WEeDvO/8?=
 =?us-ascii?Q?pydlJffgSlIERGu8zxRm0fUx7lICTfYmPjmYcwobolaD5AyN6ATe+d/hDIls?=
 =?us-ascii?Q?3rDkrDeLMN/FET0ntZlLxKM5ldqCEwfAM50ONFkUPh9mzSGNHLjQ0ot9Hy0z?=
 =?us-ascii?Q?dGGVu8W8zPksjmKgOzhm2Z1j2WE1LxaKtGN2VnmjskFfOT+bj/6lEGP/yaYD?=
 =?us-ascii?Q?FpJaoSGJWkHyHWDHm7rQ0CWNIEiugGtxoEhHSqXcR5Br9Ku6eDeKN7JQPcOa?=
 =?us-ascii?Q?8RITUtlNALT0fAp7DVMbm1RUW0EbdDkl52GQvSS7ukOwULX4xYsaunKJH5J0?=
 =?us-ascii?Q?zZEltC6+hvN3Zla8laz9gJHWAilc+F4umgZ7Hv+Uj+323vPDY2FuG36NjNPY?=
 =?us-ascii?Q?kfBUxf7SCvC0QfdGWzmbnL/sKx6Q6hHN2DjMvWhyWtMZ7tabA+ssHrbpuCeN?=
 =?us-ascii?Q?WY6ha6cYIR1sDPF9rD0odJBTUKVfRQ3MZr3NF56y6e5a3GItRgBqwxzXhd3U?=
 =?us-ascii?Q?RihAQycgkGALgBQI6/knrs7IMkjXXDuVX430GTHmtCQsnPZCIQpS/EbczuFT?=
 =?us-ascii?Q?R7Ok7ugL7oZgVrMzSEpSUWYxHja5O6RxdpiqEVdqA1aA4q3qlYHz7WGv28Oi?=
 =?us-ascii?Q?WVo6oJW6V4gIWRemLhnbQzMZ/o+lEzqrqzLF/HkAOXwR7tv6Iq9UZgy5hkcX?=
 =?us-ascii?Q?8ehWs03lelzuWS6EQdXE83SSpURKofP6anFG+iunBu7EcCwRdsiecPKJ0voZ?=
 =?us-ascii?Q?21eGKSPy04tvP94Jus+AYLE9YQtA/Bgh/+pmQvBBCZakXH4F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465764e2-bbb5-4850-72f7-08dea9af8aea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:34:15.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zZg/zI2QTuspnI8urWe1ckgS2KHk1lUZQx9ohk2eWlFpBhHhHyz8KmvmuFPKDoy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
X-Rspamd-Queue-Id: 3950D4B968E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19903-lists,linux-rdma=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]

On Sun, May 03, 2026 at 03:02:46PM +0000, Yonatan Nachum wrote:
> Expose device P2P DMA support using the query device verbs.
> If the device support P2P DMA, it can DMA directly to and from a peer
> PCIe device

This doesn't seem right, this should be policed by failing to
established p2p mappings and to fail mapping dmabufs not with random
user space bits like this.

There are lots of things in our system that need this feedback to go
down that path.

Jason

