Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D03169253
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2020 00:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBVXiD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Feb 2020 18:38:03 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37713 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgBVXiD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Feb 2020 18:38:03 -0500
Received: by mail-qv1-f67.google.com with SMTP id ci20so1311415qvb.4
        for <linux-rdma@vger.kernel.org>; Sat, 22 Feb 2020 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VLl3hzdaOkFnH3vTX45qm9Xrscpeb01D4zCnpzVFqu8=;
        b=V5VfHoWAJkVz6YzislxWFILrmAB/sXIozgEzDBTA2OJQ4oHrI7/Fgfx/KlaB0Utqo9
         LpHzDOu1VCi0AnclZu597VMIJLxQ/GKF018E+E0i+lnV4ovsj+d6P1h0rvhf2kMKQLQ6
         hu20eeFWyNKkkI9vvXMB2MIztXrKxttz8CEGJkff+7YyNwoxsor8MZRfrhnf7v8Of3gS
         eRAvF1K3Aj071czgEVQ/caDq4hVZwS/1zxcBKjSUguEJ3bDfU1XPJxT++URvn0cHa8bh
         Z0g25sy9iVbItuJUwtv+cgAKKNHQjlBoRVPGz40WG8Gq4WsDdk1kMWFSNnvJtEypq7O9
         oCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VLl3hzdaOkFnH3vTX45qm9Xrscpeb01D4zCnpzVFqu8=;
        b=MP3axJ9kF36lXAra+8UP2omVaIRAWx07WdDRLuLz8ZDAaAfmUVZq9oHJyqWj38TaQy
         u29Yn/03JQCSHNyLW/84QbQ+VA1HTyjRKSfhAqNmFvTFh8lobqyiALBppcddZz9XJ/Lp
         o5yBvZkIFTAmCudcnVOXfeHt3kqpD39W3OJs15Kzi95435fAPK6A6Sd/RN/gj6tk40S3
         ua453MbNpUA6BHSgSFeAx2mK6bXMI1q+aeIVmabnAdKy5D03rZp5vXGIGqi+gNdNCyuS
         Kex12XjWalrxinq5mF8oOwRIxxsOGYU+phV6c+zzdmp1yWVGSIbeDB4J5nfYupkn7YN+
         moaQ==
X-Gm-Message-State: APjAAAXkwRmDCzny4thnHgL1hy5AsX0o2324Ody64RwfWrxlx1nQCY4F
        C7041nPN+Rijf45GvD88p6TMRg==
X-Google-Smtp-Source: APXvYqyBPIJbENeQz0IMJMN2DpL2wub/HzApxhZ5fELW3CuQYBr+1mykDMLCSV7ekwemRg7OpeIxng==
X-Received: by 2002:a0c:a910:: with SMTP id y16mr37865569qva.139.1582414681898;
        Sat, 22 Feb 2020 15:38:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k7sm3779140qtd.79.2020.02.22.15.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Feb 2020 15:38:01 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j5eLQ-00018y-AQ; Sat, 22 Feb 2020 19:38:00 -0400
Date:   Sat, 22 Feb 2020 19:38:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Optimize qp doorbell
 allocation flow
Message-ID: <20200222233800.GN31668@ziepe.ca>
References: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
 <1581325720-12975-8-git-send-email-liweihang@huawei.com>
 <20200219005225.GA25540@ziepe.ca>
 <04b1c2e6-a3e1-9e29-708d-4ae29c1e1602@huawei.com>
 <20200219131901.GP31668@ziepe.ca>
 <2032cac3-b31f-8f86-64d2-a931b973fdfa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2032cac3-b31f-8f86-64d2-a931b973fdfa@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 22, 2020 at 03:22:18PM +0800, Weihang Li wrote:
> 
> 
> On 2020/2/19 21:19, Jason Gunthorpe wrote:
> > On Wed, Feb 19, 2020 at 04:14:36PM +0800, Weihang Li wrote:
> >>
> >>
> >> On 2020/2/19 8:52, Jason Gunthorpe wrote:
> >>> On Mon, Feb 10, 2020 at 05:08:40PM +0800, Weihang Li wrote:
> >>>> From: Xi Wang <wangxi11@huawei.com>
> >>>>
> >>>> Encapsulate the kernel qp doorbell allocation related code into 2
> >>>> functions: alloc_qp_db() and free_qp_db().
> >>>>
> >>>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> >>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>>>  drivers/infiniband/hw/hns/hns_roce_qp.c | 214 +++++++++++++++++---------------
> >>>>  1 file changed, 113 insertions(+), 101 deletions(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> >>>> index ad34187..46785f1 100644
> >>>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> >>>> @@ -844,6 +844,96 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> >>>>  		free_rq_inline_buf(hr_qp);
> >>>>  }
> >>>>  
> >>>> +#define user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd) \
> >>>> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) && \
> >>>> +		udata->outlen >= sizeof(*resp) && \
> >>>> +		hns_roce_qp_has_sq(init_attr) && udata->inlen >= sizeof(*ucmd))
> >>>> +
> >>>> +#define user_qp_has_rdb(hr_dev, init_attr, udata, resp) \
> >>>> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
> >>>> +		udata->outlen >= sizeof(*resp) && \
> >>>> +		hns_roce_qp_has_rq(init_attr))
> >>>> +
> >>>> +#define kernel_qp_has_rdb(hr_dev, init_attr) \
> >>>> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
> >>>> +		hns_roce_qp_has_rq(init_attr))
> >>>
> >>> static inline functions not defines please
> >>>
> >>
> >> OK, I will change them into inline functions.
> >>
> >>> Also, these tests against inline and outlen look very strange. What
> >>> are they doing?
> >>>
> >>> Jason
> >>>
> >>
> >> These judgement about inlen and outlen is for compatibility reasons,
> >> previous discussions can be found at:
> >>
> >> https://patchwork.kernel.org/patch/10172233/
> > 
> > Something is wrong, it should be testing the legnth using a
> > field_offset_off kind of scheme, not sizeof(*resp)
> > 
> > Jason
> > 
> Hi Jason,
> 
> Do you means
> 
> 	udata->outlen >= sizeof(*resp)
> 
> should be changed into:
> 
> 	udata->out_len >= offsetof(typeof(*resp), cap_flags)
> 
> If yes, I will fix other similar codes with this issue in hns drivers.

Probably offsetofend though, right?

But yes, that is how the general 'feature test for old userspace with
old kernel ABI' should look

Jason
