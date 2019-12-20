Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205B91274D3
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 05:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLTEyN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 23:54:13 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:60046
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbfLTEyN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 23:54:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv6Ab5xkZqYeWK1X9D7qiO/qj3pGsD5AwQ5pvabmJxoKpgtoBmvMPZhVtwaYkulV7Ax0CtPV0t8Cy5x/+DFkM1Eo+JWSm9uoLRJtLjGimPKeE4E0CX3S4lRWJK+KZL9J1h/Y4V6mRO0nnwJu10KB+KzYGPzClShHHEBarZwUMlJlpDSke8yhuJp0lU5hiolJXOXXjvC3zO//zzJuDjsHP8hL1+tpOeHxGi0SMrwohmRmOvMjXNSSaSYmGLSEJJ2NumLJla/JXAAWijmPc8OYspcexuKgwSAIaqIGAwRJMuNpjmRQfl7RqXBiJ+2HZKkSkDRJMNpEKWXRuefM8iTkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hne2o48caM4GuJlIOI2qg/dViHEMusyHGNZLSeSafSk=;
 b=UWucSx6jxCP9lJw0des6FAPP2UbqzgxQx7xYEM/67fAns6w7T/sIALxyG9RPiAaTqQsKCqVGN5MMDSYutgZyy94zotXoKVH8IGvb1BQP65i8vueyCd6ICX0VVcpfMFBHk0BFGlFoFyUNm/SYVouvkcoy8Afqv/qW/5fkHW17eyPjUy22E0h2iEHwNK3RAAglnMhHFKbmA7YSALhwVHymF9T+4hsRGBuIUWAETHHMoLGpAF7hf9l729g8RieE9LuS14iX2bWkOARGiqkjXJRrfp+ed1u7ubArjkGjcUCVG8xIc+2rZCFMJCMyrl9lCC0uD/ONBrmuQX16zlraTMlQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hne2o48caM4GuJlIOI2qg/dViHEMusyHGNZLSeSafSk=;
 b=bJZl7B6g5Nsk+ziVfZGjuutLZ0fF+awrzD9DBKsPrCJGVmHMMIy5g//mh3aOQpjOdN/yXOMMwso+0eX1IYK9na9dmHQmCTrUC/mKQcbXQv21rEuJiW9XM+du+WENYsn7wSqd1Uk2v5uv15yo3uq/XVjybK0aacQRBX6NZjzhgbw=
Received: from AM6PR0502MB3638.eurprd05.prod.outlook.com (52.133.22.141) by
 AM6PR0502MB3814.eurprd05.prod.outlook.com (52.133.21.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 04:54:09 +0000
Received: from AM6PR0502MB3638.eurprd05.prod.outlook.com
 ([fe80::811c:d98c:ff3c:d83b]) by AM6PR0502MB3638.eurprd05.prod.outlook.com
 ([fe80::811c:d98c:ff3c:d83b%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 04:54:09 +0000
From:   Artemy Kovalyov <artemyko@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: RE: [PATCH rdma-rc 1/3] IB/mlx5: Unify ODP MR code paths to allow
 extra flexibility
Thread-Topic: [PATCH rdma-rc 1/3] IB/mlx5: Unify ODP MR code paths to allow
 extra flexibility
Thread-Index: AQHVtnLMo01CvSk6c0GCERn6MPztN6fB0jOAgACjeWA=
Date:   Fri, 20 Dec 2019 04:54:09 +0000
Message-ID: <AM6PR0502MB36387A4270850750E8F4A407B72D0@AM6PR0502MB3638.eurprd05.prod.outlook.com>
References: <20191219134646.413164-1-leon@kernel.org>
 <20191219134646.413164-2-leon@kernel.org> <20191219190725.GL17227@ziepe.ca>
In-Reply-To: <20191219190725.GL17227@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=artemyko@mellanox.com; 
x-originating-ip: [213.57.222.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2b0890d-1241-4755-a77a-08d78508a69c
x-ms-traffictypediagnostic: AM6PR0502MB3814:|AM6PR0502MB3814:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0502MB38149EA734B8DDF0C29D07F4B72D0@AM6PR0502MB3814.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(13464003)(5660300002)(4326008)(478600001)(8936002)(76116006)(66946007)(33656002)(66476007)(66556008)(64756008)(66446008)(8676002)(81166006)(4744005)(81156014)(186003)(6506007)(53546011)(7696005)(86362001)(26005)(71200400001)(2906002)(52536014)(107886003)(9686003)(316002)(54906003)(110136005)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB3814;H:AM6PR0502MB3638.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0V/uV4XB/OgZFoUB2lfh9KbUo461m4zHnhCSakXvI7yihGt7BC/fbhVk65VTD1goJWdJYKjmzTE8MXAQpjhC+8LidKan7cLUVtlEuf8zZvhy1ITBkbKxizjuVzfNMrcxcNb/3awoZ5efayQ95ODJgU9F/nRwbXY8RjWZQJFpA0QUAmFLD7MTKFk8RbF3/H3Oo8HHBB87sHVKkyGQx2vB2u7dzyTZARSzkLKPkaF9ovgB2E7r6l0p/oXlqP/EZp8D1AY5lRJL5oyBuCyDZqAxoGddYeuSxCrmI+XTcW9XR3o0UiEBcb+YD2wBFcScOu9fynujm3qL7I9Yub3xeoQVJUhWbSgB4HGFUW8Iih8HNcvnvWMOOzTt/D3pO4lbszNDwUcg0c1YcJF6ZOQQirypx/9eyq/nuJVfofy9cVaY6gyMjw4bhz1VtipwhcejRKdrgDBgM8IumLqYQjRiEJM4fpJPj1W1oVEIkYPynbK5cUiMgDdvKfAsKyrzDB6UnB0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b0890d-1241-4755-a77a-08d78508a69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 04:54:09.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whkJuSVPsF1zKwmvpMG9cldkPGp4wjKHBtz2xOO5J6mhIPn7Q/aE6/p/actka7INLYISCzOJY1kqGlgGyzUxDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3814
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Jason Gunthorpe <jgg@ziepe.ca>=20
Sent: Thursday, December 19, 2019 9:07 PM
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>; Leon Romanovsky <leonro@mellanox.co=
m>; RDMA mailing list <linux-rdma@vger.kernel.org>; Artemy Kovalyov <artemy=
ko@mellanox.com>; Aviad Yehezkel <aviadye@mellanox.com>; Yishai Hadas <yish=
aih@mellanox.com>
Subject: Re: [PATCH rdma-rc 1/3] IB/mlx5: Unify ODP MR code paths to allow =
extra flexibility

On Thu, Dec 19, 2019 at 03:46:44PM +0200, Leon Romanovsky wrote:
> From: Artemy Kovalyov <artemyko@mellanox.com>
>=20
> Building MR translation table in ODP case requires additional=20
> flexibility, namely random access to DMA addresses. Make both direct=20
> and indirect ODP MR use same code path, separated from non-ODP MR code pa=
th.
>=20
> Fixes: d2183c6f1958 ("RDMA/umem: Move page_shift from ib_umem to
> ib_odp_umem")

What does it fix?

AK: fix huge page ODP MR handling, was broken in __mlx5_ib_populate_pas shi=
ft calculation

Jason
