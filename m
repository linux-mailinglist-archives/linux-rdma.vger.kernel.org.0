Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B637AF91
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhEKTvh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:51:37 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:2384
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230408AbhEKTve (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVERRdLFR1kLslDToRUmh6fiYNUcmszcxnIgKZ1zm3KpknJh/ZeOhwBs69bYsn2KdnxS3G+tG3XKHEz/WbDu42sc9VJh2N2j46uVz214mGEktfJ6szsJxg2xRsmXQUlNsksT3Mlif152kakBbRHdSBbOEtuTbWQYqUdNVBkbvIXRBWj/yTXW+ihsWoM1hQpr2bsCVpycqeNsqj2v+V5xdO+L5ajP4EUJaFzPA4VZpz/nT3hA2Y069SFayAi3Xd3NyXh0jS3xd52uHDPHmKXYlG1VXSbUM1nU0/OC9a6cm0xjQroOitOl6TrpYU3adNBZ2lZfWoamUxDspXeEOkWu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/1YE9i4gHAyhuVCSlskWDXEXxa7iOBlgdtkctjuxsA=;
 b=J+wSqJ1vLHAO2mi8qAMd/MxJcwH4eId0vimBHSoKSK6Ye9zclnofjYusTS+HI6hA6unSfAksPNUYGPF3/9l6WNoqhUNCWfxaQw2rTk0Qz9Oy4bVTohXFTJhsDifZad3XnlnlZKpy1ga6MpMWtM1jzPG68CoYlaxr7Uc9Ov+PKSFSIpcWJbxR8c0ptZfN5vu0DtZXise82mzKhJzfO8/0DPOFphMTX/pssOohXBCPzJJH5SOsdW6Ih13vKglAVBDvSGm4/i+OycXedKpOyosh36O7KM0VDeg0mVJ8MZ+oluLMtnVG+hXx3OzzJhpRtFT+R4QckxOln4C4y4j8VGcbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/1YE9i4gHAyhuVCSlskWDXEXxa7iOBlgdtkctjuxsA=;
 b=l4cU/WVCghZdExMh1eQBjZWL/XEdDDLjpewiwdLahFsIv/BKndSz3Ba3uAtAEjTltF7TOtjMLo0TZTIg3y078Z974EoU+TCtoJ9Sy3LMqyZbW8vrGNbxSYGnoZ2R8kWL9V6WlXPaL+uHzUt1LDnTg8GmzeiMKy5lxXYHsJwc7jgE8AO33VSQv982IKHjDiRr6jFDWkXrYpsYkT3BXAWa2Fs0rwv8AVLT9rKVzDJqj2L6BFFn06QlOpTII6hHQPY+KJeiDeTfVQBjtOAhpHG5LWG0lYvNddS0rzGydQwgBlhg3Dexz1Ns/bkX0fZPfvN6ybp02WbSM59lOE14y756eQ==
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 19:50:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:50:25 +0000
Date:   Tue, 11 May 2021 16:50:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] RDMA: Remove unnecessary struct declaration
Message-ID: <20210511195024.GF1316147@nvidia.com>
References: <20210510062843.15707-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510062843.15707-1-wanjiabing@vivo.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:208:178::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR19CA0007.namprd19.prod.outlook.com (2603:10b6:208:178::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Tue, 11 May 2021 19:50:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYOe-005Wf7-6Z; Tue, 11 May 2021 16:50:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24978ad1-507a-44a5-5026-08d914b6052f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-Microsoft-Antispam-PRVS: <DM6PR12MB340321523107F6D6DF56CBA2C2539@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zda8Htb7qE/iboULF2xrTcrSL7iefsMyts842pZ+vhq7KSAeDJnBmTjOYm2CwKMljqFrcOW2OLprZSE4G2tBudb9vaPw4YCAlSs/jUER1CUHoZEHLapoiq3bk4MnBoXV1+OW++bWNfTV7TM/59olujDXkrsg8V7aoVNpoDv51xpCzxSOJYq+x7GbWVBtX7yTzgxWDZJ6Af9CidlNzgi9eqHRSCZ10nOVUtOb1qA7EFMDHYrvXjltDPzy6kbt0fYRyPhK48bt6nhLyGV/WNXdqNJMYtHHrDCbFcZnUAEv+XzOTyv60TXzx8FG/bGvaGYiroVjwWmxIPvSldISFU3ni1TJHPZIa/t4uiWJ9OyEXI+xyJDsKKrSVHZnn0K1dYogDm4tLmwTnuJRuejcJ+J5fMEYCmzv5b9KS00DVFzfd7chIPDSjnZP5ReYq1PyOSXfmgpT5elHp0WTDDql4K4KzFWuXsN+nZKAgXXH+HwtuTBsGkgrHlTN+g6796D3ihlFFNNXs98lnYPlSSQGIuJXZxsI5h8OPlkYztTvyv8AbZWjfO4/TVWcRNTOa628raOkCzrWof0ckXV61iMnC1NQDE1aFQCCYsdtNPBav24ItgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(38100700002)(4326008)(6916009)(2616005)(33656002)(36756003)(9746002)(9786002)(66946007)(26005)(2906002)(8676002)(186003)(5660300002)(4744005)(83380400001)(86362001)(1076003)(478600001)(8936002)(426003)(316002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SdKPmMz/C6KKldlhYCNOCs4igs76Zj/jZBl8anwiUHZ0kC+v1MNmwTk9wiHV?=
 =?us-ascii?Q?mf+HIJv2VI6gm1HTQC+mHSr2ysoqwWoq5yYBYXDl0imzkInirY8sfDHpQw4m?=
 =?us-ascii?Q?bReIfPoNkI3E9joaPNAKemt6kYIlCk33Fi7TrJrDwmzOLZjqQ+VryUjp0bWE?=
 =?us-ascii?Q?4tiWAG0jf1iP1/ttLoIxhQrzaWYKrLeIZ6bL3IxgLCJrRaY5G1PP+wVXIOd2?=
 =?us-ascii?Q?xJ7jFTxv8pb31PQ+Brsw/hAKTWg9MZGwwb5x85KsSUlgzsMxiGec78EB/C6x?=
 =?us-ascii?Q?EYGv1ptkp00Sw+Rm8hR3I1MJN8FvJrn9R7WMoYVljGLnsVMTjeQ9fOuuuJu1?=
 =?us-ascii?Q?Qfcbhkf90EACPt7CSmrhwnNu+hd9kRowje1RABjpWt+5DPA5tjjZnSjJtuWg?=
 =?us-ascii?Q?fJk+r6guFpMlXsvz5NreEZkFzGdBIIDRYI+21edlq2uuoXSk8rLYmaKI0THY?=
 =?us-ascii?Q?TzjLy/1BgUpHvas34NoV46nooUY94nHMoJTdpLB1wfeaRlmaZewNQmaFQupS?=
 =?us-ascii?Q?sHL1FYFLymcF+IgpAE0AG/zlhciHQIJWq4rjl2bJuzYbP6BMSpBirDHSmPMj?=
 =?us-ascii?Q?AFz1cz0uux2AMNuOFatV0dP86hdgiK7yjHgacxwrhTHvbWlMAFy6jo2MR6hI?=
 =?us-ascii?Q?bKNamm+HsCc+PHYAcx/hZ+9z+RubOX3dvS/7RniaIQRttcJ3N98B94M1nx13?=
 =?us-ascii?Q?YLHfRTNqib5A9yibFTwLy2fUjQAf8Mm/7sDPi9Iz8hBL8MfQ2pw5Jr4yECS3?=
 =?us-ascii?Q?sNcQiqXrZblUtv3ZhMU7t2nmc4PmR/oNWMKX/zjt6sxV4osSwn0EwT7TkBm5?=
 =?us-ascii?Q?kbGTd6/sxQpI8lkfxa5xE8CDOkky9G9m1bjjInAR/rY3ljsBcO/TxhIbnw+c?=
 =?us-ascii?Q?Trk7WoOfwbdsuz6J1G5QyuAgzeqJ1fdM961+QRPmHiPzOlRdfUBle7QnA5aO?=
 =?us-ascii?Q?8pjpqmV70z+KRp5kAfC5l0aSGlB4OL4pkWI0C+qgwxe9KB3xZPVlUhWoIxTe?=
 =?us-ascii?Q?FpsKNP3Q9uejZJj9xHVxYAAdiwtxCRFxYzxmEtMQ5kKtTJ/ARPQZs2xqTtrL?=
 =?us-ascii?Q?NnqIhmIGHoNbADzCZRKUtsdSsztXhKnCtfcfMrrXRWNxmkZ6MG6eipcWNcfC?=
 =?us-ascii?Q?KNJdvtb0mUWBM745VpcL1mFcb9+G1atNXJSyac8lWaIJCnx1l7NXKP5FjIJB?=
 =?us-ascii?Q?C7rlJXejR9IKsMmGt0mFSa+b3j8m0Z7GwLlt0ob4MRcKbV0u8sfmJGW6bQ5L?=
 =?us-ascii?Q?5Yd1FkDna+BYTU8hxEEqxI6ykwgMsCY2++T48NKDtNgalqp8wjtWs8OwT4yE?=
 =?us-ascii?Q?xQEX3STVXHH+CzulAni3bmxW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24978ad1-507a-44a5-5026-08d914b6052f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:50:25.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qk0FdMrxYizyKwkaQ0C0fYxjl52Pbx6uaI1HdyRwiszk4lrRj5O6OY1aI3vFEp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 02:28:42PM +0800, Wan Jiabing wrote:
> The declaration of struct ib_grh is uncessary here,
> because it is defined at line 766.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/rdma/ib_verbs.h | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
