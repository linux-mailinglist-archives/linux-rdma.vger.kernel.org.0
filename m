Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC43C621B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhGLRpi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 13:45:38 -0400
Received: from mail-mw2nam08on2065.outbound.protection.outlook.com ([40.107.101.65]:29536
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233570AbhGLRph (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 13:45:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/TaPyT/wQPvBmVYfdX5+uO43zObHzy29RZXW1xGLFB9HOifjpYFqlqTeCXXUAhYaqI90GrtSSiVNxeXwZ1k4gQ4eJRvRm02cZoNvWcQ15YB4m2aoe0myejWGicXl5lzj1x6TilSi7e3d1kKZubUrJTexvtuOW3pd6g+4OPhCuVgGMeSHVTQwUy1lgly4y/YWbGxLrimp/ht33dX+JwGf3Wo6KUrStan3XcJOhvMCjHBCkzox55dlpmtOD4K6uB90q0m/xniRb6O3okCcbNXNNeFXD9zT6HLIJ8lUybi858UKxCTB4TUdR9scFXaEBCt3OiXoj6QrurwX15hlCJLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPoxdgHjpijYMfPC9u3slXxQFgoCMNitbOhrMahbDqo=;
 b=kYOGSxWTpFTwFBb+EMuaG+TpHzvONfvTqOEjIlvmovN9oUVPrsWylhqw9lxcZTTGDrz4cQfv4DgFdy9hv9FZVIzOL/iJtw8aEZD2gxc/YeAVDbR7cuugpH3F6aEJKR0LquHCB/L+KV+vjB8Tgsl8eK+ZpfTIL76SDK6BgB6pLPqOAjs9xAHZLAR1z8VLYQQjlwKBIzy1tij3owypfgSbeIoSWYkREuu69syHyfVooW30S6fFM4eZOTfKBdEntEq12HvwqF/VNJ6TvepmY13BmsB1xTIavVXrPFrqq/B69/X+ik95LNExlKGvK2k911i3HXxLfalQgG5rTNtXYdoltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPoxdgHjpijYMfPC9u3slXxQFgoCMNitbOhrMahbDqo=;
 b=rUrZdTef/D2aHWDr19qFzklLPgyGqTtgmWpX1iuEiLb8b6NKZCiLuFe+j9hEMcSOl8Rq6CVXrjJhbxbk0pqmH7btNoPbgkBsJtXw99XKE4mEjoVZt2IA1RBclGhxsSX1I/jdnA7OpQ7FnzlIij+BbA1UVGF62tGkvIOutxGWdNteg0shniToKslD9InhG0wGFaT8Jl3QfAzoifIcZkuuMXhAocq8dAyKGNBsBDEtYoMxzHq82B8qzV0Svuv0rY3UAcgNNQgMFgLb3NDqtezCSZrpKBJdwO4bfh+P5sz+PjpQbjSIVU/FbEoOayvIUic9++WKQDx9ExkVk9a2qPo5Bg==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Mon, 12 Jul
 2021 17:42:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 17:42:48 +0000
Date:   Mon, 12 Jul 2021 14:42:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Subject: Re: [PATCH v2 rdma-rc] RDMA/bnxt_re: Fix stats counters
Message-ID: <20210712174246.GA260076@nvidia.com>
References: <1626010296-6076-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626010296-6076-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: CH0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:610:cd::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:610:cd::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 17:42:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m2zx8-0015fM-CS; Mon, 12 Jul 2021 14:42:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a95bb18c-3884-404c-293d-08d9455c767f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5063A1FF632EBBBB8F9C6F74C2159@BL1PR12MB5063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Mw7ynkk6B0fKcAnvCMQqxUy+/N05ixZ4aYXOs0DXwBuEHHi8sqGkpDYNjZRE13ykDJBLnUXs4SXp3ty8td/WFlJ4UhdwM3a77ABHycEt7vVWpR2+PKc6MkfGjaISXlE/HwDomgozk6PjlKGdajZbZk7Ozd8mGs77aA1TggDXquT1Lu1/EsyHoP5kzXtYRwyAPUwxn2lSN9AH5rzp/hXjjv/zHaVgsVTuG6RmgYO0GzNwWp4uSvX6G0WyA4/q7rG9jQus1q+wZM6i5NWfizaeP01KXVg4ImEc27DgoQPw23eYAlI5TLEXp2eqTzw01rVkWkNPgYh2eCJx/E/sFPffZH0idHam2YmIP1TW4tK99psX+5ocyr2wHyKJu4wzi2zYCj92rfB0MW/RUFljTYvXhJWtqN/zClbRYqASEDLmmZNkLOwNIq+alPylcY0xC5aIhgScsZ5O3epS+3ey6ipJa0bp2COPUiIdZAfM9qfeHcptvCnD2b64uI1b0yRmjV/Da5sFk1fqVhsSJ8P7SUcnARMHpsu4URfC5gB/vLo+UOJUI/QJe3KgtyF+T/jOngVO9DOLx9jhPL0hshAyHQGS0PvU46JW3BxUp+p4Zinhr94aUapQCoxErkDQu4QdxpOG0aXMpyV+xLbXRaLT2G1cNzuezH5f6v3kA804HZpT3OvI2Rr9bQelx9uyYHYftyNtSVWDoM1DyAH/MZ6j/7Rmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(36756003)(4326008)(2906002)(5660300002)(66946007)(316002)(66476007)(4744005)(66556008)(478600001)(186003)(33656002)(26005)(83380400001)(9786002)(8936002)(9746002)(426003)(2616005)(38100700002)(86362001)(1076003)(8676002)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o+OwNvqVBcK4oh/SOOpeu9C6ircphuBlj/1ia8Eu4OsGEmpBGRAqs5Hay2SR?=
 =?us-ascii?Q?HNYq4nWYqNYQacElvYREoxU4sKkwF6pjYiFbowx4bAxlc86c/1DvzAbjh4LY?=
 =?us-ascii?Q?U+JeaiHonuhzR6uXQeYZE6US4314yf9ZDtI1tU9g+HVpXHfzarYMt2e9zY6d?=
 =?us-ascii?Q?jjHac3RrwbZCMI2nkyn+GQYTJkMUjnDpG4tI534r2CGbInYESDFW/lKmhSxQ?=
 =?us-ascii?Q?TMCbb4L5zLc4wAVoFeAg8WAn9H4JZzryYNnLXLFzbk/XcTIRZn1Uzyj/Xdbe?=
 =?us-ascii?Q?jQHm1JfNQIGLEudUfAzSvcizo+ctzZjv6sa+hJrEPMyN/fQC+GZ+tho+8DDP?=
 =?us-ascii?Q?bsE5lMCqN0QZfEd0t1jKjVFyRP/8Ciy2vpUfocP7RTLKJUlYl7ojTauLjW33?=
 =?us-ascii?Q?JmWomM5YA0udgAmsOlEioRXLVigYBOWSPuBs6Uyd4ubVYRNhI16LLITc+Rou?=
 =?us-ascii?Q?qZBlzb+cUGoIf6Y+onlr7/U1HWTf6+x+6L1v8Xr1diyWmgxuQJRyaMpkAlBd?=
 =?us-ascii?Q?NEMFH3Tx58t4FR1niwafJGZHCJ3MQR4TuZmjdPRx99hXOsMjPXPjCGo2V11w?=
 =?us-ascii?Q?nFc71diaWO/WfjeHaegtoNvOMPxBa6sd4bMF1Ybqp9EzM01lviPpL1MBDuWM?=
 =?us-ascii?Q?OjKRbfYGCGMmzfZJKDxp9CB1g3S/8yvdT8nZyJgQnDCZsd6dLOYj8iteETfm?=
 =?us-ascii?Q?XjSsi9COklhabgy0zI111PcAmjlarJyKRlY+4xC3PrQxIBmNH3N7yqfY1Ews?=
 =?us-ascii?Q?Mv9POa8c7b+Zevp1MME39+iJkMN50SJUg3N/8Gyr34+yM3eHxp0DzOYeEZiG?=
 =?us-ascii?Q?09CPdWnTe33WFxL7cTuOXpxFfb5cqhY8Y0ng82rk6HRjF0f4njy0yJom6Uge?=
 =?us-ascii?Q?+LD6tfAitSDKpwsQIniVSb5PuiT6k/i5Afal4/2SDDnm23QzOvrpPyXb0xfm?=
 =?us-ascii?Q?50uq78aiICe7+516WnBpJVngaWgXsmsHfimLkM+/fzVQ7sYBI6P/wSBGJ7r/?=
 =?us-ascii?Q?EJNl2ONccKzeyTSF0o/N0uy2yt82maPKind8yXaik7lMWHkwmvHf2Ka6O/F4?=
 =?us-ascii?Q?M6JIJtXIKdgZj8KKfrhkXPY4ZsluwfVw2asMJuCrgwIuISrZ9GWz5Z7T1RWu?=
 =?us-ascii?Q?paflQfN/ujqODcuCKYNm2VIIGC/p0ihBgsdYK8JbyKSu32lDk00C2f26t/6C?=
 =?us-ascii?Q?tNK5XhA8atAVZZYg0bnW7Ec6GRhzAbE4J2M1aeYNjQ4yMTQ2U1fRr5Jd2f4c?=
 =?us-ascii?Q?+BkHbi+icizdcNftJeSiQmEp8oHSeI0pjiKdyU7Ed4hfo1LfwbNgoyRuuonP?=
 =?us-ascii?Q?6dPoEVq/Tss7FDVMsTw+Sbx4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95bb18c-3884-404c-293d-08d9455c767f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 17:42:47.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asExyYKHGup70KaSsYFUDO1ShTWz86uCAP5RlwyNueeEj2GWvalgLWlH9j5kMh0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 11, 2021 at 06:31:36AM -0700, Selvin Xavier wrote:
> From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> 
> Stats counters are not incrementing in some adapter versions
> with newer FW. This is due to the stats context length mismatch
> between FW and driver. Since L2 driver updates the length correctly,
> use the stats length from L2 driver while allocating the DMA'able
> memory and creating the stats context.
> 
> Fixes: 9d6b648c3112 ("bnxt_en: Update firmware interface spec to 1.10.1.65.")
> Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1 -> v2:
>  Corrected the fixes tag
> 
>  drivers/infiniband/hw/bnxt_re/main.c      |  4 +++-
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 10 ++++------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
>  3 files changed, 8 insertions(+), 7 deletions(-)

Applied to for-rc, thanks

Jason
