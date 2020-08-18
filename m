Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBEF248E10
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHRSmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 14:42:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1946 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRSl6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 14:41:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c20e80001>; Tue, 18 Aug 2020 11:41:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 11:41:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 11:41:58 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 18:41:58 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 18:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWia+PwoAc6PV9YmBR0InstAArqghu+M3ANm/zQQgk23DNjuTikOi2989eeTWe10GWZn20jdVEd+LebXK3JQsrgEKCl449w131OK8kI+dNr1DY7s/GZL2bL6SujSjr6sGLQL4r0dfLow37x1MpemNlSBTX3/7SsxerBHRQTYEb0LXLDGFbc/gDs+GmeJCf9M5jKzKDGY1DSYWXLM2OmQJujOAtdR7Ei7RK2m9vtU3HZ0gdOoNzwzKI+mi/QTAqBIVBjOihIxDNUibrw0ZTTwkaqeaOHuUxmxWJoV9oYaHwHRIk55kuGK9rUmgBR9w7FAVU5J9FP2wIdWDKLlLkCWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=997xGzs791/+QoReWb8PGc+g8af+PaddkjfsFlZC1ic=;
 b=Yl4Ul3CDkYY25lg+TXCykqX5YKuj7Ed2FE2FL2qzz2bM5xa+n4rNq/cwkZPQkE/452Z00XhfwpRrgI3Veol66FlT1w8w8KftkWEZw6pw2BiEUp97XUblRsA5YapUgE3vyXIDPRiL7dj48dhRMRttoPN7Z8LWdAIGdO4cH1YDPDrAQJFJY1IoALSsQNIg/DiSA/b2zDLSQP6QyUA41wr9k3thpJC9SWYT8s5wcSqfgqhGkvj/PiukSIyxHtRl4Ugu7wv2fV1HMvpQUuZ0EIL6Y0WDrvnPHp1VcgM4QiZyYhXYEzomOnIsP0DBH4HOCx40jAb8tiwtDXVfB6VChfvYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 18:41:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 18:41:56 +0000
Date:   Tue, 18 Aug 2020 15:41:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     <sagi@grimberg.me>, <linux-rdma@vger.kernel.org>,
        <dledford@redhat.com>, <leonro@mellanox.com>, <oren@mellanox.com>
Subject: Re: [PATCH 2/2] IB/isert: remove duplicated error prints
Message-ID: <20200818184153.GA2064193@nvidia.com>
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805121231.166162-2-maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200805121231.166162-2-maxg@mellanox.com>
X-ClientProxiedBy: BL0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:91::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:91::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.16 via Frontend Transport; Tue, 18 Aug 2020 18:41:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k86YT-008f0P-D9; Tue, 18 Aug 2020 15:41:53 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5336f225-bf8a-4980-2196-08d843a66188
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR12MB1241097A4B3A1BA20DE3A337C25C0@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQIqB8slKh0rVMFG8Aj8CKjewPAjLnTIFzoL40g2F71rjCcihEUZ93p5ut9xt0JcGzTcqSlaN501tK8/gHRDSKFE6z7SeBfMyjPLo1UEiV65H774fenbU6/mgjzBPZ5WFJXgSfjHnV784efEWNVxp55G0ik8Jxx16mFh2OPlkDPuwz090nTCkF9FPzlXHBEWZfD2C3T8yTwDGV3Ui0pe/JjBCoI5bMWisYyUN7kVlT813stuxulY4EgmLwOrFTR+zLXc69d6cCvxM1kEGgAbcELXH43CkbSvg2Yz6RAVkqa5h/1H1mTJQDVyhtk2llFOqp2KpZKbC/iHMCnJbz/82w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(5660300002)(9746002)(316002)(66556008)(9786002)(2616005)(107886003)(426003)(26005)(2906002)(478600001)(8936002)(66946007)(66476007)(36756003)(4744005)(186003)(8676002)(1076003)(6862004)(86362001)(83380400001)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r3cy85RAfFoDhPkEkPCa/LjW9SjrmAf+WN++SEeaQraOARxyN97ky9eoWuNPkWFDQBP+JvKCIHCofmWaQaLy3nf5H32NwsY9nITad6WxL7lUGRlgc67y+TGSJh0rf9AcmZNSgSg2za4Hi3cUaCbwIy3YcKg4kyuao9NPP1qfFEyPfwdsWUrSyGifZPSGOzCXvRwAUe0X2Q8+2bX/v8sjoNSne9pjdj8Ewe0RmzL5AqGP4aFnDCmFXLPbXyiaXbdtD4HF2cSLXYHFsL/UHs/djk9DNCDPpQ7P3aJESNIQsjxQJY/azCyl5+hRhm7tvmBZsg5nRJF5Of/CScJ7+HszrzXPiihZJIavZ4pEnC/YR3omq4nuuk4JlUPJO2Lw4Hlr4EU7H4IwtelKZLfHfPsTH2t6ijxFGN2efMVRBL9PJWiQ8IFNALJvvOBaRigrKnaQwVUpw5TJo1iZnbYBDpADA2tEjyFyroH8Ru0G+OO3bbhL+6nSLPwIEBoijzqO7+3AjMmFyfUwaKNAC88H3bYCByhzrQ+JH8NXsCtgcVZl9wc5vqB3cUqj4kaVU9k13gJYH3eT9gw+5ke9Y9OihroEPEDPjpQt1zJMNI92EArkvLjKGCVjbpIagSn2i5kjQRxX2/twpb7BjHsQE8HS+y5WPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5336f225-bf8a-4980-2196-08d843a66188
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:41:56.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbKrLS547h7ipAPRn8q+v5VLPNl/68eAWRlKxlms/y9AdfUF6CzyiMzt0AWO5uXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597776104; bh=997xGzs791/+QoReWb8PGc+g8af+PaddkjfsFlZC1ic=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-LD-Processed:
         X-Microsoft-Antispam-PRVS:X-MS-Exchange-Transport-Forked:
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
        b=ea/8V8J00oK4x1KQOD1t8kuuAm8FD8OZdYAU0L/xS+vrETHq26RzSdfWfdblafk0x
         hUYOblghFx/cuj4HB6fIVBuQMmkkrs1xfXC8hknuLXfRYuzBbfwoE8YJMpGaGzqX/V
         QjJ2RZNWY8FbNil2xG92S7Pk0MbQrAuIm0XvyPQyX5/umzU0ynOgsmSNGYgA7uj0/B
         2zBt7mw0q79xXQFf6JHmQeeSSASDbVc4ylbz0YdkyOPcQWaWQoGcg7DOwcZhF01/j+
         GvHStn311a3dUsxLLNZXOhdJd1vxllHxOYTbdVNqJRXMRrZ5fEJi30J1qway6x1ULT
         1b5TD6VXz7TOA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 03:12:31PM +0300, Max Gurtovoy wrote:
> The isert_post_recv function prints an error in case of failures, so no
> need for the callers to add another print.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

Applied to for-next

I dropped patch 1/1 about the unlikelys

Jason
