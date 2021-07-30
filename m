Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB33DBA15
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbhG3OJ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 10:09:26 -0400
Received: from mail-dm6nam08on2047.outbound.protection.outlook.com ([40.107.102.47]:27127
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238948AbhG3OJ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 10:09:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHY6VknFtYgbW+7eFKOdXjRpiMoiybu21pCSIJq99OBzRS7ZLvYLd4Twdac3u+rs7o3mFkgxN4GpqJYxKnDE8iLD451EdhXAtprOBW4VqEq+/UJSVg8X15WTQKoX7ikRMOCTAn0pI4s6WXePN8PWfpWVp3Xow8ZPZQMnz0+4gBkuNFlj9gh7PjK6vhjfYq3+HLDYFkoDjBs8S+Xswy0g4kHebpPgHNchIhNfLKK1kUp7iSeNrveGRTfsR0iCCJ5zB49IHebVTLLHGuYuRMSMuSi8C5R2KQNw+Y1N5+ESK9Ay7e+yFXVxvytUCyvAe71j9Dr1vmF30xYUdscbafk3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBv7aB4ooIKdqBP6HqQ0knNKHUJ6ygp8ThSY2jqfUaw=;
 b=NSQNUaGCwGr54uMRch8YFG8qXebgoX3gxJR/ZgpRGJdjuuxKXzT3R4MVr1r+bIDyYKW9Ql0PJLCZO8JqaeMGgNxnwtpR+NK0jpv3QMcTGCjgHYL+093obWCbE8tdCHvjEOREqtjJzJui3fHRDAOBeVbHEbxeqBnkPTIsCPmwiwdgSh39Ptcbz5OoDjnEHDLiq/IZWFE5paiYWZKjJ3SBXO6pHO2DWeRmUU7Jil8BjhF/aaDsLxkFL1Dxgq/gcRNMIqrViNhEEBe2QnQTVWsDXdh6t/5OJDckCXkYDCqfrk0tYHfU1yDg+Wv5cBcBY66yyrDfx/HobmyosXfR2OLrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBv7aB4ooIKdqBP6HqQ0knNKHUJ6ygp8ThSY2jqfUaw=;
 b=ryy1O6LAreSuXgJTF5/lM5rKc6zoMa/7soWhIY+W6Mp9ghxN1MwVvllBCCBF4ahiMkAJU5dGvsc6OkhXr6d12sU/Vs9iOEJ6TRUF9oRLXAlrmnTCyXghp79kVQm97Sc1xKW0gYX9+iUwdpdDsuk5hbr5RAOaeIlH2vfcUC5nt6u38FnPoyIe5te97EyzImhuhiRepRV69RsPwFlrAufE0xM3SL8cTj7kz9jZKU4+B80CuhifNh38f0S1XxN9SJKbOZzxPoPYicqt42jPJXxcES5w5VeP47PA5av9lgtMaq0B2n+gruzbYJWn1TkesBngM+9aZG3RFQLUhGXsuhgdpA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 30 Jul
 2021 14:09:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:09:20 +0000
Date:   Fri, 30 Jul 2021 11:09:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        "Tatyana E. Nikolova" <tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH rdma-next 0/3] Remove not possible checks
Message-ID: <20210730140918.GC2559559@nvidia.com>
References: <cover.1627048781.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627048781.git.leonro@nvidia.com>
X-ClientProxiedBy: CH2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:610:4d::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:610:4d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 14:09:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m9TCQ-00Ajus-R5; Fri, 30 Jul 2021 11:09:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9809a709-c62e-4e70-964b-08d953639fec
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB522139CEA74ED0830C47F238C2EC9@BL1PR12MB5221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ok8doBuvEjVuG9x0MBjoUTXiKeDO2Xzj3T/GOsLkY8zFmi9aOBlPg9myKocpduHJES7L5QpJPsKTXmTXx+oXMYT691dsmr5sQuz4WEYtWtZVjVIcpzyB4Z1Nx36SUqKKFX7bPdv1oTR52dVusMLJQ0YEDt2VEcax5eT+gAK2k4TlL7e+QdfdQqDl9bs/s2mOFof/S/A0ECarmr+1mqzR8dOg3lmDLnJDZR6SPohzZd6Gf2dxmg/c8dz6AVZrlZXHpGpxBCEeTV7dJFro1ctLtup/zlhxhW9zFgUZGLio/3LuEW9OK1xk2PzUXE3Ma9aHCcIwdkO1Ht119LPexxsQ25LN2X6qXPW9+33wGVRy67INASbbvoXDCgOGgyKFSLRaeJ7MDrlupc9w55csqY+xxa0ogmRFgIUddM4oV3bShnDHb1JH5YX1kgjX6coS14BisitfXBfNfbW7jG1qJ6ZZ271trKRUUoq3Rut7XK2Oo2Ln9zhLrvieolcx6EXQpqpXsr2vRplKL0JuCKnDCk5oQ6yhxHXfsQGsxDCHFEj8T7wfcH8e9IwbWl82FSBQ4INs8bYgOUJusITmHMmUM9smfO0ttaA+CkRv50BJnYvznouoBNwSH7gGe7lqlKFsUVZmP/oS2+kJmJl7kI2FqSQBdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(186003)(316002)(2906002)(54906003)(26005)(66476007)(66556008)(66946007)(33656002)(86362001)(2616005)(426003)(5660300002)(1076003)(4326008)(83380400001)(6916009)(9786002)(38100700002)(8936002)(508600001)(8676002)(36756003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2x7aHgrivS2gzgsWPGs9pZdGYb04Q7cQ5wUAWln1jMc2nv6XOSs3VQXcqJzM?=
 =?us-ascii?Q?Ew8CFoCMwbVX/e+Iz9c8xRvEVbH7YnA6PWwAmKFPy6UetNDhwr+eaoZuSE5n?=
 =?us-ascii?Q?VQJTh9qyahTaOkbxGO5RoHO55LDuuENWOsuwZYBOuWLit30lIKoAtYSlsP1K?=
 =?us-ascii?Q?GuyBmnJarCV0Rlj8nrZOSfTrE02f2UyolwLa0DBaCzO8Bc1WGI6AUCYZKcpS?=
 =?us-ascii?Q?344K04VM+AArtF0OD/r8hRAK4t+1wX5o/4xOASez31yp9Sd1Q+X2CcYNAE3m?=
 =?us-ascii?Q?xKzLhh7BUImanq2VKer//ukAarQYP+ekuwSDc0Dlm435GvzD2BDsK0Vb5g4f?=
 =?us-ascii?Q?D5N+WjTWiETf1d5LdO5rioX4i17coUotX1IksG8jj5zlP4LWBz7uagmR0Gqw?=
 =?us-ascii?Q?LXDTU2c6TM8HpnzDele7bbkLgj+aSql+l997hnQwPGEhO+2OYWCC3Aou3dy6?=
 =?us-ascii?Q?luiVowbfXe8nbkf3hrg2VKh6MN/E14CHd+qnlAca5QYxRkK+J8EpQhFShEtp?=
 =?us-ascii?Q?zzA1Z0c1FAVhekvcQiwkvfPrUasi5W73MRywbnCA7v06/Jgdycv4J1WwE/A/?=
 =?us-ascii?Q?YXjPKeFSklE1pjcOFgrhKt4kBx427r6GZJvKBQx1f3hUQg/DsNKfarjttml0?=
 =?us-ascii?Q?1lwS/JnJ45KKu37NbD4SYkQkoe2vljCjMYBVIw3568t6JxZftk+DI1lVjuYM?=
 =?us-ascii?Q?GUNDdv7yixzMIJhWvCFvDADrDqtLGdHH60boYFaGnNyJ6L+lYjrWrnJl+xeV?=
 =?us-ascii?Q?JccX8/v2uIZg1KczZZScJNp1NhbsLjZKuJSC01+2XwZ/0TzvcNGztTmk6gqm?=
 =?us-ascii?Q?//1w+A8SWdiiLu12RfVaBofT13pEq89kV9rg9nOmx44m9LhsfGTSq33n8sB3?=
 =?us-ascii?Q?fieDizgtavvYohdZfcoZJlIXoxx5CLtiAkh13FWUtLtT6DuzKmf/jzxFyu2Z?=
 =?us-ascii?Q?xMJJL0PnOwVAV4XxAoQFBaHEaDdzaLBckCB0kHMlURdhOKrvWUtDlOGW3byM?=
 =?us-ascii?Q?0f4SmXO8w6cuxvshgAEGSBXK87PXrAaA+7oj90ISuU0xyogBDW6VfD26Qe5W?=
 =?us-ascii?Q?9qWYIPQawTR3rT9uWx0pJilYUhD7JSqSPyA3wEPvgG9Zi0mzduhSQfruR1jN?=
 =?us-ascii?Q?BJ+2MjjnkPjeX4WM3ygWaxR4VUFf6ak9B61TBTJSnj0o09iaF9f/V4HV0Bxa?=
 =?us-ascii?Q?4tph1ETTcAvkqB+EKukA18K/QCoHAX6/lFt6qGNZBEGLTZhS5IBYLd7nNb9o?=
 =?us-ascii?Q?4kikwzHVfBBnp/O3ZveR5iB+dJiaLJPiWjo4o3NmR27c/d9BlcruvZyFBQGC?=
 =?us-ascii?Q?cs2DzR2YqD8mqoPqjv+bLNMl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9809a709-c62e-4e70-964b-08d953639fec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:09:20.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVFDUS6ZNYE2UB1f/3WZvj/qDzCmbTFJz/xPOkEAzuTwbuCe+3SVzLBoZrqsrSh9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 23, 2021 at 05:08:54PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The iwpm is part of iw_cm module load, it ensures that iwpm is valid
> prior to execution of any commands.
> 
> This series deletes such checks.
> 
> Thanks
> 
> Leon Romanovsky (3):
>   RDMA/iwcm: Release resources if iw_cm module initialization fails
>   RDMA/iwpm: Remove not-needed reference counting
>   RDMA/iwpm: Rely on the upper to ensure that requests are valid

Applied to for-next, thanks

Jason
