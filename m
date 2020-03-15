Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2D185B15
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2020 08:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCOHoQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Mar 2020 03:44:16 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:19120 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgCOHoQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Mar 2020 03:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584258257; x=1615794257;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ofS9bQN8Iu/E5SS5UkatGfGBHg6wnVHxYnm1uWoXAgk=;
  b=kqJOSiIrpxWwghnhcHV3583OEzt6MDJQxsGtSemtwMMN/uAXe63J4A7w
   j4H5B1xQabOxn2Qlx30ft8mfF3QbILLeXxOtXiU4MBKByZvJ/UF7II0oq
   QeSFzPrElOlfJFn3jtf83o5+dIBxrJzBOy3LUq2aUZLJAte8kX8iDg3IX
   4=;
IronPort-SDR: nElnmPYoWb0cnoZCzmhFY8vYaA1X9zSHzfVAt26jo0DycRCdPOugt2Evxwaoa35zc+5x9ljgVd
 JvO0eMC6Fa9g==
X-IronPort-AV: E=Sophos;i="5.70,555,1574121600"; 
   d="scan'208";a="31228534"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 15 Mar 2020 07:44:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 652F2A2797;
        Sun, 15 Mar 2020 07:44:13 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 15 Mar 2020 07:44:13 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.16) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 15 Mar 2020 07:44:09 +0000
Subject: Re: [PATCH rdma-next v1 03/11] RDMA/efa: Use in-kernel offsetofend()
 to check field availability
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-4-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a1635b7d-004c-5721-a884-e11b3870928d@amazon.com>
Date:   Sun, 15 Mar 2020 09:44:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310091438.248429-4-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D31UWA004.ant.amazon.com (10.43.160.217) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/03/2020 11:14, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Remove custom and duplicated variant of offsetofend().
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index bf3120f140f7..5c57098a4aee 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -144,9 +144,6 @@ static inline bool is_rdma_read_cap(struct efa_dev *dev)
>         return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
>  }
> 
> -#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
> -                                sizeof_field(typeof(x), fld) <= (sz))

I would use offsetofend here and keep the field_avail naming for readability
sake of the using functions, but I guess that's fine as well.

Thanks Leon,
Acked-by: Gal Pressman <galpress@amazon.com>

> -
>  #define is_reserved_cleared(reserved) \
>         !memchr_inv(reserved, 0, sizeof(reserved))
> 
> @@ -609,7 +606,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>         if (err)
>                 goto err_out;
> 
> -       if (!field_avail(cmd, driver_qp_type, udata->inlen)) {
> +       if (offsetofend(typeof(cmd), driver_qp_type) > udata->inlen) {
>                 ibdev_dbg(&dev->ibdev,
>                           "Incompatible ABI params, no input udata\n");
>                 err = -EINVAL;
> @@ -896,7 +893,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>                 goto err_out;
>         }
> 
> -       if (!field_avail(cmd, num_sub_cqs, udata->inlen)) {
> +       if (offsetofend(typeof(cmd), num_sub_cqs) > udata->inlen) {
>                 ibdev_dbg(ibdev,
>                           "Incompatible ABI params, no input udata\n");
>                 err = -EINVAL;
> --
> 2.24.1
> 

