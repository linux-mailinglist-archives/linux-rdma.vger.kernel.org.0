Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317C4B11FB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfILPTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 11:19:52 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:23815
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732699AbfILPTw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 11:19:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH9ktRtnlB9DeomYlscYIgynCFOWUY0bX6LOUwUN1Gcld5x+j/EXW2iBwcPMo6Yc5h8RMX7wzkw7KOQJGgS8s4bb/MSgTIB7hDfOF2/Gqwpmag8hi8OIAXS3B2p5STWJ9vHzmnHvePo+zvCJhlmaeBEtLaoAFQPDX2gBwoIHPpU9svNurckIbMfzX8ZGzMCFI+8u+MlJ7DqVdr1XhvCviUGTITnz72w0B/AqUfnQ0WpyGX3gEfd70PS+lQ358Vyq+MbZFZHzvi7JamWtXDpWjw9q/cwRLqHf4uyLribIQufb3ylyjWcDL7OMRP6ftcjafQprSCuPBwiy5N69h8KpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K755RgnxnT7erHT5YYW7dvMtc+SwJ7G0p4t0PtPJedM=;
 b=XbQKJrOZ2gy4wMgXkJ5LTUxL74TLfHnkx6BgqyRZY8m39GyyEkCoU3qBuShu3E+xfB52hQYcVpV7RLkt2ZtRVffGQ+4PRbH+aQRMMDYtLUfFaPSWZujA+LOYEqM/ZcfE7Y7lgKU+wko6g5DiMpYfl+bojAbbixE36QVXlCG4jsS1hHRhi8nkZIXHLGmHe6xQFRVfoFGcqzOcKhN8m/z+t0XDcKDqUDRTU1QCGJL6Xq1Q1Yuj3tibXu6d1hXtHeAyVl99JLls21tg8WB/nvPTNPkI81J6V41ow7empJS9EX8nxUQwFnHzZ/BhIVduECyGJcoutjSHBp4RXTo/gq/IBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K755RgnxnT7erHT5YYW7dvMtc+SwJ7G0p4t0PtPJedM=;
 b=VdaVqu/8l+heKe9VaOCO70i4cCrBKNi2j9QSx2YCBTgV9CVvKJl0qbQtOKkZUaUIocoJHXWrHt/CdibbqnKCMjXDv/gnHNoT3aztka2h3VWg3u6/c9axe+PXP7udTetIqCpHew7ehYLcgQR9Qy6VhxnzVGxaPIqLo9uzgpyD6hY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5616.eurprd05.prod.outlook.com (20.177.203.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 15:19:47 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 15:19:47 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Sergey Gorenko <sergeygo@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v1] IB/iser: Support up to 16MB data transfer in a single
 command
Thread-Topic: [PATCH v1] IB/iser: Support up to 16MB data transfer in a single
 command
Thread-Index: AQHVaX2DnedK0iGqE0i2FO/TCy4tKQ==
Date:   Thu, 12 Sep 2019 15:19:47 +0000
Message-ID: <20190912151931.GA15637@mellanox.com>
References: <20190912103534.18210-1-sergeygo@mellanox.com>
In-Reply-To: <20190912103534.18210-1-sergeygo@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:5:80::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 612e86ef-a881-43e3-69ec-08d73794a609
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5616;
x-ms-traffictypediagnostic: VI1PR05MB5616:|VI1PR05MB5616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5616ED6B241842CF418728BACFB00@VI1PR05MB5616.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(199004)(189003)(478600001)(71190400001)(446003)(86362001)(64756008)(66556008)(476003)(52116002)(66946007)(25786009)(11346002)(71200400001)(66446008)(33656002)(53936002)(81156014)(486006)(66476007)(305945005)(107886003)(7736002)(8676002)(81166006)(6512007)(76176011)(6246003)(4326008)(2616005)(99286004)(6862004)(316002)(2906002)(37006003)(256004)(14444005)(6636002)(186003)(36756003)(8936002)(229853002)(26005)(66066001)(102836004)(5660300002)(386003)(1076003)(14454004)(6506007)(6436002)(54906003)(6486002)(6116002)(4744005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5616;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e+Es/5O+VvqE5L4kFt+347NU2u11KRWntJR9+reCBkFeSFkPz4Wka4B3OlRJ9dtOvJI75s1VRnt6ykoXhGLiTRHNSmSGKv+TC2xneeICQjEh43UFmtMwsTu3rA4OHA8Uf+ltyICGpoMvmriUDiiMnWPayeCSpmkADNK7D4UcEXwGdws3CeHVSRKFTNTi4KSW4Snya75/cBv/5pSOPa2dfEhuiEJEO7y+Ipr7MvsMXaTBT7pdrmFgGl6E/iF+Wl6SC21lT/+7c1VixfjNHgLJGbxMwKmTffd2xhb9rDx1kyCj6GYse8ENbWy+5ePm7sC+R0h9gOAafLfnGcSviKgQc77YGMK27P4YIS2N7hq4YVkcgY+d0MyRR07u/sIMQR2hbTpiwvpcwgl2PvtPubjG+e3dTQyRmOwODnrLgh/7ohs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC7D1CCCD0047741A82C5369899E2242@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612e86ef-a881-43e3-69ec-08d73794a609
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 15:19:47.8455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2p9bs2znxhiuzmlA5AfmjNpkllMBV/mfX3pX9IzIWG1Rovm8dwpoEO/sTswHbN3Qq3yR87xOK3/qPFU0Peo7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5616
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 12, 2019 at 10:35:34AM +0000, Sergey Gorenko wrote:
> Maximum supported IO size is 8MB for the iSER driver. The
> current value is limited by the ISCSI_ISER_MAX_SG_TABLESIZE
> macro. But the driver is able to handle 16MB IOs without any
> significant changes. Increasing this limit can be useful for
> the storage arrays which are fine tuned for IOs larger than
> 8 MB.
>=20
> This commit allows to configure maximum IO size up to 16MB
> using the max_sectors module parameter.
>=20
> Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v0:
> - Change 512 to SECTOR_SIZE (suggested by Sagi)
>=20
>  drivers/infiniband/ulp/iser/iscsi_iser.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to for-next with Sagi's ack

Thanks,
Jason
