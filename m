Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B6939F229
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 11:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFHJUc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 05:20:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFHJUc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 05:20:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1589A9dY047780;
        Tue, 8 Jun 2021 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8vywc9LiIxJFnVq434tlJouj+nH7l4AqgUu98HjeVMc=;
 b=ayEgkM9VZreZg45VYBaXPrjQafjFvnlPi8H49jEKjV+D8qSIVc27n2GJ+44GYX0UwLMA
 zCmizPemBm6yJ0H+fs6ZjQ9+FRZy3yJYRASpA96N6ioSbUROBMcISzj9V9cEXRqMm9d7
 ES1NkfYpvDMwC+TZNpeDg/usL6S4qwTDo/JOKEyItXuhZXC/BlIcg8vc5p5HAtWZ1pkx
 hKSMGogcUtgsF9Ly52/LRe1yNqAlhR8H0cjeI97v73VyllfIjnMolyzB2gp/nIzZ50/3
 xCohMeJ5wDaMm6bRkoGmZ0O3l5TDnhSDiydTRfAZRz0q5rIteDVkhYvh2hfO+asToQcU dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3914quky53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 09:18:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1589AYRb116613;
        Tue, 8 Jun 2021 09:18:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3922wregw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 09:18:23 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1589ILk8179665;
        Tue, 8 Jun 2021 09:18:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3922wregv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 09:18:21 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1589IHci031161;
        Tue, 8 Jun 2021 09:18:20 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jun 2021 09:18:17 +0000
Date:   Tue, 8 Jun 2021 12:18:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] RDMA/irdma: Use list_move instead of
 list_del/list_add
Message-ID: <20210608091808.GB1955@kadam>
References: <20210608031041.2820429-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608031041.2820429-1-libaokun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: snVVomTToNRPPz5sYfEWRDhHv8vK1Uex
X-Proofpoint-GUID: snVVomTToNRPPz5sYfEWRDhHv8vK1Uex
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080061
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 11:10:41AM +0800, Baokun Li wrote:
> Using list_move() instead of list_del() + list_add().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  drivers/infiniband/hw/irdma/puda.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
> index 18057139817d..c0be6e37d425 100644
> --- a/drivers/infiniband/hw/irdma/puda.c
> +++ b/drivers/infiniband/hw/irdma/puda.c
> @@ -1420,8 +1420,7 @@ irdma_ieq_handle_partial(struct irdma_puda_rsrc *ieq, struct irdma_pfpdu *pfpdu,
>  error:
>  	while (!list_empty(&pbufl)) {
>  		buf = (struct irdma_puda_buf *)(pbufl.prev);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Not related to your patch but this would be nicer as:

		buf = list_last_entry(&pbufl, struct irdma_puda_buf, list);

> -		list_del(&buf->list);
> -		list_add(&buf->list, rxlist);
> +		list_move(&buf->list, rxlist);

regards,
dan carpenter
