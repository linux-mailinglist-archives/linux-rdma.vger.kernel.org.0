Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C90E662CC2
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 18:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjAIRbr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 12:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjAIRbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 12:31:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2108.outbound.protection.outlook.com [40.107.237.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCC1583D
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 09:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl680FCDu18hmiVeMxN3yka+aA+pOMSykS1bGjQt7iJOH+LZR2YDW/ZWIWZAsvrnrZ3RFaAbyVIzex1aWYvW9eAJIDGLiIsDcIsncqEILI2K5ateos0Naa2pjwXl1o4FGfzjoIbrEYhVoVlh3gU2MDIFJOHwNPT3GoD9UK3//QA8ee2SbydB3gGCzJQEeRzTwdMfEK/bKF1pK14HsdXkBQTPB0XdpQ7BLZm0G9CnApe1T3+ugXVP572uHsItpfuFk11SvLTAKDaGbZSLp6pcaDTaAvZblI5JZ0XXG7TnnC3lX9eZ9mmhFF9J0adVPANXNd0AQixxNnrgpotnvbP42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t13avY4AeDtGmHo2jebyMj3c8Bz7MWkBGAMojmTrgx0=;
 b=ed6FqTmmqg7GVEJrBZP7orrZQ5cY7j4JexW6ty//YQulMHIZBgtMRmjdXDsEedszR1FRBY43QK6gGivuiTv5/IsnQHCNxYrgcfwdPJTbtOprkTpJYHvnFa4qwoVOsZPjHFhGSsoQ2u/6XzkzwQjKLctxm1lwDMkmnkALvrBz2+p/Ft94RlFpVnNvOAYIXL16tn3IvcBW6o2QcZuHo2tg2Z6e+oq7z0CDsZA1c5OSuBJmBmu7Z6mnvB7DYowlomms2dNFJZmce93Yx+W9Y4xLuNlrQGSOk/5EfWbHJcrkAdSMHdqKZ9TPhoyvSCGeQ51OXf5ST/+iHWYEXdZObz2EmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t13avY4AeDtGmHo2jebyMj3c8Bz7MWkBGAMojmTrgx0=;
 b=gQlWUqjITGMI1Xac6Y31CAlMPcMfQXjwMWvaoI1/itispDwrI/DHXsjBWeVzY6WASwwilFGGCLo1BoOu5zv9bd6X4afvwXah+Fx60iNKK4bm/4AKk5d97AzGygcote+KwcD8Kotm/y88K5N+pBBl14sSCOY0OA5OcPFUZ1n1XMw1QPg8XNJVvKmuaYYw4YsYhcCImS/r3cFj3hMZuY2eRWDiFdn35QUo250qB33zgPiR38fp+1ACQm5WqX+nuxMvJNhsCum0Vx0RmEOIEz1NNkCRt8Y0o8mudXKpVSaeZyyyZ2djfLq+m0Re/mur6E/Z6SUJ5Jl47A0ZIPoNvUXE1A==
Received: from BL0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:2d::18)
 by DM6PR01MB3772.prod.exchangelabs.com (2603:10b6:5:8f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 17:31:14 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:208:2d:cafe::ed) by BL0PR03CA0005.outlook.office365.com
 (2603:10b6:208:2d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.15 via Frontend Transport; Mon, 9 Jan 2023 17:31:09 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309HV6B91472580;
        Mon, 9 Jan 2023 12:31:06 -0500
Subject: [PATCH for-rc 1/6] IB/hfi1: Restore allocated resources on failed
 copyout
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 12:31:06 -0500
Message-ID: <167328546603.1472310.17312024395730671459.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DM6PR01MB3772:EE_
X-MS-Office365-Filtering-Correlation-Id: 46245ca8-7daf-490c-4354-08daf2674e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcGgsn072NUaLx4IXLKXhdeGSSt8wjl89RmEueJlxDeXUGwautW+K3SAXvC5qqm5YjQz6gUdvrFTaoSJuVMXc3dhT9LhRovxrVkbu3uUXwv25WM6xyfoFYcRB55Z50hPYYGMlegoALF6Hpd6CPMW81BhDiDFyDcsyTitcUetAr0loxdcE4zDJXDjtHST2FHZH3y1YSbsMjosFs/EFZ3Crepexa9Aym3gm/f0N04mQTBQIpXhR6zoboznxGuqOKgrtahHb7w265YY6OsuIGQDppYG7JMzLs58FMTTi+GmJHlH4lvpknZMHBY8fhnSB5PQCvILsZlO8ix6OaOmFyUYnXCn1S6QK1ooso88zqqgHKAHUOmwW5PWrFf+m+48RPMO48HrXCfeU778FrvA8MBb9PXsxCY2sIUb6UdGRF5mZ9A+nE2i+hyeqZBxQVrgBWHpfytjgET1F83rpnZ+XvcmdXwtm7hZPIq1ld3/wMXtF4d6A88TgVyX+illZ0DhpXuo/4OlFKIiO9u8TDZ1WiuQzZQDtHlNZD7d9S6+9q5eoGLDNUmI73eAxaSZ2odLxvfrp9XVGTYiIbFTALVe4tGexW4DFvzB/4+h3ivE/cwaM9//f6sXf82rOrY7Wap990LvVrts3FKVf2EIMPf7VX98DfHSQPzBRJ3jeKZ79ty7Bd/R6Hub/vr9bsDgp4XNwyO/O+IhbLrpq2yw2TeFVQS2qQ==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39830400003)(136003)(396003)(451199015)(36840700001)(46966006)(426003)(41300700001)(47076005)(7126003)(316002)(4326008)(336012)(8676002)(70586007)(70206006)(83380400001)(82310400005)(86362001)(36860700001)(81166007)(356005)(40480700001)(103116003)(8936002)(5660300002)(44832011)(55016003)(2906002)(478600001)(186003)(7696005)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 17:31:09.6346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46245ca8-7daf-490c-4354-08daf2674e3c
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dean Luick <dean.luick@cornelisnetworks.com>

Fix a resource leak if an error occurs.

Fixes: f404ca4c7ea8 ("IB/hfi1: Refactor hfi_user_exp_rcv_setup() IOCTL")
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index f5f9269fdc16..c9fc913db00c 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1318,12 +1318,15 @@ static int user_exp_rcv_setup(struct hfi1_filedata *fd, unsigned long arg,
 		addr = arg + offsetof(struct hfi1_tid_info, tidcnt);
 		if (copy_to_user((void __user *)addr, &tinfo.tidcnt,
 				 sizeof(tinfo.tidcnt)))
-			return -EFAULT;
+			ret = -EFAULT;
 
 		addr = arg + offsetof(struct hfi1_tid_info, length);
 		if (copy_to_user((void __user *)addr, &tinfo.length,
 				 sizeof(tinfo.length)))
 			ret = -EFAULT;
+
+		if (ret)
+			hfi1_user_exp_rcv_invalid(fd, &tinfo);
 	}
 
 	return ret;


