Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33EE76F1
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403863AbfJ1QqN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:46:13 -0400
Received: from mail-eopbgr730051.outbound.protection.outlook.com ([40.107.73.51]:11584
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733000AbfJ1QqN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 12:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql1KkfYXUFNwGh0oz7ssr8S6EnqfcPBNJxTvvLeBVG2DIl+ttyDgB1ZY1B6MIcM3p7iEmLS1QUt4dEEr0orqF8MO4PEw6y/S4Hi3UacEr91B94wNHh/VjU0xx08uzCaAdWvpw2ZHcM7r5ssnwPsW0A98hwcLIOY1JX1yKf/waOZaxwEyrxmpkLKmOHXKUh372mwa36rOqpt8uJ4M6VcDlNW/rnJNACwdsXwf1LtWfHn8njSmXOW0KvflSYxrOXFVab8uaefj7ejtI0B2WP0AAgcaYing/4KKRyAVUeD8wwTby57mYFpam//Sd5U1HcUB94H7D05V7Cx1EgYgnkAC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGlTxWNo/SijMmSxTzefqrHcJc9NwH110TinPMmo48k=;
 b=IeFkh5dMFRwAfzb3DnsbobmDwQubmsQ7vKRD5HOBmV+Rq7ekVOUZLKwjWtzggJ/JClZDBkump7KVTNPTuwi/WgbmHaf1Vz7WBzbveAs/YLTvUoAvcI7ehxHVXphJfWvD61SU7b/D9gweLI/X204ucIBGYXoTHM162nv8Pn3vh15NCXnyGF4Sk5vHhFtIaIxLwE3rrnMODEpytJQlEN1s/QYWte/Pb7gFu6CK8mqJY4kMlBdr5KO2ThCWVOfcmkXKl1b+jVjYjeHpJosUKpFM39yyNfEX3PzmcHGjUZeuGzGN4hhphZizz4+gxPHhIiYNqxnhYLZ+or98G8pFrQzknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGlTxWNo/SijMmSxTzefqrHcJc9NwH110TinPMmo48k=;
 b=Yea3CF5NRTQUljFEyQHnw8ratZZmR/Ma7+rdjvDCAzsN74WGqaTh5HR7KI1LMRPdhyVGcsdPzHIVyR4RzCmVJQlNM//gZFh3JO2QYbJRjVTmNFljFou8Jc4FTqmmk77xErD6p5qS17gM+Ml1jJbb5/ZHrLxrDUZqDblwi3NF+JQ=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5575.namprd05.prod.outlook.com (20.177.127.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.15; Mon, 28 Oct 2019 16:46:10 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f149:5b68:407b:e494]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f149:5b68:407b:e494%3]) with mapi id 15.20.2408.012; Mon, 28 Oct 2019
 16:46:10 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH v2] RDMA/vmw_pvrdma: Use resource ids from physical device
 if available
Thread-Topic: [PATCH v2] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Index: AQHViRQ9NYXZypIt40K4gJBX9Hr5P6dwRyYAgAAFF4A=
Date:   Mon, 28 Oct 2019 16:46:09 +0000
Message-ID: <8f14c8c9-db10-2bb6-51b8-6e3b8b0167be@vmware.com>
References: <20191022200642.22762-1-aditr@vmware.com>
 <20191028162756.GA16475@ziepe.ca>
In-Reply-To: <20191028162756.GA16475@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:a03:100::14) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35477420-344b-47ba-2346-08d75bc655c4
x-ms-traffictypediagnostic: BYAPR05MB5575:|BYAPR05MB5575:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB55756BD41BFA6DC21C66083EC5660@BYAPR05MB5575.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(31696002)(86362001)(305945005)(36756003)(256004)(71200400001)(71190400001)(476003)(99286004)(6506007)(316002)(2906002)(7736002)(52116002)(14454004)(54906003)(4326008)(66446008)(64756008)(66556008)(66476007)(6512007)(66946007)(31686004)(81156014)(81166006)(8936002)(8676002)(486006)(2616005)(107886003)(386003)(76176011)(6246003)(446003)(6916009)(11346002)(3846002)(478600001)(6116002)(26005)(25786009)(66066001)(5660300002)(102836004)(229853002)(6436002)(186003)(6486002)(53546011)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5575;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQcsZndkhP20b8nc9rRk4DESpC9IFivYVf8obL1sZwE5ZD/ru4Fo6YiObfi7t/9n02O1bxNTxYi+9EuMqqjmJVn33OBYRZaL05UIFtcsRIhxa9F7LA6m7IDBp8vyZA9/et+kz4mkueK+p37DYpzBlSYBy+qdVF1SXsMuCvRXqibMtdd6aGVxI4ubOFSkxPd4aou/HCeNrTe+i/KaD/UGFCVESjpQUgDYEvsVnrawIr3AmVeagcXX+He8ZS+gaQPlF/rzAwKNvQy0uwY+58PkPIFmOLfnijWdEYdra2ctHvqhmXlTQthk3Fm8zzoqmoXQYdlxFh8KquzYm/nEHdmrrb0hRCtRLRPyw0TmMv+HlHgZThMqlb3b+KvJkKf0e2ddqz7JcdRZ7xP4opHyT5tEYrNJKG064m+382ZBAU3KXF6jJ40RpZBC6x1kf/jprp7a
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DE8165076F15F4A9F44034B9E8B247E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35477420-344b-47ba-2346-08d75bc655c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 16:46:09.9502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtVt3LzzrrpWMrEXXkmf5Ywwbre6mWFGDmPY5lrJjEjoMFwgUW7llb8LeG+Qbtu03IrCdR4nMLzeatkty/A2vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5575
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTAvMjgvMTkgOToyNyBBTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBUdWUsIE9j
dCAyMiwgMjAxOSBhdCAwODowNjo1MFBNICswMDAwLCBBZGl0IFJhbmFkaXZlIHdyb3RlOg0KPj4g
QEAgLTE5NSw3ICsxOTgsOSBAQCBzdHJ1Y3QgaWJfcXAgKnB2cmRtYV9jcmVhdGVfcXAoc3RydWN0
IGliX3BkICpwZCwNCj4+ICAJdW5pb24gcHZyZG1hX2NtZF9yZXNwIHJzcDsNCj4+ICAJc3RydWN0
IHB2cmRtYV9jbWRfY3JlYXRlX3FwICpjbWQgPSAmcmVxLmNyZWF0ZV9xcDsNCj4+ICAJc3RydWN0
IHB2cmRtYV9jbWRfY3JlYXRlX3FwX3Jlc3AgKnJlc3AgPSAmcnNwLmNyZWF0ZV9xcF9yZXNwOw0K
Pj4gKwlzdHJ1Y3QgcHZyZG1hX2NtZF9jcmVhdGVfcXBfcmVzcF92MiAqcmVzcF92MiA9ICZyc3Au
Y3JlYXRlX3FwX3Jlc3BfdjI7DQo+PiAgCXN0cnVjdCBwdnJkbWFfY3JlYXRlX3FwIHVjbWQ7DQo+
PiArCXN0cnVjdCBwdnJkbWFfY3JlYXRlX3FwX3Jlc3AgcXBfcmVzcCA9IHt9Ow0KPj4gIAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPj4gIAlpbnQgcmV0Ow0KPj4gIAlib29sIGlzX3NycSA9ICEhaW5p
dF9hdHRyLT5zcnE7DQo+PiBAQCAtMjYwLDYgKzI2NSwxNSBAQCBzdHJ1Y3QgaWJfcXAgKnB2cmRt
YV9jcmVhdGVfcXAoc3RydWN0IGliX3BkICpwZCwNCj4+ICAJCQkJZ290byBlcnJfcXA7DQo+PiAg
CQkJfQ0KPj4gIA0KPj4gKwkJCS8qIFVzZXJzcGFjZSBzdXBwb3J0cyBxcG4gYW5kIHFwIGhhbmRs
ZXM/ICovDQo+PiArCQkJaWYgKGRldi0+ZHNyX3ZlcnNpb24gPj0gUFZSRE1BX1FQSEFORExFX1ZF
UlNJT04gJiYNCj4+ICsJCQkgICAgdWRhdGEtPm91dGxlbiAhPSBzaXplb2YocXBfcmVzcCkpIHsN
Cj4gDQo+IElzICE9IHJlYWxseSB3aGF0IHlvdSB3YW50PyBPciBpcyA8PSBiZXR0ZXI/ICE9IG1l
YW5zIHlvdSBjYW4ndCBldmVyDQo+IG1ha2UgcXBfcmVzcCBiaWdnZXIuDQoNCkkgdGhvdWdodCBh
Ym91dCB1c2luZyAhPSBvciA8IGJlZm9yZSBzZW5kaW5nIHRoZSBwYXRjaC4gU2luY2Ugd2UgcmVt
b3ZlZA0KdGhlIGZsYWcgYW55d2F5cyB1c2luZyAhPSBoZXJlIG1hZGUgc2Vuc2UgdG8gYmUgbW9y
ZSBzdHJpY3QgYWJvdXQgd2hhdCdzDQphY2NlcHRhYmxlLiBJJ20gbm90IHN1cmUgaWYgd2UnbGwg
ZXZlciBtYWtlIGl0IGJpZ2dlci4NCg0KPiANCj4+ICsJaWYgKCFxcC0+aXNfa2VybmVsKSB7DQo+
PiArCQlpZiAodWRhdGEtPm91dGxlbiA9PSBzaXplb2YocXBfcmVzcCkpIHsNCj4gDQo+IFNhbWUg
Y29tbWVudCwgdGhpcyByZWFsbHkgc2hvdWxkIGJlIG1pbigpPyBEaWRuJ3QgSSBtZW50aW9uIHRo
YXQgYWxyZWFkeT8NCj4NCg0KV2h5PyBJIGRpZG4ndCBhZGQgdGhlIG1pbiBzaW5jZSBJIHVzZWQg
IT0gYWJvdmUgYW55d2F5cy4NCg0KPiBKYXNvbg0KPiANCg0K
