Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA5322F20B
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgG0Ogz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 10:36:55 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:58202 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729823AbgG0Ogy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 10:36:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06REVRC4015524;
        Mon, 27 Jul 2020 07:36:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0818;
 bh=ZvYytE26mgm/phw5XQmFzqxhqbaV+4vagxEmhtiLVmA=;
 b=AWbUNslcY1IyiOni3WzCshIWvTp4Us4+KfWzwvsePxzta5ggR+VBnl9khCw8dnvgzNsX
 QDCnEUifvrhP40gRneZVkgyluL0Deh7i6F+e7++mHswBhvYd7h4bWQiMUsfSVFhqJgOl
 L6bus/ujJxvVwZ+eFZQ6DGQ8JaaUmb8Pd6hauxJLnP53rERBsthPXMG7f0/EMumiGyW0
 wnfvYibgdmlq9Za3bMiz6/k75VuOYdugaY0qsEpKoWRO8626iuT91D/7kgn0v2Log/Nn
 35Ydhq4H/u3TPZlvjhud8GO8StQ8hB2T+G1SCgeZTfAvvu7O2OHDN7NAYWvXU3ouHwva XQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 32gj3qqq0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 07:36:48 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 27 Jul
 2020 07:36:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 07:36:48 -0700
Received: from NN-LT0049.marvell.com (NN-LT0049.marvell.com [10.193.54.6])
        by maili.marvell.com (Postfix) with ESMTP id B7A283F703F;
        Mon, 27 Jul 2020 07:36:44 -0700 (PDT)
From:   Alexander Lobakin <alobakin@marvell.com>
To:     Colin King <colin.king@canonical.com>
CC:     Alexander Lobakin <alobakin@marvell.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-rdma@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] qed: fix assignment of n_rq_elems to incorrect params field
Date:   Mon, 27 Jul 2020 17:36:04 +0300
Message-ID: <20200727143604.3835-1-alobakin@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727141712.112906-1-colin.king@canonical.com>
References: <20200727141712.112906-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_08:2020-07-27,2020-07-27 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Colin,

From: Colin King <colin.king@canonical.com>
Date: Mon, 27 Jul 2020 15:17:12 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently n_rq_elems is being assigned to params.elem_size instead of the
> field params.num_elems.  Coverity is detecting this as a double assingment
> to params.elem_size and reporting this as an usused value on the first
> assignment.  Fix this.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: b6db3f71c976 ("qed: simplify chain allocation with init params struct")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 5a80471577a6..4ce4e2eef6cc 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1930,7 +1930,7 @@ qedr_roce_create_kernel_qp(struct qedr_dev *dev,
>  	in_params->sq_pbl_ptr = qed_chain_get_pbl_phys(&qp->sq.pbl);
>  
>  	params.intended_use = QED_CHAIN_USE_TO_CONSUME_PRODUCE;
> -	params.elem_size = n_rq_elems;
> +	params.num_elems = n_rq_elems;

Sorry for copy'n'paste braino. Thanks for catching.

>  	params.elem_size = QEDR_RQE_ELEMENT_SIZE;
>  
>  	rc = dev->ops->common->chain_alloc(dev->cdev, &qp->rq.pbl, &params);
> -- 
> 2.27.0

Acked-by: Alexander Lobakin <alobakin@marvell.com>

Al
