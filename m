Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A808184A8B
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfHGLXQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 07:23:16 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:9320 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfHGLXP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 07:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1565176995; x=1596712995;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DUJrwV2/HRKwHvABiPUOhZMrWnMHQlvXmR6sksm98mg=;
  b=obahbiqavRwpWqJGMyd5qxiPz/QLhMc+ybOP05bDNmsuLAiu3EwYd3eI
   bYVi3ysrs/Xk5gtHiLgY+0+VgXirBFyYEwsQRT0AI82hm0nW0eEFUJvgR
   YM8FBCFUS70javmMqYflDl9dshpbeTJKX7KVRmHKVffPriEZ30L1/hUVt
   k=;
X-IronPort-AV: E=Sophos;i="5.64,357,1559520000"; 
   d="scan'208";a="817547327"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 07 Aug 2019 11:23:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id DBF95A2862;
        Wed,  7 Aug 2019 11:23:12 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 7 Aug 2019 11:23:12 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.20) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 7 Aug 2019 11:23:08 +0000
Subject: Re: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
References: <20190807103403.8102-1-leon@kernel.org>
 <20190807103403.8102-3-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <20441b80-b901-9e42-90e0-f1cf17ac6d5b@amazon.com>
Date:   Wed, 7 Aug 2019 14:23:03 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807103403.8102-3-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.20]
X-ClientProxiedBy: EX13D03UWC004.ant.amazon.com (10.43.162.49) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07/08/2019 13:33, Leon Romanovsky wrote:
> +static inline void ib_umem_odp_set_type(struct ib_umem_odp *umem_odp,
> +					unsigned long start, size_t end)

Consider renaming 'end' to 'size'?

> +{
> +	if (!start && !end)

According to the man pages, To create an implicit ODP MR, IBV_ACCESS_ON_DEMAND
should be set, addr should be 0 and length should be SIZE_MAX.
Why check end against zero?

> +		umem_odp->type = IB_ODP_TYPE_IMPLICIT;
> +	else
> +		umem_odp->type = IB_ODP_TYPE_EXPLICIT;
> +}
> +
>  /*
>   * The lower 2 bits of the DMA address signal the R/W permissions for
>   * the entry. To upgrade the permissions, provide the appropriate
