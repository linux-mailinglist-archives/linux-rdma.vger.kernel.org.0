Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D24164529
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 14:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgBSNTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 08:19:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34427 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgBSNTD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 08:19:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id l16so144990qtq.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 05:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vC29mJCiaIyy7pQ6dfJE5xAfGesFoKSnva0UI2ciKD8=;
        b=TXXz28dwFrrt3BoT3YqdwNg2RavD13Po3mHQb+Blck1wV2Ujfq1DH/Lnrxzp0bEf5k
         lQ7VXrLppegr+b4dj9ZLzjcebQmmt09h2VxfDU2NGykiTMjKDxoaMl7BUOa+HYhEjaqA
         7ApNfgidrOZs6V5abWq6VctcatakKzgb0DdnaWwUpBPHWHkoQtU0sn95x1Dc9xrRK8Uw
         P4QR0pTTv8luRSg20D3AhXnm8oCbDS2v5JWbRzLJ+/fWurVC4FNHmbFmqpmaGFX/Kv+L
         cehofxiQJ9NoAcNkGeNCh9uh/B5FDceFxxPgyj28beOwZCEIBSKYy9Bc2Vqs2klK2F67
         xA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vC29mJCiaIyy7pQ6dfJE5xAfGesFoKSnva0UI2ciKD8=;
        b=TjBepQOoZ6ExzxvflXZ7Wc/yGtNEvoCaPn/NdJIkRdqQeROGysV9R+q3KBrMSCYP4L
         lrOUIu/3RV0FaNQ/9GznceHg57qmvso638nXcWI7BCdsGzEH0RDqCpUQPrBD+ooYNilr
         BljSQUfNU1t9A9K2MhcFO64y52SRM+QxZaNy+fG6o+Ckrte4JK5hmiBQrIgtaRlZmt0Z
         F83QIZoUZWwrF/DAC72XhxkNSZ9iB9XubRpsjzj2WXq+dzv3fwTEXZPxBQ+JjdOj1lN3
         3D9FnIf/j1vGavEfwlPjWugSrNbOfQzyaYjqKjJTCjVwvktOn92uXlXNF4wP5yfqXvSE
         EZ9Q==
X-Gm-Message-State: APjAAAVcmOSfM5VWyAK0oGLT7SwECiG4oY4GBI/jKsQmYDUSQkJ9h2Ac
        qeOEU4On93vfY+ytQuveQz5K5A==
X-Google-Smtp-Source: APXvYqyoMwVxL20mrcY+4ulesgqE+krTmjULJD1/uzc6NczwvMWBXMZ58K9bsGlO30tp2PwpMvW8Gw==
X-Received: by 2002:ac8:6bc1:: with SMTP id b1mr21160249qtt.313.1582118342862;
        Wed, 19 Feb 2020 05:19:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o7sm971377qkd.119.2020.02.19.05.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 05:19:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4PFl-0001Bs-T5; Wed, 19 Feb 2020 09:19:01 -0400
Date:   Wed, 19 Feb 2020 09:19:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Optimize qp doorbell
 allocation flow
Message-ID: <20200219131901.GP31668@ziepe.ca>
References: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
 <1581325720-12975-8-git-send-email-liweihang@huawei.com>
 <20200219005225.GA25540@ziepe.ca>
 <04b1c2e6-a3e1-9e29-708d-4ae29c1e1602@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b1c2e6-a3e1-9e29-708d-4ae29c1e1602@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 04:14:36PM +0800, Weihang Li wrote:
> 
> 
> On 2020/2/19 8:52, Jason Gunthorpe wrote:
> > On Mon, Feb 10, 2020 at 05:08:40PM +0800, Weihang Li wrote:
> >> From: Xi Wang <wangxi11@huawei.com>
> >>
> >> Encapsulate the kernel qp doorbell allocation related code into 2
> >> functions: alloc_qp_db() and free_qp_db().
> >>
> >> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>  drivers/infiniband/hw/hns/hns_roce_qp.c | 214 +++++++++++++++++---------------
> >>  1 file changed, 113 insertions(+), 101 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> >> index ad34187..46785f1 100644
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> >> @@ -844,6 +844,96 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> >>  		free_rq_inline_buf(hr_qp);
> >>  }
> >>  
> >> +#define user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd) \
> >> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) && \
> >> +		udata->outlen >= sizeof(*resp) && \
> >> +		hns_roce_qp_has_sq(init_attr) && udata->inlen >= sizeof(*ucmd))
> >> +
> >> +#define user_qp_has_rdb(hr_dev, init_attr, udata, resp) \
> >> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
> >> +		udata->outlen >= sizeof(*resp) && \
> >> +		hns_roce_qp_has_rq(init_attr))
> >> +
> >> +#define kernel_qp_has_rdb(hr_dev, init_attr) \
> >> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
> >> +		hns_roce_qp_has_rq(init_attr))
> > 
> > static inline functions not defines please
> > 
> 
> OK, I will change them into inline functions.
> 
> > Also, these tests against inline and outlen look very strange. What
> > are they doing?
> > 
> > Jason
> >
> 
> These judgement about inlen and outlen is for compatibility reasons,
> previous discussions can be found at:
> 
> https://patchwork.kernel.org/patch/10172233/

Something is wrong, it should be testing the legnth using a
field_offset_off kind of scheme, not sizeof(*resp)

Jason
