Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD85A011
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1P4R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 11:56:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbfF1P4R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 11:56:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2EC97D0F09FF831BD1D;
        Fri, 28 Jun 2019 23:56:13 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Jun 2019
 23:56:06 +0800
Subject: =?UTF-8?Q?Re:_=e3=80=90A_question_about_kernel_verbs_API=e3=80=91?=
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        Parav Pandit <pandit.parav@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <8e80779d-7c1f-4644-3fa7-6fca24734eb8@huawei.com>
 <20190615074400.GD4694@mtr-leonro.mtl.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <23221aca-8350-f16d-853a-3b1ca3b33e71@huawei.com>
Date:   Fri, 28 Jun 2019 23:56:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190615074400.GD4694@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/6/15 15:44, Leon Romanovsky 写道:
> On Fri, Jun 14, 2019 at 09:16:15AM +0800, oulijun wrote:
>> Hi， Jason Gunthorpe & Leon Romanovsky& Parav Pandit
>>    Recently when I was learning kernel ofed code, I found an interesting thing about verbs, the implementation rely on
>> roce driver,  taking ib_dereg_mr for example.
>>
>> When the driver returns error, the reference count of rdma resource(pd, mr, etc.) won't be decreased. I worried that it
>> will cause a memory leak.
> I assume that we are talking about lack of rdma_restrack_put(pd) inside
> of ib_dereg_mr(). It is done on purpose because purpose of restrack is
> to protect memory from being released async, for example QP during netlink
> queries. In sync flows, it is response of uverbs and ULPs to release
> resources in proper order, which they do.
>
>> int ib_dereg_mr(struct ib_mr *mr)
>> {
>> 	struct ib_pd *pd = mr->pd;
>> 	struct ib_dm *dm = mr->dm;
>> 	int ret;
>>
>> 	rdma_restrack_del(&mr->res);
>> 	ret = mr->device->ops.dereg_mr(mr);
>> 	if (!ret) {
>> 		atomic_dec(&pd->usecnt);
>> 		if (dm)
>> 			atomic_dec(&dm->usecnt);
>> 	}
>>
>> 	return ret;
>> }
>>
>> and it is even worse in ib_destroy_qp, rdma_put_gid_attr is not called, so that the net_device will be hold all the time, and caused the
>> pcie remove scenario hanging.
>>
>> The following code is:
>> int ib_destroy_qp(struct ib_qp *qp)
>> {
>> 	const struct ib_gid_attr *alt_path_sgid_attr = qp->alt_path_sgid_attr;
>> 	const struct ib_gid_attr *av_sgid_attr = qp->av_sgid_attr;
>> 	struct ib_pd *pd;
>> 	struct ib_cq *scq, *rcq;
>> 	struct ib_srq *srq;
>> 	struct ib_rwq_ind_table *ind_tbl;
>> 	struct ib_qp_security *sec;
>> 	int ret;
>>
>> 	WARN_ON_ONCE(qp->mrs_used > 0);
>>
>> 	if (atomic_read(&qp->usecnt))
>> 		return -EBUSY;
>>
>> 	if (qp->real_qp != qp)
>> 		return __ib_destroy_shared_qp(qp);
>>
>> 	pd   = qp->pd;
>> 	scq  = qp->send_cq;
>> 	rcq  = qp->recv_cq;
>> 	srq  = qp->srq;
>> 	ind_tbl = qp->rwq_ind_tbl;
>> 	sec  = qp->qp_sec;
>> 	if (sec)
>> 		ib_destroy_qp_security_begin(sec);
>>
>> 	if (!qp->uobject)
>> 		rdma_rw_cleanup_mrs(qp);
>>
>> 	rdma_restrack_del(&qp->res);
>> 	ret = qp->device->ops.destroy_qp(qp);
>> 	if (!ret) {
>> 		if (alt_path_sgid_attr)
>> 			rdma_put_gid_attr(alt_path_sgid_attr);
>> 		if (av_sgid_attr)
>> 			rdma_put_gid_attr(av_sgid_attr);
>> 		if (pd)
>> 			atomic_dec(&pd->usecnt);
>> 		if (scq)
>> 			atomic_dec(&scq->usecnt);
>> 		if (rcq)
>> 			atomic_dec(&rcq->usecnt);
>> 		if (srq)
>> 			atomic_dec(&srq->usecnt);
>> 		if (ind_tbl)
>> 			atomic_dec(&ind_tbl->usecnt);
>> 		if (sec)
>> 			ib_destroy_qp_security_end(sec);
>> 	} else {
>> 		if (sec)
>> 			ib_destroy_qp_security_abort(sec);
>> 	}
>>
>> 	return ret;
>> }
>>
>>
>> My question is what the condieration about the  resource destroy mechanism when roce driver returns error?
> Like all other destroy calls, the QP destroy should be converted do not
> fail. QPs and MRs are hardest part of my conversion series and amount
> of code needed to be fixed in drivers is astonishing.
Thanks.
>> Or I understand it wrong?
>>
>> Thanks
>> Lijun Ou
>>
> .
>


