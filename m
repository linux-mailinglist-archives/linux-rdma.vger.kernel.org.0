Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143C4368184
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhDVNfj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 09:35:39 -0400
Received: from mail-eopbgr700079.outbound.protection.outlook.com ([40.107.70.79]:16609
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236426AbhDVNfh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 09:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C25nEGFAlEkr/ZALwrgrfnrm0pzGP0HUaPJNuh6N4csG4T9EvpRxmzLn5NIIL+fbRD7fW5sleOC4CX5qcFLVlm1+I83lZU3kCHdE7yTDjNeFQImaW6V0CCZpvCp3ZnQ7e/s2lHFSDym0Iws34WacMoWGCTDCDXAHIY47zaoCPWiD6B5kmsDjufd6qxhmAWnd+heY80Vwn/KHrqaCtoG9uPAqXBJMGXhI5fq1T0viK7PZJYmEfHqwDqsWZobg0SUaJA66jeZ4jWCXQIOly1cteG6fediKnuQj2AePy2x5fSs2RV/n++krKgGkERBY18fFC8hshPi5MQYQYFVSSB1fYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M73wrhyjO1xP9YvmbsWCMQLbScxW6FeCRQv8OsOFFM=;
 b=V1BCNpHwBYLWzCMDPLPDgXeCLTeIACa5Z7ci5uIEvExrux7hqSWfrMyGP5+TT+07gWgO29U0D4uqjYunpu1Md1O4Jsp3ARh6aEISsAHOhCwR7lNLdNXF/IIi3dU71wLHh7ttOxHDVUIbsTy1Xhpi4jrn8IjB4pW4/d6ximgiWdU9ge5sA1a1nYt7gniZ2l7KK1PG2Go4I2Ngmuai+bU/Bobrq9fn4YMHiUqvFsXgCDZN8Tj6lnt49YrQfP6VIzLjxvKdgKLswxgk2TNzwDtssFJ+S2hzkweOrMr88jKcRU3r5Xqc4v69LgA9C7JHCu/k86MHRlYpdbeC5iFojDpNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M73wrhyjO1xP9YvmbsWCMQLbScxW6FeCRQv8OsOFFM=;
 b=DS4FIelUzmx7jz6BH3avyhui+4WS8ur9pSh+JpU0pC/1zYpJltCu3gv73YtDDbSwWk31ZY4i+G/E2csa0Ypg+bXwi4Uuz+xjGNaWijmD5ekeFrAPShWeIcyuqAK/BNAAA/8ewMXJbjUj1BQWCEEY+aSkkmyE22P2kQHZbjwuzplMH5CsrOEo629or3/K/0ZZXv0A5J0zCflLzshyHYLUt5tOsFUHRiFqRq0PVoc14bOdp1JBGbBrS4+BoKmM3eVU/Pb9uhRijX/WwhBGqwuHrCzoZ8wdqH6PfbfLR/YrPsRQ7FBqiS7p4zcR5ViJ/8dBp/+0VvqSbYL/LTChVjjdSQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 13:35:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 13:35:01 +0000
Date:   Thu, 22 Apr 2021 10:34:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        Neta Ostrovsky <netao@nvidia.com>
Subject: Re: [PATCH rdma-next 0/4] Extend nldev interface with contexts and
 SRQ
Message-ID: <20210422133459.GA2390260@nvidia.com>
References: <cover.1618753110.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618753110.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:208:234::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 13:35:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZZTv-00A1pz-2e; Thu, 22 Apr 2021 10:34:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a59e3d8-2f74-4419-069b-08d905936dad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4402CE70E096564069E1D6AFC2469@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmzgK3wD7h6UmvvEBRFxfO7RgpKpwhfJAxkIXHUWDgKpEbQ2U1NPKjZGl3LNyZ1t3UarmxSaWUx5ZdsPhBlpYeGcRlyxVN9sjEwqWULRQ348xEYWXP2XHLAGJ+LRHW7rtqtxGqHBYz4eoR+VDD9QzJMZkLXMd/oHSxLoQCgiuwemmpoLlACh1P/wRW1CCIIgXvO+KIf9vXpb3MaqJL23gWLnVacgYO7RcgD47Zf74qtk++Wncgmslqkr9MI4MKtuJPVQVZFkLtwh8U3Mce83b9ez/fDEd4WRwNv3TF7aSzacWWGXJn9o2dkLkoC2K5+w0FSfRLg+iavK12zQ0KPrbgQW50Zgh6exEkAHyplPHQdxLHor1NmivhUggS1/EAt1XX+mIv3BIzCM85Bg8PNBUDvALzxE1wYMmzS4wURauVzm+Fxt3DhQFYeGzZI0HTOSxqWhfAYpMfDNV2aXMATxzDiOg5+6RRy6prDm8wXp0zLiFjC1cx8mWgVyjTWsL+sX7pLZX9NUTQYeBgTl8Y5hW3BhiBpykHflXCD18DRpKnrW/JnjnET/9yYBRtIby0pqNPY68Fu+bBVc70G1+ARs+hnz3bvbefnvYE4ekNAGCf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(54906003)(26005)(1076003)(86362001)(186003)(8936002)(316002)(66556008)(9746002)(4326008)(426003)(2616005)(2906002)(107886003)(4744005)(5660300002)(9786002)(478600001)(6916009)(38100700002)(8676002)(33656002)(36756003)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?767kZlIshA96EAne8ldWVM0Ge1s8Nc3QHnRweQYiISSTJnPzSMiPI8HWqZX3?=
 =?us-ascii?Q?T10zqiY6cY0fEnsnq+YfOdD3SADLBADa59b4C+80ukHWIwnHzMFb5R+WzOCs?=
 =?us-ascii?Q?AkOk5RlCyeZ361lbmh6VbPM+lUPdA5oadDhG0cuohtqYISTgnCs/J9Cz+qI+?=
 =?us-ascii?Q?y8CtIp+U8uu4CueYRofkMUZKNYhjnHwr6+jzfQUQeIKYY2cr/J/WKErQHYh7?=
 =?us-ascii?Q?ZipUJwcLGcARae3C2OEqvKZ0n8mdZXRvF+Dz3Rr6oZnvAdrfT43XID7JLFiO?=
 =?us-ascii?Q?DPp1ad0AI1+5s/vNiQ54LyPHQTfmPTYc+MZDNn0JWYwwmhfiLETEdmUp4GPi?=
 =?us-ascii?Q?tR9cBzq7QGndtM7t7Gp3Gf9wPeIGzR4tBGUeetJigzSooFZ0PSRfZ2XUeKId?=
 =?us-ascii?Q?90iYwkwg6ywY7ijH+nVTxWEjZGyyEbJ6ljH6A0ceP0b+2KnOSaeV919eg26F?=
 =?us-ascii?Q?vkkF7cKYK9khD8hAxvZSY/+vFG6K30oyT1bkzaLEW4BucfdpLxkwYo/BG04I?=
 =?us-ascii?Q?ZsvLwX7uuhuI4J4dslZg9DqC61pFGTFgwO3ljPTxA61UCOxwASj8rnLjtXAQ?=
 =?us-ascii?Q?6WDQTlMhzfYy2acstQzQIKN9zQDlAlGr4osDidqA2ge7bWpx8lIRWRwf6YHe?=
 =?us-ascii?Q?E3OH+/mP/9HdM6zrQQqYtpDODwAXAxMx+Wj1Pe/hzDiUfkXqYVfXUwBkcNJW?=
 =?us-ascii?Q?hGpSsmYCiVRixt7zfG744nzuD6vQzEH3W5LPj/fcAHGAuzsXOD/LyD8Rl8OZ?=
 =?us-ascii?Q?nH2vDrWFZpTqgB7Hwgl8a1jDZFPep9m7VsU+tTX5H9h5K1k2hS9+pz5Jx+wU?=
 =?us-ascii?Q?8rvYVF9nA4VRCYLx8YDYCoPSBo696AETuNvv5Hy5TAKgY+ZTvTsHNtS8+bdp?=
 =?us-ascii?Q?Spmh9jNaY9cNnkfl1uSYU+RG3muzRM16cTjVR8FA5BHLW7GVNm2bxaGJdGvR?=
 =?us-ascii?Q?mk9uesKkYifna2MlDXLEj6cYnunMhtytCF6FC1DceB0YGlAy7UkuhVssqAQw?=
 =?us-ascii?Q?/sWWoaQjyzIBPrnMcD33399jZq6+ZyULCBx6ntdMeO5AFCPZMTopQL7Du4Ks?=
 =?us-ascii?Q?Fs8EkIvVRLdlQPCZgBwbVlFn26jF9Qt708btz7rs52uok1CQCMUIb4rU5mUL?=
 =?us-ascii?Q?zyATCpnh8sL1q7dOOgxrhZ9VI9If62zbp+KoQU6T6fhKLAu1KpuEN+B/0r3P?=
 =?us-ascii?Q?kKrFljgwORdco4FlzXB8lm7MnlsCva+QoVSOGqPf8VsQFmVFNy24Y0u+6o3E?=
 =?us-ascii?Q?3DgHM8KHhYDmXpbzoSFRRZBxsDBd/QN9DGsZPB4FRjUNUAu7tuhhPAR2PJzn?=
 =?us-ascii?Q?5sSNTLn5zNfPu/uX+SmVtDJC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a59e3d8-2f74-4419-069b-08d905936dad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 13:35:00.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8r9wabg9nj2jHL9Dk2B+GZez9AORl/vzxtC/n3keqXfqU2x/InGGa6zYXP6P4N/k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 18, 2021 at 04:41:22PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This series from Neta extends nldev and restrack to provide an
> information about contexts and SRQs.
> 
> Thanks
> 
> Neta Ostrovsky (4):
>   RDMA/nldev: Return context information
>   RDMA/restrack: Add support to get resource tracking for SRQ
>   RDMA/nldev: Return SRQ information
>   RDMA/nldev: Add QP numbers to SRQ information

Applied to for-next, thanks

Jason
