Return-Path: <linux-rdma+bounces-22473-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VHyWB0gyPWo+ywgAu9opvQ
	(envelope-from <linux-rdma+bounces-22473-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 15:51:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C386C6417
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 15:51:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=fzupxZkm;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22473-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22473-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF47B302450C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D66533C502;
	Thu, 25 Jun 2026 13:51:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023102.outbound.protection.outlook.com [40.107.159.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3542A96;
	Thu, 25 Jun 2026 13:50:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395460; cv=fail; b=etCp4hjBKdU5nGkOk4RjLX/O4jkUGS1GsGpLRiV+fazRWuIJsq6aljhB6HA9MYfhnW8SggbhcPAztmCYKFL7b0hfqo74G6xDAGJ9LBr1dp6fNs+dj+9UkR6kl8eZdoeSqjSy+mRL0YXoWWQePcXt9cepG2Q73th8ve51dE0nGGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395460; c=relaxed/simple;
	bh=LPfVHja/9/EsRGl5KIh46BsJ7Zdbxy6GJtlhqeYrQco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFzSropM6eMsAtfiiDICXyrJATVjaPObtk82jgDIRmVwYXOaaBr6b+VY6W+7kWFNaK4Eb86VCroXMDn10BRRq50x6SCN188EmQkAtVulWzY9U0OJyWHQgproWKFownvTaQy0XK4ehCSHfn2YWeK0L4ilz5AdrPVVRtAQDAViQDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fzupxZkm; arc=fail smtp.client-ip=40.107.159.102
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV9zil0PWy5/I3R5wo3gS0rM2vHqBiHKyqF6RhD7JYKM40aeKjRg6/G5ty3T9PwsU9vKbXgOHQQnA3A6VxAigSpn+3pTZJlV5H6i2SQXkTfQzELno5KTi88pJVnRPpxjmqhBLVfQ592otFbczg989vi72cH4xPUjmhzpxeUafPW4/TyJATqgGQX+QovKMt5hOorogAGm2soVqI/gZjRQZQpig81rluM3ndRLqlydxWmxDHCjY1FhdfeP1sXMXkunm2KC1t/B6dJ/Taf2Er7oICpER33iGJGnislZSzLEhYgMalGPNaobLmfB7F8wiBQlt1rK/nADbMZU3FQMqYSeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPfVHja/9/EsRGl5KIh46BsJ7Zdbxy6GJtlhqeYrQco=;
 b=xUelZBnSwgUwk6G48V5fu8+raVezoZwb5uY6WJhT+fLLAEEVLE/GJGMsn4IWZpSnROhpZnE0bWzkHfQ7GVYo8ornJGDGn2rwxXRGgH66pBHNAtvUrq/NTUK74ZOGBtVh7tuwPHK57oVmDQynlYc1LxY3Kd5jxdmeM4VoG7tWz79vCnQy0wA89l8z1tovEqX9i0HIBvbKIht7KgPSGUvQ3fKnI9QRwW4gUr9rC2WT8YYMY1pOnJzAJK6U0aHkFHQB7Iz85r3M8LXltez71hFnkR5zsYQAWRti28IWdo6y0vF8FpoUmyrMWWotdkE+syN5xW8emyVjPrV1annfaizh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPfVHja/9/EsRGl5KIh46BsJ7Zdbxy6GJtlhqeYrQco=;
 b=fzupxZkmM35lfo2uRq6gHWbdFFsSU5Y/a9suIRHruZ5J+pTDyJJiQ+aIwNW0YjuYDC2mzv34zSvVOIHFjL1F9FHboGMgbD80B7Lbt3bOZKc1/n7nyomadcoE1PzUpsBwwSj0qxFKK+Vi/LpOApernWtcKXM0ipr9KTXqF0222qo=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by VI0PR83MB0659.EURPRD83.prod.outlook.com (2603:10a6:800:219::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.6; Thu, 25 Jun
 2026 13:50:52 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%4]) with mapi id 15.21.0181.005; Thu, 25 Jun 2026
 13:50:52 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jacob Moroni <jmoroni@google.com>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"shirazsaleem@microsoft.com" <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Thread-Index: AQHdBKmiZ3Jb3MiyzkqQnsLepq1iTw==
Date: Thu, 25 Jun 2026 13:50:51 +0000
Message-ID:
 <DU8PR83MB0975EC14569EB79C646CF358B4EC2@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260623114444.1429042-1-kotaranov@linux.microsoft.com>
 <CAHYDg1RQ8vEMrKPoS3qHgtf5S+T1Wzrm=YuwdfzFEX3g22Ruhg@mail.gmail.com>
 <DU8PR83MB0975639D552898AC93801EEBB4EC2@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <CAHYDg1SiAfCFBUy6JsdC=ROuLcxy4_ro40MNeieJ3sJp4R_cuA@mail.gmail.com>
In-Reply-To:
 <CAHYDg1SiAfCFBUy6JsdC=ROuLcxy4_ro40MNeieJ3sJp4R_cuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=99f10c52-9774-4f3c-bc67-e405888be6d8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-25T13:35:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|VI0PR83MB0659:EE_
x-ms-office365-filtering-correlation-id: 34b8961b-de95-4d6d-1067-08ded2c0c535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|6133799003|38070700021|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 RA04XHYQDpgvSidM9P6todbaK5sFnuhRofLGdYlBbGnE4QgsrG6Qzm1wPiwamqNUWAeCIkYBX1/46Y4Mtm+u7LOM+xMTsVKcO0IyEtvbmSdLsFAlNfYmgL4DYRLzkLUWZq2XPPWqYuF6j+NO5Lcn4GX9/xns5UmbAeh5k9VBRPYecUzgxAsgg/CgUcvXG8JQZV759u2bK01+dpwRMJlu4nw60LyteCN9/VNz/fkvavUYALT3TQIDjNiqtnBzf/00jf+4+2nu4bGEqyrj8CmRYiXFeztuDUmsBJSZYVfHLI7UkmUTtAmC7D1MInLV0MR5z31fM6G6E9o0HlMPnJW4FYzPSK2bBbakCtDXxqOMxi8Plpkpp70zrQMhQQ03E5OUfb0f0YlfkdyiTiDPH5LpZWU+2tOqTN1HXdXRGDLdIU5APyg/Ma2glPJY5/d8Vwt2UAW9t6uXOcdXjLDyabf7ofsrDUF0BbnVu/QqgwzXJDgEdm/ceeS4LkhBdofHR5nIzXc4rh3RgvRnhfD9Eq27TzTjj6vSh4y34P0F8tWWVAlB0zUkXSLYwFHxCG4QFHlAtG2sqomviXaBF7i+ib9rCw5pQmzDe5INU0SFzcrW2hD11TFBHorPXY0TphxYjIV6xOZ/SyUoCWe9fsf9W0oyMvbBr66PHAUUqAnWx4/KA0x344N3tmA41Yay6Ki75SYYMCZOzSNPpOMMjJxTC59MNiNg0GaAWa61bNxvdVV0TWo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(38070700021)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnZzL3owb2xiSm42b0xhbjVLalNTcmt5S2cwMTU2ODI1WlZLejlMdWEzVlBU?=
 =?utf-8?B?TkJLdzlvc3c5VExEdTQ0bHdEMUlUZWcyQTc2WUYvUXFHcm1ubSt3N0Q1UjI3?=
 =?utf-8?B?aXJxMU5oTXh0dk1JbENoM1JyeGhGWXkvU3g4R2NiT2Mva0NKRmhiYVFqM0sx?=
 =?utf-8?B?VGNYN1lRSTdxRnYrdXFEbFZSWThPUXNYSVIvM0hURVZSME11aCtiYW5ER21R?=
 =?utf-8?B?TGRxMDNOS0xOZVdZV1hDc0hidVp1NTlCY2x6VUQxeHFFWjhIWEt1ZlpvR2x2?=
 =?utf-8?B?M013ZGdtTjlRNHQ0Z2NIa1pmbkp4Nk5qblg3U2VIZ3FzWkZjYkdTZElIYTJD?=
 =?utf-8?B?RXpCYWs5a0I5YWMzWWgra2VZMGE1L0l6bzZVdGtLQ0tXWXJkU1JSVTVITHZ3?=
 =?utf-8?B?dzlaTU5kNHN4Y3FrTjdHaDhpS1BSSEN2c1g2VGZHV08yTkxvclR3KzNWQnp0?=
 =?utf-8?B?bTZVTW1JQ1JWcWdKOXduR1FiSWtVeVk1NFA5a3plSjd6TFc3MW4yeXZjSDJz?=
 =?utf-8?B?MEQwUXpsK2huMmM5TnBNV1hPOHRsMVUwaGVVakpDQzh3Wm1QMUdqSTNvU2ti?=
 =?utf-8?B?L3dIMkhUWmhWMDJSK0FCMXVjb3Y1TWdrSS9hanAwbkd2RVo1RWY4bWozakpz?=
 =?utf-8?B?UjdDcDJEUEtZTW9rVWFDdnNtSEQvT1pDSUJta3FiMDZQcExhU0hNekEwVER4?=
 =?utf-8?B?WmIyS016RWJmUmduSml4cXhXMkJ3Q0ZoM2NNeW9UU1MxZHF0ME5xRWtrTGJS?=
 =?utf-8?B?SCtBTUNMRkxzL0JDMnNQWlR4dVFhUEtOMXdybzhMM2VoQmp6bkIvWTcwUkdE?=
 =?utf-8?B?R0pzY2NjSHY1d0dSYklUdTU4Vit2cHpLZmJnNG9rWkhHRjJoUFZpSHN2enVh?=
 =?utf-8?B?cmhSdG8vQXNvQnJkNVV4QW1zMFhYc2Z4dS90RlBtdC9nendrWFAzQTZvQndE?=
 =?utf-8?B?MnN6OFlmQzI2ZjRUU2htMXhvM3VzTzBocmVmNDBPOHZjNUp2SEU5Ulc0cG8y?=
 =?utf-8?B?cTJWZ2tSU25EeDh0Wk55c2wvTlMvNlJFQUhvL3JORldZTnhwTXc0VjI1QVla?=
 =?utf-8?B?eE4vVG55ais2enV3SUluUGpSc0VxQVM5a2JrRU96azBHc050NDBLMHJhMndT?=
 =?utf-8?B?a2tRZVhKaWxhT0gzb2ZIVXlycVMwdUZvNjU3WlNKeEVBbXAySVh5RlA2YndC?=
 =?utf-8?B?SUpBRkhzRXRvRGtyK0VTVFpqeTZDRWhEeXFYSlNvRWcweW1tWERubWZpRWFS?=
 =?utf-8?B?eU80SXZ5aTZoTm1iZldEcWswTlFMS0VxSS9UL0VxMElUYklvY1YrWXY5NVVw?=
 =?utf-8?B?a0JjRFF4TDc1OXFxU1U3eUY0TWQ5WXk3S0dIeU1XTVhFMEYvUjI2WFJrNllI?=
 =?utf-8?B?TmpVb2ZSem1VditjTHRKa1RaWlFXWCs5aDNvQ0NFRTlFcyt0NTJycU1vU29w?=
 =?utf-8?B?dmJTMlBWSFlxV0Y0SE5HSnc2b2hlajIwRkxkVUZIRlhVN2o0dzRJRVo4SjhC?=
 =?utf-8?B?QXNNVHdOb0FncEhEa0dpNFltOWNYWUd0Wks4eUlwMDlhK1BQdVBmNDE1cjBj?=
 =?utf-8?B?SmRjdFhvcTBTbmFDRGxjNFlXU284dXJLR011Q01NdkZQSVJDOEduN0cyVW8r?=
 =?utf-8?B?U3ovU2hqclUzTXlHNUVnMmxyN3NleXlleEJET2Q2TFJScG5DQjRkTCtGeWhL?=
 =?utf-8?B?OEpEKzZrUkNXNlBFQzlJK1RWYzFWRndkZ0dWTytOUm4xQVJSa3M3MnlUaEhi?=
 =?utf-8?B?TUNqbFZwdDNENnZGcmxtNDVLY2V2Q2k1b0N5TjQwc2Y2LzRJSVNOakdwMTI4?=
 =?utf-8?B?QkZNSVBVSkltQ3hDRXZOS1JxTVFCZytPdEFMYklxZVM5Vy9PemhmbXpZd1BK?=
 =?utf-8?B?TVY0RFdWT1cwdjNHZGVJT2ZheFV4UHJabjlNOEw2aE1XNmxjMi9RTk5WTzJr?=
 =?utf-8?B?UHZtL3ZlS3pGUS9LOHhNb1hTZ3MreEZPNDM0SWNlN0ppSGF1YlVhSCs2YkFo?=
 =?utf-8?B?N05zeUlGNkxRaFBDcnBnMGZwbUQ3V3RwaGFHOUMwZ3h1M0hGTzB3cy9OdU1w?=
 =?utf-8?B?QmtibWdudVljNGpyLzQ4cHltL1Q2QllQL0l2bE1iSjQ2UEROVEhraWt5Ti82?=
 =?utf-8?B?MEtSU0VndXA0eGtjUjNhTmJuaUc2N0dPR2h4NDJYNS81UnJOTDI4L0VhZ0hY?=
 =?utf-8?B?eTdEOWMvSHk5OTlSNXBveFRWQXIydm5JZEdIM3RDdmErMFlpNW00dFNCYUM3?=
 =?utf-8?B?UEU5MitPOXBsYzN2M2E2alpBbFl3PT0=?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU8PR83MB0975.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b8961b-de95-4d6d-1067-08ded2c0c535
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 13:50:51.6660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KSfoJ3+EZIiLGmsgsdIxNnc9UlcWy0rbybh276uzYXOZnvKuiDJiIvrqYldYiVZlw5T+cL8jiytOWFGiZhZmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0659
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22473-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:kotaranov@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:longli@microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65C386C6417

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgTW9yb25pIDxq
bW9yb25pQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAyNSBKdW5lIDIwMjYgMTU6MjkN
Cj4gVG86IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+IENj
OiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBsaW51eC5taWNyb3NvZnQuY29tPjsNCj4g
c2hpcmF6c2FsZWVtQG1pY3Jvc29mdC5jb207IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29t
PjsNCj4gamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhU
RVJOQUxdIFJlOiBbUEFUQ0ggcmRtYS1uZXh0IDEvMV0gUkRNQS9tYW5hX2liOiBBZG9wdA0KPiBy
b2J1c3QgdWRhdGENCj4gDQo+IFRoYW5rcyBmb3IgZXhwbGFpbmluZy4gSSB0aGluayBpdCBtYWtl
cyBzZW5zZS4NCj4gDQo+ID4gT3RoZXJ3aXNlLCB0aGUgY2hhbmdlIHdvdWxkIGJlIG1vcmUgY29t
cGxleDogbmV3IHJlc3BvbnNlIGZvcg0KPiA+IGFsbG9jX3Vjb250ZXgNCj4gDQo+IERvIHlvdSBz
dGlsbCBuZWVkIG5ldyByZXNwb25zZSBmaWVsZHMvYml0cyBmb3IgYWxsb2NfdWNvbnRleHQgc28g
dGhhdCB0aGUNCj4gY2xpZW50IGtub3dzIHdoZXRoZXIgaXQgY2FuIGFjdHVhbGx5IHVzZSB0aGUg
bmV3IGNhcGFiaWxpdHkgLSBsaWtlIGEgZHJpdmVyDQo+ICJhY2siPw0KDQpJIGRvIHRoaW5rIHRo
YXQgYW4gYWNrIHBlciBjYXBhYmlsaXR5IGJpdCBvZmZlcnMgYW55dGhpbmcgdXNlZnVsLiBJbWFn
aW5lIGlmIEkgZGlkIG5vdCBoYXZlIGENCmNsaWVudCBjYXAgYml0LCBJIGNvdWxkIHN0aWxsIGdy
b3cgcmVzcG9uc2VzIGFzIEkgd2FudCBhbmQgSSBjb3VsZCBzZW5kIGJhY2sgdG8gdGhlIGNsaWVu
dA0KdGhhdCBjZXJ0YWluIGtlcm5lbCBmZWF0dXJlIGlzIGF2YWlsYWJsZS4gU28sIHRoZSBuZXcg
Y2xpZW50cyBjb3VsZCB1c2UgaXQgd2l0aG91dCB0ZWxsaW5nIHRoZSBrZXJuZWwNCml0cyBjYXBz
IGluIHRoZSBmaXJzdCBwbGFjZS4gU28sIHRoZSBtYWluIHVzZSBvZiB0aGUgY2xpZW50IGNhcHMg
aXMgdG8gYWRkIGNsaWVudC13aWRlIGJhY2t3YXJkIGNvbXBhdGlibGUgZmVhdHVyZXMsDQp3aGlj
aCBhbGxvdyB0byByZWR1Y2UgYm9pbGVyIHBsYXRlIGNvZGUgbGF0ZXIgaW4gdGhlIGtlcm5lbC4g
RS5nLiwgSSBkbyBub3QgcGxhbiB0byB1c2UgdGhhdCBjYXBzIGZvciBmZWF0dXJlcw0KdGhhdCBy
ZXF1aXJlIGtlcm5lbCBzdXBwb3J0LiBTb29uIEkgd2lsbCByZXNlbmQgdGhlIHBhdGNoIHdpdGgg
c2hvcnQgUERJRHMuIFRoZXJlIGlzIG5vIGJlbmVmaXQgaW4gdGVsbGluZyB0aGUNCmtlcm5lbCB0
aGF0IHJkbWEtY29yZSBoYXMgYSBjYXAgdG8gcmVxdWVzdCBzaG9ydCBQRElEcywgYXMga2VybmVs
IG11c3Qgc3VwcG9ydCBpdC4NCg0KSSBrbm93IHRoYXQgZHJpdmVycyBvZnRlbiBhY2sgdGhlIGJp
dHMgd2l0aCB0aGUgc2FtZSBmbGFncywgYnV0IEkgZG8gbm90IHNlZSB3aGF0IGl0IGVuYWJsZXMu
DQpIYXZpbmcgc2VwYXJhdGVseSBkZWZpbmVkIGNsaWVudCBhbmQga2VybmVsIGNhcGFiaWxpdGll
cyBzZWVtcyBtb3JlIHVuaXZlcnNhbCB0byBtZS4NClNvIGluIHVwY29taW5nIHBhdGNoZXMgSSB3
aWxsIGRvIGFkZCBrZXJuZWwgY2FwYWJpbGl0aWVzIGluIHRoZSByZXNwb25zZSAoZS5nLiwgZm9y
IHNob3J0IFBEcykuDQoNCi1Lb25zdGFudGluDQoNCj4gDQo+IFRoZSBmaXhlZCBXUUUgY2FwYWJp
bGl0eSBtYXkgYmUgc3BlY2lhbCBpbiB0aGF0IGl0IHNvdW5kcyBtb3JlIGxpa2UgYSBvbmUtDQo+
IHdheSBoaW50LCBidXQgSSBhbSB3b25kZXJpbmcgYWJvdXQgZmVhdHVyZXMgdGhhdCByZXF1aXJl
IGV4cGxpY2l0IGtlcm5lbA0KPiBzdXBwb3J0IChqdXN0IGh5cG90aGV0aWNhbCkgYmVmb3JlIHRo
ZSBjbGllbnQgY2FuIGFjdHVhbGx5IHVzZSBpdCwgbGlrZSBtYXliZQ0KPiBmZWF0dXJlcyB0aGF0
IHJlcXVpcmUgYWN0aXZhdGlvbiBpbiBIVywgZXRjLg0KPiANCj4gPiBXaXRoIHRoZSB3YXZlIG9m
IHJvYnVzdCB1ZGF0YSwNCj4gPiBwcm92aWRlcnMgd2lsbCBiZSBsb2NrZWQgdG8gb25lIHVkYXRh
IHJlcXVlc3QgZm9ybWF0IGZvciBhbGxvY191Y29udGV4dCgpDQo+IHdpdGhvdXQgYSBjaGFuY2Ug
b2YgZXh0ZW5kaW5nLg0KPiA+IFRoYXQgaXMgd2h5LCBJIHRyeSB0byBpbnRyb2R1Y2UgdGhlIGlk
ZWEgbm93Lg0KPiANCj4gR29vZCBwb2ludCAtIEkgd2FzIHdvbmRlcmluZyBpZiBhbGxvY191Y29u
dGV4dCB3b3VsZCBiZSBhbiBleGNlcHRpb24gdG8gdGhlDQo+IHJvYnVzdCB1ZGF0YSBwb2xpY3kg
c2luY2UgaXQncyB0aGUgZmlyc3QgcGFydCBvZiB0aGUgaGFuZHNoYWtlLiBBcyBpbiwgY2xpZW50
cw0KPiB3b3VsZCBiZSBhbGxvd2VkIHRvIHByb3ZpZGUgbm9uLXplcm8gdWRhdGEgaW5wdXQgdGhh
dCB0aGUgZHJpdmVyIG1heSBub3QNCj4gdW5kZXJzdGFuZCBhbmQgaXQgd291bGQgYmUgdXAgdG8g
dGhlIGRyaXZlciB0byBhY2tub3dsZWRnZSBmZWF0dXJlcyBvciBub3QNCj4gYnkgc2VuZGluZyBh
IHJlc3BvbnNlLiBTZWVtcyBraW5kIG9mIHNpbWlsYXIgdG8gaG93IEkgdGhpbmsgeW91ciBzb2x1
dGlvbg0KPiB3b3VsZCB3b3JrLg0KPiANCj4gT3RoZXJ3aXNlLCBpdCdzIGtpbmQgb2YgbG9ja2Vk
IGluIGFzIHlvdSBzYWlkLiBFbmZvcmNpbmcgYSByZWFsIGNvbXBfbWFzayBpbg0KPiBhbGxvY191
Y29udGV4dCB3b3VsZCBtZWFuIHRoYXQgY2xpZW50cyB3b3VsZG4ndCBiZSBjb21wYXRpYmxlIHdp
dGggb2xkZXINCj4ga2VybmVscyBzaW5jZSBjb250ZXh0IGFsbG9jYXRpb24gaXMgdG9vIGVhcmx5
IGZvciB0aGVtIHRvIGtub3cgd2hpY2ggYml0cyBhcmUNCj4gYWxsb3dlZCBvciBub3QuIEkgY291
bGQgYmUgbWlzdW5kZXJzdGFuZGluZyB0aG91Z2guDQo+IA0KPiBUaGFua3MsDQo+IEpha2UNCg==

