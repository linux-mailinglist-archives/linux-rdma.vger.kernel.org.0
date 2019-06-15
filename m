Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67D046EC7
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfFOHoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 03:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfFOHoH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Jun 2019 03:44:07 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BD72184C;
        Sat, 15 Jun 2019 07:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560584646;
        bh=UntT73bkDuV1Anb1G3WwI/wo3PLFcW2T0h01OC2orVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPWppuHdNbN2tzXeF+Hk7dbChkSqCxHGMWunuhKw1Qfh35Pduz/skwVNxX3/pQOp/
         dgfqSNb0yO1kRnyAK1mloA94gu72s2WMBSC2HiUbVEBONjBbWB0G/mEUK2tJPx/oC/
         8OuJT7OsLG/P8eBwuvVYhN+DXC50gtmavrjRirSs=
Date:   Sat, 15 Jun 2019 10:44:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     oulijun <oulijun@huawei.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Parav Pandit <pandit.parav@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: =?utf-8?Q?=E3=80=90A_question_about_ke?=
 =?utf-8?Q?rnel_verbs_API=E3=80=91?=
Message-ID: <20190615074400.GD4694@mtr-leonro.mtl.com>
References: <8e80779d-7c1f-4644-3fa7-6fca24734eb8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e80779d-7c1f-4644-3fa7-6fca24734eb8@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 14, 2019 at 09:16:15AM +0800, oulijun wrote:
> Hi， Jason Gunthorpe & Leon Romanovsky& Parav Pandit
>    Recently when I was learning kernel ofed code, I found an interesting thing about verbs, the implementation rely on
> roce driver,  taking ib_dereg_mr for example.
>
> When the driver returns error, the reference count of rdma resource(pd, mr, etc.) won't be decreased. I worried that it
> will cause a memory leak.

I assume that we are talking about lack of rdma_restrack_put(pd) inside
of ib_dereg_mr(). It is done on purpose because purpose of restrack is
to protect memory from being released async, for example QP during netlink
queries. In sync flows, it is response of uverbs and ULPs to release
resources in proper order, which they do.

>
> int ib_dereg_mr(struct ib_mr *mr)
> {
> 	struct ib_pd *pd = mr->pd;
> 	struct ib_dm *dm = mr->dm;
> 	int ret;
>
> 	rdma_restrack_del(&mr->res);
> 	ret = mr->device->ops.dereg_mr(mr);
> 	if (!ret) {
> 		atomic_dec(&pd->usecnt);
> 		if (dm)
> 			atomic_dec(&dm->usecnt);
> 	}
>
> 	return ret;
> }
>
> and it is even worse in ib_destroy_qp, rdma_put_gid_attr is not called, so that the net_device will be hold all the time, and caused the
> pcie remove scenario hanging.
>
> The following code is:
> int ib_destroy_qp(struct ib_qp *qp)
> {
> 	const struct ib_gid_attr *alt_path_sgid_attr = qp->alt_path_sgid_attr;
> 	const struct ib_gid_attr *av_sgid_attr = qp->av_sgid_attr;
> 	struct ib_pd *pd;
> 	struct ib_cq *scq, *rcq;
> 	struct ib_srq *srq;
> 	struct ib_rwq_ind_table *ind_tbl;
> 	struct ib_qp_security *sec;
> 	int ret;
>
> 	WARN_ON_ONCE(qp->mrs_used > 0);
>
> 	if (atomic_read(&qp->usecnt))
> 		return -EBUSY;
>
> 	if (qp->real_qp != qp)
> 		return __ib_destroy_shared_qp(qp);
>
> 	pd   = qp->pd;
> 	scq  = qp->send_cq;
> 	rcq  = qp->recv_cq;
> 	srq  = qp->srq;
> 	ind_tbl = qp->rwq_ind_tbl;
> 	sec  = qp->qp_sec;
> 	if (sec)
> 		ib_destroy_qp_security_begin(sec);
>
> 	if (!qp->uobject)
> 		rdma_rw_cleanup_mrs(qp);
>
> 	rdma_restrack_del(&qp->res);
> 	ret = qp->device->ops.destroy_qp(qp);
> 	if (!ret) {
> 		if (alt_path_sgid_attr)
> 			rdma_put_gid_attr(alt_path_sgid_attr);
> 		if (av_sgid_attr)
> 			rdma_put_gid_attr(av_sgid_attr);
> 		if (pd)
> 			atomic_dec(&pd->usecnt);
> 		if (scq)
> 			atomic_dec(&scq->usecnt);
> 		if (rcq)
> 			atomic_dec(&rcq->usecnt);
> 		if (srq)
> 			atomic_dec(&srq->usecnt);
> 		if (ind_tbl)
> 			atomic_dec(&ind_tbl->usecnt);
> 		if (sec)
> 			ib_destroy_qp_security_end(sec);
> 	} else {
> 		if (sec)
> 			ib_destroy_qp_security_abort(sec);
> 	}
>
> 	return ret;
> }
>
>
> My question is what the condieration about the  resource destroy mechanism when roce driver returns error?

Like all other destroy calls, the QP destroy should be converted do not
fail. QPs and MRs are hardest part of my conversion series and amount
of code needed to be fixed in drivers is astonishing.

> Or I understand it wrong?
>
> Thanks
> Lijun Ou
>
