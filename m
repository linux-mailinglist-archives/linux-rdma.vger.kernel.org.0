Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207D233824C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 01:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhCLAaX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 19:30:23 -0500
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:24545
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230521AbhCLA3x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 19:29:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpWQtYR/Y7QqfGAj/ZR4l+t9rnyZKNxUJWgyjl94bWIn75FS5xxoIA+uFb5bYeEdzNBpAa0xibfC0P2jz4rUU2/dm6aFrwq+20SskCfeQAv7MuFHbHc5A+wEgfVev65HvU2jbtmETcDnBJI07HP4EeZ129zFZVMFDZzXw9kyt/xomQidaBbgrOFLMJxnHBipwol/hE0TUR2+4GySbsvaVG+HRELFE1uULg+u1R5ALrMXwOBuEz+YcljJD8dQuSJmqdfA62tFTz1FvyMqtd2UFtO+s44oPmQj4msllytQ89au9N3ZCFoplw/bxvWxZfaniB2eiH9QKSah9ploYtE5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meDvWi/58bQRC89kDtyW+VYR05H4ruwmeV2a9Vpugl8=;
 b=DIvJpb1cCJWWVj4JOIoiKthKB7liY8vCahtAif7ER1GUmN1taP5hqJFfvpBYO7tRCRhAOUx6d8IK/CE3S1t8/aMgUdCinXCJ8qk1cDkWZf7szfzFi6BFKbLBclhRemSRuZdDXGEZQvflP8kKlksqzU8MTtXd+AvIe2jJxtMUvm3tzK4ysG8/0XlVXAdLfSV/ZHLIN0DzjdOs6yDGYCyheT5+ZwdKH66G6AET723chOuLekCKoUDyXJN8uOyn94jho7db6MPx6b9BkS43yyVYEsHexGVO5UYaBpzF+ALQSaoxsIDji5NJs76ydkxbiTK3Owy/mhbj+bXmhmg4RyZcOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meDvWi/58bQRC89kDtyW+VYR05H4ruwmeV2a9Vpugl8=;
 b=Q0UFZcaU2/T66cDP/O8IY9YOXW2aSCxVNJq0kkMYaRI+WBnhiQGI1E6fzu0OxOaICmgKAqc6QL2NNbBrZTM6QHKladgjJ8zqFMeZzLrWbai+y7+VLRrgD87qJ0yv4/g4wFj3Mj5tFpJDsk2V8FL1tpL7J8srVa/UBjBZAVhmi7tWqs6TYme8VIrTi7zsKeBHdMJv7QBWiww1qQPJaPmeClshJqf4y6sn0BPT+T2GfdLq4QqcT4Y2ZtoKrem9tFZcGfqKmL/nwQXzuyiP2oy3Tyzbk69+JxGWykFpaiCmw2FS1D4s6OXvX75TSnoE4siWoIg/fmO1IQ8PEXzwV/w6TA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3301.namprd12.prod.outlook.com (2603:10b6:a03:130::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 00:29:51 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3912.028; Fri, 12 Mar 2021
 00:29:51 +0000
Date:   Thu, 11 Mar 2021 20:29:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/4] Clean the mlx5 MR deregistration logic
Message-ID: <20210312002949.GA2787233@nvidia.com>
References: <20210304120745.1090751-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304120745.1090751-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0298.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::33) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Fri, 12 Mar 2021 00:29:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKVgb-00Bh7C-GL; Thu, 11 Mar 2021 20:29:49 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f6d079e-157c-4d18-5618-08d8e4edf351
X-MS-TrafficTypeDiagnostic: BYAPR12MB3301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB330122055742D73EF01A43D8C26F9@BYAPR12MB3301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1lNZcPsgl9Ri9JZB1DvguvrFqg/DU+YgvEMsrTl+2HRDfaRnRTj/ZJJiLSMt0n3Qj2hQQV9lqNt8AWfvNKfHMN0J4rDrH4ARc5v2wy7QPDmV4/N/g4C6OldTV1PGXmtdQ48ndKf6n0tM9ugXWMfHLiWQdTU7Wesb5JSYdmfngAXJKkJhSUYKeNbO7O3YBxvweyrUR/A+snm3pyXvcTqthxkzaG699jobZLBWoBh72YzPfzu4fgsZug5hqCNsakvjzguUhukBDjgFLyCcsqJLq2HYlv1NQidTcTy8q7dpHXF3rCigtMTnC6a8gBar1QLbVti2HBpUPGRQVyvPatSAdAlhAIAWEaEJjMtYLUf1g9SBYl0xIk159sJKjyS7BYv4+gsRpzYUzXyoMhArK38oOS85759QR1b7Qwq9pMwtT30yQKspf/tJrHOEpM8Fv2xnYgQjWYZ5gV/58CdotkUGb+CrGb/rztnoKYJd4DtoIGO5rPlE1TZlRLUYKIFp9e8BoCPf75CvPBetMJOmz88XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(83380400001)(186003)(478600001)(2616005)(4744005)(8936002)(426003)(316002)(1076003)(54906003)(6916009)(86362001)(5660300002)(26005)(66946007)(9786002)(66476007)(66556008)(4326008)(2906002)(8676002)(36756003)(33656002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bLCCJJiTRcbWP/Eet5yQF6eVIVpCOj6iswLKzOrz1pCTgNPeexvbd9d448eN?=
 =?us-ascii?Q?0/52wKGYuEoD/+xVbLT9amvKGfA9MKJZZSsd2oGTxespEMglktIreHkG8UMP?=
 =?us-ascii?Q?vUpZ8U3fu9pahwip1g5iR/0EvlPWw05L1Wg7NPyBWMEQyKrROTRONl8GUiKd?=
 =?us-ascii?Q?xZ5Vfxg/8dUHl/Ll5xWIUIA2Lh1629esqim3kBXsF5SnNjBvLBj7KGsNf6yT?=
 =?us-ascii?Q?5t3ceFeB7r9xTvJPreshWcfRNxsLdfSAjaUQuTSCHazbSpwVV7lI4iG2gc3L?=
 =?us-ascii?Q?P5pHSNH332au9ZabtSPBnUR855x89rAulY68xQjvyK72W6YUs0QV4fraY8/D?=
 =?us-ascii?Q?WP0F09DwyRPXRacDgbL0MWGBp1H7fPxfc+s7olcfwZiLvij7BXcSUcDIJc7w?=
 =?us-ascii?Q?jeGrS9t9CSk6KHnlPuLlm97zSISn5OiMoUxucX2c36tomKt6oBX72LuJqXLJ?=
 =?us-ascii?Q?mX5FzGmnQwMvaPOSKet4uKREzHwNlmirc7s9ixQk4r2z5PJQEDf/B7H8DiPo?=
 =?us-ascii?Q?QKrsIFfWjDDVS/cCJ3fyUHZ4U9uxpV5xLxk+F4Zoa9UYmdEr7bKetJSm/fPM?=
 =?us-ascii?Q?XYMj0RUxnr7kz6SX65oRdH1mongtpbY9NMM4hqRAQv+nRDsw/ymccQFBOckZ?=
 =?us-ascii?Q?Q8i5D5Qqevt/k6tiegTuqRqPQ4tTJun4By2hwrRFB0aMoBLkQy6311vAC98a?=
 =?us-ascii?Q?2mSkNTWCCiLCjojYyt5et0KgwnzRmhnY/4mGGtKBnmxFVh03MjwQos551qTE?=
 =?us-ascii?Q?AL+9l9z61FH3Zy51vjuIF6+GhGwPD+0LMh9/MKXGSI8FuWf7oDNwb6nddODd?=
 =?us-ascii?Q?UiDAGWBy2IjUMg83Onj8I5OYn8hwqN4r0RYob6S1qM+RGmlA74eh5Dj5u4NX?=
 =?us-ascii?Q?a5ZmgyF9WvHNQvB1i7Y1isZaWrRdAksFFU5HyXPfUaJY2kLpVRGoo6rFuZTT?=
 =?us-ascii?Q?hvRdC42mbHMkD3VGfuXhcAJsF8La/bccBmUy42ioAeff6FSRDegzyZy61dvd?=
 =?us-ascii?Q?2+BDi7FjYcG55Me92I/8/UoqR5lN1OdW8CxlGTs269SWbCbgT9eebbhWz6h3?=
 =?us-ascii?Q?OAKx6x6xmiCrHGmDxZXbvwMy1blYkgaH6xABqi1JaI3Z8YSJdzaTgnBiCzgF?=
 =?us-ascii?Q?NicwryUh3O86av60rgbFohNcffmuE82h2MrC7PrAhFqVo8ixQxHJEqyliK6+?=
 =?us-ascii?Q?oKPYE6UJ+SHHh7NaLobIISPrwGzoeEpcYrEOxjhB4n6a21LaZEE7a3ZFGGa4?=
 =?us-ascii?Q?nYRQtvgTJdJN5plaUF2g2b+lxCQQrNeMprTTnQphjwl4blfBRlI/bUX7M/Jv?=
 =?us-ascii?Q?Ur6LbKBA3kg+AzkvRJvK1NxlTqkmf87VBG44TBu+Gy3uqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6d079e-157c-4d18-5618-08d8e4edf351
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 00:29:51.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uRTLWMW4ojjGeocbss7KYvpxJxmABjrUNWwuoaY3MSz9k1AOlz1ozAY414YYrbF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 04, 2021 at 02:07:41PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> The following patchset is a cleanup of mlx5_ib_mr dereg logic.
> 
> Thanks
> 
> Jason Gunthorpe (4):
>   RDMA/mlx5: Zero out ODP related items in the mlx5_ib_mr
>   RDMA/mlx5: Use a union inside mlx5_ib_mr
>   RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()
>   RDMA/mlx5: Rename mlx5_mr_cache_invalidate() to revoke_mr()

Applied to for-next

Jason
