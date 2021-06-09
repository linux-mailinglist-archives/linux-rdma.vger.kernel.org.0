Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DB33A0CAB
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhFIGrv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 02:47:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43330 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhFIGrv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 02:47:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1596iKNM045134;
        Wed, 9 Jun 2021 06:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=riSPw2PmJJaL77XFedYUZfTRRq9mb2xCj1jmDsQ1fFc=;
 b=qhUeAlssKK2IBGLOfgbnKbQqPeOE2yihh6XEFNKc3FwRyfWFzlNkiY0Ub13FEHyIs4ZL
 IKATmgLvkRh8VqOoX9N64feqA0GQvGQKoT8nWxaGbQhmGa1ty+svFpfKsjuGDUCluou3
 R/m5hcE2Iat1HVV9XAhiulHx25PmRzgHX+zaPEFysWKj3raYHNnoO1tlNPPb8ve5923k
 E2fi8sBopqALZtVXOgOLAbSB2vkBm398ccfe8fFqhXJ4pi+PpIihgEMolHMyngCKFWHQ
 HbQyulC9UlFwvKqp9pabllaHIrdElqx4cpZkR0AgzDfS8yydok+QJZiZSrTLF0wa0Oou iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 39017ng3kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 06:45:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1596j8VU179278;
        Wed, 9 Jun 2021 06:45:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 390k1rnvwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 06:45:49 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1596jn0s180025;
        Wed, 9 Jun 2021 06:45:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 390k1rnvwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 06:45:49 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1596jmLS018956;
        Wed, 9 Jun 2021 06:45:48 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jun 2021 23:45:48 -0700
Date:   Wed, 9 Jun 2021 09:45:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1] irdma: Use list_last_entry/list_first_entry
Message-ID: <20210609064541.GK10983@kadam>
References: <20210608211415.680-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608211415.680-1-shiraz.saleem@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: zdmhKfWNYOKJMrJjkDEivvYW4oWf8-tC
X-Proofpoint-ORIG-GUID: zdmhKfWNYOKJMrJjkDEivvYW4oWf8-tC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090024
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 04:14:16PM -0500, Shiraz Saleem wrote:
> Use list_last_entry and list_first_entry instead of using prev and next
> pointers.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> v0->v1: create patch on more recent git version
> 
>  drivers/infiniband/hw/irdma/puda.c  | 2 +-
>  drivers/infiniband/hw/irdma/utils.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
> index 18057139817d..e09d3be90771 100644
> --- a/drivers/infiniband/hw/irdma/puda.c
> +++ b/drivers/infiniband/hw/irdma/puda.c
> @@ -1419,7 +1419,7 @@ irdma_ieq_handle_partial(struct irdma_puda_rsrc *ieq, struct irdma_pfpdu *pfpdu,
>  
>  error:
>  	while (!list_empty(&pbufl)) {
> -		buf = (struct irdma_puda_buf *)(pbufl.prev);
> +		buf = list_last_entry(&pbufl, struct irdma_puda_buf, list);
>  		list_del(&buf->list);
>  		list_add(&buf->list, rxlist);
>  	}
> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
> index 8ce3535cdc21..81e590fb77b1 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -425,8 +425,8 @@ struct irdma_cqp_request *irdma_alloc_and_get_cqp_request(struct irdma_cqp *cqp,
>  
>  	spin_lock_irqsave(&cqp->req_lock, flags);
>  	if (!list_empty(&cqp->cqp_avail_reqs)) {
> -		cqp_request = list_entry(cqp->cqp_avail_reqs.next,
> -					 struct irdma_cqp_request, list);
> +		cqp_request = list_first_entry(&cqp->cqp_avail_reqs,
> +					       struct irdma_cqp_request, list);
>  		list_del_init(&cqp_request->list);

Thanks for doing this one too.  :)

regards,
dan carpenter

