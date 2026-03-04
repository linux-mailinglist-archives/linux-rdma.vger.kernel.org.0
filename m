Return-Path: <linux-rdma+bounces-17469-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILRTGc1DqGlOrwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17469-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 15:38:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B534A201ACD
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 15:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BB11317AE9E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40CC3AE1AD;
	Wed,  4 Mar 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UFIR4XMU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021117.outbound.protection.outlook.com [52.101.70.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774E317165;
	Wed,  4 Mar 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633203; cv=fail; b=fOmEnMEf3H+fphqWDlpevki0VNTBXH8mgegAh6o+JsZ2y0BZKnEI1sv+2vkbO7dcLmugamQ2/DGBRcJ5PCmUV5pjSZ3td1A6k8hZ5GJEr3JCOLEVpX3qNkcSMGqgiAtRE/yV3CxhO3MyiVdpuctBF3W4E3GRn7MVexjPFGdGxI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633203; c=relaxed/simple;
	bh=pJmDTf2UbFMj94AKs3LpdQaYYvhW0oZYvAK4aZ+nuZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fcT4GB+NoDJ8q4A5WW7474FRVXynQ2U9BeUrLtiDM823uZQCdSfZRAPiclSwzHjZ8kgKvQQOoPaL9XKOl4lkchjxd+kvA8HJxKZTQIUkHcWeKGIK7k3kjc34gEofy6Nz9F+Q0N02NfyFCqRgM9WSk1ms3uT6xQDpqt+S1uqIRXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UFIR4XMU; arc=fail smtp.client-ip=52.101.70.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYTn2ErPg5v+FPszQoRF+gTmiIa432+FTYAd/EGhZjVuwtnL8Y0K7bMk9Z5H8x00UxUfuAzrB7kbKrHBuvJ6wUeEh+uyr0ozr9sQpRObjJllTYT5IEioxhopuz882xUMbN9zHVYuYQKW4CkQMUPX17NFpZ9zHS3TB4IfueuoIV2EdxklkOElVEhWz0OB6maG8yKvKMcYFGxc9ewwIWq9IhUQWGIqAS59bdcOopPlDEY7yg+9mXa2XiVUylLCUkVN4Rh8PMaabYtquFP3tFB2kg2Od0S1VWZ+WjwptfTsMQFFswx64h/EHfn4Nd8YVib2OGTOxEIQm7TXBNt5rB3eyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJmDTf2UbFMj94AKs3LpdQaYYvhW0oZYvAK4aZ+nuZM=;
 b=MjChrDO1Hq5xJu6P3J9K81WZQCviwE3oSV56XwB2K2QObsVGAMGMnaiMul0BlJWLBMTbKO+YvPBijRBTncdvYEjTOp7Ql7B9YPnuoKeMAxsUnCmAeYuWlbsgQC/fTH/cAxXmk7Eyd3c8N4D8Je37YAcR/KkrgP5e9sq+M1pDE/teat/pvOgcE9C07ePzwf6hcplpUQL/E1fmMZp9Rs3x0yCpNZZAAl2dW+MeMT5SoHTjaOysPvzFE07XhfLeEKgCSdVQ+WFk65uesjd2WW//YE17sPBYS5TEyx52kEHVPO4mngk66HrMtZ449Sbv2cqlo9X6t9LKTIj1wH2jdWS6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJmDTf2UbFMj94AKs3LpdQaYYvhW0oZYvAK4aZ+nuZM=;
 b=UFIR4XMUcYqPsOK5cOvrVOwiXh2iDFHUJ28um4Lrjo1k259TchL6jtIzcN9ugrkTqODlVrqXWCdDXeOOyEsuukHd3C80cSfPqqTO508l4vjtGNfZvjZU6MLzxhqw9+dZ4K/vBA39pa4VbfP/1vKAziJ/WT7f5mzE1Gqrd0nXuPw=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by DU4PR83MB0722.EURPRD83.prod.outlook.com (2603:10a6:10:584::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.4; Wed, 4 Mar
 2026 14:06:28 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%3]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 14:06:21 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Shiraz Saleem <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 1/1] RDMA/mana: Provide a modern CQ creation
 interface
Thread-Topic: [PATCH rdma-next v2 1/1] RDMA/mana: Provide a modern CQ creation
 interface
Thread-Index: AQHcq9obj5Bblf2meUa1Zm63iFmp5rWeZXbg
Date: Wed, 4 Mar 2026 14:06:21 +0000
Message-ID:
 <DU8PR83MB0975A4114E1CFE0B6BFA2DBBB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260303124825.301452-1-kotaranov@linux.microsoft.com>
 <20260304110500.GZ12611@unreal>
 <DU8PR83MB09757DD51165365AC8BBB884B47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <DU8PR83MB09750B39D50595F015641D7DB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DU8PR83MB09750B39D50595F015641D7DB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec221220-48c8-4bce-a819-128ea156a15a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-04T11:27:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|DU4PR83MB0722:EE_
x-ms-office365-filtering-correlation-id: 580a4437-cc4a-44ee-3c9f-08de79f73690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 IXullmxcjCaPHQkt0VzIbsC1EIEuVJ+HKWoGoqDlCnWg0B83ULlmmYwuZUahxLOxvoUzce3zEYPYEG5po9BoQ+0L5IdDtDcTeFKpclrJ3CczpmmX2mI9qZCE16Jy1pgrX0qM2IPdKJzztHGTR8vd6IGd1QWEoF5Mo9T8/nTVgvxgsreQ52/Y+axASYdL0wTeOUP3WDu5BOZJvi/WHWfWkFWmq7mrgze2Gxr/7zdYYfNX7MWfowVSCAQTQPnej306n3jfxpRQP7PebMUUIXjgqPc9PeP7Tp8tK7YJfYyGvIlG7D4h+rqAEUro/M7j2nAFDe4eKRp/3dZ3DhpRErCksDAXqk9TZPATy5ETnBWl0Z1d1QSC8uTzVrBPxbS4/LWQ/xX+Ysqx5WylMRg+AGrvSmuqcfatRQ29Yb99oFaI3DQGdUpdb74LjclgQ87uq0+uf1atM7EExQ/aCN/3CiZIB4Tax6UsamtCnBhCzHI4Zfj3l4ODMdV9SGSnhvXwwM70ntDmVOnTdfRIa+1nXTeNtw4Qop7SS0Y+VKG5j0zUHj9bvqdw8+SfHcvG8zjdkvDTemTPqauJkwC1191+xtbdLPJwwQ4KcyZwuSctxuxvA85N3r6K7c9FFnlKXSr40ZP31wGljctV1tln4YTybOuq3U3UoOVRHvtEjsQ0rd2iTtIDxi9P8suEMOJJeRPTTRRf9yLJSG2NQxpKJFLRhlLC0e/LMZScJoEBQ+6vzANWvl21j5Z+mrWzZEiTQ8WAyySIAY0yMjFQ8WDOO8k6n02eHHlwMglms4tVXjH+KMVOAcA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUZsVkVWU2FqcE11aEV0QjhhSHdGT0RUbTRCQUZCdmowUUd0dFhRbCtVZ1FJ?=
 =?utf-8?B?K04rOEhWNkV4ZXc0RWl1YVdsaUh6akNXKy9yRk9hamNKbG9aVW9qdWpMOGkz?=
 =?utf-8?B?QmpzUEFWTXIxa2NIdFVoYjQwVjZKWDNHUGE4L1lYSFhBdFI5U0I2TG9pS1I2?=
 =?utf-8?B?cUppQXo5Sk5IOEZ1cGRxcCtpWVhVV25jK0ZVOTVhbXZnQjJKYVJGcUZTTzBI?=
 =?utf-8?B?dVk5VlIvNkJRSklCUHJZVFEwUEE5YlJqclBzRjM4Y3NKeXJYRTAza2FDdHAv?=
 =?utf-8?B?RklJWGpTelRDSTVxblR1QjhsMkNSc25UNGhZOTdIT3BWV2tRbjZlMkt3YkQv?=
 =?utf-8?B?M0orMW8rTnpYbGNYV2tHMk9QQzlWRDZiYTB3cVY4YkNpN1FkWlVzN0l5WGM2?=
 =?utf-8?B?eXU0UjltK2ZMMGtEQUxyMTBnSThGUEpkQVZRRTRqZzhhbExUSDhqL2ppbFBz?=
 =?utf-8?B?MlZxUm05TlREN2d1NldseGg0aDUzMlJVTXlCaFFuVk1WRzNNOUJiUEY4YjJF?=
 =?utf-8?B?bGRjT0duYXFwQzZ1bVdMNzRKdkprU2JsdGp0QkIvYngxQTR6OW16eDZ0blo0?=
 =?utf-8?B?WGZGSjBUaVpCNjdiTjN0N0dOTC9ySmhPTEhBYWJieXlGUHhUamJWRDdhODVh?=
 =?utf-8?B?SU1aRlJGejA0VlFMNU9yY09xMlY3TzJ0U05OcUpTcmVFb3cxb1cwNFl1akZ5?=
 =?utf-8?B?ZUtFQXByV2ZCUSs1VVJJUDFvK1V2Y09oVzlaa08zcFFPSm96ZHN1WDJ5N3E3?=
 =?utf-8?B?VVM1K3NlVXFkWUlTakJSOFhsRnVZUkV3TFBQWDFobnU3bnI0VitxZG0yMjkv?=
 =?utf-8?B?UVJNM0RydTMzekNWeUhNckt2M1hiVUlHWHorbHBhOEsxWjJmNmtHa3FCZkZh?=
 =?utf-8?B?d0dUaDE2TkhodmxnSDA0bi9KZ0JubC9xTW11VkRWbG9lWG5SUmw2VVZsd0M3?=
 =?utf-8?B?TGMyNTdBckJsc0lXR1lnb296dHVMaUdZckhHVFZ5WUV1VG9xVGo2U3FOUWFU?=
 =?utf-8?B?SVFWWS9nd2p5Z1ljUGxOR0NpNE9qSnY1T2FyVE93N0xJbGx1am9NbkNCZkJM?=
 =?utf-8?B?MjJoTG5wTTdJekVlYUh1aFQyVGhsbWRQMUdhZFdydThIOWNBb1dGd1ZTUjB5?=
 =?utf-8?B?SzNRK1IwWUQ1SFBaY0RXN1BITEh5akRqazB2MkRQbEw4bEJXck9NM28wcjEx?=
 =?utf-8?B?WDE3NVQrTVg5VFZSSFM3TnhBRkFDMW9PRm9rWDJYcDQwNWt3OStKVStIS0Ux?=
 =?utf-8?B?WkxPc2JEQTQyYUVubXN3bzBsSVFtWUZWcm1WVHRqNENVaUtaM0kyOUU0NGlm?=
 =?utf-8?B?Sk5KUlFuQXY3MUtEcUNEVm1KS25ESzhxeDVGUDBxcmgwMWluSWdlYnV0U1px?=
 =?utf-8?B?MkFnOW9mbWxqRHZvajBFWnljNUZaK3Q1MHJqOXc0eXdsdktHa3pvSXRHS1pF?=
 =?utf-8?B?QWc0M0RTYVZOTkVERitka29DYkswVVdCNlhzQTlzTmxySk1MMjlIeFNEaVdp?=
 =?utf-8?B?Q1UxOUVTR2hqYkc5aDB2UysxMkJ1T0xUVnhqZ2pOSzM1UTFXTXNsOUdFSkNL?=
 =?utf-8?B?QjRDcEtKZngwUUk5NlUwaFdXTUFWQmVZNUNDd244bEJCYU5DQWtoakhNeE9D?=
 =?utf-8?B?bUJLQnRjS2VxQ1pxdnBsc2dtcjNia1IwRnZ3NWtWWmFLWHB6Z2hiQTZTeXR5?=
 =?utf-8?B?RFkwSHZwdVZQdUVtSG50a092TWRDS2VZcjgrZDR0azJ5OWZLTzNsWmNPTVdr?=
 =?utf-8?B?VkhZbHFTUEFFQWF6TjcyYlFlV3dMTkZtL0V2eHhLSzd5MTc5NFFsQnRhbUU2?=
 =?utf-8?B?TlNQYWJ4WmNuV3M1WmNqbkgxT0tPS1cwOHFJZm8vVS8zaGg4TnRsWXNmQnRq?=
 =?utf-8?B?Z29SK2JZWlc3WDVOQmYwTnIzTjVsSmhIYW9QNHFoNlhkWG9zeHRTSVdMR1FT?=
 =?utf-8?B?MUdkd1M4Nis4ckRTU2F0OVJTVzUvSTF4Sk9wNDNGOU1wYzl1aWlFZDJVSWM3?=
 =?utf-8?B?RXVtaXRnN2gvaHl6Yms1VXNvc0FXQzJ2RURoZmFiQVo5bldKdy90dmYyaGg2?=
 =?utf-8?B?aWlnWlJKUHpzdXVSWkJSbFN3UjhzTnppVUc5ZmozVmdBd21rR1hkTzJVU3FS?=
 =?utf-8?B?OVRieEFoYUR4UEVNWG5qQnZmQzM0SFdSeWZ5SGtlZERtRFNYRjdBZjFzZVdR?=
 =?utf-8?B?QUttYndha0RmT0oyc25jRHpwN2lORkRoSGdjVkMzK0E4cmp0eVBITnNmaFVQ?=
 =?utf-8?B?TmxxVG1DU2grTVVtV0p2dkI3TGt3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 580a4437-cc4a-44ee-3c9f-08de79f73690
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 14:06:21.2082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9oVjcFosInyEXPp3z6CV5dyS50o5dK7S0f62N6hz89UnfEaLBshygQvuQATzFkrA+QGpt+oWgs2aSpPnw4HfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0722
X-Rspamd-Queue-Id: B534A201ACD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17469-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,DU8PR83MB0975.EURPRD83.prod.outlook.com:mid]
X-Rspamd-Action: no action

PiA+ID4gPiBUaGUgdXZlcmJzIENRIGNyZWF0aW9uIFVBUEkgYWxsb3dzIHVzZXJzIHRvIHN1cHBs
eSB0aGVpciBvd24gdW1lbQ0KPiA+ID4gPiBmb3IgYQ0KPiA+ID4gQ1EuDQo+ID4gPiA+IFVwZGF0
ZSBtYW5hIHRvIHN1cHBvcnQgdGhpcyB3b3JrZmxvdyB3aGlsZSBwcmVzZXJ2aW5nIHN1cHBvcnQg
Zm9yDQo+ID4gPiA+IGNyZWF0aW5nIHVtZW0gdGhyb3VnaCB0aGUgbGVnYWN5IGludGVyZmFjZS4N
Cj4gPiA+ID4NCj4gPiA+ID4gVG8gc3VwcG9ydCBSRE1BIG9iamVjdHMgdGhhdCBvd24gdW1lbSwg
ZXh0ZW5kDQo+ID4gPiBtYW5hX2liX2NyZWF0ZV9xdWV1ZSgpDQo+ID4gPiA+IHRvIHJldHVybiB0
aGUgdW1lbSB0byB0aGUgY2FsbGVyIGFuZCBkbyBub3QgYWxsb2NhdGUgdW1lbSBpZiBpdA0KPiA+
ID4gPiB3YXMgYWxsb2N0ZWQgYnkgdGhlIGNhbGxlci4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbWljcm9zb2Z0LmNvbT4NCj4g
PiA+ID4gLS0tDQo+ID4gPiA+IHYyOiBJdCBpcyBhIHJld29yayBvZiB0aGUgcGF0Y2ggcHJvcG9z
ZWQgYnkgTGVvbg0KPiA+ID4NCj4gPiA+IEkgYW0gY3VyaW91cyB0byBrbm93IHdoYXQgY2hhbmdl
cyB3ZXJlIGludHJvZHVjZWQ/DQo+ID4NCj4gPiBJdCBpcyBsaWtlIHlvdXIgcGF0Y2gsIGJ1dCBJ
IGtlcHQgZ2V0X3VtZW0gaW4gbWFuYV9pYl9jcmVhdGVfcXVldWUgYW5kDQo+ID4gaW50cm9kdWNl
ZCBvd25lcnNoaXAuDQo+ID4gSXQgbWFkZSB0aGUgY29kZSBzaW1wbGVyIGFuZCBleHRlbmRhYmxl
LiBJbiB5b3VyIHByb3Bvc2FsLCBpdCB3YXMgaGFyZA0KPiA+IHRvIHRyYWNrIHRoZSBjaGFuZ2Vz
IGFuZCBpdCBsZWQgdG8gZG91YmxlIGZyZWUgb2YgdGhlIHVtZW0uIFdpdGggbmV3DQo+ID4gbWFu
YV9pYl9jcmVhdGVfcXVldWUoKSBpdCBpcyBjbGVhciBmcm9tIHRoZSBjYWxsZXIgd2hhdCBoYXBw
ZW5zIGFuZCBubw0KPiA+IHNwZWNpYWwgY2hhbmdlcyBpbiB0aGUgY2FsbGVyIHJlcXVpcmVkLg0K
PiA+DQo+ID4gPg0KPiA+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvY3EuYyAgICAg
IHwgMTI1ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ID4gPiAgZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvZGV2aWNlLmMgIHwgICAxICsNCj4gPiA+ID4gIGRyaXZlcnMvaW5maW5p
YmFuZC9ody9tYW5hL21haW4uYyAgICB8ICAzMCArKysrKy0tDQo+ID4gPiA+ICBkcml2ZXJzL2lu
ZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmggfCAgIDUgKy0NCj4gPiA+ID4gIGRyaXZlcnMvaW5m
aW5pYmFuZC9ody9tYW5hL3FwLmMgICAgICB8ICAgNSArLQ0KPiA+ID4gPiAgZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvd3EuYyAgICAgIHwgICAzICstDQo+ID4gPiA+ICA2IGZpbGVzIGNoYW5n
ZWQsIDExMSBpbnNlcnRpb25zKCspLCA1OCBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gPiA+ID4gYi9k
cml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9jcS5jIGluZGV4IGIyNzQ5Zjk3MS4uZmE5NTE3MzJh
DQo+ID4gPiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFu
YS9jcS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4g
PiA+ID4gQEAgLTgsMTIgKzgsOCBAQA0KPiA+ID4gPiAgaW50IG1hbmFfaWJfY3JlYXRlX2NxKHN0
cnVjdCBpYl9jcSAqaWJjcSwgY29uc3Qgc3RydWN0DQo+ID4gPiA+IGliX2NxX2luaXRfYXR0cg0K
PiA+ID4gKmF0dHIsDQo+ID4gPiA+ICAJCSAgICAgIHN0cnVjdCB1dmVyYnNfYXR0cl9idW5kbGUg
KmF0dHJzKSAgew0KPiA+ID4gPiAtCXN0cnVjdCBpYl91ZGF0YSAqdWRhdGEgPSAmYXR0cnMtPmRy
aXZlcl91ZGF0YTsNCj4gPiA+ID4gIAlzdHJ1Y3QgbWFuYV9pYl9jcSAqY3EgPSBjb250YWluZXJf
b2YoaWJjcSwgc3RydWN0IG1hbmFfaWJfY3EsIGliY3EpOw0KPiA+ID4gPiAtCXN0cnVjdCBtYW5h
X2liX2NyZWF0ZV9jcV9yZXNwIHJlc3AgPSB7fTsNCj4gPiA+ID4gLQlzdHJ1Y3QgbWFuYV9pYl91
Y29udGV4dCAqbWFuYV91Y29udGV4dDsNCj4gPiA+ID4gIAlzdHJ1Y3QgaWJfZGV2aWNlICppYmRl
diA9IGliY3EtPmRldmljZTsNCj4gPiA+ID4gLQlzdHJ1Y3QgbWFuYV9pYl9jcmVhdGVfY3EgdWNt
ZCA9IHt9Ow0KPiA+ID4gPiAgCXN0cnVjdCBtYW5hX2liX2RldiAqbWRldjsNCj4gPiA+ID4gIAli
b29sIGlzX3JuaWNfY3E7DQo+ID4gPiA+ICAJdTMyIGRvb3JiZWxsOw0KPiA+ID4gPiBAQCAtMjYs
NDggKzIyLDkxIEBAIGludCBtYW5hX2liX2NyZWF0ZV9jcShzdHJ1Y3QgaWJfY3EgKmliY3EsDQo+
ID4gPiA+IGNvbnN0DQo+ID4gPiBzdHJ1Y3QgaWJfY3FfaW5pdF9hdHRyICphdHRyLA0KPiA+ID4g
PiAgCWNxLT5jcV9oYW5kbGUgPSBJTlZBTElEX01BTkFfSEFORExFOw0KPiA+ID4gPiAgCWlzX3Ju
aWNfY3EgPSBtYW5hX2liX2lzX3JuaWMobWRldik7DQo+ID4gPiA+DQo+ID4gPiA+IC0JaWYgKHVk
YXRhKSB7DQo+ID4gPiA+IC0JCWlmICh1ZGF0YS0+aW5sZW4gPCBvZmZzZXRvZihzdHJ1Y3QgbWFu
YV9pYl9jcmVhdGVfY3EsIGZsYWdzKSkNCj4gPiA+ID4gLQkJCXJldHVybiAtRUlOVkFMOw0KPiA+
ID4gPiAtDQo+ID4gPiA+IC0JCWVyciA9IGliX2NvcHlfZnJvbV91ZGF0YSgmdWNtZCwgdWRhdGEs
IG1pbihzaXplb2YodWNtZCksDQo+ID4gPiB1ZGF0YS0+aW5sZW4pKTsNCj4gPiA+ID4gLQkJaWYg
KGVycikgew0KPiA+ID4gPiAtCQkJaWJkZXZfZGJnKGliZGV2LCAiRmFpbGVkIHRvIGNvcHkgZnJv
bSB1ZGF0YSBmb3INCj4gPiA+IGNyZWF0ZSBjcSwgJWRcbiIsIGVycik7DQo+ID4gPiA+IC0JCQly
ZXR1cm4gZXJyOw0KPiA+ID4gPiAtCQl9DQo+ID4gPiA+ICsJaWYgKGF0dHItPmNxZSA+IFUzMl9N
QVggLyBDT01QX0VOVFJZX1NJWkUgLyAyICsgMSkNCj4gPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gPg0KPiA+ID4gV2UgYXJlIHRhbGtpbmcgYWJvdXQga2VybmVsIHZlcmJzLiBVTFBzIGFy
ZSBub3QgZGVzaWduZWQgdG8gcHJvdmlkZQ0KPiA+ID4gYXR0cmlidXRlcyBhbmQgcmVjb3ZlciBm
cm9tIHJhbmRvbSBkcml2ZXIgbGltaXRhdGlvbnMuDQo+ID4NCj4gPiBJIHVuZGVyc3RhbmQsIGJ1
dCB0aGVyZSB3YXMgYW4gYXNrIGJlZm9yZSB0byBhZGQgdGhhdCBjaGVjayBhcyBzb21lDQo+ID4g
YXV0b21hdGVkIGNvZGUgdmVyaWZpZXIgZGV0ZWN0ZWQgb3ZlcmZsb3cuIFNvIGlmIHdlIHJlbW90
ZSBpdCwgSSBndWVzcw0KPiA+IHdlIGdldCBhZ2FpbiBhbiBhc2sgdG8gZml4IHRoZSBwb3RlbnRp
YWwgb3ZlcmZsb3cuDQo+ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IC0JCWlmICgoIWlzX3Ju
aWNfY3EgJiYgYXR0ci0+Y3FlID4gbWRldi0NCj4gPiA+ID5hZGFwdGVyX2NhcHMubWF4X3FwX3dy
KSB8fA0KPiA+ID4gPiAtCQkgICAgYXR0ci0+Y3FlID4gVTMyX01BWCAvIENPTVBfRU5UUllfU0la
RSkgew0KPiA+ID4gPiAtCQkJaWJkZXZfZGJnKGliZGV2LCAiQ1FFICVkIGV4Y2VlZGluZyBsaW1p
dFxuIiwgYXR0ci0NCj4gPiA+ID5jcWUpOw0KPiA+ID4gPiAtCQkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gPiA+IC0JCX0NCj4gPiA+ID4gKwlidWZfc2l6ZSA9IE1BTkFfUEFHRV9BTElHTihyb3VuZHVw
X3Bvd19vZl90d28oYXR0ci0+Y3FlICoNCj4gPiA+IENPTVBfRU5UUllfU0laRSkpOw0KPiA+ID4g
PiArCWNxLT5jcWUgPSBidWZfc2l6ZSAvIENPTVBfRU5UUllfU0laRTsNCj4gPiA+ID4gKwllcnIg
PSBtYW5hX2liX2NyZWF0ZV9rZXJuZWxfcXVldWUobWRldiwgYnVmX3NpemUsIEdETUFfQ1EsDQo+
ID4gPiAmY3EtPnF1ZXVlKTsNCj4gPiA+ID4gKwlpZiAoZXJyKSB7DQo+ID4gPiA+ICsJCWliZGV2
X2RiZyhpYmRldiwgIkZhaWxlZCB0byBjcmVhdGUga2VybmVsIHF1ZXVlIGZvciBjcmVhdGUgY3Es
DQo+ID4gPiAlZFxuIiwgZXJyKTsNCj4gPiA+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiA+ID4gKwl9
DQo+ID4gPiA+ICsJZG9vcmJlbGwgPSBtZGV2LT5nZG1hX2Rldi0+ZG9vcmJlbGw7DQo+ID4gPiA+
DQo+ID4gPiA+IC0JCWNxLT5jcWUgPSBhdHRyLT5jcWU7DQo+ID4gPiA+IC0JCWVyciA9IG1hbmFf
aWJfY3JlYXRlX3F1ZXVlKG1kZXYsIHVjbWQuYnVmX2FkZHIsIGNxLT5jcWUNCj4gPiA+ICogQ09N
UF9FTlRSWV9TSVpFLA0KPiA+ID4gPiAtCQkJCQkgICAmY3EtPnF1ZXVlKTsNCj4gPiA+ID4gKwlp
ZiAoaXNfcm5pY19jcSkgew0KPiA+ID4gPiArCQllcnIgPSBtYW5hX2liX2dkX2NyZWF0ZV9jcSht
ZGV2LCBjcSwgZG9vcmJlbGwpOw0KPiA+ID4gPiAgCQlpZiAoZXJyKSB7DQo+ID4gPiA+IC0JCQlp
YmRldl9kYmcoaWJkZXYsICJGYWlsZWQgdG8gY3JlYXRlIHF1ZXVlIGZvciBjcmVhdGUNCj4gPiA+
IGNxLCAlZFxuIiwgZXJyKTsNCj4gPiA+ID4gLQkJCXJldHVybiBlcnI7DQo+ID4gPiA+ICsJCQlp
YmRldl9kYmcoaWJkZXYsICJGYWlsZWQgdG8gY3JlYXRlIFJOSUMgY3EsICVkXG4iLA0KPiA+ID4g
ZXJyKTsNCj4gPiA+ID4gKwkJCWdvdG8gZXJyX2Rlc3Ryb3lfcXVldWU7DQo+ID4gPiA+ICAJCX0N
Cj4gPiA+ID4NCj4gPiA+ID4gLQkJbWFuYV91Y29udGV4dCA9IHJkbWFfdWRhdGFfdG9fZHJ2X2Nv
bnRleHQodWRhdGEsIHN0cnVjdA0KPiA+ID4gbWFuYV9pYl91Y29udGV4dCwNCj4gPiA+ID4gLQkJ
CQkJCQkgIGlidWNvbnRleHQpOw0KPiA+ID4gPiAtCQlkb29yYmVsbCA9IG1hbmFfdWNvbnRleHQt
PmRvb3JiZWxsOw0KPiA+ID4gPiAtCX0gZWxzZSB7DQo+ID4gPiA+IC0JCWlmIChhdHRyLT5jcWUg
PiBVMzJfTUFYIC8gQ09NUF9FTlRSWV9TSVpFIC8gMiArIDEpIHsNCj4gPiA+ID4gLQkJCWliZGV2
X2RiZyhpYmRldiwgIkNRRSAlZCBleGNlZWRpbmcgbGltaXRcbiIsIGF0dHItDQo+ID4gPiA+Y3Fl
KTsNCj4gPiA+ID4gLQkJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiAtCQl9DQo+ID4gPiA+IC0J
CWJ1Zl9zaXplID0gTUFOQV9QQUdFX0FMSUdOKHJvdW5kdXBfcG93X29mX3R3byhhdHRyLQ0KPiA+
ID4gPmNxZSAqIENPTVBfRU5UUllfU0laRSkpOw0KPiA+ID4gPiAtCQljcS0+Y3FlID0gYnVmX3Np
emUgLyBDT01QX0VOVFJZX1NJWkU7DQo+ID4gPiA+IC0JCWVyciA9IG1hbmFfaWJfY3JlYXRlX2tl
cm5lbF9xdWV1ZShtZGV2LCBidWZfc2l6ZSwNCj4gPiA+IEdETUFfQ1EsICZjcS0+cXVldWUpOw0K
PiA+ID4gPiArCQllcnIgPSBtYW5hX2liX2luc3RhbGxfY3FfY2IobWRldiwgY3EpOw0KPiA+ID4g
PiAgCQlpZiAoZXJyKSB7DQo+ID4gPiA+IC0JCQlpYmRldl9kYmcoaWJkZXYsICJGYWlsZWQgdG8g
Y3JlYXRlIGtlcm5lbCBxdWV1ZSBmb3INCj4gPiA+IGNyZWF0ZSBjcSwgJWRcbiIsIGVycik7DQo+
ID4gPiA+IC0JCQlyZXR1cm4gZXJyOw0KPiA+ID4gPiArCQkJaWJkZXZfZGJnKGliZGV2LCAiRmFp
bGVkIHRvIGluc3RhbGwgY3EgY2FsbGJhY2ssICVkXG4iLA0KPiA+ID4gZXJyKTsNCj4gPiA+ID4g
KwkJCWdvdG8gZXJyX2Rlc3Ryb3lfcm5pY19jcTsNCj4gPiA+ID4gIAkJfQ0KPiA+ID4gPiAtCQlk
b29yYmVsbCA9IG1kZXYtPmdkbWFfZGV2LT5kb29yYmVsbDsNCj4gPiA+ID4gIAl9DQo+ID4gPiA+
DQo+ID4gPiA+ICsJc3Bpbl9sb2NrX2luaXQoJmNxLT5jcV9sb2NrKTsNCj4gPiA+ID4gKwlJTklU
X0xJU1RfSEVBRCgmY3EtPmxpc3Rfc2VuZF9xcCk7DQo+ID4gPiA+ICsJSU5JVF9MSVNUX0hFQUQo
JmNxLT5saXN0X3JlY3ZfcXApOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0dXJuIDA7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gK2Vycl9kZXN0cm95X3JuaWNfY3E6DQo+ID4gPiA+ICsJbWFuYV9pYl9n
ZF9kZXN0cm95X2NxKG1kZXYsIGNxKTsNCj4gPiA+ID4gK2Vycl9kZXN0cm95X3F1ZXVlOg0KPiA+
ID4gPiArCW1hbmFfaWJfZGVzdHJveV9xdWV1ZShtZGV2LCAmY3EtPnF1ZXVlKTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArCXJldHVybiBlcnI7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4g
K2ludCBtYW5hX2liX2NyZWF0ZV91c2VyX2NxKHN0cnVjdCBpYl9jcSAqaWJjcSwgY29uc3Qgc3Ry
dWN0DQo+ID4gPiBpYl9jcV9pbml0X2F0dHIgKmF0dHIsDQo+ID4gPiA+ICsJCQkgICBzdHJ1Y3Qg
dXZlcmJzX2F0dHJfYnVuZGxlICphdHRycykgew0KPiA+ID4gPiArCXN0cnVjdCBtYW5hX2liX2Nx
ICpjcSA9IGNvbnRhaW5lcl9vZihpYmNxLCBzdHJ1Y3QgbWFuYV9pYl9jcSwgaWJjcSk7DQo+ID4g
PiA+ICsJc3RydWN0IGliX3VkYXRhICp1ZGF0YSA9ICZhdHRycy0+ZHJpdmVyX3VkYXRhOw0KPiA+
ID4gPiArCXN0cnVjdCBtYW5hX2liX2NyZWF0ZV9jcV9yZXNwIHJlc3AgPSB7fTsNCj4gPiA+ID4g
KwlzdHJ1Y3QgbWFuYV9pYl91Y29udGV4dCAqbWFuYV91Y29udGV4dDsNCj4gPiA+ID4gKwlzdHJ1
Y3QgaWJfZGV2aWNlICppYmRldiA9IGliY3EtPmRldmljZTsNCj4gPiA+ID4gKwlzdHJ1Y3QgbWFu
YV9pYl9jcmVhdGVfY3EgdWNtZCA9IHt9Ow0KPiA+ID4gPiArCXN0cnVjdCBtYW5hX2liX2RldiAq
bWRldjsNCj4gPiA+ID4gKwlib29sIGlzX3JuaWNfY3E7DQo+ID4gPiA+ICsJdTMyIGRvb3JiZWxs
Ow0KPiA+ID4gPiArCWludCBlcnI7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwltZGV2ID0gY29udGFp
bmVyX29mKGliZGV2LCBzdHJ1Y3QgbWFuYV9pYl9kZXYsIGliX2Rldik7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKwljcS0+Y29tcF92ZWN0b3IgPSBhdHRyLT5jb21wX3ZlY3RvciAlIGliZGV2LT5udW1f
Y29tcF92ZWN0b3JzOw0KPiA+ID4gPiArCWNxLT5jcV9oYW5kbGUgPSBJTlZBTElEX01BTkFfSEFO
RExFOw0KPiA+ID4gPiArCWlzX3JuaWNfY3EgPSBtYW5hX2liX2lzX3JuaWMobWRldik7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKwlpZiAodWRhdGEtPmlubGVuIDwgb2Zmc2V0b2Yoc3RydWN0IG1hbmFf
aWJfY3JlYXRlX2NxLCBmbGFncykpDQo+ID4gPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4g
PiArDQo+ID4gPiA+ICsJZXJyID0gaWJfY29weV9mcm9tX3VkYXRhKCZ1Y21kLCB1ZGF0YSwgbWlu
KHNpemVvZih1Y21kKSwgdWRhdGEtDQo+ID4gPiA+aW5sZW4pKTsNCj4gPiA+ID4gKwlpZiAoZXJy
KSB7DQo+ID4gPiA+ICsJCWliZGV2X2RiZyhpYmRldiwgIkZhaWxlZCB0byBjb3B5IGZyb20gdWRh
dGEgZm9yIGNyZWF0ZSBjcSwNCj4gPiA+ICVkXG4iLCBlcnIpOw0KPiA+ID4gPiArCQlyZXR1cm4g
ZXJyOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmICgoIWlzX3JuaWNfY3Eg
JiYgYXR0ci0+Y3FlID4gbWRldi0+YWRhcHRlcl9jYXBzLm1heF9xcF93cikgfHwNCj4gPiA+ID4g
KwkgICAgYXR0ci0+Y3FlID4gVTMyX01BWCAvIENPTVBfRU5UUllfU0laRSkNCj4gPiA+ID4gKwkJ
cmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwljcS0+Y3FlID0gYXR0ci0+Y3Fl
Ow0KPiA+ID4gPiArCWVyciA9IG1hbmFfaWJfY3JlYXRlX3F1ZXVlKG1kZXYsIHVjbWQuYnVmX2Fk
ZHIsIGNxLT5jcWUgKg0KPiA+ID4gQ09NUF9FTlRSWV9TSVpFLA0KPiA+ID4gPiArCQkJCSAgICZj
cS0+cXVldWUsICZpYmNxLT51bWVtKTsNCj4gDQo+IEkganVzdCByZWFsaXplZCB0aGF0IEkgZm9y
Z290IHRvIGhhbmRsZSB0aGUgY2FzZSB3aGVuIGliY3EtPnVtZW0gPT0gTlVMTCBhbmQNCj4gbWFu
YSBmYWlscyBsYXRlciBhZnRlciB0aGlzIGNhbGwuIEkgbmVlZCB0byBjbGVhbiBpYmNxLT51bWVt
IGluIHRoaXMgY2FzZS4NCj4gSSB3aWxsIGFkZHJlc3MgdGhhdCBpbiB2My4gSSBhbSBzb3JyeS4N
Cj4gDQoNCkhpIExlb24sDQpBZnRlciByZS1yZWFkaW5nIHRoZSBjb2RlLCBJIHNlZSB0aGF0IHRo
ZXJlIGlzIG5vIGJ1ZyBpbiB2MiBhcyB0aGUgdW1lbSBnZXRzIGRlYWxsb2NhdGVkDQpvbiBmYWls
dXJlIGluc2lkZSB0aGUgaGFuZGxlciBvZiBVVkVSQlNfTUVUSE9EX0NRX0NSRUFURS4gSSBhbHNv
IHNlZSB0aGF0IHlvdSBhbHNvIGhhZA0KdGhlIHNhbWUgbG9naWMgaW4gdjEuIFNvLCB3aGF0IGlz
IHlvdXIgcmVjb21tZW5kYXRpb24/IExlYXZlIHYyIGxvZ2ljIGFzIGlzLCBzbyBtYW5hIHdvdWxk
DQppbW1lZGlhdGVseSBnaXZlIG93bmVyc2hpcCBvZiB1bWVtIHRvIGNxLT51bWVtLCBhbmQgaWYg
bWFuYV9pYl9jcmVhdGVfdXNlcl9jcSgpIGZhaWxzIGF0IGxhdGVyIHN0YWdlDQppdCBzaG91bGQg
bm90IGNsZWFuIGNxLT51bWVtIGFuZCBsZWF2ZSBpdCB0byB0aGUgY2FsbGVyIGhhbmRsZSAoaS5l
LiwgVVZFUkJTX01FVEhPRF9DUV9DUkVBVEUpDQp0byBjbGVhbiBjcS0+dW1lbSByZWdhcmRsZXNz
IG9mIHdobyBjcmVhdGVkIGl0Lg0KDQpPciBzaG91bGQgSSBtYWtlIHYzLCB3aGVyZSBJIHdpbGwg
YXNzaWduIHVtZW0gdG8gY3EtPnVtZW0gcmlnaHQgYmVmb3JlIHJldHVybiAwLCBzbyB0aGF0IGlm
DQptYW5hX2liX2NyZWF0ZV91c2VyX2NxKCkgZmFpbHMgaXQgZG9lcyBub3QgY2hhbmdlIGNxLT51
bWVtIGF0IGFsbC4NCg0KPiAtIEtvbnN0YW50aW4NCj4gDQoNCg0K

