Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001283DBA1B
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 16:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhG3OKF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 10:10:05 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:19232
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239126AbhG3OKD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 10:10:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRFzmuxxy7L2EGXEuRRlJFpk+WysVJ0EsyANHuPOa3x/qTm6EojUuY4p/am1ctYNDcpVaYXFcc9WAjggb/ZBbYx3+p04rkkM4Oyx439/LWePjRCIIj+LewJMIF4zypmhfZok4Nx4s22jeSb6kCS0S/GJ3n96JR6+uEOaDGXGxPTvczitSAI1NzCXg+jMwt9Iimmqqg28gYtwq6kz+wdcYsCNO0sgjdrRWDSexdTHuo0/25EsX4g1c+Uf9HqmgQ2rdo83XQTBRIyhYf5lYSHjw7e/JnVERAIpYMw3GeqjqgWBS1wJ3su3F1Ra2URNjBKZzbmaYzjqgN0Zh+ST7LfLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf+F1aJGh2D7mybdSCAF+JBgV0vFBPE7BQKVxaoRYb8=;
 b=bHNmVp43ZS4Yg690fQiNJKUkToT2+j46gwBa/rvDvENNz7sA3CMIVRFe9uXc4M1VsQ2/FvgYKEXm6o600Y+Y2uZkdKHyhzeUYaOiPTdBzdAzeaDbyneU+9029rQqOMWZAk+tItDFPwm7+ItQ8cVvF8Ycqjh2+uiGADth1cVKDIA29aKqYoP8E4uYeUislpumFQKuB9W9MWdD7V6/NTa1qIrgB5q0rdnPcglq1uJcsIzwLkpKQDL40IHyMaCOJjalcTA845hAQk0cNImvSfZIeOn/E2X+kiv0RxjsTFvHomOBkB54QBPr/g2AR0qSnjM9/Qe4BDx0RIY2lz5+xfPxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf+F1aJGh2D7mybdSCAF+JBgV0vFBPE7BQKVxaoRYb8=;
 b=rlWBVTLf1PHr7iD7XviWZIXT7iT8vAd6rBn2/4c2tRg11udGUny+GBRRfE0S82WiYQL6R9PJ5tZYpNk2z1PVmEjzzqvtRWL26wBil8cB1aqHl76eKFBoH8K8Xg5wm63pug2kpeJCpAyCfwpojVUvrOkfjwNbxxY/Mf/dU+XMg9sAZ5+LRfuY776+1l7IhuLL+uyntXeM8FIr7EOPR37qqubYfHjaE1E4UsBipGRL0StzWumCkKUe6ktVkQCTgudpjSetYErOe2V/j/pAmpBMQbuErtBRPLGmmSHVtZq14km0+p6v4Pj2YGz24SkUkQjg6bZL7+rUkSgb+wDWK+PjIg==
Authentication-Results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 14:09:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:09:57 +0000
Date:   Fri, 30 Jul 2021 11:09:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: Fix typo in comments
Message-ID: <20210730140956.GE2559559@nvidia.com>
References: <20210729082346.1882-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729082346.1882-1-caihuoqing@baidu.com>
X-ClientProxiedBy: CH2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:5a::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Fri, 30 Jul 2021 14:09:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m9TD2-00AjwZ-1Z; Fri, 30 Jul 2021 11:09:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b487832a-a0fb-494c-13bb-08d95363b632
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5077ECCD971643DD27FF0FDCC2EC9@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hScsexT5n+T5Nx033T9m0R5GjpIXWkSQ6QWYy7Fc8J6dYqDAGLdzu8ay1VFyd/+8p5/XSw7wDqRhwJ6dI1z+ox4rRYh8+q4LQa31qMuhl65iyHwRksaT5bAWzr0PHPaQnoYgJKhc+s+hoZPN94X1UGmx49/eXgqXzDtkAQnACfAnci4OmA44luEjSOGvZz6Y3PPkcWPjdatWUx15DyicUPgewqt/NbLuFJkP8+6rv5u9cLEQB2qVzylEQU+big0TC6GZ6kBa5uEHpWJVfXKjcQZCh853d3aKjX2Qo5Vf5MMTpz0hnAV9qnjoeAEKDU437p02p6XNoK1JUfTl4qPoWL6FXVFqCaIPILQ9WUau3Z+gYL0LbJIiGROKQVTSnBDmUJFwqSO4asz0tWtV4G4Qe9Ect/0hCjj6wVkOwvrfCj6IGnj2tuGNEfhH+0dfSnEmkM2BjxHFX1tgG4QfbfTvblGJIh4vS7WBiFqxiNb777yFZL43xSNsiBiX/QOETftFJkPVPHPFAFf06VN5HU+rzPrcrV2/1WMdXRhdi7VAGc5+6/y7Yuleh5CRdpQmItaY9O/fdwhkaZqDcV3J5MB1n2HFCPJ6ZjoukrQQ/Eeo54SaJuFTo5s0iLPzCQIxign4BOynJ6Cfk/zdCh7jGg6RsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(36756003)(33656002)(26005)(186003)(8936002)(2616005)(4326008)(478600001)(6916009)(5660300002)(38100700002)(8676002)(86362001)(316002)(9786002)(1076003)(66476007)(83380400001)(9746002)(66946007)(4744005)(426003)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLblCsgPVTZFESipvHrU38hV/x6hvvrZN0vqG/aMmC6AYzF3HY3uPgsO8cI6?=
 =?us-ascii?Q?VARsmYw4J5l4wdE12XV77IM00N3p95nkaiwqfsAM5pSsvLSFmCUmsDal5UdL?=
 =?us-ascii?Q?xa6YsC9ModXhtomkLYx5v+j+rl6sehWtRH1opp5YKFp+1PDInHooobG79NQm?=
 =?us-ascii?Q?nCqY+iXl7hGgDJcuwRcXj+e8LecpK51hA3X3qt75nUPOAmGgnc6XXPZDMPM0?=
 =?us-ascii?Q?ER+3li3044MjLUtdFIyVp2ofD9fIkd1rgI9VFEVzRjxMzt76Y+FnDIoOtKzC?=
 =?us-ascii?Q?YOGJTzsfNNUX04Yjbn6meQ1fO/SVn1Zfk1QQzif6OCmMbQUr89QsWqJtzIlA?=
 =?us-ascii?Q?/8IBuF9Zx39s3GhnHYhl0j4T9tGqGdY9DWaQ5InJGe5hC9iDxltiPy8f423Z?=
 =?us-ascii?Q?O6FSjwdiu7YKDXwVcblv8h7LVTE67knQCIJabq+a6G53Lh4t2VC/Zy1U3QDk?=
 =?us-ascii?Q?gbzmEN61cey/z+of7W3tOACvv+OwsZw+EamDBf9fTvqhOdNNWcZak5e4rbJH?=
 =?us-ascii?Q?ynn6mdPD2//q7QMZ0MQJyDpAjbuireiorlRwmKCAvq2JOPdS/DG7meM3usw8?=
 =?us-ascii?Q?KySP6bncmYUttHM3K7KlYuTjbbBVmrSCcnaBjk0b/Ge76mu1YM7Os49dy6C4?=
 =?us-ascii?Q?40DQsEDrFIo+ulcoh2y3Zy5hfclBCIXgMyhkil9idnd5nUYCikZIWKGhqbkR?=
 =?us-ascii?Q?BGAcrxEqYp5Psui1pjSS76ZExUS/CynfliOhR8D81Ohx4PGo8N68hctJj6as?=
 =?us-ascii?Q?2jOmBRJBeW/rMbIZhxZPJUT1Ys5BdZasKKgdTgUJJTqfl1Y71+UVx8vLZwQA?=
 =?us-ascii?Q?PHF7w2bJZ//MFlq6MJaNZEs1ucKut+HuUfUWk08gHRW0KSp9uM/OBmzLsV3P?=
 =?us-ascii?Q?DX+pjIfNyfnJqdbCh7o0i1a0HNzN9dP7RnRO4cpMvXiAKJBxndk2BvMZpxCg?=
 =?us-ascii?Q?508gh6eK17/CoszvOz2gyTAmC1w9M+3f4n97NQ3+0M1UR093f4eGn/I8k1nD?=
 =?us-ascii?Q?t/wKpBXdGRGMF+xLE9qayqHw7es9FVL7+7vW83ieAMEHhRWU94aOfyWq0AE2?=
 =?us-ascii?Q?tsWlnbEYSORMf6HT0KyG6cDXS66kB90/4QRLeG160xH8Bjn30Y5+Q9v6hOpL?=
 =?us-ascii?Q?Ba09wlmG0rhoqejy5C0P/ALs+hg1R/MiNCYBndTwUnENMDiDYiXn2A8HIqVo?=
 =?us-ascii?Q?zSXjxCmrlGeTzYeb5/WiOCx7OPDWbcBRCMejb6BhKBnyTDwoze1i55UOp+yW?=
 =?us-ascii?Q?Xn71VlJJwwuX3BFClTVJZddZJ3ixKUkfPbftFtBC4Pn7danVqkm26mqgxl2g?=
 =?us-ascii?Q?ZxOCa6rPhFva+G87uaZ6N3pq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b487832a-a0fb-494c-13bb-08d95363b632
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:09:57.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W72Vwig0z/U4u4W39qU//z/KVOA/hgZH5y8/I0r25r3F9TEPb0CHl7r4xZruLWhU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 04:23:46PM +0800, Cai Huoqing wrote:
> Remove the repeated word 'the' from comments
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c     | 4 ++--
>  drivers/infiniband/hw/hfi1/hfi.h      | 2 +-
>  drivers/infiniband/hw/hfi1/ruc.c      | 2 +-
>  drivers/infiniband/hw/hfi1/sdma.c     | 2 +-
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
