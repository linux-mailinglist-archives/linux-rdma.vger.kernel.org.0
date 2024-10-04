Return-Path: <linux-rdma+bounces-5208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADC98FD30
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 08:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D749DB2265A
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 06:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B381AB4;
	Fri,  4 Oct 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chelsio.com header.i=@chelsio.com header.b="bxQZdm3u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2129.outbound.protection.outlook.com [40.107.237.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B01FAA
	for <linux-rdma@vger.kernel.org>; Fri,  4 Oct 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728022442; cv=fail; b=EsHMGWHAOqmAxZBw48t6p4BuYBtJGgaR8f/PrxFBzCZ4wW7ltr+RPM4r7Q3N5dMKf8kX+kkOSDXkyfSZvkN5EgoHk8+dnZA+06O7g8QDIoZM1T3dHyZqs/y8hzfJcyqRtd0zgJnSf/ogHTyiG1XTFBlQdQGZ2m2E+N5gzzdB8nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728022442; c=relaxed/simple;
	bh=aSl9ziJBtD0f71yAlNBz8r6OwwEO0o2nkA2QC2r09ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3aPt6I7AoKNFq0ck9aq4sKZPwSOlNXPBD7QAn9bLwmIO+AUbqfScxGBgNt98WnRy5/enxOS/Yh1QL/FMFfq21e5XpOFmwfAd2YEaO0NJQ3QvAsog1OljlMcvPHNsJFpSzuVzEechhPIWIEWpxgBG9t95ZmSH8SFXqLfDwg0u8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; dkim=pass (1024-bit key) header.d=chelsio.com header.i=@chelsio.com header.b=bxQZdm3u; arc=fail smtp.client-ip=40.107.237.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwHQSeZafP5FOZrlwEPTkqzgB3o4hP5H19U12IgX20hf0rzxKkXc302NNM3mNRYO2Df2kF08zaUBpLxP7PgYRFedUOeN1ooDroyq6BPBuJ+cydlbQ+bdfdt03XfimN4TTgqbeThLN1KuRTxpdrJjZEVYmcmPrWHJsM+WN9RprRD/JDklzz6e8aVllTXljoTvYPCj3sl9FnmtJQV104qGhKNzo2/oJpOa4ndWuxXXZdPMfrM8L/ZWJlGhXBbYCyyHmxP5CPHG4sGPF42joC50WuX3uanV2KKHFbs1tgYu1rVlUT+/mBsUUDW/gxJHh1VYLl8R2OrV8LsRUvu9uO2uvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSl9ziJBtD0f71yAlNBz8r6OwwEO0o2nkA2QC2r09ac=;
 b=G572Puyt+OV3mVdTzgvLWaCPpxIQxk/tOmiqppBOsjLaokD92df0wkAbYZn85fxyxU9eXQflX9MKi2tCyT0VaTWml0WW7jPgCF44Z9S+yDXS1FVSydc3bZf3vOZLc6nyrfwaSbS6uJpbIPWueU68Jft8lKAck2dqb0n1MbTGwLGDpjt+DsPyug8miMADAFkxEuQRBcIHbedxjjd1j7mLSdTjkTR6c6Jc8+lJG5k8fBnEMFOD7HXReFi0yahaBDLhApTY5RigkW/lLbi+gG51sxFWzIFRZQnT2cTJk0HdSCZSTp0Ap0TvUq4KnnAmlhOumCIXd9HgMjCggCoOu58+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSl9ziJBtD0f71yAlNBz8r6OwwEO0o2nkA2QC2r09ac=;
 b=bxQZdm3u55NJE6lp9/W1vW3Ne/5f9rhlpXGAT2QOIjhU2Y3l/se4pj2lpZvN3QghnYtpRwBa8p9oZl+SX0w4fyduq1N8ipYrwbDaZbqrLtHVCsFpLziJIidQ7YXpN1RIGSssyf4VhQ2dXT5BPm2aSyKhw/RcW+OOMr/LPcCkU6s=
Received: from CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 06:13:55 +0000
Received: from CY5PR12MB6177.namprd12.prod.outlook.com
 ([fe80::e618:181c:dfd9:2dce]) by CY5PR12MB6177.namprd12.prod.outlook.com
 ([fe80::e618:181c:dfd9:2dce%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 06:13:55 +0000
From: Showrya M N <showrya@chelsio.com>
To: Bernard Metzler <BMT@zurich.ibm.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"leonro@nvidia.com" <leonro@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Potnuri Bharat
 Teja <bharat@chelsio.com>
Subject: RE: [PATCH for-rc] RDMA/siw: add sendpage_ok() check to disable
 MSG_SPLICE_PAGES
Thread-Topic: [PATCH for-rc] RDMA/siw: add sendpage_ok() check to disable
 MSG_SPLICE_PAGES
Thread-Index: AQHbFZAMHzvPiLygcUiMuyKWRYF9ObJ1FTEAgAEH3ZA=
Date: Fri, 4 Oct 2024 06:13:55 +0000
Message-ID:
 <CY5PR12MB617761BF4CCBEAA5A041CD84AB722@CY5PR12MB6177.namprd12.prod.outlook.com>
References: <20241003124611.35060-1-showrya@chelsio.com>
 <BN8PR15MB2513C8CC78CBEADA83117A5599712@BN8PR15MB2513.namprd15.prod.outlook.com>
In-Reply-To:
 <BN8PR15MB2513C8CC78CBEADA83117A5599712@BN8PR15MB2513.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-vipre-scanned: 71C3E5C601ABF671C3E713
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6177:EE_|MW6PR12MB9019:EE_
x-ms-office365-filtering-correlation-id: 693f9a16-0145-428e-8954-08dce43bba2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVJBMFF4YU1FaWROZTAyVVVmd0FiMDNwYnhuNVM4bHljSmJqeWZhYndWd0pa?=
 =?utf-8?B?SWJ0SHZqVS9aRmNHbkwxd0lraGR1NVRoRmY4TTBRSGlLUXVELzJHcUxrSjYz?=
 =?utf-8?B?bDRpbVV6Ryt1S2tySktoSWE4TDhvTFFKbE5YZFVvT1hjakp1VkFvSytHMk03?=
 =?utf-8?B?cWVXMDdBaVMvZ1pqb29INEVMRnJKYmlnS3NGVDdsaEd3eW8xRjRvc0FSOW4r?=
 =?utf-8?B?dDBGeHV3c2ZFSUtTTS8xNXdPYUduWkgvM1lQTU8vay83eUJNS3pjQVVVZ3Fv?=
 =?utf-8?B?Zm1CQVhFQjJpdUVrSlptZjZDd3BXSjI1QmM0elNRS1ZHenRxelFZZnN0dWVW?=
 =?utf-8?B?UUIwT3RRRnRHNis0OFkzclBocE9jb2lvRlpoNmJrcXpXR2lwUndWdkVMc2p1?=
 =?utf-8?B?TXlVWjFkdmcxNFQxTlpYY2NIWTA3SEp0VGhlU2tnUnNOTTRlS25JNHVGYVF4?=
 =?utf-8?B?eEowNTd6aGpQZmcyWkVheThqVmorQUw4N1lJN2tUOEdiZmFJRnRTMFh0WnUr?=
 =?utf-8?B?cTNMRGhpbWpTaEpTS3NBWW9WajNUaTIwUVB5Z0JIK2xaY0VqbFZaRUdZb054?=
 =?utf-8?B?SWVoZ3JYZ3AyZUV4aHFZN3RBaU9QdnlMeE0wMy9taDk2bUFNOXlQZDNXalZQ?=
 =?utf-8?B?S1dCT0N1azZDMWM0SjRvanhNakJnNFpuRTFRVGtZdnZTSGdjSndEbFdBZFdU?=
 =?utf-8?B?QmVUbjdwVzBTcVZIWUtFSlhaVmdCMkhYR1NVV2VwNE54QzQxMVdTRW5FQnpQ?=
 =?utf-8?B?dVgrZmRkalZpOS9MU3BYNXAwMTliU01LYnlNZ1FuVzFVTWFhbk8yS0Vqb0xo?=
 =?utf-8?B?V2szSkQvQUl0Y1NmdkFsaTlmTW9sTlUwZ05tYTZiZml0WjhEN29CbzR4bnJW?=
 =?utf-8?B?YWgrOHBxNHl4ejZjNmxjMHBUOC9WdVBLbnk0UFFJVjRVallMdmY0WWtVcEZw?=
 =?utf-8?B?ZlZnVG92T0M1NjAxa25RRlFHeU1STkJvRDFVcXgwYlpDdTIxNzNtZXlNTTR6?=
 =?utf-8?B?L3FOeTNvUjN0VEZyZVFXaEd6L0o2ZlpHM3JMcmZXaW5xdmdYNkNoL2JHakw2?=
 =?utf-8?B?TnNHUFA3NHUvZ3B4TWhBaWZmMWlBS3U5QXR0amt4QTNVSVdmRUlOWlgxWE1u?=
 =?utf-8?B?b2RSZ0hINjR5YXdpNFNrRjFqVnNSdXJPRUx2bytOVFZxM3hPeGRhZlNOU2lz?=
 =?utf-8?B?NXhrdjZSVmZZV0JkM0lzR0ppdDh0amJaU1ZMclBhTTFnczhRZmR5T2IrZnN0?=
 =?utf-8?B?MnEvZ3NaZW1kK1lRbGFRK3FmU2FZUFhpNjlnZG1WdFBzTU5UZ0lmUVhuSzlK?=
 =?utf-8?B?b3ozZDBiVElZb1Z6blNtVi84YzNHK3h3TmR0UURCZy94MHhUcU95UnVLV1U3?=
 =?utf-8?B?UzVCbGkvVVRwdjdVcmF3dXVsVmI0K1EzWUJ4RVQ2WGErditNQ1g1cmRQMVpF?=
 =?utf-8?B?MXRCenRhQXorbTlGeE1GSUxrZm81YkxZOHhpaTRqRmg4VndTRkhoRmlZUElK?=
 =?utf-8?B?NFlMRGkraktWVWwzVndyYkZCRkRma0ZscXA5M0tFRWdRcFJISnpKWlBTaXZa?=
 =?utf-8?B?U3M5UXBEelZGZnNHd1ZreG5ZeHBINXdqZFZGbkg1K2ZkR3krNTRWdUlKQkZJ?=
 =?utf-8?B?bUNIcitoVmI2VWNrQkNPVTlJOEJBYUtOUkxIUk5ocjhHR1lrMi9rVThzRFIx?=
 =?utf-8?B?a2M1M0lweGZKNlkwd0FpWEIxMXdWbktjOXVHZVNPNXMzSUU3cTAzUzBoY29Q?=
 =?utf-8?B?cUZSSEdSYThzM01Fa2pLcEJDa3RLTEJVTWZ5QURWU2pFOWJCN0dsSlBRK29p?=
 =?utf-8?B?NnFaZ2Z4QmJXRVZkTjZFQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6177.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mm0zUnNFWWYvOWQybkptdWpSSE1ZU29RL0FTb1hadk1xYnRFZUJpWlRoWEsy?=
 =?utf-8?B?LzJaZEJSa1VkZ0tlWk41MG9JTTlMeWJnN01GZHg5U05Ob0NJdnR2b1l4Rmc4?=
 =?utf-8?B?cDFsRHFybGpzM3k3dndFNVhuMkJPUzQxR1k2cmJVNk0xVXFmSk5uTVhzeENp?=
 =?utf-8?B?L2lWaUdjY1hWdkYvclRDYXZhQU12ODdwTHRPWUFCUWl5YStXemYyNHg3VTBj?=
 =?utf-8?B?Y0tnREpWaWNZbXBYS1htWmtkV3kzdTh2QTVvY3lENlh3U1g2OXBzeGttSzc2?=
 =?utf-8?B?aUJYM3JBT2tYcVBZYVpaQk9ISGZQUWtIdUNpdEZLa0lnY2pBcEs2RHEyNDhT?=
 =?utf-8?B?czJ3YTJJMkRyWm85Um9ucWlFdE12V1lxenBFUlhzcDVId0hYS2pjRmcybzZD?=
 =?utf-8?B?T2w4a01EdVc5am9ndUxZOWl3MVRDVnRwZFNkZm4wa1hBYUhOc1RkcFhIdGhD?=
 =?utf-8?B?U1pzelBNNDZVTHAyL21IRStscVdjc0RhNENNUnlsSTg1MEtBSjR5UGZGWjV0?=
 =?utf-8?B?NHNwMzN5WHJUV2hHZlJDQk50QTZYUXhaYS9CMFR0cnNUT3RYTjJJRVpKVzRR?=
 =?utf-8?B?UWdsdzl6TFBOZkJOWmlCdTU4dDk4ZEVCM2FPcHlkNHd5eFMxUnpxY3FROTlP?=
 =?utf-8?B?NGplTGRZOW02elhBSkJURTVIa0dBL0piNGZuSS9GbkVWTXRjR2szeXVtYWhS?=
 =?utf-8?B?VHRjcDZwdnp4VnhMZ2JZMzNRZkd5dUFKcm52ZnBHRFVvVkZCak50TXUrR0c0?=
 =?utf-8?B?TEZONVhLaFpTc25INFlVSndCLzd4MFN5VVhEQmVYbW56cytVVHFMM21pV1gy?=
 =?utf-8?B?UVNNM1NnTmJUMHM0cnlFUDRtWmMySjY5RE96TERyTGpYYXplZXFhTGo1VzRy?=
 =?utf-8?B?YWlZVXQ2QkZEdk1nRmxrUU1lSVcyZk1BRlhvd0ZsQXdnU0dlN2NhQWI2ZHow?=
 =?utf-8?B?eDFxT2FYaHgyb0Nia3kvZUxWeksrR1V5VmN4ZnZIdFNuM3lsYm1qaVB2Q05C?=
 =?utf-8?B?d2orY25nQnVEYWRDOUVpcENEZGlHaXFLTEtVWko2VkRGUm5Qc1BUVjhUL0t1?=
 =?utf-8?B?TlJtNUczaGVvNlUrSzZFaWdSY0c0MWJXMXJEb1ptZ1BKV1daUnNCODJtcCta?=
 =?utf-8?B?aWdYNnVYRWlNZHFGYlRveHVwQzN6VmF2dDdsd0RuNDRXbHhRYURSb290ZjBw?=
 =?utf-8?B?RWpsUlRyVDVac2xPa1cwUmNiQlJpK0F4KzBERlZsdmtBbmY3eEl0RXg2YWp4?=
 =?utf-8?B?UFNBR2NXTG9ETFN4Vm1oSmp2eWNVYzR6T0FxSC9kR2lDYXVHbjlvVS9YdHFO?=
 =?utf-8?B?cTRpY1BOY25VU1FYOGxwck9QVFl2UmtLeVd5T3VxQ2RQcEZ5bEtwQnNJVnBP?=
 =?utf-8?B?NHhxWGx2MDlRckxZQTVVa1hDbDdUT2NPTHRVM2NiODZHRkxRVkRaZnd3MGpS?=
 =?utf-8?B?WUpXS1VpTVkycTE4VGo1L1B1RldkQTlHMTlPWENyd244SkV3RW9mNVpPWkJU?=
 =?utf-8?B?d2xZSk5uMklEdXF0ekxIakxGMktLNTZrUkpVVDlyNG9YVlM1L1p1WXdOK3cw?=
 =?utf-8?B?bzFOTnB2WHpuWWtsZXZESldsSW5UMi9tWU1LMjVHREtCa3ZOVlZMcDJzUzR6?=
 =?utf-8?B?OUtCVzBSVFg0SnluM0dlL09CQzdHbFZrTVQ3TWF0MDBpRk4wemFyQUQxSjNm?=
 =?utf-8?B?L1h1Wmo2YmNJQ0JoY01YeXN6SjJ0MUFFY2JOZVpWSFlaRWtxVTlYWVlVL1k0?=
 =?utf-8?B?QXhreEV1NDU4cnlQMS83RElCK3o3djhmOTRLTHpRVE91QW1CMEFNTDNESEhU?=
 =?utf-8?B?ZnhLeDI4S3NnMVExV2Mya1JEUDZVVm9GeUJ3Q2UrY2tGMWpWTGJpd0p4ekJy?=
 =?utf-8?B?c1hWaXBzZU9NUE1hcGQyOEw3TU84Q0ZjK203OEk3dThDaXd2MUpabHNwSHly?=
 =?utf-8?B?Mm5ERlRqaUc4LzBwWjY5eWgzK2lQSUpKQk1STFF2NG81YVlxMjVjNmdZcjYv?=
 =?utf-8?B?TmFRVkJheGIvNjN3c2NwVlYwMmN5TWJxcHZxTHduU3NxdWVNWWs3YXpHZTdT?=
 =?utf-8?B?RGdhZUtKNmVKMG04SFRYSWI5UHVoaWl5d0pPKzJieVBkWEkvUVhicVUzdG54?=
 =?utf-8?Q?9K2RQ+7IAMyGOmSIlcoJsTG3q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6177.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693f9a16-0145-428e-8954-08dce43bba2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 06:13:55.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDaNo1REyBXD/NEFGHICI30O8Y4+8KBZ8a+PbPBspiUnzesrbB+vrRx7d+6N5vVsk+xYlxXoEpchd+WPg01T6T9FbzJU7upskye3pQwfrEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019

b2sgYmVybmFyZCwgSSB3aWxsIHNlbmQgYSB2Mi4NCg0KVGhhbmtzLA0KU2hvd3J5YQ0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNo
LmlibS5jb20+IA0KU2VudDogMDMgT2N0b2JlciAyMDI0IDE5OjU2DQpUbzogU2hvd3J5YSBNIE4g
PHNob3dyeWFAY2hlbHNpby5jb20+OyBqZ2dAbnZpZGlhLmNvbTsgbGVvbnJvQG52aWRpYS5jb20N
CkNjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgUG90bnVyaSBCaGFyYXQgVGVqYSA8Ymhh
cmF0QGNoZWxzaW8uY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCBmb3ItcmNdIFJETUEvc2l3OiBh
ZGQgc2VuZHBhZ2Vfb2soKSBjaGVjayB0byBkaXNhYmxlIE1TR19TUExJQ0VfUEFHRVMNCg0KDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hvd3J5YSBNIE4gPHNob3dy
eWFAY2hlbHNpby5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDMsIDIwMjQgMjo0NiBQ
TQ0KPiBUbzogamdnQG52aWRpYS5jb207IGxlb25yb0BudmlkaWEuY29tOyBCZXJuYXJkIE1ldHps
ZXIgDQo+IDxCTVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZzsgU2hvd3J5YSBNIE4gPHNob3dyeWFAY2hlbHNpby5jb20+OyANCj4gUG90bnVyaSBCaGFy
YXQgVGVqYSA8YmhhcmF0QGNoZWxzaW8uY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRD
SCBmb3ItcmNdIFJETUEvc2l3OiBhZGQgc2VuZHBhZ2Vfb2soKSBjaGVjayANCj4gdG8gZGlzYWJs
ZSBNU0dfU1BMSUNFX1BBR0VTDQo+IA0KPiBXaGlsZSBydW5uaW5nIElTRVIgb3ZlciBTSVcsIHRo
ZSBpbml0aWF0b3IgbWFjaGluZSBlbmNvdW50ZXJzIGEgDQo+IHdhcm5pbmcgZnJvbSBza2Jfc3Bs
aWNlX2Zyb21faXRlcigpIGluZGljYXRpbmcgdGhhdCBhIHNsYWIgcGFnZSBpcyANCj4gYmVpbmcg
dXNlZCBpbiBzZW5kX3BhZ2UuIFRvIGFkZHJlc3MgdGhpcywgaXQgaXMgYmV0dGVyIHRvIGFkZCBh
IA0KPiBzZW5kcGFnZV9vaygpIGNoZWNrIHdpdGhpbiB0aGUgZHJpdmVyIGl0c2VsZiwgYW5kIGlm
IGl0IHJldHVybnMgMCwgDQo+IHRoZW4gTVNHX1NQTElDRV9QQUdFUyBmbGFnIHNob3VsZCBiZSBk
aXNhYmxlZCBiZWZvcmUgZW50ZXJpbmcgdGhlIG5ldHdvcmsgc3RhY2suDQo+IA0KPiBBIHNpbWls
YXIgaXNzdWUgaGFzIGJlZW4gZGlzY3Vzc2VkIGZvciBOVk1lIGluIHRoaXMgdGhyZWFkOg0KPiBJ
TlZBTElEIFVSSSBSRU1PVkVEDQo+IDNBX19sb3JlLmtlcm5lbC5vcmdfYWxsXzIwMjQwNTMwMTQy
NDE3LjE0NjY5Ni0yRDEtMkRvZmlyLmdhbC0NCj4gNDB2b2x1bWV6LmNvbV8mZD1Ed0lEQWcmYz1C
U0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9NHluYjRTal80TVVjWlhiaHZvdg0KPiBFNHRZUyANCj4g
YnF4eU93ZFNpTGVkUDR5TzU1ZyZtPTV6TGtiekZYQ052d2lZd3p5aFNMQzlyNUdRbkl0NFZLYXdk
QklpbkpkVkVmaXJFMQ0KPiBCRnF3UyA5UUdiaFZXT09LbyZzPXd4TTJzUnV6RG9xMzZXMjNfakE1
cE5nZUdERVBmVG15UGhzdlBxcDBfLUUmZT0NCj4gDQo+IHN0YWNrIHRyYWNlOg0KPiAuLi4NCj4g
WyAyMTU3LjUzMjkxN10gV0FSTklORzogQ1BVOiAwIFBJRDogNTM0MiBhdCBuZXQvY29yZS9za2J1
ZmYuYzo3MTQwDQo+IHNrYl9zcGxpY2VfZnJvbV9pdGVyKzB4MTczLzB4MzIwDQo+IENhbGwgVHJh
Y2U6DQo+IFsgMjE1Ny41MzMwNjRdIENhbGwgVHJhY2U6DQo+IFsgMjE1Ny41MzMwNjldICA/IF9f
d2FybisweDg0LzB4MTMwDQo+IFsgMjE1Ny41MzMwNzNdICA/IHNrYl9zcGxpY2VfZnJvbV9pdGVy
KzB4MTczLzB4MzIwIFsgMjE1Ny41MzMwNzVdICA/IA0KPiByZXBvcnRfYnVnKzB4ZmMvMHgxZTAg
WyAyMTU3LjUzMzA4MV0gID8gaGFuZGxlX2J1ZysweDNmLzB4NzAgWyANCj4gMjE1Ny41MzMwODVd
ICA/IGV4Y19pbnZhbGlkX29wKzB4MTcvMHg3MCBbIDIxNTcuNTMzMDg4XSAgPyANCj4gYXNtX2V4
Y19pbnZhbGlkX29wKzB4MWEvMHgyMCBbIDIxNTcuNTMzMDk2XSAgPyANCj4gc2tiX3NwbGljZV9m
cm9tX2l0ZXIrMHgxNzMvMHgzMjAgWyAyMTU3LjUzMzEwMV0gIA0KPiB0Y3Bfc2VuZG1zZ19sb2Nr
ZWQrMHgzNjgvMHhlNDAgWyAyMTU3LjUzMzExMV0gIHNpd190eF9oZHQrMHg2OTUvMHhhNDAgDQo+
IFtzaXddIFsgMjE1Ny41MzMxMzRdICA/IHNjaGVkX2JhbGFuY2VfZmluZF9zcmNfZ3JvdXArMHg0
NC8weDRmMA0KPiBbIDIxNTcuNTMzMTQzXSAgPyBfX3VwZGF0ZV9sb2FkX2F2Z19jZnNfcnErMHgy
NzIvMHgzMDANCj4gWyAyMTU3LjUzMzE1Ml0gID8gcGxhY2VfZW50aXR5KzB4MTkvMHhmMCBbIDIx
NTcuNTMzMTU3XSAgPyANCj4gZW5xdWV1ZV9lbnRpdHkrMHhkYi8weDNkMCBbIDIxNTcuNTMzMTYy
XSAgPyBwaWNrX2VldmRmKzB4ZTIvMHgxMjAgWyANCj4gMjE1Ny41MzMxNjldICA/IGNoZWNrX3By
ZWVtcHRfd2FrZXVwX2ZhaXIrMHgxNjEvMHgxZjANCj4gWyAyMTU3LjUzMzE3NF0gID8gd2FrZXVw
X3ByZWVtcHQrMHg2MS8weDcwIFsgMjE1Ny41MzMxNzddICA/IA0KPiB0dHd1X2RvX2FjdGl2YXRl
KzB4NWQvMHgxZTAgWyAyMTU3LjUzMzE4M10gID8gDQo+IHRyeV90b193YWtlX3VwKzB4NzgvMHg2
MTAgWyAyMTU3LjUzMzE4OF0gID8geGFzX2xvYWQrMHhkLzB4YjAgWyANCj4gMjE1Ny41MzMxOTNd
ICA/IHhhX2xvYWQrMHg4MC8weGIwIFsgMjE1Ny41MzMyMDBdICANCj4gc2l3X3FwX3NxX3Byb2Nl
c3MrMHgxMDIvMHhiMDAgW3Npd10gWyAyMTU3LjUzMzIxM10gID8gDQo+IF9fcGZ4X3Npd19ydW5f
c3ErMHgxMC8weDEwIFtzaXddIFsgMjE1Ny41MzMyMjRdICANCj4gc2l3X3NxX3Jlc3VtZSsweDM5
LzB4MTEwIFtzaXddIFsgMjE1Ny41MzMyMzZdICBzaXdfcnVuX3NxKzB4NzQvMHgxNjAgDQo+IFtz
aXddIFsgMjE1Ny41MzMyNDZdICA/IF9fcGZ4X2F1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbisweDEw
LzB4MTANCj4gWyAyMTU3LjUzMzI1Ml0gIGt0aHJlYWQrMHhkMi8weDEwMA0KPiBbIDIxNTcuNTMz
MjU3XSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMCBbIDIxNTcuNTMzMjYxXSAgDQo+IHJldF9m
cm9tX2ZvcmsrMHgzNC8weDQwIFsgMjE1Ny41MzMyNjZdICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8w
eDEwIFsgDQo+IDIxNTcuNTMzMjY5XSAgcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIC4NCj4g
WyAyMTU3LjUzMzMwMV0gaXNlcjogaXNlcl9xcF9ldmVudF9jYWxsYmFjazogcXAgZXZlbnQgUVAg
cmVxdWVzdCBlcnJvciANCj4gKDIpIFsgMjE1Ny41MzMzMDddIGlzZXI6IGlzZXJfcXBfZXZlbnRf
Y2FsbGJhY2s6IHFwIGV2ZW50IHNlbmQgcXVldWUgDQo+IGRyYWluZWQNCj4gKDUpDQo+IFsgMjE1
Ny41MzMzNDhdICBjb25uZWN0aW9uMjY6MDogZGV0ZWN0ZWQgY29ubiBlcnJvciAoMTAxMSkNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFNob3dyeWEgTSBOIDxzaG93cnlhQGNoZWxzaW8uY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBQb3RudXJpIEJoYXJhdCBUZWphIDxiaGFyYXRAY2hlbHNpby5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYyB8IDMgKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gaW5kZXggNjRhZDllMDg5NWJkLi5kNzc3ZDA2MDM3ZGIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiBAQCAtMzM0LDYg
KzMzNCw5IEBAIHN0YXRpYyBpbnQgc2l3X3RjcF9zZW5kcGFnZXMoc3RydWN0IHNvY2tldCAqcywg
DQo+IHN0cnVjdCBwYWdlICoqcGFnZSwgaW50IG9mZnNldCwNCj4gIAkJYnZlY19zZXRfcGFnZSgm
YnZlYywgcGFnZVtpXSwgYnl0ZXMsIG9mZnNldCk7DQo+ICAJCWlvdl9pdGVyX2J2ZWMoJm1zZy5t
c2dfaXRlciwgSVRFUl9TT1VSQ0UsICZidmVjLCAxLCBzaXplKTsNCj4gDQo+ICsJCWlmICghc2Vu
ZHBhZ2Vfb2socGFnZVtpXSkpDQo+ICsJCQltc2cubXNnX2ZsYWdzICY9IH5NU0dfU1BMSUNFX1BB
R0VTOw0KPiArDQoNClRoYW5rcyEgVGhpcyBsb29rcyBnb29kIHRvIG1lLiBBbHRob3VnaCwgSSB3
b3VsZCBzdWdnZXN0IG1vdmluZyB0aGlzIGZ1cnRoZXIgdXAganVzdCBiZWZvcmUgYnZlY19zZXRf
cGFnZSgpOiBXaGlsZSBpdCBpcyBub3QgZG9uZyBhbnl0aGluZyB0byB0aGUgcGFnZSwgaXQgbG9v
a3MgbW9yZSBjbGVhbiB0byBmaXJzdCBhbHRlciB0aGUgcGFnZXMgZmxhZ3MgYmVmb3JlIGxpbmtp
bmcgdGhlIGJ2ZWMgd2l0aCBpdC4NCg0KVGhhbmtzISBCZXJuYXJkDQoNCj4gIHRyeV9wYWdlX2Fn
YWluOg0KPiAgCQlsb2NrX3NvY2soc2spOw0KPiAgCQlydiA9IHRjcF9zZW5kbXNnX2xvY2tlZChz
aywgJm1zZywgc2l6ZSk7DQo+IC0tDQo+IDIuMzkuMQ0KDQo=

