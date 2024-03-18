Return-Path: <linux-rdma+bounces-1474-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B087E598
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0611C20410
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CCE28E39;
	Mon, 18 Mar 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I8rPfpZc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2103.outbound.protection.outlook.com [40.107.14.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482762C182;
	Mon, 18 Mar 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753724; cv=fail; b=CXRmSPM6ivQLXxso196ln4H3SWvYmWLJb1a2bzQvlrMZtpjqLfbtGmCNM9aBbkVOcOMR9AObUMDS7Cjw1ViQOCh82sevASzeRJ3ZrEdMBBl3Qa7uprApClKbr5P2FsFsWeSa6DqXX6N4uByl+Ariw7niTv6AQAScRqXVbwGb1dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753724; c=relaxed/simple;
	bh=tk/8P81uObkLCBHkvaVLLd5PRfG6qBWQAeS1d4ZCIyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XIfw+t4XuOfU7IcH5tXfuGDhOeefcOrXfmtXuJtLg/kN8gPlCCbGRKwtaztFcM88bbB0JFdDZzd6fWtrGlU6BnWXPqmod9kmBIwAS7Iz2psrW2zhKRR7krI9VVxqAWBscke2l91OKCYd7Qplisb7stLZ/JuC/+ljXysqBh7dDDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=I8rPfpZc; arc=fail smtp.client-ip=40.107.14.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCgWnjOKE9bERwAoZCbj6m4IWrqz/ZEgHAMSg13YKA9i7KZHVMa6UmSakW8ITddFbSmGgTxNlXnaLOImn6Iu+OGVrU4zI4A+r6lkfwpOwuuf4tKEekmj5NaKnyv3Vi21bZXEozcuknELbI0Yu5KO4tIccXz4ah9FJmmAD6CHmL9ejGo31Gzlhg6DoD6pJg1s4ABLTqBIl6/AnXAtC1OnZvcDCWJNZzomO6PO02o8ey6u+FQTwJSYYGo0GBLntfZL8veTjWBFbKuEbm+x3ApOARdsq1gyupfFPMwiAsb/DXO9KP6jcmyn1quYl6Q4YQJo0BjoHv+ZQBiJa4Q6xpGPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk/8P81uObkLCBHkvaVLLd5PRfG6qBWQAeS1d4ZCIyM=;
 b=CSZKO7G8OwT2WKEk2P4wUnpfQs5L/XHNhVYJLt9EtH8gGxGuL3hLKz7wAxLhomXNxSTzsMLki2+9Ml0zAbww7oFrgnDCjYo55SxQ9kF/F++tByXXnzPfUCeF2VTa1iuVOyylKNWOkaHNW8fBacAW0RTKV8ZLeU3VCnQJ59iMMTYyH4CjtASefo/nL3eH4ZOwR1P0oqpoEAniIUdPDCZ9uex9Fny7SVuUbHvuE+EwjnIx5GnjA7qUB1iolVeSMkqMRIg/KV+Lz4oMZ1aS/SRHw0hOJSl1IJcEyll0Nevj9waIDxc4UnMZSQFqt1Xp81ZIDmXiF6Zf1sao720/zU7HXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk/8P81uObkLCBHkvaVLLd5PRfG6qBWQAeS1d4ZCIyM=;
 b=I8rPfpZcBLkm6wDm4D24rfxpIfxhvss7RxHYEkk3bdZPoDXoyID7clSas7WtEZ+0Rc/5U1uILeMzXCqlyJ7H4FJK4+BhNF9CEQNY99cnpFvrHtKnapMgFKbkmFoPlxJXZjVKBTKQFkdiv+2J0xIvGQnjtwj+KQEZRMFQDu5RkIU=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by GV1PR83MB0573.EURPRD83.prod.outlook.com (2603:10a6:150:164::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 09:21:57 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 09:21:57 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 4/4] RDMA/mana_ib: Use struct mana_ib_queue for
 RAW QPs
Thread-Topic: [PATCH rdma-next 4/4] RDMA/mana_ib: Use struct mana_ib_queue for
 RAW QPs
Thread-Index: AQHadUnghF4FfMjLP0ST2J8XRLpsnLE5CuuAgAQ1XuA=
Date: Mon, 18 Mar 2024 09:21:57 +0000
Message-ID:
 <PAXPR83MB055703CBC2D8F2FEB6E82AF9B42D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710336299-27344-5-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB3457C456D13346088AC78356CE282@SJ1PR21MB3457.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ1PR21MB3457C456D13346088AC78356CE282@SJ1PR21MB3457.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3cfefbec-3478-4290-a2e1-726f68dc64d6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-15T16:59:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|GV1PR83MB0573:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tC5eWXAeW1VygYBvNpumf0gHnv6fElsau2VJGDDN4wTfriiKGJQXxNw5dBRvBY6NY8NrV4giqENhFdLtaShpkUJmpcOf+9XIrBWvm24ObgWjpJPCyCHS6vJcdaEsuVfkQ9Eb871P+/Wd0IzIhuMB9aH7oiZWwaq8vAv9HhGqqxpEzlxHJMPNnYVflBV8anhrI+oyoJzmDC8hza3DB6scHW0t2QBz+/13MR92y6igFlJY6uxmEt592Tb+af/Hy3gT8t8PeXedlQQeajlp8e6ogCXfeXAq6pno4VQHF+WXL1ldxq2t3mb8MP04cFnz2xad2Qz33Wg3q/1apiI06/mNdYhbuTXvRkhTAC4PyXGPol51vZW6KXsG1OdKHWhEwMUsnv0MRrj7rngVgRM+zlqmWZkgqKexc71TK4wv/QorPBuRRVF+3Y4hrVTyeZ2lpoPwtl9OIFJ7VRiP6GcVT5Z8BbJSuSavIvZuDvj6solMzmppLNzAUlNWjxSJ/CGusc550gWM6C5wXPkF0zbvHBt1YF8uic6dt3LDtLvx0NTpD351yMMiLtB7FHw8LypU8JtgmirnVbS7CinvGAwg0l51SrrxLuMPijieXBcGhOzeWSTNAPKSc1tKDbkUOliP2YrMW3NYF0yfeFQdpbdeoOLJTC3CDpbX/SVKbLrtCTnzhoc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjR0Z2tQOXRlR3RHVWF5ZDhUejZwR0JWUnlGMnpOL3F6WFI4Sk1MeHB3Z2dL?=
 =?utf-8?B?b0pvS0h0VXh0ckJGdER2RVdLcXBpZ1lMLzBZN3FrbUtPRjlibkZCOCt2eXZL?=
 =?utf-8?B?L0dXdW55bVQ4bVBtVklLdTg0bjNLYmRHUUdGRGtpbmNqMGZwdzBMVWc2ekE3?=
 =?utf-8?B?Q1N6NllaekVXTU1IbEovUUM5UXFJQkhDakhscjJIZkptZVpwOVp6cmpRbkQ1?=
 =?utf-8?B?d29wYVhyNVFzWkw5aU1xTjEzMEpEU0tiTGhSWTdJYU1qcEVmTURlZVRJeEww?=
 =?utf-8?B?dGxJNDMvVlpPYnlhbktKWXE0T3RGNENKUnJzMzJhVmpXQUM3Sk1mbE9URHU5?=
 =?utf-8?B?RmNyWjZ3ZjVSWlVyVXRnZEZ5U1FmTXZGb29iZ3d2eFE3K00xNUNtRjJXcnpz?=
 =?utf-8?B?K0hVaDR4MUw5bFptSVdjbFNUakJxVEJJQWlTTG16T0NHb2RyMHV3SUIveVF5?=
 =?utf-8?B?ajdSeFlQeHhsZHhkM3BsU2Z2T0hNajBpaHZpQ09CNXhBYTBmbmhnbyt5ZEtS?=
 =?utf-8?B?YW1TNjV0dDV4L1ZyQzZ3UHh3eGZkMWNHbVhndXBUME9Pc1RhWWJaSEl1dEMr?=
 =?utf-8?B?MUdGNmcxOHg4Y0hvRXZlZWE5N1JzUEJMbVpMOGpOVFpmYkJ2WHRmdmFZK0Ir?=
 =?utf-8?B?THRlTVBzb0RNMEhUOUdKNWJWNjljRitWRTlMUmZyWFNkc2Nxbzh0VmRWTzM5?=
 =?utf-8?B?a0hHNm9VL25TU295LzZRUFE0cVgvQVAzM0VUZ3pxajFRK0JXaC96YVdNaUR0?=
 =?utf-8?B?VXJTSDh4b0Q5aU5zZlJyZDN5NE1BNUdHRjl5b0lNQmlOZ0FTZlpLWnF6cG9O?=
 =?utf-8?B?NzM1UnE1Zzc1c2FSeHJ6RUp5VWYxNkV2S0pmejRpeTVWNTFUTHpITnZwM0dE?=
 =?utf-8?B?Q2xTa3R4VmxkaElzT0hLZENqQkxETlV0SWlIMXlHYXRmbCtjclFaREVCamRY?=
 =?utf-8?B?TjRzVjlJb2lJMDlWZGlLcXNlOFdpVVV3VWRaVDJJQzM3aTh4bVhwTEtJaWNi?=
 =?utf-8?B?bk0vcDJLTjVZNW9qQzhsM1lTRTk3NlJiOGYzZ0dJSDFMVDFrYU1PeUxGaDVr?=
 =?utf-8?B?Um5sQzVwNmNxOEtuaXJLaEZKZEFjVDkwNVovVUJQbi90a2VORzFBY0JScmtz?=
 =?utf-8?B?TWY2a0l6SUhJeDNSa0d0d1pkZ1lmbTE0ODBqNng1Mk5OcmdmVTdiWTRjZW0v?=
 =?utf-8?B?RU4rYkNLMG50aFhJa2czSXJ2OFFmYW81WGdaU2VncDBxaFJCT2puS1c5SGU1?=
 =?utf-8?B?VFU2SFJKb283OExCcXFKb3VvR2E2ZFNaL25GZjlKSjhMZk5GcCsxK2pkTnhn?=
 =?utf-8?B?MFRWb1dLQmRDYUdFV05sQmlQOG9OdTVoTU1mbllPaG83QzBWeEpVVXlhNExy?=
 =?utf-8?B?cmNNQUE5dmRRV1NQZmpOajJSVjZzdTNZSGlJVVMzYXE1ZDdoN2ZmdjNzaUNm?=
 =?utf-8?B?L0pDRXF3ZDZQWHZYMGpZWldOVkxReDdWK2VVSGIyRXdCMnhGa1c4d1RGRzBI?=
 =?utf-8?B?eUJWcnhhblV3ZWRjeUcwTUthWWdIbG5PTFNqTnp5bnFRaWNuZXF1U0ZkVWdQ?=
 =?utf-8?B?NEYrSStPbENMTUZLR2dHOHJUa21qUWxqUjg4bFlNMDF2NE01YStUSkloOWlu?=
 =?utf-8?B?cHI2bmw0RVhrODMwQ3JGRnM0L2Ryb08xZStCbHZ1ZVh6MGpYT2QvV1YrdHho?=
 =?utf-8?B?dzcrUUNMcGVxV2lydXRhRGwxMjZ3cWZzQnA5bHZwN1UzUlk4RkxMOTVCNDhB?=
 =?utf-8?B?VWo4eGc4LzdtNUpZU2tMd3k5VjVrbkJ5NTNBZTR3cFY0UWpSMk1nck1KYWNG?=
 =?utf-8?B?aEtqWUx1eXI2MHhFc0tsbHZmT0gzV3ZxZXJaWGdDY2JJOThRUU1SakFYWlhU?=
 =?utf-8?B?eUtmZkFpWWFYb0tDZm8wV0hKb2t6dmk1WmVZOTZZTUpUSUxocXMyVDFmRC9u?=
 =?utf-8?B?eTZ3cmV3QmpML2o3V2Z0WXhqWnFleEEzejFtWjg0RjQ5RDdtM3BxRVltcGJ3?=
 =?utf-8?B?SlhubzJsMXpidE5VcTNlamxSSU1xbnpnYXpUV1JzS1EybXoxNk5FQ0s5U2xS?=
 =?utf-8?Q?BW+jCz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d1966c-c29e-4d6c-4f1d-08dc472cdbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 09:21:57.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjLAPkdmlZ5Do+Vfi6By2FgOpMd4IAU7k0JF/OGvrJ4YaVt0GP2t7K0ru9DO9myazSAS2t728cIu6rpBMP8g7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0573

PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gU2VudDogRnJpZGF5LCAx
NSBNYXJjaCAyMDI0IDE4OjA0DQo+IFRvOiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBs
aW51eC5taWNyb3NvZnQuY29tPjsgS29uc3RhbnRpbg0KPiBUYXJhbm92IDxrb3RhcmFub3ZAbWlj
cm9zb2Z0LmNvbT47IHNoYXJtYWFqYXlAbWljcm9zb2Z0LmNvbTsNCj4gamdnQHppZXBlLmNhOyBs
ZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggcmRtYS1uZXh0IDQv
NF0gUkRNQS9tYW5hX2liOiBVc2Ugc3RydWN0DQo+IG1hbmFfaWJfcXVldWUgZm9yIFJBVyBRUHMN
Cj4gDQo+ID4gK3N0cnVjdCBtYW5hX2liX3Jhd19xcCB7DQo+ID4gKwkvKiBXb3JrIHF1ZXVlIGlu
Zm8gKi8NCj4gPiArCXN0cnVjdCBtYW5hX2liX3F1ZXVlIHF1ZXVlOw0KPiA+ICsJbWFuYV9oYW5k
bGVfdCB0eF9vYmplY3Q7DQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdHJ1Y3QgbWFuYV9pYl9xcCB7
DQo+ID4gIAlzdHJ1Y3QgaWJfcXAgaWJxcDsNCj4gPg0KPiA+IC0JLyogV29yayBxdWV1ZSBpbmZv
ICovDQo+ID4gLQlzdHJ1Y3QgaWJfdW1lbSAqc3FfdW1lbTsNCj4gPiAtCWludCBzcWU7DQo+ID4g
LQl1NjQgc3FfZ2RtYV9yZWdpb247DQo+ID4gLQl1NjQgc3FfaWQ7DQo+ID4gLQltYW5hX2hhbmRs
ZV90IHR4X29iamVjdDsNCj4gPiArCXN0cnVjdCBtYW5hX2liX3Jhd19xcCBzcTsNCj4gDQo+IFdo
YXQncyB0aGUgbmFtaW5nIHNjaGVtZSBmb3IgUkM/IE1heWJlIHVzZSByYXdfc3EgaGVyZT8NCg0K
VGhlIHBsYW4gaXMgdG8gdXNlIHN0cnVjdCBtYW5hX2liX3JjX3FwIGZvciBSQyBRUC4NCkJ1dCBJ
IHRoaW5rIG1hbmFfaWJfcmF3X3NxIGlzIGEgZ29vZCBwcm9wb3NhbCBmb3IgUkFXIHBhY2tldHMu
IEkgd2lsbCBtYWtlIGl0IGluIHYyLg0KVGhhbmtzIQ0KDQo=

