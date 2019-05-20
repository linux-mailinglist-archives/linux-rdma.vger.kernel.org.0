Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9712366D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbfETMpx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 08:45:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51710 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389317AbfETM0c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 08:26:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KCE7Zr183728;
        Mon, 20 May 2019 12:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ESjA8gh9oY5A2XwGR78Aix8GZ9a6YG09Ikov6B5jflo=;
 b=2mxU1zTiSCdvKDGzEzTbdgb7UavPz3gju2LT8ClmXP85YjBnO66tnVVPORcjqUgs+BD8
 aaCDatsyBX3xqomiabxEBY/IySJYClSgqr/RJTU9sJpp2LvsCXH9Lrusvvkmo9i7LFip
 K0HDLnVNi8b3zmzrBtkgkbjjy7Bv2ctXSH5KUMU+p3nTzDHb8fuGzxTDGQxDYX+8bc7Q
 qrUEd6tvmOOXj/4pWQEPUsMFZgZ2v6l3dT1Ahyx/uh95EI1ORj65FH9x7iJ3F1YGa/kb
 sfvjkzpwpOm/he0X/INxWSygo4Brt3puvZweeV9PWEXxcqVjoeMECwjJAbKm96JdER6A hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2sj7jderje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 12:26:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KCPeGE053758;
        Mon, 20 May 2019 12:25:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2sks1htmtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 12:25:59 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4KCPwPh013353;
        Mon, 20 May 2019 12:25:58 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 12:25:57 +0000
Date:   Mon, 20 May 2019 15:25:53 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Bryan Tan <bryantan@vmware.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH for-next] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Message-ID: <20190520122553.GA13761@lap1>
References: <1558031071-14110-1-git-send-email-aditr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558031071-14110-1-git-send-email-aditr@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200085
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200085
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 06:24:48PM +0000, Adit Ranadive wrote:
> From: Bryan Tan <bryantan@vmware.com>
> 
> This change allows the RDMA stack to use physical resource numbers if
> they are passed up from the device. Doing so allows communication with
> physical non-ESX endpoints (such as a bare-metal Linux machine or a
> SR-IOV-enabled VM).

With the price of not supporting migration, right :)

> 
> This is accomplished by separating the concept of the QP number from
> the QP handle. Previously, the two were the same, as the QP number was
> exposed to the guest and also used to reference a virtual QP in the
> device backend. With physical resource numbers exposed, the QP number
> given to the guest is the QP number assigned to the physical HCA's QP,

s/assigned to the/assigned by the

> while the QP handle is still the internal handle used to reference a
> virtual QP. Regardless of whether the device is exposing physical ids,
> the driver will still try to pick up the QP handle from the backend if
> possible. The MR keys exposed to the guest will also be the MR keys
> created by the physical HCA, instead of virtual MR keys.

I don't see any thing related to MR in the patch so wondering if you are
talking about some future patch in your pipe.
In any case - suggesting to remove this comment.

> 
> A new version of the create QP response has been added to the device
> API. The device backend will pass the QP handle up to the driver, if
> both the device and driver are at the appriopriate version, and the ABI
> has also been updated to allow the return of the QP handle to the guest
> library. The PVRDMA version and ABI version have been bumped up because
> of these non-compatible changes.

I have to admit i'm not fully understand why this patch is needed, maybe i
have to read the relevant library patch to have a complete picture but what
i'm missing here is why it is needed, after all the QEMU device (which is
also derived by this driver) pass the physical QPN to guest from day one
and has no issues communicating with any peer, virtual or bare-metal.

As i see it, from a design perspectives, the driver, as well as the
library, should be agnostic to how the device allocates its QPN.

I might be missing something here so will be happy if you can elaborate a
bit more on that.

Yuval

> 
> Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
> Signed-off-by: Adit Ranadive <aditr@vmware.com>
> Signed-off-by: Bryan Tan <bryantan@vmware.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h | 15 +++++++++++++-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  8 +++++++-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c      | 24 +++++++++++++++++++++--
>  include/uapi/rdma/vmw_pvrdma-abi.h                |  9 ++++++++-
>  4 files changed, 51 insertions(+), 5 deletions(-)
> ---
> 
> The PR for userspace was sent:
> https://github.com/linux-rdma/rdma-core/pull/531
> 
> ---
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
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
>  
>  #define PVRDMA_BOARD_ID			1
>  #define PVRDMA_REV_ID			1
> @@ -581,6 +582,17 @@ struct pvrdma_cmd_create_qp_resp {
>  	u32 max_inline_data;
>  };
>  
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
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> index 40182297f87f..02e337837a2e 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> @@ -201,7 +201,13 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
>  	dev->ib_dev.owner = THIS_MODULE;
>  	dev->ib_dev.num_comp_vectors = 1;
>  	dev->ib_dev.dev.parent = &dev->pdev->dev;
> -	dev->ib_dev.uverbs_abi_ver = PVRDMA_UVERBS_ABI_VERSION;
> +
> +	if (dev->dsr_version >= PVRDMA_QPHANDLE_VERSION)
> +		dev->ib_dev.uverbs_abi_ver = PVRDMA_UVERBS_ABI_VERSION;
> +	else
> +		dev->ib_dev.uverbs_abi_ver =
> +				PVRDMA_UVERBS_NO_QP_HANDLE_ABI_VERSION;
> +
>  	dev->ib_dev.uverbs_cmd_mask =
>  		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
>  		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> index 0eaaead5baec..8cba7623f379 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
> @@ -195,7 +195,9 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  	union pvrdma_cmd_resp rsp;
>  	struct pvrdma_cmd_create_qp *cmd = &req.create_qp;
>  	struct pvrdma_cmd_create_qp_resp *resp = &rsp.create_qp_resp;
> +	struct pvrdma_cmd_create_qp_resp_v2 *resp_v2 = &rsp.create_qp_resp_v2;
>  	struct pvrdma_create_qp ucmd;
> +	struct pvrdma_create_qp_resp qp_resp = {};
>  	unsigned long flags;
>  	int ret;
>  	bool is_srq = !!init_attr->srq;
> @@ -379,13 +381,31 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  	}
>  
>  	/* max_send_wr/_recv_wr/_send_sge/_recv_sge/_inline_data */
> -	qp->qp_handle = resp->qpn;
>  	qp->port = init_attr->port_num;
> -	qp->ibqp.qp_num = resp->qpn;
> +	if (dev->dsr_version >= PVRDMA_QPHANDLE_VERSION) {
> +		qp->ibqp.qp_num = resp_v2->qpn;
> +		qp->qp_handle = resp_v2->qp_handle;
> +	} else {
> +		qp->ibqp.qp_num = resp->qpn;
> +		qp->qp_handle = resp->qpn;
> +	}
> +
>  	spin_lock_irqsave(&dev->qp_tbl_lock, flags);
>  	dev->qp_tbl[qp->qp_handle % dev->dsr->caps.max_qp] = qp;
>  	spin_unlock_irqrestore(&dev->qp_tbl_lock, flags);
>  
> +	if (!qp->is_kernel) {
> +		/* Copy udata back. */
> +		qp_resp.qpn = qp->ibqp.qp_num;
> +		qp_resp.qp_handle = qp->qp_handle;
> +		if (ib_copy_to_udata(udata, &qp_resp, sizeof(qp_resp))) {
> +			dev_warn(&dev->pdev->dev,
> +				 "failed to copy back udata\n");
> +			pvrdma_destroy_qp(&qp->ibqp, udata);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
>  	return &qp->ibqp;
>  
>  err_pdir:
> diff --git a/include/uapi/rdma/vmw_pvrdma-abi.h b/include/uapi/rdma/vmw_pvrdma-abi.h
> index 6e73f0274e41..8ebab11dadcb 100644
> --- a/include/uapi/rdma/vmw_pvrdma-abi.h
> +++ b/include/uapi/rdma/vmw_pvrdma-abi.h
> @@ -49,7 +49,9 @@
>  
>  #include <linux/types.h>
>  
> -#define PVRDMA_UVERBS_ABI_VERSION	3		/* ABI Version. */
> +#define PVRDMA_UVERBS_NO_QP_HANDLE_ABI_VERSION	3
> +#define PVRDMA_UVERBS_ABI_VERSION		4	/* ABI Version. */
> +
>  #define PVRDMA_UAR_HANDLE_MASK		0x00FFFFFF	/* Bottom 24 bits. */
>  #define PVRDMA_UAR_QP_OFFSET		0		/* QP doorbell. */
>  #define PVRDMA_UAR_QP_SEND		(1 << 30)	/* Send bit. */
> @@ -179,6 +181,11 @@ struct pvrdma_create_qp {
>  	__aligned_u64 qp_addr;
>  };
>  
> +struct pvrdma_create_qp_resp {
> +	__u32 qpn;
> +	__u32 qp_handle;
> +};
> +
>  /* PVRDMA masked atomic compare and swap */
>  struct pvrdma_ex_cmp_swap {
>  	__aligned_u64 swap_val;
> -- 
> 1.8.3.1
> 
