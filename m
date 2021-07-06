Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982B43BDC3B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhGFR0V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 13:26:21 -0400
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:49984
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230400AbhGFR0V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Jul 2021 13:26:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7QRgy1jwD5nTNztCWaGkwaWyqI6TyPR2LFPpa3jn26koTsVVLeAOw95G7yzHGnfOmjGvgAt56lFAiia1kE9F7twP0JzItlpFvop2QlPxMFJ++ePpS3TBYYxxrf6JiNV5s51UF87QBwGOCKedS7vZjvQAgnz5jFo4fp0BKTpqd8/CbQsWy5SAMA+++vX5Fn2L49I1rbFu4vYZKxJqySb0wjPTA1eshsIKFU/b/zbF2pPDrWrkBrZlRdAx8RjdQ/UbfaQZkDK1H/ugzLqZw5CQdJ90QEMMlnmJ/P6kZ3brLBhYP8tixaywraXWfogPso3/P+oKx+e7qoc9EIQPKi7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J428vHBucScjfIkgz29li/fxlCeZpB/TOTir2QNEfV4=;
 b=RSUDA3IUqBP/fLAJQY6XxReg1OOZMd7hr9yH6Z+TmrJrsQi074p0+8vuJCTb8I9epovV7T+JbaBuCLw2+LVGQGWEj4slnLrU6WAvhNoE9Mb8jkCnd+vyaHc5YEs2TP1bnvlxx9olFmLbFxwrg4q8sySQFyh2h8tVUVRzVierY5WCyeDiQe+IAxssOYcUVF1EcCRkY5DbhedKOMVmQgX1GNA9uGYTRsm4KYttUsVpSAtZ3I9fGjyP0Tgdk+tjrP05j8KyEaAaqYh39g3g7wjQZvYMdadKZbtE3PybtqR2YrjdfejKkpVaaD5YHEphDEhunbeu5u0N51IisOvvhCUlQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=redhat.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J428vHBucScjfIkgz29li/fxlCeZpB/TOTir2QNEfV4=;
 b=ZpS3ivF8RZiD+4PO2sCc9VAm3jVhsmNkjilWRO0p3dNxnbCA6ZyyUTvMLIXMXy0tWNfr0FI/cwONwkHgbAZpgjm/Bedh3Zfu/wg42EmjGA9FaIe0bMWqHFwyqfx2YK3ubJWYCq69kgpff63+DXk6AuWAk9edcXwV9Wa6JwUBepx1ngJVYOFaELCzfkrVuHs4V+S+2/AHg4/3eIorsFECxSiPI5s5NcaWuwzGaXtV+eg7zJmryiEMwwX8w2Va+P11s1YZ2fz9/KmW1doSLg+L/r8ZrVNP6d6iiegIyozKq8lnWh5+OoIvNZrbGrUG75ZDNOjKa2FWuPRR9OoA3O39ew==
Received: from DM5PR11CA0010.namprd11.prod.outlook.com (2603:10b6:3:115::20)
 by BL0PR01MB5011.prod.exchangelabs.com (2603:10b6:208:6b::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.27; Tue, 6 Jul 2021 17:23:41 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::13) by DM5PR11CA0010.outlook.office365.com
 (2603:10b6:3:115::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 6 Jul 2021 17:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; redhat.com; dkim=none (message not
 signed) header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 17:23:41 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 166HNdKj058775;
        Tue, 6 Jul 2021 13:23:40 -0400
Subject: [PATCH for-rc or next 0/2] Second attempt at two small fixups
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 06 Jul 2021 13:23:39 -0400
Message-ID: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bae90e1-ffdc-48c8-1675-08d940a2cca0
X-MS-TrafficTypeDiagnostic: BL0PR01MB5011:
X-Microsoft-Antispam-PRVS: <BL0PR01MB5011A2B2441EB8B0E7A66F0CF41B9@BL0PR01MB5011.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5ieetzE7zfmaEG3Rp9hVTWcOOIvWIadKl+IotkiqiKimGew63N7RMNcHdeTEa7tbKlTRb4LPny0DUs7+zsgCaXGqqYE4t2jxcRwWLE0zkbog4AWkhhjiC1o53aW2K39SwMrJecK6KC2y69ImPyTSGh/N+zk4bX3sGfLmfxnYpknMVIzPvcTcg3QjNEl8KxfCB6GqtpwYG8ezv5ssBQRAEz8QCkGV+ciAOYWjpeA96TxLAenFCBM9379YAG1JPpkiPEzqZ1OdcIVnVCLKrscoydxF7/hHfrgdIKV9G8lWfj9ZvnvoI57SLdwwftd0ccy1/hp1UbxT49+arg/QMQtQf8s8FfIEss6UzZyIn8tuCQ8uHLaQ041yYLabUhmYQaJLADhpm5MYO/lgthkXMIhpB3FM1/80uh2xWSRE9CzdIQyutuQZync5R0LcjvicorhUzgzF/cyLvFimWoLe9tN1uTa5ny4Z+5nC055omYiIsoiWYk2zo1a+1tUIaDlrFT3Gax0WwzVDnUN+OoLulgcMFmPb6k8PDglzkQOR87us/A1eoG1nzmyhMqqFm4G+oI0RVr+u0hXRdB/i6DDUZPgK+CVHfWUxaE0vlUhB/4/++qyvGBRtoZCDf3BS8FPl9OqqFiW1kTLhYtmCa5aSzjOJChhU0CC94F/9yAkVxtbDqdI5n/AhhDRyMBbqvSMah7ORuzk3aVPzZv3adoTiZH9ROfRnlHWWvcSJg019hBNaFITdwqS+beVvIjVbPjn1aD3ZKELxxKfND2kLWX6UDE4pA==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39840400004)(376002)(346002)(136003)(36840700001)(46966006)(47076005)(336012)(8676002)(356005)(426003)(26005)(7696005)(7126003)(186003)(44832011)(55016002)(70206006)(81166007)(5660300002)(82310400003)(34020700004)(8936002)(83380400001)(36860700001)(70586007)(508600001)(86362001)(2906002)(4326008)(4744005)(316002)(103116003)(1076003)(36906005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 17:23:41.0719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bae90e1-ffdc-48c8-1675-08d940a2cca0
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB5011
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Word from IT dept is they got the issue addressed. Test to my gmail account
looks good so here goes shot number 2. Sorry for the extra noise. Jason will
check our your mdir sync stuff thanks for the pointer.

---

Mike Marciniszyn (2):
      IB/hfi1: Indicate DMA wait when txq is queued for wakeup
      IB/hfi1: Adjust pkey entry in index 0


 drivers/infiniband/hw/hfi1/init.c     |    7 +------
 drivers/infiniband/hw/hfi1/ipoib_tx.c |    3 +++
 2 files changed, 4 insertions(+), 6 deletions(-)

--
-Denny
