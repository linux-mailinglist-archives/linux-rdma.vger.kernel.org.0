Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83325B51B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIBULF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 16:11:05 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:38981 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBULF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 16:11:05 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4ffc560000>; Thu, 03 Sep 2020 04:11:02 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 13:11:02 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 02 Sep 2020 13:11:02 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 20:11:02 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 20:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjDFP4xxWIrz1L6hySpPEy2O9JpRa+yNlgIZgg94FkRLbZmfMxvnlm0ABUCqbjocj7T7ek2eWcw3oteFFbWJy4cWKX3sWQFQWtBv684nSseeIERkgTkTUqmg/7q13H5sF0KZLrVhj+pPWdFDodMi+S1xXcLQaNuqAb4XKPPC/87Zs0dPSroSVuIhNY5pzqfQk0r+EenlBwdLnplH6GxWGhcdKjoRrsOtdi8VaXcgtQ50nwwTtbMTnlOfNsbFBoSiQhbfDtvEm5wCe7lM4htzgXhbZo0kMpTAX8Qp5LZPT/P+wZFnpGNGVMEQJ9N0bmijNTKSACs2mw0y+Lmsj9rbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKs55Sot9O0AylENLtAiaw+A1h+EzTQ50JTTj3cZ+yk=;
 b=DCUR/MHJeR3UmC7Zxaqf8Yi3XsmUVhjUNcRB2lLDN+dp65da1DBsZibJb0B7JScUgQ6nxbnRV2S1u3xW1EqmPJOhnY/pAFDY9uwm+Buk3zlCRxFH7V6G0R7j27VO79AfMEQ4wOz64kKYzFSCFLTBNT7TErAJWhWFtnQoUGKb0r2rX4AsFBfpQy9Z7fZKFeo3jGK4Txytm7K0H369tUuRargIalh9pRJV6LTj/Xj5pTtZpr17CQSZEA6xau7y7ojyVAiN9LR9WojGJmT0zTCYaOG5jec/vcLoytNn4GlC2aEDcS6AJ5zAQdpmQz1fjDdBVYCFUCUEzbehFa3x7aqUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 20:10:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 20:10:59 +0000
Date:   Wed, 2 Sep 2020 17:10:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Fix resource leak on error path
Message-ID: <20200902201057.GA1463739@nvidia.com>
References: <20200902162454.332828-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902162454.332828-1-alex.dewar90@gmail.com>
X-ClientProxiedBy: MN2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:208:178::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0007.namprd19.prod.outlook.com (2603:10b6:208:178::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 20:10:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDZ5t-0068oK-SO; Wed, 02 Sep 2020 17:10:57 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e160460e-7d9c-4a30-5edc-08d84f7c4ee4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487349B297997CED337266EC22F0@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cI00yNDzmFFc+rSdTxmgyCeBxYkjZdobUasUVtWNdCxX9FfrYFlmr9AB0HSG1bPvb0ZysK8Bde8+LzcCPUzMPrbRYx2ysJNgzg5RyRR8A4gkBP9NnEWkIe6Szzo41cK70dfIr16aMJLk3wthXbQ/EgYX11U46baCJT7CD5LsygZer8fx8Gp5Qxa9c6gtzcchA+uYgaJmbjYMJm//dmIQXcTfvezOT9pQBXxB3K3XV74Ra91mpi7cdlFjUoc24b9IjT8wv80sRJ4oXWCaUQkFoNSk943pHRVvGDyLDjVNGZ6f67mjFFd1osgw8eWTydkU6hm0+0MYjIAi3bM6aQrqVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(136003)(376002)(346002)(396003)(8676002)(26005)(4326008)(8936002)(66476007)(36756003)(86362001)(186003)(6916009)(5660300002)(66946007)(66556008)(2616005)(2906002)(426003)(1076003)(4744005)(9746002)(478600001)(54906003)(33656002)(316002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: l7wmirzo7IEjEYCFJZmWuWrpGa1QV5WRnNXyUEEZRSQZSIVhW1ZoOkRy7QlbatFtwOtzWz1tlrR/yxXFQHAJvTnHT977p/KVHdp/AvQq+08sbfn4nZGMe7DQOCNSaWmvmIC9sWMHnTxqWclk9YtPHCWn6O6eRdLH4Dka93KzvW4+fZZA7c1Qc+VsP/HztVEqW+8Eg98sSwiEzdaFG+w5fWlCOLvIjDT9z1kIzNkDMqeYu1hrOn7bL2Nrg9Qdx6vuGbhovsRI7E2y/Gxni/9BPp6GbZpGbdidIVMiFtPHHZFaKknNNQGPDxSR0Ni1RkTqBLmppNWDbz3uT2RwT5nWdLi+PMokxk16LtCXT6rkYjZfCIQ684KDZpKxv41iEUbVhO0/WPdLQGQ9SjkOyDejmIP0cs9I5WfGydVeyiesqrL425Ku710n1ATxy8A0hd9Ky3nL/5YIxF7JIFO4FgXeC+rA8+Xd/xLNmuaX8pLkcVPWN0kWm6Lz/JKDVmzhjJ1Ol3Wm4AwZBNbUTT7c4LDcFLgrh8Q1l41KEPK2a/ltoAi9Xh2WOaMfJd6oNRwPi4GsmWWubseMgUYhumCFkEKv6rOEp7oy6AEbs1eOvFB0YqdGXgHQDiP1cuutIRRiaeciAcX7f1P9fjDehfMGLXBVfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e160460e-7d9c-4a30-5edc-08d84f7c4ee4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 20:10:59.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9hIavSAYsExTSioAoxwPtIBqe7TPJhysRiML3Z+fnzYiLJPKXYE5tBqNgUQn3Kn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599077462; bh=VKs55Sot9O0AylENLtAiaw+A1h+EzTQ50JTTj3cZ+yk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=NKMT9DVjkmj+yfXFYObXfASrhLaxkddmw2gU3Mr54YluLzOAfT19Vff1M67/p6IvT
         AVuygsE5V5OZWJE28XnxfoHPLaOIhU6dRkelkFD/cRI/mBsxvmUoVUFkHFKFWS35KS
         610MitM45zGA4hVhZhEQ/vIgP6N0RlOFNN1cY2Ipt/hZsAn4qO3NwgNe0Cdo7hLuB8
         QINIWWOgy3LZLANZdqrq/m7JA2LlMhkE15fgjQl4sbc0CZY75U9t5s6PrvVtxVS53c
         /fGxWi8x8sM4KxdpbwZVaNIx3VAcjx2IgEyPdxwYyDHjks6PpEcNtrLlRisFsW75QZ
         YlBX21p/Ies0w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 05:24:51PM +0100, Alex Dewar wrote:
> In ucma_process_join(), if the call to xa_alloc() fails, the function
> will return without freeing mc. Fix this by jumping to the correct line.
> 
> In the process I renamed the jump labels to something more memorable for
> extra clarity.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: 95fe51096b7a ("RDMA/ucma: Remove mc_list and rely on xarray")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Applied to for-next, thanks

Jason
