Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1CE4F1649
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 15:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352805AbiDDNok (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 09:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358692AbiDDNof (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 09:44:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B63E5C0;
        Mon,  4 Apr 2022 06:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXy2WKXXFKNbCjTC2qahvb87Sxs7covHdpMXqmSdcVl0g0b7EkeVc67XL7e4YWLmMRj4UM/XOpR8yWRPlcu/aWk9wl1kw6ndMtA1Kfq9cypDTblorknQcuAURyRdwUvWFJM3FRxIcrcwTVO9aZPEUiHOAryv6vlZAeNkftA4DRtzRAOmNU4ghqw/noRkKPAxGnwT+GvsxPN7+YGv/kYCobbyH8uzxaw9qwerahyf8mJt+b1XELP3tMXR3nXzU26AyZtvqxO10UwHYUMxZr/hVXsj4INCG9VeKV1gM8d7Zlff/s8OsPX23JxUL91IxJHca9gd8Z9rltVZMi8LCbE1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQC89sjlu3OpJc585lX5tjE80YKj9sPyBw9litizpg0=;
 b=SOdM8aPt2tgITOFXy8vM38+72zut34tIdsHvv2hB1B2X1UN+ZzbBKgQ6qJXfglytFS6vv0Uz60GuazKxfM1UDqSlfI9AGSdTKiJhdtKMxdogNjTBp6grZl/c0o/26A+WlKhswljblf6dFH4tR9m9MjwgBBevTzaZm67e8yFH548fzpnBNXV46H9UCnGyZ441jUdJnF1q+w2VtWknY8iXWtt1hm6tOwqQzgSjUjRaXPykqkj8w9jVQkuVKQYxNe7vpxC5GOZtwyIuWfbPOc0CUhATG2rtKsYE+5F3JAE1cVx5b4gFNthCr1OfOh5XKjZ8dmR89qo7HuJYctOX1YgErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQC89sjlu3OpJc585lX5tjE80YKj9sPyBw9litizpg0=;
 b=rSnx6yUTjZbYAiET0ZROoZN0FXgYRFaROfEUdI7ttXkFT+yBuRDc81LIAzoS01M0bycCCBQhdBoNzJ/jPyvi9Gw1ctm/BRPa/tfXhx4yqCCtmc8xm1YBQYN3cGQPxqo1rRoi9JN1Pp0WcyJK9oYAps8EGcXevJhKYsZrridLkSNaDqDdmeVBOtwo6Vz2AYkwRJqZ/q7UL6PmHUZQX/Y62j2KcXToN/ID7KbSJFHI9s8h2h0c2dIX/sYQwXajZIh/YgM/5PGN62pV49J2JVL1E/iuXNQYdWs/WF+X/QPMVUC4upjuUxtBvwoc2/+2J4BWQwlQDFn1iSs65xMrNV82sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN7PR12MB2596.namprd12.prod.outlook.com (2603:10b6:408:29::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:42:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 13:42:11 +0000
Date:   Mon, 4 Apr 2022 10:42:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niels Dossche <dossche.niels@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH] IB/rdmavt: add lock to call to rvt_error_qp to prevent a
 race condition
Message-ID: <20220404134209.GA2905506@nvidia.com>
References: <20220228165330.41546-1-dossche.niels@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228165330.41546-1-dossche.niels@gmail.com>
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e50b04-7e99-49ba-0aee-08da1640eb32
X-MS-TrafficTypeDiagnostic: BN7PR12MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB25960705B86F277A85966742C2E59@BN7PR12MB2596.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq9O4hzHl73comRVC403wKBHZ65VJEtG7lDw03x7zAAAjShhV7D6WrtiV7BymjSDGYBkLRIACeYZ7IlTJTuziyCaXbAagPYjShlCoahQfGMyMWhK6UTfjmPhkhU8fzia3kn1zodevtOA5TI/bVGdHwOKndd+RyxtM5qBeIH9tMYX4AMFgkmryBhVnasLzzcpgZS8cRi7pp0/i8HMi0om+4iDWlHmMnUFZrV7PThZ3jfmxQ9rtI7RH/hCCKLnwQODLVy+dQLPonNPhqVVp/PTLPVabg3TEjFu50UI0D4zGPo7tKI9VZc+EDK/V+iAWKuFmKEzveZmFXoyjs1wIXBSJqNNH3hPIGLY2NMXwkWZfC5scqjJz0ZgbWMKhX5cmMs0xoIlcU40wLOe2YogOXVqTHIE0/1PfPo4vk657sOCz1npTcnwOSsUhrjF6hPtKNRQzV8MqKwvXwDVpVH6e0gdfzXPSefIGR3PK+7XnNqIU3nBSrcGu64IWl/aJKRgOUaFRiG/qHcA6s873CJ6pFfVUNJRkeU5asXZ9Sc5UIoX2XYPVJurIZwC896FAbt/77y+PSAqrLPZQFuvTeCJb9bjRrAMSSgQXIxVg0sggdm8oCsAZaRsNzoXlFvc6DRcNh+Puh6MLPqqP8yej8dUKdCPGhVX1Wm/81UBl28xRSfUQPlLZFMN4J3Wy80SGsgE2Y9IJI782kPJ8qK33hXh/v5iBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(4326008)(6506007)(66556008)(186003)(36756003)(508600001)(1076003)(5660300002)(4744005)(2616005)(966005)(26005)(8676002)(66476007)(66946007)(83380400001)(110136005)(316002)(86362001)(33656002)(8936002)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MhddzGb2bZiVdHMfqrQWZwysEW22+osW0oHUwzajawarQ4jAAS5p9ZSzXL9o?=
 =?us-ascii?Q?evB98tnSHKmcyb/SuGG0npHKvtHeD60S9ZCpbMxDanLbm0/g4gHVSBlD3v7n?=
 =?us-ascii?Q?XNN9nG6leYxv3GbGSslVzfqrdCUovr7+gPi6JHgzbGbvyNYXvTBdFdFErHBb?=
 =?us-ascii?Q?7bhzj3C6+jFJncGTzXxT/iQOL+3hVFO4forfHQpsAX+iTKuVgdzVNVW1QCLy?=
 =?us-ascii?Q?pgsSN0yAw4MtKin0Jy2xm5ZHy2O4RdaDOueqd7l5luZDKF5rk0bwCWi+x7Mi?=
 =?us-ascii?Q?H9EkU5rNd/8t/cRStVf99E563PSrAYr9JEIv0weUYtSPbfrqSqB4VREWEU6F?=
 =?us-ascii?Q?fzr+R0WrzKcALDB8KBayfZFUHG0wx0JVUs1VtqQph1krXilc6FKe5oF1vpBd?=
 =?us-ascii?Q?DnV7QuI+xRB0Pr9dXHg+qPZK7AKJMAmBrY+HE+lYxm+68wCsRGArclBJL8Pq?=
 =?us-ascii?Q?cpoZC4HlWdysrrhnZ+WzKmGPLb2QwnCDsyAzKmvlTQ58Rs11tv415Ul1Xm7A?=
 =?us-ascii?Q?S+n7vlmqOBqfKDXD+iw1p6iF2TBVsceYnqV8u0jrjfDilGlzeVAHRk1obZgd?=
 =?us-ascii?Q?lrZNNeaf2OvyAtqOuwi2cyK1AIIy44+sCDGR0FsJxy7sFdd+I9SVMM8tUTVQ?=
 =?us-ascii?Q?CbsJ5MWTDaXyCBZPUH7xGUWkv2wH3xFLCI9iDk7/9wTg4h7K55UNx6l0Al1w?=
 =?us-ascii?Q?SQJouwxFUCYZVxKQ/2A6q7B2scb+J93TEwzYtzCIlVYLxgfJ3vCJfbUenUmI?=
 =?us-ascii?Q?UhFOYc3O8IlI7W6eArR4edMlu0iHYAOpOKgwh6T1iBhAE6ljLEciMIagOCkV?=
 =?us-ascii?Q?Fii24HiZTDfuAnSeH4fhluQZ2O34pl+4dAFznlrPAJj2Gp9YJsSKRU8GkHxz?=
 =?us-ascii?Q?U0mr8vcUpieqCTWfXnGlzU+uLYOV4qNZgHH+14mEQ/Isd24KYzedwJTY5wVS?=
 =?us-ascii?Q?PfnysbkvvcoHP8QNNAbSRWtfYkJL8eUph4S/+2yrX+g2V0QMDKbsEDz49e4i?=
 =?us-ascii?Q?qg8N2MIXRM23uLPSB3+AeWR9UVKCn2w08DbmSq7HtLH91T1nVRfeXzLMGoTU?=
 =?us-ascii?Q?2fsy3IcOqRj7Y2WZjxa0Jtt0MfQ/6ItlH8U8vwZSsbOgLQvnfHCjJIaYF4a1?=
 =?us-ascii?Q?g93cspVRVhuERp/qmaTZOE8lazwmg/oZ6xeckrqIoUsxwzQaVonUeQDRO1xM?=
 =?us-ascii?Q?t8qTB4tk3pR8c/PyF2kxqlOEyvf9gfPXXl7wFdxgjksHN9XWscul9C2gkFN4?=
 =?us-ascii?Q?Max8IIYL6FHsRdwoVAH5NksxvWQJ43eri+pTWh8sZujwXTNF0BV1/LMAJodu?=
 =?us-ascii?Q?af2U24C1My22CNSm5zGYNesGd5hVPm9n2VAyN9GAoIjXtelCtKpAnICpopNm?=
 =?us-ascii?Q?AI6Uy1aX/gHbwECWSTMOcNVnE8u+84grhxihvhotg5ZvQBwg2yo08XKuhDKe?=
 =?us-ascii?Q?jraD7n8Y9OxOVIUZQ1cHUlkCx3WFOXsw3YKbyQxG4a5dvK0JhLDr8hExr9BK?=
 =?us-ascii?Q?oDxx3FNYVRVIsOjZgWF/6FJHInR6+rZ0Ki6A204dzp22/rPdM6soS5CRgoQ9?=
 =?us-ascii?Q?DB8ZvZnuXhgUm92zoWHlI+lpEsxFeBAXnksNCkJhyaOU7LJNEt5cpgcZH0aS?=
 =?us-ascii?Q?pfV0UK4OQFIxPl33jMQR4qsE5EwHH7N8tUKTHfO7fkFdwHtpEGFZuIgLSr2L?=
 =?us-ascii?Q?mXGQYQCODa8qJUwhc29fHiDJDq6rFamrYoyXuAid1POun8GvFer6NQVyB5TK?=
 =?us-ascii?Q?G6m8qvFqtg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e50b04-7e99-49ba-0aee-08da1640eb32
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:42:10.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJKC4FWpmliMZNWuAjXOQvMmDodcVklDqBEVRe/1BKLicR4CvcDQeswYrrrSZTka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2596
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 28, 2022 at 05:53:30PM +0100, Niels Dossche wrote:
> The documentation of the function rvt_error_qp says both r_lock and
> s_lock need to be held when calling that function.
> It also asserts using lockdep that both of those locks are held.
> However, the commit I referenced in Fixes accidentally makes the call
> to rvt_error_qp in rvt_ruc_loopback no longer covered by r_lock.
> This results in the lockdep assertion failing and also possibly in a
> race condition.
> 
> Fixes: d757c60eca9b ("IB/rdmavt: Fix concurrency panics in QP post_send and modify to error")
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Dennis?

And this too:

https://patchwork.kernel.org/project/linux-rdma/patch/20220228195144.71946-1-dossche.niels@gmail.com/

Thanks,
Jason
