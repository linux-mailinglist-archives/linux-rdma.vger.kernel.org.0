Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9698514863
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfEFKfW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 06:35:22 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:18214 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFKfW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 06:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557138921; x=1588674921;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZYH2vrDzTF9oDgcS1iKeZOV80kPjv5cYq4sjmNyFptw=;
  b=NtSNefWSYcN4K/mwHzXN3U+mcy4KxaKqN44FIZgrgeSuc3FkWi9js+fp
   Z56lPAGiVI5ZyOL0f+seQwuHNCifjFcs9YXvVVR9z/eSP1DLBpHzL2Mz1
   zFF+Dt7fAxEd1nvtJugPNmVh9asA27IeiLpllhjL47k9ePWNn7jU7urgK
   4=;
X-IronPort-AV: E=Sophos;i="5.60,437,1549929600"; 
   d="scan'208";a="803074908"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2019 10:35:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x46AZGa2122627
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 6 May 2019 10:35:16 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 May 2019 10:35:16 +0000
Received: from [10.218.62.23] (10.43.161.10) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 6 May
 2019 10:35:12 +0000
Subject: Re: [PATCH rdma-next] RDMA/ipoib: Allow user space differentiate
 between valid dev_port
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
References: <20190506102107.14817-1-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <4c4c560a-d3ec-4b32-203f-178bddde478d@amazon.com>
Date:   Mon, 6 May 2019 13:35:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506102107.14817-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.10]
X-ClientProxiedBy: EX13D22UWB004.ant.amazon.com (10.43.161.165) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 06-May-19 13:21, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Systemd triggers the following warning during IPoIB device load:
> 
>  mlx5_core 0000:00:0c.0 ib0: "systemd-udevd" wants to know my dev_id.
>         Should it look at dev_port instead?
>         See Documentation/ABI/testing/sysfs-class-net for more info.
> 
> This is caused due to user space attempt to differentiate old systems
> without dev_port and new systems with dev_port. In case dev_port will
> be zero, the systemd will try to read dev_id instead.
> 
> There is no need to print a warning in such case, because it is valid
> situation and it is needed to ensure systemd compatibility with old
> kernels.
> 
> Link: https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
> Cc: <stable@vger.kernel.org> # 4.19
> Fixes: f6350da41dc7 ("IB/ipoib: Log sysfs 'dev_id' accesses from userspace")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index 48eda16db1a7..34e6495aa8c5 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -2402,7 +2402,17 @@ static ssize_t dev_id_show(struct device *dev,
>  {
>  	struct net_device *ndev = to_net_dev(dev);
>  
> -	if (ndev->dev_id == ndev->dev_port)
> +	/*
> +	 * ndev->dev_port will be equal to 0 in old kernel prior to commit
> +	 * 9b8b2a323008 ("IB/ipoib: Use dev_port to expose network interface port numbers")
> +	 * Zero was chosen as special case for user space applications to fallback
> +	 * and query dev_id to check if it has different value or not.
> +	 *
> +	 * Don't pring warning in such scenario.

"pring" -> "print".

> +	 *
> +	 * https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
> +	 */
> +	if (ndev->dev_port && ndev->dev_id == ndev->dev_port)
>  		netdev_info_once(ndev,
>  			"\"%s\" wants to know my dev_id. Should it look at dev_port instead? See Documentation/ABI/testing/sysfs-class-net for more info.\n",
>  			current->comm);
> 

