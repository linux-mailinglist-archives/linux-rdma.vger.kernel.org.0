Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F42632B3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgIIQt0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:49:26 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11591 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgIIQtU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 12:49:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5907820000>; Wed, 09 Sep 2020 09:49:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 09:49:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 09:49:19 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 16:49:19 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 16:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSXh5N/3woni0XvpnGYTkufP7mHm5yr4CAgt477gHuoW0xRD0iHtIXJWCXDPKyZfChxm0mI3MsuzGuC2VYZVjBwnqBgsdaKOi7nlyiL6vpL7rLBgwME6qKgD/CWW7E2wO0CR9WBSuOIYK04VWq7/Qo0cXSWMoHRfLPd1m45ixdoA0/fjWqgwtlzfz8Xx+Xvjnl7EbkJUfXhN0mMXOcsDObTPD1USasXLAbW8Vs5c4kfOjEJfvjzcL7HdYDgqKtPKPYUokr+DfUnjrX3mgxbrpara3QXyN2YMVvirMN00Ow0i2XWeIZyYpuFw6PQMPY4/+sajYXqdAalfosl4N4EThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jodl5xqJUraF6aBqXTmeu1P0B4aUAYKfzH9n+WGWonc=;
 b=GSqlTvq+kFiPOZ+wpNAa3f1d9wQbRKBqZZMjixdSsn736ydVy2gJYt+iKjZ039/BR5Q+4WDrpBNvHmsJFpq/8rkli/jNlmPH4aC2Ced/n0S8KtfwDWWXl8ich3YzdsgmKHLmSoMZuKc2O3XFPj3CwIOVky0zN2jIDaR6pptHiQSupORnQJXm7HKO9htjrnbSAccdKvm5IqZV5cJcYKoRuiqV0aLzV9gDIciuVwsib0HM7Q3d7xuPZOUQycWtlcUNfyKS7w0DConLvVtIxxNf9l/T20BSQNRb7rxRWfFe0Vx6+MixIVrVCKpncVbi6/QpmCAKzBmOQlwrVfvOfPqHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 16:49:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:49:18 +0000
Date:   Wed, 9 Sep 2020 13:49:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200909164915.GA887151@nvidia.com>
References: <20200904195039.31687-1-sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200904195039.31687-1-sagi@grimberg.me>
X-ClientProxiedBy: MN2PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:208:134::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:208:134::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 9 Sep 2020 16:49:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG3HX-003inp-BI; Wed, 09 Sep 2020 13:49:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3938df08-c14e-40aa-bccd-08d854e04a84
X-MS-TrafficTypeDiagnostic: DM5PR12MB1433:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14335E97FC45ED2EA8C546C5C2260@DM5PR12MB1433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMQX3JStOESFtNkV5upTYrAs/BuiUh8kSEedFh+rLJT8A5zarpVJiXj+y5kjttqGo38ZjYkCasdjr7xP8unn8hIgxZxai3zRwBAxNYJjSr7wnQHrU3K3bOxPsx1EMK/j5MvM/9KRNZVng3k5JI+xZ8hFXmlitIJCYG6PPo62LW+RQsPK8u50EdLCok9z6miO4SE8Gfc9KmFJpkFWdG6OQnZuy/zYI84hsVHBhWmVtx/vHQH2EXc92pC/VKe3QK/zStJ2+O6KMgtQkFFOkte7v9V3CRpUogEJh/ax1511+LqPu5FWfXPIo0XHB2Ri8JOrBUhq0/e5NqWAGXXIr1/thffW/3poMCB3BbC85XIZk2jT4i50OMGTzOspOrqzdNS54KHd26Fjwennw+5VUuWcaUtgi23iHTjjV38pPFomwiM9tiUWgM1icJOpBYP6kg0BUgLbJfNbmoVMePO7PL2HYTCT2svdBqxFDf6NDOYOlEqGyhrwRIlBPAqD9BdE1qTUJ8Gii5wMHAitR8o2pSo5LZEaNDGxh8Lz78QsrE0GlkLFEGfj8oAD6RHc4MVzCJTObcorV2GLMp4oZfJCjx31aXMv+KFccd/FYi6BIpu6/y7DbqTUlXvi0ryOtJpcZIF2d06u8YHxkEIFANHul7OUtJlD6XlCuTYaLf1RN4x3Qk0IC+p4FBMyk3BlLBA1NtU1lWwxq6VHt5NGJpIehd1L6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(66476007)(66946007)(1076003)(5660300002)(66556008)(9746002)(4326008)(186003)(26005)(36756003)(9786002)(426003)(83380400001)(2616005)(6916009)(2906002)(478600001)(8676002)(86362001)(33656002)(8936002)(316002)(27376004)(14773001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: MPIR1SDYgHxa/G0iO7VblYFNPvXfqZLR0J1BnbO163RGrx8HuVMk5WcTSy05NtHfWi+Psg6mcwV9GNU+a6ZS0wcUixL2xAz4meMENYsLt0N3+wGfk+osjlHUS63sSjJZhOhyly9DnJfH03KNG/HZHDS/QYxNygeRTkGpzB1SGr9dqGgyr+RnwjZzR4CfpYqvjOEMxa/F/DI5GMTs7VybDwYaKGnISK2zL2vxUlYLlVPjO6ynmrWMv81HBDbSc2qqH4h2cuQPlBs7Sy2pXsqH++PMKM5dkfVF4pRX4rn2oXfrFOsKt5fw/Wi5dQLwS5Vq1JoKfCFyStY9e4R8lNIFJ76e2hS1Pbv/skU2oNNWKWCnODGxwCzJNfEGn8pkWLFE7QtGde/9OGyVr0Iehqe8c0LBn9m1epu6G6L0gdntTpW0L/kzpDDNnVe+HmkUTNEG8g/0ot9SjmONxrj4DrbSTSEld0zcAeHwqdYhr/KlFFj0R6ZgnxmvZABFIwqYPHF3FTmXUUIvQCO88SDsGbOqL7ZRuBRwfq3Ym7RpEnBwJL3wdT0MTD5dplEUZzpe8MSl3aq0uCZAt9wymLg6tS6Ht0qwPFs84jh2Pxeabv/zaiSMOOA+mpY8wQDn2ZnzBQ3qQkALD0sFwDtqOY3v6Qwsnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3938df08-c14e-40aa-bccd-08d854e04a84
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:49:17.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: druvxNpMPM25y68HhdWJYMHLEBX5UyMa+bqGXqjkLvfYMpLLbDNYqmNI0fz3eZcc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599670146; bh=Jodl5xqJUraF6aBqXTmeu1P0B4aUAYKfzH9n+WGWonc=;
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
        b=YuW4zd+DMW7ohkZzG823EZ8X5JwdUknG7sSGlpaNjuetLNQ1EalY8ufCfVuFiL2R5
         Bbi7Ie0k1BdKQC5OicvGvTuNowc5nRFehgEKLe7OXfyhD1MFseo1v67/upnSLDRpqV
         BFPvpjYXHn8zbMYCQYMhnyMefgxzGVuo1AhrqSp4i6g9dBWtybbQLKTdwKQkk7Z2Gv
         jXZMD96X9wBRdOcFeQbezfb+CK3IZY8qBHxtyy03ACjWh7dhoNtCtdc5uvZqK+FoE6
         txheTBVfqKmSAIUEzDipynibasShlJ4vPdNHh+adzHrE7uCglsZS3rXY+pKEW1Y0xn
         NCbTt+6QFR8GA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 04, 2020 at 12:50:39PM -0700, Sagi Grimberg wrote:
> Currently we allocate rx buffers in a single contiguous buffers for
> headers (iser and iscsi) and data trailer. This means that most likely
> the data starting offset is aligned to 76 bytes (size of both headers).
> 
> This worked fine for years, but at some point this broke, resulting in
> data corruptions in isert when a command comes with immediate data
> and the underlying backend device assumes 512 bytes buffer alignment.
> 
> We assume a hard-requirement for all direct I/O buffers to be 512 bytes
> aligned. To fix this, we should avoid passing unaligned buffers for I/O.
> 
> Instead, we allocate our recv buffers with some extra space such that we
> can have the data portion align to 512 byte boundary. This also means
> that we cannot reference headers or data using structure but rather
> accessors (as they may move based on alignment). Also, get rid of the
> wrong __packed annotation from iser_rx_desc as this has only harmful
> effects (not aligned to anything).
> 
> This affects the rx descriptors for iscsi login and data plane.
> 
> Fixes: 3d75ca0adef4 ("block: introduce multi-page bvec helpers")
> Reported-by: Stephen Rust <srust@blockbridge.com>
> Tested-by: Doug Dumitru <doug@dumitru.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v2:
> - fixed 2 redundant newlines 
> - added fixes tag
> Changes from v1:
> - revised change log 

Applied to for-rc, thanks

Jason
