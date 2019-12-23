Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE4129797
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2019 15:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLWOjX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Dec 2019 09:39:23 -0500
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:29056
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbfLWOjX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Dec 2019 09:39:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVKQrRkFLZBf7uu6SMUe078IIvvjZJxh6jIbfFbPHARFNUQ1rsqW9aybJ3+hScaxO6iToFySOmL3hwPoXQEiUp9hTfTXkqd4eYXbXti1RKvNSHReJFsIcfli86rE7JJWyZMZe3Y5vmpr5CM2hzg5JN9BohreqHkMHR1OfYS5z6L2IkUdCOwyu48yEDzxkImf66+7+1WHjXNiPovL30a86D2pXJSviufK4UtPamJ8Ln4WDgFBQj7oXyMBTqVL423ocZARm/i0yOyP46qiRwDWF4LcWJWOwcuhOGAvTjTvjNZymchqJtRDP2D2ujKqAaV/ktxon0FC2pCYINEYnMSvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAiCPmFKSJrH5faOVEsMNod3b44xAaz7tWU7JxUNwN4=;
 b=ccqc1EtnLId4uHUjDeX7QFvCJJIHP9OfD+gz4AEOhcdQb6E+oQJ76KC8O7cRRYKwXurKa6zng1vSE/BcqzCF0K1kSS4ufI6ATDjIpc+xDGDSesxooxvwI8b9CyBRF2g5f+Cwqwb9Si7kaE6yamt8/L0fW1WIdZPcMvtZIaoZwZoyRXMvfNXdwKSJomtx5+m1xG9eVOo9NVuXUw1qrHHuoEofQpNopJA1uO2pmK0GZ9waK/CIFTumcAUdwQ89QuMcF6mrEy4GTOb8PRdHCm6MmvvPtV8X40K++sNfyusX/fcM5hI/IvJrN1my9Bg9oslzSNL7N15GiNb8cYLUm6KfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAiCPmFKSJrH5faOVEsMNod3b44xAaz7tWU7JxUNwN4=;
 b=lTgwtkENA1QqHrLC4XQtr3eOBW3M/Arcx+922AH0BSyxAqdDWLInCADhOZHu8Yt3Wgj3t5g+H1+w7FFl1F1oxa4NCSaQPmHN6ukUkb3H3MY9T2FY2H/SjARwtm5pqFC0X68iIsV1JeuIumNK+qOaUE0PlrpQZuYnu/HAwswGRzs=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6215.eurprd05.prod.outlook.com (20.178.94.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Mon, 23 Dec 2019 14:39:18 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::bc8c:12ca:edd3:92ca%4]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 14:39:18 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] pyverbs: fix speed_to_str(), to handle disabled links
Thread-Topic: [PATCH 1/1] pyverbs: fix speed_to_str(), to handle disabled
 links
Thread-Index: AQHVt56YMvfNdL2zKUuiBqNr6rZVmKfHziqA
Date:   Mon, 23 Dec 2019 14:39:18 +0000
Message-ID: <fefd5386-d54b-a58e-29df-91a6dd94ccf0@mellanox.com>
References: <20191221013256.100409-1-jhubbard@nvidia.com>
 <20191221013256.100409-2-jhubbard@nvidia.com>
In-Reply-To: <20191221013256.100409-2-jhubbard@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:208:1::37) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 983939b2-8a92-43c4-0b59-08d787b5e43d
x-ms-traffictypediagnostic: AM6PR05MB6215:
x-microsoft-antispam-prvs: <AM6PR05MB6215627A1729188885841E96D92E0@AM6PR05MB6215.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:328;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(66446008)(478600001)(54906003)(36756003)(66946007)(2906002)(110136005)(6506007)(53546011)(64756008)(26005)(66556008)(66476007)(186003)(71200400001)(316002)(4326008)(2616005)(6512007)(86362001)(31696002)(31686004)(6486002)(8676002)(81156014)(81166006)(52116002)(8936002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6215;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fAllXakSFQILdveZGuULUvQMAIk4Xq0sz7XunLNjlSLa8NUt3bK/oQlhsEx1xBgc/HaxKUfeIvGZlK2HuG6Y8PtJipen5U0+SHrKJETRHpfB3QMSWRVmnzGBUvOQ55qLN82IGs+k2nA+L3vav5peiWR6l331kAPQfJVTD75YMF15Vc1ok7ajI5zjudh+/HEnx7z8STqmBQ7SyCVF38dXvFd/QQKbQRRGbrwXR9JxtAORZM78MONKh7hoEBTzO02W8xGq+HbHl/1m5o2WxcCScQYcqoWfri4zXXyALLzKWk1xG7+dFAKvCwngh5oG0+8ByZsN1PD8NL9QLDpkzH13qN0463LAdfei5h69Pzh2mITgJx1SOt7qP7GdHV/WwWhCdIOfDICbiHsgV3BCF3bdTJrgtWIAWsaq42kUYDtjEIt6czHUnJ/xWulIBMPo+FdO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D4C42BBF5B8914BBC20A64A68FCED4C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983939b2-8a92-43c4-0b59-08d787b5e43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 14:39:18.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeYCXQ5FS6njSj3V3lUQzVPjAZa5Y820yAE6AZ/S4+9/HgH/wXWCAX0v1A1A3RGZaaqG9UknhX9WRdq03NrPIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6215
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgSm9obg0KDQpPbiAxMi8yMS8yMDE5IDM6MzIgQU0sIEpvaG4gSHViYmFyZCB3cm90ZToNCg0K
PiBGb3IgZGlzYWJsZWQgbGlua3MsIHRoZSByYXcgc3BlZWQgdG9rZW4gaXMgMC4gSG93ZXZlciwg
c3BlZWRfdG9fc3RyKCkNCj4gZG9lc24ndCBoYXZlIHRoYXQgaW4gdGhlIGxpc3QuIFRoaXMgbGVh
ZHMgdG8gYW4gYXNzZXJ0aW9uIHdoZW4gcnVubmluZw0KPiB0ZXN0cyAodGVzdF9xdWVyeV9wb3J0
KSB3aGVuIG9uZSBsaW5rIGlzIGRvd24gYW5kIG90aGVyIGxpbmsocykgYXJlIHVwLg0KPg0KPiBG
aXggdGhpcyBieSByZXR1cm5pbmcgJzAuMCBHYnBzJyBmb3IgdGhlIHplcm8gc3BlZWQgY2FzZS4N
Cj4NCj4gQ2M6IE5vYSBPc2hlcm92aWNoIDxub2Fvc0BtZWxsYW5veC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4NCj4gLS0tDQo+ICAgcHl2
ZXJicy9kZXZpY2UucHl4IHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL3B5dmVyYnMvZGV2aWNlLnB5
eCBiL3B5dmVyYnMvZGV2aWNlLnB5eA0KPiBpbmRleCAzM2QxMzNmZC4uY2Y3Yjc1ZGUgMTAwNzU1
DQo+IC0tLSBhL3B5dmVyYnMvZGV2aWNlLnB5eA0KPiArKysgYi9weXZlcmJzL2RldmljZS5weXgN
Cj4gQEAgLTkyMyw4ICs5MjMsOCBAQCBkZWYgd2lkdGhfdG9fc3RyKHdpZHRoKToNCj4gICANCj4g
ICANCj4gICBkZWYgc3BlZWRfdG9fc3RyKHNwZWVkKToNCj4gLSAgICBsID0gezE6ICcyLjUgR2Jw
cycsIDI6ICc1LjAgR2JwcycsIDQ6ICc1LjAgR2JwcycsIDg6ICcxMC4wIEdicHMnLA0KPiAtICAg
ICAgICAgMTY6ICcxNC4wIEdicHMnLCAzMjogJzI1LjAgR2JwcycsIDY0OiAnNTAuMCBHYnBzJ30N
Cj4gKyAgICBsID0gezA6ICcwLjAgR2JwcycsIDE6ICcyLjUgR2JwcycsIDI6ICc1LjAgR2Jwcycs
IDQ6ICc1LjAgR2JwcycsDQo+ICsgICAgICAgICA4OiAnMTAuMCBHYnBzJywgMTY6ICcxNC4wIEdi
cHMnLCAzMjogJzI1LjAgR2JwcycsIDY0OiAnNTAuMCBHYnBzJ30NCj4gICAgICAgdHJ5Og0KPiAg
ICAgICAgICAgcmV0dXJuICd7c30gKHtufSknLmZvcm1hdChzPWxbc3BlZWRdLCBuPXNwZWVkKQ0K
PiAgICAgICBleGNlcHQgS2V5RXJyb3I6DQoNClRoaXMgc2VlbXMgT0sgdG8gbWUuIEJUVywgd2hh
dCdzIHRoZSByZXBvcnRlZCBhY3RpdmVfd2lkdGggZm9yIGRpc2FibGVkIGxpbmtzPw0KTWF5YmUg
d2lkdGhfdG9fc3RyIGNvdWxkIHVzZSBhIHNpbWlsYXIgZml4Lg0KDQpUaGFua3MsDQpOb2ENCg0K
