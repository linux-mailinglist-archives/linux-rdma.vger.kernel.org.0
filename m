Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5771CF0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbfGWQaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 12:30:17 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:43745
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727671AbfGWQaR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 12:30:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTV0plY43ij7Vbh1bimhDjIIxw+yy5mta4qrG8OepbubJ+8Flu2iw4uyBxQ5FojLFaQquA7wymTLwnYSWfKlTVj1qQYPBv/WmJMS9V/Cui362NqWeVqL9y2Uh3WqDau5ZdEd8hb00nv7+zIBTN42GfoEMwcL/F0kKlMs1aM5tz8lt0g0FV4QGtmcnuy7Mo3C8pDvz1n179Xwn7yt1NIa5YiR5oSA7rF0U8YP5q4PluI94ZYHHsrukwaK00fjQFA1Rdp7UA0TRvitEXWHWOBDjspqkqzN/VNUNmHV2QQoQQ5m5xXuG8dEx3mCjQgEyT3uv8fEo2u42K9gZi91IG7MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OMp0OWOjFiuQ0xqpv/ck38uaffY4uEN6NBtPTFfupw=;
 b=cHrEquMUbLrFQ/w0m5mYd56E9HGG9xAFWLmaB/yXRb8l1hcJTBFYFnsKF0FlA9KYXKHmvjoT1fBmvs6oRrkH2ywxC0VO8fTTui2aNjlwZUBYggslfrdMkz+GdoYYpAs2J6adUazCFLm4aHbzqIZIkpzTAGoEJIix/tox5Zu0LP3AtfZ/8Zja6G5JbrC5/vBgL4BUratuGYW/4Q9sKAXt+1ZUibk6DKm2WQZ+DOBbT+yAsYlVwjq7pPBCqYqaUckTitluQ/5rPzOOOibu1jFttpz6I0bDeEbxaKxMpTOtf+YavNvNILUVPaxHT9uAR4cHZIHk+GeG6jjZfXNHG3RbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OMp0OWOjFiuQ0xqpv/ck38uaffY4uEN6NBtPTFfupw=;
 b=mqozw5D3QVBQMpzBwT0WwJ+RXszlwyaRBCJqPyQ8ulNIalcT67UrF0ko5cy3TMp6QcsLNiHv3XkWSWwFYXyvFqv6Cn+Uxgy89UvMkPM1Q0FDMAMK7hb4NP606lFzSzlAzjQJ5uFd+BTmm4VtwSXARSXJCVq0pyQdtyxFNCKLRZU=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2391.namprd12.prod.outlook.com (52.132.141.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 23 Jul 2019 16:30:14 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::cda7:cfc1:ce62:bcb7]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::cda7:cfc1:ce62:bcb7%10]) with mapi id 15.20.2094.013; Tue, 23 Jul
 2019 16:30:13 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 00/14] PCI/P2PDMA: Support transactions that hit the host
 bridge
Thread-Topic: [PATCH 00/14] PCI/P2PDMA: Support transactions that hit the host
 bridge
Thread-Index: AQHVQOKBFn41TV2m5kSFYCrTCs5pgqbYZgGA
Date:   Tue, 23 Jul 2019 16:30:13 +0000
Message-ID: <d7c7011e-e9b7-89f8-99ba-b674d45821c6@amd.com>
References: <20190722230859.5436-1-logang@deltatee.com>
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR2P264CA0003.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::15)
 To DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b98a3922-5cac-49f8-a5d8-08d70f8b09b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB2391;
x-ms-traffictypediagnostic: DM5PR12MB2391:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR12MB239187FE8F6DA5533A1C856783C70@DM5PR12MB2391.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(66574012)(5660300002)(99286004)(25786009)(7736002)(36756003)(2501003)(58126008)(229853002)(4326008)(6116002)(86362001)(110136005)(31696002)(66446008)(81156014)(8676002)(53936002)(65826007)(2201001)(68736007)(6512007)(66476007)(8936002)(71190400001)(81166006)(305945005)(64756008)(54906003)(66946007)(6306002)(6246003)(71200400001)(66556008)(31686004)(6506007)(52116002)(46003)(102836004)(486006)(186003)(966005)(2616005)(476003)(6436002)(65956001)(65806001)(386003)(64126003)(11346002)(446003)(76176011)(478600001)(316002)(14454004)(14444005)(2906002)(6486002)(7416002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2391;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pAk67c+bU1rZPjhn8mNggiyUNSJg4HdRiFKU5CQPehjejVacV7FKZ3qSpoQTfDULGaQ+rSPIb71qpi1uGMpSW/VrTV76dEfXCMt2AaDPLPgV5SbL0X1pXk5oUWiqMLSCw//pWLVLGmMEnrFwzTJm9F+n1IhvFaMG+BWCFgcRMRbd7RjGyzqwZrbqA3B+Ad2b6R3ZgM18fUeoavvZEkqd5Vj8UtnuJnUiJfWE7O2thGJ4eXWWzlIVRnLshWjRHv9GLtqGPA6NibIcYC0zZ2PSpj2vkB/QDB8JO637gAY0LJTVHmSVlR4V3TM+AioFx8wmL+mpiG+Lfp+LdyYo9rzwFudFEyI+duIS3bTalD8RldF9Nv/3zpe9+hTrwLFwbcMm5Truqg3CmPn9nfa7AuhkRGtFYgkzA7RIT0RIIDzLoBU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7474CA97B07324FA8807FC37E0D0E65@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98a3922-5cac-49f8-a5d8-08d70f8b09b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 16:30:13.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2391
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QW0gMjMuMDcuMTkgdW0gMDE6MDggc2NocmllYiBMb2dhbiBHdW50aG9ycGU6DQo+IEFzIGRpc2N1
c3NlZCBvbiB0aGUgbGlzdCBwcmV2aW91c2x5LCBpbiBvcmRlciB0byBmdWxseSBzdXBwb3J0IHRo
ZQ0KPiB3aGl0ZWxpc3QgQ2hyaXN0aWFuIGFkZGVkIHdpdGggdGhlIElPTU1VLCB3ZSBtdXN0IGVu
c3VyZSB0aGF0IHdlDQo+IG1hcCBhbnkgYnVmZmVyIGdvaW5nIHRocm91Z2ggdGhlIElPTU1VIHdp
dGggYW4gYXBycm9wcmlhdGUgZG1hX21hcA0KPiBjYWxsLiBUaGlzIHBhdGNoc2V0IGFjY29tcGxp
c2hlcyB0aGlzIGJ5IGNsZWFuaW5nIHVwIHRoZSBvdXRwdXQgb2YNCj4gdXBzdHJlYW1fYnJpZGdl
X2Rpc3RhbmNlKCkgdG8gYmV0dGVyIGluZGljYXRlIHRoZSBtYXBwaW5nIHJlcXVpcmVtZW50cywN
Cj4gY2FjaGluZyB0aGVzZSByZXF1aXJlbWVudHMgaW4gYW4geGFycmF5LCB0aGVuIGxvb2tpbmcg
dGhlbSB1cCBhdCBtYXANCj4gdGltZSBhbmQgYXBwbHlpbmcgdGhlIGFwcHJvcHJpYXRlIG1hcHBp
bmcgbWV0aG9kLg0KPg0KPiBBZnRlciB0aGlzIHBhdGNoc2V0LCBpdCdzIHBvc3NpYmxlIHRvIHVz
ZSB0aGUgTlZNZS1vZiBQMlAgc3VwcG9ydCB0bw0KPiB0cmFuc2ZlciBiZXR3ZWVuIGRldmljZXMg
d2l0aG91dCBhIHN3aXRjaCBvbiB0aGUgd2hpdGVsaXN0ZWQgcm9vdA0KPiBjb21wbGV4ZXMuIEEg
Y291cGxlIEludGVsIGRldmljZSBJIGhhdmUgdGVzdGVkIHRoaXMgb24gaGF2ZSBhbHNvDQo+IGJl
ZW4gYWRkZWQgdG8gdGhlIHdoaXRlIGxpc3QuDQo+DQo+IE1vc3Qgb2YgdGhlIGNoYW5nZXMgYXJl
IGNvbnRhaW5lZCB3aXRoaW4gdGhlIHAycGRtYS5jLCBidXQgdGhlcmUgYXJlDQo+IGEgZmV3IG1p
bm9yIHRvdWNoZXMgdG8gb3RoZXIgc3Vic3lzdGVtcywgbW9zdGx5IHRvIGFkZCBzdXBwb3J0DQo+
IHRvIGNhbGwgYW4gdW5tYXAgZnVuY3Rpb24uDQo+DQo+IFRoZSBmaW5hbCBwYXRjaCBpbiB0aGlz
IHNlcmllcyBkZW1vbnN0cmF0ZXMgYSBwb3NzaWJsZQ0KPiBwY2lfcDJwZG1hX21hcF9yZXNvdXJj
ZSgpIGZ1bmN0aW9uIHRoYXQgSSBleHBlY3QgQ2hyaXN0aWFuIHdpbGwgbmVlZA0KPiBidXQgZG9l
cyBub3QgaGF2ZSBhbnkgdXNlcnMgYXQgdGhpcyB0aW1lIHNvIEkgZG9uJ3QgaW50ZW5kIGZvciBp
dCB0byBiZQ0KPiBjb25zaWRlcmVkIGZvciBtZXJnaW5nLg0KPg0KPiBUaGlzIHBhdGNoc2V0IGlz
IGJhc2VkIG9uIDUuMy1yYzEgYW5kIGEgZ2l0IGJyYW5jaCBpcyBhdmFpbGFibGUgaGVyZToNCj4N
Cj4gaHR0cHM6Ly9naXRodWIuY29tL3NiYXRlczEzMDI3Mi9saW51eC1wMnBtZW0vIHAycGRtYV9y
Y19tYXBfdjENCg0KSSByZXZpZXdlZCBwYXRjaGVzICMxLSMzIGFuZCAjMTQuDQoNCkZlZWwgZnJl
ZSB0byBzdGljayBhbiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyANCjxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+IHRvIHRoZSByZXN0LCBidXQgSSdtIG5vdCByZWFsbHkgZGVlcCBpbnRvIHRo
ZSANCk5WTWUgUDJQIGhhbmRsaW5nIGhlcmUuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCg0K
Pg0KPiAtLQ0KPg0KPiBMb2dhbiBHdW50aG9ycGUgKDE0KToNCj4gICAgUENJL1AyUERNQTogQWRk
IGNvbnN0YW50cyBmb3Igbm90LXN1cHBvcnRlZCByZXN1bHQNCj4gICAgICB1cHN0cmVhbV9icmlk
Z2VfZGlzdGFuY2UoKQ0KPiAgICBQQ0kvUDJQRE1BOiBGYWN0b3Igb3V0IF9fdXBzdHJlYW1fYnJp
ZGdlX2Rpc3RhbmNlKCkNCj4gICAgUENJL1AyUERNQTogQXBwbHkgaG9zdCBicmlkZ2Ugd2hpdGUg
bGlzdCBmb3IgQUNTDQo+ICAgIFBDSS9QMlBETUE6IENhY2hlIHRoZSByZXN1bHQgb2YgdXBzdHJl
YW1fYnJpZGdlX2Rpc3RhbmNlKCkNCj4gICAgUENJL1AyUERNQTogRmFjdG9yIG91dCBob3N0X2Jy
aWRnZV93aGl0ZWxpc3QoKQ0KPiAgICBQQ0kvUDJQRE1BOiBBZGQgd2hpdGVsaXN0IHN1cHBvcnQg
Zm9yIEludGVsIEhvc3QgQnJpZGdlcw0KPiAgICBQQ0kvUDJQRE1BOiBBZGQgdGhlIHByb3ZpZGVy
J3MgcGNpX2RldiB0byB0aGUgZGV2X3BnbWFwIHN0cnVjdA0KPiAgICBQQ0kvUDJQRE1BOiBBZGQg
YXR0cnMgYXJndW1lbnQgdG8gcGNpX3AycGRtYV9tYXBfc2coKQ0KPiAgICBQQ0kvUDJQRE1BOiBJ
bnRyb2R1Y2UgcGNpX3AycGRtYV91bm1hcF9zZygpDQo+ICAgIFBDSS9QMlBETUE6IEZhY3RvciBv
dXQgX19wY2lfcDJwZG1hX21hcF9zZygpDQo+ICAgIFBDSS9QMlBETUE6IGRtYV9tYXAgUDJQRE1B
IG1hcCByZXF1ZXN0cyB0aGF0IHRyYXZlcnNlIHRoZSBob3N0IGJyaWRnZQ0KPiAgICBQQ0kvUDJQ
RE1BOiBObyBsb25nZXIgcmVxdWlyZSBuby1tbXUgZm9yIGhvc3QgYnJpZGdlIHdoaXRlbGlzdA0K
PiAgICBQQ0kvUDJQRE1BOiBVcGRhdGUgZG9jdW1lbnRhdGlvbiBmb3IgcGNpX3AycGRtYV9kaXN0
YW5jZV9tYW55KCkNCj4gICAgUENJL1AyUERNQTogSW50cm9kdWNlIHBjaV9wMnBkbWFfW3VuXW1h
cF9yZXNvdXJjZSgpDQo+DQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvcncuYyB8ICAgNiAr
LQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jICAgICAgfCAgMTAgKy0NCj4gICBkcml2ZXJz
L3BjaS9wMnBkbWEuYyAgICAgICAgIHwgNDAwICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tDQo+ICAgaW5jbHVkZS9saW51eC9tZW1yZW1hcC5oICAgICB8ICAgMSArDQo+ICAgaW5j
bHVkZS9saW51eC9wY2ktcDJwZG1hLmggICB8ICAyOCArKy0NCj4gICA1IGZpbGVzIGNoYW5nZWQs
IDM0MSBpbnNlcnRpb25zKCspLCAxMDQgZGVsZXRpb25zKC0pDQo+DQo+IC0tDQo+IDIuMjAuMQ0K
DQo=
