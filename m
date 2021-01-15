Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5E2F85B9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 20:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbhAOTtY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 14:49:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5517 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbhAOTtT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jan 2021 14:49:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6001f1970001>; Fri, 15 Jan 2021 11:48:39 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Jan
 2021 19:48:39 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.59) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 15 Jan 2021 19:48:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAZPiK4cZGxlvGBpO5aqKLgglsRrWPY8sXG69/i5GCEBJ4ghQamvNFGNA41wMZOP+Ec7emq4M7bXswZ/uciLf7VYBK8Tmk0pdRlbi7zS/p5drW+39dqn9ikDDHiFJtb8HTseS4VbBLIO50g7GRVQrHxN+Qih2t5RGf8mV3htxtJiqfhNY7CJY2fjF7Wqi5gDEhq6eQUJVz0ZOKFvSgjvB4PwWQEyBZ/3SMxL58HkTlvaQhJQAWWgNbQU2MO1pePafHldcGGXsXj9gr9erdeoTd8UnGK86vYtbXX8aKhpsYNe0txMJzqXJysj2iD9h29nE/7BPqUNwmXv82ri+8/Jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzNOedQxF9f0dZhVGeFBfZ5yPIyMdVHnwQM+jMZUcOw=;
 b=VpmZhQCw0saZTsflmBMjKawtu7xf9eSm4f6nm+kk/ag7GbCGSe6GfVUj+jeuyKPCWZRXQyEV78/dKUmiJo6J2+hV/YBEL8AGu7rtebqlnm971r5Nw2Z4qIDr99u1qD5G9ibfokv3TcRU4OuOZ607ut3r0MK8oY1i+aSX0BcQgeGzpB9p5PGBSnEt44lrmVMZV6Rj9SEII6ppKydMF5Oodx7HDnx7hjNaMDnP5t1XW/Bd7dC3QHTw8DUVE/uCgi0S2g6Fzgu2O9BebxbSgU3Ho2Q9nOoyxISNSwebOwFJLb/A/Sf9YDkjroPx+nhb2j5wbLphgODzwk8UJfWd5Z3a/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 19:48:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 19:48:38 +0000
Date:   Fri, 15 Jan 2021 15:48:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, <bvanassche@acm.org>,
        <leon@kernel.org>, <dledford@redhat.com>,
        <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 00/19] Misc update for rtrs
Message-ID: <20210115194835.GA485446@nvidia.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
X-ClientProxiedBy: BL1PR13CA0485.namprd13.prod.outlook.com
 (2603:10b6:208:2c7::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0485.namprd13.prod.outlook.com (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend Transport; Fri, 15 Jan 2021 19:48:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l0V5H-0022Ie-Fb; Fri, 15 Jan 2021 15:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610740119; bh=vzNOedQxF9f0dZhVGeFBfZ5yPIyMdVHnwQM+jMZUcOw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Btj1aXq9tKAbf+LI2ikGkHpDPjh6zVXXjq5jsMGMn6p792ZBzv4l/fRInhqM7nIoa
         sWCQM6rDssU1klB+A8v/umWl73yMg+TZScfWj+MbNSTGeO9gINnmpsXIvawVxwRUf4
         GB0hZ0vp4IZx3vfkMJgWe+LUGJwFSm5C2nmGOB+93431DT03lY8LkCTfrAU+cB6KsF
         c31wZg/xEYGk6COKBmnrE2VP5S2s+6528dwu+17jyq7SrALOvpNJrJq2PhTxGJFpHX
         YF30pDwgPAzoS2n+6+a6xi0gKsajMLZt3HpPdzRdDWoPqT6BKH7LTuqyIQKSUKzxD7
         RCuuuOKZBgvOQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 17, 2020 at 03:18:56PM +0100, Jack Wang wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to the next merge window.
> 
> It contains a few bugfix and cleanup:
> - Fix memory leak incase of failure in kobj_init_and_add in both clt/srv
> - reduce memory footprint by set proper limit when create QP
> - fix missing wr_cqe in a few cases on srv, it could lead to crash in error
>   case.
> - remove the SIGNAL flag for heartbeat, otherwise it could mess around 
> the send_wr_awail accouting.
> - flush on going session closing to release the memory presure on server.
> - other misc fix and cleanup.
> 
> The patches are created based on rdma/for-next.
> 
> V2->V1
> * more descprition for the patches above as requested by Jason, also include
> Fixes tag for bugfix.
> * suppress the lockdep warning for PATCH 2 `Occasionally flush ongoing session closing`
> with comment.
> * new bugfix PATCH 19 RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug
> 
> Thanks!
> 
> Guoqing Jiang (8):
>   RDMA/rtrs-srv: Jump to dereg_mr label if allocate iu fails
>   RDMA/rtrs: Call kobject_put in the failure path
>   RDMA/rtrs-clt: Consolidate rtrs_clt_destroy_sysfs_root_{folder,files}
>   RDMA/rtrs-clt: Kill wait_for_inflight_permits
>   RDMA/rtrs-clt: Remove unnecessary 'goto out'
>   RDMA/rtrs-clt: Kill rtrs_clt_change_state
>   RDMA/rtrs-clt: Rename __rtrs_clt_change_state to rtrs_clt_change_state
>   RDMA/rtrs-clt: Refactor the failure cases in alloc_clt
> 
> Jack Wang (11):
>   RDMA/rtrs: Extend ibtrs_cq_qp_create
>   RDMA/rtrs-srv: Release lock before call into close_sess
>   RDMA/rtrs-srv: Use sysfs_remove_file_self for disconnect
>   RDMA/rtrs-clt: Set mininum limit when create QP
>   RDMA/rtrs-srv: Fix missing wr_cqe
>   RDMA/rtrs: Do not signal for heatbeat
>   RDMA/rtrs-clt: Use bitmask to check sess->flags
>   RDMA/rtrs-srv: Do not signal REG_MR
>   RDMA/rtrs-srv: Init wr_cnt as 1
>   RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug

Every one except:

>   RMDA/rtrs-srv: Occasionally flush ongoing session closing

Applied to for-next, thanks

Jason
