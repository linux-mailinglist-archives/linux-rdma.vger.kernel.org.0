Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B69E381D
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 18:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503488AbfJXQhv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 12:37:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32801 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503426AbfJXQhv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 12:37:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id 71so20139791qkl.0
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=icUcqUpogMECyP9sH76MDAGI4PdsOcFvi0zQAXjD5gw=;
        b=ST1oBqzm9l8vzLOyZd0hRdCTcihiK2U9o8TM/jacoBDnU4AVFGgpmdK9QyBPzIv0LT
         XqKXh9bzvZ2CnNsSRCsquLkCF1HfYeHjxZaJtKWFtPbuoBSBKAymRWHa0E0sNJtR6cDZ
         AaMopgtUpByu56oJEt9TxwZr5BVD8EkBQxHqDxmbTjv8JPDr8EPZ68zRRqtZh3Yu+t7/
         TaGpCpxuVgyAJT0mj84eAQUTdDMbp5MSb3zka9FpbFq7XGbLhD51oVezSDmqoYruc5F3
         GGv3HLNnCM0k+G9j3XEtyD6op7y7uLr4FhsZWnUuXhX7RdOzG0esFhmuBDcSpHUvVGAC
         88ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=icUcqUpogMECyP9sH76MDAGI4PdsOcFvi0zQAXjD5gw=;
        b=lxbqdoL585/o+s8FG5wYLvXmlBVrLG6WYh78Wn7zlYU/fVvfG3bTMRvgV9WX3xvEi+
         y0c+OKDDf5wJI9vAlfI8Ka6ha/LKcXbcDiEsdnoslsaRtRSs0px5dEwRlYP3hfLc014A
         7p0TZ+uRkvUIQxHV7DhcuBH68iaUUAjiLAkwylCnzkU73AxgMXy6bfXetj/CcdBDPHbq
         RjRvsslWNGAJ0gIxdrm5pDtkZ87xeDzmEkIp109Vee88VLYRvnmINN+gRKXMLEVGj/RF
         oY8YHd8yuhoZB+rBiAzG+BfTfLvfYOy3zJVjjMYjz/e2vdhHxDfbTaYTqg1P+3D6V19z
         j7Vg==
X-Gm-Message-State: APjAAAW1m0URpRgjqxTWFwJykNarXxdzIgIMqRD9im0iRYbOhnyHpncq
        +gVBzvdzwg1kxX4YDhUJUQBnng==
X-Google-Smtp-Source: APXvYqzZ0VWRSwVTylmKa0BuouZZvLyySisivc4pMB71YfWx6u3wxNBWEhqw/qDGp1ExbrEwOrBvbg==
X-Received: by 2002:a37:2fc1:: with SMTP id v184mr14897957qkh.18.1571935070042;
        Thu, 24 Oct 2019 09:37:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id f11sm12729426qkk.76.2019.10.24.09.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 09:37:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNg7R-0003wV-1Y; Thu, 24 Oct 2019 13:37:49 -0300
Date:   Thu, 24 Oct 2019 13:37:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: prevent undefined behavior in
 hns_roce_set_user_sq_size()
Message-ID: <20191024163749.GX23952@ziepe.ca>
References: <20190608092514.GC28890@mwanda>
 <20191007121821.GI21515@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007121821.GI21515@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 07, 2019 at 03:18:22PM +0300, Dan Carpenter wrote:
> This one still needs to be applied.
> 
> regards,
> dan carpenter

Weird, it is marked changes requested in patchworks. An email must
have been lost??

I think I probably wanted to say that:

> >  	/* Sanity check SQ size before proceeding */
> > -	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
> > +	if (ucmd->log_sq_bb_count > 31 ||
> > +	    (u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes
> > ||

Overall should probably be coded using check_shl_overflow(), as this
later shift:

	hr_qp->sq.wqe_cnt = 1 << ucmd->log_sq_bb_count;

Is storing it into an int and hardwring '31' because it magically
matches that lower shift is pretty fragile.

More like this?

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index bec48f2593f405..6aa27d6ea3a600 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -332,9 +332,8 @@ static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
 	u8 max_sq_stride = ilog2(roundup_sq_stride);
 
 	/* Sanity check SQ size before proceeding */
-	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
-	     ucmd->log_sq_stride > max_sq_stride ||
-	     ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
+	if (ucmd->log_sq_stride > max_sq_stride ||
+	    ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
 		ibdev_err(&hr_dev->ib_dev, "check SQ size error!\n");
 		return -EINVAL;
 	}
@@ -358,13 +357,16 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 	u32 max_cnt;
 	int ret;
 
+	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &hr_qp->sq.wqe_cnt) ||
+	    hr_qp->sq.wqe_cnt > hr_dev->caps.max_wqes)
+		return -EINVAL;
+
 	ret = check_sq_size_with_integrity(hr_dev, cap, ucmd);
 	if (ret) {
 		ibdev_err(&hr_dev->ib_dev, "Sanity check sq size failed\n");
 		return ret;
 	}
 
-	hr_qp->sq.wqe_cnt = 1 << ucmd->log_sq_bb_count;
 	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
 
 	max_cnt = max(1U, cap->max_send_sge);
