Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51033CA1D3
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbhGOQHf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 12:07:35 -0400
Received: from mail-dm3nam07on2092.outbound.protection.outlook.com ([40.107.95.92]:61056
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239701AbhGOQHe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 12:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hry0R2uiVej6zVmsIuvv3xsShSt1X08nBSycyhYaLAO7WDmC+0wvcPSThXokLfUScZJbvJH/U4bwbTStMxD/qqIw7zpEihEjt7intxSO2cNr5XzOcXW2k5XxfuUL9Cq+AKfZXy0rC+NkjP+VK/oiAT+/qcB5TGLkaSvpwpPf9/xKyxNKZoLjtxNTiT3N5s3oXr8iQyJRCn+bf9p+EeDNBmthnPIOHm0AswqQM7K8LkDZcqFVQACzM+wnEQ5IDYfptcvIzy/mqt5vgjXv4hU1rHM5PFZvnjnVej8YnGZmPKitWzuvzOGqupbFlh+da3qRAf4ahB/MdQHLkONFfn6HRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK0cZmuGtSoMlUdwH/3q9QGFKtFJagKTa1IDig5H/F0=;
 b=ecMz/ytkp5XKDbL6oTkj58rN7qRnBu/kd9of0GDd6csjNVTUpLcX2Yw6jGl3ZRVouv6BCtc2dsx3jEu3lV9jr4VUmQ/fSgGeCn2oYNSaIgUiOzXlGC0tJslGCDGE8VzP/flRx+FbLIkI3Qhe/bHiqCuCTKs1fycwsg//HyYGHyZ44XOBncjnNp1e/AT5c+YFO8REj2akt5NQKJaYLaL3g7y7oEcDOOxID9P2Vz8DW7VOpkW7wBAqGbn65ibYywsp4qmjV7NT0ct0QfY38Ru+cITLNUONC7KqOBI8DL79BXhfOi+TgidQljyh790VqYr7EZMwQec39X4nfJeCoGBOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=redhat.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK0cZmuGtSoMlUdwH/3q9QGFKtFJagKTa1IDig5H/F0=;
 b=MwgJZsu/CUesml4mEA6g4T6LIcpl+EJQjF86SehhTt1ASpeQkPUvpohLukEkvRFRA9KRBeo2TC2dFEWzARJ/FW+wN5pZ6PCu50LdZeNJU8SDn5ZBr8ojT2FCytcvm+6wf68Mfegy44Elsl8lHWwtvdS3qgXc9AOzeBHaTIcYvFLYTTsu7oxakEE6V/b0l6JhQXXPMy8my0nns3K3tqIfspGvSM1GxTAHGy2KQ3t1oneXGYPNUhf4DQ9Vl5SofoH/R9di+JKaNS92Zv2pxw0u4uivDodbdnA/ppIQpsMri8d4bM7/FambTa4wW6+Ip2ZrnLeaKI6Xz5w9FhmCwbm7zg==
Received: from MWHPR12CA0054.namprd12.prod.outlook.com (2603:10b6:300:103::16)
 by BN8PR01MB5617.prod.exchangelabs.com (2603:10b6:408:af::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Thu, 15 Jul 2021 16:04:36 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::93) by MWHPR12CA0054.outlook.office365.com
 (2603:10b6:300:103::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 16:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; redhat.com; dkim=none (message not
 signed) header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 16:04:36 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 16FG4YEw146294;
        Thu, 15 Jul 2021 12:04:34 -0400
Subject: [PATCH for-next v3 0/2] attempt at two small fixups
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 15 Jul 2021 12:04:34 -0400
Message-ID: <20210715160303.142451.38503.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac565953-c79c-47eb-dd37-08d947aa3e2a
X-MS-TrafficTypeDiagnostic: BN8PR01MB5617:
X-Microsoft-Antispam-PRVS: <BN8PR01MB56171EDC4CEE364182EB595FF4129@BN8PR01MB5617.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hwPYJQcu0mJhwwSuSZjfTkvqlb1xRT3CKvv3ECX5UGbYB4jld7e9jYNMfeLr8Qliqyj4Q7k/NCsy2IOVTJDlLj6EkXD8YH8fbU79Qg0XfxThXeIQzw1qwxJSwZjlSZmm0GYF8ELEnOaeT7jXhPjX4nZNcAmluQGyBEjMn0Em+ctSKmlEwxMqGyTY5jugVhVULHPaTn/U2Y+j6dpOpW+bLFeU3TnKZOxolpwOvw6+YFftgaY9vzwQ/vCZN1Wdb/xsFVXAwyPJvA9DpwdTxypPnyUbxNEXCLLFrmESsNOY6KYt0ymwdND6NwBqRulJR37P57u5lEP/vtuHSqU0/S6Z5bXOGOLdd7E3D4Eocp1kGNGqkDmhfUmHENrGxVDtMTPrc4jJALihYaAYyRAInfuumTeLMKbgUV3YIWHziT9XRyzM/JhEolpmEkd5Ihe7yaeNHFh9N9Qq81NXvODs1+BEEIBvWkqadQKGv+jCmYb3l6CjIQmEjgaZ3KfSES31ndeWEcafOU0B3+BlYSNRhvnoBqKSji4rCZ/6Xcue2nAkxUo/qGoR1Rohd19L9RRGRQYOy/6woLPnGGoLDzM8w/LRY9Fg/hKSXEadZPEVwzeXklib8EDnlJk7xjSvj422u092VizKizTjF9URN27fVq1HonumHcdKa+IhejBR16LSirqU3vsQE+Pibd83h224fibObOlgG54am6mJgEFMUdJFZLxPG8fs6f14T8OarHFaoc=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39840400004)(136003)(396003)(346002)(46966006)(36840700001)(81166007)(82310400003)(1076003)(186003)(44832011)(426003)(86362001)(7126003)(7696005)(478600001)(356005)(26005)(4744005)(316002)(4326008)(36906005)(5660300002)(8676002)(336012)(70206006)(2906002)(47076005)(103116003)(70586007)(83380400001)(8936002)(55016002)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:04:36.1135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac565953-c79c-47eb-dd37-08d947aa3e2a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5617
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix up the fixes line in the one patch. These are good for next, not necessary
for RC. 

---

Mike Marciniszyn (2):
      IB/hfi1: Indicate DMA wait when txq is queued for wakeup
      IB/hfi1: Adjust pkey entry in index 0


 drivers/infiniband/hw/hfi1/init.c     |    7 +------
 drivers/infiniband/hw/hfi1/ipoib_tx.c |    3 +++
 2 files changed, 4 insertions(+), 6 deletions(-)

--
-Denny
