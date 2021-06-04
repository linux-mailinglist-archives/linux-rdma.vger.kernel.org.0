Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69E639BB0E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFDOpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 10:45:03 -0400
Received: from mail-sn1anam02on2088.outbound.protection.outlook.com ([40.107.96.88]:14548
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhFDOpD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 10:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B28vaMqHNOMn/JjioMF/mEoWuGqQp31bFw7m6HqGZ5Nsj6vAVn1kJ8C5McOF5uSfITMgUeaR9b69XpAp2hZWUsuMY7SW2OrIjlPg5G413fnSDGARBpMgrJddZlHm661ZvzlTvcvyDoxRc7Hz/z0Docuot+/tDoaAQor+FNUEyceqsi2HoHOVqvqPeddOn1VRBl1+Lv5GbYRSnkyj8B6Q9/7ukxrVTNLnWQzh3CoJomLtYKZ0RyleqA0urWT0l1sHNNyRQOiaEwP+OKCFzhaVKpHT+DWdl9x8gkEb0SMuQSzVaOceRRFK5pEDakJ+gQn4p+h8qf05Jz7bIE9/0i5Wtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL6cuAfEyGci3gNavPmdeAoEG4cDfw2KudOI5dfuiCI=;
 b=cHYzoxVwK57rN8M6ZyYpvom3FmVOoiDbrit/7pvUUcTlzsSg/gJn2N2MC58RHUqE1ol9Kck2112rSeVbi9hwu4lb8/3Ocs+sTmtWY1BGJczxv+zusnM3tDrlGAXTKB6BD9x2IxsGWdoumHxdZ3PqyJkDHkA0ihvJIAQyvXSNm2hQMf0qDqXlYhJBQYtrvXRG0l4rwMjPXITbzezQoEITAsd1QcjbW8II4zAfZ1Gxc/ZDIS6eZsDxbsm9O+t8gUMSPMxM0G+Ts0kk6mmKCCEgDzk+91+CzOsQ0bXc/zLz5RMDj3qio/EPxbExD6KPHffTywbeZKmOOtN7QuaVP1B0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL6cuAfEyGci3gNavPmdeAoEG4cDfw2KudOI5dfuiCI=;
 b=kVidqD0BtXLFVQBO84QR9GBDpOjqs80Bc6Izx5gnLwdmYQBIP1rcU/iz7UlQsMhDcjX6M/0fsp1kMvQI3fiRNR+PKUrxjYYjPJmd7J5EDeJXUE1ZUsBrN9LnOi7pmXDMk4C0ZSYkD0hvdL1pW6WSCmBVx9sRSwGlvC3onSMaWdfPPgtp36UfoOkR2CF/J/Dm9QNjA7+e92rYwpSgxhFgrPoKkh17eJwk7KqWeKRNK7XMyGwGKgDZ3pYnn2rNnQiILgqxr/cdSynR+pqOcHGrzpSIG+UnwjK3Wb06lYwaMuFGrS8dDN3f5F4B5dFJpXRTz8MabWU27QXoZkbwEzvNtw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 14:43:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 14:43:16 +0000
Date:   Fri, 4 Jun 2021 11:43:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH rdma-core 3/4] libhns: Fixes data type when writing
 doorbell
Message-ID: <20210604144315.GA404834@nvidia.com>
References: <1622194379-59868-1-git-send-email-liweihang@huawei.com>
 <1622194379-59868-4-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622194379-59868-4-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR18CA0016.namprd18.prod.outlook.com (2603:10b6:208:23c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Fri, 4 Jun 2021 14:43:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lpB2Z-001hLC-5r; Fri, 04 Jun 2021 11:43:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f77d5cb-091d-4359-77aa-08d927671665
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5142C2DCFA8FFB1EC6F1FBDAC23B9@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:289;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4otwRJJEeIyVL72VMR1fvZkhw8Agi0moSql+OM8dZ1uZdF3+4/JqUuQyf4iniald3aEkJITV6zAtQZz05aWSwoRLBPMid5uS3yyfYef0zdtJlTGENkPLvBoSFbZrMF0mFD+pcuVwzesvywgedkfVgqiZhVvqvVSTbfT//wh/cfQFWy9Tkidhwl7K9D6bykPrySYRhARM0uDi6vWYauBvlEnmm3zRPrg0zbleJfU/MwUb3Ut7FkLrNB4DD7EAKmJNxHy4jz8NU+ANlf+A7dKq4V1wlV6UHGJymrUVNPRMNc9w/YCnGhZFhkjguXcCW/IMZ8biLXLt3wzl9fEtV7qw1hb8jhEjz+ZUxajPeDyIk3604DTBN7XcNWfm2HNSoxHps39CLYyYRceDn7qLbE/XQrx5pMiOV4PtCJlIZRmbrSgDFVzXzscz5xTe5k3wwHlMSuuj0cMAgxjSbrVmhpM/JiER0vyUlennv4lUYU3uStjgmQ10aAf1g9IFSiC4hBpIwjX4wfwCw+fSkzpI1QWoy/mFqaimPOfWVkfPvGKpMQPj6goS9jKytiV69C8o6iBppNZf8+mu3wVILQ0n0oPNw9dM2/dE9zJPzUFW154pDYZcIqC+B3bBmX/MjMjRCYsPlql9pvMJp0bffB6zi0jltH9++1+FMFMPMLzG6EVVt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(478600001)(38100700002)(8676002)(5660300002)(8936002)(426003)(66476007)(66556008)(9746002)(66946007)(9786002)(26005)(2616005)(2906002)(83380400001)(4326008)(36756003)(6916009)(316002)(1076003)(186003)(33656002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YLvwGQjmkXuQYnyJqG0kUN50pWFz1WxoYRFkzRsI7S1zMvPTn9jJCY/gY0sK?=
 =?us-ascii?Q?NxnsASn87N1wXjiUlwD4r1Gf+x7ia2rgZN52etr3CG3Gp7RQVmi4T3sQTl82?=
 =?us-ascii?Q?RMPIDHmHWLnvPlOGVu11WAwtWElheLTLpkMqzxDEIhdvaE4C/ESHiZUD+2HT?=
 =?us-ascii?Q?N2y42uTtJjNPIYEWNZr2zK2+wABOrZuB7P44JwzoFZMh+vQoyB4D6SCgrjXH?=
 =?us-ascii?Q?SH/8zZn/nz5TfAG/CE36lYX3wCTZ5cMkqh71wGPS0ye5j5tVdSCrsnMF+895?=
 =?us-ascii?Q?cUy1W6H6ffXpG3o1rdtJbheV7kcGfmKoqNaBflrQVjm+7bfE22VKPrXk9jeC?=
 =?us-ascii?Q?4R4phGXKKz8p8uBqY8U+k7jp8q0d7HsAQ/g8OEEEt15ZarvOgsNSbn65sfNH?=
 =?us-ascii?Q?rdBF7vxB62hHX6e5XZEUq+G4IjHigJuGgOV8i3wLxNt9ODNd78l5UA3zrcmY?=
 =?us-ascii?Q?6V3/eODnPt+Q0Sh9oG6qiju7zW94GWULf5D64bRlQdvIrEk3gTV9fQaPT0g+?=
 =?us-ascii?Q?7EU2sB+qtsvJB+aHBN+sSVoYgs32JsCMAvhHEZ56p8toMajJzIq3UjZOfwpx?=
 =?us-ascii?Q?MmnT3P4JLgGNlTTxvM8zUfkngUsb4H27hAD//ajc41dYniIpiMl0r3ZFz3Gz?=
 =?us-ascii?Q?5jYnGtYUItQslQHzElbnSHEkqvWY/4JlLFcJzjaAL7bKPqjtjXWrei4iYv+i?=
 =?us-ascii?Q?Su2+GGsD88IAG380dZH8sIrRIfr5SJ1pc1jkT8CyjrGJtOd2V+R+LWQH1A6R?=
 =?us-ascii?Q?jzv+USoT6Uw7VpU1gRX2AUSg9czs7YQSmgs+61geclRKNvVD9R9lSacopmcS?=
 =?us-ascii?Q?8t+Veay1vAsMSGvhDv2tl3EhPV/NCAPF9FD+nVWA8TB3+ZwwLSJsjQLyrifT?=
 =?us-ascii?Q?K7hEjGMfr1wccTrAWmnYWP+ivXNrgZw0F55Yx5+DfTmMrkyYK/stxfK2vmKD?=
 =?us-ascii?Q?W9oDNEwYV/btf+hFaL6DXvJ9ndPDEOm0VGa7+9X/3cMxstVLUnvyIrOxqvvK?=
 =?us-ascii?Q?Y3eCxc55x0yhY0A/e0nfVg5APjLM7LRM9vqUJZOYhSz1yT9xl+/+KCs0XyQr?=
 =?us-ascii?Q?ClF2MrvPdgn/eqGdRtUQBUj7CpbflZzbH5YYaUp4I2sFEkblfPfLJBFgmgPZ?=
 =?us-ascii?Q?WrUBGGK+K8qreLsi+VLUL5edQRNNCKTLk5smN8qR/JBYdBXdS+Z03mjqp10G?=
 =?us-ascii?Q?fX4bneSu/I4wfhm4FHKtS1MjQAZqYcivsB5DwGkcmsGbBKEllD8OEaCF7dD8?=
 =?us-ascii?Q?Kh6zp9Zsr/u+Z6yb77Dh7TPAmlVz0IaTFt8tEkLOIDCEf2BEc8hTIVAcCFHH?=
 =?us-ascii?Q?5dGAxtY/vrRbuz4dl7z98NE9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f77d5cb-091d-4359-77aa-08d927671665
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 14:43:16.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTpJf4z7zNCj7v4xRt0LFzUtDNIcLnIc3voqq01udURsY7geqiZyGLY/p15CJyzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 05:32:58PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The doorbell data is a __le32[] value instead of uint32_t[], and the DB
> register should be written with a little-endian data instead of uint64_t.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  providers/hns/hns_roce_u_db.h    | 13 +++----------
>  providers/hns/hns_roce_u_hw_v1.c | 17 +++++++++--------
>  providers/hns/hns_roce_u_hw_v2.c | 28 +++++++++++++++++-----------
>  3 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/providers/hns/hns_roce_u_db.h b/providers/hns/hns_roce_u_db.h
> index b44e64d..453fa5a 100644
> +++ b/providers/hns/hns_roce_u_db.h
> @@ -37,18 +37,11 @@
>  #ifndef _HNS_ROCE_U_DB_H
>  #define _HNS_ROCE_U_DB_H
>  
> -#if __BYTE_ORDER == __LITTLE_ENDIAN
> -#define HNS_ROCE_PAIR_TO_64(val) ((uint64_t) val[1] << 32 | val[0])
> -#elif __BYTE_ORDER == __BIG_ENDIAN
> -#define HNS_ROCE_PAIR_TO_64(val) ((uint64_t) val[0] << 32 | val[1])
> -#else
> -#error __BYTE_ORDER not defined
> -#endif
> +#define HNS_ROCE_WORD_NUM 2
>  
> -static inline void hns_roce_write64(uint32_t val[2],
> -				    struct hns_roce_context *ctx, int offset)
> +static inline void hns_roce_write64(__le64 *dest, __le32 val[HNS_ROCE_WORD_NUM])
>  {
> -	*(volatile uint64_t *) (ctx->uar + offset) = HNS_ROCE_PAIR_TO_64(val);
> +	*(volatile __le64 *)dest = *(__le64 *)val;
>  }

Please use the macros in util/mmio.h

Jason
