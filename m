Return-Path: <linux-rdma+bounces-891-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E4848FA1
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C61F21932
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0169D241E5;
	Sun,  4 Feb 2024 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WRRKyOSq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2115.outbound.protection.outlook.com [40.107.7.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15122089;
	Sun,  4 Feb 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707067094; cv=fail; b=tzpjKo8VrGQuTHhn5D2LjxfA1/J2uPd2MmvN7zr6eIz9rdlLP40YHCs48wFsCwQjJy79yiHFKjuftKxZbIb8teEOsCS/drqzx0ajq/L+Eji/iXg0xbKMGfzMeCgAmW3AEbX18WLQVzglyTAeeaEjIGl0dxQJJcfiiIeT7dwa0Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707067094; c=relaxed/simple;
	bh=9FsgrLc9Oo6oQGSX3/vpKP4/4OFGl38wZjdKBiW5PvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uKByPcwx+aH5kmNtkW+wCq+qHhRdwXJ1GXmpcehLaEynTl9ozD5hzcHB3f9Ryv4fndtda2JQX7GHv+/yP/re0rD7kLbq1DXExYd+ChE/zgH7nm4mcoaViXTGqhvQtoz4ETYGtmmhyMyACjL1G1HHlGxL1V4EBK+og/4cwXsrCNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WRRKyOSq; arc=fail smtp.client-ip=40.107.7.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaOb5PfCq5Lw0HZlAWGu58NQ5dcTmZPZhjugx8rC3lJwaSTS/9PD9dxjw9M24/czWLw96MwF0/aZ1jum4CzgWRc9wOmpwSG+nucClNyn97BTTPvNLcP/Oh4JU5QK/ve9PKxQMCt8BKV9ZSaxVF6/ovE/1g/EIm0DSfMnPeqtaB1qO3MOCwzGuSjwCO8BcH8uk2esC1UboCkaNnfNO3b5ITDh188VoSP7k6MGunIWWSk2VlBaL3Gf0OpS3FVy8JfYQE35y/FCBVsO4queH/ymyG41i90KF+iv89t7USuVZDNcr2TGwm4SMgTqruv7y737QkaQeDprE7h7hXMwP4MQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FsgrLc9Oo6oQGSX3/vpKP4/4OFGl38wZjdKBiW5PvA=;
 b=XI7v+i5fMPKLl1kJIAobqth6D4gAMafSdVWXMUkB30MQm3jd+lNaFMgGII+r2BLAtP5LJu0FpAwGtWeOilEu3RFCiqIM9Aj+dwzBrViAysmEfWOkT0aBQcWXTcaPVzS04wgEHtNr0zKncZzfh4hVVWvJyeecIKqbBwYF8PNZxHk5Z9BGpm8ZgKzDen6uFg5uR/z9nbPUgPAfkBbkIBX4deaMBgI/Kp401TAlK3Nr5BU3aDyJyHwj3XNWgd9SuFxWcG8EbLFUcZdZdLw14M2dKf/Q/76WydcJor/NT9jSPJnRs9WWilw+ctuSDXGiG5IT9jbYA1Bnemf6bFrCdA5h1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FsgrLc9Oo6oQGSX3/vpKP4/4OFGl38wZjdKBiW5PvA=;
 b=WRRKyOSqSOVQUD2OfeTlowVWZfwn3qWi5H1puZGwE7pDZTjOeO3hzWc/YamCrn0DBRQ4m0Hq7Oghg2KDEv0jnUYVrUWjRkqJwu3MlOWvbHSuORkxH03XvOHDyp192LimcWs2lbXHP96B/5bYNFLIHKa6oeu0CB79Mw7QTT/mwNw=
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com (2603:10a6:10:322::19)
 by DBAPR83MB0406.EURPRD83.prod.outlook.com (2603:10a6:10:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.3; Sun, 4 Feb
 2024 17:18:00 +0000
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::a8db:9564:bfb1:181d]) by DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::a8db:9564:bfb1:181d%4]) with mapi id 15.20.7292.001; Sun, 4 Feb 2024
 17:18:00 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and
 destroy rnic adapter
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and
 destroy rnic adapter
Thread-Index: AQHaVelzQoHpJTBxI0CA3jYtbVkPuLD6H/mAgAA1LyCAABPsAIAABMBw
Date: Sun, 4 Feb 2024 17:17:59 +0000
Message-ID:
 <DU0PR83MB05536AACA6D1E980AD91BD8DB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240204123013.GE5400@unreal>
 <DU0PR83MB0553DF0BA184971EDD66DB0EB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
 <20240204165152.GH5400@unreal>
In-Reply-To: <20240204165152.GH5400@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b8a97f42-5099-4616-be1b-d7708d3ac898;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-04T17:08:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR83MB0553:EE_|DBAPR83MB0406:EE_
x-ms-office365-filtering-correlation-id: ec28ee7e-3522-40d6-c24f-08dc25a53ccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /Va4lHpCa+8IP2seNg3ftZBW8FYQlAeVPMcexWds8DHMymw1XuMNRmLQYVAjY/OLvsBgiW3t7RwEwtHzulMckppFi4KBiQ0CdUKXpLeKCZoDbkkmF7+xLh1KrBR+AQCUYu3B6NMFNzphefWI4B+0ZcohRUIrDHDyUZk/TPikVGD4rZ2lypE1fVMhgY3qQevgwoKZib3ZdvY4UOP3XqKMnldp8Ua//qRRN4pzOw42FJ6P3SRfv6tsorpXEQ+THuy3EcVyWI6BgS28vZ1bas4c6JlBylR+AMmWlBb48aXTNrxYeg3kNhoAzg38pETIgJ9CASb6/3Gy92wKc2s5aTsPpmMOrWdrs19j3+hlls8Fh18mLPef9l8I/j+BVa/z/eHSyqFQv4lzV0G673bb4jvkAWBmGzMoWYCXh/lNOTLXTvfYTySXitENEtFau8DH80nzXkNWGfc8sF8xc7Wg0zjtahhTUZ2s+FbdQIxonZesBf3H9wfg2uG+1pGcm1n1MO4fesRxKBXv5h+oYST99qtCpCFYNT2Md0EIqIRuCCxBhJ1u64++gG3vBQxtyCehKwDsFVhJekR15bqWas4dmXZpLcTb/xpMKuHZHwZrdmYyRrnhONEd0IM+BbNfEI/uOJkY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR83MB0553.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(82950400001)(38100700002)(5660300002)(82960400001)(4326008)(66446008)(66556008)(64756008)(122000001)(52536014)(8676002)(33656002)(8936002)(2906002)(8990500004)(86362001)(10290500003)(478600001)(9686003)(6506007)(7696005)(54906003)(71200400001)(66476007)(66946007)(6916009)(316002)(76116006)(83380400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2gxM3FRelBlQTFYU2hiVWpGdzZPdkpDYnJsQkVGa2ZsWlFmUks4RTF0dEwz?=
 =?utf-8?B?aWFSRVlXa2tBd2hpRHJtV1kzdjlLWDdrR1RUWGY3Q2xPdGt3QitrVTBWWVla?=
 =?utf-8?B?b3VBRUJFdEVHcURuU1BKMktaNlVqODdSVXhoTGVyYXQybThaMGFzaUl3TVZr?=
 =?utf-8?B?RHlhK1BmTkxqTFVjYW94cCsvTVkvOFdTaTc5R0Z6eW9rUFEvYTV6eWd4TzhL?=
 =?utf-8?B?N0dFMFhlRkxDc29iTWZtREVRWUxsMHJzcndkK2NSSWkzUjFWQWhIa1hYOHA3?=
 =?utf-8?B?eU9FRzEwSGpZbjVuZjdNVXRpVFI1M2ROM2pDb0ozYTNzZGx1VHZUdDRCYTdH?=
 =?utf-8?B?M1BBRS9aZkc4aGF3SXZVOHMvNlNLbGFkMm9LSEFrMTdMWGxFNHM1aEsyakV4?=
 =?utf-8?B?U1l2T0U3bWxhNEVwOTJrU0ZwdHNNRVExdEJxSEMvVnYwMlhpRUI5dHRiV3Yz?=
 =?utf-8?B?Y1NOaWMzTzVCS2pzZTRtWU5Eb282alZBQ2IrZ3pPcUxxL1pIUHgyb2R2MlYz?=
 =?utf-8?B?cHFGQXAxQ1NhL2VoeXVwNGU0YkxyckVyNmVOd2lVcE5CQjh4N3BDT0JDTzJY?=
 =?utf-8?B?MzNFZy9NK0dZVVc3RnlDeERqTjZyK2plYmNyR3dTZHo4OTg2WU9HdGRtYnlI?=
 =?utf-8?B?bVA4a2pUL21nRkkzYkN3RjZHeGd1b1FETnErK2tPZTYzcWpYZXhwZ3R3eUlr?=
 =?utf-8?B?NjQxVVBBNzBHajR5aDAvUXJ4bTFPTUlKZEV0SXZwaU1XbjU3U0lGeVNpUGtP?=
 =?utf-8?B?VlE4LzYrVGRieStkN1pkTklnVnZhV2tNWUhZZ1ZxaFVaQjc5eU1IbEUxVlVK?=
 =?utf-8?B?QTdWNG1ZUVhhcXZWS1VxMmtYTHIvRmNjazRxMW5meElrRElYajRscjh6clBY?=
 =?utf-8?B?UFp0TVgzYmlTdTlJYWtwVWl4V0JzZHovWnRJRS9JN3FNWlhxQ2YrVjNjOVdY?=
 =?utf-8?B?QWVDdjV3QUQ0OWEwcVNrUTJYTDFvcEdLNVYvczdMRGsyMzhZclVWTXV3TmZL?=
 =?utf-8?B?T2QyeGtIQUt4cURNTXJ2L3NJNmxrdjZrT01Qa3J3THIrMVQ0NzNCa0ZpVXpU?=
 =?utf-8?B?Z1NuejQ2ZnJvaWdSR1lURC9sQ2hkVGduSkFDQW5YWmtDSlhHQ3BKV0VoTHJw?=
 =?utf-8?B?bFA5ZVE1bk9nZW8xQWs2ekZlRGtaSWErejV4RWZtb1N6TkZRMHJ1QUppRTZ2?=
 =?utf-8?B?WjBEenBvM2M4QUc1dWRJZ240Rk5UbjFMVXdmMW1vQ0ZnenV6ZWVCcWhEaE15?=
 =?utf-8?B?R0ZicXdaV1pCc1hCbFdFeWc1K0pac0FyY1J6TU9mWlNTNnVna1lYRzFXSkE4?=
 =?utf-8?B?VkdaTVlYVlJTcmlvbFQzblUrM1hnRkRCa2NEVXhFTG9KdFRxQUZleWQzSE01?=
 =?utf-8?B?MFVvS2Q1T1BtNUNJaWlVSjVJNWk0RUhYZ3ZxZ1g2LzZVTXlHc0w3dUUyYW10?=
 =?utf-8?B?TmxiZVRvMnVaQitaVHZiVEZsOTRIR2ExM2UyU1g0U3JmcEhxcVVKS1htM0R6?=
 =?utf-8?B?VDI4eDNVU2VHbFBRaXJZc01QYS83aCtDb2FOblg4OEJPZkV4aEY2NkZ6K0hZ?=
 =?utf-8?B?MFB5LzBSZW9xZW1VM0NIMjd5a1pEYjBxRDVjdTQ2aG1TSm5PbnZBQU1OL2J4?=
 =?utf-8?B?MWIrbTlUd0xpcU96TW82ZVpTV0RVOGJITDZVaGdLS1VyNHl4STN2LzYxZzRR?=
 =?utf-8?B?bnhaWnJDNUltcmx4cytnakxIMUFVSnJjRUVlMy9Gamxqcnp0SFVSNHM0bXlG?=
 =?utf-8?B?dWM2eTVZMllBNTRUQnBPanZESDVyWjJ0bXAzOVZFV3pFNTVVdmpzMi9WdkIx?=
 =?utf-8?B?K01FVHBDT1EvWFZZdVdEYi9TSkxNWnVMY09jaEJpSWRjR0NpLzU3ckNJcnJT?=
 =?utf-8?B?aGZDWE9uZldGdk9PMC9ENUhuYkxNOWRjb05JY3JVM3lKdHR1eXd1VGp4OFVF?=
 =?utf-8?B?b0VwY2tsWnhHLzV4dkFzS2IxOXUzejRmeldXTlhlOVdzMzcySWprWnUyYVQy?=
 =?utf-8?B?elJoTHdXV1Nzb0lvT0hjZGhSTmFJZEl4ZEduRzBCT3p4aDFQYUU2cWZ2czJG?=
 =?utf-8?B?alZ5eFJLaGhXNU9sbWtSSjR5QkFPTFhLRzZDM2VyQ0pXV2xPamZWRlczMzF1?=
 =?utf-8?Q?gEmxmbKRi7y2KzweXKVtu4hOs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec28ee7e-3522-40d6-c24f-08dc25a53ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 17:17:59.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EVTTqX8sWlgaSnKwCSh0fwR/Ezinbo7HyUNgdE6BPkkCKn6yKbSUA3e2z8ZNHIdXuBgC8WbprgnCoUhzk7Liw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR83MB0406

PiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4gT24gU3VuLCBGZWIg
MDQsIDIwMjQgYXQgMDM6NTA6NDBQTSArMDAwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0K
PiA+ID4gRnJvbTogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IE9uIEZyaSwgRmVi
IDAyLCAyMDI0IGF0DQo+ID4gPiAwNzowNjozNEFNIC0wODAwLCBLb25zdGFudGluIFRhcmFub3Yg
d3JvdGU6DQo+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBSTklDIGNyZWF0aW9uIGFuZCBkZXN0cnVj
dGlvbi4NCj4gPiA+ID4gSWYgY3JlYXRpb24gb2YgUk5JQyBmYWlscywgd2Ugc3VwcG9ydCBvbmx5
IFJBVyBRUHMgYXMgdGhleSBhcmUNCj4gPiA+ID4gc2VydmVkIGJ5IGV0aGVybmV0IGRyaXZlci4N
Cj4gPiA+DQo+ID4gPiBTbyBwbGVhc2UgbWFrZSBzdXJlIHRoYXQgeW91IGFyZSBjcmVhdGluZyBS
TklDIG9ubHkgd2hlbiB5b3UgYXJlDQo+ID4gPiBzdXBwb3J0aW5nIGl0LiBUaGUgaWRlYSB0aGF0
IHNvbWUgZnVuY3Rpb24gdHJpZXMtYW5kLWZhaWxzIHdpdGgNCj4gPiA+IGRtZXNnIGVycm9ycyBp
cyBub3QgZ29vZCBpZGVhLg0KPiA+ID4NCj4gPiA+IFRoYW5rcw0KPiA+ID4NCj4gPg0KPiA+IEhp
IExlb24uIFRoYW5rcyBmb3IgeW91ciBjb21tZW50cyBhbmQgc3VnZ2VzdGlvbi4gSSB3aWxsIGlu
Y29ycG9yYXRlIHRoZW0NCj4gaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gPiBSZWdhcmRpbmcgdGhp
cyAidHJ5LWFuZC1mYWlsIiwgd2UgY2Fubm90IGd1YXJhbnRlZSBub3cgdGhhdCBSTklDIGlzDQo+
ID4gc3VwcG9ydGVkLCBhbmQgdHJ5LWFuZC1mYWlsIGlzIHRoZSBvbmx5IHdheSB0byBza2lwIFJO
SUMgY3JlYXRpb24NCj4gPiB3aXRob3V0IGltcGVkaW5nIFJBVyBRUHMuIENvdWxkIHlvdSwgcGxl
YXNlLCBzdWdnZXN0IGhvdyB3ZSBjb3VsZA0KPiBjb3JyZWN0bHkgaW5jb3Jwb3JhdGUgdGhlICJ0
cnktYW5kLWZhaWwiIHN0cmF0ZWd5IHRvIGdldCBpdCB1cHN0cmVhbWVkPw0KPiANCj4gWW91IGFs
cmVhZHkgcXVlcnkgTklDIGZvciBpdHMgY2FwYWJpbGl0aWVzLCBzbyB5b3UgY2FuIGNoZWNrIGlm
IGl0IHN1cHBvcnRzIFJOSUMuDQoNCkF0IHRoZSBtb21lbnQsIHRoZSBjYXBhYmlsaXRpZXMgZG8g
bm90IGluZGljYXRlIHdoZXRoZXIgUk5JQyBjcmVhdGlvbiB3aWxsIGJlIHN1Y2Nlc3NmdWwuDQpU
aGUgcmVhc29uIGlzIGFkZGl0aW9uYWwgY2hlY2tzIGR1cmluZyBSTklDIGNyZWF0aW9uIHRoYXQg
YXJlIG5vdCByZWZsZWN0ZWQgaW4gY2FwYWJpbGl0aWVzLg0KVGhlIHF1ZXN0aW9uIGlzIHdoZXRo
ZXIgd2UgY2FuIGhhdmUgdGhlIHByb3Bvc2VkICJ0cnkgYW5kIGRpc2FibGUiIG9yIHdlIG11c3Qg
b3B0IGZvciBmYWlsaW5nIHRoZSB3aG9sZSBtYW5hX2liLg0KDQo+IA0KPiA+DQo+ID4gPiA+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QGxpbnV4
Lm1pY3Jvc29mdC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5k
L2h3L21hbmEvbWFpbi5jICAgIHwgMzENCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21hbmFfaWIuaCB8IDI5
DQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+ID4gPiBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+ID4gPiBpbmRleCBjNjRkNTY5Li4zM2NkNjllIDEw
MDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYWluLmMNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+ID4gPiA+IEBA
IC01ODEsMTQgKzU4MSwzMSBAQCBzdGF0aWMgdm9pZCBtYW5hX2liX2Rlc3Ryb3lfZXFzKHN0cnVj
dA0KPiA+ID4gPiBtYW5hX2liX2RldiAqbWRldikNCj4gPiA+ID4NCj4gPiA+ID4gIHZvaWQgbWFu
YV9pYl9nZF9jcmVhdGVfcm5pY19hZGFwdGVyKHN0cnVjdCBtYW5hX2liX2RldiAqbWRldikgIHsN
Cj4gPiA+ID4gKyAgICAgc3RydWN0IG1hbmFfcm5pY19jcmVhdGVfYWRhcHRlcl9yZXNwIHJlc3Ag
PSB7fTsNCj4gPiA+ID4gKyAgICAgc3RydWN0IG1hbmFfcm5pY19jcmVhdGVfYWRhcHRlcl9yZXEg
cmVxID0ge307DQo+ID4gPiA+ICsgICAgIHN0cnVjdCBnZG1hX2NvbnRleHQgKmdjID0gbWRldl90
b19nYyhtZGV2KTsNCj4gPiA+ID4gICAgICAgaW50IGVycjsNCj4gPiA+ID4NCj4gPiA+ID4gKyAg
ICAgbWRldi0+YWRhcHRlcl9oYW5kbGUgPSBJTlZBTElEX01BTkFfSEFORExFOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICAgICAgIGVyciA9IG1hbmFfaWJfY3JlYXRlX2VxcyhtZGV2KTsNCj4gPiA+ID4g
ICAgICAgaWYgKGVycikgew0KPiA+ID4gPiAgICAgICAgICAgICAgIGliZGV2X2VycigmbWRldi0+
aWJfZGV2LCAiRmFpbGVkIHRvIGNyZWF0ZSBFUXMgZm9yDQo+ID4gPiA+IFJOSUMgZXJyICVkIiwN
Cj4gPiA+IGVycik7DQo+ID4gPiA+ICAgICAgICAgICAgICAgZ290byBjbGVhbnVwOw0KPiA+ID4g
PiAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgIG1hbmFfZ2RfaW5pdF9yZXFfaGRyKCZy
ZXEuaGRyLCBNQU5BX0lCX0NSRUFURV9BREFQVEVSLA0KPiA+ID4gc2l6ZW9mKHJlcSksIHNpemVv
ZihyZXNwKSk7DQo+ID4gPiA+ICsgICAgIHJlcS5oZHIucmVxLm1zZ192ZXJzaW9uID0gR0RNQV9N
RVNTQUdFX1YyOw0KPiA+ID4gPiArICAgICByZXEuaGRyLmRldl9pZCA9IGdjLT5tYW5hX2liLmRl
dl9pZDsNCj4gPiA+ID4gKyAgICAgcmVxLm5vdGlmeV9lcV9pZCA9IG1kZXYtPmZhdGFsX2Vycl9l
cS0+aWQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgZXJyID0gbWFuYV9nZF9zZW5kX3JlcXVl
c3QoZ2MsIHNpemVvZihyZXEpLCAmcmVxLCBzaXplb2YocmVzcCksDQo+ICZyZXNwKTsNCj4gPiA+
ID4gKyAgICAgaWYgKGVycikgew0KPiA+ID4gPiArICAgICAgICAgICAgIGliZGV2X2VycigmbWRl
di0+aWJfZGV2LCAiRmFpbGVkIHRvIGNyZWF0ZSBSTklDDQo+ID4gPiA+ICsgYWRhcHRlciBlcnIg
JWQiLA0KPiA+ID4gZXJyKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICBnb3RvIGNsZWFudXA7DQo+
ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4gKyAgICAgbWRldi0+YWRhcHRlcl9oYW5kbGUgPSByZXNw
LmFkYXB0ZXI7DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICAgcmV0dXJuOw0KPiA+ID4gPg0KPiA+
ID4gPiAgY2xlYW51cDoNCj4gPiA+ID4gQEAgLTU5OSw1ICs2MTYsMTkgQEAgdm9pZCBtYW5hX2li
X2dkX2NyZWF0ZV9ybmljX2FkYXB0ZXIoc3RydWN0DQo+ID4gPiA+IG1hbmFfaWJfZGV2ICptZGV2
KQ0KPiA+ID4gPg0KPiA+ID4gPiAgdm9pZCBtYW5hX2liX2dkX2Rlc3Ryb3lfcm5pY19hZGFwdGVy
KHN0cnVjdCBtYW5hX2liX2RldiAqbWRldikgIHsNCj4gPiA+ID4gKyAgICAgc3RydWN0IG1hbmFf
cm5pY19kZXN0cm95X2FkYXB0ZXJfcmVzcCByZXNwID0ge307DQo+ID4gPiA+ICsgICAgIHN0cnVj
dCBtYW5hX3JuaWNfZGVzdHJveV9hZGFwdGVyX3JlcSByZXEgPSB7fTsNCj4gPiA+ID4gKyAgICAg
c3RydWN0IGdkbWFfY29udGV4dCAqZ2M7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgaWYgKCFy
bmljX2lzX2VuYWJsZWQobWRldikpDQo+ID4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgIGdjID0gbWRldl90b19nYyhtZGV2KTsNCj4gPiA+ID4gKyAg
ICAgbWFuYV9nZF9pbml0X3JlcV9oZHIoJnJlcS5oZHIsIE1BTkFfSUJfREVTVFJPWV9BREFQVEVS
LA0KPiA+ID4gc2l6ZW9mKHJlcSksIHNpemVvZihyZXNwKSk7DQo+ID4gPiA+ICsgICAgIHJlcS5o
ZHIuZGV2X2lkID0gZ2MtPm1hbmFfaWIuZGV2X2lkOw0KPiA+ID4gPiArICAgICByZXEuYWRhcHRl
ciA9IG1kZXYtPmFkYXB0ZXJfaGFuZGxlOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgIG1hbmFf
Z2Rfc2VuZF9yZXF1ZXN0KGdjLCBzaXplb2YocmVxKSwgJnJlcSwgc2l6ZW9mKHJlc3ApLCAmcmVz
cCk7DQo+ID4gPiA+ICsgICAgIG1kZXYtPmFkYXB0ZXJfaGFuZGxlID0gSU5WQUxJRF9NQU5BX0hB
TkRMRTsNCj4gPiA+ID4gICAgICAgbWFuYV9pYl9kZXN0cm95X2VxcyhtZGV2KTsNCj4gPiA+ID4g
IH0NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21hbmFf
aWIuaA0KPiA+ID4gPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21hbmFfaWIuaA0KPiA+
ID4gPiBpbmRleCBhNGI5NGVlLi45NjQ1NGNmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmgNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvbWFuYV9pYi5oDQo+ID4gPiA+IEBAIC00OCw2ICs0OCw3IEBAIHN0cnVj
dCBtYW5hX2liX2FkYXB0ZXJfY2FwcyB7ICBzdHJ1Y3QNCj4gbWFuYV9pYl9kZXYgew0KPiA+ID4g
PiAgICAgICBzdHJ1Y3QgaWJfZGV2aWNlIGliX2RldjsNCj4gPiA+ID4gICAgICAgc3RydWN0IGdk
bWFfZGV2ICpnZG1hX2RldjsNCj4gPiA+ID4gKyAgICAgbWFuYV9oYW5kbGVfdCBhZGFwdGVyX2hh
bmRsZTsNCj4gPiA+ID4gICAgICAgc3RydWN0IGdkbWFfcXVldWUgKmZhdGFsX2Vycl9lcTsNCj4g
PiA+ID4gICAgICAgc3RydWN0IG1hbmFfaWJfYWRhcHRlcl9jYXBzIGFkYXB0ZXJfY2FwczsgIH07
IEBAIC0xMTUsNg0KPiA+ID4gPiArMTE2LDggQEAgc3RydWN0IG1hbmFfaWJfcndxX2luZF90YWJs
ZSB7DQo+ID4gPiA+DQo+ID4gPiA+ICBlbnVtIG1hbmFfaWJfY29tbWFuZF9jb2RlIHsNCj4gPiA+
ID4gICAgICAgTUFOQV9JQl9HRVRfQURBUFRFUl9DQVAgPSAweDMwMDAxLA0KPiA+ID4gPiArICAg
ICBNQU5BX0lCX0NSRUFURV9BREFQVEVSICA9IDB4MzAwMDIsDQo+ID4gPiA+ICsgICAgIE1BTkFf
SUJfREVTVFJPWV9BREFQVEVSID0gMHgzMDAwMywNCj4gPiA+ID4gIH07DQo+ID4gPiA+DQo+ID4g
PiA+ICBzdHJ1Y3QgbWFuYV9pYl9xdWVyeV9hZGFwdGVyX2NhcHNfcmVxIHsgQEAgLTE0Myw2ICsx
NDYsMzIgQEANCj4gPiA+ID4gc3RydWN0IG1hbmFfaWJfcXVlcnlfYWRhcHRlcl9jYXBzX3Jlc3Ag
ew0KPiA+ID4gPiAgICAgICB1MzIgbWF4X2lubGluZV9kYXRhX3NpemU7DQo+ID4gPiA+ICB9OyAv
KiBIVyBEYXRhICovDQo+ID4gPiA+DQo+ID4gPiA+ICtzdHJ1Y3QgbWFuYV9ybmljX2NyZWF0ZV9h
ZGFwdGVyX3JlcSB7DQo+ID4gPiA+ICsgICAgIHN0cnVjdCBnZG1hX3JlcV9oZHIgaGRyOw0KPiA+
ID4gPiArICAgICB1MzIgbm90aWZ5X2VxX2lkOw0KPiA+ID4gPiArICAgICB1MzIgcmVzZXJ2ZWQ7
DQo+ID4gPiA+ICsgICAgIHU2NCBmZWF0dXJlX2ZsYWdzOw0KPiA+ID4gPiArfTsgLypIVyBEYXRh
ICovDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0cnVjdCBtYW5hX3JuaWNfY3JlYXRlX2FkYXB0ZXJf
cmVzcCB7DQo+ID4gPiA+ICsgICAgIHN0cnVjdCBnZG1hX3Jlc3BfaGRyIGhkcjsNCj4gPiA+ID4g
KyAgICAgbWFuYV9oYW5kbGVfdCBhZGFwdGVyOw0KPiA+ID4gPiArfTsgLyogSFcgRGF0YSAqLw0K
PiA+ID4gPiArDQo+ID4gPiA+ICtzdHJ1Y3QgbWFuYV9ybmljX2Rlc3Ryb3lfYWRhcHRlcl9yZXEg
ew0KPiA+ID4gPiArICAgICBzdHJ1Y3QgZ2RtYV9yZXFfaGRyIGhkcjsNCj4gPiA+ID4gKyAgICAg
bWFuYV9oYW5kbGVfdCBhZGFwdGVyOw0KPiA+ID4gPiArfTsgLypIVyBEYXRhICovDQo+ID4gPiA+
ICsNCj4gPiA+ID4gK3N0cnVjdCBtYW5hX3JuaWNfZGVzdHJveV9hZGFwdGVyX3Jlc3Agew0KPiA+
ID4gPiArICAgICBzdHJ1Y3QgZ2RtYV9yZXNwX2hkciBoZHI7DQo+ID4gPiA+ICt9OyAvKiBIVyBE
YXRhICovDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBybmljX2lzX2Vu
YWJsZWQoc3RydWN0IG1hbmFfaWJfZGV2ICptZGV2KSB7DQo+ID4gPiA+ICsgICAgIHJldHVybiBt
ZGV2LT5hZGFwdGVyX2hhbmRsZSAhPSBJTlZBTElEX01BTkFfSEFORExFOyB9DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IGdkbWFfY29udGV4dCAqbWRldl90b19nYyhz
dHJ1Y3QgbWFuYV9pYl9kZXYNCj4gPiA+ID4gKm1kZXYpICB7DQo+ID4gPiA+ICAgICAgIHJldHVy
biBtZGV2LT5nZG1hX2Rldi0+Z2RtYV9jb250ZXh0Ow0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAxLjgu
My4xDQo+ID4gPiA+DQo=

