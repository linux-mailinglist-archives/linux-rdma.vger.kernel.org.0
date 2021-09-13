Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB376408EAA
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbhIMNgQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 09:36:16 -0400
Received: from mail-dm6nam08on2092.outbound.protection.outlook.com ([40.107.102.92]:6028
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242535AbhIMN3k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 09:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsWt7+SzWduxwvJlTukLto/pe1+4QGow7IOsqbliG13qqIRn4hcbJ4XV31DL5XP7jtANmNSqF85PnRzdkhGCOs7L6xjgIiDpyCoNA1mZm+2yH360QfeVz2FfwwoLBLIRszJY80fBHCPE9pG4zl3bmtR+r8NFX5HsvxMFf86Ai7AMoLLlUpU/Ripb20atD+BSfPa2V/oaoAL4UjaPEAFIJw7h2xnJHRmYUEC4Q/21BoUVeKWVDmEbsnThDF3WrjLVoMA3vECN6SYTCPF2A0HPk95TZL/Hd8Mhv8Ayyr3HlHI8UJkHdTEzH4xRMFJ4b0mb/icak0WEyTccsOaBOBFWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nUcHAQ5LAQc2Pubg99NMP5LmYuufsucQ6c4xvjwfb4I=;
 b=Wkt6zePvV+UlaknDARAK0Hdg9BWWDCY3EPh0eB/6u4hkSxpcz8XX4F7BJPVzjSLTe9BbeXl2xO3beD4YRacVz/SNKhTOrTiUbaWfpjywMhfaPNQ5n7k0LbtUjgFAQTLojcXSQIr9TYVgaowCs73gceeeUe23mwVGFEvpVj/9wmGQJM8Cp5+te0b3HN8g8dmaogRxXVH6ZzTD18Witr1G45rKMLVBJxZaG4rch4uQNuT+C3EDEgHQ3jmAYkP4eaBgyKEwTxvWpZTDDXcdCS47ipsh98LU4kwOOjQ4uSdu/D3n9UKZ8p3psP+eKU0/u6GFWwKnDMIAP/8BOd/6RttkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=redhat.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUcHAQ5LAQc2Pubg99NMP5LmYuufsucQ6c4xvjwfb4I=;
 b=drInZmwQMy5C/Ulf3AKUhY8UQRrsqOoluIekXXh9y+QIX1aFZCUQyQKgtyqpKVayc6WDdm0Lx/CjeRfskj7m/ijR2xUjo26mY4ySNabTKu3uv37xF5KeWhTUUOVga8u+D47ZiS9Wt8JR1vGk5CrSr0yUHwxHPne8RL6B4m63wOSPBV8bEHojSIHzi4xUn7aC+HeqPh7qylRyhVciMd28GdmAMHaO88n3xlcApGveNu6vFY6PzecRHtgtg0VvYkw6IMFBmPqnmxmO/tPOSLRP2tHM1kLa3C/g8ouEjb6vsQ7sUwQ6wUE/50/U5YzKZ6ZhDwzcGM6PEr6Yt1P4TfDI4w==
Received: from MWHPR13CA0035.namprd13.prod.outlook.com (2603:10b6:300:95::21)
 by CY4PR01MB2600.prod.exchangelabs.com (2603:10b6:903:e6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.18; Mon, 13 Sep 2021 13:28:22 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::3) by MWHPR13CA0035.outlook.office365.com
 (2603:10b6:300:95::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Mon, 13 Sep 2021 13:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; redhat.com; dkim=none (message not
 signed) header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 13:28:22 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 18DDSK1m146588;
        Mon, 13 Sep 2021 09:28:20 -0400
Subject: [PATCH for-next 0/6] Perf and debug fixes for hfi
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 13 Sep 2021 09:28:20 -0400
Message-ID: <20210913132317.131370.54825.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a706694-5245-4767-9085-08d976ba5bcb
X-MS-TrafficTypeDiagnostic: CY4PR01MB2600:
X-Microsoft-Antispam-PRVS: <CY4PR01MB2600EA21399171D4923E44E6F4D99@CY4PR01MB2600.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLxpy69d7TiGerpiVo7waV9oWDmKN9Ct7sXiKsUV7dihdAXxBNfvf0kTOoUohidG3O6eQ/HSPlPwh0XmxooXwZ0rUGPATtgIGUmrTQu0tIA5lkUlDWThV9U50kLppfxN7rKJOBGuvrIQOgvI9DB5vDiEmm5cEC9kq3Yjor4+LBXlIms+YY81l0cz0To4MSAu/xgo5koeHftWJDxqvoQUMid0vACF8N1SIz1AJdd1Yg69EhOI958wsnhK4MKiVjiA64FAzx3yXB+CGcphAlHXBj9Zv6I/UwQ9NSM1OUhxuphMG//D1s9bywHn4bgkfn3awIh4IXxS3Oo+24e5VM0qG6C1iLGII+Rctr6qY27eD8J3TeWUXJJ6baM3OuZ0cL7LdLR8CKouub2N4z8VX4gr2qkRl8aPWGDWVYw3cVgjjDFAvnMEF1UrgUep8SJSLmZkxmx7V3s5zPauVZzddHyhQ1bt0wmYmuB7jeYplyReQ/1/CW7vb0cvztK2AhrrRZixDQr7foDfw+BG58gAT6PUfd5E9K1VUF9cOtrRnywF+j0Knsk8cEY4agiO5r3XWMZY96GultJF1xjHSeC6PtwZOKgkjIzM+H2oAmz0JNBmQTGaS4YzqmuM1X1sA+D0+zdi7nWTVtQsuZoACtkwQWXajRXjnold+ip9cG5nBbJIJZeitqanijfdiACes94s7UblhWBD7UCh5Dye7cWULolwyFaB77af+tbL5AQsJufO7on/dJ2iXiecnvf6c/2rlh40rF11D549ZdudHRlKOz7wlTwvWQZZjFRKInRj/cv33oF/M9U/P9LFRUfsDUyMBXJc
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39830400003)(136003)(396003)(346002)(376002)(46966006)(36840700001)(7696005)(2906002)(36860700001)(70586007)(44832011)(70206006)(86362001)(1076003)(426003)(336012)(55016002)(103116003)(186003)(26005)(8676002)(82310400003)(5660300002)(316002)(4326008)(36906005)(478600001)(8936002)(356005)(81166007)(47076005)(7126003)(966005)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 13:28:22.4088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a706694-5245-4767-9085-08d976ba5bcb
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2600
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here is a series of perf improvements and debug/trace fixes from Mike,
who has this to say about the patches...

The AIP SDMA interrupt handling is inefficient:

- A slab entry is allocated for each sent packet

  This is despite the fact that there is a ring for each possible send slot
  that could be occupied by a tx descriptor

- The interrupt handling/NAPI is lock happy has a mixed up notion of
  producer and consumer

  The ring should be a ring of tx descriptors vs. a ring of pointers

  The consumer of descriptors should be the xmit side of the TX

  The producer of the descriptors is the SDMA interrupt handling and NAPI
  tx completion

  There is certainly no locking required in the interrupt/TX napi tx queue

  There is no locking required in the xmit side since that is held off by NAPI
  code

Note that these patches are also staged publicly on our GitHub site for easy
browsing in context.

https://github.com/cornelisnetworks/linux

---

Mike Marciniszyn (6):
      IB/hfi1: Remove cache and embed txreq in ring
      IB/hfi1: Get rid of hot path divide
      IB/hfi1: Get rid of tx priv backpointer
      IB/hfi1: Tune netdev xmit cachelines
      IB/hfi1: Remove atomic completion count
      IB/hfi1: Add ring consumer and producers traces


 drivers/infiniband/hw/hfi1/ipoib.h    |   76 +++++---
 drivers/infiniband/hw/hfi1/ipoib_tx.c |  314 ++++++++++++++-------------------
 drivers/infiniband/hw/hfi1/trace_tx.h |   71 +++++++
 3 files changed, 246 insertions(+), 215 deletions(-)

--
-Denny
