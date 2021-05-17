Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2DA383A66
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhEQQtg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 12:49:36 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:65527
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239779AbhEQQtP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 12:49:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j71xaeTaO0YctrFulbtjZqTEm7ZIAMLLcWqG4ZgsMAB0M5KlpAtNpgE/tQeS1NwRg59RwW7OUYBkaPi0YRiFDGT8tWWrf9yD3YUtKEYZDx3S/HmoMUiU5uIBN3EP9GqltKV7vctnaIMLU6ELDYHVB2s+dfFTlTp2tpQvyCpq2DPfmExfG4Qa2bULps4EMv09AxxVrErrCt5BiZ2+GckE1oGpx2pWtugMQyxk5lpuD+rnxUPyZfvD8Ud5ppkZWWdZ3f2qUOQY9BBpHiD0RF2EdwjshhmM8q9i7u41GMva5DrqKoUF9+kO6Bq6gi+NXjXy0uUeFVQRxhlrKFX1zwhifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldNFWULt7iC+ylA0MhPSsEFM5ZqdKjaBsneY1jIw6s8=;
 b=cNuzyLiiiQ4lkRXS75rHZD7kpVijOyrRtnCPJRmrrrjx4D5iSHJLNuWk/aWYqbiAckMzf8BNnqDEXvTzR3eezIl0fUUV1Jne2jAZ1xim035E86nkV/rh4VzM492+JcwZPKl4FoOxryx+8/Y/x3YSOmN8OZe+cn3Yii3aDKNFrv3uPuTIhee1T8fMndzgcKIP8GqD74aAZFNduE1SpR5nPgyuPPnGy+tGmJl5C9BHgu1+S0N3sI4KW4kRPVXisDGmHuBp+MbXUZS0bg8BEWhE1Anqf3b8tSSyFRxeZsboJ3PA6gyf+KJHsnlqOfLV0QuBIWAzZ5xg7WIVs1kWReqawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldNFWULt7iC+ylA0MhPSsEFM5ZqdKjaBsneY1jIw6s8=;
 b=sjJNQQkn4QSbLJ66JKYzcp6nVgzhsDuuwC30pEllDy6ynmS0+PIAY1vYdT5/7pZdcv1rQJck9+1eKVHSXUVGIKxtWNnFwAVmCze/27qgFDdDzWLVaY/PhkfiwqHj/FTBcdJAffCktuYytYUtpQS2Bh9VM6gu1CVMid5oENtWnNo5rLt6moIQ1VCMXt1RE4JB+2CYsXw77/uQcQqZH7P97/Z5oYvgFu4A/8DksVs1qiLI5iYEUs0p66umL3sC8p1cmBFcJD9BXLnLgh09AQbfZubyAfRbBQr0Viq/kCkyF/t7Kur8kUx19CsnZkxVwM5Ind9J65wsLjEkg8lxDopdWA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:47:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:47:45 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 07/13] RDMA/core: Create the device hw_counters through the normal groups mechanism
Date:   Mon, 17 May 2021 13:47:35 -0300
Message-Id: <7-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:208:32a::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0108.namprd03.prod.outlook.com (2603:10b6:208:32a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Mon, 17 May 2021 16:47:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligP8-009LYj-1p; Mon, 17 May 2021 13:47:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae324dd2-f7ce-467d-0d93-08d919537e01
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB285884BFFDF6C5BE0FA6323DC22D9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHOtOvxRJVQ9j4KDjTKtaXHSodo2WijcTWCADDxvrXMmqdWM1/rsE8BJN+MuNCq/IBM2Sd3ToRYN+zEtRwWwyZaCcd2VO6/bEociYlDX63xsVFR1fiQBNnWJEF5PcEc8BewNg0C7CUxCKHcjCrJ1+gM3Phjol4HSW4Jp28bJjSS5kouCcfaiBQc8NU8HV7HMcl/ini3lHgLDiKPq08BH1y9OebWOOmtkIoJTCscwqo0StPsQo+ibU/yeXLM5sPB+FCRxEjA77IJsPgpPRKdRXrWFa5IIaOMC/XzhlNQq7Yb1QBKOELPhTdagEdnyF3uhMvUv2mHhXgQNdSq7Kx5pZ0Soy8jPI9S+IP7UERkEo9q5nRBbliWLqlrnGPWtIpUBeB0zcNCxy9nvlLHuM0aCoqcJRFycOwXiOtWweEX1bJK5jIjanmnCJaqZQjlpVuJ0u76qXLcRjlJVusViryNjQyOrEhpT+fhFdkN13BeipdWhjLQB+bUZfYLqpCuo+rzaEvEWmrTwjQbSBFiZT0VPxcm17xJsPzjgOofrj5UZ7oQbdiqzhG6sWExrWWzIJCfwJN9BD/3JZsEsfflAa4JtUk1d4jGKKsPsntVRZDtLDcSQLKwitOZUj2JkVJN0Euqnx+b3EVM27Zznh/MIKLc3vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(54906003)(6666004)(9746002)(8676002)(66556008)(426003)(83380400001)(36756003)(9786002)(26005)(66946007)(38100700002)(316002)(66476007)(4326008)(478600001)(86362001)(5660300002)(186003)(8936002)(2616005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nA76F6HDGsjHunppm5XBgMEoLtjKR0mpCYOeKPOdfiwKSGjaYm8wRRMWhTcc?=
 =?us-ascii?Q?Kfa01iT2RJuw+Gn8XauABpXPV+WWaXDbfkiUoRNPfJyDb9uIQo6C6biOMTk0?=
 =?us-ascii?Q?wcNYw9dJUCYrQc0dLo1yFxgelF4dy+JYbmIbgztexaDrZoTMt3b4df/pu+p3?=
 =?us-ascii?Q?lIpM0M+DOzohjUJTFGvTi0iOxTPkbeqbzon1NZCzRa7iKPHU5QJNIc5I8cmw?=
 =?us-ascii?Q?Yzuhkeq9TxDKEnEjchmmryeWs09+Vhk8MAVsc/MxbX5X0NeXmVQckC84/vEF?=
 =?us-ascii?Q?su5AdwO6WWRCTtbX3HbE1PYK8TrJ2PcIU3PkVdoUxtgXbvvsriHjeiczxmXD?=
 =?us-ascii?Q?3VJMbVICgzV9i2d5ZXB7VoNuhF5Vh7Uc3pr9ISPHN/dV+3u5XTX5UFRh99Yi?=
 =?us-ascii?Q?6LrqADPhSH6qDzFI2mt0+bh4iw5s7V1gg7J54rESYOazagxom/zZOmNR2X4x?=
 =?us-ascii?Q?ZvqG5GhrsvMXkVqUw2iBA+aq6XCpSEhXX4zmyj66ZhI/nDjUYZiNTKqsf4R6?=
 =?us-ascii?Q?z8Jgy4UdoRFahiRbX1xjwAw50zoCpafAmOmwuO2jaUkiUsefUkuI1QXdKxe+?=
 =?us-ascii?Q?1/KqNWWrIL1iF2lCtHi3jkr+o2LWR8IrswPvDsXmbJNURS404Fcxg9jTbHcZ?=
 =?us-ascii?Q?Er5Etqeq2YJLQHmtk6hmORDg0QYZumZyiQRQuoK+6RJJa/GEtSVR8+SgkC2s?=
 =?us-ascii?Q?PKoK9UYhuA0orD5Y43ykB2Ph74pNzZTCyWUSTCjWlRyEwONmtoQP0JR2uDGT?=
 =?us-ascii?Q?t0DEMMo1GtQbfQCdUvlSjo52oGZoVmG8vJ2AU+zyIgPC5MTBVF71XdpigljT?=
 =?us-ascii?Q?vgLdHwAfohoczuPl4/L367pBR4vH6BoM2V57rNcsoUZh9iiveA4GL2AYhLw8?=
 =?us-ascii?Q?54GiFfK+wcMuuigvhjG39BjMtR/3zF7XmyVT58vhf3rKdaDPmFTuz7TDaXou?=
 =?us-ascii?Q?fJOkOdkJH2cAW41CIPMFkH6Ui1gDk6B145cMO9iPaT/B5LUaYT96Cz6z2FdL?=
 =?us-ascii?Q?UTgluHKhqpO5PpRzSZEgu2Tmfcqh3eCFskAfGPDYZjGZG/FFh3G7BmY7FOLY?=
 =?us-ascii?Q?AGOSkSbjXNeMY71vnJtMKtYBoRz6inh7FBrEp4GWt7GWDGh2nVAd5bNN7Sf8?=
 =?us-ascii?Q?xKUnUANef3dqBKUmuRbG6RsDYT+8Pi0Mjbu7mSQZaLLALRbbz8dOtP+qEaYu?=
 =?us-ascii?Q?tYm0T8VAM5F/mlgpKtOeACIejy861cyoZ4yuHerV+MeJpNPQ5ovR4RBAwrHd?=
 =?us-ascii?Q?WWfXXKwuFJsOfmDe6VbFCbfTLoLkYQx2d9yjizfeHu117AQLZiHVooMsk8AA?=
 =?us-ascii?Q?3hdkJn7HQShsjtZVuck02tay?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae324dd2-f7ce-467d-0d93-08d919537e01
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 16:47:44.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSNNNXxSiEVtbXOl++wRkDRDvDvfmrjZhLQi1ce17wLxe3tPr6cbc23fz+xpgOmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of calling device_add_groups() add the group to the existing
groups array which is managed through device_add().

This requires setting up the hw_counters before device_add(), so it gets
split up from the already split port sysfs flow.

Move all the memory freeing to the release function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  4 +-
 drivers/infiniband/core/device.c    | 11 ++++-
 drivers/infiniband/core/sysfs.c     | 65 +++++++----------------------
 include/rdma/ib_verbs.h             |  9 ++--
 4 files changed, 31 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index ec5c2c3db42303..6066c4b39876d6 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -78,8 +78,6 @@ static inline struct rdma_dev_net *rdma_net_to_dev_net(struct net *net)
 	return net_generic(net, rdma_dev_net_id);
 }
 
-int ib_device_register_sysfs(struct ib_device *device);
-void ib_device_unregister_sysfs(struct ib_device *device);
 int ib_device_rename(struct ib_device *ibdev, const char *name);
 int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim);
 
@@ -379,6 +377,8 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr);
 void ib_free_port_attrs(struct ib_core_device *coredev);
 int ib_setup_port_attrs(struct ib_core_device *coredev);
 struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev, u32 port_num);
+void ib_device_release_hw_stats(struct hw_stats_device_data *data);
+int ib_setup_device_attrs(struct ib_device *ibdev);
 
 int rdma_compatdev_set(u8 enable);
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 86a16cd7d7fdb2..030a4041b2e03b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -491,6 +491,8 @@ static void ib_device_release(struct device *device)
 
 	free_netdevs(dev);
 	WARN_ON(refcount_read(&dev->refcount));
+	if (dev->hw_stats_data)
+		ib_device_release_hw_stats(dev->hw_stats_data);
 	if (dev->port_data) {
 		ib_cache_release_one(dev);
 		ib_security_release_port_pkey_list(dev);
@@ -1394,6 +1396,10 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 
+	ret = ib_setup_device_attrs(device);
+	if (ret)
+		goto cache_cleanup;
+
 	ib_device_register_rdmacg(device);
 
 	rdma_counter_init(device);
@@ -1407,7 +1413,7 @@ int ib_register_device(struct ib_device *device, const char *name,
 	if (ret)
 		goto cg_cleanup;
 
-	ret = ib_device_register_sysfs(device);
+	ret = ib_setup_port_attrs(&device->coredev);
 	if (ret) {
 		dev_warn(&device->dev,
 			 "Couldn't register device with driver model\n");
@@ -1449,6 +1455,7 @@ int ib_register_device(struct ib_device *device, const char *name,
 cg_cleanup:
 	dev_set_uevent_suppress(&device->dev, false);
 	ib_device_unregister_rdmacg(device);
+cache_cleanup:
 	ib_cache_cleanup_one(device);
 	return ret;
 }
@@ -1473,7 +1480,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 	/* Expedite removing unregistered pointers from the hash table */
 	free_netdevs(ib_dev);
 
-	ib_device_unregister_sysfs(ib_dev);
+	ib_free_port_attrs(&ib_dev->coredev);
 	device_del(&ib_dev->dev);
 	ib_device_unregister_rdmacg(ib_dev);
 	ib_cache_cleanup_one(ib_dev);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 53838bce574264..168c43a644d76c 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -107,7 +107,6 @@ struct hw_stats_port_attribute {
 
 struct hw_stats_device_data {
 	struct attribute_group group;
-	const struct attribute_group *groups[2];
 	struct rdma_hw_stats *stats;
 	struct hw_stats_device_attribute attrs[];
 };
@@ -916,7 +915,6 @@ alloc_hw_stats_device(struct ib_device *ibdev)
 	mutex_init(&stats->lock);
 	data->group.name = "hw_counters";
 	data->stats = stats;
-	data->groups[0] = &data->group;
 	return data;
 
 err_free_data:
@@ -926,29 +924,33 @@ alloc_hw_stats_device(struct ib_device *ibdev)
 	return ERR_PTR(-ENOMEM);
 }
 
-static void free_hw_stats_device(struct hw_stats_device_data *data)
+void ib_device_release_hw_stats(struct hw_stats_device_data *data)
 {
 	kfree(data->group.attrs);
 	kfree(data->stats);
 	kfree(data);
 }
 
-static int setup_hw_device_stats(struct ib_device *ibdev)
+int ib_setup_device_attrs(struct ib_device *ibdev)
 {
 	struct hw_stats_device_attribute *attr;
 	struct hw_stats_device_data *data;
 	int i, ret;
 
 	data = alloc_hw_stats_device(ibdev);
-	if (IS_ERR(data))
+	if (IS_ERR(data)) {
+		if (PTR_ERR(data) == -EOPNOTSUPP)
+			return 0;
 		return PTR_ERR(data);
+	}
+	ibdev->hw_stats_data = data;
 
 	ret = ibdev->ops.get_hw_stats(ibdev, data->stats, 0,
 				      data->stats->num_counters);
 	if (ret != data->stats->num_counters) {
 		if (WARN_ON(ret >= 0))
-			ret = -EINVAL;
-		goto err_free;
+			return -EINVAL;
+		return ret;
 	}
 
 	data->stats->timestamp = jiffies;
@@ -972,26 +974,12 @@ static int setup_hw_device_stats(struct ib_device *ibdev)
 	attr->attr.store = hw_stat_device_store;
 	attr->store = set_stats_lifespan;
 	data->group.attrs[i] = &attr->attr.attr;
-
-	ibdev->hw_stats_data = data;
-	ret = device_add_groups(&ibdev->dev, data->groups);
-	if (ret)
-		goto err_free;
-	return 0;
-
-err_free:
-	free_hw_stats_device(data);
-	ibdev->hw_stats_data = NULL;
-	return ret;
-}
-
-static void destroy_hw_device_stats(struct ib_device *ibdev)
-{
-	if (!ibdev->hw_stats_data)
-		return;
-	device_remove_groups(&ibdev->dev, ibdev->hw_stats_data->groups);
-	free_hw_stats_device(ibdev->hw_stats_data);
-	ibdev->hw_stats_data = NULL;
+	for (i = 0; i != ARRAY_SIZE(ibdev->groups); i++)
+		if (!ibdev->groups[i]) {
+			ibdev->groups[i] = &data->group;
+			return 0;
+		}
+	return WARN_ON(-EINVAL);
 }
 
 static struct hw_stats_port_data *
@@ -1445,29 +1433,6 @@ int ib_setup_port_attrs(struct ib_core_device *coredev)
 	return ret;
 }
 
-int ib_device_register_sysfs(struct ib_device *device)
-{
-	int ret;
-
-	ret = ib_setup_port_attrs(&device->coredev);
-	if (ret)
-		return ret;
-
-	ret = setup_hw_device_stats(device);
-	if (ret && ret != -EOPNOTSUPP) {
-		ib_free_port_attrs(&device->coredev);
-		return ret;
-	}
-
-	return 0;
-}
-
-void ib_device_unregister_sysfs(struct ib_device *device)
-{
-	destroy_hw_device_stats(device);
-	ib_free_port_attrs(&device->coredev);
-}
-
 /**
  * ib_port_register_module_stat - add module counters under relevant port
  *  of IB device.
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 53eba744ad8fb6..5f70aab1f8663b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2678,11 +2678,12 @@ struct ib_device {
 		struct ib_core_device	coredev;
 	};
 
-	/* First group for device attributes,
-	 * Second group for driver provided attributes (optional).
-	 * It is NULL terminated array.
+	/* First group is for device attributes,
+	 * Second group is for driver provided attributes (optional).
+	 * Thrid group is for the hw_stats
+	 * It is a NULL terminated array.
 	 */
-	const struct attribute_group	*groups[3];
+	const struct attribute_group	*groups[4];
 
 	u64			     uverbs_cmd_mask;
 
-- 
2.31.1

