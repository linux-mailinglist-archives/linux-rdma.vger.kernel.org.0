Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7F38B345
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhETPbl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 11:31:41 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:33192
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233010AbhETPbj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 11:31:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgvtPguKK06l9rDeaPefyvrJtc9rdEjJank9unWjwfk+K7zPLiKXZrHuogcMN90b0ayEa56lmtakSTZpJ9RMH8jDR5aPpkKamj8EJnQ0ToPAW1CC1EbmP3+m+Lqje0OnX8weTDFNI2unl/PIlCOUk/vxdbIDFauChiVOeSyk+cQlgdZr3gC1xi1glL9PKQkqYJjEyHOrQdrMpkYlE8mhYybOvqjZEz/rcqO84mcCuWZybP8jT2QUUG39niEBbfDRzxkjqsB/b53+Xh2XO0s/9oqc3FJKFvI2Z4XP/O97eHDWgvupI5+uqy1VCFwqzliMpdffWCLlV+EcXnc/W1T/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jlvdn3MJWaoLyN0FtvoHf9eS2sjNGQofEHd5LZaB++Q=;
 b=J48+5PlVfnazu78+lFEW+FC2eTQ0VbmYSGXKo1sa6E0YehR2Ey1UsrokyTlERJXx7LmHrtdRCC+qswmq+ZWb89mIRZcmrMz3Ecw6LHm0bTPAopEWSvGXFiVBVFb6xR7bv/xazSaimlAqZ224F/ghaFh6hz/fSf6glRt4TZccW7nznMeWphhl1YHYs5G5DIgH9fssnL2qOXaJ6leXXdBGGiDjPAO8+Drj1UdNhtrYvzHge8BQT/H79pksR4T1EoG7BLqvnFowAVNv51hFSr8GgczlIDbKhZyz12LT+DL+Y+4lewdUini3Db9Ywd2L+t7tVJGMeNtC4oS8f1n2C+ShQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jlvdn3MJWaoLyN0FtvoHf9eS2sjNGQofEHd5LZaB++Q=;
 b=WU0/m5FtHAcjbTBXSpNEKmbSurQr0oDoDAImGNmIt86Ocba/6IvKjdXs0RHB2m5yRDGsRByHndpezsHgW0dD79wg9Pqlu9nQUcnW+QpUCH3bnVwMPZkBYRlAioev/M+2xj6c4J0+8u6JzCV1fpGyZH/8KccT+T89SsgM7Tk45VV62ronxcUXYF4U4UtP4rVU/kIoHWLmrRwngpimECW4lPhYeHsrGOEQ0KzaCj6wZV1jgirkV0ZgwzbNwxB08+thSHEN4C8cc7juv3cYj+LuHcwMrjTXH7GzxWSJTK1CK7sYwiblZUfIL5BzncoVld6MKzb9+FAUIwemLZHHNNmIxg==
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 15:30:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:30:16 +0000
Date:   Thu, 20 May 2021 12:30:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] IB/hfi1: Remove the repeated declaration
Message-ID: <20210520153014.GA2748036@nvidia.com>
References: <1621417415-3772-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621417415-3772-1-git-send-email-zhangshaokun@hisilicon.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:208:236::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0055.namprd05.prod.outlook.com (2603:10b6:208:236::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Thu, 20 May 2021 15:30:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljkco-00BWxI-Ro; Thu, 20 May 2021 12:30:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0c83a5f-fb76-469e-dea6-08d91ba42afc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB440233576D97E2F8830FC281C22A9@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYBKIApM9D29CFWpU+37F0SK9lMaGlJMdN8e/nQPxTUfCPmAfH165CpJ8ejvMPD4kKdbeo0EIrRmpY93p9ORTuVqeFJace9c5ec7LSce2IdlWm2roKNn+TSJeT+vsdLrYCbV+iy8MIFi2SuolnUjS94MYlFJSDv/6DSHS6fMuQDtzwkoGXOGR67mkQRGDSsmSfvaYe6enbHTpFIe0tGg0z6hiFMeokO583A+UaP5J43Ui6eZoj4GdIhpG74V1kgoSxIdcpiScRPfH7YdFtcWkSPp82ltosCYw1nogoYPkl1+x1MaLv7F5eV7qzmIVauUTia6lFIqxY28T4Zi95UYe+D0/wM7ymaiVH7guFABWTmGpj1BcyCKAD+KX6uYivJw5mV2GMHU94rg72tVZ0zjBn+yRnm1LackuvgXff4bUGXrUe3tNkXi1WK25/ua7qhUdVqbdq6gXMWeqcByxo7Y3anwMb3MlF8Q0nd1QWnHui2gedCEKWXihvpiPR9RbmmGVNTItE+jWNUXgAHUMqtEvkSkPK9EgQ596PzFDfBL8WCCwZAkJRbm2S2lC75QCLP9pAl5agWTuxk6V7zEyVHJM46xnRwPOgDN/hy+XW5SwEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(86362001)(8936002)(83380400001)(4326008)(33656002)(186003)(9786002)(54906003)(8676002)(426003)(316002)(9746002)(6916009)(4744005)(478600001)(66946007)(66556008)(66476007)(2906002)(38100700002)(26005)(36756003)(5660300002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bKCNXmR6jdM2Zff+LilRdS5rMlWjqiY6eZg51f2GG08NtRbtqcOrYhvJEEO8?=
 =?us-ascii?Q?jkIw4Fg183ot2EoZSjOXO7qJEy/orjfSp2enzsXNxEILZGU0H65mw8VdEaM8?=
 =?us-ascii?Q?2le1SvRUHIoXIiUs0O/wa0nsaVdbOrEXlBauRKr1loJJcUU2vcSzeLCVJlHk?=
 =?us-ascii?Q?um2Wh2RGVkjIIclosW69v3GaGR6XxSrZ29qQTqinXEGBJ9q1hnm6FMXz+v2w?=
 =?us-ascii?Q?aEgTybwFYMauVPBS/ckva7xGRZp84b3mUK3KLPxKFrNxz1XZM2qEuQpr8m0m?=
 =?us-ascii?Q?HropX50f0VPqrdpZGCdNSTILaCrC6WkscwsRkUI0IHmVNrvWi3AEzW8WRKFX?=
 =?us-ascii?Q?Y8vgwZlUVS9cHbe2cDq9pgz38TgmADxzoPSL6MfmN0MDTclraH0OrIqfJjv1?=
 =?us-ascii?Q?wMNEKFOBPQOnc8xhjn3b6ahDuxGUmKyQT+LxOoSgI+8FE0wbae8GAYb6NUMQ?=
 =?us-ascii?Q?eGlvxMjZMs3Cbb4dFkib6aNvcAIETP/2E66H5PCXTCV4IqkGQDSxpRKcC6R8?=
 =?us-ascii?Q?QQ9TlJfM+stjj7lkPwUhhzrWS8jfluOxkzMEnjsAPVYWIX0YIRjxM92XEZOA?=
 =?us-ascii?Q?8id+LGOJYe3ZjZIu7ny5IATBhiqrG/D4yFwjZNCi8yBGAjtOPq7l0MJmKby3?=
 =?us-ascii?Q?vdeYnPd6dTnRe4cMiz1brK7Ub6koKzt/Guo9J2EL4CJTdDgqe0Kt4TFgATtY?=
 =?us-ascii?Q?wSe4gGbzzzBN8unjayHHzLfE3LPQEUK/djoHnmUVvg6Z+Obb9POXzVKl23sd?=
 =?us-ascii?Q?wJeMCjIGp3O1b6Eu8/iag9sg4WcyzeyW8Un4ApndN4w8fj9HN+bx4zbl87MU?=
 =?us-ascii?Q?C+pxpYmR8mH0neZtS6exZbr9PZCc+hOxDC7lQLsbonibRPgPNSw5eXNuyCa8?=
 =?us-ascii?Q?Qot92mI8VKgB50FURGn0+HRnPPeUjYATVlu8mQ7P0S2kNEgfTEHZDQ03e5sK?=
 =?us-ascii?Q?zZzSCzje1c3BngnOFGtimVfSzpNu8cWtryrRte+rTbvw9ntX1n1cT4cH4Xku?=
 =?us-ascii?Q?XhHojPeTLvHDqmWhsffUd5mNplPyQhF2wmYI19XOuPI4Ssc+rMWFkHYETMHS?=
 =?us-ascii?Q?NfogNYFu1KN+w4U14AoQFz5jd7ImcYDC0FtLNwUfw0zfVwPf5iEUsm1AP87a?=
 =?us-ascii?Q?XCxf7Re9PIpsXFy1/k6/8iXP3b2Jptlq7+YY5UdtqD/CNDlPFS14Ss6Y5Jsy?=
 =?us-ascii?Q?UhwMUE6vqFVHah21ZJf0pwU4H7j/hChbBqld43hRRGkYTWYKw2kQQczstmdo?=
 =?us-ascii?Q?hIty/wl0BjJ7h+A8nBOQfH61XEh/xLAyu7SqeYydgJ20t/i2mVnLMTsNTsx1?=
 =?us-ascii?Q?H8HYpeFLSmazNII6gisua/VP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c83a5f-fb76-469e-dea6-08d91ba42afc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:30:16.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oihyi7fj5I5MynI3wDaDPG73IBimcBcEEgRKDELHssvPnOAZt9GSjqGr4dV9lXLy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 05:43:35PM +0800, Shaokun Zhang wrote:
> Function 'init_credit_return' and 'sc_return_credits' are declared
> twice, remove the repeated declaration.
> 
> Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/infiniband/hw/hfi1/pio.h | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
