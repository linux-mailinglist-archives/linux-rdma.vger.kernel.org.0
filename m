Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC02EC5C6
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jan 2021 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbhAFVeD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jan 2021 16:34:03 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:20625 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbhAFVeD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Jan 2021 16:34:03 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff62ca10001>; Thu, 07 Jan 2021 05:33:21 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Jan
 2021 21:33:21 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 6 Jan 2021 21:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLxIL7mC8gqwJNhHkDnGLYOC4/hllSLxh5Ln20AGW+zA9AjmJScHrD4MEh5SUQ/eFjOR+e28lAKaG2BOxGN7EahjYgljspv1n3kYFOYJ5+L8v9MbXV0eGMR4CH6ycdTVdEAu1vy1MGvgPrwzeABLj3IgD0ESHkD/4Gwkl6/H5+i84eKbPY+hss6CIor7HfIo/dbd2Z5XWGGQncEGRfU6Xlp2Ll+8VIwzITdSy2n4Wsl2T9TswDOVxfwrCcuLcVEmXOgjUrBa4LtVGGUpeNqDXm8QvsQMLa3aHEuEeimQN/ffOMXlyMwGT9cWDiP1Msihcg9UHAATjx5I6w8ZXeuV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJgex0DFKwo68rzQZK2gxVVQb9RoLyBqyeQnHFi+lII=;
 b=YXZ7ZHQGLdD/uOJhcK5M5RbKiz1Wz0iccz9T2tkmUXMN0dv+j8lX+iSynapCbZ3cB6A7Lhgy9QxyA4e1Ah1uI4JE1O/7naoKjx6+vfkLCdMji5En1rbfuYeAo5AoICKZ8M+/mvv38gX9Lp7RqDmdVIOo1TOvu8EFhZ3bYvqMYenXwAIb7N2utoyIZ+YeFGDNQsgVteF2OWuYE+qORMyCKbpwMYrDeFI+WaWoudGwGJuhhb1+eCmVRuxc/DCB+oc+HXnZDQKtz0tdQxl170fccYcKW8KJY7XXToWiejoLwBQALfzFUSsOBC8freuhsK0HP5AQCiOJHl0BHvdYALtHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 21:33:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 21:33:19 +0000
Date:   Wed, 6 Jan 2021 17:33:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/ucma: Fix use-after-free bug in
 ucma_create_uevent
Message-ID: <20210106213316.GA825697@nvidia.com>
References: <20210106122212.498789-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210106122212.498789-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Wed, 6 Jan 2021 21:33:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxGQe-003Sqc-W0; Wed, 06 Jan 2021 17:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1609968801; bh=IJgex0DFKwo68rzQZK2gxVVQb9RoLyBqyeQnHFi+lII=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=kEGH6BmkMBw7iSVMtRj3SaJnbEbD/k3kaiJRRLv+DuRgJ538Q4MKhF7qbEo21uaRe
         BIbVv70uybKBm1Dp6DH5qUC03gEbE/feWQXlq0eHzDP4C/IS0dpldFxG9pYZoWvHH+
         DGiTB61dSOREL/LIx/BASrp9kOPhYx0aH0/Bn36IDY/MrYcLZ56MCabhi28aOm+oep
         M/QrrkM5TTGh7N1Qrv/ax3Zq5lIVEAcN5LMq8BdTJy9XH49RGacl8mbBTONH6DO4Ah
         +EZd4RsMzRq1IP5teQF7C00zmaOEz+QCfJpaoIXvju/mKrmitLdDIy+hxsE3MiMcQr
         hBKy2rdYBX7YA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 06, 2021 at 02:22:12PM +0200, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index da2512c30ffd..d6cd72ff213b 100644
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1430,6 +1430,12 @@ static ssize_t ucma_notify(struct ucma_file *file, const char __user *inbuf,
>  	return ret;
>  }
> 
> +static void ucma_flush_wq(struct rdma_cm_id *id)
> +{
> +	if (rdma_protocol_roce(id->device, id->port_num))
> +		cma_flush_wq();
> +}

The problem here is that rdma_leave_multicast() does not cancel the
work it created. It is a bug on the iboe side because the normal IB
side does do the ib_sa_free_multicast() which cancels its callback.

The fix is to add a cancel work to destroy_mc(), not queue flushing

Jason
