Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6E48F9C9
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jan 2022 00:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiAOXDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jan 2022 18:03:04 -0500
Received: from mail-sn1anam02on2109.outbound.protection.outlook.com ([40.107.96.109]:14916
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233892AbiAOXDD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Jan 2022 18:03:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsEOMozJ1qxZ5p1YRCJ8uROhei4+KKSKjkisthiL2uqNiV7K3QUdU+/21Q2b/dq50Rg+yVkBXgm8c0/FZPEtcGNSrWZvh25BcbFSX0fJT1wDnFJt4DhLlMImCaq4Gm7U6DBZ9DargzVuOceuilL7KB5xw6m5nc90+4hCr5mDFAOFAl+wsQGUK6rsHPTXSYZfRtZI3FtzVCtEWlV/Xrhr6BsphEb/8vyaMCAp+jaElyhBM4lBhZyed40H/9fOz+Sqrshqc/yetCJnvHPuLyTdySjzHTHnwY2rOJDsZ4SnVFhn+AVTbVxPNiJhaZmISeXFCPof+AjvHyB3mfqWMIF74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea7AFtHsO9g/DjEvFV6rc29IBPPyBU7ea71DXeSlSU8=;
 b=SXcfAItNeH5f2YOl8lJyBVrUKe2N7wvJkNrfJdZRshxOaQE+NzzYMG9obn+irbKkGUfAgO17FniZzelmhSL019APoxcR2RDsIxc3ZyWrBx57wHkCyR/lJIpe/QYaHI6Dwc1UM4m9bhpYEOXsVZ/wPFCZGgX//FN98bDMvsGXPhBdOSZmBTWj+TuhVMj37e2q6rGXD1E81OdK2kvo63SzhlPcPBS5+g+VJM0MgPK/zwqhgGou0lgi57qwHJAK76g8JXf4wSmBDRl7Kbtk+aSoajjf++nEb4kRks5GJ+KVGyCEkeNxSG/3RbQH1oLR3Z/x2O6xhi0EIIbkttQvW1jaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea7AFtHsO9g/DjEvFV6rc29IBPPyBU7ea71DXeSlSU8=;
 b=fKfhbRNVz2nIzHUje8WmyubPr+e4ujUog6STcOnSDc2O0IOReryQcW7QpR36U/+VlzCUnQGYE9b6rYWvnTbU6Q0H7P1il/3ojAkkb757wrhp2Yhr0fL2Hk+GvT4rMaCo/2lldyu1/spyE7yGQEb3jDGj2q+KR1lVkW/Y0illgl+AOxb+9X1hY9arFAXoFAjCIfpgl5uiC/GS/I/Q5QHTzmMvkxV2aVADFeUj0g/yxqTmy2eCY731FtZ+7fFuPzKUYvgDQIrBAOBfWpR/0lroMlU/GwrM0G2twRXrK3buA4MPX1dDlDWIy5IG9PRJ2fJZqiS+bFKoI1UpGFBvqOfAcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 SA0PR01MB6140.prod.exchangelabs.com (2603:10b6:806:e4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Sat, 15 Jan 2022 23:03:02 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0%8]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 23:03:02 +0000
From:   mike.marciniszyn@cornelisnetworks.com
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: [PATCH for-rc 4/4] IB/hfi1: Fix tstats alloc and dealloc
Date:   Sat, 15 Jan 2022 18:02:36 -0500
Message-Id: <1642287756-182313-5-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1642287756-182313-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
References: <1642287756-182313-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To CH0PR01MB7153.prod.exchangelabs.com
 (2603:10b6:610:ea::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e064fbc-b300-4f94-edc4-08d9d87b2e96
X-MS-TrafficTypeDiagnostic: SA0PR01MB6140:EE_
X-Microsoft-Antispam-PRVS: <SA0PR01MB6140C82796BC393A760331E9F2559@SA0PR01MB6140.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWBzqBKyPPAgRaJ/DAoOw5b/dmD5gB1J/3AtyZGLB+S2WxFa7Af/kgSrEfTPsctwYvZeCpgnWkMKg8OtGVzTMIqbYkrAqsfnJocO40VdvI1xVO9aVrjp+ErHb95g6/vHlonPzYf2YwA/tIxTIcAVB/VIM0Dc12BBxvNVRaXg2aLmEiVPhfa5kN6D1iJmhpVt6ZDePcUs0RXm4/Syu/2WLx3sg/xeJ+Sz4b4kpIKrTZfveQSVYSXAm4ABOPO1AqA+tNoE78KDWACTE68PBTQXcXwcRDxhCIVuka/SjbFVA76FmcIvefk2aKZsgsKPdDkiB/IqGW+EB7+dhSw09vlD+/vkYxWdzajILAHR0zG68jLMSMEAhHw/iLynjBW1KfYbufLq05tRrbahMIFa8tsUznA2i/Do3FVaFTv9vpyp2sMHh15N2GcQr4Edsl2uhMAt9FDekFinSkFjTkgmp/8TJeejD5VsLTKSoPoTITmKnr/jyIe8XU4CKlR4SSyx4PPf6wqtsbiB9NmIrhumuFEklflZYdfvHXQZHyOlkD/zJLpIPGd1pyv2l2ClGktnV0pRtqRuVfx50i2NrRZEgyMGN3uS0eHyADGABxXEWqqWOfGEwxB6ajICsCDer8vS4V55ZmApkPv5IRbz++JV9Ii+zKs+n+gWQNziV8+e2evnV/3vH6UnP/3ETFjwzEGM3EQn5KddTur5A0ObbDPvdTKOqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(376002)(136003)(346002)(366004)(36756003)(86362001)(508600001)(4326008)(26005)(52116002)(8936002)(6666004)(38350700002)(38100700002)(6916009)(8676002)(6486002)(107886003)(66946007)(5660300002)(83380400001)(66556008)(66476007)(186003)(2906002)(316002)(2616005)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HG6BiyADX1zymP78UXXMQ28vyIrzLIlCTU023MToalKHjg3NSjiUFxskBwql?=
 =?us-ascii?Q?HvRWdkicyMx8M8V3k9PXiSxZtN5fmpk8rwKAwwb2VC+dNaLTW5Dk/2c6THYz?=
 =?us-ascii?Q?M6Xq20TbztceLdGbnzVlGoBVAtSiAbZsqwNuJ1cInVoDTjam2+iKqzFUYwdy?=
 =?us-ascii?Q?BVodfucfNQFCqqBB/+UHIAesdE4+XyvPYo153P61SZJG0VoJtQAf0edMHBNr?=
 =?us-ascii?Q?ofTIFxhDLfgUkmyCQIQxNLF+S78CAtxhfBvd09R9JAWGlRqW7LwdsPlzOKLd?=
 =?us-ascii?Q?MZbnAHkT+iY38aBXoURgvihnQKcy9UT+qZyNvbPVaY/Hu+/yXUMwQE7qRnP1?=
 =?us-ascii?Q?iZFu6osF+2vZ23Fq8n72XYhGxit+QK0RR6pKJnlMeodsTS/R+EgLddjUmCJ+?=
 =?us-ascii?Q?oND5qJZlZCQk+6JH7GPe0fQ+3KoeB5tA3RdKJWYgklEsvvrh5G0lsRvTBKlb?=
 =?us-ascii?Q?r1/Hp4zbmD5Zpue+3FE4FfvDEhftX4vuX/IgV37N1yc2U2rfenybHvsE1BRq?=
 =?us-ascii?Q?0n3JrvpmtFsFjLITPdVzO+BrFY4BJ3cui+UXoGXxbm/aQdBXvR2B5i+u58Zk?=
 =?us-ascii?Q?StDfrcGmAPir7jssqHsPBCwvd+dy3p1q4lrPpvkFuOboo2pPkOuXqcEnld3a?=
 =?us-ascii?Q?9F6ct69DHkZn5mFLSd9pq2uZn2PIaFLGtb5JQMTq8ut4R+BY7oKqem80OwgU?=
 =?us-ascii?Q?kUVAjs/lE7wiSKfZdakdlICzReZO0KvfedoT38VhJIpuMTNnlM+NUkhqxt91?=
 =?us-ascii?Q?0raoGvoqUgMbTPGb3L8qDDHuvDSRaV27RcMRx8lAgm6xzlE8cbfrcNDspUmO?=
 =?us-ascii?Q?gmhPcKEF868e7T2sFLPdEQ6ruEZFeHgpxVpG+J9QIprauxs/MM5WLCGKfBwU?=
 =?us-ascii?Q?EiO9fiq9iHXhV6Rdlk38y+7XQmQI+YqgS2FY79WFe7IkETE4ppbhTyVOi+jW?=
 =?us-ascii?Q?W91cwx0mGVqHAJmjj+QJXJPejP+dPrTL88W+8DVp741dauCNG0p1rKUB1tS3?=
 =?us-ascii?Q?pEUwWBGPwVejH5CIPP5DIwMnpNfioZMKGbUsWmBYU62LZl/J6cpmgpATpdTF?=
 =?us-ascii?Q?ibNobfy4co0qEh/rDwvqDgMtoKDUwAWCp5cbJydaRBpHGd854G4gDGg3QWOB?=
 =?us-ascii?Q?Rck9Bn78wZgnd5obESR1D7clirW4nJT2u1uADCmhJkAqH0b4fPwWV05j/8jc?=
 =?us-ascii?Q?Ara99NuCuTMLeRHLRSTgUgKPOPY4rZdMbdFyZu4YgLYJtxZchioPuIncFgwy?=
 =?us-ascii?Q?Mm9EQ3MkmF1FIr94oTUnEsdjf72L92P7WlVPZpckZVdPE+BEsJPlYp9jSIhK?=
 =?us-ascii?Q?kJTPhDpw71dYNEQxIB0aSH6aHh/UGrhTD7xX0iwx9Nm2Zu+H6lwibhG6XOAu?=
 =?us-ascii?Q?uVv90PNVErxkrGHLofTgdTaBs8qj335kHN9JvTf5DFeqhQNmGNzXieGoY2F6?=
 =?us-ascii?Q?GrK6d1FGb8ULkPSzd/lDrfN+j4wlQI9vVYciBNdMebFzUA6nDRlpxU5cXQcH?=
 =?us-ascii?Q?g25Asi0LUErjs31Ho4it5EiLUGMHy4E27t56SSytGchtInSVBQvqPtislEck?=
 =?us-ascii?Q?t9XTYBdl13nNjH/AmwgycMp9OMFKYmaKV8KsHPzvqwNXEg0CCQPINKcPP6Qz?=
 =?us-ascii?Q?9bUkL0WDVLmER6g4fRT/flhtT7b6PfQWMbVQH/n9NrBROyRb6xSQ9z40uchO?=
 =?us-ascii?Q?v4nXOCg06WZ87kCB+myJo4jejWQo7lAPD0Nb3SjEd0eHiJExTSKvYK3Oenp+?=
 =?us-ascii?Q?ek7G7zwILA=3D=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e064fbc-b300-4f94-edc4-08d9d87b2e96
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 23:03:02.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+dLBza/oxusYEjyZ8Cf+7snVth7LXMrhcvoVYgapUT983u+12M6PBOXHP5ggA+ZEhIpnfcvF+KBGtiLrEIrjiDT5aaxzwGnojia3oH8wwD11A84LEBwZKN0oaXrqLYP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6140
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The tstats allocation is done in the accelerated ndo_init
function but the allocation is not tested to succeed.

The deallocation is not done in the accelerated ndo_uninit
function.

Resolve issues by testing for an allocation failure and
adding the free_percpu in the uninit function.

Fixes: aa0616a9bd52 ("IB/hfi1: switch to core handling of rx/tx byte/packet counters")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
index 8306ed5..5d814af 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -22,26 +22,35 @@ static int hfi1_ipoib_dev_init(struct net_device *dev)
 	int ret;
 
 	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		return -ENOMEM;
 
 	ret = priv->netdev_ops->ndo_init(dev);
 	if (ret)
-		return ret;
+		goto out_ret;
 
 	ret = hfi1_netdev_add_data(priv->dd,
 				   qpn_from_mac(priv->netdev->dev_addr),
 				   dev);
 	if (ret < 0) {
 		priv->netdev_ops->ndo_uninit(dev);
-		return ret;
+		goto out_ret;
 	}
 
 	return 0;
+out_ret:
+	free_percpu(dev->tstats);
+	dev->tstats = NULL;
+	return ret;
 }
 
 static void hfi1_ipoib_dev_uninit(struct net_device *dev)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 
+	free_percpu(dev->tstats);
+	dev->tstats = NULL;
+
 	hfi1_netdev_remove_data(priv->dd, qpn_from_mac(priv->netdev->dev_addr));
 
 	priv->netdev_ops->ndo_uninit(dev);
@@ -166,6 +175,7 @@ static void hfi1_ipoib_netdev_dtor(struct net_device *dev)
 	hfi1_ipoib_rxq_deinit(priv->netdev);
 
 	free_percpu(dev->tstats);
+	dev->tstats = NULL;
 }
 
 static void hfi1_ipoib_set_id(struct net_device *dev, int id)
-- 
1.8.3.1

