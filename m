Return-Path: <linux-rdma+bounces-994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83FC84FE1D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 22:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC53B1C22511
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 21:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA58015AF1;
	Fri,  9 Feb 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NvxbOE6X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2118.outbound.protection.outlook.com [40.107.8.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C851862D;
	Fri,  9 Feb 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512697; cv=fail; b=OH2DwgfGLfQ3sYut0VYhfWAiIepc4ruJ5DFPmlTF1OkbEQUg2G/u9aC6+Rm7abnbQVoai6PByt+B3/T2qOFnI9ESokQpdZ/dD7RF0ihfBfpWe5rojxsKAQTP4InTThIYoZBylUHjF1hgioR5cz/NemVPaRakYPIHdqD8d8MIghc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512697; c=relaxed/simple;
	bh=DTZ+urvuEPV/xPswy/3lcW/2iDi1erXq9Put+pOpLe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SeQM8IdWNZa0iom/voxOxj/isTMKB6YneKZOL8XF48cbibOHXPfuKnKjD9Jr8TNnqvb/RUBjwRml302mZmt57bS4+2bUOeBk8W16pn9S2fTr568poBBEfm1kTulY+gHXuo+tCVAJED8PkC4Dyw4l0h4+k1h20GVcHMWtWIhhTiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NvxbOE6X; arc=fail smtp.client-ip=40.107.8.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieFqk6WvzXaUNwyyTNfDHO6G8LZfZMqhfukU3bHLWGMLsCBI5RXhKRTl4/53qoBV51aypYaK1XO3eozSMI8YLnKD4Q9jUITXwEcdS5vXbTQwdNgSck7xIBY8fmubhom27v+WSXK3ydcxWttmENPjKQfvJIrUtAHE9YEGS5smI2MgVcSs7t9v0vVzxOQdOT6lILC9lb2YUmSV1m6bSgcExX1q3aIHBSCv9rcg0K82EH4wiPtOszwFX3sBvXeLpm6yxLpzxMBXb2G/Wq1WtJlE+KdaaUaXOSoqxF82OgNWcgrVgWrJOOQZ9tFql6d04EIHSK9v5LyNrRAqLxPCR0fdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTZ+urvuEPV/xPswy/3lcW/2iDi1erXq9Put+pOpLe8=;
 b=DmyDfKRYmbg/ZJLlmMPhAksQQTjPODRXDOZZfNf01c60kai7tjrhCnEzCjM5yxzA9EEYc6lgkw884NBM9jbdwtDXnVmgin4tTNN3dvvbwcEMd9vH+FoCzz0Z7h3kOcVKe4ippqZPcd542NaaKo2hITLZkOGJaMRpuZdEX8IoSBtZqtPoWLqyOgUJa3JNrITct9JzgB7BJ3qSdvvEzAsXK+kLR4Rr8s6+as7iqxAjGbX4GjzLjdWO4Rcw1shdnA+w94iecQEMyEY7kaPXXaxe9456izBdpPUV4qwtEQ1KoncPghWwFzxPYuC7ayIlGk/Lw1P+SUb9aQmiVG5VHOwhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTZ+urvuEPV/xPswy/3lcW/2iDi1erXq9Put+pOpLe8=;
 b=NvxbOE6X5cQg6dOp8FZC1Zkr5gAtNmdK/LJLUmPb97mKqIOcP+Cm/nGRvRt70E8CxNMmol5Od6J0CNY5OjD9S7V6y0H5X6akDi9HE2iL+g78vF63ZzclWuEtwfStSYvKdgOcRzNbHYpEmi5vfcqWYBtoyzbiMTkO11Jp2pSLoQY=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by AM7PR83MB0433.EURPRD83.prod.outlook.com (2603:10a6:20b:1c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Fri, 9 Feb
 2024 21:04:50 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::f7cd:8031:f6bb:1dd0]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::f7cd:8031:f6bb:1dd0%6]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 21:04:50 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of dma
 regions
Thread-Topic: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of
 dma regions
Thread-Index: AQHaW5ueHr/Oj+OkUE2IVnz+RWSpnw==
Date: Fri, 9 Feb 2024 21:04:50 +0000
Message-ID:
 <PAXPR83MB055734F57720593B5577A23DB44B2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1707318566-3141-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB326394A06EF49FF286D57B63CE442@PH7PR21MB3263.namprd21.prod.outlook.com>
 <PAXPR83MB0557C2779B1485277FD7E417B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <20240208201638.GZ31743@ziepe.ca>
 <PAXPR83MB0557626F0EDEEE6D8E78C6D7B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <20240209003115.GA31743@ziepe.ca>
In-Reply-To: <20240209003115.GA31743@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=669fdcfe-4f73-4c68-af05-01197a5337fd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-09T21:00:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|AM7PR83MB0433:EE_
x-ms-office365-filtering-correlation-id: 23401a29-491e-4e1b-4f9d-08dc29b2c137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1ehgVUn6qudHau8ib7Qzddyfkreq2onYQABOuMPUQVpm2kSMh3/DaTANzBX89Ul0cYokPxK/06n5WOg1A9W6Sv+gGL6LtOoIeeRb2+gbnI6qfBr7Pm4xYzXarJynQwsYAP8TyUFEwH3LxerQCATRiXnlv+hdrpbsNIaQ4qJMIVdWSGGjZJ2MaoPHRle/C5nC42SJLFaPeUEsHWAA+KdlidVRb1r/3j2KUZe63RPH1qelRNk80bFrkhPdVFPcFr3q7BZNaCzFjGIoVllhTGelD8TQ9+jJKbKk99vSdPfYILG3xgn1aB4wWHW53nkA6gpQVtOY2X+lNy8X9V3TtU99+xjpVMYF/kAmPdcHl7mTZx19NvcXjnnMObdO1MBZa5F3tpisaxeLOqtZwbna+Ic0aXKtl+eBGJD73lFk0Q4wu0qK6M2uI9EV9ewJK/ABSh4B0fqkYye2gZZGkFPJJoPpGyvfG1c6ZvQkqHBky/ht4CcdkR8O/Vnyjs87nzSJUTUmadEpaiupkWTeS28oG3Io+YC3fxuGHfj/Fm9l2+QxccyfS+WASIFzDZqBOlwtTN1ou45+NvaZHcTrKimxs5U6WPLBo8Lb5ec0PeqwURgTa2j343K6DEHf+uQ00zoBjwcI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(52536014)(55016003)(41300700001)(83380400001)(26005)(122000001)(8990500004)(38100700002)(9686003)(8676002)(10290500003)(64756008)(478600001)(71200400001)(8936002)(7696005)(54906003)(66946007)(66476007)(66556008)(76116006)(6506007)(38070700009)(33656002)(82960400001)(82950400001)(6916009)(316002)(86362001)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEIwWklKMVkzSEpOTlFHUzdBMGZwQU9mQUFXYmZNRVRIY0d2b2hMUHI5ZkQ2?=
 =?utf-8?B?S2NJTVdhVS9pQkZKNmF4ZUVJeFZoeEMyMkk2Y0R4YnZsL0E4bzdvN1Nxa3Bk?=
 =?utf-8?B?cStXNGUwRHhua3piNEFxbFZqc3NtNTcvcHAvSkNpcVlyUXhmeTJhdHdwM1Vr?=
 =?utf-8?B?c0RaR2p5b0FnaTZmNG84NFNBYUthOUtvZmZsZHNldG9TRE5yNkNENDhKN1Zl?=
 =?utf-8?B?OXNFdE52U1dJVmhONEdZWS9HRWcrZTkrRzduenU3alJjRHVpNG9pNmF2YU9D?=
 =?utf-8?B?c1dMTlBGOW9obUQrdWwrVDE4RWlFUGxoZlZmZE5peEVPZE5OTkdoRnY3V1Jh?=
 =?utf-8?B?aFRkd1VIeXFkbjF4ZDcrdXBIdExKRGh6eEhudVNBVmluTUxVM2prYmVYZFM0?=
 =?utf-8?B?QWsvL2FZNWxuaDU2YjB4bkxhWFBEWnNlQWFEOTV4MXVlWTNRalllOTU3Ky9X?=
 =?utf-8?B?MFgvclBCcmlHQjNqL1ZST0JmNVVzNEd2SnBIWHlrNWlxMTBvOWxKejFQU3Iz?=
 =?utf-8?B?MEd0Z2tWU0ViUUNYNExlM3BodjZ3US9ybHArQ3FCTmlzTDh5ZlhVa1FiZTVz?=
 =?utf-8?B?azFPYTFVNGp3TVgwYmkxUk9QWloyOWc5cWlVWDlrZkM0SHNOWVNFRjlrRFhZ?=
 =?utf-8?B?VmN6bEZ3SGU1clhTaUF0Nk5DMWl0ODRyM3VQS3I5azdoRjAzYklQNWREdG9a?=
 =?utf-8?B?V3d0TTJoSm9DOW5LY1ZwUnpCYnAzMVNEVjVvZGt4czJWcFkwdHlCcFZnUHMz?=
 =?utf-8?B?bXJXZzB5TXQrVnFMczZzdmNyZFpnemVFaEVzdFZjYlpneDR5Z3NHRGJhaDFL?=
 =?utf-8?B?V1ROWjVZRFZKenpJTlJQK3hlMFJqTEFQUVRSdExzdnYrdVR3Y3kvbVc5UFBV?=
 =?utf-8?B?UXk3RHJ6U3lwK0xMR2xEeVEyZzdYZnF4T29zWG9adkhzY1JYTlo1Zk5MVlIz?=
 =?utf-8?B?SERyVWxhQVpDOUxiR1ZvVVY0YTZKQ25zbFc4bEpuSFZwWjdrbiszWVArWVgy?=
 =?utf-8?B?bk90NlQ4SWFnbG9KTDlKTDVLeVFEU2E3bGY3SzBlTHJwSS9CQTRodEVubHFx?=
 =?utf-8?B?bXdTTG1EcWN1Uk1xSHhKM3NzLzBVd1E1bG1icnpPU1dMYUFwd1ZRQ0ptMnph?=
 =?utf-8?B?cmZTYmNvY1l1K3ZkV0NiRzdCWGo5UENqN0JXTGZaa054bE5sZlc4OWJuWURm?=
 =?utf-8?B?Ly8ycWp5YjFsR0V1Q2t3SThpU015UkdjbGk3bTl4eExIZXhXd2xmNmtkNDdK?=
 =?utf-8?B?dzdEaHQzS01NK0V4dXo0VStlTHRSaS9WOXRzKzJCR2ZyanljclhzVmJ1dSt2?=
 =?utf-8?B?Z0kxWmVyRWg5aDRlbHRIVnJ5NGtoRVFCalpZNzFHMnlMUTk2VzFkUW1NeVNO?=
 =?utf-8?B?dm9FWmd5ejdvOVVpVkpjbmtqcU93S1VJTFhCOU1UQVltTzNvM3NUdmNNYVZF?=
 =?utf-8?B?Wlo5T3ZRR0xFTEF5dm10NXpPL0pyUVpWWlRCOWRNNnVudHVGL2xZTDlpbmZ6?=
 =?utf-8?B?eGVTUFJuaVllRUxRc1cwc3piUXJpT1QzdkxEcnNNVGkrYkN5dmpBYURXZDJv?=
 =?utf-8?B?OTk3dWZEYUJiV0l0Wm5GbGdGS3FKVTZzRjBaWkNsL20xMEdNcG1LWmRkOWNY?=
 =?utf-8?B?K21mQ09iYnVTTnk4R2NnaHpnQnBXVFRzSjVFbXdmZVE2VHFxRDZNQk96dCtB?=
 =?utf-8?B?YjVDbzNuT2NPd1UzSFRLUWdkZ0Ezcm9mSzFGZEJ2VTNmV09tblQvdjJSaGt2?=
 =?utf-8?B?TjdmYjZtOEQ0aDk4VzJvL1FXOU1kTXpGbStaalY2OXMxZ3p5L0Q4MGRnZ1Zp?=
 =?utf-8?B?Q2xlWTE0RHVDd295bFBselZFRUcwY21RMXEwdVF4bWlLSzZLUTQ5SDlHNkxx?=
 =?utf-8?B?Zm0xMmo3RkxJcTducXlQZUFMZXdVT1prQXA1RjFGYytucnk0MGxHbVNRS3VL?=
 =?utf-8?B?RUdsaVlCeEFrWU8vUzM4WVhkaTJnejFOcENSYVlsTllOWGFHL0NWRVIwRUEw?=
 =?utf-8?B?OExiMXhhZmdDcXl2Q3pCdzlDTFRrLzVON21BUFhTaUtIbUtHNmxnTVZ6cnJt?=
 =?utf-8?Q?QIzik+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23401a29-491e-4e1b-4f9d-08dc29b2c137
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 21:04:50.1810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFb/aHhsZ5n65i/7XO7z5F6dACdW1kP4oFxbmI/xYnUcYn3Sv6sEfDR6OWOnyB38NtoBAoj/Ng1uXPbtpMlYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR83MB0433

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiA+ICsgaWYgKGZvcmNlX3plcm9fb2Zmc2V0KSB7DQo+ID4gPiA+ID4gPiArICAgICAg
ICAgd2hpbGUgKGliX3VtZW1fZG1hX29mZnNldCh1bWVtLCBwYWdlX3N6KSAmJiBwYWdlX3N6DQo+
ID4gPiA+ID4gPiArID4NCj4gPiA+ID4gPiA+IFBBR0VfU0laRSkNCj4gPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgIHBhZ2Vfc3ogLz0gMjsNCj4gPiA+ID4gPiA+ICsgICAgICAgICBpZiAoaWJf
dW1lbV9kbWFfb2Zmc2V0KHVtZW0sIHBhZ2Vfc3opICE9IDApIHsNCj4gPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgIGliZGV2X2RiZygmZGV2LT5pYl9kZXYsICJmYWlsZWQgdG8gZmluZCBwYWdl
DQo+ID4gPiA+ID4gPiArIHNpemUgdG8NCj4gPiA+ID4gPiA+IGZvcmNlIHplcm8gb2Zmc2V0Llxu
Iik7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiA+
ID4gPiA+ICsgICAgICAgICB9DQo+ID4gPiA+ID4gPiArIH0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+
DQo+ID4gPiBZZXMgdGhpcyBkb2Vzbid0IGxvb2sgcXVpdGUgcmlnaHQuLg0KPiA+ID4NCj4gPiA+
IEl0IHNob3VsZCBmbG93IGZyb20gdGhlIEhXIGNhcGFiaWxpdHksIHRoZSBoZWxwZXIgeW91IGNh
bGwgc2hvdWxkIGJlDQo+ID4gPiB0aWdodGx5IGxpbmtlZCB0byB3aGF0IHRoZSBIVyBjYW4gZG8u
DQo+ID4gPg0KPiA+ID4gaWJfdW1lbV9maW5kX2Jlc3RfcGdzeigpIGlzIHVzZWQgZm9yIE1ScyB0
aGF0IGhhdmUgdGhlIHVzdWFsDQo+ID4gPiAgIG9mZnNldCA9IElPVkEgJSBwZ3N6DQo+ID4gPg0K
PiA+ID4gV2UndmUgYWx3YXlzIGNyZWF0ZWQgb3RoZXIgaGVscGVycyBmb3Igb3RoZXIgcmVzdHJp
Y3Rpb25zLg0KPiA+ID4NCj4gPiA+IFNvIHlvdSBzaG91bGQgbW92ZSB5b3VyICJmb3JjZV96ZXJv
X29mZnNldCIgaW50byBhbm90aGVyIGhlbHBlciBhbmQNCj4gPiA+IGRlc2NyaWJlIGV4YWN0bHkg
aG93IHRoZSBIVyB3b3JrcyB0byBzdXBwb3J0IHRoZSBjYWxjdWxhdGlvbg0KPiA+ID4NCj4gPiA+
IEl0IGlzIG9kZCB0byBoYXZlIHRoZSBvZmZzZXQgbG9vcCBhbmQgYmUgdXNpbmcNCj4gPiA+IGli
X3VtZW1fZmluZF9iZXN0X3Bnc3ooKSB3aXRoIHNvbWUgaW92YSwgdXN1YWxseSB5b3UnZCB1c2UN
Cj4gPiA+IGliX3VtZW1fZmluZF9iZXN0X3Bnb2ZmKCkgaW4gdGhvc2UgY2FzZXMsIHNlZSB0aGUg
b3RoZXIgY2FsbGVycy4NCj4gPg0KPiA+IEhpIEphc29uLA0KPiA+IFRoYW5rcyBmb3IgdGhlIGNv
bW1lbnRzLg0KPiA+DQo+ID4gVG8gYmUgaG9uZXN0LCBJIGRvIG5vdCB1bmRlcnN0YW5kIGhvdyBJ
IGNvdWxkIGVtcGxveQ0KPiA+IGliX3VtZW1fZmluZF9iZXN0X3Bnb2ZmIGZvciBteSBwdXJwb3Nl
LiBBcyB3ZWxsIGFzIEkgZG8gbm90IHNlZSBhbnkNCj4gbWlzdGFrZSBpbiB0aGUgcGF0Y2gsIGFu
ZCBJIHRoaW5rIHlvdSBuZWl0aGVyLg0KPiANCj4gSXQgZG9lcyBleGFjdGx5IHRoZSBzYW1lIHRo
aW5nLCBpdCBpcyBqdXN0IGludGVuZGVkIHRvIGJlIHVzZWQgYnkgdGhpbmdzIHRoYXQNCj4gYXJl
IG5vdCBkb2luZyB0aGUgSU9WQSBjYWxjdWxhdGlvbi4gSXQgaXMgYSBtYXR0ZXIgb2YgZG9jdW1l
bnRhdGlvbi4NCj4gDQo+ID4gSSBjYW4gbWFrZSBhIHNwZWNpYWwgaGVscGVyLCBidXQgSSBkbyBu
b3QgdGhpbmsgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bA0KPiA+IHRvIGFueW9uZS4gUGx1cywgdGhl
cmUgaXMgbm8gYmV0dGVyIGFwcHJvYWNoIHRoZW4gaGFsdmluZyB0aGUgcGFnZQ0KPiA+IHNpemUs
IHNvIHRoZSBoZWxwZXIgd2lsbCBlbmQgdXAgd2l0aCB0aGF0IGxvb3AgdW5kZXIgdGhlIGhvb2Qu
IEFzIEkNCj4gPiBzZWUgbWxueCBhbHNvIHVzZXMgYSBsb29wIHdpdGggaGFsdmluZyBwYWdlX3N6
LCBidXQgZm9yIGEgZGlmZmVyZW50IHB1cnBvc2UsDQo+IEkgZG8gbm90IHNlZSB3aHkgb3VyIGNv
ZGUgY2Fubm90IGRvIHRoZSBzYW1lIHdpdGhvdXQgYSBzcGVjaWFsIGhlbHBlci4NCj4gDQo+IEFy
ZSB5b3Ugc3VyZSB5b3UgZG9uJ3QgbmVlZCB0aGUgbGVuZ3RoIGNoZWNrIHRvbz8gWW91IGhhdmUg
YSBncmFudWxhciBzaXplDQo+IGJ1dCBub3QgYSBncmFudWxhciBvZmZzZXQ/DQoNClllcywgd2Ug
ZG8gbm90IGhhdmUgY29uc3RyYWludHMgb24gdGhlIHNpemUuDQoNCj4gDQo+IEluIHRoYXQgY2Fz
ZSB5ZXMsIGEgaGVscGVyIGRvZXMgbm90IHNlZW0gbmVjZXNzYXJ5DQo+IA0KPiBIb3dldmVyLCB5
b3Ugc2hvdWxkIHN0aWxsIGJlIGNhbGxpbmcgaWJfdW1lbV9maW5kX2Jlc3RfcGdvZmYoKSBmb3Ig
dGhlDQo+IGluaXRpYWxpemUgc2l6aW5nIGFzIGEgbWF0dGVyIG9mIGNsYXJpdHkgc2luY2UgdGhp
cyBpcyBub3QgYSBNUiBhbmQgZG9lcyBub3QgdXNlDQo+IElPVkEgYWRkcmVzc2luZy4NCg0KVGhh
bmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbiEgSSBhZ3JlZSB0aGF0IHRoZSB1c2Ugb2YgaWJfdW1l
bV9maW5kX2Jlc3RfcGdvZmYoKQ0Kd2lsbCBtYWtlIHRoZSBjb2RlIG1vcmUgdW5kZXJzdGFuZGFi
bGUsIGV2ZW4gdGhvdWdoIGl0IHdpbGwgZG8gdGhlIHNhbWUgY29tcHV0YXRpb24uDQpJIGhhdmUg
YWxyZWFkeSBwcmVwYXJlZCB0aGUgcGF0Y2guIEkgd2lsbCBzZW5kIGl0IG5leHQgd2VlayBhZnRl
ciBydW5uaW5nIHRlc3RzLg0KDQo+IA0KPiBKYXNvbg0K

