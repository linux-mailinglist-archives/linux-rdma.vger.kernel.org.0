Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF44AE232
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385664AbiBHTZW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 14:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349608AbiBHTZW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 14:25:22 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2128.outbound.protection.outlook.com [40.107.96.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396EEC0613CB
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 11:25:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUMUH11XyIcTz7DZpQcmnmGY2mO0c9a0ZAEHT4FTLgB3vW0tcXK2TvWsMN/PnC2OsxYqL6kPqjleeY3TEhmgikEf3p9RWubU5QkNkAhz97jcdfhuKEcAGA+vuYYycxOPfpagrMinfAkbuouuyghA/SqmLT1lJt4KbIGv+30U5RPPHZWW6f4i9HhSjXKczIFqc8xQikNcAtttJOL5f3ccpnBhfn/jVtp5PbbL3cN4vFYUuGE05exm5VG4GnKlG2qWbn8DjGUoK0BrAPOA69DGWARoGGyn7nWOkVxzTx7tvGZNKpihKM+7ObNFruHbcEBnxMM/hwUrEY7MLjws2R7M4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTFPrBM5okCaUmoKDChFZsF1OqAfddZCimzoT4eRJPg=;
 b=A5vyMwzaoyvT6N5t3r0fAPsFUOiHeaSUBS515qNAajfXlxp5+mSg9kL6QufJgdP1Pe0WzsCfowrJSqdIXkNR7UbX5yiGqSZuVf4l5dmSa4Ee/I5qorSJJaX7kIsDasK1PXfI17rph4rlMGWJuGHTE76KAAtiz52sE+1EgtZQNmfzR+zOHtCNByY1v3lMkHPELQLW8L7hlVsEvdIWcMOZUOrXWb+xLTrSk7aVxHzWmVvt4ynIGo0htjo4iE7Jrmpp59GJO7G11IqczBjDsIMM0mD/R0muknRr5a0ZoWvWrSJzWO92At2/pWR0ifaNdfWo92pgC8FoPfQzQLnejKIqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTFPrBM5okCaUmoKDChFZsF1OqAfddZCimzoT4eRJPg=;
 b=evUp/++AQw6qPDEHwIhoKp2bhGfugaWjSvjubGvSlpVU4e/nEF4ytOSPgmpjZCQo3OOc2ZVf8zUAKdFiCQ3w7YJTMdZ6z0hUTewNK59RWjyoh88RhuqxI8AhN3dVx8ppnJuflxAw/9+xQs3YeIUDtZxd4vHby2twbffgtlNdAdzn3aRyrXAW5xEH4MbS0QuuxuewBNgqEnsXRceRVUodBVn+ZgWNkFsOgD84fzrXUmhQABXJAftpZXr+HCbP4NunyMntPGut9/eKbD/vw1TSQWC+XI5nxvl4R8GHuOGfwHAaVeNdVqJdgqR4AcsMtj9UZEU/3jc6DYac8FgScxmuAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 DM6PR01MB5931.prod.exchangelabs.com (2603:10b6:5:200::29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.16; Tue, 8 Feb 2022 19:25:19 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 19:25:19 +0000
From:   mike.marciniszyn@cornelisnetworks.com
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: [PATCH for-rc] IB/hfi1: Allow larger MTU without AIP
Date:   Tue,  8 Feb 2022 14:25:09 -0500
Message-Id: <1644348309-174874-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0440.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::25) To CH0PR01MB7153.prod.exchangelabs.com
 (2603:10b6:610:ea::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59d4610e-1efb-4c40-1185-08d9eb38be57
X-MS-TrafficTypeDiagnostic: DM6PR01MB5931:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB59319E3A00A68678C2A2787FF22D9@DM6PR01MB5931.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAsnMe05o7DR5iWWo7iMAa1uoSJsr+5661H5R/tKHRPkvhMzmlej4XJ0I5TKUhdDKZv59NWT9yIeaes1vM3VeL6QLByFkOtybIjBQWz1agZAzU715luCCztyM6nQt22GNK8n4OqvoPV/EBvoc8QtHKxiGkpX96Fs2RHdU/d7YUCbS1hcqOaCMz9Xyoi1x6aZy5bqjI4zk579xW3+c1jDAhYG/whCQ0KChqk+m3x/nRcgw16DEccpk/KM9DYEleikDw70dDRzZAEVEMb/rNCU6QU9O8Dqz4dDuFl/ZE8064qjoqEj0rq5idbO4rIhU8NlNiSvO8z/p/4IHCPiy8bFMy9XgEyJyZN84kCtVb5H9uwKlxDEQInhOdw1O/nN+MqMXwWQnY/KvWPuRrk8yCs+NQ2OqernVaZ5sKO6rMbCG5A45CPEmEi09Mx15a+CgEm+KOYECN8/HfsXOff4DZhVEJkC2LIgh58hjCN//3kmC4ix4o+U0RZVGJVThK+RBR9LU+ETr28e/ojtj73sAiONkHAVnw/zPdPPwgMeIXvyawONx8/0a/kBqkoFCdc6hC/0FsWtpxTsr81XfXKHI4x7Bc1DqmYojTu31bo+u2TQggwjSyDPdOMPgWQV1yNrgAqSgqPc90SURDsb/WpKjIIuF/iNq9ttMRWOP7OC90yVHdnpsbAbpJLhyKdJXdN/hDJAyYXuwB8ZV7k0dCavRiARUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(396003)(366004)(39840400004)(346002)(376002)(38100700002)(6916009)(83380400001)(186003)(26005)(2616005)(2906002)(107886003)(38350700002)(316002)(66556008)(66946007)(66476007)(6506007)(5660300002)(8676002)(6512007)(6666004)(9686003)(508600001)(4326008)(36756003)(86362001)(52116002)(6486002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKXNHZVvdj/0Tj2cgH0RlOAeOaZ6U4iAQ9M3v6qRLocfSs58CBEHr2B2tmWJ?=
 =?us-ascii?Q?4AfFPuS//mFGcnQkPjVRMA6zYVzEltDc0B0aXt1NQw47g99lcIN+BcYkCmPr?=
 =?us-ascii?Q?HVIPEnaTxZeSuhc6YtuZNqntiVXtsz7ddiimei7t96ZXzgK+/7Ghhy1/SAiF?=
 =?us-ascii?Q?bE3QiHOqvkOm995+Sah/1I6Z2wdTWik14FVUhhIHS4B4gNvyLogT+8LeWCCf?=
 =?us-ascii?Q?4EiaeZUl8F6tPT2yUDymwTPkmDGa+nX6aZCXx0XEX3CTE4/4C/1yAgxQsiy+?=
 =?us-ascii?Q?7fSCtKgtgewoG7790+vaTSquIPYoq3hMSWHsOmlatYoNItP8txwhQqkfpYvq?=
 =?us-ascii?Q?khe83WJ4XOPw9kgmPN4FKBoPPxruCzx45vrpNHKtSuEPh7jZF3fXwdW8xEkG?=
 =?us-ascii?Q?T9DuL5BThYNKqkwUC8NQgDOaevIu8VnONb845TSR+XjZXtWq9iRLa12gO504?=
 =?us-ascii?Q?E4Hpeo7CzwwEE7n9EYdTx/SEkrOXh1uTQypDGDi6kdeXm+DReOKSzbzej6Gi?=
 =?us-ascii?Q?21MgimzSHfiJ+eZgENlfYn18p+B6BeohuoaHbPMN8nj4FHZhY5JMwAh83GGV?=
 =?us-ascii?Q?9fDeUpJAPFTx1nXpg7o+fOYOSM2pygAuiuaoo0frMGedbx0U8Qagw+TD0INW?=
 =?us-ascii?Q?3HDVGwlOrBrK9YzCH6cBvKqMrsNgm3d40V65UqU6FHNM/y3mbKTTEJ8NT9Me?=
 =?us-ascii?Q?qlLCgxHETliEsSaDmwYJ+u27BiD33mu/mTGA3xNzce6kwbPxcnDgo32bNy7p?=
 =?us-ascii?Q?I3q1j3kqhqDjpqgfXueCNApLjK5PvNAApQdm43HOOxjvDl/4aLQqWEJskwhG?=
 =?us-ascii?Q?oNP70I3/mTBwPzSxh0bx47jgHEod/nxu//yLPbiU2FiEqFfV8s7grPom5t+a?=
 =?us-ascii?Q?y1QFip+xNL2Lg2sR3HszXn2l7ljvvkuaGIHTeYriDqOpndd24Lhtd5NXk6EZ?=
 =?us-ascii?Q?SsuC4tLCq5HedVD2fh1wsH9JncrUft3OdTH1D7FJObtHWHK2b+6QMv9BeQmo?=
 =?us-ascii?Q?shihr1D5I87/Xi85B1dGYC49io5YqJUf4xnxlz5ZCc4GNXYOSKdtrGNoSqbq?=
 =?us-ascii?Q?PbERBPPctbYbZjPhMzQleXuxPUEPkC2Hd9ba+6qlviJ4w0eU3r61G3pb3ROc?=
 =?us-ascii?Q?QOuLPJn02yo+P2bBIr0q1tPB5r5W6JG6f1GVZb19NDrjCtZd9R1fN53OvOck?=
 =?us-ascii?Q?6N2F3tzfLNxYnn13oAjNdnNuKngpwpNnqcPUxrno4mTQFUGAgprS2oWsuOLi?=
 =?us-ascii?Q?sr3S1FSj7I3JLkceYe7mWoqOjwq+S19Vnvma5E1XubI1aGfng9DD/mqGRmdX?=
 =?us-ascii?Q?DabvYdc2yxRCrTffU3zCDj3JBuhTX8Mcfa46rNyGL5UGfclt07Lseb8vmORu?=
 =?us-ascii?Q?1lCW1Wsmc2U22y3xVsaGHAsiGbKWfePGL2tyAczSUwh4WwcWTkRW+dibQN97?=
 =?us-ascii?Q?wAS7UZzTUsw9sKkC1f+nmeX6DAVm1E1SAjBQnuG882s8HZnm442n1lC2zKiv?=
 =?us-ascii?Q?yTgqOVLCgtnOHuZVnHMBzYD1iRBRKXHIgoisl3bt2nizxklAYedmIIQQIENR?=
 =?us-ascii?Q?UlFPDEuXQ9SkFg2xMtqCZltZVSfGtBqd41hhJPcN1N3UpMYtO4avKMm+WGA5?=
 =?us-ascii?Q?Vrp15jVHhMkHLZ8g1UjN052DxfMXX7rMU+8DqVS064kdfqD6Hg2Km8FRlMiW?=
 =?us-ascii?Q?2DVG1d6SG+UaI5dHD6B3ASZo6W1jXITz3InxdPE67IsuIs32sgeIDxrmSRBd?=
 =?us-ascii?Q?bPgik/ynwQ=3D=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d4610e-1efb-4c40-1185-08d9eb38be57
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 19:25:19.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8lBGjHPbx+GWZaZ7l0ME0+w6hyMhgez7r/UWgEmIdhtoYvP1YwaGkAlPpuwM8rBH4WO4XIdEa3MYvNo2QJBteg+fZzvTGtG09kv7lhg1oak2kSo2JXI8AfcYbg0CoDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The AIP code signals the phys_mtu in the following query_port()
fragment:

	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
				ib_mtu_enum_to_int(props->max_mtu);

Using the largest MTU possible should not depend on AIP.

Fix by unconditionally using the hfi1_max_mtu value.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/verbs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index dc9211f..99d0743 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1397,8 +1397,7 @@ static int query_port(struct rvt_dev_info *rdi, u32 port_num,
 				      4096 : hfi1_max_mtu), IB_MTU_4096);
 	props->active_mtu = !valid_ib_mtu(ppd->ibmtu) ? props->max_mtu :
 		mtu_to_enum(ppd->ibmtu, IB_MTU_4096);
-	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
-				ib_mtu_enum_to_int(props->max_mtu);
+	props->phys_mtu = hfi1_max_mtu;
 
 	return 0;
 }
-- 
1.8.3.1

