Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166C1709CF8
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjESQyY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjESQyW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 12:54:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BDA13D
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 09:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKvpg7/Dx6AkMhRqahC++S+HOQKeaXvtM21Ww+7hmyZNyEJ4IR8vgaysbiWXOdJ0CKX1c5nb+itIjrlHkXG3Ts3icfIZ0Qd89OB9V6nSMl5MG9IdTKaF5hXQJadfcIIvg3Ut+x1YeiFR7f5cD/EnwtwgTCuzUb0O/+wVvAXVmqazporZq9QDwaZjb+jgmZ3kcDHi6veOaQYhAp9sihU0lL5dbzzS2kkLIyuXsnPwh3lMoCo+/3IGmER8jwleLrsYtlFI15/OCXEvMiiJKiZeR9W3c5eKYrGtDBedfyfNGjcqldBcVbsu9tcv4ArN5Qx9qVHdb/u0ZF6e7wEULibOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uF7u4Jr1EOS0hJCxSNrMsHPG2t3yqJMN3vJNoSL5CE=;
 b=DbJBvikqitPALXXRDerUlP0kT/Ee/ulKmRJ5mnP/1JFal/3879IxS765YH/dthv5bD5FUyQdqOQp/NtNr8U6ao0uvW/mmoYfwhb76rz5pGP51Joufwbg8f3OyQUV54GndasjFWexGqZXJ2XtWbs8VjY7g73YdeliRE/3PbgOY4OtEO44rt/Y0wuTVCUTnafMCwXHlQ3/6XSLAWkw5KcKLnTRVkCcqxvrEFUH8Fza0ks98vjaFI68IABMJycUXtSkf2aQdCOIh0qdzAJlDAt0pXkt8dIyot0gWH1UC03qVrB+u7vhDiSRCqTZ+Fbh+1dQjisIjF0vUkErc6oRXt7L9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uF7u4Jr1EOS0hJCxSNrMsHPG2t3yqJMN3vJNoSL5CE=;
 b=PCQ9yf2ntd/bjc06caDKvyzByVO9Dpsg8uc3qk4D3JD87Oj3IxCWBOtaXIWrV6jiKZ/cpekRrLAaU6Gnwhisni89J+3YEQeuGtmWtqIeMJJRSFVnoxO55dsjTOTWIMpmJSJ1CRiYLJpshd0oIISP2Z28fJX4JC8W57RlqQUcUPWx24m92pMPrFxJaTM1phoyZ0bfxx0LkoIAZsa2EuZiP3nvasLmULSTOlQ8Of3ACgCsDaMIyE/QalluZ/aMtHm8hc9JhQgYyyU/Wx/mxP6TWGuPJhBxZVbuw0ZKl4R2KohjwQgbWxMBXsmV9Mlj8ZOtzDqfvVq+s5veqiDzf2i1Hg==
Received: from BN9PR03CA0663.namprd03.prod.outlook.com (2603:10b6:408:10e::8)
 by DM4PR01MB7713.prod.exchangelabs.com (2603:10b6:8:65::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Fri, 19 May 2023 16:54:15 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::66) by BN9PR03CA0663.outlook.office365.com
 (2603:10b6:408:10e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20 via Frontend
 Transport; Fri, 19 May 2023 16:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:54:15 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 34JGsEEx3702359;
        Fri, 19 May 2023 12:54:14 -0400
Subject: [PATCH for-next 0/3] Updates for 6.5
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 19 May 2023 12:54:14 -0400
Message-ID: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|DM4PR01MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: b042e123-4f8a-48b2-30e6-08db5889ade2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6L2EJ3sJwkzgvgvdZjTtM7rYyQz/1Vv4UJwVqUqQ+ei+oHGdq2i3tFcVX1PRsD7vgH2nWR/z9nKXzT4tYvVZ5Pu/iBbMP4ks3j/pBwQsq0IAveGum9jk4Y0IA8zAF+/M4lcJanTM3+SfITqzjpxv0ylTXIkET4vU5GmGIPOWuEnIhbfcXLqyApPfL4sQ2dat5n+M0jwDekz/Qv7mNQG7PF9V0m+BhjN/acL0RmO44WjbRsx8WVFMtw2sa1YqYObICf8w/kTHBoqocQWasXfN11KvgZD9Jej2fBr07eCllOxbeChC4vLCxA1PYY308PN7ko2bXjFJYN5cWsHvFPgc2Cs4kkk/BMvB1PRCzDyBwEziDD+0dwoNuw0F7hDnM2M24OqwOpHTDcTpa0R6MDEfNoKAN9jP5hsUe/jya72PEHtfq41VQKLhQPnlEJhQmUnNjC/MKBibjOH0ByfEgtV3+2EaEIp2tXctWktjCrnVf5k8gfn6PDMwKCrrKhVvxnn8piNaKgRqzI/AWbcA7rJTlaV4WtEMuoOZetfIH23pv7RElqnBM3j5boY0wqWZ/0BfJg9BA3H7cBYdCVrzTn6MOZpNL//dRowIYOoy87VoktCn7z70CQ8HboRVcyn+sNrGS04ak3oMOu4rIJTh39yaCXuLk32e3vAazpyDgYTY0Jo9HwE9d2eKRKjtLPcyswUtdraLCC/AnJ4fcb/R+crYPhsxLq81fGXx0oD2wnEtrc=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39840400004)(376002)(136003)(451199021)(36840700001)(46966006)(26005)(7696005)(966005)(36860700001)(7126003)(40480700001)(47076005)(83380400001)(426003)(336012)(86362001)(82310400005)(103116003)(186003)(356005)(81166007)(55016003)(54906003)(44832011)(316002)(478600001)(2906002)(8936002)(8676002)(4326008)(41300700001)(5660300002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:54:15.3790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b042e123-4f8a-48b2-30e6-08db5889ade2
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are 3 more patches related/spawned out of the work to scale back the
page pinning re-work. This series depends on [1] which was submitted for RC
recently.

[1] https://patchwork.kernel.org/project/linux-rdma/patch/168451393605.3700681.13493776139032178861.stgit@awfm-02.cornelisnetworks.com/

---

Brendan Cunningham (2):
      IB/hfi1: Add mmu_rb_node refcount to hfi1_mmu_rb_template tracepoints
      IB/hfi1: Remove unused struct mmu_rb_ops fields .insert, .invalidate

Patrick Kelsey (1):
      IB/hfi1: Separate user SDMA page-pinning from memory type


 drivers/infiniband/hw/hfi1/Makefile     |   2 +
 drivers/infiniband/hw/hfi1/init.c       |   5 +
 drivers/infiniband/hw/hfi1/mmu_rb.c     |   7 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h     |   7 +-
 drivers/infiniband/hw/hfi1/pin_system.c | 487 ++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/pinning.c    |  55 +++
 drivers/infiniband/hw/hfi1/pinning.h    |  75 ++++
 drivers/infiniband/hw/hfi1/trace_mmu.h  |  48 ++-
 drivers/infiniband/hw/hfi1/user_sdma.c  | 472 ++---------------------
 drivers/infiniband/hw/hfi1/user_sdma.h  |  15 +-
 include/uapi/rdma/hfi/hfi1_user.h       |  31 +-
 11 files changed, 743 insertions(+), 461 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.h

--
-Denny

