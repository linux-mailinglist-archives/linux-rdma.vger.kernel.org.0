Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300C145DFE7
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbhKYRnW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:43:22 -0500
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:5790
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348350AbhKYRlR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:41:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIL/e4q/LpiU+1I9cWtbLburpfRRdmouc2QEpBgbN7B1z8Pk1LceQTsiyKbut5HTjwtVhgbLSyWPImSyRAxXgCjrBUuZWd13xyGTqi/i2T7gfHZVCcpk5a6IkMCXStjKIo+X7hlIv9kZb/9XfO+p8GKx8uMripiBoa7BfOiYNPS1Wf6hMyUJIA6SDO1BfM06vEkyEXkhr3VrZjTwVMFxl/EvIV+wd4Ti6hs3sAjMkKzbXpYEoKICfcgdyI1OVxm4zJFrQCItc6+F7uwAduJ01tWiHrdnOR1eLUeL86hIRJioWAX9QtRFQOBEp5oE2QFQKgX2BpZYfhxQIHNqQ2wDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fml6QVUvP2rXh1m6IOTEGPWilj6P7vdyvLvlWqqjSe0=;
 b=azg8JbV4l2YAhPFIyrxkkjdCMFLca9da1o8uOLLTzWCIQhqwM7TZPwAMUma41Bhj1CaxuvSHmfUw/1ZIFrSCSsPauVjc9fW5DY+Xj1RcU+IA2V6u/R4HpF735W7osdQZzMD2bjjImZ1/xbd16GsteZFCgVWC467+ZWBdgwrF61/9TgAwKv8gMKWVn6j+mlV96I2qR2aPPkcK3QeCOHdwOGEFYrFliZI4XGw7rARCz8fEzvfhGHmDOQVK3yswKfIFnqWQ7BTWDz5mRIHbrsdhVmR8g/92wLmivsoxmyqd0Josx5Onf5hy6HOuDm6KUMGpdIIM0Rsq4y72rWjxuOGzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fml6QVUvP2rXh1m6IOTEGPWilj6P7vdyvLvlWqqjSe0=;
 b=jjoAgXVWe4OBI8prVvBVe95xAOoo9l3h3o7M24naNbPHvzmy6dUf7P5EwtFGSOaYYlvlmXHto5nTovek8p0NPliQW8qJpSX9ywSOQkdkrYhzKy8lDqXIeMpCb42UP7H7+lNgCoThAigZ7h+CmYCMnYc7nl7pJ7RjWI/3R/yRnoACoVGkoZO8SsyzUpRwJHC0Uboh4ZXyXB181kIVvaMTEDqnHYYCPtPtBIuBLTSaBhK+OL9cT8vhM21da/7UR8UmSkcDPzv5WBCQioS/KKctpoanbncHSwnvVHKU0IFoyUgXy29T5uC9oj/LNmuO5/DYY1BNElwcmKZ7LKQnpXSOWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 17:37:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:37:30 +0000
Date:   Thu, 25 Nov 2021 13:37:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com
Subject: Re: [PATCH] RDMA/rtrs-clt: Fix the initial value of min_latency
Message-ID: <20211125173729.GB504001@nvidia.com>
References: <20211124081040.19533-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124081040.19533-1-jinpu.wang@ionos.com>
X-ClientProxiedBy: BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Thu, 25 Nov 2021 17:37:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIgb-00278J-Kl; Thu, 25 Nov 2021 13:37:29 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10482adf-7a1e-4d80-12fe-08d9b03a419e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349C8405627AC9BECAA758BC2629@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1zsWQwK8os9iz57fqg4lbPtdNmjLhe/BlHtZelPImu3OQ+p6kPTAm/SznOwSl3USp5jo+liL7kZhFotG7RwF2ecrZCpehl4PIJFPgzpDmcLo8zk6DrjXLv0v4LUJoLUgvrtmwcerwHkmrAL6t55l3rf7/Xo9H+acTDse0fhE5y0RtSgPQJ0hFc95AR5e7Jv2vJlxx8FIf+BlGR3lNpD/PjDZYqDAj4gpr2Ll2B0XaHbMElRwpEhIPmK8muWl/wbc2rrFrC6QU7Pmsc1rEsWnunB23uW/BuCNLuGSRo9GUnCsmFFcw2ZoGG7vdYaqbZbJGmJ6rqOQzxk2W9czsAuI7b0LyomfOi8ZjNNGS7UOEdzP7rr7+LT3msbp3But2AJdHki0wBbEfDJVX/JiM44eHAbMcYydY85t1eltOjAynzHgQg5RmUBsIdySMxAm3fuRog21Fr/PIWK96nw425xRiE1KD2gF45QMmc1J29/X99hbXhH7uQ5IVX3w9rZ2rQUTq/XmIpoSxd1hJjDo+o6Q6VwpESXPrfWKmAoW7qCK0xlJSvr/hEqxpRmkhr7PM9rOSbH1dawb+IKolBVEmHsL70C5KMf0zwMx0wYUUmX7ES6vZxx4H+xoMZDFHNluQKl8Z6u3TQpEBJdasmGWanaKuGzppinBz4WpEsDwMa2gy4FRv27/E/supikXL1Y0h+tK4SPnN4AvadtSAey1VdrOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66556008)(4744005)(66946007)(316002)(2906002)(36756003)(83380400001)(66476007)(2616005)(1076003)(4326008)(426003)(33656002)(8676002)(508600001)(8936002)(5660300002)(38100700002)(26005)(186003)(9746002)(9786002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z5sF72FZau1HVq6DPpa3PJpzyvtysKDxy4x5luvo9C8oTPPZYFspaqNY4NIK?=
 =?us-ascii?Q?rv3DaaqX8eOvOcNRpnrf4klXvWT4mNA9758TXmDonvcDCam/yBWWbzeV3Fli?=
 =?us-ascii?Q?p6tprKKqzdaB6mpTp1qtouHLSa6CvtNl9goRc7Z+geRZHL/+5NfzCWjyUU4I?=
 =?us-ascii?Q?IeFif9wO9Unk6IltSn83Vvhj5214itXyVFDB10+NKFocPF0xIBk6oud7S4+8?=
 =?us-ascii?Q?7UTKKg1h/dPjataABTnBxQS2crQThKha05vMsLqYcTJG4TPBHgMePzoRMNbh?=
 =?us-ascii?Q?kU6g4YfKggiAUVW9tVihYUd/zbLCHbgWzA+S88dhhkVhWq7umf4nz3px/pDF?=
 =?us-ascii?Q?hbEUqZqrN2pcjrODLe1HY9sA82f/vV/f0QjH1Ia9kW+ALUi/AdezlzgdQ4DS?=
 =?us-ascii?Q?A32zdXWCawEqOEuHyGzTfkxTujKho78EYXsbnjUTbCD97Ew5+kcoYq6cr8DL?=
 =?us-ascii?Q?g5Cfd7rcIrtwnDeIeKvwJvLDqcn4YkPAide4BPr+KsrrA7S1jahnGe9mGo5h?=
 =?us-ascii?Q?hjYgecOymwE9bmrEi1G+GarBsOZedPl7vJWnQTpAQSRApM1goYe/T46FCBlJ?=
 =?us-ascii?Q?0spyL4XfwW5T//erIbU6Q4iRsvk0KSfD9q+FjWsx9nxUWtczim5nMnDEb6uC?=
 =?us-ascii?Q?kT98YU+vjL36jSeFldAIcgsbmuHsN3SZf2biR8CcJgYjZU1pDxLJLUITKR/y?=
 =?us-ascii?Q?T6ZIKdFwkAwhnCkwEPsAjemE2kFYADeG3FEnoQBmngptr0SqmPVbT9/1boiB?=
 =?us-ascii?Q?3s/UAPW1mszkLYaz6Jg+qXGCL7FQRzEW4vLV9UrjYRQGcu3UU4AVuWAbU+7x?=
 =?us-ascii?Q?75SnRtbbmlqWrMLlsmzJu9bahemswC+TqPaXUMiLtST/hM9hLrlutxWAP0Nq?=
 =?us-ascii?Q?DhojcqLnZeXNs3AySMzQGCVwqKa3gTQJKanJxk7NOF/10iorMNIgHNQ2LJ6a?=
 =?us-ascii?Q?trPTymQ9gXXPzQbHVcZPJZ+iQgQZbasQRLeIbj8LUjJeM21RRr2CbeJwLEku?=
 =?us-ascii?Q?5MFLBbAtDtMVfdov8NpILI1TYchlyGPqOR/eiyWa2iJi9VQGZ+BcQg+GVoWw?=
 =?us-ascii?Q?cNwE0FXuTwjCyzQY0VTmPo76GNjSv8ZE2f1NsK7dL+I1V05g0TFGjJovtrWX?=
 =?us-ascii?Q?KBI5D0by21QZ/LXJhVgDfrArF1PATxOlKzcWbGCfUGv6Edui7Vy5FipXuDhv?=
 =?us-ascii?Q?h8yioLXBLwu2KJWz5GwDTP4IJw3SoX5ubfIz8IEljOSf0xUWkABsmyshwZA7?=
 =?us-ascii?Q?kANPI9IlS++vhYm2G2c6gxXdTpffQVyqjD2xEgbRlqh8jq5thjw/rn7v2upr?=
 =?us-ascii?Q?QdtPA89+MM8MbWnFBGxZjI578KGK+QKV5JreWo/M+jK3adp+RJSqW9h7BcTr?=
 =?us-ascii?Q?/oZBZndVP445vm+IsvS13+5JuNrVfr65L87Lb86QiGY0QZil2shtIIQc4lUx?=
 =?us-ascii?Q?RZUc+7hZKkirEP9VUEQfUBGlQVt3LLjn42qxe1/s7SOTsUPqI5squknQ+zIC?=
 =?us-ascii?Q?UdFE4+BD9cBAiWeqSnM+Qdz87ShFKG45k1B5rzdeZF5bLHbmgZ//+s9WnNmg?=
 =?us-ascii?Q?Lz87PTV1Z9i0U10tuAw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10482adf-7a1e-4d80-12fe-08d9b03a419e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:37:30.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seV7izhemjB0ZbMb1QhXzYI6JDf53JC6+2ypJ56FeYPpKps8i6ZA1qNspN3U7QOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 24, 2021 at 09:10:40AM +0100, Jack Wang wrote:
> The type of min_latency is ktime_t, so use KTIME_MAX to initialize
> the initial value.
> 
> Fixes: dc3b66a0ce70 ("RDMA/rtrs-clt: Add a minimum latency multipath policy")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Guoqing Jiang <Guoqing.Jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
