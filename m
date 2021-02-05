Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14A2310F56
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 19:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhBEQSh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 11:18:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11835 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBEQQI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 11:16:08 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d871c0001>; Fri, 05 Feb 2021 09:57:48 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:57:47 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 17:57:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6GR7DQhZj7dkChhmNmt4vBOlt+S6fe0Y86O7NTVLNpXSAzSJOb5DTo9eTnzMDfJ/g/UILdx2KgROgwXrfHW0vIf98ZNxGElikx/dpZR3vIyE/acRfAhVncuiwuZyeoCi4B67w6JsvpyKgFzWL0tIva1r/g29Lxr80w2kzbqtuSCs8mt+mdPP4byL/yeoK8R2JeDsG9gfZdBtMukTClvCcyZrM2ge73cg3mzgxemDcnWfSVvdebi9ob+a+PCphJHjtLGerKsot3JmLQqvh/LUhyOcJWmPVrO9oLm9IocqYN+k5msR3Zen989P+zkRDw005KDc2TMD2G1bfSeAH8r8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOjI+6clK4oNTfvwYE+oiTKqz5CteE05YnOznR8E+RQ=;
 b=I9MuysCHPMVZJ1YUffecy47CVZs2uAVY9w3q3K2c4prmDgXu/Lp0bAbST4SFB1zW9Xu0qHFPkgvfcSZxjAcUzapA9OgspitvMz1xxhQcdFVBv2DaA3nQotvSA+zC/EhVCnBz601UH9Tjvc1Isu4R/uY/8XadHhjeOB67OntA9j6cVDkeTRBuPeVBuk9jCwAu3JfCoVdVpoxbzNxehQpYpm169u2b6zeWdWImfG0t7nfBLiyp8IMFlapn4u6HS4r9/WYX1h0YI4JhL1xavOrB+C1/ghSvy/ETuEErv8ZoRwp6Dj8qWODOFrSPsZJyfola1Lu1m8unnjyY8cALW1sDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 17:57:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 17:57:46 +0000
Date:   Fri, 5 Feb 2021 13:57:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix coding error in
 rxe_rcv_mcast_pkt
Message-ID: <20210205175744.GC968475@nvidia.com>
References: <20210128174752.16128-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210128174752.16128-1-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0358.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0358.namprd13.prod.outlook.com (2603:10b6:208:2c6::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Fri, 5 Feb 2021 17:57:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l85MW-0043zb-SH; Fri, 05 Feb 2021 13:57:44 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612547868; bh=BOjI+6clK4oNTfvwYE+oiTKqz5CteE05YnOznR8E+RQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=QIvlKOOVyMBYU9zF/AcgcjB/ul8RYKrV5lmm6b3A06E9ACXFXPCdhhtDcoycJjuJf
         bmxjebukUH4eonFPJLraM753/m0yH7osFEdyeQu34DFXILEXhbJyB2azqkXbxpjCbJ
         /upafwrgPMIW9l7JGg9qxOIQYO4CVteCB16Fxof4MSNOaPhwU+CZY/Fmi7pf8lnK6f
         v4P0Fe+kHMk7VGWVTA3OPcw55zmWHnlEJVbr8C8DUJSTxVwMk0ANHk3RrynTOjKZqT
         BNqknprjowHXrbQ67HdpyvdIj/CRFgd2wsBJbyTcwbM+hwTyUFjuRQRI/TIN4oqUuB
         G5BTOXOejmfUw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 11:47:53AM -0600, Bob Pearson wrote:
> [2]
> Replaced unnecessary if(skb) by a comment.
> 
> [1]

version log at the end after dashes

> rxe_rcv_mcast_pkt() in rxe_recv.c can leak SKBs in error path
> code. The loop over the QPs attached to a multicast group
> creates new cloned SKBs for all but the last QP in the list
> and passes the SKB and its clones to rxe_rcv_pkt() for further
> processing. Any QPs that do not pass some checks are skipped.
> If the last QP in the list fails the tests the SKB is leaked.
> This patch checks if the SKB for the last QP was used and if
> not frees it. Also removes a redundant loop invariant assignment.
> 
> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> Fixes: 71abf20b28ff8 ("RDMA/rxe: Handle skb_clone() failure in rxe_recv.c")

Applied to for-next, thanks

Jason
