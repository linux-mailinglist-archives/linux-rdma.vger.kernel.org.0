Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7062548BA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0PK6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 11:10:58 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:7752 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgH0Lpe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 07:45:34 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f479cda0000>; Thu, 27 Aug 2020 19:45:30 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 04:45:30 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 27 Aug 2020 04:45:30 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 11:45:30 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 11:45:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXexxqI7AuEVQZQVIqbdt3RpU7If4No4lxTc5alQEdLpnXdVuTI92Yo1I4L9ZxPyqGBiw/R6e8YTmyuEDhQMTTh4pPNOTuxcf3eUJuGbFEQludjdyGHaGnbraGciaGhdCXG+MLYRtmSj7YUyb2IWGqVjnDgFeEMF/d92B4nrIvhCm/G3RywqyDFPY5DIecfxmEyyOZMWJH5Eq0psqMB47qXr9NEniD86KhlWJ0Ma1yCK7SB3M6gDfXQXCqAflJuUk9sZEfGgcl/Tj1w8GtJ8u5Z53my5fdGb83aRl37qRTGiPo5RfZ09aZQp8frlVIP5hh9geXH7pAV1JD5UeTL9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHh81+h9+6ZyMEzf69G2kjBNVQIRMPkaO8Q6oYoCRLI=;
 b=OTcP7/0xGDJWg4JJW892XqtOydULH0WAn1BQ8ozJx3OfuZjXTcc8toep1y2c59I+M+8GooMpnNtMSNFGLWvcrhdiRcl3f7InuGMfdhhs9+B6IYcqF6I8Iy32Gpz5+h+XMqTTDhQOqNUZZds1eoReSPWNNjivz7mGQaJln2dLHi57kd15hkVjITu9eIJFepRkNPC7Zd1KxUBhNq+iB5JS6m5ogED4i6xVUx1/tD4Ay95Y318b0OeA0me1Lk0orEc8LkYA68BrIzXN1AabBuIURcSJ/Y5kSsc0ueE5w6Tg8pL1UIoWM4gLH067JlKFGNziswVvx5fxYA52DoBUh/2QFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 11:45:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 11:45:27 +0000
Date:   Thu, 27 Aug 2020 08:45:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
CC:     <danil.kipnis@cloud.ionos.com>, <jinpu.wang@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <leon@kernel.org>, kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v3] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
Message-ID: <20200827114526.GA3997016@nvidia.com>
References: <20200820034152.1660135-1-haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200820034152.1660135-1-haris.iqbal@cloud.ionos.com>
X-ClientProxiedBy: MN2PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:208:23d::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR06CA0004.namprd06.prod.outlook.com (2603:10b6:208:23d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 11:45:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBGLO-00Glor-AQ; Thu, 27 Aug 2020 08:45:26 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d7f5bc-90fe-43a1-af52-08d84a7eb154
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882E81600497662869C7A1DC2550@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGFrv+GBZz22+q7I67VuPg2mTcOf3VbPCLmtWKg6hlLG51FrEXFA+hQxXt1Rj4QVsMwSWMKycVzQ6CWCDF+MH/slFj5D/0aY1c7v9UkHVe0lEn9mbK27uN6ngbkQ7zQpZ+l7/W42Wcd0Yc+f/s6oTsUcBpBHZvck0VyXy1jxs05IKHM8pOZTwbquXtb3f8UnMu8UdSpeBMakWO2twud2+iNLJB+egEg681iQ0/h71cVW1qdjTedF2+yKfx5ETHldOkDdYL0c5SZ5Fc1+35jesu6M+SSXlyDi7y/eYPJH8lbbueNCB4JmlZg0CUVKAeWq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(66556008)(66476007)(9786002)(66946007)(36756003)(9746002)(6916009)(478600001)(426003)(8676002)(4326008)(2616005)(1076003)(8936002)(83380400001)(316002)(26005)(5660300002)(186003)(4744005)(86362001)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0yRB4McXXFDsWrMTB2vJUnk+EUwipGmwwMiFqYykbeP6lu2kocJ7yYyGYBK68z87lSXF3jPItji0UUCNJuMhr+/6DFW2koixApyBUn3nrWiwHT0Y+rZCsXK6GgkTjodsaQvJ1rIOkLPYl6iJP6UFGg0qtAn38o/T00VyQsIPPoXeWP2TggIWYrOaq+xuXEOUBho4jkPFctAsXZ4ndAuOO/YSY0U2VooeuGZlwU3VWbbJHUpU6TVNYHXUppf2mqMeJe3SzQ4SVJGvj/n4YLXhT9Gs0dB/D82BQFRE+G8QbrgqlhyhclRKgkrhMS2iAIcD+R7EhXY+h/jcD+tYvbd7PwyVyTUd5yHezElyugZVCLxOa1pu/V5/xgdetoOjoA7Lob2y99c0NTLBeBSu9wBgvQWj5buSjnx05qzbnRwvp9vnqdXB+jspTYowUyVoYlNHryIpmbf6J/CAjfIjHP3S8DETMWt0lsNSL+xo2DqDQEjFIr2ARIR931YPWebxqK1Yln0WtJUZVeVeC+b7x7PJIHmM+/lKTesqJZwufgdtRF7j5BpGEBmHElIdF1xjc5pBoLtqzdUKzzU5mgVMRcsnyxRGVOlaF8F9wO1RAj6yQezRPc6kClx7TUjOvs+Ju6OJZtNk/pSstkWn68YSYl7fpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d7f5bc-90fe-43a1-af52-08d84a7eb154
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 11:45:27.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsjUitjs+bWpiO31zt0tn2jpM6bYngqWzyxGWtCdlPK8VgHXqOEXmpUarFZlv9jA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598528730; bh=sHh81+h9+6ZyMEzf69G2kjBNVQIRMPkaO8Q6oYoCRLI=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=revcp6/o+Qb2P+S10h+5TbS0xWPzr0KQmLpB2vezS7zmj9jdLDCTGPHAsI9rIbQmi
         teMOKFc19YUR+zTI37rW5SLpfTUH8YPldgs3zjoCPJDxhREPA4vlkOj9pdpjbrUrQ9
         XK5M5Xxvk+mUGtMrtglbQS90FS31vX7afZnRlHuI9uzkty3fuFMkW2TxDEj5Q6up0y
         JG82f/9MrA/EIvFjWyjC34gLdEv57BWWd0qIz7e82mi2xEtGW40GY8nV9zeL6MAGYz
         CY4nKUHDKflI789pwnE/8X/B9EXWBt8BZIQ2P2pKB5l+mpQ0dd+1UfWzcw85WQXO2P
         kfw4usKGnanKg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 09:11:52AM +0530, Md Haris Iqbal wrote:
  
> +static int rtrs_srv_add_one(struct ib_device *device)
> +{
> +	struct rtrs_srv_ctx *ctx;
> +	int ret;
> +
> +	if (ib_ctx.ib_dev_count)
> +		goto out;

Add's can run concurrently with remove and with other adds so this
unlocked variable is racing

Jason
