Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463EF7A803
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfG3MRj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 08:17:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40986 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfG3MRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 08:17:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id v22so46383765qkj.8
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2019 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LWjIEz/0prx+1jOIYL9QohDLp7vc71PtsEmjeGuN+cs=;
        b=bZVl5dStU6dTlnm2dt/ODv37hQV8tcCqNnmEwh46Zi2YyzGmExADMLPitIHMz9e9gS
         fS0c6Xcjt6YkWofBraLf+ohwc3IV70PINuaX2/ZijAzEZcPrBnfG5BcLVZCUbbQ/Dyxv
         6BMS8db3Tjv/1QoaNdgHOpSMx8aXVzjwbeinN2A3p/6x3EywIYvAvfwO5SSJPxkMRY62
         DuD3rTKQovkxpXdquxsvwdV0N7DjUWlO8v+0AP7cg7CYiKfMAWroCkxnygDh1NvR6toV
         fk6+KOUMnEES4QfiEJLMGcYBjwVP5bE4OILwDOynQucyutyzn7WGQ+uGiplqJGHpRalA
         E0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LWjIEz/0prx+1jOIYL9QohDLp7vc71PtsEmjeGuN+cs=;
        b=YzPmNijvrfrxfiwZ65sKFIbkSDtqm1CnHCKyi2wsHAp8dVccGgXFyx1wjnZhmQ6OKu
         u+bjJOMqFTMPjFJBSWIgvMTron27WrFRRwU+kyRGPbf4aIK+8ppfWo+JdtVofDnETyud
         r7l4EvY2i3jcVnf+WJrQetpkKbTZDTWwM6XPjUddpc6LsrLtsCsdVlCuJbTKc1VLaiqM
         dvZ/vuDJq0UlRQ0twEyh04o2XCfTddtyoxQpMzri0ZRonLpvN9Mav48Ua4LFWR2DvM6H
         Sa4oBbam0pXwjvxIqmHF5EjgbigDM204oClvXvQKE6UmcTn/ycigwxTegsExjrDw2+aB
         fOdA==
X-Gm-Message-State: APjAAAXH1AWsDBFK0SyP9h24svyzZAHNqf6hG+QfrsAZJURfBPjkmksh
        7RclYLJ7/gC+BrdOYOkmMk2G8Q==
X-Google-Smtp-Source: APXvYqwzys00zp17kremgV+qFCjJPibZkxL8yWOEmu019gezrbOCglwpaNMn1MdlZ1vMXhTIO2TKdQ==
X-Received: by 2002:a37:4e92:: with SMTP id c140mr69898580qkb.48.1564489058017;
        Tue, 30 Jul 2019 05:17:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w24sm38404483qtb.35.2019.07.30.05.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 05:17:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hsR4S-0006Gv-Ta; Tue, 30 Jul 2019 09:17:36 -0300
Date:   Tue, 30 Jul 2019 09:17:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Lijun Ou <oulijun@huawei.com>, dledford@redhat.com,
        leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 01/13] RDMA/hns: Encapsulate some lines for
 setting sq size in user mode
Message-ID: <20190730121736.GA13921@ziepe.ca>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
 <1564477010-29804-2-git-send-email-oulijun@huawei.com>
 <01dace9b-593d-39dd-99e7-d8d60803949d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01dace9b-593d-39dd-99e7-d8d60803949d@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 30, 2019 at 02:16:01PM +0300, Gal Pressman wrote:
> On 30/07/2019 11:56, Lijun Ou wrote:
> > It needs to check the sq size with integrity when configures
> > the relatived parameters of sq. Here moves the relatived code
> > into a special function.
> > 
> > Signed-off-by: Lijun Ou <oulijun@huawei.com>
> >  drivers/infiniband/hw/hns/hns_roce_qp.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > index 9c272c2..35ef7e2 100644
> > +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > @@ -324,16 +324,12 @@ static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
> >  	return 0;
> >  }
> >  
> > -static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
> > -				     struct ib_qp_cap *cap,
> > -				     struct hns_roce_qp *hr_qp,
> > -				     struct hns_roce_ib_create_qp *ucmd)
> > +static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
> > +					struct ib_qp_cap *cap,
> > +					struct hns_roce_ib_create_qp *ucmd)
> >  {
> >  	u32 roundup_sq_stride = roundup_pow_of_two(hr_dev->caps.max_sq_desc_sz);
> >  	u8 max_sq_stride = ilog2(roundup_sq_stride);
> > -	u32 ex_sge_num;
> > -	u32 page_size;
> > -	u32 max_cnt;
> >  
> >  	/* Sanity check SQ size before proceeding */
> >  	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
> > @@ -349,6 +345,25 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
> >  		return -EINVAL;
> >  	}
> >  
> > +	return 0;
> > +}
> > +
> > +static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
> > +				     struct ib_qp_cap *cap,
> > +				     struct hns_roce_qp *hr_qp,
> > +				     struct hns_roce_ib_create_qp *ucmd)
> > +{
> > +	u32 ex_sge_num;
> > +	u32 page_size;
> > +	u32 max_cnt;
> > +	int ret;
> > +
> > +	ret = check_sq_size_with_integrity(hr_dev, cap, ucmd);
> > +	if (ret) {
> > +		dev_err(hr_dev->dev, "Sanity check sq size fail\n");
> 
> Consider using ibdev_err, same applies for other patches.

It would be good if driver authors would convert their drivers to use
the new interfaces

Jason
