Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA503F4ED7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhHWRAA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 13:00:00 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:21049
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhHWRAA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 13:00:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShlHXodONNg5kjMlbZxDd7/kQ7IxKhcFez+6S+9A92hq4a+2F6f4PM3dmVXl4kJskamuDVFV6XLK5EOjW+EyFcZJREg7XZXisovIgNUN1WoN//BoF3/JmVmHgm1121TSFsVm0P7DZ5N92iXQJfAkTlozUU9xk4/0MVZ+dg0M/S6NH8aKlkUHGbgmSPkmcvrW66Y59FBquKgn8nhA/56Wsm3m8fqBgWtFke1ffOdwhJlV5hWmBkdI4PcerPaih412hYKgImbG7JYW1GxZVfJU+teQKSNoa6eyyEZbPYy/iKolM65mPE+HyjEDMdMisvKgErqcag/aeqnWtx03rtp09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVBR440jdmEBYmiS6phan/decFAqljmZ9u6sgIrASVY=;
 b=CF95HspFMqWTvzfugu4BU+wq3zJLfp/t7Q/5pMbN8aqwRWVAKB1EDIa+sDcZjsx78bRHYWBC7lf2hDmvhUL7FrVTvUuAAzbCYzKO/M9e4MHTmrDDUDIV+jqeW5z19/xxz/07sSvgVDx8vl8Eg9uF7EKqsUN5/oMWnuEoJz7HyrvQpo1L0EGAzBCLb33iSWfb2Ze5pf2DsBU5kLMteKgqT4SCkBrpNtx5AirZmpvo98yKXkFvc3nUH5P9a/iRwR29OuVJewswnmA8EaTa0pQjDkKHmjiKCpaW1jnUx9lF/wdXc+PiSH6EvsutfcAehb9QTbAJOiO7Izj5kD80Mcfu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVBR440jdmEBYmiS6phan/decFAqljmZ9u6sgIrASVY=;
 b=OcMkYje03rYhs6jv9j/J4Ch9LmrxIc1MtNuy+5ADRU58xg535VrhkyApCezD1sPNzEln5yH+yxXX4bZESbx++ccQrub61yQ1h+5XO/NKiLCQctjbY5/zqqgbQi452XU7+/WkJLrtcNLAFXcSD382v63xVW2cZhfPvAUKPbvs4zUQ/w8xbW3i7v3r1avFVhCiXMv9XdpcsP26Ao4Cs5NnS/bVYtyyvKTz/MIdRbyfR2fJGsatLzaVC2tjcrLbALBrIbyv21R9RIzU/YKd4DDEnutck0y6Cp7ILCumWTAzrD3baW9oewpmIhV6ilBHaMmVh7W1fON1ryku8cN+gxZ5Rg==
Authentication-Results: cn.fujitsu.com; dkim=none (message not signed)
 header.d=none;cn.fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 23 Aug
 2021 16:59:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 16:59:15 +0000
Date:   Mon, 23 Aug 2021 13:59:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        yishaih@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Remove deprecated current_seq comments
Message-ID: <20210823165914.GC984782@nvidia.com>
References: <20210823035246.3506-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823035246.3506-1-lizhijian@cn.fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0066.namprd13.prod.outlook.com (2603:10b6:208:2b8::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.10 via Frontend Transport; Mon, 23 Aug 2021 16:59:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIDI2-0048Ik-SW; Mon, 23 Aug 2021 13:59:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adbf4bd-9035-46d6-e270-08d9665756f1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53638F2A179B55E5671BF3A2C2C49@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqsgXDbr0mBOFxxqHFDacAypCQV2u1k0YQYJ9UUbUoWl+Fwpkg+7f94uJIV29LWPXeqyAlstJFQn77gLmBTycBFWNDK/49F/+Vn7/XVD4wTEKibjR3oB+KjusVIyWRTUliIOTC5r62lBMV9Kmm6M9w2YG2RRGLPQKrFT+wC0SF3+oHRBNuESP33yKxAmDJoX8QNCpUS1TEIL/sKveNNlvOI08u3+IN8d1hkrodl86+LpjMylUO4qRFljC7KaF5oJ00VNWnKNAKATN0Dwzixy38W6bgpoRI91rHEg9Ffx1KTTw2Yfy7TLBhXmPDwxsD1Y5RGXbgIAv7eUGGxxAkefH5Pq22lFr+p7zWr/Zz68R1ybh7PSwhRpFkPLuAdU8k1YQd91KhJ6zQpJ4dbz28bz5BU8xzbhyI2IE0JlsXoudYA8beJsKn+VDo/L8ZDaWgDMfEPC812MJemCCk4w7FXaQ+8PT6f31395O0Ymx7ZccySRmzWDuDi+bMVaji0zwQ5nvY4si3P+HnYDV3FYrXV8Zz0fZi5bkBKfdEpmke9pKSsifOOLK/V4ulUNTleJ/l+Bzn/GCsRn2ZuM7qCPXLhBgcsrq46ty/ZbiCyACmdWXCdeEVMSm0fKpYvpAKyroxkcVL6b1+clAle1iHpjfOtjyLWYCDKXkoAoZjB1nNEoc3Bj4vQt6Y7JwUC5S6rd5xOy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(8936002)(316002)(9746002)(8676002)(1076003)(33656002)(36756003)(2906002)(66476007)(2616005)(66556008)(5660300002)(508600001)(4326008)(66946007)(83380400001)(38100700002)(26005)(9786002)(4744005)(186003)(426003)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZHu5QFsJ2/qmPagcZbkrsr3WSr2JgYPyxB5B+vEKk4CRkr9+NcfO9xeDxNRH?=
 =?us-ascii?Q?bNl8DUqas/bxmWWaJOovn2uSX0wYfXu4orG4KfuTWEPSBB99mNvpJMZW1q89?=
 =?us-ascii?Q?sZPOWdPIGjrE8EEksmXPhvcHtI8JBOlOvYlWrO6WFdUBVR7gba6Fft1ed86E?=
 =?us-ascii?Q?OYz/+kKKBtGOLoaD6LyR2aJ8virKgNkV86zypAVyigY5rciyAJZOad8zYAcP?=
 =?us-ascii?Q?Rixy/FCl4sxxi4tk8pkeWNHWJIzpjcVS5VkgqqZuZxjejF6G3m5UlDIX27EK?=
 =?us-ascii?Q?9SoU3u1i91BKFrQfRWirRmaUtDuGH0JYhQhIpgskK506OytN47mKb9CPiN7U?=
 =?us-ascii?Q?vnQl8/WV2HDM916MjAnCtn0Bvo/sPRs7EC1Pvt2q99qqppK3dIX9SxH5kJZ7?=
 =?us-ascii?Q?hncxbiuE+j/llM5nZgyLZpZyKFH9094C6xs3k0Azjrx0MDGi+0kigaBMhOKX?=
 =?us-ascii?Q?N9MyQkYl99ERAwKlEBe906bWUW8yFmCkI37pA88niIlt8iorUntFdW3+kcG0?=
 =?us-ascii?Q?jdx1kUT3Qs0/vSzR98UcK4VCO7biXYKwuhqDGXs+kewdopz5TxEZrkG9bMgS?=
 =?us-ascii?Q?bL96/03rWzdk1K0u3+AZX4/zpq7lXw3B5JoxoLhcti1PN7K02bxn//tMbmO6?=
 =?us-ascii?Q?8BGes859Ht9UxNqhoOdwgnZZ5jh/rPC7Hrl2Lo4VHty3vDs8JyyuIlbVFxtV?=
 =?us-ascii?Q?P0ZD0KOnDw8RdLr2x0Dh1WvXzhCn0ZsoOrS9J5S6rTuspu6/oJxk5bdY6yFf?=
 =?us-ascii?Q?5Kyj1tkSi/2kH5Nqn7kyEagPJ/kKfbl8toRuXsr5efqB8v8aWcZFIRPJEIO5?=
 =?us-ascii?Q?e4qSe2X5RtzfGzfoj7WnfuMcz7Mbbhrv25ziwBsDYcbf08pRAwPP2SfM2oaq?=
 =?us-ascii?Q?J3lEbIhAUf2zbkkfUubpqe7JEYtuN7TDZUY6EGJeETVbIi2ZQpF9ZDLQGkL+?=
 =?us-ascii?Q?vri8qorKgM0bfFBsx1G26M6YWXIGscFwqnJQgXg5CEvmXekfNKvhvO6blIwW?=
 =?us-ascii?Q?Ev0ocoFnuW//bxqmAsMQ28kcGHtgp5HfLH5jK3dJyIeVQcwg14VAZ1fhZFSh?=
 =?us-ascii?Q?QB8klOikZHPYpxFnwfHszSoXCt2QkKXfVGeviz92qjxcaz4b/tOPSwcti5pX?=
 =?us-ascii?Q?HOJCDKQv3bkYhAHh5pHAGksSef+OEJejxxV9R+q6QntaGIuykYBp9sNmB+br?=
 =?us-ascii?Q?BJvAgyWljBNX0zN0xQeDiT+dWpr5YNkmf3GmCN4CRpgAek3IbY7UfcP+DxOA?=
 =?us-ascii?Q?A8d5uj4bDRhiKodxLg58Q308wForTbPdFE6hH29t6NSwN56YbuVawMW+qsfb?=
 =?us-ascii?Q?2K5j4OXas4pWWqs3Lzpb5G8+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adbf4bd-9035-46d6-e270-08d9665756f1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 16:59:15.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i53ew1O6yHVh+83IDWNOrTZxyhv/H2mSKGrkuAnkqcHE1TjuDAC+XmVcHv51qNye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 11:52:46AM +0800, Li Zhijian wrote:
> current_seq was removed since 36f30e486d ("IB/core: Improve ODP to use hmm_range_fault()")
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-next, thanks

Jason
