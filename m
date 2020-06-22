Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF64A203E84
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 19:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgFVRzx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 13:55:53 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:35364 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730067AbgFVRzx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 13:55:53 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef0f0a60000>; Tue, 23 Jun 2020 01:55:50 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 10:55:50 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 22 Jun 2020 10:55:50 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 17:55:50 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 22 Jun 2020 17:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm1a6Ehp7orc566SKImCFtuDf4ShASYG67a/LRc7CBhrFh2cQNAlsz6sYNHWXuKUILsH8kiHKlg34ebrtlubFMUTpmAOWjjvvhX+WizvRfOG6zUySiV4GTkOZjQQ8V4cNckEzfbHnlgwLaynibyVZr9OnRoIawl1RmMqc1RQ3TZDoTdB572JBD8ebdGaPPIIUx3/Ju8TEah/JBWL5zyJQOe69v5qBsximtNiXtYP5S1bhfoIP0Hpjxsp/ArvSRXaJE5CHheOhXw+OiN2yEY/qW4Ypamkx/pWLNOLkSOx6phIcy9X2S3WRApz5I++I6ybRGAGdAm0wKOjHgy6n6aWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwlQdBl8PugFeH+905tHpamk5xZBzaaWnx5Tq93ksLk=;
 b=hA/vKSrcgBEql7p+qL2qRw4WKcl2YH5GmoHk49gYHrL6ab32srIepBZi8/YHdqkb2KfYFxjiEz4IzJFPwIW9TFiFecEaGIdLotNaHqyQLj0lIL10V4JASRp+HOuk8lYYdhnQ3os40KmDMateI6Bv88Y+yzmdYkgRodRZKULCib0CukOfRy7qeCGEQnSfAWY1uY3Xsq6pRtaC80pn6SG2iKbx2iwSv8VQ1TOuNZoWUdnLXGJHLpecMDtSgMDc4PRot0C9305rF8Lo4a1hirUioeGOzZr/JbPsBlWGg/yvGeIUWlmA372PDm7pXGyfPnV97QIjFpA9fd89soPml1pU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3639.namprd12.prod.outlook.com (2603:10b6:a03:db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 17:55:48 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:55:48 +0000
Date:   Mon, 22 Jun 2020 14:55:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/ipoib: Return void from
 ipoib_mcast_stop_thread()
Message-ID: <20200622175542.GA2892511@mellanox.com>
References: <20200622092256.6931-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200622092256.6931-1-kamalheib1@gmail.com>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:208:23d::28) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR06CA0023.namprd06.prod.outlook.com (2603:10b6:208:23d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:55:48 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnQfW-00C8UA-Ub; Mon, 22 Jun 2020 14:55:42 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d29b4fda-325f-4666-d6e4-08d816d57ea6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3639:
X-Microsoft-Antispam-PRVS: <BYAPR12MB36392D2ED8798F1F8F517B73C2970@BYAPR12MB3639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEhDwu4zP10vonjxHSeXl7exPQFLFEBWsazZiJeJ/oRk870SWl5PktRT5YUczFb6t2+QrX3bsjHFAAeCejlfNG/VcZsAUaWO09Eo8Ou++AVz5AtBl7wpllt06jiQK1toYTtZC/OjYOG8FxNG+sLhrI9u3oPalw7TGDUak4tjW35FDu9ft2+Re3zxApM+yPrvZroGUZkxVkGwOxI7717yMsLnIAX2YPai6J4QAxZk/O3W4G6vbSfVtYG63p0WJRbdUt/x4olweM175dhY1SrB0a+k4P1oRO33HR3aFYQA1WrK2SsYFgTK6x06HcEyEIydls5eJhzS8HuLCqcMl+0irQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(136003)(396003)(376002)(33656002)(478600001)(2906002)(66476007)(66946007)(66556008)(4744005)(9746002)(5660300002)(9686003)(9786002)(4326008)(1076003)(186003)(6916009)(36756003)(86362001)(26005)(426003)(8676002)(83380400001)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: l+Ry291HB0j98lLUFj4jsAyOkz+WWdUsRq0b0iCVyF8ZtZYkFDlPPLVZwFc6EBbbQ44C/tn5AlxmDthdOhwXyU+pTRuK14cUVyLonKkOqtXSsqpg5dXLq6gIvjKJZ+guJk4pfmmfAuDgcRrrz5XpCSUkb9AB3fjwNHc8WxQU3vJFD9f3ViKl8qVSIlVaj6rxnSo766QA6xoKGVrBuhDXeWrKb9zc3s89AgXw/66EoAgbF4af+IELfmxEhFTHFFGLYiV0Xjy79ngR4ztLO9ftTpkJ5s4yPW8RdKsbWahQeF5Mt/9Uw6qekC3wtOQIzuesXON9VOmgkonfrtEyP8jGAj2YOVDnMA4CTpbEoJ2JazR4dIsFhQcEdmu+eiS+R8u9RflB6Vc7emrZRKUuggfcVj5AiNrgOIWSsIctVWJC1kf8u61N36rLCqe1S3Q4F5AHhnrhtYmj5b2e89V3zrV6cD4YzkBzm4TH5vJ7flUlHEzg5jsQPf+XAsj4EDtftQOX
X-MS-Exchange-CrossTenant-Network-Message-Id: d29b4fda-325f-4666-d6e4-08d816d57ea6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:55:48.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLhd2rvlPhbVLPDuecRcjF5FKVdOfdBMARZFxWRvP77ACX7laX5GC+mBNQI2JmZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3639
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592848550; bh=rwlQdBl8PugFeH+905tHpamk5xZBzaaWnx5Tq93ksLk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=OOsEnfxtFFb3RclAfSjkNwuYi+kgw3wmZcLwbMQuWqjtrDG42XXl5GxEqFFKFbpLn
         ZzDZA/qnM05YzWIXBL4X7egqBKuoGDj5SOZo6By4ZZbu5xRP7ldts0C1+uZ7fI+oof
         vdMCsR8+6G4tg56gklnnV4m+2ULitpmX/vE3PMla7NuI/MYOL8GyO2nsV4FpHJBnAN
         agOgb+ADVjO6J6Y8E1A1mrcMzopHYLOiNw3qR1SGrJAhYBrApu6Aa+UVvs15JmwONz
         JW5eFJeFZZ4wTcqjEiLZusETQh7q0h7L99h++hOgjh4ZVZI465brPTp/0aXD5wW999
         NPXhTiIRKnbpw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 12:22:56PM +0300, Kamal Heib wrote:
> The return value from ipoib_mcast_stop_thread() is always 0 - change it
> to be void.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib.h           | 2 +-
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
