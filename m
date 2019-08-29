Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCADA0EBD
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 02:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfH2A4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 20:56:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbfH2A4p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 20:56:45 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A32CCDD77757902318F;
        Thu, 29 Aug 2019 08:56:43 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 08:56:36 +0800
Subject: Re: [PATCH for-next 2/9] RDMA/hns: Refactor the codes of creating qp
To:     Doug Ledford <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
 <1566393276-42555-3-git-send-email-oulijun@huawei.com>
 <e91d1e75aad3b283e3d232993b15c1bb33e522d7.camel@redhat.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <0115f305-fcbd-f1c6-c552-7713ed0b9a0d@huawei.com>
Date:   Thu, 29 Aug 2019 08:56:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <e91d1e75aad3b283e3d232993b15c1bb33e522d7.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/8/28 23:19, Doug Ledford 写道:
> On Wed, 2019-08-21 at 21:14 +0800, Lijun Ou wrote:
>> +static int hns_roce_alloc_recv_inline_buffer(struct hns_roce_qp
>> *hr_qp,
>> +                                            struct ib_qp_init_attr
>> *init_attr)
>> +{
>> +       int ret;
>> +       int i;
>> +
>> +       /* allocate recv inline buf */
>> +       hr_qp->rq_inl_buf.wqe_list = kcalloc(hr_qp->rq.wqe_cnt,
>> +                                            sizeof(struct
>> hns_roce_rinl_wqe),
>> +                                            GFP_KERNEL);
>> +       if (!hr_qp->rq_inl_buf.wqe_list) {
>> +               ret = -ENOMEM;
>> +               goto err;
>> +       }
>> +
>> +       hr_qp->rq_inl_buf.wqe_cnt = hr_qp->rq.wqe_cnt;
>> +
>> +       /* Firstly, allocate a list of sge space buffer */
>> +       hr_qp->rq_inl_buf.wqe_list[0].sg_list =
>> +                                       kcalloc(hr_qp-
>>> rq_inl_buf.wqe_cnt,
>> +                                       init_attr->cap.max_recv_sge *
>> +                                       sizeof(struct
>> hns_roce_rinl_sge),
>> +                                       GFP_KERNEL);
>> +       if (!hr_qp->rq_inl_buf.wqe_list[0].sg_list) {
>> +               ret = -ENOMEM;
>> +               goto err_wqe_list;
>> +       }
>> +
>> +       for (i = 1; i < hr_qp->rq_inl_buf.wqe_cnt; i++)
>> +               /* Secondly, reallocate the buffer */
>> +               hr_qp->rq_inl_buf.wqe_list[i].sg_list =
>> +                                    &hr_qp-
>>> rq_inl_buf.wqe_list[0].sg_list[i *
>> +                                    init_attr->cap.max_recv_sge];
>> +
>> +       return 0;
>> +
>> +err_wqe_list:
>> +       kfree(hr_qp->rq_inl_buf.wqe_list);
>> +
>> +err:
>> +       return ret;
>> +}
> This function is klunky.  You don't need int ret; at all as there are
> only two possible return values and you have distinct locations for each
> return, so each return can use a constant.  It would be much more
> readable like this:
>
> +static int hns_roce_alloc_recv_inline_buffer(struct hns_roce_qp *hr_qp,
> +                                            struct ib_qp_init_attr *init_attr)
> +{
> +	int num_sge = init_attr->cap.max_recv_sge;
> +	int wqe_cnt = hr_qp->rq.wqe_cnt;
> +       int i;
> +
> +       /* allocate recv inline WQE bufs */
> +       hr_qp->rq_inl_buf.wqe_list = kcalloc(wqe_cnt,
> +                                            sizeof(struct hns_roce_rinl_wqe),
> +                                            GFP_KERNEL);
> +       if (!hr_qp->rq_inl_buf.wqe_list)
> +               goto err;
> +
> +       hr_qp->rq_inl_buf.wqe_cnt = wqe_cnt;
> +
> +       /* allocate a single sge array for all WQEs */
> +       hr_qp->rq_inl_buf.wqe_list[0].sg_list =
> +                                       kcalloc(wqe_cnt,
> +                                       num_sge *
> +                                       sizeof(struct hns_roce_rinl_sge),
> +                                       GFP_KERNEL);
> +       if (!hr_qp->rq_inl_buf.wqe_list[0].sg_list)
> +               goto err_wqe_list;
> +
> +       for (i = 1; i < wqe_cnt; i++)
> +               /* give each WQE a pointer to its array space */
> +               hr_qp->rq_inl_buf.wqe_list[i].sg_list =
> +                           &hr_qp->rq_inl_buf.wqe_list[0].sg_list[i * num_sge];
> +
> +       return 0;
> +
> +err_wqe_list:
> +       kfree(hr_qp->rq_inl_buf.wqe_list);
> +err:
> +       return -ENOMEM;
> +}
>
Thanks， I will consider accept your advice and fixes it.


