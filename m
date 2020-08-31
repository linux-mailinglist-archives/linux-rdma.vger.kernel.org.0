Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA0257C41
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgHaP0j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 11:26:39 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12438 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgHaP0j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 11:26:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d16810001>; Mon, 31 Aug 2020 08:25:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 08:26:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 08:26:39 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 15:26:34 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 15:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBdJfPqJykeFoVepc1vpQ/KLQCI6uKVuvH9rCshNL/8gGSedt7Kw5EJvvIxHH3yTeQx9l+mJFZ8EzHz6C+1W7R3r37NOXV3Ul2OD+1xwxcuQk6zsaRWc3TfkX/pzbwXqWrskqc2DXrVjcjYH+qjvr6xB2+J8dCB5KP8YUzAQyoFr8k5X8ST7ScHsxRK5ifU7IH0apFD4jdSzXRuciFgQtQccNDKFCtjUMSjhC54CV6T+9NMm2b07520zaRobrM89N//l5KwcLUveuOlPRVZ4YCmLMP/Uu2iNc17aPS2k98biGPlZsvhzlxYQFrNWgEtnuU10ZEPd/lSiFA0DZyt27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5iGMQTgPLCqH+eotnkvu1f0io/mpv//xXx+VfXUW68=;
 b=CK61JTHzsnqMkMde/1lGBUXCi2nFxb25UFqteLQmkoeCKN1j+q3NYK2UO158i11Y0ORUiYsElUnv+Zf7ijnJ/+eZS6WKhGPfpX7Bzt8BlHWjB5oRZzxLPyOIbnw9SDj2qFQMgm5DW8jBdmC9asj9kBZ/q/dyqGDCQNkJhCQsUwHg8hVhH4DXmVuV19zuj7HkVB/nBMvW8lwB2CVPqZfaLZOpwlan3T4rWhqNTVVx54OyMEkDCsUvbHPFfspcwU3Eoq6rX08Do2AtJf/NVWIw7q1Mv5zCdtvl1+WfGxfufvwMq+fRveXZ93WfTNE7a65eqCJoHaiUzixHTZaZyP3PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 31 Aug
 2020 15:26:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:26:33 +0000
Date:   Mon, 31 Aug 2020 12:26:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH] RDMA/umem: Fix signature of stub ib_umem_find_best_pgsz()
Message-ID: <20200831152630.GC628533@nvidia.com>
References: <0-v1-982a13cc5c6d+501ae-fix_best_pgsz_stub_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-982a13cc5c6d+501ae-fix_best_pgsz_stub_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:208:120::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:208:120::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:26:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kClhW-002dXG-SE; Mon, 31 Aug 2020 12:26:30 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b54b28-f8f2-43c7-6c20-08d84dc23d77
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB294025CDC0F3223A0B784A98C2510@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilG6dVrNxo9CLPIL8jeKf6kHLLGKPMyybXDui1nGG6IiYCrIk9SVrJhNbKOEs+qZ9BJL5/nXXgY6uxMr720rXWFRPLguW27ffK08BoZMYRaVq9sSVOg6+lNbD2JcUMeKzfggyqiyOdj0q+k9zZea+abs+Ka7wom+w+nPtEzj2aGcuntmTZQcdPdr6wX3H+Zvxh1iridW7WC2IPF1jGsICDp38Z9Z8zZ3NlTyEetLJWltyBROjzxTwW39QHPdYSCtu9bSJlXAnVcD26iMriPeLG93Iu8c75IpKXrZgU91KwmJ3c4/foogemrsCkcYRk9i8nffaCddiAs+8WINOfqJJYQnpGwH0UI8RMVwsYP1R9rcmQ5es5SFC1TXNNs46G4L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(26005)(2906002)(5660300002)(36756003)(86362001)(478600001)(6916009)(8676002)(1076003)(33656002)(4326008)(2616005)(426003)(316002)(8936002)(66556008)(66476007)(66946007)(4744005)(83380400001)(186003)(9746002)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5FEc0RenZnGwiELDVSa60+7TNq9vtzyah51kBzb+eJ9fa3w4dOEfFXRtnt+x/ZVkX9OhnwK0rf3xU5cBBx8mCGi2TFVsks8gt5ppfrjxSNfpV1+Hha1cx2u7OTKeXag6flecMTVBQeZKqVjWPL23fH+aez8K087h4uk7N85A4eQc+UfNu4k3qpXt/dx0Y/gQF7ZDWbHapNUJDVcr3RlHpGbMAFbJDbXpvcS0R9bngrc1GVzki4zBbWLCACdlwQDj5ffBT/GoWsg8aLVjfZnj3ec0wnemMpwe6N5/7MPvDYtZsbjKYq5ocYQjRaI2NcDU654S/e+OOLVlTT0tm/zkHe4AfyR2qOx66/Qyo88KVMQqKwmfB9oyEgo5UlA3+xPGkxWpRBas11Gs/u0x+ogwIbaqKsxRLsYD5uz4OvilhAhlRAtA2jIsGtZn46suMYQOcFsHV9Aw/WUEEw52nG1ChnfETOfQs9+Pi/K2SDn2pz8od8W5/rmSXeHooIxBodiu8Gz2lxYRwPpsaujjawzDHy6seZXWz7bTC8Wgi8ONuTZAewLzWPOOSHey6+sr5GQRx2UMGFqTQefkJyAelnWCI6zaxrCO4PalHLy5+rrT48SXbiaa9dLAEKuiJVI4WLaIi3vy83S6DdxRjTKZparwlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b54b28-f8f2-43c7-6c20-08d84dc23d77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:26:32.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u+NUlnKCVThHtG/SriyECxnag3fEMjEzhFVggzZubskVxcGgOk8qFXJrYZXVtzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598887553; bh=n5iGMQTgPLCqH+eotnkvu1f0io/mpv//xXx+VfXUW68=;
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
        b=Sxx73eHRAwdtQjehJohDFaMgYiizwElvhmvmFXAE7CSmBWe8hrTjZOKDkjSQJOL2E
         OmKAK/urVPhQZ/IxWY+DlN1+CikdfrBT/jijRqPL0w7uFtFsLaC1wIKNA9Oc80IOIQ
         AdFpReml52WgO7MEyHFGlBtjMXieypcVoRzIeSjQholMPt6ROlEvFmPqFxkBstaEWS
         8BXuP4IBR1Vu+MbxcvOpPgrd3/aGc2E98BxPD+kEMdNAw4Vc7FqdSS2Z2AJCKtJXlp
         nzxQ852qzk9mKYHrKQBbmdElDZgsZcIw6QawqNSr5KO14iGfAbNJc4IZNBF8NfAqpc
         AbZkmz/V8AdnQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 03:17:08PM -0300, Jason Gunthorpe wrote:
> The original function returns unsigned long and 0 on failure.
> 
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  include/rdma/ib_umem.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied to for-next

Jason
