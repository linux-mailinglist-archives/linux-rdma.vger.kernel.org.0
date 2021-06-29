Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3E3B7A91
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 01:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhF2XIn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 19:08:43 -0400
Received: from mail-bn1nam07on2086.outbound.protection.outlook.com ([40.107.212.86]:26436
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231952AbhF2XIm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 19:08:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJN6+xqn922qBKO4fhzbAaLgV+wT2U+OiaWuL1b+CkbFC/u370+M2FnUbnEgV86FXH3H1bHhtnpCuyBRzGQBTSZwj0GX6Lyw7zGWRjkvagTWMiXot6wL3sncGcMrInTcPzsXyAsFKODBwByPzsPTaRoQIZXWIIyf0OG00cXzwR7zlYXy3pgIx4qKwbQaTK2YM3Ttm6L7NaVaHh1JgpUdCsF1NWu4nY8NxnxaA+MmbA50qiptmK5G4KWa0hPU4N4tXK+dKSbSVsYIc8gzERCqvpX1rKCMILgNT7VpoJrkDk7ng5kxjOtksDR0AdK9AKn8m5f6IoH7nmbyfwITI6Q17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quzThdpSv08KSJxQ8KCvou6GZCPL3dHl3oYbzT3Gnec=;
 b=KGNYJq0/Q9fzREtcH5gsRcnBSaHOqty/4S09hhFtCX50TsdmNOvbZw2tvvb51a4x7Nj/1/aOeMHLQB7NxLEDYehiZXQQldpEmW0XBB1WfNRAIONRrfk7pXpgtU8lQQIRjb1I0aJGjWXTwiftIMjeNMCeMD9hIO0zMl/6OQ9dZ7+iev3LmkzJUlmRbxs1Fdgi+JxFbZCOFvUNU0YHGp2Jdi24uvFrw0M24JAY+llajxJBJMOt3ID1FniDhN7DqjCJd6hToFgnH+3oMANIZ7GCRUMrhbkYWRNI9dhsN4AWvnBnLscvP2gzJBtcE8FOLt02QrhdbuIB/pACcrOY3LOgsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quzThdpSv08KSJxQ8KCvou6GZCPL3dHl3oYbzT3Gnec=;
 b=J0eVoctUfJtI9dCRrunIDsogRdAK1YHCjfeRzlz9yflUWwvEd+l8uCg1/NsClWx7NUpxTIKLpV4gbDhbi7zPJIyIVb+modluBCnr+4kokqDzu9zsQum/L7ju/CC9wX3CWc7vC+WAJtEuTorO8HkXU+lESsao0QKcQMLdXrd9RWk6kiETDVyE1GL0iJTNtgIgy89awGyFYf7q7WVQlMUrwCdm86mQ3KtL3c441zWi9Jp0Lsj5uiUtXMp7Meb8wMmGitzd+Vr1uMUKGT3TeC0zpbIiVtKb1CXxVSEQy3BpPx93DsFBHtVf35yuxEsNnZS5SblqiI3N9AXxxapxHqGMPQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 23:06:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.027; Tue, 29 Jun 2021
 23:06:12 +0000
Date:   Tue, 29 Jun 2021 20:06:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc v3] RDMA/core: Always release restrack object
Message-ID: <20210629230611.GA278274@nvidia.com>
References: <073ec27acb943ca8b6961663c47c5abe78a5c8cc.1624948948.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <073ec27acb943ca8b6961663c47c5abe78a5c8cc.1624948948.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Tue, 29 Jun 2021 23:06:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lyMnz-001AOo-Al; Tue, 29 Jun 2021 20:06:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8bbdb54-62a3-44b2-e134-08d93b527d0f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5208641BD100A293A539B96CC2029@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TH5SkfWyxfhc6Rk3DW6a9NMMAjHU/cEaTqo9yu8Smr23tEmZUZDIp/H+/EnnkigE5cIUroohBYOPJEcZC9uovA7gUYqWnVkmpLqxJ9ZzDBuzZyjCW21z23N5kSZnhevEWlg//EqcGrnPrSNF95jvNgqDsN3A6Z/bpyNOXSv2SEF0xv71kcRYcxrEw58vbXQDogtIw88CGjzfRwHieInLz0uJ9PNjIRS2aCozEli1/tWweTgvGKxvuwinous60TuS7XMxmHhBtG+rsiJdg1gASMYxxiKSANdvbyxQiQ8RxWlALJA0Tnc+DWPPY4+1NfD6rQ4g1Oo9niV2V/+kofwsZTsCpaU4p4/de4Aq6UyeAb75ANx9METf4cMXavIU9JpauXpa6wuzHbSZQyKtPHjV6sdH3wvMZVT/rEkos3oVE9HMFUsHJeeuI/ePu2Ss/Kxs8SJK2CphZ88pZ8nQ5y8oNCBvFUehO6irbveXikjZ3Zy0NbqMXRlQhR6artCXdFF7iA/9DAohkFb9DNCbK24/vVlmzw7racwcGh8WiX/orTToMcULpV/m51QU+iOw7S6+jJEV5HcNHhN0Nv+Dhfwg19RuLwJsm6Qo3QwQA+ZxN4djMjifPX2eNVqAQS7A4ETXRzMehvykXgJaVFY8Zce3HQjfDwDFjJoznzOBEakIWRjlbwwijC6ZlckEjqnQ2C8qu+FNf/E0Ecu8QO4TIdg7JtSySuN9a49AhAI0zBr/HZj+sD+45fJEZbkQFyuiM/8PhgX7uYinKkRb7sCtPka268xKKTMVzIrMc2bNQEvSqLKV5lYGwIopoNWlFIc+57/KmaVKaPc6No+ypRS5DPFW2iSpKeV3E0aLdOeSCrsRQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(36756003)(2616005)(1076003)(38100700002)(316002)(426003)(86362001)(9746002)(9786002)(8676002)(26005)(6916009)(83380400001)(5660300002)(107886003)(4326008)(186003)(966005)(66476007)(66556008)(66946007)(2906002)(8936002)(478600001)(54906003)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1rIKUpnf91OdliumwGzUhO8O1P/kqSerDNThocpgtxTVM3nv2n4vkb+y2mU?=
 =?us-ascii?Q?UT0vhu3VWpT3SCuvj/vnuac5+h6LnNxgf66NZ9ncLnTwfRwvSrVTTMXYfqxd?=
 =?us-ascii?Q?d06S/5s4WkTuCtqRoqlotKsPAik5fpjgaG7ssX+UDQ5O90xHLWkL4F+QSRjs?=
 =?us-ascii?Q?wKdSIJJDHEQfA0/4BThbsLt5Wt0Jl6qk7LibC2LzyKpcP6VRV0b6S9JNC7mQ?=
 =?us-ascii?Q?HUwDooSQOFj0vZwFK3JEp8pzpUUXmKolOHnw5oc9bkIA+hvVJ6JsHLY4Q2DZ?=
 =?us-ascii?Q?vOT/LZoibIu7kfK2BsVgeJ5qRST/fKz2YL6oBNqr8eZyYiXQJQNOR6O7DIJ0?=
 =?us-ascii?Q?eCPYjEamphqkjAWgMDRIURq9wonfRjcfjy97GwaYYUmZYE+e+4gSuQ0BZm0Y?=
 =?us-ascii?Q?Z6vq3+srd6jlaZR3mf8ZkR+KRyw16v4jnrPLMIjpklMjMjz0erRngU53GikR?=
 =?us-ascii?Q?n+zMLqlGVfLJ+4gakVHHDqmh2M2S8eEfB8Y8pD1LV/GL2OnZPG5yP5kMOKkI?=
 =?us-ascii?Q?Kv3AfP972Nfr+c3r7PqTyA7mDIv+w8G++Tf//jIhaHqGFuHszYvYwVMUZopt?=
 =?us-ascii?Q?hqhSPJKC2TL43uxqF3oK2ZQqTefk4+3IgF+fpolx8Xpqhy1wqHXAuqjHtPpd?=
 =?us-ascii?Q?Y/14wzz0AbG6TT1OCTxzPtFx+rbnWweQ10snXE83gX/Hn1OOoDPv206i8ztV?=
 =?us-ascii?Q?mJcsEkz+HJUq3tkq6YLgtJ1qChjdnHa3QguBPsNxvbcHI/gX0KL1DLAtS2yg?=
 =?us-ascii?Q?npoPgGUn4kc17T75h7++TeeX2N2ibCE4qs26hUAGom4SfCuM8B02Pm5ZrIOX?=
 =?us-ascii?Q?bylIuzvYmOVe3sIGeq76WQd3ptqqyURFRqgMuOMmReQ1fIvE+0EAOq9hkgys?=
 =?us-ascii?Q?jLk9drYLtKgSdlkhsv85uBDbVzFBAiJzNARypaS7gFk9rDYt9vL9bopSk2+M?=
 =?us-ascii?Q?gRG9tZv5hXBozQQGMhJ25ieDwr6SzaUzVTUEo1VAliOzgKsJ3usgRSKjG/jM?=
 =?us-ascii?Q?k1xaQ/sm7JU+E/tH6/xCqsTiGqQIx5mbjglZMFhhb33YOM8NTGKlgD2Q2oHg?=
 =?us-ascii?Q?TDEODBUajCUo9LA9qfOIHj1Acqass+8P2uebmCv1IrO5tS17J9z50fcW6l9J?=
 =?us-ascii?Q?CiylygoNaFYEE7M77wWLGIDMlfXUFIrFmUesDHDDyJv5lFSqJrfZoAOF31hS?=
 =?us-ascii?Q?4tMWhwFlI3A/opP3uKPbk4COcGhMjPaNOF4In2tzMmbSlvEeX/LWD2etFSUQ?=
 =?us-ascii?Q?Fn5wmwN6NV7E9XFIzefM6GGUUDrruiKlS+zCFGzBXufOWnYkbKs6OMKAShuG?=
 =?us-ascii?Q?ONGgWSbcsv1vEhA2H4LQV1xa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bbdb54-62a3-44b2-e134-08d93b527d0f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 23:06:12.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: habQdsbTmB6whXm/hd9JMyyof1bHITdUBPFo2WTZ8hf1S/PiYHnEEd2Z1k4LltnF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 29, 2021 at 09:49:33AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Change location of rdma_restrack_del() to fix the bug where
> task_struct was acquired but not released, causing to resource leak.
> 
>   ucma_create_id() {
>     ucma_alloc_ctx();
>     rdma_create_user_id() {
>       rdma_restrack_new();
>       rdma_restrack_set_name() {
>         rdma_restrack_attach_task.part.0(); <--- task_struct was gotten
>       }
>     }
>     ucma_destroy_private_ctx() {
>       ucma_put_ctx();
>       rdma_destroy_id() {
>         _destroy_id()                       <--- id_priv was freed
>       }
>     }
>   }
> 
> Fixes: 889d916b6f8a ("RDMA/core: Don't access cm_id after its destruction")
> Reported-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> ---
> Changelog:
> v3:
>  * Dropped controversial hunks and updated commit message respectively
> v2: https://lore.kernel.org/lkml/e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com
>  * Added bug report analysis
> v1: https://lore.kernel.org/linux-rdma/f72e27d5c82cd9beec7670141afa62786836c569.1622956637.git.leonro@nvidia.com/T/#u
> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
