Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794A9358D4A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhDHTLd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 15:11:33 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:34401
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232970AbhDHTLc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 15:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDp9lwvDMstYMm8gJvQg1DQMla1189YgH6DVlyad2Xdxh2XsHCejLYvRudG+bvWk4r6rdYispAbpRWVCUwjA+y6/bujFU66b24BFibTS3qdKCtzF1RhcYRKWt3BNpiOeNcvvZBpg7mu3UUMWEgzxzYpNTGf1cDH4EcC/p0i+1tXgNTwY2XyoxB1dqbbq/fC/8ogbEvqj3UU8CoeKW+boTaGp3KSSE1/zODkzoJQiVGyjH2pBheeJFKN4CIlmLGzHVg8kli/3adW9gGmlpYWB9IlGroY3BC8GO2TLq28FtT6vMuprsZPFcmZ8+3mJKSHvoywQGkJNezsw6zHNL1uLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1NM9u4Nb8tNr54OoCGcNyRUeGWvcSkD8jIg5EAKDI0=;
 b=UY7UWg+ccoeFmhWIAWkDUT+qMlkEJEVGH27Ux3ZiRcCvlF3zRu0QGtnvhPFBfNYCyH461aCT6z5ivYfaejEIaUyHbFrfEQahhHDmsGZMOr2BviCYyr68+W9qZkOEMET3pr2MkvU0V87JrLdtK7u75j6151Y0kWcGSc64aQOgaPRoxAk15CoPTUQd14rUPIQwEhKQ9P1VuiJSSxwz9zdkDh9paUnVq6S6Hg70OJyHmvuq5Q941sVS0JEBfG0+IAwKtIBLQ6DRLZ6hs0NB4/RsnyEEaPDrX1bD04D/BybUoN6kZXAtMKiQZPYBYbYxIKslbsoygAt4EgiPl2WaQu2YmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1NM9u4Nb8tNr54OoCGcNyRUeGWvcSkD8jIg5EAKDI0=;
 b=Or5d5czomhUWlsb0sIqUAw1EkU51xQk1UKdBo/Op4t50WCqR4h810Y1G3L1Nnya69sgzYjlTUyYb/iD/LnEQ1Yi6+0JfmAf0C0oaRX9j+utV8+jjuvSkhfTPFQ+ZVrRRXo2PFvddLttSA0u5OK+inEHhwsfL7JkBxx89eIYthReu8bXP7Lq6XGMvW5WvsGi2YT8omRcrKWDODgK40lHDKem+ON9PMJxeLkAecqpChLHhbsSPRffkMJfGKsAHrcR8/v67RLK7meBGigEIe0GFl/t0ngf5+OtgSxOyA1PdU3EbB0JrOf5Oll3BXgwa20SQwfSfxotdg9+46ANIkyqhAg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 19:11:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 19:11:16 +0000
Date:   Thu, 8 Apr 2021 16:11:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Updates of CMDQ
Message-ID: <20210408191115.GA692402@nvidia.com>
References: <1617262341-37571-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617262341-37571-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:208:237::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 19:11:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUa3f-002u8r-Iv; Thu, 08 Apr 2021 16:11:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38045174-5939-4191-0793-08d8fac215ad
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203513D382FDD116EB59882C2749@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pW4wY64RLzUGQI3EhNw5oQ8Nyj6I0b9q+og3QBamP5bua1nFOzY6yZMbY4xSTYdAzvckQJ5pEue56YxbVNx5rq+i34PNXtLblYKZEu2RUHWuiAINFJsF7guVLCA30aMtiJhVq59xNLf0TuiPMER20Wjm0StUWjE7h/NyaywM2gG5SWOdg7S38LlR6i4uaXGuYbM/dTtGtaf0RsFjVY67TTWD/qyhEPOYUo8edXLoFXYEZWnUGPYCVUwbS28qeVzw1dM3wMzEkl/a1ldRZt4LmoL3wVkS5A6EgoLd0yJCk3y0uSqKZ7BVTjgzKoZ+sRqqPqMb8508XYee67iHdrvq3kFAYgg2NrNwMmvAqp+ry0JgIF1uGHOMdBIL3MHX9CHtg6iww0TsdDHU0kLJQtgbtaMSY7UjG6YIp4kAuucGpA74gIxypyi+xhvBucm0k9hRtCJqvPBlfNdLgaNiOGUMg6pr2LhrMhL22rezR/CS1lAEcba0V5PlKY2qd8cwgF09oTHscChI0s9GLeV+QCwp+STzH1cb5hz47QyaWy0wdxKzI1egyby/YyKvKuluY6yVY8i/aC0CTs55ioULFi8T7iUtz5Zdr506/jemUv2uZ1aPUfHVkvN10LcMUD/YL4sHdQ3CEtXTTykfHaGL29mC1HbvlvBDe3GhPysjpB6KluhRD8HsfmWEA8o8Wmm02V4H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(66476007)(5660300002)(4744005)(83380400001)(8676002)(86362001)(9746002)(9786002)(66556008)(8936002)(66946007)(36756003)(6916009)(478600001)(186003)(426003)(26005)(2906002)(2616005)(38100700001)(316002)(15650500001)(4326008)(1076003)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Q1ocid1eI4gl22f+HX7/3/R+2XsqOFaFjGOG1Kz25HUonqxaEORbO5ODwdIg?=
 =?us-ascii?Q?UroSZBWj0XJv1HnmbCNjaeWvxiATt5/DJVb2yXxsLYaMuSNcCN/od8TaXDUB?=
 =?us-ascii?Q?QfL7lYdp8PAEShRI3pLRrmeYAYt8y8PtaBFAwgcic56yuQtn5U3Gn32514oU?=
 =?us-ascii?Q?DiSNQ+xz1Dqrhj0oMY84905PRHvPL/60t2sVMKBFAnkZx4YugKn/p6sNqwzn?=
 =?us-ascii?Q?DEYMvXnNCc72xfanVodfy7Gcb+QOB26/LuNmH5UVV1BL9Ku2dqQTl9iqDNlI?=
 =?us-ascii?Q?hZzMWWT5GPVSGYXcSKwn0KUrAba8SmDeLTmIRWEsT7IefUbOhLsXoChKhBCh?=
 =?us-ascii?Q?utyAA5CjCA8Nr59OFx0FJgNADIwFfMMewacoGUMnQWcKMC0Rw/g8qruCRlcr?=
 =?us-ascii?Q?0QRJ3SRS7MuotnGXz4yvZC8wc0HhFLu79CDEJax9KKiGKTqZAy49i6P4Mrgl?=
 =?us-ascii?Q?ZIdjVUleZHfxgPhcJkPsjL2bKzDc1v2dCBvpNjbaBUVneGCGPpU1Zylsnic/?=
 =?us-ascii?Q?DJC1jW0+HY9cAReOeN8fvFZGtjME83TnfFQektFxE/fcmk0j+nzwQTqAB6oT?=
 =?us-ascii?Q?LiDhNDY+IDhKobCd8MVx80LNxpIVjZXduRfgXqVqIm8y6ukjdUUO8fhLuEtV?=
 =?us-ascii?Q?rHOa82s/5lBSfMn4iVKmIKgIc5TdZtMY4M0D+yZSzb7qasdPw577S8mIynf4?=
 =?us-ascii?Q?Fv/c9BjXrEVjZM/E7lzl+Efrr5YxtbTsnozKAaoQQoqIeGK2GmGDiiPSrfBd?=
 =?us-ascii?Q?lr0skHRMAOzTMQHH104u7dR4mgJvdvYMaLGXJc6eNKbU4Fj/O5K4+2JyrtKn?=
 =?us-ascii?Q?hMVTFybzOJYVblfAY9KO6CFjU6/ejE7Rwj14FdiVLKjq0uYZgvJ/vHO6bOrw?=
 =?us-ascii?Q?p6Jf30k7z0ARBrCR7C7dHrDrFfKrRg/TQYg1OTWf9KGppuoAH8jFtOjXv3m9?=
 =?us-ascii?Q?HAcjer+xGj6VHDesmSDq64N7YizSxKa0z0PpOgc5KRLb8vuUnwwtBMpFvXxx?=
 =?us-ascii?Q?XxC9xDTpK6BzjUq6lF52DgSKDeaqGnERykHTST56xnHCGb52MzbkClbpHgvM?=
 =?us-ascii?Q?POJAo5isaS8ZbP0f478RKmLMDDyBDy69pisG+e6DnJgP5V0zjuOrF/9n+uWX?=
 =?us-ascii?Q?3siY5LUCkOvWMa2Ayv2cVMI5GVOa7xZ6IDVS8iASrxoTMgQoPsE6z6XMgAdi?=
 =?us-ascii?Q?t1JbeKAExlkXBBC3nSBqkBBldHSRHGlMjWWRrTxpBmHyOHnO6PfdMhJoTr8e?=
 =?us-ascii?Q?d7dYS9eTJOMjYw2YRF+WZPQC5ex9DDD50obOFnvnP1b4GxIhraC83hZiM0/L?=
 =?us-ascii?Q?bLp4EexRDDKxmkb6d1a8Kha1O+KS/uvvLKgZUNVICZ+90A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38045174-5939-4191-0793-08d8fac215ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 19:11:16.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXMzJsuzOKGdaeiOSlZ/JfKZ7j+XYI8/Uc9ZXtwGTxh0jKGYj+yfAR076dFRaJct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 03:32:18PM +0800, Weihang Li wrote:
> This series contains few changes about CMDQ of HIP08/09. The ibdev may be
> null while the driver is resetting, so we don't use ibdev_err for prints.
> 
> Lang Cheng (2):
>   RDMA/hns: Enable all CMDQ context
>   RDMA/hns: Support more return types of command queue
> 
> Wenpeng Liang (1):
>   RDMA/hns: Modify prints for mailbox and command queue

Applied to for-next, thanks

Jason
