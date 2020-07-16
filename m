Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204372229FA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 19:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPRb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 13:31:26 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11154 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPRb0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jul 2020 13:31:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f108ee10001>; Thu, 16 Jul 2020 10:31:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 10:31:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 Jul 2020 10:31:25 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 17:31:16 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 17:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=albH2ZvKJ+mpa7Lp2hBrFe7gsIbZc3lnT5x92hbL6eyWj7VGUmgDgz0tYcMwWovKskhvX12jamnAGmJsYkx06pBFNL7OyFoRXUrhcDpSkfQEDyi0RimdZV05Q0P/aqYp6xKWqr84eoMmq5NbT3rvIiKWy5K+bBOE4+l0pjZ/YTiRjQzkJQbFoaHMRZkp4SNSNG/dHBsRfvzYK71AOapigRNMqdrAesfGmuby/zx1XxiUt0PaoEHMOslsLfUQPy1koSedqq/Wj0YDw8AXI51jn/3v679/+x6m7Z5nmAJIgRV7JFEC24HWeT3Lpl36ZhFlnaYTSYJkAO1mx0Lc2Ohc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFQFA+pCnqN2yX54hRSwxD9UXF61qzo3skGaNHAD67E=;
 b=HAoXYBvhhWekZRohLADsvv6BBJhoSQweOe99OT1EwmYMinEPSYKf6rDAFNckKtPhsRg+/z2wmVn/EGkAKXH4X0qkT/stwJodk8047t94WSpOPmHHNKsyUe8DBTSmBw3apT0oe/DANks6D2CvDYlsjaP/9IFsyXAOmP6fIEuy9GjyDKsNSg+sMs/Dqf0/ooVcxyBiW/CmW/sK8CzBYzD5Ih3H60vfepbbiYt+mAQmbpec4gpk6jNqqf39QwvOYqlR1IK5ueTjeS9wJNJKknQs1aFSH0t2zXqINnz/lrVCsZuFEKvNWc9r1vAc3XSRlROES6/k3MmahiUg50LqOzO8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 17:31:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:31:15 +0000
Date:   Thu, 16 Jul 2020 14:31:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     <sagi@grimberg.me>, <krishna2@chelsio.com>,
        <linux-rdma@vger.kernel.org>, <leonro@mellanox.com>,
        <israelr@mellanox.com>, <nirranjan@chelsio.com>,
        <bharat@chelsio.com>, <oren@mellanox.com>
Subject: Re: [PATCH 1/1] IB/isert: allocate RW ctxs according to max IO size
Message-ID: <20200716173113.GA2647180@nvidia.com>
References: <20200708091908.162263-1-maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200708091908.162263-1-maxg@mellanox.com>
X-ClientProxiedBy: BL1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:256::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:256::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.10 via Frontend Transport; Thu, 16 Jul 2020 17:31:14 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw7iz-00B6oy-1Y; Thu, 16 Jul 2020 14:31:13 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ece0ca-9b25-472c-08b6-08d829ae0a7d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB435639B258C7E72E2BCAB654C27F0@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zd0TGIkoZVwV+nluy1ItVjRKRyE/BIRvGcVQs1/Ja3ikdUETalVsDAED6p044Tt6icaIHrgwcOCLIEk37KrPrvkuQjAx/DqRzkxSc9ZhRPFhU8p4fKWwwY5LAgQhxdM2gZphnpAI6Y6VkuGiTK7F2ydQTjjjkfzk/d9swlxDLPM/qNYxmERv8nRe52k3txATnsKztexQZrjN0dSs1wWHQ90RNFGn0hxGVWsmoqQJy01/768pKQXMpc6W/dAuQzOJG3ppQsR+CzpkCJ1W9k1IAt2DebsdO4CvgXo/+nd5T4X6q1aBfzyVkbgfL6Ze4eAM7gMDEZkXgfMAFsCajRfbbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(2906002)(426003)(8936002)(5660300002)(66946007)(1076003)(66476007)(316002)(33656002)(86362001)(66556008)(9746002)(9786002)(2616005)(4744005)(8676002)(6916009)(478600001)(26005)(186003)(83380400001)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KRuKa5vXyV8w+juieS35QrWbSED/d6DwzwYuOglKRtF8aFsbeg2SNy9dkCVNIzFelBUGPrktsrlNUbQ8+y/zRxP/4ILI67YMeco96cSC6LmOrd+FO1M1XbGsxYnlfsHGSN1yHwggc67df3ZGZGjJoqMxux0H0oXM09MGFg+yZdldJA7mo2QSps4J6a8vTRn890+hjWB1U0Ye7/SP/Bsf/89upQpTlUwixACW01PEE6BRTimp6wWRLuIpiIVr79EC2drZLAuZUDerALkluA4uYYrRnPfzFAtvOQcaF5nkQASgoH5bHu0/bnxp8e1xewAs/sIEXSysb2/KIkfJlfnp4Zp/yfeAKGKy0KOCwbb4GzhGx+h3Z3rQT9pcTj35zcN1+hZ1Zj2pc9cX8MPr6oMNVuGtVyS7gHV2VfRsPacYLNvMekOyP4aiEqg0zr4nUzaamDFsPt7NWhSLYsbw+t9QDq522h7nq07WBADRIn/pWwmNE7RVGZ4TM1Psdz9Aj6IB
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ece0ca-9b25-472c-08b6-08d829ae0a7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 17:31:15.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFtjm9EJtmHPvLUinJTa7sVjs0WxcJVIn8OVkEsquYiiBYQ5+ls8PBdUl0FBE7GM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594920673; bh=QFQFA+pCnqN2yX54hRSwxD9UXF61qzo3skGaNHAD67E=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-LD-Processed:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:X-MS-Exchange-Transport-Forked:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=M763cUK3/iBMhOJ9bTHON4msY83D1Ks5WXDFookwgVRS56VOMAEU9eHxttLFsQgVy
         GNNGHvwaATHkeXXc/J+01o+qd2mhQAJsrdU8Vur/IxqZXCwjshbGFFffIiL5i6FPwC
         LXZfknbUko7uhGlQGHWUnmNA6rfORyWtwrWCvTG4tM9gy9jlp6B2yr3lbWM/tJxc3P
         Z6G+B4TOioLxtnLOQhPuheHjTb4NI4/AYnY1sD0b57B/Fz+reZHJ2jw+bI+OBPEJd9
         5oRMl33Ecp6Mhd8XR12Q1CorXGeM+xGkOpQ6QT6P9IrN5sTpjgJeamEuRM091iqGbD
         TFt2EGt7FjAEA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 12:19:08PM +0300, Max Gurtovoy wrote:
> Current iSER target code allocates MR pool budget based on queue size.
> Since there is no handshake between iSER initiator and target on max IO
> size, we'll set the iSER target to support upto 16MiB IO operations and
> allocate the correct number of RDMA ctxs according to the factor of MR's
> per IO operation. This would guaranty sufficient size of the MR pool for
> the required IO queue depth and IO size.
> 
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 6 ++++--
>  drivers/infiniband/ulp/isert/ib_isert.h | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
