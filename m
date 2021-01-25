Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FDC30353D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 06:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbhAZFiF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 00:38:05 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17825 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbhAYPq6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 10:46:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600ee1b90001>; Mon, 25 Jan 2021 07:20:25 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Jan
 2021 15:20:25 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 25 Jan 2021 15:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrOgbmciVilVQmNERElcSMQWyA4susIXNtafwLLZYIfP8AsSnr2dl94dGylSsdc9mjRY8zS9dQ52zmUDgHSQ2U27WUFwIcsMU+pFBVJ3XyKgBkrESM9OLYspLetC2cUBN64RYVTV5kdni2itWurZMkmDG34Rz77YmccEHiAqSDvsdLCZclVv2cSmHg0mfYnbT2wI8Rc+Y6e/0ng6o2SHgEiPZj2ImEvGTfmtDZj5sPxpWVRHpxzEmS5givGb3u667dE2KjhmgePemyinzb3tTdu3V4OFwXTUMuDQk7W/+P5cQ6kfoNSFjmljXNgMtkRIw/jqE/JkICX7x0blpja7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBZffCft+fw2plvSjJuORdwKIoPkn2d42p3ZJY8O+e8=;
 b=VAH40BSYUQQB/BTHAoNYG48boNXNbuqq3pslnFW5ckvesTaLgTcXURgF8u4/1hF5q4V8QFW+ATle8PpTVOcmmnumTMroGhIe8/WKCDVd2IFH7Nkmqm7NPyFmVhqBtKOH7l4aHA3+fc6+hFS7BcIkt6xlxMtuRFl/uKF+7WQ6C754Q46yJGTYqAIH77+jWFHS8crcZk1eScs98XjulMTw/rwgd1kd/fEY94NISt0+P7iTM8QYAnErVkUGVraaaaHD3+dHNzR1LxWd3AoDVu5TKL9S3hJfzBBaM7puRavt3UUoHABpzlzxcEuC15zvI9IlHVImjxVdbexLMN+RYeEh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 15:20:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 15:20:24 +0000
Date:   Mon, 25 Jan 2021 11:15:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH for-next 2/5] RDMA/rxe: Fix misleading comments and names
Message-ID: <20210125151522.GM4147@nvidia.com>
References: <20210122042313.3336-1-rpearson@hpe.com>
 <20210122042313.3336-3-rpearson@hpe.com> <20210122192725.GG4147@nvidia.com>
 <CS1PR8401MB0821842A2477AB7CE0B8290DBCA00@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CS1PR8401MB0821842A2477AB7CE0B8290DBCA00@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MN2PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:208:23c::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:208:23c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 15:20:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l43aM-006XNk-MH; Mon, 25 Jan 2021 11:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611588025; bh=yBZffCft+fw2plvSjJuORdwKIoPkn2d42p3ZJY8O+e8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=fUj2ri0MyCfVmIfs5K/rJ3I54KYSk24KylLY9QIzWO6jBx/iXPynoeJU4FhgeGrg2
         5k61R48NR23lL8VxojRDfq/jJr5/66YFZnsTuTJjYN48l72JglC7QNuIakCrOZf4K6
         Ai23lfIfRn7FkkiXs/FYDlQKuFA5p+jKwcnS5UpohBcs2JGU96Y+1Fy757Q6EbtStJ
         l4un1BrUarIaZTmu6hkL2wE81dfc2ahxtF/5BV4zaC5rvmyQEM46vWba+NIZKTHZtE
         Y41fExJcSRl36vcxAfqoHIiG8q7LjkIFmYaz8vCbXp/0JcP99BMTvSBzH8aZTwxNac
         5THbDjrIwchEg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 22, 2021 at 09:48:21PM +0000, Pearson, Robert B wrote:

> I have both in some cases. A #define and a locked version in some
> cases. I'll try xxx_locked().  To be clear that means caller should
> hold some lock, yes?

Yes

Jason
