Return-Path: <linux-rdma+bounces-1847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9B489C4A1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09BA1C20751
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6034781216;
	Mon,  8 Apr 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="du2+6RjA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2131.outbound.protection.outlook.com [40.107.21.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728D7C09F;
	Mon,  8 Apr 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584072; cv=fail; b=bMh8eU7k8EdfUQtU6/H4EhHrn5fPclX80X10svwxPAjefluwADW+VXY/P9SgBqAoQmqT3/O5GiJ0Wx3Z0Yy+n+0ACiAcaQ5ln9sluKbL/F2OowPe21Sl17AJDxDSIZRfZiyz4wkOei6oNxhDkD3GGoET1M8s7KFnlhC34CO6+/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584072; c=relaxed/simple;
	bh=6gE86aQTixKYP/XuypCSi5UnwIhFVlEcMOLoduVrcpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+S16Hfx7QZLoDNocdX8xgX3SAvdDduJEq7I6idUQq8RZFnkilcV1rUdvEa/gIUR25fm4Z5mpDV3mwDpUGW8MrgGaydszDHD0xdBNn9j0wZjynOwh6K4Tvae5hwvrE17pcfTjWaNIeZGKHZ1Jm4ENOnsAXTmW2dH0w1srDM8FY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=du2+6RjA; arc=fail smtp.client-ip=40.107.21.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij3JeEaLm79tSvo3lP/Q75FhtDwxVsB8PoJ1F3S2/63anmkZlOQ/5B4ITZRvi1trtynreDVB4CFCcfPgMhgukueHVH4gzdAAIp6aAibM1Ybl0KgohvwAHU+JA4fRX3T6mlyHtvu8MNfy1icFFSuNiZQczFcYiFFT6176Qd7cB3FdR2g7c1LlXCG1dOEjgP+HvQal8aJStDby/D2QsgyL+75+zd4i4/hOs/RHLedHRfgSoxMye3nkEabE1Q0ryKy51GTkoRocp79A6W7uvKlnMSjk5NnOKiaUxL+EmxbnbEsV3qxHotNNqEWLZRIErXPGiG7QUk/s5WoM/IOmiTuQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gE86aQTixKYP/XuypCSi5UnwIhFVlEcMOLoduVrcpM=;
 b=KT9Ky8cYWGMiJofAY4GtJb50XFQ37PcYDTCwP3BelAHaamhE98bkLz/se2sXZmcb8yMu+O9/c6VwtHFypw0uLA+gyDsK/DTzu48pTm2gNYSh0kDnzdur1uyviQwhEy1O1vPxVcNom5y7UNXQXuX+AJ7faFaFw6Y5iv+m3CfNMkEsLD5O0odr898I+G1vgaIWvEJ6Ygdcdrj+pY4s3GfSC5OnReBQQhZzIcBCCPBM9JEV8R/C2yTKV3OLGeRi+3Zc85f+PwfG0RX8WhtwSFJS0FId+FegIh7F9L42BSgHQPLczS+aX6Zo1iG+ZESE8hPZ2poG+DWl98Rz8Zptvsy4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gE86aQTixKYP/XuypCSi5UnwIhFVlEcMOLoduVrcpM=;
 b=du2+6RjAfDtbL43e1Z2bxHWuP93YIEx7zSB+x6D+4AlAcXxxAFRjVIU5jKjPOZb5NvZFmreKQECiTq6b4S8A1eY9QFhozEqMf8LibEMwXanANYp/dZuNtkMjJgdGYMvfymTqiVEPHt8DL4nFk8tsFCLguJZki8muAfEYyLnWCTI=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by VI0PR83MB0590.EURPRD83.prod.outlook.com (2603:10a6:800:212::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 13:47:45 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 13:47:45 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v4 0/4] Define and use mana queues for CQs and
 WQs
Thread-Topic: [PATCH rdma-next v4 0/4] Define and use mana queues for CQs and
 WQs
Thread-Index: AQHaibtVp4qPjQ+ZPE6yrJQG2FfHYw==
Date: Mon, 8 Apr 2024 13:47:45 +0000
Message-ID:
 <PAXPR83MB05573802DE8859318A7B1435B4002@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240408112533.GF8764@unreal>
 <PAXPR83MB05570E9EE9853B2E6F66703DB4002@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <20240408130024.GG8764@unreal>
In-Reply-To: <20240408130024.GG8764@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f1a1c888-d94d-45ae-8ff1-b191260498e7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-08T13:36:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|VI0PR83MB0590:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CFkXOf7J9xnhi9GMnOczW1bE3SLjMxURVJgKFKTARyjBzpOwIrWYBveb4s1JZhQsRhbzrQoCqg2zYojbgACwpaZCfxLbWt6/EwRSxZr3xTyvAw3qf1KLARpVu9EN5uGbSOo26LzSW0QLl9NuqaOBnB42ueB+lFVpPeOZVIpoaJAVtjArQg+E0pO1uYKujXxxsN/zWbPO7uOxiS3LWTjds/rU8lPmNWaHyMttevLb8PYiLZoOof+rbpzq+MzWJT/L1pTfbm1PczQrDYCqz9TqV6BzU8UFgTCFpMVo+GjAH5EJda6iU5uTBYdtIKlyVJhjfBoRMdzfVT/G+5paQwAYgz6nk/r2QA+8etg+TNW5+jeYAM4Kl+eXJVCfahI5FB7YNKoftPbY9NDAzkQHZdRJwfVe2my8OGIYUB9O4sTUTRAImSIuVF8QVdU8YiQSXm6dm3l7J82DohN3MfQybFl6aWgeMQfrSrlGcpBk+s1FI/DvILQ12Vgl4/1Kfr1F4BOMbeqJ8srljkaVBajPJu5tt3cT3Cugx4TjVNHI3uGe229v//IuaimHJG5nzwV1QePXXMnOUtFc8seyAIKSS2TVl/oCB2WOvsOk/lmoNkZfN8snC59gw/INSIu6Dq7XwQvCLqPcV+4lbbBu9fTIBIbUYbIbyYwa8APu4XE9w1mWYLs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azVoOXpWTGNpSzl3LzQzdjY2QW85MzRxd1hackdBbHdrakN1QUhuejRxWkR4?=
 =?utf-8?B?c0NSRUUzUms0b3l0VjlKU2QyWHhmcW41NDRyT05sL1RJL2VIK3Rubk9Bby9m?=
 =?utf-8?B?TTJYKytGWnh1YldUZ1VqT1VJTklDWjBpSDFZcTN3SXIxTjBYeXB4d1U1ME54?=
 =?utf-8?B?d3o3Z3ZEcERMdElsc3JoNUJrVmJJV2V5Ymx0ZkhMdjd1Y1ZZdk9wMXdjSEoy?=
 =?utf-8?B?bzFvVmNqMlQxckR2dkYvU1lDOHl4aURvUEZDbkJpQ0REcVpZOXdaaURrN2Fr?=
 =?utf-8?B?Nng2Y1JOT2gvUUdyVHhWSlh4YXpYcnZYbGtXRkFOL0lmWDBDQ3NkbVNSVzNT?=
 =?utf-8?B?ZjNkSk9IOENtbDcxTzBJMXZzSUpiMnFjYTFlY1NRRmk1VTlRdTg2UElIcTk1?=
 =?utf-8?B?ejE5Y0x1ZG92UitiZCt3QlJFZzRvSWRjbnNzSkxZb002NXA3b1N1SitDdDhB?=
 =?utf-8?B?bkowTGZNVGt4b1RsT2pmK2kvYTROUGhWNVR4ekpLMkppNVNrWmNjYXBiVWdy?=
 =?utf-8?B?bXpzaWcrbDZ6RWRZOTU0TzJjc0s1MkZTaTA1TE1ZVUtERWRNUmRRVFc4RExV?=
 =?utf-8?B?UjlXbkVjbThVN2M5ZE14RDZGRHZ4UVBlbWxidnVhRXFWUHFJNEdvclRVV1pw?=
 =?utf-8?B?cTR1RnlsM04wSkx4bGE5a1NHZFk4Ni9uL2NzNmFxL3NGZEVpWUVxdUloTnFG?=
 =?utf-8?B?cU8vSDRRbFAvZzJNOFpScUJrMHRXbmMyR0hsSjVTa29CZlJKR3JWckRNajFi?=
 =?utf-8?B?ZmlkYk94TDZxVXJOOU5OclN6OHg0dGt6N09YV0owSUh6QnJwMlRGY3pmdjhG?=
 =?utf-8?B?dEp2U216U0VHZkp4NUN5SzVLd2w0Skgxc25JcDExMldCV2VDck9vNjZjcG1u?=
 =?utf-8?B?aUVhNzZJaHZyMENHWCthNHBxd2k2WGE1MmlYdzYwS05TeHlQRjVLYWNYRXFO?=
 =?utf-8?B?YktIMktncTl6dW5FdXdrVitPVjlid0k2eWNGSUYveStGamYrMThKTDgzdlBW?=
 =?utf-8?B?MGxTU1E5QXVIWHBwZlJzKy9tdHJOZ202UDFrZjY2YU1NUUFwa25la1VWYVNo?=
 =?utf-8?B?a09HbWdkeDVXRExNU3RGenRpTzBPaUcxZTJoR0wyQ2NDaC9ROGFUSTdoeTlI?=
 =?utf-8?B?UEJtak43clNmYU1wY0hlL0JwVU1uSkhXV0JWSjJlQ1BnYlU4U3pPWVozUHgz?=
 =?utf-8?B?L1dRYjk5UkhhU25tdlZ2NEhpWWdidUlxWDl0YU80WmowRk5UMWJ5emZ4Q0tu?=
 =?utf-8?B?NDhHN0RIUURjY3hQQXZ5a3MrUDZMMVl4QVRWWFdRbFBZdVMzaXVWK09FcUp0?=
 =?utf-8?B?eEJjbFdDQWgxUG1mS2Z3YUxzamc1STBWb0daZkswOGtGdlZ2ZUNyS2xveHVx?=
 =?utf-8?B?SmR0QWdJQStuQVFGRlJ4eTA2MXc4dkFpZ01zaklxZEVNaFlpUUxrMGg4SGFz?=
 =?utf-8?B?ZUMyWUZIZXZvV21hNmF2dTFCSWV0VjhyQTVRYjlHaXZOdWpGb01aZ1VTbnBH?=
 =?utf-8?B?TXVDQmczemRxTEptdHp4YkVPZURkK096d0FCd3RaM09qdWtobGlwNjZza1hR?=
 =?utf-8?B?akxCNmtIQ3c5SEt3bmp6ZkdVM0lzWVYrR2gyelQ3ZHFjbFlpRlRSWFY1am9J?=
 =?utf-8?B?dnFmMnpNdXN0RkR4eEZRTUJBTm1SbVE0ZXpzOE93NUJEOXp5QXZrdXhXdG1o?=
 =?utf-8?B?WFlCSHdQRVVoR242c2FBUlAvNXRLckd1SmYxTStjZUpIZ1lSS2pGMzQzSjlX?=
 =?utf-8?B?elY4TmN5ODNTZ1lMcEV6RGlGT2Vqa0V2bEM1Z0tLeXVNWmIzU1N6clQxV1NJ?=
 =?utf-8?B?TGduSWM3b3VhbjBWMHBLMkFVaVVBSElFZlRSaC94b1J1WklzeE1wNkJzT3pL?=
 =?utf-8?B?ckhqaktaYk83OEdaQTAxNkNMNWo2eU9rc254OEh0cGN6QzZNNXMrT2hnRnh0?=
 =?utf-8?B?SUJmb1RKTXAzMWpIRzQrMDBMb0xtUExxMTZrTmF6aFVURWZsbDQ1bHZscEc3?=
 =?utf-8?B?Q0R1a3hqcGFOZzFTSlBEaXFoS0FVenBPbldPMGJZVndpNzFpV0MxZER3ZTRZ?=
 =?utf-8?Q?WEJgua?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9100cdb3-a634-4284-8c51-08dc57d2786f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 13:47:45.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDSkfotdiwY48XFTSf9qMgAfPB2/rMBw/wtzhBK8+sdJwsWTcuSaFKMNUSgvvivHMzxtP4Fzw8Dy39do4AJxdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0590

PiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4gT24gTW9uLCBBcHIg
MDgsIDIwMjQgYXQgMTI6NTA6MTJQTSArMDAwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0K
PiA+ID4gRnJvbTogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IE9uIE1vbiwgQXBy
IDA4LCAyMDI0IGF0DQo+ID4gPiAwMjoxNDowMkFNIC0wNzAwLCBLb25zdGFudGluIFRhcmFub3Yg
d3JvdGU6DQo+ID4gPiA+IEZyb206IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jv
c29mdC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFpbXMgdG8gcmVk
dWNlIGNvZGUgZHVwbGljYXRpb24gYnkgaW50cm9kdWNpbmcgYQ0KPiA+ID4gPiBub3Rpb24gb2Yg
bWFuYSBpYiBxdWV1ZXMgYW5kIGNvcnJlc3BvbmRpbmcgaGVscGVycyB0byBjcmVhdGUgYW5kDQo+
ID4gPiA+IGRlc3Ryb3kgdGhlbS4NCj4gPiA+ID4NCj4gPiA+ID4gdjMtPnY0Og0KPiA+ID4gPiAq
IFJlbW92ZWQgZGVidWcgcHJpbnRzIGluIHBhdGNoZXMsIGFzIGFza2VkIGJ5IExlb24NCj4gPiA+
ID4NCj4gPiA+ID4gdjItPnYzOg0KPiA+ID4gPiAqIFtpbiA0LzRdIERvIG5vdCBkZWZpbmUgYW4g
YWRkaXRpb25hbCBzdHJ1Y3QgZm9yIGEgcmF3IHFwDQo+ID4gPiA+DQo+ID4gPiA+IHYxLT52MjoN
Cj4gPiA+ID4gKiBbaW4gMS80XSBBZGRlZCBhIGNvbW1lbnQgYWJvdXQgdGhlIGlnbm9yZWQgcmV0
dXJuIHZhbHVlDQo+ID4gPiA+ICogW2luIDIvNF0gUmVwbGFjZWQgUkRNQTptYW5hX2liIHRvIFJE
TUEvbWFuYV9pYiBpbiB0aGUgc3ViamVjdA0KPiA+ID4gPiAqIFtpbiA0LzRdIFJlbmFtZWQgbWFu
YV9pYl9yYXdfcXAgdG8gbWFuYV9pYl9yYXdfc3ENCj4gPiA+ID4NCj4gPiA+ID4gS29uc3RhbnRp
biBUYXJhbm92ICg0KToNCj4gPiA+ID4gICBSRE1BL21hbmFfaWI6IEludHJvZHVjZSBoZWxwZXJz
IHRvIGNyZWF0ZSBhbmQgZGVzdHJveSBtYW5hIHF1ZXVlcw0KPiA+ID4gPiAgIFJETUEvbWFuYV9p
YjogVXNlIHN0cnVjdCBtYW5hX2liX3F1ZXVlIGZvciBDUXMNCj4gPiA+ID4gICBSRE1BL21hbmFf
aWI6IFVzZSBzdHJ1Y3QgbWFuYV9pYl9xdWV1ZSBmb3IgV1FzDQo+ID4gPiA+ICAgUkRNQS9tYW5h
X2liOiBVc2Ugc3RydWN0IG1hbmFfaWJfcXVldWUgZm9yIFJBVyBRUHMNCj4gPiA+ID4NCj4gPiA+
ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMgICAgICB8IDUyICsrKy0tLS0tLS0t
LS0tLS0NCj4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYyAgICB8IDM5
ICsrKysrKysrKysrKw0KPiA+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFuYV9p
Yi5oIHwgMjYgKysrKy0tLS0NCj4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL3Fw
LmMgICAgICB8IDkzICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gIGRyaXZl
cnMvaW5maW5pYmFuZC9ody9tYW5hL3dxLmMgICAgICB8IDMzICsrLS0tLS0tLS0NCj4gPiA+ID4g
IDUgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKSwgMTQ3IGRlbGV0aW9ucygtKQ0KPiA+
ID4NCj4gPiA+IEl0IGRvZXNuJ3QgYXBwbHkuDQo+ID4gPg0KPiA+DQo+ID4gSSBndWVzcyB0aGVy
ZSB3YXMgc29tZSBtaXMtc3luY2hyb25pc2F0aW9uIGJldHdlZW4gdXMuDQo+ID4gSSBzZWUgdGhh
dCB5b3UgaGF2ZSBhbHJlYWR5IGFwcGxpZWQgdGhlIHBhdGNoIDYgZGF5cyBhZ286DQo+ID4gaHR0
cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGZ2l0Lg0KPiA+DQo+IGtlcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5l
bCUyRmdpdCUyRnJkbWElMkZyZG1hLmdpdCUyDQo+IEZsb2clDQo+ID4NCj4gMkYmZGF0YT0wNSU3
QzAyJTdDa290YXJhbm92JTQwbWljcm9zb2Z0LmNvbSU3QzA5ZWE2ZGUzODExOTQyOTVjDQo+IDRh
ZTA4ZGMNCj4gPg0KPiA1N2NiZTEyMSU3QzcyZjk4OGJmODZmMTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3
JTdDMSU3QzAlN0M2Mzg0ODE3OA0KPiAwNDEwMjcxNw0KPiA+DQo+IDMzJTdDVW5rbm93biU3Q1RX
RnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXoNCj4gSWlMQ0pCVGlJ
DQo+ID4NCj4gNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWp3R0do
bWF0SHFkTjRiVw0KPiBYYyUyRnR5WHR1YkQNCj4gPiBaeHhDWHBueUwyNlM1bEVLZDAlM0QmcmVz
ZXJ2ZWQ9MA0KPiA+DQo+ID4gSSBhbSBzb3JyeSBmb3Igc2VuZGluZyBhIG5ld2VyIHZlcnNpb24g
YWZ0ZXIgdGhlIHBhdGNoIGhhcyBiZWVuIGFwcGxpZWQuDQo+ID4gSSBoYXZlIG5vdCBjaGVja2Vk
IHRoaXMgYmVmb3JlIHNlbmRpbmcuDQo+ID4gSSBjYW4gdGFrZSBjYXJlIG9mIHVzZWxlc3MgZGVi
dWcgcHJpbnRzIGluIGEgZnV0dXJlIGNsZWFudXAgcGF0Y2guDQo+IA0KPiBQbGVhc2UgcmViYXNl
IHlvdXIgc2VyaWVzLCBhbmQgcmVzZW5kLg0KDQpTb3JyeSBmb3IgYSBjb25mdXNpb24uIEkgbWVh
biB5b3UgaGF2ZSBhbHJlYWR5IGFwcGxpZWQgdGhpcyBwYXRjaCBzZXJpZXMgKHYzKSA2IGRheXMg
YWdvLg0KU2VlIGNvbW1pdHM6DQo0NmY1YmU3Y2Q0YmNlYjNhNTAzYzU0NGIzZGFiN2I3NWZlNGJi
OTZiDQo2MGE3YWMwYjhiZWM1ZGY5NzY0Yjc0NjBmZmVlOTFmYzk4MWU4YTMxDQo2ODhiYWMyOGUz
ZGM5ZWI3OTVhZThlYTVhYTQwY2I2MzdlMjg5ZmFhDQpmMTAyNDJiM2RhOTA4ZGM5ZDRiZmEwNDBl
NjUxMWE1Yjg2NTIyNDk5DQoNCkFzIGEgcmVzdWx0LCBJIGNhbm5vdCByZWJhc2UuIEkgY291bGQg
c2VuZCBhIGNvbXBsZXRlbHkgbmV3IHBhdGNoIHRoYXQgcmVtb3ZlcyBzb21lIGRlYnVnIHByaW50
cy4NCg0KSSBtaWdodCBsb29rIGF0IGEgd3JvbmcgYnJhbmNoLiBJZiBzbywgcGxlYXNlIHNlbmQg
dGhlIGJyYW5jaCB0aGF0IGRvZXMgbm90IGhhdmUgdGhpcyBwYXRjaCBzZXJpZXMgYXBwbGllZC4N
Cg0KVGhhbmtzLA0KS29uc3RhbnRpbg0KDQo+IA0KPiBUaGFua3MNCg==

