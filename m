Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC16CFB67
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjC3GSm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 02:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC3GSl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 02:18:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2913C40C8
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 23:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUFfkcTH8qCm9MrUnLj94J2T4eb8QIrI1p5BlVspt9IklHdfrRYPORFravAZbmqAc+b4XDcHsyQWqSeP4DPr5XufquB2UrDnpnNjgMf6KYMt5QFjo/Gln4J7z8plfHzjNdaX399rKARN/Cq88JXn1rd6jQmw2NWkKaAzPVBRP/+FhIs1CaPOcwKt85+MZ+zBjgq9iJVr5f01ksypmhfYMTFjjGJ6wYcxbLsTXjhvndcF0gEz9bgc2B78AgCY2ll2OKiXk/0ggF63G+Byz5DB4OSsDafWcJ7WMRiQFrvlaWacWnORdXOE4cQXraAqxOPBjZ5mtUXYVZdbFK0nBGmkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH21nrYbdr0mZfBZsiNNLiEoCpqJjwF4+St3lgF49F0=;
 b=G6d8/r3E8Fh3z3lVdUJ19obDZteuuQq83SH/nd5/hWVo8D7ak4RYgChdeEITVBzSQxUBXCGwGNl69sumvB7vVCTctPvqptuoGbk++eiWaXLVKlwhvcZxhSBN2qc9q0/jlv4dFQ/f8zpY0hNWY2DZljM0R5MkiM9wAUWotMraAn1Uq8QligJ70jngSCaHP/V10DmY6cAm0NvlfLIjKG29q9AX4E/2LYmFe57KKIThljopaNuJi+0Ajsl3IdyMP6SibGJ/9NeFABfZpc+KN0MkiBM4zyjK8qCVIM/fTdXwyBSyzSfKOWVerUCKsG7US9c7/2vxMnkWlWrHodaONVJ+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH21nrYbdr0mZfBZsiNNLiEoCpqJjwF4+St3lgF49F0=;
 b=GxhqJ/fMGlX2tXKs4vDtcujl1oS+N4dF/HFmI7K7v8fSlqejd+VYPl44uAiQ2sDe4aecnMysLfcPIlkf1wqS0k34WxlWE9NaAZojI0+IgmunYM2PvjouYEtz6g9/Rjt2pdwcUXQbFgYnhcRb/I6KVAsC6dxRP2/MgU1J/4rSpGWjcJagb3ojFRfBPLvM2Dn20VgDqUCIA6sRRAwtqTPerkSLCwbibl8nH/ENjLysPAaIZGMpXSGyGQAYYh/M0ANjC5Oa9/20J1OaLFzGda2ZRxn6jjKLZhrTvx3yu+bqawrrE1UynUehFpQjadM3ALCM6hHucvr2GaS7aGj+SJ3F/Q==
Received: from DM6PR08CA0002.namprd08.prod.outlook.com (2603:10b6:5:80::15) by
 MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 06:18:35 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::75) by DM6PR08CA0002.outlook.office365.com
 (2603:10b6:5:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 06:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 06:18:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 23:18:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 23:18:16 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Wed, 29 Mar
 2023 23:18:15 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next] RDMA/cm: Trace icm_send_rej event before the cm state is reset
Date:   Thu, 30 Mar 2023 09:18:12 +0300
Message-ID: <20230330061812.479463-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: d31fdf55-aa47-4314-5587-08db30e697f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTl0xfCtJ7wEP9aruACVT54qO2+SXC6C3oGv7aZ6qH7E+2e+A1huXd4mTuj8G3DgUvjEDAy6V26nkXo+VUJ4VMXvId/GDRTyUAIkTEDWs/aE9sDI66yMnHDUEpXfsCBGHpQQyztM3TR/ybkKpIKsXFzypMeO3cFhdHG3LcBicviaHY9LsDxAVGZcYE6WHJSJG1H3L9YiK1xizkDqopDHeJW+buQrBC98ivO3nkKoatTPqE8xM0723LQyCpoU+3OS4Mnhtj77LjsaHOp8aVf4N7on7fPmgOo1fRno+/JvNglmGo3u/tafZC726UtiOaI1o4Kskj4OF28TDFDuJtIK5YE2r//e2wbys+ZK6be/G/nKJ188i081GVrAn5nIDtny9ZKqsbnFQmTJyyY0t9PxHz935tpes8anByfysy8RWnjqgyFAi+FfjzPsl4zz7bR45f7dfM9Y//FJSnbv4IW1pydd+dpu5T8Zom7Yk9jeC9aEThxxRb/ddbidJSeSvtoUtPWlhwg+7O7KbK9GQEE8H5oJY2IyP87fDxIRa6kJAXrA/oIcxzCTNODcefDJy0NwcbWwcVI+/oAiNQ2JfsdyvqdE/Pwicj8abAtru0XO3pqlu0VsHsljIcCyAnBRU5a5jsUZJfpA7uGzG5mkZXMh1d+rLpEEtr0IGO3GX9tpZoDzocWTZ2gOUk2jjLb+QRzmL/V1BkxszDMGUQ3lpnpl7QfI0A0C3PxH5HwdaWRAWKBcqyM8U9++S4hx9eq4/sxym9oaeG81ARM+V2VlV2Y+3IwaUHCaUcdULHrwXsOeL7U=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(426003)(2616005)(336012)(83380400001)(34020700004)(36860700001)(478600001)(7696005)(186003)(316002)(110136005)(26005)(107886003)(6666004)(1076003)(6636002)(54906003)(2906002)(82310400005)(5660300002)(36756003)(40460700003)(7636003)(8936002)(356005)(70206006)(70586007)(8676002)(82740400003)(41300700001)(86362001)(40480700001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 06:18:35.1806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31fdf55-aa47-4314-5587-08db30e697f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Trace icm_send_rej event before the cm state is reset to idle, so that
correct cm state will be logged. For example when an incoming request is
rejected, the old trace log was:
    icm_send_rej: local_id=961102742 remote_id=3829151631 state=IDLE reason=REJ_CONSUMER_DEFINED
With this patch:
    icm_send_rej: local_id=312971016 remote_id=3778819983 state=MRA_REQ_SENT reason=REJ_CONSUMER_DEFINED

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 drivers/infiniband/core/cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 603c0aecc361..ff58058aeadc 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2912,6 +2912,8 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
 		return -EINVAL;
 
+	trace_icm_send_rej(&cm_id_priv->id, reason);
+
 	switch (state) {
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -2942,7 +2944,6 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 	}
 
-	trace_icm_send_rej(&cm_id_priv->id, reason);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
-- 
2.37.1

