Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDF2F3DCB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 01:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436897AbhALVhT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 16:37:19 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:56717 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437020AbhALUmO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Jan 2021 15:42:14 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffe097c0000>; Wed, 13 Jan 2021 04:41:32 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 20:41:31 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 12 Jan 2021 20:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7a5wgUbz/Ks7IGk5ToDV1FvY5J50hb5N8ZlqcvbdkztP44smm53fwi8vtn8tu9oq3a8pWb/BD4C03Atv5hxQFPQc0ewMMGQmvk7RRyYsMr6L/3g+sxl3yMbUf10cB3mSgUUNg2y9IGk4x0xCJImI/PAoDjVZimC5+lejBcEAn5cjjVRrWgLWW/gIF9QkoBvMaxnBJDQMOZueReaOmHyJrtU5JJFZuk6NE6etPh4K6l00ydq/vfyFVgIrH8qCSH3iEdQmdkUmEaudLALtHAxrWcY6XojNPSVBILhvjgqk1sck98qYqX/aW9Og3yJBPUgWG4osOU7tMmPqLa8cg0ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQKjOtAL7NqBpVfuviDDBdJljt2iKAp9gZw5GRXhgiA=;
 b=iJNUm5IOItdAOTncgvattqahJVdXQkAc6lo4HJuj63X9lFPqSaUEcxYQArMUhhNqtG7ak0Awmeuz2+kyN7RqYwpf0ZB8B7LF7qiGyFDkLpvyae0z9p+Y2iw5N45Q1hP+0RedEOtVwN7tElPGuZ1nvQ65oGfp44vuFexraesNkTb6qwCxvXkPeN6SewZG52PSgM60E/OGP3Tne6Ow/jk6AukkQcsPCf/Q+tSoPd1dm+A+miLs/qeVppDZW7T7KRgi08gyxmYnfYWmoBMYRSFH5EAtCt1L8+ckHG6caZBA4PZu/l8E2dzdaErWXbB/fiyL/XLFul7X5utG/HYPmKDoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 20:41:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 20:41:29 +0000
Date:   Tue, 12 Jan 2021 16:41:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rxe: Add unlocked versions of pool APIs
Message-ID: <20210112204126.GA35902@nvidia.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
 <20201216231550.27224-7-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216231550.27224-7-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:208:134::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:208:134::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 20:41:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kzQTm-0009MY-Js; Tue, 12 Jan 2021 16:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610484092; bh=OQKjOtAL7NqBpVfuviDDBdJljt2iKAp9gZw5GRXhgiA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=sIkby1Nr/jBgrYdWFCa5nB9JqJ5Vvnd8sss+bGaF0EO51sGo23zXPzI4jmRwHYXt0
         KwtqPQxY4DK9sxD2AdL8TbU8c5DSKBQbxx6e1IBPgLX3hhKwzosC/OnwcjxVwzCEqK
         mGUly1EdkWShcNDomSq17mCLXG7wd+Hrqzbyemp0oevCoUlCP7Sf5bdcZIl6CiCaU+
         5hV/c9HtW4ItU52MPtPINxhhVco53mV7hDYxr/C2sfhNXHMBuHfz7CvkcyalPaDQ+U
         jfRe0vxCjYt/gYym7bdaQklC2xmoON/9EmpEVAJCmtYJ6tgbpkxsaBPd48Qa714OiV
         57FOuRFrBd5Tw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 05:15:49PM -0600, Bob Pearson wrote:

> -int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
> +void *rxe_alloc(struct rxe_pool *pool)
>  {
> +	u8 *obj;

obj shouldn't be a u8 * here

Jason
