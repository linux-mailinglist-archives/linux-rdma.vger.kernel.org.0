Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B1307888
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhA1Oqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 09:46:55 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10349 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbhA1OpY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 09:45:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012cdda0001>; Thu, 28 Jan 2021 06:44:42 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 14:44:41 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 14:44:39 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 14:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlMf5b2V5ZcZEt4DwwSLNBLhnBryNHhTeCJJl/ZsOJ96RPMo9urjq47p7fawGo5Nw0iBTE5C+gg9mHs5uDrBVZICzRwHGw6T89tfkx70Ql80hbKW6KB1pXlGw623T4wWHzpWKr//0m4z9tTkhzw5PbwZcw4XQfuzxq/FhZxDCAunmME7/lhzJlbrf5/psc/mF9Xqcc/yJfBLwwZnS2YdJbG3SnX3oASvwenUsN2Uq67KcrwOyZR5VlLCerdMQiQNtmpT8djq0l+qQIDEWDYvVCOTu/dGCyDWkOWGJ5q6a/yS2sE3Rqt0QIj/SzbvnnqRWY4l4BOXzsOOyrj4TAOyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtzU7eUEsKmufiqRnl1+QkCajuENldc2ppT5rJlebL4=;
 b=hmUH2HWIhODp3Sn08YH34L8QPEXFcM0L3cOaZGcVEa8s9tRBV0Xg/TGDByYiyIfVmUFBurqTOd5awL6HfBG2dfbik2SkuqhGO75qOTKjXQwejecRdx56OG3l1ShSRZckU0w7MdCVUZ34qBREHOPfkR7JSfO24g1s26DXrWYcwkb4wAaXq3y/wa0D/ml2ErQb5J+GpfzuXoE2d0ScFhDNPNEMmmn3bnYvLv4QBxiplaafj9DCZmuWaxaf9dVSrkg10QHNHrSQ/xojKA2WLQM11pGA6hWxTvQhv2o961M81Vz0/mEbm9SYGiA1j8JGkktnXur1bn2Ss236YcpcPesMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Thu, 28 Jan
 2021 14:44:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 14:44:36 +0000
Date:   Thu, 28 Jan 2021 10:44:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Lameter <cl@linux.com>
CC:     Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
Message-ID: <20210128144435.GG4247@nvidia.com>
References: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com>
 <20210128140335.GA13699@nvidia.com>
 <alpine.DEB.2.22.394.2101281433270.10563@www.lameter.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101281433270.10563@www.lameter.com>
X-ClientProxiedBy: BL1PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:208:257::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0041.namprd13.prod.outlook.com (2603:10b6:208:257::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Thu, 28 Jan 2021 14:44:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l58XD-000Fvq-5O; Thu, 28 Jan 2021 10:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611845082; bh=RtzU7eUEsKmufiqRnl1+QkCajuENldc2ppT5rJlebL4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=LtBN0woYprnL9CI+kTwc5QO0ybVwWDtqhxs5QY/pGol173CPavLm19bU8aTTlDT/4
         KZz2kSkexL2chUNwnM6j568TuTrhnDak96vDvcEUv2/+9Yps9pjephLQgo1FoBjDBD
         WcXdm1OvFQBVnJYszpxINV9RS5bDYl8W9nSxHrSVxN70ctthi9UshsDkYfmpo/i+pu
         sGw0BvtMZBpdckrze0M/5nOzsxkRMp1hcaJH06qcILnkNUjgJRvSv4XQ6OxAUq1zz5
         5Up+jKnP40wQ8AyPiRUeFiXFA3rn0fvYeyMO2eUo6CTqnvVi/KPReJpDfjwjnLx8kf
         6EB2E91OlKE4w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 02:34:45PM +0000, Christoph Lameter wrote:
> On Thu, 28 Jan 2021, Jason Gunthorpe wrote:
> 
> > I need patches to be sent in a way that shows in patchworks to be
> > applied:
> >
> > https://patchwork.kernel.org/project/linux-rdma/list/
> 
> 
> I see it in patchworks:
> 
> https://patchwork.kernel.org/project/linux-rdma/patch/alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com/

It is not in the right format in patchwork, I get this mess when
applying it:

commit 9215f573b2ce9233b6d99d7b9b45bbcf3b2d9d90 (HEAD -> k.o/for-next)
Author: Christoph Lameter <cl@linux.com>
Date:   Mon Jan 25 11:28:57 2021 +0000

    Fix: Remove racy Subnet Manager sendonly join checks
    
    On Sun, 24 Jan 2021, Leon Romanovsky wrote:
    
    > > Since all SMs out there have had support for sendonly join for years now
    > > we could just remove the check entirely. If there is an old grizzly SM out
    > > there then it would not process that join request and would return an
    > > error.
    >
    > I have no idea if it possible, if yes, this will be the best solution.
    
    Ok hier ist ein neuer Patch:
    
    From: Christoph Lameter <cl@linux.com>
    Subject: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
    
    When a system receives a REREG event from the SM, then the SM information in
    the kernel is marked as invalid and a request is sent to the SM to update
    the information. The SM information is invalid in that time period.
    
    However, receiving a REREG also occurs simultaneously in user space
    applications that are now trying to rejoin the multicast groups. Some of those
    may be sendonly multicast groups which are then failing.
    
    If the SM information is invalid then ib_sa_sendonly_fullmem_support()
    returns false. That is wrong because it just means that we do not know
    yet if the potentially new SM supports sendonly joins.
    
    Sendonly join was introduced in 2015 and all the Subnet managers have
    supported it ever since. So there is no point in checking if a subnet
    manager supports it.
    
    Should an old opensm get a request for a sendonly join then the request
    will fail. The code that is removed here accomodated that situation
    and fell back to a full join.
    
    Falling back to a full join is problematic in itself. The reason to
    use the sendonly join was to reduce the traffic on the Infiniband
    fabric otherwise one could have just stayed with the regular join.
    So this patch may cause users of very old opensms to discover that
    lots of traffic needlessly crosses their IB fabrics.
    
    Signed-off-by: Christoph Lameter <cl@linux.com>
    
    Link: https://lore.kernel.org/r/alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

> > > Index: linux/drivers/infiniband/core/cma.c
> > > ===================================================================
> > > +++ linux/drivers/infiniband/core/cma.c	2021-01-25 09:39:29.191032891 +0000
> > > @@ -4542,17 +4542,6 @@ static int cma_join_ib_multicast(struct
> >
> > Also if patches aren't generated with 'git diff' then I won't fix any
> > minor conflicts :(
> 
> Well it was quilt ...... Do I need to put it into a git tree somewhere?

If you are doing this a lot get a quilt that can generate git diff
format output.

https://lists.gnu.org/archive/html/quilt-dev/2015-06/msg00002.html

Jason

