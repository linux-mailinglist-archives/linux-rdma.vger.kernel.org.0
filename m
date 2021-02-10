Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0AA316E7D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhBJSZA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 13:25:00 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1201 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhBJSWy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 13:22:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602424500001>; Wed, 10 Feb 2021 10:22:08 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 18:22:08 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 10 Feb 2021 18:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+hypw31tH14dmqoc0dZ1ocU1drRcnTLSYQAGNWXRhfbqnuRlo0XkNNsjIUAM2STW1F0P6qcUQY3J9C2ooCgO9N5N7/1RMQNOtAvfPMbQQ9xWyKFp/rHwy/jgwKftffBiOYl2J0HqIw0coiFbxUEhktl+sbS9wsaRsH/UN59+B82rg2eAvQiXLheM3zSlN5i2qruoAtPVwUEHgL0exjHaK8vrOP63f6qCpEJuvOpPI+zF/wNx5X30OeirbuJk5HdSwSN7DQ+SP5e/x2rSUVOcxtksO8BWjE0Cyhewct43AAmwwdjIKU63+jWU0BRpmfNOt39kzLMHjb3JxAxfzLo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nS0f6ubicUCjDr7N02lYYlUoUzuLW78BwRGVvsgf8A=;
 b=ePuP5nnUTGG3KG+tXb0kPxn+xk79FFSzT9yex8jP+RpCx+fVWJOKj5qR7TBsTHAsMYraRslPKfPi2XBrVm8Bf4eJLXxYK1++2+MC1E7FZaS347kZC3lD8yd6GhDNkFC9tOx1Mju+UHPTusJ9eaXov31fOjPZUi57F1ZIRXaCK8oXSnl0RYGI1ln2H20kW6KSmuiNEpBS0khbW7l2QDIiiETNsnQaCH2Ded602AWKEVl8yd122NujYSuTp75leimqZXviMwZvM2HuZMglb661sMO679/1VFSMKK12h6NTxQviBfGSWnAzFgopXMDNz833Fd2T/5dT5NZYmq95DiLh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 18:22:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 18:22:07 +0000
Date:   Wed, 10 Feb 2021 14:22:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Parav Pandit <parav@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix kernel doc warnings
Message-ID: <20210210182205.GC1470084@nvidia.com>
References: <20210210151421.1108809-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210210151421.1108809-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 18:22:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9u7p-006ASm-Fy; Wed, 10 Feb 2021 14:22:05 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612981328; bh=0nS0f6ubicUCjDr7N02lYYlUoUzuLW78BwRGVvsgf8A=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=rzSzvE5lUE+DFjkknVOvBjBPMDtdznM7difGhEcN1u4KYKXfA9J5H/RJcBEoE5g0D
         twgDQ29gBwlpLJcgjQwrIq7UEjWw4go7ANCgXPD63Q0p+IfkLTfl1mTHclYtwaO/vq
         DCsPxp17hezB9EwCJ6WJtME0gxRB1yMPV6IxEczhQan62g4NHR2Nj3zsoi61j7IQCi
         Vq4KeJbOzP5jCRXnsXE6Z/N/fUYvZByBwKRQv465i1C6M2th0NQglHUphbk9S2ccse
         mEQ02voa3Zl89MOiheGOHdIAxxnBx27uDHZu3NX4GVaKVAZ8AD3WUT6syzM13KNsFw
         itTiVKxfhtuMw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 10, 2021 at 05:14:21PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> drivers/infiniband/core/device.c:859: warning: Function parameter or member 'dev' not described in 'ib_port_immutable_read'
> drivers/infiniband/core/device.c:859: warning: Function parameter or member 'port' not described in 'ib_port_immutable_read'
> 
> Fixes: 7416790e2245 ("RDMA/core: Introduce and use API to read port immutable data")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next thanks

Jason
