Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C512528C5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHZIDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 04:03:35 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4107 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHZIDd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Aug 2020 04:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598429013; x=1629965013;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7QLvkIgpWyK+WPTBdmKXB+SIuV+jBSuSagDlNE7CqQ0=;
  b=llGpCGCRoXIMXD3T768eUHwoG9ZE7JH8Tdz7oY4+OcTz1dEvCsdyc9Md
   BHKNMv2MNT4G3yVBTjZLF4K47XWXYBH3BBWJqscVYgKdyU0Eq80T43t+p
   BIZegJNvegVN3H4OIf3dcDgu7MN/Au9cGBVEw7JNYKM9QDFfLnHkiLIQP
   k=;
X-IronPort-AV: E=Sophos;i="5.76,354,1592870400"; 
   d="scan'208";a="51497374"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 26 Aug 2020 08:03:30 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id DEB4FA22D6;
        Wed, 26 Aug 2020 08:03:28 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.192) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 26 Aug 2020 08:03:23 +0000
Subject: Re: [PATCH rdma-next 12/14] RDMA/restrack: Support all QP types
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
References: <20200824104415.1090901-1-leon@kernel.org>
 <20200824104415.1090901-13-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <14ac653e-fc64-589c-e202-09fba6b39020@amazon.com>
Date:   Wed, 26 Aug 2020 11:03:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824104415.1090901-13-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D25UWB001.ant.amazon.com (10.43.161.245) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 24/08/2020 13:44, Leon Romanovsky wrote:
>  /**
> - * ib_create_qp - Creates a kernel QP associated with the specified protection
> + * ib_create_named_qp - Creates a kernel QP associated with the specified protection
>   *   domain.
>   * @pd: The protection domain associated with the QP.
>   * @qp_init_attr: A list of initial attributes required to create the
> @@ -1204,8 +1204,9 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
>   *
>   * NOTE: for user qp use ib_create_qp_user with valid udata!
>   */
> -struct ib_qp *ib_create_qp(struct ib_pd *pd,
> -			   struct ib_qp_init_attr *qp_init_attr)
> +struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
> +				 struct ib_qp_init_attr *qp_init_attr,
> +				 const char *caller)

This function can be static.
Also, caller parameter missing from doc.

>  {
>  	struct ib_device *device = pd ? pd->device : qp_init_attr->xrcd->device;
>  	struct ib_qp *qp;
> @@ -1230,7 +1231,7 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
>  	if (qp_init_attr->cap.max_rdma_ctxs)
>  		rdma_rw_init_qp(device, qp_init_attr);
>  
> -	qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL);
> +	qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL, caller);
>  	if (IS_ERR(qp))
>  		return qp;
>  
> @@ -1299,7 +1300,7 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
>  	return ERR_PTR(ret);
>  
>  }
> -EXPORT_SYMBOL(ib_create_qp);
> +EXPORT_SYMBOL(ib_create_named_qp);

Shouldn't ib_create_qp be exported instead?
