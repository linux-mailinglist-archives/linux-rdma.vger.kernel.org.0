Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C617B1659
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 10:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI1Ir0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 04:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjI1IrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 04:47:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5934A1A1;
        Thu, 28 Sep 2023 01:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP3dl+vEZpL0C2mG8uRTNphJiXb4OQd5dgTS5mpbkGpPE7RaWVqkQ5x8vEOkHs6wU4B15/oez0j+eqMWbXknzNkGpEp//xt8XyySTLPAeUqZvuecLxFCxp/Yhn+cknpgpJEJCjkk40ejmjSPL44DwmS0dV8iANBW1yxBEqBCBDYL0lcXlIB6mcQrpUjZ4fuEYmKg4E4ff6kaGB7FyzMZmBs0KlsrKCgXCHAbaa6Sbw94zzefSuO9SMTrNd7SrRy4X4cuWRYDIM21JYyGek2ExHcU5tfvvr3cr/sQ2Zo+TOu0wegKhZzlibPGUPG/eM2mv8K5gVtG9JaXDzAyWPy62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTKHGEQWyH0vwp//V+E2asoik8YKanaGHPBAdcOqHlo=;
 b=fKKzYgG1R5/kRLrGP8NuvA0xOxoR8k4e3j9um4iIIk6i14eJuHTS3R3sw5RqRedAoUA2IcPBCoM/3cWRPV2g/uEVt6oQnUjANLKtscEB3m4erWBGiX+qDSpHeqH3SFI5dONsXYHmbmhnm1j5lOqJI1KCa9s3yOQwlYfXQHIeerQ2Sw4waZ4h99lTOO3jtN4wOlghlEziR9lv3EFzeCE8GFyvHeLir9ol/SvImRchdUgcvlRzEQuT5/P6HyXrBs8j6nbX1Pze1vvIc7beJnLXzM/fsBY8dPr+XhSKCEro4rB1p2W6Gecro2r6WjQw9HeBetf3cTn6t5khObvKQ7G7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTKHGEQWyH0vwp//V+E2asoik8YKanaGHPBAdcOqHlo=;
 b=P2F320hEm4fLOm5aGNPJHGLljwn7TKzlYmDaM50gCwbtR+IMRhLh7AYFgkKJdsCIt0EBkgej3ipj+wmoYJaxMGYTvdNdgB8ZSkANuJeGCdOvrdRUKTrWb6gqUpmP9HOqRwhHUoO5tcm51kF37dLEHr6ruRlBFgE4wINu/akJkpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB8475.eurprd04.prod.outlook.com (2603:10a6:102:1de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:47:16 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:47:16 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, sd@queasysnail.net,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v6 04/10] net: macsec: introduce mdo_insert_tx_tag
Date:   Thu, 28 Sep 2023 11:44:24 +0300
Message-Id: <20230928084430.1882670-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAXPR04MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: abb2a6bb-f20f-48c8-4673-08dbbfff7999
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yE0gxPMMEvuNYSobDLM0nxukIh8o6Kr5Nm6SHvdypeuDt8zGk6bdnU2S3wcEIpfoQBEE0y4CwijFTlioJXaRw5eda7sQF8unons/p0OimrdJ11NLdpRcYH6N3g4HfwrhzuXDKJReNFQvwSivORwjuBmNRu2+x35E7RcQmUAlaOU74cxDYQ0/kcUqp7mOJU07Ctat9Y/XdD55EvMKBquaRQp1j2ONk04bi6OeXp0hVVpQbKoNMIQzUtGIi3GxpkBpRv4kdQa3pft8RgF+faqiTgwvKLsjAyT5cxmAcgUrhHcPdeFG7YbSrm8VMQsUGSgUC79kOPRi/SeyNf+G1mg8/ZTkjhAclirOezOaDSo3WGBzrtXP7ZTW4xVl9sFHm/2QfheP/37rkXzt7TipOOpkKxShrpsgGMi3meuIYueS2deIDaW0Jxo07ry4u/xhmN8cIQe2uhE8VpNU1O8G/lKxnwBY7KX2F+93UumlB21kKqS8LQh2ChBF/L4RVtC2bXCXHjJNyvQ0CZZPTXhg9QoPKjH5kRz9a26hG3HpxLeRDx9myjwU+5/yJdQw7bjnTh0jZ02UXfTFpqp6tURzWbNWhDVDja3//zVkCaaiu/tFeuCFCh2/AERSzCj1m0gLUhQyMdCaz/qhDRGbLFNRNqfHDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6636002)(52116002)(6666004)(6512007)(26005)(41300700001)(921005)(38350700002)(478600001)(38100700002)(316002)(2616005)(1076003)(83380400001)(5660300002)(66476007)(6486002)(6506007)(66556008)(8936002)(8676002)(4326008)(66946007)(2906002)(7416002)(66899024)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbANHzI0J7YyMZCzVWlXQPHZ4sRUxkbcZY7Kb5IMiLseOTlO+kO0QkwaLTG3?=
 =?us-ascii?Q?4RuBte46I/GVtM8haWE8HFr9tVNYk7zFc4hItLFvkEHj7ghEuV2L9D76KF67?=
 =?us-ascii?Q?DJiaMiIkoRym7ADXkBm1W7KgQs5t5qfhKoTKTBgr1RG4XiLGLTKQNh9BL3n7?=
 =?us-ascii?Q?eaTf0iAwpkwhsQ2Ugbdn9IG85IIn8yN+Sw+0IGTT94cm8lUGg308Pc2okR4v?=
 =?us-ascii?Q?L+tW2aRl5ES7Lyu5vlJqMnlVF9/qMjs8v6L+loxowhbj7Sjp5AZiVLlXXSmt?=
 =?us-ascii?Q?V9d329dh3HzQw6Vf5XOTEXqjn3qZ3COJGQ0y3gErXkL+BrJfc/e00+M7xcrT?=
 =?us-ascii?Q?Bn82F4xlufuQWPreUh7uCsBMPKbsBTCoiwVnLeTPlBN8WAkcTlmZFe6fBhHE?=
 =?us-ascii?Q?1omqC2XKFyydQCR4hGe6fUkkKiQ2304F64UFQxWvOTy54CUwCafH62ujsM75?=
 =?us-ascii?Q?OJvSyx6ntIZ8hSyh5V5ML6Y3sMN6unQ4c8l3qTA01fQ6kq+BFor1Trz8jnRz?=
 =?us-ascii?Q?tH4xb+ta+YSD4ZVYs8+4vfWnSyRJh3IROeNAfk7xYF5fduxP2x5+OFkTMTUA?=
 =?us-ascii?Q?PccrFZPMFmDIDjN8Vmq4OoDBEjhYLdvFfiFYKGwM5HmM0+SN/eZQbSHHL4dZ?=
 =?us-ascii?Q?pVatvkwNI77KxxEyEyw17NNW6Xx7SwxMo1dhH+k+rCIFSMullqYxCFsEZmtC?=
 =?us-ascii?Q?elYEyOrFcePKgaImypTsdKRcga1l4a56SAqiIjPulOp13N+CBG674L3N7rI2?=
 =?us-ascii?Q?1bgSqErxk7uHHtBNX6C7yIn06Ffzew7PphHaUceuK0F+V1eLQ8fl7JC33UkS?=
 =?us-ascii?Q?KPez/nbFyTGY6MGjk0w2l3iRxLAC7VKcHRWNdsLCh3yV5lLzK2nq2QvqkE3Q?=
 =?us-ascii?Q?ycjZ5K9N4AU+KUPCQQ/QLxoTtD5+nidScoliCDUssCdyRECqUVzDTtO0SsFP?=
 =?us-ascii?Q?upS84Hr1SL0RDIbrcjyhLXsnwty6DJSDI/PE6qBIADqWojwlHaODUaYpt3z+?=
 =?us-ascii?Q?ERkBgiUwQoM8dSISZp6TGTsUVg+3dmWn5hxDK44AfKMxWQI489vS4r2+0kwe?=
 =?us-ascii?Q?+i8b6TIGvUaU7xyFxsdp6a7HaskTWwK4y/dZmBqvWITHG89BLqA5UO7jazA6?=
 =?us-ascii?Q?7uYIZKyZ9jiZXT8YkLzdvv6KL9uzOzKvIuJRLTucHlRGamDJ9VL5WvQPEjMz?=
 =?us-ascii?Q?k0X8NDMV7tihowTSlhdci/6+STmdgMCrgxlTNv7bJN0fLYcHHrPinmLgGEs8?=
 =?us-ascii?Q?pIpWigfbKuQWbywxZY9n0BWGkQ1wj/BUvVij8gvPDXiTqNUddLoJQMe/XmhR?=
 =?us-ascii?Q?Md6V2BB160LYQFtDii3BAoC9Uz6rs6/usGl9iTqUgRKWSGqMD89dMwp5+mwP?=
 =?us-ascii?Q?HyMqPdkz6Ai7PKzcb//9nXUZuGKwebWy4R8eBwTvU4dy16KT/NHKSFKQo8RK?=
 =?us-ascii?Q?Ug83I87CHwurZwf18F4GiPgMDJ75ODxEiBvZjGoEkQ1FYNK8k+V9bL097b0X?=
 =?us-ascii?Q?wtmoMHtroWwXQR5sYfFjMvLC67+aS0cblEO0/L+ZeGjrg5Wzl+0Dyy+onBoM?=
 =?us-ascii?Q?xxyBKAxfyP6/bP/amZFKeyRO4VoFsSlK6B1pOYElBN6jZ9p2OmOGZBnhQxNp?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb2a6bb-f20f-48c8-4673-08dbbfff7999
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:46:58.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B9wF8zFqhd99A2exr+JRKm7qjy+P9amjY0309XJz/BpvyiF55djtv5rjB+E4fYhx+k2EbmJxjjJhNdiW2maW2RKnjmAhjZYugKAc+967Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Offloading MACsec in PHYs requires inserting the SecTAG and the ICV in
the ethernet frame. This operation will increase the frame size with up
to 32 bytes. If the frames are sent at line rate, the PHY will not have
enough room to insert the SecTAG and the ICV.

Some PHYs use a hardware buffer to store a number of ethernet frames and,
if it fills up, a pause frame is sent to the MAC to control the flow.
This HW implementation does not need any modification in the stack.

Other PHYs might offer to use a specific ethertype with some padding
bytes present in the ethernet frame. This ethertype and its associated
bytes will be replaced by the SecTAG and ICV.

mdo_insert_tx_tag allows the PHY drivers to add any specific tag in the
skb.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- improved insert_tx_tag flag description
- macsec_adjust_room uses the difference between MACsec room and 
device room to adjust the macsec netdev room.
- macsec_update_offload return error instead of goto
- macsec_can_insert_tx_tag renamed to macsec_needs_tx_tag
- insert_tx_tag flag is checked in macsec_start_xmit
- "TX offload tag" replaced with "TX tag"

Changes in v2:
- added new fields documentation
- removed unnecesary checks in insert_tx_tag
- adjusted mdo_insert_tx_tag parameters. macsec_context replaced with 
phy_device and sk_buff
- statistiscs incremented with DEV_STATS_INC
- improved patch description

 drivers/net/macsec.c | 92 +++++++++++++++++++++++++++++++++++++++++++-
 include/net/macsec.h | 10 +++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c5cd4551c67c..f0ff33025500 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -93,6 +93,8 @@ struct pcpu_secy_stats {
  * @secys: linked list of SecY's on the underlying device
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @offload: status of offloading on the MACsec device
+ * @insert_tx_tag: when offloading, device requires to insert an
+ *	additional tag
  */
 struct macsec_dev {
 	struct macsec_secy secy;
@@ -102,6 +104,7 @@ struct macsec_dev {
 	struct list_head secys;
 	struct gro_cells gro_cells;
 	enum macsec_offload offload;
+	bool insert_tx_tag;
 };
 
 /**
@@ -2583,6 +2586,29 @@ static bool macsec_is_configured(struct macsec_dev *macsec)
 	return false;
 }
 
+static bool macsec_needs_tx_tag(struct macsec_dev *macsec,
+				const struct macsec_ops *ops)
+{
+	return macsec->offload == MACSEC_OFFLOAD_PHY &&
+		ops->mdo_insert_tx_tag;
+}
+
+static void macsec_adjust_room(struct net_device *dev,
+			       const struct macsec_ops *ops)
+{
+	int diff_headroom = MACSEC_NEEDED_HEADROOM - ops->needed_headroom;
+	int diff_tailroom = MACSEC_NEEDED_TAILROOM - ops->needed_tailroom;
+	struct macsec_dev *macsec = macsec_priv(dev);
+
+	if (macsec_is_offloaded(macsec)) {
+		dev->needed_headroom -= diff_headroom;
+		dev->needed_tailroom -= diff_tailroom;
+	} else {
+		dev->needed_headroom += diff_headroom;
+		dev->needed_tailroom += diff_tailroom;
+	}
+}
+
 static int macsec_update_offload(struct net_device *dev, enum macsec_offload offload)
 {
 	enum macsec_offload prev_offload;
@@ -2620,8 +2646,13 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	ctx.secy = &macsec->secy;
 	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
 					    : macsec_offload(ops->mdo_add_secy, &ctx);
-	if (ret)
+	if (ret) {
 		macsec->offload = prev_offload;
+		return ret;
+	}
+
+	macsec_adjust_room(dev, ops);
+	macsec->insert_tx_tag = macsec_needs_tx_tag(macsec, ops);
 
 	return ret;
 }
@@ -3379,6 +3410,52 @@ static struct genl_family macsec_fam __ro_after_init = {
 	.resv_start_op	= MACSEC_CMD_UPD_OFFLOAD + 1,
 };
 
+static struct sk_buff *macsec_insert_tx_tag(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	const struct macsec_ops *ops;
+	struct phy_device *phydev;
+	struct macsec_context ctx;
+	int err;
+
+	ops = macsec_get_ops(macsec, &ctx);
+	phydev = macsec->real_dev->phydev;
+
+	if (unlikely(skb_headroom(skb) < ops->needed_headroom ||
+		     skb_tailroom(skb) < ops->needed_tailroom)) {
+		struct sk_buff *nskb = skb_copy_expand(skb,
+						       ops->needed_headroom,
+						       ops->needed_tailroom,
+						       GFP_ATOMIC);
+		if (likely(nskb)) {
+			consume_skb(skb);
+			skb = nskb;
+		} else {
+			err = -ENOMEM;
+			goto cleanup;
+		}
+	} else {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	err = ops->mdo_insert_tx_tag(phydev, skb);
+	if (unlikely(err))
+		goto cleanup;
+
+	if (unlikely(skb->len - ETH_HLEN > macsec_priv(dev)->real_dev->mtu)) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	return skb;
+cleanup:
+	kfree_skb(skb);
+	return ERR_PTR(err);
+}
+
 static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
@@ -3393,6 +3470,15 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 		skb_dst_drop(skb);
 		dst_hold(&md_dst->dst);
 		skb_dst_set(skb, &md_dst->dst);
+
+		if (macsec->insert_tx_tag) {
+			skb = macsec_insert_tx_tag(skb, dev);
+			if (IS_ERR(skb)) {
+				DEV_STATS_INC(dev, tx_dropped);
+				return NETDEV_TX_OK;
+			}
+		}
+
 		skb->dev = macsec->real_dev;
 		return dev_queue_xmit(skb);
 	}
@@ -4126,6 +4212,10 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 			err = macsec_offload(ops->mdo_add_secy, &ctx);
 			if (err)
 				goto del_dev;
+
+			macsec_adjust_room(dev, ops);
+			macsec->insert_tx_tag =
+				macsec_needs_tx_tag(macsec, ops);
 		}
 	}
 
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 0821fa5088c0..dbd22180cc5c 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -316,6 +316,11 @@ struct macsec_context {
  * @mdo_get_tx_sa_stats: called when TX SA stats are read
  * @mdo_get_rx_sc_stats: called when RX SC stats are read
  * @mdo_get_rx_sa_stats: called when RX SA stats are read
+ * @mdo_insert_tx_tag: called to insert the TX tag
+ * @needed_headroom: number of bytes reserved at the beginning of the sk_buff
+ *	for the TX tag
+ * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
+ *	TX tag
  */
 struct macsec_ops {
 	/* Device wide */
@@ -342,6 +347,11 @@ struct macsec_ops {
 	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
+	/* Offload tag */
+	int (*mdo_insert_tx_tag)(struct phy_device *phydev,
+				 struct sk_buff *skb);
+	unsigned int needed_headroom;
+	unsigned int needed_tailroom;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
-- 
2.34.1

