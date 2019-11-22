Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE84105ECF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 03:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKVC64 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 21 Nov 2019 21:58:56 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:58016 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfKVC64 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 21:58:56 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id DCCD63840DB641BC80FC;
        Fri, 22 Nov 2019 10:58:53 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.127]) by
 DGGEMM402-HUB.china.huawei.com ([10.3.20.210]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 10:58:45 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     liweihang <liweihang@hisilicon.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH rdma-core 1/7] libhns: Fix calculation errors with
 ilog32()
Thread-Topic: [PATCH rdma-core 1/7] libhns: Fix calculation errors with
 ilog32()
Thread-Index: AQHVoAo7Qv7b6bhdREOl0yi3XoMtM6eWgFRA
Date:   Fri, 22 Nov 2019 02:58:44 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED300CC8A5@dggemm526-mbx.china.huawei.com>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
 <1574299169-31457-2-git-send-email-liweihang@hisilicon.com>
In-Reply-To: <1574299169-31457-2-git-send-email-liweihang@hisilicon.com>
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
> Subject: [PATCH rdma-core 1/7] libhns: Fix calculation errors with ilog32()
> 
> Current calculation results using ilog32() is larger than expected, which
> will lead to driver broken. The following is the log when QP creations
> fails:
> 
> [   81.294844] hns3 0000:7d:00.0 hns_0: check SQ size error!
> [   81.294848] hns3 0000:7d:00.0 hns_0: check SQ size error!
> [   81.300225] hns3 0000:7d:00.0 hns_0: Sanity check sq size failed
> [   81.300227] hns3 0000:7d:00.0: hns_roce_set_user_sq_size error for
> create qp
> [   81.305602] hns3 0000:7d:00.0 hns_0: Sanity check sq size failed
> [   81.305603] hns3 0000:7d:00.0: hns_roce_set_user_sq_size error for
> create qp
> [   81.311589] hns3 0000:7d:00.0 hns_0: Create RC QP 0x000000
> failed(-22)
> [   81.318603] hns3 0000:7d:00.0 hns_0: Create RC QP 0x000000
> failed(-22)
> 
> Fixes: b6cd213b276f ("libhns: Refactor for creating qp")
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  providers/hns/hns_roce_u_verbs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/providers/hns/hns_roce_u_verbs.c
> b/providers/hns/hns_roce_u_verbs.c
> index 9d222c0..bd5060d 100644
> --- a/providers/hns/hns_roce_u_verbs.c
> +++ b/providers/hns/hns_roce_u_verbs.c
> @@ -645,7 +645,8 @@ static int hns_roce_calc_qp_buff_size(struct
> ibv_pd *pd, struct ibv_qp_cap *cap,
>  	int page_size = to_hr_dev(pd->context->device)->page_size;
> 
>  	if (to_hr_dev(pd->context->device)->hw_version ==
> HNS_ROCE_HW_VER1) {
> -		qp->rq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_rq_wqe));
> +		qp->rq.wqe_shift =
> +				ilog32(sizeof(struct hns_roce_rc_rq_wqe)) - 1;
> 
>  		qp->buf_size = align((qp->sq.wqe_cnt << qp->sq.wqe_shift),
>  				     page_size) +
> @@ -662,7 +663,7 @@ static int hns_roce_calc_qp_buff_size(struct
> ibv_pd *pd, struct ibv_qp_cap *cap,
>  	} else {
>  		unsigned int rqwqe_size = HNS_ROCE_SGE_SIZE *
> cap->max_recv_sge;
> 
> -		qp->rq.wqe_shift = ilog32(rqwqe_size);
> +		qp->rq.wqe_shift = ilog32(rqwqe_size) - 1;
> 
>  		if (qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE || type ==
> IBV_QPT_UD)
>  			qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
> @@ -747,8 +748,8 @@ static void hns_roce_set_qp_params(struct
> ibv_pd *pd,
>  		qp->rq.wqe_cnt =
> roundup_pow_of_two(attr->cap.max_recv_wr);
>  	}
> 
> -	qp->sq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_send_wqe));
> -	qp->sq.shift = ilog32(qp->sq.wqe_cnt);
> +	qp->sq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_send_wqe)) - 1;
> +	qp->sq.shift = ilog32(qp->sq.wqe_cnt) - 1;

One suggestion, it's better to introduce a new micro instead of ilog32(x) -1.

>  	qp->rq.max_gs = attr->cap.max_recv_sge;
> 
>  	if (to_hr_dev(pd->context->device)->hw_version ==
> HNS_ROCE_HW_VER1) {
> @@ -884,7 +885,7 @@ struct ibv_qp *hns_roce_u_create_qp(struct
> ibv_pd *pd,
> 
>  	cmd.buf_addr = (uintptr_t) qp->buf.buf;
>  	cmd.log_sq_stride = qp->sq.wqe_shift;
> -	cmd.log_sq_bb_count = ilog32(qp->sq.wqe_cnt);
> +	cmd.log_sq_bb_count = ilog32(qp->sq.wqe_cnt) - 1;
> 
>  	pthread_mutex_lock(&context->qp_table_mutex);
> 
> --
> 2.8.1

