Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF43E351F56
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhDATGG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 15:06:06 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:19808
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240419AbhDATER (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 15:04:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaoL6qc9NwCt7R4L3tpeeamXZ+kDXhXuCOIwSuKiKqp5q4VYu+85gFemFgc8kAy13SJ6lLmG8JzgkkltD+je+HOA/jFX6qX3OIM0678yXwByEyxR1s3dMr18UceOFQbduebNOM3nclg228esBBiPG/aMing2Z/XyOPKNFE5d70URHvNeerA/bzKIDhH3CnGPcldMZlYSlZ9gR7cPDWmyO62uesWY56EmuyZDBvwIt2hubHNUMhXZ8SnXmvsLku/DN5a4UKct5qQKP0mdbik4SnqJ9CyDeVXVv3kM4I4bwJjEn06fZvpxIlvFLdmUTac8PvDQPOIzUjN28NmR3XMFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v+cFfWZcOi2ox4rOm0OQ6MrOsviD/NH5JEjPWJBuWA=;
 b=gLfqQo0op6rueGgyrqKhRtT8AONPjIADhxehk+lBbCrLp26VKhNpeNPTRcR426dtMovQaZvq30Z+myKzNqPtR+GzTbZYMOiNXC1oLmNJhOImDEyypu7IYcEHGQ7KwR2P2Ff+DnpFVa5SmOSdzYorzh2Bx8UR6g9YijsHtrqdUBCqL30YFg82gq3RB7v4z2ob15r4ru1+hD/ZuTxlyYOG/Xm1sw/IoXrVHEjICYcpd53J+Cl+2QQluhfGRM1zB+7ZRZwdTa+cr5IITC/AVJe6pYum8eT3ncYhImt9pWkwfsbur7vM9ZGiYtOPQGkxAPzBxhUqHO4KPPRYOHf2vwnXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v+cFfWZcOi2ox4rOm0OQ6MrOsviD/NH5JEjPWJBuWA=;
 b=gfH7ZW6ICPg7bv5xBZ+8v5JvlM4bawJf3hYTOWqI5GkYC/uKefBhvnEf64SJI3opoY5OJgK2wMFHncNCM/WbDsONg2G3wlV2uKVdm4AvXZPsWqAQxZqUGEmoMJDLBbTJWG9KA4Ku5ls0grkfgCO73Vlr0NdB1R7oiMqOUAKxLF49/jKLBAY60vzc+lr1mr019IXsrZPywaZwkJ00MNqtZ90GUt9y9Bi/FVFN43AyqEYKn9uOrReOTjJhEXRYKL+bCHCNNLcC3l+iZICYKwDEcPdlISZtUY/neNfM83I9Fjd/z8hRnhLCmTBRhXrptEotpV8A7Q70B94jVqwaoRJ4dg==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 19:04:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 19:04:16 +0000
Date:   Thu, 1 Apr 2021 16:04:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: Re: [PATCH for-next 00/22] Misc update for rtrs
Message-ID: <20210401190413.GA1652301@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0425.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0425.namprd13.prod.outlook.com (2603:10b6:208:2c3::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 19:04:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2c1-006y24-0z; Thu, 01 Apr 2021 16:04:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc92f83a-9fb0-481b-5f79-08d8f540f12e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42685DAC38CF4417497D5E30C27B9@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfo22nG40tTFtTJhvyzZ2SUqbEltdG125c2ty4ZIerY/aOLgixjpwa3X6kRuxGyRNsqwagw5ALc5f27RxCp/DDqKLGweKAzPPR+GPmS8ExNo/OAMl7qX2lv1EofAEcL0lIeiPDfYFJXPcWE+bIPhJ+640O+Tkxomu1FKC5jFB9faPO8tdByTZa3CBTl5dtpbU9LD+klA4VaZuOI/HQCh7N74n5L3U1Gxmq5TDscTpuv0n096mByVCT8XJPLfvnZwENHvN5eoRtQ4EREjHIxkg+vV6BTN5jaYW2Yb3majKRCzzr1b8ej/KmVH/0vi/L2EIZsdyNgD4E8OJ74L0sBvMSD1gr3BWKgaqYCjOEnZs4FBs3Zhd5YnX9QGCOj//JECNlmj9vziwKS6I9D0ANHd0Zmmb4paB1OOapEWvl15fyy6NToxvd7rVPkhcunuFrPb+XzFWnwDQjNDZlofpZpPBJR7wzVVkEa4XkI86PhsL1kNpsAZZ9S/qr9QSmeXBqC6ItJTyAnJkM2XjZsLmI/+xCMXoXICJekkifGMoUSMNUTJtKKvc/+eaBw5A3Vba5di3yGd3oFI3Qj8xAd1uDWFxsSKJaZ2Hnq+o3Kf/7cpxoOBUmAkXqZrRvVxDugiJ9B46ZnH02XUbvFCFvtx1gCcx8B8y1gIPpIJkAb+f9Peg6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(15650500001)(2906002)(9786002)(1076003)(4326008)(5660300002)(66556008)(38100700001)(66476007)(66946007)(2616005)(36756003)(426003)(9746002)(8936002)(478600001)(83380400001)(26005)(33656002)(186003)(86362001)(8676002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1w61lg7LftYqe2OVPannNH/G9/8XMkM3aQBiGw+3uyCMbC/t7/gBnYKr1Thw?=
 =?us-ascii?Q?fDdZbaK4roVITdTqsXRyJms9jntpsoP18srA3IphcP4EiVP/FLDe2aHBFH5s?=
 =?us-ascii?Q?DViAOlSVMMysE9OMIQHo4d+ZjYBMGjUHNtOUYuxOVLk7aUygq1s0Wj5e2yzx?=
 =?us-ascii?Q?II2GYQ/AF41A0kyOYkspuEL3ON4qc86g490CG9rcKvfPAgOy3YEPKQ6TjiUj?=
 =?us-ascii?Q?1wVXcgoXfk9CHwEYx+k0/m7c9pLVv9qnfHefO/C+4ymfc7DuJC0wlkXBNdqH?=
 =?us-ascii?Q?AqQhDRk92yUB95za6wBDq1ZyrCdAm93QkF9b0OkbT7ibDKs4RV3O6HvarSq/?=
 =?us-ascii?Q?/oiYHKOAQ2o8pmPh1kBoe07k/rDvnrr0VTotRI2biShn+LGxTJFolIEpatME?=
 =?us-ascii?Q?/mEBN8DmloOncWOd3hkaGEatBibKiUdQPN1vdYb0z9ecnZGmvF2dMvlL4Jde?=
 =?us-ascii?Q?Cl+bfL9bXUbZeU87Iz7pFnjyiPLoP0AHxogIAEQJ6TZC0H5YvNveSoQIuPSG?=
 =?us-ascii?Q?b5pUZub7BI80cmQ+g7ps/SzefMcy7w71Z/XzwwYGixq0VYs1VvB7r9JWrbY1?=
 =?us-ascii?Q?6eLfAYMcZW0YDJ3b+a55fIOuWJ916ATLmLP5P58oWq1Yiht5pyPKS9s6Bsfh?=
 =?us-ascii?Q?9EHcr1gRXPsDMN7k0zgE9puANhiV+PC74VDKhQvSk+9SiAOG3kAbm9fmPxev?=
 =?us-ascii?Q?/1TIg3VlMje4c8yzm9zsUjCFite+USve3D9lNAwZDnfGQ3wOmEO5vwlvY1Ar?=
 =?us-ascii?Q?+0ik591vtdi+NzItOCObgx315gHkjRfyNT69NWeUS4QOcMk9TrFS+V254nQo?=
 =?us-ascii?Q?xPyV885NDvXDhXEj1vnbHYlxIqoGXFIvvEmBLxvMzrUT0EElmHof4fj06Dv7?=
 =?us-ascii?Q?1ymD7DW67nNV9LvlJk0ogv0Qyx9TGj40zi6qbRKOoDzvBwptAyEzHpjpEbqr?=
 =?us-ascii?Q?/VcY81VHLDMCckbK058ltnB6V7ZXfpe25QQQsgwaDCJtMbhftxjRqj8Z7neG?=
 =?us-ascii?Q?PRGbBacxpxiCJiILDS44cbFXwtiT5DFq4vJb164XUBviTDURfDhNxicO3ZzV?=
 =?us-ascii?Q?KOJfCdb2HXUNaLjSmaDuQVx9YFph8cGHdzi3T5Btb08uCGi+8ZVjc+IbsCLX?=
 =?us-ascii?Q?grek6B7E6JFLPxmjkO3ACOREgfQkF/aI8JMuVCWeXHLWWuxYfc7XSrdgR5pA?=
 =?us-ascii?Q?DteOctOp9LU1w4KdMdVy1FQQJ4m23Z5SPB0581tuqKR10M2l4g7uVQCHD6Bo?=
 =?us-ascii?Q?UE/r/2yDO0UjwsOw7o5mVXUacQ6wNqGDL7w/sgpN5cxdpszkPLWJmq4iufz+?=
 =?us-ascii?Q?aO0mOd2iPIEpXvKV4zx2/wEnOP9sA7SLy4qmt7TuegbiwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc92f83a-9fb0-481b-5f79-08d8f540f12e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:04:16.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0cOMdRfZcP/twK2QJim+LvQ1M1L+LEoNQOugwvZTdYiV8joEdm+rhFbdFpaYKg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 04:32:46PM +0100, Gioh Kim wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to the next merge window.
> 
> It contains a few bugfix and cleanup:
> - Change maintainer
> - Change domain address of maintainers' email: from cloud.ionos.com to ionos.com
> - Add some fault-injection points and document update
> - New policy for path finding: min-latency and document update
> - Code refactoring to remove unused code and better error message 

>   RDMA/rtrs-clt: Close rtrs client conn before destroying rtrs clt
>     session files

This one is for RC, and you need to add Ffixes lines when you fix
things, I put it there.

>   MAINTAINERS: Change maintainer for rtrs module

>   RDMA/rtrs: Enable the fault-injection
>   RDMA/rtrs-clt: Inject a fault at request processing
>   RDMA/rtrs-srv: Inject a fault at heart-beat sending
>   docs: fault-injection: Add fault-injection manual of RTRS

These should be a series

>   RDMA/rtrs-clt: Remove redundant code from rtrs_clt_read_req
>   RDMA/rtrs: Kill the put label in
>     rtrs_srv_create_once_sysfs_root_folders
>   RDMA/rtrs: Remove sessname and sess_kobj from rtrs_attrs
>   RDMA/rtrs: Cleanup the code in rtrs_srv_rdma_cm_handler
>   RDMA/rtrs: New function converting rtrs_addr to string
>   RDMA/rtrs-srv: Report temporary sessname for error message
>   RDMA/rtrs: cleanup unused variable
>   RDMA/rtrs-clt: Cap max_io_size

I applied these trivial patches to for-next. Please pay attention to commit
messages, these are becoming hard to understand.

>   RDMA/rtrs-srv: More debugging info when fail to send reply
>   RDMA/rtrs-clt: Print more info when an error happens
>   RDMA/rtrs-clt: Simplify error message

This is a reasonble series about improving debugging

>   RDMA/rtrs-clt: Add a minimum latency multipath policy
>   RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
>   Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy

This is a series

Everything I didn't apply needs to be rebased/resent/fixed.

Thanks,
Jason
