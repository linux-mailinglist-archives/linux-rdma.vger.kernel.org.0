Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC473F7BBD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 19:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbhHYRvQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 13:51:16 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:61306
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242398AbhHYRvL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 13:51:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9b9lcS9g5f0uhLaGzqiKNYeB4+ASce+ATLJ7N/t4vnF4LmGs/a+3A65Ab0uXT3xU1kkT4YR8EwZggWmB4zgv6lhd9EjD7sicKC7os57uBG9HfPPunQJso3kQZaFEaHe5lVq5gq/PEfFSi6rNpiZ7LKTTJ6U3QtlVuiNa1vUiwvI7rAUYlsIEs3d/sU+N3PNQYH1q94cAaA9HlHtoVFkS9kIs/IrpZXAQkpAyYfsyoTY3MYoTkZ4iF5P+Cx+xBcof2R4Cg1VmmBbm1GxWKJab6IDVQ+fnFLPMVCOYEstW47vTqEzg8nXpVAKy9m/VOsSaEJDbdDHLnNoti8Eyzd9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDcQn8/9FNjkyHP9SjJTny3XqWDRWT38HHVpnEDEfYw=;
 b=csDJE/7LFctxXXi3WiQ80DDWzLNCA4muaGf1hxQpgYm4BNUDPrhID3IFGvv5agGE/WQjg6yWLTIWw/7ki0f8zpQ230taGzruxBqqQiMcxS0QgfLzlmUUeUC3+RE25fG0kgsiD6TP5p4ApJK95vOsH65/2JpPAdWI18Ig+STJsM3pepc5U1bp4U7AXN0YVdMl7JMpX9/m5vexTJKZB2Q9ANLStwnO78uBPqDfL3nMynCZibOz1zbKesxBcAajgNFPPVXbWtGI4JsWxUQATx4DsC2VWPYoIyIe52l5roZREB0sX3MK/sWXVZNMduAO7lEBptQn7x/NpjoF/O71XycGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDcQn8/9FNjkyHP9SjJTny3XqWDRWT38HHVpnEDEfYw=;
 b=kWHLI+fTkJ3oUFnitwzwuKaRSgpEFOwNN3LFn4sGQtA6qX2gu3dh1Qgc2wrOuBNYGs0ursUpBCPRMZzbNAVeNvw7pIO1Yj15RtCkB7b7pdTinIpg0Huk5mM84lt6uJrPGIOOknkbxUcCgfEgu/k1WVYNFR2jYjptQYUq/x0Bp2ZvaV989pqeVOK1ik5CrAFHxro7elQLQDxSOs4GcTPtOMPCLPJUWAAzZ5trbyRb0OzBZ7owz0zn25aCpBxQuTF91SDrhmSUxsfTR6V1hXKWRTwMAd/af/sYPhn/3nVaDiYKheDqrbtoklfAcmxJ2wNwcw3r3SJ7tqbb+vti82HRtA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 17:50:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 17:50:24 +0000
Date:   Wed, 25 Aug 2021 14:50:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [RESEND PATCH for-next] RDMA/hns: Fix incorrect lsn field
Message-ID: <20210825175023.GC1200145@nvidia.com>
References: <1629883169-2306-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629883169-2306-1-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR15CA0038.namprd15.prod.outlook.com
 (2603:10b6:208:237::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Wed, 25 Aug 2021 17:50:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIx2d-0052GT-E5; Wed, 25 Aug 2021 14:50:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2c0150c-5bc2-446f-f4bf-08d967f0d0d9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5142D74479EADFD63559890CC2C69@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkyldoMIKy9tayn1fzZqCO1JY84vt+KKa3B9yb5pz0RsAchbOvk5e/GqSU7I/tvot0yBM8xr9j52S1qhwXDD3Dy1xJ/leiLm16o/QhH1Yg++yTd2dzrYGD1bZ9ty0uHDzCfYO/fyO8UfJVy88bnw/vfNqpjYDLzVyvDpjei7OHM4kl6equgT/Bh272mNPqGtf/d9J9BuQIuOH9kUVQj8NC1E+IK7CLhA3SiamfJ4uLp4yljQVbHAB3Ou0CXHfkk3hXpRA+jwk9e9pOpD7DI0vuTmozyPy431kGw45fI43YaoB8dXWtFA2fPZtlLkfIg5PJ9j1irgU3FW9TUOTUxAUpQBjbnSj0RhX8lnhwS+DI6/wdfaymxArHz4rt9EkoUyLbAm9CpqiF4Qj0kyJk6erSveDlIZK4+6ZA4+jhuzPDbpaXn/7/xybpjgQn6FJbgo7ds2M7Z6djKYBU0Z4lg6Xm4n/wFYl6AM7d4Nz72ezKScPArzomohuJYhQFyMWQV3iGPUCAcSdqlKYBls54DVZv3f2n5FRasgA7djaKnzFxBG5wuUmlICIXDW9gxie5Ab/NiXyALsKY68NTxr47c/tD/SmbsazcHqdbkJTCxVfdWGTqpeGspggIrr0UIT+dWWnQrrEy1mmx55dZYfB8iVAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(38100700002)(9746002)(86362001)(8936002)(2906002)(8676002)(26005)(9786002)(426003)(4326008)(2616005)(5660300002)(316002)(186003)(4744005)(33656002)(66556008)(66476007)(36756003)(1076003)(6916009)(478600001)(83380400001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ezjnqWDBoXcJatsiPKwBjpjhQ+pORiXaSUdg3OKyCukXfDSClDND3vIBkP6c?=
 =?us-ascii?Q?fNi4an8EfpJo9HjbUwo5M0g227v5o6qHHa9cnmr37Kt0gn+PogMAvT3h6QvK?=
 =?us-ascii?Q?qpF5GqV6XfFej83V105zcC1br4XdWljR99T2E6vMSnxiRtHZ22Z4i6f5ErWr?=
 =?us-ascii?Q?f0sA7/i+2QGtYCQutjx6RRCL7rFaUT7nHCPh8fQ0km+yAouczCSb1qWMtcab?=
 =?us-ascii?Q?nNgTKX8amA3DNEhbIpkmm3R/zF3+4BHwLy5geqymhotPbigvgBPskmEK2gbG?=
 =?us-ascii?Q?FaoyNBDrx9s/M5TyZoyqPRv6i1HL61VEeI7keyZacVrq08CS1rdZuXvQpWkc?=
 =?us-ascii?Q?wFK/FiuaJjtmqD2LgYinqgVlnszORsuw91nLhVpPl8wcXLh+DK+LiwU1kh0B?=
 =?us-ascii?Q?4I9HlcYjjtbwvfQZ23vlmxEIWg4E8He7iX83r7yrIlRevk/h/ZGZaXnKnns2?=
 =?us-ascii?Q?kGezgvraqDhey4gEKFYpEbU+MaRLh5Quy/3E6b4REpqmkwRtAx7PBxlZWm4g?=
 =?us-ascii?Q?qHqWyynU7XlsSkYvxz64vhr/8MaSQpl6WP8OITzhr5CVxi8+5mOu30o12s7i?=
 =?us-ascii?Q?UGLOKwK0nVDPSHg20Kw37cOqYLvv9fds596OFNDQxMnM4wxo5mz+md5isS3j?=
 =?us-ascii?Q?T0LhEWdjJdjSKJgh0JriLjyC9vtw/CfBNApTMSH2XNLY8dxreelFGVmjEAT8?=
 =?us-ascii?Q?ElfC9mwBac9UCVL+v/y76Kcs9LxdfZ3e74LbJlzKIELao8RpcsWzfTBlnZl9?=
 =?us-ascii?Q?LeLLfOXOqkT9n4FTtfwDUPJtC0b72oj2WBjKR2l/TBKXyjZ5QWjys8o46ONp?=
 =?us-ascii?Q?lCDrFkGue/bikEiLnIVOzQ4LbLAxaVn4jN9ji3HjkiMoS+X1I+7pUzgc5dwl?=
 =?us-ascii?Q?7iFcXU2be82n9TOKEQTKJc/UelrbaVuurxeS6N1e1WJmAFK2NepOBg3S0XnD?=
 =?us-ascii?Q?uz6YRqJuLypeVe58cnS7TG+nBe5Q6Ih9d5YqjgTh0m3L8sXkmZawxviWCCQu?=
 =?us-ascii?Q?hEQFfYH4SAzWTbE4eT3iLL+rsTbIFmDm+9fG1C4Zd6AW2/9Pq2GqJbU+8goX?=
 =?us-ascii?Q?tII3qcMdE0fYVz1ePHcvGBrmflNx/2/9zK+F+8+rY41VAGri6uTOpQ1LfUhQ?=
 =?us-ascii?Q?1X6I/vB/EX89u0esC3IymdKB+gDfWDo2jPFoMtISmcbDdzcwcXeZSeMqgsHX?=
 =?us-ascii?Q?4SHTFpAzGDdC5p393TLb734glIoV8XlrkdMazo2AJ+jufgfOZV6PVsecOgiV?=
 =?us-ascii?Q?3x07zY4aatQYaGDVH/tyB5ozlT7SI2LUE7Lu55IJcyCPL86EsBqgoB+nSJ91?=
 =?us-ascii?Q?Y7id8bA6Me1z7+D+mh/u7hUm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c0150c-5bc2-446f-f4bf-08d967f0d0d9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:50:24.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sB3haMA2mpWWHXboNvoctHsb0DLCQ/Njht+yyKWIo44rX/zupT1o+M+DNDK1nMFX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 25, 2021 at 05:19:29PM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> In RNR NAK screnario, according to the specification, when no credit is
> available, only the first fragment of the send request can be sent. The
> LSN(Limit Sequence Number) field should be 0 or the entire packet will be
> resent.
> 
> Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-next, thanks

Jason
