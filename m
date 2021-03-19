Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF98342170
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 17:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhCSQCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 12:02:19 -0400
Received: from mail-dm6nam08on2061.outbound.protection.outlook.com ([40.107.102.61]:45216
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230423AbhCSQCJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 12:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuQbArTI/9P/gTKPyTtvt0z9EqhZAb2IVuj46RQ/B8Y3/mLT1B5YfsFlxNNyUmy3BI8fl1erNf/m853WzHscLstXz1VXTOegPAm5ensTfEIPUoe1rI9lzwIaGAMYolU63IWMJFqCZCJm87w7DaS0ePZ4ERr6GZs+NpcjvhO+dURq/qZxGa/4Z/qCaq54cAJ11wLYiydZmVrOwihByMZAaVByM2EmVoEXm9VcCDCTY7wqOb4CjpX2poDmb67k9abkAHtH0xgdGFrwOYxV7lhkRGej9fYzQlASrdZg6Wnb+jY4S5QB7v4Pw8//EwYugpyf0qdaDjh//1jvZT/CL5DeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tCQpBJ3P2bzL7SsK9jDd18wDzDCMY2o3s/FKcf3ge0=;
 b=lSnjzrdl/kW1gu7FQuwbOA+XvRr9RiauEMNQ6hDZwsFbdLrmqr4o6uf1Ef0G7OLFcjK7iYhoalXxqsCbG08i2FrUgkO0d17EqysLnAxUZYrrrKfV1gwpoUjW+t9mr/V2kjgbAPbDh1d+1+N2A0/lzajlgV1h0s4xWx1kAkLehlQYrTM10vdRzH6FTLqXVTuGW15mP0f7Cvfcv93oV6sBxieoEHGVwA0X1Up9Pfd8isnzSHPFq4SzSlfAPTPsgEO1m7oQ9rJwikFZiUC4GP+BIuL7Mft8THaFkgm0giQALm14/CURnAoGId1ApVAghv8kJPfqHOa5CYsV5Pv8fvpyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tCQpBJ3P2bzL7SsK9jDd18wDzDCMY2o3s/FKcf3ge0=;
 b=VLIraLZy/3Jjs4uXh7bA3TkmaWagoc215lC9BED2U8xBGCj1xhESiKM0mnNMdoX0nr8/3R53e8pQ+401wKtgcVE7qma2PI4LQl/BcoGI6fZUSPfg5b3PUIWNcfvsCa8UjlOb6bLRbbrN6V/5R0bMxua76PC/HsfdU6y2XqSIweGSSxIOe0q6a5MhoMx7RYxqtbDaDWSEYXsVqngjzimvPCL0tZKbWTlOrTU7ERE2LOg/AILoGKHHau1UUq+mDsTnSsiNa0rlSP2MpwPv/7/xuRkS5I/3RyVRuoQzvZsseq57CPmVU5CTcHO2RKZQKwHeLeUYsJuR678P4+Ymc+6iWA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 16:02:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 16:02:07 +0000
Date:   Fri, 19 Mar 2021 13:02:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kaike.wan@intel.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        todd.rimmer@intel.com
Subject: Re: [PATCH RFC 2/9] RDMA/rv: Add the internal header files
Message-ID: <20210319160206.GX2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319125635.34492-3-kaike.wan@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319125635.34492-3-kaike.wan@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0118.namprd13.prod.outlook.com (2603:10b6:208:2b9::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13 via Frontend Transport; Fri, 19 Mar 2021 16:02:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNHZe-00HLnr-3n; Fri, 19 Mar 2021 13:02:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82a51b0a-77b7-4ed4-0c09-08d8eaf058d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:
X-Microsoft-Antispam-PRVS: <DM6PR12MB277982C701A029807F6D4E78C2689@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yunELAroSrGKneDPEAQaMY9/vAiLpjiRG4vF0QLSLxMU6V1xM5dR0PDeEDR1kRyI2lxuRPm118ZrVHSeFY0zexC0bl4nc/+a42ZV1HWuFcu+XY0VKlvIFfveNBbK7VqCAjM/olPvFq74kccYeaz3YM75Y23p1TOerYu8BamfL6x6WTRXGUEdSAMIOaOXZzmzwqkHA//jtZ0pVoFA6jw/B21wRG2vYLJPhMiX3bf1DPeKU/E9qce0BU9kZlDeC6RP6aP9FQxbJDfwopPc6zxdAlLwdGQZpv5la9yiu0oU6j3gXweKfVI6W0Y5IxxxCQdf1kLkfqSmbxutZ1PvIUwsdNVqMB5hFrzi0qjJoArC13gjsHml4DsTdWBpsfqtB2agB5Os4LGdkNBH09ImyX5zH3qEgsJy8TBJyVz9Pn/I/5kKbd9krBnYRIesIADdhZT2ca4VrFJFWq6cy7qTPLWkNje0spS+O1F/4iO0aOQaG7yHrtb33slE6M5AUNCkxd6ZDqmmipsEvP+76iesXjYjFseRsyWsUkoKIVMvN1rWdJOyHK2boBaCrkutvxMwCsEt9Km0QVpaK8YmeEIlDhYasKwP5y66Qlm2277cq7yrG7ZtA8DY1ElrbtrmIKD4fHDbwq62uIkVqwqs7HZI4Tuy9pZNysd9vYN9lJ9iiH9UqRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(186003)(2616005)(66556008)(5660300002)(8936002)(86362001)(38100700001)(6916009)(1076003)(8676002)(33656002)(558084003)(4326008)(66476007)(66946007)(2906002)(426003)(316002)(478600001)(36756003)(9786002)(9746002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AoR5D6SRkTAku/2VnHS6CODcGSEvnOurfFlz29MOEYskVRvpZqHrNeBZk42I?=
 =?us-ascii?Q?wUUoeVEIdtVU3f89Wvfr4/sE+JQhEwJjcJN3tV8fbJTpQdCdOXoVn9JwRsl5?=
 =?us-ascii?Q?SWLO1ZSX88OX9oFmpPVjkJrBLsC1IGslUM5splNDAmPrliPZhJ5wn1RaeGR1?=
 =?us-ascii?Q?uAf/LIMxr88UC9w0nSsIsahPkW4C4Uyd+RFeydG8Jz4c/0vWiUr44bkE/UoK?=
 =?us-ascii?Q?QYHrkUOBwzUDWf1+jrkFbLrHB07lvpnVLf5xvOyIJHWm/MGqreI1zywuNqxB?=
 =?us-ascii?Q?bhN5pnMftkadqe+vvjqGaF25LxDczukVATseKXVj+dL5oewnbl12Ie+FvNR3?=
 =?us-ascii?Q?iZgqvc0/wQBPZV95tEnjZ4iu9Ah2cK+VjfNqvrg3kF7bzM7c3WdiwFtYArsY?=
 =?us-ascii?Q?ZysEjCy/RuaV6cChbkePD25R6XCzx8MlHRWAwOrvcbMmCzQRJ0+bJsQwgdvj?=
 =?us-ascii?Q?XpSC/0sTTOsxyMJGI/quSBs6o5+oxt72Prb3yYEPVJ9WmcrnYRTH6vsTjIn+?=
 =?us-ascii?Q?yhagWoZFxP603ePaP32bCcH/0tx4HTaRBgULDcSSYleMQPL5tlNpnq1B0L1h?=
 =?us-ascii?Q?LH0B8nr1b9jTUB0alZz96hMBMUVh6U481JU5bp0V/V/WQwALHuLXC1vu9DSW?=
 =?us-ascii?Q?w39UHfzJ71MLZg2gee0cRcTadH/j3tKhZEI5RZEO4Kxk9Pk5+mqkSrRfzC5G?=
 =?us-ascii?Q?KIqMxEsZiS/mugmlb9ljPjav+vRCrKGrngGEcezlGcaRt5BapnHYysmLmG3D?=
 =?us-ascii?Q?Lr6ePbw/9vb+k5yX5xCtgWQ7GVoP/WnN2rIoZwFMw6aKtgIDXDQh6xEv3Roq?=
 =?us-ascii?Q?wnzugCw7BK0q7LYpr6vYKu7sXtYNPmAXTriGHThX+2COrhaLrlCSZlnmkj/D?=
 =?us-ascii?Q?theKwjCSBDA1uFMiq3LDCtcX6FVZwNLKoSeddrQk6PvWHTWbLMRk9aa1YkOK?=
 =?us-ascii?Q?R4yQoA5Vzxp3wZLLlPcaVV4XQyyXiHhEapJD049mD7jyB5Ct8QoX2J9YASHE?=
 =?us-ascii?Q?f+kNWDygA47Ps+s40/kWGfd4v6i6jFi7QKzn8QbP8+0PcqQjLTko1sX5oNQP?=
 =?us-ascii?Q?HxNduILYu0oKQnNtZCwI92fRhvrYbSIthxYONOAHTYW5ZKD/p7ZUR7gXsFXL?=
 =?us-ascii?Q?9igw5iyZBoor9g1pFKuRhIV31JsDjiDfF8b/HonSPkzYPWt5I62vvbppex6E?=
 =?us-ascii?Q?e75UO7zEZWaemzkWJD3vuJpzLI+Pr/hpqziOqkQRrH9/ihE1q8SoSeN709T2?=
 =?us-ascii?Q?duvnWpIqeV8xTrkhGC4hh/auJJttxf5J8CMps5wTZSDWTaG53ZwPKovY04U2?=
 =?us-ascii?Q?gYb5rIF8/VPCnTNjOy7DqmWDPVMl0J4oefP1WckqGEObwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a51b0a-77b7-4ed4-0c09-08d8eaf058d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 16:02:07.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcmFpNDr8lwhy153XKrXaavFplUgxBs5JXFWncOCwE4PNkaDGae7WkLLtjIO23Ol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 08:56:28AM -0400, kaike.wan@intel.com wrote:

> +struct rv_mr_cache {
> +	u64 max_size;
> +	void *ops_arg;
> +	struct mmu_notifier mn;

Nope on using raw mmu_notifier, this code isn't done right in hfi1,
I'm not looking at it again here. Use the interval notifier.

Jason
