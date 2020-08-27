Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6688825450C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH0Mg4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:36:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17482 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgH0Me4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:34:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47a8430005>; Thu, 27 Aug 2020 05:34:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 05:34:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 27 Aug 2020 05:34:54 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 12:31:52 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 12:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5QtwYblh42sXDTDkDGGntDoIAXP5GG/d9l09VrWXYV6YxTxi6LJ+QM11xMJq2AOR3/CloRQN4VCzXbQuk204CS6UCUXPfFUVxkaw07xtPiS4UbmBl7G5+TAjr5E/shZBSD1bikb0mksVrY4GMWct6zLF8fV+a8X/th1nGgeJhTsvsywilkHgJd8Kn2+PuWJKPKKkKKpzfqLtJ7QkQwGPczzfR94jEUaVYnAZl1hPFWKCz7MGBZ3/VonAJin3ahnSnNkbDRy/T2CW5h9cTkifnuH2Yj3Zgp+CJLdKxdqgIbZZC5d8Op2jxroIIGi8fIThZQyQyVuzEn/lEe2WBbC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCjYGPpJggMVRgIr17OL8FNtjkYJ34N/LoVlqXq4Xs8=;
 b=QePjR8r7UTGo/jbhQZUbh/rUE1YUYpBylR0Ev079U//Yma7s2mNypbDJxMPPL9Oa0lkP0Tj0cWcQWXBVkN32oy3Z8NfaYHgG5Fncy/uT9uZo3J8vEZrpRSpOsF6z1L2/UO8Ly6F/QiEGpHPMnJHuUSRVcBUwCIkS6TC09u1+DeCGRuEaGgS8tyGesBLp2svZUV8kQG1lgjGJVn50rqlR27xmkhDa5lJFgndgDmUmOGVMldVwA32lwwCxTM8CoZsOBfUbUTo71oY8ewqZN2HZbKKoTXmTbUN3750oZCdn9Gr48nt1pNUXMfubfu65nQdt5Fpm6ZbQvs5tRsN7JFfuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 27 Aug
 2020 12:31:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 12:31:51 +0000
Date:   Thu, 27 Aug 2020 09:31:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc 0/6] RDMA/bnxt_re: Bug fixes
Message-ID: <20200827123149.GA4019426@nvidia.com>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:23a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Thu, 27 Aug 2020 12:31:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBH4H-00Grf3-23; Thu, 27 Aug 2020 09:31:49 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e17e5e9-388f-4cd6-7e52-08d84a852c55
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45137977A4071DFC09693C93C2550@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kg1+tphU8WHr3RRY9O2+6HxYXpGcnP4NAiwRnB5UCzdb8lZyEIjVdCu193eHsl+HWo07kN6jslPPFt22TD7vGUDJr/tV4rdVDDrmu9zHilO3LIUpPQu8u+SwPoHP/kcMNU9jxDh+VLoPLMGfGnaYaFyYLxpLPVNzm+RvgbnMSVsO+qclA/2+23l3neOw6rAwUZKxE0/TdePknQ3XmYaCYuLnUNAecSElkWLHRb8rf4azYyzz0qa/3ZKWgVz2B4sgWti/GnlkRjo52Yxkb2nbk5oJDZlT/C1RYdTEcWpU0lcNqhB0uqvhfZ3h8brh3XQHVzSbSQnfiuFcqTNB3kSixQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(2906002)(8676002)(4326008)(6916009)(36756003)(8936002)(86362001)(316002)(426003)(2616005)(478600001)(9746002)(9786002)(33656002)(66946007)(66556008)(186003)(1076003)(26005)(5660300002)(4744005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 48OAibiGhBUFL4HPhcTZHa6E91GNW/3oCCwqDBgYdT+J9DmNOm9e11oSDW06MbRzn1GfZZc6q84E2Dldosfh8z91qFAIhkrM0KVFoyxr7CfZZd4ZS+3MFJ2uINYZxvWk8bXXIkFX2Mb1JZzd95KNc1myaYZXySEz8ftfc4lN5NFIH2Ogy7x/nH0J6ETvBVCMSsF7cl8+rDn2MgVArmDC7O5Y6uFnSX8jFidKEaOJKMXULNcdK588ZNjVfA4D2s+ycQuqbCCHzoJCNZixm2Nf5FB+77KYiEwaI6O+lpTsZyXjPh+8pAOOTBR/saPoBD8pggOtfmPjgVUdt71zgWfMRrS1Ol3DCnZaNNlgJBNBgH/DY1ikVx0XyQyNp5JDEvT612tSRO2oXPBw77eH9zPWwL5KFIRszauEOmU011KKrB5t9MLXhm5mjG4CCU1eV4cRMrxvXAif+vbPyy0xGxxcl96o1OC8/oU2gXq5jXs3/6J6yjqUcr2msyuHXoCa+a/as3eXg1Gv20D/GSha8RLsZxiiISI7rLcVN9cRYeugUclXaWb6BXdTALoIL2GOQboqqo7037vS0AcvIhNpdl0qpy/+rjGT/WEaicrXs54rUsFrn8BT4KTd69/4B8XXnvioPyZ+1UQdfOP0w3OWuZciBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e17e5e9-388f-4cd6-7e52-08d84a852c55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 12:31:51.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L2H5Ta4vKrscmGdr4OOEXOS2X2WlsNy3dIK6uu7sKdpuKw1Ph9Jfh8NM+Tdp/gr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598531651; bh=PCjYGPpJggMVRgIr17OL8FNtjkYJ34N/LoVlqXq4Xs8=;
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
        b=YOegUzo6RSzXWMAHoaTU4xsb5ILVp7JtrBZfItf5Z+pzpfeo0QjlG90utYz+oGETq
         VyO2K6cl1L1WQTDiG2lTq4MeELFQBdLRSMJzNdhVeDDUZcZI5R4fr0ddW+qoeUJ1jV
         WO1yrqGR3ARRAPC7zpv4qruq/y34pfOmIAH5MuqX6F2UkRYvM4x01PbqOe5Y/PUxH6
         Kged+lASy/DXbSdfJtqbz0AqXPy6LOCkWVQLpVA6+v7nsURwdTOdPbPb7EysNRny0O
         gz2/+yc0JKnkSpGo73X0yo+8yRcly1nlAeE3WIEbYFOSF4DZw5nfEX3nQ9JinTg8et
         hLr2wjEl8svjg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 11:14:30AM -0700, Selvin Xavier wrote:
> Includes few important bug fixes for rc cycle.
> Please apply.
> 
> Thanks,
> Selvin
> 
> Naresh Kumar PBS (3):
>   RDMA/bnxt_re: Static NQ depth allocation
>   RDMA/bnxt_re: Restrict the max_gids to 256
>   RDMA/bnxt_re: Fix driver crash on unaligned PSN entry address
> 
> Selvin Xavier (3):
>   RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds
>   RDMA/bnxt_re: Do not report transparent vlan from QP1
>   RDMA/bnxt_re: Fix the qp table indexing

I took them all to for-rc, even though the destroy patch isn't really
the right solution, it does avoid memory corruption. 

The driver will still trigger WARN_ON and still leak memory however.

Jason
