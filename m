Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6183CA544
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGOSVy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 14:21:54 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:48481
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231627AbhGOSVy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 14:21:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdIPM8hGqvBzhsVbNzW2qpVglgIRPWulvs4616LwOtAGIYx/eqexlz2Ut0MJJNS569BU2Rl+ksadZsPEFs2ralTCOYLjaQ7BS/2KVgtIhS0SvOrxKXRCbsyjV3qbzsT72XRP/h3zXdKx3qYU76De7B3mjg2K2NWDX+0nwVZz+YOfY3RBjnadCw+8YPybhJklcRAhobyxSU9rp+3SvMzVZ9b5e5f7JUr4hL1eTFfAW0mbB5ccSSoMI/3Pzlut9e1zkmG3vIQd0CU4GoG+N5OHtj+sj5wVQIfNTvMhHEObOnI1iGTIaTBBmQQJUZczgYGPiE/9w6+MMNHxc+zJLEdqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWC0ar32rxHvabKlqWcT9WBcJiCFTnfGp/xfUc/RWZM=;
 b=PkJszhGGiCfAinBxEUailASlSfwzzMQ1ZI4dC07JBX+tDRV7mij/jMQoUDvchpjar+K07THBInsnfdJNXH6yJtGeBqg4b8i4O1SMhSeImT4t1NJX9eXgMNtFtjvv6Wd0CiIV1hlrdD5vevVPBwREc5Lp8hjcGquDtPt+hDv0BaUSYIIxMtCsceB7e0AeLtY0n7oQPmMxKO+fpLUZlK/Uuq71yKtceq76rnR9TJ/TqBioN/psqMzEzCtItH6iB56YiRHe0PnP7NJNal9cb+Yy1FxTfGOcNJZ/W5wjtBlqk75oZUqigWvOaXMnA/uASyyS4x4TX27UmLwToxdPsFAj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWC0ar32rxHvabKlqWcT9WBcJiCFTnfGp/xfUc/RWZM=;
 b=oEclsnNRUbe1HW5EMYU4kHrz1h13jvMBvDrD/KlfVIdkvVbVhsf+AywqhG9+bGiVc9/GCRIKM1ol8BihHQ0OKY3VRKC27wuJfkqFDqlkkMOg4PrKZ9LAFepXQv5Nt82QCXD4dP5V11ZJRM+cZ5F7nV3vgaOsnl3Ikyu/5lmMchZIDmKdAi9avuoBEPVutNpSbzNOfyOaVR1Ad62tUxVWA079vhfQPy7zGiRSl1L4k0LlzBjDcZ8rdGYsi+NHMEfT9bcizdz17oXhtd6qf0ueLLjUmEvs0Z0UgzOUpFcrZsvT4/p/s/Jx0XPGnHD2Qb8W38nYJzpbePEa+nR/erdJCQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 15 Jul
 2021 18:18:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 18:18:58 +0000
Date:   Thu, 15 Jul 2021 15:18:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH rdma-next] Check vsi pointer before using it
Message-ID: <20210715181855.GA673000@nvidia.com>
References: <20210708213521.438-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708213521.438-1-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: YQBPR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQBPR01CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 18:18:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m45wl-002p5S-Uh; Thu, 15 Jul 2021 15:18:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6225a628-34a7-4b9b-2d01-08d947bd0394
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50474099C1288E6B1160B7F3C2129@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMm3+0fKcvBAmZImqSCq5lUHhL+gscbo8+7b24TWewalw+S/INuhYGT8HH9LvF52PmjuUk0AR41jMjpnmiJZaL2T1fc6xp6LjgGCBQiClMz8HjOh0dV2eRxIwR6EEP0k0u4GWmdm9PKKLjmAdsN7CqA182NmOPNQT3uWLkpmez5s3Lygl9nVhdZneVey/gIX5t2mvJNpRNZMgF1lFQDFBHfRRbYeMK60Ni3JJnBtrHSJym+yFKSQJr7Zz9IDm7NhHYDjAH6+pOk5+Q6SwjKV9NIf99/4syL22ys3OiXZaw/NHS53GeMkp4iz9d45myFMevY1K/ANi4A/IY/Cb08oTvEWabOi4/Wpm0WCJpEImWgeIVLEBCvi/WQaZkTGXQDFs8meCI9XqEiKkbxoaClwVkK+a0OE83+w993Nl2DDn9RZgfvLUS5E9KHsUf4RBJ6cw4ObBl85lucDUPsQxKkfo9hjGvxy9n9dhgR3GP28CZQ+0Uq2WFaF7kIPo5QO+6wgGdW1YRUrvR1eeKua8AQSBcc//JtbgHjGXGfl5t3s0M3nxqFpWm9JwqILGG2uqbUJZh2XFDxRA5x6ntRJamub+k1Rk3/by4rhBLy8KWT8+zrov3IndHR9N4stqqyzlarm75FDg+tHVP94hPn8zFyEzF0rkWIdZTRyOvHWx9yHjdVT7G+1ZM5BE72aJuHTYN1U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(83380400001)(38100700002)(186003)(2906002)(66556008)(316002)(426003)(2616005)(26005)(86362001)(66946007)(4326008)(8676002)(66476007)(4744005)(9786002)(9746002)(36756003)(1076003)(8936002)(5660300002)(6916009)(478600001)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQWIM0LyOz9U5QkNL+Ere0R/yr4JIYFu3pPvlrKSwfUEQp16Hl6u6dWPFkAD?=
 =?us-ascii?Q?UA96+4gBc9w2JKUDsP/E1lQDxx9HnnVFAiZ5MzdmaTVSTQdH95lAhHjOvaJa?=
 =?us-ascii?Q?BwRbCWbuekYd+cG164yt+5M5X82AwnbxFV1eFckrfqO/5XDT7Xnn+fGUgjdl?=
 =?us-ascii?Q?9DMwTqeo7FgzIIfkQo2hb1zw+kgwnVfy8eOWCoZkJWSfM9j+Lc8W4HnsrMs/?=
 =?us-ascii?Q?7S5f5wssjbJPWdfAdEOndxdIgsdg9bueWlj0HMbioBLFq54x3KOiwTsIPpO4?=
 =?us-ascii?Q?i2/KaqJpJoMoOtpb6vmUwaxM6ixgrXODBYQKNuLHLm8yrOfsRlOjcvfYNHHU?=
 =?us-ascii?Q?j9j14essVCZij7NbCkmZSGV5nMPJ1JvPDMw1GDJpkf6r7KcheL/4TS2y06mp?=
 =?us-ascii?Q?fhDNHVbJNPYYr/voDtXuUE25KI2HiepMDCM9wrQWowgqgEmKYqefhA0afNT+?=
 =?us-ascii?Q?3dF/9xFYNKEMzps+tNiTUm0wQK4rinljMgvTmHo+H4aqn4tAPcm1eWBGn9Rh?=
 =?us-ascii?Q?mt/jC4/Fqlh+xCI/bJ9x9COjFjRXg3Swk9g0zCjTbF8cAsbz/nxPxFiXqZK3?=
 =?us-ascii?Q?jeV6LofdhOZq4C+YGBqLXcSj/lihadRFWWZjVCXomDlf/RJK7nTeFcxTWLQ5?=
 =?us-ascii?Q?1xDgPhX1M6Dx30xBBvwATFh3VgNPCXui35cOFCc3Gg/zKdRd0fee4Hpc2ZlS?=
 =?us-ascii?Q?PnKf4q0lGj2TQogCilu5yRTyWgKkA8DM04MDtWvzG+Aq1dQwK8V7J9wePVdn?=
 =?us-ascii?Q?HY9cd1blkI585SMfm/FaZ81nl0jQU4i74xdo5FcBL0VTw+kZr0IqDjkpo9Y7?=
 =?us-ascii?Q?3+bi5A3BqJW8YscQ27lhIB+Zy/yPSKv3QY+uRNAWwp/fnqT59gQvuZNhiiHq?=
 =?us-ascii?Q?0XgjmzDImC2jmh1i3IYJ4UtkLbbJCxIt8jkuy/W314MPM6tuhEyqJITZ0kln?=
 =?us-ascii?Q?PHbY/8h0j0hzAUBwiRYK2VNTNxyXN3yDv1J8HUhtF1PyHMQPUCHgLFXXLYdY?=
 =?us-ascii?Q?YBTCEomiao5Xk/9BYeWu9tHBC+HUIF4GUb4G9x3G0EFZcsLFyGcbN4eb0dNb?=
 =?us-ascii?Q?4CzAnfUZ6CQZZac0mfZpxSnlAQ8ljHbNPOPwOxOYFGyIhKN/V5v1q4ERJSf6?=
 =?us-ascii?Q?IGGKNjkN2zYTjWAGUwOVlZ9M/wR8rrZi3/PwXdz5ayYtJr14Q4gpW+HTRdfA?=
 =?us-ascii?Q?w3tzNSuedN/mTuBl5w3q+8R9lUhEJbaGnzXGO+ctErfP1bCIlSpUzcBYaYGq?=
 =?us-ascii?Q?5qJQcqzhsUm1pv0pG1+HOlVRPO+8kgprzrG1fIaRYuDkyP4hcDN7EyRDoCg1?=
 =?us-ascii?Q?w5DHhLVbqG3EsHjdPwq0NV9w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6225a628-34a7-4b9b-2d01-08d947bd0394
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:18:58.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnZTfJKchyjOUhCD4WM/vXm4f51tDxxQsNb2pDQjeVD7U4redXVm08H+icnNg3tm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 08, 2021 at 02:35:21PM -0700, Tatyana Nikolova wrote:
> Fix a coverity warning about NULL pointer dereference:
> >> Dereferencing "vsi", which is known to be "NULL".
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1505164 ("Null pointer dereferences")
> Fixes: 8498a30e1b94 ("RDMA/irdma: Register auxiliary driver and implement private channel OPs")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  drivers/infiniband/hw/irdma/main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
