Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025B13672C2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 20:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhDUSpk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 14:45:40 -0400
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:59010
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233038AbhDUSpj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 14:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jztFW9zCd1K0QzKnUS358WE41YRn+/AoqFHBA0r2YTzM7weOPvDC7Li26oyzUxl/RoJ89SVe52/RK8+ox27dJjwkb6N5HiOrL4ml2VTG4ELE3ycU93+YGR7fYHwxwZ6KZLyjHs8My6Vpma7Gz3QwsLrbM6z+yjuSp71LfwFxpx8Q0F54eDvXH1Om6dcy+xW8V52S2Pndq0twdvy4CAgPWC4r0QR7Ygvaou3BOY9WT16EUN8K8suhULIn/r6OvJwOHmx+quUGXFK3gM6z7MvKXLVh9VNhVrtXKniWolKCLrhBVmbIup+vgkzeXNKpJYHcZ54nWeaj71hxcYv/Tfqu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opBizZvEDtFdqJkshpXkoorQCEatGXVNCh6VBMd8cjk=;
 b=Ddh8teD5I+QQmbY9As1ky09IagHacj8PQ1gbX7KKoXzKSXwLdFMI4MLISvmY7jTAEuO54PcTFkxNZrR0f0OBZivppZ0ki2shwaZ1mZTHK2b5h8rDFvDZcK7bQ/RwVIcXWzPZFyPi3f8DgiG6iPRk4hxAkgmU15PZjv6GAIBFbiqPzkeEy+nTnQjDRinZoafANohlyusbEK2RVLdzN4muVobJeGLkdjadlneUBStjcw4WBjn+U7k07MoM5YHcRmDi2hLIFcEA9l+EKwehnJMaZq6YtZZsSfS3SozwozKXbJ9Jmwh5x+0m1Ezn2ct0btRqwaGP1YHzMScdWqFDunNOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opBizZvEDtFdqJkshpXkoorQCEatGXVNCh6VBMd8cjk=;
 b=as48H3qwnT44Sw0Ol5o4YTyCfnb9/n0byeAVDf2jrJriKbgISR29AhW/5x3l/+TI4zUdG4BpXZR64mV0USJZi++p0afgHTI2ErzlRZgIpn+gcUyN8qxayR4KiEABXzDLz+AKs85hReng9zd+QUBzQ7+Psgo9ZnsqLiFr72ob7kG2SsdyrPLUBzOhC33uEnz3TAIDzPShdzmlZQx2EU/LJe67IKpzGZ4YwTV9jfURlIdcDcXoLA3sxKDuuTnIu/KDxg0kseMNNJRrBdDIVpi36ZY8VnAXVbhmPyS62L0j/v26IIg3iHWFNjkuBhfP9oUg+m/3ynciJCiCUZre0QSiTQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 18:45:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 18:45:04 +0000
Date:   Wed, 21 Apr 2021 15:45:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Mark Bloch <mbloch@nvidia.com>,
        linux-api@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next v3] RDMA/mlx5: Expose private query port
Message-ID: <20210421184502.GA2292095@nvidia.com>
References: <6e2ef13e5a266a6c037eb0105eb1564c7bb52f23.1618743394.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e2ef13e5a266a6c037eb0105eb1564c7bb52f23.1618743394.git.leonro@nvidia.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:208:1a0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Wed, 21 Apr 2021 18:45:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZHqQ-009cIz-GJ; Wed, 21 Apr 2021 15:45:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40d50e1b-b69b-4af2-72e0-08d904f59395
X-MS-TrafficTypeDiagnostic: DM6PR12MB3929:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3929D4F93294B7AE835D3107C2479@DM6PR12MB3929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXsYhDtOrgw8bB2cyolh4on4RI/N6SiLY/v7cQESVRG4coGSfBQmAF3lrk+7J7cfOS6ZPmxk0GNccavEXZpa3k0V34CboqvdfGorDGPrQnBrk/gr8hewryMBfryjTiME6kPBdrer7kMM8yUcret6LyJOwx2hv+1J+3zHtMACKXbbwzApszRR7FoY5JdYpr8hrdtlLEeD8zATBy7vVOQbCUM/34iaXlXyrHcn93fJVHz6h5f9Wd+kiMuEWZl0T8JMBd6Xw1X5+upeo554INC9gAgqlmjDSRd2xwVQ/9Vc9iCJ9jR+SWq3fKxUjRCRLitI7tyuZSvM8WjIOyaGu1EVjkuytpDtTWv3PmExyU4crB8s1qpiNYvF0c/T61bvbBxrTzd1PD/a1J5kUccFPMbwimn1uvRTeuXEIP8nyNCrbMd3tWnjzg/0k4tsC46471YX5k8CYvFLCmf8DPZnSGd9cjigj+y4xXuaK/h7XL/3cQ1es+71Y616WZBI6bWtuUoFaznwUlgaTVzmmlxZ1YYGq7QqvaqdHCrrVmLMz4G2n3qDF4ajgMwrAJxnsQa6yoeOsRaxJl6BeIgqsol+FW35fTAj0ayRM3pxlnPOJiFHU/7VX5gF9nfxslmMBwPLfS2uI0OhX/ygwiRx+4DDTP0gLHzMuR8S7ca0ifhuTaKuwp6WK4lsiK7QcV8slI/GzT3z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(66476007)(966005)(33656002)(66946007)(83380400001)(1076003)(107886003)(26005)(86362001)(478600001)(6916009)(36756003)(426003)(2616005)(8676002)(66556008)(8936002)(316002)(186003)(4326008)(54906003)(38100700002)(5660300002)(2906002)(9786002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ltx5MVYbYSZPZt9/+2Ho3HJCSsRkbBzdrE84dVSdWWlIoCsWy6niinrK9JKT?=
 =?us-ascii?Q?v4JFBvWsY/9VB3bBCA5TFW4VeNOhOG4xzKFX0MIXHyUwiAIJTewPNcFaRzV6?=
 =?us-ascii?Q?BZ21n81uBlKoRqMX1JBiNkoktuGZOBEYpb+NO5U0RE2XG8SvNax4N7XcXr7x?=
 =?us-ascii?Q?Y/xsu+NkzdwIP78EMtav2SgB6ja9/wT4+ta/1igdQCCwBP9DvplvhES0t5Wz?=
 =?us-ascii?Q?g5MadfchG8BmU2xHfjXqJs9Xiuqvxdeb1ZF0cmLRSrBu1S2Qm0j0YkGpTNwQ?=
 =?us-ascii?Q?rRB3SizD1a894H/E/NITSlsaHuTRSZEf8rA4bYqLCd9gx6linZJJN74ILf1U?=
 =?us-ascii?Q?3nPz7pmSXcAi4suAcbDghgafRjJuCpQ5FcTBWQSwPFthUxMGlvhibdaxLy7N?=
 =?us-ascii?Q?+gXk1VC2YKyjuZoQFxnq/iMWM73gRtVlJYyJmT2tPaNGh7yt8OoD4qioWXys?=
 =?us-ascii?Q?ScV1L5D3NA621mMKEd11G92P+brl3D0xclQB6ndSKypn2orYZk9q5roevMw3?=
 =?us-ascii?Q?dBdpEh8wH9xnjlVtNg536SCETA/GY04ieHjEVRKqSNGPNYR4uWokDoVUjHjw?=
 =?us-ascii?Q?A9EYeLOFkVC9gOfPvEQXYLJSREf9JAoTTBalKBvOvDfMyQeqYguX8yz8Cq/P?=
 =?us-ascii?Q?yW56fMnnGX6Bl3kHm2YkII6/OpXWFDFnbmjolH6VDtDHjR7xPY1m3h87SyAC?=
 =?us-ascii?Q?+KpeL1Dt5opnISVb2dX29tW8kMT1ym1BufajebGcFbBxAZLnbmwhXniDkcfu?=
 =?us-ascii?Q?+eM9SWXas4xz7Y4mFz/mfto2the1n3PCzVQ9j6kUkYm0xp/d2wPnjQvCdsL+?=
 =?us-ascii?Q?OiAmvP9K54mdLC687tzqFL5RXT3WPABBCRoWYrnK1RB4OZ1qWlRRMmoKAZ6K?=
 =?us-ascii?Q?nsPN+XM8kP92+Ws3UXEaRGQIvYTFYKJYF+a5DsVAh6LWX521rG8fUXnJYttD?=
 =?us-ascii?Q?WPl3Q4pT8/jkQy3YI3GRu8JPsrac8/1YhiPbUIlp9+bI9EfCRD76K+0mxO7M?=
 =?us-ascii?Q?WZeAtniWpDsZaDsqzSUVnoJkBYo79DSQLs/yzJL2h6LxgMxlguXNPgBcvO8O?=
 =?us-ascii?Q?wHgx0Wq4NY95c23PE25Da8lrNAAxfGsFZLuvOV1tJg4M6UYKrT8eusWBOT3G?=
 =?us-ascii?Q?I+2Dtwu4ERHN/pbyUvfOGgz2b8UQhL+xh8EavBNDSFsoRgpGleVZkkZZLR4H?=
 =?us-ascii?Q?mJApjKNiL4bV+637UojHq6DLGxiv9Gj7ruFf+0SnMABPj3WVXlRGuyPY1Ggx?=
 =?us-ascii?Q?AzngsgF9VRy1ryWDnS9axkG3MgFm5vjVd3GV06bxLn9OxffjFW0YLu6/9sXj?=
 =?us-ascii?Q?JHRSHQbT+8HEDRmV5wE8fSadrEvs9PHxmQTwUkxNZjO9qg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d50e1b-b69b-4af2-72e0-08d904f59395
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 18:45:04.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/TyoTIQJZFH9hJw4ajoJoUFsYtcd0l593Bm4bBZ90Z/B3XbvJSLgKo5lwGcgESx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3929
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 18, 2021 at 01:59:21PM +0300, Leon Romanovsky wrote:
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
> v3:
>  * declared "info" variable on stack
> v2: https://lore.kernel.org/linux-api/20210401085004.577338-1-leon@kernel.org
>  * Changed __u64 to be __aligned_u64 in the uapi header
> v1: https://lore.kernel.org/linux-api/20210322093932.398466-1-leon@kernel.org
>  * Missed sw_owner check for CX-6 device, fixed it.
> v0: https://lore.kernel.org/linux-api/20210318135221.681014-1-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/std_types.c    | 173 ++++++++++++++++++++++
>  include/uapi/rdma/mlx5_user_ioctl_cmds.h  |   9 ++
>  include/uapi/rdma/mlx5_user_ioctl_verbs.h |  25 ++++
>  3 files changed, 207 insertions(+)

Applied to for-next, thanks

Jason
