Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5E14DDF0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 16:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgA3Peh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 10:34:37 -0500
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:19841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbgA3Peh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jan 2020 10:34:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEgcfPj0SZuopmndW+1dW2kOSSG2FVHg7I83wdzzOmEGCLjCEj/FFNjoHc8BfVhqRJK7719YrtnQ3PMBi0OYz2aomiGBliF3q3Kvek1D1iUneeliS55ju0OsM2Hs8wVxVJY8TwFdJXIpzWbyZ90U2GT98uOjmWHAi7R3CvwfBCpxAkZV0/AXDmiPBD1aA1TvEsyVCekAqRkylCvjeDsy4eUw4FSRHTQrdD9gW+kOXoxUMpCkDQ/RVEw6d7/WoDI06BtXRB/qIzsMo4fDoEbZ03vBYpv5NtiyVJBoVfoV6Sa6DC2pmMnvMrkNV6N8cjVEahyDmNIdfWv2ixtg4OpA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73tUCYOaqBa2IgHSVFjP1V31ZaOC6C6TG1vdWFd9Fo=;
 b=O1a6s53x3712yrXPZTtnsN0cjjnTfI/W8hd9azgy2Y9WjyDnCVjt42ompkhziI/evuN/bP5ecBQWr1c40EXJRpQMVGzxqGW8XC29Amp4EoEcommdeF2/S0O6z241KSRaiw4T5MHu6rjDgXjUyy3r3c8vmwP9dOTKz5btXVnT6fFQslxhbyqEhfaXVYyCY3bhjCy3tWQMnTxjl9DiIYeM6+ZZKlhz57R8dj5Ss6/EhL2r1kID79bo8IJNRgfe8VfOYGna85kw147ChTdi0bpS4qmeN5cr/1k6IKHcIZ9FfhhMCg1gC13XIlWRXigoV2uxLb45bxhfr6tVNjDJhot4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73tUCYOaqBa2IgHSVFjP1V31ZaOC6C6TG1vdWFd9Fo=;
 b=cbDD5F8LUAKDOPTJxrLq9DM0QB7kZRVjqc8aZCLUCoC8Vg4Ux5h8/gZZKuLhmWvfUlOB0ykflcBeJ6NirluWxogoVhBFfiQmjjV5oMytBcra4BHuYJbPWb/GPn/g89U76TRHxvGekBxPuK0TWMqpXpHzsUZftQjoalaqj+8LsVQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB7085.eurprd05.prod.outlook.com (20.181.35.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 15:34:30 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 15:34:30 +0000
Date:   Thu, 30 Jan 2020 11:34:26 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix compilation breakage without
 INFINIBAND_USER_ACCESS
Message-ID: <20200130153426.GF21192@mellanox.com>
References: <20200130112957.337869-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130112957.337869-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:208:a8::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:208:a8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 15:34:30 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1ixBpq-0000we-AC; Thu, 30 Jan 2020 11:34:26 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc723a0a-050c-4d35-e555-08d7a599e5d0
X-MS-TrafficTypeDiagnostic: VI1PR05MB7085:|VI1PR05MB7085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB7085C9125BCE8F5719253101CF040@VI1PR05MB7085.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(8676002)(8936002)(9746002)(33656002)(81156014)(9786002)(81166006)(2616005)(1076003)(478600001)(36756003)(66946007)(4326008)(66476007)(66556008)(5660300002)(6916009)(53546011)(186003)(86362001)(26005)(316002)(54906003)(52116002)(2906002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB7085;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/zlZCUL7NdnYgJxRk/F192QUTeuzFZclkB3vfzNrLxjFni0Jpytt0F/ui7aPH4eRJTEaqW786fZHRmIrt3bRWxyzuwQ4SHfeSYU+oMgJAfyn156QtlHT/88Fo07fgIwcGaUMTq/zTtqi+J4uKj7JtBH1X7plgZ4Tn+RHUV5Ux6e0VLPuDUoDJsZWJpk1ORG2GoSaEpP4Urci2laT1nSAE/pg5zNyl9MAC4hHCw1t1/ReegWPkJ+c4G6VvYdZmgbYqa6492zzXFJP/ApkjBkDjOaB8cwro8CfaKJh3gdN0YlHssqagbpT9+MlBQenIdR3kHPTmK6LcgwZV15pxnyQMjyXnhLdQ++igl0yIAxRnyfb03SMsQ5Ywi1EQPVUx6RO9wWWfAVXz/lfSjWuSQRHpc7eg94jpGlOK2jhw5+DQ0FiKxGjF2TfJ1PyXD06ZT6QnICduTYb2Y7/qiFuTMxvtKmquHiiKYxRqk0DqwjEYQWdu4Hgdb7TH+NyVAxcBvU
X-MS-Exchange-AntiSpam-MessageData: Q+1Pgz6ND5sLtb+5Gtp7vm+q/nFaCKCgjILsH3UFVkfT+c3iVj1+3nTvftXrx0XK/CZ4fqDiBbVLfajvnw/eZafNCpq2idBhni358GYF8VhGtW/hFt6B+20ntpVLJ0DUUddQIM/+m2yw9eimLzeLbw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc723a0a-050c-4d35-e555-08d7a599e5d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 15:34:30.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syuZIB7jk7ZiLwer/JtqsKCjryNZaTSOKif6AFqVAi+j5USfL81OZ7gjqz5ZGN5RjMMvBJcX0/bzPjM3eEZKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7085
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 01:29:57PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Compilation of mlx5 driver without CONFIG_INFINIBAND_USER_ACCESS generates
> the following error.
> 
> on x86_64:
> 
> ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_handler_MLX5_IB_METHOD_VAR_OBJ_ALLOC':
> main.c:(.text+0x186d): undefined reference to `ib_uverbs_get_ucontext_file'
> ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x2480): undefined reference to `uverbs_idr_class'
> ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x24d8): undefined reference to `uverbs_destroy_def_handler'
> 
> Guard the problematic code, so VAR objects API won't be compiled without CONFIG_INFINIBAND_USER_ACCESS.
> 
> Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Hurm. This is actually a side effect of some other code that needs to
be deleted.. We can now make all the generated structs static and rely
on compiler pruning to sort this out.

So this:

        if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
                dev->ib_dev.driver_def = mlx5_ib_defs;

Will cause the compiler to drop the entire tree of stuff, above
references inclded.

See below:

From fb22c0daf5fac6fd5e014e691f7c92421d848330 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Thu, 30 Jan 2020 11:21:21 -0400
Subject: [PATCH] RDMA/core: Make the entire API tree static

Compilation of mlx5 driver without CONFIG_INFINIBAND_USER_ACCESS generates
the following error.

on x86_64:

 ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_handler_MLX5_IB_METHOD_VAR_OBJ_ALLOC':
 main.c:(.text+0x186d): undefined reference to `ib_uverbs_get_ucontext_file'
 ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x2480): undefined reference to `uverbs_idr_class'
 ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x24d8): undefined reference to `uverbs_destroy_def_handler'

This is happening because some parts of the UAPI description are not
static. This is a hold over from earlier code that relied on struct
pointers to refer to object types, now object types are referenced by
number. Remove the unused globals and add statics to the remaining UAPI
description elements.

Remove the redundent #ifdefs around mlx5_ib_*defs and obsolete
mlx5_ib_get_devx_tree().

The compiler now trims alot more unused code, including the above
problematic definitions when !CONFIG_INFINIBAND_USER_ACCESS.

Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs.h     | 17 -----------------
 drivers/infiniband/hw/mlx5/main.c    |  2 --
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
 include/rdma/uverbs_named_ioctl.h    |  6 +++---
 4 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 4d4cec46d25132..7df71983212d6f 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -271,23 +271,6 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_flow_spec_type type,
 					  size_t kern_filter_sz,
 					  union ib_flow_spec *ib_spec);
 
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_DEVICE);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_PD);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_MR);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_COMP_CHANNEL);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_CQ);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_QP);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_AH);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_MW);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_SRQ);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_FLOW);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_WQ);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_RWQ_IND_TBL);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_XRCD);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_FLOW_ACTION);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_DM);
-extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_COUNTERS);
-
 /*
  * ib_uverbs_query_port_resp.port_cap_flags started out as just a copy of the
  * PortInfo CapabilityMask, but was extended with unique bits.
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 01fc09f3ddd3f9..0ca9581432808c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6247,10 +6247,8 @@ ADD_UVERBS_ATTRIBUTES_SIMPLE(
 			     enum mlx5_ib_uapi_flow_action_flags));
 
 static const struct uapi_definition mlx5_ib_defs[] = {
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 	UAPI_DEF_CHAIN(mlx5_ib_devx_defs),
 	UAPI_DEF_CHAIN(mlx5_ib_flow_defs),
-#endif
 
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_FLOW_ACTION,
 				&mlx5_ib_flow_action),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 7b019bd4de4b2b..c160a43d77f0fd 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1379,14 +1379,14 @@ int mlx5_ib_fill_res_entry(struct sk_buff *msg,
 int mlx5_ib_fill_stat_entry(struct sk_buff *msg,
 			    struct rdma_restrack_entry *res);
 
+extern const struct uapi_definition mlx5_ib_devx_defs[];
+extern const struct uapi_definition mlx5_ib_flow_defs[];
+
 #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
 void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid);
 void mlx5_ib_devx_init_event_table(struct mlx5_ib_dev *dev);
 void mlx5_ib_devx_cleanup_event_table(struct mlx5_ib_dev *dev);
-const struct uverbs_object_tree_def *mlx5_ib_get_devx_tree(void);
-extern const struct uapi_definition mlx5_ib_devx_defs[];
-extern const struct uapi_definition mlx5_ib_flow_defs[];
 struct mlx5_ib_flow_handler *mlx5_ib_raw_fs_rule_add(
 	struct mlx5_ib_dev *dev, struct mlx5_ib_flow_matcher *fs_matcher,
 	struct mlx5_flow_context *flow_context,
diff --git a/include/rdma/uverbs_named_ioctl.h b/include/rdma/uverbs_named_ioctl.h
index 3447bfe356d6ea..6ae6cf8e4c2e13 100644
--- a/include/rdma/uverbs_named_ioctl.h
+++ b/include/rdma/uverbs_named_ioctl.h
@@ -76,7 +76,7 @@
 #define DECLARE_UVERBS_NAMED_OBJECT(_object_id, _type_attrs, ...)              \
 	static const struct uverbs_method_def *const UVERBS_OBJECT_METHODS(    \
 		_object_id)[] = { __VA_ARGS__ };                               \
-	const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {           \
+	static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
 		.id = _object_id,                                              \
 		.type_attrs = &_type_attrs,                                    \
 		.num_methods = ARRAY_SIZE(UVERBS_OBJECT_METHODS(_object_id)),  \
@@ -88,10 +88,10 @@
  * identify all uapi methods with a (object,method) tuple. However, they have
  * no type pointer.
  */
-#define DECLARE_UVERBS_GLOBAL_METHODS(_object_id, ...)	\
+#define DECLARE_UVERBS_GLOBAL_METHODS(_object_id, ...)                         \
 	static const struct uverbs_method_def *const UVERBS_OBJECT_METHODS(    \
 		_object_id)[] = { __VA_ARGS__ };                               \
-	const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {           \
+	static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
 		.id = _object_id,                                              \
 		.num_methods = ARRAY_SIZE(UVERBS_OBJECT_METHODS(_object_id)),  \
 		.methods = &UVERBS_OBJECT_METHODS(_object_id)                  \
-- 
2.25.0

