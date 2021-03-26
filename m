Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07A534AA68
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 15:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCZOrh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 10:47:37 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:12833
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229986AbhCZOr3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 10:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULVQRALxlBNhl76oVtPVshHoCd0PkcfAD6zEjALq7MTmdeKjUZGEWqZeNxkZxcGighJOVdZfex+V481FBDvk/ssyMCqzlU3Y6RoEB8g2qRjSUzhyayAjOHIbf0cl3izuvzaRl0bgLODkpQrzZbMwQIKlYnjZ88MouqpFf+poQj2XQBbFXOCbCu0UXMYG+6oZLXYJhCf7x51OuF3LfZ8ouS0cOvRovGh8Nh/gVg1AFCBWVzNgaG/ZxnoXArKTFgOWBst9Nw5QmCn3B/UTTaOsEJsorgIhRha9djqVudKSEpBS3RIqYobTOFqSXT0Csin6lekHmD1dHw0/DeyX7BQu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G312ZHcST9Fn+qnQhSPmskaNLxTikH6F8HNQI7IEWeg=;
 b=HAMYuhXs+7JAwI0jKFfLJZm3n2Zr2uQd++L3/qdO77b/BCE3mcypFHoRrUw2i9In1Gwv0wshrRvAsCyspYqHI+j88XIVmRK4+ejVWyKA7851cNHOP2MjAPmtKCETPb1BdM9eojEV5B0V1oG/qd1nF3UzizFuQW2rT8GVguW0bLOa5vxOxlhbU5mjnL4PgYmOH779nwerxMsVcbOdU/OxU+RkjXwNBJEmvf+JsUwNi0Hw7wwWj7BdfTOeZpTw1sa4wwbrUNluIDhj/JBYMo0nFWRH8ZPZ/brrCtJ4aj/oFEv3bm2tPd6N7BXT0qSdEpsHWOwqG8pG/UXJ4vN1zA0EyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G312ZHcST9Fn+qnQhSPmskaNLxTikH6F8HNQI7IEWeg=;
 b=OyHGP0eJIOHWN5oBOX7JLqwm1uscfoLGMBQOjjcf7so82fzJYe+ndkaAFDa5AVFfXpQCMVIZOp54f1PrZnpo1/gabr5rAaj3CaQm5eyDGBnAjSJq2XR4GDzdOdBF6l5pdys51gfd+ytW+tDCflTkUWgtc/7vMesVVyMh6gboRZ7fw44yAKMtnlqMhVkI7Eqs7l6Q7tdfe+M42RATSFG9t53p10O2DHYBDpGVRjbety1Kqn+WMXHxQSrbqNc3HSPAAo58mS7M1Ss1MnY4Kz3Aig/S9P7W/GjVNMtnPbSWFr4+tUi3nbhyKxfN8DQPnUkljgT8XtB8hJI21/D+w00V7A==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 14:47:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 14:47:28 +0000
Date:   Fri, 26 Mar 2021 11:47:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next 0/5] RDMA/hns: Refactor and reorganization
Message-ID: <20210326144726.GA845659@nvidia.com>
References: <1615972183-42510-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615972183-42510-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:208:257::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0032.namprd13.prod.outlook.com (2603:10b6:208:257::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Fri, 26 Mar 2021 14:47:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPnkE-003Y0Y-RT; Fri, 26 Mar 2021 11:47:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca554db3-1e82-4775-eb27-08d8f06613be
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0105EA95EA644CCBF341AD33C2619@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZMqqt7rlVkxLZkMQ8MpsiXM5VW3mI5FlFpmreO0McQFQD1OAMXmB+EO7ZOcoQb5Vg8XUV8y5jFL7dm4j47S2x9xongfqX8AwVuaiBYoo7sRwAIEqS+nACZND8yNONm6G5kexMW6Ds8S2CXr51qXefhatwKuzsnd2GZDaznTQdRHg+2nY4e68QKyHsDEN8RjNnZcVBJbNAV35YnV48QY6UZ0dZQPIjCrkVKSBoRHtcnMBgiWgSm6LHax3kB8dUo1mwcpVF1l5PXSPFOFLVtQYoekIxfNMmtk3hVeBpji1W27JRLqHu9lYOMpYitZs1NgV73WtBLdSzxHmSD0W2Uj25agy6yCEiq9Ww1qomN04Vt3tnxhsQKCHgMBnaAVgTCUfBdHby6fZRsHD7RMT/aN4zCyM5AnWh8/yz36FeqLhD/VQ0ADRCg22vHDR8Uyc4VmLDcy3NzW4/G4lTglkQOO68bDBuWpOGKViaiV843CZUwb+0MdO4zGKOQmZCMy1Ltx0tOhSxrr4KoZZq6xNZU5fMlV4pWBhR/Ye3xuAnGm6zS4dsDUDFoVDO0PR2qpet2Dg5bzgyfXylIIoLms78ArFLqpJFNaxSXOkw+VACwr40YrkzFl60LT5XxXarAd5n/8bIm+pXbaSMPKjhyEO8UGcMPiksXef14DgDGJ+GzI71xgO/L1FOxghmKA0ROCABUL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(86362001)(2616005)(8676002)(4744005)(2906002)(8936002)(426003)(38100700001)(33656002)(5660300002)(1076003)(6916009)(66556008)(9746002)(26005)(186003)(316002)(66946007)(4326008)(478600001)(66476007)(9786002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?duRUl/cSGy7uWDGf49keie1ZHFcZAZFzNDOKvW8GaANlY6Alf1eJbxAIwYu0?=
 =?us-ascii?Q?xhL2LnDCInB4qLkHtZyiQf4yGo8cM9PrfBiBOTd+S7JZzNc6Yu57WlEPW1os?=
 =?us-ascii?Q?edD87SRHoWpkh7XKEEL3Nq2TGSJWIha+zcEp4PYnwZWL80zgWS8GfVqMtw6K?=
 =?us-ascii?Q?Fn4Ye6zpb2BKnDBpbVbGk1BBHwOj++9OLgcnbHJVq/UmUUi68Hp9Wcp0QW9w?=
 =?us-ascii?Q?/ue0u0Co32VODqzmavdpaTx//SeUBGWpJCnqeoSkmQxftu3LcEQN9ikJmS/e?=
 =?us-ascii?Q?PZ53vRj6Vr/S/Zl/oy234r8zpBms/cMMNuPfUzC1/El38SmW8701Veu9/cLu?=
 =?us-ascii?Q?bIAMHtR5J27c2yCjWmMNtGUPUrq9Do+KAD3jdufO5Uuzc483Rj5awe0tF8M2?=
 =?us-ascii?Q?bucU3kL0FUGfdKvR/4+ZsBYDN7+Bd8Q3uRdniR99sWSS+boJO0I0yHzX2qlL?=
 =?us-ascii?Q?mC/57aBOYVSfZ7BFdmUxbNttXl0Ih0MVYNRd9EIWkw6WCFdhIhwTssDHrfdd?=
 =?us-ascii?Q?xVvvGW20LUVBFnV66Rjfs3vNEg/VRnOAys8K6STBMqGlJvGs0Ejgic5cLB6s?=
 =?us-ascii?Q?/mTztj+dw1Rk1J4i8FfaAJW09HPHj6UvHbl3G5Iw595P9a+aY9u9XXAmWBBE?=
 =?us-ascii?Q?jHXyIzsDB1V3dL+BMwaRqzonQ1jSB2Q+EMvV41GopQPscM8LiANIy0X4rgYz?=
 =?us-ascii?Q?o2c+6cBE3yHNgCXUAJVUE15/TPJkeQN7fHJSpjah/r9435FZuOq5cHC7MlZ6?=
 =?us-ascii?Q?Ud/UssWea0/8z8SPegAiAQl9o7F1OnPtLAdZl1gvwilTgtx5b0toXWANl4ZG?=
 =?us-ascii?Q?1c6KJOrE0YiPdg4DkuZLXxi+ozA58e9IO5+cgwTJxObUCkl7x7rfL7GZWMeT?=
 =?us-ascii?Q?0zqz1/3W3pAmu7/8tUHuUjC7oif/hf1319G2ZZYLgfZIXfq4nMzQo90Mjl8x?=
 =?us-ascii?Q?uxh4/s0Io/E1xcRpp5vX0ywcvQLL+rAIdYDHaJlymyzv+y4LiZJNlHq6qmqM?=
 =?us-ascii?Q?l8cdbo3mWK86Nj8xMrc5OTXVVZqVdYxKKInR1uHbfPxzql2Fj3VOlBUIAda8?=
 =?us-ascii?Q?+b01J/IyCCK53vqF1vk3rAi1VV2o6PSWl7q2xfXRcaVK9o/7/KOU1vD1AoZ2?=
 =?us-ascii?Q?QgJdAaYuLZi7tlLh/N01QWw2aZzANetIbi7tfXafvQaghK0UNMJnJGPDysum?=
 =?us-ascii?Q?FHQRx26uKj+ADPaO/QBJKWio/f33nW0aalhoc8fJfspt2JsH4JDMTpaVkXF1?=
 =?us-ascii?Q?ihj3jCmVffKSGWSoUSNWWRgTC8ZWWSgMZ4ZBv4fBt7Wl1EugMLC+CjypUh9j?=
 =?us-ascii?Q?BRWDbOcZyI/iQYbkWZ7JFHs5yPo02LPUst3/0LJT1jjSyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca554db3-1e82-4775-eb27-08d8f06613be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 14:47:28.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lg/CWR4qkKlNHDmH64cRgovX8/e1aq+olUHKqj8EPIm09ISGtBmrLgv9uKVEmGu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 17, 2021 at 05:09:38PM +0800, Weihang Li wrote:
> Refactor the process of polling CQ and several control paths in the hns
> driver.
> 
> Weihang Li (1):
>   RDMA/hns: Refactor hns_roce_v2_poll_one()
> 
> Xi Wang (3):
>   RDMA/hns: Refactor reset state checking flow
>   RDMA/hns: Reorganize process of setting HEM
>   RDMA/hns: Simplify command fields for HEM base address configuration
> 
> Yixing Liu (1):
>   RDMA/hns: Reorganize hns_roce_create_cq()

This series doesn't apply, please resend it

Jason
