Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BE32A075C
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 15:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgJ3ODL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 10:03:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10700 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgJ3ODJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 10:03:09 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c1d270002>; Fri, 30 Oct 2020 07:03:19 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 14:03:08 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 14:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLXyjp9qIe3erWamO+JvxmbU8nr/+WHfAZ82rAvW5qP3ZN94pkvJm65ob18I/B9SYy7HmJGPjpOVJzBz1Ou28CumSA04G79gpMF7NNiplTFCo8ICD0zURdOkx9laqHqX9FJOEqOnRkI5s/cid4+GTXVZ4nfRCPTeZoVLVbN+PnOc4lbRMZIsMnOP2OjCZBRSASCJOTSLyeHr7OVWOkYOqXQxzzdtH5d1JK7Objav6AUFcMxv0dqYmeOrRy+0j8WtSdsfNQrVEqb/ycjYAtdamiLS67M5SJOhzOQjinuDcr/dkDlLzn5XI4ULNE2gJHgXQ4X6sqC6S/I9WhMFja4rVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvz573NFZ3QPZ62op1ryPkG607dT8d0VAWmyZYein8c=;
 b=Emt52P/OabCzOfG93m8XiAdnHCh/dSeZAh3HDYJorEJnOp6FgBDZtZGuz1WFQZN4ewyQh2gr+ONB8zxLnm+WZr/gtmwvGRatIVqfhAdBOSG3FOoURMy1FTvY5DdIP99OF9sxNKyfUp7WiUsR4bsPNwOdgHjQkf8SjOAmUXmC+0KhtvHaz6Fjn3XHX0I8unHElQ0D4GhI3KSqhmGOAJdy+CwgXaUOZhUEch7LhIIKpLRMTxLa5OhSTDWLa59mBZAzjmKtSNvIstKrdS0L/WwIgkqSecQddeif0tMv4xCqnYYBENRCdnktWrFBJkDQ5huah0kvIgaZxm30rQdnac8XRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 30 Oct
 2020 14:03:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 14:03:07 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>, <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <yanjunz@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] RDMA/rxe,siw: Restore uverbs_cmd_mask IB_USER_VERBS_CMD_POST_SEND
Date:   Fri, 30 Oct 2020 11:03:05 -0300
Message-ID: <0-v1-4608c5610afa+fb-uverbs_cmd_post_send_fix_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:208:134::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:208:134::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 14:03:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYUzh-00DDTr-LC; Fri, 30 Oct 2020 11:03:05 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604066599; bh=s4LsK2eF2M0pTMuYIVQMOCqQpKXC8cya0UqXQ9UqSBs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=jfJUZ564bSTSXJoE9kulI6+qUNNnFmr66glIpS1DcV47nzFfKv5zywC3X6afB9TfD
         v+AltztkWfQ2S4NAnSG41Jfiz/NX7gPnozRKNtwz7mTzDli5OOu+Z+j+eld2UOw7EG
         sUN2ILiC3R8xP7rEUud8EwxTFtd36WosR0ci2MStW0BqhqDvx/KuFe81jPJ2Ud2/v0
         s5IfFz9fAzU3Eqf9CfQHm9Xbe3qjQ7iHY6irqJILMn5pBGYfAjMBzmy/7nY7A5iU7B
         2zB84q94QeNd+gr6FbeCaN1as+7mFg6UuoMo+obsm1Ub28h/lztAbhWexUfNF3701d
         KzKA8Da7Wv7+g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These two drivers open code the call to POST_SEND and do not use the
rdma-core wrapper to do it, thus their usages was missed during the audit.

Both drivers use this as a doorbell to signal the kernel to start DMA.

Fixes: 628c02bf38aa ("RDMA: Remove uverbs cmds from drivers that don't use =
them")
Reported-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 3 ++-
 drivers/infiniband/sw/siw/siw_main.c  | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 7652d53af2c1d9..209c7b3fab97a2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1142,7 +1142,8 @@ int rxe_register_device(struct rxe_dev *rxe, const ch=
ar *ibdev_name)
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
 	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
=20
-	dev->uverbs_cmd_mask |=3D BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
+	dev->uverbs_cmd_mask |=3D BIT_ULL(IB_USER_VERBS_CMD_POST_SEND) |
+				BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
=20
 	ib_set_device_ops(dev, &rxe_dev_ops);
 	err =3D ib_device_set_netdev(&rxe->ib_dev, rxe->ndev, 1);
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/s=
iw/siw_main.c
index e49faefdee923d..9cf596429dbf7d 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -347,6 +347,8 @@ static struct siw_device *siw_device_create(struct net_=
device *netdev)
 				    addr);
 	}
=20
+	base_dev->uverbs_cmd_mask |=3D BIT_ULL(IB_USER_VERBS_CMD_POST_SEND);
+
 	base_dev->node_type =3D RDMA_NODE_RNIC;
 	memcpy(base_dev->node_desc, SIW_NODE_DESC_COMMON,
 	       sizeof(SIW_NODE_DESC_COMMON));
--=20
2.28.0

