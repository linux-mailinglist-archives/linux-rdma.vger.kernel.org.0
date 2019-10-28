Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36174E7741
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 18:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbfJ1RGL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 13:06:11 -0400
Received: from mail-eopbgr690089.outbound.protection.outlook.com ([40.107.69.89]:24807
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbfJ1RGL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 13:06:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAA36sJFzYcq+Nwve22jnnbMa3nXFNYgCzqbzpjwJ/6T639v/5E33LFbSrrCcnyfCfbf+at0tY3ppW30uxjZH5Sj5Z6Czy6uMeWYhXcDSvwPpBLwVAQEZIy9y60Ob4yZCgG9lWQ6ec+MT7PHoF5i6/eqR2i1GPoEYxicmtFpmtFPKuR1cT9dvzh5+Asg+cuW/voqOK5l5kxI81soQR6HFFKma3lKd7eLlM/Rq70G48akZPbEgRrXYSfYgisefT9BrBv8FUUY0WVnMrZ6qTDQJgqxn2sVn2oxAhefuq3cfxlZS2cdWP3iAXTqHWOE+hML8Q+tIDgWbW0g6ZVqOSxE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbRHt5llUSUWj8v7E3dyOCogutSPlTXrOfXiusG3ZWs=;
 b=bp3pHdJTnsl3uAXl1BFM9Y/SXO5NKtWTwsXGdVEWYpOqtirOoZLDognoO2rKNoJnd7/kKTCbi3/ybuZsIRWwFOoxzp0naAl9fUqkntpeX55xoLrBfxEINxDQAVnNkoohOSdgky/dQvERHXu5vn1qq0Ihueatyj40CK8X4f0uTFVi1yTEZhaH8zQjvzyz8Xku2/Ybl7BvCJiq5ArV7D6C5+FTpJs3YzSQNbODEBH6sQCmKKvtfql7s2hYe1uVco58WOVRnkGiGBVTs0fVZth+SCG6BoSNVQaO0UU9tYtsuJoVQoUFJLm2Aq/2wJkhP8MOPuUQZK9y3ooUtDpMMxyIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbRHt5llUSUWj8v7E3dyOCogutSPlTXrOfXiusG3ZWs=;
 b=Jjl4JINr0RostFoFxTeekFQyrvbderbQtaM2Ng0atiW1w+97uu9Wzztd7aU4JgNRB9CbYnJ79H6aQLMhPeJoIWvhOE7OTs8VprEP+YNtJd+CAcbJr1qbBJp9f10cbZxVCt+wUVpxSYM8NXzbvS+4BBN0o62c+btSCmJVj3gPCpU=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5992.namprd05.prod.outlook.com (20.178.53.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.15; Mon, 28 Oct 2019 17:06:08 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f149:5b68:407b:e494]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f149:5b68:407b:e494%3]) with mapi id 15.20.2408.012; Mon, 28 Oct 2019
 17:06:08 +0000
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
Thread-Index: AQHViRQ9NYXZypIt40K4gJBX9Hr5P6dwRyYA//+PvoCAAHi4gIAAAjWA
Date:   Mon, 28 Oct 2019 17:06:07 +0000
Message-ID: <48518d0c-f04a-fa80-71f1-bf8db27da36e@vmware.com>
References: <20191022200642.22762-1-aditr@vmware.com>
 <20191028162756.GA16475@ziepe.ca>
 <8f14c8c9-db10-2bb6-51b8-6e3b8b0167be@vmware.com>
 <20191028165813.GG29652@ziepe.ca>
In-Reply-To: <20191028165813.GG29652@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::16) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ccf35b4-9509-42eb-550e-08d75bc91fd9
x-ms-traffictypediagnostic: BYAPR05MB5992:|BYAPR05MB5992:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB5992E8DA10CC6D0E9A72A45AC5660@BYAPR05MB5992.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(31696002)(8936002)(36756003)(86362001)(31686004)(2906002)(66066001)(229853002)(6116002)(3846002)(6246003)(107886003)(4326008)(6436002)(6486002)(6512007)(14454004)(478600001)(5660300002)(66946007)(54906003)(316002)(64756008)(25786009)(66446008)(66476007)(186003)(81166006)(102836004)(71200400001)(26005)(71190400001)(256004)(81156014)(6506007)(53546011)(11346002)(446003)(476003)(2616005)(305945005)(486006)(6916009)(386003)(76176011)(7736002)(8676002)(99286004)(66556008)(52116002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5992;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcISgKARIsziM+g+dy/WFDri1vLxK1dDVkEZiYcMGs5b9vqohyhVBaayXTnWeNL14JlzbqTi5udlB5ipMSaTpRJfVj2Jujdn1+8b6tl+mBZfIBCpkDG+K8mMWrdA1EIJqgwk7MZ6XXytsftBB4vs1Ke1zaM+KoKLbcBVqcY8+GVbYIZxal2A3OgCAQQ9zZ3TPZ2oM3OALxsglz2/PhiwEVhOSgC6o/CcXFHAj2jnBOMJJODMhPVcgez0e7sa744KBMxoCegnUrePL4T0K9OJhHbuDD1FqOGTrhOYkYeDaRW6VCM+5BTIE5BVVfQKS2Vu2VX+V61ll3/X17/FkSN931bsS7Koi4xw9dy+zW0NZ6VDjqsfrtuqO81sHHJiH8SOX8Kee8+5LmCL5RFXf90fl34o4OQxVlH/9l+4zS9OQoPFNE58SuLa3nW3kjBz6IB9
Content-Type: text/plain; charset="utf-8"
Content-ID: <71465E83427A7140ACAF21CD3DA96C1E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccf35b4-9509-42eb-550e-08d75bc91fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 17:06:08.0123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhjRKGXv6q2zgHmCDc87oH4YX1OjWjqB8sldpHxOJp6uR+3IpXrbq1wHygjeTJ4aF/+IDUmwlCvOaHBhpEEUrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5992
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTAvMjgvMTkgOTo1OCBBTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBNb24sIE9j
dCAyOCwgMjAxOSBhdCAwNDo0NjowOVBNICswMDAwLCBBZGl0IFJhbmFkaXZlIHdyb3RlOg0KPj4g
T24gMTAvMjgvMTkgOToyNyBBTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+IE9uIFR1ZSwg
T2N0IDIyLCAyMDE5IGF0IDA4OjA2OjUwUE0gKzAwMDAsIEFkaXQgUmFuYWRpdmUgd3JvdGU6DQo+
Pj4+IEBAIC0xOTUsNyArMTk4LDkgQEAgc3RydWN0IGliX3FwICpwdnJkbWFfY3JlYXRlX3FwKHN0
cnVjdCBpYl9wZCAqcGQsDQo+Pj4+ICAJdW5pb24gcHZyZG1hX2NtZF9yZXNwIHJzcDsNCj4+Pj4g
IAlzdHJ1Y3QgcHZyZG1hX2NtZF9jcmVhdGVfcXAgKmNtZCA9ICZyZXEuY3JlYXRlX3FwOw0KPj4+
PiAgCXN0cnVjdCBwdnJkbWFfY21kX2NyZWF0ZV9xcF9yZXNwICpyZXNwID0gJnJzcC5jcmVhdGVf
cXBfcmVzcDsNCj4+Pj4gKwlzdHJ1Y3QgcHZyZG1hX2NtZF9jcmVhdGVfcXBfcmVzcF92MiAqcmVz
cF92MiA9ICZyc3AuY3JlYXRlX3FwX3Jlc3BfdjI7DQo+Pj4+ICAJc3RydWN0IHB2cmRtYV9jcmVh
dGVfcXAgdWNtZDsNCj4+Pj4gKwlzdHJ1Y3QgcHZyZG1hX2NyZWF0ZV9xcF9yZXNwIHFwX3Jlc3Ag
PSB7fTsNCj4+Pj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4+PiAgCWludCByZXQ7DQo+Pj4+
ICAJYm9vbCBpc19zcnEgPSAhIWluaXRfYXR0ci0+c3JxOw0KPj4+PiBAQCAtMjYwLDYgKzI2NSwx
NSBAQCBzdHJ1Y3QgaWJfcXAgKnB2cmRtYV9jcmVhdGVfcXAoc3RydWN0IGliX3BkICpwZCwNCj4+
Pj4gIAkJCQlnb3RvIGVycl9xcDsNCj4+Pj4gIAkJCX0NCj4+Pj4gIA0KPj4+PiArCQkJLyogVXNl
cnNwYWNlIHN1cHBvcnRzIHFwbiBhbmQgcXAgaGFuZGxlcz8gKi8NCj4+Pj4gKwkJCWlmIChkZXYt
PmRzcl92ZXJzaW9uID49IFBWUkRNQV9RUEhBTkRMRV9WRVJTSU9OICYmDQo+Pj4+ICsJCQkgICAg
dWRhdGEtPm91dGxlbiAhPSBzaXplb2YocXBfcmVzcCkpIHsNCj4+Pg0KPj4+IElzICE9IHJlYWxs
eSB3aGF0IHlvdSB3YW50PyBPciBpcyA8PSBiZXR0ZXI/ICE9IG1lYW5zIHlvdSBjYW4ndCBldmVy
DQo+Pj4gbWFrZSBxcF9yZXNwIGJpZ2dlci4NCj4+DQo+PiBJIHRob3VnaHQgYWJvdXQgdXNpbmcg
IT0gb3IgPCBiZWZvcmUgc2VuZGluZyB0aGUgcGF0Y2guIFNpbmNlIHdlIHJlbW92ZWQNCj4+IHRo
ZSBmbGFnIGFueXdheXMgdXNpbmcgIT0gaGVyZSBtYWRlIHNlbnNlIHRvIGJlIG1vcmUgc3RyaWN0
IGFib3V0IHdoYXQncw0KPj4gYWNjZXB0YWJsZS4gSSdtIG5vdCBzdXJlIGlmIHdlJ2xsIGV2ZXIg
bWFrZSBpdCBiaWdnZXIuDQo+IA0KPiBJdCBpcyBhIGJpZyBnYW1ibGUgeW91IHdpbGwgbmV2ZXIg
bmVlZCB0byBhZGQgbmV3IGVudHJpZXMgdG8gdGhpcw0KPiBzdHJ1Y3QgZm9yZXZlciBtb3JlLiBC
ZXR0ZXIgdG8gYmUgc2FmZSwgSU1ITy4NCj4gDQoNCk9rYXkuIFdpbGwgc2VuZCBhIHYzIGZvciB0
aGlzLg0KDQo=
