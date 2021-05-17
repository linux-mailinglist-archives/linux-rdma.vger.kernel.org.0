Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB56383A61
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhEQQtd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:33 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:65527
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237179AbhEQQtI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nljDhG5ANr2JPiackVajpR9Q1EMdAYfNaALoQTqLKRkF6d4XYQuc2UXFbIBePjnNIBWyK/C0uzwaw2LdMqHOJFTXETGybJan4q56wwDgsyBSihd0mY6s7N4Li0uZlchyie5jgBUHfc1XQad0E84GWzipsO2WdalE8WZ807GWJiejQVdYgUHG+pl0eLfwN8lIEolc104oAkRTnR8RfECc9oxbcJrMGfEFW/rwNdvVjTMsOmYTcvlrHiEjBOxTGrI8KYWwW3N7LGCIN2pkyDZcO2OcHV68/8e4xAiYAkjYyxSoiq8OORblljQ0WFDC+HY02pz6kwGvmaa/xy5EJZapqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnH71x5pvpiEfewRk/m6bvlZHsDgVK095wL1t/Kj8NY=;
 b=cr56BvcgEbpgyXmaFqCkwDYoC3P4Y6AVAPqU+nTijmQq/lAQ002cxiGpRsX2yx/CYwphG1MrXh3auzEMR8bZEcwjiTKiR90ZbzQ6OYY3+oWecn5M/8OKC5ovQMEcRMzUBkE53mkfyT95Qcsh852h741/nMZX5vRlZ920LFNYO3YzClxXAYvgkuJvedLLRJ2qHAAwK1VIS1l31BRdXvxeRqfMyMOvES/i+jEI2IQEjto8bIB2mw5B1AuYbX1EQUwRvlS18gRvMnTwtJnTicGY4XbEteYxwVtzJ7uGL+aoVMW3VCXT+uQk5JWkXI/kQOB4Redea1sHEfmb2Tz/ZQVW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnH71x5pvpiEfewRk/m6bvlZHsDgVK095wL1t/Kj8NY=;
 b=DwdWZDw6e6Z2N6IbY+v10lpQI3KUkrbQcDh1J70dxjajx2gnIorhinaY64lQfc4k3K4wAs1obpi6KDIjHz4RDa84cU/c+L8ID++DjsRUjwOsDZ8lXBvLiFm7qcSdVpm4PLXQ0TupoLjGkZ3XTE3EbIisSM4dhiD8kEllSNanqb9DQqTp4AGlewjYdwX7KzaScvjpHtsmJBLnfEOgRlrlGrPyU7BANuFmrMKhnfdkf+kaVccg77SN7zC8Jiaz6HXgLFcXP0bTlQsp7bg7shlmIHFvGOn7HGFo41/X1TUSKncwx3/9bLDUvD3A98k6CObLdgGU5hOXiVkfjTvcJy/Tvw==
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and device variants
Date:   Mon, 17 May 2021 13:47:29 -0300
Message-Id: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 16:47:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP7-009LYL-P8; Mon, 17 May 2021 13:47:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2584fe4d-7849-406e-4b3c-08d919537d74
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2858BBA5BA3F5A15531F0B6CC22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skE4mBSSfFiP9CJIdOIWhbGA+c6z74vbPxRVnDRlHLV+SxPdpVvp816wNKl6Xx59vaiCHO34CzRghS94lwvRn0Tlilh9yTuYK55m1pUnuRV6hgPYJsLN1yv9THt0zpQOZjMsgqwvcQ+3Wj9lgHQm/UNCzt1d3GLsKxqPEeJEu0kCMbd5y/45NHhOUCL8zHyLGC6ti099FsgQvC16m/6wof3BuE8w7h1Ms+6ptGllWUdCAp5cprldADJIw8MevSJnxvuW001c3oK9oedUSUkKF+dJN65IeTT+vDLMlF28EKvvBwA1CMZDgJ6Afo8bOVGzi9HuLFbSh1hGC10OANCpS59kWyJXavykD8cXu0q5YvSthLbAXH7ab7IhiXBJhB5N2v2uAEt5wPx/cqVH2lkTaLf6Gtrx7mS6RKcN7frAZSX40UoSJwHMYqOALKUB9fNdptcqSMkHXrPgGX/hlJmlaLHg+bkWkU82jvt77pBk8byioSARePiTaju1EgHqp21XwOXA810zM2vut5IWIAfdJtMUji0eewZWe9MQx+uprTQH3+R5xC5OYH7LVazTbC9+bLNXlFNeO6aIoEngz+Yqb49MuG2bCS9gZYKReX5LybwDhWlonQC+a7cIQZcjqz8iXxd2G9MjcJS0mhxq44VUruf7qdiLw7uaXM2mgWZpfsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(921005)(54906003)(6666004)(110136005)(7416002)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(30864003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CeQ+cknMKyeRzPdwFB8zi5xABzjSyV3udLnQZLTorD3IoBT0IGY8pa8HYUYw?=
 =?us-ascii?Q?EsJRrHAtaaIiXfqpYM6erCwDbauFdg96YvYIgcq2SAT2LiG8Ph9kRbJbaqKc?=
 =?us-ascii?Q?oXp+JekRbLVUCKA9zxLcUf+ZZ7ilSLfBIAu4GV6+uePPsbXHUh3bpx/ft6sL?=
 =?us-ascii?Q?dH/Wvo+4KRE6ERv6fiIPtTw9I0uJQfSIc+lxYVEUCL4NnXzo4zUPg3QFzE3C?=
 =?us-ascii?Q?H6eMlabDMaev1fLO1avSlexNTQVN561bCXUrVWDXXvtyJ7Tua8LRfvd3Inwf?=
 =?us-ascii?Q?ydUlgIXkHe7xCkQXW/ECXIMuKTNVAvACMLylNC5K4kZZlqbtqeu7nkk+aMUf?=
 =?us-ascii?Q?PaMXD5HA1R9IIWmVlHZCBxw+WaL8OTLwkEW7/cJvSlgcL0ufzV2bzPUfIVQd?=
 =?us-ascii?Q?XFRiRFscTjXZBKHQM7EQAeOA7denv2PRt38uCm7+xkjdfs7+5mYq++2i8uxJ?=
 =?us-ascii?Q?MJuCwMwgTr8lCryw36OqRwVjT3uJPsrh3xrGqADQMqdZB/WbxG7pqigCRT2S?=
 =?us-ascii?Q?Mq5wqmLHA+goFHd8Z4onS441/I6KyaeS1/dTyVXFNMvJB1SehI5gtyjzqLEB?=
 =?us-ascii?Q?TNpVLZhDZ88zgB50CxxY0rN04tCXNB8AR96ae5B0YE933RDOyMSnt/yuwuKs?=
 =?us-ascii?Q?KxxYIzYraf2IFsZBT66O8k+5+BnF8lZdQwCaB7pEcoeSHsDQLs/bhrOyVsB6?=
 =?us-ascii?Q?86qaMiNKDs2tEjvVhFJQQv+A1P87fk2tAsiuJfzJl2s3rRbt2axIcbb1yQmw?=
 =?us-ascii?Q?x0XErAg8XfIsV9kOvvOl/vRY/mj5Vf2uBWnk5AUF96JjFGl4ERzBvC1+gr+R?=
 =?us-ascii?Q?fB/uBfNhmDZqSHkXEcdl6OzBAw2GoMJ4IvqCXpv4/pSX+MbIusWTUO7XkDGF?=
 =?us-ascii?Q?FIHdvs9WNy2vV3IfiY6kBNaxLzDEy99VR6O6Id7umWbq7HG7x6wcPrkMzzy9?=
 =?us-ascii?Q?mFmndOWs3q/5nFO5GVAu9I4wS+z5L9UWppof2eA8F0b0Lo0bjoJ9LP7/pVhI?=
 =?us-ascii?Q?OPqnasGBzrr1xktzZQuPmfaKqp6bXI/BW8mQ7RsI1pnm93jovbhTJlNuvrWS?=
 =?us-ascii?Q?+aj/rcKcsrUM+Gx2rwEuSREMMfY1mXMrzhEOUJQuMWt1Zl0YqJoehiOo7rdS?=
 =?us-ascii?Q?q9Nf7oVxwybSl3aSswpnUiVcqzFzhs7SVGnDnRaRKzgm+mO+oSsgVKMNcfR2?=
 =?us-ascii?Q?ssTfAbao/pcM/iXwefIlvxgsZURUbixjrrbbc82x6nORrgR7W5njW4SbzSGz?=
 =?us-ascii?Q?tlLaXHUj87jjwxMTW6z/ccE363t7bpOtc7bNIjNu9m7GSvjJ+Z54U+atizgZ?=
 =?us-ascii?Q?rr9GOknrNjceNko8RaJp8Z+0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2584fe4d-7849-406e-4b3c-08d919537d74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:43.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evBJjsvZAeckEtTRkXP6Mu/2bFz+0s3Hltkw1NU8qZFoeg9u3SCYNfZNBHwzw5pQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is being used to implement both the port and device global stats,
which is causing some confusion in the drivers. For instance EFA and i40iw
both seem to be misusing the device stats.

Split it into two ops so drivers that don't support one or the other can
leave the op NULL'd, making the calling code a little simpler to
understand.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/counters.c          |  4 +-
 drivers/infiniband/core/device.c            |  3 +-
 drivers/infiniband/core/nldev.c             |  2 +-
 drivers/infiniband/core/sysfs.c             | 15 +++-
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  7 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.h |  4 +-
 drivers/infiniband/hw/bnxt_re/main.c        |  2 +-
 drivers/infiniband/hw/cxgb4/provider.c      |  9 +--
 drivers/infiniband/hw/efa/efa.h             |  3 +-
 drivers/infiniband/hw/efa/efa_main.c        |  3 +-
 drivers/infiniband/hw/efa/efa_verbs.c       | 11 ++-
 drivers/infiniband/hw/hfi1/verbs.c          | 86 ++++++++++-----------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 19 ++++-
 drivers/infiniband/hw/mlx4/main.c           | 25 ++++--
 drivers/infiniband/hw/mlx5/counters.c       | 42 +++++++---
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  7 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c       |  2 +-
 include/rdma/ib_verbs.h                     | 13 ++--
 19 files changed, 158 insertions(+), 103 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 15493357cfef09..df9e6c5e4ddf7a 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -605,10 +605,10 @@ void rdma_counter_init(struct ib_device *dev)
 		port_counter->mode.mode = RDMA_COUNTER_MODE_NONE;
 		mutex_init(&port_counter->lock);
 
-		if (!dev->ops.alloc_hw_stats)
+		if (!dev->ops.alloc_hw_port_stats)
 			continue;
 
-		port_counter->hstats = dev->ops.alloc_hw_stats(dev, port);
+		port_counter->hstats = dev->ops.alloc_hw_port_stats(dev, port);
 		if (!port_counter->hstats)
 			goto fail;
 	}
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c660cef66ac6ca..86a16cd7d7fdb2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2595,7 +2595,8 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, add_gid);
 	SET_DEVICE_OP(dev_ops, advise_mr);
 	SET_DEVICE_OP(dev_ops, alloc_dm);
-	SET_DEVICE_OP(dev_ops, alloc_hw_stats);
+	SET_DEVICE_OP(dev_ops, alloc_hw_device_stats);
+	SET_DEVICE_OP(dev_ops, alloc_hw_port_stats);
 	SET_DEVICE_OP(dev_ops, alloc_mr);
 	SET_DEVICE_OP(dev_ops, alloc_mr_integrity);
 	SET_DEVICE_OP(dev_ops, alloc_mw);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 34d0cc1a4147ff..01316926cef63d 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2060,7 +2060,7 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 	if (!device)
 		return -EINVAL;
 
-	if (!device->ops.alloc_hw_stats || !device->ops.get_hw_stats) {
+	if (!device->ops.alloc_hw_port_stats || !device->ops.get_hw_stats) {
 		ret = -EINVAL;
 		goto err;
 	}
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 05b702de00e89b..29082d8d45fc4f 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -981,8 +981,15 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	struct rdma_hw_stats *stats;
 	int i, ret;
 
-	stats = device->ops.alloc_hw_stats(device, port_num);
-
+	if (port_num) {
+		if (!device->ops.alloc_hw_port_stats)
+			return;
+		stats = device->ops.alloc_hw_port_stats(device, port_num);
+	} else {
+		if (!device->ops.alloc_hw_device_stats)
+			return;
+		stats = device->ops.alloc_hw_device_stats(device);
+	}
 	if (!stats)
 		return;
 
@@ -1165,7 +1172,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	 * port, so holder should be device. Therefore skip per port conunter
 	 * initialization.
 	 */
-	if (device->ops.alloc_hw_stats && port_num && is_full_dev)
+	if (device->ops.alloc_hw_port_stats && port_num && is_full_dev)
 		setup_hw_stats(device, p, port_num);
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
@@ -1409,7 +1416,7 @@ int ib_device_register_sysfs(struct ib_device *device)
 	if (ret)
 		return ret;
 
-	if (device->ops.alloc_hw_stats)
+	if (device->ops.alloc_hw_device_stats)
 		setup_hw_stats(device, NULL, 0);
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 3e54e1ae75b499..7ba07797845c03 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -234,13 +234,10 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 	return ARRAY_SIZE(bnxt_re_stat_name);
 }
 
-struct rdma_hw_stats *bnxt_re_ib_alloc_hw_stats(struct ib_device *ibdev,
-						u32 port_num)
+struct rdma_hw_stats *bnxt_re_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						     u32 port_num)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(bnxt_re_stat_name) != BNXT_RE_NUM_COUNTERS);
-	/* We support only per port stats */
-	if (!port_num)
-		return NULL;
 
 	return rdma_alloc_hw_stats_struct(bnxt_re_stat_name,
 					  ARRAY_SIZE(bnxt_re_stat_name),
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index ede048607d6c0d..6f2d2f91d9ff09 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -96,8 +96,8 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_NUM_COUNTERS
 };
 
-struct rdma_hw_stats *bnxt_re_ib_alloc_hw_stats(struct ib_device *ibdev,
-						u32 port_num);
+struct rdma_hw_stats *bnxt_re_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						     u32 port_num);
 int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			    struct rdma_hw_stats *stats,
 			    u32 port, int index);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 8bfbf0231a9ef6..c705f09e767036 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -662,7 +662,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.uverbs_abi_ver = BNXT_RE_ABI_VERSION,
 
 	.add_gid = bnxt_re_add_gid,
-	.alloc_hw_stats = bnxt_re_ib_alloc_hw_stats,
+	.alloc_hw_port_stats = bnxt_re_ib_alloc_hw_port_stats,
 	.alloc_mr = bnxt_re_alloc_mr,
 	.alloc_pd = bnxt_re_alloc_pd,
 	.alloc_ucontext = bnxt_re_alloc_ucontext,
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 3f1893e180ddf3..c0f01799f4a0b9 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -377,14 +377,11 @@ static const char * const names[] = {
 	[IP6OUTRSTS] = "ip6OutRsts"
 };
 
-static struct rdma_hw_stats *c4iw_alloc_stats(struct ib_device *ibdev,
-					      u32 port_num)
+static struct rdma_hw_stats *c4iw_alloc_port_stats(struct ib_device *ibdev,
+						   u32 port_num)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(names) != NR_COUNTERS);
 
-	if (port_num != 0)
-		return NULL;
-
 	return rdma_alloc_hw_stats_struct(names, NR_COUNTERS,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
@@ -455,7 +452,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.driver_id = RDMA_DRIVER_CXGB4,
 	.uverbs_abi_ver = C4IW_UVERBS_ABI_VERSION,
 
-	.alloc_hw_stats = c4iw_alloc_stats,
+	.alloc_hw_port_stats = c4iw_alloc_port_stats,
 	.alloc_mr = c4iw_alloc_mr,
 	.alloc_pd = c4iw_allocate_pd,
 	.alloc_ucontext = c4iw_alloc_ucontext,
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index ea322cec27d230..2b8ca099b38115 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -157,7 +157,8 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		  int qp_attr_mask, struct ib_udata *udata);
 enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
 					 u32 port_num);
-struct rdma_hw_stats *efa_alloc_hw_stats(struct ib_device *ibdev, u32 port_num);
+struct rdma_hw_stats *efa_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num);
+struct rdma_hw_stats *efa_alloc_hw_device_stats(struct ib_device *ibdev);
 int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 		     u32 port_num, int index);
 
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 816cfd65b7ac84..203e6ddcacbc9c 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -242,7 +242,8 @@ static const struct ib_device_ops efa_dev_ops = {
 	.driver_id = RDMA_DRIVER_EFA,
 	.uverbs_abi_ver = EFA_UVERBS_ABI_VERSION,
 
-	.alloc_hw_stats = efa_alloc_hw_stats,
+	.alloc_hw_port_stats = efa_alloc_hw_port_stats,
+	.alloc_hw_device_stats = efa_alloc_hw_device_stats,
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
 	.create_cq = efa_create_cq,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 51572f1dc6111b..be6d3ff0f1be24 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1904,13 +1904,22 @@ int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 	return 0;
 }
 
-struct rdma_hw_stats *efa_alloc_hw_stats(struct ib_device *ibdev, u32 port_num)
+struct rdma_hw_stats *efa_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num)
 {
 	return rdma_alloc_hw_stats_struct(efa_stats_names,
 					  ARRAY_SIZE(efa_stats_names),
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
+struct rdma_hw_stats *efa_alloc_hw_device_stats(struct ib_device *ibdev)
+{
+	/*
+	 * It is probably a bug that efa reports its port stats as device
+	 * stats
+	 */
+	return efa_alloc_hw_port_stats(ibdev, 0);
+}
+
 int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 		     u32 port_num, int index)
 {
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 554294340caa28..85deba07a6754b 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1693,54 +1693,53 @@ static int init_cntr_names(const char *names_in,
 	return 0;
 }
 
-static struct rdma_hw_stats *alloc_hw_stats(struct ib_device *ibdev,
-					    u32 port_num)
+static int init_counters(struct ib_device *ibdev)
 {
-	int i, err;
+	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+	int i, err = 0;
 
 	mutex_lock(&cntr_names_lock);
-	if (!cntr_names_initialized) {
-		struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
-
-		err = init_cntr_names(dd->cntrnames,
-				      dd->cntrnameslen,
-				      num_driver_cntrs,
-				      &num_dev_cntrs,
-				      &dev_cntr_names);
-		if (err) {
-			mutex_unlock(&cntr_names_lock);
-			return NULL;
-		}
-
-		for (i = 0; i < num_driver_cntrs; i++)
-			dev_cntr_names[num_dev_cntrs + i] =
-				driver_cntr_names[i];
-
-		err = init_cntr_names(dd->portcntrnames,
-				      dd->portcntrnameslen,
-				      0,
-				      &num_port_cntrs,
-				      &port_cntr_names);
-		if (err) {
-			kfree(dev_cntr_names);
-			dev_cntr_names = NULL;
-			mutex_unlock(&cntr_names_lock);
-			return NULL;
-		}
-		cntr_names_initialized = 1;
+	if (cntr_names_initialized)
+		goto out_unlock;
+
+	err = init_cntr_names(dd->cntrnames, dd->cntrnameslen, num_driver_cntrs,
+			      &num_dev_cntrs, &dev_cntr_names);
+	if (err)
+		goto out_unlock;
+
+	for (i = 0; i < num_driver_cntrs; i++)
+		dev_cntr_names[num_dev_cntrs + i] = driver_cntr_names[i];
+
+	err = init_cntr_names(dd->portcntrnames, dd->portcntrnameslen, 0,
+			      &num_port_cntrs, &port_cntr_names);
+	if (err) {
+		kfree(dev_cntr_names);
+		dev_cntr_names = NULL;
+		goto out_unlock;
 	}
+	cntr_names_initialized = 1;
+
+out_unlock:
 	mutex_unlock(&cntr_names_lock);
+	return err;
+}
 
-	if (!port_num)
-		return rdma_alloc_hw_stats_struct(
-				dev_cntr_names,
-				num_dev_cntrs + num_driver_cntrs,
-				RDMA_HW_STATS_DEFAULT_LIFESPAN);
-	else
-		return rdma_alloc_hw_stats_struct(
-				port_cntr_names,
-				num_port_cntrs,
-				RDMA_HW_STATS_DEFAULT_LIFESPAN);
+static struct rdma_hw_stats *hfi1_alloc_hw_device_stats(struct ib_device *ibdev)
+{
+	if (init_counters(ibdev))
+		return NULL;
+	return rdma_alloc_hw_stats_struct(dev_cntr_names,
+					  num_dev_cntrs + num_driver_cntrs,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static struct rdma_hw_stats *hfi_alloc_hw_port_stats(struct ib_device *ibdev,
+						     u32 port_num)
+{
+	if (init_counters(ibdev))
+		return NULL;
+	return rdma_alloc_hw_stats_struct(port_cntr_names, num_port_cntrs,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
 static u64 hfi1_sps_ints(void)
@@ -1787,7 +1786,8 @@ static const struct ib_device_ops hfi1_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_HFI1,
 
-	.alloc_hw_stats = alloc_hw_stats,
+	.alloc_hw_device_stats = hfi1_alloc_hw_device_stats,
+	.alloc_hw_port_stats = hfi_alloc_hw_port_stats,
 	.alloc_rdma_netdev = hfi1_vnic_alloc_rn,
 	.get_dev_fw_str = hfi1_get_dev_fw_str,
 	.get_hw_stats = get_hw_stats,
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index b876d722fcc887..33f16d2b8e74fb 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -2441,12 +2441,12 @@ static void i40iw_get_dev_fw_str(struct ib_device *dev, char *str)
 }
 
 /**
- * i40iw_alloc_hw_stats - Allocate a hw stats structure
+ * i40iw_alloc_hw_port_stats - Allocate a hw stats structure
  * @ibdev: device pointer from stack
  * @port_num: port number
  */
-static struct rdma_hw_stats *i40iw_alloc_hw_stats(struct ib_device *ibdev,
-						  u32 port_num)
+static struct rdma_hw_stats *i40iw_alloc_hw_port_stats(struct ib_device *ibdev,
+						       u32 port_num)
 {
 	struct i40iw_device *iwdev = to_iwdev(ibdev);
 	struct i40iw_sc_dev *dev = &iwdev->sc_dev;
@@ -2468,6 +2468,16 @@ static struct rdma_hw_stats *i40iw_alloc_hw_stats(struct ib_device *ibdev,
 					  lifespan);
 }
 
+static struct rdma_hw_stats *
+i40iw_alloc_hw_device_stats(struct ib_device *ibdev)
+{
+	/*
+	 * It is probably a bug that i40iw reports its port stats as device
+	 * stats
+	 */
+	return i40iw_alloc_hw_port_stats(ibdev, 0);
+}
+
 /**
  * i40iw_get_hw_stats - Populates the rdma_hw_stats structure
  * @ibdev: device pointer from stack
@@ -2521,7 +2531,8 @@ static const struct ib_device_ops i40iw_dev_ops = {
 	/* NOTE: Older kernels wrongly use 0 for the uverbs_abi_ver */
 	.uverbs_abi_ver = I40IW_ABI_VER,
 
-	.alloc_hw_stats = i40iw_alloc_hw_stats,
+	.alloc_hw_device_stats = i40iw_alloc_hw_device_stats,
+	.alloc_hw_port_stats = i40iw_alloc_hw_port_stats,
 	.alloc_mr = i40iw_alloc_mr,
 	.alloc_pd = i40iw_alloc_pd,
 	.alloc_ucontext = i40iw_alloc_ucontext,
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 22898d97ecbdac..341162aa2175c4 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2105,17 +2105,29 @@ static const struct diag_counter diag_device_only[] = {
 	DIAG_COUNTER(rq_num_udsdprd, 0x118),
 };
 
-static struct rdma_hw_stats *mlx4_ib_alloc_hw_stats(struct ib_device *ibdev,
-						    u32 port_num)
+static struct rdma_hw_stats *
+mlx4_ib_alloc_hw_device_stats(struct ib_device *ibdev)
 {
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
 	struct mlx4_ib_diag_counters *diag = dev->diag_counters;
 
-	if (!diag[!!port_num].name)
+	if (!diag[0].name)
 		return NULL;
 
-	return rdma_alloc_hw_stats_struct(diag[!!port_num].name,
-					  diag[!!port_num].num_counters,
+	return rdma_alloc_hw_stats_struct(diag[0].name, diag[0].num_counters,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static struct rdma_hw_stats *
+mlx4_ib_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num)
+{
+	struct mlx4_ib_dev *dev = to_mdev(ibdev);
+	struct mlx4_ib_diag_counters *diag = dev->diag_counters;
+
+	if (!diag[1].name)
+		return NULL;
+
+	return rdma_alloc_hw_stats_struct(diag[1].name, diag[1].num_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
@@ -2206,7 +2218,8 @@ static void mlx4_ib_fill_diag_counters(struct mlx4_ib_dev *ibdev,
 }
 
 static const struct ib_device_ops mlx4_ib_hw_stats_ops = {
-	.alloc_hw_stats = mlx4_ib_alloc_hw_stats,
+	.alloc_hw_device_stats = mlx4_ib_alloc_hw_device_stats,
+	.alloc_hw_port_stats = mlx4_ib_alloc_hw_port_stats,
 	.get_hw_stats = mlx4_ib_get_hw_stats,
 };
 
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index e365341057cbe2..224ba36f2946ca 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -161,22 +161,29 @@ u16 mlx5_ib_get_counters_id(struct mlx5_ib_dev *dev, u32 port_num)
 	return cnts->set_id;
 }
 
-static struct rdma_hw_stats *mlx5_ib_alloc_hw_stats(struct ib_device *ibdev,
-						    u32 port_num)
+static struct rdma_hw_stats *
+mlx5_ib_alloc_hw_device_stats(struct ib_device *ibdev)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	const struct mlx5_ib_counters *cnts;
-	bool is_switchdev = is_mdev_switchdev_mode(dev->mdev);
+	const struct mlx5_ib_counters *cnts = &dev->port[0].cnts;
 
-	if ((is_switchdev && port_num) || (!is_switchdev && !port_num))
-		return NULL;
+	return rdma_alloc_hw_stats_struct(cnts->names,
+					  cnts->num_q_counters +
+						  cnts->num_cong_counters +
+						  cnts->num_ext_ppcnt_counters,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
 
-	cnts = get_counters(dev, port_num - 1);
+static struct rdma_hw_stats *
+mlx5_ib_alloc_hw_port_stats(struct ib_device *ibdev, u32 port_num)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+	const struct mlx5_ib_counters *cnts = &dev->port[port_num - 1].cnts;
 
 	return rdma_alloc_hw_stats_struct(cnts->names,
 					  cnts->num_q_counters +
-					  cnts->num_cong_counters +
-					  cnts->num_ext_ppcnt_counters,
+						  cnts->num_cong_counters +
+						  cnts->num_ext_ppcnt_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
@@ -666,7 +673,17 @@ void mlx5_ib_counters_clear_description(struct ib_counters *counters)
 }
 
 static const struct ib_device_ops hw_stats_ops = {
-	.alloc_hw_stats = mlx5_ib_alloc_hw_stats,
+	.alloc_hw_port_stats = mlx5_ib_alloc_hw_port_stats,
+	.get_hw_stats = mlx5_ib_get_hw_stats,
+	.counter_bind_qp = mlx5_ib_counter_bind_qp,
+	.counter_unbind_qp = mlx5_ib_counter_unbind_qp,
+	.counter_dealloc = mlx5_ib_counter_dealloc,
+	.counter_alloc_stats = mlx5_ib_counter_alloc_stats,
+	.counter_update_stats = mlx5_ib_counter_update_stats,
+};
+
+static const struct ib_device_ops hw_switchdev_stats_ops = {
+	.alloc_hw_device_stats = mlx5_ib_alloc_hw_device_stats,
 	.get_hw_stats = mlx5_ib_get_hw_stats,
 	.counter_bind_qp = mlx5_ib_counter_bind_qp,
 	.counter_unbind_qp = mlx5_ib_counter_unbind_qp,
@@ -690,7 +707,10 @@ int mlx5_ib_counters_init(struct mlx5_ib_dev *dev)
 	if (!MLX5_CAP_GEN(dev->mdev, max_qp_cnt))
 		return 0;
 
-	ib_set_device_ops(&dev->ib_dev, &hw_stats_ops);
+	if (is_mdev_switchdev_mode(dev->mdev))
+		ib_set_device_ops(&dev->ib_dev, &hw_switchdev_stats_ops);
+	else
+		ib_set_device_ops(&dev->ib_dev, &hw_stats_ops);
 	return mlx5_ib_alloc_counters(dev);
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index f469fd1c753d99..d5ceb706d964f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -40,13 +40,10 @@ int rxe_ib_get_hw_stats(struct ib_device *ibdev,
 	return ARRAY_SIZE(rxe_counter_name);
 }
 
-struct rdma_hw_stats *rxe_ib_alloc_hw_stats(struct ib_device *ibdev,
-					    u32 port_num)
+struct rdma_hw_stats *rxe_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						 u32 port_num)
 {
 	BUILD_BUG_ON(ARRAY_SIZE(rxe_counter_name) != RXE_NUM_OF_COUNTERS);
-	/* We support only per port stats */
-	if (!port_num)
-		return NULL;
 
 	return rdma_alloc_hw_stats_struct(rxe_counter_name,
 					  ARRAY_SIZE(rxe_counter_name),
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
index 2f369acb46d79b..71f4d4fa9dc8b6 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
@@ -29,8 +29,8 @@ enum rxe_counters {
 	RXE_NUM_OF_COUNTERS
 };
 
-struct rdma_hw_stats *rxe_ib_alloc_hw_stats(struct ib_device *ibdev,
-					    u32 port_num);
+struct rdma_hw_stats *rxe_ib_alloc_hw_port_stats(struct ib_device *ibdev,
+						 u32 port_num);
 int rxe_ib_get_hw_stats(struct ib_device *ibdev,
 			struct rdma_hw_stats *stats,
 			u32 port, int index);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index aeb5e232c19575..80f3094b17b5c3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1058,7 +1058,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.driver_id = RDMA_DRIVER_RXE,
 	.uverbs_abi_ver = RXE_UVERBS_ABI_VERSION,
 
-	.alloc_hw_stats = rxe_ib_alloc_hw_stats,
+	.alloc_hw_port_stats = rxe_ib_alloc_hw_port_stats,
 	.alloc_mr = rxe_alloc_mr,
 	.alloc_pd = rxe_alloc_pd,
 	.alloc_ucontext = rxe_alloc_ucontext,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7e2f3699b8987b..8fa7fd20e94aa7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2523,13 +2523,14 @@ struct ib_device_ops {
 			    unsigned int *meta_sg_offset);
 
 	/**
-	 * alloc_hw_stats - Allocate a struct rdma_hw_stats and fill in the
-	 *   driver initialized data.  The struct is kfree()'ed by the sysfs
-	 *   core when the device is removed.  A lifespan of -1 in the return
-	 *   struct tells the core to set a default lifespan.
+	 * alloc_hw_[device,port]_stats - Allocate a struct rdma_hw_stats and
+	 *   fill in the driver initialized data.  The struct is kfree()'ed by
+	 *   the sysfs core when the device is removed.  A lifespan of -1 in the
+	 *   return struct tells the core to set a default lifespan.
 	 */
-	struct rdma_hw_stats *(*alloc_hw_stats)(struct ib_device *device,
-						u32 port_num);
+	struct rdma_hw_stats *(*alloc_hw_device_stats)(struct ib_device *device);
+	struct rdma_hw_stats *(*alloc_hw_port_stats)(struct ib_device *device,
+						     u32 port_num);
 	/**
 	 * get_hw_stats - Fill in the counter value(s) in the stats struct.
 	 * @index - The index in the value array we wish to have updated, or
-- 
2.31.1

