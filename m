Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8D63B9441
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jul 2021 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhGAPtb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jul 2021 11:49:31 -0400
Received: from mail-dm6nam10on2098.outbound.protection.outlook.com ([40.107.93.98]:51936
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233702AbhGAPta (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Jul 2021 11:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaLM8BzLza/uivucJzEr+NvCDnkd+4b+rLpbmR9zOsdio1UAgkLA0LLoLA0UcIFw5E4w0IA0k/lsKO6AecfUI+1+8bJseb+mfED9bhEhleDzKzDZKrT02wuWyH2PFnN4Y4xfS0ypFP5alfORvqp9+Mk04P1rvaSS9GmbA4CQSNru6UJMdB9xMY+qZa2PFKGkNiC9UlPd2NN8Y2bzXK366kp3FejGMS8gyCjAMmuNA6CyVy7oXxcg+qc+Ekyz7Vr8iWT/VTpOV2XKg7hFYi84X0Y3OKONeA53FClBRmnfFBwhKPIxdPbfjbUz0mkF/IjyAFZDOSDMKyyoozykKzYftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSkh5aGaMTigRe6Wj+95NW4E8Z+zL1ZQjieaDbmjxTs=;
 b=oHCdaf+L38STlejTCF8Gc9me3Bn1H07FJ+9tnFTY+pd7ereJYvJtkxW03hDqOjbExIRDjgLdu87Wfq6xDjoXsmUFd+0g+uhcHrCwYrmYwKYlj/VcNkRgAueuUhiQAf741JN+Mh1MSQdMY3yz06GxHIQGt9ypI4mc7QDhhLYK3KDrDKT+Vs7BYqdcB1e8g3H/CX8xwud81TjHIlCK9QDFzCREgKSZOqolZT0C7nk8THK8WBAsDXc/TdzrrSmRtookEAjHg+s/GK4D9NHJUFOymfVTzAMSQjBLdAblkmu+WPcCWniW3IRSjkYgKYLkXLCkIrXr8jze0U+QLC3jUdrJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=redhat.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSkh5aGaMTigRe6Wj+95NW4E8Z+zL1ZQjieaDbmjxTs=;
 b=LivhoJNNz9WrI+8Sb/BBVFJzaiEUU0QelsjYbe/KuKMoFvLA7drcvY1d3h527dbbjtphhm0sd/tmucEuEyFYwgbahjWffS622KdcBwKuGhJxLwe9h3m1b1s3ut8PDE/pyH7h4RU6MLkXMFe+8XHXcHiBlnqfeKeQwZwQgAVarAT74yEWbeZhrMwTVo0jefL6IUiybA844d23PfhMic3H7BYLVKs5Eh8G2ppMyGZuVxpeIyYSb2C91YAmZeym14xw5kKiqo1G5dxHi2aikjr5RoLFOwxjEvsJZ7nLeFUfaYLkl9r8pWseyXrrsAdF3tuGK1SiQgzIAfBYbU+pu52C/g==
Received: from DM5PR19CA0002.namprd19.prod.outlook.com (2603:10b6:3:151::12)
 by SN2PR01MB2079.prod.exchangelabs.com (2603:10b6:804:8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Thu, 1 Jul 2021 15:46:56 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::2a) by DM5PR19CA0002.outlook.office365.com
 (2603:10b6:3:151::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Thu, 1 Jul 2021 15:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; redhat.com; dkim=none (message not
 signed) header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 15:46:56 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 161Fkt7k101966;
        Thu, 1 Jul 2021 11:46:55 -0400
Subject: [PATCH for-rc or next 0/2] Two small fixups
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 01 Jul 2021 11:46:55 -0400
Message-ID: <20210701154318.93459.18982.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb01948-eb5b-4a88-420d-08d93ca774a8
X-MS-TrafficTypeDiagnostic: SN2PR01MB2079:
X-Microsoft-Antispam-PRVS: <SN2PR01MB2079DB277851658211DAC9B6F4009@SN2PR01MB2079.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHPEYi6c1hBasZG3/7tuTxR12W1bWmd3wKXqCLAtz0QjWe1uSpemiCQpiDn9sDUzm3yhJ3y+21IdbBwdEyH9VLZfF8wdyBBZECxWzJfWXq3IlskneZ1BxoCxVRyFMGC/E3jOhn0ggc+WeqxChNJt6NkikcqugW2KfqIZ5b5S1jQdt8/HNfU8hZyFdn9JyOIxH+2+Op+R0WD6JQNUO89/I/ak6X13Tpa/HZ3bm6LedsXndZPgTvblkstNLESPb1PmaKLXUMCvQieui2NNcdEioeIuLaI9MuA3yVNudNcx1bWLLrhnmRrW2HRTnkljONPeKUyDKcfaDz4BNB0tx4lz+I4dpKQt6dO8929VzNZm7nwoPlBLAfRd4ttuZsk0w+tzIyWdqh+ajdY+ZK69Gz+mv7GaMra2ve5cFKoW+Vd3jJALR1pkFZpNDSlX/sHAalaj/WAN5zKqgW41MVktFwdpwR/Z/b46npDOC45VEBP8VRdJBK7/Ah0ySCu/RLYdI5a3d2ptob/rHnp8hY1d7mQ+hTVMiU+U9/X6PysJ3wavVrPQX75r6P95N0RLRzS8UH3BflXrD2GLKXY5ZWpwZfBOQ5WJx0sykHfY2z8k7A4NfIggIM+Zl+lSAlm+rVLhEMhj+j7a7Spxy/UmIX5eOrjuCaGrs++yF+wgnfBp6eJCeu0hwnJQAdtDdOqDH0JjBhJXu9X5AW9FuW6ADwE5OQa11cH1vtWq2sX3BFGS41iUN+M=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(39840400004)(376002)(396003)(36840700001)(46966006)(2906002)(86362001)(47076005)(1076003)(44832011)(7126003)(8676002)(81166007)(4326008)(316002)(8936002)(7696005)(5660300002)(26005)(36906005)(82310400003)(478600001)(356005)(103116003)(336012)(426003)(55016002)(4744005)(36860700001)(70206006)(83380400001)(186003)(70586007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 15:46:56.3285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb01948-eb5b-4a88-420d-08d93ca774a8
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR01MB2079
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

These two small patches aren't realy fixing serious bugs. Maybe you want to
wait for 5.15 content, but they are small and have fixes lines. Maybe OK
for the RC, so wanted to get them out.

---

Mike Marciniszyn (2):
      IB/hfi1: Indicate DMA wait when txq is queued for wakeup
      IB/hfi1: Adjust pkey entry in index 0


 drivers/infiniband/hw/hfi1/init.c     |    7 +------
 drivers/infiniband/hw/hfi1/ipoib_tx.c |    3 +++
 2 files changed, 4 insertions(+), 6 deletions(-)

--
-Denny
External recipient
