Return-Path: <linux-rdma+bounces-889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E728848F01
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 16:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FB31F22A35
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A1225A9;
	Sun,  4 Feb 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V3CIHpKX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2117.outbound.protection.outlook.com [40.107.7.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D9225AC;
	Sun,  4 Feb 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061848; cv=fail; b=qkbtWHpXy+O172e+eEQ119Yk27CuDoCnyNBOLUiS2gWn7p2EIhftolzpH0RJthu2HqqUtZ056QHxB8BheSddCc9bEAesia3x4xh1UF1Dv6HHtJBLUw3e1KN7v1Ig8zb5P1nX1O3sWll2u0WlaykNyB7CpZs35vav1w+VkBL/6VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061848; c=relaxed/simple;
	bh=kRqeHQr/nFaH4Reb1DY7Zxr5wxbL7DT5kojaVDX9RGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=udPk7QcROEXqpGdd5LDi8FwNAuJ5vyuZ+LeLwA9GWrZYQDiGyxqn2PRXyDSOUs7QyaSvhaQKSIAsp/qYcooFPNHEG7w/amZOZA9eg4eOJBptNaVRy+iMsxRFLtGer2SxAadAzYG1dA4Ac5xDL5z19B2kidthtBGtg8T1WeRRWhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=V3CIHpKX; arc=fail smtp.client-ip=40.107.7.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoNjRZcajiHVvL4TEIM4TgetrXFAqfhoJhLWG/L4Q/B8zXER7c6HlFSqmT/Y48KdyrUgu+fWth+91rCNYTzSi3JwvpkROFFUMBKyfAY8ypg2xf+StAy0/ozwQyqJDjMBHlarvTY7LyeXuh3/Pm3c7LpieALSeL/kxe/ggM+35854bDP4N2NstBx+/e6vdiwDhHP0DzhOT9EiytlP7bvEwr/4HFWK0Uuf5k8SyT3Oa/AwtaSzoi6dNq4jSi1wyaf2slDutCZFjyRDZMsHw2wX9FcTyxO8uavLGN8eRQqxVXCBGtZitDpJD1sulQlBU6Asfnqe44libLphG+osroNS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRqeHQr/nFaH4Reb1DY7Zxr5wxbL7DT5kojaVDX9RGc=;
 b=eSD771V9wyidnMi+yHKciffdG9AfMQS2okn5LMMhGu6nbnEA7b25jjS+IXdcJCrKGeQBersmeJt5gD69fktbOQsIey9tNtFurG4g/nhtPU2bs3PRIop6iCnxldbvDSOJ6aAPGrwS/YVGf3l3o2Em93WEaj8Qzugeq/MY4V5xdHB41fS1z8kDlViWLkvNHIoHgOq9F31SF9RDBOKGtWYkoqqBOMWDWE/FVWsBqIbOajn48/L8Kbq4tSYsRtrFidFE+T8vwiKlKoxs3T1LiPgtEG3sE3NoR9govNHUztYPMTKx/m0hV/IctuH4QRw58sX8ABn5mjpXd9jEwduJZauAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRqeHQr/nFaH4Reb1DY7Zxr5wxbL7DT5kojaVDX9RGc=;
 b=V3CIHpKXee9kDJHYFYoNFf8tH3X8YJ0JW900Y5lQcDXpLv9N4lteSiKO08D8LlMlYeCpzA+JGxfL+HmQ39ZcLQd5ARtht3x0lCxcsmaTLrYRpSEuZhueJ5z45gV8Ra4z2czMt7iZKt2aMSngeLW21q1he4111p9AxRpykRqEnzQ=
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com (2603:10a6:10:322::19)
 by VI1PR83MB0432.EURPRD83.prod.outlook.com (2603:10a6:800:190::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.3; Sun, 4 Feb
 2024 15:50:41 +0000
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::a8db:9564:bfb1:181d]) by DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::a8db:9564:bfb1:181d%4]) with mapi id 15.20.7292.001; Sun, 4 Feb 2024
 15:50:40 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and
 destroy rnic adapter
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and
 destroy rnic adapter
Thread-Index: AQHaVelzQoHpJTBxI0CA3jYtbVkPuLD6H/mAgAA1LyA=
Date: Sun, 4 Feb 2024 15:50:40 +0000
Message-ID:
 <DU0PR83MB0553DF0BA184971EDD66DB0EB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240204123013.GE5400@unreal>
In-Reply-To: <20240204123013.GE5400@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=817c7b8b-2bdf-47ed-b6a4-83e93130ac85;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-04T15:40:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR83MB0553:EE_|VI1PR83MB0432:EE_
x-ms-office365-filtering-correlation-id: 9da4fd8a-651d-48fe-add3-08dc259909e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 p6uto1aWgrRNMWvkBmtFHrb5w46E5ofxvImMYi8s2/Oz3YTrHma8HNSV3uB8U8CS83OSDUpzK3K0EzuFy/IjmqEAlsk6KAOmqUxUAINLLl1cwP3HoRPWnERZ34O27Fn/rxBpJ4U6RwUnccsqMGB2jns4kgWGCbz4Szvb7iE2dvYdDGFzAi0FSDKPhrXu+N3TaQs8JAvJseeU6YTW/Wb+xFfxg1R7KM+jL+0cV9L2rX+LbP34AdhcV4LlEAeXfUnHQwScQIeaggVyBT4QdOqAx/p0brCbc/F8SIU2RokEuQOGh+cdEF7m0hEZmPR4XLrRJaIwhvw7Gx7qsXfOb88tRq1unVoFSljETV+c8MOKFOiCANAk5Q+OYsGZnMv8ATHV5J55PLR3bHRneYQ582WfSq5CjX2A5Es87wevTYYOu+NWhN97UCOFoTAVdlLN7wZbJtQ0UXzZWcznnxjodsGDPeWUrvVouXol4U3UQVEgn75Sk+tsqbdfVyGsOjFpjLJJggKk8r/ZOeuc9kGa4J/HB7CdV5ip80GxSpXatzF0gGhcPAbTFnV1dM/ZojKoMPwhC0RC2HszxAIsD6i8ND4IfxLXHjPL0pXNirsquHBs9JHOPtUndYbi2QJ2/wnh4bhL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR83MB0553.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38070700009)(55016003)(41300700001)(76116006)(66476007)(66946007)(71200400001)(54906003)(316002)(478600001)(10290500003)(6506007)(7696005)(9686003)(110136005)(83380400001)(82950400001)(4326008)(66446008)(38100700002)(82960400001)(8936002)(8676002)(86362001)(2906002)(8990500004)(122000001)(64756008)(66556008)(33656002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWZmdUxDQ1NIVGRrL2JVOHRCVVhqUEdScnpNZTN6Z2J1U2hlRmlLa0hnMlIx?=
 =?utf-8?B?alJxbk5pL2hYVGozbHlaMFgwZkpoMEdTRHZnTlMyTThxaEFuU2F4aEpJVzh4?=
 =?utf-8?B?SENDOEdzVDltL3JuQ0wzSzVDQnBLS0N0Z1B5a2ZMWjk5RUI3S0pYYmhCUWJW?=
 =?utf-8?B?YTdXL25lTjdTRjN1cjY5MFh3NDFkWkluMlNjakVKVGx5UVdsTmxGemFnVVRL?=
 =?utf-8?B?b056aS9UaW0xLzRFdTJ5WHIxWXJ2UFlmeVhNSHJpaWswUGxCaXVJbTZZYy9q?=
 =?utf-8?B?U2hyRHc2VnoxRFJFTDRXYWhoSnhRQ2NkZTlCajVreHZEdFdDVUZnUlZBdVBK?=
 =?utf-8?B?YytRcjd0U0M4NWVMVk9Xb3Jud1F1dUMyVGtBNEY0UHBoZ2ZWa0dKVms3cnJK?=
 =?utf-8?B?amhsYU9JUWFvZFFEMjRsOTBtMndGazJOZmtrM09QYlFPaDduTWxUa0JSL0ow?=
 =?utf-8?B?b0QzeWhZQnBYVzllZ3B2MEpzY256eFMvT2VEZHIrRG1sTVhYSm9qb1hSalI0?=
 =?utf-8?B?QjhndC9jWXFXVTNoZFYzcWREMlRJek02OVFiVmVSci9pY3BleC9IVm5RVDcx?=
 =?utf-8?B?TUQvQVo0aVEzWFp1ejJGMk1CcUZoamZreTZTV0NIQmkrUTlkdUh2VUJRNnhD?=
 =?utf-8?B?aHZVTXU1TERaZFZrM01SUWxJSjJlQmw3cy9TNjJkcTJYUTMyd3FFeUt4TGp4?=
 =?utf-8?B?aXJoVzZlOTNwemF1SFlJUWEwTmVpTlZwNUxnNUtUUThJMmJwMG96STl4eUxu?=
 =?utf-8?B?N0orUllNMGR3RmFXbm5Ec1VPckRLeEZud0RhK0M2SWFMS2hCRjhwQzRqdzBo?=
 =?utf-8?B?SFdneERLY3BLMzRVNldoc1J0NXpVdE9YK2doMDhmd0prRzVSa1ByK1RKY0tV?=
 =?utf-8?B?akZVcFl6Q3RLdXpuUVlkd3M5MW9lVEEyOVdNNjFzZmtGTFN1ZnBKYTgxdUE0?=
 =?utf-8?B?dkYrd1c0VzdTQlFiMUlLRVFrdVR4R2N3U2pCWFRjS3B2T1JpZFZRUEFHZEtR?=
 =?utf-8?B?MlNINlYzSDRMc3R1a3B5bmhBd0kwbXVLclVpbGx5OXNIZkY3ZC9KTlhTQ1dJ?=
 =?utf-8?B?bDdNaWd1L0R3U3I1T0daNjZ6SjZ6b3ZmMXk4ZEROLzAveStoSkdkZlZRSUpC?=
 =?utf-8?B?cm91QnZ0NUk5U0RwVytRZDBJRi91bGNQU0hhVWZ2UmwzaERWckhzQ0R3WDVE?=
 =?utf-8?B?Q2xzUmFyTUN6YyttcmY2RTRZeDcrT01ydTdoL0NST0tUS0NROWJqRHFaMi9z?=
 =?utf-8?B?dmc4UXZhRER6WjhFU1ZOd1FwdUZBNWtFZGhuQWJzK01ob3NSeUZzNUVjaUFn?=
 =?utf-8?B?aHd3UnE2ZlJpaWNGRnUyY3RqWWlWTXcvaWU4ZFgyVnNLdFVvREI5MnQvd3lv?=
 =?utf-8?B?dG9VT3FTTEtqQ3pMRisrcjRGWklTVEk0ZFVxbjVBRzI4MklzRDhWRFdWTWZV?=
 =?utf-8?B?SFJmWnZDQjZmVEpXSE5qTjJvRjhhUDRrdHV2dHpZR3BuYWxlSVNlaWtreFUr?=
 =?utf-8?B?dktmenljL1lxUlVYOFdhczcvdlA2WlE2NnRTK3ZxUDNWYk9GbUdvMnhpOFpY?=
 =?utf-8?B?N2JxZWV6VEVLcXJqbU03RGpqSUdTd2pFMDRpRW82SHpSRXYwdnVkK080NTVl?=
 =?utf-8?B?cVNNWWdBdndtYTBYOFNOMmlIemxGY3JpZGNybkV0U3grK1RyaE5Xd1RXUU1s?=
 =?utf-8?B?cDc5eUZ6UDI5TVZ0bnZ3b0hvRmh3ZWZEaWJTK2lBUmM1YitnRTRxc2RHdWFi?=
 =?utf-8?B?NDJxY0pTTVMvRUZxdlY4LytGVjNHK2hKNDlxWnl3bWsvR0h6T0VubWxqeEgz?=
 =?utf-8?B?bHRXS3J4eDg3RnN3a09rdUhUODd1RGNDOGRzOVJKSlI4OUE0ZjhIbE1vNGly?=
 =?utf-8?B?UlhyZm85RmxOYy9vb0ZXSUx4SFZNOGM3Y2RkYXdLY3lITFBReDRBV09UNzdl?=
 =?utf-8?B?bFZUTFFPTm1EVVBtRnRvU0RESmhYbm14TjhOa1FxT3NBZ2VQNC96SSt2U01Q?=
 =?utf-8?B?cWZEMDVwQjh2a2tvYmY0TDhNZ0N0cWs4ZVd5R012aTI4S0pBMk5PWTlzRHZz?=
 =?utf-8?B?VE1DdDhyajNjWDF2aGpkc2RZaGFiY1p2MTU2VnFOWlN2UGZ1UEU5dW15SnFq?=
 =?utf-8?Q?WUKD16Q4m1seidI0by7SCxJbe?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR83MB0553.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da4fd8a-651d-48fe-add3-08dc259909e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 15:50:40.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6K6al0M1Cy8KJgX406aFEm/8ULIQlaQt28QA+FO+CYT0eSxslYe7wCcD/dVBpu9mTgD23EFwkrkZ5hGjuLNE+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0432

PiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4gT24gRnJpLCBGZWIg
MDIsIDIwMjQgYXQgMDc6MDY6MzRBTSAtMDgwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0K
PiA+IFRoaXMgcGF0Y2ggYWRkcyBSTklDIGNyZWF0aW9uIGFuZCBkZXN0cnVjdGlvbi4NCj4gPiBJ
ZiBjcmVhdGlvbiBvZiBSTklDIGZhaWxzLCB3ZSBzdXBwb3J0IG9ubHkgUkFXIFFQcyBhcyB0aGV5
IGFyZSBzZXJ2ZWQNCj4gPiBieSBldGhlcm5ldCBkcml2ZXIuDQo+IA0KPiBTbyBwbGVhc2UgbWFr
ZSBzdXJlIHRoYXQgeW91IGFyZSBjcmVhdGluZyBSTklDIG9ubHkgd2hlbiB5b3UgYXJlIHN1cHBv
cnRpbmcNCj4gaXQuIFRoZSBpZGVhIHRoYXQgc29tZSBmdW5jdGlvbiB0cmllcy1hbmQtZmFpbHMg
d2l0aCBkbWVzZyBlcnJvcnMgaXMgbm90IGdvb2QNCj4gaWRlYS4NCj4gDQo+IFRoYW5rcw0KPiAN
Cg0KSGkgTGVvbi4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCBzdWdnZXN0aW9uLiBJIHdp
bGwgaW5jb3Jwb3JhdGUgdGhlbSBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KUmVnYXJkaW5nIHRoaXMg
InRyeS1hbmQtZmFpbCIsIHdlIGNhbm5vdCBndWFyYW50ZWUgbm93IHRoYXQgUk5JQyBpcyBzdXBw
b3J0ZWQsIGFuZCB0cnktYW5kLWZhaWwgaXMgdGhlIG9ubHkgd2F5DQp0byBza2lwIFJOSUMgY3Jl
YXRpb24gd2l0aG91dCBpbXBlZGluZyBSQVcgUVBzLiBDb3VsZCB5b3UsIHBsZWFzZSwgc3VnZ2Vz
dCBob3cgd2UgY291bGQgY29ycmVjdGx5IGluY29ycG9yYXRlDQp0aGUgInRyeS1hbmQtZmFpbCIg
c3RyYXRlZ3kgdG8gZ2V0IGl0IHVwc3RyZWFtZWQ/DQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYyAgICB8IDMxDQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3
L21hbmEvbWFuYV9pYi5oIHwgMjkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYWluLmMNCj4gPiBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+IGluZGV4IGM2NGQ1NjkuLjMzY2Q2OWUgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+ID4gKysrIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+ID4gQEAgLTU4MSwxNCArNTgxLDMx
IEBAIHN0YXRpYyB2b2lkIG1hbmFfaWJfZGVzdHJveV9lcXMoc3RydWN0DQo+ID4gbWFuYV9pYl9k
ZXYgKm1kZXYpDQo+ID4NCj4gPiAgdm9pZCBtYW5hX2liX2dkX2NyZWF0ZV9ybmljX2FkYXB0ZXIo
c3RydWN0IG1hbmFfaWJfZGV2ICptZGV2KSAgew0KPiA+ICsgICAgIHN0cnVjdCBtYW5hX3JuaWNf
Y3JlYXRlX2FkYXB0ZXJfcmVzcCByZXNwID0ge307DQo+ID4gKyAgICAgc3RydWN0IG1hbmFfcm5p
Y19jcmVhdGVfYWRhcHRlcl9yZXEgcmVxID0ge307DQo+ID4gKyAgICAgc3RydWN0IGdkbWFfY29u
dGV4dCAqZ2MgPSBtZGV2X3RvX2djKG1kZXYpOw0KPiA+ICAgICAgIGludCBlcnI7DQo+ID4NCj4g
PiArICAgICBtZGV2LT5hZGFwdGVyX2hhbmRsZSA9IElOVkFMSURfTUFOQV9IQU5ETEU7DQo+ID4g
Kw0KPiA+ICAgICAgIGVyciA9IG1hbmFfaWJfY3JlYXRlX2VxcyhtZGV2KTsNCj4gPiAgICAgICBp
ZiAoZXJyKSB7DQo+ID4gICAgICAgICAgICAgICBpYmRldl9lcnIoJm1kZXYtPmliX2RldiwgIkZh
aWxlZCB0byBjcmVhdGUgRVFzIGZvciBSTklDIGVyciAlZCIsDQo+IGVycik7DQo+ID4gICAgICAg
ICAgICAgICBnb3RvIGNsZWFudXA7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgbWFuYV9n
ZF9pbml0X3JlcV9oZHIoJnJlcS5oZHIsIE1BTkFfSUJfQ1JFQVRFX0FEQVBURVIsDQo+IHNpemVv
ZihyZXEpLCBzaXplb2YocmVzcCkpOw0KPiA+ICsgICAgIHJlcS5oZHIucmVxLm1zZ192ZXJzaW9u
ID0gR0RNQV9NRVNTQUdFX1YyOw0KPiA+ICsgICAgIHJlcS5oZHIuZGV2X2lkID0gZ2MtPm1hbmFf
aWIuZGV2X2lkOw0KPiA+ICsgICAgIHJlcS5ub3RpZnlfZXFfaWQgPSBtZGV2LT5mYXRhbF9lcnJf
ZXEtPmlkOw0KPiA+ICsNCj4gPiArICAgICBlcnIgPSBtYW5hX2dkX3NlbmRfcmVxdWVzdChnYywg
c2l6ZW9mKHJlcSksICZyZXEsIHNpemVvZihyZXNwKSwgJnJlc3ApOw0KPiA+ICsgICAgIGlmIChl
cnIpIHsNCj4gPiArICAgICAgICAgICAgIGliZGV2X2VycigmbWRldi0+aWJfZGV2LCAiRmFpbGVk
IHRvIGNyZWF0ZSBSTklDIGFkYXB0ZXIgZXJyICVkIiwNCj4gZXJyKTsNCj4gPiArICAgICAgICAg
ICAgIGdvdG8gY2xlYW51cDsNCj4gPiArICAgICB9DQo+ID4gKyAgICAgbWRldi0+YWRhcHRlcl9o
YW5kbGUgPSByZXNwLmFkYXB0ZXI7DQo+ID4gKw0KPiA+ICAgICAgIHJldHVybjsNCj4gPg0KPiA+
ICBjbGVhbnVwOg0KPiA+IEBAIC01OTksNSArNjE2LDE5IEBAIHZvaWQgbWFuYV9pYl9nZF9jcmVh
dGVfcm5pY19hZGFwdGVyKHN0cnVjdA0KPiA+IG1hbmFfaWJfZGV2ICptZGV2KQ0KPiA+DQo+ID4g
IHZvaWQgbWFuYV9pYl9nZF9kZXN0cm95X3JuaWNfYWRhcHRlcihzdHJ1Y3QgbWFuYV9pYl9kZXYg
Km1kZXYpICB7DQo+ID4gKyAgICAgc3RydWN0IG1hbmFfcm5pY19kZXN0cm95X2FkYXB0ZXJfcmVz
cCByZXNwID0ge307DQo+ID4gKyAgICAgc3RydWN0IG1hbmFfcm5pY19kZXN0cm95X2FkYXB0ZXJf
cmVxIHJlcSA9IHt9Ow0KPiA+ICsgICAgIHN0cnVjdCBnZG1hX2NvbnRleHQgKmdjOw0KPiA+ICsN
Cj4gPiArICAgICBpZiAoIXJuaWNfaXNfZW5hYmxlZChtZGV2KSkNCj4gPiArICAgICAgICAgICAg
IHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgZ2MgPSBtZGV2X3RvX2djKG1kZXYpOw0KPiA+ICsg
ICAgIG1hbmFfZ2RfaW5pdF9yZXFfaGRyKCZyZXEuaGRyLCBNQU5BX0lCX0RFU1RST1lfQURBUFRF
UiwNCj4gc2l6ZW9mKHJlcSksIHNpemVvZihyZXNwKSk7DQo+ID4gKyAgICAgcmVxLmhkci5kZXZf
aWQgPSBnYy0+bWFuYV9pYi5kZXZfaWQ7DQo+ID4gKyAgICAgcmVxLmFkYXB0ZXIgPSBtZGV2LT5h
ZGFwdGVyX2hhbmRsZTsNCj4gPiArDQo+ID4gKyAgICAgbWFuYV9nZF9zZW5kX3JlcXVlc3QoZ2Ms
IHNpemVvZihyZXEpLCAmcmVxLCBzaXplb2YocmVzcCksICZyZXNwKTsNCj4gPiArICAgICBtZGV2
LT5hZGFwdGVyX2hhbmRsZSA9IElOVkFMSURfTUFOQV9IQU5ETEU7DQo+ID4gICAgICAgbWFuYV9p
Yl9kZXN0cm95X2VxcyhtZGV2KTsNCj4gPiAgfQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
ZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmgNCj4gPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9t
YW5hL21hbmFfaWIuaA0KPiA+IGluZGV4IGE0Yjk0ZWUuLjk2NDU0Y2YgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFuYV9pYi5oDQo+ID4gKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL2h3L21hbmEvbWFuYV9pYi5oDQo+ID4gQEAgLTQ4LDYgKzQ4LDcgQEAgc3Ry
dWN0IG1hbmFfaWJfYWRhcHRlcl9jYXBzIHsgIHN0cnVjdCBtYW5hX2liX2RldiB7DQo+ID4gICAg
ICAgc3RydWN0IGliX2RldmljZSBpYl9kZXY7DQo+ID4gICAgICAgc3RydWN0IGdkbWFfZGV2ICpn
ZG1hX2RldjsNCj4gPiArICAgICBtYW5hX2hhbmRsZV90IGFkYXB0ZXJfaGFuZGxlOw0KPiA+ICAg
ICAgIHN0cnVjdCBnZG1hX3F1ZXVlICpmYXRhbF9lcnJfZXE7DQo+ID4gICAgICAgc3RydWN0IG1h
bmFfaWJfYWRhcHRlcl9jYXBzIGFkYXB0ZXJfY2FwczsgIH07IEBAIC0xMTUsNiArMTE2LDgNCj4g
PiBAQCBzdHJ1Y3QgbWFuYV9pYl9yd3FfaW5kX3RhYmxlIHsNCj4gPg0KPiA+ICBlbnVtIG1hbmFf
aWJfY29tbWFuZF9jb2RlIHsNCj4gPiAgICAgICBNQU5BX0lCX0dFVF9BREFQVEVSX0NBUCA9IDB4
MzAwMDEsDQo+ID4gKyAgICAgTUFOQV9JQl9DUkVBVEVfQURBUFRFUiAgPSAweDMwMDAyLA0KPiA+
ICsgICAgIE1BTkFfSUJfREVTVFJPWV9BREFQVEVSID0gMHgzMDAwMywNCj4gPiAgfTsNCj4gPg0K
PiA+ICBzdHJ1Y3QgbWFuYV9pYl9xdWVyeV9hZGFwdGVyX2NhcHNfcmVxIHsgQEAgLTE0Myw2ICsx
NDYsMzIgQEAgc3RydWN0DQo+ID4gbWFuYV9pYl9xdWVyeV9hZGFwdGVyX2NhcHNfcmVzcCB7DQo+
ID4gICAgICAgdTMyIG1heF9pbmxpbmVfZGF0YV9zaXplOw0KPiA+ICB9OyAvKiBIVyBEYXRhICov
DQo+ID4NCj4gPiArc3RydWN0IG1hbmFfcm5pY19jcmVhdGVfYWRhcHRlcl9yZXEgew0KPiA+ICsg
ICAgIHN0cnVjdCBnZG1hX3JlcV9oZHIgaGRyOw0KPiA+ICsgICAgIHUzMiBub3RpZnlfZXFfaWQ7
DQo+ID4gKyAgICAgdTMyIHJlc2VydmVkOw0KPiA+ICsgICAgIHU2NCBmZWF0dXJlX2ZsYWdzOw0K
PiA+ICt9OyAvKkhXIERhdGEgKi8NCj4gPiArDQo+ID4gK3N0cnVjdCBtYW5hX3JuaWNfY3JlYXRl
X2FkYXB0ZXJfcmVzcCB7DQo+ID4gKyAgICAgc3RydWN0IGdkbWFfcmVzcF9oZHIgaGRyOw0KPiA+
ICsgICAgIG1hbmFfaGFuZGxlX3QgYWRhcHRlcjsNCj4gPiArfTsgLyogSFcgRGF0YSAqLw0KPiA+
ICsNCj4gPiArc3RydWN0IG1hbmFfcm5pY19kZXN0cm95X2FkYXB0ZXJfcmVxIHsNCj4gPiArICAg
ICBzdHJ1Y3QgZ2RtYV9yZXFfaGRyIGhkcjsNCj4gPiArICAgICBtYW5hX2hhbmRsZV90IGFkYXB0
ZXI7DQo+ID4gK307IC8qSFcgRGF0YSAqLw0KPiA+ICsNCj4gPiArc3RydWN0IG1hbmFfcm5pY19k
ZXN0cm95X2FkYXB0ZXJfcmVzcCB7DQo+ID4gKyAgICAgc3RydWN0IGdkbWFfcmVzcF9oZHIgaGRy
Ow0KPiA+ICt9OyAvKiBIVyBEYXRhICovDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wg
cm5pY19pc19lbmFibGVkKHN0cnVjdCBtYW5hX2liX2RldiAqbWRldikgew0KPiA+ICsgICAgIHJl
dHVybiBtZGV2LT5hZGFwdGVyX2hhbmRsZSAhPSBJTlZBTElEX01BTkFfSEFORExFOyB9DQo+ID4g
Kw0KPiA+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCBnZG1hX2NvbnRleHQgKm1kZXZfdG9fZ2Moc3Ry
dWN0IG1hbmFfaWJfZGV2DQo+ID4gKm1kZXYpICB7DQo+ID4gICAgICAgcmV0dXJuIG1kZXYtPmdk
bWFfZGV2LT5nZG1hX2NvbnRleHQ7DQo+ID4gLS0NCj4gPiAxLjguMy4xDQo+ID4NCg==

