Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C343C6E5118
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Apr 2023 21:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjDQTlD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Apr 2023 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQTlD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Apr 2023 15:41:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050F10E9
        for <linux-rdma@vger.kernel.org>; Mon, 17 Apr 2023 12:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbmbWdggReGCrv1Vpbp/Zc4hDvz47BAr4xO4wLNfdIW/CDVeK2TovCYqlXljh0sO0N7zT3dGtRC7ljnrZDvZWoO4R6B6iVr5HnBw3YwkikUscP8nNP6/jnTGv8QFpBrHhYn1h03Fs74TeFFQ/mj25AP4Lo0Ab8f7gL6c70Uwfm4IFkip/HlyTnn2k+a50KnYNW7+fdSZLvcRzwbVY0SfQNVpup1lO5xHRJaySUluZFJXuQ7+rdW+UHmorqTk4pmiszblLaASGrDlGHA1XvOiLHQCc15cwl/Wf/Q7hhT1K0/A0hn2zEAW+49BeORVG/b+JeHiHBC82WUq+wRtGSr/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z6fpwH0gQh+Dn5pt7c4HsYDCVZ4JX8mKkHBpTWV0ms=;
 b=ULsNMsgK7JdRe2DTMKmaS5MVL0ceHSmdosw5SIAw2Rrp4ND273Wz5WI48rIAEEGQX6cqzPWk1G54XC7mUdeka+F4nb6nDruEn0uQYTQYkgWzZYYyYZE1csgvoNwjq8vlKRbu5xbKrWkb3xOQQcMYb2fMfPPp5tL/Xxby/xkJ7Wgdwgd3YR5gbdeuvTcJA54eYza+017B46fkcdk8V6rLG/HitN9sECRg4KzdC/W5y0/bybpCdZJGLaLjZm/42ljFNhylnLbvEsitw1GvGGLMKElkBNA7qhNwGWg8hjiaecatxL8rt5NjpkVwDm2QbYLumYzaCJ21vAx4l9rwlYLToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Z6fpwH0gQh+Dn5pt7c4HsYDCVZ4JX8mKkHBpTWV0ms=;
 b=U/GaGbrFJdE1t7n5yIGK0nuXableNODhKWtQHmAL7FwvV6Uo3oMo72W1iHzudNtjgtz7fsplkeu31MKYHqJBWjyzb5G+7azTZwzGtOkZT4ohSyg5HZ4o8J+C4/DVS5JnZbOanFf+DnvEf6W4mCTVJLbYxHqpIRa4lWXse8U2n+pepYEo0XvTjYUIRC0gXIuq0BEh+oAWwNVO63RMBHUVN/Fx4aqxlUF0NUIELzUbD6s28N+ISs0MMPlqi4/PLsKMfM0kpnRzYzdsNXhevCvA84201EDLpyjTH/cTkQ69WxSrQfP2dSpOUWm7Ln6TLCnZxyCjKU2Hh9xKfnoGPOGXxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 19:41:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 19:41:00 +0000
Date:   Mon, 17 Apr 2023 16:40:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/5] RDMA/rxe: Remove qp->resp.state
Message-ID: <ZD2gyugyKi9rnmS4@nvidia.com>
References: <20230405042611.6467-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405042611.6467-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: CH2PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:610:58::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d74a842-2e73-4125-286e-08db3f7babd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+JBUF60pE8Os6Xno0z9XXSYX0MjmgnULfcNgPUlDQKvz/pZpgnWtmhcRimz5B5ZC3vMm5GuEmaKxKeh67G5/m1qmygwPA4OKhY+LicZy1fp9prse+ox/ydYU3q3xMN2zm6QAuO7J9T8rTFrxRRmPAozbn4IPQycm6IaHvQIUzazVUwFGG4dVWBiW8PsGF7I0abBvD4hz6UnjgqF5tRahybZtmEXzVv0iJmvhAT+2CSjpCTR343+WaEAASgcFYqAenLbrMQhMGwCJxDRTBmYvOQsTzMY68X55dxRIwVvEXM0FrfQF9o4rIw8dVHa90QAlgfwQuVwszPelbVh5lAACDjjfQPdupXSn3fMpwKpPfYRtv5/xKkAO35hCRRCN1z8fosT37SjpalfTqiHDAb6rmNZyRwBDZX8PsBOjiG2z5Y3DDEp7ZIXqpxx0oSi3vZH9y1xmXGS9GXT8opoIUz69zUfJ3SLxv+mL6edOFGPecn1yi6MDc6D4GXiY8VCWsKgQ7PnDP52hrcWDbnGij+5+74krPh7w3i7gW/86Yfv68y7g4mwZvaP3k8i5vG9cM9w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(186003)(6512007)(6506007)(26005)(316002)(41300700001)(2616005)(86362001)(66476007)(4326008)(6916009)(66946007)(66556008)(2906002)(4744005)(83380400001)(38100700002)(8676002)(8936002)(5660300002)(6486002)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AxSb+LoZOntTIuCabY0+YDszb8kMHnIJadEai7oRQaFCdMJgX3pQlls8FzV3?=
 =?us-ascii?Q?S2JDFl7RFwc8x25+8zPnaWXSrZHO+aQ+Ksi+Apbt56kBef9YDZECYJMoUQuB?=
 =?us-ascii?Q?HXLuzUsii2NYZexiJ7GIPjYZ9KdAMDFrbM/nnkftMrknwDZ26TScie4XErfc?=
 =?us-ascii?Q?2yJF2m5ww+n15UGieMC+iFEwtLDWzNxeLrS+swPJgjgK7DJyFfoWvyJlNwtR?=
 =?us-ascii?Q?RlbKzEGiRJ1l0VV/b03P9FYkithV06uFllebpYv1wT9MJ0U6XPdi2HwSAKiM?=
 =?us-ascii?Q?VeLEdpLvHcRwzylkr5ZaZZfiWTY49zCq4y3nR4J+hq7pkFcWhOOf6QMXDYnG?=
 =?us-ascii?Q?s8XNe7SzBd3Li1NavfWMUwKpg62an5d6skMl8xGFKhjQlMPeR0mNRtgPUfeV?=
 =?us-ascii?Q?zgqif9/ShqLqRACJYZETFOr3yZutEXqs8kUsoZcpxJgKGunN5SQ8GglVkOQs?=
 =?us-ascii?Q?RtQG8VD64E4i3GhtfFg1+jgkn4eCczbtx+rIeq1BQyGYkDDL+sEG7rK0WFMx?=
 =?us-ascii?Q?xDDsOiFJvqeKew4/bVJBdq5QmJ31vhzhTfeSE06g87xQcxSXaTMS2zCv3ItI?=
 =?us-ascii?Q?bGyN8x0htZbUJzksDUNAtI/MPCWVbGHcMv+ORgPL18dgpAWpddK5zyWl4Msm?=
 =?us-ascii?Q?bErjLSHODwk8VJhzVx9/lsgzmADrxt+tkHY6bnzchiA51HkqNjaiIDXtpVk2?=
 =?us-ascii?Q?kqbzmjofalciLpUVRY9DlGKBOMnK0B+6wAE3fXxEEoA371DyOCyOrAoVU6oX?=
 =?us-ascii?Q?C6mGcPJw/mhx7Wv0dyctEu2wFLl8L8NDclqJumUgLwzQTTyvRbygz1qDA4it?=
 =?us-ascii?Q?lt/XU76adxELKq0AjVFk+/vLMIucp4Bb2JgnsZYZ1Q9iHRcYwELxMP5BPeEY?=
 =?us-ascii?Q?noiKqKc/5E+moaT/xNij08QjHOkHx15uU3u+VzUyIfSpNP78eC/r8D278Ids?=
 =?us-ascii?Q?fx0f5kfdZWu/WQ7yZHdJWAPzJbyBShMoMMUdCUCQO48x/JaLGzf/GTu3NMe+?=
 =?us-ascii?Q?ZFAWPOXbtJ0017Gcybi1/yWRSiUfDdwK0gqAUaRUFBcZPip0Lt+8KVxKPNtj?=
 =?us-ascii?Q?GRW4bXkxEtTbb8CZ9DLnvU7ssUQdh9ZGamW/FgHkj31hEUccQRhAlDD05fRo?=
 =?us-ascii?Q?Ygx3mkpb6rGn5Kq8wPjfygCgO7kVbzcTmB192MEEmWIvOIkR+tlDDX9aFG5m?=
 =?us-ascii?Q?8WDwoV8jahA6eAR6Gm7Mj31zzx4bXDFVgmIeVAxjJ/l334bsSkPh/N0pgnEi?=
 =?us-ascii?Q?oILfF3rkTKJrMmQJ4YD6XCSi4oUeyp6M7gBf8mQtJdpNxuZfcue1cpLuayxp?=
 =?us-ascii?Q?MxBei7OPu3MOqu7QpskTv44P9lx/zEeooe+YXTq2G52witrMC4Aog/KO7pCa?=
 =?us-ascii?Q?FXfEN58R8Y9j7nLXyHRUXIIUoq0fHeXJSjMl+zYdPVWMTqL4FP5IW6BNpija?=
 =?us-ascii?Q?hlcT4vD+lXfWS0muI+popHJQByTKGEBEPxIXXYq/5xon9eVStsPu/ZruvFB/?=
 =?us-ascii?Q?dpOVHXMmn+A1ipBaXhq3rUNDirHZhGuV/AZgSrQbaPt7KCmPqH56DEiRBicp?=
 =?us-ascii?Q?wn6y/dh8I3unvkuT6Yb3V6UNTqN30f+K/UT/NvhG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d74a842-2e73-4125-286e-08db3f7babd2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 19:41:00.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUNsfDv2Ag6cdj448WWDdflV2m1fL2Psqm22xVviLyOfUvT+0KFW5shIN/Jub3S8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 04, 2023 at 11:26:07PM -0500, Bob Pearson wrote:
> The rxe driver has four different QP state variables,
>     qp->attr.qp_state,
>     qp->req.state,
>     qp->comp.state, and
>     qp->resp.state.
> All of these basically carry the same information.
> 
> This patch replaces uses of qp->resp.state by qp->attr.qp_state.
> This is the first of three patches which will remove all but the
> qp->attr.qp_state variable. This will bring the driver closer
> to the IBA description.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c   |  2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  5 -----
>  drivers/infiniband/sw/rxe/rxe_recv.c  |  2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 10 +++++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
>  6 files changed, 8 insertions(+), 14 deletions(-)

Applied this series to for-next

Thanks,
Jason
