Return-Path: <linux-rdma+bounces-855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13CE8454CD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 11:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB971F2B263
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A7415B0F6;
	Thu,  1 Feb 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HhLeCqJC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2101.outbound.protection.outlook.com [40.107.22.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE24DA19;
	Thu,  1 Feb 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781914; cv=fail; b=bwLcwdSIEqC9lAm42phx6jqzx0NZOA72SBvtYsOxWUkgS9eY2MCsd3iErpc98Nn4NHFT0xsP4p0Z/hOAbGxwwFlimZPnKrMC5fc0noopxa8thuDANx+LWibD+6m2EO5pP73i4TIVpPjKLsumEi/Rg/Oay07H2B8K1QVKaRkdQ5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781914; c=relaxed/simple;
	bh=FPB1OWhbmfzbmpzDyjTXxsp1iw+OuemE+PDQFncMtRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ETq5znf28mqFP/sDVSVFpenJO2GfO6Jg6nS52D0tNJBngyFKq2W9RxE3TXqWSbL52GiJ5Tq9YKqXHYJddThoQrTGB038iZFyUffalACAp0BtsjfCwv1BB0sEu5gQhMwNs8HLMrl7MPTpLbl4sQYLb5HAlI8jrfhMxZCjdkHAthU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=HhLeCqJC; arc=fail smtp.client-ip=40.107.22.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lrdri/BUpm4ZDCWe14bvL4EgQB0IS8IFBmL+/hO+bSVeyYhUdc/7VdXxfpo0/NsxvLH7bWictSOHF/lpS1Ix51W1LtNWcNQ8+PBCA40pNXS1IzrJ9nzaRogPHzmpt96iUYeTVdTo3lXvDkibV/rjCDdqnOUBKH1F0PJsTNuDAvlNsLkwObm3AIz5zYrgM8wEgyLTqeo5WJ0UnZY9voakNmeWAfD8I9CZdO6q1v73cyATt7wYzvff20tL2h7E8f72rSNCvsbL+xjecLa9b9RsiryPg9Bx9KtNZxm/LuE5Y/EglUJweEwgCgzgFAhtv69HNTsrCY6UmnIhpO+Y/dSeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPB1OWhbmfzbmpzDyjTXxsp1iw+OuemE+PDQFncMtRI=;
 b=CttXtPyCinQ1qxJjItJYE+qunm7Xynok7GO3thH/1IF9yHknm7DPSC3GA8bu40YJMGmsfvWjgIkTk4DEhxKlWoNrYEGZOnyH7304921/Oh/8nzC8KozKDm8/TdQ6GwO917jsHSHbZsDkKD0pcoed34AnLc9Hb6+hDHa/BniquXCESc5CA4OSPIPDPDCz2H7Gjjxvcs7tnMSVtWP0iJu/lGvjXnGfph6gkreJegu/iB/LCZ9jYFgjX6V6AvNWau3JQarOE9BIXTuUn/2bw4lHTJa/Xx4JT/t8Em8Yr9G2tu8irVn6vxrd9xeUtq8E/Gx+h52cfIiS/B7qI4Cid6J/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPB1OWhbmfzbmpzDyjTXxsp1iw+OuemE+PDQFncMtRI=;
 b=HhLeCqJCSUP2C5yxwX0ZPJmHCZN2iStGKW+U6QrPruTYZgGvZQJ6D6q7lYb59pG68rejtznex4xQqAj2B7nN8DqaYJzb33VpaGyPiYRrKmg9fT/x+j5ufpI2OykiqmVeY86FhCM2YVmBru6QKcrZdfGH+UXa2bigWU8AJsJNa68=
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com (2603:10a6:10:322::19)
 by DBBPR83MB0614.EURPRD83.prod.outlook.com (2603:10a6:10:533::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Thu, 1 Feb
 2024 10:05:08 +0000
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::a8db:9564:bfb1:181d]) by DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::a8db:9564:bfb1:181d%4]) with mapi id 15.20.7270.003; Thu, 1 Feb 2024
 10:05:08 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v1 4/5] RDMA/mana_ib: Enable RoCE on port 1
Thread-Topic: [PATCH rdma-next v1 4/5] RDMA/mana_ib: Enable RoCE on port 1
Thread-Index: AQHaVDQVXIefiiQAVkGTqp7U4WO3BLD0X5gAgADj6tA=
Date: Thu, 1 Feb 2024 10:05:08 +0000
Message-ID:
 <DU0PR83MB0553677CB52F310AA7CB0F2AB4432@DU0PR83MB0553.EURPRD83.prod.outlook.com>
References: <1706698552-25383-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706698552-25383-5-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB326369CB38C5714D1294FE27CE7C2@PH7PR21MB3263.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB326369CB38C5714D1294FE27CE7C2@PH7PR21MB3263.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=447472f6-7b77-48a6-9d46-53f657f92654;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-31T20:26:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR83MB0553:EE_|DBBPR83MB0614:EE_
x-ms-office365-filtering-correlation-id: 4db86051-c0ff-42b9-f736-08dc230d4567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QjRtrF5iLYugCoCyP7Ew3EHjxado68xAjuc3z6jmEtxG423l2AVfKDqVhbnUIHajw72/U9VVhY0xWcejfxuEUi4/r1N/YFkmJLUMs0N+44N+Lc0AlKTsIoiHvN4K2LLqOYUV6ThxaiyVDdsb6JSqBUn1Ji1Nc+5fI8U7JyDOqzj1+Vp0zbhQyD5zYSIY9Hco0rRAI6vFM7y3P6GNtVmrWSt4ltRUBZwTDS2cT4Bv4CtGPwcBGujvQF18V0SzAp5pCV0R5tsjgmHf5WNQEjuJhUK1ZD/hQcvI4qOMrjt/Fxc4pTYiTyhvlzPguZSJ1G3lhAdylnL8IT8ExDAoXkDDK5eWIr5LqBohlRDlU2Zn0QaWGdpy6NCnAEMPIB2Wf+c+0UnAOCXiSwrV8YVb6C09lj1gCm7xB4e7GV8pjKxEcJvBpljaUoTMw9Pg1EAN6Q122oGYFvjdMawBxF8b16i2g4IeAI8vTX3Dt6rio3ySdUz6HR9U23u2y7M6EQHZwVy/juHVboxfvA8AMw7RgNK/AQe0y9r0jb1KdMhg+OArV6qkag/rcWIwVrdIX/Mm86G9eDlYxZurYP7JjI4wIlUJEEwDCdg1Y+lBOstJ/6P+j7cKWlCz0l4pdwM9modXq0qz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR83MB0553.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(55016003)(41300700001)(54906003)(38070700009)(316002)(66446008)(64756008)(8990500004)(38100700002)(82950400001)(10290500003)(478600001)(9686003)(7696005)(6506007)(83380400001)(82960400001)(71200400001)(66476007)(66556008)(122000001)(33656002)(86362001)(2906002)(5660300002)(110136005)(76116006)(66946007)(4326008)(8936002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHpFZ1UrZDVyRnpKMFdkcnBLSTN4WERkYjBUNHZHUTdMUGpDMWhEQlVmR2Zs?=
 =?utf-8?B?RFlyK1U0Mm9TaHRuV0pKTGpMR2FzcEtKb2hzeG50bnV6bmZpQW5mUWFXOHIw?=
 =?utf-8?B?bmJaVVl0dUhqaGNpdkFWY1pEZXl3M2JUZng2ZEZFTHdMaW5BaDJtczN4TWFG?=
 =?utf-8?B?akxnOFRINWNhL1BiN2F3aWJnUzYwR3FWRktmNC92dldldEt3cTFUVk5sM0Y0?=
 =?utf-8?B?dmlKcUdTUjRyWGc4QTBQR3dJK0VXS3Nyc3QxaFBud2lMS0Z2L1VlR2QxcFFB?=
 =?utf-8?B?ZkZkaDh0U2J2ZUJXNGtLalZxWnkzc1pRbFBKMlFDdmVBMzVPUWlSdlBtbXps?=
 =?utf-8?B?eXJlbVhHSjJBRG1tMm5PTW5zT3N1bVN0eGJVWm5HK1pTQTZKR0VIMVlQeDRO?=
 =?utf-8?B?UzZ1cVBUb2wwcEZWdmNoNXI1b2tES0Q3REZ4bnNoN1FYUUV1MUNqY2I0bVI0?=
 =?utf-8?B?SVI2UUgzbTFmZk5JcG5yTWgwaUs2ZjFQTjIrZHpFWmhhNWdFUk1Dd2ZrQXlY?=
 =?utf-8?B?SHJCakxUSDNXVnRQbUpHbWNpUnVQKzFvYjNpV3B2SmswVUVWeWpIdnJFVThz?=
 =?utf-8?B?dXlVbHZkRkYvTTJOa0tQbThEckQ0ek1tTzdYNVlFNDRDOHZ2NDdrQlRNdU4y?=
 =?utf-8?B?am9uL2Njc2hvUXZWUEgrbkJ4V0wzekVLb0pidXNyb1kxdWFNczJKT04rUzhS?=
 =?utf-8?B?eHZDRzNYZWpvK2c4cGZkbEl6L1dLTWRYRUxSVHppZ0dXQTJYMzRXL1JFNHNG?=
 =?utf-8?B?R0szUjA5YXlINlN2MHRGU3ovNlR1elBTV1ZmMGlWK1hCZ2tINFJybXREMGE3?=
 =?utf-8?B?RiszK2dtY0tVNEZkbG43dXRsejQ1MmFwdmMrYzgvKzViRFNoZlphQlpFQUF4?=
 =?utf-8?B?bmhmTHRTL2ZlUUdIMTZsU3JyL011ZW5ybG9mR01oUHpVb2FJNzdsSFNrcTE3?=
 =?utf-8?B?RUtnbjVJYTNXUkxKQ0tUUVNBd2lhdHlxWGpzdGEzcGxrcGk4MmpZYUFSeDVa?=
 =?utf-8?B?WVh0em5IWjB1czlscGhKYkxrbzdSU1NNam1xMWVYdEFoWkJ6cDVEL2hvVm10?=
 =?utf-8?B?MVl1bmZxUlNrSzdGbGpKTFZlV0t1dTFzc1ZRVWNFL3E4aDg3ZllIbS9XZllS?=
 =?utf-8?B?MUZpc3FObnEyWGJBeEhzWEtNaVl6OGo4RWY3UGdHcWlOa3FIYStUVVQwaHp1?=
 =?utf-8?B?WHBXcm01SFdzN3IvQzlBSEVhZW5CbTVIVHZWd2F3U3pjRDlFQW9qY0N0TFMy?=
 =?utf-8?B?U3h5RzZoUy9YdzM2Z0VvcTluSEVYczIxbkZnaDJMY2tOQmlFUFlrazFmaW14?=
 =?utf-8?B?U0V6YlVNaDdRTStRY3IyajJFRm5zZ0tqMzI2OWovZ0JKOFJmYkMvV2lCTXhr?=
 =?utf-8?B?ODBidmt3ZWxzeFRuZDhneUc3MDlVOHlsWGlvb1A3RVppRzh0SjY5NW9vWXJh?=
 =?utf-8?B?TkhXdU45ZHZaQVpaemhKTlBzK2ExeVQ1RWNyWS9pcnNNZURlNXFNd1ZxbWJv?=
 =?utf-8?B?SUxUWVBuWisrWkFtNnFpb3R4MDk4SnlPQzJlYkRYRXpFb3dKNi9ERXI4cGVB?=
 =?utf-8?B?NzNqNVBxWDUvNzhkdWtxRFhDblpoTFAxcUlwL2FTcUZMcEozUW1hYmVOd1Y3?=
 =?utf-8?B?c3pnUlpxSlh4M21DKzlsOUhPd0Z0NHFVY0c0YnZ0QTRJaDdORGQxZHh5c2xP?=
 =?utf-8?B?QWRPZkZ0QXVRTHRkcDI0bnJkSGR6bDl4NWN3R1VjQ3ZyNXZvbHVvdnpzZW5r?=
 =?utf-8?B?KzFxM0MwbDZaaXUwNlpLRVl0WDhGSTJ4ZEFmOG1wL0szSkY2YWo1d3lXUEdw?=
 =?utf-8?B?MUM4SHpBZ1RyYjMyWk9sT0dRVzB0WXZ5RWhLM1A3amxoTmNDWDVHWTFlOGxr?=
 =?utf-8?B?eDVadGJrOUhnRjREN1FrNTcrY2tJUWRHYjFPcFNWUmFMeGc5d0VGbitoakNZ?=
 =?utf-8?B?bTExWTMwcm8rN25rS1BQTW51dzVIZjI4SE9DWHpOekNVYStRWW9qRlVPb0RV?=
 =?utf-8?B?SHp3bXZhUEhVUFVxcmJ5MlpqOE1kNjJpMUwzWDFzZ0E4YUdJOVN1VEM2R3VE?=
 =?utf-8?Q?O8+Guy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db86051-c0ff-42b9-f736-08dc230d4567
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 10:05:08.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4o3VambvpeWjQT3mbu11geoUfWYonJNG2r0z1YyNa9P6ybvgp4KNV6j5YgymqcaSrkTpRrGKi1q9L0t0grA7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR83MB0614

PiA+IFN1YmplY3Q6IFtQQVRDSCByZG1hLW5leHQgdjEgNC81XSBSRE1BL21hbmFfaWI6IEVuYWJs
ZSBSb0NFIG9uIHBvcnQgMQ0KPiA+DQo+ID4gU2V0IG5ldGRldiBhbmQgUm9DRXYyIGZsYWcgdG8g
YmUgdXNlZCBpbiBHSUQgcG9wdWxhdGlvbi4NCj4gPiBtYW5hX2liIGlzIGF1eGlsaWFyeSBkZXZp
Y2UsIHRodXMgd2UgbmVlZCBHSURzIG9mIHRoZSBtYXN0ZXIgbmV0ZGV2Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbGludXgubWljcm9zb2Z0
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNlLmMg
fCAxNCArKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYWlu
LmMgICB8IDE2ICsrKysrKysrKysrKy0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9ody9tYW5hL2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2luZmluaWJhbmQvaHcv
bWFuYS9kZXZpY2UuYw0KPiA+IGluZGV4IDExYjA0MTAuLmI5ZmYzZmQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvaHcvbWFuYS9kZXZpY2UuYw0KPiA+IEBAIC01Myw2ICs1Myw3IEBAIHN0YXRp
YyBpbnQgbWFuYV9pYl9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZQ0KPiAqYWRldiwgIHsN
Cj4gPiAgCXN0cnVjdCBtYW5hX2FkZXYgKm1hZGV2ID0gY29udGFpbmVyX29mKGFkZXYsIHN0cnVj
dCBtYW5hX2FkZXYsDQo+ID4gYWRldik7DQo+ID4gIAlzdHJ1Y3QgZ2RtYV9kZXYgKm1kZXYgPSBt
YWRldi0+bWRldjsNCj4gPiArCXN0cnVjdCBuZXRfZGV2aWNlICp1cHBlcl9uZGV2Ow0KPiA+ICAJ
c3RydWN0IG1hbmFfY29udGV4dCAqbWM7DQo+ID4gIAlzdHJ1Y3QgbWFuYV9pYl9kZXYgKmRldjsN
Cj4gPiAgCWludCByZXQ7DQo+ID4gQEAgLTc5LDYgKzgwLDE5IEBAIHN0YXRpYyBpbnQgbWFuYV9p
Yl9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgCWRldi0+aWJf
ZGV2Lm51bV9jb21wX3ZlY3RvcnMgPSAxOw0KPiA+ICAJZGV2LT5pYl9kZXYuZGV2LnBhcmVudCA9
IG1kZXYtPmdkbWFfY29udGV4dC0+ZGV2Ow0KPiA+DQo+ID4gKwlyY3VfcmVhZF9sb2NrKCk7IC8q
IHJlcXVpcmVkIHRvIGdldCB1cHBlciBkZXYgKi8NCj4gPiArCXVwcGVyX25kZXYgPSBuZXRkZXZf
bWFzdGVyX3VwcGVyX2Rldl9nZXRfcmN1KG1jLT5wb3J0c1swXSk7DQo+ID4gKwlyY3VfcmVhZF91
bmxvY2soKTsNCj4gDQo+IFNob3VsZCBjYWxsIHJjdV9yZWFkX3VubG9jaygpIGFmdGVyIHVwcGVy
X25kZXYgaXMgdXNlZCBhbmQgbm8gbG9uZ2VyDQo+IG5lZWRlZCwgb3IgaXQgY291bGQgYmUgZnJl
ZWQgYWZ0ZXIgc29tZW9uZSBjYWxscyByY3Vfc3luY2hyb25pemUoKS4NCj4gDQoNClRoYW5rcyEg
SSB3aWxsIHVubG9jayByaWdodCBhZnRlciB0aGUgbmV0ZGV2IGlzIHNldC4gSSB3aWxsIGFkZHJl
c3MgaXQgaW4gdGhlIHYyLg0KDQo+ID4gKwlpZiAoIXVwcGVyX25kZXYpIHsNCj4gPiArCQlpYmRl
dl9lcnIoJmRldi0+aWJfZGV2LCAiRmFpbGVkIHRvIGdldCBtYXN0ZXIgbmV0ZGV2Iik7DQo+ID4g
KwkJZ290byBmcmVlX2liX2RldmljZTsNCj4gPiArCX0NCj4gPiArCXJldCA9IGliX2RldmljZV9z
ZXRfbmV0ZGV2KCZkZXYtPmliX2RldiwgdXBwZXJfbmRldiwgMSk7DQo+ID4gKwlpZiAocmV0KSB7
DQo+ID4gKwkJaWJkZXZfZXJyKCZkZXYtPmliX2RldiwgIkZhaWxlZCB0byBzZXQgaWIgbmV0ZGV2
LCByZXQgJWQiLA0KPiByZXQpOw0KPiA+ICsJCWdvdG8gZnJlZV9pYl9kZXZpY2U7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICAJcmV0ID0gbWFuYV9nZF9yZWdpc3Rlcl9kZXZpY2UoJm1kZXYtPmdkbWFf
Y29udGV4dC0+bWFuYV9pYik7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gIAkJaWJkZXZfZXJyKCZk
ZXYtPmliX2RldiwgIkZhaWxlZCB0byByZWdpc3RlciBkZXZpY2UsIHJldCAlZCIsDQo+IGRpZmYg
LQ0KPiA+IC1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYWluLmMNCj4gPiBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+IGluZGV4IDNlMDVhNjIuLjY0NWFi
ZjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+
ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+ID4gQEAgLTQ2Miwx
MSArNDYyLDE5IEBAIGludCBtYW5hX2liX21tYXAoc3RydWN0IGliX3Vjb250ZXh0DQo+ICppYmNv
bnRleHQsDQo+ID4gc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpICBpbnQgbWFuYV9pYl9nZXRf
cG9ydF9pbW11dGFibGUoc3RydWN0DQo+ID4gaWJfZGV2aWNlICppYmRldiwgdTMyIHBvcnRfbnVt
LA0KPiA+ICAJCQkgICAgICAgc3RydWN0IGliX3BvcnRfaW1tdXRhYmxlICppbW11dGFibGUpICB7
DQo+ID4gLQkvKg0KPiA+IC0JICogVGhpcyB2ZXJzaW9uIG9ubHkgc3VwcG9ydCBSQVdfUEFDS0VU
DQo+ID4gLQkgKiBvdGhlciB2YWx1ZXMgbmVlZCB0byBiZSBmaWxsZWQgZm9yIG90aGVyIHR5cGVz
DQo+ID4gLQkgKi8NCj4gPiArCXN0cnVjdCBtYW5hX2liX2RldiAqbWRldiA9IGNvbnRhaW5lcl9v
ZihpYmRldiwgc3RydWN0DQo+IG1hbmFfaWJfZGV2LA0KPiA+IGliX2Rldik7DQo+ID4gKwlzdHJ1
Y3QgaWJfcG9ydF9hdHRyIGF0dHI7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWVyciA9
IGliX3F1ZXJ5X3BvcnQoaWJkZXYsIHBvcnRfbnVtLCAmYXR0cik7DQo+ID4gKwlpZiAoZXJyKQ0K
PiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKw0KPiA+ICsJaW1tdXRhYmxlLT5wa2V5X3RibF9sZW4g
PSBhdHRyLnBrZXlfdGJsX2xlbjsNCj4gPiArCWltbXV0YWJsZS0+Z2lkX3RibF9sZW4gPSBhdHRy
LmdpZF90YmxfbGVuOw0KPiA+ICAJaW1tdXRhYmxlLT5jb3JlX2NhcF9mbGFncyA9IFJETUFfQ09S
RV9QT1JUX1JBV19QQUNLRVQ7DQo+ID4gKwlpZiAocG9ydF9udW0gPT0gMSAmJiBybmljX2lzX2Vu
YWJsZWQobWRldikpDQo+ID4gKwkJaW1tdXRhYmxlLT5jb3JlX2NhcF9mbGFncyB8PQ0KPiA+IFJE
TUFfQ09SRV9QT1JUX0lCQV9ST0NFX1VEUF9FTkNBUDsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+
ID4gIH0NCj4gPiAtLQ0KPiA+IDEuOC4zLjENCg0K

