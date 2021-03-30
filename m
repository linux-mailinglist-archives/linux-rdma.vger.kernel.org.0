Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961E234F1FD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Mar 2021 22:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhC3UMy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 16:12:54 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:65248
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230125AbhC3UMr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Mar 2021 16:12:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXlP16F0AZpZSnX3PNflOkZdJCMnIyVcjTx4E5c2hNc8Nt4HdsTv1689pEh0b91y0SF6tYUgccKNDwm8Xp089vXhZ80qqHZKaPVpkclu3SJX2ZxLUxIRUNravbdrpR1DzqrIQoK/T3lTEvfBIxyXKe2GHf9m3VTssWoJDKsl5WHJHn6VKdbqoVygptfWfSBKF+oljO3RrJ2xIBxHfbDLpKK55OAY5ANC9DWNwBbFKL/qnLhJ8mVgKxI1v655LH38awT7/tLOm4wfXZWAoTMpcgJeIYYQlTFvH71aSST6zhhVZNidtZYuuuMJk+sfi+T8ARS4gL+L+gGLMOPaKTGnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF1FXP8w69jsbleYaJSJV8LLJ9oe68aFpafSk0dxMRY=;
 b=kTCFYc7aHNmRxjE3l5t2ti8bLZpaFRYD7yaD6lRlg4zQrVUtiC3SlezUFq68T0XYHNYztTbph/Vg0XJRLZOWOSwUIx/+C1pxMVAsqoT/P3qggZkYCw4ctXz7V3uyBAex0bSWiP6GN5KRRfe/0HHtzKnkqk+g4/oFmiTAVC98RaSGLTp1D6AEFwtyhXnlZNPB/vIabEiHBHjolk6jrtPdZFNxBmhbqfWaDrDSzlIqNyXo5wkfMJoUwdFqHv6AVz/nrR74wq24pGyRTYLqn3xYxCeyPubHAnc931biJetahOzG0rZDIEkD33BQ3dFS2LOQJRZzZiu5KhiWdNCb97XX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF1FXP8w69jsbleYaJSJV8LLJ9oe68aFpafSk0dxMRY=;
 b=T0hOi300RB6To+KK34tXFjr7vLKjV1W2L91ZE1MoVujVfUs4b9b3YYTE54xXPuwf0sbzM3yH0pq+mzba1WvT32Nhv7Z/UGLpNns6GYKX450jJEY+kqsNlWLyb7Z7mnKIS/4m/mLsTcG3ULceOT8zYXxqCJyW7O32MRwgGPubbP5eWQzvZswRMfYO65UgKS7oxnwYxNinyztZpTfQTTRJluA3q4mUd+Lva90qjHuUJ8SJAkLfTK1lzsM5dGY5JZNoAqxuxoFxMMWUn+0pNv439IBZqZt4L/sx7RKlDdhAc2TZTTbiFygWmxM7kQQ4gYKS9ijQmQp9PAPS0cWdpc+XRw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 20:12:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 20:12:46 +0000
Date:   Tue, 30 Mar 2021 17:12:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Split MEM into MR and MW
Message-ID: <20210330201245.GA1447467@nvidia.com>
References: <20210325212425.2792-1-rpearson@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212425.2792-1-rpearson@hpe.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:208:51::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0094.namprd02.prod.outlook.com (2603:10b6:208:51::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend Transport; Tue, 30 Mar 2021 20:12:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRKjF-0064ZI-8V; Tue, 30 Mar 2021 17:12:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4025a36e-f20b-4ee2-662a-08d8f3b82f32
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25828E42D5BEEA442CF6FDBAC27D9@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuO9psJFQdRp4Rix2HH7Ey78fqLI13MmPh7bR+4PJZQYSzIYUpc29pU1R3i5aQxja26nv29XARAtUqaGrHag0n83Jk5ol7Enp/h1fUKXcHkTFEg2rRyilRLuhy5gC+KSNmGOE4dKuGTwi7LKg8URessYLE+jGqgzPW5+hn6t6PGRPFG/Tdj2upGGOdnoGRdtxOmVY4Stgc2fmIlVfM+hkej8g2OowSDI/8ZU3J4UO/IC09MHAUKSwN5JMHbWYIZOwE/ypEGtstekMG+9Zfp8PMf3Ic5lozMuH2nXGdbKYMWh+QkRGjp5MQLeKnjB7EqjNrgH0PZeAWAxLhygDO58Iy5K912TWZzQKnFAyZYLHuGaxQINZw3Cos5cUipXxSWME7fdtz6YJLuJ49izGhJuMYy1Q+qufx8IpiO2owdT22vN7N8II7eFw7XppLqlcGRZIyNtGkucCpW5kph84t37QTLBBJjqBVn20g2bQs13/7HnVl9c2P7sa7EV+NaxU3M9Q7FBNqZ+5g6KBSfYBAfe5g5do3ozB0U7Ke0DgCvzk4JHLlEcxIajBwvemtgPzRKnDb1BAKLTun40GrbU5Bk7gQWppKIX7RSx/g7WMnnMAHOr73F2goD4gYHLvBzbOadr4zD/A5N4CgZHzquAOhTkQ/cM3fb585uQr0jPe5eUcEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(5660300002)(2906002)(2616005)(36756003)(38100700001)(9786002)(8936002)(26005)(6916009)(9746002)(66946007)(478600001)(66556008)(86362001)(66476007)(1076003)(4744005)(426003)(186003)(33656002)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dKgdzY2OP4hPRq08B7qx0ZdUUqGviHuLroBNjh4dNI5jvE1xIA10lDsJzXHK?=
 =?us-ascii?Q?GmaPyGAKlgjLytyKxvwBU54sBwLbpku+d9aCtUCrZjS6h/lsGtlZNTbYKtOh?=
 =?us-ascii?Q?RaVuglPG9xw0saW/HaI+LHg0VY+aeu6m3u5sBhrsHepMEof/prDxGjxX724j?=
 =?us-ascii?Q?Qg4ZWFBWserc58HVXqSskOU4oSrgm53NeRqIiIiG+i63leuvqsb/oFT5BPnJ?=
 =?us-ascii?Q?FQr6cIKq3RsbPjEDQZ5cLkMFatHue776+WUgWOj+Zhy8b6qz3XLDWKEJOFsy?=
 =?us-ascii?Q?ty56MQgSOdrXEVX6P8WRZITanjjPOcGmvRov3jrFK3Hn1JhZUD+id4nNPnLa?=
 =?us-ascii?Q?3MFZ98ajg+LpS9QYQX2rwDJmZqKJ5D/bOorZNbrpHVEb8JEaOlb92qFHPHMg?=
 =?us-ascii?Q?6MX/JFU5UW62sib0EIVrZDuW41wYl4b7urMaeKqtP92xXgbaMJH7GUFlWA4a?=
 =?us-ascii?Q?O0ZMuWOLfZMnxWDEeEGZrTMB7XSZQ0Hm7v1li1W1o8mqokX7dSOQF2+6PFPB?=
 =?us-ascii?Q?dgpJ3J3Ub4gcGvbGWn6OKYHwZ7FHO2W1Ws6DI30GN5Ex/YfRg9xMV+/MoYmL?=
 =?us-ascii?Q?qS9tVztdiLn5q9naX/0vA91EvA9YOX+UUBLVZpXo7bGD6QnJGvHqD3xpxxtG?=
 =?us-ascii?Q?iVdRKtCqdVuM7s4b7rsgd4/Pwkpvx1iHrcSBn6Q2vW2UTHAlrlzthacYDIn9?=
 =?us-ascii?Q?6u1odDnMQJm7hCxWwtczViqVVpGyLI6TgXBeBp+02nSqhenpWjKL4F64cSX9?=
 =?us-ascii?Q?ngvJvikp2Zehic7juw6NAow2QrGdC+viRqyD73U8mn29h/8ojOal3iwIVmA9?=
 =?us-ascii?Q?8IPJaCBiuDpu/nSJn1PvVqC3VvWSKxjYhlmdKpDQ+OMY8l5/FJ12iD0JD8iT?=
 =?us-ascii?Q?/uTrWS/phMqxGLJpWybdXWtnL6kQZQSJsXMcsHSoQ+KgJqfEVbMpCMeGlV+5?=
 =?us-ascii?Q?bQBUCNt39KHFTwzTSXl5s0pznnxCBkB5tQQSfYW5cwO/PeBfXrdv7qNHx8Zv?=
 =?us-ascii?Q?wN4cE/m6Tbgg35eSpbNO7UuZzQ1/yx+AMlJToWY8iiL5tTJDFl6DjqE+HVzj?=
 =?us-ascii?Q?qQpp7Hye7+xXgkQwTjgmtjMecJFTzQJpubKiRfYpqtCNDFuj+SuwEgqxfZx3?=
 =?us-ascii?Q?wib7Sz8wsAqtK6slTURxqCQVYj2p3vjKfns1b4YDyPJFcSWl3lZ7iIK7UP80?=
 =?us-ascii?Q?jiRKvGCnq3Ovf/Hu0RZLIDQ2Vpbp2xlRpFJhirpkPHoaOsjJBsxtTyCpL78v?=
 =?us-ascii?Q?I00X8uDbj6y70aSSecnCRA7/wLL0qLzzvCcCr2zPR56MEcjdpFvCsIxjHjn3?=
 =?us-ascii?Q?tMaS5cfgxLXNdrk/Hi1vxT1snTk1nsJuWt9CYKbFeqbHlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4025a36e-f20b-4ee2-662a-08d8f3b82f32
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 20:12:46.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Os/KIROAI2NqrkXnADJMoXuMCUaPpx/otfPoKgxH8sfdXTPG58+f6TvDXGRJr0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 04:24:26PM -0500, Bob Pearson wrote:
> In the original rxe implementation it was intended to use a common
> object to represent MRs and MWs but they are different enough to
> separate these into two objects.
> 
> This allows replacing the mem name with mr for MRs which is more
> consistent with the style for the other objects and less likely
> to be confusing. This is a long patch that mostly changes mem to
> mr where it makes sense and adds a new rxe_mw struct.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
> v2:
>  v1 of this patch included some fields in the new rxe_mw struct
>  which were not yet needed. They are removed in v2.
>  This patch includes changes needed to address the fact that
>  the ib_mw struct is now being allocated in rdma/core.

Applied to for-next

I touched it with clang-format first though, lots of little whitespace
issues

Thanks,
Jason
