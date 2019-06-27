Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937C658CEF
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfF0VTR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 17:19:17 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:14098 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbfF0VTR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 17:19:17 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RLAgW6003868;
        Thu, 27 Jun 2019 14:18:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=X/Zv79FrshufWy87m7yfvaDrFdfnMGHISys3ZITbr2U=;
 b=aKhb15FuVoHEGPoi1YPHvIU6z0JxY3tMIUt3iTE097J6zlFzLNENH/DCodLqoqZ6IsR4
 qektV9kCAuMj/JJBOMz5DuEkBa1PcBMt7C9QcH8LG1tooUP3kSYcdbr48Sjx3tbI0M5A
 Y5hY8RtdcYJKIVXtYIGW4hMCOTqv8BscRQ6HB3gTUBkCgN6RLywCnDsBem88mx0wXq7H
 TkbD8m/U0WBLnxGa4wk8Szi/q3/88GkjcWvwpWLE7BXGuE/bErxUvz1tgqBOSzVuWvf6
 0F2+aGPSf74Z0+1JHHlvhttItGW0fiqCnku9LMqt2zKtHl5DgREp0bxpSGz5kTXPx5XA 6w== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tcvrsae9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 14:18:53 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 27 Jun
 2019 14:18:52 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Jun 2019 14:18:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Zv79FrshufWy87m7yfvaDrFdfnMGHISys3ZITbr2U=;
 b=DEaykTeq4mySp9l9nBeCnhrdV5PlE/alLWpFHTu2JidZNXOxj158CPJEIu99HJ75xRRqXm5bwtUshFdRbaTwVLJp4SvrPzrmTSuv3cCJyDHekVkTzvHl4eJ3ppa7bE+14ao1M0t6122jgSluBxr4jdtGEOuu+PQh50qyccS6OYc=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2878.namprd18.prod.outlook.com (20.179.22.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Thu, 27 Jun 2019 21:18:50 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413%3]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 21:18:50 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Index: AQHVLPCe9cWnyNWtL0+HivI8MaeykaavlE6AgABtdcA=
Date:   Thu, 27 Jun 2019 21:18:50 +0000
Message-ID: <MN2PR18MB318211E59713A2885CFB6727A1FD0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <2933b9d9-7b54-78a3-ba1f-e47c354b154e@amazon.com>
In-Reply-To: <2933b9d9-7b54-78a3-ba1f-e47c354b154e@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.10.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33fe1f6a-463a-41ee-37c6-08d6fb450cc7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2878;
x-ms-traffictypediagnostic: MN2PR18MB2878:
x-microsoft-antispam-prvs: <MN2PR18MB2878FFE0391C03DE056E3573A1FD0@MN2PR18MB2878.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(305945005)(33656002)(229853002)(186003)(8676002)(14444005)(476003)(486006)(11346002)(256004)(2501003)(68736007)(4326008)(5660300002)(6636002)(99286004)(7736002)(478600001)(52536014)(8936002)(2906002)(81166006)(81156014)(7696005)(53936002)(53546011)(76116006)(76176011)(66446008)(64756008)(66556008)(6246003)(66946007)(73956011)(6436002)(26005)(6506007)(66476007)(25786009)(74316002)(9686003)(102836004)(446003)(55016002)(3846002)(6116002)(316002)(86362001)(2201001)(66066001)(110136005)(71190400001)(71200400001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2878;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1SeLVKJtT/RwBaDQfhbW5dK8I4AP/W+0BV1vLSxZPetShLLf9nSjSie1jmphdhBR1Ztz2g7FBrwsz00Sf5ibTpiPpgp3tGN8l7CdJWbURQeeAhSuv/uCOIOgvsP0bXxncYynoyPUU6IWYDDcMyX/+bBMlZ4hcuy09nsBH+XOVKhmXmwHcAw84t6afRkDESRnH4F6yYgUxnA9v8B5uvwEsQGOaMpbxn9S5q3RmMpob/gm+NSgur3Il8YzSE5XlITrmOqiMJU5Ies/3Ssmxod7E08M7jLrSl/z1Vvcczd4nP7X+C1bLFsETl2CLEisynaYHEOy3P/7f4LgpbhdZWu8I60HhwDg9XoOe2RQmkZubxqEHJxzrRQI2nYZOsyAhZs08Plw2E2lByOogKuq9JO4f2jcEhkcPwOj6pgltNHkhME=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fe1f6a-463a-41ee-37c6-08d6fb450cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 21:18:50.3702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2878
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_14:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgR2FsIFByZXNzbWFuDQo+IFNlbnQ6
IFRodXJzZGF5LCBKdW5lIDI3LCAyMDE5IDU6NDYgUE0NCj4gVG86IE1pY2hhbCBLYWxkZXJvbiA8
bWthbGRlcm9uQG1hcnZlbGwuY29tPjsgamdnQHppZXBlLmNhOw0KPiBkbGVkZm9yZEByZWRoYXQu
Y29tOyBsZW9uQGtlcm5lbC5vcmc7IHNsZXlib0BhbWF6b24uY29tOyBBcmllbCBFbGlvcg0KPiA8
YWVsaW9yQG1hcnZlbGwuY29tPg0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtSRkMgcmRtYSAxLzNdIFJETUEvY29yZTogQ3JlYXRlIGEgY29tbW9uIG1t
YXAgZnVuY3Rpb24NCj4gDQo+IE9uIDI3LzA2LzIwMTkgMTY6NTgsIE1pY2hhbCBLYWxkZXJvbiB3
cm90ZToNCj4gPiArLyoNCj4gPiArICogTm90ZSB0aGlzIGxvY2tpbmcgc2NoZW1lIGNhbm5vdCBz
dXBwb3J0IHJlbW92YWwgb2YgZW50cmllcywgZXhjZXB0DQo+ID4gK2R1cmluZw0KPiA+ICsgKiB1
Y29udGV4dCBkZXN0cnVjdGlvbiB3aGVuIHRoZSBjb3JlIGNvZGUgZ3VhcmVudGVlcyBubyBjb25j
dXJyZW5jeS4NCj4gPiArICovDQo+ID4gK3U2NCByZG1hX3VzZXJfbW1hcF9lbnRyeV9pbnNlcnQo
c3RydWN0IGliX3Vjb250ZXh0ICp1Y29udGV4dCwgdm9pZA0KPiAqb2JqLA0KPiA+ICsJCQkJdTY0
IGFkZHJlc3MsIHU2NCBsZW5ndGgsIHU4IG1tYXBfZmxhZykgew0KPiA+ICsJc3RydWN0IHJkbWFf
dXNlcl9tbWFwX2VudHJ5ICplbnRyeTsNCj4gPiArCWludCBlcnI7DQo+ID4gKw0KPiA+ICsJZW50
cnkgPSBrbWFsbG9jKHNpemVvZigqZW50cnkpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghZW50
cnkpDQo+ID4gKwkJcmV0dXJuIFJETUFfVVNFUl9NTUFQX0lOVkFMSUQ7DQo+ID4gKw0KPiA+ICsJ
ZW50cnktPm9iaiA9IG9iajsNCj4gPiArCWVudHJ5LT5hZGRyZXNzID0gYWRkcmVzczsNCj4gPiAr
CWVudHJ5LT5sZW5ndGggPSBsZW5ndGg7DQo+ID4gKwllbnRyeS0+bW1hcF9mbGFnID0gbW1hcF9m
bGFnOw0KPiA+ICsNCj4gPiArCXhhX2xvY2soJnVjb250ZXh0LT5tbWFwX3hhKTsNCj4gPiArCWVu
dHJ5LT5tbWFwX3BhZ2UgPSB1Y29udGV4dC0+bW1hcF94YV9wYWdlOw0KPiA+ICsJdWNvbnRleHQt
Pm1tYXBfeGFfcGFnZSArPSBESVZfUk9VTkRfVVAobGVuZ3RoLCBQQUdFX1NJWkUpOw0KPiANCj4g
SGkgTWljaGFsLA0KPiBJIGZpeGVkIHRoaXMgcGFydCB0byBoYW5kbGUgbW1hcF94YV9wYWdlIG92
ZXJmbG93Og0KPiA3YTU4MzRlNDU2ZjcgKCJSRE1BL2VmYTogSGFuZGxlIG1tYXAgaW5zZXJ0aW9u
cyBvdmVyZmxvdyIpDQo+DQpUaGFua3MsIHdpbGwgdGFrZSB0aGUgcGF0Y2gNCiANCj4gPiArCWVy
ciA9IF9feGFfaW5zZXJ0KCZ1Y29udGV4dC0+bW1hcF94YSwgZW50cnktPm1tYXBfcGFnZSwNCj4g
ZW50cnksDQo+ID4gKwkJCSAgR0ZQX0tFUk5FTCk7DQo+ID4gKwl4YV91bmxvY2soJnVjb250ZXh0
LT5tbWFwX3hhKTsNCj4gPiArCWlmIChlcnIpIHsNCj4gPiArCQlrZnJlZShlbnRyeSk7DQo+ID4g
KwkJcmV0dXJuIFJETUFfVVNFUl9NTUFQX0lOVkFMSUQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
aWJkZXZfZGJnKHVjb250ZXh0LT5kZXZpY2UsDQo+ID4gKwkJICAibW1hcDogb2JqWzB4JXBdIGFk
ZHJbJSNsbHhdLCBsZW5bJSNsbHhdLCBrZXlbJSNsbHhdDQo+IGluc2VydGVkXG4iLA0KPiA+ICsJ
CSAgZW50cnktPm9iaiwgZW50cnktPmFkZHJlc3MsIGVudHJ5LT5sZW5ndGgsDQo+ID4gKwkJICBy
ZG1hX3VzZXJfbW1hcF9nZXRfa2V5KGVudHJ5KSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJkbWFf
dXNlcl9tbWFwX2dldF9rZXkoZW50cnkpOyB9DQo+ID4gK0VYUE9SVF9TWU1CT0wocmRtYV91c2Vy
X21tYXBfZW50cnlfaW5zZXJ0KTsNCg==
