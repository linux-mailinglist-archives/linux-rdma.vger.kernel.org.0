Return-Path: <linux-rdma+bounces-8988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85428A71F16
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 20:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D6F3B26BE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 19:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE6250BF3;
	Wed, 26 Mar 2025 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DuFkXIpD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010005.outbound.protection.outlook.com [52.103.10.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5523C8CD
	for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017152; cv=fail; b=tBT3JrlNJVcvGVTch8UAtUxQRsZoNTeb5fNaTfyzhDDPOUSOlQiSZytrlGX6VSVsZCfVqVX1pmC+hCVH/gHQDX5qL7fDyPr9xxpoQzRIt8RsdCg1C7ZsoKCTun4RyhhHMraPx4CS2mTCP+rYaodqAF3HBp4Cqq4u/DUky89v5jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017152; c=relaxed/simple;
	bh=52xeuAsUCAgRiFFQFr9UcDbz4Ow0vl+wI6u2MO/iRkY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XuniSgTTcpy9DaK/sFLOZy8xiw7sUZq8Podrdo3P6h2DJQ47ckmpHtWQG/GNdhhx2Wa9POVJY1V9ZAsd1tJO6DppbRsZVCN0rEnvOS/WrnTBg1S6Kp5D6lCabml11irRtkjrqcCTsY6jxDZ/VdH5IIppiAPj7HgcyKWQf10DEX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DuFkXIpD; arc=fail smtp.client-ip=52.103.10.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMLCMlYdpHAF017tJNj3RW+n0vircFYBpdxWxk8QS2UlTb9QiFMWFcW2CqoQPZrBSJMfP8LV8AMhSR9rRNAwRzZv2X/S4mUkkDs10eks5J6HQvpfP9/4RNnhLn/kTsOsLx9VFxAdZJCCIyz1abh4TrjFv6FWETrQcUsBCI9HrKj0z4rvysjqlxaWhxSkWCFpp1saBVOOwRVGdSu7DHG2hzJq/hToYs8xPGJdoZUtCAbPwHh88XrTnOgWmd7AEJb25qivYbCNMGbk6ahQWeVVHNiq/MKfAt3+p6r9z2vB/QVSI0oztTGWVj8E5Pj7t7nlUYiTIobu1BKffUIUspTu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52xeuAsUCAgRiFFQFr9UcDbz4Ow0vl+wI6u2MO/iRkY=;
 b=k0M0g+zP041vqZazJ3SZi0P1tb2PUuo7odVhTSwHC1dgsg6lZRzCdiKnCkPTK/7eHkc0Tr2H+KrNamkij2nnXM194si3TKA41PU5Eqqq+l2+/hdc46nM0nMkVDQ50SGfy+dU468zzmpm+0URGmbdvbtFkvudqBc+c3TBASNmVZfrL4MbJOtdkc4bLEda4YuzRllEbKCqhp0GTHblEpdDcSeW4uyTTpnQP6xU3PcFQQexDe+Eb+2ZLRLMnPd41Jfy+/BrDFB3rQwCm52nhC/Qn8wU1MU9sCE4NG+R1lOn8W7WfuPWvmxFesu+Ld8+/XaNuohYMmk8HpJe2vscVhNl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52xeuAsUCAgRiFFQFr9UcDbz4Ow0vl+wI6u2MO/iRkY=;
 b=DuFkXIpDGThzm18R2N2GFcn2ElgKvNi38wci5PojT3jNULNFMQsGZZWpNpqli6tsIF4I9hqRC2DRbbIr0dpdszAcBHTkNuYBAJTcrSCMuX9H9px2/bY9jgk262HshqeVj5HnumbJrIpMudncS5kwnwRIM9Uk5k5GaEeGwJvOdmX6KAbq7wdaKCwYVp+AQzzTtW6t0r801WzZksLGw9K2B8F5rS+xw9pLpMJNrgy+1z+xQwYVG/eJEzQ5fcd0coKV7Lmb9uqushsx/u/JxXv7ti4a8JfGbyrsgEpP1oY/9hx4RMLUTD84UwRwr1TastZBxYUcQ2aooFJVN+tscABhBQ==
Received: from SA1PR10MB7635.namprd10.prod.outlook.com (2603:10b6:806:379::17)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:25:47 +0000
Received: from SA1PR10MB7635.namprd10.prod.outlook.com
 ([fe80::2971:86e2:851b:f009]) by SA1PR10MB7635.namprd10.prod.outlook.com
 ([fe80::2971:86e2:851b:f009%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 19:25:46 +0000
From: Anna Lewis <anna.industryinsighthub@outlook.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: ISC West 2025 Attendee Database for Generating New Business Leads
Thread-Topic: ISC West 2025 Attendee Database for Generating New Business
 Leads
Thread-Index: AdueWAtrtVGeVL3tSMalsMwuqcxBDw==
Disposition-Notification-To: Anna Lewis <anna.industryinsighthub@outlook.com>
Date: Wed, 26 Mar 2025 19:25:46 +0000
Message-ID:
 <SA1PR10MB76359A2B88A6027EF4781521F1A62@SA1PR10MB7635.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7635:EE_|PH7PR10MB5699:EE_
x-ms-office365-filtering-correlation-id: baa8100f-1a68-41c6-2a67-08dd6c9c0255
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|8062599003|15080799006|461199028|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PSV/tOBIrv7TpAnKJaLnheKLjJPG2iXOVe92Vc3sXgKJCuSP7bQtlML0P8?=
 =?iso-8859-1?Q?lb9pZtEmCLi04lZH+JypRJgXwm194wx9HeIRpNDW992TfN2YPhQVCFBXes?=
 =?iso-8859-1?Q?1iJF9qustQk/SUDDlrvHmnAgpsw+dTLWyk8H743qWPCyrVvk0qTcYO1UoW?=
 =?iso-8859-1?Q?NSnnKG/fpG575gJUnQ715jQ8NI1/ZZOTAxemc1NitQHlbyhmAVFsoi/g1m?=
 =?iso-8859-1?Q?yc/GkVZh1jRPswgjcOM3OSHuKcji7FrT8rGuFq5L/C7zLFbCBW/+r3GpuY?=
 =?iso-8859-1?Q?9GZo+qJwYmlgxj1jkZGcKrfVqtb05vhFCbY7dlPYKw2HhweMyIFD+53/m8?=
 =?iso-8859-1?Q?ZJ8LfOdzAyCSWz683uwVNRt73X14Urdz5X7uw+cDV8bQS05ZZss/xPi8eU?=
 =?iso-8859-1?Q?jXsCyRxJty9aAv+V+PU8yB+agGkMucXR/sjy1O/3TNzy0HutjOV34hTFL7?=
 =?iso-8859-1?Q?I1HGXV4Lju49KKLB2xORNc0CLAByALAJAzT6s86KlDkigkKgvG9GII9Fhe?=
 =?iso-8859-1?Q?d13yQdOekdf4TuEvJh7JX7xvt3XjG+u08De1B3WLEU+19xM0ini8JpboBX?=
 =?iso-8859-1?Q?d0lzQ5OYO44tiIuMXzkibKTuVoifhQZYWoRAq32Z6N3Jx5d2Rhq/h6dKtx?=
 =?iso-8859-1?Q?njwlSM8NhR4D9PRLpBRoLXKtXjmaf96BF8rWOjE3eBIezqSf4pElpEtI0i?=
 =?iso-8859-1?Q?q3gNOLpZ7HO0XhgScQze3DjamQJo2UligIClfnYTGo6ZaxraM1nnzGRy//?=
 =?iso-8859-1?Q?bQ4DOVppiz7UkhkKzThhoS4eakjMLQTy1QM0+3bifcU/fRWezsPN6qKrVM?=
 =?iso-8859-1?Q?hferSxWI8Qmd4iKGdtLhZu8Ngcztq1uxxVqTHLoW0sU6KYvToKyYrwJrtL?=
 =?iso-8859-1?Q?RI2BK3q0TKPykiVUXoFMmT/362e+WqNZ2bdRkHW8sjDbaMP4rtODDsStxv?=
 =?iso-8859-1?Q?zvmCIo9kUt7liSnl7JKrJh5BfsFSeQQatTwe3IzNB5++8JEZWnIJbFRX1R?=
 =?iso-8859-1?Q?pMBQAlldk1aeDV2NqgUTHE6f8It3itESF1YzvNNoDXAgejbA/v8hJ85E0m?=
 =?iso-8859-1?Q?wYb7IaHNB/fpT1g0DBYXKgMvr7qbfbQQy+uNZb2QHw7XBU1VUxzfeHARjt?=
 =?iso-8859-1?Q?47QPdLYlf0Dyum1QTFs3u8N6BGIFE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CtuXml8920W5o37oO7YRxkd8CcElpFgsOLatW9UvovTkKgfcB+iOgbWHCR?=
 =?iso-8859-1?Q?r/q+WPL/gfepkwq4BXSEGlMPAZNxOgyerhsXmNVR0+ecl4p22Py7uHbryg?=
 =?iso-8859-1?Q?A5ZU/hiunM2wReaUYUvADhaaivy8RGw7IJNk517DyUqJpTOG0FD6tThcAj?=
 =?iso-8859-1?Q?TkGPtXrE2fui0cyQ5LFa/F3M6KOrnRCg+hYZ4QQn3uiWwcvzoAB2jia2h2?=
 =?iso-8859-1?Q?RMTdpmm+ZkC0nrH1b/mnellSLLma1YI2/EN/LTbYw7s8DlrpQYxIGfM3Dq?=
 =?iso-8859-1?Q?Q0peK+CwBhhmj0GE5x2IJqeBHjbEkIRKL1KhddZ0Ff5J31seRcP3XBht1i?=
 =?iso-8859-1?Q?5N6SyjzzGBzons40kQX4CxI9z1mJ7YnyFp7CcU1xnoremCRuMiNWd6EHtp?=
 =?iso-8859-1?Q?rtyRAjAQi6WYcOBgRw+9h/TdMngauoAgFci7sbVKzPf7Li8rgXfoSE6Vn/?=
 =?iso-8859-1?Q?YZ9xFPcdVHcRjYF2Z6VAXb7shvrX1XiOgICmBK68ysR9XiEm68bGKO4wcB?=
 =?iso-8859-1?Q?gBp3cRBUrMQvO+N73EZ+zZqjE3Wy0LrQBkuSi1OrNeNBzvBFDP4d8ve/BK?=
 =?iso-8859-1?Q?sb0BgTtEYnoXCJX+T6LHCcAwP4cY0x0/ZhdAd/IO3m93MrI/sFecy9/j5j?=
 =?iso-8859-1?Q?4eIfexDXlP7sfB+jEPSE9mGe/ay3cI/C2ID1ew0+fNrwz2gpUq7+7IX4aR?=
 =?iso-8859-1?Q?Q7z+8/6B16b+a0YTRoA4eb/w2heIvwgw4/t9C2OrMM+p+A3TsjfapDuSnx?=
 =?iso-8859-1?Q?Q6nRwnFdK3P3Nziy/MxagphQI2QKngB6Cztg+pd1fS1w8m0VUz56VMpJ6q?=
 =?iso-8859-1?Q?4Ix/twYbIXehR1qAo1soMvV/Q6HzMN9UHbp7yRzNSEyNAKleZ98qCXS2ld?=
 =?iso-8859-1?Q?9lRzxEMIvhh216D7b0OO4SUYKENq/V2ys8s1h94eVzE6IPYaBJFSQPgjGO?=
 =?iso-8859-1?Q?9JoomChQXmuruLnlSSdfSQXGRsOV2r7r9k5sWBiviWWkC9RGTzn7LNitej?=
 =?iso-8859-1?Q?y9Ft+yEMrRlIJWyKJw5xwofUqNnJhZUo7oJnr80XRbKOEFA9nmR+WkCpKw?=
 =?iso-8859-1?Q?ChFwv6P5JM4fPU4pw8z2naXpOY8ITH0FTpX+bdu8fryJTseIYol4qQ5ywc?=
 =?iso-8859-1?Q?6tsVgNUzyrvM2690+p1DhD2lFoBgmW2jxI84mfpvqdEqIeYNEiSgFTsJz3?=
 =?iso-8859-1?Q?H+HZQL2c8AFd/XePQIe/OVtNhP2dde0mKKsGgzeWc18ouKyNraRK2til1d?=
 =?iso-8859-1?Q?zpfBsE8heXfNkQyuS82GQtrCYTRR9VEmUWa3Ur5MYfCf0XAB71fZpICgRE?=
 =?iso-8859-1?Q?HAgPG/KQCId1dZ3WlgLfPcn4UkGOLt1R3dhhEB/UcKUsmPNLZT1iDZpIP8?=
 =?iso-8859-1?Q?gcRDOtCrv1EdNMigDgaLa0dydA8QM0Hg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: baa8100f-1a68-41c6-2a67-08dd6c9c0255
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 19:25:46.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699

Hi ,
=A0
Are you interested in obtaining the ICS West 2025 attendees list?
=A0
Expo Name: =A0International Security Conference & Exposition West 2025
Total Number of records: 23,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.
=A0
Do you want to proceed with buying these leads? I can send you the pricing =
details.
=A0
Can't wait for your reply
=A0
Regards
Anna
Marketing Manager
Industry Insight Hub.,
=A0
Please reply with REMOVE if you don't wish to receive further emails

