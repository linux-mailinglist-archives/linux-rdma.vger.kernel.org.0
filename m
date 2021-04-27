Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81BB36CB01
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbhD0STy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 14:19:54 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:53985
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236874AbhD0STy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Apr 2021 14:19:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMOt75QhoteupZd+2bsWFz78jjmn0IFGxiGayTrmSnwrWtg0nztsUaKEWeYtDcP84xj9L9Q9YAZ865dJsnzeFVEcn3uE2/syrVIDxFHlk9KQH4Ih+Byl0iCJggSKdYLzEOjn5EYJTC0fFuTLGpWR9uawt6GgLOrZsUIrxkKFY+kH+uEsxyZ0c+GyntcOI8ntluWq9uR4ZdjZws0dOVtok1pMm/6ayRj9ALWkymj/NkqK2bSm/p1GZ5rtSXBX/i0Ne+1h82FmLNuVuxob/DgPcRq9VGUtyud8YBpyVx4sZSlPbz3L1cpgyguTR31bbA9Z0pOazUu8QC+ZgvFvo0RBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoGcDqUbZd+Ni/2BC0MrAbhu7sbpUuBn5EDcDY8kcw8=;
 b=jMsKTDgwtLX7YeFxqaNInEKc4FBceZDHr6o1S1To8JnPuywn2AnwurOYHd4ZsvMxui+BFGoLiixwJUt2c70UHIGnQTt0fFwj2MgBP3djcCHeKZk5n6B4Kx4T7D6BigqGzTu67DT3GELV1o6KViB6F2UGTiY/r3sxPZEX1PNe9L/dXqk+w+IvzQCiok0HFbf5FacjoaIXfd2WmRXYjZ5BheTERXRxoAaXVbFh45XGCYLa4zl5AI4PNPVD4OZ1Zmaqy+fqPeUgsSNyBxKkTcLci4RIQ1065amSREUjcIW1pjOqiwyKgOYHldKTCgYoG5flZWIo6SYIkKIKgpHyd8csFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoGcDqUbZd+Ni/2BC0MrAbhu7sbpUuBn5EDcDY8kcw8=;
 b=bmdsg4Hvw0ThZ7W41Sbavul0sT44dj+Fou6DO/c8sprOHfu3qP9j5dKFj2rQ88/x6KC8FXpHRIlcwW77a5YvOse/MGSsEhGfO8hLXHjmo8wZGzuF50D8X3rc0PuRlcFRag6l2vuAN1lboaL4XuQo3pM1VwdQw7rlmvd25lNNvXTloUv0TqnGHaKPG3MufRxNgmSqD4bLSuRYNink0nw+/fMJezLe5o+i79DZ+Ztk75A6RyS6ltz6B8+PhTf9PPM2n/2wrnTAQtZZXiVIS0YEfFyYKyTtvkuTrYljOqLWCrngv+BnL2eEYjUIxe4t9/iswUNvETwHL5kyfiieCc+m7Q==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Tue, 27 Apr
 2021 18:19:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 18:19:08 +0000
Date:   Tue, 27 Apr 2021 15:19:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Remove redundant variable rcd
Message-ID: <20210427181905.GA3241618@nvidia.com>
References: <1619346696-46300-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619346696-46300-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Tue, 27 Apr 2021 18:19:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbSIb-00DbIr-Ud; Tue, 27 Apr 2021 15:19:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 745140fa-af11-4383-fb9f-08d909a8f2db
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Antispam-PRVS: <DM5PR12MB114879C275C162687F00392DC2419@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoRGzfRpzDzF6C6ECCUCioOiKk63TbFBFZlWtt7AHqs+hm3ziX+KNXdnvUpj4n6sWp2FdSQ0hhXXFPQl65O5Gh3oTvBvzDEd0xSn61748Odz6CRyEaQfHoBDWKjDWmrswDv3vF/+DaqUqk/f/cuHo4zrQdFDmo+Uy5LMK81ojWkhTdECtCkQiKQQ6ZK71IrW7JUlKZn63MlFjqcPbg2u4A09ErZD83pJV/KcH4QUu81/NAuxInev8+aojcQE5IGoBaPZIPeRjar08Zjlzq3kNUUNZoUOIr4+6JP7b+A/vdAOesWkpAusA9kqqtKJzfaVKui4NX5u+eC14c0r/3VrZBUQ27WyV65vS/S2UOfM3SFiBjj1A3Evb20HvyX1xZNvezdjKo4ba5335wZx48hXEhZKF1FIQRjz7mMBiqq2/8S4i+H7umu+Mt8NR/F+FqyiYmWIHRv0aXL2Na8A/1qoLr9Llj4TNGRnLYImQz6hitjwdenAWJpS+NC4GyVvh0yCy8tiWrc+k8hNbv/eu5LRJTW9c7N91ht/rky7nmE0nu+GPUCx5bmIprOH2xizgpf+kVKiVxZBIHbr+J9zUuXU5WN2rroSBdzmtNRgIhO700I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(366004)(346002)(376002)(396003)(83380400001)(38100700002)(186003)(2616005)(8936002)(426003)(66476007)(66556008)(1076003)(4744005)(8676002)(26005)(5660300002)(66946007)(9786002)(9746002)(4326008)(2906002)(36756003)(6916009)(478600001)(316002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?H0cuwT/+AUzJ+j3Ir4IMd2JoK3e5UkYNlNxoaSyxtOGU2oQbxdVQ50vt3g7v?=
 =?us-ascii?Q?tDZIYLHkAG/fyzlgJY/MErq6+jF6egrMVPfnc7oG0L6NltBcNSfF9myHU3MZ?=
 =?us-ascii?Q?bfhxAN3lJKIynAII6TRs7TFVs37Cez4I2Y56BxTMFJOVCamk/Ngmhwdj7tyK?=
 =?us-ascii?Q?4UP4DmdBtrGuRTZM8pe04DX2cbvYogjZ8VLGblxvcZ/6XI+/lgocC2Z3hGlk?=
 =?us-ascii?Q?CnclwgEPIDT/zCvn0JeUEGy5Vt9pD3RMHdhFc27/eeCDBtX4IkXSYJ5hLaRn?=
 =?us-ascii?Q?UGEdZmveZKDCH9DX0ozFf6bbPyoM7fE9lYATqswP+is+WNnzCepXBu6duiEn?=
 =?us-ascii?Q?qO9xFBt7Rdmxe72RCqdetXgFqxTWU4T+8f3/KXNNKgy2TcT0UZNTdr1j+Gzd?=
 =?us-ascii?Q?PYXdlhB6cbhrtnMkwhcjSnOH82+YixS02+XYurInJ3OxhAO9HyNzoR8htZuT?=
 =?us-ascii?Q?SBWId6XN+YNf+uzZc4a/vS/872heqoMlJJBSq/1b1rXHlYumzK8spH7CVREI?=
 =?us-ascii?Q?USgp7jRDNnffTow8tF0EodeeSP1+6bpmyNeOJzkRVgNCn82kBVSb7+Je4uAR?=
 =?us-ascii?Q?mT/jxo11pNJx0dDQsfNx754fWWLpuAbeLC5aKb61M9eLK/Rdy/I7WFoS+McO?=
 =?us-ascii?Q?UjIFFoXsDiYQQHqWv9qFApl3NAt+/qcr2xfKUwmYXJQ4Ps0qZ6k8rXiQBmwQ?=
 =?us-ascii?Q?xnVdFeYMVUm5LQ06PuuBO6r8yWo7kUa8v2ZO9+B26RJAHfAMV8GpAaa5FBb4?=
 =?us-ascii?Q?ITctVLSvSSKpDGJidgSLVELcVx0effmaiZZqGNUfcdQKLacwV85tr7LzSdlD?=
 =?us-ascii?Q?xSn64FjsjRS7iHCZibamaEmigcWxgXGe8TnshVAwBxqKlekBw4dgA8pGlRDq?=
 =?us-ascii?Q?VxCp1atw8DMFfRpzeacR4I9nbo6qwMZfLDxdfsz1tRqDXetegYOhkeq8fgUA?=
 =?us-ascii?Q?KdXPQKkX0C0rtECgUoRyEG/JOp80VPWEWicpxwJdUERh87vFnUztL0AKJCIL?=
 =?us-ascii?Q?ATWLHkIO8msKpYQMuq9aTrzKOHdaoQWFVrmRihdwNYIel+TNaZf1jQz0ySRV?=
 =?us-ascii?Q?M0geD3wArzDmhAvudhOlgPWzWm7t91YcrbDeCfYNZ4dtjIJosXl2yKpHNJI8?=
 =?us-ascii?Q?nnkXIy0cY7VPPDy7yoVazBx8QamX4vNgP9QalumV4sAblrcI5pdIwutuQ4ms?=
 =?us-ascii?Q?ICnPm+iyumwEuBzoIk+yyenL5Xep1Tu1kkGxZfxAeGpkzA8NKu/eI2nRUQYT?=
 =?us-ascii?Q?7D0bBdBuOg66xgfZWIEnGT8V6nmjDAT+SqlGAmuMO79misuMvGUzz5J4ndFS?=
 =?us-ascii?Q?i/bhRm3bQqbXHFHuoM68KL6F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745140fa-af11-4383-fb9f-08d909a8f2db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 18:19:08.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2qa3GGYT4WoAzGHFXqKL9HddEFbo/eBVdRFouXMCpJ9BcdoJQrNlGc8WBvn/Idq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 06:31:36PM +0800, Jiapeng Chong wrote:
> Variable rcd is being assigned a value from a calculation
> however the variable is never read, so this redundant variable
> can be removed.
> 
> Cleans up the following clang-analyzer warning:
> 
> drivers/infiniband/hw/hfi1/affinity.c:986:3: warning: Value stored to
> 'rcd' is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, though I also moved the rcd variable into the
only scope that used it.

Jason
