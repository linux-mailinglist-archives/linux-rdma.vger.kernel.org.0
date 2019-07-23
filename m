Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F252571CCD
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfGWQX1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 12:23:27 -0400
Received: from mail-eopbgr770072.outbound.protection.outlook.com ([40.107.77.72]:60536
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfGWQX1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 12:23:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROG4Mn9nsW26B9AoMxSmnAx05Gd2ZEb4EFTkDgV0JYM0wv6tGrVEYvXspwMl9Zv6flDK1ExLwtoUwXpRHihRhH75qOVCk08qTr4w37uRznOXAehWsuF76Kcl7p6Zlh+8EClw6gPGtbNa0oMMgw5xOCD6LWkTFQ2VI/J680AdtddZWlql+7U84ycb1aq8a/Uc2tVUcPZACy29KpW1TEbmWh+aqWC+ZIFKEWwnXt7vj6a4WJVLZzkh3FvvwObTvLRn7I02qhmnBh5A/fpYPlmR9HxLwMBCKDqBPeCPZy8IetsQHNknZOuK9D//Pq7n9dVckpm5fF+287UJiSmhMKdrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H+PUymqNmgS/222ucsZnxhkrs0RPcKhEUVFrNKW/X0=;
 b=eTxwudOeIMPOV3VeEEjw1NzBFzv8htNxSpUUxaOEW02rFbF+9bzo4xwipTvIW8IVxjoYIB6JngOgo/8jWOvo37db3h3P1qfyA3nzcVwCQfIJ+YSmoK9TXh4BFbd61y/Et7sQR2c5CaLip3mnRT4fMdN9e0LNXlqmzHwn5jp5O8UsL4zdq65hYVZvkqQq7VkW7j3XivexIBVmTkHzWR/bLoHeILXq+aAQMxsS/ILW4c79LCy3n7jOj1CejWj11oWi8P063hzR4OgwftU9lclRjss32ExdUfFKKVWKfwBkUwjF40SHdcs6sDRuJpXep0YFohoe4V73aAESqsizImfk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H+PUymqNmgS/222ucsZnxhkrs0RPcKhEUVFrNKW/X0=;
 b=ELjMKWsWkIe3ZeVNIu5UwnsBfDJPbS8cBcjuWkA0Up4UtM2J9UU5qixR/Ae5nLmdSp5ijWGL/F1XGF8OE/80c3etU95u5xGTNhiA2bVCxxOsv30+YjI4hxt6ujdp9eCoW9TqQ4zA3K4fB+pyvK4trkDu2IwT3yTIJwvBKe0O+hE=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2358.namprd12.prod.outlook.com (52.132.141.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Tue, 23 Jul 2019 16:23:24 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::cda7:cfc1:ce62:bcb7]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::cda7:cfc1:ce62:bcb7%10]) with mapi id 15.20.2094.013; Tue, 23 Jul
 2019 16:23:24 +0000
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
Subject: Re: [PATCH 03/14] PCI/P2PDMA: Apply host bridge white list for ACS
Thread-Topic: [PATCH 03/14] PCI/P2PDMA: Apply host bridge white list for ACS
Thread-Index: AQHVQOJ/hJntFdbC7U+X8XDxXeMMNKbYZBcA
Date:   Tue, 23 Jul 2019 16:23:23 +0000
Message-ID: <7ced9658-33f9-4496-4335-a6852f08ed12@amd.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-4-logang@deltatee.com>
In-Reply-To: <20190722230859.5436-4-logang@deltatee.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR2P264CA0022.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::34)
 To DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a29deadf-5a1c-432b-2120-08d70f8a1574
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB2358;
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-microsoft-antispam-prvs: <DM5PR12MB23583D8824C5743D0BEC7C8883C70@DM5PR12MB2358.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(189003)(199004)(65806001)(65826007)(65956001)(31686004)(71200400001)(8936002)(36756003)(316002)(58126008)(110136005)(6486002)(6512007)(54906003)(71190400001)(6436002)(8676002)(99286004)(7736002)(5660300002)(64756008)(64126003)(66446008)(68736007)(4326008)(66946007)(66556008)(305945005)(66476007)(46003)(256004)(6506007)(52116002)(11346002)(446003)(76176011)(86362001)(476003)(53936002)(2501003)(6246003)(186003)(14454004)(2906002)(2201001)(386003)(478600001)(102836004)(2616005)(25786009)(81156014)(229853002)(486006)(7416002)(81166006)(6116002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2358;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eTlI2kZPMY780FBUghE11PfWYHVCVxtMd1tdXYXFA9ibpPYAquas7Pg+XJwpkK6msFX2KRIoWVtMI2Zba10Zd+/WZhfsaVjD32iJW3IhJo1f75MF049NIu/Y6SfYL4JrYX0Oi1dh4hgqsIhRjjs5yC7yXzy4NuW6pzu6yiPUcUmXl/tmsNjbPnPADLU6mgwMVC6NiDM9dPq5PFRz5UU8nEpVreTVLrA+2lB0xl5iB3fcsfSI/duy0jcKWdSgAP1EJg/0im/JKeSE39JLneXIcllLhJ50tdi+B8uO8F+ZiQJYzIm6eQoDjsAZZNEQOotvTyC0mSPISsBk70LUz0Rtg4TPb/hNEjPxb058JxpxK8iX2YLNiKarwoupS/pUmwzvOhh9kYXus6kJ8Ncl8J7FzowPBhFkFt98SyTOTIuus8Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F27F267EF2060F4AB0608F6D12974C74@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29deadf-5a1c-432b-2120-08d70f8a1574
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 16:23:23.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QW0gMjMuMDcuMTkgdW0gMDE6MDggc2NocmllYiBMb2dhbiBHdW50aG9ycGU6DQo+IFdoZW4gYSBQ
MlBETUEgdHJhbnNmZXIgaXMgcmVqZWN0ZWQgZHVlIHRvIEFDUyBiZWluZyBzZXQsIHdlDQo+IGNh
biBhbHNvIGNoZWNrIHRoZSB3aGl0ZSBsaXN0IGFuZCBhbGxvdyB0aGUgdHJhbnNhY3Rpb25zLg0K
Pg0KPiBEbyB0aGlzIGJ5IHB1c2hpbmcgdGhlIHdoaXRlbGlzdCBjaGVjayBpbnRvIHRoZQ0KPiB1
cHN0cmVhbV9icmlkZ2VfZGlzdGFuY2UoKSBmdW5jdGlvbi4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
TG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KDQpUaGlzIG9uZSBhbmQgcGF0
Y2ggIzIgYXJlIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIA0KPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4uDQoNCkJ1dCBJIGFjdHVhbGx5IHRoaW5rIHRoZSB0d28gcGF0Y2hlcyBjb3Vs
ZCBiZSBtZXJnZWQuDQoNCkNocmlzdGlhbi4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL3BjaS9wMnBk
bWEuYyB8IDI1ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9wMnBkbWEuYyBiL2RyaXZlcnMvcGNpL3AycGRtYS5jDQo+IGluZGV4IDI4OWQwM2Ez
MWU3ZC4uZDUwMzRlMjhkMWUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9wMnBkbWEuYw0K
PiArKysgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYw0KPiBAQCAtMzI0LDE1ICszMjQsNyBAQCBzdGF0
aWMgaW50IF9fdXBzdHJlYW1fYnJpZGdlX2Rpc3RhbmNlKHN0cnVjdCBwY2lfZGV2ICpwcm92aWRl
ciwNCj4gICAJCWRpc3RfYSsrOw0KPiAgIAl9DQo+ICAgDQo+IC0JLyoNCj4gLQkgKiBBbGxvdyB0
aGUgY29ubmVjdGlvbiBpZiBib3RoIGRldmljZXMgYXJlIG9uIGEgd2hpdGVsaXN0ZWQgcm9vdA0K
PiAtCSAqIGNvbXBsZXgsIGJ1dCBhZGQgYW4gYXJiaXRyYXJ5IGxhcmdlIHZhbHVlIHRvIHRoZSBk
aXN0YW5jZS4NCj4gLQkgKi8NCj4gLQlpZiAocm9vdF9jb21wbGV4X3doaXRlbGlzdChwcm92aWRl
cikgJiYNCj4gLQkgICAgcm9vdF9jb21wbGV4X3doaXRlbGlzdChjbGllbnQpKQ0KPiAtCQlyZXR1
cm4gKGRpc3RfYSArIGRpc3RfYikgfCBQMlBETUFfVEhSVV9IT1NUX0JSSURHRTsNCj4gLQ0KPiAt
CXJldHVybiAoZGlzdF9hICsgZGlzdF9iKSB8IFAyUERNQV9OT1RfU1VQUE9SVEVEOw0KPiArCXJl
dHVybiAoZGlzdF9hICsgZGlzdF9iKSB8IFAyUERNQV9USFJVX0hPU1RfQlJJREdFOw0KPiAgIA0K
PiAgIGNoZWNrX2JfcGF0aF9hY3M6DQo+ICAgCWJiID0gYjsNCj4gQEAgLTM1MCw3ICszNDIsOCBA
QCBzdGF0aWMgaW50IF9fdXBzdHJlYW1fYnJpZGdlX2Rpc3RhbmNlKHN0cnVjdCBwY2lfZGV2ICpw
cm92aWRlciwNCj4gICAJfQ0KPiAgIA0KPiAgIAlpZiAoYWNzX2NudCkNCj4gLQkJcmV0dXJuIFAy
UERNQV9OT1RfU1VQUE9SVEVEIHwgUDJQRE1BX0FDU19GT1JDRVNfVVBTVFJFQU07DQo+ICsJCXJl
dHVybiAoZGlzdF9hICsgZGlzdF9iKSB8IFAyUERNQV9BQ1NfRk9SQ0VTX1VQU1RSRUFNIHwNCj4g
KwkJCVAyUERNQV9USFJVX0hPU1RfQlJJREdFOw0KPiAgIA0KPiAgIAlyZXR1cm4gZGlzdF9hICsg
ZGlzdF9iOw0KPiAgIH0NCj4gQEAgLTM5Nyw3ICszOTAsMTcgQEAgc3RhdGljIGludCB1cHN0cmVh
bV9icmlkZ2VfZGlzdGFuY2Uoc3RydWN0IHBjaV9kZXYgKnByb3ZpZGVyLA0KPiAgIAkJCQkgICAg
c3RydWN0IHBjaV9kZXYgKmNsaWVudCwNCj4gICAJCQkJICAgIHN0cnVjdCBzZXFfYnVmICphY3Nf
bGlzdCkNCj4gICB7DQo+IC0JcmV0dXJuIF9fdXBzdHJlYW1fYnJpZGdlX2Rpc3RhbmNlKHByb3Zp
ZGVyLCBjbGllbnQsIGFjc19saXN0KTsNCj4gKwlpbnQgZGlzdDsNCj4gKw0KPiArCWRpc3QgPSBf
X3Vwc3RyZWFtX2JyaWRnZV9kaXN0YW5jZShwcm92aWRlciwgY2xpZW50LCBhY3NfbGlzdCk7DQo+
ICsNCj4gKwlpZiAoIShkaXN0ICYgUDJQRE1BX1RIUlVfSE9TVF9CUklER0UpKQ0KPiArCQlyZXR1
cm4gZGlzdDsNCj4gKw0KPiArCWlmIChyb290X2NvbXBsZXhfd2hpdGVsaXN0KHByb3ZpZGVyKSAm
JiByb290X2NvbXBsZXhfd2hpdGVsaXN0KGNsaWVudCkpDQo+ICsJCXJldHVybiBkaXN0Ow0KPiAr
DQo+ICsJcmV0dXJuIGRpc3QgfCBQMlBETUFfTk9UX1NVUFBPUlRFRDsNCj4gICB9DQo+ICAgDQo+
ICAgc3RhdGljIGludCB1cHN0cmVhbV9icmlkZ2VfZGlzdGFuY2Vfd2FybihzdHJ1Y3QgcGNpX2Rl
diAqcHJvdmlkZXIsDQoNCg==
