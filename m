Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177D0B3F93
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfIPRYF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 13:24:05 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:3552
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727987AbfIPRYE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 13:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ6/kj2qZoTaHY19zrxb5TmINj8XnrzXHg+YviWOquIu8M+cu0H/t0q6Ga0HC2hR4i5pUlmaJoj6YdzPG57655YQ22WEyX5GpBHIIvr7KCxdx/i7YVeYYOxi9kzJfmfHDV5gUGZ8HjRfUWoMB9Yc/ZgO5epv7rGxOqEE4TREWFeTOAUSNCMwl9qI0MZLohHicXx3leuz5Dpnxu/BZfleL7eKkC7dyD46JfR+b5gyTsTY+Z8Xn7dIo6KjJ7aotOsTXv+T9Yn7TeQ0n5HtwWcaYTdMDl8xMEvGN6ODoEkkaOJTL2tnbwoYl1uZCI2ytiixBAcG5BnNj/SmrvJyENYzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khzErD073lR/FTjtRZRcbfMLeppF1yjWoQWzSevV1MU=;
 b=NlXtE+43zcrxrFr3O3tgHPCDsaDWGTvM3w7FxMv2dap0QCcLG27gq6du01vBQH8di14kPqMt8kpjFE4sZqiMe6Tp4qBIEfdQv90zJPXHJFrkrSe5CNuaqKeuHNws123kd/d7hmuvTPEefua0TLHPdrf5KT3A6I2BJbCbyYE34KV+zwLf88cGAOrch9eLLedE75sXIceOwct62Jszcz8jwhiAfNxJ5vPLgkULii5Yrd1p/mCVCNeVcqdYEKsaDdm+7YgclJ5LP/Ot+O7Ty8rOmY45zFl9ykpqf5NLLy+vLVX++xO967Tr5Bps38qxFKz32Rh0RzELUc5hoaMVRErnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khzErD073lR/FTjtRZRcbfMLeppF1yjWoQWzSevV1MU=;
 b=Ls0Q1+dknBzAMsM422GBkkLjBXl0+J4mLCiF6ltXpQxqnIj0Tk+bTQX1u3SJotHvfv2XZeIoc+sJtf5L/H4jLbrm/5qkMAjjpmKqcgcLPf9ljA2KxpLXTQ0a1QO4+zUubm8JgWer5FS28+u5eTS+jHoTNuKnu5VmbMlGGTxRn3I=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4670.eurprd05.prod.outlook.com (20.176.3.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 17:23:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 17:23:59 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH 2/2] IB/mlx5: Free mpi in mp_slave mode
Thread-Topic: [PATCH 2/2] IB/mlx5: Free mpi in mp_slave mode
Thread-Index: AQHVbFrC1fO1CpNws0Wyj0deQHR6fqcujlCA
Date:   Mon, 16 Sep 2019 17:23:59 +0000
Message-ID: <20190916172353.GD2585@mellanox.com>
References: <20190916064818.19823-1-leon@kernel.org>
 <20190916064818.19823-3-leon@kernel.org>
In-Reply-To: <20190916064818.19823-3-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04919a0c-69b4-4a2b-57f2-08d73acaa8ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4670;
x-ms-traffictypediagnostic: VI1PR05MB4670:|VI1PR05MB4670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB46701FDC84CE2B21D9FBE61CCF8C0@VI1PR05MB4670.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(66446008)(64756008)(66556008)(229853002)(26005)(76176011)(386003)(6916009)(446003)(3846002)(71200400001)(6506007)(476003)(486006)(99286004)(71190400001)(33656002)(7736002)(305945005)(186003)(6116002)(53936002)(107886003)(6246003)(2616005)(1076003)(11346002)(4326008)(316002)(5660300002)(54906003)(8676002)(81156014)(81166006)(66476007)(8936002)(6512007)(66066001)(36756003)(102836004)(256004)(14454004)(86362001)(52116002)(66946007)(6486002)(478600001)(2906002)(6436002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4670;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1yUSouerJtamlvARYCmb+xtrdlr/w8LtgqhOKyyT3r0JCbGTnMhkUQwKLqAXCO0trQj6VceYRCMkWl/qfE17EokZTXygyBWplSFbE1YWX2WbHfKlgAJPAk90I8eV75VYtsIDuUyqTvnekiXJgpnxyRaxSzIZfLNC3t7iG+bx+Mnw208LDPFsVXhH2dRqQhQPVSzZwmHyyThcW3nodrpIl77tu+Zq/R3in/kRDJ9KpwuI4FtJGBKQOV6sDmDvLcC3bushfD9yJaOaB8oV20QAfMDwgkcU/7DUMrVe3qcgTb2gYvisM4s0OnS08AiU7RnUeeO62CacXvtJNbtm+1G7mHma5lj6MaoPIfb+ioDAkycrOlfr7d9oJUEJvFd7aZsgsJQZWAdiTv9lm+rLBz/p5/oO5ia4O4Oh5b43YkDCmUk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01A991971721F64F96A13574181DB306@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04919a0c-69b4-4a2b-57f2-08d73acaa8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 17:23:59.2042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpIXDvZKUKlhoT9+Y8vr+3V22JLpMyCEkftQSU53TGVF+ccsO6ZYXe3/WpZtitd0o8IcoriHCD70pl8sFr91uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4670
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 09:48:18AM +0300, Leon Romanovsky wrote:
> From: Danit Goldberg <danitg@mellanox.com>
>=20
> ib_add_slave_port() allocates a multiport struct but never frees it.
> Don't leak memory, free the allocated mpi struct during driver unload.
>=20
> Fixes: 32f69e4be269 ("{net, IB}/mlx5: Manage port association for multipo=
rt RoCE")
> Signed-off-by: Danit Goldberg <danitg@mellanox.com>
>  drivers/infiniband/hw/mlx5/main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
> index 0569bcab02d4..14807ea8dc3f 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -6959,6 +6959,7 @@ static void mlx5_ib_remove(struct mlx5_core_dev *md=
ev, void *context)
>  			mlx5_ib_unbind_slave_port(mpi->ibdev, mpi);
>  		list_del(&mpi->list);
>  		mutex_unlock(&mlx5_ib_multiport_mutex);
> +		kfree(mpi);
>  		return;
>  	}

Personally I think the way this code was written to try to share the
struct mlx5_interface between two completely different usages, with
totally different opaque structs is really obtuse.=20

Two interfaces callback blocks for the two parallel uses would have
been cleaner and might have made this missing kfree clearer.

Jason
