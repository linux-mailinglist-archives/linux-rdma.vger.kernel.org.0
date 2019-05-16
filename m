Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7820EA6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEPS3K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 14:29:10 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:19231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbfEPS3K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 14:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axw3mLAiHvt7qXVX8LWAQsp0v1FVxKftR0cpIiN7rac=;
 b=UeedgriDbRf6jTI3pTl5x4bSKrv0uddcETfHt4A3KrOd/WIao+FeSSmoRGsMVLG7GO8leoRczLbQzUWYYp/J8kNURkkbam4H3fM+G1veA/HJViRq6qjEQyJA+9GaQVq+E8TwaGd/bX8uqxqHwEGm0okY6KJo6NiYQmom9miIcVI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4160.eurprd05.prod.outlook.com (10.171.183.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 18:29:06 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 18:29:06 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Bryan Tan <bryantan@vmware.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH for-next] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Topic: [PATCH for-next] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Thread-Index: AQHVDBSlkap1QWBkwEm57ccCex0bMqZuEk2A
Date:   Thu, 16 May 2019 18:29:06 +0000
Message-ID: <20190516182901.GH22573@mellanox.com>
References: <1558031071-14110-1-git-send-email-aditr@vmware.com>
In-Reply-To: <1558031071-14110-1-git-send-email-aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8c06842-3dfa-4113-c636-08d6da2c60f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4160;
x-ms-traffictypediagnostic: VI1PR05MB4160:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB4160B7D81A2397BEE923FF71CF0A0@VI1PR05MB4160.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(68736007)(14444005)(6246003)(256004)(229853002)(66066001)(6506007)(26005)(11346002)(66476007)(64756008)(54906003)(386003)(14454004)(66556008)(66446008)(2616005)(66946007)(476003)(102836004)(81166006)(36756003)(73956011)(81156014)(6436002)(53936002)(966005)(8936002)(7736002)(305945005)(71200400001)(76176011)(8676002)(6916009)(86362001)(186003)(3846002)(6116002)(25786009)(5660300002)(6512007)(99286004)(316002)(1076003)(486006)(6486002)(33656002)(2906002)(478600001)(4326008)(446003)(52116002)(6306002)(71190400001)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4160;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zFBA26Ug3vk4XzOet9unEUtD4H7tM3XeBIxeXgdVqs/tE7oXQLXiRhVw29BzbYJkGzQtH4FnSrSZI/6ryePwZUc2e6CONvW0/Q2h4nVIbJgRglHOyJJWO1GNBeYtgG9uxHJQUgh5kM6w3xDy/jZPfKpO5llmTIwcEgIMx1ZjLq6V6XNnD5cgqPmFc4GvILKMjsGMqpUY+6X0ava8V+m4TR+GHxy2gM1b1E0Zd0eVEb6j1mIAjtc/dKbSH7uVVT5DcRQm+QNYJMqi/NPLfEBWLnAf0wzu95ZlMOSMtLElDDGVlyxAU3bxs7sH62VgbvTmye4B9AlRD3wYwhYcXZDa9WS4YbHJng+pTO03nhN1nttWdQV1q3VkllU/3Y/tDtzrfTCkYone7ubr+1zuoloQe3WhtkporiIKqU1plZWf+0g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0AC85C1AF22A84E959CD0AFFC7243AC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c06842-3dfa-4113-c636-08d6da2c60f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 18:29:06.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4160
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 06:24:48PM +0000, Adit Ranadive wrote:
> From: Bryan Tan <bryantan@vmware.com>
>=20
> This change allows the RDMA stack to use physical resource numbers if
> they are passed up from the device. Doing so allows communication with
> physical non-ESX endpoints (such as a bare-metal Linux machine or a
> SR-IOV-enabled VM).
>=20
> This is accomplished by separating the concept of the QP number from
> the QP handle. Previously, the two were the same, as the QP number was
> exposed to the guest and also used to reference a virtual QP in the
> device backend. With physical resource numbers exposed, the QP number
> given to the guest is the QP number assigned to the physical HCA's QP,
> while the QP handle is still the internal handle used to reference a
> virtual QP. Regardless of whether the device is exposing physical ids,
> the driver will still try to pick up the QP handle from the backend if
> possible. The MR keys exposed to the guest will also be the MR keys
> created by the physical HCA, instead of virtual MR keys.
>=20
> A new version of the create QP response has been added to the device
> API. The device backend will pass the QP handle up to the driver, if
> both the device and driver are at the appriopriate version, and the ABI
> has also been updated to allow the return of the QP handle to the guest
> library. The PVRDMA version and ABI version have been bumped up because
> of these non-compatible changes.
>=20
> Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
> Signed-off-by: Adit Ranadive <aditr@vmware.com>
> Signed-off-by: Bryan Tan <bryantan@vmware.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h | 15 +++++++++++++-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  8 +++++++-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c      | 24 +++++++++++++++++=
++++--
>  include/uapi/rdma/vmw_pvrdma-abi.h                |  9 ++++++++-
>  4 files changed, 51 insertions(+), 5 deletions(-)
> ---
>=20
> The PR for userspace was sent:
> https://github.com/linux-rdma/rdma-core/pull/531
>=20
> ---
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/drivers/=
infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> index 8f9749d54688..86a6c054ea26 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
> @@ -58,7 +58,8 @@
>  #define PVRDMA_ROCEV1_VERSION		17
>  #define PVRDMA_ROCEV2_VERSION		18
>  #define PVRDMA_PPN64_VERSION		19
> -#define PVRDMA_VERSION			PVRDMA_PPN64_VERSION
> +#define PVRDMA_QPHANDLE_VERSION		20
> +#define PVRDMA_VERSION			PVRDMA_QPHANDLE_VERSION
> =20
>  #define PVRDMA_BOARD_ID			1
>  #define PVRDMA_REV_ID			1
> @@ -581,6 +582,17 @@ struct pvrdma_cmd_create_qp_resp {
>  	u32 max_inline_data;
>  };
> =20
> +struct pvrdma_cmd_create_qp_resp_v2 {
> +	struct pvrdma_cmd_resp_hdr hdr;
> +	u32 qpn;
> +	u32 qp_handle;
> +	u32 max_send_wr;
> +	u32 max_recv_wr;
> +	u32 max_send_sge;
> +	u32 max_recv_sge;
> +	u32 max_inline_data;
> +};
> +
>  struct pvrdma_cmd_modify_qp {
>  	struct pvrdma_cmd_hdr hdr;
>  	u32 qp_handle;
> @@ -663,6 +675,7 @@ struct pvrdma_cmd_destroy_bind {
>  	struct pvrdma_cmd_create_cq_resp create_cq_resp;
>  	struct pvrdma_cmd_resize_cq_resp resize_cq_resp;
>  	struct pvrdma_cmd_create_qp_resp create_qp_resp;
> +	struct pvrdma_cmd_create_qp_resp_v2 create_qp_resp_v2;
>  	struct pvrdma_cmd_query_qp_resp query_qp_resp;
>  	struct pvrdma_cmd_destroy_qp_resp destroy_qp_resp;
>  	struct pvrdma_cmd_create_srq_resp create_srq_resp;
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/inf=
iniband/hw/vmw_pvrdma/pvrdma_main.c
> index 40182297f87f..02e337837a2e 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> @@ -201,7 +201,13 @@ static int pvrdma_register_device(struct pvrdma_dev =
*dev)
>  	dev->ib_dev.owner =3D THIS_MODULE;
>  	dev->ib_dev.num_comp_vectors =3D 1;
>  	dev->ib_dev.dev.parent =3D &dev->pdev->dev;
> -	dev->ib_dev.uverbs_abi_ver =3D PVRDMA_UVERBS_ABI_VERSION;
> +
> +	if (dev->dsr_version >=3D PVRDMA_QPHANDLE_VERSION)
> +		dev->ib_dev.uverbs_abi_ver =3D PVRDMA_UVERBS_ABI_VERSION;
> +	else
> +		dev->ib_dev.uverbs_abi_ver =3D
> +				PVRDMA_UVERBS_NO_QP_HANDLE_ABI_VERSION;
> +
>  	dev->ib_dev.uverbs_cmd_mask =3D
>  		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
>  		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infin=
iband/hw/vmw_pvrdma/pvrdma_qp.c
> index 0eaaead5baec..8cba7623f379 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> @@ -195,7 +195,9 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  	union pvrdma_cmd_resp rsp;
>  	struct pvrdma_cmd_create_qp *cmd =3D &req.create_qp;
>  	struct pvrdma_cmd_create_qp_resp *resp =3D &rsp.create_qp_resp;
> +	struct pvrdma_cmd_create_qp_resp_v2 *resp_v2 =3D &rsp.create_qp_resp_v2=
;
>  	struct pvrdma_create_qp ucmd;
> +	struct pvrdma_create_qp_resp qp_resp =3D {};
>  	unsigned long flags;
>  	int ret;
>  	bool is_srq =3D !!init_attr->srq;
> @@ -379,13 +381,31 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  	}
> =20
>  	/* max_send_wr/_recv_wr/_send_sge/_recv_sge/_inline_data */
> -	qp->qp_handle =3D resp->qpn;
>  	qp->port =3D init_attr->port_num;
> -	qp->ibqp.qp_num =3D resp->qpn;
> +	if (dev->dsr_version >=3D PVRDMA_QPHANDLE_VERSION) {
> +		qp->ibqp.qp_num =3D resp_v2->qpn;
> +		qp->qp_handle =3D resp_v2->qp_handle;
> +	} else {
> +		qp->ibqp.qp_num =3D resp->qpn;
> +		qp->qp_handle =3D resp->qpn;
> +	}
> +
>  	spin_lock_irqsave(&dev->qp_tbl_lock, flags);
>  	dev->qp_tbl[qp->qp_handle % dev->dsr->caps.max_qp] =3D qp;
>  	spin_unlock_irqrestore(&dev->qp_tbl_lock, flags);
> =20
> +	if (!qp->is_kernel) {
> +		/* Copy udata back. */
> +		qp_resp.qpn =3D qp->ibqp.qp_num;
> +		qp_resp.qp_handle =3D qp->qp_handle;
> +		if (ib_copy_to_udata(udata, &qp_resp, sizeof(qp_resp))) {
> +			dev_warn(&dev->pdev->dev,
> +				 "failed to copy back udata\n");
> +			pvrdma_destroy_qp(&qp->ibqp, udata);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
>  	return &qp->ibqp;
> =20
>  err_pdir:
> diff --git a/include/uapi/rdma/vmw_pvrdma-abi.h b/include/uapi/rdma/vmw_p=
vrdma-abi.h
> index 6e73f0274e41..8ebab11dadcb 100644
> --- a/include/uapi/rdma/vmw_pvrdma-abi.h
> +++ b/include/uapi/rdma/vmw_pvrdma-abi.h
> @@ -49,7 +49,9 @@
> =20
>  #include <linux/types.h>
> =20
> -#define PVRDMA_UVERBS_ABI_VERSION	3		/* ABI Version. */
> +#define PVRDMA_UVERBS_NO_QP_HANDLE_ABI_VERSION	3
> +#define PVRDMA_UVERBS_ABI_VERSION		4	/* ABI Version. */

Don't mess with ABI version when all you are doing is making the
response or request struct longer.

Jason
