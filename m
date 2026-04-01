Return-Path: <linux-rdma+bounces-18900-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDHXDr8YzWnOaAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18900-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 15:08:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AFA37AF44
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 15:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB6393011A67
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCA4402449;
	Wed,  1 Apr 2026 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YI0T8LFK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023084.outbound.protection.outlook.com [52.101.83.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B872E2850;
	Wed,  1 Apr 2026 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048454; cv=fail; b=gi0Vaaf1SucEoZK2Lf0BAgUZbR1F/W7dvMmSDssostQUkgwIyl3Rmdl0WasHBUpg6DvSmZouD8gOAkkdJlYsKCCl2sHr7eeVf/gD69b8IpxHGpp/4ZcRHJ1ub4xf+yEgtRUN5klv/mWXnVxlB8Wioorcv3Wsi9Ep2AmXbH9qJOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048454; c=relaxed/simple;
	bh=KbabQ6fYUAX7V/Owq+wVNCSfVurWX7lfIWKWAnAqHhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jYnR2yplwNoUccM0RfLdoq1zGIzhourEAKNH5DtXxoWmaFjmjLtUmAwGu9BzMHsoJerXQ9Df7xPLWOSuDs7JRARz+yNBU7jjit2dG+cCbQgak8SxPIeyZ5UGwO1smjIBLaFVmxkotden+ilrBDV/NqZRj47mgvPIyga4tWsWpBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YI0T8LFK; arc=fail smtp.client-ip=52.101.83.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HG7l9YLmFs/nzU2tXua01Gv65KFzy4UH2I62genfCsETLF8hghnHpFgvm+p2wPfc4czdH6GWvOH101X86OhDcqPKyQMNKKyLq+Ctz5lILDZPrtujnZIePb6UHJJbOspEXwyCTsuvnXXFHXSxa3vsBkyjOfmujt+6PNrY/MzrCEriI1sDiHKejpEgL2/t7e3CVWmPCK+tQyfk0faAjMYhPtHSPrDp2LeaQgMsX4a5xx8P7Vo2ElQ5J7i2s35eLY3isp3uWWxOURDdsYIF3KSuax/Yrf+9fJDCRRSrtL9f5FPxLeXUdzIJDWJTomVP8ojvABJVGy4YN71G/QrrRulJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbabQ6fYUAX7V/Owq+wVNCSfVurWX7lfIWKWAnAqHhk=;
 b=Fo25ja2ySs7jYCEJZ21Pvq6/so8YXRhhjd5M+FE9GsFIDz4g/EZF2R5xVldyDUb6wV9jb/hsPw6raQWz42xp/uEgRzpgqQ7t9hmgSySXE6AsfoP50xdr47fBPwyPZ6pbbRrhJIU2eWJAImAmMIU4m7PrWtJenR4rHczipD77xPRxGrC9bbxSZgrpR5RWMgVQRG95WCa83BtbN13GYMPaGg1pAzSXcuzDKdXNe8Wt6czXyn9GBIdGExH+Eb+hol6Z6pE3NRvsDaylocOLDkoeRLPYiJc5+//hUcunA7pKTWY7C3FxBeYIwv0hZHGOnInkzxKSH74TZa2H5TGMp8AgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbabQ6fYUAX7V/Owq+wVNCSfVurWX7lfIWKWAnAqHhk=;
 b=YI0T8LFKfhwV3fOJc+JtJvbG5XOO6dLUd2C1FSM3ZnVr7XTk3sZygduweKjrYfWJQF7I/RxPKnYN8Rn2tVPa9WCPK909KlzHIDvVId8sgZ2HdH1VSQnHlBE+BxmSY8Bl2lhjSJDlEqty0kjQSZFNNtTUMmk+OkYzOyhEz1K8VeI=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by FRWPR83MB0866.EURPRD83.prod.outlook.com (2603:10a6:d10:174::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 13:00:48 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 13:00:47 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Shiraz Saleem <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v3 1/1] RDMA/mana_ib: memory
 windows
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v3 1/1] RDMA/mana_ib: memory
 windows
Thread-Index: AQHcwO4CiO3SPJS22E2zl6oCib9TErXIqiAAgAGAsTA=
Date: Wed, 1 Apr 2026 13:00:47 +0000
Message-ID:
 <DU8PR83MB09755ED493DFC68AE5E2533DB450A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260331090851.2276205-1-kotaranov@linux.microsoft.com>
 <20260331135512.GG814676@unreal>
In-Reply-To: <20260331135512.GG814676@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ebdc035a-eace-4654-a0be-4e7aa2ffc369;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-01T12:52:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|FRWPR83MB0866:EE_
x-ms-office365-filtering-correlation-id: 9a33684a-3147-4eb0-bc63-08de8feeb19d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 o4/2d6Me9eLLk552v3y/ghnBZZMuvZexE/GkUbsfZckNqooLDvyaXFRhuiDjVSGJLHeDy5YnpgBaJa3UuzQOAVlDr9mlvYBpASOO6VmmqDtFK0KG9xfa+4L3hJSxm6fW4JS5PpDjmkhJEqQYHmZ0HYw8CPhsOIDW7VjVIwni4uVLJX2PQkOhctlTqL59QyS2U0VBTJbD1OL4tpifjSf6uMqCi6Sk4y3Lu/9gNDnCSbWXBDG2zAmmurFDrZa2++Vgk0K0HtDRH2cEZfu1/9XdVCgF+HAI1ZiB09uq47llFgGj8GcmCVaoKHeJ/54MyzfSo44sNUfprXZgpWJegxa9xdDvQ616ndnNPLV5fjCCRKuIC/ceiEcHounE74svwtQlb/a+uPZkFa6VVNVQlkRmoJW1lds04FZjKnPKHJr01+/x+25Qkd5k7bP1pnvQq1WJn9shU8Ke61KtXsTvvttKfArY6hLiRsBOd1iqTqcjO6C1p3uHc7+7qhTPtnY9JQfItmhmMKGk1ASB0XmoA5rq84QMG35nb3NHzL2mPkxblgl583+cVPYECyo7c+uoASULRhJKcItFc5ycPvir/LekAc0Hqwm15vO72GHfgJSJGUvm6jAn0vql/GsUfCJAjnM0HwV3S7+h1/VqO+FitLmoSXIMap3BwoHCBoPZqaFp9Wu1uHd5jKCervNKGm9CdWGlYjoBVcwOeZCMMxsNfdoldym8vKvkzD6JXhY2IT7AejjKilAiTuQ1osHSK3GDt6zUoAfvto81TDUToVUvW3JeuYi5uusAG+rHPRiyevba5so=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFJtUU1jVjhJbnNja2dMTDdWRGo0QTkzeEJQTFNrVkJibDcxSUdudndmdjhm?=
 =?utf-8?B?Sm9YT2tiQjYzS1FEaElzVGFHaXNnaHFYQ3hzVHNkWDRidEtHUldEZmpHOUNS?=
 =?utf-8?B?ckpXUkMrZXFJb3haRFZNUTN6VWNkUUxQemFRVVBpUTBLSVlzQ2MwMGMyTWs5?=
 =?utf-8?B?d2NMSkpBRkJpdmNIajJGbmd4ZS9LUFRXYjByL2tPMmNBSEJ3WHIyNDNralNt?=
 =?utf-8?B?Wkx5ZlJWSGZhQUswRlFOaytBMzNBQ2lsK0xJVEhZZVRPekdUQUNMRGZic21C?=
 =?utf-8?B?NlFGc2M3aWs2OVFqaXlFY1hWb2VFYjFlaWFRWTNUTEY4RFlXRHRJWFRvTDFv?=
 =?utf-8?B?TVl6RGkrT1pKcnA0cXYxRytlY2diT05QRFJEM3JyMDQyOURDaWI3SlZYdWNi?=
 =?utf-8?B?MjlmNUJ3MWdDUWs3VzNLbFU1YzJSWDF0QjVvaVc2eHJTQnlXZFdMcFBFWlZI?=
 =?utf-8?B?dGhRL2ZPelhMbG5wZDBrT0JJUVVtazgyWXRGRHpyUVUvU0pjTGE3NS9FRytv?=
 =?utf-8?B?bFMyNGIzbGw3LzNaUGwyZEhWUzJQakNWMFJkV2lVZmJiY2JLcDgvbllCUElB?=
 =?utf-8?B?aWtqNVpBSUIvV2txOC9LeHZuUU4zNDBFSVBiNVZLNUR4K2NaUzI2Q2pTeHVY?=
 =?utf-8?B?emxnakg0TEE4UXMyS2hRYTl3Z0Q2aE9CSmh2V1dwTENhTzBhdlhtU2c2bEZ1?=
 =?utf-8?B?WlNUNnJ2Z2RxLzlDczczRXVGQXpjUjVqQVFPYXh6NFpBWm9UdFcrN1BoUlQ2?=
 =?utf-8?B?NXBnN3diSTIzRzZZdkhWa3V5NlQvYnh2M2RuRklzL05SZGVzN0htbmVOT2V2?=
 =?utf-8?B?dHFlbDhsVGFjaXkrbEtpRFJ0TFVRQis4SVFxa1BteTlrU2p5QUtuOW0rT1ZT?=
 =?utf-8?B?eGg2ZVlzOFRjeVkzUEU3NjA3S1JaSFdJSUtLZ0ZadnNUV1cwc2JPbFptRlp0?=
 =?utf-8?B?SzBsakpRYXBtNkdkRHpuRXh5ZHRYVmVpYXZsaVIzcytvTlZSWm5VWERwem1o?=
 =?utf-8?B?dlpVOWVPQ25jbTJhL01ua1hPN2tLd3FZRjQrSkI0TDZxOVJ4bjFHK3ptY05n?=
 =?utf-8?B?VWJ4ZnpKaUY5YzZoZXJQZWI2QldsR0tyaUJXQ0YyQzhLYmI0N0NXdm0vaEVG?=
 =?utf-8?B?TTc2SzRtOUhZUTUzM1NPZmduUGR0SVBFMzYyWjV1c3NZQ3dsMlQzMVBTTHQ1?=
 =?utf-8?B?UkFrc2p0c1VHaXIrWFF2elRpTU82b1M0TWF0YXVzQjBFT0wwN2E0ZXhEU2tw?=
 =?utf-8?B?UFhCNUs3VWRWM2hTd0dXWW5UTnJ3bnJvZ29oRURyazMwR01NM2IzZVFaVVJG?=
 =?utf-8?B?V1MvbGxSVWlTWXZzd3ZFK3RncEVUZEVEZDYxUjdIVjAyVE9xZTdtcUFleTdj?=
 =?utf-8?B?Z084K21KK3RyRjhKZDBaSStwR0NJWG1FNUtmeFRLWUp1N3hhNzdnVXBmdmVh?=
 =?utf-8?B?UnJvYkNzUjRlMk11bDBxazdvcWlXUTUxM3JFZHdkVG5WWkd3UVdXUHdpZFg5?=
 =?utf-8?B?b2NwTEdOakRwMU4rRTArSGhJeVBOSUU0NHFKdWNSR0tJZEg4R2owdEkxT0hy?=
 =?utf-8?B?UTJpc0MyUi9BdGhJbVdpZW55WDdjSVhNdExaam4yRFo0RkluWnVOb2RLTk0r?=
 =?utf-8?B?M21UQndGYjQ2cGVRVmZlZlBVRzMxdkp0M2QrUWpiOFc0NWtXRG1YcDF6Y0lO?=
 =?utf-8?B?cHRjTTJvTmxtd1NyUmUvTWFienJGU3B0Wk0xVnNjY3I2MHEzQlNZTWVKYVdt?=
 =?utf-8?B?ejd4RHMrSlFTZWJ0d2Faano1ck1IT1c4M2VtN0VDTFNqRDgwVUxlL0RoOTBq?=
 =?utf-8?B?MHlBS284aHA5OGtaRTVHc3Y1Vk5Cb281LzVuZnlEVzN4R2t3Nm1qNXR4Zllt?=
 =?utf-8?B?RU5KdlBRVnRCNFhuWHRnaDZEaFFGZ3VOV3V2bnF3ZTRVanlpemhkREgwVkNF?=
 =?utf-8?B?eDRQM0JkQU9paVhDNGg4VDQ1QkFuRUd3MUJoaUhkT1NrN01OUDk4bFhRRnBk?=
 =?utf-8?B?aEZDTjFPUTZRRUJPNUEzcDRtUjVvUnNFbEFGaGRqbjFnK25nODFGL1JjWmtL?=
 =?utf-8?B?K2dWVWx4MWhtdEJEdDZsTEl5TllodlQraExSN0paTnFGQUttdk5vVFQrMDNE?=
 =?utf-8?B?N2tiZXRpWm5mbDN0YTZrWW5RSytWeSttK2dtc0QwWmJZalR2MzFIczhnWXRj?=
 =?utf-8?B?Y1MxQldMQk9sMWs4d0UzQzdUQ0tsVm5xWm16Z3UwSCtrQ3FWZ2NNRnI1ZUts?=
 =?utf-8?B?V3M0ajJDYytjcjkvQ3lTd0pORkZnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a33684a-3147-4eb0-bc63-08de8feeb19d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:00:47.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MO8d0hS6kIHVnAzUo3wiChuvppnqnmx30I8GKHmn72yAfsT+v6Qc4dPst4nZXKLAX9V2xARQJHTLBq215o2NzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR83MB0866
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18900-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0AFA37AF44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBUdWUsIE1hciAzMSwgMjAyNiBhdCAwMjowODo1MUFNIC0wNzAwLCBLb25zdGFudGluIFRh
cmFub3Ygd3JvdGU6DQo+ID4gRnJvbTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbWlj
cm9zb2Z0LmNvbT4NCj4gPg0KPiA+IEltcGxlbWVudCAuYWxsb2NfbXcoKSBhbmQgLmRlYWxsb2Nf
bXcoKSBmb3IgbWFuYSBkZXZpY2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLb25zdGFudGlu
IFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBMb25n
IExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiB2MzogVXNlIHYyIHJlcXVl
c3QNCj4gPiB2MjogZml4ZWQgY29tbWVudHMuIENsZWFuZWQgdXAgdGhlIHVzZSBvZiBtYW5hX2dk
X3NlbmRfcmVxdWVzdCgpDQo+ID4gZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNlLmMg
IHwgIDMgKysNCj4gPiBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmggfCAgOCAr
KysrKw0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tci5jICAgICAgfCA1NA0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGluY2x1ZGUvbmV0L21hbmEvZ2RtYS5o
ICAgICAgICAgICAgICB8ICA1ICsrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IEhvdyBkaWQgeW91IHRlc3QgdGhpcyBwYXRjaD8g
SG93IGNhbiBhcHBsaWNhdGlvbnMga25vdyB0aGF0IGFsbG9jX213IGlzDQo+IHN1cHBvcnRlZCBu
b3cgaWYgeW91IGRpZG4ndCBzZXQgSUJfREVWSUNFX01FTV9XSU5ET1cgYW5kIHByb3BzLQ0KPiA+
bWF4X213Pw0KDQpPdXIgbWFuYSBIVyBzdXBwb3J0cyBNV3MgYW5kIEkgdGVzdGVkIGFnYWluc3Qg
aXQuIFRoYXQgVjEgYW5kIFYyIGhlbHBzIHRoZSBIVyBjb3JyZWN0bHkNCmRldGVjdCByZXF1ZXN0
IHN0cnVjdCBzaXplIGFuZCBmb3IgTVdzIGl0IGRvZXMgbm90IG1hdHRlciBhcyBpdHMgZmllbGRz
IGZpdCBpbnRvIHYxIHNpemUuDQpUaGUgYXBwbGljYXRpb24gY2FuIGp1c3QgdHJ5IHRvIGNyZWF0
ZSBhbiBNVyBhbmQgc2VlIGlmIGl0IHdvcmtzLg0KcHJvcC0+bWF4X213IHdpbGwgYmUgdGhlIHNh
bWUgYXMgbWF4X21yLCBzaW5jZSB0aGV5IGFyZSBtb2RlbGxlZCBzaW1pbGFybHkgaW4gdGhlIEhX
Lg0KSUJfREVWSUNFX01FTV9XSU5ET1cgaXMgYW4gaW5mb3JtYXRpdmUgYW5kIG5vdCBlbmZvcmNl
ZCwgc28gbm90aGluZyBwcmV2ZW50cyB0byB0ZXN0IGl0Lg0KDQpNeSBwbGFuIHdhcyB0byB1cHN0
cmVhbSBNV3MsIFVDLCBSQyBzdXBwb3J0IG9mIE1XLCBhbmQgdGhlbiB1cHN0cmVhbSBhIHBhdGNo
IHRoYXQNCmNvcnJlY3RseSBpbmRpY2F0ZXMgdGhhdCBpdCBpcyBhbGwgYXZhaWxhYmxlLiBBcyBu
b3cgZXZlbiBpZiB3ZSByZXBvcnQgTVcgY2FwcywgdGhlcmUgaXMgbm8gUVBzIHRoYXQNCmNhbiB0
YWtlIGFkdmFudGFnZSBvZiBpdC4gSW4gTUFOQSwgV1FFcyB0aGF0IHBlcmZvcm0gbWVtb3J5IG9w
ZXJhdGlvbnMgc2hvdWxkIGJlIHN1Ym1pdHRlZCB0bw0Kc3BlY2lhbCBxdWV1ZSwgd2hpY2ggaXMg
ZGlmZmVyZW50IGZyb20gdGhlIHNlbmQgcXVldWUuIFNvIFVDIHBhdGNoIGluY2x1ZGVzIHRoZSBz
cGVjaWFsIHF1ZXVlLA0KYW5kIGFuIFJDIHBhdGNoIHdpbGwgZXhwb3NlIGFuIGV4dHJhIHF1ZXVl
Lg0KDQpJZiB5b3Ugc2F5LCBJIG11c3QgYWRkIHRoYXQgY2FwcyBub3csIEkgY2FuIHNlbmQgdjQg
d2l0aCB0aGUgbWF4X213IGFuZCBJQl9ERVZJQ0VfTUVNX1dJTkRPVy4NCg0KVGhhbmtzDQoNCj4g
DQo+IFRoYW5rcw0K

