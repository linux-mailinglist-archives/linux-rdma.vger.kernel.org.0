Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78D29999E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 23:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394213AbgJZWZ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 18:25:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12465 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394196AbgJZWZ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 18:25:58 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f974ce10000>; Mon, 26 Oct 2020 15:25:37 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 22:25:53 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Oct 2020 22:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HytROxR/ccn6PrOLZZrWOaqrcQkA/28bJjfvh9bgsF5MchMzYZxYsufsxXN0rlbBfieWq7z7TkHv7sALwq9KIduqCOfz4KnF/qAVSqds77Rsih+PDnOMKk5haWQ2pAoVGFLs+KlwaUz77fkCLlLnw6UVPqyL4LUUTDnbEKWYQ/2KqqQONF/hNJ/o7XFs5ZbmoN2tgZgGJ5nqPuyxGYVax6Fi1L7Ta8HFqTLOit+54FrZbBgPx4KxAMvkgEbo8CE4dDB64ZXswS88Qk4/cH95U/uB84G3aFgTfJ2r+6GmAwX3AYArZGh+nmhdbXtMcJ3VJD723c3Aec+zNR759uyNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4+1LH3S0k1C690B3pUL9o5aKWsU4LX+gMz3IrH8KeE=;
 b=EfWWy8Tf9IR5eo0Wz+QEZqN1uoiDqu8wpjb/wQksp98asFayzkpcBUyiMJOmxBCAf1giJhBZxDvYETDtQz17dHUO5SqavUh1185JfCyePktjaG3Z/NsDxWT7u6DI1vornO8RIOXKuBINu35E1z+zUWU2HxfiMiL+lp27BvKg8705z1k1cp9mw/5Co/ps5G1tzYctxctbr20jAIhwzrbWFiZxqMcREHfdSX8gG3lnt4o2g7yDI2uqH1qPjax2Okbn1YaXbWAYJL7MqTch7h5dStXrKKY1j253qUhwhboUjrkx1izSQQp0JK2jrS2x+XEz5NzcIU7+9HfXOQhC13Cpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 22:25:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 22:25:45 +0000
Date:   Mon, 26 Oct 2020 19:25:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "Devesh Sharma" <devesh.sharma@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Set queue pair state when being
 queried
Message-ID: <20201026222543.GA2067062@nvidia.com>
References: <20201021114952.38876-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201021114952.38876-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR19CA0045.namprd19.prod.outlook.com
 (2603:10b6:208:19b::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0045.namprd19.prod.outlook.com (2603:10b6:208:19b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25 via Frontend Transport; Mon, 26 Oct 2020 22:25:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXAvv-008fkY-1r; Mon, 26 Oct 2020 19:25:43 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603751137; bh=I4+1LH3S0k1C690B3pUL9o5aKWsU4LX+gMz3IrH8KeE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=qwIhT5Rr5L+nohgQNMbdG4MZ2rx7SEM6aSegvIA04qW67PKlFjwyzXTYE+cJBV29R
         m2x35bEGs2QIWoUjzKNIGcb6BSIzPl6NlIS6/Hb3IxOMsHQGE90YlXJj5AB5t57yxL
         tVlEIApSbXzcmYRJmmGWldVlOatjc6qXyqbEhME80YN4tbJ9InL0JWvRY3pMxyW/i1
         AMHSPs82NHMRdZXCf27jp20IDBK870CwmgyLuxxyIAOHjWuQU9eGnn+VIhDp8D/L4d
         KwDDgHDYqNMJJPYCme99xjgQJ/6WCGpJPNam7ZlNivAqMPSL5FMmEj0/tXiQYII+At
         IrPEgawIAf56Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 21, 2020 at 02:49:52PM +0300, Kamal Heib wrote:
> The API for ib_query_qp requires the driver to set cur_qp_state
> on return, add the missing set.
> 
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 +
>  1 file changed, 1 insertion(+)

Can't see why this would be for -rc since it has been broken forever

Applied to for-next, thanks

Jason
