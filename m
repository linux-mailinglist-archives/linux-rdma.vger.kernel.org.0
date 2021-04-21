Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC6367349
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 21:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhDUTSO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 15:18:14 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:38049
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235865AbhDUTSO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 15:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf1/WJf+AwiUBSU23esVX2vJd9LasV1c0ZLXhxoYg0R4j37sisbavn46FpnjdLtidsaWBR+LRZACRrmcFCISrjrTNAMpTxVstpDqKMiXbtDMFGAcyf4a11EAkk8fpClqqLD6MZLkxVilw2Hh8ai22rUhs7TdVWtWD45hgLlnR7HeXfK9IptJtUB6eAbnIv72UxCy3P++PxxeTmIETIAAr/LClXP0Dk8o3jsi5zUZC1DQXqf7iMZ6bDVkwXhlbyp0zyLm4yPaAIX5l5t3f/mIheTfb4StloQyiwtQxalg4EKH6xbQDbRAD+Q2HFi2V1Oz/OJk0sFkG6SaHKq9J1kbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYeItd/2fboHm1nHGMFT5TuDgKeAzzY55o/MplQFMhA=;
 b=N50PO9qVc7KOadYjp24FG82mDxO8KXTK0mbg6tIGoNeCCT0spCEp8WzwGARyanNLrdk7m7VNavg853jX50n8gemAfLUg5veLCv3rGXTL3LRQOlxRIYXOUMYqzRefXfhnhL323860wuJnGZHIHsnWHw6d++uu4ni4BGi10suPSu5zaxkVtHDdjFkBkPtFhlTf9648i9xc/VZyZatSC9/xVQQbVfrOr3L4Xb/ndf9HOPA+m1+J0FYjLDtfqsKDpy444lAkomZTGQQmymc8B5Y83WI/Y1D1U/eqdNsJd93P4pnQK7Q+og+LRMGEnaMLkXmXx7+iuzmg0j2yRSjipiXRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYeItd/2fboHm1nHGMFT5TuDgKeAzzY55o/MplQFMhA=;
 b=mTDO035JzKnLTIZI/whtbpQ5/dCiTsyPqLCvWlrhHzmgZfvEbs5fyOxNuYioKR8kFDpvTX081A0zXyJh+s2gXfmNwonulS2Pg+gC7S5Ga70jLjZk7W+rqMuDDNuM8ExFHapRhSXftxVp4CyNf8q54feh2K7vrzdAEs5t7QfimOlSin5ztjDQQhpzJHeaTNLuQMzLcl+D7eITAn3sRzHzsHnUumofnKnLyTNb61Ps32ETPmkssJv8Bwn1N3y22FhBBbiGnLyW1JXE0nf+EdviubaRNNQxgSOKD4KG/ooim5D0cwsECb11hlP4soVS+0R/3zqQUvHqH7iVTckTRnEnmg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 19:17:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 19:17:39 +0000
Date:   Wed, 21 Apr 2021 16:17:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>, Frank Zago <frank.zago@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix a bug in rxe_fill_ip_info()
Message-ID: <20210421191738.GA2294545@nvidia.com>
References: <20210421035952.4892-1-rpearson@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421035952.4892-1-rpearson@hpe.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:208:32a::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0118.namprd03.prod.outlook.com (2603:10b6:208:32a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Wed, 21 Apr 2021 19:17:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZILy-009d09-3Q; Wed, 21 Apr 2021 16:17:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f9a72ed-0c76-4083-1e88-08d904fa2126
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1753251DEEFAB3F8DB1FC58BC2479@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frOAyEkJ9f3njod11K12LJDtXEdcOz1fYmth5xsVGbMxm50Dcbx5j4+lV9/KpEQL82+7vSApvY7Zq5GUO/f9U7lGvsc2t7mKkeFoOtTSL6lOSkXzN7nXUJILG+jK5GUfpBW+qK4c3QxqvEz2igeOMCARJ6osJdJcamERW9rxKNAuLMUtX9RlT98aqDRedpTSVGrsoISORVSbXl9ALFcpQWN3AFMSz2N6R5fmCO178chpgSZQg9Q86FolpDoksmIjQUy8kNj0PmGwE7ZeYmeaRKX2N69VWGiGFgqF1BjtLngHZw5LlTxeOp4fVTU7vrjpjGgkh5hYCVfOjTj3wip4lcF0FH7KOiq9aHiMNN73Ts+6vaW19NPs/zMtQSmMi4/0VXXWtti5DEouc8NizC7XpaMNivJ8XeHw8LiAc/PcskHtbGk087oH17Wtzs1HXAksuNKr6PXm6R0rOPZJhNWYkq9T8rFS6VQwK41sfPy+vtpHb/0ptfVcF6dkjFoqRZCJTHOMLaGPXF3qG0XnMUSxe9FrcZk+IJ69Lei6GbKgp86pD6VFPNHMCQN53cB4toasyPAsQ8rXqoXml941mUuvFNSFv7zA5UhewrXaTme0F6yyh1bqv3Rx9j5Dzok9ZMQf7qKmNLD3102krFzVJ/ypww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(5660300002)(4744005)(1076003)(66946007)(66476007)(54906003)(33656002)(36756003)(316002)(8936002)(186003)(9746002)(9786002)(426003)(26005)(2616005)(8676002)(2906002)(66556008)(86362001)(38100700002)(6916009)(478600001)(83380400001)(4326008)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qt8EoCLMuawQHe6VMk10E3sSnYX6HtR4O6vg2PVD24vVatse3vQAxP3YTj0y?=
 =?us-ascii?Q?h07WHuIBlifCtE/5EJg+cHolYvtWh+076BL5jOzcPeW1giN6hZURfpao5oRH?=
 =?us-ascii?Q?4sJyYVjmll5+nz/+AYXJW/QwWQrXNNfvA+WJE6VNQuOlXzmeEVGtPeQ6oEmX?=
 =?us-ascii?Q?CyI7sxEwQwUr6vNXZbSKxYPZHPRvcmGiUl7z0T+CLER3g189eP2V3TMpmbr1?=
 =?us-ascii?Q?lIJOZUoXikWZ9ix81cpANtzZzRbDCbGTiSypwF2crDMhZVYFeHwP7aH/xSUI?=
 =?us-ascii?Q?mkcduWSNsfOgKSlQ2Ls7VVMcja02jIApm+H4Zj6X4/Tl8ZbWgkWshqEeBIUf?=
 =?us-ascii?Q?70HybMd1DehQH/1YXAqvDc2ENcO6fatC9la2/7lhl9nNcok0H/Uum0dXjE5Q?=
 =?us-ascii?Q?TfgmJLF5HRqp88QbG5/srKMSxI8qZlqxbTmEaZsJWysDOXl/+28JdNJYhjN9?=
 =?us-ascii?Q?wRGPQLtQVao+MfnJlSU/lcP51xszMJMsUVMj3WXBPT5/FljRQ7dKAWmHA+XV?=
 =?us-ascii?Q?vGfjH3vaXiP8hxQ6GtZh1WKQSnRk86U20t1pZzgb9F89hJQ+JJu0lhcni0/W?=
 =?us-ascii?Q?UcX5AsiUPhaqkTdodp32N3VBUehntb7UHwOvSntUG8I3n7tgWovuBySSDqQ3?=
 =?us-ascii?Q?3w50xtAXBcJtzvTp6jJQ84cmI4VTstTLZoJOhH0FdCQvCxNBADmKp4soI1op?=
 =?us-ascii?Q?gCaUu5K4L1maA2Af0W5Drh6iHDslKkpa96cvPiNd+Kf0kxeZnngnCPOUpvRB?=
 =?us-ascii?Q?TrXg68WbuNackO6iM13pYAZnK83lg5td9J+08635vwhh+66u7ags0kEnOrjl?=
 =?us-ascii?Q?ZJMUuHdIDxtgs1G3tYobUxWSFRcOuev83IvqGqvaI+eE5ibDPlSHXn/FLjzC?=
 =?us-ascii?Q?mRKRqtoFNWBadzSf9odWw5xPD8NIjXfRyWkustigQ/kds1SfXLTehQGIyqph?=
 =?us-ascii?Q?ZveJ4BJJdMAli2uYqyARmxyxla6KBgFimEv7bIDVCVdxC8voKK0qWLFH6an+?=
 =?us-ascii?Q?xD9ZO7EhwF2Ckq+UGRSMNdXK+GU3Tfdw0L+mpBRFhQRS9nSWmp+d2kV/hQyw?=
 =?us-ascii?Q?EUpQqwWHt5Tvr4QF9St6FzzB/MwYE2U54WgMwMSjdDVSvbbuCXiWVPud1f6y?=
 =?us-ascii?Q?pTmogmySnLyPJMlopkqK+94DtqFgxmr5osATQ+LWjkF/C//kp1C7srA2WKQ7?=
 =?us-ascii?Q?RGzVi4PuSkT0iJ2xY1TISqWaAx948zeYlZcilGmgNMOSpJFYXUwBsjuzG/ky?=
 =?us-ascii?Q?A0LPrRFvwS8B2S+bK3ydArBM2nZx99+AIrQziWeak6fF6qzVaiSneQosHL2X?=
 =?us-ascii?Q?d4jh+XQL1PPxdYVDkwLxXGJVL4YLL17kdOJY9J9+7XoFZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9a72ed-0c76-4083-1e88-08d904fa2126
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 19:17:39.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4H8FwM2lcORYvnqymCs/Ok4XB3vxYDLO21Lh90FIgJCMwAMNhUDjazzmpHL5iTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 20, 2021 at 10:59:53PM -0500, Bob Pearson wrote:
> Fix a bug in rxe_fill_ip_info() which was attempting to convert from
> RDMA_NETWORK_XXX to RXE_NETWORK_XXX. .._IPV6 should have mapped to .._IPV6
> not .._IPV4.
> 
> Fixes: edebc8407b88 ("RDMA/rxe: Fix small problem in network_type patch")
> Suggested-by: Frank Zago <frank.zago@hpe.com>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_av.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
