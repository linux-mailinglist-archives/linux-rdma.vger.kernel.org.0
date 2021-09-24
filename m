Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0867A417663
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbhIXOAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 10:00:42 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:53728
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231176AbhIXOAm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 10:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5jcYeYlIGcmPRcE7zWgZ4PhuftHj6/JCKtaMRyHz8GOrFgi5qdDVYcRypBfTThSvBGrtQaIwoLtRAq5V+OuxYbeTgUPRyZYCQn5bmrtTquPdEiE3EUqXfAsf0FHuQzrccaiRKl1P1H0xl8pSfSbsVvngU+LSCEeoVsgLJPmlYyJOyHgWY7fTd8YsjNmS0KB2tgDn/WUDpf3PSM3Hi2NhxIY6LG1l0rgdTmXnQJvnzsek7UTo7fe6ylFdITOxC5ZH40KzMCkqx4/4wK3fw+axbsoxPKW2zJjHHMjxwAmgI5B7snRhfic/x+XICEFkDOJu2g9Zu4UKWrtr3alnmk1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VU/unksrwpXSE8ynC65Xm6OYmFAkZnhoGU/nnq5q0FM=;
 b=OV8mU2zI97HamqMhELU6NX739FPTp4OkC4ovUcfcJIqCkhLq4y2hKpZcDvdR5ZhJVl9AsJpH0vcuueRw4C0c593t19Ts6Kr/9svTFxMR+/hyKEM8NLh+MUGn8O73IPXkxwZC5aQnoOjrMm6X7R/fAzZwP5ee8TtMrtkRIL5U2R6IF+nsep2CqMMgFy8dYpFeuuBnJmd/FxgKdi6HwgUaA0S5bMVcLTNQDB09zYpBfXWWClKv8AU2kM42V2XI9TyMTVJmVdJBdakQQ/0UNBdX3vf79wSEdOXUCf8Vx6sOpv0yv9S3KW1+YV2ZdKe/0f+YdwlDVCe+vAxpq5FPiU5ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU/unksrwpXSE8ynC65Xm6OYmFAkZnhoGU/nnq5q0FM=;
 b=hhu1R2+L+Q4gq9BFob/Bk2k3XJ2EUF/yc1GUy9zezXHrNeZ47ln+xDfVszhFDg+NX4HeyHR8UbLZwYbikFZO1b1fpBj3fa781k9ISaQyNOeKPi6WHgMBOrXe/oJ5ZOh4s8ra6NaceeDOMfrF/X3qDXsaJockBxwYKlA63+PFGxSNFMvhL1AcmTg2hp/W9avc2hp0sFrg8mbV2D2CCN3dYSqR3rUDH8eGJWYd2ZIgGgEzJecchORzMk71Hyo8N2r8DawAu/AfJ/id9RIa06AgSvh85djvKB5FaCnCIppqlU3ZveutQ22fnfijwMpnXQUj0fSy1lkQqdn8o9U/lWDZAg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 13:59:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 13:59:07 +0000
Date:   Fri, 24 Sep 2021 10:59:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH rdma-rc] RDMA/usnic: Lock VF with mutex instead of
 spinlock
Message-ID: <20210924135906.GA1236744@nvidia.com>
References: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0334.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.9 via Frontend Transport; Fri, 24 Sep 2021 13:59:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mTljG-005Bl9-Hj; Fri, 24 Sep 2021 10:59:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64f876d3-cd9e-4aac-534f-08d97f637a01
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5030F745CE13989419F2E876C2A49@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmlNH4DEHbQZGZWDQt9JLj3fFR2hiEoOmFARD+wwPk17aM6fTdIDJaoppBa8oeaoeW5ATnQonjZ9x42KOXknZxUwH09Nn1dO48JHxmd5YjU+qX+QgrBSDJovAOW0UNIeaczCyNzk2IU02EWtYtQvoleScNeUCgnmp+6y4GK2N01WU2okiBLPr97BVkbdFxb0LM5FfV6WwYFDs1jagaSRsgCtFS1qQ+8Ej4VA2Ey7c1UgEi/xO8abGrkJkMfBD/1pzrPHiqCP+AlE9C+1DePnjHsESNZPwhuxVpMh+CoNFYi3JxQnn6aFnzsqljT3L2ngLP2AxQfaE0GHAAA4q8/JX7BIwlu9agjmgVBepqcMeyeAescWdSpufk1iGF3iMdyQIHp4WXth93LlysmW4aBu5WdRNQEmY5px6Ra/gMWmXdZkHvZVVqFRFmV1kyvzZig+4VpYxDjBCPyTG07jwJ31qxVzpQ9lVHfcdlWds8Y0zObsVi7xueBaKn5nUMzEZukRykE5HgcJlpqwayi+0XNbgL+6pp2IYl70Z04Nk7cU9aAM6bcA64OfOIK6Aue5qc1ikHDkhsYyW1dfn1nIZKTyJxwBtysd3qFXmVCyp8cp5Ty5oqDs5vaM8K7KhUyguNXFWUhp03FfazByDuCyWQd2Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(83380400001)(2906002)(33656002)(9746002)(9786002)(2616005)(66574015)(86362001)(4326008)(8936002)(8676002)(316002)(38100700002)(66556008)(54906003)(426003)(66946007)(1076003)(508600001)(186003)(26005)(36756003)(5660300002)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBqM2g4Ry81NGpGby9SVnMxMWV0a0JKWU56RjJrNkQ4UDR6bFJLd280UE1D?=
 =?utf-8?B?Y0R2R2ZaRlRGU0J3ckU3bG1TNHFQalVXQ1VYNVorVmNTUTZTYUN6MzNhWUEy?=
 =?utf-8?B?UmVSOE42bzFPb0FCSTBwV2dSL0dMelBsUEZVajRGTmZQMkp6akdTdnFZV29t?=
 =?utf-8?B?U0RLSHNOU0RHZ2hpMWJCY3BpT3Y1aXVEaTBWMXhnR0ZBemljUFpoOHhTa3Ro?=
 =?utf-8?B?bytlS2hqZE5JZ0FXdEdKcUtYblpHTDQ1ZXQvNEl3aytoU0lmSzB0aHBIYjdC?=
 =?utf-8?B?T2p0NitlUktqWDBuMG10Q29ucFI5d3dtVXllV0lnaENmdWVJRDZlSHAwNmFN?=
 =?utf-8?B?S3NVSGs2TFB6aVEyaWJhNy9tVGRqSjdBN3VRak9pczE3aVVjaHU1UWU3YUcr?=
 =?utf-8?B?dmVFcGh3aUN5eGpOeG01b2ZHMHp3eVBSM3hZMnU2cmxDM0FUaHJEUFk4d1VD?=
 =?utf-8?B?Rk8xZGVCSm5KbzFacldHTWdoaVhLWGpkMjZxTW51YnQ4M3ZKcU0zck5zVk1K?=
 =?utf-8?B?Z0JUaVIzaVZVR1RzdEErZHhRRHR0WFhkZWlyV3B1THAwUHRFeTJlQ3VKRkxP?=
 =?utf-8?B?RWx3ZGJ1MzdVZEdMcURSTm1sUmZwT2NjT1ZlV3loL1IxTVJyS2liRmc1a3Ny?=
 =?utf-8?B?Vkg0Q3ZaRUZrb1U2bFpta09IdnFkNER3VWU4dVFDeU5oUUtDaytLeGtwM0lL?=
 =?utf-8?B?L0t3dks1eHRDUUdSWW5oNW1ML3ZQVnd2OWVYc3V4cWsvK2l3QTVkNDNzMXRo?=
 =?utf-8?B?WFEzK1ZMU1AzeTRCZjlCRSt2N1pQb2plTFFWdGM4YjhqZHZSNnRwYXBXdEM2?=
 =?utf-8?B?QUdLZjNDcHpaT1dnT292b1lva3N3ZHByWFFjMGgzVlJhVVBVdFJLL2xEWWQ1?=
 =?utf-8?B?Q1g5V0FKUHJKeVlIVUNKb2FNTk91NlYxY0p6NkE3U1JHSlNoYllBOEIvV3pE?=
 =?utf-8?B?MjRnd3ZyU09BNkNtd3RnZFhxU3JnemNzdEQrY010N2xLMXVGblpzMVgzMk9n?=
 =?utf-8?B?M09VM25YeUhkUC9kWS9mQzF0aEFVTGJQOCtHeUdnN2IvL0lwZmpJM25mSU84?=
 =?utf-8?B?N2dZNnpnVWJBekZJblBYdmxVbGxuU3NIa0JhOUo0WlFRUWJEb2E5bDhwbmto?=
 =?utf-8?B?dXYvZ0trSGNDUDJMQnVXWW5Ubzc1N29sUDhVb2l2VkxsQkFUNVNUcU1VRzhI?=
 =?utf-8?B?WncyZDR6UjJ5T3ZDSTkybHI0YUJaSys0VlJXR2pBWEUvQWplRlphM2Fld2V3?=
 =?utf-8?B?OXk1THl6S3BjZzBDY0tsYkZhZUE5cFU1VlpWT0VnQWdIQXFCZC9qTHhvaEZm?=
 =?utf-8?B?Wk5zbmFlK3h2RlJJK1Mxc0xlNW5PcHZvWDdNUGdYZG1ZVkF6TEt0c3hoZFZM?=
 =?utf-8?B?WGlnTjA1bFFBNGVReHBIRE1pbzBkNWN2dExqbzhHb2ZKTll6ajFSaUZVR0Ni?=
 =?utf-8?B?bWxlZndnV2RhRVpoWXRIVXN0dnRFTUk3bmhkb2JyUUlWOWlFMytpS0ZIU1ZP?=
 =?utf-8?B?ZmlYWlloVityWnkwR0FWdWtxTmpQN1lsS0MvZ1VKcVpJQ1F4aUhTVXdwd3Rq?=
 =?utf-8?B?cHU4ZkNScUhHaEtVNjdKZUlYemFmUTJsaE84TGgrSGxJdnd3eDRPbjJ6ZnpU?=
 =?utf-8?B?VEdtc25HaDhSWEk0UTFRMXFOK2tmckUrTU9YUUVXUUVoMHpoaWlpL25BNC9Q?=
 =?utf-8?B?MDZKNjg4a3lQbEl4SVhyeWlxZ0p1bDN1N2NhUTR5YjdxWXNxSytpQ2R1aWt1?=
 =?utf-8?Q?dZIOCnMqwsYg+Cc6aveiWdaeHVAkmcWlWkz3Vws?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f876d3-cd9e-4aac-534f-08d97f637a01
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 13:59:07.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWwNOZBwYfqgXlTTUlDV33BjHFhcUypureq7Jtql9eN5+rjGqb/Lc2o9SpErEGcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 11:04:42AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Usnic VF doesn't need lock in atomic context to create QPs, so it is safe
> to use mutex instead of spinlock. Such change fixes the following smatch
> error.
> 
> Smatch static checker warning:
> 
>    lib/kobject.c:289 kobject_set_name_vargs()
>     warn: sleeping in atomic context
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib.h       |  2 +-
>  drivers/infiniband/hw/usnic/usnic_ib_main.c  |  2 +-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 16 ++++++++--------
>  3 files changed, 10 insertions(+), 10 deletions(-)

Applied to for-rc

Thanks,
Jason
