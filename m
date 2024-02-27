Return-Path: <linux-rdma+bounces-1151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C80E868AAA
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 09:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9781C210B3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ADF55E78;
	Tue, 27 Feb 2024 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e925k+me"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413575644D;
	Tue, 27 Feb 2024 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021852; cv=fail; b=JafJ5oVMbNE7MGGxsEiuO3pUeqfaWL8UptF9LLDbgzu+IZJgar8a9h2OmPO89WDSJhZ9iyIC/Nl9MEKXAecPQGbkbVEbEaSxikMzIunxR9Nz+LcQtSRtCNMdvTpHXXk6LKSb1JFeZCqFK+1WnoBX+74gv3xFOm+PzCM6I099pok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021852; c=relaxed/simple;
	bh=yUTzE0cXUTSkw2DcOEPWVytIo8QEEGkIZeSeCc0stds=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JtBrgjD+pEH5pmVgvMbxylmLozXasN0ZoiC1hNwudZws0UJcHtvnh/MZSd3n6jJxQz2AsZdMsiSVjfKNh6QrB/8BVAMtCjyPTKfkXqdCIPHlxJF46fVfulg5pOk3uufI1G9XEZ2Cw4Ha+/769iM3BuWLTlbo8BBJfQgRG72jUKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e925k+me; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9MS6zAtH5ETvFmDs2S2PHMtHyLzbrBBiBVyIUyXq6NdZfhgfqMPvU+Wj8/vSw50xqzbrMICEJhkWfyfrGd104sa2W7eGAmKFYZ2WPMvnGMoAuy2glqGH47dIGNhFd7mAT/+34tbqmhh/ddYnGr0NnbrJTS+re6me27A2ypgUf0roCZXAmRHrCh6MSyCEPXzq5f/ykUJFiTarHsOEV+AeWRhfY22yyI5GaeGJOvbUx0PIjXs0y7NrygF+KmZDhUb8S6LXDTQg7WxRyKG4lClMvAyNCwKkrqJGzP4jXDHLD5DffuEjBebX/c8q6Re3WdmQ0Qowg4NadRJ/ByTanHruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUTzE0cXUTSkw2DcOEPWVytIo8QEEGkIZeSeCc0stds=;
 b=Tioqe/wUBTRoDQsxlnIsQXE+pWxNLQJUKTPoiL4gtLiI7jhqqOa/1sPhQJMuUgSSll+NwX+Y+PuwXLdAfNZGjDeMshqpuSkj6y1uNszXG84Sn70xMX0SfDTASknAlZ2FmAP00wv0oi0SvYzEOG9czO9qMGyIqKZT1zGlTKISJieyLF8b7ncFATPjgS6p/o5WP5oHqeT/LNC+PGv5Ak9oip4e0pB9sG/O/3/Va9o8isIPZl1Ye8Et+tlfxGiRWpmDyZ2B5rsY6utmrPo623wamBQURSrXbfC8T1ik/m/X9tot4ApM896+ANKJeNqzoSdUm5K+FqTNZu4xC5Rht7rqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUTzE0cXUTSkw2DcOEPWVytIo8QEEGkIZeSeCc0stds=;
 b=e925k+metwBVHAmQ4+PivlOEfFh3A1fuTPzxKE9xihoN0ourLYXwxVicGtIOcwVtLHv9VSfWllKg1sSuFeew3V17NZbKYSmTfYmvXMOPyOoM6P+4S4bvZSCEs/txXX2g2ErLPhGYSgZLJ15cku+8d2URtwu2sdcN3WzHc5d1pGs1FcohKacoH8kEc0rqAd5y/Abuu0DW+VRx9sHJNqWrFItHg4N0diOmxoXFI7OfD1k5f8WeIOF1PdCFn6ORJsLi/bvGBWOLzyc27u5rZ3z3X/EYC+GwBAFLeQJz0rRgoqjtnb7ipsmJd0zg1Y7/NkiBl+JKVY5KzIt6TCAI0Ohx9A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 08:17:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 08:17:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, linux-rdma
	<linux-rdma@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>, Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Leon Romanovsky <leonro@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>
Subject: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA mapping
 operations
Thread-Topic: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
Thread-Index: AQHaaVVmcDpH2A9N+USRW3ux8c0jzw==
Date: Tue, 27 Feb 2024 08:17:27 +0000
Message-ID: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5764:EE_
x-ms-office365-filtering-correlation-id: 579a5b48-990a-4363-115e-08dc376c8953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7l22f95zq1dX8/laPsbBWHAq5su38ZZgUqkqMaPvai01v+WkkkLeNENoSMlEvdRUnym+Vd1MgysP45JUzG2cbNPcuQPOSGtsMNThMMF3wNOuoxg/N6IHTkoUY6eRYG1HnXXm01clDmdxQwPqXxqYsiTAX7bxVmA6nJwlgg39KX6tjqNMiVCMFEU0zEKWFAFlYAkCZAb/MDsH5nczkYQ0abP/7DHCJgVJ7fkWeZh1pf8bHqHVJBGV4R9J9tn+SYQd43JjcO/2OOajGovSc8qsXVbQqFsZDwLgNWxymOgPAvzjWT9CP63UmE0n5NhdmxMS4j6Ar2dInACrJteWCTs2z438FysiqP2LEYXtsp+a6r1GrumMgTJp6lp6HXfilcCz9zHcxMQhQ+A8sWdBDWYUlSV1XDR4kGu7WpWRfyJ71T9uAe3ImMthA6W/BbWsQ50cSGafMXju0Wm1xdxcv0TagdsFLAorvcbZINg6o9+tE9ivRnxiQRRGmz2v+csTd8q48mGhSCzfbXBHdZRfrBbNFhFBlYv+9NRU/Qnns4gbxZ5Ad+vdZZageGyAW4nLYDS3empe7VB4mWpHIcEPFkUKTmzkzqzrbMKEGFnivWCzzNQpXHeJlabVkvsXb5C9rFxxyg+9p/Y0B0gwD9i+PgoGkTZ/2WmY9+UVnQkEzmFptQOSKCcHR7R3MepCtvyM9pltLme84nzyJjkRIm0ozEYQbtk7SsK5cfHB/5CZ3GyRagpRcQj03Oeq4g/PWp07c9Wi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ukw4YTY3Ym5WVUhkeFRCK2pQN1FIVmtGbWVzOHEyalZmT20xenhaMlNqeW1v?=
 =?utf-8?B?RjMwbEE1TVZaNmdLSXRGS09Tak1NbVIrdlpxNC9zZ2ZCQ0Y4aU85YlZHbWJn?=
 =?utf-8?B?Y1hrNEp0Tkp4YXYycXlPb215RXFrRzc0YkdhNGQ3QUw5TnBpOGFKMEREYUcy?=
 =?utf-8?B?Rm5XUjd3WkdxaGpzZnp0YjJhMmRTS1Y3VnFkVEhob3g4cDZXa1JMWExsMVZO?=
 =?utf-8?B?MGhaSXZhT3pOSXVtOXFpU1FtV09Rbm1ucEp5aHpJVjZEZXdEZksrVWF0dm1x?=
 =?utf-8?B?bEpwc1hxaXBpUEhjYWFyRHp0bTFoek1xSGRuaEY1WXNITzhhd0hoMy9aa2tX?=
 =?utf-8?B?NlJiTVVobVpZTE9jUi9uYWRBblBmRnNFWk8yUFhMa1JpRWhlVk5hTFZQMEJ1?=
 =?utf-8?B?VzBEazlMOFFpSGQ4cm1rdVFLaVBmWnR6UG1CbG5yMmR2QmFJOVhra2paY2h4?=
 =?utf-8?B?TWsyVVlDbFptSnJmdlIvbkJDK0h4SUp6RGIxL0xFWkpzajRJbzFSdUJjczM3?=
 =?utf-8?B?ZGhUM1JHcTlhazNYemR2eUtxZ3cyWnZUS2c3N2J2ZmprNEpNazFZTFNrOS9V?=
 =?utf-8?B?T20xMUJpbGFETHBoSWRsVWlPcDhuSmN5Q1hLMGt3NFVzUE9Hclo1bGt2QXF4?=
 =?utf-8?B?Njl5dldFNnN6VG4zNjYxbXNZUERlbzNXVHlUSTBlZlhJN3IwMlV1MEhtL3BN?=
 =?utf-8?B?YXpabzlaWUtvMmNpN08yb2RtSGRuMEVvSkJNWGpUNjdld2wyOE1XSGFOeGNi?=
 =?utf-8?B?dWNJM01RMEYvNElUaFhDc0wzVjFGSU9BL0wyTVVNbDIyOWIvUkpGaDhqWWwz?=
 =?utf-8?B?MVJ6SThld1FhVzZQVnlnVU0rVU1xcUp4MTJFWEIyWUJqb2d0ZTZnc0JCN3Rz?=
 =?utf-8?B?dk5hRldCQk9JT3Y3dkNYN0tIN0E1SVFublBIR0FEcGQ4V3FJbHFTcnN3Wm1E?=
 =?utf-8?B?UktDbmdmMHBZVUlJVnh2bHhkeHhTSEtXbjFyem5ZUzFFNTQ5UG42QUtHc01S?=
 =?utf-8?B?Q1RRRXVmVlNJQ2VWOWxsRlFGamo3NFZwWXpyRjJzRjZBTmdURW11blJkWG1r?=
 =?utf-8?B?cDEvMkFKbU4yWHVwbHN1MXlXVDV6QVhtbFByYktZOVB5YzBpU3VaTzFEMWt6?=
 =?utf-8?B?Q09oNFk2NnRERGJiaG8wWkZpTVlBQ2RWMi9IMkpWWlZHWktEQnlWVDZJQnZv?=
 =?utf-8?B?MDI5VnFKVjFoOFhRSlJ5M0NBUGU0SWI5dnJhWjVoUUVteStnY2R5MlZOdUkx?=
 =?utf-8?B?RHhtMjBJNkxGaUd5cUFnVUFhbEJyQVI0WDd1WTIvOXA2L2N1LzRRbFZhWHBv?=
 =?utf-8?B?Z0lIQnBHRXRrTlhGbkYzRk9UUW05aGc5NndZdi9vTmFJcFMzV2lrTWw1OEFl?=
 =?utf-8?B?N2xEU3I0LzdwMUh3MmpYUlgyWDh2d1dwVStBYzdnV0wrM2ZpOURINi9pRHZr?=
 =?utf-8?B?V0M5c3NjRng4UEMxZldETGVOQnhIVVJyTUpXN3hiNm9JYyt1anByeTRPRnRT?=
 =?utf-8?B?MmtVQWRxQ0N1L0U0S1p0SjFuZ29Oa2tZK3VITWUySjZBdkRDUG4vVjlVVUZT?=
 =?utf-8?B?MkJrQk9xY21qY2JsME45em9kNzN5UGY5QWpXN3dMLzJRQXZLYlN4Q1QvclNY?=
 =?utf-8?B?cmM5bFM0eEViMHZwVG4yd2NWOGtSSzNHSHgzVU12L0xCcVRUL0lZdkp4MUJa?=
 =?utf-8?B?K2RYK2x6NEVvMEtXMGp6UzVyRHhvRXVQVUs2ZHp4dTgxWSt6eVZSdDJvSmFS?=
 =?utf-8?B?QmVNY2dwL0RqSW94YXVxWWpNcEZ1d1lLVzJRVXUxZFdwTGRDVVlJWVBPRzR0?=
 =?utf-8?B?anRTMEIwTm9Md2c3Um0vYk9pako4RmgzMzVvdFpMM2FvS1VNQ2ljdzBEOTJF?=
 =?utf-8?B?YTdIL1JvTzhsdU5tL3hLcGdaWTJkTnQ1M0FMa3FvSVdOa0IrM0tWYTZHeTVw?=
 =?utf-8?B?WG4xaGxFMy9pdUN2cW9tdDZ6a1RZZjRVUGt3aC9HWHNuQ0JSTTFyaTZVbEpt?=
 =?utf-8?B?cFFXckJYWTYwKzZYZDM1SnpERmRTQTB2bGRYWDZGMDQ0Tld3UjIxWGlrWkx5?=
 =?utf-8?B?Q2c3cXdiVGRnbzNmUVVzMDFFQzVIMVZKUk5LUXV5aGlCZTExUnJCVkkzM0hm?=
 =?utf-8?Q?/9acpVDLBVW60OXNnZDSiHryu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <021A7227AADC5848B915B50B8EECCFD9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579a5b48-990a-4363-115e-08dc376c8953
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 08:17:27.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sk41UcTzDiWT7UDAdIXchM5LDm0zQoK/1hL78hbd/fiT0xP3vcqbDqXdECZ69KCNppO00rBs8pdFmwiemURiSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

SGksDQoNCiogUHJvYmxlbSBTdGF0ZW1lbnQgOi0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRoZSBleGlz
dGluZyBJT01NVSBETUEgbWFwcGluZyBvcGVyYXRpb24gaXMgcGVyZm9ybWVkIGluIHR3byBzdGVw
cyBhdCB0aGUNCnNhbWUgdGltZSAob25lLXNob3QpOg0KMS4gQWxsb2NhdGVzIElPVkEgc3BhY2Uu
DQoyLiBBY3R1YWxseSBtYXBzIERNQSBwYWdlcyB0byB0aGF0IHNwYWNlLg0KRm9yIGV4YW1wbGUs
IG1hcCBzY2F0dGVyLWdhdGhlciBsaXN0Og0KZG1hX21hcF9zZ19hdHRycygpDQogwqAgX19kbWFf
bWFwX3NnX2F0dHJzDQogwqDCoMKgIG9wcy0+bWFwX3NnKCkNCiDCoMKgwqDCoMKgIGlvbW11X2Rt
YV9tYXBfc2coKQ0KIMKgwqDCoMKgwqDCoMKgIENhbGN1bGF0ZSBsZW5ndGggb2YgSU9WQSBzcGFj
ZSB0aGF0wqAgaXMgbmVlZGVkDQoNCiDCoMKgwqDCoMKgwqDCoCAvKiAjIyMjIyMjIHN0ZXAgb25l
IGFsbG9jYXRlIElPVkEgc3BhY2UgIyMjIyMjIyAqLw0KIMKgwqDCoMKgwqDCoMKgIGlvbW11X2Rt
YV9hbGxvY19pb3ZhKCkNCg0KIMKgwqDCoMKgwqDCoMKgIC8qICMjIyMjIyMgc3RlcCB0d28gYWN0
dWFsbHkgbWFwIERNQSBQYWdlcyAjIyMjIyMjICovDQogwqDCoMKgwqDCoMKgwqAgaW9tbXVfbWFw
X3NnKCkNCiDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIGVhY2ggZW50cnkgaW4gc2cgbGlzdCgpDQog
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2lvbW11X21hcCgpDQogwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW9tbXVfZG9tYWluX29wcy0+bWFwX3BhZ2VzKCkNCg0KVGhpcyBvbmUtc2hvdCBv
cGVyYXRpb24gd29ya3MgcGVyZmVjdGx5IGZvciBub24tY29tcGxleCBzY2VuYXJpb3Mgd2hlcmUN
CmNhbGxlcnMgdXNlIHRoZSBleGlzdGluZyBETUEgQVBJIGluIHRoZSBjb250cm9sIHBhdGggd2hl
biB0aGV5IHNldHVwDQpoYXJkd2FyZS4NCg0KSG93ZXZlciwgaW4gbW9yZSBjb21wbGV4IHNjZW5h
cmlvcywgd2hlbiBETUEgbWFwcGluZyBpcyBuZWVkZWQgaW4gdGhlDQpkYXRhIHBhdGggYW5kIGVz
cGVjaWFsbHkgd2hlbiBzb21lIHNvcnQgb2Ygc3BlY2lmaWMgaW50ZXJtZWRpYXJ5DQpkYXRhdHlw
ZSBpcyBpbnZvbHZlZCAoc2cgbGlzdCksIHRoaXMgb25lLXNob3QgYXBwcm9hY2g6DQoNCjEuIEZv
cmNlcyBkZXZlbG9wZXJzIHRvIGludHJvZHVjZSBuZXcgRE1BIEFQSXMgZm9yIHNwZWNpZmljIGRh
dGF0eXBlLA0KIMKgwqAgZS5nLiwgRXhpc3Rpbmcgc2NhdHRlci1nYXRoZXIgbWFwcGluZyBmdW5j
dGlvbnMgaW4gZG1hIG1hcHBpbmcNCiDCoMKgIGV4aXN0aW5nIHN1YnN5c3RlbXMgOi0NCg0KIMKg
wqAgZG1hX21hcF9zZ3RhYmxlKCkNCiDCoMKgwqDCoCBfX2RtYV9tYXBfc2dfYXR0cnMoKQ0KIMKg
wqAgZG1hX3VubWFwX3NnX2F0dHJzKCkNCiDCoMKgIGJsa19ycV9tYXBfc2coKQ0KIMKgwqDCoMKg
IF9fYmxrX3JxX21hcF9zZygpDQogwqDCoMKgwqAgX19ibGtfYnZlY19tYXBfc2coKQ0KIMKgwqDC
oMKgIF9fYmxrX2Jpb3NfbWFwX3NnKCkNCiDCoMKgIGJsa19idmVjX21hcF9zZygpDQoNCiDCoMKg
IE9SDQoNCiDCoMKgIExhdGVzdCBDaHVjaydzIFJGQyBzZXJpZXMgWzFdIGFpbXMgdG8gaW5jb3Jw
b3JhdGUgYmlvdmVjLXJlbGF0ZWQNCiDCoMKgIERNQSBtYXBwaW5nICh3aGljaCBleHBhbmRzIGJp
b192ZWMgd2l0aCBETUEgYWRkcmVzc2VzKS4gUHJvYmFibHksDQogwqDCoCBzdHJ1Y3QgZm9saW8g
d2lsbCBhbHNvIHJlcXVpcmUgaXQuDQoNCjIuIENyZWF0ZXMgZGVwZW5kZW5jaWVzIG9uIGEgZGF0
YSB0eXBlLCBmb3JjaW5nIGNlcnRhaW4gaW50ZXJtZWRpYXJ5DQogwqDCoCBkYXRhIHR5cGUgYWxs
b2NhdGlvbi9kZS1hbGxvY2F0aW9uIGFuZCBwYWdlLXRvLWRhdGEtdHlwZSBtYXBwaW5nDQogwqDC
oCBhbmQgdW5tYXBwaW5nIGluIHRoZSBmYXN0IHBhdGggKHN1Ym1pc3Npb24gb3IgY29tcGxldGlv
bikuDQoNCiogUHJvcG9zZWQgYXBwcm9hY2ggYW5kIGRpc2N1c3Npb24gcG9pbnRzIDotDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQoNCkluc3RlYWQgb2YgdGVhY2hpbmcgRE1BIEFQSXMgdG8ga25vdyBhYm91
dCBzcGVjaWZpYyBkYXRhdHlwZXMgJiBjcmVhdGluZw0KYSBkZXBlbmRlbmN5IG9uIGl0LCB0aGF0
IG1heSBhZGQgcGVyZm9ybWFuY2Ugb3ZlcmhlYWQgd2l0aCBtYXBwaW5nIGFuZA0KYWxsb2NhdGlv
biwgd2UgcHJvcG9zZSB0byBzZXBhcmF0ZSB0aGUgZXhpc3RpbmcgRE1BIG1hcHBpbmcgcm91dGlu
ZSBpbnRvDQp0d28gc3RlcHMgd2hlcmU6DQoNClN0ZXAgMSA6IFByb3ZpZGUgYW4gb3B0aW9uIHRv
IEFQSSB1c2VycyAoc3Vic3lzdGVtcykgdG8gcGVyZm9ybSBhbGwNCiDCoMKgwqDCoMKgwqDCoMKg
IGNhbGN1bGF0aW9ucyBpbnRlcm5hbGx5IGluLWFkdmFuY2UuDQpTdGVwIDIgOiBNYXAgcGFnZXMg
d2hlbiB0aGV5IGFyZSBuZWVkZWQuDQoNClRoZXNlIGFkdmFuY2VkIERNQSBtYXBwaW5nIEFQSXMg
YXJlIG5lZWRlZCB0byBjYWxjdWxhdGUgdGhlIElPVkEgc2l6ZSB0bw0KYWxsb2NhdGUgYXMgb25l
IGNodW5rIGFuZCBhIGNvbWJpbmF0aW9uIG9mIG9mZnNldCBjYWxjdWxhdGlvbnMgdG8ga25vdw0K
d2hpY2ggcGFydCBvZiBJT1ZBIHRvIGJlIG1hcHBlZCB0byB3aGljaCBwYWdlLg0KDQpUaGUgbmV3
IEFQSSB3aWxsIGFsc28gYWxsb3cgdXMgdG8gcmVtb3ZlIHRoZSBkZXBlbmRlbmN5IG9uIHRoZSBz
ZyBsaXN0IGFzDQpkaXNjdXNzZWQgcHJldmlvdXNseSBpbiBbMl0uDQoNClRoZSBtYWluIGFkdmFu
dGFnZXMgb2YgdGhpcyBhcHByb2FjaCBhcyBpdCBpcyBzZWVuIGluIHVwY29taW5nIFJGQw0Kc2Vy
aWVzIGFyZToNCg0KMS4gU2ltcGxpZmllZCAmIGluY3JlYXNlZCBwZXJmb3JtYW5jZSBpbiBwYWdl
IGZhdWx0IGhhbmRsaW5nIGZvcg0KIMKgwqAgT24tRGVtYW5kLVBhZ2luZyAoT0RQKSBtb2RlIGZv
ciBSRE1BLg0KMi4gUmVkdWNlZCBtZW1vcnkgZm9vdHByaW50IGZvciBWRklPIFBDSSBsaXZlIG1p
Z3JhdGlvbiBjb2RlLg0KMy4gUmVkdWNlZCBvdmVyaGVhZCBvZiBpbnRlcm1lZGlhcnkgU0cgdGFi
bGUgbWFuaXB1bGF0aW9uIGluIHRoZSBmYXN0DQogwqDCoCBwYXRoIGZvciBzdG9yYWdlIGRyaXZl
cnMgd2hlcmUgYmxvY2sgbGF5ZXIgcmVxdWVzdHMgYXJlIG1hcHBlZCBvbnRvDQogwqDCoCBzZyB0
YWJsZSBhbmQgdGhlbiBzZyB0YWJsZSBpcyBtYXBwZWQgb250byBETUEgOi0NCiDCoMKgIHh4eF9x
dWV1ZV9ycSgpDQogwqDCoMKgIGFsbG9jYXRlIHNnIHRhYmxlDQogwqDCoMKgIGJsa19ycV9tYXBf
c2coKQ0KIMKgwqDCoMKgwqAgbWVyZ2UgYW5kIG1hcHMgYnZlY3MgdG8gc2cNCiDCoMKgwqAgZG1h
X21hcF9zZ3RhYmxlKCkNCiDCoMKgwqDCoCBtYXBzIHBhZ2VzIGluIHNnIHRvIERNQS4NCg0KSW4g
b3JkZXIgdG8gY3JlYXRlIGEgZ29vZCBwbGF0Zm9ybSBmb3IgYSBjb25jcmV0ZSBhbmQgbWVhbmlu
Z2Z1bA0KZGlzY3Vzc2lvbiBhdCBMU0ZNTSAyNCwgd2UgcGxhbiB0byBwb3N0IGFuIFJGQyB3aXRo
aW4gdGhlIG5leHQgdHdvIHdlZWtzLg0KDQpSZXF1aXJlZCBBdHRlbmRlZXMgbGlzdCA6LQ0KDQpD
aHJpc3RvcGggSGVsbHdpZw0KSmFzb24gR3VudGhvcnBlDQpKZW5zIEF4Ym9lDQpDaHVjayBMZXZl
cg0KRGF2aWQgSG93ZWxscw0KS2VpdGggQnVzY2gNCkJhcnQgVmFuIEFzc2NoZQ0KRGFtaWVuIExl
IE1vYWwNCk1hcnRpbiBQZXRlcnNlbg0KDQotY2sNCg0KWzFdIA0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzE2OTc3Mjg1MjQ5Mi41MjMyLjE3MTQ4NTY0NTgwNzc5OTk1ODQ5LnN0Z2l0QGts
aW10LjEwMTVncmFuZ2VyLm5ldA0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlv
bW11LzIwMjAwNzA4MDY1MDE0LkdBNTY5NEBsc3QuZGUvDQoNCg0KDQo=

