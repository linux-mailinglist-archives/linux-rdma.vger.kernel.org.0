Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3B2528CA
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHZIEt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 04:04:49 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:5012 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZIEt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Aug 2020 04:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598429089; x=1629965089;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hLrR7ty8/ugv47/RBwbAtLa9geA6CkknX6C8ibIcXSw=;
  b=bdJSVdxV9cmfv3NQIhYPMp8KR84f4d/Hy15KwIlHU/q6EfOrSJkgyiRj
   hqnp+CAvNWKL66DtG00NQOiHiz1O0AfGYWEldeveUHFJk3w+O/Bo8OJry
   ROmgJHGVpmD0ytU2S7VAHjh6V+nq10Ypw5Ep/oQLIegfuchayOnCoWFY3
   Y=;
X-IronPort-AV: E=Sophos;i="5.76,354,1592870400"; 
   d="scan'208";a="50060815"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 26 Aug 2020 08:04:47 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id AE15C1A4C75;
        Wed, 26 Aug 2020 08:04:34 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.192) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 26 Aug 2020 08:04:30 +0000
Subject: Re: [PATCH rdma-next 10/14] RDMA/restrack: Store all special QPs in
 restrack DB
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>
References: <20200824104415.1090901-1-leon@kernel.org>
 <20200824104415.1090901-11-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <6de2c8a5-3608-29a2-ecc3-41cafb2ed0a7@amazon.com>
Date:   Wed, 26 Aug 2020 11:04:25 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824104415.1090901-11-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D25UWB003.ant.amazon.com (10.43.161.33) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 24/08/2020 13:44, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index e84b0fedaacb..7c4752c47f80 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -347,6 +347,8 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
>  	qp->srq = attr->srq;
>  	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
>  	qp->event_handler = attr->event_handler;
> +	qp->qp_type = attr->qp_type;

Already assigned above.

> +	qp->port = attr->port_num;

If the assignment is moved here then it can be removed from ib_create_qp which
was added in the first patch.
Also, in the first patch it's surrounded by an if.
