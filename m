Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0731217367
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGGQMy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 12:12:54 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:38852 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgGGQMy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 12:12:54 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f049f030000>; Wed, 08 Jul 2020 00:12:51 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 09:12:51 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 07 Jul 2020 09:12:51 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jul
 2020 16:12:51 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 7 Jul 2020 16:12:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LABwgLpROD8zn6TeMfv+JslHh9+qtKV9/E0oVvQMeHOkbn6hy1uXUEz/j60flP1AswqIZUvIeNthBXG8rA475kPbPtqa2o35SczudLo/58TL4ot2nInwBmaJZbcJsIOFrMnO4pbtB1mvM4SQZ8BdTJpQhIPY5wag0ZNUvLrp/0SY3EHGePiQ2cuyImpsjeoyU89y5dknGSU9t+r9hUKe+J52gsys8ybnKDg9B7YUT6kbJWdYsiqj04EI0YNtM6veaeaQ01C8Xlj6lSaAeqdRW0vaZtUWPspa/yHTucUCRHtWra0jodGoDVj1gbCPPQ5IzkFu958tW8P0ekLKKg81Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJzyTYvnaxLUniMcD21849M6pRjWRgvOOgpcg5//y+A=;
 b=kgJxh/yBdKOpib5ySWnev5/HfoGFgsA4H5OTjHqPrER15BMX2WCMrmS3IZ7oB4qO1/sp7ymfofYuM0u4eDH+aMEMqWWlL0LVYwX7TWPUP45g8hJ3O0k5AfVYL66ouotBq2Km/rzShuIi87q7jX2EuFb7pYDKnBJUigqZOT2DI7xQGSiO23Ffu7miu9WGnzhCXJwAmNaCJci/1pxxWaCJUnNBd6V3M5WjhwOGM/CEJnj2wsHlacb/vjQnbUtDEr4VQce5KUbsJ22LHL99GboalMxW7izqQDObBx7Z62iP3bpSRqhhClYygD0xFstmsc4rpIdXEjSEP7zsDtJlxa3Q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 16:12:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 16:12:49 +0000
Date:   Tue, 7 Jul 2020 13:12:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v1 0/4] RDMA/providers: Set max_pkey attribute
Message-ID: <20200707161247.GA1375440@nvidia.com>
References: <20200706091119.367697-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200706091119.367697-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Tue, 7 Jul 2020 16:12:48 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsqD9-005lsa-Ar; Tue, 07 Jul 2020 13:12:47 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5b70f01-bc81-4827-e56e-08d82290977b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44830675BBEC74C17D8708B3C2660@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dniRUE2PkKQuLs4zXm6Jzey4zeTHnssVgGzwyiTGUjt2aQ9RdArSUvYsA11BOSIQJ6lZGbQ71PYLcwErhMIQQAZ7Ruo6VKZmd77TVQwiy5YQElOAazB7WLlmVom9njWjVG/sEWFAdoDi65XK8MGOLa2ttbDDOyt6I3UGZ0MXMJzS9p3BKgs/jXXK2i8OcbDNuiyqF83DFPQz9H0+hoIM5Gq2PaPviIdCtrkEki1T9Gkbq1fp/HUwJ94l5xcRYBqfCA9hh/s1Eu+KVgV2Ecf51+9PzOMb/yjSdWtlqNTnuOIo9xtvSskBhq2/Qz3GqWvTRBUDC30LuxGhbfmGLBwcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(426003)(316002)(86362001)(2906002)(186003)(6916009)(2616005)(5660300002)(8676002)(478600001)(66946007)(66476007)(36756003)(66556008)(26005)(33656002)(9746002)(8936002)(4326008)(4744005)(1076003)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: g5h5KHuDaC7mhHaGSyaNHVF/Dxcxh/a8s4VuKHSr1dfP/9bOS1RQt1/unNsvNBhQQVSvbk7MQS8c3iPG2Z/+XPgOuz4Rzp3ufRKS0rsA/dH/zXE8Scy1e1oGoIptAEcWOeUFsnWnZXrYKdvx0zwBINHwhle+03geC6tcElfaBGK+SwRMxO72qU+aOfuRCe+QwIVUSaI18M6gsJGBg/C+gUVEjB299P+mMDqOJL7f3X/VD5LnVRiSGaNwgGN8tLqhzS9nbcLrT7UpO5pHojw+8XHktD33JSGkXuFn1RrRn1IBsELVN0mrXfPZjFXpkdD9ru54gaHoLBHMpFi4PiNrC/bLPB+hJuQpPeviKhjN6WdlHma6K7QK8VIZNQygQo4tse2EWLKCrB04pZIim8Zu1qHFx26ZGLbR4U+tZALCWw6MIr5b0xa1cRDPYsG9M8QuSCw6YHtQBrKck2mN9bSbdEFFD2+0824bGVKvP3noM6Y=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b70f01-bc81-4827-e56e-08d82290977b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 16:12:48.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUe4jGkXCVIvTbalvikXe+lPuf1yBnoKS/z1cojwChE20a4qodma2zIUBvioEjSj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594138371; bh=lJzyTYvnaxLUniMcD21849M6pRjWRgvOOgpcg5//y+A=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=oj8C9xrKq5ew55Pi3yfdQxwbBabdXZbNffkP0p0Xtwfzkg78ljHlDV94UYbgX66hS
         esMcZmGAdPd3L+DpBagQP5fWdrUncN+6zWl6VkwTCaSK59vgobgIAGvs6Duj4Y4+Lr
         m8QSotR9llnlYMTjBohFmGWCeydkYMDJjwG+ylJMkrC019J5MF8tBghy1mtjVjStny
         OvJNwhp/ynxbBIZZmRa4zicrAe0YOSAgrj0XTvLV5nf8SxJiPlPK01FrlCX6w48xk7
         I1Ad8Bl442Y8Au2sNS8qEtB2Ubjdq+l9r7SEnO91dsviBGW7WufjjrDFUsngCeW5Rj
         UDk9T8x3FWVFQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 12:11:15PM +0300, Kamal Heib wrote:
> This patch set makes sure to set the max_pkeys attribute to the providers
> that aren't setting it or not setting it correctly.
> 
> v1: Drop the efa patch and target for-rc.
> 
> Kamal Heib (4):
>   RDMA/siw: Set max_pkeys attribute
>   RDMA/cxgb4: Set max_pkeys attribute
>   RDMA/i40iw: Set max_pkeys attribute
>   RDMA/usnic: Fix reported max_pkeys attribute

Why should iwarp have a 1 pkey value?

Jason
