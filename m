Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3704248D9E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 20:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRSAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 14:00:35 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18649 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHRSAc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 14:00:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c17050003>; Tue, 18 Aug 2020 10:59:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 11:00:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 11:00:31 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 18:00:31 +0000
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 18:00:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ++KQOpnHyerh9c8gDcCx0jwfwjd6deXvWSPybhmuQQreRKXvIHXyU4cHk1sl6POHCEaHdO8WHU3QcG1m3XNma9vcbSWM6yohjNO0LFNM+K6dNlOtvXXBReCK9z0SKvoH8mu8eoBl7RnFNU4ChEdMyinPG5xDkIJogfq5HR9IYZZSOi4h0TxvrNwajlZJU6++KqwwCKAJobLADSf2TKuhNen6Jzm2yOy+ww7UWci/xBA3GyJjq018AePVD+KVoPDOTzCaEQvuaPN0PzRHO78jaZmdQyV04kG0g9pb0PmeRfjEDH8yAaWzKKzp8txEd9zUMbtTmc0WIG1PIk+LPIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdIffwpkdCgXFwUoecVzKow+Tj7FkSRff4d62iQ8GHc=;
 b=LTC19IciQh+NqRdBBaNToqjcN1JkC5vULNzBJV/jlnMx+9WI9PkWOWOyzTH797rTsfp7ArZe9n1+PHr1csswQ14vIjl4McDB/JPEonAjhgQH3t0I2DI3J/USUZO1K4DMGcdUcno0I+5GDqBUJc0cypga9LS+E4cAKAsk4kaWJ3vvoG4UYbmd5ZeCt0bcnH5wt7PTgvk07iSXxpYx7JUCFPkb3NO2dgKPrQIWxDKspr/uZ2gOTwLJxmluOYmFAx1SNtqfJxLyGFflVRxpD6qARVuM5gvQsJWydXGalOWNfGWZePTbBEt+zFfaWVVzooAhlPDlPyZig50vEF55RLuRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 18:00:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 18:00:30 +0000
Date:   Tue, 18 Aug 2020 15:00:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 0/3] Cleanups to flow creation paths
Message-ID: <20200818180028.GA2056204@nvidia.com>
References: <20200730081235.1581127-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200730081235.1581127-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:208:d4::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0016.namprd04.prod.outlook.com (2603:10b6:208:d4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 18:00:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k85uO-008cxc-D6; Tue, 18 Aug 2020 15:00:28 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bf7ab3b-2031-41d3-3a5f-08d843a09815
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0204311FF3FD9AB493C67E88C25C0@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhG7POF0k2IKLKyY/T4nNmAuLvqDpBRhW8Nd/kAE+0LqgE6y0MaZkHAz8w5QP9UoYyC4kO4EKFKtN4b4ytms0bflMJlvBWZeCjAngPiyHTxPB2n0lE5cDgys2K/AwboztFgXFl8vDe96D7GkxV4Qt8SKCviFnZVaGRHiBNMGHEleAo4IqKOYWlLO08QQORPZL9Hqz4+nd0v7cmHsXQyT8G3fyE/MMSzT46MaI+8vOdn8cCrDoPVbDnyG/cVW/hJD61UM2NlpWeqQ50JXxRjls1fDIlMAxqxikCKMRFhX5AXovNozK1omwv7dzq59XezgSd9FBW1EgaBRHrKEUu7a7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(2906002)(33656002)(8676002)(4326008)(8936002)(107886003)(6916009)(9746002)(9786002)(54906003)(478600001)(426003)(2616005)(26005)(1076003)(4744005)(5660300002)(316002)(186003)(66556008)(66476007)(36756003)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GT1SJ3H7/xxtV9l8nUBrYOYpDj7nelAVJZRH4bw62VaT5bf02TdHyCdyTMqKO1cQ+c19IwEzMvGtOSww5ngHT8/418BOE6LwD5B6aSB27vTRY+qje+rnOjD2Rg7PcN9O/M3GtiYwJQ8l7uRPpq1MhCUBUM8V3l2IZYFwOgV3ANHAUcucy6CVcnfoOFBqRbV21s7QOQyKHeDBkyKMkbZrh+oiJhFC36YEh2wWtLJhxslxHlamB7smzV7UjKybQe0pPaL4pNDX+Xhbj71Ipq43DFq0cvhRVBVzc2Xacdc/7mNN3hOMvvEcucmGCntBfkSprK1wyngsG96nrMNA3UTn4253zEfLKGnBrYG5+9LeRAZxPmQOSmPoZjPoBBcCpVBGA6HxWd/UVETxhZ9Ro6hiwQotvWiK2dxaGJOHzxfhE5CN6S4IPTb/eKhaLPRzfGj+By7TRjCIXYK9vWvu0tqjl8zxi3c/48DwbyASOrU+s1hF0Jadpj7kMwrua6dqdLiVS6m0YgpcWDM6CV174MZjlx00FfJ9YJQhvH9ceBzsYZ6Wl8/Khrwpz94cKEUMT+JAwih9E7wOL2w2tm3Va16MhpkVwcJ915stqWHUTQKNT5F+pFBG10LhG7Fqqi16L73UQBaxPlMjOSdP6u9hmIOITw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf7ab3b-2031-41d3-3a5f-08d843a09815
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:00:30.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F/5g0T6yBr/Zzj/AfIH6ANy+0sQfg7/jxNoIxGlTt35/nfbysswsjTHXhSUChRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597773573; bh=xdIffwpkdCgXFwUoecVzKow+Tj7FkSRff4d62iQ8GHc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=jO4SgFTlMGnaKZ2cEL42TR7m86fLiw2rLeWW1NaSpOrFZa8kVWdRmRTfQ9hPmW4dU
         Q+9E6LTaACVryCuIwE2CGA5kHBqWzcRtVQIA+3+knBihPo2RfajI0ZX5uo3GXUiM70
         7aNIsVoUzMTwqxqQPC9YxEKKdEM5vxusWrdT8Wlx7mfh8l5MLtXXzA6EEzhEoYlh/m
         Xzp37OvkAoooRm5ZUv4VrHlS5jTeRxiQYhlEexEdtXsJFuof+Rzlszrgo7WhM+DMXi
         CfL7q4CQ/Sonotgpc/u0BEPaWZ62c2tgk9FyVkpVmm9l12k1JO3t4zNIdhhYK5JzAK
         kqizYD4fy6x8g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 30, 2020 at 11:12:32AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Very straightforward cleanup.
> 
> Thanks
> 
> Leon Romanovsky (3):
>   RDMA/mlx5: Simplify multiple else-if cases with switch keyword
>   RDMA/mlx5: Replace open-coded offsetofend() macro
>   RDMA: Remove constant domain argument from flow creation call

Applied to for-next, thanks

Jason
