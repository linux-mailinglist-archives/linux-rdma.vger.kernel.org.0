Return-Path: <linux-rdma+bounces-20409-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEWyG6IfAmq+oAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20409-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 20:27:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 766815146AD
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB2D530125B7
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7D047B436;
	Mon, 11 May 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jFPR0n8J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4C401A01;
	Mon, 11 May 2026 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523705; cv=fail; b=uSsMU30i/2kn5ATn5f/jdfGfvrd+9BXl+tm3Sv4FoSWUlM1ERGL13YksaYhoACDV1RMN5YE0c4U+V25h0dmVcQDaeFJXEPpXFf5fDR4N+c753lczMTwpv8c2t/u7VWiuzukCFLDun+VVo7ZqambAgoaLL8z2K2QUdYRhEb0Wius=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523705; c=relaxed/simple;
	bh=6g+qndO3SlumgmKilt1UwODt6WBl7vIPu0rAloScePg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDhIvsUyTIaxE6vcNn+63iaugNZle1MAmGze/aTQQGGoWyxmxK07L6gwkDdpI1Nvl2Jom6iDi/XVCejeNoKwHy8zcbijPghaLIp6k2QjWxGG1shTXdzkU1xy4RruV+/MNRFHZBEO0SXlk7OHnS5drTjAwCbjtbmyKZBdjUtU4fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jFPR0n8J; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy5p9TIbwfmkaUZGurOLSlfqV/UiS5G34vzIrVqFzi/BBYabcA0E20dOczuVezRbUbW+DTjN0wf10PESLwXwaCgBwnNm+ueUTUhv4gXCXWE+3r6t/GWONLsZ49ZJ/6721Kl3ZRvzqYP9o9dXb5fOEL9y9NQHatVNHd6jQEaNBXMkDuhO22W7Yhs7HKdgoUKBgVEaTZrJAXzvvuz3NqFTJ7pSPmL13J5Ij/lzLy9AtkIeeMbKNqlVFBXkRfOXTHT6yc8eCgSymVoiHhkHNDP1TNBa4Oj1S7KZ9H1nrVGc/HdwP4IgB3tr3kXNqVbSQ6O3ybhcDE+BblbdZsLg/fplYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g+qndO3SlumgmKilt1UwODt6WBl7vIPu0rAloScePg=;
 b=Tx6jXhWAoHPa198kFDgU29IMBBQJzSUyz0Vc1v2TIeoOfsfm36ioXWJ+/28A06fZdq1u16F41jPfeLDavD2dCaAB5cHs0OjF0wZMtxsv6Az3hLJIe2aaxhi3mG+Kc9mvOmRCNjSrVZQ9uSmfexAGDw9y5KQplQjaxtiIY7bpmEIRP1POxVDMh3MQBTjX6O7LtNZnN0WCRBTU9XOi1NNkY9DKg9ERG+IOrsjjZd2P0TtdNfD17ABu0XWta/m/EQDwS0oEWuC6zzNmGeQ0xSZFVrDD7XlAgJMd1mkpJlXc6fXBuE0lpPoC/q2YfpnozMhXvk4VJaCiH6MxC7VkjxvefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g+qndO3SlumgmKilt1UwODt6WBl7vIPu0rAloScePg=;
 b=jFPR0n8JeMcGZq97t0sht74eacLscnZzqBGfpPe/QhajivU0YFyh+Q7whBLWh2FPOa54a/xpU3/KfKq1EPBeGtW/7VFU7FvIUEU5R+bal4XrcXQrQBD99XNgpYLTfUkz/wMISBtMRRWmQz4PgeXRRaOpyCT53w9h0uASlBnVoxMdT/xNq1aOz03yPMdIfPjZaE0aksGgAaLnthR4Le4mhRov93MV0CU8AAJXA2cFnGRHHgOczSPe5jV6D3NOrTz6RSg+fi3CQHMo6XRa24Su2J9vhVtwctIw7ByrrYTwQGF1HoKLg/XrMOIyv7QVcStzh+QrGZXtCMG41yqSCL528Q==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:21:37 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:21:37 +0000
From: Parav Pandit <parav@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Jakub
 Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, Randy
 Dunlap <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, "NBU-Contact-Li
 Rongqing (EXTERNAL)" <lirongqing@baidu.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [RFC net-next 0/4] devlink: Add boot-time defaults
Thread-Topic: [RFC net-next 0/4] devlink: Add boot-time defaults
Thread-Index:
 AQHc3VU8tJbglNPDbUazXOkyKNlt8rYBHYOAgAAlMgCAASTMAIACBosAgAACbACAAHEDgIAAZySAgAHul4CAAfKGAA==
Date: Mon, 11 May 2026 18:21:37 +0000
Message-ID:
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
 <aftaW-irGmkfA7FS@FV6GYCPJ69>
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69> <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
In-Reply-To: <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|PH7PR12MB5855:EE_
x-ms-office365-filtering-correlation-id: d6901f72-0f2c-49ac-e0de-08deaf8a23c7
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|18002099003|22082099003|38070700021|56012099003|3023799003|11063799003;
x-microsoft-antispam-message-info:
 UwT+OXWYMPmaW6IgunJoDAr3RVon8CbsMRl5NEnP7QU2/IKt11v8fll8LOMaTYFgaij1RgqkkuleJyQiE4DbI1Dn1YruMIJEb/NY0h2Q/KQmjNY3nIA8mqxI1/UMdxqCiFlpo6CxYVSHkrSIK3rxiM1jRwFlKJi1q51u26vWh2GiwrF9K301XPn1p8ag6BprDLp0ktuyGUPWZWA3UdyffQEPsFONq/m1SvLiTutDuzB8tZiA7jk5koD9xYgk+xyPIvdQrH4pKaQ9pxcCtTbHhHSydvgvXf+ysbwJCjaGEImYdz3EgFOBLbHpmMZtysGpA0sm7NggJa+yfSbELzsLHxXI8Cn9c5ZFoqE2iz5jnHby3occEj2q/ZMOYrLHMQc9K6KNSrko/194xhD2HDC49+eDL/UHo77/5rjH8VH5pHJXG+y1h6AXZt4IbeKh/5rk1pzsmOM4U5MMloWqYbzkUQoz+jUCybFIa8+BCF3uVuNiwZytWgROuvolpINdUTJLrjTCUHSFSFE9o5YaPtH1q4JPN13W9qDd2iA1To5nA+YfQBlT5XK/DmK+KUDGLBq7HjvroGEPaLw4ZhHHBAI7Rotf2E+O9jSxcxvLeI/BSRp8O/Q+Uv8RJTtuPXmmQXbBMIfpY2lncD8ACVzyttImt9PtqV6QiBo75GOq69Niq27RgAPOL5SXKCK4XEQZJ5yDUA8+hYYFj+G6PQqoIwtXvhg16AHfxTo5yInAbmX9kYY+1ccYKeqRu+RzgJou8+H1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWhoVjJTdjl4VTVGbzZtWnlKTTE4dHU1MEI5citaNjRDSDI3RlIrb1Zma2Vk?=
 =?utf-8?B?ZmN5dWd3VGxCZkM1N3BieGROT1VKZXFRSGpaUlZjR3BQTWNKMXNpd2ZHcERj?=
 =?utf-8?B?ZjlaWXJkM0tZNWVhVVhLVmlHTkd1TFpqSjJEMEhWd2ZrcXExd3Y2Rktpem55?=
 =?utf-8?B?aFhaT1E3eXlEcDl0b3JySFdpd2tqTHhoY3Qrb1lTd3dFTFRFYjdxM1JNbDRk?=
 =?utf-8?B?NllrbURUbDlwUFN6eXFaYnpmck54RFp2TFRsSGM2Z1FIbjRJams5ZjRiVnJV?=
 =?utf-8?B?czR5Q2xNS25jQUU0cWI2WTRrRmUyZEVQa3pkbElVWDlYSDBuMHlXaWNiWnZk?=
 =?utf-8?B?aGl6SW1ISDJ5cjlReXhreVdCQXNyNFNyYkk4ZERza29Kem9RZi82V3ZhRTVp?=
 =?utf-8?B?YVdmN01HQWY1NWhLMFdraHdwYnBlZ2dlMU1GcDI3THo0THEwekZUd1pucGpY?=
 =?utf-8?B?SWFkcXZZTUJZaTh5ejJHV3R0UzExUDREQVlZVklzR0Y1UWc5dHppMmhGWm9E?=
 =?utf-8?B?QUJuRTIrb01FdS9NYm9kNmpJMEJmbjVDU2ovZTdkT0VvWGVpUFlnWmVRY1Rt?=
 =?utf-8?B?Q0hyRTJEc1VKWUw2OUxPRVhBd2dwSk0xdWQ1ZXpCUmhOd3l2Sit0Tzd2aUww?=
 =?utf-8?B?MHpNWXdFZUxIdHJhUGRPMGxZQU10THpUYmFtYlhPaXFNdTM4N3V5aUhIakdq?=
 =?utf-8?B?b2U2VDlvUzAvbEFITGVFRmtMNWRCUTBkMm9oM1h1azFER0dNbTUzUllpcldI?=
 =?utf-8?B?Z09mdG8vMmZhajRSTXN3OW9WbEgvYnVacjVadVBmWDV1cnIwWXlJT0NYMGw0?=
 =?utf-8?B?dzRjZFF6UHZvTzN6ZGRoQnlzVkNwdnNnRjh3OUphbFp0SW5FY1dPMG0vTEI3?=
 =?utf-8?B?cXcyR2lEZVJUczZ1OGljY2dWL0JEdm5oRGY3Z3ZTMVZ2cS80S2JMT2UwQzcr?=
 =?utf-8?B?YlhCTnpveVZHZk1TSENaKzNXY01sZWx0cDJBZTAyQmt3eTNTaGdJZmIxODBP?=
 =?utf-8?B?dEcvQWpla2sxUi9GTVFaaSt1alpWKzRVLzNrRSsvb0ZXWUQ3SGpvSTI4TDdI?=
 =?utf-8?B?MEwyLzZrcC9HNGpmTXZkWkNqcWUwYVJZUmFQamtsVVV6eE8zdlFMWXlVVWJh?=
 =?utf-8?B?SnlQVnYwNVRVSW5VTWxkMVRYdUxGaWhtL1UvYlAzSVhtQmovSHBjd09IUlVm?=
 =?utf-8?B?N09sOGxzRGVWbGFTNmg1NmUycmhhVURXSnJJR29QcGQyTWdWOFZxN0hiTlpi?=
 =?utf-8?B?bzVyeTZjVnZMYUc4SmcvQ0hUYkRaSG4rQkhhSXlyYkZwSUFjcUNwalJCK1k4?=
 =?utf-8?B?UHk0MTRpZ3dRRzV3M09sU25MQy9pR05kZFhzMHFlQWZxS25GbXhOR3UzWlJi?=
 =?utf-8?B?bHM2RVIzQnMvczZ4clBsNzZYd2F4T0lOVStMWUgrd0wyS3l0ZzR4TjQxRmgw?=
 =?utf-8?B?SVBON2RnUnI3VzVkckxhYjJQVnM2ZVdtYllLYWZ5M2hKTnYvZXFSQkNkSnFa?=
 =?utf-8?B?ZWN5K2ZIVEVJV09NQTJUV0x2K3NaQ3F2c0xhUHVRUVBhcy9TajZ6M0hiY21o?=
 =?utf-8?B?ZjI1QWVXZElYS0R2Qzh4dXNwYzBhTVFFem1haUxYMUxiYXF5WE5XWkN6c3dK?=
 =?utf-8?B?d3c5VkJkWEQwYzAwK1pITGJGeWVBcmF5U2EzU2JRRTZiQkZHbEg0YnZYVVQw?=
 =?utf-8?B?ZGJCdTRKZzM5bkpYUHY4dkxadW1sR1JIeXl2OXkyakNjaFVkL1VkTk1qNE9n?=
 =?utf-8?B?amlDVkphV1E4c0dmc2h3NkFMUmhycnUzdTJMU1pMazZvY3ZkZVg5SXlVU0lw?=
 =?utf-8?B?ZXBGcDlIeWJVRzNqOS9LeHoyRUliS2poU1N3bndmcFllV0V3NFNjL2FwejVw?=
 =?utf-8?B?LzFsNlJ5UDMwVCtDdTE4VjFGWlRiZDl0bE1PRmVrYVRoNFNkaCtCSVc5RWZN?=
 =?utf-8?B?akEwSDUwQTdRSG1OTXFhcHBIbG5LNmNtYW5CbDllcWlBUHBiK0Z3UUpZT21Y?=
 =?utf-8?B?WGtSc0NES0pmVUw3UGhEUXJBVXpnY0lQWEVwR3dyR2V5TFNJWURmUlZJU2VK?=
 =?utf-8?B?dWFyTlFqUFhDVFJDa3UrSUZLU1UxUWpxcmI2SXBtWDZPeVVBTi9kUnBCeXky?=
 =?utf-8?B?MngybXBSMk95bldRT3EzUjk4SlIvK0x1Zmg3Z2x5Wm1rUU1hZi80SU5Ha0hS?=
 =?utf-8?B?bnJ3bUhJdmxCeEVmbElKcjU2dXZlR3NQbDF5WnF5MU4wMjIxUHVrWkRaK29q?=
 =?utf-8?B?VjVKYnZhVWt6OGJEN0xvYlJCci9SQnplYlZDNnBvZThqbzdpYVF5ei9Hbkkw?=
 =?utf-8?B?aHlLNU5UcEZmRGE5ZVRDS21IZThMWGhjUTJmZ0RnUmRaSnNiSXFNbU00a1Ew?=
 =?utf-8?Q?Bd4qIqKm/faxqUA61cfgg0sX5lWGpdkI4DvLV?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6901f72-0f2c-49ac-e0de-08deaf8a23c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:21:37.3279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2S3iF3AI1wRCKUavU9bl+zczymVLNkrs6Bp5G7tk+MHxlBp+IU1035Zpgh+e1HtogKe7GS6xdOzzW2JJ/3/C8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
X-Rspamd-Queue-Id: 766815146AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20409-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parav@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,SJ0PR12MB6806.namprd12.prod.outlook.com:mid]
X-Rspamd-Action: no action

DQo+IEZyb206IE1hcmsgQmxvY2ggPG1ibG9jaEBudmlkaWEuY29tPg0KPiBTZW50OiAxMCBNYXkg
MjAyNiAwNjowMiBQTQ0KPiANCg0KWy4uXQ0KDQo+ID4gSSBsb29rIGF0IGl0IGZyb20gdGhlIHBl
cnNwZWN0aXZlIHRoYXQgZnJvbSBzb21lIENYIGdlbmVyYXRpb24sDQo+ID4gc3dpdGNoZGV2IG1v
ZGUgc2hvdWxkIGJlIGRlZmF1bHQuIFNvIHRoYXQgaXMgYSBkZXZpY2UtYmFzZWQgZGVjaXNpb24u
DQo+ID4gSSBiZWxpZXZlIGFzIHN1Y2ggaXQgY2FuIG9wdGlvbmFsbHkgYmUgcGVybWFuZW50eSBj
b25maWd1cmVkIChudiBjb25maWcpDQo+ID4gb24gb2xkZXIgZGV2aWNlLiBXaHkgbm90Pw0KPg0K
QmVjYXVzZSBzb21ldGltZXMgc3dpdGNoZGV2X2luYWN0aXZlIGlzIG5lZWRlZCBhbmQgc29tZXRp
bWVzIG5vdC4NClN1Y2gga25vYiBpcyBub3QgZGV2aWNlIGRlY2lzaW9uLg0KSWYgaXQgaXMgcGxh
Y2VkIGluIHRoZSBkZXZpY2UsIG9yY2hlc3RyYXRpb24gbmVlZHMgdG8geWV0IHVzZSBhZGRpdGlv
bmFsIHZlbmRvciB0b29sIHRvIGNvbmZpZ3VyZSBpbiB0aGUgZGV2aWNlLg0KQW5kIHRoYXQgdGhl
b3JldGljYWwgdG9vbCBjYW5ub3QgZXZlbiBydW4geWV0IGJlY2F1c2UgZHJpdmVyIGlzIG5vdCB5
ZXQgbG9hZGVkLg0KDQpUaGF0IHNvcnQgb2YgZGVmZWF0cyB0aGUgcHVycG9zZS4NCiANCj4gVGhp
cyBpcyBhIGRlcGxveW1lbnQgcG9saWN5IGRlY2lzaW9uLCBub3QgYSBwZXJtYW5lbnQgcHJvcGVy
dHkgb2YgdGhlIGNhcmQuDQorMQ0KDQo+IFRoZSBzYW1lIGFkYXB0ZXIgY2FuIGJlIHVzZWQgaW4g
YSByZWd1bGFyIGhvc3QvUkRNQSBzZXR1cCBvciBpbiBhDQo+IHN3aXRjaGRldi9vZmZsb2FkIHNl
dHVwLiBJZiB3ZSBzdG9yZSB0aGlzIGluIE5WTSwgdGhhdCBMaW51eCBzd2l0Y2hkZXYgcG9saWN5
DQo+IGZvbGxvd3MgdGhlIGRldmljZSBhY3Jvc3MgaG9zdHMsIGtlcm5lbHMgYW5kIHVzZSBjYXNl
cywgYW5kIGNhbiBzdXJwcmlzZSB0aGUNCj4gbmV4dCBkZXBsb3ltZW50IHRoYXQganVzdCBleHBl
Y3RzIGEgbm9ybWFsIE5JQy4NCj4gDQo+IEknbGwgc2VuZCBhbm90aGVyIFJGQyB2MiB3aXRoIHN1
cHBvcnQgbGltaXRlZCB0bzoNCj4gZGV2bGluaz1bLi4uXTplc3c6bW9kZTp7IHN3aXRjaGRldiB8
IHN3aXRjaGRldl9pbmFjdGl2ZSB8IGxlZ2FjeSB9DQo+IGFuZCBsZXQncyBzZWUgd2hlcmUgd2Ug
bGFuZCB3aXRoIHRoYXQuDQo+IA0KVGhpcyBsb29rcyBlbGVnYW50IHRvIG1lIGFzIHdlbGwgY292
ZXJpbmcgYWxsIGVzd2l0Y2ggbW9kZXMgYW5kIHN0aWxsIHN3IGlzIGluIGNvbnRyb2wuDQo=

