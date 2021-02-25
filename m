Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D16032518B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Feb 2021 15:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhBYOeA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Feb 2021 09:34:00 -0500
Received: from p3plsmtpa07-03.prod.phx3.secureserver.net ([173.201.192.232]:59663
        "EHLO p3plsmtpa07-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232000AbhBYOd6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Feb 2021 09:33:58 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id FHZ1l9SQZKQk4FHZ1lYChe; Thu, 25 Feb 2021 07:24:24 -0700
X-CMAE-Analysis: v=2.4 cv=W6D96Tak c=1 sm=1 tr=0 ts=6037b318
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SRrdq9N9AAAA:8 a=lXvwE3LD-PdbJlVjoP8A:9
 a=APAc10L1BaqvsfqQ:21 a=jEGF4k1KpHUJKy5Q:21 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH] RDMA/hw/hfi1/tid_rdma: remove unnecessary conversion to
 bool
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        mike.marciniszyn@cornelisnetworks.com
Cc:     dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1614245175-73043-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <aeaa298a-8e62-4f0a-c0fe-72cec3c1ed90@talpey.com>
Date:   Thu, 25 Feb 2021 09:24:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1614245175-73043-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMfvRsARG1iaHqRBbSLhFxYGvBT444uELJqm4wCVBI1b6vLP1+04IjycYc+r+Z2rDC4JWphHjAr0Y3sTsVm28IUHu4gX1eypmsPigoROViwTiltKOnph
 J20MtSA4e08gnnOJtz3kzpjbAgjRiEq12SAzvlX2VDyfI7fK6t+aFn+DPKdTPjeJyxnAPtMKJtFMNz2N3/5Of57kh1pVaHOgh4BOPckoXYyL8u3IWBvdx8h7
 5scEGjt0JlkMDY+xASFUYbB1blYPbT5QFx4FcSbWJ6LBTlShYepR/F0oUKxxVQlTcDmLOsong0OD2rYZL6lBVGGj5z5KMsWMi0tPtuNNIOv99maRVDUjTFCs
 6zLoq7HfnmBKXyw4xC2MU6dJcQl7/WYg+5n3uoQrfbORUNrek9TTw2pFFepWRPgq16JEH00KtFD+Z4onfKsbo139gz4bqQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/25/2021 4:26 AM, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/infiniband/hw/hfi1/tid_rdma.c:1118:36-41: WARNING: conversion
> to bool not needed here.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
> index 0b1f9e4..8958ea3 100644
> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> @@ -1115,7 +1115,7 @@ static u32 kern_find_pages(struct tid_rdma_flow *flow,
>   	}
>   
>   	flow->length = flow->req->seg_len - length;
> -	*last = req->isge == ss->num_sge ? false : true;
> +	*last = req->isge == !ss->num_sge;

Are you sure this is what you want? The new code seems to compare
an index to a bool (refactoring)

	*last = req->isge == (ss->num_sge != 0);

Don't you actually want

	*last = req->isge != ss->num_sge;

??

Even then, it seems really hard to read.

>   	return i;
>   }
>   
> 
