Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72502B9640
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Nov 2020 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKSPbB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 10:31:01 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:2640 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgKSPbA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Nov 2020 10:31:00 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb68fb20000>; Thu, 19 Nov 2020 23:30:58 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 15:30:54 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 19 Nov 2020 15:30:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3w1B5NqvLpnc7pOAIhdqWs9psiOf15COXaMj53eSVWKgFqKXaawJpjtRs8hFsEYeNdJbLYf2cqjnud5tJtPIEThsx8JD1kcMvrFghdVM0dRxd8KvNCRukN2E8YrFe+MTS8D/OsnwD/kfyVQufjanzJCSFegySvECGvGnBR57f6NpXUY7rklhIgD25sjB7d9DpIkJq9qZUC68nkH/nIvkZ8yFH17x9SsiFLPgqSqj4UBU0xmlBhABzE0J6RErds8thl8dqU7r8Qaks1zynx2vmX/TnbZIPzQdZZvqyg8rPxa5kH0XZ6/2a0P1iZ2RLMOcq7WCac47Wl72Beq7XBfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpxPmkk/QmdinUr1rcPJTGyxpgrcO/YAYQSLBpuzy/w=;
 b=ikA9SvEkkWdm09YvzIeWurDP5/1dKg0O8or8NHroQeMA7jLOoBOIq2hFXcL9iwL6BfXkAu6y9CYdJ5PQZSi7TRsjE5Xq1p3boU+sbw1YgZgL2ODhuCLS0lc/KlUDWwsQhcD11ICJQLZsXad6ipnq+aUp78UIK+2jHWPPcacw76Uk0lmWpX2cShF5ujVmQnGHgoHIFm/AZlLI0XmHk1dWJJlj3smWScK4hX6wkqmU+9nDsEUU4546jB5iWSRn8rFrytNxnnwx+ecAP5bnUD+ami5WirjoZv50OZroFZqFVNYzF/7grgjcokxrSqtRVHbtzcyV76/amF4mCSUy6BvObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 15:30:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 15:30:52 +0000
Date:   Thu, 19 Nov 2020 11:30:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mthca: fix return value of error branch in
 mthca_init_cq()
Message-ID: <20201119153050.GA1960484@nvidia.com>
References: <1605789529-54808-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1605789529-54808-1-git-send-email-wangxiongfeng2@huawei.com>
X-ClientProxiedBy: MN2PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:208:19b::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0041.namprd19.prod.outlook.com (2603:10b6:208:19b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 15:30:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kflta-008FIr-Li; Thu, 19 Nov 2020 11:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605799858; bh=bpxPmkk/QmdinUr1rcPJTGyxpgrcO/YAYQSLBpuzy/w=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=W66E96HYcoSD9CRgtSphzl4ESm2g2Y1RCkXtri18TT7OOktIXiwtShnACTzOTdHAy
         ULSmbTkiIyqWb+oZPG64GMRBk95xGQ7M24ELbSr63RHQmGblERL+BiqFV81x8neYQG
         F1OvZhfJrR2HzRVPxX0wE+y13kfiPoy/jMq3C2Hc7lkNJDpJAKfr1wpC82NKOj007b
         SrF4i0norNOmQR1Z5rH5eCvU4zZywZgTYD8MQW/abNwT/EuW5VfkvEFGOm1S+wNMgd
         /C13bUPFCsW+MhMVyRYKty8BlgpZftqMvGFoqSVn011O24U+hnczACzRa0o/DZintv
         CmGuFFkkS/fjA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 19, 2020 at 08:38:49PM +0800, Xiongfeng Wang wrote:
> We return 'err' in the error branch, but this variable may be set as
> zero by the above code. Fix it by setting 'err'  as a negative value
> before we goto the error label.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Missing fixes line

>  drivers/infiniband/hw/mthca/mthca_cq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
> index c3cfea2..98d697b 100644
> --- a/drivers/infiniband/hw/mthca/mthca_cq.c
> +++ b/drivers/infiniband/hw/mthca/mthca_cq.c
> @@ -803,8 +803,10 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
>  	}
>  
>  	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
> -	if (IS_ERR(mailbox))
> +	if (IS_ERR(mailbox)) {
> +		err = -ENOMEM;
>  		goto err_out_arm;
> +	}

mthca_alloc_mailbox returns err_ptr so this should do 

   err = ERR_PTR(mailbox)

>  	cq_context = mailbox->buf;
>  
> @@ -850,6 +852,7 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
>  			    cq->cqn & (dev->limits.num_cqs - 1),
>  			    cq)) {
>  		spin_unlock_irq(&dev->cq_table.lock);
> +		err = -ENOMEM;

And this should assign err to the output of mthca_array_set

Please fix and resend.

Thanks,
Jason
