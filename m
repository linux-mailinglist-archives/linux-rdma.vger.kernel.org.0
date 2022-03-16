Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034CA4DB5A1
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 17:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiCPQJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 12:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355862AbiCPQJU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 12:09:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547AF205E9
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 09:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2FXyUKMO6uJCP4DXonoUJO2sS6B6860H6kaWbsGf47tYWENzw1r9qzs/FaFlTEREm9VmvN8Fz+I5cPt6FRZzglfyIiMN+1QbA+cEf2jRErFH+Co6+y88WBePvlEIPnEAaE7aKCHTyNujxg08TJwACkdKpXZyEynCgHDpDIihGjJNW04omp42iXZNak7qO129VkrbqRbgM1+ka5IvAMQZaw6L2OQwr7IaUrLbR2UcHblr5gpAfknTRu7VSYSsWoZ+62ySC93zh6saZ6WOw4KDB2klxj/lHIilA6g1kKxVB8I476LH1JwqX9fvjt7iBXfG0GElSHgj0EIGgatkL/Z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhszJyCy/6RZbWx3TInh0abJBc/DfFIMJhmLV1B/AB4=;
 b=H3y4hS5EICaVLLJJWRvR436J6JzpCBMUstnj3bN+cyBMYMUm7BruM4uAHvO8P5atpwL+5CdTizcf4Jer1811aQm65UyvXfPew9KWbwDd+wG2Lp065qPp7phXv4QEBbWBBJNr0FzIbpveRF4TijgfK/2ltIkNxDhlGIn4KIjRBZqVpKgpI10pD7yLvq2WIa+Aextx5qUnYD5sA9gBWFpug6M2377y2cc/dlbXWFGNmr1Zsjvy+/F38qvhAn0glUn5bG9GaiVkjZeNuk7Mgy0pHSydv9bxMFJZIdgHwAh7xCmBDhOO861xYhi6MlPHQwZgQ04ol6SP6YeqtnkUeUs7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhszJyCy/6RZbWx3TInh0abJBc/DfFIMJhmLV1B/AB4=;
 b=Hj9rkGJzj8UzqQHAwGaJoU4Xe2BCfC9DiNTD7lLzB9151y93tyuu2pOtbjA//fgNPSw0OtsnKjLpNX9TuBj5z+zt/ffUBVUb9UToUMTlntxMl7Qd1YBQrZtai1LEC3AhMFrclZwXMOIY8fUwKZEQ6CLzbDFE7OhmsSbD8q8k1LQUCJrfWjZz/Kb1G2UJ+A138Mqw09in3tjZGogDajpu5CcKH3/7SkAgNpZSeDdht5XQGwihSdlYq2M47XDIeAbLFh8rdkVXHDbNfQ+lBXFuU4ulqBrykZH2zaEibsHoR0ax/kyYcQhQkQQh3lj9CN7fohMgvX0D9PJKiH8IvxC2qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1172.namprd12.prod.outlook.com (2603:10b6:404:1f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 16:08:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 16:08:02 +0000
Date:   Wed, 16 Mar 2022 13:08:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 00/13] Fix race conditions in rxe_pool
Message-ID: <20220316160801.GJ11336@nvidia.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220316002515.GZ11336@nvidia.com>
 <883b72de-850c-7b4d-fdaf-457f23d309ea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883b72de-850c-7b4d-fdaf-457f23d309ea@gmail.com>
X-ClientProxiedBy: BL1P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209df7c3-cfba-4ff5-fb5f-08da076725f7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1172:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB11721458E1B295E2D38A0318C2119@BN6PR12MB1172.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8j41tTLn4usMWtGjp9VJG1VcvuPv8Ac1jbsJPn+9lRhRsUDMCriWhXz0Yrv3tZxUOL5mZPRmENR3t5S0LbQI2WdkHPWDf7GBqxVyhHvpvryRio2pF3xXKA9q04M9v/GDeIu4NLosji4N0mHnWtsf8S46plcAtv/wV0AedCjuRRZZuB1PrO5QnnXjhVcOQ2nZqGbnvVK7R/VuPilhIMDIkQ20q209UovPnSG2YQjllqJBuIJwfCHELTqqpTkyFQfiPC0XCU6jQ0QHIw2yTwF1ro51cLQb4WUn2ZpMSxzt9OCkel0bkcc2I+KKqI4/ZuTIKYnjnUUUsaCbDbcP7CW1vksr5HfA+/4D5loNi2j3Hx0Vbl+8dtPMmkJ10RT3/9ILZmoGX57Ng+Ezl90MI/ZLEfC3hIrtarPWOdqQdXgLgHQS81Bcyp5tXc29CCrcpRXvXJwV+2U9+bqE5+6DZoR3/FbViZKgDyv7WMlr/pyYV3Ou98vQ6jijOXpqQ50Jx22Hcy1xTFU30bzRkXft7j/nQ1CwU4fs72bn+yeruqVM4+fT4OliPvxPg+tWVcygmYsI5nQJ2E+SWKkaP6bLYZ0gXCqevMy5h+Q0wbXbdx6iZxdNJJGUEld0zSLFVeFwAvY58n0quNVlA29GqJ6Zgdy+0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(36756003)(2906002)(38100700002)(5660300002)(8936002)(33656002)(508600001)(316002)(6486002)(83380400001)(26005)(186003)(66946007)(1076003)(6512007)(6506007)(86362001)(6916009)(4326008)(66556008)(8676002)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCisC1ZQXqFdOazChEqY/bDwtwJMyY7slNDv78w9KiK+LoTtrg67E1f43cBI?=
 =?us-ascii?Q?dFLgwO2+7YISDMgfqE6G5xT8NhEvCBKfU/E5s9hwy2sX+TaMxsBBX7yQEun9?=
 =?us-ascii?Q?jD+vYBa8vhppMCLwaFPyL+I6IuljllQwGd7fvtcOv+0kqH8ONSMdBx5+R2j5?=
 =?us-ascii?Q?EYKrFFH/ObgORQpVMyEvl1fjndB6TdiWj/465LXhDlQlsoRlbKBPY1xi88p2?=
 =?us-ascii?Q?kfJgkxEV+Cbc7LgLnaeBNSNDHDmC+VnQEUJgX3rS6BY5THKNieO1iQe7XAgO?=
 =?us-ascii?Q?2CpqBgJyvMOe2YsghBEPH5kyZWD9TeJ/ZW3meJ87cQyQqt7QWcb1xUN3KWug?=
 =?us-ascii?Q?7RIkxjDQazAUwzx7X8fnMjI9+irqwFhRcmNC6Wq+lMCmQgIp6V0Ns3XkrtSn?=
 =?us-ascii?Q?DK2/fNzcZDrhdMbUHVeKWujXNuRRLlJ8M8MH+4uGeJFlscd+FMSQ38w3WQBS?=
 =?us-ascii?Q?TXZAXIPjp8KAxu2pSOXu9CLGDcIEGQcy6d65I62EJOhQYlt9dNDKBhbgjFcD?=
 =?us-ascii?Q?ONYoH8ZgX19VQUYr7ExpvIq+ooQluvFgDfCXEEC95bFPQybYb1gx38wcDknn?=
 =?us-ascii?Q?n05NmS9sXT9OO7iG537LcJz4n0udZb2QU0qv/+ocnpzxZb0npnXWHrDpdAXi?=
 =?us-ascii?Q?jLbChYRRuzCgI53n1RYp2eTR4/z3PJHsdEBaKrPl1e5kRg/xO8LLHFsoboin?=
 =?us-ascii?Q?Km8KYyTkp+pqYTfdY4d8RXxYBxenvj+QNl/SnI2J/L/8s0nPTlW3blbgxEYh?=
 =?us-ascii?Q?GqVwsDsRHSn633LdcoME5L5MsS4hpVXO07hHQnI+OeDn9hCvdi7sO4eB+ztz?=
 =?us-ascii?Q?q14rIMlT3KEIXyU6UpqHLWNn2f7KXf5rBG7iQ4Oeyyh0FQcbZXIHww2nzMiJ?=
 =?us-ascii?Q?1F62X9FiBLBP0/UOLEP9veoB78YV56Np0IiO6wQbLOYJEM4AsSfygcibH8M3?=
 =?us-ascii?Q?/+Q28DsmCln82UZJchNL/pl5Uft0iVsJRZZ23mX66PfbcjSWO6cfI7KkF51A?=
 =?us-ascii?Q?a8AewHijAVAnL1YhZ8NMoxC1TSuiqm/FlZ9h1SqdcByu7j3iLrhkhJ2iv6Mp?=
 =?us-ascii?Q?4zwCKrYBE0tEOqy9RmSjgGG5pGkd5jHOuBDQroC5gaze/0N1FSd1mAw89Pku?=
 =?us-ascii?Q?skcQOxLXkveLh3a9z5IPZaomZAIY0+yzyrKJnJ39dWPK+xMrMpdWo9wtE/kK?=
 =?us-ascii?Q?wXiJoPckGz6Gv17sYTv2bNymZRNXIidAJ6vSkGtbgkGR2+Pm2vpWRJ9PfJHM?=
 =?us-ascii?Q?+2yxtyV7UBAqgrWB/LUi7JNlUBnAX45zkaqF6XCDVhGCEhvhYkD+YRFS6zqZ?=
 =?us-ascii?Q?FT9Nh3Nnq++SzKpGQV5t/kHHMPXvkzn/J+uXSmv1szezQRqfU8LScuXCbRi4?=
 =?us-ascii?Q?4O2u7cX+Gp+TyA6Bv6u0ncfjyc6JeyoRX20eZ7+1g7IzRvt/K2AS6eG4FTUJ?=
 =?us-ascii?Q?gLNUgYMipYtU6wGW6n9llPA1BBazBHnV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209df7c3-cfba-4ff5-fb5f-08da076725f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 16:08:02.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpuymW5pKJrirXSTPfOg+4UtXyw+NNIfMvO2IjBYt0hh6eoXrSm2HhTYx+NJyKDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1172
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 15, 2022 at 11:05:48PM -0500, Bob Pearson wrote:
> >> Bob Pearson (13):
> >>   RDMA/rxe: Fix ref error in rxe_av.c
> >>   RDMA/rxe: Replace mr by rkey in responder resources
> >>   RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
> >>   RDMA/rxe: Delete _locked() APIs for pool objects
> >>   RDMA/rxe: Replace obj by elem in declaration
> >>   RDMA/rxe: Move max_elem into rxe_type_info
> >>   RDMA/rxe: Shorten pool names in rxe_pool.c
> >>   RDMA/rxe: Replace red-black trees by xarrays
> >>   RDMA/rxe: Use standard names for ref counting
> > 
> > If you let me know about the WARN_ON I think up to here is good
> 
> I agreed to the change.

Ok applied to for-next

Thanks,
Jason
