Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A561F8AD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKGQPA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiKGQO7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:14:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F8263A
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:14:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8CKDHs0AuXA7LkI0KFq8pKjjvkz9/a2H1Jh0slOK+NvC+2J9jII+4Agwp1pnI+E9yX5I9RZDiWHE/bZFDVVExJGEHRqqlyVYkzdeop9o+WQqbjZt8rAdTylYHy4PgMrdVchosFGM4s9GnsrqF9/tFPkpHXLz508KvVHNROyez8ppyC9pwATC4sUxoCIB2V60fdq0MIOa67oQQoVfrFfYaitICW6ytqLTrtI2sDX4bZVlpXrDRZd9651gFN7OWF+ypzvAph4zLDg/5kgSBOmcqqw5uRm5lBesi4Wr32Y7+IX1fcxXIKRdLBg850lqWcn8V0UXgp6FrN9THGxfoxTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV6o+xm5sjs9NFMPubs4WaARbvI0lko2FezGtZyJ19s=;
 b=mC0Tfuxx2/Dxo0QI875hLpYijEmIK97qldNvsagT58xjfBPEWWzzYrML3o//Y1jo4gYT5D+p0swu01Qngx/NABAn/Mp0UzUh+UHHG1x+rDMas2UoZ4MszHnH4ym6KPhF6QRp7VDD8QloJPCDrDLovRBUWVo0jDzfE8y5Cjf0xlPPwyqZhxTf2kc6acJzlK4/Jo278J65YolrKmG+1O0KWnOXtcWYH3aXDL6kXLh+xCAa1aFN6X4Cocns0eiaELuiptA4iS/6GZn3a/SLOWUO3MGgqMcmTB+gyiOmao8Ory+kfphQpHjdEQSRLsO+zhEpG/447Ael/DFRtC92eCsJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV6o+xm5sjs9NFMPubs4WaARbvI0lko2FezGtZyJ19s=;
 b=HCZXVfwTs8Q9eosgcwG+usCS5wb8Wuo9q7E+0Eomzez4XhMpdmVZh9iFXE+qp9BbrSH+dlD0vK/z7QDkD4eo/sfBCXP4cr+CUAsVE3ajDBm6VToyaBIYLcfs+IbU32qtYZjgSOzcaaaVZvVx4f8CivGW+CHSH9OCokGyIJ/wpMSXfbEjSLW6IfihmY6PEZDZS/QtWnG8rW43l02b/uZ/A7vRJjrotASKSYxKKyVnawPZLTrEMqWTiW0WUFgyfjiQTwoSwA7Tvh8k2OXeBTonopgGif/j53Sd+LhuZv+VsIULltCcFbZML/RRJJgWPq3s/WLWyrT48xsGccvJpjOvyQ==
Received: from DM6PR06CA0036.namprd06.prod.outlook.com (2603:10b6:5:120::49)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 16:14:54 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::b) by DM6PR06CA0036.outlook.office365.com
 (2603:10b6:5:120::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 16:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:14:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:14:53 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:14:53 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:14:51 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v1 rdma-next 0/8] RDMA/mlx5: Switch MR cache to use RB-tree
Date:   Mon, 7 Nov 2022 18:14:41 +0200
Message-ID: <20221107161449.5611-1-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b174dd-de44-49ea-9d24-08dac0db3507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zq+LZiPzvLpKcIZ7Eiqy3E+OYfxsvre9Qk507M0JRxtPdvKW+k4jgXV+YtJIEtgOxY8JgTB1K5OXFIr71bae743IfxxKC13GCiHMlC5lnTOebmRVCo2Z1JKyrEQSkC1GkToU02dPOPuzCvDzLZQnvdYcfYuuECqviZQWoTrqZGr8oSyTpwQWPNDs6b9P4AgHY65TCcDXpiurKQ8nRAJRWvUBCmRkL4vgFBLO7OFe6cms+mVex0LEEkXPianXNcntr/mVLW/xQnbnO4pgsmROujxZDmO2ijVVkRQkt9qp00EqsiC7zrIuDwDjkL/zdlOD/DDcYcfq3WKBYYdEf9GSxZZQVisrOtVzq6Cnm2T5KhlakYHBqsKOAfXuy42Nb2LXH9lLjkyYLCfdbkJWYi0CqrRGl9TR+6DH6BTUbDow46UbMy3eCRXRhczJtrpGCTf+tJxHFVPvFB/UnpMqp2MEqBUAV787kD8azCs1U5IL5dKP9P7OyPY0hLU+NZHZyEK7HkXqFGXy1RrzBdmpCJeJ4knGlLLfu3CdQP7mgj9qB4RGlaFiWUaWstgnl84Rl1EOIzGTgJelSj+/EignLFuR/M5/2YUGZ9j4QWi0M1FQVe5/fUrxUBr+ov/ke16eq09gT3tyrcCahwdO+uajWt7EHLvgDXcGRlWgigbB9Dler6pweyCpPbuoRra/0ENW4teRhqvQP8f4CYu5an+hizn5TLJny7e1HoVJ3SQF0dwHd+5KaFAOf5CA3Y0qtyTAnn8Nzt+5wJy9/RFF+13QOVZ5WGiBd8wQi7EAw6HVhnM0z7Y=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(54906003)(7636003)(40480700001)(356005)(26005)(110136005)(82310400005)(70206006)(41300700001)(8676002)(70586007)(4326008)(316002)(1076003)(5660300002)(186003)(7696005)(478600001)(8936002)(2616005)(40460700003)(6666004)(36860700001)(82740400003)(336012)(107886003)(86362001)(426003)(36756003)(47076005)(2906002)(83380400001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:14:54.4690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b174dd-de44-49ea-9d24-08dac0db3507
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series moves the MR cache to use RB tree to store the entries of the
cache. By doing so, enabling more flexibility when managing the cache
entries.

The MR cache will now cache mkeys returned by the user even if they are
not from one of the predefined pools, by that allowing restarting
applications to reuse the their released mkey and improve restart times.

v0->v1:
- Fix rb tree search from memcmp to dedicated cmp function
- Rewording of some commit messages

Aharon Landau (8):
  RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
  RDMA/mlx5: Generalize mlx5_cache_cache_mr() to fit all cacheable mkeys
  RDMA/mlx5: Remove explicit ODP cache entry
  RDMA/mlx5: Allow rereg all the mkeys that can load pas with UMR
  RDMA/mlx5: Introduce mlx5r_cache_rb_key
  RDMA/mlx5: Change the cache structure to an RB-tree
  RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
  RDMA/mlx5: Add work to remove temporary entries from the cache

 drivers/infiniband/hw/mlx5/mlx5_ib.h |  42 +-
 drivers/infiniband/hw/mlx5/mr.c      | 574 ++++++++++++++++++++-------
 drivers/infiniband/hw/mlx5/odp.c     |  34 +-
 include/linux/mlx5/driver.h          |   1 -
 4 files changed, 465 insertions(+), 186 deletions(-)

-- 
2.17.2

