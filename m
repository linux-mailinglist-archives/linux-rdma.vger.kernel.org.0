Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC552FC582
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 01:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhATAQO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 19:16:14 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5370 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbhATAQL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 19:16:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600776210000>; Tue, 19 Jan 2021 16:15:29 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 00:15:29 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 00:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0MgQNcZpJZ/OEwmAO27BvqpTAxqtz+obEEDALDyq2OWpnyDKnUKiKhlcM5/+QW8ro5e5/fedoGyyHik1kYZuUqsdMpA0LcBhdpDQb4XRKim9m1dl4B0FNKnYbHKVEMs2a89fiqsTjSPYF6GeI0PRwWXgEDUGjBLrOt7f0bZGGrjstbEGbLA45+GT9msxoC1kuv6Yxy+V46hQEaxovVv7sZOLZEnVwqy3hlm4yfkF9X5abU0iagHo8pBQM8vzL29HEeVXmUm137uG00MqxaX/wdtBMNm5kY++2WbHdPL3wf10T/xnzZiGtSrN6w2y7fbs0TxVFVA9Ov06gbZTevp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LrZvW1QGcnRTa+vw/b+U++eWX7OSfi0z0SNsSIyHlc=;
 b=WKX84+6MpcjRLHvqpekvblTSkaXVz4ZA/S9g2QxFsxaMRC/VTGC/4yhvQFTWAwIbzzrEQEcR7nQ+AJp3aP+9Uh+9gWAG9bSYC/VscKjs+DHzS/5x9iFS+ArWTxLb1yU6phgs93AF3bGrP1mgZTCGT7SRkXL4fpIJgNNE2QtAp/J6Pp9ks3ZHS8mq0Dz+jc8JnzxhSaPToZW0jBYLhuTo3Ker3jxDC2OYgJuFQ8QPL9RtplUjN3us202gIZ4Py/eIfEexeYu2zLQhRwpBW6fu3EWV7yROUyMlSlp6o1CMJymBDcYFT5BFrVyFZrfcCvW4iIL0x976XbNARPkf1DNYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 00:15:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 00:15:28 +0000
Date:   Tue, 19 Jan 2021 20:15:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH rdma-next 0/5] Set of fixes
Message-ID: <20210120001526.GA948597@nvidia.com>
References: <20210113121703.559778-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210113121703.559778-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:207:3d::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0067.namprd02.prod.outlook.com (2603:10b6:207:3d::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Wed, 20 Jan 2021 00:15:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l219i-003ymj-RK; Tue, 19 Jan 2021 20:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611101729; bh=8LrZvW1QGcnRTa+vw/b+U++eWX7OSfi0z0SNsSIyHlc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=FGyz0eIKWp5fWCXd9teonIW2dHECSBxeDD5TOocbSwUOX2HlV9NCYDYfFqfDTsajo
         6KQD/c7i0i+MM07d70oQ58fqFTCgh6VKPKaGnx34Vu3eQf3g3PmuAISeR4FB3mG3JT
         CstUMjZ2NV6TLFdAl2TjJAwHVd8n6uV9h1/UE57XH+W+V8BIQcAytKqIVYH/YBJOa8
         w7p3h15MUOmPT3a+r19/7I0++qc+Ow+lw+wnU+uwoVe8vSAcAEZsCK6dMSfK7HGEpH
         C+tzz7+OUZ8VxwxShL4cLeP9DQIGw9PcYy2dfCInsCcf5TExZsNfrExFchs7A3l5od
         ZoVwj50TJhslg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 13, 2021 at 02:16:58PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Small set of fixes for -next, only Aharon's fix has potential to be
> taken to the -rc.
> 
> Thanks
> 
>   IB/mlx5: Add mutex destroy call to cap_mask_mutex mutex
>   IB/mlx5: Make function static

These two applied to for-next, thanks

Jason
