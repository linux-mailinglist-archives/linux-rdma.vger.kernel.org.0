Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C059347BB6
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhCXPIX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 11:08:23 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:36801
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236500AbhCXPIC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 11:08:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXqB6lzMeEYHPMlHoszmQcvnmTS5cuZpF2H8D0VHp9r0gU1vhrZ1iLXHOqRtFrcsQ61Jf76s+eaCbOEZBNX2ApDkX8P1r1BbNN2PiupgK1uEinCcEVgaPuy8xrdRJftkdcMtRSdxQC9vxXx0ImdbkGhZxM91smr4Cqdu3xZaZuiN+iYk2aksr9fkO5EUhI1iwof/8SZXK8Q8jYeKPlWvVB6ndM9Y+I/e1PhBYCH/D9eZPp1tMnuyibiqsGTzlwU64erXJ3eBAoN/QywLT+SuWPdpyfEsyxICUOR0UvWI+arkTZ6fxmOHmcEK+KNUJtOPx4rASN4Lbbphq2EMFy+xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZO3AWLQj+Gq/3/uAp8Hgon1dpUuaEqJM9thFEUqZM4=;
 b=Ei4HEbP7GHpEDK793PAVrslfxm8qSK/Fc6cGJSwQpXjq7uS4kluTBBePlf0y0XHt0H7aGt/zrG2kfdMLtW2NixpkASXg5KGJiADrTTwVs1a/YWk5JvdVOU0154FeYttITbdnUQgWEc8y0yqf35wOogmkuopl6QKPte9bLgxbmGa+7K/+T7mvAAXkPoGjEzCA+jqQ83OwEKJ181yP6wPDlh38kE+MqpKr3FUD0ujdQMpz+Lx26kVFIakf2HZlN7NGvViy+YpFYRWqUPK9WfTuklYvcM18KfqFKp8UIp9uFsWlYcLGpxlWtlrlIo4hA+AWJaKGTOrMwqPyyNMKGFNa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZO3AWLQj+Gq/3/uAp8Hgon1dpUuaEqJM9thFEUqZM4=;
 b=GNqIIIYgqe5GCn4wjQCD3+Jtb1UfZlC75/9pTtXt/p0tw46tjXqoUogczFG3kaQOH969cwplaeFSOMu/mKxixAQtahT6c8LenjsOoquRhGhImqcpsCnA70Ug08SY3Y43dO1eg+q4w6z5/DKesTeRfGI27PlEXG+UwOn3MduBWq6GPQwotoxFn87U5cK7rH7yH1gAjUP61zNhNlsmqDMZARgax6KPQRStJuvRID1+SunBLPbWLMLEY2qpSkrS9vXtbJQm6BOkfUr5+uDIJUQsgqAqe71BvRPlS20PhopD7nDl9zgQ+7/uHM632u5jC5ljwUHA15KSMDWJEyOEZaCodw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 15:08:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 15:08:00 +0000
Date:   Wed, 24 Mar 2021 12:07:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next] bnxt_re: Rely on Kconfig to keep module
 dependency
Message-ID: <20210324150759.GH2356281@nvidia.com>
References: <20210324142524.1135319-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324142524.1135319-1-leon@kernel.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:610:cf::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:610:cf::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Wed, 24 Mar 2021 15:08:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP571-0022mP-1I; Wed, 24 Mar 2021 12:07:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e16eb8bb-7b83-456d-6c34-08d8eed69d56
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1833C7544B7AD92FD0B1243CC2639@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2aKRhaZx02OtTVSRk+v0QGsqudWvwADkbZ5dJT2hHQGRX6WucuN7EBJ36fJpfkOZy4uJsIv6tsKLrFMn2ElAECdP1ibJ7eI77nWnWW4t0X9m5mr9YwR5ptjAmZaNIaBMeHyDXr0AQV4wEMPCfZqPCZX+xzaEqPIXDG4PvNq/nyD3VAvxym+u/xE484PXeoLs4AxlWApRB8Sb9wyW2yWoLV7exSZjET8ZIF1xk0qFGBHt9QSj3GZusD5XjSCwfJ74WFuyWQ+mjEhKhjTiuN/NJNPJ1kiq0xuRGz5vaz0hPvJyPkvBNUsyYaxr/KDbHoMJtTr87LDkPjmbzNU3Ck/z6lTIvrDRJaoWZdwV0ZKyc4hrkAj9ES0YBuNFlDo+MwZgXr7dSqccqEe4u3wTEa4nbPnfy7I5CmK1v3b2mSIOHT4oM2lKZJYM5uilqFTGwBJXGCoB7pQEUWjuSlKoeh9+3M4iTtciR57ha+rpu3cI1d/pMNgo3TSqr0n8zOpFV1QTj4I00KLbiUEccL1je2mLHwMfQ2uIU39DDcGS6bHvEqOfNbK8xu0qXqu+WxAtmVvNl0I9d6bM5Ocwq8wiBKE09o9/Nhsj6ermlJvBLhlIz2DzNAt0ClwkCVNmTswKU1SKZKdk4vCnYgsnaUaqILu0xDvmuv6zDMlEbFuR3exifk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(38100700001)(5660300002)(6916009)(33656002)(2616005)(1076003)(316002)(478600001)(2906002)(426003)(9786002)(8676002)(86362001)(8936002)(4326008)(83380400001)(9746002)(26005)(36756003)(54906003)(66556008)(66476007)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?COOUBJBjHOZEZOk9LggehojuOxqz2JDIQbYCEe1V4zCJyOqMf9woghhva20p?=
 =?us-ascii?Q?4FA8FNWM+Nzzpr7wFQrfkTQzSn4o/HB8rk8uWzOsR+U2lWsHfxwV9KFheClw?=
 =?us-ascii?Q?MWwyPnalAWHMY9PYnOkobyapc8qWdouH9vlDYAnKRuAJwRWR9M1wWYEZLKMn?=
 =?us-ascii?Q?Ug5mIl5leMCK6sBrM1u2Wq86u71r4CDEoXzhNOsocovsUfIcSQ7zabwUMDLK?=
 =?us-ascii?Q?g4tCygMQ/Sv+m18WGJfNbaqg0w18JhOR3agOi0HwwB1buL9GMckHlrdRg6l4?=
 =?us-ascii?Q?t5EnugVy0d97/Y7IQDajMpRSXtfrsFGyJtyj5aIA5W3tHI/ImqNBGzGZoGuS?=
 =?us-ascii?Q?fLyxR4kcO+j/odtT3HB+tZmws00zGdBT9NWhrPD9aSJV+OxVikEuKcuOgIm4?=
 =?us-ascii?Q?ITxWW2inSLyPppzT7KRDd507JCkduCSB3nyPXcS/tckBbOc6VjlS3RW49tc9?=
 =?us-ascii?Q?q9ga30/+HVmrBt9mVt5lwezKaszYrXdSuzXCthE/GkFIdSfkLJVj3lw/Iqbw?=
 =?us-ascii?Q?lSE86GA63pl8+duVN5WpvpIxqDLM/0kqkxUsscjQV3ZAcuC6x4LI/g6AB4oe?=
 =?us-ascii?Q?Qmay5yNEPE5X2an/ILYTvFAHY2qwfvBIRRLQdz62VQBGTe8SRxOllFTqs66o?=
 =?us-ascii?Q?O9LaFBWQYrPcr2b47EaMjAXO06xkikilHeN2eguMUptRfv62W1BNJYs0yKrs?=
 =?us-ascii?Q?XMvYQF7EJDVd6AvY45ShVOvdVBdEpjfA3+6/b2ffdZc8bmndDOkJszdntaQd?=
 =?us-ascii?Q?uozncXEt4fwL12TP0THZKbv1541Dwm6LMXqUDQl80Ps8jB65KGs35FiVx5bH?=
 =?us-ascii?Q?lQOWfUHNZO5IMjTszkYrnekghYCQw1sk+o2OlK1q/oqd/hEPM/S0GikZCVPJ?=
 =?us-ascii?Q?whbJqwT+SHfNoiMGaria65uPTgY92C9g3SaPJwiWMt+sdIQNiPBoyauqJ8S8?=
 =?us-ascii?Q?gMh9cvuFXZztL+cDyIvqgQ0/9Et/Mef2jOxCJvcglrWNpF47IFBIKqBjxFYX?=
 =?us-ascii?Q?/sOb4lkM8LWCJvOTc+e3tY/5ea0tRgkdocp+Ymtky2rA81Vznsy7ZDk30iHf?=
 =?us-ascii?Q?LJ2utbBxVwXBumvZbZ8CZlWn3RmZxunZbS+dbPZbyUKqNyWfBaJNL2j+juAc?=
 =?us-ascii?Q?giR8cryOheQ+Bz+6cIn7kGDUsI2FnRe9ABZGN/Mo4dUEUr351gy/wxEsl8JS?=
 =?us-ascii?Q?j7cDycaB0M820Re9GjdzEfsuJgjKsWD54vkr9nhIjBRMXh8b5PHcyxBPRtQq?=
 =?us-ascii?Q?qlRT6W1lG7E5eRO9vUHPB6uqFZ1NiEM8bKy89a/oIF/5U2p+t+byldy3ITq0?=
 =?us-ascii?Q?7IrQPPqNKur675F5JlGlmfJl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16eb8bb-7b83-456d-6c34-08d8eed69d56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 15:08:00.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0foqMYrG4/j9/4JLEYHoD3wWvUw+7C2mdwclFbG39EV/5iqY8z1BGgmeAFrV88N1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 04:25:24PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Instead of manually messing with parent driver module reference
> counting, rely on "depends on" keyword to ensure that proper
> probe/remove chain is performed.

?? kconfig doesn't impact module ordering.

To have a proper remove chain there should be a symbol reference from
bnxt_re to whatever the other module is

> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/hw/bnxt_re/Kconfig |  4 +---
>  drivers/infiniband/hw/bnxt_re/main.c  | 20 +++++---------------
>  2 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/Kconfig b/drivers/infiniband/hw/bnxt_re/Kconfig
> index 0feac5132ce1..b4779a6cd565 100644
> +++ b/drivers/infiniband/hw/bnxt_re/Kconfig
> @@ -2,9 +2,7 @@
>  config INFINIBAND_BNXT_RE
>  	tristate "Broadcom Netxtreme HCA support"
>  	depends on 64BIT
> -	depends on ETHERNET && NETDEVICES && PCI && INET && DCB
> -	select NET_VENDOR_BROADCOM
> -	select BNXT
> +	depends on ETHERNET && NETDEVICES && PCI && INET && DCB && BNXT

Though this is correct, BNXT is a 'tristate' so it should be
referenced with depends on select.

> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index fdb8c2478258..a81adb07e5d9 100644
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -561,13 +561,6 @@ static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev)
>  	return container_of(ibdev, struct bnxt_re_dev, ibdev);
>  }
>  
> -static void bnxt_re_dev_unprobe(struct net_device *netdev,
> -				struct bnxt_en_dev *en_dev)
> -{
> -	dev_put(netdev);
> -	module_put(en_dev->pdev->driver->driver.owner);
> -}

And you are right to be wondering WTF is this

Jason
