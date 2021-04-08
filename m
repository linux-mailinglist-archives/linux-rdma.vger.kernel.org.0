Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F19358D00
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhDHSy3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 14:54:29 -0400
Received: from mail-eopbgr750042.outbound.protection.outlook.com ([40.107.75.42]:11684
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231676AbhDHSy2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 14:54:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9dfX5oYDgEjt+QXogl6qLA8JXFY7qsYLFpg8y9DiqxR1PGdnCagEWvxhZrwRG8OhfpdKZ2rNVVEJnoweySIsdMhu46Eq003kw6imtynwU1NoHyblVEQe8z8sfRy8111t7R/aFZXdgf79voSBIW5KQIakUj1uJDILK6Cvb3MPb+crd12QVIVxnJ/qoJeBMkytjmz6hJIeb2UAjkdMocYUhEblgP2GDl3G6rkzVVRHPplUj9zjxmqClMpgUO4BBxLDL0kkCHQtoetmKa8c3Ber932rBabCC+QcMFzBBpdLMWzpJo1rVvFHDRQ0hcTzN9YFI2wAzzw86CYBo1V62DJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7KdduM3mxENjEL+8NsEQskE+wNDjBp02zvCTGul4GY=;
 b=n4F39TR+eolzRZO7YtMdEyjKybESIB+v7yq4xGHxBzwsD26KSRhF/1+Cf8hS1YGS9/JzoMsrkpkGpigfp2rtFDkQH5sHmD6C/j55244VhLKjXorJ50r+VU8NO0XhPPJM4mVDCRmklWMtWFQ+9cCoffvuaGhRstfU4I2kpTGsXuxLN2HfOU6W0RZd6KH5gLJQTn+f9ixOOh2BXEGlW3Bfaxoi8Qu5Hfvy6g/eXsjbubbdB++isKwaJmbOrKrxyCui31ptWLHAPzDsM//AZyEaUfzzSqixjiZJbEuXonQL/UimWE32wCwx9E7XTS0ARyTANzOQT7IuaMEYf6/NluuFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7KdduM3mxENjEL+8NsEQskE+wNDjBp02zvCTGul4GY=;
 b=ZseLciVA8kHMA4UXLDgHUxG8Q1/uLjw9U5oamF9okDrBCaHlFS10We5qyFKU9lvNHi2L8tVZp/T0DNau6HSUGSjPkfwMNHv8sVcCx+WRNxFsefI3rlTNCxuTbmeSBmtgm1oPRopeSZ5YVROGlO0bV+6OKr9iSFumHiHhDGUIBhdJzUQ95YS+lmH9YWMiU4ylvn8HGTNBuWfwBGDPWL58Z75p3Zrw7re4AQHUhc+2vhsZH1D6f2E6r9rNoC1r2IX1kXCm9lOeYQJmIacebwIA1/trk3OApc7q7JUZWHoTy8DoG4TLkjKjSGvPw8PVdoWMqvjw3hvbNqQi/oZzqoPSBw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 18:54:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 18:54:14 +0000
Date:   Thu, 8 Apr 2021 15:54:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Mark Bloch <mbloch@nvidia.com>,
        linux-api@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next v2] RDMA/mlx5: Expose private query port
Message-ID: <20210408185412.GA678376@nvidia.com>
References: <20210401085004.577338-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401085004.577338-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:2d::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:2d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 18:54:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUZnA-002qfe-Dx; Thu, 08 Apr 2021 15:54:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6786b40e-be44-4292-ff22-08d8fabfb3e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4497AAE3F99FA9E3659100F7C2749@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+GNdPV/rcJ+TP9rVJRKM59TYOtH1bINhI6hkzhv8j5kcCVAtI9Bn07P6hrkHtdbVmimtGjjX2QQ8Fi7nz4/T5esIrByMY735HU+pkCbLGbdrJ5MMj96Kp5cHNNLbRzHHQoZsg8/VnV8QoFFyFLdnRPcBflq4SZzcVtlp5suaAse1swoBX3+3ILL7Hi4G8Ltpqg/4GF87jg4uSHFI6USL3qiREhhk40sbS4Fkx2XPibCF/EKAmJtzfo5dSYbcIyg+SY0H4grJUtwbwnhBBuEAHwHPyfOUdouZ+PCRLuqLTmCqEEXKZL/6eD55t27+Fb/gxOJjn+DI2NgrNFGTFPdrJ2CyCKa4EQwdHoWblUiTzjzKDbzseF2J1+E2q75SwRCVPwpEMc/8q3hpWOmts+8nXtoOTRS/T8hlnyanUp3MVLTjVOcHHc1513drFlG+QQjuaR/FsCo4M5c+BzY58xU2DNNfGBbl+XIOYsypRmkYM5ddvtzAur7zZ8lSCF0pDkHdvFe6Q0CstRSb0Mfzra57z1iL05L1drTmQoGRDggTLEXUfi8OTwai9/BZjEkpLkubsVbHjfumorgOF17+9WS5cosGez2HLkdvLY1Oxu299ji6RPLpHmpG35GbA3DJ8tix6tcO33HRZV3L9HrZIcwsKhrBa08Np9VWEuLd+RjYPVj0CB6Ns+oN5qYHtJF2x5CRhZ1B+JpePZKX5lFKLu4rvW0i/E1kMhrr8800Aymc5k8WA5a4/ZS9SOhyt9kg0vP3okHNz8hNjVJMNHFOmYevw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(1076003)(186003)(54906003)(6916009)(426003)(83380400001)(9786002)(9746002)(8676002)(8936002)(316002)(2616005)(5660300002)(26005)(107886003)(33656002)(36756003)(38100700001)(86362001)(2906002)(66556008)(66476007)(66946007)(4326008)(966005)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/t9nAwEzZGFrfQKz5cIs++vEnkP06tn3YVNvN1jPhQY6+l5CiDLT+dOXuJRF?=
 =?us-ascii?Q?Gckntn+qgHJ3nSgX0YDv99u5Nx+LZBNAP+EmV2HyNREy1tDHRbLYSlWNllgW?=
 =?us-ascii?Q?Ux21cz/h4NDtIltLfedmL0id5kKQWecHybzsO4a5eFi2DthWPrza5PrIwArj?=
 =?us-ascii?Q?hGVS3dC1TbMHd4rpjznCbqUsWvTpdLAnwbKWvY+a4omlCVZeyrs+DJF2Rut3?=
 =?us-ascii?Q?qqBK0XCd35WDslgKo/9+r4UCqTx7qwNP/lqd0pnyEXEjZDRYZ2iOg+bfcZET?=
 =?us-ascii?Q?VER4jUzugWcKWQMJZlCWo/kFqc8stAqnEC6nOtgPtUB139KPLzFIgsQ5jU3i?=
 =?us-ascii?Q?t7pgolNmS6XQkaHvxxRRcDDs2VemLkuaXbL1TJ/788gLOZSMxuJFPFMNqisl?=
 =?us-ascii?Q?1f7/L3+7onsbYXKFFDCmDoGE/S6KN7Ih2xqDglJii8M3agnKSNz/CNR34o26?=
 =?us-ascii?Q?6VVn8qHvOFqotcTE4xUhCHhmusGSafhyqyullE09m8MOLz+NG9Zp9uoZljjx?=
 =?us-ascii?Q?dKG5RbSFj6EIZzcAt09DF8Q6bzPX56Krp5B555FT8uYbFkfZ8yYi0UoYmQch?=
 =?us-ascii?Q?TwC3aIjBH5repN/7K11jJ2k6uEdurq4GMfFhASl5hO1q3+4IH8ZvoE1+Ynfl?=
 =?us-ascii?Q?A25YhoRc/Ntw4Natw9esplEPyI7EJjRmz/3prIqvuUE6Re8zhVCaC8a4D10G?=
 =?us-ascii?Q?xIFEarorfhQ5YF+UadXPzU6jmACT5sXMozr1+uU1FGTjKahSpkwcmJw6PfMk?=
 =?us-ascii?Q?mZ7k4LQG2MbwHmF52Cbyazi/SXIeQAEsrQcyXNhsgvfN/PIM29DQvF2XBydf?=
 =?us-ascii?Q?Mds/M9p+BJ8Mc2nDiHfJ/5oyKsCcPQ0GgAG+q64lPDomWjJ2/zScMeAJco+0?=
 =?us-ascii?Q?0tFkOvJ+2uSpJ7UDCV9QWZrw/OobhA76qGI1JruHm2+d8V39zOdEaMFJXIjb?=
 =?us-ascii?Q?O8EeIMKiDgjwXhotmA057W7xCW3tYPav+OFdcLokGhcAsA5b3cqx8RC9HFme?=
 =?us-ascii?Q?/WgSZZ65WHmw+ZNNJ0f5q3/giCZtIUkZMWqVXTGdOEAuP9dnrNiLMqV9r2c5?=
 =?us-ascii?Q?i0vMBKt2uFpaiBsvhRbMxBQvt2TccCV3Fchomq/b8iHogmQtoiA657CuIpbb?=
 =?us-ascii?Q?WRr/5e7izpaGg6v1sBNplqPJUGCURzHavS4KW3jMtF8qkThhvj9Vru/fjwf7?=
 =?us-ascii?Q?nfZCZOzv3KhhNxngqIrTN2PRUB91hGXi5fMzqVNRk/Bvfl3OHDdfCJ0LEFCV?=
 =?us-ascii?Q?FTTesqJjk3hkPkzZFOmL6xtlAuMItuNUJU3yLiaqIGZ/BuZe095R3lxav/Wy?=
 =?us-ascii?Q?E4ujVRXOWXQIF8D50QZf0hd4qTXqn2Wtl7UEXCj7VpC9bQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6786b40e-be44-4292-ff22-08d8fabfb3e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 18:54:13.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlQO4cWMlonZ8EK5aMEc+UgOJXvdSELLcoSibcyhYRrDYdCJcz6fnjU6W0zcAiTg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 11:50:04AM +0300, Leon Romanovsky wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Expose a non standard query port via IOCTL that will be used to expose
> port attributes that are specific to mlx5 devices.
> 
> The new interface receives a port number to query and returns a
> structure that contains the available attributes for that port.
> This will be used to fill the gap between pure DEVX use cases
> and use cases where a kernel needs to inform userspace about
> various kernel driver configurations that userspace must use
> in order to work correctly.
> 
> Flags is used to indicate which fields are valid on return.
> 
> MLX5_IB_UAPI_QUERY_PORT_VPORT:
> 	The vport number of the queered port.
> 
> MLX5_IB_UAPI_QUERY_PORT_VPORT_VHCA_ID:
> 	The VHCA ID of the vport of the queered port.
> 
> MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_RX:
> 	The vport's RX ICM address used for sw steering.
> 
> MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_TX:
> 	The vport's TX ICM address used for sw steering.
> 
> MLX5_IB_UAPI_QUERY_PORT_VPORT_REG_C0:
> 	The metadata used to tag egress packets of the vport.
> 
> MLX5_IB_UAPI_QUERY_PORT_ESW_OWNER_VHCA_ID:
> 	The E-Switch owner vhca id of the vport.
> 
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v2:
>  * Changed __u64 to be __aligned_u64 in the uapi header
> v1: https://lore.kernel.org/linux-api/20210322093932.398466-1-leon@kernel.org
>  * Missed sw_owner check for CX-6 device, fixed it.
> v0: https://lore.kernel.org/linux-api/20210318135221.681014-1-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/std_types.c    | 177 ++++++++++++++++++++++
>  include/uapi/rdma/mlx5_user_ioctl_cmds.h  |   9 ++
>  include/uapi/rdma/mlx5_user_ioctl_verbs.h |  25 +++
>  3 files changed, 211 insertions(+)

Where is the rdma-core part of this? Did I miss it someplace?

Jason
