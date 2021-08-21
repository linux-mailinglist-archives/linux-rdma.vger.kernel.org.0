Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861E63F3A7C
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhHUL4V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 07:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhHUL4V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 21 Aug 2021 07:56:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47A4A611CC;
        Sat, 21 Aug 2021 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629546942;
        bh=rY6FVsif80lxYBGPifMhCxtPJ3tnjW7mNgQrGOMy2OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCtSXf4q94IASA4pPPfDxTw4EAkL9TBj/oxyugtOhg3TUP8L5qW+tJ5uEraOeoVTN
         kfw+P1sgOQ+0c75kvRyXI3foJpQDuilDj/6l9HntKufmBUKHLxmOEF5TbPheiB7yg9
         3xmmmWQdzE1YT3Jg3A6vJXdKV6NAO1EQY544sdqkWjhs3r3m/yvwHnH9f1G+pGKE7m
         ufnQ+l07aFpan58+MeDBxOUG6Xc77Dhwcjz2QWOA2OoERGXhcsenrLYWpF/Zartec7
         11pwpFksQDrv6PIbTo4p+qGgQ0NShxWCe/fUwKCu+ZdlNBmcujOB/Vux+iEGnT85pj
         teTDicO67IbBw==
Date:   Sat, 21 Aug 2021 14:55:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Alok Prasad <palok@marvell.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, michal.kalderon@marvell.com,
        ariel.elior@marvell.com, smalin@marvell.com,
        linux-rdma@vger.kernel.org, Ariel Elior <aelior@marvell.com>
Subject: Re: [for-rc] RDMA/qedr: qedr crash while running rdma-tool.
Message-ID: <YSDpuTIsM2gL1h7e@unreal>
References: <20210821074339.16614-1-palok@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821074339.16614-1-palok@marvell.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 21, 2021 at 07:43:39AM +0000, Alok Prasad wrote:
> This patch fixes crash caused by querying qp.
> This is due the fact that when no traffic is running,
> rdma_create_qp hasn't created any qp hence qed->qp is null.

This description is not correct, all QP creation flows
dev->ops->rdma_create_qp() is called and if qedr_create_qp() successes,
we will have valid qp->qed_qp pointer.

> 
> Below call trace is generated while using iproute2 utility
> "rdma res show -dd qp" on rdma interface.
> 
> ==========================================================================
> [  302.569794] BUG: kernel NULL pointer dereference, address: 0000000000000034
> ..
> [  302.570378] Hardware name: Dell Inc. PowerEdge R720/0M1GCR, BIOS 1.2.6 05/10/2012
> [  302.570500] RIP: 0010:qed_rdma_query_qp+0x33/0x1a0 [qed]
> [  302.570861] RSP: 0018:ffffba560a08f580 EFLAGS: 00010206
> [  302.570979] RAX: 0000000200000000 RBX: ffffba560a08f5b8 RCX: 0000000000000000
> [  302.571100] RDX: ffffba560a08f5b8 RSI: 0000000000000000 RDI: ffff9807ee458090
> [  302.571221] RBP: ffffba560a08f5a0 R08: 0000000000000000 R09: ffff9807890e7048
> [  302.571342] R10: ffffba560a08f658 R11: 0000000000000000 R12: 0000000000000000
> [  302.571462] R13: ffff9807ee458090 R14: ffff9807f0afb000 R15: ffffba560a08f7ec
> [  302.571583] FS:  00007fbbf8bfe740(0000) GS:ffff980aafa00000(0000) knlGS:0000000000000000
> [  302.571729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  302.571847] CR2: 0000000000000034 CR3: 00000001720ba001 CR4: 00000000000606f0
> [  302.571968] Call Trace:
> [  302.572083]  qedr_query_qp+0x82/0x360 [qedr]
> [  302.572211]  ib_query_qp+0x34/0x40 [ib_core]
> [  302.572361]  ? ib_query_qp+0x34/0x40 [ib_core]
> [  302.572503]  fill_res_qp_entry_query.isra.26+0x47/0x1d0 [ib_core]
> [  302.572670]  ? __nla_put+0x20/0x30
> [  302.572788]  ? nla_put+0x33/0x40
> [  302.572901]  fill_res_qp_entry+0xe3/0x120 [ib_core]
> [  302.573058]  res_get_common_dumpit+0x3f8/0x5d0 [ib_core]
> [  302.573213]  ? fill_res_cm_id_entry+0x1f0/0x1f0 [ib_core]
> [  302.573377]  nldev_res_get_qp_dumpit+0x1a/0x20 [ib_core]
> [  302.573529]  netlink_dump+0x156/0x2f0
> [  302.573648]  __netlink_dump_start+0x1ab/0x260
> [  302.573765]  rdma_nl_rcv+0x1de/0x330 [ib_core]
> [  302.573918]  ? nldev_res_get_cm_id_dumpit+0x20/0x20 [ib_core]
> [  302.574074]  netlink_unicast+0x1b8/0x270
> [  302.574191]  netlink_sendmsg+0x33e/0x470
> [  302.574307]  sock_sendmsg+0x63/0x70
> [  302.574421]  __sys_sendto+0x13f/0x180
> [  302.574536]  ? setup_sgl.isra.12+0x70/0xc0
> [  302.574655]  __x64_sys_sendto+0x28/0x30
> [  302.574769]  do_syscall_64+0x3a/0xb0
> [  302.574884]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> ==========================================================================
> 
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index fdc47ef7d861..79603e3fe2db 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -2758,15 +2758,18 @@ int qedr_query_qp(struct ib_qp *ibqp,
>  	int rc = 0;
>  
>  	memset(&params, 0, sizeof(params));
> -
> -	rc = dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
> -	if (rc)
> -		goto err;
> -

At that point, QP should be valid.

>  	memset(qp_attr, 0, sizeof(*qp_attr));
>  	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
>  
> -	qp_attr->qp_state = qedr_get_ibqp_state(params.state);
> +	if (qp->qed_qp)
> +		rc = dev->ops->rdma_query_qp(dev->rdma_ctx,
> +					     qp->qed_qp, &params);
> +
> +	if (qp->qp_type == IB_QPT_GSI)
> +		qp_attr->qp_state = QED_ROCE_QP_STATE_RTS;
> +	else
> +		qp_attr->qp_state = qedr_get_ibqp_state(params.state);
> +
>  	qp_attr->cur_qp_state = qedr_get_ibqp_state(params.state);
>  	qp_attr->path_mtu = ib_mtu_int_to_enum(params.mtu);
>  	qp_attr->path_mig_state = IB_MIG_MIGRATED;
> @@ -2810,8 +2813,6 @@ int qedr_query_qp(struct ib_qp *ibqp,
>  
>  	DP_DEBUG(dev, QEDR_MSG_QP, "QEDR_QUERY_QP: max_inline_data=%d\n",
>  		 qp_attr->cap.max_inline_data);
> -
> -err:
>  	return rc;
>  }
>  
> -- 
> 2.17.1
> 
