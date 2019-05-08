Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D21717EDE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfEHRIL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 13:08:11 -0400
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:10944
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728533AbfEHRIL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 13:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3VA26tvZYD9qFyNSmJZ0TXKnQwobzZTsJULuJncfq8=;
 b=r03rf3yrHwUPrUGzbN2jaWtIEQYX9NQ65juIHDgIQsLr/ssqB2grwJYIoQazzNGuWYQgOqWW85Cpy/tFs93ayFvzlkbqJdEv+vHS8jFx0FWWG5R4HGrgJbTqNizELhe5UgnV1Qa5lICMI4lupBiV5R5vxWYKB3pMDxC5OE1EjRk=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4998.namprd05.prod.outlook.com (20.177.230.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.19; Wed, 8 May 2019 17:08:08 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f0e2:4d9d:b09b:def5]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f0e2:4d9d:b09b:def5%7]) with mapi id 15.20.1878.019; Wed, 8 May 2019
 17:08:08 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [Suspected Spam] Re: [PATCH] libibverbs: Expose the get neighbor
 timeout for dmac resolution
Thread-Topic: [Suspected Spam] Re: [PATCH] libibverbs: Expose the get neighbor
 timeout for dmac resolution
Thread-Index: AQHVBJQ03rON3H5UMUmK3O/KPKwCrqZfnnCA///fJICAAc7IAIAAK6WA
Date:   Wed, 8 May 2019 17:08:07 +0000
Message-ID: <bda02d68-6a72-7076-60b1-4842de18a48f@vmware.com>
References: <20190507051537.2161-1-aditr@vmware.com>
 <20190507125259.GT6186@mellanox.com>
 <266697af-bf5e-07a1-489e-fed7cf8c695a@vmware.com>
 <20190508143133.GG32297@mellanox.com>
In-Reply-To: <20190508143133.GG32297@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR01CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::43) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ee40927-d2df-4303-2cbb-08d6d3d7bde6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB4998;
x-ms-traffictypediagnostic: BYAPR05MB4998:
x-microsoft-antispam-prvs: <BYAPR05MB4998935B55B22D3DC7B5FC8CC5320@BYAPR05MB4998.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(68736007)(66946007)(73956011)(66556008)(6246003)(66476007)(64756008)(31686004)(36756003)(102836004)(66066001)(8676002)(478600001)(4326008)(229853002)(5660300002)(6436002)(8936002)(6916009)(186003)(7736002)(305945005)(6486002)(26005)(71190400001)(71200400001)(81156014)(2616005)(476003)(25786009)(99286004)(11346002)(446003)(6506007)(386003)(66446008)(53936002)(3846002)(14454004)(52116002)(6116002)(486006)(81166006)(54906003)(256004)(6512007)(76176011)(316002)(2906002)(86362001)(31696002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4998;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: juDd4qAukb3cE68+tLP82vVTqf/LuHlS9ZwSruijQ7M8EOmenrKypVFWfnMswlHckX1bxjx1tWOqu7lewaRMrPxkOwDgYoDjGQZmGBsmw4UOw7ZvI7QN1XaycBHcRtqDUbR+QeENaqTT8z4yatanDVrjwWTpP7UwqkRRHvJlaBLWRc0WPfd81c12iDAr3Icaj4fV9Lg3CK+gUCMkbiYwMwM6TQ0jOTb4BquWZD1/8Yt+NCYZts5UMwWu4HJilkY758tWU2D+QAekYEzm1oX+aYYs1M2Amhr8AQ5NnS2efJqoK+11rrc8gGC7kNufa03fzdFTP2qJNkx9PSrjp7/iQSXWvnNvw0ffLHdJnK8+jbW6rHajqoIvO4NkuMEDIkeEwy4QrzNAEAnASZYAWPJspx1gfeBrGiBqA+20rYZ1+Yg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <337335E3715EC74AB27C42B8A5B0D58B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee40927-d2df-4303-2cbb-08d6d3d7bde6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 17:08:07.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4998
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNS84LzE5IDc6MzEgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVHVlLCBNYXkg
MDcsIDIwMTkgYXQgMDU6NTU6MjVQTSArMDAwMCwgQWRpdCBSYW5hZGl2ZSB3cm90ZToNCj4+Pj4g
IC8vIENvbmZpZ3VyYXRpb24gZGVmYXVsdHMNCj4+Pj4gIA0KPj4+PiAgI2RlZmluZSBJQkFDTV9T
RVJWRVJfTU9ERV9VTklYIDANCj4+Pj4gZGlmZiAtLWdpdCBhL2xpYmlidmVyYnMvdmVyYnMuYyBi
L2xpYmlidmVyYnMvdmVyYnMuYw0KPj4+PiBpbmRleCAxNzY2YjlmNTJkMzEuLjJjYWI4NjE4NGUz
MiAxMDA2NDQNCj4+Pj4gKysrIGIvbGliaWJ2ZXJicy92ZXJicy5jDQo+Pj4+IEBAIC05NjcsNyAr
OTY3LDYgQEAgc3RhdGljIGlubGluZSBpbnQgY3JlYXRlX3BlZXJfZnJvbV9naWQoaW50IGZhbWls
eSwgdm9pZCAqcmF3X2dpZCwNCj4+Pj4gIAlyZXR1cm4gMDsNCj4+Pj4gIH0NCj4+Pj4gIA0KPj4+
PiAtI2RlZmluZSBORUlHSF9HRVRfREVGQVVMVF9USU1FT1VUX01TIDMwMDANCj4+Pj4gIGludCBp
YnZfcmVzb2x2ZV9ldGhfbDJfZnJvbV9naWQoc3RydWN0IGlidl9jb250ZXh0ICpjb250ZXh0LA0K
Pj4+PiAgCQkJCXN0cnVjdCBpYnZfYWhfYXR0ciAqYXR0ciwNCj4+Pj4gIAkJCQl1aW50OF90IGV0
aF9tYWNbRVRIRVJORVRfTExfU0laRV0sDQo+Pj4NCj4+PiBSZWFsbHkgY29tcGlsZSB0aW1lIGNv
bmZpZ3VyYXRpb25zIGFyZSBub3Qgc28gdXNlZnVsLCB3aGF0IGlzIHRoZSB1c2UNCj4+PiBjYXNl
IGhlcmU/IA0KPj4+DQo+Pg0KPj4gSW4gdGhlIGdlbmVyYWwgc2Vuc2UgSSBhZ3JlZSB3aXRoIHlv
dS4gUHJlLWJ1aWx0IFJQTXMgbWF5IG5vdCBoYXZlIHRoaXMNCj4+IHNldCB0byBhbnl0aGluZyBv
dGhlciB0aGFuIHRoZSBkZWZhdWx0IHZhbHVlLiANCj4+IEhvd2V2ZXIsIGluIG91ciBpbnRlcm5h
bCB0ZXN0aW5nIHdlJ3ZlIHNlZW4gdGltZW91dHMgd2hlbiB0cnlpbmcgdG8NCj4+IHJlc29sdmUg
dGhlIERNQUMgd2hlbiBjcmVhdGluZyBhbiBBSC4gSW5zdGVhZCwgb2Ygc2ltcGx5IGluY3JlYXNp
bmcNCj4+IHRoZSAjZGVmaW5lIHZhbHVlIGhlcmUgSSB0aG91Z2h0IGl0IHdvdWxkIGJlIG1pbGRs
eSBoZWxwZnVsIHRvIGV4cG9zZSANCj4+IHRoaXMgb3V0Lg0KPj4NCj4+IElmIHRoaXMgaXMgbm90
IGdvaW5nIHRvIGJlIHVzZWZ1bCBJIGNhbiBkcm9wIGl0IGJ1dCBJIHRob3VnaHQgaXQgd291bGQg
DQo+PiBhdGxlYXN0IG1ha2UgcmRtYS1jb3JlIGEgYml0IG1vcmUgY29uZmlndXJhYmxlLi4NCj4g
DQo+IFN0dWZmIGxpa2UgdGhpcyBzaG91bGQgbm90IGJlIGNvbmZpZ3VyZWQuLiBpZiB5b3UgYXJl
IGhpdHRpbmcgdGltZW91dA0KPiBpdCBzb3VuZHMgbGlrZSBhIGJ1ZyBvZiBzb21lIHNvcnQgdG8g
bWUuDQoNCk1heWJlIC4uIEkgZG9uJ3QgaGF2ZSBhbnkgY3ljbGVzIHRvIGRpZyBkZWVwZXIgaW50
byB3aGF0IGxpYm5sMyBpcyBkb2luZy4NCg0KPiBKYXNvbg0KPiANCg0K
