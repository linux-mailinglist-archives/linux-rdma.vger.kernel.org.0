Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5175364654C
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLGXnt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 18:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLGXns (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 18:43:48 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2A85657
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 15:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGP42YvL4YByEfxliLTi72SnVoo2WsXqJl/dXg2lBeE3aknLDOlrZ/CAbkE8JwRSyjHHQxI8/t83fSkrq8fjEf39nd3mPIriJVnZHU4RWN1Da5+5T34cRAIIS+gaO7mDigYHJ0O1/1V1CHkldH8Oa+FhWIWcCCSOBwRpTkan3jf9izcbmwZkUhpXU2fXKBXv//drbzECUSNCQ6/ORC9usPkeV1SM4M/Bsw+O5CsN7OgNfL5h9bo7YMY/7qaJXF/v2mcx1sJExzgsNLKvHTbDXXQQkHAN30D7BwnNqNCVdZh4UWcA3RZOj5SovKL7le9FZzrHcLnDyUyhI0qUQ3OLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vIurdW2xqxhbFFJHuGEQmsNBOpTr25qpbXIUo3FkTM=;
 b=AD79Ym49ZojWt1z7n7dwxRr9KYvJpU0elZPCNwcV+46P2fgP8GSvJGprWIS8urz19PP0GuOMMxT43LkujmTJSQeWjI55OZxr+45BBn8HQlp4ad4QxCkskIwwjZgdH4+WuZtzQRLZX9IhxhfwOkSuqeJMa8gr2ExDAUIFp7GQxDrjUKPSxxlrU2ljjIwHfuA8tHnifRDvzClxes0UCVswl2UAMzHlaWowFsOzl9oWU2JdxbGg/RpMIFmc/qAhgIAKA6aT6gSNQCr1Nsdc48IAy65ngml0kWx58252Pjap+jzeVUwY7Anf9bVcwQXIrGwmqHIrLDMoj8pjDcm0hXDDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vIurdW2xqxhbFFJHuGEQmsNBOpTr25qpbXIUo3FkTM=;
 b=UoOAysY4I9eRcIo49ZzyU8X6XfR+zyne/0CIpq1MT14jwu6JXKcyTorHJXFwZURpTDSlIx0DyJTyemlp3mm1zWcXBGWzNeiitpq8X/Tn9I73upbzNQUQPUxWE32o+7s6w9Ft8uDdZXWUHqfdWa6QYBuYRwqgwOe4GqI5CbOaZQznI5BYPhF81HZnHsArVeFhzcPrdVi3HEjFpdv4Q8z3OLUAeFGSrtarcYFP0ATalX+AcBdjD5JzwClwxfaIOcjUccpcr7BxcDTy+skxT4rmPPwUtlsp60JH014+4zT0GD/kSuYvwuEQ5D2Mk+Xxyliqi998QnBOXwpoZMOf59Jdnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 23:43:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 23:43:41 +0000
Date:   Wed, 7 Dec 2022 19:43:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        zyjzyj2000@gmail.com, lizhijian@fujitsu.com, rpearsonhpe@gmail.com
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Message-ID: <Y5ElLH2Lyw0466fK@nvidia.com>
References: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0255.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f03692-e82a-4f30-0aa4-08dad8acdef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeyJn135AHaszrRgNJ0KQ+KM6WgdhaayWWFb2HHnTAxD3Ce14HZtQH/LF5K//NRrK13eZQ111lnTc/P1CxpcqLw331nYWjHTJEalzIwLBim7cTU6Tt0/71baJzgaGAK7BLBXRtOTzhpcuW0teF4WSA4i7HCkkB52a17jCeGMvcduZ4LSSKPdZgrbrSXxN+6P8jIiGt7L17QVRNZVwbqyUIwgtmmVbkgm9gVWxaIVf5NgF/r2zvnaVqZ8SzXgR483nF5qIM5iOiX4dBW+Mki60SmLsd6kVDFdsr/1y3TSYAP/Xhqwd6sj+i9p/mYWLQQnilXHIfcSvShomYnTtl469BLDDqL27Fmi34FwSOv4hCtS0VryJd63h1ROf61elrf/mpcOwXp8GE4EKt2ChMaHhm0dOgeTKBtwU8KpzkK/wiKeUNM9oIRuGpb9YSpIyWPnNpRWdEJWKm2EAvuHrcfCaHwtUiHsl6zoq+AuE3Azu/hsee4aZjcep48zxjBxZFWyBJv5+sJSw7sK2ok36mPNMnKL/46BbAtaL/LXAJljLNfbea3K/xdienvsEzlKfYyi3FxxwUx7P6S3zTeDp8ap+ji3FKcxX6nIZfd9JH7EZfbNE3pzciIJU6cUyI9cDOs6X3FOZc726pyroWL6iGXS7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(36756003)(4326008)(83380400001)(38100700002)(66556008)(66946007)(26005)(6512007)(186003)(6506007)(2906002)(8936002)(5660300002)(41300700001)(66476007)(2616005)(6916009)(6486002)(316002)(86362001)(478600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NM2SO7Atss0SvQpkXdzo2a9VSozen9RJkjJlJwV2NHFnkzHCeRJWwQsxwKiB?=
 =?us-ascii?Q?NnGK9+Bfbo1CK+h4Lr+2I1GdalPJAboxxLmYlz+LlZf7okIvcWDVjwH/WNXW?=
 =?us-ascii?Q?45Gnt7cf1p80HTkpQ3bXgoHuLMd1i1nPnAp9ObW6OlmH+CoRkFkJpuPkETeN?=
 =?us-ascii?Q?vfPUeHvs4qib1SISEgNNhpSpmnskNPFXR9e5ikssQNujj30uvjpuhA1KVlRH?=
 =?us-ascii?Q?TJ/wXf6EbT9/0oLB1kB2lLxXVgPCwDjVDQLTyPW2iXscsNXOb7I4gJgD1Z5y?=
 =?us-ascii?Q?OK1M19NnEEtwAndE5F9tPVORTaHi5W2cGr2gGR2hbUFZgxM66O0uJ8t20/EP?=
 =?us-ascii?Q?2XPYED64kCxklMwvFQtiQHVJ/lPAVk6mmaQqDq2V/0wCsSKcBFKwDgtguPnO?=
 =?us-ascii?Q?ajh7g41HMtd806JynCWoywTojiKjZEVtIaCv8VPDhTX8jsrAXFHguti0AqFm?=
 =?us-ascii?Q?fh9TfTmcX/2YKEG6NYIi041j0shytODopnJnUPfbM9bitJahSFiIliQXkgv2?=
 =?us-ascii?Q?ANdd8FMXcCQ5i6o74r4fTApeCo4HZtEFhbYIMogEik4VKGcVx4vFpUlHY8KS?=
 =?us-ascii?Q?kLczRFblx5y2XcZBNEfQwhom6C6B2xBnefaLH62n2ADecZh0APfAk8woHwU4?=
 =?us-ascii?Q?hxNQ9WznOvWTJtVmBHyywZuWQnvcMQYrB5AHrMQtopC+AS5zTLK6SyP4bDjc?=
 =?us-ascii?Q?Xr+3odukkUa0BJWt1GYtAfJq/881/7dqfdkJoTLQ7PkljP47nTdZPGA9rc+O?=
 =?us-ascii?Q?d3YkgcLcDqxOWBp8OjsstcWVZD6XiuYrzrznHtBtyp4l1+Ta1vGEuBwnYUqW?=
 =?us-ascii?Q?6ke7/8w0h7pxn9XcwiuZAsu04D1VJ+rIY6Hr2Zuse8txb8PeKad30TboHIzR?=
 =?us-ascii?Q?c9+cwml0xCsDs0bNKfyNZYkc0RBHT6F4MtljtnbQ2Zyma7OXE7slIaM6eILo?=
 =?us-ascii?Q?xufHxJjMQ0RB7l39d5qbAYpsjdBQosx0QY+QZfjHSIoyoUPFuLfBKk8s7mA1?=
 =?us-ascii?Q?4b26pO7K15EOMzFnLpKGN1sgolpb+Gvu5BKItr74o9HlBBXX56D9xQFwrbXS?=
 =?us-ascii?Q?wevTENa71BsBwjTDO7aPHAYM3045s1DKXWjDaM9zKEOiwVlLZWJkbMRYdaJq?=
 =?us-ascii?Q?6AC8AWg5a5PmIhWSs5PDxAhrBRFM2zgO750LI9Krk3OIyv58nARJIBS9EInu?=
 =?us-ascii?Q?EKsIbqrb7bzdiXYiG2oogaTd266Lq3SFrRdOUTckLJyg6UgRPId/wJfajABi?=
 =?us-ascii?Q?IMflWbij64q8IzPAMRoQyP/jZ79cTIMR0ngXmul+ziKqmppoTsfzdOPZxVQC?=
 =?us-ascii?Q?9DEih3HECasxkFdkD9y9h8wSMyvmuOpaDS0lmK1OOpmNJV4/ShKdo05OnDO+?=
 =?us-ascii?Q?e3kCA/FKj9aQH7ynF9bBULptiS8KLXli0rsNXVqScEyqG4lMYsQ0amtpgCZs?=
 =?us-ascii?Q?X1tKQK2UAJTQarN9HLs+u70or5zGbE02RcOKfBwudOdMZXV9aOYm39ov8xrh?=
 =?us-ascii?Q?zPVQstcGZ2PAHmZTIt8q4l4xtgQXcMJ555WNXoU6FEcjsF8JWYfoCLyYONOQ?=
 =?us-ascii?Q?D8anKnY2kINf2hyyUpM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f03692-e82a-4f30-0aa4-08dad8acdef9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:43:41.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVCKHhZUAeIvppC0hqa+40JEd0KOiehxU4NWCsustTuiYtF85sUmFPg2SY3eVxZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 02, 2022 at 08:01:57PM +0900, Daisuke Matsuda wrote:
> The commit 686d348476ee ("RDMA/rxe: Remove unnecessary mr testing") causes
> a kernel crash. If responder get a zero-byte RDMA Read request, qp->resp.mr
> is not set in check_rkey(). The mr is NULL in this case, and a NULL pointer
> dereference occurs as shown below.

I don't think this is right.

What justification is there for not validating the rkey in check_rkey
just because the length is 0?

IBA 9.3.3.2 says:

  A responder that supports RDMA and / or ATOMIC Operations shall verify
  the R_Key, the associated access rights, and the specified virtual ad-
  dress. The responder must also perform bounds checking (i.e. verify that
  the length of the data being referenced does not cross the associated
  memory start and end addresses). Any violation must result in the packet
  being discarded and for reliable services, the generation of a NAK.

Which I do not think allows this behavior.

If check_rkey validates the rkey then this function can assume it is
not NULL in all cases, like I think it is supposed to.

Jason
