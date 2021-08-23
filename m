Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB33F4EC8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHWQzY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 12:55:24 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:22180
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhHWQzX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 12:55:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnnJfBKO7pmGkXd5NsD9ME3s+JfM/RfoZR47JLGvnT5/0su1e+HAk0vBpUI7Wyln0mN6E5GnU7yKpTAniulxnWIcPwCHZ+JzEvOF1mjE5HLpFaE74wlTNSfUjx583JITGf4Zlnfg0fFGWtCvcnaWg6zrTYa/ZpahS/ZiJPE+Fmyj1SRyxcovYuK4mfdlpi3Z+tLOJtXzMOfRdT3H+4bcC43I4GX40FSd9mLlXjdtf0oDkex2+XVdYuea2rqJI1ENJFPOa4JTU2NqcJjxaYhIMl6Q1oUcyx4F/izm/FIhMUsf0ddxd4kWP2+zG9gwvNSqHpz5OkxgX+CAOh4sUESyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyjvUkow50w4gqHCimDtADodWXjDe/ozYUL385j8tB8=;
 b=R3VG26jp9iaaF9VZtFpf15qPqmTpqChx3lwCZ52hV5l4Np168cqIr5LP9SzdmI6452Pg1RJ21CCuAa6c+l5c/IExgsKOP5YmUZZiSs93y4l+EE+s/5/ES8NgtW4anxYklCmWJoiu8bcCU5UG/MbwJ5a+Bnhzxyom9Mk5zZu11ta4xX+8Awjf9NBfaxprbPD3Kik+A+x1KpaUG0KptJ417hsPAFZepK6Umm1J+zuEWYdZIAWaofKI1Z0k//K0/dAWvIOD8Q3+5PHnbnNdImGUjlh6zC4EA4UulZQTf2R22GrnmLAJ97tWhJJ5gn3GYcQGu2vd/sTjK6CmtvYlkkLaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyjvUkow50w4gqHCimDtADodWXjDe/ozYUL385j8tB8=;
 b=HNfe0PKGOY5dq3DfyppRwKasNCqO/WI3emPmV0xe4waS4PQz4avm+flLGy0zq76CiIys4HTOYynzQR2s8fBNr2HsjJ21lJweYTuqjn0DDILnhEN6JsT0rwnKyCYDIohru0WdyEu6d7L0sZWiI3nmaq/EhLHePNpO65pn2IhROi4k633lekyqwWFQNmuq1FW6hBw9u+N2IdhEr9Bw968ObVNM88vR7GlqPSJeQ79vM7880AdSXKjk6DPnvYzI1jOuMSuO4UaxDG08iNUnder9Ss+mSYOqGKAoONKPOWM2uXEiw6JNmF0EsikmqSAccW0YO39YPheFsFEP9hOptGYTMQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 23 Aug
 2021 16:54:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 16:54:40 +0000
Date:   Mon, 23 Aug 2021 13:54:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] Enable or remove hardware features
Message-ID: <20210823165439.GA984782@nvidia.com>
References: <1629539607-33217-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629539607-33217-1-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:207:3c::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 16:54:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIDDb-0048Cg-4U; Mon, 23 Aug 2021 13:54:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ff5d887-08f3-4b9e-98f9-08d96656b283
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53641097AD23A015B431CD87C2C49@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZhaGQm7NTexXKx+o5fsSOD6+jzUmrAxW0yFICGHQY+VY4AIj5cft1TJWxQrmfUx8IqqqiwTsBlm+tiwRflD9PeaxqOcJnscG+ISRzav7dU7tEvEjg1mw3FLVTNFpuSu1wBvYvz6WSH5WaSeOHCWHJ3AGmU1iiamsmme7rkiNXgGfHH1stxaME0HOj4f2BhgJbYPJJnMOGGifEWXDazHzheHObTr/W2zITAqlaAnIxh12hgtWvTtnX0V/yR03d8tJjtjJq8+qLQWHytFq0Z5zuTUHDN5hkO9QC4HUt2bqstZVsKmIF2a5xOTuWVZYPugAoTSdEEOSk4glg9jvIWh0gm4O3DYKjxF033i1Oo8gjKbIxnnbGJiESKlkBxTdiNIscZcfB8g2iA6037iRFoQTo/jCueG6678wHX/5r1hAXo7YX1euUJhJLObg6RyuxltWiTLvFso4/CW92TTuvdPWdEtbHjNq0JJlB42S2oKlrRtgp9GeIMV6wqisekS83LfYf7bJhvzXq6bR0Fkb9F6DfDjtJun1Dd1WaeAZXZ6tOhC8Osi/CKWJkGyCzsoRLVjmqv1yDAw5q0+Pk5ckV7t8BkSazBqHR8s3LcqPJIu8fGIRxhnrp/WWg0dS7lxqDwM6QCcCrUttlBD6N39i3i2aiPaH/ODAUp/oLOemi7MEitJ+r02B54FOAeEhplwmCd4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(1076003)(8676002)(66946007)(26005)(478600001)(6916009)(33656002)(66476007)(186003)(2906002)(2616005)(9786002)(316002)(4326008)(9746002)(426003)(38100700002)(66556008)(8936002)(86362001)(36756003)(5660300002)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5YnDJ0dJCpjlfiqvmLRsVweBxq0EQN1JE6sOssWZoy+Mk1EEhhhNK/2AIHkO?=
 =?us-ascii?Q?xHY8wRf+zPQSRQuKI/taYOoZZ3HSmwY7CI+6ItDcONZHrxsCAtfM+YBtLIuT?=
 =?us-ascii?Q?de0Fm1CnaYBmZWwD3A6g+En0o5dPupRneRIKm7WeQdGl6tYGqqrRXfRDgqaZ?=
 =?us-ascii?Q?IK+EBjjacyInCu129qCipgnVIFKajagbft0MPZ88gAunHNtFnOncEovMJyLT?=
 =?us-ascii?Q?xmgmfkk/BmtX3hAtABFJR7vBOoWusPcwO0rLY6KdsVZawevAwnLIjI7xZS2M?=
 =?us-ascii?Q?A+hlqskii9mVk6ou4FVPpqRGYC9ufrSUOJc/lt8t0Jf2437XQUrI3t35I+sR?=
 =?us-ascii?Q?vYLiE2W4b15aI9OzZK+AJZ/5L4GufCGQ6W1nN6zEFgLy2D23N/MF5AUJqqy4?=
 =?us-ascii?Q?uhrDVhvae6r+h252U7OnLn8HpSMVa+C+R0ct6iTqkcRJ2HFdpNq1cmv3ARV0?=
 =?us-ascii?Q?mK9vKFxrXZx95Yw1+Hct51zmH1xmV7nUqrDpqVHLZe7xHV7qnlFkvgkQe3tS?=
 =?us-ascii?Q?zyG1qOjz/Vlj+v/8gt2fl8j005crkfjIP1AYfHzPK776AzAOsb51f65rz/9a?=
 =?us-ascii?Q?in6ljc4Rm0Ecuc2epRy3AzQHu83oo734YY187VnOm3MuCo8aA4hGdiH3HkoR?=
 =?us-ascii?Q?ws9W6PgibdVL/6/x1YpyvRSzp5UAHM1hV9d4+yRfT/6DJWs7KtgBNeE2iArW?=
 =?us-ascii?Q?mA9XnH0UhWAcLqYUOV5RH4GbNW0oD1HEClhIeAYiMtBnzzIxYgzqESHJD/GP?=
 =?us-ascii?Q?8tDxcCl2b8MxU8RNcWPzILQCZ6XDBPVdBPIMQaFFmloi3drx3Z9Lt9dG7HrH?=
 =?us-ascii?Q?x1ZsHtBFdJkEmDjrT4qg8uZpqNbtBrpdlOViBz4JLPvgJEBt0sPNFt8kGAOq?=
 =?us-ascii?Q?rQUUlRR3cjEyHxnSqP3Cj1nVM4UxOz2+fko5yaMmRyRXnos1GrbGmmaD6Ksm?=
 =?us-ascii?Q?BiXiL6P5qv+L2R6M1hZvlG87Ad77r7twnAo7OeaSpl2IEI/jGwi1qhBxG9qv?=
 =?us-ascii?Q?/9PxNtFP1lDwOeQdJHDRQqk/hWNBJqz5fv3IKkpHYMLeDIZut/lV0XjvaJEP?=
 =?us-ascii?Q?WtVBpgLybluIW8+lxMkYznwL/gU5tSPAskzMbXfQeJG4NzWfAOpSsjJ2l+q/?=
 =?us-ascii?Q?GKyRqiCQkkp9iAwDnojUvh4ZoLX85emu/DI7BKpvKtXzS5AH2AjeRzXaxeMg?=
 =?us-ascii?Q?KkjqHgvgSbgwGG224yg/Pk219MiGRKigeLqGJyCbCAdzVrmW1cPqarHP56J7?=
 =?us-ascii?Q?WlvU+cRvS4I8wGlEO6Z6ZkJz1PdOlsgh41n7C97dUQuMVTm+BHz0WOz9/MUj?=
 =?us-ascii?Q?GouKcmM/c0K7O9Pi/wnHlDkV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff5d887-08f3-4b9e-98f9-08d96656b283
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 16:54:40.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7Roi2Dwf82peH7qr/6MHH1zJ+3TyAgJ9cHxJ0QZ6vDF/vZ5lbFMxx+0a2KU9f1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 21, 2021 at 05:53:24PM +0800, Wenpeng Liang wrote:
> No bugs occur, just enable features or remove redundant flags.
> 
> Lang Cheng (2):
>   RDMA/hns: Remove unsupport cmdq mode
>   RDMA/hns: Ownerbit mode add control field
> 
> Yixing Liu (1):
>   RDMA/hns: Enable stash feature of HIP09

Applied to for-next, thanks

Jason
