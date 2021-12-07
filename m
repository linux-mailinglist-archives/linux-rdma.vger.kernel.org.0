Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C746C232
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhLGR6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 12:58:51 -0500
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:35040
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230184AbhLGR6v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 12:58:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpO9H2yQ2IqAhKdkMnF3RmSReu9ZiEV3asT+pFSh73L59Sh8j4+nG+kT3Myc2vU8cZnUT8v/R1db3hny337Piup6aEnEI6QLlyAgaqdQyBqbSXtG3p6bLDFIWOns1fXtwBpAejY6OVYTjJmLmG0TO/ldnWSxGlrgZpZSVHY0OnxsLdr7KjjQY11bwz3rturu/bc2TZNg+5JWHUJbamp/IXAjZ4hCakbocW4q7flST3I5Zzu2Sn4NdHaoGGPQeNgM6R1mv/Bj9Fn87n4iZqdvgpubnyMMqLZMQQMYD5hMRwXCNnrqH/yIiTIwswckt+mzaRXwqGHscPKq9Y4pdsVAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMletMFpv8KfuXuGqTtgfPpUP1Ogz5tyqZIQ+nxRjLM=;
 b=EtgddW1IX3MiZpcWWGLh4olqzRW60lDwkVuERBMzbETt2coxu+tx3Vih/UtAeXowPrvKvGWhs31neaXrKekjEzvcZ1U4/3Kn/rRXni+IvqEajQfwdP/SlwtK6/m4STFegZelP05slHBczrSwEy+VBRir5Cv3aI2nYUD+FZUrE44lP4CGwd5VtBX7rAWa+9SYfxKlqvppJyYh6TVB/3iXf4J8z5lvxW2TyL4rFBTmSikB7LM4qjrWZoJti+4Ks21RBSF3yOpatbx/5UkbaOH6lfQ0bAtgsLYsr4F72pCtEd3ap7pPDcJBDYErg0NFJforC12+IpIjvusp5k3BJiE9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMletMFpv8KfuXuGqTtgfPpUP1Ogz5tyqZIQ+nxRjLM=;
 b=jP99oT+kSImph1v0AqqCEC0hSpj08z0C5vHFdPMGi8FGdcCZRMvO+twYnyLwUNLKNl4vVkhxoLSxnXjyQH8tk3psuG42dmod4pA6MEk+rb4z/g/gASS5YF6hzSHnLxBCOTiz4QbrmKzIVC1zfjUtKOgK5Yyji5Gjr9Io9qPbTJCzIsEhVWBpqaTUaWsgCGOpGMulD0k65hpWao+jvohnVuBTi2F0TSJxbVqwPNceb9hYbvet56B74+/V/Rg9AiR0NwRh3aj7mgVfGDRfAlC9/0C5/Ip1fsbRIkjGigQsfxtn2lLUmuhm83hEVdGwIMX2rrHoiIwbE2YEJrlyiZZOdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 17:55:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 17:55:19 +0000
Date:   Tue, 7 Dec 2021 13:55:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 1/2] RDMA/irdma: Report correct WC errors
Message-ID: <20211207175518.GA71237@nvidia.com>
References: <20211201231509.1930-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201231509.1930-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:fc::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:208:fc::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 17:55:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muegQ-000IZ6-EZ; Tue, 07 Dec 2021 13:55:18 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead9efb8-b37e-4812-f52f-08d9b9aabb9e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51769E3E80B9B84F103E2FC9C26E9@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffnelbdAZNpC93VvE3NXdz3y5GRTNDEXc79bREk57x/OCkpCMJcEOY9zSYa6Mnf57lF9Jv6xKmOV/SzFYLvZU1vYABrsnOWNYtQ7q6tryyFtoq+MkqtC2S/vKTMbbZJHSZmGDpq53+/S5hmihxhKlzgXGmzjRxA7LYMMeyhqBrcwi1TyDalrGv/ZAMuVahjkWR5LmQlbfvWc4YUD0j9+n51PGkRD3msSiWnCDzSh6tmezZAJ7vJz3oImRR8zI3m/FYs0O+oSpbkE+xPPF0zWV504WPVL8yoSXwudrJJs1Gr3hYXEEvX6EzPlWFroampMF7cNq9VdmtpmQ63zW9trjzvSur44XojwBOcjFlpgcGRmRBx8xTf33Wfl5OBqTX6LfAJEtyzKaGlIZaPM5qaGN8ZCk2CTjbnyd5X7AeNUieTSiAQVTkNx0tF6C0M1Nfjf1IAn2xaCuvvXiXol8Ms1GhVReVxqrjrZngNZ4VwJU4ga74dhvppJTMbkPQsF3NtA9SE0RLSYrslduI0tO4CwvzycSTID/2lA/oW/mx3QiPAFLkQFMagwFrDZXUkN2/lFibplzN8IzUfKAiSl6dipHTi4oMu6I81/fP2huFte9FSitUSW8zm9AQHz/CrMy3MJsUjp6AuwLUjsx0LgXRQpXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(33656002)(186003)(66476007)(2616005)(38100700002)(6916009)(508600001)(83380400001)(26005)(426003)(5660300002)(86362001)(4744005)(8936002)(1076003)(316002)(9746002)(4326008)(66556008)(8676002)(2906002)(9786002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LLgffKfPMfZ7kSZy7k4ERlt1tgw7R0eS+E5vuGoQuDAoAVUOtTsLui7lCZC+?=
 =?us-ascii?Q?qvCy5zsY++n6gjLiYshqy5yTtEI0PJTPv+Z3+8Kg0WGJEm/XzxZ+25Hem/80?=
 =?us-ascii?Q?ZEG3p1wEaY4hoQiGTKbeXJ99jbNcvxxLFeMw43bHqvvS/A2nyskl0VXJgx+0?=
 =?us-ascii?Q?jscpuH3uVqUdBV5gD2eI14hmRBTrvTCAccoDLR0MvhCqA06W/hZMX/i118ab?=
 =?us-ascii?Q?dzcW7mwl0UlcFBraQaqcEY4h0RpVq1cBpZjTBLnrmhWOv0W/cTJwyQzcteW5?=
 =?us-ascii?Q?xz/P3187RkWnvqlA2mrwZmeQ1nAcJ8AW5daUaQejHj8zVkq6GTjqa1xs3EsP?=
 =?us-ascii?Q?rxk4b1UDq3daeKzmD6pZx+W2flB5zl4NBcBASDqZ9hBTMdNw5ZxgrpJfJfEH?=
 =?us-ascii?Q?jXRyARJZNs/Eb6OoGZ4ZkA2lgR6atBcghDFL8b1ESuveW3lFGQmDvan7a22x?=
 =?us-ascii?Q?gsemjHnWbxFixS03Y1Kuorf5w2YxJCSiJY4JOBudiIHVDRukIh2Q825a8sUH?=
 =?us-ascii?Q?ASeeTwaR8OGFFfCBFDjkvbRmjG79Xx11xc8kzhz6qnKYvZLq41kltAL6ptYf?=
 =?us-ascii?Q?f3oxhlvvOHwBNj9j0QNBvFti6zrTIhNPEDYZTBCtMrfWEiCgSANaxYOf9Suk?=
 =?us-ascii?Q?0zl8sRtOOviRBunXPCngB45tbCjrGgsrZegsgajCJmIKVp/RlOQBUUE7gkAl?=
 =?us-ascii?Q?0MY9lgKzwSfnItyUvDwZl0WtAOst4w1ygYd697CeDY2USgJuWjbfUtVSUQ3d?=
 =?us-ascii?Q?7YXGykbGlnBK5PgxXhYpdY8tww+BfN/iVfwuLCE1IEDYo3kaN6qliA1PROlN?=
 =?us-ascii?Q?m7pi5OND9f7q2HZvSj9AlqvVb2D4UVwEWToHMUh3Js1eorPmNgX2blRHJxib?=
 =?us-ascii?Q?PQE/N9zxGWVE15YuRQClnQPZob64bZJhr2hiFFnpLxBYvqK3oOT4iM9GlTLz?=
 =?us-ascii?Q?s6ZUnu5Ho0Kc+JAiBTmO+15zfJeMaGxnxGEHfQfKl6o8oGOqDGywqhyeE41N?=
 =?us-ascii?Q?JXWSUfjAc+ML800wtzaq/+XgRXtuArfBo2iy4gt1RMe0oy83XUvcnpXQBrua?=
 =?us-ascii?Q?PhHxm0pw25xqKKuvO8Qmz1d4TCegO+EVlb8lYDzFgOzTvVT8R1BI73fU75FM?=
 =?us-ascii?Q?Uk7pQEnR7EwyDmCq5iv3l9LtBqOuit5oIJtX4vsOIiFpVB81epYscrr3aNXj?=
 =?us-ascii?Q?zl8qVI/bR3oe4gVOPoFjA4TJgVuZ6IdgD1znxwUcziYV7SZ/BLhnmTcuK2a7?=
 =?us-ascii?Q?2QU4JAhLBeFOTpHXJGXzd7rdrK32rkose1OCJhZfQbZeXd5jlI2uR93D+K27?=
 =?us-ascii?Q?MfYXAXxT4OMrkljO6r2IkDowjLS0tR0UJBnqBbMY08bvVp2yURO4dKuKcXU5?=
 =?us-ascii?Q?8wA07g3nQFbP3mvJ26UwLb8+rEA+Bx2tpfxKsYWJid6jlUchGzFKGdUxfBKd?=
 =?us-ascii?Q?67y1QFoaNziySk4t8qGkOXHGK1QAf9PkkmDuCBN1x5LgY7lOTnYJePYfFwvE?=
 =?us-ascii?Q?/L3C2iqj0aICjad4yBWDLm1Bw4oYsbCYGTmw1xfIkXQwENmNBU+uaR8h38NA?=
 =?us-ascii?Q?4WPOKv1r4gUG9w053/Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead9efb8-b37e-4812-f52f-08d9b9aabb9e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 17:55:19.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OETbVZgd5ntpdhrXru2pZWAR7uMIiNNHk7CSnVqPyB0zzgAMyVBZ3pMLUcmiLQbx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 01, 2021 at 05:15:08PM -0600, Shiraz Saleem wrote:
> Return IBV_WC_REM_OP_ERR for responder QP errors instead of
> IBV_WC_REM_ACCESS_ERR.
> 
> Return IBV_WC_LOC_QP_OP_ERR for errors detected on the SQ with bad opcodes
> 
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

This and the 2/2 applied to for-rc, thanks

Jason
