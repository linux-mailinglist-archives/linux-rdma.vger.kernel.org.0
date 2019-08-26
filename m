Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9E9D2CF
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 17:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfHZPar (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 11:30:47 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41850 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728965AbfHZPan (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 11:30:43 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QFTvDe024769;
        Mon, 26 Aug 2019 08:30:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=bEuZWkSOKWi5WBjSwr7+FUvXac5fG5ezTD6h7ivrnhQ=;
 b=PaKcY9CNDs32AEg0oLMFmMR6BHRjRFXghSFhDELagZnog/gYmluyUU2R7usclDP4aCEb
 FnrcGXVfgwpk81auYg0rWOQjKJrBcsxNH2FPLJF3eBSGbDepm+b+Nf4nLZmzCLQibeMN
 EA6saU9roZPADSJNlycOZ8iJbhO1jUiHPQmz+w7mYMMkn8h8p12WzbqKvYDPUZv1c8hJ
 lduGognyy1SQiz6J8GMo5Yc0BMe+MmIaduPT2bTM2VvsaEZ2/Ds6XbZlQPMkwpWEG7Pi
 52S3IXxqGO9rqMKHPbeJYhQRFTMKwel9qMfTcC8keFllQcseSKjH3/oK6UtQAPR0RkCI 8A== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uk2kpyk95-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 08:30:38 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 26 Aug
 2019 08:30:37 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 08:30:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClGJOYsSXGwHwPR0fZ1PJ4WXpK8v4h2/wBMKcvPnNLCy/yqjFVUmX5+4cJPEnOYM4FgwsIkQ09seQK6q3ZmPFOM/RScZvN9v/SD9AZ3HJ5G7jRqZ6weyCEVgGLik9iUALatLBFGyfBzeM2BHjjYeMEcgfjbanou0yQRrJT8TWaS07ARPGzfa9AvA0o9Q9fALsxp/mBlss7xxIkX9uLjv1+EcJz+v6Qyr2qdm/A0vlir1jHVByy6bG1tGrwjKk8/DRcGSZSqveEzee/qrsFCd71Hl3Yg9gwomeW/OAu1HM1PW8z1yo6ZlDJxMLdXRplEPElEfy9cVVjCk5u44U/MQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEuZWkSOKWi5WBjSwr7+FUvXac5fG5ezTD6h7ivrnhQ=;
 b=PPV6YQob0S7HXYP7spOwlDOPzsOQvudTB6x5VRKc3qr8fOQj9SVAq88P3O/mW10yiHdocDJFPG5LceZxbhRP/wn3KfghZZnhhHabbMBwdAdkTnSNka0b96walQ6y5e+bblP1S3KoyArSSGhF7AdIwxTqAfyzrhjkdL3srn7OyXIYiPA1CE8cw/6PXpawwdK5Fog+PzGpGnFRIwGKJKDKL1TNKDkbMmsrDcdNFuen97mGROxjrkRqW7C/WHZalPARg1mb0jTchERmWoLSGQ4Z+yHmpDA65wg98ulNHhpM3pm/tzI6+STqeoLGetz/eokEwVsaeadYnE/kcpNvLx9mlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEuZWkSOKWi5WBjSwr7+FUvXac5fG5ezTD6h7ivrnhQ=;
 b=YboTeTWoZvgRK12jtFJA0T4PUjDljQmyn+IMAYXbFiduISGR64gxpn9QLhm9SKxuZGuUQMnUqbYVcaNMF/f6Gt+XQ+IjEve+d+qvd64nQAZBrGmq+thANKkWwgRl9I2cZG9X1ERydgG5LMTJi1UVTpk/M1gDQKKzXBczioWnWo4=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2557.namprd18.prod.outlook.com (20.179.84.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 15:30:32 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2199.020; Mon, 26 Aug 2019
 15:30:32 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Thread-Topic: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Thread-Index: AQHVV1GzaBcLwMoagEypYNTXoU3KUacG2nQAgAS1rDCAAgcu0A==
Date:   Mon, 26 Aug 2019 15:30:32 +0000
Message-ID: <MN2PR18MB3182E3EEF6AD329B853E28C1A1A10@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <3b297196-1ef6-c046-d0b2-c68648a50913@amazon.com>
 <MN2PR18MB31820859BDBA0B87D0830935A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB31820859BDBA0B87D0830935A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a26bbff-75f8-4032-0322-08d72a3a555f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2557;
x-ms-traffictypediagnostic: MN2PR18MB2557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB255729A05DF34C86C110DF0DA1A10@MN2PR18MB2557.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(86362001)(186003)(74316002)(305945005)(2906002)(7736002)(6436002)(3846002)(6116002)(33656002)(71190400001)(66556008)(66946007)(66476007)(66446008)(52536014)(64756008)(5660300002)(14444005)(256004)(71200400001)(76116006)(53546011)(6506007)(14454004)(107886003)(6916009)(316002)(99286004)(76176011)(54906003)(7696005)(476003)(486006)(229853002)(53936002)(66066001)(8676002)(8936002)(81156014)(81166006)(9686003)(55016002)(4326008)(25786009)(478600001)(102836004)(446003)(11346002)(26005)(6246003)(130980200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2557;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DY/O2ExtkIweeaxylecm4J9qwAiwhJec9ak+AGobgR5URB2X/Xi4rLIkh8oqQ1iJZgYuBO7L5DqBAaVP1wRQeZKeV87NrRDEJZ3bt3dZkTYPriUCqtv0MWmfD3b07Yv4b0skl0pRCxyhjXeCWGtSXreff/qnAG8B9UZJq0JjRXI6WkJSvSTuz0RyTgdcg2mqbtgsX4HtjpfxgSMOa6FyCwXEzrCbpqO90enqpMg0XUbyyEfalPy2+iZfPjE74vtN3jEG+GY9kxuZdn9EJJ2ziMhlgobgwpCqSx5rMoRSW3Fiin6V90x0Sjo7A36rbJMC37e7/HlGJAvksmbd4kzSYn7Ko3MEDqBznAiGbxbo+7W/cd6fm7YtkO4OrYhPtXWhsAurl6d0ve+XeM7fcxwlZespKCtzM5k0h+hZ2PqegWU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a26bbff-75f8-4032-0322-08d72a3a555f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 15:30:32.3735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M68xQTsU7H9ioFPc+hM/+AH25EdfadBT0NxSVrM2QDz12U7H6cT6Z88vZMPDo7VKs0xQDuDInBTgGon/7tgsJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2557
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_08:2019-08-26,2019-08-26 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgTWljaGFsIEthbGRlcm9uDQo+IA0K
PiA+IEZyb206IEdhbCBQcmVzc21hbiA8Z2FscHJlc3NAYW1hem9uLmNvbT4NCj4gPiBTZW50OiBU
aHVyc2RheSwgQXVndXN0IDIyLCAyMDE5IDExOjM1IEFNDQo+ID4NCj4gPiBPbiAyMC8wOC8yMDE5
IDE1OjE4LCBNaWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+IA0KPiA+ID4NCj4gPiA+ICt2b2lkIHJk
bWFfdXNlcl9tbWFwX2VudHJ5X2ZyZWUoc3RydWN0IGtyZWYgKmtyZWYpIHsNCj4gPiA+ICsJc3Ry
dWN0IHJkbWFfdXNlcl9tbWFwX2VudHJ5ICplbnRyeSA9DQo+ID4gPiArCQljb250YWluZXJfb2Yo
a3JlZiwgc3RydWN0IHJkbWFfdXNlcl9tbWFwX2VudHJ5LCByZWYpOw0KPiA+ID4gKwl1bnNpZ25l
ZCBsb25nIGksIG5wYWdlcyA9ICh1MzIpRElWX1JPVU5EX1VQKGVudHJ5LT5sZW5ndGgsDQo+ID4g
UEFHRV9TSVpFKTsNCj4gPiA+ICsJc3RydWN0IGliX3Vjb250ZXh0ICp1Y29udGV4dCA9IGVudHJ5
LT51Y29udGV4dDsNCj4gPiA+ICsNCj4gPiA+ICsJLyogbmVlZCB0byBlcmFzZSBhbGwgZW50cmll
cyBvY2N1cGllZC4uLiAqLw0KPiA+ID4gKwlmb3IgKGkgPSAwOyBpIDwgbnBhZ2VzOyBpKyspIHsN
Cj4gPiA+ICsJCXhhX2VyYXNlKCZ1Y29udGV4dC0+bW1hcF94YSwgZW50cnktPm1tYXBfcGFnZSAr
IGkpOw0KPiA+ID4gKw0KPiA+ID4gKwkJaWJkZXZfZGJnKHVjb250ZXh0LT5kZXZpY2UsDQo+ID4g
PiArCQkJICAibW1hcDogb2JqWzB4JXBdIGtleVslI2xseF0gYWRkclslI2xseF0gbGVuWyUjbGx4
XQ0KPiA+IG5wYWdlc1slI2x4XSByZW1vdmVkXG4iLA0KPiA+ID4gKwkJCSAgZW50cnktPm9iaiwg
cmRtYV91c2VyX21tYXBfZ2V0X2tleShlbnRyeSksDQo+ID4gPiArCQkJICBlbnRyeS0+YWRkcmVz
cywgZW50cnktPmxlbmd0aCwgbnBhZ2VzKTsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmICh1Y29udGV4
dC0+ZGV2aWNlLT5vcHMubW1hcF9mcmVlKQ0KPiA+ID4gKwkJCXVjb250ZXh0LT5kZXZpY2UtPm9w
cy5tbWFwX2ZyZWUoZW50cnkpOw0KPiA+ID4gKwl9DQo+ID4NCj4gPiBTaG91bGQgdGhpcyBsb29w
IGJlIHN1cnJvdW5kZWQgd2l0aCBhIGxvY2s/IFdoYXQgaGFwcGVucyB3aXRoDQo+ID4gY29uY3Vy
cmVudCBpbnNlcnRpb25zPw0KPiBUaGlzIGlzIGEgZ29vZCBwb2ludCwgdGhhbmtzIGZvciBjYXRj
aGluZyBpdC4NCkdhbCwgYWZ0ZXIgcmV2aXNpdGluZyB0aGlzLCBJIHRoaW5rIHRoZXJlIGlzIG5v
IG5lZWQgZm9yIGEgbG9jaywgdGhlIHhhX2VyYXNlIGlzIHNhZmUNCldoZW4gcnVuIGNvbmN1cnJl
bnRseSB3aXRoIHRoZSBpbnNlcnRpb25zIHVuZGVyIHhhX2xvY2ssIGFuZCBpZiBhbiBlbnRyeSBp
cyBlcmFzZWQNCkR1cmluZyB0aGUgaW5zZXJ0IHRoZXJlIGlzIG5vIGhhcm0uIA0KVGhhbmtzLA0K
TWljaGFsDQo+IA0KPiA+DQo=
