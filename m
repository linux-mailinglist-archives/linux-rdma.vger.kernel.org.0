Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A343B0448
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFVM1L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 22 Jun 2021 08:27:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5419 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFVM1L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 08:27:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G8QVp6YzHz71Y1;
        Tue, 22 Jun 2021 20:21:38 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 20:24:53 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 22 Jun 2021 20:24:53 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Tue, 22 Jun 2021 20:24:53 +0800
From:   liweihang <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liuyixing (A)" <liuyixing1@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix incorrect lsn field
Thread-Topic: [PATCH for-next] RDMA/hns: Fix incorrect lsn field
Thread-Index: AQHXZ15L3pFPfhSDEk2Jbk/a+xtQHw==
Date:   Tue, 22 Jun 2021 12:24:53 +0000
Message-ID: <51aff2ce364746228bbf2399531a25af@huawei.com>
References: <1624363243-12306-1-git-send-email-liweihang@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/6/22 20:01, liweihang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> In RNR NAK screnario, according to the specification, when no credit is
> available, only the first fragment of the send request can be sent. The
> LSN(Limit Sequence Number) field should be 0 or the entire packet will be
> resent.
> 
> Fixes: f0cb411aad23 ("RDMA/hns: Use new interface to modify QP context")
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 069c7cd..7da2a74 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4515,7 +4515,6 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
>  
>  	hr_reg_clear(qpc_mask, QPC_CHECK_FLG);
>  
> -	hr_reg_write(context, QPC_LSN, 0x100);
>  	hr_reg_clear(qpc_mask, QPC_LSN);
>  

This hr_reg_clear() is redundant and needs to be removed. I will resend this patch.

Weihang

>  	hr_reg_clear(qpc_mask, QPC_V2_IRRL_HEAD);
> 

