Return-Path: <linux-rdma+bounces-22032-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Th3EW9tKGosEQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22032-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:45:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CAF663DDC
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:45:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=hhLz5rqW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22032-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22032-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D66C231866C4
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954D640D574;
	Tue,  9 Jun 2026 19:19:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020120.outbound.protection.outlook.com [52.101.61.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F8540D568;
	Tue,  9 Jun 2026 19:19:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032747; cv=fail; b=tHNtkzEGykDhkmZSP9kvR/2r0q5L4642strsqdJVJ30PfQ3mcFOD7Mpejh2zPdqHJAZPGDFHRGla9B+6RQ7HkTuqgPGJNNs/I02ZRMX5vedmcTsWl8fD+wkEmisLjKHytrErSHWR6+qw+QUwdyD2/88gT/FjxVcclYptvR89oU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032747; c=relaxed/simple;
	bh=g6yO0TDo96M2OYEaOk7wBJuvgS72zU6ztVT/bKLpkLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IUVUeVDXDx74BMaWoBBIRGWgaXFjWmZQBSN3hvLhgYDgmSa6xZIO/mTChKTdxKIIaMCI0pVet7MHhRIfOgXl5w5WcB9z24qrEkVkwRJ2nvjTcsgZt+mlaFW94L3aJ1TyKESAi4Ink9h9dQdRMxQTMbce2zYPMRdf96UsK3BDjYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hhLz5rqW; arc=fail smtp.client-ip=52.101.61.120
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqoEJtERH/tpfJBldRracfTPf5YE0YB0wOX3wYW5Nio+1ippJFEZMbOf69tUkggRU2Zal5fDrWrW+bTIFjQK5iiwYSAoj6n3G3qSnpSMBFw8BNmYZvmPFanq2ItIZ+5dqivTWUxz29nSYQvqeeKlQRZpRXfRhtoED6BMn6bYF2cclvGwz1EU6c41DAip1ZcRzWbqvocP2mDzMVB0w+v2FWlbO8QDh+PJd0Am+8J4sNVkm2kRBkiUWxmoBSZ97XaizZBVRy/tAFrkpwpXKes5k0htKIJPP2Q5quCd+g7R9Id2IDrwbrN5tlFlwN8mD0SSEr+DyYtWrG0qcwWfRv8irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6yO0TDo96M2OYEaOk7wBJuvgS72zU6ztVT/bKLpkLY=;
 b=KznX9bL+XlF3nyI7q48WZkfH9p0x5VjFsRkTZMs/jmafUGqe4mUfRwkwVNyRkhd6rxnQgZCdAtNJKheAeLbx1EKsJ+CYOZ4H+NZoiqTMUGm6ptgUMKjbNwLcF6GhnwgDogo8VjBXRUaKnXX2iSiWXJ7kUapHvO0KQqS7M3LMstP7D7lAntuBYynB6YVZBLBn6Z13FdO2E6FIiMclMmy7cz4/r9JlY+V87uoffEz91sMB3RAN9N16TrSQOrjp1v66yDGaFwoYdo1kfvPbpDOJpLX64l2eh0qR/cTB+0x2Z3u06tVpy1DDOSTOR/jnm7ZMbMcbw7Jo0igaUjO7y9HW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6yO0TDo96M2OYEaOk7wBJuvgS72zU6ztVT/bKLpkLY=;
 b=hhLz5rqW62d1xSoGlk+P8uZCfNXK00mpId9Bt7rnfWFFy0ZnAbyQ2Mm0S/P/nIgmVyIXwYCF92lF7bWNWF+pbyUo3fJta37/HB8GmP6g48bSS+e2+Q9W5zf8Jel0628J/NSMQXvJZeCHehDHUmk1iH5dmNLwvL7EH6nxuk7wbPo=
Received: from LV0PR21MB6670.namprd21.prod.outlook.com (2603:10b6:408:337::12)
 by LV0PR21MB6073.namprd21.prod.outlook.com (2603:10b6:408:33a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.10; Tue, 9 Jun
 2026 19:19:03 +0000
Received: from LV0PR21MB6670.namprd21.prod.outlook.com
 ([fe80::c354:baab:cb7e:3c96]) by LV0PR21MB6670.namprd21.prod.outlook.com
 ([fe80::c354:baab:cb7e:3c96%4]) with mapi id 15.21.0113.006; Tue, 9 Jun 2026
 19:19:03 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Thread-Topic: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Thread-Index: AQHc6EBrqDIqOwotcEq8/4EhQ1Be27YvQ+BQgAbTpACAAKFxEA==
Date: Tue, 9 Jun 2026 19:19:03 +0000
Message-ID:
 <LV0PR21MB6670161CF7DCBDF30160A853CE1D2@LV0PR21MB6670.namprd21.prod.outlook.com>
References: <20260520100656.875006-1-kotaranov@linux.microsoft.com>
 <SA1PR21MB66836572AF65E8A2D147F96DCE112@SA1PR21MB6683.namprd21.prod.outlook.com>
 <PAWPR83MB098460109147A819963260A9B41D2@PAWPR83MB0984.EURPRD83.prod.outlook.com>
In-Reply-To:
 <PAWPR83MB098460109147A819963260A9B41D2@PAWPR83MB0984.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6b2e4d92-126f-4e0a-b295-cf383dcaff25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-05T01:25:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR21MB6670:EE_|LV0PR21MB6073:EE_
x-ms-office365-filtering-correlation-id: 7372b744-3584-4958-678f-08dec65bf7e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 fDTRk98atBQN6xp8JsqC5BM7qItV4QBY1mtI4ODn5fIiukBhECCxuIIcz0iKjA9wge41rjV7K0ts4+eSfBO3pvmdBWrWT4cibIL7MhsBv7tYIfeEaJJ0dpITBaJz5FLOAwiEaa+DupZSwNl7iJiqFeKme5uLBfUoz5qydHyx8B31pZ5Wcrdyath2RZGZ8FCjmvN5bNd5FkZ/nlpLjwFCkebY2pWAUgdPSKSJhohkUNGcS30MWp+dLT0mzRahGXXIEZauZkJX/11PrujYN6PwV9qttfqU7X7ux5lhJd21RM431nTp3449fsL3Xm2ZR/YHPkAuU++mMUDi1Pfq/oNYIeOVEK3adV0b+sQK/YElu83ceHy992ou/Hm5QCw1GFVjhA5igDMz+66NeFhe4gP2w9kSOM/rHAyqnteMYlyElQKioYQz4F+naaLirQiCg8XoZpu5lzfp4gx1sc9joAo+FTRvwvNcmLYqGmiH+9C/eR/tWEyRr9e7xpfEsmpqzVZP7edbeNJ4k4ZrY8j15anuKJ3B5P9yrya4e21NTmsATXJ59YTzMjBZNuyGYbU9EKFZqkWO+7KNf5sW0TawbURMunSCz+wCaRYhs0Oyu3GFi7DpGrOaFS3xcBHCFjzEJlrazj9Z+/hBlhZLygNDPKjijMas+uIMfOG98WMmadu5WfDuFn9BXIoy2HPcnOmW0glkDzR6kfZvrk9aWaFHLmXb5mUMpSNuZK7NL5G/cZey6NGVFrpevl/waa7nA6bCCwPD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR21MB6670.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHRIYjlWeExPcmlLTm1mdlY5K2ltRUZqOGY5a3FSbFJXSUErQWhFaFQrV3Iz?=
 =?utf-8?B?Rnl5d25Lbmd2RXZOK0t4Qmx0KzYxaGwrTU9DSDlNZmdzbXBEcGcwY3JFbUpY?=
 =?utf-8?B?bjFxbVJkbzdDb0huV2tJMk51cFVpVFJwTW4vbzZoQW1QSUhJd1BSekVCWUN2?=
 =?utf-8?B?eTMzZ3p6Y2tWalp3enpqRHB0bERNNzVCUG0wcE1lWFFKSzRFaHl1Z1pBdXRI?=
 =?utf-8?B?SExDVE5KMlo2L093SUpKYnBMbTBSQmo1WHc3Y1lINUpheEV6eklYNUs3dW5P?=
 =?utf-8?B?Y1F0bUhwQU83bDNWUS9UT1hWazNHWkFaV3JlWXF3a1Y1RGtOdUo3Q256OExY?=
 =?utf-8?B?SSt2OHJEckwva3dGTjFiOUtWNVJvbGNuc0NrNjZpWDRvKy9DUEo3cmNJWmNV?=
 =?utf-8?B?NStMNG15dlBveHJ4Ui9JNXFLcDJvRjNZc284eVMyOE93L1EvRFJmcThuNW5Y?=
 =?utf-8?B?cGhuWkhoNGJyZTRsbUllcjBvMm1OT2pid3JBZThldm4wamh2UXRNSHY1alJs?=
 =?utf-8?B?c3c3dXhHcCtYWEtlNzkvODdCUG15VWZQZlhEY2Iwd0lrWTloNzZ2bUE5VEQw?=
 =?utf-8?B?RmV5cFhtRGFwblZBTGE1YXc1bTIvbDdGVEFDcU16UjNhMzdRRTBibW1HUHIz?=
 =?utf-8?B?SEg3M1pCZVlYZUlNK3ZiZDRpbkJFdnF0Q08wbGplOXh4QVlCWTFaTnEzbXVp?=
 =?utf-8?B?RWo0b29FeWxJSkFBY0plbjhPZFdVUVVtcnFrRDVVbWJJa241SW1qZ3k0TFh5?=
 =?utf-8?B?SFZKTTBtS1JhaU4yMjFtL2NVMEg0aE9UZkZTTjBuTU1SamhESy82R3lmVnVQ?=
 =?utf-8?B?aVJ6cHB5Zm4yZG1mSUorWkRXalQzUk14OVZTNk5SanA2aVRndXBUci9SbUI2?=
 =?utf-8?B?Vno2KzZYYU1wNWpUanFEVnUzd3B5dHRFQnJZY2xwcHJjU2M4SlBmOFJ5azFy?=
 =?utf-8?B?R0lWU1pTdkJ4UlZwN1Q3dmgySTFENS9JdEd1QWFtYmNRZm95Skt6RWpoV3Rv?=
 =?utf-8?B?ZnhWSkJPQk5BOGwzZW5JRjk5K2VSaHRZRGJpRXBUZUxmMlRybFpFM3gvREtR?=
 =?utf-8?B?Yy9ac09kbzJMSEpQN0I3NVdscThRTzFYSXZXYUZGN1hJTE5CWFp1V0JjM29R?=
 =?utf-8?B?b09XRlU2NUhCQkE2akFrTFZta2hpMmRiVEcyemZ1bUd6M1B3ZjdkMHphTmk2?=
 =?utf-8?B?WnQzMU1STVQ5YWtOcVVsVUtNNGFuVGYvb21KVGRoUEZIN0N2L3FkMFdGM0Fh?=
 =?utf-8?B?VjZmUFQzWUwvZlUySW9YeW5sL2dGNWlneHp0bnpka1RHNVJVSDBnU0wwOUpE?=
 =?utf-8?B?MGdUUVA4Njh1VXVQRFpHOC9CREhFaU5IMHBKamhJMW1TVGtQZlkzMTlpL1Ux?=
 =?utf-8?B?ekpReFBmOFRSRERRbEtYdmNtQUZ5eDhvLzJVSmJyZzYybmhyMWU0SEU3UlVU?=
 =?utf-8?B?REVwY285YUZlUWNLU3ZtTUdWaHdlbDA5UzRUOXI3TkE4cktJb0ZFaDBuSnUy?=
 =?utf-8?B?MVpORWt5aUZSYlFiVmRoWUxpbEFwNzJBNngvNHNJSWg0SDV2aXJua0N0c0Jk?=
 =?utf-8?B?RkE3S2x4Sm0yMWRXQ0drSGJZNEJGMVJsOS9pcEszbncraU44Y1RBd0ZNNUJJ?=
 =?utf-8?B?WXVpSm8xbzB1TG5FMXV4dUZRY05XN1p6Z1p6WmJFT3dkMmFuR1VZdDZ1V3dS?=
 =?utf-8?B?eTJ2VjRGMnBjSXFlZVJCL08xamxHQzZzZi8xdWVVR2FsQTZIdUlaNERIZGpM?=
 =?utf-8?B?Ym1OeFVaZldmNFZIQ2w4cSt3a2dPT2hQSWZvbGNTMW9UeVJNek80Ni9DZFZV?=
 =?utf-8?B?OG9rTUM4MmcwY2FXZUpMbytPbmQya0ROSXR6VlBJQ1Jtb0V6bVRwclZZSGln?=
 =?utf-8?B?TEx5aUczRXFYZDFMRU82MU5yQzRNdk8wdVFoakdxVzgxU3dZR0F2Mk1EVjNP?=
 =?utf-8?B?L09FektaNS95MnBmV1RmR1FtdTdFRXFuVnY1b1o4cEFqekVsckU4Ym0vd3Uw?=
 =?utf-8?B?VllWV2UzbHlOQ0YwK3Rza1htZEZTUnpUaXY2akJoTStvS2tKTUxTT0E0RU5w?=
 =?utf-8?B?anhmaFF5MXk2Q3Nwb2tnTFJOS2N2REpOM0I2ZDZsVkN3OXpLUFJwMkV0R0hr?=
 =?utf-8?B?ZUxEZjFlVXVLQ29PU1RCSi90L0RNTVlSd2pGTWRZa2o0Z0FzWHpHTlFsOGZh?=
 =?utf-8?B?V0h6ODlGU3FJNW1ZTGxUK3VCeWFlZFh5UGdrRDM4TTEzT0prUVdLVERkeldK?=
 =?utf-8?B?WjFOeGM0RFVJRVIrZXdiY3Z5aitGVmpNWXNjcmJlQnFUd2laQ2VsMWtXYXc1?=
 =?utf-8?Q?b55hLAxNFxzzNcxKhF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR21MB6670.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7372b744-3584-4958-678f-08dec65bf7e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 19:19:03.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29XJRUoGU48H2HhEKQOo7FcisBCgn/Ws0+UvJz6U0obz4YMcHoaSEuRCisV4n54DgSVKZPbdUAhMCBjUziafNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB6073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22032-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@microsoft.com,m:kotaranov@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,LV0PR21MB6670.namprd21.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37CAF663DDC

PiBTdWJqZWN0OiBSRTogW1BBVENIIHJkbWEtbmV4dCB2MyAxLzFdIFJETUEvbWFuYV9pYjogVUMg
UVAgc3VwcG9ydCBmb3INCj4gVUFQSQ0KPiANCj4gPiA+ICtpbnQgbWFuYV9pYl9nZF9kZXN0cm95
X3JuaWNfcXAoc3RydWN0IG1hbmFfaWJfZGV2ICptZGV2LCBzdHJ1Y3QNCj4gPiA+ICttYW5hX2li
X3FwICpxcCkNCj4gPg0KPiA+IFRoZSBmdW5jdGlvbiBpcyByZW5hbWVkIHRvIF9ybmljXyB0byBi
ZSBzaGFyZWQgYmV0d2VlbiBSQyBhbmQgVUMsIGJ1dA0KPiA+IHRoZSByZXF1ZXN0L3Jlc3BvbnNl
IHN0cnVjdHMgYXJlIHN0aWxsIG5hbWVkIF9yY18uIFNob3VsZCB0aGVzZSBiZQ0KPiA+IHJlbmFt
ZWQgdG8gX3JuaWNfIGFzIHdlbGwgZm9yIGNvbnNpc3RlbmN5PyBPciBkb2VzIHRoZSBmaXJtd2Fy
ZSB1c2UNCj4gPiB0aGUgc2FtZSBkZXN0cm95IGNvbW1hbmQgZm9yIGJvdGggUVAgdHlwZXM/DQo+
IA0KPiBTdXJlLCB0aGV5IGNhbiBiZSByZW5hbWVkLiBJbiB0aGUgZmlybXdhcmUsIGl0IGlzIHN0
aWxsIGNhbGxlZCBSQyB0aG91Z2gsIGJ1dCBpdA0KPiBjYW4gYmUgdXNlZCBmb3IgYWxsIFFQIHR5
cGVzIChldmVuIFVEKS4gU28sIHRoZSBuYW1lIF9yY18gaXMganVzdCBoaXN0b3JpY2FsLg0KPiAN
Cj4gTG9uZywgZG8geW91IHdhbnQgbWUgdG8gcmVuYW1lIGl0Pw0KDQpZZXMsIGl0J3MgYmV0dGVy
IHRvIHJlbmFtZSB0aGVtIHRvIGF2b2lkIGNvbmZ1c2lvbnMuDQoNClRoYW5rcywNCkxvbmcNCg0K

