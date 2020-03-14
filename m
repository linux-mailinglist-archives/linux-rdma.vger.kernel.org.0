Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3281856F8
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2020 02:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgCOBbI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Mar 2020 21:31:08 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:43394
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727201AbgCOBbI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjQgGUMopQp/Cp5dsczEKpRtdHC0vyvl37n3rDHXWyYrJyfIgu/6jOWp3KIZcBAFl7jltl3BiWVG2DQ3if8AHzdzsWLs6dfifsnYc7SepwImzFoJaqzdEgbPbM1Grs5tDvcAe/oRPztLxgpEqgleSb38UBDaNYy0UtKKF+0jQK0uzOqBPj//R3IHF6NX6IMl8nBA/EJMn0bH+qQ69fS7sf2gZHgSMwzd7AIXhf66dQmgwvijpvgA3U+sLgquTObJuJMGyzcW3Q4T+AUBj+GStxDSStj0bkLTPJaRsuR0bFt7DznxGKh/tTKytboWeFiEhXuxKiZ5aAjIR3K/74iXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJTmaRLkjapgTpdGnlPDKTq46hOfWbCbSVPGOqFSbIw=;
 b=T2ywksX839r/H5CSRqFUFfEa/vMZUBG23rf+mkK6UaKP2nx1phiEU6Jq2zOjStOHKWHiY36QabXohSL9iWxZCTNEqxjXBJG/mWIXETpSQQ3NAXQsx63KhT8OS8SWbM5/OGF+F15CYOwXEr0/hIOo5SaoRlqc+MprAGwyPmhQEjyLVDgsr1d6syuCj1x6sVwb1DeooG7B6zFjA50RvDQrgtUBZgvNKRJ8TBJRmHzTQTP3akUdj9TGtUDZE7SOqe89MEdn654BDJTqleDBcqsuUtSZocdHlzV/aEDWDeJSXFhfxzazZZLJoVHpKj75Tee5LP1gPdzTTMdwxdxOYG0TXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJTmaRLkjapgTpdGnlPDKTq46hOfWbCbSVPGOqFSbIw=;
 b=C2xUqFqikdm3dbkNiHujEMZ1JLThsAFZImQdRhNOBdhjUkgfamcfiEiSZRpRfmScIHAx9nWrBNXW4Ry2/q9f/Ss4+gSVYM6JkNmAEIlzNrbLsZpEcMJKt+qT61wKpSUkVfFvlRmvoZdHhTja6HtPtm1kZsx+CuJgk9V4+TENs+w=
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com (20.177.33.13) by
 AM6PR05MB4933.eurprd05.prod.outlook.com (20.177.34.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Sat, 14 Mar 2020 12:54:56 +0000
Received: from AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::cbb:a034:c324:138b]) by AM6PR05MB5014.eurprd05.prod.outlook.com
 ([fe80::cbb:a034:c324:138b%6]) with mapi id 15.20.2814.007; Sat, 14 Mar 2020
 12:54:56 +0000
From:   Yanjun Zhu <yanjunz@mellanox.com>
To:     huangqingxin <tigerinxm@gmail.com>, Moni Shoua <monis@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        huangqingxin <huangqingxin@ruijie.com.cn>
Subject: Re: [PATCH] RDMA/rxe: Advance req.wqe_index when rxe_requester meets
 error
Thread-Topic: [PATCH] RDMA/rxe: Advance req.wqe_index when rxe_requester meets
 error
Thread-Index: AQHV+f/Ce6EEdiLdJEyOO/8uHJrwxQ==
Date:   Sat, 14 Mar 2020 12:54:56 +0000
Message-ID: <f1b791c7-8d6c-8816-ff16-2180a12f9934@mellanox.com>
References: <20200312165032.11644-1-tigerinxm@gmail.com>
In-Reply-To: <20200312165032.11644-1-tigerinxm@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yanjunz@mellanox.com; 
x-originating-ip: [118.201.220.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 443363d7-9474-45af-a67a-08d7c816e5a0
x-ms-traffictypediagnostic: AM6PR05MB4933:|AM6PR05MB4933:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB49332AEA1C63034070652378D8FB0@AM6PR05MB4933.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 034215E98F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(8936002)(4326008)(8676002)(316002)(36756003)(81156014)(54906003)(6486002)(81166006)(110136005)(31686004)(2616005)(6506007)(53546011)(6512007)(478600001)(6636002)(5660300002)(2906002)(76116006)(91956017)(26005)(186003)(66446008)(66556008)(64756008)(31696002)(71200400001)(66946007)(66476007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4933;H:AM6PR05MB5014.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EM9XiwMZNCqoOsSozGA4Q9rHzp13SbUmfj8EpQA89LeLkKqRvMnCjW9BHIjSveKoDv29WhNhHgXriLOQw22O6fqIVUCNvcUgd8SI7wqnkcD9jX8McoCOeAbqiR9CgOD7w+o/LFPjSsoYukxBNf9cvlm5bEng51iAnoWzvT8ZtaXvXhisXOJpFX6/5WgcXgmEIYsr5gzJ87+N8WTqmdBfR0G7Z6UkX1smo+p0mmHrhQMCB3PFFMeBhjfah5qCQ5qkU3HacCVwFM2mm+dE2EXkUuvdsF23KY47+LxgncquOr9wOh8iuSV2Q4dZSu2Ke9fAGWLFs2NOjgukrZ3IEDOeYKCMLKhU4bdHXfXX97NE94Y5XZqHstMciYbCrdP45FH5LSh4OtBM+vUsp4yXA/zYALqj1HrOoXziODmuSI2gD2LtqHe7N/Rm02tPAeWa00pw
x-ms-exchange-antispam-messagedata: wIKRM+8V+N3mei1aV+vDf2Y5yugytNTPxygoUYKDcLjTaVfMyOnNdpXvjH4dXdwbrWaXOjc1Mw3relQETMZJH5Adb3L9ntT0Zj5uIMvQ5KXCtQF81DzGv695uzCLfE5lXDap3mh4QVN1v3P9IxVc2Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A57113360D0B044F9E47D2339B25B951@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443363d7-9474-45af-a67a-08d7c816e5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2020 12:54:56.2002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfb7hRJg8x3VESlflf2P6f2GW8/Z3TfwRemPXo6tb0HjbQ8lSH78MbnL2f06nHw+8QjfegWnWlzKWA/MkI+kcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4933
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpXaGVuIGFuIGFwcGxpY2F0aW9uIHdhbnRzIHRvIG1vdmUgZGF0YSBvdmVyLCBpdCB0ZWxscyB0
aGlzIHRvIHRoZSBSRE1BIE5JQw0KdGhhdCB0cmFuc2xhdGVzIHdvcmsgcmVxdWVzdCAoV1IpIGlu
dG8gd29yayBxdWV1ZXMgKFdRKS4gVGhpcyBpcyBkb25lIGJ5DQpwbGFjaW5nIGluc3RydWN0aW9u
cyBpbnRvIHRoZSByZXNwZWN0aXZlIHNlbmQgb3IgcmVjZWl2ZSBxdWV1ZXMgdGVsbGluZyB0aGUN
CnJOSUMgd2hhdCBtZW1vcnkgYnVmZmVycyBmb3JtIHRoZSByZWdpc3RlcmVkIHJlZ2lvbiBpdCB3
YW50cyB0byBzZW5kIG9yDQpyZWNlaXZlLiBUaG9zZSBpbnN0cnVjdGlvbnMgYXJlIGNhbGxlZCBX
b3JrIFF1ZXVlIEVsZW1lbnRzIChXUUUpLg0KDQpBIFdRRSBjb250YWlucyBhIHBvaW50ZXIgdG8g
dGhlIG1lbW9yeSBidWZmZXIuIFdoZW4gaXTigJlzIGEgc2VuZCBxdWV1ZQ0KaXQgcG9pbnRzIHRv
IGRhdGEgdG8gYmUgc2VudCBvdmVyIHRvIHRoZSBvdGhlciBzaWRlLiBJbiB0aGUgY2FzZSBvZiBh
IA0KcmVjZWl2ZQ0KcXVldWUsIGl0IHBvaW50cyB0byB0aGUgbWVtb3J5IGJ1ZmZlciB3aGVyZSB0
aGUgZGF0YSB3aWxsIGJlIHdyaXR0ZW4gdG8uDQoNClRvIHRoaXMgY29tbWl0LCByeGUgc2tiIGFs
bG9jYXRpb24gZmFpbGVkLiByZXEud3FlX2luZGV4IHNob3VsZCBub3QgYmUgDQphZHZhbmNlZC4N
ClBsZWFzZSBkbyBzb21ldGhpbmcgaW4gb3RoZXIgcGxhY2VzLg0KDQpaaHUgWWFuanVuDQoNCk9u
IDMvMTMvMjAyMCAxMjo1MCBBTSwgaHVhbmdxaW5neGluIHdyb3RlOg0KPiBGcm9tOiBodWFuZ3Fp
bmd4aW4gPGh1YW5ncWluZ3hpbkBydWlqaWUuY29tLmNuPg0KPg0KPiBJbiB0aGUgcnhlX3JlcXVl
c3Rlciwgd2UgbWF5IGZhaWwgdG8geG1pdCBwYWNrZXQgZm9yIG1pc3NpbmcgR0lEIGVudHJ5Lg0K
PiBXZSBzaG91bGQgYWxzbyBhZHZhbmNlIHJlcS53cWVfaW5kZXggdG9vLk90aGVyd2lzZSwgd2Ug
d29uJ3QgYmUgYWJsZQ0KPiB0byBnZXQgdGhlIG5ldyBuZXh0IHdxZSwgYW5kIGNvbXBsZXRlciB3
b3VsZCBjb25zdW1lIHRoZSB3cm9uZyB3cWUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IGh1YW5ncWlu
Z3hpbiA8aHVhbmdxaW5neGluQHJ1aWppZS5jb20uY24+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9yZXEuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQo+IGluZGV4IGU1
MDMxMTcyYy4uMDhmNGJlYTA2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9yZXEuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEu
Yw0KPiBAQCAtNzU2LDYgKzc1Niw3IEBAIGludCByeGVfcmVxdWVzdGVyKHZvaWQgKmFyZykNCj4g
ICBlcnI6DQo+ICAgCXdxZS0+c3RhdHVzID0gSUJfV0NfTE9DX1BST1RfRVJSOw0KPiAgIAl3cWUt
PnN0YXRlID0gd3FlX3N0YXRlX2Vycm9yOw0KPiArCXFwLT5yZXEud3FlX2luZGV4ID0gbmV4dF9p
bmRleChxcC0+c3EucXVldWUsIHFwLT5yZXEud3FlX2luZGV4KTsNCj4gICAJX19yeGVfZG9fdGFz
aygmcXAtPmNvbXAudGFzayk7DQo+ICAgDQo+ICAgZXhpdDoNCg0KDQo=
