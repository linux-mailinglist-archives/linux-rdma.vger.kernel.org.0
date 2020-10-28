Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2829D5BF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgJ1WIb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:08:31 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:45024 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730339AbgJ1WIa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 18:08:30 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f999c260000>; Thu, 29 Oct 2020 00:28:22 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 16:28:22 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 16:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je5MjEluuBpQPAvHQS3Kn8PQMFwGE4wG0iBgO1ssO9PI64BzFluZ49jBod8yaNq5C6st5Ax/nY8ETJ+SCY3Jodv5z0vQFA9zdlhk4E+hpTAc4JRNJ0hZp+UM72roie/GEEVIePZ+eGN089fR2jzRCevnBuN2RpToSP0jMQmfDe5LYAShHb3LSpeW5uqWSAS1BB8RMH48D8ijAOYbR6+1r5SukdwILHOaBXikz6JIG7BVstHxrhtQ1TAl1X92CQ6CchqT1COqHuwTcV3tPrc8BFCsQZgg1ydsuxWkcKXArE8Lot2d4ejdFOqWWS9tDkR4cRk2B/kaUNuvuqimqnxboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9XKxWM41PHbejEVQiBxbz8AFGPDCbFjDvDqmKpI2AA=;
 b=ehZLM9IOYysmEcQ4dKdhvTXqiXFV74n+wNFdGHygZRb5jrgEqf1szZ5WHrYELscfQRPlPlANs2Ujqc2UP9PfFz0DgH6L7s5eoocvs7LqZpdbnNJchepIAaVeOYQ98+gk+oZRNE3zkV2xBBGrQarrIMA0YJF/Hun0hfqoLWT2Vf6MtHV29pFGh5DRbM1DasE2oOpIw4ZldKVqNBV3hzxI+4wAp9ZpHAZBUucoA2X0S5XD+nU1HjpRDh/Z2O4nUs6SWRNTTpCjL2Eb121RiyQ4Tex/WjvSR5StV09KN8cKeQHQja7Gd9WMvc6/D8vJgbv44WJtLHNAgfr4mQQwoLY1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 16:28:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:28:19 +0000
Date:   Wed, 28 Oct 2020 13:28:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, <bvanassche@acm.org>,
        <leon@kernel.org>, <dledford@redhat.com>,
        <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 00/12]  rtrs: misc fix and cleanup
Message-ID: <20201028162817.GA2448145@nvidia.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
X-ClientProxiedBy: MN2PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:208:e8::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0004.namprd20.prod.outlook.com (2603:10b6:208:e8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 16:28:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXoJ7-00AGtG-U0; Wed, 28 Oct 2020 13:28:17 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603902502; bh=C9XKxWM41PHbejEVQiBxbz8AFGPDCbFjDvDqmKpI2AA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=X8O7hqDx5Wxc73I7mQDuDFK5yjX2LsEx8TMDKKk2y+kzsjq50R94l/YaPPWy5HShc
         MWAYDqDJkfOWIzjJtODHj7APzugqf04i/4blN4h3zvOacl1NmeJKeUK/Eo5ZGNMcXB
         sm9pK7nZTXqdn+ZmQyzrzEzv047791FHMvmxxP46Qk9VMwsuq2bekuHZ5mYLjjbzTa
         whW3M82H2m3D7DbYGe2Wf8e2TcN8czQgH1ocGEcAAxnzoKgloHiAA7CGD7HNljoLIy
         Zk4g885pI9EYnYNjC5/aiDjgTKrYEjUtZRZtOyJkrVeL3mz6h8Iioc1bELUNQuHgFR
         UzlUYzxNXgEQg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 23, 2020 at 09:43:41AM +0200, Jack Wang wrote:
> Please consider to include following changes to upstream.
> 
> I re-ordered the patch sequence so bugfix comes first, then cleanup.
> First 5 patches are bugfixes, we also added the Fixes tag accordingly.
> 
> Thanks!
> 
> Changelog:
> v2 -> v1:
> Droped "RDMA/rtrs: removed unused filed list of rtrs_iu" merged alreay.
> Droped "RDMA/rtrs-clt: remove unnecessary dev_ref of rtrs_sess", buggy.
> New "RDMA/rtrs-srv: don't guard the whole __alloc_srv with srv_mutex"
> 
> v1:
> https://lore.kernel.org/linux-rdma/20201012131814.121096-1-jinpu.wang@cloud.ionos.com/
> 
> Danil Kipnis (1):
>   RDMA/rtrs-clt: remove destroy_con_cq_qp in case route resolving failed
> 
> Gioh Kim (4):
>   RDMA/rtrs-clt: missing error from rtrs_rdma_conn_established
>   RDMA/rtrs: remove unnecessary argument dir of rtrs_iu_free
>   RDMA/rtrs-clt: remove duplicated switch-case handling for CM error
>     events
>   RDMA/rtrs-clt: remove duplicated code
> 
> Guoqing Jiang (5):
>   RDMA/rtrs-srv: don't guard the whole __alloc_srv with srv_mutex
>   RDMA/rtrs-srv: fix typo
>   RDMA/rtrs-srv: kill rtrs_srv_change_state_get_old
>   RDMA/rtrs: introduce rtrs_post_send
>   RDMA/rtrs-clt: remove 'addr' from rtrs_clt_add_path_to_arr
> 
> Jack Wang (2):
>   RDMA/rtrs-clt: remove outdated comment in create_con_cq_qp
>   RDMA/rtrs-clt: avoid run destroy_con_cq_qp/create_con_cq_qp in
>     parallel

Applied to for next

Please note subjects in RDMA should lead with a capital letter:

   RDMA/rtrs-clt: Remove outdated comment in create_con_cq_qp

Thanks,
Jason
