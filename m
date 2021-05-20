Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3038B266
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbhETPDm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 11:03:42 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:22689
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239668AbhETPDm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 11:03:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECFDwNM9GWe1Q0Wb/wyqqmaShX8oeReZsIDfK/1vnFHMg+yL+Om2h9eCUBjwct3V7XcTLld5rdnRDKzTK556QIL5Q+c/G1aylEd0mr+maZZ4wO4vR8giqE2GSMFxIy+mRS+X3sFmyli2lgZy/2D9PEoS3zeDHlbbGr8HlvhRnjWHonglB++zQ9o28xQ913QQoryFJLEWZc+qhEURJvswJ1Ud0TAOorTsiMV4o3mzfbsdSOTJThSx45lwQUbnqyh4Fd+D5VdXgMBzIp7SOquryNp35Yh8j35DWKJjv4X05IPut8jSxp/qyaUB0KOTQKgSuQukg27JU13YEqISGsshrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1E3sGntiEkycDtcrsFyZ18mRSIsa7/tmrp68L2uKec=;
 b=Bif2RkpfmhtCuzj8DeYt5ClQNLTFJSkCm+XABIrAzhzyGalZXJDsUPipauDpE+/l7rHjB9/muz2UeJk+sYS6RJAoUWk4EGJ09iOWJKKiP8ECQ6azcaZj4QX8PCjCmIPn39vCGaMGKr5q+5vow3cc+rPLfkWRGrFghst6wVTyuWAMUxUsw5/AokDZ7ihPdxq6VlBs0kEt2Bk8GqAq886hJKIVm18KU3ufBttP0X33tV7KxyaX8FX9bsbnCLoc/NNKAo0Ynf8hsAw9c+rajwreFM9hL92RjnwoiqEgPgUKTHGU1sTEq76g4KVLF6dq5lq6k4DZk/abs69o5XSNw21FCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1E3sGntiEkycDtcrsFyZ18mRSIsa7/tmrp68L2uKec=;
 b=iEv6svpEfad1OwGhB19ycsFQ3SbJZxrb2ajt9ZyodT6eHpgXoYFeeOEuN9wRBRqvtCSTWpUskVdSZUBydqu1AUBovKTPWHoly+6yA9DFEuC8QL5D7U6q7KwhhRuTkK5HXLOPetnrFsTuUehpAaXtjls4qJLjCvk2jotnpMR+mqI3CbeEd5qgiMV6WpLOSzv+C6QX0aL0oiyCXxUkuZzIRoowrbRdYY7nL0tjbOk+lu/1XhxOChdVaq9JZkTXnfseqjj54Nt7s8S7Y9j1RdpVayDZC6WKOR9K9uuuhg+bmUnWeS+emdPmmItOru7/JPZSX0qbcPnTFIxQYXX2qr5gHA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Thu, 20 May 2021 15:02:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:02:18 +0000
Date:   Thu, 20 May 2021 12:02:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA: Remove unused parameter udata
Message-ID: <20210520150216.GB2734122@nvidia.com>
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Thu, 20 May 2021 15:02:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljkBk-00BTI1-Fy; Thu, 20 May 2021 12:02:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6bc8080-f033-4bae-a1a9-08d91ba042be
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15154DDD404960D7B95055CAC22A9@DM5PR12MB1515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTBnuGTP2etJ3BQt170+dqjeOJdnyQv/A0Pe0SC7SIsxGaKAOj0tyDgnKXk3ExuIEmqAOesHOgilwM7EygRhS64IjjIHDq3is7jfz0yGpyXDkzAR7VkxsoUA3HBQFgWfWJu9g7NkfRwe8RtSWM96tmQ6TPXZ4LeUS9olQW5GM6Gj+69daaTyMecZLU92SBDKc9/t8q4C/oCg2Kgn5pGQYfyzLR3SVRwozQYpy1pQGR4PE6LoWIHBOMq+j/oiRBYVlbda2uIL6l/ROG7GahqvNCXDpiQ4hsbh2BD2aoBlEc98OGTN1A8V3BDYEJvu+Jlq3vAe+LuehaAQ5VbnduGJ8dAJFyrWf3Hpdz3+WcoqJ/B9HmhMy0HG1k8iD3YGsJ6MlWwkdfGH/F1TqgPt/dmC0L0aTDKkEqk2oxhZ1goYwrFeglzTf3JzrDg4FrbVnnWoGPc7xipbAxvWAS7z2Olb0hJ72nxQGuZRn3JOpLZA9ot1//VjxxiaJVWjrwfF1cFr7CXi7hq7vm9tipRG1iA4Qte+yyV5MCCr+q0gUoHQusJ72jYZKFeDwFW6Szq0+Bo0KzvFUEHRNPjFKAkWgkxqZovI4SgV7NLMN61VsMVuOvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(66476007)(186003)(5660300002)(66556008)(1076003)(4326008)(66946007)(426003)(4744005)(2616005)(478600001)(38100700002)(2906002)(6916009)(316002)(8936002)(8676002)(86362001)(36756003)(9746002)(9786002)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PbZJ57NUzw6/b3fD1Qv3HxJXPRizAUaBu2QXDEPoG9YEEMFARESItwMWLly5?=
 =?us-ascii?Q?w7RG65CwS5VwJwLZQwevnktetOh6fthNCErkS5jVTSOJJTMb2tVjVrAQkkV8?=
 =?us-ascii?Q?+KSWUqoaCMZK3hMdBXfSRu+IE1SzyTrjWdR0BBybWBlUo1m7PucX9MvWEWRM?=
 =?us-ascii?Q?C6vpvck6NLC0yiO9/tGHHSYMjqc6/ePD1acW8PgCqY54TXuC+VwxZqNh9ZZb?=
 =?us-ascii?Q?HGygqnL9yNVPvKw0NMdCYe1CNSw0wCr84Mfm2dySak28Fw7mfva4BVV3akWt?=
 =?us-ascii?Q?OuR4QbtFBBK1jcf8fEMffeXHRUihnCtz8fxY4n5pxxglsk4YG/CfTW3IHWKn?=
 =?us-ascii?Q?ZcecncH5xSGCcoaXACjkk1ZUdoSm8VeYHwEb49f1JhK6coNPnsy6NZlMs6p9?=
 =?us-ascii?Q?8xyiOmvq9sgBM78zNFhC0rY2NlUcvTNLalIrxXIrDtN5waSu5CdFXnWzoMqN?=
 =?us-ascii?Q?MUhmZEs/zbrC2rPPPZnr/LN/VRUctEDvv6Bz+o9MHx8N499ZVSc7FTcKyzAs?=
 =?us-ascii?Q?wUstqmNcA9Zs8t30ac5sXEhPgMv0mRGUgtU30v2LuHlAOON1vd4EJHDby15S?=
 =?us-ascii?Q?1hICkLXWLB12L2/+5mkfFJuov/Q8q22tV44aIH7nZPHi0kTxho5c9Y4yvO4h?=
 =?us-ascii?Q?r/95A3kR3X59Q/ToylXz2NonbD1g5+bjtzcr34hgCBa9tWp46MGosyrePu6J?=
 =?us-ascii?Q?bMMuFZJpeRxrZuuaExTLsL/VR3BgzeFvfLwaH1hJGqU5pwV89Hgr4/fUFjAW?=
 =?us-ascii?Q?x/voNRqZsN3WoRpFipoMSn3tIaHM2KIV5C6X0vGnYnfqjRRqHVv0p+bY+TML?=
 =?us-ascii?Q?qqjTVGIxkvL9P0gsMJxrtKLRp9oR/7S4UTDIMAhxTQdLxcUjoIkysAvvjfhm?=
 =?us-ascii?Q?YlJRFZZdZW5s/cx+5BHACkz1vzGLPQxhoqkIAGVwEYNelQIW1u9aBk1rRzRq?=
 =?us-ascii?Q?zyqLwxvGEI8sluiUTYp3eBiEdyTSBrkuksQ9dVoDpOFJU3HyTkIwohh+CJBZ?=
 =?us-ascii?Q?+5x2ZWWtNbJT6ozlkuniEi6EbXYt3GGSV/g5RDs8OGQX//52jIXE7YHNz+ko?=
 =?us-ascii?Q?dzD2cPYCDVxmt6qw3Adju0bIh6QYiXxtifjKk5+tiqDw+6QNg9FfiNivavX5?=
 =?us-ascii?Q?nxzkiv9dTIGVeFBhjUIYBOwGKeBsHJ5sWblD3HI7vDyzEBUZUFNxugQi5h6x?=
 =?us-ascii?Q?e35IixiiNBo3o6k5FRIAD2ZPvbv9a0LfvlZU0w3MSuJWFmR+oqKUHsBfy7Ng?=
 =?us-ascii?Q?5d0gx/MTOLp85QYzVaTrbGx6s7fsvrV7zTFRoaxZMhaOHk9tvrR9PN9sYDbl?=
 =?us-ascii?Q?hljkJzXcY7qQaGskquMnQrgG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bc8080-f033-4bae-a1a9-08d91ba042be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:02:18.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40F3JXptZ1fnrv6jyOWvhiPKG56O0bRedAEg2RSrYBAs6KcfrNAbRCLH5C8G5Fry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 04:12:18PM +0800, Weihang Li wrote:
> The first parameter of ib_umem_get() has been changed from udata to
> device, but some of its callers retain 'udata' as a parameter without
> using it.
> 
> Lang Cheng (4):
>   RDMA/hns: Remove unused parameter udata
>   RDMA/mlx4: Remove unused parameter udata
>   RDMA/mlx5: Remove unused parameter udata
>   RDMA/rxe: Remove unused parameter udata

Applied to for-next, thanks

Jason
