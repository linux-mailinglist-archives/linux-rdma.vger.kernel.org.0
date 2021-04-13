Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B12135E98C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 01:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348744AbhDMXMA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 19:12:00 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:9601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348740AbhDMXL7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 19:11:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTwH7nO9LrzU4xXsuVX1FT3E8jTWoTUcUopLv3gWeYfmol4DXEj/8yGus4tqxAFAZfsUZv4dCigddYQxwMv9wNN4IN50Zf5UUs4kAU1dy8G1OM0H7pp65zpByCIcnTqyu1PPvdcsZ9AySwFb5r0PiDzWq3HuppPFGZRaqnsWXe97SNuUaJT9Ii35sI7zlDba9LHwzwDzU9p1MNFkWDgtztOTnxBtl34FJ8lleU2QC8uCvhMW+WAZJk48gUN2IvGfNL8wv3QZQdQt8LPfGOnGOmk1BQ8FqwpvrefdknGv8kynVGLescdT5rgs7/Y0EJIdyx1TWGzgq0qfY557cLcDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxMliU8uyUb8MNjaIenGmAiokLzKzpW2ociGbHGVAhM=;
 b=iOfIlaHQ3e9r658n+OXxVcYIZgtf2iMeNVfreHKc6SUXoS2u4/0/jS/U4HGUV1fTImC5k357QfkkDl1DH8EQNFRpSg3LE8WXFZkHPLqYDtPtbQProahO61PvOp4mtbK8NsbJTTxYFsBj918gN0xR5SHjuqAOwDtBXJQMlfgIgInJT5jctynYGmNCYpIEBICp0oe4sBC3tcii7nXFcJgdm6YBrLPzvzDtpvZ7ZJukJsmUHF5SjtVIbYosd/Pg27eKG0NQZTcrl1CE9rNIydp5hQ+RqY2o7scMJrugiatS74SDAeRXEWfmOe4yQDgCNGs4ff6LSpaVDhrh/MpZbbO7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxMliU8uyUb8MNjaIenGmAiokLzKzpW2ociGbHGVAhM=;
 b=FeERM2L4kM/CNJLaSr9ixJZWry9bfoniO2ELS7TdD8VclX+a7hY9bHgnsO06sZDjYUNJxMEAvXHucIxEX/xmmrm+DGXgnOu4PdbaWNcipTF+sG1RqAtF1xvfUpbenuE3tUR9cMl1ZuLrxw/wRM1Rews8XvNZpcNnb1ZNTelmgGSi6X89JCUmd2GoD+LfO6pimzALfhwtzYORL1a2nefoHMLmKNnQQKUs+ksWAYjrFhY24Z4tw4EWXm+fbw0bk2D36IiN7kGrV09Q0EISZcwr+YxGgS/K2HBFY456pnURT185his9oOD4cTkJ9SmfkWx8YtIArc2r4LHYN0EAJpqt0Q==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 23:11:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 23:11:38 +0000
Date:   Tue, 13 Apr 2021 20:11:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next 1/9] RDMA/rxe: Add bind MW fields to rxe_send_wr
Message-ID: <20210413231136.GA1385646@nvidia.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
 <20210408214040.2956-2-rpearson@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408214040.2956-2-rpearson@hpe.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:208:e8::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0016.namprd20.prod.outlook.com (2603:10b6:208:e8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 23:11:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWSC0-005oWc-Td; Tue, 13 Apr 2021 20:11:36 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d69469ff-70d5-4730-a52a-08d8fed17d6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:
X-Microsoft-Antispam-PRVS: <DM6PR12MB285967E9B8B3186278D90B57C24F9@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpBVjhLZO8qBT3qa6gL974Q7kDBiyN6ixNwuQponbFiOxRlvf7SyUu9hj5JB9Qr1Qb+dk4ChgPSTBuwE5tSiynAH6QZCkZOI75oOCaSXNYCdmalAQGOgxWNDPxNeqP2erLazCKiJCMMwe1q67dOMi9zWKTO8yqG6maDNNRc6SzYBpDyQAWpzHwYR6UCo11W7wMjh5jP4Cnkd8l6xBb+ETW5ecoud4GsrDrufWXccehJQ3xqJjT+/TalebB33jxewit5zytU53PT9VdOibv0Ij19/WDFCvkN8K1sq7JNZIjYOnnNS2Rgtk/A2uVKAd1Ku8wmaeyuhToGtWeobRiNH8sXiV3EVvzWccof+X4m1nS4YEy/BRf0PmB39jvpisKQKq/VXaCZteQWT2emLypj8xJvhiP8Safp+/HM7ImMDSrS8SkHfj/BKfTLM9GYRMlaRQnlYYnjp2our2rl/zElT4UwerLXX7GdWUzkkw0agIJN5GkYWYqfKsgu11ACPN6x2Dd2/s/L0eixsE/IYU/akIVRhuybsv95/ekO++kwurETPPFRqUD4Vlho5XWcHdz0PFOCMESudPuci8+w1gIuDFQweief4A8jtGXWwbAoP4Kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(33656002)(6916009)(316002)(36756003)(8676002)(83380400001)(38100700002)(26005)(2616005)(186003)(8936002)(9746002)(2906002)(426003)(86362001)(1076003)(4326008)(9786002)(5660300002)(478600001)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y7xO/+6ySMiZar6doyneO/g5qcjOxmOJ/A2oBLa5cIzS5hrimuGF0saDQaco?=
 =?us-ascii?Q?1ksFLXk4PKCEDNHAL6DaofGANq4ADMPR+einws8askQ75gL3GVblz9oMDMiJ?=
 =?us-ascii?Q?yw/pfZwuIRLjsveITKgtYrf6efuaOPEh9Hg5UcJv6kOd+6qocb8EyTYHi92x?=
 =?us-ascii?Q?8OdX3yKD3QTcsJqPgu5WMKBi3EoVNjPLGLnaSHxUlWebof1KHpa1mBvP61+x?=
 =?us-ascii?Q?QWRADukrs8gf7V3pDWsSM7Tu3UwDnZUxhjPCbwVmF+xyY0FhpdhYxPC66NdP?=
 =?us-ascii?Q?iPZ54QrxRTkav7MLABfAN0t+bGC/wRLXD/iclgwd6JUbC5DYsEu/LDv2gI7r?=
 =?us-ascii?Q?wiczgHVzHvmz8lrRxDeL40XG8RuNY5MbmAIDMyg/NILdyzrBSwjuxR/4K69N?=
 =?us-ascii?Q?+8nxG2UVCsjltC73i7PFghxNkyv3QLhwU12/JO7SPWgni6sUdbXqktzuVKMP?=
 =?us-ascii?Q?Wja8LuGbdPz1wPVKoLHDSZv4TY5JHNhHl+fRz0mFgt9/79vOMswvDBNwIdaf?=
 =?us-ascii?Q?Bc7iWoYTuu/zFV8cBxBe6vg+BYYpEhYw0NJRX1vsq4qYWw5WTkijjsKqy8O+?=
 =?us-ascii?Q?0iOpz5DRpRkkzgIb2r6AHQz9rO/NDY0x95NOkBpda3n6KfJ/qbNLnrm2Hrb9?=
 =?us-ascii?Q?YURZHeQPH1efvwvjkXchiKq7mkZzG8n148OEXBPeOBeV1oyIgxyoE91C91zJ?=
 =?us-ascii?Q?X+pt15/ix07Tq++f2kiu37H1zSOIt/dpWG67dLpBcicLs7y4rfNMUO6Q/q8t?=
 =?us-ascii?Q?HqIU3qHjAfgY6V2+KjY8E/PYEPAK9VIypkefyOlg+ZjLh3vzHY7GYhiAewGf?=
 =?us-ascii?Q?43Q87a4lTTZxGCs/DwaGnJ+d9Sbcej3M1hjtJJ0F65aVj2ZCdrSA0gO82DNs?=
 =?us-ascii?Q?PmvJLY1DlUICy5+Eb+u0K42+V4edI0WjxiYya8FOOAb3ZZHOaQMdnSB3r6y4?=
 =?us-ascii?Q?uLEUfByasYtXgpqaMu1yvUWiL4TJ9J+2p1OFUsKaNL2aoP5ufziEt9AXqLRt?=
 =?us-ascii?Q?0nPncCbXoxjzHIxoPYgWZBacziPU981FuQFH94iTGNVWBY5P9hrSZJyXV6di?=
 =?us-ascii?Q?W+H4q2t1lOtLZkHZ2Z5/dWDUFsiI5BOBLiENLPy52pHktDnBUQEnV8zVT7HU?=
 =?us-ascii?Q?f+oBvoPZoO1gqfvodHkDEzF0BYooHl7o86x/3rvHxWQo2w7wbWsZzyBDsFOi?=
 =?us-ascii?Q?k/YOHWVvKFD1ULNdAcCQLR7n9cwm7O6wJr/3n8P/XgKhOgGbY98z+7cbsQPK?=
 =?us-ascii?Q?HlBFxP4SgV6mDyh/escN+f52ugu5IWFzyth1TEl1SyL01u5LpqGgLZrJHWaf?=
 =?us-ascii?Q?Y2qzG/p6+GFjAO19I5PGuKVMvh0uztVqieCSwLIg5grftg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69469ff-70d5-4730-a52a-08d8fed17d6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 23:11:38.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjVI7hlg7lCOmCAYAFXM4x8cLmFvSei2zjAhCC3gYHTNztpnE5BZxjTzrEt8ZqYc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 04:40:33PM -0500, Bob Pearson wrote:
> Add fields to struct rxe_send_wr in rdma_user_rxe.h to
> support bind MW work requests from user space and kernel.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  include/uapi/rdma/rdma_user_rxe.h | 34 ++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> index 068433e2229d..b9c80ca73473 100644
> +++ b/include/uapi/rdma/rdma_user_rxe.h
> @@ -99,7 +99,39 @@ struct rxe_send_wr {
>  			__u32	remote_qkey;
>  			__u16	pkey_index;
>  		} ud;
> -		/* reg is only used by the kernel and is not part of the uapi */
> +		struct {
> +			__aligned_u64	addr;
> +			__aligned_u64	length;
> +			union {
> +				__u32		mr_lkey;
> +				__aligned_u64	reserved1;
> +			};
> +			union {
> +				__u32		mw_rkey;
> +				__aligned_u64	reserved2;
> +			};
> +			__u32	rkey;
> +			__u32	access;
> +			__u32	flags;
> +		} umw;
> +		/* The following are only used by the kernel
> +		 * and are not part of the uapi
> +		 */
> +		struct {
> +			__aligned_u64	addr;
> +			__aligned_u64	length;
> +			union {
> +				struct ib_mr	*mr;

A kernel struct should not appear in a uapi header, nor should secure
kernel data ever be stored in user memory.

I'm completely lost at how all this thinks it is working, we don't
even have kernel verbs support for memory windows??

Jason
