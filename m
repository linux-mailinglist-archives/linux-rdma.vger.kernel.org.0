Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF0699AA2
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 17:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBPQ4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 11:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPQ4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 11:56:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2135.outbound.protection.outlook.com [40.107.244.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B1135
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 08:56:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXpL9tHVU5jbVY9FsRzFHqaTP06HPfAnbB1E0UUlrliYK6ZqwKy7I1VyjE4klLons6Nuv9m+P+l069jmEfErE6jtHalaB+xi88af5Bhwmf6Uv/+5KkTsh6QQhw7hD902LkrR1U+J4ynllKSe/wRr7RXVEXv/BIajW5xdKM8JTtFlUFyLZKxlAQA37ZcswILWETDL6DHvrqTH5cFgXAj+1GV6ZWnyKsGXaF6a/M581OnOD9ziCr0NEa9S3mxnPpkY4tpwh/pOVcWwm0ziBHoo/WKRdOEaAOBAzDaFlkgs1azzA13cq3qwGkI6iO7A/DmxrATvh4FRyDkXpYjeAbL/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp13FoppRJCaVD9YgUeE/7uE8opVq9Ebm7OVJzUog90=;
 b=THtm4tjzKEQw7TmxLd2jz85J7X1BAB4/ZctbWZKnPyXDt7/hujYKYFkbODXRj7fMoa56yp3jnVxoueW5E3UaYps3BXOPwEomHMeIb03Q1DCMfNO6mYE9rc4bFHWex5WBCjAJ2ADV+x/dhDPdWdfUKSltg4jmApBmRFdatwLhI4tIp//ZXgfIG/rHz4SExZe4+5eKqTodI9SNfLxBomXDL47QA5GexcB6ztiInEOGj6Tdg+Bm+KVj7eUYs+NvsMQp1YAzXB1iVwrLVwujeyZ4O2MyAQOcV4PJ9pwO0e5J4HETHRaDzdrYBj6xDjxmL2NY5EAzUR7IiUXLp3jar/FnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp13FoppRJCaVD9YgUeE/7uE8opVq9Ebm7OVJzUog90=;
 b=hSeklk+NzOpXWfNe21dcD24ja6Qup1mPmoqHd9p1QUwD8djaPSbeDn1m8KPYUG+sjiWteav50xGLAcmu82vcVVCAypa8yxTH5KWvCdNsbBlyNjBJ5XFjIE/g87zmSQWCVeVzJQsnWRD7BpRQXUqT7Rnwxtjj1CSQz4mkHOgB6av+2YyJ1ruwWtChXDNmV6KCYJc9YHsaySidR9XoZp9aCZ40kuwLl/i0LxIYI95hEvIh1bJYBSq7JoGFVxuFXr9uwMtFeN94MLt1Pp0gl5Fjwu1uuUN+m18mQjX34r/BoMP3wnxvGo3LbQzD/Ctp3YI84XzNTdTs9xHnbK/UPlbQiw==
Received: from MW4PR04CA0221.namprd04.prod.outlook.com (2603:10b6:303:87::16)
 by BN6PR01MB2580.prod.exchangelabs.com (2603:10b6:404:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13; Thu, 16 Feb 2023 16:56:20 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::c1) by MW4PR04CA0221.outlook.office365.com
 (2603:10b6:303:87::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 16:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 16:56:19 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 31GGuIFo2223737;
        Thu, 16 Feb 2023 11:56:18 -0500
Subject: [PATCH for-next 0/3] Respin: Rework system pinning
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Thu, 16 Feb 2023 11:56:18 -0500
Message-ID: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|BN6PR01MB2580:EE_
X-MS-Office365-Filtering-Correlation-Id: 796f9ce4-118f-49f1-1436-08db103eba0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNZwWi7ji2O/LhmN9lxuogrulfYRrnnwP8ZI1yEFrj91y0snfH330RoYwdc2Tn7ToXIEJFhNYFSBCbBZWj/VQxyZsvzqjTL5CcGkCXl3US+sfEREE7k/8jZONq9m9vNKa5Ry/Ub4wKFgHK1Chmu707+4kvabT7VyoAwuKyqhJbpTuw3N2aMxTQvTiLdQFPdAMDzNbRCfIK7UOGAqP4yxrxXT25YuUH7ISbJZSofFSQ961KUSCcHyRcQy0NcfxWFoaovoLqMpP9MzX4cXCMxsfHwJLPvtF+ElnxYx56H4NooBxMop4hE9oAFiAMLB3a6dDj0IM5FL3cRyPfsewreTl0eo3xxhJOEb1c80XKHOyraOCstx2NHSSyVyr0NL9AnMYiS649sNI0Si0JcveoyLy6Y4ZmzQJjwHZht+cvBFFzLeZjLkzbfmKBNQXVqmJQAQb152SCLr/mecXba0TpGPeXCaSRbL6OrzOWgY400S+Gn5Q8gkB6gasF9gKQHGdmGfRRxBfOqxQZrnSp4BbRZJcGuyc7VpgHhNxkqGy2IFl83U58MCY8Gc3vBezVaI9ZIa4j1mIseQQN5kRybC87oZFEfxjcEc7cXahSPAkUcdpdSDBo1O+CP5mdg9KNklECbdOs56ImhdT0SgyMe2WuSgS1bBTJjlb1TqLm4GYTvxWBiZ3Q8BriP+JxUpFO/0Dqwz
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(39840400004)(376002)(451199018)(36840700001)(46966006)(83380400001)(86362001)(44832011)(8936002)(4326008)(40480700001)(55016003)(8676002)(41300700001)(356005)(103116003)(5660300002)(36860700001)(54906003)(316002)(70206006)(70586007)(81166007)(7696005)(186003)(26005)(478600001)(966005)(82310400005)(47076005)(426003)(336012)(2906002)(7126003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 16:56:19.6734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 796f9ce4-118f-49f1-1436-08db103eba0a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a respin on top of the latest rdma/for-next branch
of the series being discussed on the list here:
https://lore.kernel.org/linux-rdma/Y+EbyU4HkGyzPoFO@nvidia.com/T/#ma3d153151adf1dbe2b9800000fa9a01f95a80c1f

We have added fixes lines, and Brendan has discovered a couple code hunks that
do not need to be here in this submission. We have also removed the stats stuff
until the user side code is readily available.

---

Patrick Kelsey (3):
      IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
      IB/hfi1: Do SDMA memory-pinning through hfi1's pinning interface


 drivers/infiniband/hw/hfi1/Makefile     |   2 +
 drivers/infiniband/hw/hfi1/init.c       |   5 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c   |   7 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c     |  96 ++---
 drivers/infiniband/hw/hfi1/mmu_rb.h     |  30 +-
 drivers/infiniband/hw/hfi1/pin_system.c | 516 ++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/pinning.c    |  55 +++
 drivers/infiniband/hw/hfi1/pinning.h    |  88 ++++
 drivers/infiniband/hw/hfi1/sdma.c       |  33 +-
 drivers/infiniband/hw/hfi1/sdma.h       |  77 ++--
 drivers/infiniband/hw/hfi1/sdma_txreq.h |   2 +
 drivers/infiniband/hw/hfi1/trace_mmu.h  |   4 -
 drivers/infiniband/hw/hfi1/user_pages.c |  61 ++-
 drivers/infiniband/hw/hfi1/user_sdma.c  | 354 +++-------------
 drivers/infiniband/hw/hfi1/user_sdma.h  |  24 +-
 drivers/infiniband/hw/hfi1/verbs.c      |   5 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c  |   6 +-
 include/uapi/rdma/hfi/hfi1_user.h       |  31 +-
 18 files changed, 918 insertions(+), 478 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.h

--
-Denny

