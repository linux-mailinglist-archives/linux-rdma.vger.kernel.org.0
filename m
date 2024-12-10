Return-Path: <linux-rdma+bounces-6385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2459EB08E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 13:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7BE188A98B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19B1A2547;
	Tue, 10 Dec 2024 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Lm6oiN1r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81F19F130;
	Tue, 10 Dec 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832782; cv=fail; b=tpmKybYXEEm7MPlSN97KYIj9jTdWAGPoXVGdUOSCYuqEx6e5dX4a4aqlrzyBk0shC4nxLtKXwU5c6QZVCf/xa8Bg0IV48r4lC8UmF9WKw9PtoOUmx6rMXOoYe93aWJDlHOzGW4ezbUTQB4c1JVXWb8CFAJra/C5YVm3X1ktK2V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832782; c=relaxed/simple;
	bh=ETHSN1iVl3aApvTelIx6HNAdHPlWjNYGsdnHN9v9rvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YHh7a2DZ+lOLq3iMu75ZNa7iyPhswZxLk3In0N2OHFwquCnR4IsAsZ+3jI6MsNzeBwBGDQqGhIi4duQzcwm8wS1DYg7ZZVBry7tQcn+k0gODmeqkQs2xKQeQydsBHfC0PCFXBxmld/NceWmKjUYwJTwly13W0Yj5D3O9iwjRL0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Lm6oiN1r; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733832781; x=1765368781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ETHSN1iVl3aApvTelIx6HNAdHPlWjNYGsdnHN9v9rvA=;
  b=Lm6oiN1rZFeaPd9qfVGRoZ8/JcsuvX3THosYUY4vOiFJRHRZ6r7JpUwn
   uj9UMHEaCW9lN7fY21EGtuYOkLkzkyQRI3BDXW/AeZSEkGFJKxC9Xz8Db
   dM+OIMBtzP3GexOeNS/Y2K5EcCqCin9VU/cPp0Q8GO0Yn9RT/Y6Ci01N7
   /N1WARfzuXRKCZNW1K/spzr4CowQVktu1BqJEEd0gxLUJHIreIQxj3FYp
   tqs+s1rrGGAZ6fIiz6IzjpUmwFxgNSMhd9+aTJQLBHVBEzaFDmofkLnH6
   nTUvU9OGFm6BdPXcD75XcqtfrgyhyuvNi/PSYmK+gAMGHfFbDPqmTd6u+
   g==;
X-CSE-ConnectionGUID: tX6Ny6nuT3m0UHcBT1TALQ==
X-CSE-MsgGUID: MZkz/1NAR9S1kHjqBnA7YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="139321389"
X-IronPort-AV: E=Sophos;i="6.12,222,1728918000"; 
   d="scan'208";a="139321389"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 21:12:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2L+EebZUq+Jo9T3bYDWUda+ygt4kHkhcjZK7CLrjIFRAl9iqtZym4ERuwHo3jzTap1ItveBqaQm+OwVb5L7mgAejyJeYqPkzFc45Keqj+hECPyogeUDtzWUPsXS4J8ilClHN8JDVBD5/4yysKkqxpmlvfrxzI2Aqlakrten5Yd70cqdIJJSRXoBCmAOA7qmayOpMoHC+TVOrysb+BTb3GRiNJg7W2l+Ofpj8rJc/Iec5cQRC4yzko+uQRxmyWz1Cng9ltzaA/9In9qgVdZh4Jh1UKmKpEk0Xhm8Bv4itGRFJBw7T4qfCjf6cxlQ4YeCo9lhQFrXcE0ExPJNvYls8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETHSN1iVl3aApvTelIx6HNAdHPlWjNYGsdnHN9v9rvA=;
 b=rfYJykGuwvrz5WkW1S75CJawo2xHk+jFr7An8ToDqlOJd2v9gXrHZp+kyfSzBthoUXbo4bvsAxu3QKz8lzESlkG2Qt3zFOCdgEsM4vuWIXrg9FrFj+am2zbxcWgj4gGs8T7Y+TX2PJUCLf1mvY8u4D53AbzOyXUPLumIVrgCVACrD9V7nbhQrwZMucvOTIaL9xensmYOrcneQCNqrL9V4eKRL8GAwcFfyYZvkp4an8GoYiqY/QhK0ARP+bLG5iK6ouvoVLmtYShu/w73Yu2bl/9mKf8yfr+tlWTYd4T7ODFPd4xbhKhQ6HxxTdi3NldBKG85B394arYkflqON1/7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS3PR01MB9460.jpnprd01.prod.outlook.com (2603:1096:604:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Tue, 10 Dec
 2024 12:12:47 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%4]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 12:12:47 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Jason Gunthorpe' <jgg@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Thread-Topic: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Thread-Index: AQHbGe7gxkmvLoNIN0q2dVdbsLfwpbLereUAgAEIUsA=
Date: Tue, 10 Dec 2024 12:12:47 +0000
Message-ID:
 <OS3PR01MB9865AAD73DAD668A0918E909E53D2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
 <20241209193102.GD2368570@nvidia.com>
In-Reply-To: <20241209193102.GD2368570@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9M2JmMGVjMWMtOTI0YS00MTE4LTg4OWEtZGYxZWY0OGVh?=
 =?utf-8?B?NjhiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMTItMTBUMTE6MTc6MDRaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS3PR01MB9460:EE_
x-ms-office365-filtering-correlation-id: e2ce367a-c603-4ad1-54be-08dd1913f58b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDM2S3dnRmlNL001ZXRJekE5NkdjS1FrQklpUDVXZXRuaFVReG1YdTBHNWRz?=
 =?utf-8?B?Ykhia2xFd05DOTNiMldlSCtvcTIzWWNJcDZIZ0ZjUjhDTUJhc096SnZ2dXN6?=
 =?utf-8?B?aUpOeHFqeVk2WHo3elIyTHpvM1lwYXZ4aGh0VnlyeHVsNXNqWlRYc21kSXhP?=
 =?utf-8?B?YTB6ejRSOUoraUxnUXQxbTlSLytlWXF1VTg4UFYxOUxMQk84a3YzUzBIV0pu?=
 =?utf-8?B?bko1NDlyb2RobTdZT0VVcjQ4N3U4VnVHRi9jZ1Evck1nS1k0dU5oSWNYcUJ4?=
 =?utf-8?B?bzFEU1lYeFVEcTVrbS9wQVB2dUU4bVlwaWw5N3RNcW1aeUpjMkdyRm1nT0VO?=
 =?utf-8?B?Y3BwVUlxY1U3R0ZSSC9PQ01RNlpyV1lEK1M0TGFLMC9xLzk1NDJ6UlFDbzY4?=
 =?utf-8?B?SElVYzF0cFZXYjc1U0UyaElZS3M4amhWRThpTHVMTG5GYUVPS1I0WCtROHpv?=
 =?utf-8?B?azlvZ2lKZnMyb1luOTF6NzdQY3VWbkFZcUdRdVZCbWtXYm1nT29ZT25BRW9M?=
 =?utf-8?B?bkFHWXpFdFJoTy9JQWFCM2hDZWNZTDlITVY1RVZTNU9HSkFKdGFpWVdWVHBy?=
 =?utf-8?B?SEpVb0NERUhwbTNERitmMGw1MnpJUG1veS9zRVdKMEcrTWk5eU52VkZIZkdR?=
 =?utf-8?B?cFk4RXI1MjMzb1YxeGRlQ1ZkRUt6RHh6YUs3UnlFcFZQeGRIR0JjQk5wZDRI?=
 =?utf-8?B?NDhFRzkvTnVhNmtiK2hZRFBSTTdvcWlReDNmTDNmR2RyWDRHVUNDMWVGY3k0?=
 =?utf-8?B?OUM2aG51YUZMN0dZNitSeG5BczVkdHNjU3Y5YUs5elVKZHVHckdtSE1VZjl0?=
 =?utf-8?B?TGt0ODdYUTB0K0lURllvRTF2bkRKYUYyekh5RHRSQzlabFd0MERwL1N2T0d4?=
 =?utf-8?B?UWE4NU01U1FCOG1BakFlcFNrZ2VDOHhQN0xEVksxdFRraGtUbTNoVGh0N0x4?=
 =?utf-8?B?aXBIcWxRemhHTHozQUtNaVpneGlRVGZDQllIS0Z3U0Y1U0N3UEtJUllSWjda?=
 =?utf-8?B?bGcxd0NxZzVYNUQ2TGFnQkU4TW5MY2M1OHI0RE1hS1ozOW5RYVpmcDRaS0pQ?=
 =?utf-8?B?M3ozOWNDWXd6S2RUektsQkV1eTA2OW1Ja3ZlamJ2T2NNL2VvUmFRSXRJeW5h?=
 =?utf-8?B?YmlqL0pkeFl6cktlcUg0SlRJWklBWlhxR21yVWFlWVhMVEpXZzNwSmNsL0Rx?=
 =?utf-8?B?T2ZLVEJoY0dlZjVCbFJsMlorT29FMmNmNlBZazdCZTI4cWJRV0w5VzJOVy95?=
 =?utf-8?B?cGc3UXp2d05oeWlUVkliVmI1SGZqT2JTS0o3bVFubGNrdVR3NTdxbDN4TlZn?=
 =?utf-8?B?eFFIY0VwZ0Y5TGVYMU1JZzRJbk9YME91anI5UndZV2Q4WkZvdW42TUQ2M1Rk?=
 =?utf-8?B?ZDVxRDFNemsxNFNsZ0Z2Y0huRVZOTDUweFJ1TmNwQzJORWRxYVllNGdvUlY3?=
 =?utf-8?B?aTlmZ1gvQXU5dnJwRWZYZklPSThEL1FlZmtOZ0RMZlZWVC81VkcxTDhUN2dY?=
 =?utf-8?B?b0NrS2pjS1ppaDJaQkRLcE5laWpYc2Fzdis0YS9DbU5WQzNZckxTZEU5V1Ri?=
 =?utf-8?B?QTI5SGlDOERCRTNXeUkrd3c4SHQwMDlod09DMnloL2U1L1JSYTcwRzFnNjRC?=
 =?utf-8?B?TDN1ZExFNzZhdXBFVDdyOHhKUng2QTNUQURLc041WTR6VDhMaTdVbjVUMFIw?=
 =?utf-8?B?bEpxNlVwQWxhNTc0RGVTV1Vwbnd1MDZCNkVTdENENVA1eFN2RllxZFB2d29W?=
 =?utf-8?B?RzdYRGtqNCtKUnc1ZlJFK0Q4Rmo2SEF4REJJd1pRNXdwdFVDSndNaDBUK0dq?=
 =?utf-8?B?cG5TOXZ2RTQxZGRyU1ZDdUtyek5LUFc1amZaSXFxZTFzKzd3SzZQRytBa0Q0?=
 =?utf-8?B?aUNSQmMrZGNEbWxmQ0xHVUVMNmpIanJMRDhYZXNxb2lDa2hzUG9XMnJINDhT?=
 =?utf-8?Q?GLguAuNmR0fHYSBhBRua42E28xWtg98D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0hwSmtTWGxTTDdubUswdmpSRzd5U3N6cC92VTFOOFlCNGRnckxvalFCQmp1?=
 =?utf-8?B?RVhhN2JySkR6M2J1NmVhd2xPNzdTRnJqaSs1dHVqRVdmUW5MejdFbGFTYVY5?=
 =?utf-8?B?a1VScmJ6ZE1IaDB1alppeVB5eDgrM1lXNkhDZkh6TkhLanZVa3pQVDRIbDhE?=
 =?utf-8?B?UkM1TC9mSUx6RWVGZkhmRGhRNS9aRmpYN2ZESm1RN3RXOFlkNnhndFF1ODBm?=
 =?utf-8?B?eEdkMzlzYkNOajBBakdPRHRiQ3JjNXNiV0tobW1nUk9UUWozbW05aHlFTDln?=
 =?utf-8?B?MWJURWNsRFpoelFid0I4K1lQQlpDOHJqbys5U1hMMFMrRVVzQ052OVR0NEJw?=
 =?utf-8?B?dnVQMTRDbElDL0x6L21ydnpyN251M29HejZMTXRrYS9oYWhHTDdSNDNDSU4y?=
 =?utf-8?B?SzlwRDl2byszcFg4RjF6ekRHc2psdGN0YUxWZkxTclkxeUtLMFU0Z1Ard2Vh?=
 =?utf-8?B?Z2EyUHI0blZDSW1FZjdKVVVYUUIzRGtOSDF1anVhQ21wV2FMSkdlM3BnWXNC?=
 =?utf-8?B?ajdlbytKMjBjS3Y3eGlKeWE4ZHBPUG1ua1lhU0VWazM5Q1BzMCtUT0hSb0Jw?=
 =?utf-8?B?S2FMZGxvM05oVFZBajlrM2VDQVNYSTk3MDM2ZTJia1luY1pKRGJrN0Q2Qk92?=
 =?utf-8?B?VjU0cE9PWmx0NUJJWkFEMUNqelZObXB3c2Y2TGtDTzRZalJXaVVxVWtJVnJB?=
 =?utf-8?B?RVdnbGV1Rkp4SytzYlFNaHVlSkJMbHNCNndUcy9YNkFxMzRreE5qa0RRMmtX?=
 =?utf-8?B?d0NYcDdzUkpSOE5mU3dPM29sdVpmOGpRRytGeklvK3FYQ2pYcnI0NDEzbVZR?=
 =?utf-8?B?YXRVc1U4YW0zeDZ4VERYK0x5YlJoMjJnMFQ3YXBlR2VGYXZVcHlZUHBqWlF5?=
 =?utf-8?B?SnI2eHB2QW1QWHRVN1VMTjQ0QjNBTnl0TzROUHRxcE1QeFdmSWhoUk9VaXcz?=
 =?utf-8?B?UnBzUm9hRUlzek1iTXlVbG9EbEJRN2V6ZEdNMUpwVEY3d0poNUw3S3VjWlpT?=
 =?utf-8?B?V0wwbkNGY1VxZzZCQm5ja2FnT2draFJxZVBQT2VLa1BPanZjMFg4QVE4V0NG?=
 =?utf-8?B?L3k0OEpnSTl0NjVVU2R1Ylc1V0E3ekoyaFpsVzlQTWJLcDNGSkMrVHlVc0RG?=
 =?utf-8?B?T29RdTNkMU1BZEZ2RFRzV1dQZEtFclpaampTUENMSW5zaEEyQ2dJdGg3Qkxw?=
 =?utf-8?B?Nmg5VVUrcmc5WjBXeXpyQWZ2MWlZY0t5dThlS25FRXFuS0wxdldEd1hDd1Mw?=
 =?utf-8?B?NzNjVCsvU0tKY1dvS1dVT3JOd1M1aUN0RkFEcDJ0a2puSUU1T3VqY29ZVEVO?=
 =?utf-8?B?enY2V2JlQWx1cWRXeGt1ckJLTGRhelBXSDJqQkZ2ZFI0aVN1MnM0SitpTXRD?=
 =?utf-8?B?MWtsWWJsVjFNUXFCd2NVdmhWaS9lbGlSbm9iVVUxOWJlU0o1VFpmV0pUcENY?=
 =?utf-8?B?VzBSOGMrWWgvU2VBaFhYcmsyMXZqa2MycjlQd0lnYkVaZGNWcmVmNmx0TFZ4?=
 =?utf-8?B?V3JJTFYyU2cvL1I2MVFzZVdzdXlYbWgyT21EUkRFOVBybWswYmJMcGlOREk2?=
 =?utf-8?B?QWcwSzhQMVcrVmNlWlM0SCtTVGo4UHVBOC9vWi9HVWptVFZ6NXdtUUhOS1RT?=
 =?utf-8?B?cGFJZmtJOGM2N0pLY2EwdVJJMm5VU0RBZTFRd2syeUpVRFh1Y1ovZE4rL00r?=
 =?utf-8?B?MnVLaEVYQ3pxQjJ0OEEyWG43eERJTEhDejV0M1ZYeW4vQndWeHhmNTcvMVBZ?=
 =?utf-8?B?UjIrQkt6bmJTZGhOK2NURXMxV0hQQkthRWZCL0h2dE1zWXM0REFieXQ0MFdx?=
 =?utf-8?B?dSsvU3p2Tk5KbjF3b1FNU2M4Q1FtNy80UkdHUTh4S3BubW02S2hhUjRqaldy?=
 =?utf-8?B?Mk5xVjFxVFF4WVJnNHp5RWZiUldXNmFQdGkxWUpiVlhueGl2eGQxSVRXalg5?=
 =?utf-8?B?dkVxWkdqVTZvTTFkRWpnZVpnTEJlY3g5clpMTHZLdmNhQlMxUHo3UnhzNlR1?=
 =?utf-8?B?TTNOVk14VVkyVkt3WkxjanZXNjhqY1hIaXpzc01SN3VSUjBLVUIvSFE5REMv?=
 =?utf-8?B?TDhadVdMdWRnUHJyQjRQWUxlYk9DQ0haZzZtMy9sVWljWUF5Y2lsWWgxSGRJ?=
 =?utf-8?B?NmljU1NhWjJRYWZubVFMRjJ4U0lsN3M1UStkWXdVSHp6dHdxQ3BlK0Z4c29M?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pYcaPeikHJFI9lfCQpdJZX3b5ds2xjsou7x/M5XucM/HybwZtiZwNr6bL2/mCCC7jN/zdGjbisDtv+qtwLkqWU0A8jBa0TnuzBAtqTIBnYVYlCOaTvQzYfgfwFdGdJe7Zgd6k3BSyPk31Uk3PaHy7Om9Fl2n+BekFBG2B0xeQcm9B19CoqkOZbxeR2EfHKDHn8ANb4Xv0HPoUAjjlAwWE4faXp8R5IgWwefg9or9cHXzVXUIc0tFgjsgEQ1kEDRMbmfeuUOP2jn5VrF0mT4XB6pXJBdQUaH2D52Fa5e1xDIyOVCjAuB/syT0OzPUAQjk5MsQoXVbLRsERlVew1CxuRgxAP+HabKSm7uff5MFMOwxrjy5hdDm+kROaoGy3p7M1X4xHc723uCnDGmlmhXF8au91wYbfs/nilTgtXThVvknM/tTxjXRH9QCfPUMnFCbcw6jyLQI+U4MwGNQ+csymHD3U2taDnoGGC5pikegoX/Guw/E6uFcmVgIW7SbiJofImqwnx5yRiwBxJa/yWMCHUT3fDmFHj0NuDuBXRUL4E/94SVSky/LGw0Caq2juwWtBxrz3e4UJRT4n3RqBqwGsf28nWFaEo4jXsoLHkMODnlIrCESByCusI07N8uVqUEl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ce367a-c603-4ad1-54be-08dd1913f58b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 12:12:47.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3wU1U7y1W4VrvPFiyjB53DIgJyBjxFyGn8q1cf5Dxy6Sk24+5o1A/j7gW3azu5s0uOmUsPdVYlPuqgNZ8u31NPtyy2MeV61VN3Mst7lEPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9460

T24gVHVlLCBEZWMgMTAsIDIwMjQgNDozMSBBTSBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9u
IFdlZCwgT2N0IDA5LCAyMDI0IGF0IDEwOjU5OjAwQU0gKzA5MDAsIERhaXN1a2UgTWF0c3VkYSB3
cm90ZToNCj4gDQo+ID4gK3N0YXRpYyBib29sIHJ4ZV9pYl9pbnZhbGlkYXRlX3JhbmdlKHN0cnVj
dCBtbXVfaW50ZXJ2YWxfbm90aWZpZXIgKm1uaSwNCj4gPiArCQkJCSAgICBjb25zdCBzdHJ1Y3Qg
bW11X25vdGlmaWVyX3JhbmdlICpyYW5nZSwNCj4gPiArCQkJCSAgICB1bnNpZ25lZCBsb25nIGN1
cl9zZXEpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBpYl91bWVtX29kcCAqdW1lbV9vZHAgPQ0KPiA+
ICsJCWNvbnRhaW5lcl9vZihtbmksIHN0cnVjdCBpYl91bWVtX29kcCwgbm90aWZpZXIpOw0KPiA+
ICsJc3RydWN0IHJ4ZV9tciAqbXIgPSB1bWVtX29kcC0+cHJpdmF0ZTsNCj4gPiArCXVuc2lnbmVk
IGxvbmcgc3RhcnQsIGVuZDsNCj4gPiArDQo+ID4gKwlpZiAoIW1tdV9ub3RpZmllcl9yYW5nZV9i
bG9ja2FibGUocmFuZ2UpKQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4gKwltdXRl
eF9sb2NrKCZ1bWVtX29kcC0+dW1lbV9tdXRleCk7DQo+ID4gKwltbXVfaW50ZXJ2YWxfc2V0X3Nl
cShtbmksIGN1cl9zZXEpOw0KPiA+ICsNCj4gPiArCXN0YXJ0ID0gbWF4X3QodTY0LCBpYl91bWVt
X3N0YXJ0KHVtZW1fb2RwKSwgcmFuZ2UtPnN0YXJ0KTsNCj4gPiArCWVuZCA9IG1pbl90KHU2NCwg
aWJfdW1lbV9lbmQodW1lbV9vZHApLCByYW5nZS0+ZW5kKTsNCj4gPiArDQo+ID4gKwlyeGVfbXJf
dW5zZXRfeGFycmF5KG1yLCBzdGFydCwgZW5kKTsNCj4gPiArDQo+ID4gKwkvKiB1cGRhdGUgdW1l
bV9vZHAtPmRtYV9saXN0ICovDQo+ID4gKwlpYl91bWVtX29kcF91bm1hcF9kbWFfcGFnZXModW1l
bV9vZHAsIHN0YXJ0LCBlbmQpOw0KPiANCj4gVGhpcyBzZWVtcyBsaWtlIGEgc3RyYW5nZSB0aGlu
ZyB0byBkbywgcnhlIGhhcyB0aGUgeGFycmF5IHNvIHdoeSBkb2VzDQo+IGl0IHVzZSB0aGUgb2Rw
LT5kbWFfbGlzdD8NCg0KSSB0cmllZCB0byByZXVzZSBleGlzdGluZyByeGUgY29kZXMgZm9yIFJE
TUEgb3BlcmF0aW9ucywgYW5kIHRoYXQgcmVxdWlyZWQNCnRvIHVwZGF0ZSB0aGUgeGFycmF5IGFs
c28gZm9yIE9EUCBjYXNlcy4gSSB0aGluayB1c2luZyBwZm5fbGlzdCBvbmx5IGlzIHRlY2huaWNh
bGx5DQpmZWFzaWJsZS4NCj4gDQo+IEkgdGhpbmsgd2hhdCB5b3Ugd2FudCBpcyB0byBoYXZlIHJ4
ZSBkaXNhYmxlIHRoZSBvZHAtPmRtYV9saXN0IGFuZCB1c2UNCj4gaXRzIHhhcnJheSBpbnN0ZWFk
DQo+IA0KPiBPciB1c2UgdGhlIG9kcCBsaXN0cyBhcy1pcyBhbmQgZG9uJ3QgaW5jbHVkZSB0aGUg
eGFycmF5Pw0KDQpBcyB5b3UgcG9pbnRlZCBvdXQgaW4gcmVwbHkgdG8gdGhlIG5leHQgcGF0Y2gs
IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGludHJvZHVjZXMNCnJlZHVuZGFudCBjb3B5aW5n
IG92ZXJoZWFkLiBXZSBjYW5ub3QgYXZvaWQgdGhhdCB3aXRoIHhhcnJheSwgc28gSSB3b3VsZCBy
YXRoZXINCnVzZSB0aGUgb2RwIGxpc3RzIG9ubHkuDQoNClJlZ2FyZHMsDQpEYWlzdWtlDQoNCj4g
DQo+IEphc29uDQo=

