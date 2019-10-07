Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6120BCE16B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2019 14:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfJGMS6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Oct 2019 08:18:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41036 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfJGMS6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Oct 2019 08:18:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97CEu7C143489;
        Mon, 7 Oct 2019 12:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=/UOOc1cATzBwlPLu/8Sz73f+GGsqx83AY5fORC6N2rw=;
 b=YY52EU6E9j39+xDs0clyylXViFHdLWF8fquciX/gkrS7ysfXoA5oko4JS6lmFS04qohh
 /7aqxdTuykCIg52zegrmiECBoiZlwG/AX0onyhOYOT5vcG7V3p72isvI7bOD3z7RUq0m
 lKehiA9D09i/+9HEshNZ6EmbdgbtDrmL1n/V194TNJdt440x+Qjpp5Db7oPV/UEIi/vO
 kRiN5+TNKMLerHYfwjqDlitTQAenRxzSXZNwSJq5Cp9KsXVbX/QljrD/wQvhekXgJ0Mo
 gSJtXB35ZIIYRRg1gR0qlaP26qLXs7/RJqohxYlCN/m78w4vv2EYJkgmwOG7DxuDzU7J rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vek4q69qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 12:18:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97CIQMQ055176;
        Mon, 7 Oct 2019 12:18:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vg1ytssh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 12:18:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x97CIc9n009673;
        Mon, 7 Oct 2019 12:18:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 05:18:37 -0700
Date:   Mon, 7 Oct 2019 15:18:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: prevent undefined behavior in
 hns_roce_set_user_sq_size()
Message-ID: <20191007121821.GI21515@kadam>
References: <20190608092514.GC28890@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608092514.GC28890@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070122
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This one still needs to be applied.

regards,
dan carpenter

On Sat, Jun 08, 2019 at 12:25:14PM +0300, Dan Carpenter wrote:
> The "ucmd->log_sq_bb_count" variable is a user controlled variable in
> the 0-255 range.  If we shift more than then number of bits in an int
> then it's undefined behavior (it shift wraps).  It turns out this
> doesn't cause any real issues at runtime, but it's good to check anyway.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 8db2817a249e..006b3e7f4ed5 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -342,7 +342,8 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
>  	u32 max_cnt;
>  
>  	/* Sanity check SQ size before proceeding */
> -	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
> +	if (ucmd->log_sq_bb_count > 31 ||
> +	    (u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
>  	     ucmd->log_sq_stride > max_sq_stride ||
>  	     ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
>  		dev_err(hr_dev->dev, "check SQ size error!\n");
> -- 
> 2.20.1
