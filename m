Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0226320EAB
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfEPS3u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 14:29:50 -0400
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:47059
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbfEPS3t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 14:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHubt/S9JKEsQVNsPm3V79OlM2UzXv9v0I36mC0ebCE=;
 b=gAxk84oVIFjFyGjfC/Y+jRMahCi85VewnAXpCzQ7hQ83PeGcIx5PAXOZvFtqH2MgP4Ru5beiiuwFmNPecvJuFffCs3ZfNRNNszS/e18ONseNkxuYk54gXFu22ztdhfuKyv+sbsefLftQRs7iyw2lvOcV8GlkqI6tOQF5qcMO+8Q=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4160.eurprd05.prod.outlook.com (10.171.183.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 18:29:45 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 18:29:45 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Bryan Tan <bryantan@vmware.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH rdma-core] vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Topic: [PATCH rdma-core] vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Index: AQHVDBT3BQBSIqM9/0CtsQbRxE3AJaZuEnsA
Date:   Thu, 16 May 2019 18:29:45 +0000
Message-ID: <20190516182940.GI22573@mellanox.com>
References: <1558031213-14219-1-git-send-email-aditr@vmware.com>
In-Reply-To: <1558031213-14219-1-git-send-email-aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::39) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eec42925-1256-47f3-e703-08d6da2c7884
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4160;
x-ms-traffictypediagnostic: VI1PR05MB4160:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB4160251B67946962F740E2BBCF0A0@VI1PR05MB4160.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(68736007)(6246003)(256004)(229853002)(66066001)(6506007)(26005)(11346002)(66476007)(64756008)(54906003)(386003)(14454004)(66556008)(66446008)(2616005)(66946007)(476003)(102836004)(81166006)(36756003)(73956011)(81156014)(6436002)(53936002)(966005)(8936002)(7736002)(305945005)(71200400001)(76176011)(8676002)(6916009)(86362001)(186003)(3846002)(6116002)(25786009)(5660300002)(6512007)(99286004)(316002)(1076003)(486006)(6486002)(33656002)(2906002)(478600001)(4326008)(446003)(52116002)(6306002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4160;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uwtKN+U63yt5lurHY0g2ESc2hcyvXWsHaUtqFmg8NbG1Q8KDCL8Bv7MeBJoEgJ9XuR2kRA3ZdTMY0/ACFQNyhUmidQBz6iMM8E2CXwayn3b6Rxpj3b4qQjSlcZ6imv+IcxDN4YZBSAERjCAT1XFeZJjMScKffenzTJeIiXsPwlE5GWR6lVzBVZ2j4Rj8hAb9fEVy2eLIVqMPtReVh+n6CRqHJv1+ITG5QGL4ce2I2ACevzMLpe7tsAI0DWfLp5xyoh/FaJ2opb1xblYHw8I8/kouVtoIG6LRg5KUs3GZ63kQYNzRVqnDTydjTI/DA8bs4XZbbj7A/OO6xU40IdVQfTPAyGdlTgnZDEnbjHdFQeuj34RMm+qvtHsVLcacy+kjI9bsoqKXZ1LdusWNX3jL6hSLSzAenLVZ1BISrrnAosI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A3CEFC46046ED4A9EB1A18FA087D17D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec42925-1256-47f3-e703-08d6da2c7884
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 18:29:45.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4160
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 06:27:06PM +0000, Adit Ranadive wrote:
> From: Bryan Tan <bryantan@vmware.com>
>=20
> This change allows user-space to use physical resource numbers if
> they are passed up from the driver. Doing so allows communication with
> physical non-ESX endpoints (such as a bare-metal Linux machine or a
> SR-IOV-enabled VM).
>=20
> This is accomplished by separating the concept of the QP number from
> the QP handle. Previously, the two were the same, as the QP number
> was exposed to the guest and also used to reference  a virtual QP in
> the device backend. With physical resource numbers exposed, the QP
> number given to the guest is the QP number assigned to the physical
> HCA's QP, while the QP handle is still the internal handle used to
> reference a virtual QP. Regardless of whether the device is exposing
> physical ids, the driver will still try to pick up the QP handle from
> the backend if possible.
>=20
> The MR keys exposed to the guest when the physical resource ids feature
> is turned on are likewise now the MR keys created by the physical HCA,
> instead of virtual MR keys.
>=20
> The ABI has been updated to allow the return of the QP handle to the
> guest library. The ABI version has been bumped up because of this
> non-compatible change.
>=20
> Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
> Signed-off-by: Adit Ranadive <aditr@vmware.com>
> Signed-off-by: Bryan Tan <bryantan@vmware.com>
>  kernel-headers/rdma/vmw_pvrdma-abi.h | 11 ++++++++++-
>  providers/vmw_pvrdma/pvrdma-abi.h    |  4 +++-
>  providers/vmw_pvrdma/pvrdma.h        |  1 +
>  providers/vmw_pvrdma/pvrdma_main.c   |  4 ++--
>  providers/vmw_pvrdma/qp.c            | 31 ++++++++++++++++++++----------=
-
>  5 files changed, 36 insertions(+), 15 deletions(-)
>=20
> Github PR:
> https://github.com/linux-rdma/rdma-core/pull/531
>=20
> diff --git a/kernel-headers/rdma/vmw_pvrdma-abi.h b/kernel-headers/rdma/v=
mw_pvrdma-abi.h
> index 6e73f0274e41..8c388d623e5c 100644
> +++ b/kernel-headers/rdma/vmw_pvrdma-abi.h
> @@ -49,7 +49,11 @@
> =20
>  #include <linux/types.h>
> =20
> -#define PVRDMA_UVERBS_ABI_VERSION	3		/* ABI Version. */
> +#define PVRDMA_UVERBS_MIN_ABI_VERSION		3
> +#define PVRDMA_UVERBS_MAX_ABI_VERSION		4
> +
> +#define PVRDMA_UVERBS_NO_QP_HANDLE_ABI_VERSION	3
> +
>  #define PVRDMA_UAR_HANDLE_MASK		0x00FFFFFF	/* Bottom 24 bits. */
>  #define PVRDMA_UAR_QP_OFFSET		0		/* QP doorbell. */
>  #define PVRDMA_UAR_QP_SEND		(1 << 30)	/* Send bit. */
> @@ -179,6 +183,11 @@ struct pvrdma_create_qp {
>  	__aligned_u64 qp_addr;
>  };
> =20
> +struct pvrdma_create_qp_resp {
> +	__u32 qpn;
> +	__u32 qp_handle;
> +};
> +
>  /* PVRDMA masked atomic compare and swap */
>  struct pvrdma_ex_cmp_swap {
>  	__aligned_u64 swap_val;
> diff --git a/providers/vmw_pvrdma/pvrdma-abi.h b/providers/vmw_pvrdma/pvr=
dma-abi.h
> index 77db9ddd1bb7..9775925f8555 100644
> +++ b/providers/vmw_pvrdma/pvrdma-abi.h
> @@ -54,8 +54,10 @@ DECLARE_DRV_CMD(user_pvrdma_alloc_pd, IB_USER_VERBS_CM=
D_ALLOC_PD,
>  		empty, pvrdma_alloc_pd_resp);
>  DECLARE_DRV_CMD(user_pvrdma_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
>  		pvrdma_create_cq, pvrdma_create_cq_resp);
> -DECLARE_DRV_CMD(user_pvrdma_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
> +DECLARE_DRV_CMD(user_pvrdma_create_qp_v3, IB_USER_VERBS_CMD_CREATE_QP,
>  		pvrdma_create_qp, empty);
> +DECLARE_DRV_CMD(user_pvrdma_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
> +		pvrdma_create_qp, pvrdma_create_qp_resp);
>  DECLARE_DRV_CMD(user_pvrdma_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
>  		pvrdma_create_srq, pvrdma_create_srq_resp);
>  DECLARE_DRV_CMD(user_pvrdma_alloc_ucontext, IB_USER_VERBS_CMD_GET_CONTEX=
T,
> diff --git a/providers/vmw_pvrdma/pvrdma.h b/providers/vmw_pvrdma/pvrdma.=
h
> index ebd50ce1c3cd..b67c07e94f90 100644
> +++ b/providers/vmw_pvrdma/pvrdma.h
> @@ -170,6 +170,7 @@ struct pvrdma_qp {
>  	struct pvrdma_wq		sq;
>  	struct pvrdma_wq		rq;
>  	int				is_srq;
> +	uint32_t			qp_handle;
>  };
> =20
>  struct pvrdma_ah {
> diff --git a/providers/vmw_pvrdma/pvrdma_main.c b/providers/vmw_pvrdma/pv=
rdma_main.c
> index 52a2de22d44c..616310ae45c5 100644
> +++ b/providers/vmw_pvrdma/pvrdma_main.c
> @@ -201,8 +201,8 @@ static const struct verbs_match_ent hca_table[] =3D {
> =20
>  static const struct verbs_device_ops pvrdma_dev_ops =3D {
>  	.name =3D "pvrdma",
> -	.match_min_abi_version =3D PVRDMA_UVERBS_ABI_VERSION,
> -	.match_max_abi_version =3D PVRDMA_UVERBS_ABI_VERSION,
> +	.match_min_abi_version =3D PVRDMA_UVERBS_MIN_ABI_VERSION,
> +	.match_max_abi_version =3D PVRDMA_UVERBS_MAX_ABI_VERSION,
>  	.match_table =3D hca_table,
>  	.alloc_device =3D pvrdma_device_alloc,
>  	.uninit_device =3D pvrdma_uninit_device,
> diff --git a/providers/vmw_pvrdma/qp.c b/providers/vmw_pvrdma/qp.c
> index ef429db93a43..a173d441df0d 100644
> +++ b/providers/vmw_pvrdma/qp.c
> @@ -211,9 +211,9 @@ struct ibv_qp *pvrdma_create_qp(struct ibv_pd *pd,
>  {
>  	struct pvrdma_device *dev =3D to_vdev(pd->context->device);
>  	struct user_pvrdma_create_qp cmd;
> -	struct ib_uverbs_create_qp_resp resp;
> +	struct user_pvrdma_create_qp_resp resp;
> +	struct user_pvrdma_create_qp_v3_resp resp_v3;
>  	struct pvrdma_qp *qp;
> -	int ret;
>  	int is_srq =3D !!(attr->srq);
> =20
>  	attr->cap.max_send_sge =3D max_t(uint32_t, 1U, attr->cap.max_send_sge);
> @@ -282,14 +282,23 @@ struct ibv_qp *pvrdma_create_qp(struct ibv_pd *pd,
>  	cmd.rbuf_size =3D qp->rbuf.length;
>  	cmd.qp_addr =3D (uintptr_t) qp;
> =20
> -	ret =3D ibv_cmd_create_qp(pd, &qp->ibv_qp, attr,
> -				&cmd.ibv_cmd, sizeof(cmd),
> -				&resp, sizeof(resp));
> +	if (dev->abi_version <=3D PVRDMA_UVERBS_NO_QP_HANDLE_ABI_VERSION) {
> +		if (ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd.ibv_cmd,
> +				      sizeof(cmd), &resp_v3.ibv_resp,
> +				      sizeof(resp_v3.ibv_resp)))

And here just pass in the version with the longer size and provide
some in-band way to tell if the kernel wrote to it.

Jason
