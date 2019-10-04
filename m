Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E19CC1CA
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfJDRfe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 13:35:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40026 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfJDRfe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 13:35:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so6523878qkb.7
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EKS9jfBt1Cia3S2tiBMJrQQRBhZeZmZbTpNVcTFJ4GE=;
        b=IUQyS3HBtwQdXH5V7/7gmonFZeT72tTO0Bz5NkqS9+YfmiELvzJdLkQC+n54tbcejG
         Q/VUMv5jZz4U8tC5rDp4DbkTvIia2cOUMJdl2eOkAcDHXSR7T5OQErl09NZCnJlpNvsJ
         /w6S67yawkB85pR8rcfVhAbKMB/10tB62R+I5nKXB8sTf6PuMsN3x5Hf2/prQzoIzPpc
         FUs3uV0eDBb7yIo70nnFQpnS9zA+Ufx2bPUxWe//ppjV1nwWYkfXfScIWjyV7OiL9puD
         zQIVkkHGk0z0uwORAmHCFxn3wrr24eNNLjR1/wYb5oI//rPMK4juIc04DM3bUP7OOuSl
         2KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EKS9jfBt1Cia3S2tiBMJrQQRBhZeZmZbTpNVcTFJ4GE=;
        b=kO/cKZ+deJaBceLtHdNVgeicTcr8AeeJW4x5kiHw3txOJ3x2M/j3AIhz3liBKhpCV0
         eG5iD7RBppwfKtJ1xtPOZM80A+zMHR1jt6CUa3qYCRodGlDxZ9hsLzHkri+9gnAbOqlf
         WhnScI/spa4V+Kg6KQyZFe9ikahjYTvjrn2/lnwJ5B6UvVUD5jBEW0ceDObkg900e3Gh
         Ivg4Wow9gqWJAIsg8a33eWhszc2PkroXh9gGZHohdHAI6RAAG7PPvzK3yUbKK3u/UuUm
         l9XHIpb47t2G7mFKAowQ6kLlSyrwDN4q5yx6yBH3aytCGoBBdC6k+x5l1JZfTvZ8OzQs
         essA==
X-Gm-Message-State: APjAAAXY435JYyNvS0g8Om6gqCSSCyaKIyGBs/1b0+5FTtWuK4WSj5b3
        L6PwC456F70WjmaOX5L0KLUBLKaDgw0=
X-Google-Smtp-Source: APXvYqyUHgGgLQtkmEjeBx3OKLRlWVEqXdrGJfabu+5Q7XZfPaR7EwIneEZwHA6XXKUkBaFqRF6Uow==
X-Received: by 2002:a37:5f03:: with SMTP id t3mr11532792qkb.130.1570210533036;
        Fri, 04 Oct 2019 10:35:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g8sm4529053qta.67.2019.10.04.10.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 10:35:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGRUK-0005d5-0b; Fri, 04 Oct 2019 14:35:32 -0300
Date:   Fri, 4 Oct 2019 14:35:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add UD support for hip08
Message-ID: <20191004173531.GC13988@ziepe.ca>
References: <1567155056-38660-1-git-send-email-liweihang@hisilicon.com>
 <cff5e5f3-8eac-4456-0b4e-5d5bb9c9b393@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff5e5f3-8eac-4456-0b4e-5d5bb9c9b393@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 10:13:00AM +0800, Weihang Li wrote:
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > index ba81768..5374cd0 100644
> > +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > @@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
> >  		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
> >  							(hr_qp->sq.max_gs - 2));
> >  
> > +	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
> > +		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
> > +						       hr_qp->sq.max_gs);
> > +
> >  	if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision == 0x20)) {
> >  		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
> >  			dev_err(hr_dev->dev,
> > @@ -1005,6 +1009,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
> >  	int ret;
> >  
> >  	switch (init_attr->qp_type) {
> > +	case IB_QPT_UD:
> >  	case IB_QPT_RC: {
> >  		hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
> >  		if (!hr_qp)
> > 
> 
> Hi Jason & Leon,
> 
> Do you have some suggestions on this patch? Could it be applied to for-next?

I'm not applying any more hns patches for features until the security
issue is settled

Jason
