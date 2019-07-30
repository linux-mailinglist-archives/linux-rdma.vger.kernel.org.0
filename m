Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6317A6B2
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 13:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfG3LQP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 07:16:15 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1531 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfG3LQP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 07:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564485374; x=1596021374;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YMeyRbqzfd/ZyBM1tySbb74zUxnsQ9pyBPYVhX4Rmrk=;
  b=sJwWDsabvx8jbqb8XbwLZlSXMjxhkknKgqDBiK19ZVTn4Pw12YtCTgmM
   Tn6SnkSq4uMD6gc+lVhTm6KG9f9fwiarCTb7cjRqweSjs8RHhbkaitHQr
   XjIjNfRmhiXdAR7hzlHy37dxA3kwTFwGcH1UUol7c2spw9DamsWplXEIB
   w=;
X-IronPort-AV: E=Sophos;i="5.64,326,1559520000"; 
   d="scan'208";a="776863683"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 Jul 2019 11:16:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 143A4A1EE7;
        Tue, 30 Jul 2019 11:16:11 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 11:16:10 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.197) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 11:16:06 +0000
Subject: Re: [PATCH for-next 01/13] RDMA/hns: Encapsulate some lines for
 setting sq size in user mode
To:     Lijun Ou <oulijun@huawei.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
 <1564477010-29804-2-git-send-email-oulijun@huawei.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <01dace9b-593d-39dd-99e7-d8d60803949d@amazon.com>
Date:   Tue, 30 Jul 2019 14:16:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564477010-29804-2-git-send-email-oulijun@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.197]
X-ClientProxiedBy: EX13D19UWC002.ant.amazon.com (10.43.162.179) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30/07/2019 11:56, Lijun Ou wrote:
> It needs to check the sq size with integrity when configures
> the relatived parameters of sq. Here moves the relatived code
> into a special function.
> 
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 9c272c2..35ef7e2 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -324,16 +324,12 @@ static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
>  	return 0;
>  }
>  
> -static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
> -				     struct ib_qp_cap *cap,
> -				     struct hns_roce_qp *hr_qp,
> -				     struct hns_roce_ib_create_qp *ucmd)
> +static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
> +					struct ib_qp_cap *cap,
> +					struct hns_roce_ib_create_qp *ucmd)
>  {
>  	u32 roundup_sq_stride = roundup_pow_of_two(hr_dev->caps.max_sq_desc_sz);
>  	u8 max_sq_stride = ilog2(roundup_sq_stride);
> -	u32 ex_sge_num;
> -	u32 page_size;
> -	u32 max_cnt;
>  
>  	/* Sanity check SQ size before proceeding */
>  	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
> @@ -349,6 +345,25 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
>  		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
> +				     struct ib_qp_cap *cap,
> +				     struct hns_roce_qp *hr_qp,
> +				     struct hns_roce_ib_create_qp *ucmd)
> +{
> +	u32 ex_sge_num;
> +	u32 page_size;
> +	u32 max_cnt;
> +	int ret;
> +
> +	ret = check_sq_size_with_integrity(hr_dev, cap, ucmd);
> +	if (ret) {
> +		dev_err(hr_dev->dev, "Sanity check sq size fail\n");

Consider using ibdev_err, same applies for other patches.

> +		return ret;
> +	}
> +
>  	hr_qp->sq.wqe_cnt = 1 << ucmd->log_sq_bb_count;
>  	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
>  
> 
