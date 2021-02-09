Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897A2315725
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 20:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhBITr0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 14:47:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5245 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbhBITpH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 14:45:07 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022e47e0000>; Tue, 09 Feb 2021 11:37:34 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:37:33 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 19:37:27 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 19:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTER7JNY1PqusPXVDf+7A4QTVcqxq2NiMGwqQlJmCNwAvs0aFlWIdlowl4pJAIDgxIkGQe5bSn6AG7EPeOVphryb8VVe0jtfNR0EIRlWrag56H32uwLTYTfipU7a9fKhdKUKrBgBJE45BTjJPy9tMgEv1lbM14ntLiayrlLVS+zZ5kwQ8Y21ok8OEz7XftplGZc6Kgp76VzwETLaXLB2fpA2kiPl2rnnup2JxmZ1ldJASMg7NdncCysqQ/UlIt+BLNZDG3ZI0pcFyChAMbGag4+6r7yJZAqk0B/IQ4y5o+T0cVohJXuKMGL8sccwoVHsNkoYFS3cBfkb0ruoiS8PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKS3mUK4K20hym2ByaGQIgasnROXIM3uCl1l+oi+MuY=;
 b=KKZZ2FzpqmEUbgo6rgc53VKS2q4sBC7Rve0aoZZNEmxvzd61jdusmxbAqp6qtTWG3NJJ/GEcQ0NazisvyQgttcb8h+TdPjsz7tsL7ZGjr+nx43W6jvMyB63+qOKPjGXCZqT2PVl/0eQbJRfFopaBbW72NBCybkCOS88s6tJyMKF+hVOMuPQbgj5BS/4M8pw1AZs8FC7E9bi8Nbb09MCHOxQcD37zTnBd8+tPd+J6KJ2Mld/0iqzruzET852NWZ3QSrVNTI4hVO+spIsPIEa3tlyxv4KORuKQm8zkj7YKgr7V/XHNyq7qAXWNabuT1dPjBZrIINuotIC8/i3wa8Imyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 9 Feb
 2021 19:37:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 19:37:24 +0000
Date:   Tue, 9 Feb 2021 15:37:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 for-next 0/5] RDMA/hns: Fix and refactor CMDQ related
 code
Message-ID: <20210209193722.GA1339019@nvidia.com>
References: <1612688143-28226-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612688143-28226-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:208:257::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0031.namprd13.prod.outlook.com (2603:10b6:208:257::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.15 via Frontend Transport; Tue, 9 Feb 2021 19:37:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9Yp8-005cLs-SL; Tue, 09 Feb 2021 15:37:22 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612899454; bh=EKS3mUK4K20hym2ByaGQIgasnROXIM3uCl1l+oi+MuY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=USHAooATTvkhH9NOKtkYlE7of9mPRddGeDoaq+pcFx3/e4KpOm3HpqciqTZ7IDJkf
         YRPbWEtJT98A9NrWPKzNLViQV7w3+6KWqLZhek7v9neF+sDLsienId0Z6Rppl8xcop
         KIiYs/mfay/XP6/CSwxYR3krxXe5uf32tEoExYFMm2qfB9WHduBfgYfBj1paHlcqx4
         9eAcyp05IgeTzJf9wsNCRihRCSxIJfPv+X2EaYDiLqDmIYN0LwxUkcO6NwXGxUyc/D
         rpXvwY4ZI/iNdpjjYhtU/8mfmLdOGih3WHxICDcJbYInPhGdda2+SZWKuufxNUMLas
         aOhB8+jSZmwgg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 07, 2021 at 04:55:38PM +0800, Weihang Li wrote:
> Remove some dead code in process of CMDQ transmission, and fix an issue
> about missing error code.
> 
> Changes since v1:
> * Drop #2 from the v1 series because the compatibility with the firmware
>   needs to be considered.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1612419786-39173-1-git-send-email-liweihang@huawei.com/
> 
> Lang Cheng (5):
>   RDMA/hns: Remove unused member and variable of CMDQ
>   RDMA/hns: Fixes missing error code of CMDQ
>   RDMA/hns: Remove redundant operations on CMDQ
>   RDMA/hns: Adjust fields and variables about CMDQ tail/head
>   RDMA/hns: Refactor process of posting CMDQ

Applied to for-next, thanks

Jason
