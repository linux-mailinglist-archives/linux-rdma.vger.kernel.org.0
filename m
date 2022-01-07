Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC5C487B11
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiAGRLE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 12:11:04 -0500
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:42803
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348486AbiAGRLE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 12:11:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmaxXsCZMlEFiwH6hhvF2agQ7IM6exY1xYSyi5ls/23mHZA14Y3Zg81yTTHVc6KWa/ZQ4IWjYH7S1tiTedOEPsfKYK42TQKjkD9SIQsgAIizKPZDzjvRi70W3W6OSvxFm8QPidCQ6f5Vn3L4482I0Vu0UWr9eleNTH8ebBylPKAO/1NNwGOBwJ7obsNWfouQkLVMjvrVkwRPADyfgCZbAmD8kERWU0dOdiro/BrVHcv113dhLptPnpRbClx/aphdJzCQ3PydQA0rQNYBgLrnoDwRM2gzF7oASqzrfs7+AWlRvqOy0Hs7gVWevFcRZzVH1BuLKo5DmgmF2AC17zHVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inY1/RkYYfH51ZSmhq3lTHIreXsYYHZFrywS9BRUS1I=;
 b=YXaiyIpurn/ID/xDD2x2BQeMtfa0aIYe7qi8dmFxIpGEwhRHJkQBFYZ3TezSM6fQkY4oP93AtQWrP0oFXMOoURyHDj2Ced0HGdnwSE9aC365syuPKuVhcp2FmPIoXEV5NxVmC5fWe1E2rxsoWhlMWE7d6rhy3tL75l+EfTIkn1IS80/IsIh95CEQj6gJxA2KNZZPDeJUkzwa4Q7mIUiRdYgyF+2JoEJ48lrmrnZ++dI2GM79ga3KmbCAV78icDpdH/P0S243SFlPGft2MmlAeDA4WGmU8TKvDb6MqW5ZRjlu8Qb0eac2x/Y0a3RGj+eNMqwhHVTTvkgLNKuULNb5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inY1/RkYYfH51ZSmhq3lTHIreXsYYHZFrywS9BRUS1I=;
 b=tm1WzNUTE/EGEAX1M1bNmHwODeDINRxXOxTrW0JpLEL2jlndt2X9d2p0wpV4tcn6be9i0As4p4nvbxzyQbItUT2eECYhrxF/nPPYNyMJe3duA1Yeib6w+lxykLwyYHXJZObq4MeM+X9ejDvOTdsh+yX5F8xSjp1pOAaSxfhT5zQLuR69y7i6+G5kJt7e6HQG2zdKsjNuQOwOX4z3mlZYGWHKRIluxA+r8bjUtg1zVSB9u/BIezOQbA7Az6BiKpciX5FNtBNO4WDcVlZ247dZn/9gRyyBhErKzUHLPEmOF8cGTsl46MzDblnt646WOYAJsm4UTx2CWZXwnZ1jyC5bWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 17:11:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 17:11:01 +0000
Date:   Fri, 7 Jan 2022 13:11:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220107171100.GA3093627@nvidia.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <61CEBF4E.1090308@fujitsu.com>
 <0a226c28-9565-55cf-7680-432b28a02cfb@talpey.com>
 <61D563B4.2070106@fujitsu.com>
 <130d8b4d-3565-eba1-c56a-58155d3303b2@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <130d8b4d-3565-eba1-c56a-58155d3303b2@talpey.com>
X-ClientProxiedBy: MN2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:208:e8::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe40fd60-40e4-4792-74ba-08d9d200adef
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5144045B584C06BD43E5991EC24D9@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05HoU8aLybVkV1B/ZlV+D+35QxTpyWVEq0EISPBi2LYsKNJVeDlvmBiSymxAookl5+R2o/7IO1FaVCzXmIb66QnUNCbSYNv9OFAPPDGQCSebOvUHQKT8w77ie84jovHHlM5YsiXEZ8dQKUB5VypYdI42BgwaYE3/AJv0288eVN6MtKJNWr8Q9jsDfIgg0xfLd1AYRlHRwh68+6jjE1apap4rBmZMS/Xuu9mYtfseuF+ygI4OfcWDIepU1o1KGv/7/UVYIw0OZi2JSoqgerZIWjJGMKh65yA1JuqPJXi4roevUjFEGhp8vLx3ov8xvwpFS7/F/3eYhyPyPM16j5srhUXY5l4PnZTw28Oy8uJnChTAn9WoxMO+sNERpEhRA/EaNF7VQn6WFb7OdAzuFbUER3F0ek0wLwL0Kzxmmx6cNl2FDevWMAEbd0ja0IgJEJqcovv4Ni1SvugnZcnb7TZZaxnmk9NjaB3PkHTf7cj4MzIulvzAJ1qYjzUzGrY54hBA6DnEvmmb+WFKUwpc9A7XDc8npo2dOUS0oMK5IAppVU+YYvNKu7YXBGsA+ximTwl4dqQd+eNZ0ma1saavdiR6VvEwKgNM+VGhjmDCNKf56qYRSBV1zitz+iETrrQz4NS3nNyxO+s0dFghPGqTTUvW9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(86362001)(4326008)(6916009)(2906002)(6486002)(26005)(36756003)(4744005)(54906003)(6506007)(6512007)(186003)(316002)(1076003)(66476007)(33656002)(66556008)(66946007)(2616005)(8936002)(38100700002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cq8F32ujZJq+ZLH/t43N5IYF5S9Ypa6JxP7yxZYQg5qV7lCvgh6P5uEMTz3L?=
 =?us-ascii?Q?6l83LaThJEUu5HEG54nGb70mlTMzDKtT+GnK0uvCFoV+DiVhODXO6k15G2R0?=
 =?us-ascii?Q?ur8TLZRak2RlXeB+QufaSS50EC4g38bWMqwJGCF6jF1VUehmZqzvbvxsFOsq?=
 =?us-ascii?Q?t2yG7iCKOg8kt3pZdKsydgO7D5eT/wlqCFP9y0A3ky5WbMCorarSD/2xSXQI?=
 =?us-ascii?Q?o2LjjsLFAQihOVPbpu8vaw53fbjTcqo5BxtEKWJPH2+jyi06Duw63MpxduwE?=
 =?us-ascii?Q?DivxeW+MILda08/2QxT37B2PxFJxMRvjOCg0xxw9hil1YABLEA4B4gNJUEo9?=
 =?us-ascii?Q?YCc9XIWTHQFZBPBJabBgQXd8OCxifpL+hGTUs1LHgElc+ZI++lbSIQdRu224?=
 =?us-ascii?Q?WVBKdD90pjSvpmIYnV/Nkky2SnfosnsaaEt86NYjtuPKjA574tWSVqtl1uG9?=
 =?us-ascii?Q?DQO+wL6DTGxLSppcL78JLpaFqltx5Ls2tctK9LIC8aHu7b2F40CDeJvFgvAC?=
 =?us-ascii?Q?f1xWvTYg3INIYIldv+IRReVbveFIE1usJt3NNYpHTFggk3ps0b8gh7va8vZc?=
 =?us-ascii?Q?2BW6c9W1rRkmtqYmYLn6N9eolDxC+ES4lNYqxWFiBWfr2jUYtvM67u8zU+q8?=
 =?us-ascii?Q?I6/LDdHH1/cOm3NZeV5H4q2ey+WKxiDTIho+ETMbsBsm1kpqiicIoWo1/6Nl?=
 =?us-ascii?Q?pIT0p4lBQ32l3Fy58EYXzH1zXMj2fT7S+TyulwttjlJlzxGGVHOx9HCjJ3ax?=
 =?us-ascii?Q?xiNRWzHx5fvaV0RqpmpKA1FNFFVVNcZgmnhLWtkObmt3xtLKbFTRVZ5F4qzo?=
 =?us-ascii?Q?hu6/1RUaI1UA9kG5RemiDYYOYwMkHqnM38br1PbU4dVj4rLVrbMPzvHz/USQ?=
 =?us-ascii?Q?uvgsvKMlXSztiGaSDw7VabZ+mXuRgONLOCBp89HODMmka5eCI+vSXa0nH+8A?=
 =?us-ascii?Q?opQF4GdoXVSbimzurHkcZQAALKDMDy5WxtBLkpDl5VMIdE1Hzs030B7JN04O?=
 =?us-ascii?Q?p2hrZwPDAc3nKsNNR5J05CfwWR5KFhhNDaIdIEnHvpG+gLt2fzCfNxVTZyDw?=
 =?us-ascii?Q?SXVu+rAU0oxttdhtsiEbTcnbE1Me3l322FBMVg6I13LTMOaNyI8LuulgF43L?=
 =?us-ascii?Q?rzTr0VRVQCLLJrkuZol1Nun9BrA5VrwhsJBM8EC9grhO804RA9VjgtxlOgTJ?=
 =?us-ascii?Q?m4omEdWMt4wyEs9gytVtpRTHL058XgDf2oMPcm1T2tihqVp5wWZ+MwDr8Zdl?=
 =?us-ascii?Q?tMlfK8kV3ReYMdf3+MUwaDRjbAPN8QQN9yxnXRjYm1N/IEuLFCs2tkhl3xde?=
 =?us-ascii?Q?O3Gnh4PFkm1goKrlPnJxcEZ9cZKH6BO32aDsmawBwQ3DUOeIDQuypTNOqAeI?=
 =?us-ascii?Q?X9O1+Ke8sDCCFlmPOd0x581CniOmqnBW1vgx4THu8LzzAvKYDl4TtyTguwV/?=
 =?us-ascii?Q?WYaWy/QXK9erNQxucYLogOitK94r+cp5lYNX+9fsKNcq572P7TanqMKih+lu?=
 =?us-ascii?Q?6XZwj1diEuDCFO+M7+wZAsKgU6cP3FzeuLfruViOimGMxqQM9pFCli/JuK0x?=
 =?us-ascii?Q?Fxs3jxSFIvJDTrtLsos=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe40fd60-40e4-4792-74ba-08d9d200adef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 17:11:01.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvr6OSH+ZNM4RDDAJtZlGcg3VGdH29/2zRrKHTd2J7hcq9+vBWCAyl1Bvu/Ab4OF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 07, 2022 at 10:50:47AM -0500, Tom Talpey wrote:

> Keep in mind that ATOMIC_WRITE allows an application to poll a 64-bit
> location to receive a result, without reaping any completion first. The
> value must appear after all prior operations have completed. And the
> entire 64-bit value must be intact. That's it.

This is exactly why it is a release operation.

Jason
