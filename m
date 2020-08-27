Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BB254804
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgH0MZd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:25:33 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7455 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgH0MZA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:25:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47a4360000>; Thu, 27 Aug 2020 05:16:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 05:18:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 05:18:55 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 12:18:55 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 12:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HODewWW4rnzrGaA7rYXx8nxmJENU+uIvqHnOwPOT77ycEhWHsD5snmDpis9Eq7bSOshYd24p0vvlvu87RNjc63KLE15tGdz+CUSTVO1nC8zupj1ednCGgmUeJmXwQLtnKXqceMFHq3Oq99LffII01U3kdBC3Ez+t/utUka3/FuLXkx9ozvzpsWTxI5WcZVIubUHKx9X9yVxyHvL1pCup/elaBB2BI1o6+NcomykbhLtBur+4LKaLMc4+UCcPUknbZ6TSmxs+OmkAfIOqZ4fe0E3GWpGoky8EHtrUwrKhBLGx+BQla0wzHeUCNsOU1it41W63nzN00WU31uLBgScVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEdvc2p3AqvOen2oSfwdwHTG3fWRtgfD70XBuh3mz3U=;
 b=TZtH0C+7Cp6I8AyqaEkKB7UxW/+03nDY9RYJNS5EMnhJKudj6cZ/KWGzmguB3ASJfCGQdrK0P52tkS6qKKGVksZzgF9LPQks4zOB9368sh51dNMOKyvV3BJ5nJnnKqeh1OjIqWWXjlHVzTMHIcoPRkUNHJcq1dB1RKMGyxo4DuodpGQePeU2OYvxovPFV9zNnodwMjv2TUEeXx9DLeaSIft9f3wdbK/2mjLBYstCVWy2Jvm9hyRvTgI4N137ONTW6oAuGj2RNhLnSIMynkiA8IEsK6gpiLaK+edOwnKfzJNPDItrOnJSD+6lvXPINx5/ydGFab0sGpGbPYWK5wFVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 27 Aug
 2020 12:18:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 12:18:54 +0000
Date:   Thu, 27 Aug 2020 09:18:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Mark Bloch <markb@mellanox.com>,
        "Eli Cohen" <eli@mellanox.co.il>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/mlx4: Read pkey table length instead of
 hardcoded value
Message-ID: <20200827121852.GB4014126@nvidia.com>
References: <20200824110229.1094376-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200824110229.1094376-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:207:3c::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:207:3c::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 12:18:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBGrk-00GqHq-Cf; Thu, 27 Aug 2020 09:18:52 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ae9b8c-04bf-4b2b-2730-08d84a835d1b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1146C4A34AB8496243B39FE5C2550@DM5PR12MB1146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r6i3sJhJ0JGfDKVq5knwVxrNXS1VHYxeyS5bIuvhEQwotjUIna51zT/kUD3AD0bzpReE1qx4WueoMMveAHr8cIFUApXmZuxQyvefxzbp6hoqhRaNACrTrPmCZoqPZtSf+EaydboDkH7VnLQrQrvtEcZgGurWHK/tLWzIBLDQ2XXfeBzEqYq0UYpoARscoMpYNRfDqoIG/Ms49MRVZIbKX2x2yK5NY4Wys1E5j2Onu78Q4sUmzV7nyUJfKDqzM6IXotWg0xPX04a6DhuBr/lVKZfBxZhsDhhFrVWlwBptfFf5/T6+Zpfr1nRW961x/EJ4ASxLB+eZ/6LMu1R1GJDsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(45080400002)(8936002)(426003)(54906003)(6916009)(5660300002)(2616005)(186003)(26005)(1076003)(4744005)(4326008)(9746002)(36756003)(9786002)(33656002)(316002)(66476007)(86362001)(2906002)(66946007)(478600001)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wgu73VriLtSCaDnIRz+v/ph6tO6ZERDbP3/GIsSKHQ2TO+Q0fchZV/rF+lWLsJFF+idc9bY7bccXgXjdsf1FRncj69lM4rANPY+ozLAiWLcAWD0UwwAc9ZRXrvqJd0YkF7U9/E0Lgj140uSY690BgcK9ur2KZMVJhRgLEfpvejh+MERAr10ftLtgby9lMiGs4EclEXBHDRU5t+jglhH5sJbam4wY5oY85Cse7kogVEDtNIGS5NEMfk+CO18p4hoP2eryOhiQ3NZ6FrWiLOFWoRkqnpFDnb/bvjl57MxHdoUomQu7+MPeVL/LNN/ERA3IDPpSh+RYUOG+kHUm8Hq5Qey9cCYyFvkxjYG3ywRP+gQakL1Yl3A5xNLM2AWHpOWcwddWeAsif9QKYlz6n0paBhuB1CbyphYtXhIszhWseg9wtUqjSdSlJcV9P2LYJNYrnc+merFwxdqjUcIjarkdUZ3B+F24krkTAWqthvCXojvPOB0z7vJq7Kc3mBYabRuOLdbz/Ve9unHYR820d7tsHC0UDECF35ONuAuhbRAijzMKJWwZWxR+7aW7i+NhmYbsX3Orud0ZwYivEMAj94ta/+VuCeNIjIXbkkUdPCik5L8msdUD/KRpq54npKiE78T6o6zbzpdA/LPy98FweqAnPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ae9b8c-04bf-4b2b-2730-08d84a835d1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 12:18:53.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wsVDzUeDpkzUOAutdVr2ij18iTMUo/cQMs1rOle2X+f0SsxJBCyJO1aMRNIlS24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598530614; bh=UEdvc2p3AqvOen2oSfwdwHTG3fWRtgfD70XBuh3mz3U=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-LD-Processed:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
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
        b=T4pzIHYjtdNt/54tq7KTFmaXwrQtG/9lrXIdAu9mg7ffDqDEhupk7gkNPL45MrYJc
         +bD7zuvidmkcauLh/7SuuTNj7Lh8j4wNBDvuheGJ9QqWKvGUigzj8La5Sy47PUMhwp
         29gVYRjgwy0NEM7SmYEYFq4K7cavlDWo/klVXyUXHotUNImxGgZb73XyKMX4Js5Mox
         kbZbpQhc0C+B7G9Zs1nyYSEqyi1IaPTxZgsR10rIoW+tE7nQ6Nc80R2ZA/vmx7XzJd
         O9nhcZTR3VCjtmA317dbl5zsa6AV3zxowwVOpr/5qrhr+oH9SYApCiv7og/EPtccNV
         dYOjkFbG4aE4w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 02:02:29PM +0300, Leon Romanovsky wrote:
> From: Mark Bloch <markb@mellanox.com>
> 
> If the pkey_table is not available (which is the case when RoCE is not
> supported), the cited commit caused a regression where mlx4_devices
> without RoCE are not created.
> 
> Fix this by returning a pkey table length of zero in procedure
> eth_link_query_port() if the pkey-table length reported by the device
> is zero.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Long Li <longli@microsoft.com>
> Fixes: 1901b91f9982 ("IB/core: Fix potential NULL pointer dereference in pkey cache")
> Fixes: fa417f7b520e ("IB/mlx4: Add support for IBoE")
> Signed-off-by: Mark Bloch <markb@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied to for-rc, thanks

Jason
