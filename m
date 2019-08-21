Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2928D98012
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfHUQ2C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 12:28:02 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60488 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727962AbfHUQ2C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 12:28:02 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7LGP5U7021117;
        Wed, 21 Aug 2019 09:27:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=OA/7OfCVF7qWqjjPJkH/ZSKnUtxYcO7zP0HATJ5HBQ4=;
 b=SXRbj4us25vUYLQhHA+ikwp1SBUSsLYcWK2kS4cq5+iLuLMuXWAVfrPziBPWG46L1cER
 cpFZbY034xpmbPxM9LjqmiUba1o8+rtIY7NfEMEEECN68Fjzo40tsvUPj9bbM7HwepZb
 ZcRGYk5d1SMs/gS5juAGTCrFPDkClEoyqSKRVsEtwivmsQPSQW79JSjcOrweuOsow8bC
 KragpiEuRlluUY5EBx4Xxbt8hRhFjewVCel1A0n9QyBmPN51b2IZlhM5J6IzwNiB96Xm
 DRqg2n2ERv9/f1ImVvg9xLi9QzJz0qeIVTJYe5xOSGv1A14MhDdPRay1lK1pN8Qeu3lu Ug== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ugu7fk6mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 09:27:57 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 21 Aug
 2019 09:27:56 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 21 Aug 2019 09:27:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxKywFFsmfHHrRpim0RBITaua9U5BBOTMduyl+X+u4EBdAPcj7POniglSAXlHU083AG9X1qK9ODU3GN8c+3XYHcQVy8RW4zjANj37jpN0N6Eznuy3IwtfKJeZCSORdbXZ+JwJBkvE69HgpIZEvCtddcv6ot6PZoR17154juGndwpKI3zPs+USDFmJIBdRon4MrxD7ZD3oEgodpfFKS3sxAcSRuHhE9hSXczUuPorBzjm6wCIzYJN7TdPYzLtKOxzu5GhXa8vGjjIpIHQoJaGrOAREFxG1EK0S1NYzEZHFG0N4x/KmWFRTfWM8YafrnUx6ACGJ3YoYBi5gemi/6gxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA/7OfCVF7qWqjjPJkH/ZSKnUtxYcO7zP0HATJ5HBQ4=;
 b=jdaInJZ1CzHBdSp+kuJdcDZDAybjh9MJXh2dtR/VTnLd1A7dPMVOGWn4jN0IDPc20xyOh1aFeeqkGRsbcGZGMODknabaJKmXImJLCl6AEU4tRSG63SJfotzNiF/yxo+/4s2087rBXP6JP1v9X+HZg5qUazQcIp6BXhnuToVS3WnpuFMAQ3PQRbbn0eEqu8TjUI2qDaNYwiKwdKzbNSR9VzFuUea/EkQbj+pgLC38vvay8R5lcailPc0UGOTCYuaBp+n3bE/vFmdDy/FCPLqmPeUTXwUe8RhAK5+CfCfbdA5q7N+etgAmQdvJAzGUtBjjJAICyuBzo78wECnKV9zZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA/7OfCVF7qWqjjPJkH/ZSKnUtxYcO7zP0HATJ5HBQ4=;
 b=IDCt4B6pvG2QgtrhKbV5Py+rqPnG16DnDIPLYcmxJjgjDPBjWrSqshm1jys2MnSyPxWK88vjYr0QUrbbiollFC8mcb4mwzDk0J0XjLdhoMlSPutOB8gqel8jR/hsgVRjOehpyLHHlzx+Y4q1rdTt+Yex1AQPhjRBi4dNzJpCNJo=
Received: from CH2PR18MB3175.namprd18.prod.outlook.com (52.132.244.149) by
 CH2PR18MB3414.namprd18.prod.outlook.com (52.132.247.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 16:27:54 +0000
Received: from CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::810a:1cbb:1b73:72d5]) by CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::810a:1cbb:1b73:72d5%7]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 16:27:54 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Thread-Topic: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Thread-Index: AQHVV1GtVvd83t9SYU+cDjHdgZGzk6cEXE6AgADg6bCAACbRAIAABB0ggAADIACAAB0DAIAAQreAgAABAiA=
Date:   Wed, 21 Aug 2019 16:27:54 +0000
Message-ID: <CH2PR18MB31759689344B5D0FA5FD5DC3A1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <aca72068-1155-6755-4494-0436a5d5a31f@amazon.com>
 <MN2PR18MB31827364A5B64323681D1B4BA1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <cee52133-ae69-3709-6f3c-187382af054f@amazon.com>
 <MN2PR18MB318297E219BB657ED716C3A3A1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <87468101-ace2-b718-fd1c-aa6d84554773@amazon.com>
 <8470780c-7366-dd71-fcb5-372f2c420e8b@amazon.com>
 <3b7e92ce-d74c-201d-1ed0-31f8fd360d2a@amazon.com>
In-Reply-To: <3b7e92ce-d74c-201d-1ed0-31f8fd360d2a@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aabd44d7-2865-4b52-2d9a-08d7265484ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR18MB3414;
x-ms-traffictypediagnostic: CH2PR18MB3414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB34147841A23A158DAB490786A1AA0@CH2PR18MB3414.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(189003)(51914003)(199004)(71190400001)(53936002)(9686003)(71200400001)(25786009)(102836004)(186003)(55016002)(8936002)(8676002)(81156014)(54906003)(81166006)(99286004)(478600001)(6246003)(229853002)(26005)(7696005)(76176011)(486006)(6916009)(4326008)(4744005)(6506007)(86362001)(446003)(33656002)(52536014)(66446008)(64756008)(66556008)(66476007)(305945005)(66066001)(66946007)(53546011)(316002)(256004)(6436002)(5660300002)(5024004)(2906002)(14444005)(14454004)(74316002)(76116006)(7736002)(11346002)(3846002)(6116002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR18MB3414;H:CH2PR18MB3175.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qYfbX4dyp5sxbeUHn915nGj5Og1NBKeDGEsONBbNjTKxUoEItY5ogLIIoicYi4akA2pQobOzsIUw1xrtGIT55sPPcr+Mo6n9el3tXZGkxuC9Rykv808HwApizBm6a781PChYPEUbogVuGoXI5ybGc/2Ho4pgtK3xtXlPP1ge8zzwagf5YR6/4xcOA/Seq+8B6lhueT/LxCcwltb4uEfXiXswSKM7uohSXoSz/jSjyBN0G88i3SDEAeHpD9UgoRe/5E4rrzNiwPr2no6eNIYf9UCh6M1jryAboom4Y6dZGFdXkUM55e0b4IV5frcxTVUZ8FCcW3zFEnYwa2CCcYA3QznkkEgbBPqcude6AGGMqmZ2kGhhP1GdJWUf1FSnlZJ2grBeBNg1e9hD68VAA/gD5chEpepMIXA9kldOykAoiRM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aabd44d7-2865-4b52-2d9a-08d7265484ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 16:27:54.1376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GCCq+nHCzKnsa6HPz8Qeb350XJxJbLR8wnR6WZ4aCO0sZt7+qcw3PiAEPA87QNyvl1vK5VNZjVq74d4FJsfFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3414
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-21_05:2019-08-19,2019-08-21 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgQXVndXN0IDIxLCAyMDE5IDc6MjQgUE0NCj4gDQo+IE9uIDIxLzA4LzIwMTkgMTU6MjUs
IEdhbCBQcmVzc21hbiB3cm90ZToNCj4gPiBPbiAyMS8wOC8yMDE5IDEzOjQxLCBHYWwgUHJlc3Nt
YW4gd3JvdGU6DQo+ID4+IE9uIDIxLzA4LzIwMTkgMTM6MzIsIE1pY2hhbCBLYWxkZXJvbiB3cm90
ZToNCj4gPj4+IFRoYW5rcyBHYWwsDQo+ID4+Pg0KPiA+Pj4gSSB0aGluayBJIGZvdW5kIHRoZSBw
cm9ibGVtIGZvciB0aGUgaXNzdWUgYmVsb3csIGF0dGFjaGVkIGEgcGF0Y2ggdGhhdA0KPiBzaG91
bGQgYmUgYXBwbGllZCBvbiB0b3Agb2YgdGhlIHNlcmllcy4NCj4gPj4+IFBsZWFzZSBsZXQgbWUg
a25vdyBpZiB0aGlzIGZpeGVkIHRoZSBpc3N1ZXMgeW91IGFyZSBzZWVpbmcuDQo+ID4+PiBJbiBx
ZWRyIHdlIHdvcmsgd2l0aCBvbmx5IHNpbmdsZSBwYWdlcywgYW5kIHRoaXMgaXNzdWUgd2lsbCBv
bmx5IG9jY3VyIHdpdGgNCj4gbXVsdGlwbGUgcGFnZXMuDQo+ID4+DQo+ID4+IFdpbGwgYXBwbHkg
YW5kIHJlcnVuLCB0aGFua3MuDQo+ID4NCj4gPiBJIHNlZSBkaWZmZXJlbnQgdHJhY2VzIG5vdzoN
Cj4gDQo+IFdlbGwgaXQgc2VlbXMgdGhhdCB0aGVzZSB0cmFjZXMgYXJlIHRoZXJlIHJlZ2FyZGxl
c3Mgb2YgdGhpcyBzZXJpZXMsIEkgd2lsbCBkZWJ1Zw0KPiBzZXBhcmF0ZWx5Lg0KPiBZb3VyIGZp
eCBkaWQgbWFrZSB0aGUgb3RoZXIgdHJhY2VzIGRpc2FwcGVhci4NCg0KVGhhbmtzIGZvciB0aGUg
dXBkYXRlLiANCg==
