Return-Path: <linux-rdma+bounces-10978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E443ACDC12
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 12:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BC13A299D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7D928C5B6;
	Wed,  4 Jun 2025 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+xQzyPG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD557262F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034020; cv=none; b=lpfuclyX916rzQNENs8ryQ2qDInahcC8FwN8Zcjq6hRFfcTp+/V56c0J8NldXCiwKB+1aUULlV6Fb0G+OYocjly9QDobOSANo83Prc4y/F57UoXP3RG0+mxMu4zzA01BAcTq+p/Ib+tgAg/kslvWrb/dS+9XlRLbnwXWImBfJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034020; c=relaxed/simple;
	bh=dwFj09Wv/47n5Q/m5gEmNT9biYmFzuo2CYC8eVdX2gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/ydEqsGASPPt+QmM9T4KduuZPJlZFPHWNE3e2JW3hE7Xm0zU/RL/oWxw4tXGGRrYXUFq1e2BaK5AxA7a3EuQFN4wbWgdlAoYESYRJad9t3o5BrvRWgeLHgwDxG6mEhcEfXBWy+8Wpzln+xc70jqlzGgWf+kNmIt3b1uUMu7BcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+xQzyPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05027C4CEE7;
	Wed,  4 Jun 2025 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749034019;
	bh=dwFj09Wv/47n5Q/m5gEmNT9biYmFzuo2CYC8eVdX2gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+xQzyPG/sCHR/eAzRAmG94img6nag9yOG5a8b9+ukTMIYBxjld/yhzGZ+9TfKO+J
	 CKo1YF4Z2dR4gL8fzs1MMwDdhAnfWH+si4c3ty0raf1SdoqqFvB8wscmkIn4yZQaS8
	 m9bJ5Ay4rsCBrSw5VrZ2rPpCDxoj9KlmcRr3IZdZ/Bne3QYeIrGGhFfqHyLb4q/Twa
	 DPIr4cEzpTlMfWjum75suco2S8br/GDgsUq3vzqVQ68gfW/xvLjj3q/te53dAZM3kD
	 EyJvCKqmIjGGo1vRcUucwjcrT88vWl+O3QpBnjvR5iiMurqsiQcBQKYPeTolvPT/wI
	 +WcFow3v7qaDw==
Date: Wed, 4 Jun 2025 13:46:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: luoqing <l1138897701@163.com>, tangchengchang@huawei.com, jgg@ziepe.ca,
	luoqing@kylinos.cn, linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: ZERO_OR_NULL_PTR macro overdetection
Message-ID: <20250604104652.GE7435@unreal>
References: <20250603015936.103600-1-l1138897701@163.com>
 <bfa2366e-6876-ad51-ce07-fe98a46f7833@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa2366e-6876-ad51-ce07-fe98a46f7833@hisilicon.com>

On Tue, Jun 03, 2025 at 10:16:21AM +0800, Junxian Huang wrote:
> 
> 
> On 2025/6/3 9:59, luoqing wrote:
> > From: luoqing <luoqing@kylinos.cn>
> > 
> > sizeof(xx) these variable values' return values cannot be 0.
> > For memory allocation requests of non-zero length,
> > there is no need to check other return values;
> > it is sufficient to only verify that it is not null.
> > 
> > Signed-off-by: luoqing <luoqing@kylinos.cn>
> 
> For future patches, please add RDMA maillist.

For this patch too. Please resend.

Thanks

> 
> Thanks,
> Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>
> 
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
> >  drivers/infiniband/hw/hns/hns_roce_qp.c    | 4 ++--
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > index 160e8927d364..65884f63fc7c 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > @@ -2613,7 +2613,7 @@ static struct ib_pd *free_mr_init_pd(struct hns_roce_dev *hr_dev)
> >  	struct ib_pd *pd;
> >  
> >  	hr_pd = kzalloc(sizeof(*hr_pd), GFP_KERNEL);
> > -	if (ZERO_OR_NULL_PTR(hr_pd))
> > +	if (!hr_pd)
> >  		return NULL;
> >  	pd = &hr_pd->ibpd;
> >  	pd->device = ibdev;
> > @@ -2644,7 +2644,7 @@ static struct ib_cq *free_mr_init_cq(struct hns_roce_dev *hr_dev)
> >  	cq_init_attr.cqe = HNS_ROCE_FREE_MR_USED_CQE_NUM;
> >  
> >  	hr_cq = kzalloc(sizeof(*hr_cq), GFP_KERNEL);
> > -	if (ZERO_OR_NULL_PTR(hr_cq))
> > +	if (!hr_cq)
> >  		return NULL;
> >  
> >  	cq = &hr_cq->ib_cq;
> > @@ -2677,7 +2677,7 @@ static int free_mr_init_qp(struct hns_roce_dev *hr_dev, struct ib_cq *cq,
> >  	int ret;
> >  
> >  	hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
> > -	if (ZERO_OR_NULL_PTR(hr_qp))
> > +	if (!hr_qp)
> >  		return -ENOMEM;
> >  
> >  	qp = &hr_qp->ibqp;
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > index 9f376a2232b0..6ff1b8ce580c 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > @@ -1003,14 +1003,14 @@ static int alloc_kernel_wrid(struct hns_roce_dev *hr_dev,
> >  	int ret;
> >  
> >  	sq_wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64), GFP_KERNEL);
> > -	if (ZERO_OR_NULL_PTR(sq_wrid)) {
> > +	if (!sq_wrid) {
> >  		ibdev_err(ibdev, "failed to alloc SQ wrid.\n");
> >  		return -ENOMEM;
> >  	}
> >  
> >  	if (hr_qp->rq.wqe_cnt) {
> >  		rq_wrid = kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64), GFP_KERNEL);
> > -		if (ZERO_OR_NULL_PTR(rq_wrid)) {
> > +		if (!rq_wrid) {
> >  			ibdev_err(ibdev, "failed to alloc RQ wrid.\n");
> >  			ret = -ENOMEM;
> >  			goto err_sq;

