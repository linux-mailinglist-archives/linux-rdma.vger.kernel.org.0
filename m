Return-Path: <linux-rdma+bounces-1553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C9B88B24C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 22:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38891291B2C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F75F47E;
	Mon, 25 Mar 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jOHcs7Zs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD75EE64;
	Mon, 25 Mar 2024 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400826; cv=fail; b=L2ZjuQdbOXh526e5Muzi4Ba0tdYdaVE5joFf0vwhjN9U2dx4Q26CrtvX3mwWRJnHBXe3Lqdqho00o2CGUJ0xwbEG/2uxDmv3BHd8xPDRZuka37Fkk6GrsyhdZ16BeSzDDqXhLBNFo0hCREz8WZD0FBxmp7vsaEASob60ICigY1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400826; c=relaxed/simple;
	bh=TkDapE9DrnRKdekMYLTU95FKWLA7ejX3ZtJYvvKVxhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7/1jLE7e7fdbf+21L/B+hVkOmXHVsnQImY+9KfE8g3zIaYXQB+h2+GC8Vmutoui6S8NzCzN+W7pUOvjMjXlCudQlPleBx0u+cP27D8ndaawul8WMsS075DQJ/tLpxHb3kF1MX6P51MHWMDia6HqG+/iG0MjPQKGqRHvQCwECBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jOHcs7Zs; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEvmJXeuTVJ+/3hiv2jGEkkRnLjidnwENv+tdfXdOnYkkQ67C1Mdo2+LDhVVwR+dnRaWgUQIJZna3S+ty5/6mb1REthZDLiiqT+3146L5iJkdCGbePEjAjhYK+H4QHt+STEvLvZbJRFpFsH53zpqPSV/Ts69mFPepzNwyXF/HMb0rlbFWXJ9UgZSzKsWdopT/lfCsGJaEJToSB0wcqgMDFces5agjOx045b158Q0C8W3bwyZajvXOXqpazZsXrbZaU7E4Yj2r7JQzHqJWixFDH8XSqCahmrh2NVJwUkqDOANNHIC+zH/EZAd3kojAXDN6yj9SsfEXCgKSgYAqq3MjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkDapE9DrnRKdekMYLTU95FKWLA7ejX3ZtJYvvKVxhA=;
 b=Q8ihQqcZ60DtJkBG+GAChWobRwYUDUoKGOoP8Za+67zwffUlTSXDXW9ywxMIqgJBSFsRklTxyCPqe8mLr+Bf6yyw5QaJkTRYXdzqggxmpIC80ZZPWAXaUh729vzTFgCSDQ7+hyQkY17sns00q/EGOr2XJdxdCVn47ZPi2sJlbMOJsfcVJwgRQ4PR7ckuQyNRPxsZnjpZgW22fQTBk/dN4JnsyH08er5InGVtbs2NsBrLZ61euTHdOnwxIG2Jlyib+Q6faQ1Zw2A6hpDGtpdvWdK58obzQJLseTwhewIuoE81F6G0PD9eMKudk7rf24irHGU1Aqkq6tVUg/Be0bJSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkDapE9DrnRKdekMYLTU95FKWLA7ejX3ZtJYvvKVxhA=;
 b=jOHcs7ZsZQgoxC0GIxtpt6xvdRLGwaU8AJxLZRJx/jV3tNBWcX8VkNXye53KwFnvtLHDcDKwthWEdVRUolGU42NyxzKISRXRER5o339f18KiPXreojDX3Gz5cG+48gbLvRRgfQsU3Bo0cCe0xaU8ILNkIAS893FzsvKqJFi4znY=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by SN6PR2101MB1358.namprd21.prod.outlook.com (2603:10b6:805:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.20; Mon, 25 Mar
 2024 21:07:01 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7430.017; Mon, 25 Mar 2024
 21:07:01 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 4/4] RDMA/mana_ib: Use struct mana_ib_queue
 for RAW QPs
Thread-Topic: [PATCH rdma-next v2 4/4] RDMA/mana_ib: Use struct mana_ib_queue
 for RAW QPs
Thread-Index: AQHaeh7xOJCPEnE8T0i7r4Bx7u7kA7FI47RggAAWLwCAAAGGoA==
Date: Mon, 25 Mar 2024 21:07:01 +0000
Message-ID:
 <SJ1PR21MB345727F29DD1E4608A335B43CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710867613-4798-5-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB345735033DFA7CFF14B7BBD5CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
 <AS1PR83MB05435D612E76C1F4488FE99CB4362@AS1PR83MB0543.EURPRD83.prod.outlook.com>
In-Reply-To:
 <AS1PR83MB05435D612E76C1F4488FE99CB4362@AS1PR83MB0543.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1de6e87c-a583-43bc-aa2c-c97facb0b9ad;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-25T19:38:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|SN6PR2101MB1358:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rTheGkfHUj/IffNNz37FYT7/q52Hi6gtQu87sNRJL3e/bjzPsCQPskEWuPSyRgs0JzzA9GwswSB4rVGckd46lVTQXVmwrnVr3wfwI7BUkY3e1+aF0tpTW5hOe4iyC7C/YpCmNjzMSHGltPveaItRQJ92av4yKer+hzZ9c1uZetfYaTawtPPwN45si9Aa0qkCU4gQA/Jz1QXG3J/6ZxLPl0sCpZS5G00UtSSDHCbmqhYdwKWtdljgHPMYxI+YM94yRwnrRmuL9UZzp9ImOsdG7AzMUnNf3S+n52y0pKp14Rm+b4uCPiot9dD1eIIfeahkwE9GlMc7UQlTQw+bxyIyzAwrWts1drv2X3epH/INK8PV/k0B8hm5OpJ2W7DsiDOCdC35KGP8r0WFjEQ/NX+TetLEczADy0KCpZlzwQlVfeQBGghYLIEyJFpSK75lbjxTbrWgNZC9+JqatH7XT082OOvzdBG3Dpu2LNhqi1BYtL+/WQiwSQ2kZWnwOzXcFqVfJ6K3H3uQOMse5tEyQ2bBuiURylDt1+vYjRtfL9KV2TDzS5KYezofZG4WGO533mRbb/SuhRsW1BF9W4Z/ARVTgr+v6Znk8KOa7/Ort/SWpHLPxR/BN0m+lI6FYfAyaBJc+0okXk2zbAhyD7fLOZBh06vQOhrItRo4TmU80EIueLQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHc4cGdNcFFoSWszZDNkb09GY3ZBeDhOVjNOZ1NoN3FYN05Scm9OTkNISngr?=
 =?utf-8?B?clQ2dXhiWlBQNXhEVDBrcTdMU29ZQXpZd1FFdGtFU0FOMjV1VlRSbFRsQnNM?=
 =?utf-8?B?d3BTcGVFdWJOcUJHV0xEK1BwazB3UWNKWEl6WFd0anlJblV6bDdPOXBSc0J1?=
 =?utf-8?B?QnJoclRqeUVpTWdtckNyOTlGN3R3U1VVR2R4V21odnZCVERUaGpSbzVOSUFF?=
 =?utf-8?B?a2VIUkIyY2doREF6NHpKbzZHcTFJdDhHazNmZXA2WUtJeElCMFRHWVhNR2pu?=
 =?utf-8?B?eTV3K2hYMTFBTTFMUE1qQWZjZmx0QVJoVzIrcUdwNXMyQitpTWRYTWVCN1JK?=
 =?utf-8?B?VCtXejh4YVpJQTZ3SmlkdnVkbXoxcCtzcnEydWFnYjVLcFBtc3F2djIzRTlq?=
 =?utf-8?B?V3cyb3c1UjVMS2xYcTRPaFVWK1kyOTBKcEV5a2VYbGxFcXgrektpaTFrRmlJ?=
 =?utf-8?B?ZzBvVVZHNUZCUlZwRVdreHgyUFU5WVdpVWdhWFJwaGxCaE5vVlI3bUVON3U2?=
 =?utf-8?B?SmdDbGFvb1Q5QmlnSWRhNDFSRVpVTTJrVmU4L2tSQXk2UGZmRUsrM0JRQ01z?=
 =?utf-8?B?YjM0TVJQVDBXTmc0eXlNbFNDR0k1ZDZSTFRjdGxjZkF0Y0FEbHpVVGd0dnBo?=
 =?utf-8?B?TkMvOGRDTTFDcTR0ZlRJN2owTEJubW1ZWkQyL2xrTVMyWm91b1FSc3pEamxD?=
 =?utf-8?B?TEN5dmhuK3p2UDVOQU5yUHJySFljNU5keWZFdFRPSWp6VjBlaDltOUlXN3NO?=
 =?utf-8?B?UUVmcGdFdlk2U3lLTzAxb0FFeW5TaUdRbCtYRm5SSW5sTVdsMTZRODRXTkY5?=
 =?utf-8?B?UlhNTUJFSFBJdmZsTlJJblJqbmZDQWc5ZFJCNGlyVEdub1ZyZ3JiUHRZdy84?=
 =?utf-8?B?ZkEybDc1T3V4RmhTZmllb2ptOUl6TUFOSTBHUWdjYUxwTk92M2c5bklHaGsr?=
 =?utf-8?B?YzJTZlJ5b0o3MlN0eWU2YTZCRDFsbGgrTG9jbHZFMDU1QVFXZkc3czIwS0Vq?=
 =?utf-8?B?Z3V2MHZuT2VRbE1NbjZ6UlVKWEorZStkS1pKTGlOQmxDd1l2QnhvdkVkQU10?=
 =?utf-8?B?OGV5MCtEb2JTYUczV1NRSHlVNTA1Z1ludEg4aklWSVIzWmhOdGxkZEM0RS81?=
 =?utf-8?B?cmdVUGtnVzdHKzBBS21IRkd4SmFTY2V0R3BPcmM1bDUyQ3lBNXRrQ3RZV3FU?=
 =?utf-8?B?WGJFU1F6R3ZqVEkzNlZ0UkY0WTQyVTl5SUVyVCtobmdXN1ZKZkc4cEh1RXN0?=
 =?utf-8?B?Yk9YZmhxMy93SjRsN0lVMmk3TzFMbHFQSWdoVkp1UlRHbUV6MnlWRW9vOFZV?=
 =?utf-8?B?RUx3K1FMblZMT1ZoNVhzNjNJNjAwSzRKTmkxbjhHRXkvUlA0QU9HSng5M0Js?=
 =?utf-8?B?M2wyQnM1QkhENFptRktNM2FOUmV6TDVuMkhOb1FaSE5GdC9XdmlnT25IU2lm?=
 =?utf-8?B?dnFiS2JmbG1lMjZyQmRNdFN0cGtIcVRMcjZKQWNBbWpVQTRjeFZhRE1IN0w5?=
 =?utf-8?B?UHBkNERNL0k5L1FkWTdPVVR1THpueW1FWGJ5Uzl3NEthQUdJL0ltcmt0RHlP?=
 =?utf-8?B?dkFXc2pFeStKK0IzQXN4cWMzTGJCam8vL1hUZDcyelZ5WG82eWhuRExrM01a?=
 =?utf-8?B?Z2xJdnAvaHFBTnZOT1NEenQwWkRJS0x2L094RUxUTDMwSlh5M3JaYTJGVUl3?=
 =?utf-8?B?M1VNbG5pbk9pb0Nja1VyWmRtM3pQWWJpRktmSWNwMkxUaVVZeEJlRHUwNU1T?=
 =?utf-8?B?eXhsMks5SmMzcnNmbkNtQUJ6V2p3VTByNlVUNlJlQWFkWFJVQjI2VFBjR3k4?=
 =?utf-8?B?Nk5nZzlyT1JDMEpxTE83b0RFTFhudHA0cDJDK0IzSXZJV0NJZ1N4OUNWRTdQ?=
 =?utf-8?B?Ym5UTUU3WFFlQ2xtQnQ3anlxWTd5WUlGVzVTNXpMNzVyTXM0cStrdy9Sa0lk?=
 =?utf-8?B?SmxFcUJURlA0NHFMb2V0S0p0TXd5QVVTcGJzSWlodzExQzIrU2pLOU1PN1Uy?=
 =?utf-8?B?S2JtMVQvRDFBellVY0hJYmtvQkRvcWtaMzNjTmd4MitDamNWTWlMVW1RWUdv?=
 =?utf-8?B?ODRKc0ZIL1RvU2NsUENEWVIwQ3VsSHh0SnlPWXJJTGFGUnRtMEphdnZENkpU?=
 =?utf-8?Q?B8G/+07sKPxP2eDbN+mZx0qLQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd2ab65-1d36-4a02-7551-08dc4d0f841e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 21:07:01.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clO/63rPYFzKvZmqvE916SocgGgqi1PF3x2WubwOCO1WN64RxqnJz3QoqxzJzeVybOedj5KIiw7n4d8R/tVQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1358

PiA+ID4gIHN0cnVjdCBtYW5hX2liX3FwIHsNCj4gPiA+ICAJc3RydWN0IGliX3FwIGlicXA7DQo+
ID4gPg0KPiA+ID4gLQkvKiBXb3JrIHF1ZXVlIGluZm8gKi8NCj4gPiA+IC0Jc3RydWN0IGliX3Vt
ZW0gKnNxX3VtZW07DQo+ID4gPiAtCWludCBzcWU7DQo+ID4gPiAtCXU2NCBzcV9nZG1hX3JlZ2lv
bjsNCj4gPiA+IC0JdTY0IHNxX2lkOw0KPiA+ID4gLQltYW5hX2hhbmRsZV90IHR4X29iamVjdDsN
Cj4gPiA+ICsJc3RydWN0IG1hbmFfaWJfcmF3X3NxIHNxOw0KPiA+DQo+ID4gQXJlIHlvdSBwbGFu
bmluZyB0byBhZGQgYW5vdGhlciB0eXBlIG9mIHNxIGZvciBSQyBoZXJlPw0KPiA+DQo+IA0KPiBU
aGVyZSB3aWxsIGJlIG5vIG1vcmUgU1FzLiBUaGVyZSB3aWxsIGJlIHJjX3FwLCB1ZF9xcCwgdWNf
cXAsIHdoaWNoIGhhdmUgc2V2ZXJhbA0KPiBxdWV1ZXMgaW5zaWRlLg0KDQpBcmUgeW91IGdvaW5n
IHRvIHB1dCByY19xcCBpbnNpZGUgc3RydWN0IG1hbmFfaWJfcXA/IE9yIGlzIGl0IGFub3RoZXIg
c3RydWN0IGNvbnRhaW5pbmcgbWFuYV9pYl9xcD8NCg==

