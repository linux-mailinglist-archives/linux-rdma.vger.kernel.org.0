Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714BA2D2510
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgLHH4e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 02:56:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32776 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgLHH4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Dec 2020 02:56:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B87tGRr041349;
        Tue, 8 Dec 2020 07:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JoRnSXRuxByrCw8DKj0JvHYTmhxkq8eIB8CQIX6rsgU=;
 b=wZHW5SC79K6+hYi+Nh1mq5M8Ae4g8ML5l2qzdKS9bDZbFJ3k+GUDQ2wClXbGXY3TDyLV
 kCfV+PvWCXf20mJU0P/YThMqDaYNjFls5aeBxmCVfnILpNmKggwLY5rrW9ql7LDCqB9Y
 B4/9aFRa2J0L/po20T0pyzoX8hRcM9+cl5+Vye22MwqE1I4tkk00WFpaNC0sxNSWqRsp
 BldvENo5DiUZtBOaETqlHFHUJyfansh0f7onikV3zeJTid/ix98i4efyqqmc2dpe4vzi
 LnwEMjqKldtO2VeB+izvUs5kfWDDb9708i4HOm6dtbiwniB+64RvCn18rhUvxoouUtHu RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35825m1cf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 07:55:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B87oTgX044643;
        Tue, 8 Dec 2020 07:55:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 358m3xcbj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 07:55:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B87tkpo010578;
        Tue, 8 Dec 2020 07:55:46 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 23:55:45 -0800
Date:   Tue, 8 Dec 2020 10:55:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/3] RDMA/uverbs: Fix incorrect variable type
Message-ID: <20201208075539.GA2789@kadam>
References: <20201208073545.9723-1-leon@kernel.org>
 <20201208073545.9723-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208073545.9723-4-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080049
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 08, 2020 at 09:35:45AM +0200, Leon Romanovsky wrote:
> @@ -336,19 +335,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
>  		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
>  		user_entry_size);
>  	if (max_entries <= 0)
> -		return -EINVAL;
> +		return max_entries ?: -EINVAL;
>  
>  	ucontext = ib_uverbs_get_ucontext(attrs);
>  	if (IS_ERR(ucontext))
>  		return PTR_ERR(ucontext);
>  	ib_dev = ucontext->device;
>  
> -	if (check_mul_overflow(max_entries, sizeof(*entries), &num_bytes))
> -		return -EINVAL;
> -
> -	entries = uverbs_zalloc(attrs, num_bytes);
> -	if (!entries)
> -		return -ENOMEM;
> +	entries = uverbs_kcalloc(attrs, max_entries, sizeof(*entries));
> +	if (IS_ERR(entries))
> +		return PTR_ERR(entries);

This isn't right.  The uverbs_kcalloc() should match every other
kcalloc() function and return NULL on error.  This actually buggy
because it returns both is error pointers and NULL so it will lead to
a NULL dereference.

Btw, when a function returns both error pointers and NULL the NULL
return means that the feature has been deliberately disabled.  It's not
an error pointer because it's deliberate.

regards,
dan carpenter

>  
>  	num_entries = rdma_query_gid_table(ib_dev, entries, max_entries);
>  	if (num_entries < 0)
> diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
> index bf167ef6c688..39ef204753ec 100644
> --- a/include/rdma/uverbs_ioctl.h
> +++ b/include/rdma/uverbs_ioctl.h
> @@ -865,6 +865,16 @@ static inline __malloc void *uverbs_zalloc(struct uverbs_attr_bundle *bundle,
>  {
>  	return _uverbs_alloc(bundle, size, GFP_KERNEL | __GFP_ZERO);
>  }
> +
> +static inline __malloc void *uverbs_kcalloc(struct uverbs_attr_bundle *bundle,
> +					    size_t n, size_t size)
> +{
> +	size_t bytes;
> +
> +	if (unlikely(check_mul_overflow(n, size, &bytes)))
> +		return ERR_PTR(-EOVERFLOW);
> +	return uverbs_zalloc(bundle, bytes);
> +}
>  int _uverbs_get_const(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
>  		      size_t idx, s64 lower_bound, u64 upper_bound,
>  		      s64 *def_val);
> -- 
> 2.28.0
