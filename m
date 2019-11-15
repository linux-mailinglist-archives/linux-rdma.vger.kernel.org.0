Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232EBFE6CA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 22:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKOVGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 16:06:25 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42337 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfKOVGZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Nov 2019 16:06:25 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so12237564qtn.9
        for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2019 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EG7K906kMcGt8+hVZrab1HJ1S3nSC9E+4VCaJ0YH6Og=;
        b=Z9ZDikuVFJXByH5te2jhsysWQO0nk5fnvqrPFzFBaBS3o8aWRlV0eO6sKD6v2ts7kG
         Y887kCjvxDfKuYQu4bWp2Nrn3ypI1NP+hCcbJ9KPJuKNIF8PW/9qkun1mvKwuXCCj05S
         OWcaOKlAlBLqEylcJBI4Qq3gVOFRLPSPj/lmi6MX7nIzC11znKuoPjgFOfmGOkoPEjec
         ImJ7RhmWp0gvxNYiWyOcegAmDpvtOfpNvLCp3JVtJdueCxSXh2MOCFu54UZKmLeYjEWb
         9vBEl8rRwxTailjhI+RtrjGTTyTPrJr1rfNIMx+rhH4ygeBNH6EdRqp8jalCtDWiu4T4
         QwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EG7K906kMcGt8+hVZrab1HJ1S3nSC9E+4VCaJ0YH6Og=;
        b=Ktd33x64LmBraimVXzIVAAVWvUWATaKgo45joz6vPCawDfRSErYPv3MQcjMYJFs1AM
         FwTjPeEPvXFSQsems4b6JNRQFI2DCGadOmMDO9YtEHWvoXhjoWytWHUNNYswjsQKhWGN
         cvahOAqmIsxKn9XUrUNHDj0WMnMAtNtHU0f8+iYYm+UMNbXb5wCInTdfd2c1mC+jYAvQ
         C4OFAJvDXmaYg/pw7102pamVwYBEBqA24GMoREBjUUbxH+d88mEz9HET1VXxcbqkd6bm
         v4VyZa2X7XO1O3UZtjT1nIeVJ/MCKHqaSqA2F6As9nyzRnAz1yC8fZfWH4hTUi7iy9CQ
         duHw==
X-Gm-Message-State: APjAAAUyBcKocqNrHkw+vFFmC+4TV3he9p2Ls3e51VAs6G1ukx+NNpjQ
        I/obWTthbcexWXr0D79kV7f7Qw==
X-Google-Smtp-Source: APXvYqypB4DMZbRD5BpxEBe23sYi/2s4isift245iiIywNpHDQGvlx+nwmOXPtY8nGL1XCQ6C8L5lQ==
X-Received: by 2002:ac8:4901:: with SMTP id e1mr15923535qtq.280.1573851982475;
        Fri, 15 Nov 2019 13:06:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id n5sm4737221qke.74.2019.11.15.13.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 13:06:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVinN-0007lF-Is; Fri, 15 Nov 2019 17:06:21 -0400
Date:   Fri, 15 Nov 2019 17:06:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yixian Liu <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue framework
 for flush cqe handler
Message-ID: <20191115210621.GE4055@ziepe.ca>
References: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
 <1573563124-12579-2-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573563124-12579-2-git-send-email-liuyixian@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 12, 2019 at 08:52:03PM +0800, Yixian Liu wrote:
> HiP08 RoCE hardware lacks ability(a known hardware problem) to flush
> outstanding WQEs if QP state gets into errored mode for some reason.
> To overcome this hardware problem and as a workaround, when QP is
> detected to be in errored state during various legs like post send,
> post receive etc [1], flush needs to be performed from the driver.
> 
> The earlier patch[1] sent to solve the hardware limitation explained
> in the cover-letter had a bug in the software flushing leg. It
> acquired mutex while modifying QP state to errored state and while
> conveying it to the hardware using the mailbox. This caused leg to
> sleep while holding spin-lock and caused crash.
> 
> Suggested Solution:
> we have proposed to defer the flushing of the QP in the Errored state
> using the workqueue to get around with the limitation of our hardware.
> 
> This patch adds the framework of the workqueue and the flush handler
> function.
> 
> [1] https://patchwork.kernel.org/patch/10534271/
> 
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Reviewed-by: Salil Mehta <salil.mehta@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_device.h |  3 +++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 33 +++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index a1b712e..42d8a5a 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -906,6 +906,7 @@ struct hns_roce_caps {
>  struct hns_roce_work {
>  	struct hns_roce_dev *hr_dev;
>  	struct work_struct work;
> +	struct hns_roce_qp *hr_qp;
>  	u32 qpn;
>  	u32 cqn;
>  	int event_type;
> @@ -1034,6 +1035,7 @@ struct hns_roce_dev {
>  	const struct hns_roce_hw *hw;
>  	void			*priv;
>  	struct workqueue_struct *irq_workq;
> +	struct hns_roce_work flush_work;
>  	const struct hns_roce_dfx_hw *dfx;
>  };
>  
> @@ -1226,6 +1228,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
>  				 struct ib_udata *udata);
>  int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		       int attr_mask, struct ib_udata *udata);
> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
>  void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
>  void *get_send_wqe(struct hns_roce_qp *hr_qp, int n);
>  void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 907c951..ec48e7e 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -5967,8 +5967,8 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
>  		goto err_request_irq_fail;
>  	}
>  
> -	hr_dev->irq_workq =
> -		create_singlethread_workqueue("hns_roce_irq_workqueue");
> +	hr_dev->irq_workq = alloc_workqueue("hns_roce_irq_workqueue",
> +					    WQ_MEM_RECLAIM, 0);
>  	if (!hr_dev->irq_workq) {
>  		dev_err(dev, "Create irq workqueue failed!\n");
>  		ret = -ENOMEM;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 9442f01..0111f2e 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -43,6 +43,39 @@
>  
>  #define SQP_NUM				(2 * HNS_ROCE_MAX_PORTS)
>  
> +static void flush_work_handle(struct work_struct *work)
> +{
> +	struct hns_roce_work *flush_work = container_of(work,
> +					struct hns_roce_work, work);
> +	struct hns_roce_qp *hr_qp = flush_work->hr_qp;
> +	struct device *dev = flush_work->hr_dev->dev;
> +	struct ib_qp_attr attr;
> +	int attr_mask;
> +	int ret;
> +
> +	attr_mask = IB_QP_STATE;
> +	attr.qp_state = IB_QPS_ERR;
> +
> +	ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
> +	if (ret)
> +		dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
> +			ret);
> +
> +	if (atomic_dec_and_test(&hr_qp->refcount))
> +		complete(&hr_qp->free);
> +}
> +
> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> +{
> +	struct hns_roce_work *flush_work = &hr_dev->flush_work;
> +
> +	flush_work->hr_dev = hr_dev;
> +	flush_work->hr_qp = hr_qp;
> +	INIT_WORK(&flush_work->work, flush_work_handle);
> +	atomic_inc(&hr_qp->refcount);
> +	queue_work(hr_dev->irq_workq, &flush_work->work);

It kind of looks like this can be called multiple times? It won't work
right unless it is called exactly once

Jason
