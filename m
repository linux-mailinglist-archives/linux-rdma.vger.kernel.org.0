Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5C31571A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 20:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhBITp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 14:45:58 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4887 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbhBITkJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 14:40:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022e4d40000>; Tue, 09 Feb 2021 11:39:00 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:38:59 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:38:53 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 19:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRgua/fCkxhwoSdE6/pTTBYKljjWggPUJsbNIjNLOVsIXTJB/6OYDi8pJurk5iV7KlvMs0JIHTE5ECKYIzKPHSGn9hTk1SdpKmk6SxvVveMAdR8n//ehOA5uP8/8+yLPnvJ/w2A/OmpLoVrQEr6wlk39OT0MCk5ew7oFvGzn3oyorR4frjrH1IhjKO8BNv11Vl+HFrNVLOe3sjjXmpZ12sbAuGKBjnBmOrtHzEiuLL/6WTOCumjghopZUl6OVE+VQcbpPJfcP+9cBrrOSgESqzCfULRtQxoQq0OssYXwG5HUvgcGBPtp5islp414U/O+JsEW9bi1oHSDwxj+UqcqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6uVMZcroOYS+fJNeEEAvgv0uqfE2wY0UMvg+qqHUT8=;
 b=Unt5BJ9f3UXtsIcOrXwRBeYFjbdTEkOwZ682aLhaT6jXuZo1Q4lwxW5A3BP2e5F6xcsLLpOgCoZZjW5tk05IhTu1M5zjuwhtK7GdrD7HAJAgOxDPlkk9GxlvRhz41KeWFfn1S3X7GHBGHipsNTVpb6ghnGlTgE75hHddw/jfaOrRFcTnmlN3l+fjM90L41m64JkugcGSTPV2CvjjAy2W7H1myRLRp33EXknudz7yYdLxBCkBXNPWZsL+tY2yMeeGa+YjMBD5yQ0qSpvUpc3K33iqUFfGcAQm9fimSbbURH7THhuhVktzsMXwbs0sQmiVzhTY6o3G07nhH6/u+ENddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 19:38:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 19:38:51 +0000
Date:   Tue, 9 Feb 2021 15:38:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <leon@kernel.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic
 Context Attachment
Message-ID: <20210209193849.GR4247@nvidia.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:2d::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:2d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 19:38:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9YqX-005cP3-RZ; Tue, 09 Feb 2021 15:38:49 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612899540; bh=L6uVMZcroOYS+fJNeEEAvgv0uqfE2wY0UMvg+qqHUT8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=rBtUCtJ4Tn8mX3/6ijWubBebt/xvyYQfaA2nh381Wqmmo3hNOHA1eKCPSv3nFdBTb
         AIlhwZCy9dI69MIq84mlKVnebcrVk14g3y6sBwFR2zfr50xwP5hBg2PrnEKbrfjzf3
         IyfjRlcbjWINmyIOS4hFE80ut3fPWBrca8hKDLYvYb7d4Gr8FrjA46vL9k+xe8vtAF
         PTAqLTQRlanwym4yZyyqEQO0RzAw2yG9y97M+NTO1BPD2oHLX6meqAYIaMaFwQC7yl
         JJsLvllyOsD4LwIsBufEmC6OkxvleOYtLWz8oitMYhGdziytoWaNYw3q2OgOYK6Y7y
         5CxQr/a5NnrXg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 07, 2021 at 11:12:49AM +0800, Weihang Li wrote:
> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> enables DCA feature, the WQE's buffer will not be allocated when creating
> but when the users start to post WRs. This will reduce the memory
> consumption when there are too many QPs are inactive.
> 
> Please note that we didn't find the right way to get user's configuration,
> so in #4 we still use environment variable to achieve this. We will be
> appreciated if anyone can provide some sugggestions.

That is definately not going to work.. It should be some dv thing,
dv create qp or a dv customization of the parent domain spring to mind

Jason
