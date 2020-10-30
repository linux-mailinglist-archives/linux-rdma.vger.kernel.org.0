Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B52A0B09
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 17:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJ3QZM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 12:25:12 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12836 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJ3QZM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 12:25:12 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c3e6d0000>; Fri, 30 Oct 2020 09:25:17 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 16:25:11 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 16:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI6yhskRnsUGKEauwVRUAGkEoKday04V3gwPV2mGytk9/pUN3Yl4jDl8pwpBWZfFd5/EELQsoRseY1Cca+5zbZWEa9xlmxVzyuFPgmbkv2X6gDY+UEwaxvlmNGIKeEjC/6s/9llUNJ3wXitmpEuebYWJ+eIBVHT1FGRRJ80ySS9ETSIDI0SGExBDbWt2L3x3/Af+QWX02pghy6uiCwNoU7BuAB85PwEp5WAB/OTnjf+PDRTfXkoDPP/XA3ShJskWKp+5q9IMtxcJq6R/fldfmpM59nmFYVPU9BePSP7znz0oBtg521jDIjj7P+cYZ9g7qwJhfm6ks6X65WLyoDGhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAc9fhaDTqA+NCBqugPoP4lAkdqgtBftHrEDr7vhjLQ=;
 b=KdKd/9hYctJj1kazGmL22HQG/ISYrxtUYAuNbHhJUh1HDR9ZIh5yXoWJlgfpwLgaRIck456zFtCXbLJIO/mwPv+YLE86ltGNTC4g2usUdxBaB4gmfRsx8LLMqLyiychVzV3kWr6AjEnx6EjlpbNX61WiVw0KhC1yYvysG7wscZVuM+9S3sC2VGhePgMn1uyjhBobGmDjpUlUdWseGkqF+OhqsfFGJvU5ZWOpTrMc6GEG8nrWD2yVVw6CkgYFPGANCyD3k9BswFKt5dXFfgsZAkkB1vB9/JNMEw5aCYMIrNVVA7gNXBSzNAwGTc9HSlyASBoh7Ijj8D0Z7my8Fjl4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Fri, 30 Oct
 2020 16:25:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 16:25:10 +0000
Date:   Fri, 30 Oct 2020 13:25:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     Bernard Metzler <bmt@zurich.ibm.com>, <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH] RDMA/rxe,siw: Restore uverbs_cmd_mask
 IB_USER_VERBS_CMD_POST_SEND
Message-ID: <20201030162508.GA3195718@nvidia.com>
References: <0-v1-4608c5610afa+fb-uverbs_cmd_post_send_fix_jgg@nvidia.com>
 <77c24a90-0df2-e0b4-02a7-6f88f2aa9b46@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <77c24a90-0df2-e0b4-02a7-6f88f2aa9b46@gmail.com>
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:208:234::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 16:25:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYXDA-00DPVb-Re; Fri, 30 Oct 2020 13:25:08 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604075117; bh=oAc9fhaDTqA+NCBqugPoP4lAkdqgtBftHrEDr7vhjLQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=nJN3X6S6U+XZMTqa8/9pzTyMlgcsM/fMrF0aU3eADMeuWWABT3D9IJb4kt9jsLsFX
         h4wx+W7KThQb1upXuYZwNAqg3tUGOnzHTCQIe6c62yC7MAQhhj5cALmOr5VsYZnRE9
         Fto3M0ZHwqSGbxSTwf2u+BfrHgVwftxIrHTO09fi4I1fJjbOiyKjKtyhi6901gX/Zv
         NcnWTULwBa7ffbpFgFPSGNZJulgGIa1jEhMgNwIYn2cfDMYTTUHB6tivcwJXP79/3f
         5GHe4aWLhSzP7e2+gGMZivfqaMMhRW0UCA3gKU3ivPbO9A07PVBOnH2brTrJCfg4wJ
         vOH6ZccRJSc9A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 11:18:15AM -0500, Bob Pearson wrote:

> This the right short term fix but seriously why not just completely
> kill off uverbs_cmd_mask? If a driver sets a non-NULL value in
> ib_device_ops assume it was done for a reason and allow commands
> through. Is there any example of a driver using uverbs_cmd_mask to
> dynamically enable/disable a verb? I thought this was your plan when
> you mentioned this change a while back.

The remaining ops are all shared with the kernel, so nearly all
drivers set the post_send op but only a few are prepared for it to be
called from userspace.

It is an unfortuante side effect of co-mingling the kernel and user API.

The only way out would be to split the remaining ops into user/kernel
versions and require drivers to set the user op pointer.

These would be effected:

        rdi->ibdev.uverbs_cmd_mask |=
                (1ull << IB_USER_VERBS_CMD_POLL_CQ)             |
                (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ)       |
                (1ull << IB_USER_VERBS_CMD_POST_SEND)           |
                (1ull << IB_USER_VERBS_CMD_POST_RECV)           |
                (1ull << IB_USER_VERBS_CMD_POST_SRQ_RECV);

I thought about doing it, maybe I should check again

Jason
