Return-Path: <linux-rdma+bounces-12982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2EB3A48C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 17:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F24686481
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D37223BF8F;
	Thu, 28 Aug 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lWizcWAO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4321CFE0
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395368; cv=fail; b=gDAasKR2LIFYGHeRE3sc44HnbWrfphjlFSZfDnlBBaqvHnjurujRUBT2rNyl1V9kpdowAQSu4wy+alrc0N3YvmFUr02I8zKjUk50xpQfbj0L2n7gRtGRU8129xR9CHwphntj20FIjNATA8oEzA12HcO1NECcazvvY1ulEJUm+N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395368; c=relaxed/simple;
	bh=SubHWxrX6lqN+uGQhkiZFawltITzo9kQAdnAQk1PWbM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fI+p07PgHOjtUs+JJCrWsAnrUauseOEgYFfT6X5xCWkn0yA4IAehXyebThcUoRamzWLF6uxQ78V5WnXAekk/rQTLwl+g4NmKW7bRcpauK9/vdZqjboRiex2yXx9A7liiGFeJhHw4NnK532zxDTw9HH3IuagbsdFcWRYPLoi6ntc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lWizcWAO; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0qsAgtm72xJR7Gib4BdkvVN42+Hp3KFnC/SN4XmEXhbjIJoR+BzFRSweLPQl+4rRqs8j7TpJ1jN6PsLl6Ysyk7lq6gS+HEId1BOThFIKqe5w86qOgpaCJ9byPLb7S/le+S9oC1KoM4hH8USmP3iD/fyhnp30c+WphOSTuOo3oF7mtBB9JbOVLHTp3IEnGtFxHEz9mRn56Ky/RXSe0rCHNZe9RZV+TGG/ygBWqxaols/lY8xVf1FQTjrwYlMNu3d1zpF4TJblfYhFA/nDdF1WbbQnEnJOIoaK4uIRFy4SjmVQ94VIYq1PFrbTCO7HtbUY4V97+D6WM3uTff5oUlwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SubHWxrX6lqN+uGQhkiZFawltITzo9kQAdnAQk1PWbM=;
 b=XEEXy5/Zr9/kiSKNK8KRe0NQr4j1OZ52VpJizSO43By5KmVrunSTOAJbGDyU3AshaO9IWwGA+WWzkU3TU1qih1b8ToUu6tCdie5Sb92MFq8oKDPlPOm7uIWRlQKlNQMcE5AUcA3IqZ+itpsQlxqmfIGv32PQSXrzjxgvAKZf2sHlpTY8OV37Kyrs3waI1mWqDvrzO4cT9s1NDXsJkNfBbc32OQV5hEU+XKycrpsk4nWWKEn3IO8kVROn5BN+Ez48dO9sSxoh2aTZUYdn2BE1GI+cbjMaTI2GTtPTN7ku2l0Hq3rkitFPRAYtlE1XERtA0e1+FTyYf3xybqwWy3WXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SubHWxrX6lqN+uGQhkiZFawltITzo9kQAdnAQk1PWbM=;
 b=lWizcWAOJ8ZZe+GD1hXM+2jcL5o5UyWMLiUNZ4jVJEYr6sf0P7LAPbfcO2ahf/YVApoqiWNkN+Xd27KZ0e/LHblH2nutAegfmeMU8T9py6yG8DroRnl7MCQlQUH+L4hiCbAlGed9UL6YWOHd7ykaypK0Q6OmQPj1+0Bz+xnbNLktXjT7XoIhVMjxRI+90ndeou4jMJ9GPWTGe0cJ4+KfOSYs399aa7bf2RF+6bRDi/KzeqbtY+rivYoztB2RmdrFQyp5fIMG8PGBQwhPDN8mvxbD2kSgPakKn1dHFJ1IQHwboR2X+Y/vzRDkeuYxmM13gZlgOo75mzLOz1Yb1tPxmg==
Received: from CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 15:35:58 +0000
Received: from CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::4fd5:60a3:9cfd:1256]) by CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::4fd5:60a3:9cfd:1256%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 15:35:58 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Mark Haywood <mark.haywood@oracle.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: RE: cmtime changes
Thread-Topic: cmtime changes
Thread-Index: AQHcGCisbs9EfV+YqE2rrYO1rU4Av7R4McjA
Date: Thu, 28 Aug 2025 15:35:58 +0000
Message-ID:
 <CH8PR12MB9741FA55780650C84CD3F807BD3BA@CH8PR12MB9741.namprd12.prod.outlook.com>
References: <1e5a6494-91fd-40a3-abaf-a614bc3f0e2a@oracle.com>
In-Reply-To: <1e5a6494-91fd-40a3-abaf-a614bc3f0e2a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR12MB9741:EE_|DS0PR12MB7510:EE_
x-ms-office365-filtering-correlation-id: 2a93122a-38ab-4976-4750-08dde64895f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RE9tb2JFUWdNN1NpTkFHck9xYzdwUVh3eXBLdnJzOGZ4S3lGdjdEUDRLUlM5?=
 =?utf-8?B?S0I5VTJrTjhPdEs5VnBOYzBHNE5FNGxxYnVDd0FZUUkzRUpocTQvSFRwYUtz?=
 =?utf-8?B?VEVlelVMQWJGU0V5TkcycXNKMm5BaXFESG5rUGxKVUErT0xmeGhZMUhtK2NZ?=
 =?utf-8?B?Z05KTis1TUJZblo4TjJHa29iTUpJU3BXYzMwWUZWTENHOG5wY2hrd1JqbW5Y?=
 =?utf-8?B?YUVlUjkvOWNqaVR4bkRUMmxwRENXM1VUeVYxeWVFZnp1WEFkRm43Z3NxVXFl?=
 =?utf-8?B?b2VRRDUwUUxrLzVsSFFsazVVdXBzMHdRSlRaMmYzL3VjS2VuMC96Rms2aThY?=
 =?utf-8?B?akdUN2VmVTZaMnVSSjFaeml4blYzcVRsaHVDbTVuZ0h5QU0yQytGdVliUEp4?=
 =?utf-8?B?aXZpc253MVZ4VXluOFRBVEJ1eVp4QktFTEhtcmx6Q2YxamJjOTlpeGZKeU9v?=
 =?utf-8?B?SzhScjNvMzJ3bXIzQU5ML1VuUzVYZ2Jaa0t0N1plZGk5TWl0Ly9uaVpCZ3VE?=
 =?utf-8?B?bmtERTRBWFVZOVlHT3J6UTBoSkNlS0RxeUxIelFqeC8wY005QlA5ZSttUDBQ?=
 =?utf-8?B?REFFcTlBN1kyYWMrM05ZRC9sTUNHVS9GQ25vdzUyYjNMcU1NNmZ2RHdnM3lV?=
 =?utf-8?B?Z1A3cTZuSStqVkd1SHZTYXc4VnRTZWZsdy9vQVpwSldUSSttY25iWU54UDVX?=
 =?utf-8?B?OFhFVjMrUWVUWldnZlJJSWZjSzYzV3hxUlhrWmxQR1loczJvZlJLVGtZQTJJ?=
 =?utf-8?B?NE5SNlE4TzhQZ2lpWHNIWGdmeTJGSkc5NkVLN3Nva2lyS21JMmFvYmJ0d0VM?=
 =?utf-8?B?OTBxd0pDQTZSc0ZNL01nUHNOTGkvZWt4d09zS2pGbitrdFNsY2s1V202L3ZI?=
 =?utf-8?B?RmdLV09zYUowaExrbFAzVitUaGt3Ynk0K3lFM2VwQTh3MmlHRWp2MmROQ25K?=
 =?utf-8?B?ZjhaemRTQVVhWmFCL2IxZDNMVWJJbkQ0QmJRS1Y0MjJrOVNkWk5YNWpsNVYw?=
 =?utf-8?B?YlFRK3NGY0cvUWhMRHBqdGg5ZkludnNtTDlidkRVQzlMZWRqcGNQZERmbXBT?=
 =?utf-8?B?N1lsNDFmd1NrUyt3Y292M09UeU9zdGxYMVhtZ2l5Tnl2WTVuWmY1RHRQTE9m?=
 =?utf-8?B?OGpSOTR4TGlGaWN2YzRUekNpQnJydkpSZVdwNWFlcXlrOUlBU3RLby9PZ3BY?=
 =?utf-8?B?K0wwLzA4Y2xaS3JRL1h5YVU2eHBmM3A4TDNWUkRPTlhVUlJnTDRHUXNjZlpj?=
 =?utf-8?B?TXlyL0o4Rml6NW5HUy9Wem1tTDNFeGtaUlg2QnVCZFBObzNVV3RJNW1CWUFV?=
 =?utf-8?B?d3U4RVQ2TFlJSUhndDdjZzVtVWZQY2YzYVd4aVZ4SUloejBtZlNWL2pHbSsy?=
 =?utf-8?B?S3dqYlB0T2N4U0RyUi8rY2hnREhOdy9OMnozaDVnSlUyMHVRd0REakdEUUda?=
 =?utf-8?B?NjVGYjRpejZCMVFtbEl3YktsUUYzY0Y3ZktRMDRpcWJkSVNWamxoUGpqTEZT?=
 =?utf-8?B?MkdiQkltMC9iU2FJYm80UU1TdHVzaEJFbFoxanNIeUNva3B5dHlFZnd3dnY5?=
 =?utf-8?B?WCtmUXhMR0hhZlJ6OWdsQW5lQmQ0N1dGRWYxalBVK2lReUh5WjhRV1MvTmht?=
 =?utf-8?B?R1FwTlBjdlpZSEpKa1M1dXFVMmVLN0Mvd1BKS1R2c29qTVdaTS9aQ3ZYOHJP?=
 =?utf-8?B?VFhrMFVLYmQwdHF2YU5RM2dINC9ZaUNpMy90QTZua2o2TW1naGZ1UnB2YTBt?=
 =?utf-8?B?SlFscGpjQVlVRElHSmxFVHRLd1piS2Z1WUh6NGNIZ1pGditheVZEYkJGOTVh?=
 =?utf-8?B?ZWdCODNlRzR2aXMzV1MzTzdmdzM3UHZtR0lGZU5KbnZxcDhDZXc3RnlHa1gx?=
 =?utf-8?B?TWZkaWxMZWVLaSs0WWNLMVVHZFFabHFRRndXbjdveXNTNWlrSDRGaGg1V2Rh?=
 =?utf-8?B?TFVOTWZ3VkRCVldTOFc0b3JCZGFaSTdoSUQ5ODFBZC9GL0wyT1VxRTl2TVdQ?=
 =?utf-8?Q?8of15uioGBPG/wqLehyXdJ42gec9UE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9741.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RE5BR096eHVTY0xtT2hCUldweFl1NzlQSnc1YVkzUXdubnlMSHRCZXJ0aFpF?=
 =?utf-8?B?dlZCN3gwZU5xekFCeUllOXQ2b3U1WndDVlhkZVhFcGMwTFY4WUxzNFhrMDFy?=
 =?utf-8?B?Yjd3cjdRQThjZTFWcVlLZHd6ekJ1cFZlSUdCaG5na3pYR21icTFZenN2QVFm?=
 =?utf-8?B?bDRLeVlRaWJTM2o2bXNyYlc4ZmFIbVNzU2hxNkhScTJrR1JZMmRIa1ZKektx?=
 =?utf-8?B?ZTRjWWw1eEFsWTkzcUJVRXV6ZUcrRDYybUVRbitTTUFFTGpUWWVuOHZRWFhX?=
 =?utf-8?B?S2ZTMHdyQUxveWRoQVJONzRtdmNYdnhwdVlNTlBMY1B6NURDeU4yaGQ2bVF6?=
 =?utf-8?B?OHlqaFk0L2Q3bXRFa3VFZHdNR0hobzlyRm93QnJrV2NSZ3luOVhmSjJHbGZq?=
 =?utf-8?B?UHVGUGhzdkE5eUxSckdkVlpwVjR5OURjT09vWjV6KzR3QmxLSmlKdHRRVlZX?=
 =?utf-8?B?blpBTUwzdStrVWpFT2kvbmk2RDRmN2lSVWRLcy9GLy9Wb1Z0YmhpdGhkSFdU?=
 =?utf-8?B?VmltMEFCS1JCVCtDUC9FQ25FSkdCNld5VHU0UHVTMHVXTGdoR1p2WXJkeXZh?=
 =?utf-8?B?eXN3eDduR3VQdERVS1Jza0FFRS9BRis2SEJIaWREa0tQZVA2SC9kS1REY2Fo?=
 =?utf-8?B?Nm04b29Fd2hETHMxV2Y1Z3IxdUNESnFDQWgzMUF4V0V2OHo5SklIa2NlcXV5?=
 =?utf-8?B?Y2c0TjJ5RjVJaEtRbnRsWGxvbDFmZXdvdUJ0R1E0dk1TbkEyRkxIMlVyb0lj?=
 =?utf-8?B?bjZwZUVDaU1maW1EbkN2OGd0YUl3TnpzZWw2cW9iQlUreWppR2FrMXVndVFI?=
 =?utf-8?B?K28xWVV5VndiRzNGWDRmNWpiNTNlUzl6KytIK0ViSGNNVG9hODZTL3ZYdUpj?=
 =?utf-8?B?bzBreVFoK05tbnZtTllRV0p5WDk2MWtxUS9OSFpKemVHS3R1T1FPK0YxZ2p4?=
 =?utf-8?B?RVM3WUkwMEhrRWphOWlWTi9mbVV0a0VHR2wwNXFIQ3Q3V3d4TmVsYlhFRXhB?=
 =?utf-8?B?OUtEVjQ0WkcxS2ljcVNoL1VHdGxkbk1GODR1RHZWazE0OFkrOFhDaEVkRjhP?=
 =?utf-8?B?K3d3R2s0R1RhUWZmRUtMYjROcFMrTjZaUFJjVjZvVmtrdkl4bndnTTNkdmVm?=
 =?utf-8?B?U0pRZXJTU2U4RlJMdkIrSDBrMXRIQjBsODZva2ROZm9yQzNwYm5wQUpYK3F0?=
 =?utf-8?B?TmlPd3pSV0pRbkQ1bVBOTDducjZCRE9ZZWtqVjgwVDJUQnRTRERtMzd3TmRV?=
 =?utf-8?B?TTlsTEJWc29sSEg1N2Y5UEpsalZ3YXIxUzRtcjNCY3VZQnl5RUlmZUlnYlFn?=
 =?utf-8?B?Yll2REh0MllMUjZHdXM3Y0NWMk84Zlhwc0ZMU1puTEFpVVVhZVdPdzU0Q2pK?=
 =?utf-8?B?ODNjNmtlbTZwczZiVGVqWDdLdFdvMUFiSmhQa2oxcnhyL1Fma0w1MDQ0dWdW?=
 =?utf-8?B?L3hNRjZDYnJsay9BOTNoWHdPR2x6ZmhvbzVTai90ZURyaEg5ZXZnNUF6SEMz?=
 =?utf-8?B?QnVlWmM2bFRQZFQ4N3ptVm1jSlBpNlhydm01ZHNOTGNuZVE0ZnNiVGx4cEJG?=
 =?utf-8?B?N2VRTW1qLzdMZnp5OXhqWk53eExITnZtRThBcVhwTElCeTVucVpScU1Hc1Fl?=
 =?utf-8?B?czRtMVZCL0RLc3F6aVRjVWN3eE5CK3hWbkxuTzAvQ3IyNVNWNm4yTG1vREQr?=
 =?utf-8?B?Z1NiUGN2bjc0NStTb2JBMXIyQnIvcFhOdk9obkhreVZYaU41L1JXR0NhV2RM?=
 =?utf-8?B?UDd0U0NUcERHb0dBaEEyTzlOVlhwSE5Fa28yZEczc2JXOXdaU0R1L0FVZ3dY?=
 =?utf-8?B?ajc0R05FSHhtTFNySnVWZXBTREhBVTBHVDFHZFZ2UUFoWEVQS0sxaXJhaWl2?=
 =?utf-8?B?RFM3ZWFMSVVZdUU5NnpTc2FFbktzQnB6YjZuOG43ak40bGF0RjlkYjZRcmFl?=
 =?utf-8?B?bmh0SUg2RnVKTW1lQVd4TlhnK1Z1OEZYUmhERlAxR0wvMFhRa2pwbWRBTlNu?=
 =?utf-8?B?T05vTzQrV1JzTm90blhhMUpLdk5zbzJDNEt4TXYzdm12QkJjNm9HNjBmUFFo?=
 =?utf-8?B?amtDN3Nlem1ma0ZiOTRrRGNjTWtGbG9HK0d4QlJIUTROSGExUUxuMHZuSndw?=
 =?utf-8?Q?dhpw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a93122a-38ab-4976-4750-08dde64895f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 15:35:58.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTI2q8eS+zJ5ED0WghO933jk6QXs+uHQl7KJSYHUihrhPR7fZN92Vn5l0SV7MZotaLQBZjgLATU38tWyvCplng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510

PiBUaHJlZSBwYXRjaGVzIHRvIGxpYnJkbWFjbS9leGFtcGxlcy9jbXRpbWUuYyBsYXN0IG1vbnRo
IHNpZ25pZmljYW50bHkNCj4gY2hhbmdlZCBjbXRpbWUgdXNhZ2U6DQo+IA0KPiA5M2JmNTRhNDNk
ZTIgbGlicmRtYWNtL2NtdGltZTogQmluZCB0byBuYW1lZCBpbnRlcmZhY2UNCj4gNjc4NzlkOWYy
MmI3IGxpYnJkbWFjbS9jbXRpbWU6IFN1cHBvcnQgbWVzaCBiYXNlZCBjb25uZWN0aW9uIHRlc3Rp
bmcNCj4gMDg5MmRkNzcwMGY0IGxpYnJkbWFjbS9jbXRpbWU6IEFjY2VwdCBjb25uZWN0aW9ucyBm
cm9tIG11bHRpcGxlIGNsaWVudHMNCj4gDQo+IEkgZGlkbid0IHNlZSBtYXkgdXBkYXRlKHMpIHRv
IGxpYnJkbWFjbS9tYW4vY210aW1lLjEuIFdhcyB0aGlzIGFuIG92ZXJzaWdodA0KPiBvciBpcyBh
biB1cGRhdGUgY29taW5nPw0KDQpJdCdzIGVpdGhlciBhbiBvdmVyc2lnaHQgb3IgdGhlIGNoYW5n
ZXMgd2VyZSB1bmludGVudGlvbmFsbHkgZXhjbHVkZWQgZnJvbSB0aGUgUFIuICBBZGRpbmcgVmxh
ZCB0byBzZWUgaWYgaGUgaGFzIGNoYW5nZXMuICBJZiBub3QsIHdlJ2xsIHVwZGF0ZS4NCg0KLSBT
ZWFuDQo=

