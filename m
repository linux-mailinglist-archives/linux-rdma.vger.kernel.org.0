Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD762C269A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbgKXMzX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 07:55:23 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:37709 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733265AbgKXMzW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 07:55:22 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbd02b60000>; Tue, 24 Nov 2020 20:55:18 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 12:55:18 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 24 Nov 2020 12:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSvzx9ht9qPbnHgIOF2uy156/1Avv0hB8PKD2qDLbLlMYypO5JsANB9oh1XG227mqaWAUwb6w8N7zV15UqSjlnx3f9xEa1+8rvmVrHFHtcx4lnjdTJHfgZAOkOuBD48m2+k09PtRrEZaqrlvc4Od12YuIJkfiaNvOdiS9JtrNIuwZcYisZ85ZrFBUNguZ1vSYr+dRyRtACF+4OGszeZ45WtDdgfS9Cidq9E7psxDPjeX94dZbyJHupNJKm3w06iwNAPlSJ37rO2dgbnOcGrJEwzUWq3CrLUgOeOTQOW+0Yod0C/GRj6fZd2vclTgxFLAn3BFPC3D6geWxWy7yhezFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do2HQg6+NP23aqNwbeJuyw+TWGJch7Ff/6hfUrkfCr0=;
 b=j5vG/dHCeKYsxPdeAjk+WEl5PBQvTvJEp5RlSDvXDHzq3QfprftcpksFqx6i2agmSPFOnNU5U57ZpgFgfhMjCMaLNBtxmHf0U+hDD0QgPVYlDVv0eRPsCzeS98A3jUtd8gN3MrWEwTARJVu+8/oJZMsVxPWBmnZcij6sFrpS+nS5157gLOihg3EF1TLJulyHFei4TJc050AiiiMielrAMCsJW6x4r65sCzcn40yHxQU0yaqhQcJcKUHHZWq/ly7CFc6SSw3BjKrs0IV82CJe+HMela85clwYkRDSosgHgwo5343BSByw8mYG5H75R3+GWqWFd2I471uS5ZS1zqg/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 12:55:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 12:55:15 +0000
Date:   Tue, 24 Nov 2020 08:55:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <dennis.dalessandro@cornelisnetworks.com>,
        <mike.marciniszyn@cornelisnetworks.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] IB/qib: Use dma_set_mask_and_coherent to simplify code
Message-ID: <20201124125513.GA85927@nvidia.com>
References: <20201121095127.1335228-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201121095127.1335228-1-christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MN2PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:208:237::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 12:55:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khXqj-000jiS-UC; Tue, 24 Nov 2020 08:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606222518; bh=do2HQg6+NP23aqNwbeJuyw+TWGJch7Ff/6hfUrkfCr0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=TECiQojiFPlsFp9RIA04GGM6quEMo7Aef20u5gu9tihiSwOwXgg3pD8suDqwU0wpP
         Df9aV+0hW+4dSlWVXrXjuI7F6qTlOFW47xM4KxilUBp1+Vl0H2PUFjfLdpsA1TQzQP
         36AiWMoPYzcvPKMl0C+Ei0zopQwAyADM/6PoWFtqUclmnsOkPIkODr/zPYzBPGw4V9
         al9k3rYVm61XiGdi3Dt9iAdpaj04mPeEGccebzTBqqhiwUj6D9YiJbwWJLVF7t4Vp3
         t+KImW7UuZ9KO9AnqWXfNGXYoxuX+MJlxRk1YEfqe2fHUq9OVfxChdluBJ+pEhBmV3
         odVuKGc4k771w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 21, 2020 at 10:51:27AM +0100, Christophe JAILLET wrote:
> 'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
> an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/qib/qib_pcie.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
