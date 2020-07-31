Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E125B2349CE
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgGaRDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 13:03:16 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24101 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgGaRDQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 13:03:16 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f244ed00000>; Sat, 01 Aug 2020 01:03:12 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 31 Jul 2020 10:03:12 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 31 Jul 2020 10:03:12 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul
 2020 17:03:07 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 31 Jul 2020 17:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f06dwpbQGF8YTvaDaiK06LtM9U1kIOdDYA1R3PvpLmeK4cKPKypjdwCO/r3bXYvGLbb/83LZo9REz+35HSKjc/uetSB3Xx7rAgDX7MMtr+qj2i2WP1bpiQ0l4SAprinm1fDqhvwEoLp6sHr3c/TwfjrtTFwus74TrVm2ggfUVMlXRQZD5Rk7kvEdnFH32cTQDpN/nVgokQopvjEAnGGmfJe+Whlx8qcgiFy7MEKWj4JyqlOUhLP/EilvY4I2J7FfwHB8N8TU5XoGDIXDpROS11VZ7ee8OxX82IMpeznEOXx8tpTCEx97rAzNd3uyHNdnKFspppzuOX41T0ptcSqOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVnTdyqY6u/QNdhoAjoLCCavhCKDpFQdG7SDseJEu4s=;
 b=JA5kecl+bW/zbJGiXl6jNFb8lGpk9xiWzLNNOb6WFb7HkoQoLK185RR6AhO3jZl8f4XDmkUO+4HeEZFxyR6BsuWxDaA/kMiQ41xWWYzxzSr+sEoooNvis7gO5TT4uxWYo3Mv/W7a9UoDwSMorWidwxn/sbcDmBPCzaoRNkPvhg57pO1zHxabw5n62Z8ogvswPvb+pqKgjC/e5g4s3YvDWDfV4eWpnoPfxR2qjO8D/QF21xf86xYTfOUnMyzOjo5whYJbI9O3rSe7Np69v1JFzb9DYfRwSKJBsWFosanF72VXzApczx+0GEDwAFaQ/3ZAN3PmPfcgykEaO4X7CiT0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 17:03:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 17:03:05 +0000
Date:   Fri, 31 Jul 2020 14:03:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 0/7] RDMA/hns: Updates for kernel v5.8
Message-ID: <20200731170304.GA508060@nvidia.com>
References: <1595932941-40613-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1595932941-40613-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:208:23c::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 17:03:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k1YQy-0028B3-4P; Fri, 31 Jul 2020 14:03:04 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ed0381-897a-46e4-6b4f-08d83573977f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24867EDEE56EFCC155D04E8AC24E0@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40ZnUMib753dYhNmrgkN9H0p+emz3+XinL+x4RuZ9g3B8T1T3nkPsYD3ny4gwkUTN4QNX+DzgzJpa5FLnWNrmbRpY2oVsIuGNc9X/EZ7+TgYsiLGoKBERoDHriWp92rQF4HIP5nwpnL2gTUb24w3pgRt7Vpdyqe7XJ1fyMtuPKzzM7Qh2me1XsybDijvD2utnKwBo/Eu4N/ZDOuch8RoZ1BfrLYVlficL+hns2pjzELu0NxwXQbhhmsR8SQ4bnVWNFDeFESN/JxIxBhpQ2XYoyrw2cdPrWAqfiw1u4rAglARE0AE24Mlqqi8WV03d8Dor6BaGp+gmURmTCsDUsCJOT1h/Hm68MM7oHmz0F+O/Wvnyl5Lpkb9JakuZyJoJSxu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(1076003)(4744005)(26005)(86362001)(186003)(316002)(5660300002)(83380400001)(8676002)(8936002)(426003)(9786002)(9746002)(478600001)(6916009)(33656002)(66946007)(66476007)(66556008)(2906002)(36756003)(15650500001)(4326008)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RVZaP6QhayTuSth6LtckWGEA81cAFG6Z0g3KMDnJuP9bTOs2Hsqi3kgsxJMvXpEqznN5x2GrIHmWcipobLRNwMKNLPWZ7dDfl1FfSRP8BLUWCmhCvkqDd/jJv3Lt5L5Fq8JGm0msXjsOfedFqz1d+VtZD63auyEgTSrteQBRPiyhi8zDaZOtEt1gakY7ahXuNZZLPYTX5aNbXgWtewH180zhn6Cp45JpT3RPJNuo+gJ7Y4oTSJpSS2iLqGV1GcJ5zjodhxBxLBhrxbYwBVCvDInHcdz9IuqMOkx2K0msLzxzX/tmyzIt/9B3kp2JIM+cVCc2+4D0zMgy4GKPyD4G/cPqswxX6QNqHiiVUlglt7gDXuJrtM0p6JmM6hR3mtCbDwMpycbb6ySwJBBw7hxFl4H0PshaeyJbfmiCvWJEBT2JZZQmTIHi/gc+qWpcoRrwmIf/qzFUN+JI2Ipfz/9RKyNh88aGnBub/RjH5ggwkf9tuLaJ6AMEzHUqtRIRfibqtsZcdiNe22n1A3jQyPr0SzkXcNwaFL7dnC7XIKAmrFi3zsue2KuaEtmmRNSpPEWJC9T0p6SMrdSfpWT6FLEh50VJ8ZYvx5yQnWgIovUIujbJ8rSQoJfThqmf16bhMjNBMFiU26rJMKXelN+z5V4ZHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ed0381-897a-46e4-6b4f-08d83573977f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 17:03:05.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl1lwlWbUk9s5KmU/7GMOqrYStEUv4yjnhIxs8a40EQtoi6XOvByEcO9WMvfANWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596214992; bh=EVnTdyqY6u/QNdhoAjoLCCavhCKDpFQdG7SDseJEu4s=;
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
        b=hLfoGcNDPYFn9bBAvM3Ilvm+WqOS1nPC9usJ7LMEAqNlHWCpajVLYM7k17SfLUZ51
         UyQghLi5YlPKFqM8Q7EvYKDbMu5M7l2O8N+r1QzZjwWidOSyxJ93C8RlAi2mFOjJ+W
         ZCSFoG8TGqi0UNExphOgeWGQQh0i3pOow18+q0bEoDKZC8VpAWpdCyuZ1oWSiFFQCD
         yKi5xIkLy6+n64mSW2ssQz9BfpiAJjsZmHfHKHaN7NbnUJWMwn3aTTEBho4sIcrw8s
         IPEtWlIoQS57r2mViLmdXVTcTtEeuvMaekVnK3mwmZqpFQ7RujE57fpRjHXIL37BSA
         HB2UQMi+yX/jQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 28, 2020 at 06:42:14PM +0800, Weihang Li wrote:
> These are some miscellaneous changes of hns driver. #1 ~ #5 are cleanups
> and #6 ~ #7 are small fixes.
> 
> Changes since v1:
> - Fix comments from Leon about the judgment of return value in #2.
> - Rewrite the commit message and remove the unused macro in #3.
> 
> Lang Cheng (4):
>   RDMA/hns: Remove redundant hardware opcode definitions
>   RDMA/hns: Remove support for HIP08_A
>   RDMA/hns: Delete unnecessary memset when allocating VF resource
>   RDMA/hns: Fix error during modify qp RTS2RTS
> 
> Weihang Li (2):
>   RDMA/hns: Refactor hns_roce_v2_set_hem()
>   RDMA/hns: Remove redundant parameters in set_rc_wqe()
> 
> Xi Wang (1):
>   RDMA/hns: Fix the unneeded process when getting a general type of CQE
>     error

Applied to for-next, thanks

Jason
