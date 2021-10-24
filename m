Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CCC43885D
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Oct 2021 12:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhJXKsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Oct 2021 06:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230435AbhJXKsa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 24 Oct 2021 06:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635072369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNiB61jam4E0ZD6WREV4B3cyfiTACQxCTr0BCdGDrRw=;
        b=XSN+lD62bRYccLRxl45khwN5BIBR4ASHkNgdbKwCjwbOj1nl8V6xKzULAXM7ZlonuY1b6W
        eYp8EOc6zQkWNPO10cBe8Rq/qRZ1rvaMVPOjeFFXY9BXoIag+yFlDlfMJ5sqxZud9wNpkg
        ahiMMOu8hhN+iJYl2dUvJH4yWq7sThQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-Th3-GXsdMviUf0sOosD47w-1; Sun, 24 Oct 2021 06:46:08 -0400
X-MC-Unique: Th3-GXsdMviUf0sOosD47w-1
Received: by mail-wr1-f69.google.com with SMTP id m5-20020a5d56c5000000b00168861c65f9so636141wrw.0
        for <linux-rdma@vger.kernel.org>; Sun, 24 Oct 2021 03:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sNiB61jam4E0ZD6WREV4B3cyfiTACQxCTr0BCdGDrRw=;
        b=sma5NArT0ukOQ6WQ/HBeQbmDcXrRoEXGWCL5oRoS75e+P2+ce992mtHcbi92BoCxIs
         /McAjNDpDkPwIT5jjp302SYvvWAkf9/YDMuxEs3Kt0E+jgTfTmk3UFk0YiweBIBNENUD
         fqmOdc6NieJzS27hUe7yDm3uk3z0vAr+RPY9GdkSXTC1OpQ68AIQD9mCSwSsl/NTFKZ1
         lLMMjqQK63U1f9lCMkskOeNbPpJSZW4L0XcoaNH535GXa8n6J+E0/UlYfJzRLVgmXaSO
         l98Im6DTMWUhttJMlaLq7mTMiIfV1ijwYWSLNfMg68e5A/tN23kSO0rtRloTcxkzhaVA
         zvoA==
X-Gm-Message-State: AOAM530Wgfz0iLqMPEWiPr7DGOCZNWXY+GJuN+Bpp4hGicHV2GkBtVTl
        RbefR6R3H+1Ll5+Tz2BngaQDUHIjP1YyjecQDX+RbcKw8G2v2mxnajACCIM5AG2qdW+zT0boc6z
        y5OfDCSXeIm/1QLPgxWFB2g==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr12253285wmk.149.1635072366548;
        Sun, 24 Oct 2021 03:46:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIy6zjeyw1x5VuDa7SvyXVxV7ig67qoF2Izu3C9aHv4fLF5gKv3lCdaHsylaHNvSqrkmx18w==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr12253251wmk.149.1635072366230;
        Sun, 24 Oct 2021 03:46:06 -0700 (PDT)
Received: from ?IPV6:2a00:a040:19b:e02f::1006? ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id l21sm6491704wms.16.2021.10.24.03.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 03:46:05 -0700 (PDT)
Message-ID: <1871141c-2af4-5959-4c1a-1a7c9df73598@redhat.com>
Date:   Sun, 24 Oct 2021 13:46:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [v2,for-rc] RDMA/qedr: qedr crash while running rdma-tool
Content-Language: en-US
To:     Alok Prasad <palok@marvell.com>
Cc:     michal.kalderon@marvell.com, ariel.elior@marvell.com,
        linux-rdma@vger.kernel.org, smalin@marvell.com, aelior@marvell.com,
        alok.prasad7@gmail.com, Michal Kalderon <mkalderon@marvell.com>,
        dledford@redhat.com, jgg@ziepe.ca
References: <20211023164557.7921-1-palok@marvell.com>
From:   Kamal Heib <kheib@redhat.com>
In-Reply-To: <20211023164557.7921-1-palok@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/23/21 19:45, Alok Prasad wrote:
> This patch fixes crash caused by querying qp.
> Also corrects the state of gsi qp.
> 
> Below call trace is generated while using iproute2 utility
> "rdma res show -dd qp" on rdma interface.
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
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
> v2 (from [1]):
> 	- Change description.
> 	- Corrected enum type.
> [1] https://patchwork.kernel.org/project/linux-rdma/patch/20210821074339.16614-1-palok@marvell.com/
> ---
>   drivers/infiniband/hw/qedr/verbs.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index dcb3653db72d..85baa4f730df 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -2744,15 +2744,20 @@ int qedr_query_qp(struct ib_qp *ibqp,
>   	int rc = 0;
>   
>   	memset(&params, 0, sizeof(params));
> +	memset(qp_attr, 0, sizeof(*qp_attr));
> +	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
>   
> -	rc = dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
> +	if (qp->qed_qp)

I suggest to use "if (qp->qp_type != IB_QPT_GSI)" to match the handling 
of GSI QPs in the QEDR driver.

Thanks,
Kamal

> +		rc = dev->ops->rdma_query_qp(dev->rdma_ctx,
> +					     qp->qed_qp, &params);
>   	if (rc)
>   		goto err;
>   
> -	memset(qp_attr, 0, sizeof(*qp_attr));
> -	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
> +	if (qp->qp_type == IB_QPT_GSI)
> +		qp_attr->qp_state = qedr_get_ibqp_state(QED_ROCE_QP_STATE_RTS);
> +	else
> +		qp_attr->qp_state = qedr_get_ibqp_state(params.state);
>   
> -	qp_attr->qp_state = qedr_get_ibqp_state(params.state);
>   	qp_attr->cur_qp_state = qedr_get_ibqp_state(params.state);
>   	qp_attr->path_mtu = ib_mtu_int_to_enum(params.mtu);
>   	qp_attr->path_mig_state = IB_MIG_MIGRATED;
> 

