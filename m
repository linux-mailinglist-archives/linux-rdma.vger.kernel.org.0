Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5821B150FF2
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 19:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgBCStk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 13:49:40 -0500
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:20339
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728085AbgBCStk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 13:49:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS8LqnxyIwkeYiQvVAzzs6gBJREhhwUwyuneqFKfCbvrBPB3jom0oLAUmJgLIhNkPYg5ty7/v/NS/9u7A1CaEwH5W2DJmqhOfVOi5HTBFADLjIm/ern43dYE1k3eGqJwnX+rs2fE3LToxLQS3SsUEVOiiUDrJcj6lMrqQswDc6e02AnI9/wMRvj7QjO9hKRvGwHvOv232nRXwAdLdYGkzq6nzEtww1YbNGgLSeWs7+T+px7DlFVM84IekP1PX9iYbiQzChqXs/vD3jiksti9GN6BRafa4mTjQvD+FJTYQP6kZvobAMGgHRIkHf0FfyB2kuzllMKIDnYC3lhEX/erYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqJipS5QnlEpv/wsQoFLJ6kcfcccvbbswq6IaeaSp2s=;
 b=fCgK6Gn9wpiN6JdbkjUie0s9YLIf++GIhTMWuegLc6CCefYias0VCu+fD9iR0GNmlOuFgeL13Ql+eQq+knSlulcY+G60vEf3LOqr5gk8wgqCtO0aX/JGXxszRfDEmu8RV9F9/RdCWTiFUgHCELTpp9m1JfenbF89j2i93F1I5NLY6vOztdlMlta8T5mlxSv69BlpiugJ0WuMnHOAREjpy+zt7rx3QofACj0UNDmoYHuNs5dnRBI3NN30D+BBKP+Xp3XBJt3S+DKa91wR61eUxnlV5U9rKRjeby58U+J8nU6yaMMa8bJODUQEo6A0K6uYDc84hKugDGytref06SV3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqJipS5QnlEpv/wsQoFLJ6kcfcccvbbswq6IaeaSp2s=;
 b=Or988MG6z8SZq5a8XlYK3bzHu/+UGFF5Zw0PiFJnFOlU4sOGTB6luGMhM83tpXqQtTXt24DAF1N4m76NJoU8dNUX9f75S68BPciI7OKfxCBjZAjJ9hUTQ5qNYMBoktz+5SALXECIWuY97OmEjgJC37hTLGZZ7FlztYjtlvg9Rks=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4856.namprd05.prod.outlook.com (52.135.235.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.14; Mon, 3 Feb 2020 18:49:36 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::2cad:e39c:df45:c1c6]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::2cad:e39c:df45:c1c6%6]) with mapi id 15.20.2707.016; Mon, 3 Feb 2020
 18:49:36 +0000
Received: from elrond.eng.vmware.com (66.170.99.1) by BYAPR07CA0059.namprd07.prod.outlook.com (2603:10b6:a03:60::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Mon, 3 Feb 2020 18:49:35 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Pv-drivers <Pv-drivers@vmware.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Yuval Shaia <yuval.shaia.ml@gmail.com>
Subject: Re: [Suspected Spam] [PATCH] RDMA/vmw_pvrdma: Disable PCI device on
 error
Thread-Topic: [Suspected Spam] [PATCH] RDMA/vmw_pvrdma: Disable PCI device on
 error
Thread-Index: AQHV2sEJBfP4UtkyZkm8ZWGktzEvs6gJz9aA
Date:   Mon, 3 Feb 2020 18:49:36 +0000
Message-ID: <d34947f2-9a24-a724-6f42-084ce0e45c2d@vmware.com>
References: <20200203183736.10932-1-yuval.shaia.ml@gmail.com>
In-Reply-To: <20200203183736.10932-1-yuval.shaia.ml@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cd951a2-cf06-4cee-7ddb-08d7a8d9d078
x-ms-traffictypediagnostic: BYAPR05MB4856:|BYAPR05MB4856:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4856807979F7BDC041B9915CC5000@BYAPR05MB4856.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(71200400001)(8936002)(52116002)(86362001)(31686004)(110136005)(4326008)(8676002)(31696002)(186003)(6486002)(7696005)(53546011)(81156014)(16526019)(2616005)(2906002)(956004)(81166006)(26005)(316002)(4744005)(66556008)(66476007)(478600001)(64756008)(36756003)(66946007)(5660300002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4856;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UlOfFi7Cm5Rw4eC05q37Z4uu2i0OFmZV9DE4a4ibuyxdM4Aug2WKJyd9dm14ElFoxAMJZRr4LTBtpg5u6HZCHsx4ErvcSqLz6dPpOsHXB64aTPIpvzXm+esUHxPgAtxvdmqvmH3zAci2KgTgV3NBM6FX/atr+I73f/1RiYcfCqgd0DdULGbm/4lQbWGG/itAeNkTkklUydFrK5pz0Q/eyZ0NVtvOWUQbrY3N7uCEBu0D464vFUiWXAifU76Jk1Pk34SoMuXuiqQ71UkeZyMC0JL0hu+E5RX0HVSjA7cl4ZzWzHiZH8fNXaXXjPAMA2eAO6foR5GTJ42NfN4BusESvsLmaivipoA2F88uV0/J/iKBCcD8RimIaBzzljkFnvX7SaCsljcNuHtQTztMCiamYZGIR/qFZ3oM8GL/k8LA+VJRN93QEtTf+KRXhM+Gi8Wt
x-ms-exchange-antispam-messagedata: eticZ/i/g2yhwVET2LgtT6l4HTf3NhKpJIyFBHEFzi6IFbOrQe2ReqNQBC/Ws4RbiyTjqmqepggqFbjfbd5dYvTKzxGlOd3eJPvI/CzG2QITap0Jz79XZu0hx4eYE6hpOLBdHvy7Y10rXbPXGtTMhQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <730A2975E01C0C49B9AF4E4ECBB6EA7F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd951a2-cf06-4cee-7ddb-08d7a8d9d078
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 18:49:36.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpmj41+5ZARyPxHLe9BmtoSsgEjw/Al46K4mJ9Nt4sL63ruGSJYMjEYAip2Jyc8ZvjvjjDdjHuFXTPIL9Kgofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4856
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8zLzIwIDEwOjM3IEFNLCAiWXV2YWwgU2hhaWEgeXV2YWwuc2hhaWEubWwiQGdtYWlsLmNv
bSB3cm90ZToNCj4gRnJvbTogWXV2YWwgU2hhaWEgPHl1dmFsLnNoYWlhLm1sQGdtYWlsLmNvbT4N
Cj4gDQo+IFdlIG5lZWQgdG8gZGlzYWJsZSB0aGUgUENJIGRldmljZSBvbiBhbnkgZXJyb3IgaGFw
cGVuIGFmdGVyIHdlIGVuYWJsZQ0KPiB0aGUgZGV2aWNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
WXV2YWwgU2hhaWEgPHl1dmFsLnNoYWlhLm1sQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2luZmluaWJhbmQvaHcvdm13X3B2cmRtYS9wdnJkbWFfbWFpbi5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L3Ztd19wdnJkbWEvcHZyZG1hX21haW4uYyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9ody92bXdfcHZyZG1hL3B2cmRtYV9tYWluLmMNCj4gaW5kZXggZTU4MGFl
OWNjNTVhLi43ODBmZDJkZmMwN2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy92bXdfcHZyZG1hL3B2cmRtYV9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3
L3Ztd19wdnJkbWEvcHZyZG1hX21haW4uYw0KPiBAQCAtODI5LDcgKzgyOSw3IEBAIHN0YXRpYyBp
bnQgcHZyZG1hX3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gIAkgICAgIShwY2lf
cmVzb3VyY2VfZmxhZ3MocGRldiwgMSkgJiBJT1JFU09VUkNFX01FTSkpIHsNCj4gIAkJZGV2X2Vy
cigmcGRldi0+ZGV2LCAiUENJIEJBUiByZWdpb24gbm90IE1NSU9cbiIpOw0KPiAgCQlyZXQgPSAt
RU5PTUVNOw0KPiAtCQlnb3RvIGVycl9mcmVlX2RldmljZTsNCj4gKwkJZ290byBlcnJfZGlzYWJs
ZV9wZGV2Ow0KPiAgCX0NCj4gIA0KPiAgCXJldCA9IHBjaV9yZXF1ZXN0X3JlZ2lvbnMocGRldiwg
RFJWX05BTUUpOw0KPiANCg0KTG9va3MgZmluZSB0byBtZS4gUGxlYXNlIGFkZCBhIEZpeGVzIHRh
ZyBhbmQgY2Mgc3RhYmxlLg0KQWNrZWQtYnk6IEFkaXQgUmFuYWRpdmUgPGFkaXRyQHZtd2FyZS5j
b20+DQo=
