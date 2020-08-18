Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D81248BB8
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgHRQeL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 12:34:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15119 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgHRQdz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 12:33:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c02820000>; Tue, 18 Aug 2020 09:32:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 09:33:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 09:33:54 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 16:33:51 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 16:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6wJhGFakdcGTfxV7pDn4XTlChh4VjXjcBQD5fTh/Cdes6Yx19efDJydDslRzGgRQh5xeeBw3q9MZ9cRsIdQShz3QLaI8DdcoiP6COrbBbcS8ujppyJK9RiGE0IWPzDSNUuPSVmGzw2UQonaV+5ZRmC0Axuh81vWMzZrqIh1SZj6G9GY9UvI+mw6rtBEOshtFTH5HguvazSm5UF1T3cluxUWwBzCqweXuY+3cqZz8kS8eZBurgMv7mkHJv4QIIZjfYGe0WtjvL5Cv73fcFu7ok3LVEeLOGhk0sRPmyhlQkcx5gvxXa58D+vEVImBusWv+UA4Xg+l9byYbnEyZGkHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO43U25FN4TTT1HXiKdax/tC7mtMC1Uktn1/hU5OjMg=;
 b=Kaz3Yt2t/VYx/4bRJku53eRPOpxrRM0tTGwF481S/W82/PnKvEfUiiOO9GPiErSikUxKVC+jXWrHGVg1+f8+AH0QWtsKzougj05+WfGB+ZgTvBVecxuy+/ijbPALKpB1wJkOzDB4FoGXnDjWh46Q/LzIjFKCcLVC0sIjozFzkmCLC17AlV4+DeedsQhuLSZJEvldKANXpCoarIpHbYhRLtjZ+1tKEgbvpUNJ8+BNoaPTZR/vpY4S5S7VHLiqIngj/8HQaqnL/vq4yS+spXKw5JvSDKUNUwh3eJHAUrdMLtbUz1XLlbJg65MzO2lQFC8EztFsy/aFF4oSIi7ANSM3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 16:33:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 16:33:50 +0000
Date:   Tue, 18 Aug 2020 13:33:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Do not add user qps to flushlist
Message-ID: <20200818163348.GC1990081@nvidia.com>
References: <1596689148-4023-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1596689148-4023-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MN2PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:236::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:236::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.10 via Frontend Transport; Tue, 18 Aug 2020 16:33:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k84YW-008Ljf-Kl; Tue, 18 Aug 2020 13:33:48 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 801a757c-8d2d-48f2-d11a-08d843947cae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB435611282F3CA725D5AF3EB6C25C0@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmRiNTSLKLzFExN1U8yPtr8S3SGUK0hoIyTEiQbsZJ7xkhqk3+mj9/jZNQ4t42TLFIOG9TPYpCCrWNph+RVMgzxH3SgPTmfINAmquZdE0kez+fQVLiYVUtNjEtNMe4onTWKZvzJ0rRVNxPbFSLUy3yoftC0pFsFvxwaGR4vCUq5VBpoLrWrkhaplThmuRnruw2GgASF+SPXTZ4rUSeIPLSUf7f+ILBs2JqwmPSCb6lGSEKO2B8h5LY85UUyo8kFtHNlBDTwqi5dKS5Trhb/INl+qfOkwHjzU0zmQFEGRt3XtgS3rroBWo6smejUMyvNXNwJlK3DVqptRUZFQpG0W2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(2906002)(4744005)(86362001)(1076003)(186003)(66946007)(66556008)(8936002)(66476007)(316002)(8676002)(426003)(6916009)(478600001)(26005)(4326008)(9746002)(2616005)(83380400001)(36756003)(9786002)(5660300002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ncMZE905SE6FTavMKSwBSzP5dBwBZtUXI/egNSjGXj7PRvWcaXjUaKTe0eNCQ9Rme0ctes/EIHcNTUet5+a3IQG1j/teobR5e9sCvqlCvb1UkoIODbA0K99VfA5FqAY8cylo4OMCCzWrjh49Fjz8Die/ooQ9qQ1L4d06MAyjtQshzCrFUXqU+L9yOXzkhyxp16iqJiqqsXZiH0mX8oD840Sz1hO88b1R5sN6cZbdBEgobSWJsNhL0cCAdAfEiwPy35Ki7Pnd3o5ux/ZUHKXq7HhDgcSEEce9Dxek8Cgz7I+yOzAw8vQpX8OKDbTTW9OoqmwoTbdp7q32umIGsTJUn4KS8YyKgnPrLhMD3aRR+2Fr4uHUipKjxZhKpfDLWI8seL7Hr+RLVPni56Ul47D00ksjbrocFpx7cDEB28JnIN0l5AC3eU6sNhU3yJJNud1/QRSe7oRwfoyFAhAoK+DEQ7/p/3ZlmNFGLRsRMep2VU5SAaT2hCzk/rJGGCm7Wf9jHUDcRwHEUBxvRRkoPtOF9hY8NDw8E3kepFf2SD4zJVDUhvJvr4YbxN31Gdp87y3O/7C6ECzSamLxlXHrordXlwNI0blg0rilcqvBIkG/KcW7ax/do4MNaLGpR4AeWiZIMfGk72/FyVymWuly1rbDnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 801a757c-8d2d-48f2-d11a-08d843947cae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 16:33:50.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrOfktg8AET6mroWL/AvRBeZplm3xbtWEGK2xvqs4mQNhH9pB4iUOb1oprPsO2ZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597768322; bh=OO43U25FN4TTT1HXiKdax/tC7mtMC1Uktn1/hU5OjMg=;
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
        b=B2V7B9P3CyIPhUBNZHIbed8D/atByGdcBsgMkjfIEuWd391pz1t1j1GEBgY50r9IP
         1ZTLsukgc3G4k2+KOMM05IIvED131wqer9XuRLfecaSp5UM9TGHTx9Na4C9Wp1uNTo
         O/2ikm2LkfO1O+RrZzXNwoojL2BxQVUVRPpgW2T0eotX3xmekBGTP9L1ZqAgHztcEV
         Gb2aUty1pVBn/+Do7acm4PtCb1qf0AODZ77KhM47v0mk582M5ycG3vb86sj/AW2OCq
         JeaiTmbZgEon3A/siZIUD/NemQCTrVT1yDxrCoppkqcas9Hv2e6fpB7GbhL6Kv84ts
         YgbCxpoiADpLA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 09:45:48PM -0700, Selvin Xavier wrote:
> Driver shall add only the kernel qps to the flush list for clean up.
> During async error events from the HW, driver is adding qps to this
> list without checking if the qp is kernel qp or not.
> 
> Add a check to avoid user qp addition to the flush list.
> 
> Fixes: 942c9b6ca8de ("RDMA/bnxt_re: Avoid Hard lockup during error CQE processing")
> Fixes: c50866e2853a ("bnxt_re: fix the regression due to changes in alloc_pbl")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
