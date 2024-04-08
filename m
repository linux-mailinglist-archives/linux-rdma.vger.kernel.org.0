Return-Path: <linux-rdma+bounces-1844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C2289BF6B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873411F225BE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B736F07B;
	Mon,  8 Apr 2024 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NZfr76e5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2129.outbound.protection.outlook.com [40.107.22.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6671C0DE8;
	Mon,  8 Apr 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580619; cv=fail; b=RG3otnRujcYRpApnNTZmDpHt6Ej+zP2gd1SPGWbud/jZx9xFa+2dAfFe8zIOBzZp14NnCMecFtjx6MZM4d+Ld0n/a/TGtIPzeP4q2/A5CfRxu+q4bIUhkDJNN6C6dn7inQcuxeG7MPZcsUyIDc9NEC7JVc5DyMcvnEw4JjnUEXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580619; c=relaxed/simple;
	bh=EWxZVIvUG0HaFu3qSUlMKUQSzOD1QZYZV5DmEA8JYHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T7P0+JCbTw0pM7k/QVBhnFLTk5d4rzoyo27GnIEJqIi5+Rn3XUT6JcGiHcK+7DW8rrDl7Pr8ObbtEsT3m5W5tAQr0d2a2hqJgKD7EYwsIgkRjnZbDu+zZtAhTjdV2QliYJnEbzpzMqmLYT1UHtewtVS3TdlA4n91oaJcaS1TEGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NZfr76e5; arc=fail smtp.client-ip=40.107.22.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbny0aI/fpq9Uwp2hfHpn0e0nTgnnSOTEY/NZmqiLaCGGmkL1m+wYiUD+cvJwKgG4nr3KizjwEnULkxJVe2K/oo77iwfy2uK+dbRAa2tM4y1o93faHWMEYZE9Mg8fR02yRKRDZJgqAjIHO8DyTUyCD/sJrOMZWEHbRDodZdggK/ZQK7xjLCgTE82t0W3Aaaoh1/YX5/1+y1PLBw/BmLkR+JyaIQuEzcMe040/hFSlXTgzPQvK3QgMLrEA/raS5rVd6MWCK2g1W6+Toh044ZakaruOlEPsV/9HH9nLcrUFMXmcYnzTOhPjG3nAiwqifAbBMub6fVsDVaDiqMSWYRh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWxZVIvUG0HaFu3qSUlMKUQSzOD1QZYZV5DmEA8JYHw=;
 b=T3cI5dVAc1gGuCOS1HZswmaY+GiIrci6z2rPmdMsn+C8sjbFYBCj/bu1ZcFiEybJG1ua9ajc13SyLSHSaPK/Bit0fw/3Sovch2zv7aeVSwcxeCYHzo0b1OjmIDc+/KH3VUqxqbeTOBbjAm+I4ehA5X/aOliQ4X/GnjBZO48rITBiZev4L/BqnbX+b84mmfgP+jRNjP7izW7ck/wi6Kqufxv9HNCLhkW8XRhxKoXbLAe5XC4YadapMM9vF64+vB0JB4eQbaro6kmmMRWqu9AuKWvJACnZ9vplCyFSyFW4MPUBk+Fa0K6WGPGIlyDdmbKMslX0VX+mimpAL57s1Dmpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWxZVIvUG0HaFu3qSUlMKUQSzOD1QZYZV5DmEA8JYHw=;
 b=NZfr76e570yV5FpLrSkOvWBi9SwCrvFNoP7jtkeYTcpjO1wsrP+1+5ZrqcUR/DRN4n/HI23v7SCTRApLlI71PxzuOoEbe+RPjgflrVr8EURNVG3ncbjU0KTM+ANmZbQ81hGo1vzYAtsanjo55DjjE/Gg5vFqre6zLBAPD705hwI=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by AS4PR83MB0548.EURPRD83.prod.outlook.com (2603:10a6:20b:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 12:50:12 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 12:50:12 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v4 0/4] Define and use mana
 queues for CQs and WQs
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v4 0/4] Define and use mana
 queues for CQs and WQs
Thread-Index: AQHaiZUjaNcaSXOlU0SCiirzhamgTbFeO8aAgAAWEVA=
Date: Mon, 8 Apr 2024 12:50:12 +0000
Message-ID:
 <PAXPR83MB05570E9EE9853B2E6F66703DB4002@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240408112533.GF8764@unreal>
In-Reply-To: <20240408112533.GF8764@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=91c06a3c-dc96-4c92-9aeb-db157940ccf7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-08T12:44:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|AS4PR83MB0548:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tzdA7CGARdmpM7kiB8LRdoFklLg30dZPnzLKUMBdne5+ql5ovDvV1KoBYSEgCaJgezvxsUKz+rudKhW7UMCehtWkOchhb6Y0bVeC9Uo8f38PBzPClNXmz8UeZs7XxAXUn9C0+eiVmucp5y69kE5o0gWNjccsB38NdaPAhjNqbcR02zHPmt9QofJQ83fdsedbkv4mT3LPMuIXk9FK3R1XHCbj2DImMhZeVFAce78IyMtcB/xDDf151Fp2xuj0SSd0OVfB04hMqQwyqHsQVUCCrFu4gmz9785qh8O2JmchXmpZbJ33VaMMXkbWFKDT+1S3wKgk93GqxbBgSazSBEoiFe1YofY9XtHNhaG6dWN6uoOfrNadOlUfGwLBS0HRmjTuM9rQgbC6CQrgFPa20f6TrOL0fd/2XjA6KBUznA2Nz0E9NFkrQaIdArGGHrpim66I5G99eoYyEPlilRnjll2GL2lr8ok855p4LsxvGGwh7fD8qpC3NrNx0A/vZzzJbDPh31VtlpNf6zKfJjLvJDIizIFItHgAbj0x5ahWKGRx3dN1jSFr685QeVmHzwK8/XrMRe7YWKc8j0GkYfKGTjBr8owfVvKTde38OMmYasN54YA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1dJU0I4YnpSekhIaU9SbXJFODk4anQxRUhza243eWs3RDNUcGJmUmFqczZE?=
 =?utf-8?B?RGRiYlQzVVZnOHh6eFRyVVcycXpJZjlMLzlsMmFBT2ZXdkhadi9ERmV5eWhQ?=
 =?utf-8?B?YVQzdzArVVV6eUg5ZDhXekN3Q25mZytrVlRoczlYWk1DNHRReEQ5Mm9aT2NJ?=
 =?utf-8?B?eWx3bXg2bnp4MFN3WTczV2VzRGY3N1lrNHgvbjY3dHZUVGtZRTNxczNXM25s?=
 =?utf-8?B?T1UySVJURHFWdlR2WFI1eHZjSUtraFFJbXJzMC80Q3l1R3lyZm8yNkd3RURL?=
 =?utf-8?B?NFFKcVBOYzJpSXczZGlhK2tBR2dKZkEzQ3QwUktTZHJZZHpvTnQzTlV2QkF1?=
 =?utf-8?B?S1cwNFJPVnFuZy82dVlOR1hHZ29NVGJWOEdSb2Q5SUtIZDc2dExDU0gramhI?=
 =?utf-8?B?a0NlOXovb1ZzeVBSNUdMUDFONlhOS1NCWXBNMkRycGxIQVVHSXVPUXM0RjZS?=
 =?utf-8?B?RlVoK2QxbGd5V1BEc1R1eEpyVWhzUFlnY0xsQ1BXMGhkRE9xNnU3dVJ2cUkv?=
 =?utf-8?B?M2JNRE5KTlNGRnozREZCTzdVdEpGZEhhZVNXNDBkZ2lvaVNwKytubCtXTVlV?=
 =?utf-8?B?b1J4UEFGQk1RSkJjK0lQeStZempNOUdYeWtBNVNNNDkyL3lpNlk3aTdLMk9I?=
 =?utf-8?B?YXlGOTZhWVJpUStCcEhPOUFUYUMwTzdWZDRrTUIrVHV1cFVRWlBMWEtxZUFz?=
 =?utf-8?B?djRyV01MYTN4UDNVR0MzbmlObTFrWTNwZWlWVWw4Z1lvRWl5ZlcxT2JZS0RY?=
 =?utf-8?B?MGFQbWtiOUY4L2RPNW9TL2RHQjVITDdXOG5yOFd5bDh3NW1zNE9DQkFFck9t?=
 =?utf-8?B?ekdxWTVjV0c2b096WjZXbkloTFJ1N2J0bi9UVENpVnJXTkxEeWIwQkFpUjc2?=
 =?utf-8?B?WXdRKzlvWEpPZ0lmRUt2TEU0bmlNWmM3NXNJVWk3TURlL2FVZHE5UkJFVkhn?=
 =?utf-8?B?MDZUdXRPQ0NyajZlUzN1aHhiWGhWQjcxTVVxZ2owL2d4ZUpWY2NjQktqa0d6?=
 =?utf-8?B?MkNodDRadnFHVXdJV2E2Yks5eldNVGdEM3JPVDNrQ0RGanRwVW8xTHVxbGU3?=
 =?utf-8?B?RnZ2aW9udVNDWmZiYVU5Qldyam9rRWFTcHpIMlhiaGpqZ1R0T2xRNHk4bW1K?=
 =?utf-8?B?SG5oZHUrR1hreGhNZUg3WHIzZitFMU9IRytNNnpHS0ZsbDZ6RnhOK21GU3k1?=
 =?utf-8?B?QnExb3VaOHpFK2FwNUgrTk1JWlRXVHZ2SjJyQ2dTKzFHWG5wSEJXaW13UGxY?=
 =?utf-8?B?c0pkOUF0VGdMTml6T1pQMUpiQXlpclV0dFBTVW4vby9MVy9RcmJOQW8yLzRJ?=
 =?utf-8?B?a2xhb21odHpkTmYxYXFoeXRzdU5JeUlyZG1JQ2FucUpOaWh1bnYxTWEwMUtC?=
 =?utf-8?B?YkZKT0Q5Zk1jN0luSjg0UGdWODVMd1VxQUZ5d3FIQzFhZUY1UzM5STRUcDFB?=
 =?utf-8?B?RG9QTUdWbGxvOG80bEJWeWdlNnJrK0tpeWdpYXFmeHc5ZVNvRDg5TjV0WlIw?=
 =?utf-8?B?UmswSkVvWThmak9nSXRzdUNRUXdtUzJtSGRnNnhMZVZEUEJMNmI2cXNJMjR4?=
 =?utf-8?B?dmRqKzZadEJmK09kUS8yZWkvdTdxSDRITFNwdVNFcmpXbzA0RXREeml0eHVj?=
 =?utf-8?B?YVUzaGl5Skk0UmpBZkttSk1zeGRRQUlnR3VGNU5NeE5CVDlaZlk3M0dUMFNM?=
 =?utf-8?B?U1JjOUxIRzlIWXB2enRXd1E2SDF5SmFsRTd5VzFmaGdCQmVORDc3NGp0ZzQr?=
 =?utf-8?B?VlVFU3h5L0VFd0F5cXFqakF0OEFSTjd3bXJjT2RrMlNBMVNRRUhIa1NrSklG?=
 =?utf-8?B?MXMwZlR6TXA2ZTdYVW11MHE0NWZIN0h0Vk0vQWJ5NGxJRVdkcmJ2VmVnREVt?=
 =?utf-8?B?Q3dSRFJIdy9LbEhQb2NDU3FySUJhb1U0SmhHWkd4SytGbzBoRmptT0NMZXd4?=
 =?utf-8?B?NUsvOG8zenp0V3BuK09ZQmlybCtxc25VTFRjempIK1dqdndUK1k3ZW51RWQz?=
 =?utf-8?B?VEJZdnJaVW9ZbUNWdHBuZlJoYUk4TktIdEc4OTlJTWtPOG5BN2ljb3VoZ1Ni?=
 =?utf-8?B?aEx6OFd5YTU0RmN2dndPd2d0Vzg2am91YXkzdHg0Qk81ZEF3TDV1cXNYTGh4?=
 =?utf-8?Q?NFA4XF078w9fBj5dhBV/ShHUu?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f1641a-9414-4597-88ec-08dc57ca6e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 12:50:12.5418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnMBSjHEfFe9KQhOHp/dQQQKCO62+WT+D/x5/nQqerB1p5YJsXqLDw0BGsoRXgUm1ZVseoBQrScVbcWFK063VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR83MB0548

PiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4gT24gTW9uLCBBcHIg
MDgsIDIwMjQgYXQgMDI6MTQ6MDJBTSAtMDcwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0K
PiA+IEZyb206IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+
ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBhaW1zIHRvIHJlZHVjZSBjb2RlIGR1cGxpY2F0aW9u
IGJ5IGludHJvZHVjaW5nIGENCj4gPiBub3Rpb24gb2YgbWFuYSBpYiBxdWV1ZXMgYW5kIGNvcnJl
c3BvbmRpbmcgaGVscGVycyB0byBjcmVhdGUgYW5kDQo+ID4gZGVzdHJveSB0aGVtLg0KPiA+DQo+
ID4gdjMtPnY0Og0KPiA+ICogUmVtb3ZlZCBkZWJ1ZyBwcmludHMgaW4gcGF0Y2hlcywgYXMgYXNr
ZWQgYnkgTGVvbg0KPiA+DQo+ID4gdjItPnYzOg0KPiA+ICogW2luIDQvNF0gRG8gbm90IGRlZmlu
ZSBhbiBhZGRpdGlvbmFsIHN0cnVjdCBmb3IgYSByYXcgcXANCj4gPg0KPiA+IHYxLT52MjoNCj4g
PiAqIFtpbiAxLzRdIEFkZGVkIGEgY29tbWVudCBhYm91dCB0aGUgaWdub3JlZCByZXR1cm4gdmFs
dWUNCj4gPiAqIFtpbiAyLzRdIFJlcGxhY2VkIFJETUE6bWFuYV9pYiB0byBSRE1BL21hbmFfaWIg
aW4gdGhlIHN1YmplY3QNCj4gPiAqIFtpbiA0LzRdIFJlbmFtZWQgbWFuYV9pYl9yYXdfcXAgdG8g
bWFuYV9pYl9yYXdfc3ENCj4gPg0KPiA+IEtvbnN0YW50aW4gVGFyYW5vdiAoNCk6DQo+ID4gICBS
RE1BL21hbmFfaWI6IEludHJvZHVjZSBoZWxwZXJzIHRvIGNyZWF0ZSBhbmQgZGVzdHJveSBtYW5h
IHF1ZXVlcw0KPiA+ICAgUkRNQS9tYW5hX2liOiBVc2Ugc3RydWN0IG1hbmFfaWJfcXVldWUgZm9y
IENRcw0KPiA+ICAgUkRNQS9tYW5hX2liOiBVc2Ugc3RydWN0IG1hbmFfaWJfcXVldWUgZm9yIFdR
cw0KPiA+ICAgUkRNQS9tYW5hX2liOiBVc2Ugc3RydWN0IG1hbmFfaWJfcXVldWUgZm9yIFJBVyBR
UHMNCj4gPg0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9jcS5jICAgICAgfCA1MiAr
KystLS0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYyAg
ICB8IDM5ICsrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYW5h
X2liLmggfCAyNiArKysrLS0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9xcC5j
ICAgICAgfCA5MyArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvaW5m
aW5pYmFuZC9ody9tYW5hL3dxLmMgICAgICB8IDMzICsrLS0tLS0tLS0NCj4gPiAgNSBmaWxlcyBj
aGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCAxNDcgZGVsZXRpb25zKC0pDQo+IA0KPiBJdCBkb2Vz
bid0IGFwcGx5Lg0KPiANCg0KSSBndWVzcyB0aGVyZSB3YXMgc29tZSBtaXMtc3luY2hyb25pc2F0
aW9uIGJldHdlZW4gdXMuDQpJIHNlZSB0aGF0IHlvdSBoYXZlIGFscmVhZHkgYXBwbGllZCB0aGUg
cGF0Y2ggNiBkYXlzIGFnbzoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3JkbWEvcmRtYS5naXQvbG9nLw0KDQpJIGFtIHNvcnJ5IGZvciBzZW5kaW5nIGEg
bmV3ZXIgdmVyc2lvbiBhZnRlciB0aGUgcGF0Y2ggaGFzIGJlZW4gYXBwbGllZC4NCkkgaGF2ZSBu
b3QgY2hlY2tlZCB0aGlzIGJlZm9yZSBzZW5kaW5nLg0KSSBjYW4gdGFrZSBjYXJlIG9mIHVzZWxl
c3MgZGVidWcgcHJpbnRzIGluIGEgZnV0dXJlIGNsZWFudXAgcGF0Y2guDQoNCktvbnN0YW50aW4N
Cg0KPiBHcmFiYmluZyB0aHJlYWQgZnJvbSBsb3JlLmtlcm5lbC5vcmcvYWxsLzE3MTI1Njc2NDYt
NTI0Ny0xLWdpdC1zZW5kLQ0KPiBlbWFpbC1rb3RhcmFub3ZAbGludXgubWljcm9zb2Z0LmNvbS90
Lm1ib3guZ3oNCj4gQ2hlY2tpbmcgZm9yIG5ld2VyIHJldmlzaW9ucw0KPiBHcmFiYmluZyBzZWFy
Y2ggcmVzdWx0cyBmcm9tIGxvcmUua2VybmVsLm9yZyBBbmFseXppbmcgNSBtZXNzYWdlcyBpbiB0
aGUNCj4gdGhyZWFkIExvb2tpbmcgZm9yIGFkZGl0aW9uYWwgY29kZS1yZXZpZXcgdHJhaWxlcnMg
b24gbG9yZS5rZXJuZWwub3JnIENoZWNraW5nDQo+IGF0dGVzdGF0aW9uIG9uIGFsbCBtZXNzYWdl
cywgbWF5IHRha2UgYSBtb21lbnQuLi4NCj4gUmV0cmlldmluZyBDSSBzdGF0dXMsIG1heSB0YWtl
IGEgbW9tZW50Li4uDQo+IC0tLQ0KPiAgIOKckyBbUEFUQ0ggdjQgMS80XSBSRE1BL21hbmFfaWI6
IEludHJvZHVjZSBoZWxwZXJzIHRvIGNyZWF0ZSBhbmQgZGVzdHJveQ0KPiBtYW5hIHF1ZXVlcw0K
PiAgICAgKyBMaW5rOg0KPiBodHRwczovL25hbTA2LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLg0KPiBrZXJuZWwub3JnJTJGciUyRjE3MTI1
Njc2NDYtNTI0Ny0yLWdpdC1zZW5kLWVtYWlsLQ0KPiBrb3RhcmFub3YlNDBsaW51eC5taWNyb3Nv
ZnQuY29tJmRhdGE9MDUlN0MwMiU3Q2tvdGFyYW5vdiU0MG1pY3Jvcw0KPiBvZnQuY29tJTdDNDQ0
Y2MwOTAzMjA3NDU0YTA2M2QwOGRjNTdiZTlmOWUlN0M3MmY5ODhiZjg2ZjE0MWFmOQ0KPiAxYWIy
ZDdjZDAxMWRiNDclN0MxJTdDMCU3QzYzODQ4MTcyNDA1NjQ4NzcyOSU3Q1Vua25vd24lNw0KPiBD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYVd3DQo+IGlMQ0pYVkNJNk1uMCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9Q2FBcmNBNFZ2YWJi
Q2c0cGRKYk1TTG5JWg0KPiBpTXhET1JFRnNpcCUyRk8zSXdnNCUzRCZyZXNlcnZlZD0wDQo+ICAg
ICArIFNpZ25lZC1vZmYtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPg0KPiAg
IOKckyBbUEFUQ0ggdjQgMi80XSBSRE1BL21hbmFfaWI6IFVzZSBzdHJ1Y3QgbWFuYV9pYl9xdWV1
ZSBmb3IgQ1FzDQo+ICAgICArIExpbms6DQo+IGh0dHBzOi8vbmFtMDYuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUuDQo+IGtlcm5lbC5vcmcl
MkZyJTJGMTcxMjU2NzY0Ni01MjQ3LTMtZ2l0LXNlbmQtZW1haWwtDQo+IGtvdGFyYW5vdiU0MGxp
bnV4Lm1pY3Jvc29mdC5jb20mZGF0YT0wNSU3QzAyJTdDa290YXJhbm92JTQwbWljcm9zDQo+IG9m
dC5jb20lN0M0NDRjYzA5MDMyMDc0NTRhMDYzZDA4ZGM1N2JlOWY5ZSU3QzcyZjk4OGJmODZmMTQx
YWY5DQo+IDFhYjJkN2NkMDExZGI0NyU3QzElN0MwJTdDNjM4NDgxNzI0MDU2NDk1NzAwJTdDVW5r
bm93biU3DQo+IENUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16
SWlMQ0pCVGlJNklrMWhhV3cNCj4gaUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1D
RiUyQjIlMkZ4SyUyRmJxVTR0eWxKJTINCj4gQkw5azRYT2pJNklxdHRoeWRLc1olMkZreHo4bkUl
M0QmcmVzZXJ2ZWQ9MA0KPiAgICAgKyBTaWduZWQtb2ZmLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxl
b25Aa2VybmVsLm9yZz4NCj4gICDinJMgW1BBVENIIHY0IDMvNF0gUkRNQS9tYW5hX2liOiBVc2Ug
c3RydWN0IG1hbmFfaWJfcXVldWUgZm9yIFdRcw0KPiAgICAgKyBMaW5rOg0KPiBodHRwczovL25h
bTA2LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
b3JlLg0KPiBrZXJuZWwub3JnJTJGciUyRjE3MTI1Njc2NDYtNTI0Ny00LWdpdC1zZW5kLWVtYWls
LQ0KPiBrb3RhcmFub3YlNDBsaW51eC5taWNyb3NvZnQuY29tJmRhdGE9MDUlN0MwMiU3Q2tvdGFy
YW5vdiU0MG1pY3Jvcw0KPiBvZnQuY29tJTdDNDQ0Y2MwOTAzMjA3NDU0YTA2M2QwOGRjNTdiZTlm
OWUlN0M3MmY5ODhiZjg2ZjE0MWFmOQ0KPiAxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCU3QzYzODQ4
MTcyNDA1NjUwMDY0MiU3Q1Vua25vd24lNw0KPiBDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpB
d01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3DQo+IGlMQ0pYVkNJNk1uMCUzRCU3
QzAlN0MlN0MlN0Mmc2RhdGE9WmxJRnRXVDBmT2R3aXVKYnFWaWtpJTJGVGQNCj4gQ1phQnlCYnpV
eTdnNEQ5SENIRSUzRCZyZXNlcnZlZD0wDQo+ICAgICArIFNpZ25lZC1vZmYtYnk6IExlb24gUm9t
YW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPg0KPiAgIOKckyBbUEFUQ0ggdjQgNC80XSBSRE1BL21h
bmFfaWI6IFVzZSBzdHJ1Y3QgbWFuYV9pYl9xdWV1ZSBmb3IgUkFXIFFQcw0KPiAgICAgKyBMaW5r
Og0KPiBodHRwczovL25hbTA2LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsb3JlLg0KPiBrZXJuZWwub3JnJTJGciUyRjE3MTI1Njc2NDYtNTI0Ny01
LWdpdC1zZW5kLWVtYWlsLQ0KPiBrb3RhcmFub3YlNDBsaW51eC5taWNyb3NvZnQuY29tJmRhdGE9
MDUlN0MwMiU3Q2tvdGFyYW5vdiU0MG1pY3Jvcw0KPiBvZnQuY29tJTdDNDQ0Y2MwOTAzMjA3NDU0
YTA2M2QwOGRjNTdiZTlmOWUlN0M3MmY5ODhiZjg2ZjE0MWFmOQ0KPiAxYWIyZDdjZDAxMWRiNDcl
N0MxJTdDMCU3QzYzODQ4MTcyNDA1NjUwNDI1MiU3Q1Vua25vd24lNw0KPiBDVFdGcGJHWnNiM2Q4
ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3DQo+IGlM
Q0pYVkNJNk1uMCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9YlpUeEcwa3o1Y29zYnRXNFFNZzJyU2tl
aQ0KPiBoMDhRJTJGQk9yUiUyQkVISTRST3JZJTNEJnJlc2VydmVkPTANCj4gICAgICsgU2lnbmVk
LW9mZi1ieTogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+DQo+ICAgLS0tDQo+ICAg
4pyTIFNpZ25lZDogREtJTS9saW51eC5taWNyb3NvZnQuY29tDQo+IC0tLQ0KPiBUb3RhbCBwYXRj
aGVzOiA0DQo+IC0tLQ0KPiAgQmFzZTogdXNpbmcgc3BlY2lmaWVkIGJhc2UtY29tbWl0DQo+IDk2
ZDljYmUyZjJmZjdhYmRlMDIxYmFjNzVlYWZhY2VhYmU5YTUxZmENCj4gQXBwbHlpbmc6IFJETUEv
bWFuYV9pYjogSW50cm9kdWNlIGhlbHBlcnMgdG8gY3JlYXRlIGFuZCBkZXN0cm95IG1hbmENCj4g
cXVldWVzIFBhdGNoIGZhaWxlZCBhdCAwMDAxIFJETUEvbWFuYV9pYjogSW50cm9kdWNlIGhlbHBl
cnMgdG8gY3JlYXRlIGFuZA0KPiBkZXN0cm95IG1hbmEgcXVldWVzIFdoZW4geW91IGhhdmUgcmVz
b2x2ZWQgdGhpcyBwcm9ibGVtLCBydW4gImdpdCBhbSAtLQ0KPiBjb250aW51ZSIuDQo+IElmIHlv
dSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNoLCBydW4gImdpdCBhbSAtLXNraXAiIGluc3RlYWQu
DQo+IFRvIHJlc3RvcmUgdGhlIG9yaWdpbmFsIGJyYW5jaCBhbmQgc3RvcCBwYXRjaGluZywgcnVu
ICJnaXQgYW0gLS1hYm9ydCIuDQo+IGVycm9yOiBwYXRjaCBmYWlsZWQ6IGRyaXZlcnMvaW5maW5p
YmFuZC9ody9tYW5hL21haW4uYzoyMzcNCj4gZXJyb3I6IGRyaXZlcnMvaW5maW5pYmFuZC9ody9t
YW5hL21haW4uYzogcGF0Y2ggZG9lcyBub3QgYXBwbHkNCj4gZXJyb3I6IHBhdGNoIGZhaWxlZDog
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFuYV9pYi5oOjQ1DQo+IGVycm9yOiBkcml2ZXJz
L2luZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmg6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+IGhp
bnQ6IFVzZSAnZ2l0IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoPWRpZmYnIHRvIHNlZSB0aGUgZmFp
bGVkIHBhdGNoIFByZXNzIGFueQ0KPiBrZXkgdG8gY29udGludWUuLi4NCg==

