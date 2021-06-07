Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C331D39EA50
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 01:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGXrj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 19:47:39 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:12029
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230209AbhFGXri (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 19:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INK+0M3tM8IeQM7sGUjXXTJ3Zmqxt/7dt5IdhV60caxleqaUMqoypzMRl2sW6ldqyEM90FkQAmmJWuR6MQPfD83wZH2DrpXsk3SgreKJz2+LtgR1NIH7UbvLTKzQZ1xDx0eoDE5RvFkhTIbAfOfFNiDd1giXGNUepdzW10TuFHKc+wH2x8KfpeLyskX3QWPhT36gsa6QrhmzyDA75enKeYr7dBEI0xlXze5V2UVRvkQtUAZFHkR5xkjrWFsjGEln2h5ByJzSnRLSSlHb+Uaahydv1nlwUvLpiXx7bXT+GdizxEXseN6Vu6PGCZ930kT7CeUbEk1R1NyH2GROgM/f0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6IuvL1Ycc/tZhFCu8lRAEQcNkp7SfuohyYJvfHbCvU=;
 b=En5J2Zudw1BigTBGn8XSrtWaOMQOVFr9iPjaitLl6G91idjk7jYhJu7BrOa6B7XvcyYKuCq+zHf6Xgwq4rsFa+z8bMGMknCo9RxP2e13s6BmS0Aikw64IfxeJFay/hxBfSTaRenX7e4gPm+Yu1KWd++/bDG/1QF2rbfNAMQDrUHicBVFrq+MrHaIjvWBuv46+L0BW0IL28AIdLnHhAw4Wq3uGeC/vNaeAfolLW2Yv6+E+XckAFLYcPNnVzsics1QmQLmHx5bWucb17Sz0tQVes30sSjbb2yYm+klly42urJMAvccsleoVuje5T0mfs9ZJYRBSvcuVujmZhrz7BHkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6IuvL1Ycc/tZhFCu8lRAEQcNkp7SfuohyYJvfHbCvU=;
 b=V8S/gUU7ndASjA4N1OArY2sV1c3dU/TQg0y9yIUKp8BA8yKsb4U0bRhP71D/gPhOIPaXeHhmVZUMOV+Wa+8BaOoHtP3EOHu+/TOpAgmJ2Ly1iWwthaD7sv5PRLSfesnSg7nUrxdXsy0XkZ5V1B/JgxacUmSx73K/EjnGLkXuNdJ0mKzWYELkgz0o45JsmAKJaWwTcGWgdylwmjQruIjwOgBqw9PVNmDy/hTNpFJKqpsN7WkAqub1Z0JBbzdpj/hcT2SqmM5CwDguF/ZomDaRc/fxVxlqKnlPWQzUgd/k/tw6HEvuu8dlAVzXGWeeokHpREPxp1w74/vTQLNW+3bJrw==
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 23:45:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 23:45:44 +0000
Date:   Mon, 7 Jun 2021 20:45:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/irdma: Fix issues with u8 left shift operation
Message-ID: <20210607234542.GA840331@nvidia.com>
References: <20210605122059.25105-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605122059.25105-1-colin.king@canonical.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:c0::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:c0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Mon, 7 Jun 2021 23:45:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqOwA-003WcX-SP; Mon, 07 Jun 2021 20:45:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d71d5d-0d32-46e5-370a-08d92a0e5dc8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB534919DE86582674A756E000C2389@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhMgFBCwltfmuDZLv08UB5sYIdG2AXtelD8xUB4bAPV0FFGTh/R+VAWIPkYvStcJfBSTwNGawKF6ConDhZdJxMkZUGbd3TDZqACduyHXzuNuMTciArLx7JWXcay3PQJiSecY4o6ooiR6nVGN4BhFBIHXqfNuSHrw1s3ecRkqYrH3enwEsdtJWKbe0teuSjdxfn1iUTPadZYpB50+HG9V77TJnqn6Gj1zQPLwsKHKBKua6UhWm7751+kJKmbQQNLOEs69UUMKLuOErYTnAtZJP+WnThd+YCJsQZYrd0JJv7uIfQCJKt3nm5c04cIxcZciOtQs6lsKLPRzOotNZfleF6r2WQu4NsD5kWQRsUzT35LnT/MbZB5OD/lgF33nzLhIDeRuTx8mq9er945KKWBHbi3b97+J60zYWUZDzRppONEm4LdYDO/8/W+eNwo1hMyGqurqygNgUQhFi/D46jY9MJJLsSSzFRkgnUPxfofZfBG18x67I1wRJDOK44hdYhedqv65GH+pKxTzV7maf3mjz3ZHb7NK6aS3woat0V4tKwSP53WTWBeoVLlTnwreM1GN+ZqmTQqegyPAf0JD3a7+rhohDAsTJkLzMQQ+IIiaqBjqP/a6KHfSR3tWB1KjpBNUi/CCeavHCLCnvhOSk9kkazlIgEp4Yx8TGrcog6UFs98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(66946007)(426003)(54906003)(5660300002)(4326008)(38100700002)(186003)(83380400001)(9746002)(9786002)(6916009)(1076003)(4744005)(66476007)(8676002)(33656002)(2616005)(66556008)(36756003)(316002)(26005)(2906002)(8936002)(86362001)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vJI2+DtNRuuspGVv8z7Cf0KaV9uuG8UtwiKww757mOPW8CVxf1k0ThGs934q?=
 =?us-ascii?Q?nUpNgn8eXlVL+NMvA4BsHE0n/dpeqmL/ZAGEXEQ7boni7G9GCM4qzs4Kr736?=
 =?us-ascii?Q?FR7zZRQIBhHklBRwtnwYD8Fxjjb6QJW0mDcto+8+QvZDV6beb39sbQV8vIT4?=
 =?us-ascii?Q?Byc2/V+A0v4qgL2cck6hEfNEpBpSNTM/SotqyywkhTf++Hif9UKoXrRI2aBi?=
 =?us-ascii?Q?bF4e324+cVrDiOfZOjzCvRptO4bbrLuStUgNVtjtFAEq3jrUonGAcsjtNbWB?=
 =?us-ascii?Q?7uoVOMAMUO8elXpFOBrcQWndgm8ghnMcx1hyDC+DJCGtnDV898IrDaabcx7J?=
 =?us-ascii?Q?xSVvEYHiobxOu4UT/KZBpUFCfDXQzkNbb1Yvr9/2Lc4vFeat+97OU+lVtyz6?=
 =?us-ascii?Q?orNi9CDpWVdsSI8Q82l+YVhrTTFfzccr+bvb20CZuHBUYhgnuCoglhjcTrAZ?=
 =?us-ascii?Q?Go540QfMbCgdC5k+1MUr44ub9X6pDtKIHjJU6lPbyTjPaZoU7Kz5jJwVAbwF?=
 =?us-ascii?Q?C3APYbQEdZi2PdQ+A5LRL0AkgBbY/nBOhxGIbwfRqYdbMEn4wLiogcnF7GoJ?=
 =?us-ascii?Q?/dltMHYMOMjUmVE78WBM7zbTL1dJczez1nRvh9uT7mYc9/a7ExSzCsrwqp1g?=
 =?us-ascii?Q?hRxx+6iIPFKhLpaJ6ptM+S+A1PRqjOt/eNGhCNl+eCPm4WcTXLmuFVMABZBk?=
 =?us-ascii?Q?WZO0h5HxN+57nbwRaV7/DX2UKakTy8JPCbxHMxY9XcLVuLVZu6MzqbPUqFeN?=
 =?us-ascii?Q?NKNYBBKVZ9JnGmv8UbDwrMQEZe8qa1Vr5VIAfBDem8P7cS9KrAGVnf6iTGWT?=
 =?us-ascii?Q?132smxOd+sWLwEF7gWZH0c3QWql1TYg4gobNraiM2WQvTv2+h+qzUnfzDQg2?=
 =?us-ascii?Q?RPAQEc0f1KrfIs2Jr9dB9hW2okTRRPNYX4DrQOwHDHR6JU6jdE7cuqRXdEHz?=
 =?us-ascii?Q?JnCdyfSRG2t9VL2F03psuCNbAMitD/TO9y+u6pmNmRbmEFQYEckclcNYh2rv?=
 =?us-ascii?Q?Lzd50CZ0SlXhMNKE7YPF2WgpfgeLUF/pT9AkPWuHSY1XCNdGyrJSISYmL4Zt?=
 =?us-ascii?Q?oDG9SOK3r3qVFEjZWTAwIqiIgWzf8sRSQRobA+SRnFS9Hajm+W28l0Efzjn/?=
 =?us-ascii?Q?8h1V+sYjiZBmfTFLKqZg542/a3sfbHDl5p4+FkiHS7PWdljKPTImbwvnXg3t?=
 =?us-ascii?Q?KbCI2nbbUyBfO9ZWaQtVZkAeYE7oU8J9kmvV8ctT6ETYeUuCjP/2fJiy/G8p?=
 =?us-ascii?Q?EptvJtOv9mTp+HM4nF4bnBWGbvrk2CFsvmgz4tzIwoizOXZLDMMRWQSlENlE?=
 =?us-ascii?Q?2CM8WI8NqYU4la+0tnZkjUac?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d71d5d-0d32-46e5-370a-08d92a0e5dc8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 23:45:44.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKk6Ek4ylLJzD4VjTdALarf7N9fLD5WAkaRH+ynfd4+Vi1zY8ccsb899z3OXbH6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 05, 2021 at 01:20:59PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The shifting of the u8 integer info->map[i] the left will be promoted
> to a 32 bit signed int and then sign-extended to a u64. In the event
> that the top bit of the u8 is set then all then all the upper 32 bits
> of the u64 end up as also being set because of the sign-extension.
> Fix this by casting the u8 values to a u64 before the left shift. This
> 
> Addresses-Coverity: ("Unitentional integer overflow / bad shift operation")
> Fixes: 3f49d6842569 ("RDMA/irdma: Implement HW Admin Queue OPs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
