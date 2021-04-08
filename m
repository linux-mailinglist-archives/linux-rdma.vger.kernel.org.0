Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D272A358CB5
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhDHSeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 14:34:13 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:5345
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232608AbhDHSeN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 14:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3Pyg/DE9qyq1nOBlSHHgqF13ABEpd++9RPvpUeDtj4rdOXNgj9O/YCKel5LZjN6CZQw4uEnJdCpo66jYqNx1LFIB64yKkYyLZkUmEsX+ebv37/5q4lT2+7lXzvJZPDSwYsHu+GQjP3hCpP25xuxffxOb6miEq6o4AQWE9gPC9E6+Gzb20+45bue5m/wGUjwIrZaCKOxZwXmgGoeiycMGZrTI0sgJgNTJIyyboRWXB4XUobIvOp0ajKj3K3GksyAYRZAMNXCfp/kFxUiGzUjysXPB23U0v01pp6CTyO4qSeolptIkdlnzOA9YM8piX3/jvBQgHUxEZQ4R73VLtiKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zen4okSYh9Hd6RNz2z7SkowBY1+G56CbCaYhxVakQvc=;
 b=T5rA+IDo0yrldbDDbX8MlPoTft01sF0EZckQtd3nL1JzqGoSKyfAZ5N4XBi6Bu59NVO4g6Y9XtKbjaB7kCNFrGJkSmwm24D6Kec9EL8dvyVVyd2haNmgDWKNWUil57THd3LWGB6BQREVjZhfXFPomMmJ8LLtoJgBausp91tH/offpRmBuD8c6ddgEBYXhABgXktG9943MtZODeb882ZC7NbZ59fT8nrHAIb7QgW3uijPQafkn6bdUxeTCs2ztYs1mbxp3tpCvCNVCLo66Yf+q02SQ0cuVGQsx0SJr8sCTKNlF7YctxJtPn53Lt1XQ3a6d7endktiKRGYnQTMu05Wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zen4okSYh9Hd6RNz2z7SkowBY1+G56CbCaYhxVakQvc=;
 b=tc/IqVZft5BtwJlOVHjvqie/SZPJDw7rSfmzhe3V9AZvH2KrTkhFqHrkBUutLE5ZnvlfUJYRaLG2UVtarHzqD3n2MR6W+gCIfrX1nsSmiFqISvBYf4pTCaVz8SNhSEYsj82qT5zRazPzQg5g0uR9JoUqWLIGMLbqXSUjWnPNu6FMrc5lgGXgCsmRQCNFPaExhIR/0zPA+czp/eM3rGs+4wOAxKvpKHC57DJ1I0N9kkQiVv9enJRO9RzI1GtyzB4Io82O6Psb+NaD7P8nvzjC+2sVRsizZLvNRDgt5PWI4ENm1BbY9QMaYy2/e6WCwq7jrfv8aLONPUyL7JZj2NCcCw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 8 Apr
 2021 18:34:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 18:34:00 +0000
Date:   Thu, 8 Apr 2021 15:33:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCHv3 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable set in cmdline
Message-ID: <20210408183359.GA676678@nvidia.com>
References: <20210326012723.41769-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326012723.41769-1-yanjun.zhu@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0049.namprd19.prod.outlook.com
 (2603:10b6:208:19b::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0049.namprd19.prod.outlook.com (2603:10b6:208:19b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 18:34:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUZTb-002qAp-61; Thu, 08 Apr 2021 15:33:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38190545-1a45-4ff5-7694-08d8fabce0a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3307BEFEC941EB106675CD99C2749@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/fAbBZ0IoXVORayWGOo7JweRIR/mB34JV+tOWArdQdeR7WFh9pDAEZUgo7Y3fqt8+e29q+SeR5WSWlIt5a7SkhytypFHUcFuxlCrcojvlXeKVHin8CXvOD+jcLpDO34L9MRXS7LehkEwFQ99/2LezOYS/H5dgT8RDqa6qIIrFwK5D5kQ4VxxApBp0TJnWf7t+yCek2abIgC8XxtOytDpXZlUD/nS52b2c4qEHlGLtDq/UYkiG/8zlHTGzIBmlOSYaML8WvyBV4syLBl16OAv9FmHSs60hDHH8pMLvb36PEdbv+HEKm6QirJwHvHOzgYmvIUTZeFFcv12tgpREvPM9tzwkDkTFgHSx4nxbb0JhVykBTEUpuXproVgQGCVzoL8TuX+1MjmdRCiWcexi565NL9GMZCi8agroQ+jwi8qPLF32PmcCNClORDXfJX5/lQCUUi4h4i6fMsDJ5lWEyA1iFI+M+TvJQqHHI8xNCCaaxUkQFJ8JYeOGOG7tbE7+zDxdWDq33xwS8VCgVMSsyCWI+tnuPBKBS/HmS6VR9XZ+jie3aO3OkQV2iHOlFDuXkmFAXDaP86Uj+kjQrCFXWvGqCC92MeCN+ZTrPAKdD4VyddJDWE6A8xVxIe5/l1l0hEhRDMjyvd1VKs3gOMaAZt2QCx5rL8viQuvNt41Ka1Xee2oAPZ6frJRQYY4Pqwy6RX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(478600001)(66556008)(1076003)(2906002)(33656002)(66946007)(316002)(5660300002)(9786002)(83380400001)(36756003)(2616005)(9746002)(8936002)(66476007)(186003)(26005)(107886003)(6916009)(38100700001)(426003)(4326008)(8676002)(86362001)(54906003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EKTLykTFi3paCYuEh6RjqwOZ2q1eWa8CLloEBkiw5RNakmcnm4JCdhGc/mYt?=
 =?us-ascii?Q?nsQhXPavWay/X1a4puIBXAiPZhvh5sSfWXgJxXBGV/Urph05aw/IGjiVSlrj?=
 =?us-ascii?Q?Ha/NgcbAqcyHDyjlTBF1d0tkgrSellxdgI1PzfZYl4tBLPpXuOOUhsjbkPIy?=
 =?us-ascii?Q?W71Nur637VJJTC2HmCS3OkJZPoQm0ExxAkzXRfCCiRP7bx0xzhlvu1bvLExY?=
 =?us-ascii?Q?bD8O3E+dGr2cFqYP6dlqj+x/kv/clLYp1FQ5w+pbldIsozCdOBdw4+TAIcR1?=
 =?us-ascii?Q?rwAfUtWtPkR/apROWSdRxTCkGtUosUeTSSHFto0hr5S8F35DIRT5ZB3QEut3?=
 =?us-ascii?Q?BW8goHsOLkbbAgO5E+EIA4N6eXL0eK9EZ5alaFljG7T+2nndZCC1UKuwhDLu?=
 =?us-ascii?Q?bo7slhjf2u0wtR0mW/bUlYzcyV2G1Bbif8ReVKt5pgJgYGchZH32CzuiUqZU?=
 =?us-ascii?Q?GvIiGp1pG4c1ksYFTmoN80mIWpvvlNEg36WQEup7w0xHurNh7B6qcLMMd0T/?=
 =?us-ascii?Q?R5NPMASyaLfoPoOiopwx6QGPLzRtjuXgWHpGToyQD5w2yW6jf9RQ7+OAAHs2?=
 =?us-ascii?Q?NLkuPdKktnhNvabTUEW6M6h+scqwBJU2KaB2r0WGzo1cuvK3of0TcIHkD8jU?=
 =?us-ascii?Q?k2Yn/CPjy/Ytk3mu2dzwrj4fvEOJlHyCgPPHoP/Tq09pZYHqvaHXL0rnZDu5?=
 =?us-ascii?Q?eATnl+IzKyaH5EQd80I+JbqS0X2HksrjeNE/6U9O5vd3JDoxFdg8UPquvtEL?=
 =?us-ascii?Q?HrowRPkbIzQXURITg4vEWJ9FhSYJGzLF+1nBJteA7EhNwmG1XcMWXZ4Z1Nu+?=
 =?us-ascii?Q?tJoe62W40754CMfwE+IUELFuSvkaTqjEK6SkDIw1WSWk73reP2eMUiWLeJhs?=
 =?us-ascii?Q?Iyfc5Jw44WHzh//2Lf3PjoGcC0pqcU5ZvdKQMLvA5x/wcfusMqLnw2Xyv4U3?=
 =?us-ascii?Q?aVJFb61oxAaBm0btwozZ5SsiLXaEohyfuEXevIqDXDRNgMy7dNEXsljY25kr?=
 =?us-ascii?Q?KDML3eu5z/OSU4JjyFJia51XmClZNJwApd5v9j7jMKWK/DCZ4rNT/N/WwJOm?=
 =?us-ascii?Q?RZ7LmKdalFLvpghnk/zaNYOnAA12oUI8JYtL/ePU9RlEf2qfdJ8azQ7FOF6S?=
 =?us-ascii?Q?47qiL5VqJp1XdtcSlQqcs90Dd7yHsaZVK7+XICRRqDtM16hyGqV/BD76njZK?=
 =?us-ascii?Q?9c+lM1A3xnnUESrzlkxpcymtbKSAziR4wL4xIc4L6Acphr9Hb+xid0vjHMHR?=
 =?us-ascii?Q?ys2oHZhxJAD22XpaThlZn6Xbc1xFmeFBPs+sngI7nX0dhJqJ0vELq2XLWQvj?=
 =?us-ascii?Q?dFLKjUPqv6TKEUaCHe3/N4lr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38190545-1a45-4ff5-7694-08d8fabce0a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 18:34:00.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuq5zBooiB/vkRLJpAaQZ5JqOvWIAdeqR7yYXPJB7Kkp/m7DLOmd2LR6Gge7sh5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 09:27:23PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> in the stack. As such, the operations of ipv6 in RXE will fail.
> So ipv6 features in RXE should also be disabled in RXE.
> 
> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> V2->V3: Remove print message
> V1->V2: Modify the pr_info messages
>  drivers/infiniband/sw/rxe/rxe_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..3b8ed007e8af 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -72,6 +72,9 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
>  	struct dst_entry *ndst;
>  	struct flowi6 fl6 = { { 0 } };
>  
> +	if (!ipv6_mod_enabled())
> +		return NULL;
> +
>  	memset(&fl6, 0, sizeof(fl6));
>  	fl6.flowi6_oif = ndev->ifindex;
>  	memcpy(&fl6.saddr, saddr, sizeof(*saddr));

What is this actually fixing?

ndst = ipv6_stub->ipv6_dst_lookup_flow() will return an error if the
ipv6 support is not loaded so why do we need more tests?

> @@ -616,6 +619,8 @@ static int rxe_net_ipv4_init(void)
>  static int rxe_net_ipv6_init(void)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> +	if (!ipv6_mod_enabled())
> +		return 0;
>  
>  	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
>  						htons(ROCE_V2_UDP_DPORT), true);

rxe_setup_udp_tunnel() should already fail naturally because the V6
socket won't be created

What is the actual symptom this patch is trying to address?

Jason
