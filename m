Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C92506A3
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHXRh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 13:37:59 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14329 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgHXRh5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 13:37:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43fae70000>; Mon, 24 Aug 2020 10:37:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 10:37:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 10:37:57 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 17:37:57 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 17:37:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POk3wzVgxyUN803jXu0KKksq4EoTi6Pr7w7d+XY5DVZP7DiJtRN6AX2c+xk31tSEx0GS8M46uXrmtZulTbSSqfQatbhx4B2DVTz/fDyXVJTRhqBRstmTfPjNQOKnemJbA7ZjQw+Fe55g9IGFTknu1nnCrYbkXOP/d7MY0fqxA3ksU0M415bMfC5z0N56sARXgxx7a00WsgCa3XlNCwwlD8NuyX3+JFIvk7a4vLACJb36nsw8ryXCwO/XmP3alMCJdHAre4F27W0Wb2/48tkMKg2KqoCib98EUzxvqppc5fFlKiCnsI6/yqF4oqwBXunVIx/yiE1ZmvUh7UM5zGwDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdf3qGk9rj5AAkTEytSaL1SQHwEr8wrS2+XmYAtjJoE=;
 b=aDZC6SgDneK58Pl2wi0tt/XfvdWI0xUGfN1tJy8mCaq5md/MNNjgAAAL9G2RGSujKwzHlFw2+pn+G267CIM/lc8DIO9rWymSP79O+dGsELyY1KbN0Yg/T15g8Yvh3zcx0qn5Min2+GfYeSoSgCaa0lUGkS34NP1y3U/ryYTR6SWXc9tcLnsa7/k4RcarBykMW3yO3u5t8IXQ5VBynQnEL1m7aChXxazN9nE8sBWyFpA/nGsqnEjagqddIq8NCkeJoR14ah5evNiD5ZCPrgt71XKXSt+TLyQgkm1bGSkEaWYsUuLYJmXiqFvc/EWeX6Zq6ZF3awJK2l2naio4pgY0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 17:37:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 17:37:55 +0000
Date:   Mon, 24 Aug 2020 14:37:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>
Subject: Re: [PATCH for-next] RDMA/vmw_pvrdma: Fix kernel-doc documentation
Message-ID: <20200824173753.GA3217792@nvidia.com>
References: <20200820123512.105193-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200820123512.105193-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:160::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:160::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Mon, 24 Aug 2020 17:37:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAGPp-00DV6M-5g; Mon, 24 Aug 2020 14:37:53 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70579962-79fa-4bb0-ed47-08d848546e90
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40570499BC07CA541D02984FC2560@DM6PR12MB4057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csg8zTCjbT4t+ZhKIKp6z9P2ffOj/ihSPEa3tz+UgM7eq2lhae8Ind2HUkvOT4lyPaj14HgjCR2ZBFGG9a9S4Vbqc+Xqi15sdAIv1YqKwvjEZDS1/LEDvofBWDmdZbyfq9gbVkVOL0XSd1PQ+a8W/39tovMjLF451hZhjodhMLYCcnn56n334VHtleSvIYyaMF3Y/wexINnMEyjS++v0AaGqne7vp3N5pJYter6xl0ZzPaMi83vRyDQe5HxSphsAv2Fnx0JFUd5s5yyEkXWyjOINtF9b8tgsebvfnoc2WmvH1wPjxM2STLGCa8g9XMPvBLGyfTxMrjlbQDoUN6eiRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(54906003)(36756003)(186003)(9746002)(316002)(4744005)(478600001)(1076003)(9786002)(86362001)(26005)(83380400001)(4326008)(33656002)(66946007)(66476007)(2906002)(66556008)(5660300002)(8676002)(8936002)(2616005)(6916009)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: b0wO4e9Gx7mX//lU67o0JkQ4q3y3QtKEXpTuUKv5ZITeUiqrRaEudGxpZg1TM5qqw+7O1AiSu31iYRSOQ7i9PwnIDTwbXxqVJKJmR2xifMWvzKPrmP8jqx4mvTDmNvqD7YAPtWfAUd4iCees4aPW4eQkHnEHl3fwFhA8MpKb+Zv/ztjxZcwDeHSDrCsQxe953CeIa+6z1IwyneWigDzGm3IRfIAr28btmNwHgoaDhvoiFUtVPC/Q0woGIFPkKX5LQIhM07QTzk4GDOLKGYcq1QJNuemNaZvFnm7s+4yvwa7vEkU+twLUE0xWSxz3LdtUWvCpkoO6TCVYfA9qXxnMlfOJfnLWF8x+jXGS4Hhen/b9tiz/ubv49iDyfIC9kINIsq26Acz38pgZbr8P1ZcxvDCG1mpxbSFs2wGkzOqXALq1PU0HpQG91PJqnJjRxoXdJ1zKgebIDtDqUB3HEgPMTMqnKqlpDpHqPwUyEOyMJSY8fRljDtsg9CM9caZOdLdEcg58s/scFCPGSmXFAICxDBGs+AcCAY5PytVvRQEOPVSuFcITne14e1DWOPh4Qg+1QoKyL2a+dE8oxmEq3Cu8uqU+RN1/vxooVq+L5bINNDVD/ujSEBeWHnMMpdLBVmSnhsaar7yBd8KwQqxnpmdyZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 70579962-79fa-4bb0-ed47-08d848546e90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 17:37:55.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJNaqlq4T6pKaSu+zgaj3YnIsvUIlhHGG3O67mn37A3eo/vOqzU+9+AT4U/UfZCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598290663; bh=Gdf3qGk9rj5AAkTEytSaL1SQHwEr8wrS2+XmYAtjJoE=;
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
        b=WT/drcCPMlpZjxmZHu4Jl66rMN9jqM9NOcDWvCQJWPULiXykXpYfjw+RF7qcJZxNF
         8HwPcG66gFR9Yz2bxrArCuEZPhDqUgSsiocbmY2/4o5hUMewYuhZ2Bw6/OX9o8Vyz8
         fmUhJM5vyHdqr7N7tT0p52bxXZiUqsg1I+FpZ3JvFmmsRSmCv+e/hbuRV+QXPLlysh
         vt1ni8LPbwrS3TgcwyV4w3fEIfooK3K51e2XIK+wsS7TrXDcI/Qc4/3Payp7g0KezI
         5sq+61b0KxX4nJTeO7O6dE3Ys/gI4O/rnsrfJfTDW7IHZPrBC0Bqlcd1PW1AuYALoO
         rEY1uT+/tV/2A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 03:35:12PM +0300, Kamal Heib wrote:
> Fix the kernel-doc documentation by matching between the functions
> definitions and documentation.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Acked-by: Adit Ranadive <aditr@vmware.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c    | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c    | 1 +
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c   | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c | 7 +++----
>  4 files changed, 6 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
