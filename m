Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01CC248BBE
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHRQe0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 12:34:26 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6747 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgHRQeK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 12:34:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c02c80002>; Tue, 18 Aug 2020 09:33:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 09:34:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 09:34:10 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 16:34:05 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.52) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 16:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfH3OIe2gyq96iW223RMU7oHEnkTzYHdFu+Wnrn+LbVu4rXmXNwn4i/jRDAoUghzxHJJkBTw3VOrK7Ue2vF+hKPDPi8HrRIBQgaA2Pe8tWQRBS5bJDc7BIqxfmyekcCkuYxoDf1jtbuxmHxXP4d3PINO1u/vmoSX0Vs/FF1KAOsxHPYN7UiiSESGKv76WCX0U09iKAwrVZo65UEAuwJNQRxCmpx3g8wwI76Dbtf6RCAGsuaVIlSs8YtVpbG0OTv7jzTj5PBJ/j8G9Uj89UUg2zRGZKRcKn3c/04GvqC5lz/dxq5uXcGor/aNvAlcGA7AhkWtvAt0nVC0rgg7WsEgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmMPqUUMKX3ClgqYQmDkylLAAJLE0SZseV9ZMyC1hBQ=;
 b=oGpS/zOsPZKVKdW69iRTAWZ1sG0BB0znNrfFEMPl/GLoG/8X5Ffy1PxmyIfix1MS0JyhaKMUh2UEk5nK/GqSYFJ0I7G0cSPM+lGXHarde2gW5ouhEvQY8COY4/SYI9EKI6PDJXEUsZCOsKp09FU49SsN3Urtu3u94dzxxESU3fWSZPHLG/VitM+Bj2BHXMXXB40DGlUqY0zUvnHWTnj4BeCy/EBMOUhFf5Fl2ZuvPkqfFVL2nAJ/gtYxpfDo0Ax6vMJa4+zvnlnEszBj4wQ6ebRIndi0ix5FohVFKoid3LGdH7CzV+hRb8QV3Cnjt/esZ42jUBnWL8MQMNqAdbYvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 16:34:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 16:34:04 +0000
Date:   Tue, 18 Aug 2020 13:34:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/hfi1: Correct an interlock issue for TID RDMA
 WRITE request
Message-ID: <20200818163402.GD1990081@nvidia.com>
References: <20200811174931.191210.84093.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200811174931.191210.84093.stgit@awfm-01.aw.intel.com>
X-ClientProxiedBy: BL0PR01CA0010.prod.exchangelabs.com (2603:10b6:208:71::23)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0010.prod.exchangelabs.com (2603:10b6:208:71::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 16:34:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k84Yk-008Lju-M1; Tue, 18 Aug 2020 13:34:02 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9d3bb7-2f8a-4a3d-dd5a-08d843948525
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4356B64341215DAD867DDB9BC25C0@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7Dle9P4jyctzMNFB8kiJX3UBUgE4Ig6xtyw9I97a007MRBjpUTZ0y0KmOI5jCKeeZR1JGVsALsL2Zm4K2ohpyw+f/5KzLh5cE2DPoqqa2JXR4/O9pRlcsKuFIMYD275u+CJGiVZe9X3RZUIODMOUm7mVgvCkT2EhZ8/Ky+H65EGUJJUXNqAL3dpc6AI5pvJMA7skqUPYOv63QPpNgmsg7f3HDjPma903tRK5RAjb+Ar3/YpaYNRpPF0hpXcAo0IWOzG+IJA3LTmp6JApcyhcHxCB4wO8Ln6gwu3mmbZx4q7ZSu9L6N97Qc3Cl5gN9EsDSiJEwV5m7y5Kv/VJMeyeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(2906002)(86362001)(1076003)(186003)(66946007)(66556008)(8936002)(66476007)(316002)(8676002)(426003)(6916009)(478600001)(26005)(4326008)(9746002)(2616005)(83380400001)(36756003)(9786002)(5660300002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6Pfs72opaKJKb3/A3sNr8Nv/EHBJ47wTYqHIVIpANK3cZths33WL1lPnN8nTY5O5HpBEHDOSEmJYBuC3iepReA9Mj95CFrhKvgaDsjsCSmM5b4QRlB1K4Wug9UrkZ5QNsC0ZORpIAw93Tq1XCg9W6yBAoUU3AQxuav2AF14Wx1P3Q4Rl6QV+h96Fq/2HnSo9Q4f7uIkGCLEEisAvrfOGPPYtdPjQzAvuGmOMUSJdTzo/Vzzxdgt2clkcaC3CnDyuRy6H4v4KLYLUn536P15n3z+KmcPr6BJY/cXBQInJFMyp7NSUhi4NfZnbE5rnj4bnPwc8Zs3DuD7O5kSeRLgXlrTor9EWdIOuW+rqkPkKvNGFGf8nuieDTMiIHbcz9T7NmRe5liPs59OU4GXtASZT7bCSgk5TobMF71CJH8+SSliDt+ijVODngDkXiIY76zoTtEfKbSGUT15PtEcD7dTIrmhaiu+035Z5EMmElp6/1z0nZ8qQvpScVM4YF3JQF+rkbEDOzNultW1fQGRBxfeUUkmqznkzG73xXeLgiVBEP7t1v0eEbhDKtgBAEHvrL9g4ly3WZIJvzMChuFv/vrzrHroYjEDpnq6VpG6hwrqGWzENf/CIfXaqUs6LHHrqlxjgfPl2kLyswCqxhBO4Vu4mLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9d3bb7-2f8a-4a3d-dd5a-08d843948525
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 16:34:04.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiKKzKHopfBR00YvCOftJm1ty22JUkzt0RJd0Tai4D6g2CIoaLhlpoE5f0Ajcm7C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597768392; bh=vmMPqUUMKX3ClgqYQmDkylLAAJLE0SZseV9ZMyC1hBQ=;
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
        b=kr1W171LUWMtUaH3N/3KpyxsX9vyNeu4uR124hVRpJvjEhNia86hvTntyAERtWFCe
         +a/lcoPgmS10Qz4Aow1mRlzYv5k/SSTGpdn6IK+CRI2vDQ0GZfnxqyRm2FhzQa/I4v
         24TN3X1RvnXycmMVyuGeNHtt7cZuumOa6DUS73Rom4Fnbf2b5522x3ZKU92AveTRx+
         KA51oeGK6Idl2UDeCLzVyb2CecCHeDrNM/QMuaspoXQ9r6rgkDyCgg79xxY45fdxN0
         JHr1XIH+hagug3Mt8Shd7ipWvxv1NUK4sA/fl29T+/vXDSRbl7pQZwNeLF4xTY0ltZ
         PBfk+cCFjoESw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 01:49:31PM -0400, Mike Marciniszyn wrote:
> From: Kaike Wan <kaike.wan@intel.com>
> 
> The following message occurs when running an AI application
> with TID RDMA enabled:
> 
> hfi1 0000:7f:00.0: hfi1_0: [QP74] hfi1_tid_timeout 4084
> hfi1 0000:7f:00.0: hfi1_0: [QP70] hfi1_tid_timeout 4084
> 
> The issue happens when TID RDMA WRITE request is followed by an
> IB_WR_RDMA_WRITE_WITH_IMM request, the latter could be completed
> first on the responder side. As a result, no ACK packet for the
> latter could be sent because the TID RDMA WRITE request is still
> being processed on the responder side.
> 
> When the TID RDMA WRITE request is eventually completed, the requester
> will wait for the IB_WR_RDMA_WRITE_WITH_IMM request to be acknowledged.
> 
> If the next request is another TID RDMA WRITE request, no
> TID RDMA WRITE DATA packet could be sent because the preceding
> IB_WR_RDMA_WRITE_WITH_IMM request is not completed yet.
> 
> Consequently the IB_WR_RDMA_WRITE_WITH_IMM will be retried but
> it will be ignored on the responder side because the responder
> thinks it has already been completed. Eventually the retry will
> be exhausted and the qp will be put into error state on the requester
> side. On the responder side, the TID resource timer will eventually
> expire because no TID RDMA WRITE DATA packets will be received for
> the second TID RDMA WRITE request.  There is also risk of a
> write-after-write memory corruption due to the issue.
> 
> Fix by adding a requester side interlock to prevent any potential
> data corruption and TID RDMA protocol error.
> 
> Fixes: a0b34f75ec20 ("IB/hfi1: Add interlock between a TID RDMA request and other requests")
> Cc: <stable@vger.kernel.org> # 5.4.x+
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/tid_rdma.c |    1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason
