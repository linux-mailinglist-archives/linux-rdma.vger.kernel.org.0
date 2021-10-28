Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD943E132
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhJ1Ms2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 08:48:28 -0400
Received: from mail-dm6nam10on2116.outbound.protection.outlook.com ([40.107.93.116]:58060
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230281AbhJ1MsZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 08:48:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acxT0sWXJV5JdyKDhecAy1ACMo/TqwDqxcv2w1ZYboPHzt/rlVTWi/ntX2KVT1N+HaQIg0wIfuwQ1J0zgwUySHr2H48F9+avPD/vvquub1sczBS5ozZDavlkZ61OfN+StvD24hWaPiLrXWXv20f6aucCKOVQ6dBATIbE7XYhjKx3mn2gYRoC7gPTakIMJ8V00rQILNQRjZ5q+znrD8dSCGPkjd1IKgA9CFsn3DyP04tNaUcw3si8T8/oSghAndRG6zHTcNBcF3J+MbXrAHFtJopZIzvWh83LT2cfLNGYp6hHWhS108mwVoIgkIUI3RTXFW27guB+xBt58wrQytPFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn8pVbJtGJvEQg0C7Ut+HudZmHWaQWzbQ4byMj821Iw=;
 b=QPw7DBch5zsvoIpePXr2jzVm1ujttiNMrWTKCcs1MoTHBtsmqw0ZYKJgnitTlassVtFoDliRKO7bcWFb2YzSQesetJLZI/SZ+MpBubQ+w0QaAczaL5VLOugkrFo3dTD1EFAYYNfIdkugZ947opaFFPJu8+ZZMNhKa7oHEtwnpmdBwA0Tdmj60LGDN44AVRQJiTMm3o2z+Ad8lxqHskA/cB4uKwGha03kbCavR5m7UgJlbryy4ffXf/1VlmX1ayD9L7Re5yV+WSYOYaAslOMBZnVMc+buL+ES6ULwcnI2/IdJKhZD9ls5+ChdK9iTGitpXLftM4jHx/B6lAIItDeyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=redhat.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn8pVbJtGJvEQg0C7Ut+HudZmHWaQWzbQ4byMj821Iw=;
 b=INY+N3IHUS3wLZ6xcimneZi3iCkel7E6athj+n/HHj84Je8rE82u04+QI8teAVo+wlGK1puX4PkefRD86RkZauC+SHsYCJiXuaAfiSX/gl0RxSRMCe3kuawmI/5IbUu7yt6n3SZ9QoQVqpPOxOQ0f4hMBYutCsRnZ/CzzoSWu6p+hLfNeT0bqL71DCbQfUPHVyum39IO1yra4iEvW2xadk/wi1TiH6pmnN3f7xvT4PR7vf7PU0oQucD3v36xIZoV5Fk7T7h9A1Y4KICTTV3HEZ/MZ3PqIzrSiDMaWJpG7SWX6GR8ZqDvidZQ+mHViDOkoDEMcIEKrbgQjW74yap5ug==
Received: from BN8PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:60::39)
 by SN6PR01MB4192.prod.exchangelabs.com (2603:10b6:805:ae::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.13; Thu, 28 Oct 2021 12:45:57 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::9) by BN8PR12CA0026.outlook.office365.com
 (2603:10b6:408:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 12:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; redhat.com; dkim=none (message not
 signed) header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 12:45:56 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 19SCjt6A028780;
        Thu, 28 Oct 2021 08:45:55 -0400
Subject: [PATCH for-next 0/3] Rebrand hfi1 from Intel to Cornelis
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 28 Oct 2021 08:45:55 -0400
Message-ID: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18108f27-6089-4d68-90ce-08d99a10e2fd
X-MS-TrafficTypeDiagnostic: SN6PR01MB4192:
X-Microsoft-Antispam-PRVS: <SN6PR01MB41925FA8F504612D0F71486AF4869@SN6PR01MB4192.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yVrIqiWJpMUq+5oX9XH2Pdk8nLrvglfbPeNpRR50M6Mg9+f+37ibFTQaa+OA4es5bQeG9SKqF6A02dVFPFTOU7EfOn+oM9cLh0Jn4IhNbDq01BUo7+5REXKFyHV6sil3X/Ve5eBsxmWgfxrLxBWE9vKwc1MsrBsrmTYrfZjiFjY9SQIuQdOthIRQU/3xGCLSUt9NtDRK2dmP/9FOj7+wYGTTSIdfG1568rlDPz8+ogOSCFCaVFQaa0Rwxu6gaeCBhsH7NEHUHSOEOzX47QvLS8+ikmFICqp1fhwuHROJl5Rd8ZOcU83fiG49lMJUUkxxnv4J/v2VBhp4NR0hABVD9aQ31PCmaDLSZ6HzpTiq6axnzt63Fc6LfMnXtXGnZKDS8QFKn/YjKSPhOfvrCa2sVIdipdyS5rvBOs+qYrPGqPik71RM6T8d/drpRDjFbzSoJNSdCYA4TK3wqAqMN6ZC9ELwRs+cUMf3/6Q1QK/gb+7i8+dVazG/l6nb+SCa5uq8pVVrOCSS/oEIHn/lei2olXPt569l5BBNqR4BCIVZ9xnO+kbCjpdY670M9X18PmMXQDivaovogSr0a1mYJjGLFPB60+d5stUywiy//VUnHPftfO9I9KQ/0e4J7gWPS2XGGDcuWHb+Lxd0p/TkhjgFL20vDPdXi30pR0rUUwOTfTMTWfdi+g7TpmgEIZHiiHuSsU5OobubgxOVAGrDZHZakJdILhnILa7g2kisG2+i4I=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39830400003)(136003)(376002)(346002)(46966006)(36840700001)(8676002)(356005)(82310400003)(336012)(7126003)(4326008)(8936002)(81166007)(36860700001)(103116003)(426003)(47076005)(1076003)(86362001)(4744005)(26005)(186003)(5660300002)(508600001)(2906002)(55016002)(36906005)(70206006)(70586007)(44832011)(316002)(7696005)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 12:45:56.7119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18108f27-6089-4d68-90ce-08d99a10e2fd
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Touch up the Intel related branding strings in our drivers to reflect Cornelis.
Note rdmavt did not need any changes.

---

Scott Breyer (3):
      IB/hfi1: Rebranding of hfi1 driver to Cornelis Networks
      IB/qib: Rebranding of qib driver to Cornelis Networks
      IB/opa_vnic: Rebranding of OPA VNIC driver to Cornelis Networks


 drivers/infiniband/hw/hfi1/Kconfig              |    4 ++--
 drivers/infiniband/hw/hfi1/chip.c               |    5 +++--
 drivers/infiniband/hw/hfi1/driver.c             |    3 ++-
 drivers/infiniband/hw/hfi1/init.c               |    3 ++-
 drivers/infiniband/hw/qib/qib_driver.c          |    5 +++--
 drivers/infiniband/ulp/opa_vnic/Kconfig         |    4 ++--
 drivers/infiniband/ulp/opa_vnic/Makefile        |    3 ++-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c |    7 ++++---
 8 files changed, 20 insertions(+), 14 deletions(-)

--
-Denny
