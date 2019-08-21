Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2373D97454
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfHUIDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 04:03:35 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:14610 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfHUIDf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 04:03:35 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7L81eLG010737;
        Wed, 21 Aug 2019 01:03:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=iQUCEyWdePuoqu44aabVE8rNxQGlY76XotR4pDhOQCU=;
 b=LdS8Yg2U783wQi30GYyZc7gvXq/zDEBZo+ynKIVqg7jzowXTtsMh98KZh3QOxa+4FAdr
 SedxMfJSOBf2Uxv72XJV9MF/rnxSL4QuuJPoCV0ZrJUTN8ss154of5e9xyB9rFkCS9LP
 SzS9iQqLjckC4ZZBZ7F4YNz9YIDqgxueexMK14a/iA2Tci4sDX4DHfsKN5Y8RM0DE1fP
 Yhqpr7iCSggTUIKvvZCxiL85UWlQ2aVSo3Y65BtdkfTNuoT8MTrGT8Du2F3ObvG33BiS
 AF7WkbeCfbK6FwWBvvulJXudMWgvidu4aK85f2Lw0AqzdyOrDEEdYi+cvT8o2px/3R/d mg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ugu7fhdhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 01:03:30 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 21 Aug
 2019 01:03:29 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 21 Aug 2019 01:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9YOA+YP0cYIq3Dkdgv46l9j9ktX7lOKVk69eJ9+f+JpWmLzeTcXJS7miM6d02S1FEIBPYy/nfXJBjftVZgkGkNd0huf8YVm7pvaej7v7AogPgoH1dWAcBL6IrHfWgs71zja9y0bd+EV6+yZFscNunSjLIi3spI9l0vmqUSdDm3idODoqmhUBqt0UN1soAgYvNORNhQzA6rPnj+/t2abmHoyMjbcgt9trWbn/ApyWmtFXpTXuc4VYT+u7sTZSAyDOlBHl2v0KcEZ8T7luGiP0UR0FQQeLPnuFV6t8OYkMIo7a1YOGcMkr2boqnwcnpVEs+oA9wb/ka8Ktw0eKaQx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQUCEyWdePuoqu44aabVE8rNxQGlY76XotR4pDhOQCU=;
 b=XVcreHBURRy8XG2mcUa6ykmyaldo1QhJIRXiNhXiKFn+jlCKQFKsw2GDK7gC04TykIaISPFPf8njkBOuwzxWsYfYb7x2Gqsw58ZNvsy8eNjIEQ09pdSmysWEac5jVc66P6xGcKU592t9BnGqe60ruqTwN/d3a1ZaTN7n9yWOWMNY9boqNsIvs+uGMz6Fmx7RWsqC7LoyuEu1OMZd31DpAgcX86QFiUUHpszvj54lwin5d65CW1lvOY8YYCDpduFmTZEuocCjksNASgROV6tbZZl3I8Hlez+rN2sjGIMj7YSGPZgEp74I3iSNJ/SMNxyX4FogAUHwdmumPFQXzw75Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQUCEyWdePuoqu44aabVE8rNxQGlY76XotR4pDhOQCU=;
 b=xP2NSHvrYjeSWfkxV2Z3cn+Q72HIiXZHMmy2OOd040z/gNFdRwRSXZA6/XXiTPeFs5y9ZmPWez4U9s+4O1YRtmmngvpwVV6Nb8iZtQ1+LW5foYXXmGbXoz40DIlv8ZPT4vi9XGeVBGyPMLodT25KXbZuPyghn6ynhd+jkTC3Dzc=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3005.namprd18.prod.outlook.com (20.179.82.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 08:03:24 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 08:03:24 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     Ariel Elior <aelior@marvell.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Thread-Topic: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Thread-Index: AQHVV1GtVvd83t9SYU+cDjHdgZGzk6cEXE6AgADg6bA=
Date:   Wed, 21 Aug 2019 08:03:24 +0000
Message-ID: <MN2PR18MB31827364A5B64323681D1B4BA1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <aca72068-1155-6755-4494-0436a5d5a31f@amazon.com>
In-Reply-To: <aca72068-1155-6755-4494-0436a5d5a31f@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1da1801-2303-4eaa-bd16-08d7260e0a75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3005;
x-ms-traffictypediagnostic: MN2PR18MB3005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB300524EC8A4FDC58D2DB25E5A1AA0@MN2PR18MB3005.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(51914003)(11346002)(4326008)(316002)(54906003)(229853002)(8676002)(66066001)(6436002)(25786009)(55016002)(9686003)(256004)(53936002)(14444005)(7736002)(6246003)(52536014)(8936002)(74316002)(81156014)(305945005)(66556008)(81166006)(99286004)(5660300002)(76116006)(66946007)(64756008)(66476007)(14454004)(66446008)(478600001)(45080400002)(2906002)(2201001)(33656002)(2501003)(53546011)(110136005)(446003)(76176011)(476003)(26005)(486006)(71190400001)(3846002)(6116002)(186003)(102836004)(7696005)(86362001)(6506007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3005;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DV8TSrpZcD8ro2R3rSGmG+D7ljv5XjkWzy5fKX0Jme1Y9Cxd0QYA79gSBTMnM8JcyvS9C+p4RQjRP++yypsyXqDzLs2VFab1QR4jtHd5ET5XYXYLRTq71jqkLZevIUs+7X8Fdloj0kse2sDBfcs0Oy3dSVUyrlYBWLAnQtzvXn8wE3kcwVM2+EehOCNXBTNZquzWq0o4bvfzRIykTyBOoCIb5TQdq41lbO64WLSXaPnuo6rwJvN8qakNC9Jk4EWuZ7WbqK9+FzC8bVXIZ4HOuTS4FFKpX5cY6xKERLOonof+PmmtRq42hGhIqbSYh7vTRcHq6AM+28Szw1CoIP8xp7u9xAsGKigeVUltYhVa2kd7oOSOSEG8UR7t4yImrUi884tK58nS9cOLUTVc3fcRUvhix66clJOzEs0UCXIGDzY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1da1801-2303-4eaa-bd16-08d7260e0a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 08:03:24.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xyUVHYsT4BwFGPxUf21wst/yCvDIhQiyzsTcaDmts2QyMnxkSlq5kmSixuk7rcHUZkvzR1OybaWG4eRL5eEe1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3005
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-21_03:2019-08-19,2019-08-21 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCAyMCwgMjAxOSA5OjMxIFBNDQo+IA0KPiBPbiAyMC8wOC8yMDE5IDE1OjE4LCBN
aWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgdXNlcyB0aGUgZG9v
cmJlbGwgb3ZlcmZsb3cgcmVjb3ZlcnkgbWVjaGFuaXNtDQo+ID4gaW50cm9kdWNlZCBpbiBjb21t
aXQgMzY5MDdjZDVjZDcyICgicWVkOiBBZGQgZG9vcmJlbGwgb3ZlcmZsb3cNCj4gPiByZWNvdmVy
eSBtZWNoYW5pc20iKSBmb3IgcmRtYSAoIFJvQ0UgYW5kIGlXQVJQICkNCj4gPg0KPiA+IFRoZSBm
aXJzdCBmaXZlIHBhdGNoZXMgbW9kaWZ5IHRoZSBjb3JlIGNvZGUgdG8gY29udGFpbiBoZWxwZXIN
Cj4gPiBmdW5jdGlvbnMgZm9yIG1hbmFnaW5nIG1tYXBfeGEgaW5zZXJ0aW5nLCBnZXR0aW5nIGFu
ZCBmcmVlaW5nIGVudHJpZXMuDQo+ID4gVGhlIGNvZGUgd2FzIGJhc2VkIG9uIHRoZSBjb2RlIGZy
b20gZWZhIGRyaXZlci4NCj4gPiBUaGVyZSBpcyBzdGlsbCBhbiBvcGVuIGRpc2N1c3Npb24gb24g
d2hldGhlciB3ZSBzaG91bGQgdGFrZSB0aGlzIGV2ZW4NCj4gPiBmdXJ0aGVyIGFuZCBtYWtlIHRo
ZSBlbnRpcmUgbW1hcCBnZW5lcmljLiBVbnRpbCBhIGRlY2lzaW9uIGlzIG1hZGUsIEkNCj4gPiBv
bmx5IGNyZWF0ZWQgdGhlIGRhdGFiYXNlIEFQSSBhbmQgbW9kaWZpZWQgdGhlIGVmYSwgcWVkciwg
c2l3IGRyaXZlcg0KPiA+IHRvIHVzZSBpdC4gVGhlIGZ1bmN0aW9ucyBhcmUgaW50ZWdyYXRlZCB3
aXRodCB0aGUgdW1hcCBtZWNoYW5pc20uDQo+ID4NCj4gPiBUaGUgZG9vcmJlbGwgcmVjb3Zlcnkg
Y29kZSBpcyBiYXNlZCBvbiB0aGUgY29tbW9uIGNvZGUuDQo+ID4NCj4gPiBFZmEgZHJpdmVyIHdh
cyBjb21waWxlIHRlc3RlZCBhbmQgY2hlY2tlZCBvbmx5IG1vZHByb2JlL3JtbW9kLg0KPiA+IFNJ
VyB3YXMgY29tcGlsZSB0ZXN0ZWQgb25seQ0KPiANCj4gSGV5IE1pY2hhbCwNCj4gDQo+IEkgaGF2
ZW4ndCBoYWQgdGhlIHRpbWUgdG8gcmV2aWV3IHRoZSBwYXRjaGVzIHlldCwgYnV0IEkgZGlkIHJ1
biBpdCB0aHJvdWdoIG91cg0KPiByZWdyZXNzaW9uIGFuZCBnb3Qgc29tZSBkbWVzZyBjYWxsIHRy
YWNlcyBbMV0uDQo+IFRoZXJlIGFyZSBhbHNvIHNvbWUga21lbWxlYWsgd2FybmluZ3MgZm9yIHN1
c3BlY3RlZCBtZW1vcnkgbGVha3MsIGRvbid0DQo+IGhhdmUgdGhlIGZ1bGwgaW5mb3JtYXRpb24g
QVRNIGJ1dCBJIGNhbiB0cnkgYW5kIGV4dHJhY3QgaXQgaWYgbmVlZGVkLg0KPiANCj4gVGhhbmtz
IQ0KPiANCkhpIEdhbCwgDQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIHRlc3RpbmcgYW5kIGZlZWRi
YWNrIQ0KDQpDYW4geW91IHNoYXJlIHNvbWUgbW9yZSBpbmZvcm1hdGlvbiBvbiB0aGUgc2NlbmFy
aW8geW91J3JlIHJ1bm5pbmcgPyANCkRvZXMgdGhpcyBoYXBwZW4gZWFjaCB0aW1lIG9yIGludGVy
bWl0dGVudGx5ID8gDQpDYW4geW91IHNlbmQgbWUgeW91ciAuY29uZmlnID8gYXJlIHlvdSBydW5u
aW5nIGFnYWlucyByZG1hLW5leHQgdHJlZSA/IA0KQ2FuICB5b3UgcmVwcm9kdWNlIHdpdGggZW5h
YmxpbmcgaWJfY29yZSBtb2R1bGUgZHluYW1pYyBkZWJ1ZyBvbiA/IA0KDQpUaGFua3MsDQpNaWNo
YWwNCg0KPiBbMV0gKHRoaXMgaXMgdGhlIGZpcnN0IHRyYWNlIG9mIG1hbnkpDQo+IEJVRzogQmFk
IHBhZ2Ugc3RhdGUgaW4gcHJvY2VzcyBpYl9zZW5kX2J3ICBwZm46MTQxMWY3Ng0KPiBwYWdlOmZm
ZmZlYTAwNTA0N2RkODAgcmVmY291bnQ6LTEgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAw
MDAwMDANCj4gaW5kZXg6MHgwDQo+IGZsYWdzOiAweDJmZmZlMDAwMDAwMDAwKCkNCj4gcmF3OiAw
MDJmZmZlMDAwMDAwMDAwIGRlYWQwMDAwMDAwMDAxMDAgZGVhZDAwMDAwMDAwMDEyMg0KPiAwMDAw
MDAwMDAwMDAwMDAwDQo+IHJhdzogMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIGZm
ZmZmZmZmZmZmZmZmZmYgMDAwMDAwMDAwMDAwMDAwMA0KPiBwYWdlIGR1bXBlZCBiZWNhdXNlOiBu
b256ZXJvIF9yZWZjb3VudCBNb2R1bGVzIGxpbmtlZCBpbjogc3VucnBjDQo+IGRtX21pcnJvciBk
bV9yZWdpb25faGFzaCBkbV9sb2cgZG1fbW9kIGVmYSBpYl91dmVyYnMgaWJfY29yZQ0KPiBjcmMz
Ml9wY2xtdWwgZ2hhc2hfY2xtdWxuaV9pbnRlbCBhZXNuaV9pbnRlbCBhZXNfeDg2XzY0IGNyeXB0
b19zaW1kIGNyeXB0ZA0KPiBnbHVlX2hlbHBlciBidXR0b24gcGNzcGtyIGV2ZGV2IGlwX3RhYmxl
cyB4X3RhYmxlcyB4ZnMgbGliY3JjMzJjIG52bWUNCj4gY3JjMzJjX2ludGVsIG52bWVfY29yZSBl
bmEgaXB2NiBjcmNfY2NpdHQgbmZfZGVmcmFnX2lwdjYgYXV0b2ZzNA0KPiBDUFU6IDI5IFBJRDog
NjI0NzQgQ29tbTogaWJfc2VuZF9idyBOb3QgdGFpbnRlZCA1LjMuMC1yYzEtZGlydHkgIzENCj4g
SGFyZHdhcmUgbmFtZTogQW1hem9uIEVDMiBjNW4uMTh4bGFyZ2UvLCBCSU9TIDEuMCAxMC8xNi8y
MDE3IENhbGwgVHJhY2U6DQo+ICBkdW1wX3N0YWNrKzB4OWEvMHhlYg0KPiAgYmFkX3BhZ2UrMHgx
MDQvMHgxODANCj4gIGZyZWVfcGNwcGFnZXNfYnVsaysweDMxYi8weGRkMA0KPiAgPyB1bmNoYXJn
ZV9iYXRjaCsweDFkMi8weDJiMA0KPiAgPyBmcmVlX2NvbXBvdW5kX3BhZ2UrMHg0MC8weDQwDQo+
ICA/IGZyZWVfdW5yZWZfcGFnZV9jb21taXQrMHgxNTIvMHgxYjANCj4gIGZyZWVfdW5yZWZfcGFn
ZV9saXN0KzB4MWI4LzB4M2UwDQo+ICByZWxlYXNlX3BhZ2VzKzB4NGM2LzB4NjIwDQo+ICA/IHB1
dF9wYWdlc19saXN0KzB4ZjAvMHhmMA0KPiAgPyBmcmVlX3BhZ2VzX2FuZF9zd2FwX2NhY2hlKzB4
OTcvMHgxNDANCj4gIHRsYl9mbHVzaF9tbXUrMHg3YS8weDI4MA0KPiAgdGxiX2ZpbmlzaF9tbXUr
MHg0NC8weDE3MA0KPiAgZXhpdF9tbWFwKzB4MTQ3LzB4MmIwDQo+ICA/IGRvX211bm1hcCsweDEw
LzB4MTANCj4gIG1tcHV0KzB4YjQvMHgxZDANCj4gIGRvX2V4aXQrMHg0YzIvMHgxNGQwDQo+ICA/
IG1tX3VwZGF0ZV9uZXh0X293bmVyKzB4MzYwLzB4MzYwDQo+ICA/IGt0aW1lX2dldF9jb2Fyc2Vf
cmVhbF90czY0KzB4YzAvMHgxMjANCj4gID8gc3lzY2FsbF90cmFjZV9lbnRlcisweDIyZC8weDVm
MA0KPiAgPyBfX2F1ZGl0X3N5c2NhbGxfZXhpdCsweDMxZS8weDQ2MA0KPiAgPyBzeXNjYWxsX3Ns
b3dfZXhpdF93b3JrKzB4MmMwLzB4MmMwDQo+ICA/IGtmcmVlKzB4MjIxLzB4MjkwDQo+ICA/IG1h
cmtfaGVsZF9sb2NrcysweDFjLzB4YTANCj4gIGRvX2dyb3VwX2V4aXQrMHg2Zi8weDE0MA0KPiAg
X194NjRfc3lzX2V4aXRfZ3JvdXArMHgyOC8weDMwDQo+ICBkb19zeXNjYWxsXzY0KzB4NjgvMHgy
OTANCj4gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ5LzB4YmUNCj4gUklQOiAw
MDMzOjB4N2Y2MDcyYTNiOTI4DQo+IENvZGU6IEJhZCBSSVAgdmFsdWUuDQo+IFJTUDogMDAyYjow
MDAwN2ZmZTRlMDlhZTY4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6DQo+IDAwMDAwMDAwMDAw
MDAwZTcNCj4gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6
IDAwMDA3ZjYwNzJhM2I5MjgNCj4gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAw
MDAwMDAzYyBSREk6IDAwMDAwMDAwMDAwMDAwMDANCj4gUkJQOiAwMDAwN2Y2MDcyZDI0ODk4IFIw
ODogMDAwMDAwMDAwMDAwMDBlNyBSMDk6IGZmZmZmZmZmZmZmZmZmNzANCj4gUjEwOiAwMDAwN2Y2
MDcyNGVhZDY4IFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA3ZjYwNzJkMjQ4OTgNCj4g
UjEzOiAwMDAwN2Y2MDcyZDI5ZDgwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAw
MDAwMDAwMDANCj4gRGlzYWJsaW5nIGxvY2sgZGVidWdnaW5nIGR1ZSB0byBrZXJuZWwgdGFpbnQN
Cg==
