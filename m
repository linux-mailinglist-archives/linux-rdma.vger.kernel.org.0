Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1A434A4C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 13:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhJTLln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 07:41:43 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:3968
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230243AbhJTLll (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 07:41:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZAND30vCxoxaW0zCB8Ni/lDm3HbK+cP4x4eqbie0FPcMvPTHxfCYCeEcdBvoCgpRpQOCMo6HpFuRd+kFASLSaWIXd1SBvxND0HsR82I9Oz170HkRuIJ/qGr/3hN/NldRJabCk1nz85CbBTA/lNh91sXDzUBrqmCsonlGYiv//R96uUrmPMXuCx9hArxE5j7fTtUTS7Fz1CLjWuapTQBkYESEnV4FLc+Xaxpic5Lztyv1Z6KyZPtSkRZzs62YQfO6rIa9OOwVQKB57CxUlwFtfRT7YES2UH4hLQBSkTo0cSadId5OAltRffgmBOL58LrjXPdW7NTbiIb0x0P/HzNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RKWp/SfcIJVipK8HvUtLgZ7L1oQTwOSwxl7p7Rahxw=;
 b=AimqfooTJB2p6IqoEMg/XnGa9fvLHVvucvVOimaVMSLN5vgKJNHlTyKVvotbdssIM5hoIXJjhWq75F211GPx+gMdDkJ3qCuH+ebRv8KCnfd1XhfFU/YVRS2wuIyw1wqtdIMpT0B2Rdgs3EUIE8lbSfRfZwbLXv81huIlIdTqFQEsKCoCTW5P4WTnfUeSJdmTUYMfTIulPOyyWQ2zql6P3L3k4uvtQBS0BZD8FKCta7wBW0JHWsa+KcpcUh2/AeCnkOngk+3+QnKaVA5LEi/9JE/zMzLeRcAtbNpgMEd4VWLqM0uOjSwZqw48y9o6PPxJgE+JhRC2Iy5kI+zd4M5mKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RKWp/SfcIJVipK8HvUtLgZ7L1oQTwOSwxl7p7Rahxw=;
 b=GlhBox5WWBCSa7+2iSXJabdW+I5YPrtNYU9jjdsdclLYawtMzEYPOEXGY+rLKPMSP82GZH3nH0nJnAL0gJ3yg116GpGL2Cg5JgVnt8BNJJcNKLfuq0WDKVlz4vhQzkdN943wyeBO5fTIj6WdJO6ijPO9f3f2zhf3VrwgMS5MR9/f8hKB0dlXdnVMNMyDFhm2mZrT4KDotjxEXnD2KP6EUZ0mQLl6po8zT9pfGK1xBuMiszfVnDUs8Ui8Z/qMbX7Ih0PI5SQWoi895Pii4wRr+0L9sAO/uNoDi/tYTc5GgowYZqfM93iKcXCMIz47kZNURbVRL3B9gVM26KsATGDwJQ==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 11:39:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 11:39:26 +0000
Date:   Wed, 20 Oct 2021 08:39:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Edward Srouji <edwards@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: 10 more python test cases for rxe
Message-ID: <20211020113925.GC2744544@nvidia.com>
References: <34a9a53f-1f1f-bddb-0c8e-63ec5fbcd28e@gmail.com>
 <20211013150045.GG2744544@nvidia.com>
 <CAD=hENcvfUbbhJ_fZ58A7KeyY74mGP2v4Q7D84nCnwJnBVmzBQ@mail.gmail.com>
 <DM4PR12MB5216785DF4827AF953E2AC04DABE9@DM4PR12MB5216.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5216785DF4827AF953E2AC04DABE9@DM4PR12MB5216.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:208:23e::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:208:23e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 11:39:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1md9wL-00HUVP-DJ; Wed, 20 Oct 2021 08:39:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b085570a-6dc1-4c43-4c9a-08d993be450e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52875E1066DEBEC700F7159CC2BE9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmUPtWRAkRdcjpVAyt1ziFYagkuBb7O5CVw61yqC4If12dTZcVOdau8gn8G6qpcE4e/+BJGf30pU5sZtJv1DXrwmAl46Wybro43MVxx+68qZqAOU853l0u7OvALeIaI5PUIDRAxDg436isE/5M+CRiabp0ALiEOxUeg/o75zRfMy7Vr/qtkR3OaofhIt3aBQYla6pTrfDMG4DR7x0Ebv8tKOTESKy+9JZ1XGPlBJwgtMdE5UtyyJv+fdpLsMytO5Kf0+sBAx08oZBV9k91PMVT4148Gd0bCSpyBr3tI3iC0Dn+b/9EpZAtwsgQRMTNdtaoL+sc9Xyck7CFv8bcwSb47gcNcXugrIF8naYmUb5cFB23ea41b1BHTsnZ8a1Ui0en36B+AYsP6FxQ4pxy4G+9z+kw1X9IvH4yVGTNZx8x/AFMVgq9JNlRk6i0X0zV4PWroTx6+/Ta3J5JSPuEzEzsnqG9U7xm59MKHXHzfWS0dyLh9ULX3+tYwZJCIazFYO3nkRGKDL6CVh3KKRSnyWy+kTziR/ivkwr3bCDlI2iHHyi0N6B4wVCAvROVypTngPT6mgwwF31xKzNt6OCJutrz0EgpjULbz7qmVRS44pxZqLv947uO15oMIKfbRF5y7EHYbTCsGX3DjQICPS2Q0UWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(508600001)(4744005)(4326008)(2906002)(6636002)(6862004)(1076003)(66946007)(316002)(66556008)(66476007)(38100700002)(5660300002)(54906003)(83380400001)(86362001)(33656002)(37006003)(426003)(8936002)(8676002)(186003)(9786002)(36756003)(2616005)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LB7C7JxodGXbtVH90h1gl9yPvKFokdXsj/6Vq+woXHuPycbGWqNRoF7iwsGj?=
 =?us-ascii?Q?Q+ZFiz3dvatDXsEipHuA+fjOMTf6h0HsEFA6UKZp4Vx9BHXdx0756+GrxMCz?=
 =?us-ascii?Q?/diCJNuCjj8wpmIiWsLXSXDP5N7g5kS2f0qaqOs8pxiy1RbeGatnVbt7m7RC?=
 =?us-ascii?Q?yCDogC+4sA7q0smi/F85xgVDYZLBB4/wifcFtYnbucJmmf16Ywikr/OjYFQR?=
 =?us-ascii?Q?tpKkKy2ovc1oqwR/ZDa1ONucMGjjGkD4t8VMOrdznk87exM17r4Ve7D2WuCs?=
 =?us-ascii?Q?uyYxIyVBzr+7BioaQzwc5oOOt6/L4CB4CT+5FAtZ4Khj7eYgoSUhUF8b5NOb?=
 =?us-ascii?Q?ht/8ISgaPAX3EFO4NBj3RTI0x/XZdPHtcMDtUmqTdD9jWYEP3qABa3WK4Qwk?=
 =?us-ascii?Q?KZTViy8o8FNnPMfsUlmYd3lhdp6xliVzBWNCHPfjcudHOD3qjnLY6heq7Qvk?=
 =?us-ascii?Q?mjbUHpLHJlz7MJIAxV2RtFjCF4h7CvK/r60aZXUDgL3QrSJ6LmUUApJ5pOzM?=
 =?us-ascii?Q?j+24i4TL5Q1cQLoShGjSpXY2RE+8bzRqgHTNDva0gmOB2EeotIgC9r5qq117?=
 =?us-ascii?Q?DMIFZdddxFMo4A6IeLOdvKHJXLXPo/tfJGvZkmnkVbXUYH4Vp9kTmQZG8160?=
 =?us-ascii?Q?35/GduVeoho3RpvpN1QC89UMhhwWPReksqN9px4HmH4fRzeRe6SaGH0Jb5pz?=
 =?us-ascii?Q?fz3HuWS1X0q2Rr/YpQbtDB2st7VvYBHMOH0I9CU94ZXYFbFTTo8Nj//+iDrC?=
 =?us-ascii?Q?YVNJTpkTa6nAjsu3jw3lxW/PNRJ3xKqcMvCF0u9w17brxh4CxavnAOkUwhTJ?=
 =?us-ascii?Q?yQsfAMKfjZ8aYiD9vS82nbhAMy2+g5OnH+x4WEDpskQBk9cN5ek4OPJFYN2U?=
 =?us-ascii?Q?bvdNpjknW9z+DbhvTJwBMxVQtsPOJ4H0rF4bxGHbTPsBW6TN7/ZZjENsiASG?=
 =?us-ascii?Q?PB6ZqiU537vDBh4v4DTrS8rh4ZfX0WE7Kdvl0RyUnuhQrbL/Crp0Fj5YA/nQ?=
 =?us-ascii?Q?eJF/9WYk7gaQungjSn8qTfoaZZlBuBmCWBBUXyuK9yZ6+Eik10prR9VFQNDr?=
 =?us-ascii?Q?jaV90FG1nin1tgH1+v5vkZMjX04OgUjWfDe7KytkgJtw/W8Xjev8unKXR/RA?=
 =?us-ascii?Q?CwRr08eXJpQZmb0S9557Gr/w+C2TXR4biXT8piO4oC4M7XKzbqj+9JLAroUb?=
 =?us-ascii?Q?GVDyXboXrkCNonstEd00eBCKxXm/NOhT/BChkLBT2LVK3epV8NFVl572gBaV?=
 =?us-ascii?Q?KVpxIDxpOd8owWRwPC2R7ifGmcSaKXA6hy1zbPu1YsGjnjICJKi3jH/JXi8z?=
 =?us-ascii?Q?Ate61NmBmC+r0JyNTW7VQy8DBCCLEcfPHMUrwRgactGN70d0avJ+MgncPnlk?=
 =?us-ascii?Q?kwQYSDJbPHJ95rOph7y8BnB8q5RiJn3tZ+bhigceqR5YDnRHfDs9R3XX83W5?=
 =?us-ascii?Q?1DPz0NrlWk0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b085570a-6dc1-4c43-4c9a-08d993be450e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 11:39:26.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 20, 2021 at 10:27:08AM +0000, Edward Srouji wrote:

> I will modify the base test file to use verbs API instead of accessing the sysfs directly.
> I wanted to do that using ibv_query_gid_ex to get the netdev ifindex, but in case of IB (IPoIB) the netdex is just 0 and not updated accordingly.
> Not sure if it's a bug or by design (looks like a bug for me).
> I'll check that and update accordingly.

IB does not have IP based GIDs, so it is not a bug.

To find the ipoib interface you need to scan all the ipoib devices and
match them to their IB devices, there can be many due to pkeys.

Jason
