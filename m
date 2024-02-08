Return-Path: <linux-rdma+bounces-982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682484E8AA
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 20:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF5B2C9F3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 19:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E131755;
	Thu,  8 Feb 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h6xjUdBq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2109.outbound.protection.outlook.com [40.107.104.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963033CFB;
	Thu,  8 Feb 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418392; cv=fail; b=UWUa2dmnvQiPPVG0QAezUon/OTSNAgY6mrj6xEbvttLLVSWtVpJVy3BYHhQaBJPHarG9BfmTD1rlYYrC8ykyRv1SyzH5O/tCxbhsvrSg8JSmPk6a3+52LcqnqSNVKHWooTZC4AyE9757YxwcR3wZKpnx92kEgNndalDqRTlGU8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418392; c=relaxed/simple;
	bh=PCjDrPJsa/S5+zTkqjJm5mZhzkHTyL7TBFGEAuXlUcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SonZevO5AZrOV5OYOLSm+Z59dlla+CZLXtUcn6hQ9M4aGG0vb27kIgm9wUWkPT/81LAAJPEGHngsHJWn42HsvGbt8RacYgs2xCDOTAlClLJLJWUJSN8KxuzouG5VG7lMwLJwFgyEjUC/VJfkmWyvsvJRlxG+Vh2RAJbN9FZ9yH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=h6xjUdBq; arc=fail smtp.client-ip=40.107.104.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKnKVGxhiTdmCTbY8PE965riMk+m7ighjNGAOn6Szx71cX0waLdt9KKCQ93tAAa45pUJvDHwNjnppZornHCzSQVyUCwIcC/8y8qDvVjvCGbmiPwKappv0CV2Tn6M6GoBprMpluUcZU8sh0n5mzf+AT2ltkbFd4nK4d0JBDTwah5QsTU8FY8eaqNBEIiHdEjYia1EkvtkuyinVMmWeFDfUCuke2cdei8brr3YXncW6rZCjMVczAAKva6DSOS64E2PV370hkJdHrMcxpnwsF4SDPgVbbajX57CfSXb5aI5JRolatyxzG8TyCf6cBtA4MC105OwUaurB5srWtBx4f0Rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCjDrPJsa/S5+zTkqjJm5mZhzkHTyL7TBFGEAuXlUcE=;
 b=ZteJyO1rmK3hnDDSNZPV0zeOFTM9WdUaCYBEIgNjIHUAksbGXlVy9fbFnNdqHKRJ4wAb1P7rg8fVFHLo0uTzfCFesRIDAqRKEAIybf4/HqY0nNEvXi7CAZf7MhYFsCu50iZmpQvOWcm1gyB+B6RyoBeB/Si78Aon/HfrT9uZ1Ckn2Wlw+9RciISLbYiNpHknbXBB7sPJXT1sIMvyCkQPwKpvDIWIAdpwX5s43dOWbT5ImoA7XK3B0e+DFeeplMO+tDcEN3tiKjOO7kUxANHfT1ufURgtgzB5mTyLeKq9i7OPD3uB8IloKV7Nv7etE2iQBNEtekpzSwGDY02w1CNGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCjDrPJsa/S5+zTkqjJm5mZhzkHTyL7TBFGEAuXlUcE=;
 b=h6xjUdBqL49qwCcU+KHoWN0LFiNkI2BtSi4dIDWs0g2IKz6JvEJfAPeqQoc894GwigUihs1ODx0H+QInXtEXzETRVLwkIsWOn9O8W/ut6JMMSAATRTixRDn5T9YUbXEf4o4F5A98uEzr2J84wO0dvPB5xuHOUSna20x/iWz3h9c=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by GV1PR83MB0573.EURPRD83.prod.outlook.com (2603:10a6:150:164::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.7; Thu, 8 Feb
 2024 18:53:05 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::209d:228b:661b:cc60]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::209d:228b:661b:cc60%6]) with mapi id 15.20.7292.001; Thu, 8 Feb 2024
 18:53:05 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of dma
 regions
Thread-Topic: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of
 dma regions
Thread-Index: AQHaWderjoPSz0yqiU2OXZSPMQzlRrEAyY2AgAAAyGA=
Date: Thu, 8 Feb 2024 18:53:05 +0000
Message-ID:
 <PAXPR83MB0557C2779B1485277FD7E417B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1707318566-3141-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB326394A06EF49FF286D57B63CE442@PH7PR21MB3263.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB326394A06EF49FF286D57B63CE442@PH7PR21MB3263.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=289b4371-128b-4703-b0ba-3eec5406477d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-08T18:40:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|GV1PR83MB0573:EE_
x-ms-office365-filtering-correlation-id: 93750510-808a-456f-a8f1-08dc28d72f68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H31UMwkHrMKesxvDcWRzo78Dgpo/640/DthKd0W+j9b7vbS9819jNNZBklH2aL1qPV20nWm5N7LZI7OWc2718piZ3fcsKdPlfPeffxFKDeSNLldlrXKLf0yEmyA/iA+f6k64iqEwgvdAwLmuVUa3aXOQYt3o2lz37p4h1VG2uGbjBCLtgPkiuuzaASsW2rTeHvUG/a+yKi4ZtD71f3vDOgY8jPuZtyANCAZrds6RNL459pH51SpWsmnz7Q4dHo8a/CWbgMP7483dMogYs+yxVVZoV9vU+AR05VVfqCqPRIYtvDVbavdQ8nhQWjV0oKM3sq1S+gbPm/8isn2VZlke51Ppu1wCF8hLzdwbscqWJYfMIQ3QJs8EjEmFK3EKTHXrLjyLoWhfAz87wTJiguGV6w/6qNICQQNI0hn4fjX08uuAhJKB4w+5CycEI2MJZZK3yMJeNP4g9w6F+Rak/c/B3+i21bj8DhhaBi/xLPhDm6Xj+U7U4eevVjC4CZGI310ZExWOD27TP5Z+zIYsotCL2DPWYV+ymamFMdlxhfFZZx3b+QCrkUzUztY9qTIWLzRzeBzfr34zoW4Jdc+4xCoc6Ku1BH4FGdmiTOdRcCP6mELM3GBRyA1saL48XALoH3+c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(76116006)(478600001)(53546011)(66556008)(71200400001)(6506007)(10290500003)(7696005)(110136005)(66476007)(9686003)(66446008)(8990500004)(64756008)(41300700001)(26005)(52536014)(316002)(5660300002)(8676002)(4326008)(2906002)(54906003)(8936002)(38070700009)(86362001)(33656002)(82960400001)(82950400001)(122000001)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VU9zL01jdEtyUmQ0cUlKUHdNZzkweExZdWEvVStLK2pLUXZzTFBGY1ZOZ0x5?=
 =?utf-8?B?NDVoV2NybjYrNmR1b2x6SFRycHplZFVHWDh6RHg0WDlwaTdtS0tWN2pKM1ht?=
 =?utf-8?B?emtSTVZTcFU2ZWllRDBFaCtRbXh2ZzJGUWh4NDdDVHVkRHhjcFV6YVNacW02?=
 =?utf-8?B?dWpEMTBVU2I2OW5jSTlOalIzYXJwVjFReEVHU3lQcnBILzUvV2tFZDl6d3Bu?=
 =?utf-8?B?KzFGWDBFYWNwTlZNVVhvUHdmRUVXK205TXR5MlFJbmtJOEJNYWpQUUQ5ZnFo?=
 =?utf-8?B?Y2RTV0FQblNBL051VFZ2YVNzREV1RFBLL3NCLytobXZXSndZWmM4THVRUDdq?=
 =?utf-8?B?SkFIY2tjc2djOWpRQW1wSmdSdnppZ3hBaUZTTzNVN0V4NEc2bElpYUNvb3Ex?=
 =?utf-8?B?WkF5NGZvcWZYWXA0Mjd4dEZyUGlSYytKeVZGRXBkRU5XV1ErNXVuWUpjZ0FX?=
 =?utf-8?B?Y1dJd2REcWFHY2pVUzlWSTYvUU5CSWFYdkc5Y2pMVE1LK2VQSWV2cW85aFNa?=
 =?utf-8?B?bFdLMTl4bzEwcWdrUG5HaTIrUWlzUGQ5YVZuSC96N09KNVFEOVpRUzZLdW1j?=
 =?utf-8?B?c2lPQ2RWL3ZBQUNHYklQVHN0K2pCb0JRZEZTVVl5WnNpb0dVdXZMdDdJMmEr?=
 =?utf-8?B?L3k1T2thL0ErVVBidWZKMndwbmxDem1uMVp3UVJPVzdXemE2NjNjcGZBZU1E?=
 =?utf-8?B?MC9QdkNrQ0k2dFhzT05KVUN0bnJ4NFYvNWtkN3RmcG42STZ3RFo3Tm1BcXJB?=
 =?utf-8?B?UVNpcHEyOHgyOUpKdUVWZElPUll1T2pLc0N6NWhrckxnSWxCZnk0aXlIVHI1?=
 =?utf-8?B?dkhQa1FKUTlyUkZVTmxHbW90ZWNMT1NVVHQ2ekRmd0NFczBiUGhFMFVBcWNN?=
 =?utf-8?B?N2x0Vnp2K1Z3K0tvZHpHRS82akZoU21uMmFEcWd0c1hXZmNLRDNXRWllSk9a?=
 =?utf-8?B?S0VYUGJ1MnpwVmRXWHFVeC9ndzVjZDFTb2I3eURDQ2xqZE8zZ000aEdRZXpk?=
 =?utf-8?B?RUlJSFQ4VmhSQjgvVjhDRTNjNWRabUZqOFo1OWdpZkt3Qm1kUmxDYklxRXh3?=
 =?utf-8?B?T0RiZnE4V1RUeUdjTzM3aFBkdlNtK055bXpJNzIxSmpUeDZNM3I0K1ZGUXQw?=
 =?utf-8?B?VXpiQjQ4UW1ZYkdwbHc1Vm5lNVlrZng1ZWNmQkoxckZjUEloOW1XdW50Q0FX?=
 =?utf-8?B?dTE0Qk5jZ0VxejRqVmJucHo1ZXNwd0tSb3dGZ0tUb1RXdGNtdzdBeUcxYW03?=
 =?utf-8?B?U291TDVUOGVlNjkrRzNzNkhKQVFZYzl3VVBaQWFSakhYM096d2ZqNFp6UjRm?=
 =?utf-8?B?MWluU1F2WnRBWnVqR0JEc29uQnp3WWhLTFl3VDBBbDJVNlJGbGQwbUhUalFs?=
 =?utf-8?B?ZlhKaWtrcldIUkV5RHlwMTRwbk85ZlpDZzlLb0N3OEJtNFhzcUJSVGRKRnNZ?=
 =?utf-8?B?WDdudzFsdkJzZmhqV1dEYnpBcS9nTnlBVUNSbkYxS0N0TU8xQnRENkZSRmRU?=
 =?utf-8?B?VzZoODV6VStQeVhSRmtPb0NUWVIwYk5FREVBdXZtaHlsRWt6N0ljUndVb0NT?=
 =?utf-8?B?S05iWUNBQm4rai9QVWFHNS9Penk2S1ErWHh1NTR6Q2RWWlo2c3JjRjN3Z2ph?=
 =?utf-8?B?V1l2cW1XemFQL3NrMjd2bzdFa2cvdDRQMGF5aTRnNzU1Q2lOdTRmL1dtdzh2?=
 =?utf-8?B?bGFzVkM5VGtUd1M3c1dqVGVrY2c2aGtqQW5jc2NFOXkzSUtGM3NydER5QitH?=
 =?utf-8?B?d3Q2dTZmaTZQeHFTdDE3QktjeGxtQ3grTkhvVTFjTzlyczlHbEtGYldJMGFu?=
 =?utf-8?B?UU5Rb2dPZzNOdkFHaEVXK21JSHZDY3cyOVNHVzhzVEJqa0Q0clJ5SVZOWFht?=
 =?utf-8?B?blpQL09XTHMvVnNad3Rwc1NqOUtSYnBzbWt5TVRya2JyYmhqb1NVVytlNHVN?=
 =?utf-8?B?N0dyQzJWbzViV0NJOEY1NXM2c2ZRMkkzWWdLTTNiWVpJTHdWS1hPM3hPR2oy?=
 =?utf-8?B?ZVB3ZDQrZ3J1ajkrNXdPMFZZVThmVUJTUXVFdmtkZFVWanFnMEo4QjB0b3Y2?=
 =?utf-8?Q?lOS5A1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93750510-808a-456f-a8f1-08dc28d72f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 18:53:05.7661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6nkiD6PQ0N7o5MkYfSmhGYzHsX39UJLXow3nlFEwKYGBP2ovTHBHT19OrE5Af+3j2UZHmcQFqZ5rchtmwsobQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0573

PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IDggRmVicnVhcnkgMjAyNCAxOTo0Mw0KPiBUbzogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFu
b3ZAbGludXgubWljcm9zb2Z0LmNvbT47IEtvbnN0YW50aW4NCj4gVGFyYW5vdiA8a290YXJhbm92
QG1pY3Jvc29mdC5jb20+OyBzaGFybWFhamF5QG1pY3Jvc29mdC5jb207DQo+IGpnZ0B6aWVwZS5j
YTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHJkbWEtbmV4
dCB2MSAxLzFdIFJETUEvbWFuYV9pYjogRml4IGJ1ZyBpbiBjcmVhdGlvbiBvZg0KPiBkbWEgcmVn
aW9ucw0KPiANCj4gPg0KPiA+ICAJLyogSGFyZHdhcmUgcmVxdWlyZXMgZG1hIHJlZ2lvbiB0byBh
bGlnbiB0byBjaG9zZW4gcGFnZSBzaXplICovDQo+ID4gLQlwYWdlX3N6ID0gaWJfdW1lbV9maW5k
X2Jlc3RfcGdzeih1bWVtLCBQQUdFX1NaX0JNLCAwKTsNCj4gPiArCXBhZ2Vfc3ogPSBpYl91bWVt
X2ZpbmRfYmVzdF9wZ3N6KHVtZW0sIFBBR0VfU1pfQk0sIHZpcnQpOw0KPiA+ICAJaWYgKCFwYWdl
X3N6KSB7DQo+ID4gIAkJaWJkZXZfZGJnKCZkZXYtPmliX2RldiwgImZhaWxlZCB0byBmaW5kIHBh
Z2Ugc2l6ZS5cbiIpOw0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+ICAJfQ0KPiANCj4gSG93
IGFib3V0IGRvaW5nOg0KPiBwYWdlX3N6ID0gaWJfdW1lbV9maW5kX2Jlc3RfcGdzeih1bWVtLCBQ
QUdFX1NaX0JNLCBmb3JjZV96ZXJvX29mZnNldA0KPiA/IDAgOiB2aXJ0KTsNCj4gDQo+IFdpbGwg
dGhpcyB3b3JrPyBUaGlzIGNhbiBnZXQgcmlkIG9mIHRoZSBmb2xsb3dpbmcgd2hpbGUgbG9vcC4N
Cj4gDQoNCkkgZG8gbm90IHRoaW5rIHNvLiBJIG1lbnRpb25lZCBvbmNlLCB0aGF0IGl0IHdhcyBm
YWlsaW5nIGZvciBtZSB3aXRoIGV4aXN0aW5nIGNvZGUNCndpdGggdGhlIDRLLWFsaWduZWQgYWRk
cmVzc2VzIGFuZCA4SyBwYWdlcy4gSW4gdGhpcyBjYXNlLCB3ZSBtaXNjYWxjdWxhdGUgdGhlIA0K
bnVtYmVyIG9mIHBhZ2VzLiBTbywgd2UgdGhpbmsgdGhhdCBpdCBpcyBvbmUgOEsgcGFnZSwgYnV0
IGl0IGlzIGluIGZhY3QgdHdvLg0KDQoNCj4gPiArDQo+ID4gKwlpZiAoZm9yY2VfemVyb19vZmZz
ZXQpIHsNCj4gPiArCQl3aGlsZSAoaWJfdW1lbV9kbWFfb2Zmc2V0KHVtZW0sIHBhZ2Vfc3opICYm
IHBhZ2Vfc3ogPg0KPiA+IFBBR0VfU0laRSkNCj4gPiArCQkJcGFnZV9zeiAvPSAyOw0KPiA+ICsJ
CWlmIChpYl91bWVtX2RtYV9vZmZzZXQodW1lbSwgcGFnZV9zeikgIT0gMCkgew0KPiA+ICsJCQlp
YmRldl9kYmcoJmRldi0+aWJfZGV2LCAiZmFpbGVkIHRvIGZpbmQgcGFnZSBzaXplIHRvDQo+ID4g
Zm9yY2UgemVybyBvZmZzZXQuXG4iKTsNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKwkJ
fQ0KPiA+ICsJfQ0KPiA+ICsNCg==

