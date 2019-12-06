Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB20114BAD
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2019 05:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLFEcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 23:32:47 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:50670
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbfLFEcr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Dec 2019 23:32:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It5vYAAyAC07tkPuM+thhsUzef22H6EhsqGeR9E3EeOUt1q39YrgeZDAOK2ovALuAGJHPjKU7hb94v391eby4l2cpsXRbFnYAeOWIdkQMvvQunBiG6AOQ9z56D7BDAhis+p0/67sE2RyeaFVc6hNml4awhrEFG/s/0cQF5eL/1lVmfZ59GaAKhaAefwG6j2c1T33Zp9kDuH1T3Li+TO7YnsNGvGTR/Jd5/Ee4jq7uJhPu4j3MOXaexpX6NKHCUFKSGbSF5xhkNFnp0/id9+wegiikj7OiJKUvNM0OTF4VxapwLTb6lpOD97piwf1pjxpVMARggCnOM0mnvCVtSQbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WYgzwjpnUyQpURA6qRvLVTB+nB/CAQJjlnw8TcKIug=;
 b=S5H6vMdFwCbFr/QTlC4ceLU8XPmNm3SxCRXE2L3WUdOX86Sc3i667dicew0SXQw61cZZYNpEfW2usnukugdhSgNZbjo4bElAVW8bw7LXzSUpxaepTZ0zvfy2f/GaCxyvkdDUkC+iM0HSdiw6dxBx07gneppOJ19Rlis4pRmhNP5RPGCjHLcksetPVycj/jDBvDjaXRFUg4hoZyPb0R6UmdLqO15z6VbPM61cAMpIcKGOY6F3AAc7TNWf8Hn5ZIjZ9hdr18RKymwHrHGgQFQumSgxHsIAYbnSQDx+rXg3dDrl0HF/6utnCpYHzmA704aWGu0/pT/0StAr4yKnZdfQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WYgzwjpnUyQpURA6qRvLVTB+nB/CAQJjlnw8TcKIug=;
 b=lCzaXkE+cexN1EBaDBwB4nFjTxgBT1nMpPTrQZcsm3ie76UtNBgB2VywqLMcKZItjugEYIDfkDOArMHnZcofjMMpb/kRRkKDkCbAMEd3t+DUzSBiigEw0mJ+4zfgW2QxHUoGEsboym8kitGKbrPQxIKPWyVCcGxtskqQ/faFo5M=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5617.eurprd05.prod.outlook.com (20.178.114.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.16; Fri, 6 Dec 2019 04:32:43 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::16:9951:5a4b:9ec6]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::16:9951:5a4b:9ec6%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 04:32:43 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: add missed unregister_pernet_subsys in init
 failure
Thread-Topic: [PATCH v2] RDMA/cma: add missed unregister_pernet_subsys in init
 failure
Thread-Index: AQHVq9Pt89YatrMAwEiYHZZ5ODPWQqeshL0A
Date:   Fri, 6 Dec 2019 04:32:43 +0000
Message-ID: <005ae1f8-3241-4a7e-aa1e-eb26275d15a9@mellanox.com>
References: <20191206012426.12744-1-hslester96@gmail.com>
In-Reply-To: <20191206012426.12744-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43a1bdad-d94c-4959-a987-08d77a055656
x-ms-traffictypediagnostic: AM0PR05MB5617:
x-microsoft-antispam-prvs: <AM0PR05MB561721424592D800FAC15C6BD15F0@AM0PR05MB5617.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(229853002)(2616005)(25786009)(5660300002)(11346002)(26005)(186003)(2906002)(64756008)(4744005)(66556008)(66446008)(66946007)(76116006)(91956017)(66476007)(71190400001)(71200400001)(76176011)(478600001)(86362001)(6512007)(31696002)(99286004)(4326008)(54906003)(316002)(102836004)(6486002)(14454004)(6506007)(53546011)(81156014)(8676002)(81166006)(8936002)(305945005)(36756003)(6916009)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5617;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NCxkO7grzZZCfzEOjrRODY+tw+5Dmta/+/rnc9FBLVVpuMb02mNn6YVr5cHuAdXecBNWup7PNtbx8km7bMWplc4S+B6CfDW7VQlex9U5zYXKkvQSFtPhtvGlF2SKyb6u7pm+xz0nKIbv9+qPwOe1NGrMldq6klTK+ajHMGnwEyhqocFuEFk94PXwdJYiwCKZlumMq6uH5Z7CviKfu6EnqL7v0SCDkFmr5AiqE3l8keqNFGuLliR2PRlsR/YZRnLgmQ2EEbePMNGapGm536tbkJe02d6nIzIfAJ063rVr3c9ooh9kJlAmTUcCpqGiacm2k79r0V6Vd/y9BY6XXT5YopVQ77QK0OxBo+oZ5LaYzS7AWxFTft52d3xO1PwoWAoBAWijsiiNGq82/135aXLubgvQ0U58ksOn70RtRks50QrHQ8xmEETXnkuyEMpPuPW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAC5438D2C75384D89383C38EA7F5F06@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a1bdad-d94c-4959-a987-08d77a055656
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 04:32:43.6690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aElmBjhqrAA814HgbqTQuo7Msps1AVXQEDo9BWZWzgc9CYVk7Ob7L6wmtvUYAyoWXC8jm6WLJPUmY9ewTkgf3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5617
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTIvNS8yMDE5IDc6MjQgUE0sIENodWhvbmcgWXVhbiB3cm90ZToNCj4gVGhlIGRyaXZlciBm
b3JnZXRzIHRvIGNhbGwgdW5yZWdpc3Rlcl9wZXJuZXRfc3Vic3lzKCkgaW4gdGhlIGVycm9yIHBh
dGgNCj4gb2YgY21hX2luaXQoKS4NCj4gQWRkIHRoZSBtaXNzZWQgY2FsbCB0byBmaXggaXQuDQo+
IA0KPiBGaXhlczogNGJlNzRiNDJhNmQwICgiSUIvY21hOiBTZXBhcmF0ZSBwb3J0IGFsbG9jYXRp
b24gdG8gbmV0d29yayBuYW1lc3BhY2VzIikNCj4gU2lnbmVkLW9mZi1ieTogQ2h1aG9uZyBZdWFu
IDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAgLSBB
ZGQgZml4ZXMgdGFnLg0KPiANCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jIHwgMSAr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2Nt
YS5jDQo+IGluZGV4IDI1ZjJiNzBmZDhlZi4uNDNhNmYwN2UwYWZlIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQv
Y29yZS9jbWEuYw0KPiBAQCAtNDc2Myw2ICs0NzYzLDcgQEAgc3RhdGljIGludCBfX2luaXQgY21h
X2luaXQodm9pZCkNCj4gIGVycjoNCj4gIAl1bnJlZ2lzdGVyX25ldGRldmljZV9ub3RpZmllcigm
Y21hX25iKTsNCj4gIAlpYl9zYV91bnJlZ2lzdGVyX2NsaWVudCgmc2FfY2xpZW50KTsNCj4gKwl1
bnJlZ2lzdGVyX3Blcm5ldF9zdWJzeXMoJmNtYV9wZXJuZXRfb3BlcmF0aW9ucyk7DQo+ICBlcnJf
d3E6DQo+ICAJZGVzdHJveV93b3JrcXVldWUoY21hX3dxKTsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAN
ClJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT4NCg==
