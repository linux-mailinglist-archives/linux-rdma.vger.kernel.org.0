Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FFCF2006
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfKFUkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 15:40:15 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40402 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfKFUkP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 15:40:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id z16so1015884qkg.7
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 12:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sjx8Xs6SbrczuyHVgKdcy4Y/dtyvoOMxY98T8JxSX+o=;
        b=luq+e1ysEyk3Nt1189211Cct5eqjeX3sXXnLOF27pd/w8XXDS3D+7hK7oj9h2g5o5v
         qs7mQoFTSeP7nMtCn95pCJeED68U3x96JQSUJpwrypxakFbE9nb9YYYFuBugpgcoEuK0
         LZno0pwOc4fMtHTxq4FL/9vFfeFx3m1gpTJeRfvf7J3mwFb+TI+BpZyXvyEkPPmxz5Wg
         wXy/tfkmFSttOInODMAJX5XT/j7a/qeAUOzDB64Ud4pQD3QiPyNvOaNIhLXyZYHNy9yz
         tN2DXAU0dop4xrUJKXT/41z7vj1rDY86xvYLfddZ8WzjJf3/fW7H9qVG7NAYE8iPrAfx
         97Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sjx8Xs6SbrczuyHVgKdcy4Y/dtyvoOMxY98T8JxSX+o=;
        b=Tp91No3I5PAWM20nh6Dh+jP6zIrtB6jHAxcW8a5P4sj582vbupXrxpXBrKrq4ee06D
         yjBiuYiwuhDzUhV7XEmK5xFDTBI1Bb0FyDtOU1Eo+DcCeOHRSeMi9C94GKVEn76nNY6i
         WVGZgAawthxv1iUP9ynhFiBwK6Zi9543ZdZgXnvTs04MJALP1rjzcxXwJ6EI5l/pZo3U
         +0F+vXMuD4uLZ1/XYwXAklLuVj4VMxW4Cxge/3OLe8PHiXIs8zYJALhI7ErJyTb7xnDF
         NqowVRVytn41RthuBqECv+tCJCKGIUUSts+OXwDNVHdIUvkJ0IIZ1ueG4Bgig/VA1vhp
         ZYGw==
X-Gm-Message-State: APjAAAXwVuo8IIRLzs5qPw9yt8/45qxd4aSqmSM+cHo+wCJm6zT9amtX
        eEwgQlUgWcRUspraFgsyCebYMw==
X-Google-Smtp-Source: APXvYqyHTJ4nqb2UzYdrkyvB0G623N2/DoYZMHYvLpFltfkfPoQCLuXPET8bXkKSKD5TANRNfTo32Q==
X-Received: by 2002:a37:2d43:: with SMTP id t64mr2517704qkh.51.1573072814726;
        Wed, 06 Nov 2019 12:40:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j71sm5986672qke.90.2019.11.06.12.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 12:40:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSS69-00070V-8o; Wed, 06 Nov 2019 16:40:13 -0400
Date:   Wed, 6 Nov 2019 16:40:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yixian Liu <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
Message-ID: <20191106204013.GA26459@ziepe.ca>
References: <1572255945-20297-1-git-send-email-liuyixian@huawei.com>
 <1572255945-20297-2-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572255945-20297-2-git-send-email-liuyixian@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 05:45:44PM +0800, Yixian Liu wrote:
> @@ -1998,6 +2000,17 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>  		}
>  	}
>  
> +	snprintf(workq_name, HNS_ROCE_WORKQ_NAME_LEN - 1,
> +		 "hns_roce_%d_flush_wq", device_id);
> +	device_id++;
> +
> +	hr_dev->flush_workq = alloc_workqueue(workq_name, WQ_HIGHPRI, 0);
> +	if (!hr_dev->flush_workq) {

Why is this so time critical?

> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index bec48f2..2c8f726 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -43,6 +43,49 @@
>  
>  #define SQP_NUM				(2 * HNS_ROCE_MAX_PORTS)
>  
> +static void flush_work_handle(struct work_struct *work)
> +{
> +	struct hns_roce_flush_work *flush_work = container_of(work,
> +					struct hns_roce_flush_work, work);
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

There is something wrong with your description as all this seems to do
is tell the HW to go to the ERR state.

Why don't you do this from hns_roce_irq_work_handle() ?

> +	kfree(flush_work);
> +
> +	/*
> +	 * make sure we signal QP destroy leg that flush QP was completed
> +	 * so that it can safely proceed ahead now and destroy QP
> +	 */
> +	if (atomic_dec_and_test(&hr_qp->refcount))
> +		complete(&hr_qp->free);

> +}
> +
> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> +{
> +	struct hns_roce_flush_work *flush_work;
> +
> +	flush_work = kzalloc(sizeof(struct hns_roce_flush_work), GFP_ATOMIC);
> +	if (!flush_work)
> +		return;

Don't do things that can fail here

> +
> +	flush_work->hr_dev = hr_dev;
> +	flush_work->hr_qp = hr_qp;
> +	INIT_WORK(&flush_work->work, flush_work_handle);
> +	atomic_inc(&hr_qp->refcount);
> +	queue_work(hr_dev->flush_workq, &flush_work->work);
> +}
> +
>  void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
>  {
>  	struct device *dev = hr_dev->dev;
