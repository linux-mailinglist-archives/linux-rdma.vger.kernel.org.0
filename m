Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4642B3ABF10
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 00:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhFQWnx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 18:43:53 -0400
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:39872
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230393AbhFQWnw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 18:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMKd6GsMYwXWIpVOhVVi81h/o8or1/WJHbdwVFFwnAp9zJrk3sLEoWiFXL4FwyMXQgNfQ657v4sYnMWq/xjwWete2qs4Rm66KyOpjZ8s6lAV2BOL4vE+nSrBIAlYHRTYBWomImw71v0ifjGeLTQzBlxuAsOMYNCLzSrRUwR6OijpC99ApF+BK7BlodT973ZDUodXA+J7jmXtXkT54nJJ+7KUK8+CmviphVUZ/mGT62zC8RQtOhQo/Zx0+VKV9OrEqI0Ll+vgkl6MDeWX5dGvZ4RG/MOATmYicUrZv9yuYFPVoJvyJNsFj2JaY/1c2ChyhN2AO/aP0CVkpyHPQDkYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yiPI6eZgyt1NgEGAFk+UyMcJbtJClY9qKjDHyi0WfA=;
 b=cwuTVZG48zNLywqKfjZaU6PAeRqHb0agZJIiERVmCsaF5xKcvRcrGErc8ga9hPf0ie3HHNNj5B4GJ/s2W8+vFSEuDpx+rdB2R8+6R5rL6KzcZsizEDjnD3cOfdsbnY67kNBdbJxY8TOyrtKuXnD2laJVq3HlXnxolsj4NzvmCJ8QnoK/DSshbyMk8IBDhysnRqnK5M+jsHt1yX+wgR+a0787QKtPRP1FLiqjZlEU+28w/O4GUvi/KCmTyRk6p7CGgAEN8Y14qb5sPVGjqRef9gSe+MrhWIRrMVjJGmj6Ti+YqLCxKliEg8N4j2pBG1kJHeXMNr7Hx81j6obIkB9RvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yiPI6eZgyt1NgEGAFk+UyMcJbtJClY9qKjDHyi0WfA=;
 b=QTNZAnOkv3meXbsvSo0HXYPpwx10SNyq+g7/780Jri5E+ag4tjPaDiuQip0Cp48DLF8xei5VnbWKDV5M+B5lzTnvWq3VIG4DasoqBqldLr6MzEJRxtuB68L09GJw0GoXfAXjgpsTYv2SCSzx1j9sJnqJToSMRnB5rsaDiEXx8cHDsnz34OkWAhfBlyNoDDcctGpy1PAq0oGqWEUaWGKBNmDnLw2qg6wLR5AdOLIsLLxeWl4WSUSQu1fQqFTKvcP7MR1AQ9hMBaSAH0JgZU2CoViYKOaIQfiQg35OYj7jxRcFCTMem211sZ3Oxkw+XQBlvinxaLSnpdyTZM8XGEKZzQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 22:41:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 22:41:43 +0000
Date:   Thu, 17 Jun 2021 19:41:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH v3 for-next 1/8] RDMA/hns: Use temporary variables to fix
 warning about hr_reg_write()
Message-ID: <20210617224142.GU1002214@nvidia.com>
References: <1623915111-43630-1-git-send-email-liweihang@huawei.com>
 <1623915111-43630-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623915111-43630-2-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR20CA0059.namprd20.prod.outlook.com
 (2603:10b6:208:235::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR20CA0059.namprd20.prod.outlook.com (2603:10b6:208:235::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 22:41:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lu0hi-008JGG-1d; Thu, 17 Jun 2021 19:41:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1afff465-2d38-472b-a4b7-08d931e11475
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55059B473A9219E7AF8CDFEEC20E9@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: He7V2qLUaccj0hNN+UTjNyRTPqzMf26lbb19ay7ANCftmaKzwkCKlTUVDqoN9MBd3U4yr8Xcfct+2Lq2vy4TrAGypvQCxnCHvdlGZh/4qwRb0ci0v3Sj4D056gLN9eC0LNxgDE4LklGscFDkboH0wGj45V84IYmc2HU6JT+Xi+fMaMCP1RmIDoinVbi4uia9s055YrnKkLUW/LX18moSefPaLOEMl8sOtnwdRyxy2j1if2cy/hIMD1pz6zS881LDv4DRGd3G+Ax775l9GYQsInLuYF/xsXtYiB1ikx19cXqU0Q6kPnBHKzObRw/7w6X3j/s+3a6jNIUo90B5TDdi2k5YTtc2NXzeYKKp6zfZbrUskBXI/zRfdsorjlou++SOjRgSHaRoHPnRjJmONjFjPwYOvY4kN2kVRwR3V2ScwQouHWbVBddBvAOndUGwEZe0NBNXLwdLtca9MJx6MfksKz4mgkRE1t9iXl0KAMtNH/e4NZzj4YCwBkrLYCaOWpbNDfHZ1gdPf0sMhmAY3qxadXZVijXw8uWKaue/Dm/hyVKh9KbyXwW2d5oTyjGwS+N883fUU3yJgAyl2t6N3bSds1qokmSUtfrD2ELTmiQWeji69dl0DOFF3WvggY0+erurKP4akXxDAT6w/RB5rjEQ7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(5660300002)(8936002)(86362001)(8676002)(26005)(2616005)(478600001)(9746002)(9786002)(1076003)(4326008)(66556008)(33656002)(36756003)(4744005)(2906002)(6916009)(66946007)(186003)(426003)(38100700002)(66476007)(316002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ynnBIanzQXLmvOiCKb+E5DH7509rzqrsnWRGni8uuvVzLOz8u/3tJIP1sI/?=
 =?us-ascii?Q?wJ0Yf6Ynf5/cpBYMgHGKjRk2rGiCJoX6cxwqgiME1jlID/rcNXvrZRirv7ri?=
 =?us-ascii?Q?DRlD4evVARzD0BrLU0D4WpQeEIDOaLYTomxn7g8KvcqKNyfvgLO2gCFFA0Sb?=
 =?us-ascii?Q?ZdKCfLvcc0xarRPQk7YKukW/2SFHqukVoRrpQBwz2FxTNY025Wxhz3WtOOF0?=
 =?us-ascii?Q?JfR8dfjK8fgI9lmngguTz1Z2cpjo3VnL+YiK8Q3O5YzcpABbMBEhQjvctls1?=
 =?us-ascii?Q?d2DgG/vkhiHvVtAlDCfVRgx7JzBZbz7JeXo5k7cKO+MRh1KFdSeGtyRONIB4?=
 =?us-ascii?Q?cPk12n5VVdO7sQ+5XDT0ginz2RzC4bb5/oN0eRAhFPLVFUcn1H4g+HVWCMfZ?=
 =?us-ascii?Q?U+9wQgxGEzeCJseEXNxxu7eZoueeLObgA2YJTi3pqawAMuBx+K28sIWA3cA7?=
 =?us-ascii?Q?6MDk/6xdH42/fqQPaviHsJUb0ZSNB1f1Wvz+vVMhCFo7ulahqrxfRC/Edrrj?=
 =?us-ascii?Q?9zRkkzs4Rm7LtcABZnMJpe2+sauCbomU15s2zCKyAdtgaRtAEqjcGGiIwbNg?=
 =?us-ascii?Q?fHy5Ku4FNZdbMwN7gLdPCW5lMOyos5n8iamr1r1W+b5uCU1v/WkyhL8hXr8Y?=
 =?us-ascii?Q?suZeUyHrIti4tRpjx8SYwelU/wE/vqwvhs0OTfxiGMMc581jXW4bK61df4gt?=
 =?us-ascii?Q?HxJc794fgsakC6E8oSw6dAOzp5UU2W+OW5H3npAGLeVh821zS1oaqze9FFHK?=
 =?us-ascii?Q?ArtQnmK4CZZ6tkg3PUMyAfsvcsEQIarGE9oFI5lgGjg2A85inJmPIDD5L9md?=
 =?us-ascii?Q?BDsWCFPW6LjiCnUbeyWbPvQ3NCvghk0VcNMPpZlY1+8+IIYPOsjk69BwZMaf?=
 =?us-ascii?Q?jCHssjG+GbyzD32cVqCgH4+vkfCkrNzq3ExOpFcCw0PXZCXfeZ+d5pjKxOg5?=
 =?us-ascii?Q?QRWST21Fip3KFiy9Fdiq+NqEeLwfDrCxe+/58n2SGZsx8b5kybtW+a8rxtU7?=
 =?us-ascii?Q?HsKwMoOggQhR1HM4aAn72zxqBRBDP0eljJ76i+SA94arhJLpNUDQJyPAJT1+?=
 =?us-ascii?Q?bfpXG8UDNByIdcVhsAI4Uda0ZQI6c3HaXlP8hx50Gvf2R/RzKzIr6gRWJdcB?=
 =?us-ascii?Q?7OtffajYRwCXudHFaEghN8PpndYjwBBC/Yp9ZqhcXL9ly/w5vQK/8VF86prD?=
 =?us-ascii?Q?O1tbpu9ZUEed4+atGSpJCwEnfuBj8ZdvsAOG0J/Ka9KETm/qY/jd8iJ/KWCt?=
 =?us-ascii?Q?+PlxDDzH4NzHVnCUcU6X49ZLY1A0OZdnsGu2V5BS79g0qouQSMn/WaBraSkw?=
 =?us-ascii?Q?7CI/DPCRSIGXkKnscvX6Mqq4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afff465-2d38-472b-a4b7-08d931e11475
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 22:41:43.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px2LRkqC7A4zQj4XmqwQMp+9b39nCDwrE9DAkKLeTLpXQ44J5RHpVkiChaqrn06z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 03:31:44PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Fix complains from sparse about "dubious: x & !y" when calling
> hr_reg_write(ctx, field, !!val).

Where is this from?

I'm not convinced you should have the temporary here given how much
magics are involved in this stuff that rely on builtin_constant_p

Jason
