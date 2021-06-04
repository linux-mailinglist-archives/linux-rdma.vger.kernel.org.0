Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5F39BB62
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFDPFo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 11:05:44 -0400
Received: from mail-dm6nam08on2067.outbound.protection.outlook.com ([40.107.102.67]:60897
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229692AbhFDPFo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 11:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqeQZQldpPbwR5yrS97kGbH7SbLipPEiY0KQN1JzNmbJY6kbGn1i+dYUuLwk+Cu9uUah7SHMuOFpWkDsPV84odBizvm03KuicTg28BioOUwzO4ttYIXlAkEfVZGNmx5wE0sy7cGe3/eSE5CBbmSqzXv9uIK58RJf7DWP6kAeZArLQOxm0wJvSI5rwO0oksRC1WJgkmvhUqYLeGfHV/O/L6/me9cYHBDydrv8QRJuK7myIySfyneDE1wi+pSPL5fAVp+2slh9aQlBE6fA6ND1zDrzoFaigtU6a9iRDbPZF4QtEPwxfrsIctCoopQLDnUhn6sSDJKdOCW+jm306RTyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBmRd1qnUKYgzq2S8PRIdZxOXp2lhxhPdTx7aaK65cs=;
 b=VM5z8+Mdpl4V+KTQutNYQhw2l9ZMhwI8XZ664YerhKRxooXVgRhLGJunDNMiGVRuQzQdrbEQCcDh1oXILJ58pjc9S7E0fq8iL4mtpGnDvgrRWJLuUqeZTZ5OPo/dMY7ypI0TdPQmvhj9jFDFIHe1AR2USiBTca7/tbv5jirU3VxmN9zhwNqtStffwieVA7qDl5WUfbw+UtdeY3mT2gNyauNI4C8tRj/4oFFNzfEnZQXmzQ838SjgAbwU6cNpRrEpyFV/SBhiLZKnqK8dai4Itb5Kc6Mtd7IzMZn6TOZvNI0bbzHqMqW70Z3TOYTxp/1DMm3DRYma4XTGXKSjezG6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBmRd1qnUKYgzq2S8PRIdZxOXp2lhxhPdTx7aaK65cs=;
 b=FeR3hrmrXCzcpkZ2ReLWHly8x3RtFM5mwO1AXJlAGEZurP3CO8fPn6M5IpcDO9AsPQsjIlu7NUSmoD6Depk38YFDuXJFN35WZ6Y3S0AAEevEwZv2qlxlxMaxmsl+pPZHQBP9+Ca5q3B0U6Ovv6TXfoQ58oKKYJhxCpTEp5QgpWdjbL8Vyg6z+bLExJ+zhd+iXde5auZ/DEBVqRI4el03ABuu6rce0rUk45Ncc7C4cIS1gR8QgVyyEq5I4DKJJQEb9KQNydQNtzTPhxJkbp4CmBlfqF5uHPWKJbACpOyL6ZFukBKo5b0Dv1J97Ld8Njt+S4wToE3tqGlmeF2cIec16g==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 15:03:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 15:03:56 +0000
Date:   Fri, 4 Jun 2021 12:03:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     bharat@chelsio.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: Fix missing error code in create_qp()
Message-ID: <20210604150355.GA409628@nvidia.com>
References: <1622545669-20625-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622545669-20625-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:208:239::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:208:239::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Fri, 4 Jun 2021 15:03:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lpBMZ-001iZg-O0; Fri, 04 Jun 2021 12:03:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e45497e-25f8-4d26-5c5a-08d92769f9c7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5048:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50486E9AF11EC8ACD931032DC23B9@BL1PR12MB5048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIbrmMjK8fRB3Dh5i4paY8mB8QKN22jwsfCebmYp0hb2hs3ddrzL0jlfZT4tSlTMFnuHj2cxOAjl1UQoj79f6kdfY9qC8Twur91NgUAR19iu8B640lofE/JUh4hHxYO9fJvwUKqEtIrH2ObrPiwYqo4Id6Z+qUsBO8u+ehiyU/omwjhR+0hubzIl2rYGbfbebQx2r8yb3yKJr9lGokyqkO/Wf2PyEH+o5dx/QDmgZA7NEGKpCdUPLtshMymL2MYyqY9BKG44dxvbF8/NFie0PvQohHXtWsgkKIP8PVriulhLzN5e9kCiRKPuMgQNfOvzkQ2xCc99XEu89pqMeDjapcSHbcWl5vBPWfYsroby4Hns7GWydaeD16zmDJ+jDKb2Zdmfeqjgrtv1hOKsRT6eRITlAegcYtehI7Qu8oLV9I2Tqyez1nrb2I6+nbP1uwBGhxoChyYhDBLR8txpdsqs91Os9qGQkNsmtkB7O/IKGopLO9TZApApIBWPbBNyi7XkLWPrqGRHqDJTvRFPZF5MDL1jPd8JzIW6M73nClL2ekYW8C2Tkw4iZ47Uf//OKk4NA2r7bnHA5A8qPUZ3XWz/lXwMcjDx25kN9jpHrQ72LzZu0zlr16qXB7P6qIIcJns++NoFnOgEG9jojgpIGw+WNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(2616005)(426003)(26005)(5660300002)(4744005)(478600001)(66556008)(4326008)(33656002)(186003)(83380400001)(38100700002)(66946007)(66476007)(1076003)(9746002)(9786002)(316002)(2906002)(8676002)(8936002)(86362001)(36756003)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6KhD9FdJdMi+GX8iMcwu9vLts7eStYeCePM3/KtaVCL0tKIk9mdzzJzyC9ez?=
 =?us-ascii?Q?vhzhhc7DRCiShFdavlbiciRIG0rh7Cw6h7rJ/R5YkOcZLFhqMRz9hy3VOuWk?=
 =?us-ascii?Q?6nOtEuQT1qnOnkzifwvKnTQsd0p9Fs48YiItmTZTZwelwGfTXLjgkTyWMALo?=
 =?us-ascii?Q?mSLXXFreY52rmRHX3VeFc9fZ2BOGnNp+/bU+nlc3yIRUqmCpjZ2zw0Sxi8gL?=
 =?us-ascii?Q?CRojF2mcDscrhIygU9f13nI2L/z2I8I3KKzQeHJNybogDYdKGJAF795eCmzc?=
 =?us-ascii?Q?DhquN1IFBlhV/zxaLOg7jzzJY8h1LBYf77R1eicBHQCaf+gtRnvfWGrluKaJ?=
 =?us-ascii?Q?BilorP13lVUvER0vXT7mo1iyz5xBPmvNKqbrBFMZOpi+F4l4wp89ZbK0O027?=
 =?us-ascii?Q?6Fes4uRNR+j0CbBfx/MMbkeiVJNSf94qCgXweSlL93HwBGBzX2MpAvSfdfl/?=
 =?us-ascii?Q?QtnDr2krWaSvQWGSLbz5WU+Z7FKvA1PkurPadm1bGAHE9myOf5wL5DB9kk7R?=
 =?us-ascii?Q?J2/UHq6HTjy5lipe5/ZFWKkUAUkh+jbjQeZmns5GcRaIR/dPJw/shDQ/mWZh?=
 =?us-ascii?Q?0XCClh4lYHnnRlBXJyNRvKtWJ1ujhxKJcOTMm4gFg2lN2S80ErPsfy7BwHME?=
 =?us-ascii?Q?YoJlLIgly5S6NUVdX9LKiK0bm7i92jqBlC9C/MrGIXTz+an6n+jDmf24Xrhq?=
 =?us-ascii?Q?8ybZV4oxtObdQ4rlel02Te6VO0bgUE2XDYhn+Xerydp7y3MQL64cxBhM+z2K?=
 =?us-ascii?Q?qnbOLb7m/tsk0m+/l6TM6hPswwc1xYNiDfHId2kMupYrdWIqfvNGPCxHvlLX?=
 =?us-ascii?Q?7WEPLHMqQtdRvdM1M3Q8RtP6QwtZdPih0satiaB5KgkS1Z6URtcKi/u7KT50?=
 =?us-ascii?Q?xzDJTGucflWbdw2PgPXjWaelXG7JVrK4eAQ9MfD0MV0KUTYoloB6xYziACQZ?=
 =?us-ascii?Q?qUcInfCXuGyUS19B1BO0LFwSeEAednEFKK0pzqf1FJZ3vg69xTHVZpq5s2Gd?=
 =?us-ascii?Q?SgILQNYglFo9TspAeEAHjV069+C09M0ta/bdtlV94AwwGrjiycbwYm7rBxyR?=
 =?us-ascii?Q?gNDVi7TMtkKjCnMwZWxVpljdho+lxMXUKjhSmzBuvCuqZBg90xKRh7AWDw/m?=
 =?us-ascii?Q?+3E2eU2KSn5p6H2MZCiSez0Lr0ad1jxITXf0wr+2kQ4Xf0fbo12ghR/7YLo5?=
 =?us-ascii?Q?gyg06DETXgLdp1UnqB7uFLOpDnze9X302bDMT4FpDn3DGzSgv9lY2GMbyPWl?=
 =?us-ascii?Q?a9SUyYYPk552y3TW/mujyQojps6uslijrksSV8OaReuyNdTJZXm5KkYfKV1d?=
 =?us-ascii?Q?TJcX8pNJ9Ul+JIaJgx5EecNy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e45497e-25f8-4d26-5c5a-08d92769f9c7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 15:03:56.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8g0zlA0sWkSCgaPugkRZ53pkIPi7dvAWXKOeNGw42//k0G0LrW3jUTMZZ9Um9VB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 01, 2021 at 07:07:49PM +0800, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/infiniband/hw/cxgb4/qp.c:298 create_qp() warn: missing error
> code 'ret'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
