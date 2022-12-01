Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8577C63E6A0
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 01:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLAAla (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 19:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiLAAl3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 19:41:29 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281058930C
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 16:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCnFDmJTnOPt/PaMYEdLstuXrA1VVfZt8O+WYsNtYJolvS59cQBpycpEK7DCz9fWlGjBE20i9Zn18Rpg6iOeXWgmbsoD+ugRs78vg6YGA0LCSQNs37/FsI2auHnUh9SyHS0vUUNXPLm2B2vJoxGEw9l0o5zczuzCkthG4IlbNvdD/lxJ7uALprw3H7meSRxErovXEYwakHg8JnDLWqD/xpkfWWawJsKrbgEhPlaW2lR30BizsClqYiHxFTORwYaRfZ5kNXkunutJ5ri5KsFgeFT4igHRSCW8QPcrg2VUPSk+VpJoc5nYazKDVRxnYRSrEsogtaRuaViQ1Z6LqAUDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgMeEVeeZvBJsk1dQW8w8IzPMgrDauno54IYU6ZKeQY=;
 b=iQflQWRYu3HZtadScqX0t6orLsjG5eYf7UilNU6mdgp7vDJfCV1M9T/xA3q7xemb5xYwLeBeF1bOgWhzWnE8kNjJ8HE/PVaZjojo5cNCoIRdUqfm0TcZGpzJgFYoB+Uh6FacQUyBYIXIZDBqIp52V8j8obJ74JWS6eh1QkCOnwPRtROWsfBmqpCLfWHPHiuL61CU2KfuZZ0w02bk0WsHrTbgQc6mhw7Yd2GNxrFfBuTcYpNR1wk6lHuTPeVHqf6/NgWs3LQoBOffOlWiyLWsbwj/xO6ooK8Kn0FWO+2VUKKg8Q8zpLXXRzD7NmlJFn/nmx0g6KEOdb2F7nDsnQ9IMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgMeEVeeZvBJsk1dQW8w8IzPMgrDauno54IYU6ZKeQY=;
 b=UdrS3NhBpFZHSQaBdyMSktvUQ0voQYXPtMycB4xP2X2o91zxmqbxiw+GfhiproSJZ2QwkUtn0SxTnlVWZVpLKskbk9l0qq0OCuJcB9nOzK8oZWXCTD0E+iQDzg1koXc6ftQjqVeH98u73UOaSHwpfuGnV3d5L33AlC9LpeEUmej6x06+7xSIiHsMdfffzOH+8cv3ycqmaR+yY1vfs8AcaVWTiar/rLDLepwvLCWHfDEljhHHzF17QRD+YJhQ9eKEXNOOc/5s/RN7Igf9iY3BHn1QPOxuzD1A2O09ewtdjyLNGW8W9mKqbKmXGhMwV4nfJaFhpbHbeUUwvFQYcuPSmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 1 Dec
 2022 00:41:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:41:27 +0000
Date:   Wed, 30 Nov 2022 20:41:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Message-ID: <Y4f4NkV+4ZbubQjp@nvidia.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-6-rpearsonhpe@gmail.com>
 <Y3/Bqa7obMROAtr8@nvidia.com>
 <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
 <Y4fo6tknpuCveRgq@nvidia.com>
 <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
 <Y4fzZk7D9GgLNhy9@nvidia.com>
 <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0024.prod.exchangelabs.com
 (2603:10b6:207:18::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: a52adef1-c9ec-49e8-980b-08dad334c7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiuzvVNZFyWNIU5wqPe4wLXruNq2zLLqZCS1sNRmN3VKH1k2JFOrqRX8umCIChsxIeMbGhv2rS0GBYcFLRP8a5TqE0W6bSMmeA2Z9sdEcNKxclVNwCNsG2ZCxkm5K0TRJr4Ot0+dJvmnqqW8upUPd9r9zZowE6b8CutvRWCsJsJu2gdATOB14uRW4YcyiFdx4da17EaxUj1ic5IMLbYE+ZaOexm+h9YjSIJ6mO8UfsK6QwdT4wNv8XMNVLS4bLbEX12D2HuitWbsdTjL9+MeDuYfPyZFxEowlnCtAw9oEUKutb0mM5vxbwRcn6iFCDnw6T4riYjvjg2vuLRYpMmlXor9lLk8W57TLPXVtN/7hR+IK0wsz+TEU4s0o0z7Jz1QCRojnfOXw0cI/IG5xFxxGFa/KKr63AfYo4SUI0NfRbwylStEkBhqLj3Lc9FLqjY8isvJ0V1tR5hjXnkoeqpPIFnyhPGGrDfPIbYIDStByZxdqWnQegSrc79SxASrDlex32RNV9uz9F64nVVldJQ9U7eX772BysibpPp8VQClVitwMlGRUl8gFngg5rIIJtL2pZ86k9Sh2V0hXJKfjTdfeidldc3mFlh0V97fnwxzSFtsMn2cDRk0eqwdWucnuTFdyckzQYrF5k0MOOGj5BHk/vS1AjstTUKcnBhsrAdfpgn84BOzZRgi2IUSizQVyQ4K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(66946007)(41300700001)(66556008)(4326008)(4744005)(8676002)(8936002)(66476007)(26005)(6486002)(6512007)(478600001)(5660300002)(2906002)(6506007)(186003)(86362001)(2616005)(6916009)(36756003)(66899015)(316002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YRGWS+2uNAmCxU064BITjxKSsKUO3+iMH/rAXZ5nddqxRAOlekPJSPewU55Q?=
 =?us-ascii?Q?KJrrTlSHp+LKuaLyXealaREw1y3glHw4VAqQrqLR76RWLqtQMBXu/aMOBs+E?=
 =?us-ascii?Q?EiGhXW8w0GDspLygIE+g3WKreKZpa5AKLn5v0w7gPVsFQ1SB61KWF/1K+K95?=
 =?us-ascii?Q?bqwifaxI9nyjNL/niIZWYWamB4yyxAv4N6SXzWq+LXEuiqkZc5t2/AKCD/S6?=
 =?us-ascii?Q?2pcXe86XahuxluSTLVfgTBi0yCVpHfOaTqR0RLaEkMdBhQQmZ5PMBG5X1CPA?=
 =?us-ascii?Q?Otub0qElhOb73TDJW7X/V46kLF5Vy4ITdd683d26bG6Y9XGl0kxa752KM2va?=
 =?us-ascii?Q?2DJnBZLnlYyQh2N0ys7qOuncxCbhKFBMbunZcQBLZ9vUO6jNNGAlgpgkmL6l?=
 =?us-ascii?Q?8Bt7fkiV4ybc57pgKKjuXqsL0mCGTZ9TLUbySv3jQUHk9LNQdJan7RWJVvap?=
 =?us-ascii?Q?96BDO4GvJ5ANaY0h65nloh4SVCWuZ3zHTZFNeYhqYAFDpBKEpOKZI2QqmjAO?=
 =?us-ascii?Q?DApGDeLPUb1IeS9b3gsjT7IzPedHlKXyJ1IYcS6hK9kUbHDRFYNNrtuTFn+5?=
 =?us-ascii?Q?/tApAOjPm91xzHuCRubEmpcUQjlraZL/L6YOisFnOam5mk9zUWXXl9Va0/t9?=
 =?us-ascii?Q?f3V4S8zc5X0P/zF02q804HY/6t0LD6erXn3Pa0+d95o9lvVnkeRdCd8eH8zw?=
 =?us-ascii?Q?dWtSjw8eWahfhWbVYGsPiWA9FbNvzzPQ+xF1FPXxlV/SrJJaA8sIuOmOFMxu?=
 =?us-ascii?Q?bQwPpfa5fo4/g9Z+0vXJv0C6ySeHMUDkheczcfprMSIp2HFNIlUNHn4oTKkA?=
 =?us-ascii?Q?2RrqDZSlaGNNsOFh/+XWIFSig3q9oKOomyYI8JHOgpfdui7OMRNTMzzGFfsY?=
 =?us-ascii?Q?503h7LRQE96RgcKhNe9HenV0GbzK0BuB6/XQJ++vImvZqoh7punemaubFvYz?=
 =?us-ascii?Q?UtmQnz0H7i8EHgz9ah2v2VVHh/aI4pPaYBbUjCU1xmOs+HkAwHKKhkpCMqvT?=
 =?us-ascii?Q?FSNztpY9levtVnLLJ0LYAcgH6Cqul2oi2OW55UpoBDJ5ZrvgEsMJnfCaw220?=
 =?us-ascii?Q?TFUA87oMW7b2xHQeTYkP1K0R0nCRmY+P7NmIyZoZ+N9NBIE6HmgJ4qCATGZ1?=
 =?us-ascii?Q?iXnR0skp6RTR01CD6LAoMlntrgvfW5QDfNH/xZKbECdYbwDPLqWEizrz/i8a?=
 =?us-ascii?Q?4GMEJ8qFuZ21ijZC3B8MbBTkNwJdt9cZ5ph4drI7cegIIpRNp0nM5/xwoSCN?=
 =?us-ascii?Q?/gla2Dq3dsOMGSHibCEAPJfbI3dm50P+32jNxjDgsRyKxgsVyCQKPBSCvSEM?=
 =?us-ascii?Q?ybxUGdCkL8v8MtRjbO9K+pe68JIV8Bg29ZWx8rvKHnYtOgriOef29x5AGQB+?=
 =?us-ascii?Q?q1+WkjeeooYwUh3AnSqSD2/Feh9PPu1iTIS5jYdYk51d8qhvq0/awFPPdLcD?=
 =?us-ascii?Q?DxeyQx0PHRm1dKS5JzjGzX0w5L/99DMRFKH61o2Vs8TiEpKMRYL56JjWXvb0?=
 =?us-ascii?Q?d8rxc6refIUq3SO/8eBTaH95WqieVnW9d84VLvfWE8S/emdWFLMcZMBrUIxm?=
 =?us-ascii?Q?EXNBikvBurvik6dhp54=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52adef1-c9ec-49e8-980b-08dad334c7e1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:41:27.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m47aDTZGJIk7iW7aOBHeLoy4lV/dfa4M99rRgkSpVRZUOC5z8icOgF2/B8abCtg5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 30, 2022 at 06:36:56PM -0600, Bob Pearson wrote:
> I'm not looking at my patch you responded to but the one you posted to replace maps
> by xarrays.

I see, I botched that part

> The existing rxe driver assumes that if ibmr->type == IB_MR_TYPE_DMA
> that the iova is just a kernel (virtual) address that is already
> mapped.

No, it is not correct

> Maybe this is not correct but it has always worked this way. These
> are heavily used by storage stacks (e.g. Lustre) which always use
> DMA mr's. Since we don't actually do any DMAs we don't need to setup
> the iommu for these and just do memcpy's without dealing with pages.

You still should be doing the kmap

Jason
