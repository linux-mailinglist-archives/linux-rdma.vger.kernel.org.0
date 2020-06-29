Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6139220D384
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 21:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgF2S7l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 14:59:41 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:55221 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbgF2S7k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jun 2020 14:59:40 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efa0b280000>; Mon, 29 Jun 2020 23:39:20 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 08:39:20 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 29 Jun 2020 08:39:20 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 15:39:11 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 29 Jun 2020 15:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmjAArFlAE8EFNu+5Z+s1xKo5WOkQLQIh3aCU50fJr4T1rcOXdDVmPd+3bbT/ZRExI/ybku3CCuUg/dzbH8kXNpzJ0tBIr9/pZF8lX65tIRdZSGqgRn+qZ4uR8BpHBlJSQP1Tspl0xGptvJK93+pdwpiPX40mSOpRnR+mCJCcxDqgAGFbCJOWo2nu9n7J8Oy9YEVuhN90aisroBadpnpGwl8XGcdrJK9tSJBsdXrnhiD/3Y18pB2Bul05PDFmwCBgGZJCg3gZB6+2/0BM9s4Qd2gBOqpt8N9Ku0qDUzRzXtYmvvvgmVEUCM5bXhrJCnAQvFuPMtjJ0/xSD5F83IUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tlqquE1vIIHzf5mofYXwUo36oMCfiFy9uz+G3970GU=;
 b=OztEksK6x1w2zMl5l5QFB2pawS8iOFKW92d2uOJe35+UUVb0DrPgY+GyLT3v56ZbdT6P0CTylJvT148FJzAm9uYOelNxT9zFwRqpKnZLKlqTHYl+EgPHrentz0i0S6k1djaswLL/oubLz0zindS2eKvAod3bQ/YFcu4YUJh9tcImpdL++3Ih2AXfhXyMskvZknK0JgQ+B2Xu9RwTeDHkuMwdqc33IY3gM0qWnrwlVuyIADxjEuBaQVkT4Arm7DR8hhFOd+DyXsEbpBEjv7cSajRLXL770WBaUMD1hpiFLIUnMsT2/Aub5u9WHYTemScBx/6C3bYdakyh/NaQLNNtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 15:39:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 15:39:09 +0000
Date:   Mon, 29 Jun 2020 12:39:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 5/5] RDMA/core: Convert RWQ table logic to
 ib_core allocation scheme
Message-ID: <20200629153907.GA269101@nvidia.com>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-6-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200624105422.1452290-6-leon@kernel.org>
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 15:39:08 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jpvsB-001849-Fa; Mon, 29 Jun 2020 12:39:07 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8bd5b6f-f723-41c8-8361-08d81c429060
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24864E35681F9A687DE604F4C26E0@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTLyGfx9ZWokQcQix5QB82fOqtEEi+/HCr9/GOaSulAQE3ii93VGNBqn12YztMXRq1nsrUPFJaMa3acslxnj1ALpb4Z+ZWSlY7zO+JlaZxQmLUTfr3x9u63xLXiBW5fa5FjIjNJFvYrzBQMNzYlX6hI+42a9zwt2eDNDuNUOVdjsGv0uSe2Mvg0nexcHDy3Pcqd3SXXiF90hAYJkSWwJk80oNxuBEZ8dLHHZ+adnqxydLqq7vlTZ2jpsQN/El/haxiBpU2b2bHrQg6Gj+BRoppdnrPMeT5fyrVqC/LGryYg2iQlimTHchl083TmsrSJPzlXJUiRMsugm08E+nFvWHw6WJOH5O7ppQ2hZXKv6dGppzJImQexGePr6UbadpLhP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(66556008)(66946007)(66476007)(33656002)(9786002)(9746002)(4744005)(1076003)(6916009)(316002)(186003)(8676002)(5660300002)(54906003)(2906002)(426003)(86362001)(36756003)(8936002)(4326008)(26005)(2616005)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ECGsOwLWDsI8vEo/cvgNVSfE8i4vcGIVfNwHX07AchwI+jPXqu4oRij62GEyRM31oK6d8RyLIelsVSS6qiHS7coccj7nOS+tQduOGQBmifd+Y1CqZF7JZIjsRwmowOin7DckULTUt819pZejoDQIIAyB+qTmtDQUJoMjOU6ZgFkLwKlpUE1XmHd61PBfRfImtfuuAGBLE5GVt8v/+I27kVryKmexzFnDIIXg95dIQTaspTBdi0xgrdJTnxOO4i8viPO8GLo18eD7abld894sXPMpZyHNHx6Yu860QBlY0Tzpob57vyqwcP1QB+Ge5Ot4cGH+pCUE3HAARZS+ef9cqcFZea7YpVW0N6uCr8ENupbYYmCy8DBVS6/XQdSYGHfs/IpLniTaU8wMcImv6VFlV6OnGgfsfyCwAQzKVVMeYU4KhpYnEtyompsvI97yxWblrWGfjXyRlESuo2zeQFtClsPUZUXEPt198IwT+M6OcEsjc/ILvTkp90PycGnBIDi9
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bd5b6f-f723-41c8-8361-08d81c429060
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 15:39:09.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/9W+GjAkVUz+wc38DvqlwVvOdAN2EE/bnqCwO/O3nU34iMD7+8PwL9D88UdcwON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593445160; bh=2tlqquE1vIIHzf5mofYXwUo36oMCfiFy9uz+G3970GU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=mDWY9Kk52jke3jp7vIaI2WxAabLCWqSt9GzTiT4n0JXrd1q8ZKP2ZlBGVNs7R8k8b
         ryUFW/F7jb/7Ga0Xwnu9sW/KTXmrCCtPEHT16G3TPbgUpco4lCNADZuIJt1ydq9oUc
         pRgPnnprLpubx2XYgBDQO5oGr9wLSs7AjAuNyliYta7rlFVnXC4nZmMO0HkzrUcZV7
         QR//lCgOifCqHNVytdcULm2qwe1B/zRv0wWl59XN705U4KAk0YHeQ4+1PSz/UOe4Pf
         7utB4HHpkJ9NWCazD6R1QSXTsEag+fzy+IV5k8UbfyX9HcK9eIqYugHNnljRuoK8IC
         BAyZXIzvAYBgA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 24, 2020 at 01:54:22PM +0300, Leon Romanovsky wrote:
> @@ -4018,8 +4028,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
>  			IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL,
>  			ib_uverbs_ex_destroy_rwq_ind_table,
>  			UAPI_DEF_WRITE_I(
> -				struct ib_uverbs_ex_destroy_rwq_ind_table),
> -			UAPI_DEF_METHOD_NEEDS_FN(destroy_rwq_ind_table))),
> +				struct ib_uverbs_ex_destroy_rwq_ind_table))),

Removing these is kind of troublesome.. This misses the one for ioctl:

        UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
                UVERBS_OBJECT_RWQ_IND_TBL,
                UAPI_DEF_OBJ_NEEDS_FN(destroy_rwq_ind_table)),

> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 65c9118a931c..4210f0842bc6 100644
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1703,7 +1703,7 @@ static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
>  					  &old_sgid_attr_alt_av);
>  		if (ret)
>  			goto out_av;
> -
> +//

??

Jason
