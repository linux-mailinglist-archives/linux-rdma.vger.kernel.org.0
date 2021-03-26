Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63734A7FB
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 14:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCZNUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 09:20:40 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:5216
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230043AbhCZNUR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 09:20:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obWG9P7kmQZDEqRMyROhN/emadrJ1mEAaWTQsgUoXMwGsaNIgW8Nhz/n2Z12Zy02StSggt1rwAQmvz4mSj7yN9IT+TkKGnQYt/37JWXrbtvZf/SfjxWjRjhNGduYHSdnmA+cPrhQyXOgE8IXXUfrueah5YAR1J9Z2k3yJuofZYdggpogPkUOOeWaBne6UgPKuf541T4Yg6kzBAylirSseV4rfnV1UOdAs6B8b3Dy272LvwmAjnjpiKoErt1QJFQ80a1ENduKE9QGSbLdM0ChGBwKL8LGMzGjFkcwlZpCbh23MjgDCurHvR0lKZo8Xzx+MAFCfTYIJVTPJ/wLejetHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tW/2SaTSVxN+TXXKI0J0hfn0nS3Q9y2KdYOcuuSKsU=;
 b=FDO8aEiyxwiQbeqfjRH1GHxhVQwWN0mPH8ssMuW3xGctu1ZC2TaR2zzCTq2cpublWz2VPZ1IUjhhCWZXTYXl9n8oToeBCXJYVXPg2ZUzyb4L3l1t3p0ziyuLokRUvh5u0L1QOYROAoa4T55IvKSvCsWFi1y4cLevfUOXTEOCVAQwW2GzlmxOU+tatfKcsBnntJ1+CTqPlYZxzgkzO1NeE31Wpu7XMHy2CIuY7GkF2FVKtMQ+yvF8rTr/GkF/YEJVfplJb1uhQ46WFYibVsXUiwxYY4I/4JWhWjE6Q4CCcj3T5sQOlPxJ8XS+wZCFN++PwQycJHz/wdO6xCJKYM6K7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tW/2SaTSVxN+TXXKI0J0hfn0nS3Q9y2KdYOcuuSKsU=;
 b=TiK1eWhyNRc2h+46S029l2mmkYfdu5GdjzuI71TEqtokt2sze3mjC77LukT2NKnou5IPl2uQvjG1oa4YjQ1JELlPmFn5EcecW8uaU/WXX1FoZ29kU5n86rwa5XlQWz/mLhwchI9gOu0hpHMGPF+ONCH1afZgOB3o3rD26cevzTiLhiTT6teXOSiIN6lcn+Nn6BQi1hetuoH4ptZQQTuONOz4ek9uwU+jOmI1mqoI22/gAKBzd9MufDTdruqzEjq/NRYOqM6LVOAra5+umTPtgLMgLhJg0aoJJgE4Q4LveK/CalI6JHCASHYwix4Hjng6Rojo5qA4zAvbcNhWSmoNNw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 13:20:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 13:20:11 +0000
Date:   Fri, 26 Mar 2021 10:20:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next] RDMA/hns: Support to query firmware version
Message-ID: <20210326132010.GC832996@nvidia.com>
References: <1615882161-53827-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615882161-53827-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:32b::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:32b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend Transport; Fri, 26 Mar 2021 13:20:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPmNm-003Up7-87; Fri, 26 Mar 2021 10:20:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1381e5a-aa7a-450e-b26d-08d8f059e252
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35145C7929C3D3F28DF9ABD6C2619@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAnZ5UtJ8aVeODVIcI9iMVjpIG7CAde9uAV081km+c4EnQmmJ2ekvLo1Djs4tYz19uFsdGAUMUOsWXZ5bSzkyq+jUYRz9EE7ZiJggSeZed7rcbKhQxLvI08oSD0dBxDYcoQz82RM2BrYMftxtyN4TorlHxo9KBZo6mk1mIsQSrFPg7fXB8qVks2r+iVyEbWePxsedKLEumeZfYH2mLpZed/DlTli+t+iyHSW0HVOjt0F0oRqeQPVK8N6ZjV1K4LZjgJ3wqA94yh9Ek3LWOfbYRIUvgJAda2vVTSKga1d4PW/wpxWDYbrf4lQ2ND4EhScMWSNdAFgqRAdMFGJJ7+aIMbeB6mcI1VOnsuNGmhyRsAHBCKg7SXHk5D0UTHMzu2Kq1rMEBP6iMtaN6NFh3eu6g+ldk4xZLdi/nb7lnK0H6Y9ETQaUMtvFYpYEd42xHzA9TVW4qIfV0vvt1G8F+iYA2n0VCZyGqjyPwqteE5bV/Y605QRbl2wtjbtgvoX3vEUSgappsl1GKRVDICSM5dK8S4ZDD8+9g7qh6pByth/d80jkh67ekarK/F/5/xqjH9PSx86WOsoeNkEFIZgg/kw8ifik/s2ybwKLjrmtfNhANQM2cYLu23ecepv0/NvI5GvQvdSzl3pqEsK4KZYOgaLklujXr1dUDG8QcHD0DJC7R+qx5BQSLeMr3KLH/Ua7UBk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(86362001)(6916009)(316002)(5660300002)(1076003)(4744005)(33656002)(4326008)(66476007)(2906002)(36756003)(2616005)(66556008)(8936002)(426003)(478600001)(26005)(186003)(9786002)(9746002)(38100700001)(8676002)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z/TUUqfU2zDHtMcNv+33IMnhp0fB21dDKdQnW+wktsJiPcWuZG9HXh1oTxP4?=
 =?us-ascii?Q?SRLiU/qgqe7kjPKNPkrk6ciHumd6Ekj9f85kS0W68HQR+z/ZWoPW5IhIqRwi?=
 =?us-ascii?Q?0Vsf1zy3t9q2eVpLcntVFBhOMfpXu0JbNw8Lr8CRI4kPkRZVfPiNhgD+PLRX?=
 =?us-ascii?Q?S00/42iOPmPmpY80+Z8RfWAMn5crh2i6LSXhnijYKNDSuxtqiV4RW5RpNp2I?=
 =?us-ascii?Q?4nyN2RpNZq5Pc1TDpdhjlzTKjhdHy9F+lIa67nIIS29Rq1kz0+xu7FI5KL9Q?=
 =?us-ascii?Q?ftEz6n/pUYSKwCAGgiBS6ukkwg/O8kpCUpsFxb2JOogwKG+i5rlussR3Ir93?=
 =?us-ascii?Q?rO42oh1ke4jNGv4T6C5rdsnoZUOwSPmGR5PycP/K3xK5EgoopEWfEbkKBTNl?=
 =?us-ascii?Q?hX6T66NyZ8yFqqJxDVcyc+yshD/PMppec+gnprqjf7jsW4MjI6Hm4RVCkJ2x?=
 =?us-ascii?Q?z4A8aYeGP5YO6izCWzIvVYLLAhpfurbl8QmU2TMb3iITWF5VAARnGRc9M5DP?=
 =?us-ascii?Q?cF0XCWSemt/1WDhDN1OkaeQb/Ttx8QQn4EMfe4zDIRRblAFaglFbk6JIAoI9?=
 =?us-ascii?Q?Ijdfwxt0/gmjJWv/kicL3FOyNQZkovM3gOwPiZT9E4I3IIjtS7XP1Y2pCfV3?=
 =?us-ascii?Q?kJ331+bsOqOpHhpbwezImvvcGgdy6Tj2rw4TVm2OOQvY+lgvV9oKsBlU9cXE?=
 =?us-ascii?Q?OhwkFdBpSKEprhAo+OW76vU66yiWu+909shw1+gSkxxeQNpGGWttfqp6XJef?=
 =?us-ascii?Q?jwb9c5VbxHC+bLuIKTCo28UyWN/eRoHv7g6bxS8SmTWAhRMOT/YPj8D3/GzK?=
 =?us-ascii?Q?z7Bxl55QYgG7K3h34j2JAJ33n4rOiF7JWycsXVb6DLHx2mkoIkG9riSHiRXT?=
 =?us-ascii?Q?oqGo66SmblRh+tkZncEUzM++B1Gcncwh2BvCS3nL7olhcCBJQSSXRVevDXqS?=
 =?us-ascii?Q?p17k67owaqVM5VlRW2aSH0YMRWS2OrgLfSbXOdr9iJDO0sVSfNKhZj49cndp?=
 =?us-ascii?Q?ubog/Njo26P4sly/lsRC0C3XEn8ME4pLVk3xXyi9WZxGNYr3KrNlzXkbLK7J?=
 =?us-ascii?Q?nn8fNFCFO6r8OQyiO85oYLGf8IV7QuS7bS8f3oSwpye2kqwE5Seeq99xRZTk?=
 =?us-ascii?Q?uEoY6g0okl7X6D95wxktmGzzKNgndToGdbqWN+QqTeQD/NPOcwZ7g2O3hayt?=
 =?us-ascii?Q?QwBofPoH1hJhcauTrKeJ2CApiC/OiyBKOecfqk4pYCgXt6Qjk75i+Xw/UXEC?=
 =?us-ascii?Q?SuXhfPktfX/9t8UMpfAQ9nWrnKHnLa3EyZEnU1XWiuc/zeNxHbBY3UEwuZip?=
 =?us-ascii?Q?XhVuTcZ4A4/e9ZxxVCsrzpYbMp2wryfkCPBTCTuDMSZEXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1381e5a-aa7a-450e-b26d-08d8f059e252
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 13:20:11.5249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cltwEOtrMmXVb6uRVELuJBpqGuRJR7WjDWcNg5+/YYHAnFysAOHR/V8vHQwNPQnF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 16, 2021 at 04:09:21PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Implement the ops named get_dev_fw_str to support ib_get_device_fw_str().
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied to for-next, thanks

Jason
