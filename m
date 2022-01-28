Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F200F49FE8B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 17:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350376AbiA1Q74 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 11:59:56 -0500
Received: from mail-sn1anam02on2052.outbound.protection.outlook.com ([40.107.96.52]:24036
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350379AbiA1Q74 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 11:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW6B+g+QhSpNNN391KFght3TCI1xP3ed6EeEfNKIkaT7q3kgBvaVNjJbegMMynU8+yF/P0Wqn1yWLySyv7U2LD/rzlndzOqQ+DYX9Om4Cr8+PHaDjDOtJdv43CwghjdMtHMoy4mnfzC05b3zn5CF9++i5IoImpy474Lr3kyMUtdmXWUSmkzHCb00lyxE1xZO8ehPkZZFPjWAN28s/30SfpRVwO3FqGCk80q/Q08ncTJLUBlyngi75XjU9LlckZ+9hn9Lx9uweGqSjhxtby7acQ5HcF+CAV0mZypsDO2j9Kghne8mq9ACB12ua3TL/jRkfE6DmggZXodCHbk3YAyEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/laC0wppz0wzbqNEAB/Q+3DJVVK+QT9OyLO0td1fZ4=;
 b=eVNk+UPqODrGKyyQbeizlpzP+/pRw9DKrCbYgrMXvlE+PRfxP05F7ReDtkkpSmRFitbgDT2hgOKhTI2TvY0hCaJIXnKFt32aRFeV5pZJGYatcSX5Tp8jtzmsPQSXwr2hfwwlpj5dh6lvyKHdp3OWMzTVt4n9dKPpNe3es8fUiROCB5uzW2zOS4mrZpBj8h0GpCqhtDs55n7s1Zv5bI+vthYmg6z7HAG2jwWpL7Emv1Idzy7ZyxwqwY1/US2X2wp27YrBGYivShreZPAt2JqwF8FngNUSa4C1OAILsGKtS+KZ8FSQehZgVlmuT5XK2T/7RhJVa9/z4A3pNVIA+M83MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/laC0wppz0wzbqNEAB/Q+3DJVVK+QT9OyLO0td1fZ4=;
 b=afPHHZoGACgCl+K+VCwQkqtW0JRkR5uuY4mi9IU+DXEavIgoCS3v0aY5ZBoiBl09UWc6gYw50fdVlP664AC45WY38RsrQ/KlwG/FhvyhMPRN9SKx9YjrUpmtTTbf17JMYtHDP9s1AFayA9QOElNNUq+qJebs4pqWurHO767Fs4LBVfFz7595lmV+KnXQqxreNP0VBomuzXqbqMBWauUyxxcMHqUNZDqS5VO1LryouZUMOAwadohs62QNQY2aRghc3zCmqimpooGBghWChgsS/N6f+NjgtyGH9RarP4UXMOkwRxdJ32FGf5JKNlcs8S3X1fTN+q2hrSxRGUiaKmFLcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1589.namprd12.prod.outlook.com (2603:10b6:910:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 28 Jan
 2022 16:59:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 16:59:53 +0000
Date:   Fri, 28 Jan 2022 12:59:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        haris.iqbal@ionos.com, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-clt: Fix possible double free in error case
Message-ID: <20220128165951.GA1874313@nvidia.com>
References: <20220120143237.63374-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120143237.63374-1-jinpu.wang@ionos.com>
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e544500-b881-4769-99c6-08d9e27f9ac6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1589:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1589BBE9C459BFA44CF1430BC2229@CY4PR12MB1589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJYuhI0k/XmCA7GWyFxiBBNc5fGVeqldB50q/QbO0IIYPpLrXD7pX1C3PomEB4g5aheHF5Yvguags3HCZqbwMcmLa5fiUByFod8VVgZexEI4ol2kC7ae3tU6poXiNA6dxcHxTQQ4e0dAeIoSW913ZqTdGR5X/7BCEsLn8fcBDCVwlxLzFQLsEL1G/b1UACwxVLb0ijkXM2ylBTsMBaZ6u8UTBP0jNjdZ2KoT7sOQA/wf2Dy7NppeinD9UsmNRZnXEze1oLJsKDYoPfFOdWveFuD9FBXRUM2M+9sJO+NHHp6CyTvF4JGnFWPHHlXDu9c2V9lK77tIbqTvEjxAOjAlEWvG6Xtfx45pOTGp7qGC9AQQqsFnUhBLIj3NZgL11XKE02sv8goGC4niQ6opdsCNzTjNOv8ymI+w/3wy06OlCQXhAa+CKaNK+ZccbCWBUfMeuEzNf9107quGMFydL2GG2XMdzs12cdQ9/YBVavy2QFQ9v4DT2v8ESAj63nbP/V/Obsf3SrsGxSQft7xKi41630YJrabeRFjU4fw7Ey/xIsN7ordSgA8J52Ic9L7o6popAwnbnkRuE3c111OFl2CPKUlMO7ZK784QFroR7DRDOi7yUext3QWe8aJKDSRcm7AiUm/HZ3Xfv2raWia8+FgxHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(8936002)(83380400001)(1076003)(8676002)(2616005)(4326008)(66946007)(66556008)(508600001)(26005)(66476007)(316002)(5660300002)(2906002)(36756003)(6916009)(186003)(6506007)(33656002)(6512007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfuZsATiGyY7ao9TKfvzlwZPvrbwx6RGPmAOr37rTV167+cFjH86/Zmvru22?=
 =?us-ascii?Q?X5AOSOjkSklEnewbkLoI+jpLHCWrccD1cdmfy/4oLZiUKa386LYh3h7raHtG?=
 =?us-ascii?Q?I1IbsRqKReGFRJ7dg0JyCVPuWAgPI7OkE6NeS1nC9wLH0lyQj4UxSOdKFDHq?=
 =?us-ascii?Q?wlWqq12avIt8TC5k16hyKMQpWW++OHBhi+l+ZdJm3K2PjMwYQQV1KYNdZ+Ro?=
 =?us-ascii?Q?UUypWPACAPWbiBe5jj6+I3SZOP+zLBh9ynGcJBOF+fHz1vsGpmMGgDk0oc9O?=
 =?us-ascii?Q?UmzDKR047XZxZyy04Wl6l6jrBtJaCCyJhF7gQqSrKXsVYwZdwj+V9e+15VRw?=
 =?us-ascii?Q?ZYs1DB+wn8ZaOYoUark2dVcLku91m0I8pJmLKRtzbbuNmC8DI804pXXvKdti?=
 =?us-ascii?Q?UfPvE1Iupqq8Rqz9YK/OhPFTp8FV1d07aRtrXtBrnW+YHWx5FmHriRjq+mst?=
 =?us-ascii?Q?M6NrNIU9J1tdfdErBcfGu5aTqhjlFa6wLJP8QnitDJCCtRdTNUTPP344Xz0n?=
 =?us-ascii?Q?XmvEo3BIB3Ss42ZmhO5Wo+6EuBp0Op9uqHa+DiN6a2jqnnPZAmVqDqVPCUyp?=
 =?us-ascii?Q?lhyxZAOo5xl8JxMJ/V2mQkKvHJCcf5sAeupqMhpAvHnUDw1lBWF1vi6feXWc?=
 =?us-ascii?Q?w7aOy3lwtb4h1PtfgG/2dRX81wgrf3DA5l7Da6a5iaF+z1a5FI1KFZupNNRi?=
 =?us-ascii?Q?1bZbzSP9c1YxdayHc16bxpmzBGbZcQcR32bXIoaeX+XzXFm46R1keQdQ9NBA?=
 =?us-ascii?Q?r+qOp38HoGhSctmZDFWRbvFQHzXulvhFBN8wPEc5/gFDbZIhx0vGmrh/z41O?=
 =?us-ascii?Q?BjQwcf3f0SCwTrFYaYuURfSLv9rdE4HElCc8ijKLhmy0qeYL7Lx5sUdf+WK6?=
 =?us-ascii?Q?GsHqcz5kIgHVlXi6sbSeU/6uY3YcJI9w+yni0NGL6GGgBVCP6mpJcRMk2GIA?=
 =?us-ascii?Q?mohUD9Hze6eufMREFEq64e2qlohBbQvvYEpAgzYXrBEiNLVMIKL9XKfXpaBg?=
 =?us-ascii?Q?NMS2qiJid6SGyf4E5AaWaX3amEK06+DpwEFngTmehSNuVTDwmF8nhDg4gLrs?=
 =?us-ascii?Q?BqQjZYgRanE1yvkLHC4d2lRavVn24kjyqdgWkJM357+z5AwICx6wTM5oj+eS?=
 =?us-ascii?Q?Qg6DISz4WKyLoM1xYOdZKygFgih8Xs39jVfgIKoxEG+HwZi+BBS2NnPQ915H?=
 =?us-ascii?Q?axRVNtngleRtQjgNeq+PDBMndP1OTximfHR1EmUOhpFY6NP1kdK3KyN2dZ9A?=
 =?us-ascii?Q?+2IhRo03t5cLs2Xfga8UfH5gk4GTxgMc/mfSbN/UVFY706y5cscgdTC4khyf?=
 =?us-ascii?Q?M6GZJuHX6lAA62pGfC38WvmV1wiOkPhGF4lTfCm9D0Muz8PPtWOjvfQBzaA0?=
 =?us-ascii?Q?qiMMjRivttO+p72jGXigth7OcNWKp+BLftOzGr+SeCA3iJbp98rs2dKuLRPm?=
 =?us-ascii?Q?CyOUh7sUuH7/UU7fImcr4OLKXM/qLaHhW6PRyJs/5/FsczEwS3hNaupRLFxL?=
 =?us-ascii?Q?SHwTqSzBs8iSYim2LGSyC0JLomLERaMfAmvwxdZyGOTyY5R38hYUBL50kfwB?=
 =?us-ascii?Q?4nQq57tkIM7VLm5Srf8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e544500-b881-4769-99c6-08d9e27f9ac6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 16:59:53.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgzy7OAcPvHjFy77TvXPz7TR04iZ/7grufcG5fw+GUqpbjqGdsLQD4V5KHGoeRls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1589
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 03:32:37PM +0100, Jack Wang wrote:
> Callback function rtrs_clt_dev_release() for put_device()
> calls kfree(clt) to free memory. We shouldn't call kfree(clt) again,
> and we can't use the clt after kfree too.
> 
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Reported-by: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index b159471a8959..fbce9cb87d08 100644
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2680,6 +2680,7 @@ static void rtrs_clt_dev_release(struct device *dev)
>  	struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
>  						 dev);
>  
> +	free_percpu(clt->pcpu_path);
>  	kfree(clt);
>  }

This need to delete the call in free_clt() too.

Also, calling dev_set_name before device_initialize is a bad idea.

Do it like this and fix all the bugs please:

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b696aa4abae46d..4d1895ab99c4da 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2685,6 +2685,9 @@ static void rtrs_clt_dev_release(struct device *dev)
 	struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
 						 dev);
 
+	free_percpu(clt->pcpu_path);
+	mutex_destroy(&clt->paths_ev_mutex);
+	mutex_destroy(&clt->paths_mutex);
 	kfree(clt);
 }
 
@@ -2707,13 +2710,8 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 	clt = kzalloc(sizeof(*clt), GFP_KERNEL);
 	if (!clt)
 		return ERR_PTR(-ENOMEM);
-
-	clt->pcpu_path = alloc_percpu(typeof(*clt->pcpu_path));
-	if (!clt->pcpu_path) {
-		kfree(clt);
-		return ERR_PTR(-ENOMEM);
-	}
-
+	clt->dev.class = rtrs_clt_dev_class;
+	clt->dev.release = rtrs_clt_dev_release;
 	uuid_gen(&clt->paths_uuid);
 	INIT_LIST_HEAD_RCU(&clt->paths_list);
 	clt->paths_num = paths_num;
@@ -2730,52 +2728,52 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 	init_waitqueue_head(&clt->permits_wait);
 	mutex_init(&clt->paths_ev_mutex);
 	mutex_init(&clt->paths_mutex);
+	device_initialize(&clt->dev);
+
+	clt->pcpu_path = alloc_percpu(typeof(*clt->pcpu_path));
+	if (!clt->pcpu_path) {
+		err = -ENOMEM;
+		goto err_put;
+	}
 
-	clt->dev.class = rtrs_clt_dev_class;
-	clt->dev.release = rtrs_clt_dev_release;
 	err = dev_set_name(&clt->dev, "%s", sessname);
 	if (err)
-		goto err;
+		goto err_put;
+
 	/*
 	 * Suppress user space notification until
 	 * sysfs files are created
 	 */
 	dev_set_uevent_suppress(&clt->dev, true);
-	err = device_register(&clt->dev);
-	if (err) {
-		put_device(&clt->dev);
-		goto err;
-	}
+	err = device_add(&clt->dev);
+	if (err)
+		goto err_put;
 
 	clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
 	if (!clt->kobj_paths) {
 		err = -ENOMEM;
-		goto err_dev;
+		goto err_del;
 	}
 	err = rtrs_clt_create_sysfs_root_files(clt);
 	if (err) {
 		kobject_del(clt->kobj_paths);
 		kobject_put(clt->kobj_paths);
-		goto err_dev;
+		goto err_del;
 	}
 	dev_set_uevent_suppress(&clt->dev, false);
 	kobject_uevent(&clt->dev.kobj, KOBJ_ADD);
 
 	return clt;
-err_dev:
-	device_unregister(&clt->dev);
-err:
-	free_percpu(clt->pcpu_path);
-	kfree(clt);
+err_del:
+	device_del(&clt->dev);
+err_put:
+	put_device(&clt->dev);
 	return ERR_PTR(err);
 }
 
 static void free_clt(struct rtrs_clt_sess *clt)
 {
 	free_permits(clt);
-	free_percpu(clt->pcpu_path);
-	mutex_destroy(&clt->paths_ev_mutex);
-	mutex_destroy(&clt->paths_mutex);
 	/* release callback will free clt in last put */
 	device_unregister(&clt->dev);
 }
