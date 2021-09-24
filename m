Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EAA416E1D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 10:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbhIXIkm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 04:40:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16236 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244722AbhIXIkl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Sep 2021 04:40:41 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HG55H1Wrgz1DHFc;
        Fri, 24 Sep 2021 16:37:55 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 16:39:07 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 16:39:06 +0800
Subject: Re: [PATCH] RDMA/hns: Work around broken constant propogation in gcc
 8
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <0-v1-c773ecb137bc+11f-hns_gcc8_jgg@nvidia.com>
CC:     Lang Cheng <chenglang@huawei.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Weihang Li <liweihang@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <0d7bfb8b-0947-7349-77d4-2dae2ac0d3ad@huawei.com>
Date:   Fri, 24 Sep 2021 16:39:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <0-v1-c773ecb137bc+11f-hns_gcc8_jgg@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/9/16 23:05, Jason Gunthorpe wrote:
> gcc 8.3 and 5.4 throw this:
> 
> In function 'modify_qp_init_to_rtr',
> ././include/linux/compiler_types.h:322:38: error: call to '__compiletime_assert_1859' declared with attribute error: FIELD_PREP: value too large for the field
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> [..]
> drivers/infiniband/hw/hns/hns_roce_common.h:91:52: note: in expansion of macro 'FIELD_PREP'
>    *((__le32 *)ptr + (field_h) / 32) |= cpu_to_le32(FIELD_PREP(   \
>                                                     ^~~~~~~~~~
> drivers/infiniband/hw/hns/hns_roce_common.h:95:39: note: in expansion of macro '_hr_reg_write'
>  #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
>                                        ^~~~~~~~~~~~~
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4412:2: note: in expansion of macro 'hr_reg_write'
>   hr_reg_write(context, QPC_LP_PKTN_INI, lp_pktn_ini);
> 
> Because gcc has miscalculated the constantness of lp_pktn_ini:
> 
> 	mtu = ib_mtu_enum_to_int(ib_mtu);
> 	if (WARN_ON(mtu < 0)) [..]
> 	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
> 
> Since mtu is limited to {256,512,1024,2048,4096} lp_pktn_ini is between 4
> and 8 which is compatible with the 4 bit field in the FIELD_PREP.
> 
> Work around this broken compiler by adding a 'can never be true'
> constraint on lp_pktn_ini's value which clears out the problem.
> 
> Fixes: f0cb411aad23 ("RDMA/hns: Use new interface to modify QP context")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 5b9953105752c3..a9c00a2e8ebdbb 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4397,7 +4397,12 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
>  	hr_qp->path_mtu = ib_mtu;
>  
>  	mtu = ib_mtu_enum_to_int(ib_mtu);
> -	if (WARN_ON(mtu < 0))
> +	if (WARN_ON(mtu <= 0))
> +		return -EINVAL;
> +#define MAX_LP_MSG_LEN 65536
> +	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 64KB */
> +	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
> +	if (WARN_ON(lp_pktn_ini >= 0xF))
>  		return -EINVAL;
>  
>  	if (attr_mask & IB_QP_PATH_MTU) {
> @@ -4405,10 +4410,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
>  		hr_reg_clear(qpc_mask, QPC_MTU);
>  	}
>  
> -#define MAX_LP_MSG_LEN 65536
> -	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 64KB */
> -	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
> -
>  	hr_reg_write(context, QPC_LP_PKTN_INI, lp_pktn_ini);
>  	hr_reg_clear(qpc_mask, QPC_LP_PKTN_INI);
>  
> 
> base-commit: ad17bbef3dd573da937816edc0ab84fed6a17fa6
> 
Hi, Jason,

Sorry for the late reply,
It seems okay to me, thanks!

Wengpeng

