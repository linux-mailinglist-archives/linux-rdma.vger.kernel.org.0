Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61269283E0F
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgJESNl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 14:13:41 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:25678 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgJESNk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 14:13:40 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b62520000>; Tue, 06 Oct 2020 02:13:38 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 18:13:38 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 5 Oct 2020 18:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8j3fcyyYaeMuHVxbYWuGWPoMnBD9NPtMkK6qT660DC1NxNX5XJ1PldOwchRsMIRaSzO8oOmIrz7VZes0KHCFgwirJ/lw/au0g3dmyhc0ZzaW7qdtjwlmi0zp2DYts6vFNcrFQG9WwH0hYzBJ948I05EXzWf4XQLOgdqZ3/sd8w3Brz2DZ0EAJRf1EL60unX57xgOwBvmPiGSAELLxF6ah0twkaOwCQuuC4kgaQQS1D6paL0+ObHwWToJ2G9ZsJlGa36kN8eP2qlxMB1hOiQJZAfznwGMmcHKH28sqndwVMcg+vuBBJy0bWkdJkMrwtN8K2KgA14FmZkMqxwcDj1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIaUF2fXznxddIDGx8/NKgRFMlMx0KV7TUlrHy7H4l4=;
 b=dA3HLZHjB+TucbEqd8ou9qYWyA48tQ0V7hV54jzwC2OBo9jFftH/453m2IiLIYJZkLCzCAa5rZulXrQGDqIA20lph1x3AVHueQ2fiILSx4wH3lk5N6LEHJgtP7H9iQ+3Qe1AmzSC/Jm6GdT5hhvzveoSm9WN/lkiuWi80TVG7d1mcgKES9GTsL/0d57NMUlM/3EEMG+ppBv/73o8UOMoqTpInB0HiQapqmD/xG7BuQhRRxIY1G+W0MYr9biLbxMCiaebb3drVqBVBhGG5cfZfrEI942dnqXfDKPbLTFqOH7r0H/KPGQT4x1CeBm7dpIfyh6vCYlxLJxUdwbiWiXVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 18:13:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 18:13:36 +0000
Date:   Mon, 5 Oct 2020 15:13:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v3] RDMA/ipoib: Set rtnl_link_ops for ipoib
 interfaces
Message-ID: <20201005181334.GA31434@nvidia.com>
References: <20201004132948.26669-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201004132948.26669-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:208:178::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:208:178::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend Transport; Mon, 5 Oct 2020 18:13:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPUzO-0008E1-Ib; Mon, 05 Oct 2020 15:13:34 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601921618; bh=fIaUF2fXznxddIDGx8/NKgRFMlMx0KV7TUlrHy7H4l4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=aT47/y2pLmmOdPJi01tJHPH0HjtTEEU2gCjoUP2CjtJLDnSRKCrbF/xZemjDuK3Ei
         jTQ2zHE/6MwF/sPinqpFXyMlZxBTwhXrxb8y/yUpmKZYem/slt+wmhHxycFw+hLSHw
         QJfIofJLb+NOWUtAQVert40j9aD5AtRUxTdzs8A/MXtbyv5FiTPQUOnCUVRMjkFbQ/
         yLC/VsF4vt8D3COew2rxu4/8eEw/J4fGyCY2yATNzhuMuLLQXVGYjMkSQtIKbm6X9N
         9i118Ot6V6euDXuLAAOK+GvCjyZK9T4yDNuFlqZYNY9kBEQ7hWSu7OoYlk+QSJFrkm
         uZslIkWLbJyTg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 04:29:48PM +0300, Kamal Heib wrote:
> To avoid inconsistent user experience for PKey interfaces that are
> created via netlink VS PKey interfaces that are created via sysfs and
> parent interfaces, make sure to set the rtnl_link_ops for all ipoib
> network devices (PKeys and parent interfaces), so the ipoib attributes
> will be reported/modified via iproute2 for all ipoib interfaces
> regardless of how they are created.
> 
> Also, after setting the rtnl_link_ops for the parent interface, implement
> the dellink() callback to block users from trying to remove it.
> 
> Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")

This fixes line should be 

Fixes: 862096a8bbf8 ("IB/ipoib: Add more rtnl_link_ops callbacks")

Since there is no bug here until fill_info was added

> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
> v3: Move the setting of rtnl_link_ops to ipoib_vlan_add() and update
>     the commit message.
> v2: Update commit message.
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c    |  2 ++
>  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 11 +++++++++++
>  drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |  2 ++
>  3 files changed, 15 insertions(+)

Applied to for-next, thanks

Jason
