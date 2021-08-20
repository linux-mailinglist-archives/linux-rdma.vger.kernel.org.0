Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AAF3F3416
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhHTStR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 14:49:17 -0400
Received: from mail-mw2nam08on2051.outbound.protection.outlook.com ([40.107.101.51]:52993
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229512AbhHTStO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 14:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pmy8Xr8abuBnl68Vf/0O3V3+3PytJtApropZUZUESJkC12txE0dJBNkoRNA2KaJBIhmphDEys3PlR5Hf67M9G/H9MA7CLbZHmKRGyJXljEG+GMmORcbK0wKP1sDnKzxlfTZ4wQdMzd1iO/Mw/TPb40zdz72hQEAbqQju25OVQvQ1s1dfbRwkgDQtLIsIRrDnW/xHobrEdSErQLyHW5ax2uEj94pflsFYUjDy93pMFCIWQZA+I2I6WqeZM3YMuR//fIRcCGSmwWKZkIE6zuicT8deX97+sxwExdOeBQSpXHX2893lQk/OhQuN5ZdPDJwSN32Cy2kvsr3ipXXokG65/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOmi2dWszwbCDUT31KmFL1kQcw7BgnIGEz22jEmMO8w=;
 b=H9w5dW3teYvDpwYl9kEdweorX1GGXKzRyrQFNaH4ZEtR4r7ftk1N6TjPVHioXTttCAids48RPw84JNT6dfnAu7C7salrOD2UD+Cr9r5xN407ViVFmILI4kDCitsPfXXapItNK6QP3gRO+dH83zKFYJVUDSVJZ9Be4PUfmYrnenINmMRGpTgdXIfgLIwx0t/vRV3Pu8fbvmERTHptvtLAmfe5JQ/oVJXk61bZXsgGB2RKdC1fUxptWtnwqq8Px4JVdjlxh/C+GkeA2xEKq2ueZH5V8VEQo+ix++OlhefrQCjJG+8MLIISzR6ZcAmB9tlIbhc4FbqqNNInY5FN7EzBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOmi2dWszwbCDUT31KmFL1kQcw7BgnIGEz22jEmMO8w=;
 b=kHWzJeWwy63ixYZ6OKyzV0fFp6+pgbFT7dFg2cWyAqu88hPoNdS4dqzODafQmM2dGRFHe5XjO27k9Tu3Qk+xNM88uZnHF0i9z5YheVI7hVVfRNJ1UE9MyN5qWShKwUF+hPf/5bu2vMnqd58FeRzOwhXSAe7Ut5TmmJy0X0CqLcofRfBmiDJS3VJHNQsrCWvkZojiwifvxdGQ1ItVkKc3DGWWv9/mhM9kKcUabSAlSfXHu/jY7cfYbh2p/QcOSj0QRFuG6wWPC8k5++Th87HuD41VuLAVS/9Mgc+qg08EAKhvvYFKNpiALx7g/CfHhLPoNeW4/ZY5xtHnsNCarMw/iw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 18:48:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 18:48:35 +0000
Date:   Fri, 20 Aug 2021 15:48:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Use ida to manage some index of
 resources and remove unused bitmap
Message-ID: <20210820184833.GA566369@nvidia.com>
References: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR02CA0082.namprd02.prod.outlook.com
 (2603:10b6:208:51::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0082.namprd02.prod.outlook.com (2603:10b6:208:51::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 18:48:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mH9ZB-002NLl-T1; Fri, 20 Aug 2021 15:48:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08825aab-e381-40ed-7efe-08d9640b1d3c
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5507A9B19912423AEFED38D7C2C19@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfrP5Jf7AzoTjjbJ1E5+mCkY83PGMXsdsSRuMJS1qpRTBSyt9wlzHczKsE4ErGPAGDu9rPvOIeTXTrw2WkYiZUjymWjCTdp0NB+pMujIeZjb9ZyQMIzNcvnml2U7T5AhCsLlXcN5rpqgufmwd8iCqn+24WF8ivcEs/9zjzFu7WOfXeo1emOjvR6ijjFsAn14vhF1QAG98X3A4ZCwHED6lWsSOkB+HgOzJ5591CeSq0oMcZ08RwLwmyWEOH09zjd+A85U49hSTj6TIbepGcCjFGnJvaE4YrNkbDi6Tqswla3KFK2JRtX4MsNhuDuIYLdlUlAH5Np3fXQNV4/+LZj/Ld6EqE5zelObRD6XPHczwChBSe9Geu6XTZXbGQHOPkDZNjnTzADaiPf3WD8ZkpBw47F5W+he5FLmnWRvyE8TKUC8N4xz9GK4I5dr2zEt3o9Htw7efSu0Sf6WuYDeoQ0qxI3z1/22v4DfbaAgUgALi7G2cxwCnZg7zxcZn0Nde2Z4MLTqoSSHMwO70NNLTjO2SEYl78T266F4JCbmT/22Mrbl7uc63xKSIU7d+WDZw5XKNIEyDTMs/RLWpNC2eDXw/bqdU0IAUPKfb+SJQzb1le4S6s+elrznNJpaCGNykEgxGq/wSR1Psx3chYzoAplX0rvQTxEWDjI8ycj5PIyKrNTe03hcDdLUDAwQlCnRldR6c3Nj3hA0Wl/sp8aZXUV3DSmPX2VouBMDeS98kCbdNjcwOkpWhJGt54vCFvA5t9TUig6sWsdZUELbchuEcKjXvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(5660300002)(186003)(478600001)(2616005)(1076003)(26005)(33656002)(38100700002)(4326008)(316002)(83380400001)(2906002)(966005)(86362001)(66946007)(426003)(66476007)(6916009)(9746002)(36756003)(8936002)(8676002)(66556008)(4744005)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yjDXHkpcYdZi9ge29afujfXY8+jupOjiiUlk+siTkZADKx2knGbpOIr+1slD?=
 =?us-ascii?Q?f4V0o+2dil269MtVlnyRs1KgiZ6JakGju9jFJuDZq0/WPvnD++rEIUUtK+JV?=
 =?us-ascii?Q?mehhtA7KMVhED5JD5XCkgE5iFQ9baJdmq0AxSwKhTcc3uz3MExRyUxv6X+DT?=
 =?us-ascii?Q?omMHPlYBbpkmFq0bgwqorUtJCexF6ULWEKH8wDf2pKSMVy0vU07A6uQkvh8d?=
 =?us-ascii?Q?wb2AHvp+RO5/FxrlIae3c+amcTTvBeWpia4qPE4OCQWKJrU2wVFvO9vdqpwk?=
 =?us-ascii?Q?/Y3wVRbi1Srf+b7tItLaVB8if6dxLWnvLozMimbBM3hbdT3KH+IcEGjrAKyV?=
 =?us-ascii?Q?r4ewQKssHHmhlHJI0BufNwxX8z8t0SOliGjuk5szTTUY/7NgH7dRO+tu6D+6?=
 =?us-ascii?Q?Z6bmuyz67TjJ+UVDjbECtzr0P27ikMj38lYZSZDtbJtcYleNJ7KMYyfT6J/z?=
 =?us-ascii?Q?Wj0fdVn0lg9yKkZaX5TmQeroE41e6+pIrJifJVyVs+ePx0V8D5/MYzYiir4w?=
 =?us-ascii?Q?Auaa35GkO/rU2jQQY8mn/Uu2jsbFb/2Yd2JpBXp5S9DOqZZc8sZiCSwJ1Dd3?=
 =?us-ascii?Q?/UbWqn2+UPfidMD+MUz7WWEu9/Ha3/HNzHEg596FR+qFxw6Pkam0jmDorwiB?=
 =?us-ascii?Q?Gx57jFKv4j8yISw3HgXFoLooe5dvSh1nnN3YjAyiWHu4Wf575AzWH9M5Fb2z?=
 =?us-ascii?Q?bn1M7H7VTcD3rNjIv98SjSi1pygdQA1rQBdfN6Kto47epTRtZFFW/SavZEu8?=
 =?us-ascii?Q?e1WbrfZU0Ywahib/c+GA+SifDqcBB1gYo6OYrFcLsYnhcvk9tKfQIQOmuI2J?=
 =?us-ascii?Q?caxJuT9gGVy8oq5Ekesezf6AgFE1yBF9dRvQHqqGnYre93g5ThAIpNFdIgGL?=
 =?us-ascii?Q?K96YGd+yLvwYH8QWvw5oKipvxEtQX23k6zuGLAF1k3pR0YLssEdpJxdh84IZ?=
 =?us-ascii?Q?ca9sR/XTqtdROpzWQhO0XO7zcwlFlsjMQ5QfmVl63wCpxkunS97y/e8JgQkr?=
 =?us-ascii?Q?io0CjA+cgtwRhsd6Kz7ggQZBy8MywJVQ9UMIuhq9Z1ClWREUw7rzv2qsel9K?=
 =?us-ascii?Q?1Fq7/f9g63l5bsLHh6UwUm1Sauk9guYcE6Q2CHzEPOLjhzTmrFNBIfGIHRdP?=
 =?us-ascii?Q?WwioB/rghCTKMkAaYQLYBSNy48ujbDOHnxIUAY3MVq8qwrEanzMsA54T+367?=
 =?us-ascii?Q?Q3i3MxRJf6jFioLfS7KuzDT3be3e5zLT7ff4OPg1DIZBQmEU1GVckP6PUY2J?=
 =?us-ascii?Q?4AFOQN8PaRQsIDQdz3abkpM2AWHbZtYotFOwfQ/PPLFjJRC261SqVq8XA5yg?=
 =?us-ascii?Q?yrJMLlisDACUC1ijCfWuqB1Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08825aab-e381-40ed-7efe-08d9640b1d3c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:48:34.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmArBngEMf0uBmou0ulS9sWvR+tbsX5MByoDQW3wgLYRiZZi4PaiWRLy59Sw18kB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 19, 2021 at 09:36:17AM +0800, Wenpeng Liang wrote:
> Use the ida interface to replace hns' own bitmap interface. The previous
> ida patchset has replaced qp, cq, mr, pd, and xrcd. This ida patchset
> will replace the remaining uar and srq. Since then, all replacements
> have been completed.
> 
> Link to the previous ida patchset:
> https://patchwork.kernel.org/project/linux-rdma/cover/1623325814-55737-1-git-send-email-liweihang@huawei.com/
> 
> Yangyang Li (3):
>   RDMA/hns: Use IDA interface to manage uar index
>   RDMA/hns: Use IDA interface to manage srq index
>   RDMA/hns: Delete unused hns bitmap interface

It looks OK, but doesn't apply. Can you rebase it and resend? Looks
like it was based on the earlier hns patchset

Thanks,
Jason
