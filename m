Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020587C465
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfGaOIv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 10:08:51 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:35553
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387673AbfGaOIu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 10:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrVN8O0nfx4ueeMI5Il0cD1+CrLUfzBjXPpwHggF9vYF8uBjf0uEn51Tvui2TNJK43GvFe+U0poBdZNhhz9nqiOWmIllTvE/ighIOFPCqxs+p5VLDlePXNDsmDiIY+hIuI9EdcSNw9i16iEbZ8UtpGRxvC29GaM0zemQ56El6PC9hy3xf+8FZVK2NQiOBb1PC6/YbYxUxGNkMa2/76Kzw+FEn2WUsNfF0hxU2IvnZPYjmJn+jb0QLu9TLIjdlnQueOKZaZaf94lLm4f4re1GyBkkyzYcSTI9VCxcSztmK37TbG6h8GwIhnbpA58fA6DNArqCGwfvBo2bRMN57U5cgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhvCGBaCM7Sv0KbyugAwl3LtJXSKHfibtIjpf3D3Ow0=;
 b=KfAWG2hiVSjTeLUSomiMmm3FqEQ7PBizlVVTpYWNpX6L3kfVz3+2GhxkIilRuak2h7OV3E1GrRw/nRhP0pqFkipfX+W8/tA2WnxZRS5lsr1BsOfBuBXACrgf5r22i65iClYywHt/R14t0tofk8drO2wOK59kLnYSdvCPf0axpbYqaJzHyBgbbq03xCNWFOZ/OBrB+J7eO8PWoS1kwiNyFsIkVS0lhu6MpNS35VvSKl9+BxFtKIl6N5VPlPo4SDeL84tzKTrLlzWq8HrKtTaVCjkwZrgMmJqZHU6P/j+PPb3XlmCF2J69qiOnDI+1QZTn+3J2rc9kJXmhX5SeyTIKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhvCGBaCM7Sv0KbyugAwl3LtJXSKHfibtIjpf3D3Ow0=;
 b=Zy2KcKEQD21v5dJRUk3EO6pIVCJ3yQaOTc06ygTH4pVZZZpsTzj2UtZGrsT/oHndy4xTl+6qYubvLtxDcwmflCd+GV6giOGraAnQiBW4Wg99C2C77MKS2P8h+IsQ1jwsGCaD8fooruWfPOe5JOBvbzZ4VFdtu335DVDz3TYzSVI=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3234.eurprd05.prod.outlook.com (10.170.126.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 14:08:47 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::a1bc:70:4ca9:49f6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::a1bc:70:4ca9:49f6%7]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 14:08:47 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Remove DEBUG ODP code
Thread-Topic: [PATCH rdma-next] RDMA/mlx5: Remove DEBUG ODP code
Thread-Index: AQHVR5cBIcRb5ZKgPkWhALHv2IbHa6bkw8CA
Date:   Wed, 31 Jul 2019 14:08:47 +0000
Message-ID: <20190731140845.GA4832@mtr-leonro.mtl.com>
References: <20190731115627.5433-1-leon@kernel.org>
In-Reply-To: <20190731115627.5433-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2PR09CA0019.eurprd09.prod.outlook.com
 (2603:10a6:101:16::31) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.115.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69bfcba2-7df2-49df-7131-08d715c09aff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3234;
x-ms-traffictypediagnostic: AM4PR05MB3234:
x-microsoft-antispam-prvs: <AM4PR05MB3234125C5F0F5EAF828A1B2AB0DF0@AM4PR05MB3234.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(66066001)(11346002)(316002)(33656002)(229853002)(446003)(6636002)(53936002)(6246003)(71190400001)(71200400001)(86362001)(5660300002)(14444005)(256004)(14454004)(8936002)(3846002)(81166006)(6116002)(81156014)(52116002)(7736002)(6486002)(25786009)(76176011)(99286004)(66556008)(64756008)(66476007)(26005)(2906002)(186003)(6436002)(66446008)(478600001)(102836004)(66946007)(486006)(305945005)(68736007)(4326008)(6506007)(386003)(8676002)(1076003)(476003)(6512007)(9686003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3234;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fAxkza+6D3NiAZ+tW1uWVBm3ggB0iVNzvg9q2z0gvueufdXBQjY08DhusMLmJGj8OsrbG4GSACiY2JrXxjS22nES1biGJCMniaRlPK8FYLqkfIx57c5YhHIf6u/zeWOd/I7R8vwji0bhM3Liu4DH64WHuTznB9K1Be6fBAC7gyeOflPYz+oHzrMhP5WeD7DUq4DmTvNu3LTwoKcQ2v7qryoEEYsEhXcK5ZsIle/UCBLPP9lZZElCqkkgq9LB9GA8+KPoHR4JBL62rG3ScBM492OV9hn+t535OMier7J7y9BLmG/WwKQn9kWt2b4m3InD7Db2XmZUTaw3DqOrzxpIR1LvD0901hyc4Qhl+sPZLuH65nvD4q+h3OpoklcvDvPx7yGM3hUQ7Wz+t3FraMpQUW4TIVQn9N2IUBPQvVm9Ozo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08E524FCB60B924DAE06D5154DD136C2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bfcba2-7df2-49df-7131-08d715c09aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 14:08:47.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3234
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 02:56:27PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Delete DEBU ODP dead code which is leftover from development

DEBU -> DEBUG

> stage and doesn't need to be part of the upstream kernel.
>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx=
5/odp.c
> index 74310d885a90..6f1de5edbe8e 100644
> --- a/drivers/infiniband/hw/mlx5/odp.c
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -1033,9 +1033,6 @@ static int mlx5_ib_mr_initiator_pfault_handler(
>  	u32 transport_caps;
>  	struct mlx5_base_av *av;
>  	unsigned ds, opcode;
> -#if defined(DEBUG)
> -	u32 ctrl_wqe_index, ctrl_qpn;
> -#endif
>  	u32 qpn =3D qp->trans_qp.base.mqp.qpn;
>
>  	ds =3D be32_to_cpu(ctrl->qpn_ds) & MLX5_WQE_CTRL_DS_MASK;
> @@ -1051,27 +1048,6 @@ static int mlx5_ib_mr_initiator_pfault_handler(
>  		return -EFAULT;
>  	}
>
> -#if defined(DEBUG)
> -	ctrl_wqe_index =3D (be32_to_cpu(ctrl->opmod_idx_opcode) &
> -			MLX5_WQE_CTRL_WQE_INDEX_MASK) >>
> -			MLX5_WQE_CTRL_WQE_INDEX_SHIFT;
> -	if (wqe_index !=3D ctrl_wqe_index) {
> -		mlx5_ib_err(dev, "Got WQE with invalid wqe_index. wqe_index=3D0x%x, qp=
n=3D0x%x ctrl->wqe_index=3D0x%x\n",
> -			    wqe_index, qpn,
> -			    ctrl_wqe_index);
> -		return -EFAULT;
> -	}
> -
> -	ctrl_qpn =3D (be32_to_cpu(ctrl->qpn_ds) & MLX5_WQE_CTRL_QPN_MASK) >>
> -		MLX5_WQE_CTRL_QPN_SHIFT;
> -	if (qpn !=3D ctrl_qpn) {
> -		mlx5_ib_err(dev, "Got WQE with incorrect QP number. wqe_index=3D0x%x, =
qpn=3D0x%x ctrl->qpn=3D0x%x\n",
> -			    wqe_index, qpn,
> -			    ctrl_qpn);
> -		return -EFAULT;
> -	}
> -#endif /* DEBUG */
> -
>  	*wqe_end =3D *wqe + ds * MLX5_WQE_DS_UNITS;
>  	*wqe +=3D sizeof(*ctrl);
>
> --
> 2.20.1
>
