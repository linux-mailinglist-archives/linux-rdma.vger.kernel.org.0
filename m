Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DD92B5327
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgKPUqg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:46:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17553 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgKPUqg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:46:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2e5230000>; Mon, 16 Nov 2020 12:46:27 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:46:36 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOd6zUt+nTKJM+gsV29kpgq07EZlDFoXYAXRlTaMfzXReUyRRcn4snCkzXon01yTJjBpZ7RFbrGl6AkwfEXti9uqgqeCEI4lUE2beLHCERehXBsRHM04J3PB8CmQBYd3Lkick1cEo/hUEle8Nld48NRqy55DmVlXkKSJznlG3uZ0IDEreljm4cLz4i8H+Cv9A8EPk1VnQrJiz9VKnp+GKyKKYY2LsbOYJIdfdT7LCDdiqjF9BmDWoCfbT4BOafmLhBP0+FHJw0Y8ZAI0rePbDDQkD4cCGLP2FO2TSbTbJO4XQsE/a3FNznnpyXgHYsdwIiaLTJVIsOUY2lGFuaY0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eisnhHm7usicaBKKlTD7B3cslLeK0ZO1XTmeAj9FZvA=;
 b=CvT8r7L4GkLaIV2CPEZevekesjJ7FLtHgk4/yQ0s+0Ln9ObTMMaaJCbAhq7rCsPunlAJZwngY0ORY5RB9REpRFB6cxQQlsb0HHaF3YlZRqBwoooAHTz3EZgWBYXaPzHNlUJvkKcKi9rVm6+mDYBs7X5KkLkUrcy9519KUNQUctx+RRLtVua7UqGuA6zzu2lXot6l7Njm98Wt4y9GG0I2sKGJh3eRJvVH4EmKJgcQiE1VNk2Q7jEwyrpaI9rCMPllOs49U0KqZ0kv3xziz61mz+Gxz72eHrHKW+4QnUPPLYQi64js/OmL48GEGMLzpKDsnMqUDT+wLaGuOa0sR2Qcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:46:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:46:34 +0000
Date:   Mon, 16 Nov 2020 16:46:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Message-ID: <20201116204633.GQ917484@nvidia.com>
References: <20200218210432.GA31966@ziepe.ca>
 <20200219060701.GG1075@sol.localdomain> <20200219202221.GN23930@mellanox.com>
 <20200307204153.GJ15444@sol.localdomain>
 <20200309193012.GA13183@mellanox.com> <20200627225734.GL7065@sol.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200627225734.GL7065@sol.localdomain>
X-ClientProxiedBy: MN2PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:208:19b::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0044.namprd19.prod.outlook.com (2603:10b6:208:19b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 20:46:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kelOT-006ldz-FW; Mon, 16 Nov 2020 16:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605559587; bh=eisnhHm7usicaBKKlTD7B3cslLeK0ZO1XTmeAj9FZvA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=pef4lciXgMgR3QGzrWpgaMJb0lGM1AfsKvIWzayBblHkUNt9M+uIQNlb3+WhsQS6H
         yr5aAIs87aoBXkNsRU7I6Y2SMkmIuABUqN1WaDObzqpVGxvJVHed+brVYWdp4gFFOf
         geUvegThcZ4vPRUiH7oPDdih5wHE/XgYdl5bHZqgXzwUQc9fZ50QETQnJhQhLpWL/g
         7csvMzLp6166C6gurKqEQg/8FV+VFDzvCGfNjovxatKKLtNRiT9lkQfa3lYVnDBqQu
         QU834t3PbDAMTY/1fLL0QtcT1i/D1zdJq2AKoBtM3TUJ59Beq27+ZJA1wZ3RIgXshX
         SwLmqsW1wW4ZQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 27, 2020 at 03:57:34PM -0700, Eric Biggers wrote:

> Hi Jason, here's my latest list (updated today) of bugs that are probably in
> drivers/infiniband/:

I'm going to apply this patch and I think it will clean out a bunch of
the non-reproducer syzkaller bugs related to sysfs:

https://patchwork.kernel.org/project/linux-rdma/patch/0-v1-dcbfc68c4b4a+d6-virtual_dev_jgg@nvidia.com/

But I have no idea how to tell if it fixes it or not??

Any advice on how best to use syzbot here?

Thanks,
Jason
