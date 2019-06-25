Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6EDF557CC
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 21:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFYTbZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 15:31:25 -0400
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:9060
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfFYTbZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 15:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI+W1tVJsFOLAb1HPyjANqcDABK5DuJxb7DJLCrxXUg=;
 b=FwGuLurFuP9DS9O+kqwrqTKu40jUsmE7m4fcfxEjTPay38rjwcMoy9zA1EWdeTkAhdLsbN6VhlQBwuwkRVceRRAIeL31mYxZdKkbW1NaD9n7d8HIbfc+N/Kcrcs/CIEiZWULRf1hlUhLIxjP41ddg2xk8VGUdou960UG4Io1Wz4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4255.eurprd05.prod.outlook.com (52.133.12.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Tue, 25 Jun 2019 19:31:21 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 19:31:21 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v3 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
Thread-Topic: [PATCH v3 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
Thread-Index: AQHVK4yRcqQcxGgsMEWe3FAvjxAOOA==
Date:   Tue, 25 Jun 2019 19:31:21 +0000
Message-ID: <20190625193117.GA9668@mellanox.com>
References: <71b3f719c2cb7b3c91ee1ac419b389c97e06a9c1.1561150636.git.dledford@redhat.com>
In-Reply-To: <71b3f719c2cb7b3c91ee1ac419b389c97e06a9c1.1561150636.git.dledford@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d464ebec-f01e-479e-16a8-08d6f9a3b391
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4255;
x-ms-traffictypediagnostic: VI1PR05MB4255:
x-microsoft-antispam-prvs: <VI1PR05MB425548AF04EB84AE632CB1C9CFE30@VI1PR05MB4255.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(446003)(6512007)(256004)(1076003)(4744005)(6436002)(11346002)(486006)(476003)(2616005)(71200400001)(71190400001)(86362001)(4326008)(14454004)(229853002)(102836004)(33656002)(26005)(6506007)(7736002)(68736007)(6486002)(99286004)(186003)(386003)(305945005)(6116002)(316002)(3846002)(36756003)(66066001)(66476007)(66446008)(8936002)(478600001)(66556008)(25786009)(5660300002)(81156014)(81166006)(64756008)(6916009)(8676002)(2906002)(6246003)(66946007)(53936002)(73956011)(54906003)(52116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4255;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fT+rPVXtzZ7QPu0fapOUmR4LbPRhJzRzEFFirOrvwDB6f1RGRxwy0dLs89fc+OfTsSjLiuNgKevPVKe2qmDnwPnCOR8Txw9MDIwd3RwdEuBvE6wA5JZELqjlOf2LSkmDHURhBKo53E7GfD10Qw5WbB4BUrrBPQxIIgXaoJ6G1zymefwy3C+vTSw34NSItjt4bE0eA0lUNLIDD4W39uAEhx5MuGT3QBQFxl6i5iJn2Hmel6XKyoVSWLQckAqMvS3mqCa7xIamEZDi/KNeC/xHbbVsDRT+V7iLD8127qsBh15l6BtY3F9klZxDTGVT7DY0UzcvDcmdDaI+z2Y4mHc0DOL+on0lvyspvr7ragKI8fnNnoEkHTZN1XZEyeIE/DxmO/7gCX186te0W27P1Mlwq4PtiuB6CbkUYaJnXezKYxE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45D1EF772106FB4FA74C8B3F9F0F2A19@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d464ebec-f01e-479e-16a8-08d6f9a3b391
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 19:31:21.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4255
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 21, 2019 at 05:00:44PM -0400, Doug Ledford wrote:
> For all string attributes for which we don't currently accept the
> element as input, we only use it as output, set the string length to
> RDMA_NLDEV_ATTR_EMPTY_STRING which is defined as 1.  That way we will
> only accept a null string for that element.  This will prevent someone
> from writing a new input routine that uses the element without also
> updating the policy to have a valid value.
>=20
> Also while there, make sure the existing entries that are valid have the
> correct policy, if not, correct the policy.  Remove unnecessary checks
> for nla_strlcpy() overflow once the policy has been set correctly.
>=20
> Signed-off-by: Doug Ledford <dledford@redhat.com>
> ---
>  drivers/infiniband/core/nldev.c  | 25 ++++++++++++-------------
>  include/rdma/rdma_netlink.h      |  6 ++++++
>  include/uapi/rdma/rdma_netlink.h |  4 ----
>  3 files changed, 18 insertions(+), 17 deletions(-)

Applied to for-next, thanks

Jason
