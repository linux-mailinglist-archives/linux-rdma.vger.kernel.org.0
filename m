Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DFA3F7EBC
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 00:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhHYWlB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 18:41:01 -0400
Received: from mail-mw2nam08on2047.outbound.protection.outlook.com ([40.107.101.47]:60864
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229786AbhHYWlB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 18:41:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXARV2MlGx3NVApq8GgFpobPkt2CRM+zGrjQlRnK463sDVaVhyiCjMKOh5iLeWUes+uiFtddbEiZuZzg2ziRdYogTZi3ksR/PzqIzskcB2zgCVNH/6qE3x+QVF1zbhyWk3WnLWoxuvGIBBWWnWKZx5Lrx/T/ZE7BZGkqDu1Nf4cje9/UiFoUAImXmonQvUbcHqZAv3bDtDcLWg1yIxDrP3C2T61mlZuWWDqctKIooRLq0suoXh3NRccHQ/EQyOtSnFGJR+ulB3WD3qf6RYcYsV1HE+qOdCWueGMX92rTenbsLEBOKWcWdJEY8D6Dzeq+nGCcPsltbfK/bnOAQOqIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW2CPexEaagl7EYVtA1wGuaK0WRxrliTT//2/Sqi9Ec=;
 b=VmawU1UX//0a3Dkz3skqbeicI2RDm7/ChZe9/UpIGtIpRzrIDQzpgBvPhuP1eSzgvVjVmV97TX5ZLQqQa5H6XULG1JJTB1ZUqXDbTY4ZLq+R58TBsAzya/Cf04QMKmw42sfkN+95JriiJLPZDUbnoL06RbmpGX8jU6y1Cykp+1/k6iBzZv1/K9syrJejfocWmER/hE1DtGChol87/CBeiKiZKCo2iiko70+u6KCqQvWMEMNesGP2+GgbiNkRD8cmh0Fxq+QlmG5puB8J8GCTPLWEb2S+W6mA7ZB+wV6b+zei9Cowe1j9LZrSw4U9pBdFVVSDUFXeXhPgJFUnUQh2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW2CPexEaagl7EYVtA1wGuaK0WRxrliTT//2/Sqi9Ec=;
 b=WJU7uIoz+QHQBLaLadWShV9VoNvmPMpcaI7BSzuFMdcesaDCC4YcA4C8wjyK9DNB9HsQegJ6CIgANiP1nli1KRIWkAJi+wCIiErLeVVC29d/crHTe1XeBcNlwInbBWRvYDiczgXVVWFrUjiQ2Ir23iZV7YkTUfm/DWsYiJCIABlt2sU+IPImzow01i0RQHRa5jcSWNXHXdErJJLhv8uQtoOd6ou3QQeF0ZhRMVNF8V/Jn+ltYROwjFeHnFu+4ad3R5qIYk6LH8CRaxFq2/46gpFiqz+nXQ2gWWeO0lDxfnXSc5poDjC8VRRAEeDCYT1k/F8Aol9dJD1Xn/wV9lb1aA==
Authentication-Results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 22:40:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 22:40:13 +0000
Date:   Wed, 25 Aug 2021 19:40:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: Convert to SPDX identifier
Message-ID: <20210825224012.GB1220397@nvidia.com>
References: <20210823042622.109-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823042622.109-1-caihuoqing@baidu.com>
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Wed, 25 Aug 2021 22:40:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJ1Z6-0057Yj-JE; Wed, 25 Aug 2021 19:40:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f33f5151-72cc-4f87-3038-08d968194d80
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52225B1E80948C6960344089C2C69@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QF91h8nWVqY9C8Q8EZZKXSfmqq0GQV8QozIRl2j9KmzfgxTFoiDiKn4BiX4HLUy1cMU57WfXDqWd+7eM+kuTPooVSgCQqIxM/cSWel3aL5bU3Hb28C4fRdYT2icD4Cyq0rdPw3FR8QODHc2SzVu3JyKHxVMQG/lbvk2xpiZRWLNND5IIo+zcxM8WpS57m5Pe9Frb8VJ7HuPgm4Zc0ekqHPWJM0qdcf+4piupDJZy4RzIsduZzMBwlKVHmNC1LkcjQEcB8rS0ZIpB8+04r6lc7/mHGUxI3bQ3V+WWx1LNxeseZRvYReJZtzw/PbGkkNgnLAKuPP6hsca8qnUvYKuTr9NDrmGmXv7x18zYqVlGURNP6+5tx+0zjMcb+io6PAlxYrfhGO+99cIDVoaYDakFIjI6AVOE3XXC6bRUy2y3VAKm2GK0hntU+Kw25h6gzpcf/tCEW/vyIHmZGrGscGA13AYWFHJVJpRPi/sT5CCTtlHzxUrOZiQ8u7/YjUtuX4qMyia7yJtTh8AKEYke/8nJ891OLTG+/LZ0yllmolA3tilrN5PLy0Rf6LaVlmQ9T07dZhCKN2bIC2+wi1S9zfsw6gBSZczVhYzlW5ATo05vEcktDgYGIZAGb7aWHon1hSnOSCQYWBKWUP+mKPbNymydlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(6916009)(36756003)(33656002)(426003)(9746002)(83380400001)(316002)(4326008)(5660300002)(9786002)(1076003)(186003)(8676002)(38100700002)(86362001)(66946007)(66556008)(66476007)(8936002)(478600001)(2906002)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8AqEjWAjT8bYNFU4ODmsWuizQk7b4Q3muVK0tDy8xdnLw8R1UCK7PjLqlDk?=
 =?us-ascii?Q?NzLfnWb/YBJdWla00eNa/AyivUjCiF5ReJepmcD2mHS4TKmSPGkoiqrh1pS7?=
 =?us-ascii?Q?Zd5DBEzwMtHf4rxiyNhoQuYygyezXrTorFFb2xxuYKf5qVtu7uCiO71hSj3v?=
 =?us-ascii?Q?rNY2wHZRESxAQAT1++TpclDuTvzsPAHVl54MRm/0xnIqq26/AUrPj3CKn1ky?=
 =?us-ascii?Q?FE/YY5blzE9qYFkwsVte69+EndgVvtuTUPCCMGTZDRPRwUantnF2pXBlutXL?=
 =?us-ascii?Q?7AXN+7117+vYGdZwCOoXwpnY72eACG7X+zjYcAfF1VRyHOOotbArxixkxUyE?=
 =?us-ascii?Q?NjdO9fK5SAdHFyxtvjUkoKXUfFWk4+CmuYmWHriUtQ5MtvZouX4H1MNyJsYK?=
 =?us-ascii?Q?LVUHGcsVwbUQAH4gdZ6eRkQ8D07bX4nEb0AqMBducJ89Ljc+AzFywK+bzUBy?=
 =?us-ascii?Q?5uCCWsiEmWLP+3dUrVSGbxA/3BnhgkhOwjGd6c6Y3DMFtEniiKax9ozMZb7q?=
 =?us-ascii?Q?2HiNsut46VszRw/8ZeagC82jkDs2umG1x2rKDPAA992gjgEUVnBvpf9bjpUM?=
 =?us-ascii?Q?FXG5HRUhdKNNTNyJtLoMrdGM31Zh6jnMAhnUL1MTRS0yqlv/Sv/fStuKwfT8?=
 =?us-ascii?Q?icVLTcCgm4kY8cq6KPPcAhSJvND+SNUHo9kmdj700hTi+K5kiEsOikGVj2Il?=
 =?us-ascii?Q?8I6HabApaiHeLsOnakWcWbQFG2ZJ76AWjuDxIRWbPtHYpFrVRlu/zy127zHG?=
 =?us-ascii?Q?8yXa2BJASqvD+HhNDFaskdAkTKWU7JjIf9FPEyFUx39Ihm8oDWcwxDGH4+bt?=
 =?us-ascii?Q?e3L+cNBvXvrkl8OgWDX3l5mgJNY4V9niFY2Bs6fFDJzJsEPVe1Xed3Rj9uxv?=
 =?us-ascii?Q?27Y2w1rbV2zwr2gAp+3dsu6HTc3GzXplHMyNWyQScMKGICYfVvfcPG4JNRUx?=
 =?us-ascii?Q?U0Hl0rCoO7bCWWLm1t09719J0zuOPRIKwmt8CArEfrOmOGRwdKtcDwZlFFB3?=
 =?us-ascii?Q?PcMpNeYoJgAuBaQrC5Du1iqupv8urHzOzKEYkT86UWj8xeblPZr7MJpj9eE2?=
 =?us-ascii?Q?/cj/Pmhjs1hy3cWSiRdFFPjXovR+vfsgUKUSBP5+6i8r0nVc7M6Hx7UOAqUP?=
 =?us-ascii?Q?CLmDmr1Kry3Mye9a6pobHZqd8mffU/lUreu6P2ZcdACe1Es/2WBU6moRBadz?=
 =?us-ascii?Q?7lzc8UQJV+fgQOoQrQZIolyhWCx/p2nMxtOyrpRkQiKfb5ZNF6dKfve5GQ3R?=
 =?us-ascii?Q?e1z/wM/+sqI8dt2RcAgX1dmMF7czqZJPjbKoWj7LaHmswJQc98LGASTSWPtf?=
 =?us-ascii?Q?yUqa3p+2Zu29fiAARG3P3S4M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33f5151-72cc-4f87-3038-08d968194d80
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 22:40:13.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVIAnBqZPOzRAhougNWrP39ZIW905ZasucNRcHOrzjjDGkOxJxgLXt6Cw3FU++7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 12:26:22PM +0800, Cai Huoqing wrote:
> use SPDX-License-Identifier instead of a verbose license text
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c       | 45 +------------------
>  drivers/infiniband/hw/hfi1/affinity.h       | 45 +------------------
>  drivers/infiniband/hw/hfi1/aspm.h           | 45 +------------------
>  drivers/infiniband/hw/hfi1/chip.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/chip.h           | 48 ++------------------
>  drivers/infiniband/hw/hfi1/chip_registers.h | 50 ++-------------------
>  drivers/infiniband/hw/hfi1/common.h         | 44 +-----------------
>  drivers/infiniband/hw/hfi1/debugfs.c        | 45 +------------------
>  drivers/infiniband/hw/hfi1/debugfs.h        | 49 ++------------------
>  drivers/infiniband/hw/hfi1/device.c         | 44 +-----------------
>  drivers/infiniband/hw/hfi1/device.h         | 49 ++------------------
>  drivers/infiniband/hw/hfi1/driver.c         | 44 +-----------------
>  drivers/infiniband/hw/hfi1/efivar.c         | 44 +-----------------
>  drivers/infiniband/hw/hfi1/efivar.h         | 45 +------------------
>  drivers/infiniband/hw/hfi1/eprom.c          | 45 +------------------
>  drivers/infiniband/hw/hfi1/eprom.h          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/exp_rcv.c        | 44 +-----------------
>  drivers/infiniband/hw/hfi1/exp_rcv.h        | 48 ++------------------
>  drivers/infiniband/hw/hfi1/fault.c          | 45 +------------------
>  drivers/infiniband/hw/hfi1/fault.h          | 50 +++------------------
>  drivers/infiniband/hw/hfi1/file_ops.c       | 45 +------------------
>  drivers/infiniband/hw/hfi1/firmware.c       | 44 +-----------------
>  drivers/infiniband/hw/hfi1/hfi.h            | 49 ++------------------
>  drivers/infiniband/hw/hfi1/init.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/intr.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/iowait.h         | 49 ++------------------
>  drivers/infiniband/hw/hfi1/mad.c            | 44 +-----------------
>  drivers/infiniband/hw/hfi1/mad.h            | 45 +------------------
>  drivers/infiniband/hw/hfi1/mmu_rb.c         | 45 +------------------
>  drivers/infiniband/hw/hfi1/mmu_rb.h         | 45 +------------------
>  drivers/infiniband/hw/hfi1/msix.c           | 43 ------------------
>  drivers/infiniband/hw/hfi1/msix.h           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/opa_compat.h     | 48 ++------------------
>  drivers/infiniband/hw/hfi1/pcie.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/pio.c            | 44 +-----------------
>  drivers/infiniband/hw/hfi1/pio.h            | 48 ++------------------
>  drivers/infiniband/hw/hfi1/pio_copy.c       | 44 +-----------------
>  drivers/infiniband/hw/hfi1/platform.c       | 44 +-----------------
>  drivers/infiniband/hw/hfi1/platform.h       | 45 +------------------
>  drivers/infiniband/hw/hfi1/qp.c             | 44 +-----------------
>  drivers/infiniband/hw/hfi1/qp.h             | 48 ++------------------
>  drivers/infiniband/hw/hfi1/qsfp.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/qsfp.h           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/rc.c             | 44 +-----------------
>  drivers/infiniband/hw/hfi1/ruc.c            | 44 +-----------------
>  drivers/infiniband/hw/hfi1/sdma.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/sdma.h           | 49 ++------------------
>  drivers/infiniband/hw/hfi1/sdma_txreq.h     | 44 +-----------------
>  drivers/infiniband/hw/hfi1/sysfs.c          | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace.c          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/trace.h          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/trace_ctxts.h    | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_dbg.h      | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_ibhdrs.h   | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_misc.h     | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_mmu.h      | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_rc.h       | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_rx.h       | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_tx.h       | 44 +-----------------
>  drivers/infiniband/hw/hfi1/uc.c             | 44 +-----------------
>  drivers/infiniband/hw/hfi1/ud.c             | 44 +-----------------
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c   | 44 +-----------------
>  drivers/infiniband/hw/hfi1/user_exp_rcv.h   | 49 ++------------------
>  drivers/infiniband/hw/hfi1/user_pages.c     | 44 +-----------------
>  drivers/infiniband/hw/hfi1/user_sdma.c      | 45 +------------------
>  drivers/infiniband/hw/hfi1/user_sdma.h      | 49 ++------------------
>  drivers/infiniband/hw/hfi1/verbs.c          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/verbs.h          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/verbs_txreq.c    | 44 +-----------------
>  drivers/infiniband/hw/hfi1/verbs_txreq.h    | 44 +-----------------
>  drivers/infiniband/hw/hfi1/vnic.h           | 48 ++------------------
>  drivers/infiniband/hw/hfi1/vnic_main.c      | 44 +-----------------
>  drivers/infiniband/hw/hfi1/vnic_sdma.c      | 44 +-----------------
>  73 files changed, 133 insertions(+), 3170 deletions(-)

Applied to for-next, thanks

Jason
