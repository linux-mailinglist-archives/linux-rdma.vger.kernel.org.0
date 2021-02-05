Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0D0311509
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 23:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhBEWWv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 17:22:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19308 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBEO1B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 09:27:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d6cae0002>; Fri, 05 Feb 2021 08:05:02 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 16:05:02 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 16:04:55 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 16:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6tE4CyaPOw2ZRvQ7f1sEpIWGtlzOS76n9OJRFHhV/o7gAMjkfd54f/ZH9icXHr+rMnpskfceCu/La2TseEEfknbeYBpEOt6nX42Fg3PbJrkB/qyE6c55oDbiJJZuxHDlXi1RPWbcwEUUp0PiqrGmEvnmgQ7kPHXs+zrZpRMp7yuuwO4xH4lUVzxELktdGTl0389ff5U/dBAKZa80kwihCW8JVYs6yPHZnCqbx09FnyGklHpStFyQrNEUX+O8ATsUpjEyF1CqdXb380qS+Y33YudGj+zQVptLAf0cM7wpyq9PIw4Rvc79rKXYuEkUtHV+Q3qacgUZrd0COSpocQFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PDSvB7z9BL0gulScw+ZfkqlmXcUyUKCJGStauOfL04=;
 b=XAnTyGLGEvewHsssGrUaWwBghfOZDTfkbicz+Fk8S4W5f8LkO/S3Cy4+FJXobZrEUIXKgAk+8dPbaOXkrj2oZdpZkmKs/a2pawJsLpKIquFiWcwSop4RQBB6balxGeV9zefwfC41Z+6cnTa1myCRH/heSPUW3r0DnnnmqyGBPl+ba6TQKKTz0uGtHjyFLnqW2ghWHJJqTUZGeSpIgF4rhG1QPUNShOr6cBJtuNS1V60t4bZwCtutk7GqWKg3bOVQrabi3Rj3+KkqiE1u7PkC/3Q+k+IXIYR8amEMuE9mjz7zAAowz2QCs6Z6K71s/H9Xs16hqFe7dgbbfyFnxWS9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Fri, 5 Feb
 2021 16:04:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 16:04:49 +0000
Date:   Fri, 5 Feb 2021 12:04:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <aditr@vmware.com>, <pv-drivers@vmware.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next] RDMA/pvrdma: Replace spin_lock_irqsave with
 spin_lock in hard IRQ
Message-ID: <20210205160448.GA927886@nvidia.com>
References: <1612514278-49220-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612514278-49220-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0500.namprd13.prod.outlook.com
 (2603:10b6:208:2c7::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0500.namprd13.prod.outlook.com (2603:10b6:208:2c7::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Fri, 5 Feb 2021 16:04:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l83bE-003tPF-8V; Fri, 05 Feb 2021 12:04:48 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612541103; bh=8PDSvB7z9BL0gulScw+ZfkqlmXcUyUKCJGStauOfL04=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=YCep0elOPXpDQkK6d3n9IRTHy/tnRvhSbO/3yBuK0A6dcbvSVdTl55G0fcw4d/5RH
         h4LN8NXL7XMR+RuDfSSMdyrwV+TDfZyX+l1rFInUM5MpTR69W2DmS54xjZa39/lbI+
         o/Od+HuoBrn1upYLKzf8y1Jt/HNfHAsgg+UVQX+4lYlV3Tfl2fM6/caHPk+VvqvKLn
         ZqHdfaBPbLyJTo/zYeB0LdsM43oqgn6Iv3/wdYxkGKdacmL3lXHYnRxYyeN9oKAW3N
         AlUwToTQd7l/Nd0mWYUuC2Q0oHmIoQXpB8h+hnQByDQ+DBDub2ar+otEusbe1h5M8R
         uDns5d7vufQlg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 04:37:58PM +0800, Weihang Li wrote:
> There is no need to do irqsave and irqrestore in context of hard IRQ.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
