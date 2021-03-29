Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6934D1F1
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhC2Nzm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:42 -0400
Received: from mail-mw2nam12on2105.outbound.protection.outlook.com ([40.107.244.105]:45024
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231479AbhC2NzK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMo4jKHHvmoxT18vrxv8OdOD1mV9xM9xDVMQ27GprEXQ0xCGN799t9p3tCPCE3APXHtNnnlDeJ6QA0O6IOgN1LwFrRltR5yvsRpZJy6whUrtMFFvDP0qJWXmABI70IKRgeYtLvUQzLk9xaMhnuedh10sgtZCnz6LVOGGWpACxgMxhnX1qqYPZ6KAxQXml51gciScVTZTSRP2za6vWF6PdolCLhh2l/vmYIACr3u0lpuotl7Gd/4PSILnuaschDakyyNnyvvwAaAlHiPdeH2fbJXrHU2ktLZvUYbvSNIFU/vDBDVTS/85ZB39abXuUHjPZWHSGAVfXsa/YeY66JaFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egXcVTTYXIduAKWiZKQfB+kutuMHlXi7hhgIpiJN+Gs=;
 b=lZhCXC/9pR8Lu+y2iztDZN2vsvqFbVdnMu6fbuNRlYZ+etg4usI1gSlfkfk8YvMJK6f8Nz16uWwA9i+sldd+qgVkx+c0NRHt2QfUm89wXFbveQ6q89d/Kw8R5BuW6pwL5gpYP/ottdouwFjgyMTudtbeG5qhzrO7OSuMIOGxNTpaNaP7RMKsDLygCWBjkG3RdaNwuJAmOC5l5iXcRMjpSAE/vbRC1DflelV69KnSGAoPqz5Trwql09zhGVrEos8OzRjihRyDbB+7USqTzfi1fIDFjQ69oS+FK7bJMBugLu2rAwDm8DzA/SEdp48tGBYFXG+IlGBCvDlcKYMlqrViXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egXcVTTYXIduAKWiZKQfB+kutuMHlXi7hhgIpiJN+Gs=;
 b=KcFcLY7wFFdGTDXNIMtYcuDq7EvtVhzVLXG60CGz7DCIuseM5+ELldJbX8HQI7o+dykJ36vjGEpRKypQwzI2+AW9ix3kfDlnBeR4ERvsr+G+ynrEbJJh1GZBvZkNhYqfTrgZsgzu2lR2ESVbn2M5joDdr2fkM7VWIE2cW8gONISvYAWc15jtyypKkdWHKeNTMyr9Udw4oQaelg97qUY8ePgHFX5z7C1SjdItHprlSLUMBf4zF7FwNaAqNmJBfI+BUikmL3rT70Qf4VjzMAfFI3JAj8UtCf4vPISIXo4XzMJn72BaMO4kAVA10NXQJblqKgOGjPnu3StvSzwbo6BefA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6729.prod.exchangelabs.com (2603:10b6:510:97::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32; Mon, 29 Mar 2021 13:55:08 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:08 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 08/10] IB/hfi1: Use kzalloc() for mmu_rb_handler allocation
Date:   Mon, 29 Mar 2021 09:54:14 -0400
Message-Id: <1617026056-50483-9-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1782ed02-30a7-4386-2b4f-08d8f2ba431c
X-MS-TrafficTypeDiagnostic: PH0PR01MB6729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6729ED74B2D14099C2FE41D0F47E9@PH0PR01MB6729.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpaNyi+Vn44Lq8wPo4aezVgtP4LrR9tPtzkElWaeq9ldNXkf5OpSJVolK/cQqIXZErajuuN8/XS/AUVbHXdnVOoFcB1OEyTsNeM1dFyyOrvgVIYpcTgU36dVC7+rI5Jd0fa2fejPoIqTdlP8WBTE8FZmALH/4uYOulTDNS+8qDJ9tDzezKMHu5zdG8u4RrWnSYLUQN+fc2Wvf4Cta7r/0eWEtJB8y4gcTygplrzbUg40EXzzYY7rS8mtvOKVyW7wUAEEb9K0sUUrErg3pyCXFlGM1OetUW1ni5Oh30G3SHcpF5K/OWsAIW1q820qjk++9hnFstUBWnJ6nr8esgNxmDCXfj0GNJEEN8nKJWbBrm+drEGTF1WTRHd6i8n4kGTDKNJEy2/yq+9HRECWz+WgnAqwQsyY/ty2/DihJcceQtHGMze/cJnncKv08dvgOXbzdxQyGN1w+n1/lD216lvvv1t2VdQvjM2Kk7Gad2kwstK1Oq28Dx6+OI4qpPPzITCYEDtkkxG5QfxOMcWRNuJ+ULofvun45PpnQ/1bQSjuAFylAOCpV0wni7WzUMvR0GB5jmcvpZQYp99VinzaotpD0fG1otr6ohz6cUv6hbQrznQLPfCP1X+tpoo5deWwSmBXA+7nZg2DHpx7K2RwjE0gFbmvaQ6LYCNGqjVmoN/hgN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39830400003)(9686003)(52116002)(8936002)(8676002)(6486002)(38100700001)(66946007)(316002)(7696005)(16526019)(186003)(2616005)(956004)(66556008)(4326008)(26005)(83380400001)(2906002)(478600001)(54906003)(36756003)(6666004)(66476007)(5660300002)(107886003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eIyYJt+NEyEk4TMzUjbgeHaH5Bv+oJMU3lEVYnTNxPcxcX1yBQL7jxMsVmHV?=
 =?us-ascii?Q?2z/8ekRPA1uXRGXio35KYQ2PsGR10IpBYjm3yDOg55nhYaSNh4txmiW8+qco?=
 =?us-ascii?Q?QPcl0yrhHCTS25QSQeoywZGt4G403hC3yVxnOMB1LiZeYk+gID8PpRhgjOzi?=
 =?us-ascii?Q?8dvPFk2oyun7+mh5U10zaVWk6Tlgu9n5UG+OaeyNqgyxML6Jo8JxrGJlPlRc?=
 =?us-ascii?Q?QnO3Cc2T4VGoIc14+DFVW/HIVEiehZZqI4L0kQXxQSpVBcFhpcvBR9C4HT0T?=
 =?us-ascii?Q?4thkBdV5FVl/UZGd5x5TOHD2aTllY52QS5NbfRumg33qG1rETfx5Kr5QMPOb?=
 =?us-ascii?Q?p364EvtPs9BF0hzZ/30z8NG1JGq4DCW4KGSh8ws1+om0IlYsl2WHroxH9739?=
 =?us-ascii?Q?RdiUS51RlnUjButvk6d6VgweWjgDTS8qpHdQggHGd4SmE6oRoyOwAdL4GDX7?=
 =?us-ascii?Q?rMnSd1hUfnQCboWTEdsZOnxOVqk05XFB21zb/4uOu+oVgeP6xadOKh3fNvVm?=
 =?us-ascii?Q?u4I3fGGF/M8IszbpruOpdip5Gn3sz5v8TdEpH86K0Hc2si3Sm/MveOxyfAA+?=
 =?us-ascii?Q?8zgDVUwTvWo+QCyOXPGO/TD6GSY5YYOEoL42hBvlTOQKQWPdK273ghJXOjJ1?=
 =?us-ascii?Q?BoFxMZGVsnA+bypCgDMbmy0JON6MLq0eJa9FAR2/fEtxOiv8dzF5OMFU+iiN?=
 =?us-ascii?Q?tjoo7Pzsoeum3P5c8br8SbG0Y7Os28g2dLX60Jf/ZGf85up1CZVJwx1gKwBo?=
 =?us-ascii?Q?E8uzFM9noGG/xJ1c6gIDLGVNhVZoDGdw6caH7hGeaZFea0cCNvnfW0VrVNEs?=
 =?us-ascii?Q?UdYVunG2e43sFHTY+qFAuWaGs1mfIlwK3yvGTL4e9YDhjnEckSdau0KL0gQF?=
 =?us-ascii?Q?jz/8+jbudBgJYX69365dexZ+oebNbKMLNavE+/QhI9GO0xS9Pxd8zPHhGTTy?=
 =?us-ascii?Q?K+6ow3fMti6ku6ddC0DXzYZ66Fr8MQOg/ctf2PhoPXiGYgE/nPBXvc5UEJ7U?=
 =?us-ascii?Q?z6tzIePrMtXfsiyicUXuJYWlV4gNok+s/cGpju6MEmm3QKrrI7XlzU0gOJ1h?=
 =?us-ascii?Q?Utl+jFy7d2L/1kdVu8coE3hEVgjOFFUGfptQa7I2izVyt+cvzZsc8snuoivN?=
 =?us-ascii?Q?fJFGyiPfqXKbI+vzDyqFXCUjMhoJfJRYC+YTwkO+8GQGke676ehKu4WwFl1p?=
 =?us-ascii?Q?PzXPKbe2iShZ7sccz1QakenpXJuRih2qMessvP3OF2Bki8NbyuOXOjYecBHP?=
 =?us-ascii?Q?8a4jMV9LuJVonTuT8Vi6nUFyMVQ3I6X4S0gdQqZzBv64MCzyl3A0BiW25igE?=
 =?us-ascii?Q?98mNdMycy7ryMBiPKaiiWTUn?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1782ed02-30a7-4386-2b4f-08d8f2ba431c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:07.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqsWmMLWQICP6tGh5YaWyotGMF6q113P7GKvQXjATRXcQ62buDOQc/4mjLeZnkZfB4NPOPwtE5ffEQzz+R4rcD9ivOvfeMK4xqt7Z1p9vTOLAQbaGDETDs9/LYRIC+vN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6729
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The code currently assumes that the mmu_notifier struct
embedded in mmu_rb_handler only contains two fields.

There are now extra fields:

struct mmu_notifier {
        struct hlist_node hlist;
        const struct mmu_notifier_ops *ops;
        struct mm_struct *mm;
        struct rcu_head rcu;
        unsigned int users;
};

Given that there in no init for the mmu_notifier, a kzalloc() should
be used to insure that any newly added fields are given a predictable
initial value of zero.

Fixes: 06e0ffa69312 ("IB/hfi1: Re-factor MMU notification code")
Reviewed-by: Adam Goldman <adam.goldman@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/mmu_rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 375a881..dccb4c1 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -89,7 +89,7 @@ int hfi1_mmu_rb_register(void *ops_arg,
 	struct mmu_rb_handler *h;
 	int ret;
 
-	h = kmalloc(sizeof(*h), GFP_KERNEL);
+	h = kzalloc(sizeof(*h), GFP_KERNEL);
 	if (!h)
 		return -ENOMEM;
 
-- 
1.8.3.1

