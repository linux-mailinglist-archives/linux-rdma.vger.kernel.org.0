Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974102251F1
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgGSNVS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 09:21:18 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52169 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSNVS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Jul 2020 09:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595164877; x=1626700877;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mx8Ik9v5OQBys3bgKqs2xs3STlCJajw34YMwQlsq0M8=;
  b=AN5MTwX1PVqh4IXG8FWz/yfzrWSJ+P8E4OtPnZdlVH7BpaNcD9GYZVZG
   7IDojrthPFHQ4nr5UautQTNhpoXjLuvS9YmCqYiu5CfSgAqNlqZUemhak
   LnwlDrZfOlX2QQUgq01hsHZmYC4+UP85ih6tjRXq4V+bCJWHXSpXY0AUS
   A=;
IronPort-SDR: gRg+da42zwcI015BxrsL5VibueuhH12LYJT8EJrmN4sZFJsoX6WSO7uCAN6FBOUxAJtMLoO6Kw
 7rfQoJ3uc5pw==
X-IronPort-AV: E=Sophos;i="5.75,370,1589241600"; 
   d="scan'208";a="42592960"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 19 Jul 2020 13:21:16 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id BBA84A364D;
        Sun, 19 Jul 2020 13:21:14 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 19 Jul 2020 13:21:13 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.156) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 19 Jul 2020 13:21:09 +0000
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Remove redundant assignments
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        kernel test robot <lkp@intel.com>,
        <linux-rdma@vger.kernel.org>
References: <20200719060319.77603-1-leon@kernel.org>
 <20200719060319.77603-2-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ea42d404-45eb-ec83-b42a-4a3acf659d26@amazon.com>
Date:   Sun, 19 Jul 2020 16:21:04 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200719060319.77603-2-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.156]
X-ClientProxiedBy: EX13D27UWB002.ant.amazon.com (10.43.161.167) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/07/2020 9:03, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The kbuild reported the following warning, so clean whole uverbs_cmd.c file.
> 
>    drivers/infiniband/core/uverbs_cmd.c:1066:6: warning: Variable 'ret'
> is reassigned a value before the old one has
> been used. [redundantAssignment]
>     ret = uverbs_request(attrs, &cmd, sizeof(cmd));
>         ^
>    drivers/infiniband/core/uverbs_cmd.c:1064:0: note: Variable 'ret' is
> reassigned a value before the old one has been
> used.
>     int    ret = -EINVAL;
>    ^
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index a66fc3e37a74..7d2b4258f573 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -558,9 +558,9 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
>  	struct ib_uverbs_open_xrcd	cmd;
>  	struct ib_uxrcd_object         *obj;
>  	struct ib_xrcd                 *xrcd = NULL;
> -	struct fd			f = {NULL, 0};
> +	struct fd f = {};
>  	struct inode                   *inode = NULL;
> -	int				ret = 0;
> +	int ret;
>  	int				new_xrcd = 0;
>  	struct ib_device *ib_dev;

I don't mind removing the whitespace, but changing it for just some of the
variables makes it harder to read the code IMO.
