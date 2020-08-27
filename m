Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CA254ABB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgH0QaB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 12:30:01 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:51696 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0Q37 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 12:29:59 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47df830000>; Fri, 28 Aug 2020 00:29:55 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 09:29:55 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 27 Aug 2020 09:29:55 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 16:29:54 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 16:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFkyQ1Az3gs6x5xqJ1JilZpMxQFhDPlAv4q1XzJYIIlmw+8bRItEzqEJc6BEZ529QdZmJfshgbkOuk6oSLWymvP1YMmShYMdgQfD9dz65u9Dxz6LWaiuq1uNNIlYnNz8fX/ZA/TK295oGkbvgq9Nq6zvFe4G+CpcdkZOAzsVPHqxw1XoNJA7C43Wt/p7H6e3d7s+FMMMbg8rQllsKWy0W4es5y+Yk9PWPFYelhMdQc8A3uG2ns73pqDfY3btDTYJ4Nfhl3/geBbgt4/4YgaVeAkR3vVXTNNggLTt72NvipUslO4w2bMS1HayGP43+2LwwIFpQbS6bjLqjXnH2aTrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpgs2TYo0jCVttN7CLPOCauYm18IWh7CrnyKLbuV4wk=;
 b=WWuASzH0LRdbOa3RSgfIXLwyC2UZADcCI1Ad7+40SxDZT95NBiniT0A23fUa4KDpW+IBfT9lYEd+zX3kGAgXSzNXLTw8S3VHikvc2Pas9c68UhBsJyliuAI8p7qSyMaAvFhkzZ1J3GJnbidfvejfPWZxRbSyrc7qeOX9Jxk0cbxTtin4hoRpdylwoqVQknf7Ad9kkDHRuN+1uepBaxHbrVIKBtdcW0V1T4bUOmnC1nGfFYpQu27jnNT9Ok0aZ802Fw7MyCUhTJ6Gb8G1TJZfAXp8fc2JPajRVUydG9iFzWSx5WyWbW3JjaoD6CkRyNaf0n3LO1q+OaTFTSzeEk/D5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Thu, 27 Aug 2020 16:29:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 16:29:52 +0000
Date:   Thu, 27 Aug 2020 13:29:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Kamal Heib <kamalheib1@gmail.com>, <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v4 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200827162950.GL1152540@nvidia.com>
References: <20200825151725.254046-1-kamalheib1@gmail.com>
 <20200827121822.GA4014126@nvidia.com>
 <20200827142955.GA406793@kheib-workstation>
 <20200827145450.GK1152540@nvidia.com>
 <47468360-cd58-96fd-7d4f-4f4c351e9ce7@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <47468360-cd58-96fd-7d4f-4f4c351e9ce7@acm.org>
X-ClientProxiedBy: MN2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:208:120::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:208:120::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:29:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBKmc-00HG0h-6Q; Thu, 27 Aug 2020 13:29:50 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f9e0ee1-2f37-4762-9762-08d84aa66c77
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1516A7E6447C2E8047464F4AC2550@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ve7Ua2T0jQb0pzb/5QD+Ofwyu6AcoC/ahm3Ob0vMVZJdCx2OiRVdOHW4v+2yJ/WQZCUvzY55P9R6MQsjxM5x4CkaqEsedq3Tfa7h6h/SuF6xwvV3dXqVuafdWAtZmDbmbvGeIpKOMoRyAiN1D1ZuyeQyxzfKgMreU6u5/9kvGhaZHYCbFBMOrf8WzmcYrPcAd5vgVzXXAfB7Exlv5z9cyE19ecyhyrARs3wxwLbueM+xaRKb4dvMDlFfksb4ZsC3Q8k7T9mUB8bThBk9NmLc4GV8KhN2DZFY4aOIfqeki17Qh4AI3KJRaDNXPcizF5TmE1UZieRHQJYz/ql5dtyaMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(9746002)(66946007)(9786002)(26005)(66476007)(86362001)(53546011)(33656002)(66556008)(6916009)(8676002)(316002)(54906003)(36756003)(1076003)(5660300002)(478600001)(4326008)(83380400001)(2906002)(8936002)(186003)(107886003)(4744005)(426003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: c8BFhdYlVcCng7XGS/UShkBy9efhaBHQLnwkXGclVdwEAq+78iEElqXOl2QOliCGkbgLDnRBsANBBCAahYFm08W1V9ecueu5EdhXISK6SsfWzt5n8JMJA21Jn+ftPd+qaptCz7Sqv97SQ+SMNyDik97w04PXISpnQTcz1e888ZsN1f4GMep4IdfoTeEbhATe3yPLfUa/mE6JMflCgSqStcVSS9YlJqB0/BdbwBCp5Ioog9KlDHxodFXsmapiKAYVHUSDLO5qvKvEUzWqGAFrUWXRtaRpl5D/Zl0n7MGsGhEOjvhyPK0PYRcOFPe8dxL/0QCBEQTpEgBtLsTzSzpHapjUmYNRWBdPJRsiVlM3ApebQapyNw/IL+pNnpCyVuHTHLjmV/1doK/8t/rbQZHgMI70F/v3zItQh12UIKbcaiL4ZveItNclbjnPHPUk5iV//cNrYi3elG0FvgLRJ7fG8CCYJ5YNlEI8HjmFmcXw97u6DQeCVDAdmDSWbEIwDFwJ+pwk9EjXHNnjjb6nHLf13pExYOO2BUp8tRZeVSqAowJzpE0MD9WdkQflkyQ9GqfjW8qzZmwq2VIr/wjd6KcHIVMWMLPrOYBivxFVTMacvjvvtx7rmLqVGM8RdFR5WZGi/haM3rIOxgPkkAFP0g0z/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9e0ee1-2f37-4762-9762-08d84aa66c77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:29:52.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBipzoC/++m6HPg8igpANIsAAD7uNsAM1MgKCuMR4fVp8UenV6mbL7C+zhtSBWr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598545795; bh=Fpgs2TYo0jCVttN7CLPOCauYm18IWh7CrnyKLbuV4wk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=GSwRd4o2ColOzDDs7SJY8c9THHdkvQ4w8QLcR3InKX+Ee57Mv8GlIWgDE5g+9siSe
         tT1hDDg5q+RtgrRTLCo4ZAyDOFtJ6zijJcX+j+Q0RQWB45Zg42djBbxEB5XSA64SdW
         1ndms4MMwTjuOzjj+M4A4PmmzzubrV+sZY2XFKGea0dLltnvXkIxvnZM795Oh0jmXP
         cgMWFUiWWBI+VZb2kLQm0ZKX1KNgBTLHER9XMu18N1J/atEigg+bC5K1Jfi1yPuRws
         28OT0VDc/EzSCSgbwLjCFLE/JivEnA93fgER3Blv60Ff2Mr7Oz6Lcd4YKglyABsbrw
         qs5tD3UmY3OMQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 09:22:56AM -0700, Bart Van Assche wrote:
> On 2020-08-27 07:54, Jason Gunthorpe wrote:
> > On Thu, Aug 27, 2020 at 05:29:55PM +0300, Kamal Heib wrote:
> >>> Can you send a PR to rdma-core to delete rxe_cfg as well? In
> >>> preperation to remove the module parameters
> >>>
> >>
> >> Someone already did that :-)
> >>
> >> commit 0d2ff0e1502ebc63346bc9ffd37deb3c4fd0dbc9
> >> Author: Jason Gunthorpe <jgg@ziepe.ca>
> >> Date:   Tue Jan 28 15:53:07 2020 -0400
> >>
> >>     rxe: Remove rxe_cfg
> >>
> >>     This is obsoleted by iproute2's 'rdma link add' command.
> >>
> >>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > Oh! Lets drop the kernel side of this in Jan 2021 then?
> 
> I think the person who wants to remove the kernel side of this is responsible
> for modifying blktests such that blktests does not break. From the blktests
> source code:

Just replace the whole thing with rdma link add - it does module
autoloading and everything.

Jason
