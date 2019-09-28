Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE03EC11F9
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Sep 2019 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfI1TMx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Sep 2019 15:12:53 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:38038
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbfI1TMx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 28 Sep 2019 15:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC5tw/5tsXZyAryQ0zya+AJ2pInfTvJeAY54fczhvWShkmCGx5StQuFbqMIGAdy6Zx3bcsrVUed6sn2RFjJxOqwYIAW9/KJ7tBhRViejg3HNuFt9FJ74o2XomhDuTMxm/mfrer5PS/0O6QWqPrCuzz53CJqu62eMP3uMY7rNTuzzO00MW5jYAWXsEXPwBSU8y4eiGzLZab613sA2dVUqlmspnb+qf1daJMsJ7CL9zd0kTMNTyEKj2GO0VF4SnCLzvB3ilKh0HtYC1VMKNz9tSKjEemtJ4J8uvJjxCdGYEhlYsHcabVTmWYYjNHiJpIZQgF7FLB0gShCeph4dVW674Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdaveTsVdccxdju6Nil7UfMEQ6pkxeNW85A2B94dnGg=;
 b=GgJW9LScgHDbGXQFW1AbdQEXGqi843Uc2/vKc/nDhZX+Io136dd5/wGVr4BeMQ57n4fyDCWUJhnrs77hKL/Zt+SZ3N+ZBQ9aTwvCudtqtmVxgFQJDPEXmHSN4cLuVOF5EVU8NuMOYJgh+QH6MZnDMG0tzXHEOy8Yy81Gw/b9ucuycpcqfveqH8//+dwbruC8MHm+yvD7zFbt1WGC/JO8yvE4JiQ0+tb0tFsIpizVyzXJZTCa/u/nMhtDHNuY2uLNGqmkW7wD61VJTHT28jH1zh71FrKvuKRlc7QMmGXi2uiJUEU5dCu43twTfgcd3faz7lwZJnw5ovhw/fK8lR9/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdaveTsVdccxdju6Nil7UfMEQ6pkxeNW85A2B94dnGg=;
 b=AuPNQAQZVxp6iI9tadjR2B248q7ux/iWCm7cECV/VeCX8U6Q3jjyoUSiLJVFZJd8Unk0lb0r5wHkj264F+1pvo2il1bpGcrrjxaFZnMMnpMPARhblWkRbZl74x1RpMUcZUq0hc7t6FzFc3JT8YWPWb0FxQvw4ihNA3oqWGY0EpY=
Received: from AM0PR05MB6115.eurprd05.prod.outlook.com (20.178.202.155) by
 AM0PR05MB6641.eurprd05.prod.outlook.com (10.141.190.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Sat, 28 Sep 2019 19:12:50 +0000
Received: from AM0PR05MB6115.eurprd05.prod.outlook.com
 ([fe80::89f6:397a:dad7:e455]) by AM0PR05MB6115.eurprd05.prod.outlook.com
 ([fe80::89f6:397a:dad7:e455%5]) with mapi id 15.20.2305.017; Sat, 28 Sep 2019
 19:12:50 +0000
From:   Yossi Itigin <yosefe@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: 2019 UCX and RDMA Annual Developers Meeting
Thread-Topic: 2019 UCX and RDMA Annual Developers Meeting
Thread-Index: AdV2MHuFApkTf3bHTQeqqCcemzHDEw==
Date:   Sat, 28 Sep 2019 19:12:49 +0000
Message-ID: <AM0PR05MB61157D44C2A2AE219418AC7EA6800@AM0PR05MB6115.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yosefe@mellanox.com; 
x-originating-ip: [176.231.4.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 169a5f20-b062-42eb-571c-08d74447dacf
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR05MB6641:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR05MB6641C86C1E2AAC594E346E51A6800@AM0PR05MB6641.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0174BD4BDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(39850400004)(376002)(396003)(199004)(189003)(476003)(6916009)(6506007)(25786009)(4744005)(102836004)(66946007)(2501003)(26005)(64756008)(66556008)(66476007)(256004)(7736002)(76116006)(486006)(33656002)(305945005)(66446008)(5640700003)(71190400001)(7696005)(5660300002)(71200400001)(93376004)(478600001)(2906002)(99286004)(966005)(2351001)(316002)(9686003)(6306002)(8936002)(55016002)(52536014)(81156014)(81166006)(8676002)(6116002)(74316002)(6436002)(86362001)(66066001)(186003)(3846002)(14454004)(15302535012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6641;H:AM0PR05MB6115.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: weCqbEESM8xYLmoBzrs7kGq/qqwCpZNkR3nbi9ReiLsgMBUm4L2mi11UsMZq9SGDkNKEMB55ezvFUDlsFeXUyBheuaR+srtIvmgmOd44AylfTCQVzt0AbqxjBZ7Lxq55w8bBSMUEVMjzwfNv7OegR11MuOgQYSWG5kp2s2trLHX14XQKYHfj3wwii6ZY/6d68kr6hS1gUxIPosRzoqs/ZlnLIN5AG/hKcWDkgkGraElbfuC1hr4mmhy06SN+hVUI6NWnH9UvP27MNspMdPRy6XvwpAvx1qBy8kx39CoIG53+4+6yPCXZU9soXhKsPvOHRqLilKv74B9uBrTahRL5F46BT/Vu+pmxB2Fm8G1wUPZ+PeZpDvD3oOUoAmeHGoGQsbu6eEEOTGedX5a3fH2eMUodBt0PCcln/qt9ajJl6Iiw4I1WKRNOfpT/7Wb1j6wCszzk/Cp2JQ97XjBZ3aov+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169a5f20-b062-42eb-571c-08d74447dacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2019 19:12:49.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzQMgvXc6s50bcnoKmsf1HpRKzAaBFyPRwlv1j+apr8WK/IgBxNKNcnRxFaasJGUl2BXV1op9cNnQWOTKCc6SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6641
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

The UCF consortium will host the 2019 UCX and RDMA Annual Developers Meetin=
g on December 9-12, at the Arm facilities, Austin, TX.

The three days meeting will cover UCX and RDMA related topics. You can find=
 the latest agenda on http://www.ucfconsortium.org/annual-meeting, as well =
as logistics and a registration form.

Please contact me for any questions, or requests for other topics.

Regards,
Yossi Itigin

