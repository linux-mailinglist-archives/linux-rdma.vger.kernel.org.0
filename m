Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C6B0FC1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfILNZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 09:25:05 -0400
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:53157
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731654AbfILNZF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 09:25:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akDrQpurGaXQHTL3Y2fWIzBqrz0xk6OvSCcMFBpWEw0yn4lFNzuWxeVNzmNgRcL3XMD+xgNEX5F6Jhj2rBiIVhgZfVCQEN0k57L+Kt5AIP8KJrsmcXTsoTv+0UV/ztC6UX/BOZWWSGLXJLxqq+MtK8Qicn+YvCaYt0MHOuOIJTHa5nXmiXUUXbd0ITGjrsYYW56JSSwsRXmn+L638erHuoMyj+v3btUeD81UaI6NbeplPFaEdUPfusl0i+7nh0zbkkxDRnWr9cl5y+oc8JLj3yCleGRBGtDzD6l1Z2VYbEV2wn3k9zvcYVCWc0acAPDW6IIyjreHNNCUi19wq12H/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpbgDoGn6rfIUudVpC3gzTQlrV/+bD2y5AjcX1v3TQQ=;
 b=S0/RNSrzxub3wDgdANBCeIs1DYfKREYg/b5Kc27o/7IB4YsY40kzEhqVk5EAd/w5euSgr3NUz6qe1mSMZ9iYyfzFMdjZwZQuzEgR+RKqrcYYMTmjg2TBmtO/21LeGiMEB7OzQXhTtx/htT8OriD+vjqyO1FnUF4Ht6oJWQa4eLiGlE4IwVyx9V5jcFMEil5L14VumnAhLWhCiRl2AeaSXuDZQ/8sqFdmvzJ4is9ZLGJWC1YX9D6/CwRuCc6MGQoM+aZaQL/iS5pm6IKxY1SdQG65E5gaqknM+ruofR8X4ashe6zpCZoMZNHp0Ujv0KgULifYGwS1M3Z74BrUg03SyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpbgDoGn6rfIUudVpC3gzTQlrV/+bD2y5AjcX1v3TQQ=;
 b=VzNxdIjL7NdhRL2uoPUd2P6ghbRJrbTbAvdaVfhjaDWhY54vO7QflwlJATRK5Z1GjGWpnY9w7xLPOAoK2tEFGqS6BhvAkhfaGVYMH5kdYelApMNyzS+ts0deUhhhcvr51kcVmPlZy376zlYbj6qqMKY7cytgSrTBpI7CjIzBHRw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4142.eurprd05.prod.outlook.com (10.171.182.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Thu, 12 Sep 2019 13:25:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 13:25:01 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     =?utf-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: fix false error message
Thread-Topic: [PATCH] RDMA/cma: fix false error message
Thread-Index: AQHVaW163+SKVadd0kKAlt3Citgg2Q==
Date:   Thu, 12 Sep 2019 13:25:00 +0000
Message-ID: <20190912132446.GA18484@mellanox.com>
References: <20190902092731.1055757-1-haakon.bugge@oracle.com>
In-Reply-To: <20190902092731.1055757-1-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:5:15b::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21279ffd-abd5-4fb3-4ba9-08d737849d22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4142;
x-ms-traffictypediagnostic: VI1PR05MB4142:
x-microsoft-antispam-prvs: <VI1PR05MB4142AA21E1D9FA56112DA7E1CFB00@VI1PR05MB4142.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(189003)(4326008)(86362001)(81156014)(54906003)(25786009)(71190400001)(36756003)(486006)(8676002)(33656002)(8936002)(52116002)(71200400001)(81166006)(66476007)(66556008)(64756008)(66446008)(7736002)(66066001)(305945005)(66946007)(478600001)(2616005)(99286004)(476003)(186003)(14454004)(11346002)(446003)(229853002)(6246003)(3846002)(6916009)(316002)(256004)(5660300002)(102836004)(6512007)(386003)(6486002)(26005)(53936002)(1076003)(6116002)(6436002)(15650500001)(4744005)(2906002)(76176011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4142;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vPk+pgcvacabE1D8ccLTcsEHbnAiea+kVeMwSy/291Ja5gL31ZWQZRDGJ2zZqnn2LzU89OxMjghoOiTqcX5o0qQ3N1/aJnG9i89YRp3Cd5ztIrgbaO8d4bC4Zjk6U7gSJGZyKQZ1Si6n75fm3IgjenGKiq8T4xkcR3Cph6od3FgqBgUJMFibAYvJUB66Fy15xg4Kmni4pncC7+atgbqJR/k7+hiOsRgrXiHIex2sedjYfLQPcjrfVaJkRX7hEZ64w9egUk+Vl2pWXowY332NADOV58AogBr7qdxD7xP4nf2hd2RpYeukDqhOwCsxVn9LOUxUYVis52p24U4/9DR1jbU3eMu448JrGA2HY61MNPbHhPO2qtYDtpUYkW8H90ah2nphNDqJ8seNZm1ekF1QjpXkSUI+/sMW3WnGDmY1cTo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8FAF54A570B9D4B8F935E737F50C85B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21279ffd-abd5-4fb3-4ba9-08d737849d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:25:01.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrzIMpItBxtwSpWfKDUdLlXnJYlPscfNpt4tJkncrvGlymro7e+oR/4ApkD8pw0qt86zEsY5Fj+r7d8011m31Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4142
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gTW9uLCBTZXAgMDIsIDIwMTkgYXQgMTE6Mjc6MzFBTSArMDIwMCwgSMOla29uIEJ1Z2dlIHdy
b3RlOg0KPiBJbiBhZGRyX2hhbmRsZXIoKSwgYXNzdW1pbmcgc3RhdHVzID09IDAgYW5kIHRoZSBk
ZXZpY2UgYWxyZWFkeSBoYXMNCj4gYmVlbiBhY3F1aXJlZCAoaWRfcHJpdi0+Y21hX2RldiAhPSBO
VUxMKSwgd2UgZ2V0IHRoZSBmb2xsb3dpbmcNCj4gaW5jb3JyZWN0ICJlcnJvciIgbWVzc2FnZToN
Cj4gDQo+IFJETUEgQ006IEFERFJfRVJST1I6IGZhaWxlZCB0byByZXNvbHZlIElQLiBzdGF0dXMg
MA0KPiANCj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xl
LmNvbT4NCg0KSSBhZGRlZCBhIGZpeGVzIGxpbmUsIHBsZWFzZSBkb24ndCBmb3JnZXQNCg0KQXBw
bGllZCB0byBmb3ItbmV4dA0KDQpUaGFua3MsDQpKYXNvbg0K
