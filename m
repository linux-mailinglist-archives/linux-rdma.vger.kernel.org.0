Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BB5662CC5
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 18:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjAIRbs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjAIRbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 12:31:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2120.outbound.protection.outlook.com [40.107.220.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E5AB70
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 09:31:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDW5WK7asRpy7UFTGpq21O8uqRUcSqOW3o2nOGRSuQTGKITTan1NUlXPPDAcMXn4PHNGUfvxwgslgS7jL9L7WXjfkvLPZ+BQ3GzixYebvGjGhXPcM1XidONpCXAC7XKU134xnep9y2TutVmclHWs3eIVmAQ7FKk6yGEjv8FQEl6l6Fvl9io0CsPuCyqJ9KfoPn/2D5FwFMU6tys79sV963tvb3FeW1f9+ETpFxGpcL7NjpLCGoeNB5ojcM1t28k8wkuNpTPYdFrxw7yFcWDLSXAvr2OWP/95WmpKzdro6sIixyBfXUiJdF9oQxYfIy61GSaqxkTeSzxr5P5u7dg+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlwR2gYk50YuxRpcljWa+CiIPIBD05wGGQOW2rdS7Mk=;
 b=VONTw6veumg+r/t2b1XIczeRASXIolobOA+gjewzq1eNIwfORBYkSbmkS1O384FVM7Uq3fuC+t7TTQ765sBrPeIPC+XC1EgVoil8wEIUnqvYwNaZxf8oKD9kn0HD2bmp26s27zOL86yqVAbYUbDitvA24Ok0LYwwh+1T4GpWLUOFdW7vdRo8sAoNuEnlwVA3tNmTHT9hq7ZAirgfl5LMzBOlLFnT7fncH+psbMceCvXgNtEsJcfm1Mo+sO6UHrmiFcqbx/6Gf/bnMBj8Uy8IEXUxYKaSMX26ElyZi0SXNsfM2N/AjuDsz2fbsbISwEJ/ICuxvVKdi5gkCotz0z3AOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlwR2gYk50YuxRpcljWa+CiIPIBD05wGGQOW2rdS7Mk=;
 b=LDNIQYkLosittWrNtSDNPe5vXHSDHv6lcTxapSdzW4ivEQZYwytAGqHAgPUFpl95QkznnkMtLFLCMIBpYTxZhvgAAR1O4EnkOmBb4a93oauDXCkOrRviFTZT+17R3IveEQ3/CZHzEDTCNdpAfSqZtbMPgu/C4UCcmG5m5bwUazTsRgUxAfXOvJx1WOOKG+lt8+s/PfWR0m3xqrEjAVZ4+u+eRmzUKhF9WObX1Y3ffuc73mAI35eX+U9PSAOcs01kvrCUB+k2YLP5i5u/QPPocrEreqglgG6lMvxe88pD9KOjh4oOMs0EvqWcvcvE2agxNfYu/O1yK8ws9kW5eK653w==
Received: from DM6PR12CA0007.namprd12.prod.outlook.com (2603:10b6:5:1c0::20)
 by BL3PR01MB7044.prod.exchangelabs.com (2603:10b6:208:35f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 17:31:12 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::f4) by DM6PR12CA0007.outlook.office365.com
 (2603:10b6:5:1c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 17:31:12 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309HVBfD1472589;
        Mon, 9 Jan 2023 12:31:11 -0500
Subject: [PATCH for-rc 2/6] IB/hfi1: Reject a zero-length user expected buffer
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 12:31:11 -0500
Message-ID: <167328547120.1472310.6362802432127399257.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|BL3PR01MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcdc85f-18ee-4e78-db58-08daf2674d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVHRrJyzxBY0h6rKzGFkHqn7oY+0DAdaY4xGYcO1gsBiBRS+htosywnlDFgua/GYi+WskNxiK+32Q3QI4j4xz+nUoZKDjRGwGT5PaDpGtjLSkGyScExC8+qIfcmd+sXoe4ZAtrL3vsrMM0sjNCde00ZeiMyvN/bgnrek5f2rMaZWu3vMoOdk9mCKffu/7M+T4E7yWu9PIY+OVpZAbVrfMuhWQhwiOc2S9erIcErNVBleftSGMtf/CEY9v8VJZYEL3t898thP3MLmBEBNPa30myfHGu2n41qoLrRR+uGjy8yOh/9nzb7EumFX1wzLrHFWSeAYon+fl5dbl59shntaXaZEpunX2z485f1u3XP47ZIICkG9b9zSkKc4FZK3F5vbCqWR3D5JKo13BbaH9bD2slD4MMFG2xvsXqkPHe9bX0sFmZF97jRySekvmD1Ynec7C04WpVCmkPcq5XecwDk5xFB6auIH9kkBafckxPmpkGq4COWBpJWE004aHxK11tynAuKMvCAzM4fzjAltqcp4SdyzJu6sKuSvVcE+X0Nz5PZds1LlKeuukbEhU+s8I4rvO8U4GErSRbsEe5mYoR8kiYtHc6ofHC/DlDv1i2Ltqjo4DLArIROmdPe1NcZiMJuXMDx1KP0Ssirca4PBTt13dEUBw5yjce1DUCtm0hMo2Pk+OUhDhiTicNKXC9FRpSI+QzxqFsL9fpjTFWuQG8XNBw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39840400004)(136003)(396003)(451199015)(46966006)(36840700001)(82310400005)(8936002)(5660300002)(2906002)(426003)(81166007)(47076005)(41300700001)(7696005)(70206006)(316002)(4326008)(70586007)(8676002)(44832011)(4744005)(356005)(40480700001)(26005)(55016003)(7126003)(336012)(186003)(83380400001)(36860700001)(86362001)(478600001)(103116003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 17:31:12.1479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcdc85f-18ee-4e78-db58-08daf2674d8d
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7044
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

A zero length user buffer makes no sense and the code
does not handle it correctly.  Instead, reject a
zero length as invalid.

Fixes: 97736f36dbeb ("IB/hfi1: Validate page aligned for a given virtual addres")
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 186d30291260..3c609b11e71c 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -256,6 +256,8 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 
 	if (!PAGE_ALIGNED(tinfo->vaddr))
 		return -EINVAL;
+	if (tinfo->length == 0)
+		return -EINVAL;
 
 	tidbuf = kzalloc(sizeof(*tidbuf), GFP_KERNEL);
 	if (!tidbuf)


