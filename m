Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C8F3AFA14
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 02:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFVAIS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 20:08:18 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:59489
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229640AbhFVAIR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 20:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEZjirnmgR3xfXs54NH+37pA/kOPHElkVuzCvOQUg7PVP3iyu/PaLJCSP3rETa0TjkK0FxrTwpHY7RUqOgkXQBpvYjU1qImoClxFUfKje/cyqjW7Kmb2a/Jz/JlOk9ue/VZdJn3/6DYG3MyR4MTf1WsU9zdoGIQ9+BtnAjIWhh4l+jxgi7o+YaDRaH+UFPj7oOSvBEPcYyHjj7asCGBA4S18lHp1YJxQDwMoH52sHu3TAROb17WeLNt/7zUQePzhqxpdLrX5JSHKF46OrVANB0kHYtXNO+WeiTYqVqCRpahvBRDUlQn5uUzl0EgEG0ZlwFaem1hveD33tpJNwGxa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E+GnAeQjljd4VtlqcEQrYpCAQn6WQ8SmDjbuu2cZnM=;
 b=jYsdZyPSjkXkA/B7RqfiS1kqIYmW3j2HWojyihre0SdOReGQR8wv2Ntz3tnPvXRUcrycHPv69zh46O6c2mjl+c8+JA3UaFhDdRY2F1wlx8pqBmf81EXHDnccDmtKQ2/xdCFHruqSkAjdOfm2013tw7WCbkJJ1P+hTzJkxVKBDyZDQ6t8xB7drqScgk4WNxPdaLOe2hX/+bUtTB/F0Y6WUa9ehcM01mz8PM2VbAoD9SHE/0pExqBCtRP6oKG/BbMXNClyJ2g39g1/cOCrc2glVb+lGVKmAzg+alFcQeaUK4ghxQiaAmQ7TQzWhcudkk9T0TroamHjwbB8sTBqxEUz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E+GnAeQjljd4VtlqcEQrYpCAQn6WQ8SmDjbuu2cZnM=;
 b=Y6BDpR8LGJQ/Ar+yLH8fc5p9MRg6xiITAsunGW0zFwQXzs2XhPwKaOs67EkhG7eyQ960pjzbNCIKmC+0GYYMlkMT+rCWc1CKf7fyNMRQp6F0dv1g1wmJWX5UgrotAPupBYgH2vStgjA/jlVUVK/Rg5zek/XTFJ1sAeWnqmaTAZ4s4mJsZCcF8WxG/6gOmC7lyIyk6jLlKytgny+aajCec66qkReqQqEzNUC7/PWy/YgJYg7IjukZDiV/W/EadLJCJb7vEoD1v2jjG+ghzgTPq7l5Yvsxp+zaasjuBnhry7NSRJjD0bE38eP+nm+eK8/ZUxKFwDZ9CibspEOOAtCoAw==
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Tue, 22 Jun
 2021 00:06:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 00:06:02 +0000
Date:   Mon, 21 Jun 2021 21:06:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ice_yangxiao@163.com
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: Re: [PATCH RESEND] RDMA/rxe: Don't overwrite errno from ib_umem_get()
Message-ID: <20210622000601.GB2384990@nvidia.com>
References: <20210621071456.4259-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621071456.4259-1-ice_yangxiao@163.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0224.namprd13.prod.outlook.com (2603:10b6:208:2bf::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Tue, 22 Jun 2021 00:06:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTvV-00A0SV-5g; Mon, 21 Jun 2021 21:06:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 636a5b78-c225-4525-6c6d-08d935118583
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5095D70D83682952424D2141C2099@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwC+iryPQvi3O3hsXx4RNA6H+bMb06i3rSg+yorI8EW1BooLta6hP/ntV5nU2Jra7miuHaccGUxH3EwjATpqOLqlmGsGs+9oKL1DmYn5WG9mFAOE20eWU6jdDO8KpzeOEjEBzhFGOe8ewWL2xyrCyZM48/s0zfV29ChpQh0PvFozdWLj0pSDoA9yB4lzvHC4WHVHudObn+Nv8mm/liVCsLXkovvp9a2cuX/DI911ndPFghF3CXpPjxYrRwrWh1ADSgrPfkddbcB3nlr+Kfr+ZZfc+TPIbnNxqHLzPJSMaa3Paa5IKxSfFeT6nswF+xsgD2uvdSmDo4qDwM00bGJadg9I0w8RrPKCXB35A52phbW9IfPrY24zsiQzbpokyXXRbKJUhV6OkYyridE5/rCqXYQD+1MQd2pDttyp8v0KfXngEdSaf0naHRmUs7ji2LiQFBr2R7lRBuGcg8UnyFZB/zEOaD5z/jA3DawqunGGoR7VMWJZIHd81T0cJaA3UfrD6Yufxh7lKpMfQXboilSGcU1f/YX0jTWND+EBNJ6pewUN0TX0YSTwF7MYszh9f3SVhMLHzsOYQn9XlNZ9gM3Cax+GhdxB2L+WUjudPFWDYWQcoE6Q3TvJFYCW/hms9iFIC5jQYPRLIsPpZ3qj0nlUKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(1076003)(8676002)(26005)(4744005)(6916009)(2906002)(66556008)(2616005)(4326008)(316002)(478600001)(9786002)(36756003)(33656002)(66476007)(66946007)(8936002)(38100700002)(186003)(426003)(9746002)(83380400001)(5660300002)(86362001)(1491003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvG/2MWEcWL/ybIh593/tkjz4QLdPKsfp4vlcr82yQz6VL1iL9J6rtBiefdT?=
 =?us-ascii?Q?e7FTtbHACLJMJaSEhPXHWwWAGSKIsAzTh26Y+XHOliQfYiO8pQddAE4bRnwj?=
 =?us-ascii?Q?WvFOvpcG+n/0vP5ry8Vr+Jv0GsC+hPhCIu8DHhQ1SkKXIZxh6g5id/8pzgx+?=
 =?us-ascii?Q?2toWjS7uazBZom0J/xH6728fzblMqTcYXNBEhb8EAsLEhwrwK/Ib5uGHuHNE?=
 =?us-ascii?Q?s9+JPbo0xB1nVlMLXrldoyflqAtpAAuiqipFCK/DDPcLa8y1iVOGgFNJRf6S?=
 =?us-ascii?Q?iAjPQVE0cFG31AjwElP3Qo9vZ1ztONFfiYq5RejI1VpVEHrxD+SVSqQWDCeq?=
 =?us-ascii?Q?8xYM0oybYTwaHt7n1TeTGVCTQbXr4E89fwvyUJLAk/hB6SRSndErcbXy8XEb?=
 =?us-ascii?Q?wBUTRubcXMjJsn5lXwBdFzKBOUrlpxDSMqbb5zDUSpjRk13c3yS/slEcJqHe?=
 =?us-ascii?Q?yFMSpVdqPlj/00gHJVc+7+MkKB+2F1WOjBx0U5NGrvRuGGlGwzaYkmEEGAAu?=
 =?us-ascii?Q?N08v+/Eu2kgLK4P1z9B91FCVLEAElHlyXQNYgx+Klq7WTEPOWYHJ0w5Xnv0+?=
 =?us-ascii?Q?6uALFvxvMs1yiPkNO9eXOeMIe/jNXErwcLeggnpRHO2NNy5Rh2Mc1yJdI2KO?=
 =?us-ascii?Q?yVIRtnUBwpSpsZKL4zGDy3aYuZM0uucJYzMlbPN4VJ0qCnVqxV9hwyZH+/li?=
 =?us-ascii?Q?iE5U2G6HQ48YxaMdG9t3M0VhJUjxQrKBuRvkuHM8TflNBBWPVTDlY9lKVIU0?=
 =?us-ascii?Q?+OKuDIdmskBhovSaWV/FlyExu4zSweIryBFYUxdERUBkOGNsWUxumpvfUZRC?=
 =?us-ascii?Q?dcZ051x6ValBA3qvMQ1eOoy5xezGTbwkHY5KgUnOyS+hWDbwc7Eg9xi8aZXr?=
 =?us-ascii?Q?KqDTXiTYcoLkjxZyvpS2OHGv6ATxmzSnksfJSRN8TYJ2dVMczrzqx705Z1zb?=
 =?us-ascii?Q?dCz4PWdjuA7RvD4IGnwfW81C0s7yPhxTF72tblQaTxgmv2SQdQyT9t8Zt20b?=
 =?us-ascii?Q?lE3qi95NxPbhzonOixImyli7G3wwR2aiNL8xjY5Z1DL03q3YhZ3vilcGeCeu?=
 =?us-ascii?Q?aasod7PA/i+Yxayfv+DssHHxJhHISwQ7QoxJFeZHKk/pySkseeyE4jbcT0i0?=
 =?us-ascii?Q?y8lo9fiUlrjyuYHZBBibyAB4LU3HEzZxLdH4KAkh+CekCSIXr6+w6fGiC5i1?=
 =?us-ascii?Q?qeP3rELNr1STjLB1xA5bvl4zcS1b6veh9tJqoNsw+tJYAN4I782Id/VcJxDT?=
 =?us-ascii?Q?f6YsyGis00CIO/lHcyX49IANf1IgiibU/oFh0H62uFCfSi8NfNWDX3ybatbH?=
 =?us-ascii?Q?3TRlHcNpXMmS2Eaks9Xg3Afz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636a5b78-c225-4525-6c6d-08d935118583
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 00:06:02.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wK8nR23Kb6ZeOnLLlBirr8SI3ptewqzza3OZw5XYG1PnUWB8iGvexoBEHFC9GeLu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 03:14:56PM +0800, ice_yangxiao@163.com wrote:
> From: Xiao Yang <yangx.jy@fujitsu.com>
> 
> rxe_mr_init_user() always returns the fixed -EINVAL when ib_umem_get()
> fails so it's hard for user to know which actual error happens in
> ib_umem_get(). For example, ib_umem_get() will return -EOPNOTSUPP
> when trying to pin pages on a DAX file.
> 
> Return actual error as mlx4/mlx5 does.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
