Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6092C105EDC
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 04:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKVDCR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 21 Nov 2019 22:02:17 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2519 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfKVDCR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 22:02:17 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 6D4EAD9C3EE80349DEDF;
        Fri, 22 Nov 2019 11:02:10 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.127]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 11:02:03 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     liweihang <liweihang@hisilicon.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH rdma-core 2/7] libhns: Optimize bind_mw for fixing null
 pointer access
Thread-Topic: [PATCH rdma-core 2/7] libhns: Optimize bind_mw for fixing null
 pointer access
Thread-Index: AQHVoAo+j8+fx7N7IEC0P/jm/KoNN6eWgXsw
Date:   Fri, 22 Nov 2019 03:02:03 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED300CC8B9@dggemm526-mbx.china.huawei.com>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
 <1574299169-31457-3-git-send-email-liweihang@hisilicon.com>
In-Reply-To: <1574299169-31457-3-git-send-email-liweihang@hisilicon.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org
> [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Weihang Li
> Sent: Thursday, November 21, 2019 9:19 AM
> To: jgg@ziepe.ca; leon@kernel.org
> Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Linuxarm
> Subject: [PATCH rdma-core 2/7] libhns: Optimize bind_mw for fixing null
> pointer access
> 
> From: Xi Wang <wangxi11@huawei.com>
> 
> The argument checking flow in hns_roce_u_bind_mw() will leads to access
> on
> a null address when the mr is not initialized in mw_bind.
> 
> Fixes: 47eff6e8624d ("libhns: Adjust the order of parameter checking")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  providers/hns/hns_roce_u_verbs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/providers/hns/hns_roce_u_verbs.c
> b/providers/hns/hns_roce_u_verbs.c
> index bd5060d..0acfd9a 100644
> --- a/providers/hns/hns_roce_u_verbs.c
> +++ b/providers/hns/hns_roce_u_verbs.c
> @@ -186,7 +186,10 @@ int hns_roce_u_bind_mw(struct ibv_qp *qp,
> struct ibv_mw *mw,
>  	if (!bind_info->mr && bind_info->length)
>  		return EINVAL;
> 
> -	if ((mw->pd != qp->pd) || (mw->pd != bind_info->mr->pd))
> +	if (mw->pd != qp->pd)
> +		return EINVAL;
> +
> +	if (bind_info->mr && (mw->pd != bind_info->mr->pd))
>  		return EINVAL;
> 
Errno should also be set properly in this function, please refer to:
http://man7.org/linux/man-pages/man3/ibv_bind_mw.3.html

>  	if (mw->type != IBV_MW_TYPE_1)
> --
> 2.8.1

