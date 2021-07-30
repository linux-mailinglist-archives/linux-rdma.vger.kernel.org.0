Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2893DBA07
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhG3OGt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 10:06:49 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:20097
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239052AbhG3OGs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 10:06:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxXWmSme6S8B76Xh8ShgK84Cx+aAMoDWY1KIjYl6mFzSOb5WxwxTVFNEHL9L21hRgLfFPNrAxLCplY4+60ltoeHyAllne28is1gTFxNR+1OUrzP2z25PZGVeBdd0fV0GmdjVi9/Ydpfi30037cC+Y/2rlQ9YqPIyP3zjxl+cHhLpG0x2BW1XXSJuzQfmiYUCTL8DLcm1QSisdMhFZyoPskVCtjDfyqmvBJJ9br3M/C1VQU8NQViPuZV9h1Z8QQwnG15xYnyTNkeueLCGCFYpWWHIkFVwgGMXYKfo8jn1agb4eoAIvF9z3p4mxObYHIDmxRoPaA4BCgVgwAzsSZ9HHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+eOfAXsTP/7OFlGNs6XFfajn2apRcQ1flQV27BGTXc=;
 b=cxcEj6UM/nuTugG3xPjPVEfF8PNmVaQasB2h9cM0iYg5Qd9NWd3Ad7JmyTIKlH/ggPLCUjapkG9ihq/NOgX+ukjQECUaGdPn1uWBPAZyQ5Zd1iwrPP2h/0g7fE4l46yh3pveCtD9v0Ng2F0s7LMnFwe0HqRbx1gVnE64DtkfzTgNYh4Q+DiW/d1rqGGmZ+MGfJArUDgxXfRnSwszI+7ndwGExyJz7qF2Nqlv+Cc0cYC0z0wcrgMkb6KuW+YDTwr1j7hNQm5oXNuyrAHj+MI/xrXkTU2unbxdTkWj+gikLMiA6Xfpz1PypIVEU+I07zZ48vf/vQ4lVcqGQ4WN71UzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+eOfAXsTP/7OFlGNs6XFfajn2apRcQ1flQV27BGTXc=;
 b=TGKIOAET3+qjXZX1npP6uH5jcg20E0nr3FMBugeM/uguGjNDvdpiTAzYlkdyo7nXCk4GVUT9rS2SmI1u1ptz4LiHzNi3gz9T/prBnLv/xDQcSehooe2RrlFrpHN3o96i0YJtjV83EtJ4TYbWQFJXCyC7vMk6xYXT8f4W0IGByz8xY0ADuhVAerMdMQaEm76/2/zaLVTUc5/vzJeOKiGkL6rjlrBfy34EX7AwIr3N4tMdjoT50svvmJUjhDXZgs9fMf1AUvnS1MQKGwLDFBFYqYRuzksPQg8ZkHioHfWhH5MqIpzPLPpBqxtpHBGqgeC6NpkyNxttQOnE/5DnQtDstA==
Authentication-Results: fudan.edu.cn; dkim=none (message not signed)
 header.d=none;fudan.edu.cn; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Fri, 30 Jul
 2021 14:06:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:06:40 +0000
Date:   Fri, 30 Jul 2021 11:06:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] RDMA/hfi1: Convert from atomic_t to refcount_t on
 hfi1_devdata->user_refcount
Message-ID: <20210730140639.GB2559559@nvidia.com>
References: <1626674454-56075-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626674454-56075-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Fri, 30 Jul 2021 14:06:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m9T9r-00AjsI-1o; Fri, 30 Jul 2021 11:06:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8ddb9f3-2ed6-498b-47a4-08d9536340b4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5362:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53629F590380D1AC526E46A3C2EC9@BL1PR12MB5362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFB6mH494DcEGVPV+GM23Oja1FWaCPgQ2R6CxG6XQPWj0cos/vLzcMmqDl2jh3cZ+gv9AJ9sThX+XheS8fCfEDOcVIZJGTkLQPfI/1sNvBbRx6xNA2hhw0nKDmZcYOCWr0ALncuUuOYM4nV35dB4fg62lIJl7Lp89F6vk/b+doUlayEQ8ZP57o0N4/TlYXi9a+rBQzO/YAGJSzVGh6FYZgoxFqRsVMkRliWoinuobS4WdJq2PTt2IsNG7K5Inykz7Q5fPi16K/DLbwZGX2hak7nzeb4Jzw1rQYRf1g7agxnMHEb6EQzColeqRbFI3sgwLynjpXauzBctGvfyMjDNdxKn92Wrcmc/C4EBrjcMdcogMCUcL8NI8Z+w3Ez00o9cxhMzqpYCRy92YgQ1g3tFTrG6z5VBvuHw71I8q0iKFlFEjEXedOaOVfMtEF4bmNbdoDw1sk3CwO1PugCpXVDBPTbl1n0Nvy1lWWzxsplL6zjDYp7ALJssTleNIr5MWZ0D2y7bRqpMv8J6IOXPotuKoeXXZ0C0xo3sdzMxl6RQ62RELpl7bgrMRegObPU0M7Cg0btCFyMM0s8OMrVC0BeerTTO2fAfSU6ShHBAx55PVd8zF58EyKndDiVQy1GFrVqYoJ5gysRj2VzuREmN8Lb3JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(9786002)(9746002)(33656002)(8936002)(38100700002)(54906003)(6916009)(426003)(186003)(66946007)(83380400001)(2616005)(66476007)(66556008)(478600001)(4744005)(1076003)(8676002)(316002)(36756003)(4326008)(86362001)(26005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOeocBEUfnkTqniQgoqbveBVaCvpgm7yxw0tSUSAJdvjGEFY3yZPvkfGWXC8?=
 =?us-ascii?Q?M7WbuCZn3SbZk/NpfiQWTlRtxwhdjaT1AXYlP16wKLtL2ktGc1PiAyCYVOKs?=
 =?us-ascii?Q?PRN7F0FQQraacjCPXMqk4clloTZ4dyqUg2eXavpRxP2BSO4FA6LKcGHxooQM?=
 =?us-ascii?Q?sqqUZ/MsJ88Gws7ljEMhm6hhWEAyfusoBesvIBHYSr1mRxdAujpfhpwEOZXl?=
 =?us-ascii?Q?d7UzSfyx5qCr4U0cNFhGMakwI6SBv4IibUCuB9ttgrTPhLHwQKQeHuo8OOnZ?=
 =?us-ascii?Q?E4o6/VvcVYqPSs6SgOJb/BGthZtzSMdV+6tunCHMAQyiiHevcrDNuzFxRM/x?=
 =?us-ascii?Q?WcOuF1cA89JmHJojkNRfviRtXKUPhv9J+sPFV36N9obylgVNbVi2A23xjvt2?=
 =?us-ascii?Q?D7WWXGY8XRCYrEbOFkc1osGkiPMrCxFvbEZ62rBhI+dlBmbUXg3xG+k/P43c?=
 =?us-ascii?Q?sTQtZIYCOiTwmdsZWHVC8EiWzfRj+s1nEMvBj9NUlv+hFD/ifB9RZkQ/bkKD?=
 =?us-ascii?Q?XzFebigB4Vwb5ZH8v9SNUXz8okqLfbJF6/Zv+Rj4N07itnJBCdByCEw6WMWD?=
 =?us-ascii?Q?VbXm9r8AF93FxCIvWLGx/XTqzu47eZV/KDUkvh3pgo+mCCZEg/c6j6/XXCzV?=
 =?us-ascii?Q?eYZk7Y+wiB9ohXN77V2jC9G1bybKg4XYuqZegb74+/77qE8rL6SIUTDS2q20?=
 =?us-ascii?Q?lGwXqs3pAwid9OUGGQMhtW2TbchR8rVlsIIiB9eZmVea4l/0p0TUI39+2Vd6?=
 =?us-ascii?Q?Rqqx7/8cNopljCpnrKlp0C2n6ZcElWxqq6RUOCExcjjeHy9+vTLH4yLV2jEu?=
 =?us-ascii?Q?IWQzAzozknmiZTzNJ+CSEhN3kGIXUFK8VhE2LSc605yAt6J291mjQrhgm/9d?=
 =?us-ascii?Q?1ZGZzm1w/sfPe7dOfFtCqiDJxfuqYlq0qlSPfqkwXTbuW3D78RKWqTcLHOLk?=
 =?us-ascii?Q?TP3JNAFUhcei28ZbZEn62XdxYvUFsavnjBJC4QduZ91goN2FkXRi2r6ikDZ4?=
 =?us-ascii?Q?AOEuhDYE4UGeOOBHdnp/VpObvMBByCKkzMwQyXK1eKWvXC0E+HCjZWGZcEuR?=
 =?us-ascii?Q?CTN05DTC+zzTJF4Uvgh3UbfxfurRbsFiEREG4c9zZ5KNkBKC958Nq6yBCW63?=
 =?us-ascii?Q?8F4ktZ0+xvj7cYHgcJoz0FjStqolZzDNo8j9pBxeFtBSuKnqqwtXHhnxBSad?=
 =?us-ascii?Q?rHtXepTcH0qcfRDGDtn242dv3UuokrpRuCcker7vSqGqart0PDEK2bpQb76W?=
 =?us-ascii?Q?8OqC0jlnIbtBtyeAQPUd8bF71Dt/ZFbPFCVWQp2yi6+B0+j8pjMsnuefID6g?=
 =?us-ascii?Q?PbHkQ/9wz9AEgOY5iyt7n/SA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ddb9f3-2ed6-498b-47a4-08d9536340b4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:06:40.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkn8l2790a4xRe4H6ez+bF5hGk1AEGnFMiZqFzGGCbyx0CgNCE9Vl5bhKQc7UfpJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 19, 2021 at 02:00:53PM +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Tested-by: Josh Fisher <josh.fisher@cornelisnetworks.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c     | 2 +-
>  drivers/infiniband/hw/hfi1/file_ops.c | 6 +++---
>  drivers/infiniband/hw/hfi1/hfi.h      | 3 ++-
>  drivers/infiniband/hw/hfi1/init.c     | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
