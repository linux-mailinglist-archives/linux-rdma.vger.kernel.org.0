Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F114E2D5C2D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 14:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbgLJNp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 08:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732601AbgLJNp6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 08:45:58 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83174C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 05:45:18 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 19so4720851qkm.8
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRkhhqxjP6co7X87PuQBiqo3eIikMs+l6W+VVm+21NA=;
        b=gweAQdIfg/XWDo51yJql3E1juvfb9D8lxVhS5gfBXBhfkapAEGUTGDWy39oGuHpV6s
         xRnGA5CK3vmJh3kc7Cy0DOgumk2Lwcw2oK1YsDvy/zc0nPPuh9VCVO4pqYd/dx4d8fQw
         g5RsHa+BZDHGY5WgQyukAvHR2un8p37MQVHIqQpHgQnKlEAyXHhKATPuyb5worKmkPhf
         dtBSWDZXanfsg5XFFLuPRWtCdfYjGpjNDflVdxMt+gHh4O9PncSOD0+3hAQlOEOVj6OQ
         g/CDdxiwoHDrKFV1Uj+JTqnlurybx9uoKAtk6uLnaqfMBWPLKByEhL6DxCoiIMMSBw8R
         P/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRkhhqxjP6co7X87PuQBiqo3eIikMs+l6W+VVm+21NA=;
        b=OqOrum9Acr/T5KYo3jXLjgw3OkbT0iy64CfYdaByECeZNLkyDklAGw6P4/zyJtwCjk
         wP24/cAI1g+knMw1uFybWUsaDkoUZl7S2Wot22BO+TwQHlI3ExtQkO4Q86G77gkm0Ndl
         MzwEM2FUX2lJvFdijb5vb5P35lvMtcFxEREzk5igk9eROQ8+hdbdjf+sa5xr1J9s2l7J
         WwQBqUSlzM/PUP+o18+HKJm0JTTb6gulsncedm07mGvGjo39bp9OcwM2y9q42qY3vRr5
         kG9ucyEfDh6pVhTlwXXabF90OaXa1eZPOn/FARgFcxwpje7lbbgQ7ITzKl5iO7np8HE0
         erNQ==
X-Gm-Message-State: AOAM533Z25wS4t3KxRM42JXMM5VOnFVEHye2CMihRRf6Nq4z+fCavho7
        Pa/B1m1dEfZ4DX1yBuo3NmxD/w==
X-Google-Smtp-Source: ABdhPJy/5amspwn9+c9+fGJUxx2jYK1QTcJNFNAJtv9ev4yiDRwyAqiNAtkVfAp3nT8aHloE9bAg7w==
X-Received: by 2002:a05:620a:15b4:: with SMTP id f20mr9340939qkk.486.1607607917752;
        Thu, 10 Dec 2020 05:45:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id q16sm3405487qtl.91.2020.12.10.05.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 05:45:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1knMFw-008oMj-AX; Thu, 10 Dec 2020 09:45:16 -0400
Date:   Thu, 10 Dec 2020 09:45:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 05/11] RDMA/hns: WARN_ON if get a reserved sl
 from users
Message-ID: <20201210134516.GY5487@ziepe.ca>
References: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
 <1607078436-26455-6-git-send-email-liweihang@huawei.com>
 <20201209210902.GA2001139@nvidia.com>
 <29da177187e44ffd98a9b834ff3dc5ed@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29da177187e44ffd98a9b834ff3dc5ed@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 10, 2020 at 04:00:16AM +0000, liweihang wrote:
> On 2020/12/10 5:09, Jason Gunthorpe wrote:
> > On Fri, Dec 04, 2020 at 06:40:30PM +0800, Weihang Li wrote:
> >> According to the RoCE v1 specification, the sl (service level) 0-7 are
> >> mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
> >> driver should verify whether the value of sl is larger than 7, if so, an
> >> exception should be returned.
> >>
> >> Fixes: 172505cfa3a8 ("RDMA/hns: Add check for the validity of sl configuration")
> >> Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index 7a0c1ab..15e1313 100644
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -433,6 +433,10 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
> >>  		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
> >>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
> >>  		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
> >> +
> >> +	if (WARN_ON(ah->av.sl > MAX_SERVICE_LEVEL))
> >> +		return -EINVAL;
> >> +
> >>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
> >>  		       V2_UD_SEND_WQE_BYTE_40_SL_S, ah->av.sl);
> >>  
> >> @@ -4609,12 +4613,8 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
> >>  	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
> >>  
> >>  	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
> >> -	if (unlikely(hr_qp->sl > MAX_SERVICE_LEVEL)) {
> >> -		ibdev_err(ibdev,
> >> -			  "failed to fill QPC, sl (%d) shouldn't be larger than %d.\n",
> >> -			  hr_qp->sl, MAX_SERVICE_LEVEL);
> >> +	if (WARN_ON(hr_qp->sl > MAX_SERVICE_LEVEL))
> >>  		return -EINVAL;
> >> -	}
> >>  
> >>  	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
> >>  		       V2_QPC_BYTE_28_SL_S, hr_qp->sl);
> > 
> > Can any of these warn_on's be triggered by user space? That would not
> > be OK
> > 
> > Jason
> > 
> 
> Hi Jason,
> 
> Thanks for your comments, I understand that error that can be triggered by
> userspace shouldn't use WARN_ON(). So I shouldn't use WARN_ON() in
> hns_roce_v2_set_path().
> 
> As for the error in process of post_send, you suggested me to warn_on if
> a kernel user try to pass in an illegal opcode. So I guess I should use
> WARN_ON() too in sl's check when filling a UD WQE. Am I right?

Userspace should not be able to trigger warn_on

Bad kernel ULPs are OK to trigger warn_on

Jason
