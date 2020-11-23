Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60922C16C7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 21:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgKWUbm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 15:31:42 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13053 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgKWUbl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Nov 2020 15:31:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc1c300000>; Mon, 23 Nov 2020 12:31:44 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:31:41 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 20:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhV3Gdx83mICDStyAntP4jos0fz2uzA6G6/vo5a5AlqB6qPGZ1A4QhH6Qv5GnVqeyK99mHheYpCR/UudW1vo3Rwj2uET1ebNs8AX8Ednj6/c/WMyCDDLuR90zxyz5uSj6VXrMK/P3rPCNa0yPZ8zmNOXCrh4OmVKs7WFr1GY6BrdRxJHMg8ozz9WEL6GNC8WPkXod3eLNtfmCZxbgAv30ATUs33pz1p4pnr3hmfZnZTUf/Kc22YAm1A2Io6vHFXJnDgLcrHbu1d3rgj+uiebvgbj+tFR3CGTitFWWJGyrgdssOFWmpJXsCX8yaAeNXIW5eD+i5W+WNcjLxThiEFraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QGft7MvfGwuBf+3h23atqzuSDUsvxMIOx6Y+kXYV00=;
 b=dkIFSkB0BzFQzjC0mlaLT+l4DL8/EPOW81Dc81/QB2U/EP/ZOPdUS2cQ6kq3EZy+u2plcEtLu955KVWupcfjNjG7AyJ0p+EEMtzZWAvm5vMzurEmNjG6qnfkkh/sAh9vTvQZ2L6QqG255AH8YcGungTU6ul2IJmGjROADZCViMdRJ13WG9UcJamztwolsyekMcVpvctEZabkmnnfJrGRCkfEhKvEXN19FUL/eTGy0FzoO6PBhl/r6yjDoF+5MrIGD6Ejz88yRGJ9rwhGOG1cn3tkLJDH2a2WbhAmQP2/LwypOXT/DoTbefwMNileVOUmER8XSVSZ2DQYT47Z22nMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Mon, 23 Nov
 2020 20:31:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 20:31:40 +0000
Date:   Mon, 23 Nov 2020 16:31:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] RDMA/cxgb4: Validate the number of CQEs
Message-ID: <20201123203139.GA85441@nvidia.com>
References: <20201108132007.67537-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201108132007.67537-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR20CA0048.namprd20.prod.outlook.com
 (2603:10b6:208:235::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0048.namprd20.prod.outlook.com (2603:10b6:208:235::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 20:31:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khIUt-000MEi-0e; Mon, 23 Nov 2020 16:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606163504; bh=7QGft7MvfGwuBf+3h23atqzuSDUsvxMIOx6Y+kXYV00=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=QLa1eKqQL1zhcYla2xdCflFfDPa6/LKzEOHSsmlWVbt5QqgY5Pf1wZVRQKBFd4FcT
         QOUXxPjuwxifB8HZwBn2WOD3FN61zQthYtokaLpoSs9BRmunp5G/jr14JWUu7x2GTv
         hz9aIB98cv7mXWuo2QhutWHo3Ru6oEabjqLyss8ujGy1jv6eN5Qvww1vNIzTgRFoyT
         AGxlJ1b0Zk46KjaQtpPeSTBfmwTFNc/tCaoVf6wObs8f5ijopmkYDMTWzAaKCTJLWR
         eUk2LKBpnuk2VdD8DtMQSMxfJSjjbcWXkc2qrWt6Jzpb6SvaXDuE++UvS4yqClrR2b
         4ECymAYPNU2nA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 08, 2020 at 03:20:07PM +0200, Kamal Heib wrote:
> Before create CQ, make sure that the requested number of CQEs is in the
> supported range.
> 
> Fixes: cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb4/cq.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-next, thanks

Jason
