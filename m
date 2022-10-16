Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007415FFE78
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Oct 2022 11:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJPJik (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Oct 2022 05:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJPJij (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Oct 2022 05:38:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027E3DBD8
        for <linux-rdma@vger.kernel.org>; Sun, 16 Oct 2022 02:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwSMJAkvT8C87UqMgL/QPALwXvZd9Mr6n2iMiI7izx9IdyuRf9/y5t9qqAC8VULAKnyA+jmE5pFXsVh6Dxc3x+GbBnVWdHOHQV6uDxHj/33w/W5tfLvhHv9RfCpnw5MTCe1kzFKQlmbLp8e8ltv6rK94rTOrBjRNYkXA0sXUgGEHRWR8JNnRQyrgIEOV6OTVoirYKzWBnaB/MY+OcB8f9uGnmOwY5v2KUYkXgRtFIIF8dlZ0s1Arsw02EtsmDuRDb0/R/4mRpX9BnRMrJYWDpkwz1B4X9/Wul+nFlgOiCeJozmrwq7TkXZFt32/2H2p7fctASymQp1B32/S9UK5DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1WaPeh8w9/ztLiXPr3I1PsdSGpzgx828rm+MVHEXzg=;
 b=fFpUW5265LnhXyUDjxJAalRqF+vVADth89ttjgBNml12ET8Yv4VZzODo9SE5gkxlZeOJIWzCc5sEXBFSQA1TDKAx7eggkp9Se79Y6DJteeZ5Ap+LywXy+r6o60i6ClHEmDWkO87rMDjNOoMt61Kkdf1X7F2LmD8DSlQqtv9a8EZRIwTQ0Q5xxgcnKgvtomLR6r3ndIcmKzd6XoYGRL1v0S72JE57ITI4b6tWBAo3+SL9YrMH6DS/5Xb2oXTlTrIayZGohPIRos+219Ul1grNbinVWzuTotwhgC1+5BKnsFBjPdP8Wo44ov4KX3alZHOlEkyqKtm3gXsF7cZ777ek9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1WaPeh8w9/ztLiXPr3I1PsdSGpzgx828rm+MVHEXzg=;
 b=OrLRRTKr0S2XkzDMwOJ6CbuAS8hqOWggcnLMTkK06V5kJiphyugr2oNgDo+t+zbOYLzeFNyg36b04Y1rw/hkfLwxScSOz0Xl7uEcAFWyvfdQMiQMEDb06femqtaicS1K8gxH4d4LEr1cmRWQgim/Gr8RiRXe5Enfe2QW7crpDo7FhJEpaaJn0CawYSvT5i1ArgPKoWfFgzxBaOIAP2LByqeg+d9H0JVGq/PDuXPkSc+XzfHqxnWhTnsdYGXXQit9JzhqbyZWceBuzSme4lDH7zifLJp83LUrZqjR+hvTT2xVaqwXWwoBoCmZ7M63duvWNtBMeH3J0a4m/zNtO/CNsw==
Received: from MW4PR04CA0273.namprd04.prod.outlook.com (2603:10b6:303:89::8)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sun, 16 Oct
 2022 09:38:36 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::d9) by MW4PR04CA0273.outlook.office365.com
 (2603:10b6:303:89::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Sun, 16 Oct 2022 09:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Sun, 16 Oct 2022 09:38:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 16 Oct
 2022 02:38:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 16 Oct 2022 02:38:35 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 16 Oct 2022 02:38:33 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <sergeygo@nvidia.com>, <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 0/3] iSER patches for linux-6.2
Date:   Sun, 16 Oct 2022 12:38:30 +0300
Message-ID: <20221016093833.12537-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d77cfc8-c249-4c01-31ec-08daaf5a3312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kj1lf3mEQT4U1lR1QCLwkbopnoQkC0UImnfw3fhFelujUKhitCkmm8DohtbyCHxp7IJ1KaFwWJAiMHyQ+FeAGscH2VXDtuucsdbgP93CHGA8YOFQvUgTEGceRREYDZ8VjtlnYmqPaDvxaS0j2cnIl3XofSVj/289kEznT4b7+dDYwQjfiU0hHqES1o7o/609F418B04K1n73vWsuAYFS8KOFv5ea0i8mGSxXO4eXQMwy7VNCKxv1zHcHHwToyf73TbyT+kmGwzXaMAnUEnoGmuyRuAJSP9hlSyNiKW90DBQbAA4hbvFCfyCqEAYPrNz9Tkn8e/LPWUwBpGNjQOVCfFOISg+49oL9zE3c0mLL7HJUbOrG/5+olFAeUcMa3VmYjRe1CMSV77/VSSSFXmfF/2BHw1VX0RrLjKpaZvXGs8OtxvtLqCT4FgZvF/5xj9O6YrCj2JPCIHowah2gN/LZ/hahzgHZi7eNQzkEopGdCn7n5yWycl4tQ8X9nRj0uoE95+vLwVfqmgvPdPkzUZrPrQqZ7aHFfaJryJSG+Fcz8DKk3RNKcZ5XULuEZ8LbMYLqBoVQ7F2KVdo6047X8jTGGZq0mLJP3l4Lu5xxqUm2NHQu0wE257/0ikoCyAF4xssMFaFoDNq61UhpW1C4TUN5W2B106HKlS6DOtsYOwaR7SNdylv0gz3NyNYT7pVGCjd+xeHbVhgN/pYgaN9nFU+qo9new9YFhZeuY5oLb7MuJ5Wk/h5kmU9oPHAAFRIXV7vUTLcparGzG3YadjHFlfG4uA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(26005)(2616005)(107886003)(47076005)(186003)(1076003)(336012)(426003)(82310400005)(316002)(54906003)(70206006)(70586007)(36756003)(478600001)(40480700001)(110136005)(83380400001)(40460700003)(356005)(7636003)(36860700001)(2906002)(86362001)(8676002)(82740400003)(41300700001)(4744005)(5660300002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 09:38:36.4000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d77cfc8-c249-4c01-31ec-08daaf5a3312
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi/Jason,

These small patches add safety checks and simplify the code.
Please consider including them in the next merge window.

Max Gurtovoy (2):
  IB/iser: add safety checks for state_mutex lock
  IB/iser: open code iser_disconnected_handler

Sergey Gorenko (1):
  IB/iser: open code iser_conn_state_comp_exch

 drivers/infiniband/ulp/iser/iser_verbs.c | 67 ++++++++++--------------
 1 file changed, 29 insertions(+), 38 deletions(-)

-- 
2.18.1

