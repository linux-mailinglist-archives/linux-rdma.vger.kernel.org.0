Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8C34216B
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 17:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCSQAn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 12:00:43 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:32992
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230225AbhCSQA2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 12:00:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLLGtN7jAM/2ngTT9fOorFXJxfIJXgrzVK9vHUShunQNbSpLOcnYWnwaZKH63pNYDDhL6AagXnZwQLPg+yM6g/Ee1Lv4kLN4cJqLafLcuJ4biJz8trPas/Gt1rZIZZc8iqboNZ/9YcrVoVgL6RlowUZYe191F3sctxv9C6eB34tULsjYARC4nsoZGoEyDGU+/kK3aOxDe7USzvT6Q93hndLw8nHW4gyM5dBpejqpwuUC+Hc//AonjmMvWepB+Iroq9OqNu0LsGU5Kx9VLD7bYmE0s/GxmFxKoEaQnLgDX28auTMLCZDoRPR2F4CfPTPAIs05y68PII6RxzEsOiP5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7gz6rVjuu8fYQKxmrwZ9cMmVKQoTQXeErrhx5XBIAg=;
 b=Y92s83HJOmOWKQiLVnQX4VZNOQAfUETJ3iWNsj/UObL2q4Z9Vr9TmGRA9b03sqrSGVqcMOtRA7CVhCmRWyGbGCbunzevfNOD8thmxA24vXjH1vJNgHhLLr32RErjzcXlkN5+HcBQoeqIULwddaTXdRqJGrK1P7SLZWUyN3Ygw1e4ztu/XyYLzsUWmM5kDMcBQTKGN+OwfqRqO7pNHox07OroVRHqZJq6ujj4tAFXikFFSkiQlrrSG0pEgqKpERqpzrGUBg+MJ1rFbk9eARwfzkZZVtOW2/m5aLKHiu+wNJ5H1P7B4Og500DsCApzO7JUmYCIvmNfvvFSwTZ+3rfy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7gz6rVjuu8fYQKxmrwZ9cMmVKQoTQXeErrhx5XBIAg=;
 b=MpH2NiisAXDD4AusQmr8CqTct37eEgixVvH/KQq1AAWqn0SLpxJB8cI/PoFVktePgEb9AI1VjKDEYfbGT01Clj6QoJSF97oRWY+gf4LaOGbgMPZIZ25UXOQ/g/U4HgUf7LzyDHXPRvTw83nOlWJj7fg6vmZJrrWDSt0gkqS2esdB5QHicJECuzI69rgfGqFhg0oYXlU9gKDNeT+IbSAs+p1drVWXWhzsxxvV5d1Fr0p/9v4IKu4CVxdVJY2h7XD0Kd+7eRtMPoEzJnAI/fLcV8BN06qrnzI8QRZSijMvcw8ayzQo+WgCneycxyzsm1B7i4W/V4OVuonMHSkpMiytdg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 19 Mar
 2021 16:00:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 16:00:25 +0000
Date:   Fri, 19 Mar 2021 13:00:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kaike.wan@intel.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        todd.rimmer@intel.com
Subject: Re: [PATCH RFC 1/9] RDMA/rv: Public interferce for the RDMA
 Rendezvous module
Message-ID: <20210319160024.GW2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319125635.34492-2-kaike.wan@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319125635.34492-2-kaike.wan@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0070.namprd19.prod.outlook.com
 (2603:10b6:208:19b::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0070.namprd19.prod.outlook.com (2603:10b6:208:19b::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 16:00:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNHY0-00HLmN-7s; Fri, 19 Mar 2021 13:00:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd0c9f00-40e0-4e8c-de6a-08d8eaf01bf4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4267B10329F342876B19E62BC2689@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thAKBD1AYkJQTZGR0HKxZdOj20ebRuiIoBcdhgGg5DkZoCFu/BibKGtb5fVI/FjAxtFj7kn2hrvmP5ZVPgWn2QlOplUHcFrKFFl3TtojlHleQYHitw8F53UDC5PCKTwIQ2YX9GEd1lFy78x1Do0khq6qA/IDto7J6qFAcYs4GPDMeQB3/2qgwWkXOL+t2gp35fk3a1zrITHCFQxIhQtDkZDabwaxis8cNe2xeR8VIkxZHWTDvy9ForcADYNcI9pLeST+Y+z+DRyRrKvYFBIIW1qWNllRGx/aq5qM3kk39o55tbNqxVrndCUDjBfWh9CaZp+9EUgd48Jg15EZyWNepXsuxQjgXGATqX1OzQA+VutYo2Vg5w46Zi3XCc+jXtWXQskWI1irYWR+oKAKVdTk4bmv4OML8Mq+q9A/g7SfR5aBIWGpv1+qK+fbHzJKCXCeguWFooW2AVx7DqNkZHNg5Hu3DhpeBM7VBN5lLVYdVevEmMVEqhp88uOvSw7GJpHrByLxfcPdgh8N337qLSjDSct/yDaqmgQZREUCLfpbHlWiKdpgIkWVY5O4VmXux81fSlMK6We9u5EIMPy+nq55ANfwpcD/fS64NuH0ZeQBBlQmnMDPpB1eOAR81NMFwtKdYI5BYrKNgHBZtKZy6O9AWrGjTeZUIqeilQ3qJS/LLyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(4326008)(66556008)(2906002)(8676002)(9746002)(5660300002)(1076003)(66476007)(66946007)(86362001)(478600001)(33656002)(186003)(426003)(38100700001)(6916009)(316002)(2616005)(83380400001)(26005)(36756003)(8936002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BHByqJbt0ot8D1GGAuCxxo4bn7KAfiDAL3cHbBaNsYw2U0y8lTMdMEhEM6AF?=
 =?us-ascii?Q?hcd3kkXIH3xhxfl91+kTlv77cloXlDJIN3lBeVhKb9vC2HuzLn/SYA+ClUCn?=
 =?us-ascii?Q?O2dAQIY4vbtY4Ng7NG2JbpC5smLQh9C8UXnXk6ibwzjsHFE7b+aEuXhnY3+W?=
 =?us-ascii?Q?QRuE9UFjqVx1OusuOvrkQNEmpH4SRPEuO8qe9JTHDFttk1jnvXsrwL2vanKD?=
 =?us-ascii?Q?Ij9n9atV5NCxU0ZdHWX+FsgCP6cDMqkxvIF0ZnaxTl3osIdXH4GLz/24hK94?=
 =?us-ascii?Q?Nq5MUcatn4qnL+8AeJso7YhceEgcwvWx6sjVh14g+9pC8HDmTtoStAFZjLqu?=
 =?us-ascii?Q?96uUiKbvNPWmYawby/YLuyOeo72VexsoyJmAPgFIjYE+Go3zSvBa7C2PgjXi?=
 =?us-ascii?Q?YFrvAJikJmD/E8kjPiqjRSFIbuvpGIommMjsLNHpf6Vt3/EE0nmQX/CPs/Ec?=
 =?us-ascii?Q?fH6f6SyWKBsi6q+nd7wc6Eej3q5Dw9Rbwn9IfhdmteR/xaGyIoJHexUohkGS?=
 =?us-ascii?Q?KuRQiJzHSwIiNM1Uh1YvQdhD5K5ZauCx7oU5j4pde55AzlkBBgh8Bh2jVsAY?=
 =?us-ascii?Q?gVwwmeZw+HKRAuYDtTqUk0Mwy8jlLw0g+6Z5XKOfcm2u3uHZsS8T4blJhsvU?=
 =?us-ascii?Q?rL+Ltnq7yOMKn+WvdhoEMudDYw8iAsqy48QOO+3oi8+ioo9FqCWn0N9hv00T?=
 =?us-ascii?Q?7G9iF0/JyeBejZVjel4zVssh/xE+E5PDk76qzHdEFHMweETgkIEumkL4jD+T?=
 =?us-ascii?Q?Xbh6f9BJ0iZ9jyjIplJqbROHdCu+Z0aWyML7UkTmqNdBrge6176AeHqu/yWD?=
 =?us-ascii?Q?C3W43V9QPIYtlgwZCPe4TNVucPb8scSeLfzUGLaicUoPAqhBoeCmiW9kpr5z?=
 =?us-ascii?Q?pPq+UQtfTy385Io3RENDUNZQ8kU+FtDFwhddlRagywsR7RnFYkKl2wjkJChv?=
 =?us-ascii?Q?k2M9L6cdDlUackEEYCbMzI/2UKveN3c2LLzkvI+Ih/f8TEQ1q695rTva89Tg?=
 =?us-ascii?Q?INPB93jVxbk5zI4jJQ97+HIgll7nyMMKV2E5kgHRndgtxk1HP27IsggFsuKj?=
 =?us-ascii?Q?nDEoBzkH4q9yVJuIyW4oUfs11K/HPF4oFqnQchRxeF17m2DE1Lsnx6WomLlW?=
 =?us-ascii?Q?ody4qoPUmUo7l6GeI0uL3Ob8zoMzViBu99lw2/yV61hTUdN7MjrH/niSqCmy?=
 =?us-ascii?Q?DIiRhc8tuKmXyP/IeHuzQQ62bQTd/8auiOw3kQYQoOQO7lUEi7/tklL78if1?=
 =?us-ascii?Q?CUIX1lJ7G/ZyT9LjtXMYbm/2eMGWBQT03VrCH7dwFGp1YB+2XOTzuUpw7uQk?=
 =?us-ascii?Q?k9Xt4GxCXDDmIohXJmDVxLp8IkOzyRtCaOci9UW8TuWP2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0c9f00-40e0-4e8c-de6a-08d8eaf01bf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 16:00:25.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGS99ZmlgCh+RrJUp9iczI3KD/bMDkxALmliVBzUxlX3kzHTLDE1BlrjpOAi2HLS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 08:56:27AM -0400, kaike.wan@intel.com wrote:
> From: Kaike Wan <kaike.wan@intel.com>
> 
> The RDMA Rendezvous (rv) module provides an interface for HPC
> middlewares to improve performance by caching memory region
> registration, and improve the scalibity of RDMA transaction
> through connection managements between nodes. This mechanism
> is implemented through the following ioctl requests:
> - ATTACH: to attach to an RDMA device.
> - REG_MEM: to register a user/kernel memory region.
> - DEREG_MEM: to release application use of MR, allowing it to
>              remain in cache.
> - GET_CACHE_STATS: to get cache statistics.
> - CONN_CREATE: to create an RC connection.
> - CONN_CONNECT: to start the connection.
> - CONN_GET_CONN_COUNT: to use as part of error recovery from lost
>                        messages in the application.
> - CONN_GET_STATS: to get connection statistics.
> - GET_EVENT_STATS: to get the RDMA event statistics.
> - POST_RDMA_WR_IMMED: to post an RDMA WRITE WITH IMMED request.
> 
> Signed-off-by: Todd Rimmer <todd.rimmer@intel.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
>  include/uapi/rdma/rv_user_ioctls.h | 558 +++++++++++++++++++++++++++++
>  1 file changed, 558 insertions(+)
>  create mode 100644 include/uapi/rdma/rv_user_ioctls.h
> 
> diff --git a/include/uapi/rdma/rv_user_ioctls.h b/include/uapi/rdma/rv_user_ioctls.h
> new file mode 100644
> index 000000000000..97e35b722443
> +++ b/include/uapi/rdma/rv_user_ioctls.h
> @@ -0,0 +1,558 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/*
> + * Copyright(c) 2020 - 2021 Intel Corporation.
> + */
> +#ifndef __RV_USER_IOCTL_H__
> +#define __RV_USER_IOCTL_H__
> +#include <rdma/rdma_user_ioctl.h>
> +#include <rdma/ib_user_sa.h>
> +#include <rdma/ib_user_verbs.h>
> +
> +/* Checking /Documentation/userspace-api/ioctl/ioctl-number.rst */
> +#define RV_MAGIC RDMA_IOCTL_MAGIC

No.

> +#define RV_FILE_NAME "/dev/rv"

No.

> +
> +/*
> + * Handles are opaque to application; they are meaningful only to the
> + * RV driver
> + */
> +
> +/* this version of ABI */
> +#define RV_ABI_VER_MAJOR 1
> +#define RV_ABI_VER_MINOR 0

No, see my remarks to your other intel colleagues doing the ioasid
stuff.

> +struct rv_query_params_out {
> +		/* ABI version */
> +	__u16 major_rev;
> +	__u16 minor_rev;
> +	__u32 resv1;
> +	__aligned_u64 capability;
> +	__aligned_u64 resv2[6];

No pre-adding reserved stuff

> +};
> +
> +#define RV_IOCTL_QUERY _IOR(RV_MAGIC, 0xFC, struct rv_query_params_out)
> +
> +/* Mode for use of rv module by PSM */
> +#define RV_RDMA_MODE_USER 0	/* user MR caching only */
> +#define RV_RDMA_MODE_KERNEL 1	/* + kernel RC QPs with kernel MR caching */

Huh? Mode sounds bad.

> +/*
> + * mr_cache_size is in MBs and if 0 will use module param as default
> + * num_conn - number of QPs between each pair of nodes
> + * loc_addr - used to select client/listen vs rem_addr
> + * index_bits - num high bits of immed data with rv index
> + * loc_gid_index - SGID for client connections
> + * loc_gid[16] - to double check gid_index unchanged
> + * job_key[RV_MAX_JOB_KEY_LEN] = unique uuid per job
> + * job_key_len - len, if 0 matches jobs with len==0 only
> + * q_depth - size of QP and per QP CQs
> + * reconnect_timeout - in seconds from loss to restoration
> + * hb_interval - in milliseconds between heartbeats
> + */
> +struct rv_attach_params_in {
> +	char dev_name[RV_MAX_DEV_NAME_LEN];

Guessing this is a no too.

> +	__u32 mr_cache_size;
> +	__u8 rdma_mode;
> +
> +	/* additional information for RV_RDMA_MODE_KERNEL */
> +	__u8 port_num;
> +	__u8 num_conn;

Lots of alignment holes, don't do that either.

> +struct rv_attach_params {
> +	union {
> +		struct rv_attach_params_in in;
> +		struct rv_attach_params_out out;
> +	};
> +};

Yikes, no

> +/* The buffer is used to register a kernel mr */
> +#define IBV_ACCESS_KERNEL 0x80000000

Huh? WTF on on many levels

> +/*
> + * ibv_pd_handle - user space appl allocated pd
> + * ulen - driver_udata inlen
> + * *udata - driver_updata inbuf
> + */
> +struct rv_mem_params_in {
> +	__u32 ibv_pd_handle;
> +	__u32 cmd_fd_int;

Really? You want to reach into the command FD from a ULP and extract
objects? Double yikes. Did you do this properly, taking care of every
lifetime rule and handling disassociation?

> +	__aligned_u64 addr;
> +	__aligned_u64 length;
> +	__u32 access;
> +	size_t ulen;
> +	void *udata;

'void *' is wrong for ioctls.

> +struct rv_conn_get_stats_params_out {

Too many stats, don't you think? Most of the header seems to be stats
of one thing or another.

> +/*
> + * events placed on ring buffer for delivery to user space.
> + * Carefully sized to be a multiple of 64 bytes for cache alignment.
> + * Must pack to get good field alignment and desired 64B overall size
> + * Unlike verbs, all rv_event fields are defined even when
> + * rv_event.wc.status != IB_WC_SUCCESS. Only sent writes can report bad status.
> + * event_type - enum rv_event_type
> + * wc - send or recv work completions
> + *	status - ib_wc_status
> + *	resv1 - alignment
> + *	imm_data - for RV_WC_RECV_RDMA_WITH_IMM only
> + *	wr_id - PSM wr_id for RV_WC_RDMA_WRITE only
> + *	conn_handle - conn handle. For efficiency in completion processing, this
> + *		handle is the rv_conn handle, not the rv_user_conn.
> + *		Main use is sanity checks.  On Recv PSM must use imm_data to
> + *		efficiently identify source.
> + *	byte_len - unlike verbs API, this is always valid
> + *	resv2 - alignment
> + * cache_align -  not used, but forces overall struct to 64B size
> + */
> +struct rv_event {
> +	__u8		event_type;
> +	union {
> +		struct {
> +			__u8		status;
> +			__u16	resv1;
> +			__u32	imm_data;
> +			__aligned_u64	wr_id;
> +			__aligned_u64	conn_handle;
> +			__u32	byte_len;
> +			__u32	resv2;
> +		} __attribute__((__packed__)) wc;
> +		struct {
> +			__u8 pad[7];
> +			uint64_t pad2[7];
> +		} __attribute__((__packed__)) cache_align;
> +	};
> +} __attribute__((__packed__));

Uhh, mixing packed and aligned_u64 is pretty silly. I don't think this
needs to be packed or written in this tortured way.

> +
> +/*
> + * head - consumer removes here
> + * tail - producer adds here
> + * overflow_cnt - number of times producer overflowed ring and discarded
> + * pad - 64B cache alignment for entries
> + */
> +struct rv_ring_header {
> +	volatile __u32 head;
> +	volatile __u32 tail;
> +	volatile __u64 overflow_cnt;

No on volatile, and missed a __aligned here

This uapi needs to be much better. It looks like the mess from the PSM
char dev just re-imported here.

At the very least split the caching from the other operations and
follow normal ioctl design

And you need to rethink the uverbs stuff.

Jason
