Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB6736600B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 21:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhDTTKY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 15:10:24 -0400
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:61679
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233725AbhDTTKX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 15:10:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpADGASy8sdf/zU9XhgHzV9XITqLWo2HGkQU3XU7DU/Jt/bg1513PCAGFadrEYwo7kiakuCgF11uKalTjEiQ+KIoQc+OLUluobMc5q7Uk2TtGOV5C2YxnTM3WivAAlR6/eCTzR/gbkNqWdRu0YV1LFfrU8KW+v2sSgjOuFAb3XZxxWPa/rZqEXzzVUlpyq1kbPdGn6w3fkIE4FgcUXjVsUuxSxn4u0VE5LWnTxNMfBSR3BRCIdbvhyM9404o3ozIsgZtA7R90QPTyuCGyK63rOlp/UKdbOldP35Q5KXEfe153CegMLWdyTp393Kv8EOe7gyYLnIKTrIInHapXpqOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw4H2Tn4AD2NIouYr9poiVPb43txrOSQ0KOJFP20k8g=;
 b=S7QI2wupWYutdkHzh+YJT/GWUnp4TGSFWNUh4DOy1y3W0j9iBy/LL8HhAA8CxtiV937vTRy42uyzF+RLbnkUwAXqbx5g0iJfLWLd48IH1geYo19CHthN2kAFHeZ9FPtwW77uUz+UgLc+u3QLzg9WJuRGS0yspkr0M8HlmbnqaU/8TdPEi2MRbtiMITehhOogYLRCdmgTsAKqKAq63+pChVZo46l10P8ik/m2m7Swk1/v2HPU5puh93x7bTWJQUYiIzP1f4u9t6LcHoiqVjB4NiDRbTUVeIiFhhDSo90x6GFjkbXftsaPN8SiD5NjuUUJSiUNRbVHzaxlsaD81VRfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw4H2Tn4AD2NIouYr9poiVPb43txrOSQ0KOJFP20k8g=;
 b=Yf4hp4EypKM2//5/AWv7oAyPvf172YgJq5vHxvfcZ2CTt2WXuRkpI2irehCPjJZAH3HRRNQdpDFHZAjLyNcD64efHJKmzBqtd1JeO3EpNrukwo6X1+oR2WJ701T4auEkPxt2eCVhpDwd807I5W1LBtWIe1k9xsYnB9LtjDq5ZiJtVet0ANznANjABJxsuMbMiLoY8NnLyHOZZC4EMle5nV/faqReI3RtrdlbAnF5jdhw3/SyRiASScZNqoSM0UDnBKRyRHbZPlZLgMh7TohCk6JG9o4H2p9USQVyIe7QlEKz/+TTLo5Rod/VMhFQDk3VaFaN7XbZ62JXdDArL53bgw==
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 20 Apr
 2021 19:09:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 19:09:51 +0000
Date:   Tue, 20 Apr 2021 16:09:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/cxgb4: add missing qpid increment
Message-ID: <20210420190949.GB2185150@nvidia.com>
References: <20210415151422.9139-1-bharat@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415151422.9139-1-bharat@chelsio.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:c0::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:c0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Tue, 20 Apr 2021 19:09:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYvkr-009ATr-A5; Tue, 20 Apr 2021 16:09:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13061c4a-9837-4ad1-b5a5-08d9042fdf6b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485AFF0A293128AC6CFDC03C2489@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7pWTRyJ4YKo46dIituJqoFiKEbSqggOxBZEIhwmO4G56WAZPJpRWfW6XyHYo2Em3Hfb6vRhHaQ54v37KgFF9twPwjF11kUL3tCNrPwWO8HRjNQ4xsTJnZcgJpnbbWPwW7Qs7LxH2NsKK/ECRIPAEOHQqqGzPow78v5oB3rZMH3SkjvOpWRplWvc5xXuDKk7XKbqzzr0QKdHJGQ+IqY3GwLK+vCGAy0JMpWXGWv6lZaHulm4cttXY9/g1MzLSwbP5MnnX0Uf13nl3oEtJ5KwCmZpMNlS2zRvHjsPkh3uMvvSRKHAVALfdqQj2q5oUdhbYtIu2lnWt09va7wP9XDDcYwhe72SRRkfhA074YHVr29LCmhdJANlQz/+5yrG2jnFDuTxAaW59NBZtvkX8DQDAJswqpQ6O7MaILMPjSyYFvjO0zTIxUBa+lIF+WvhCUNXcfVbQhWO7/rk/GzppILUVCvhjt1jH6ZeFP/fj0az4kVb5dJHgDokOEyRTgHLP2EGg/+KkKvhZoyY2kxxTwGB8odDUvDoZwz99CkmwftbSADt25y5F91fQWeVpnsmp13AR76btbaca67EoRORRuhNbGZdfSVxhKiL/Vy4+ECehHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(36756003)(66476007)(4744005)(1076003)(33656002)(38100700002)(6916009)(66556008)(86362001)(186003)(426003)(2906002)(9746002)(4326008)(478600001)(26005)(5660300002)(2616005)(316002)(83380400001)(66946007)(9786002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gZ2RascZzC/B7aTDq1TnRdNnAXn1FSvw1gKvSeRdUzpwsxRBaCvIlG7QguEW?=
 =?us-ascii?Q?cy7N9e+qy9bFPSXJbzuiTibe7+jdZXB08HbXj0FtGjjeot2Ag+eiXbk0++mW?=
 =?us-ascii?Q?xuRRyceyWerYX9Fj7ZimlOdo5ODSrk6VLxpZyyV35Yy1ojo068AG+vFH5w8s?=
 =?us-ascii?Q?FOT69k0wAEPmTHwq8Ujgui46j0erQGb/GCNp+RX5ZbfNjRRZAzq+ZnnWoEeF?=
 =?us-ascii?Q?OIs/uSmCLe7KO3bckXNlaTuldcLwwnxE/LhgBVCFaoqAprcOW5muaSQnJoMZ?=
 =?us-ascii?Q?t0ZguLRy4IAvqMTCP3ViBypW1z6qv/y1yYsaAqJU4DTqXNxSaD337FMEifPL?=
 =?us-ascii?Q?jaJUJgx8iDb40TjbVQg1O+EVCi4kna1bML+H7VrF0mSJ1o2EWhLibjkvBhth?=
 =?us-ascii?Q?+0+mxKKfeC+m/eIS5RfigYhtd9ltWnPJ+8AkAs58Fkt8SdM1A7pmLP+VwNBY?=
 =?us-ascii?Q?PF8ziqARwuF714PQRnHEuxRqXP6Y3OtOZFb7dEl60uIi7dB4GPcYsAf4a7Jd?=
 =?us-ascii?Q?wJG1QLANnVmHBsJSgmzqgODxYX1lBGoAYqDMvARWAXVXz8SYArTMGcjYl5z4?=
 =?us-ascii?Q?bwVx+3Yy6ytr2nsDIjpJ1rlXFe5IyUmuH5NELye/Fbc9Jr8q4xRCH/QsTh1Z?=
 =?us-ascii?Q?cR6XI9AqTKjrqJEH0JavoYhLXi4yX3a0crViDux8AeWWXa8lXC1wH1eMw+TQ?=
 =?us-ascii?Q?KDQEKkbmq+X9PxJvrI9goVQ61FxsIr9e7vbnakLCjabJK+eZUuclYI/yg+P/?=
 =?us-ascii?Q?lwpg8ncOA6OWCvUVM786aZwRXtj08+G5NLCj0nJI2pwcUWp5u76dzNLV+b6Y?=
 =?us-ascii?Q?KSwfyIEJCcZOJCAZTVMxUCZXywZFHWUKp/WMfLbmEpIg3B4ZKBdSJ6trQLIB?=
 =?us-ascii?Q?1Q/yUDJGWhcggPNOkfZg2bcvjWJGeNvMggafAYjqYM9VLw/hCBjse9YfrfP7?=
 =?us-ascii?Q?XwPCAbxNKa2PGhXhwcCwI0ZAJPzTSWTF0Nxl8gy4nOKa7ky2y57K4qvWJxaQ?=
 =?us-ascii?Q?ck2xp/n2ospE3qT5Rhwi5LLzQFMLH52ccUId8G+bfhgkIBk9YE7OjnVxp+7T?=
 =?us-ascii?Q?roMMmon9pkEFIKDTRCSSkeNqNsqNYSgV6tBUFhvAXN6lvSqQZtUATBbdaEgd?=
 =?us-ascii?Q?gsmyLQbIEX2Xs4fJcnAQ1nxyXvmVFy1ljT0r+0fP00WelvohVcWNAa4mlEh3?=
 =?us-ascii?Q?SgyKlwuyOd+F24vTmY33IoCuSzOMRXgWAwxwxMCqhTSCFNJScP+eyiwxvSub?=
 =?us-ascii?Q?iSCXRvatpTjdfFV15ICxhoAiZNsNjjOdba9hwMmlwmL5ut5cfK0Aw7IhcIC0?=
 =?us-ascii?Q?dmGTepRwS8xDyxXzz7rosq2MnnDktkRs20xcpuhtbzQu+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13061c4a-9837-4ad1-b5a5-08d9042fdf6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 19:09:51.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dwCLBL1lKmj18Wmemuvkfo5XApqfw/w2V6sjnON8CJkfMNgsrrBT4joSHXlVJHz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 15, 2021 at 08:44:22PM +0530, Potnuri Bharat Teja wrote:
> missing qpid increment leads to skipping few qpids while allocating QP.
> This eventually leads to adapter running out of qpids after establishing
> fewer connections than it actually supports.
> Current patch increments the qpid correctly.
> 
> Fixes: cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
