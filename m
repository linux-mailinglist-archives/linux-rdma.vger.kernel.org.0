Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69DC6DB0F2
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Apr 2023 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjDGQwp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Apr 2023 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDGQwo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Apr 2023 12:52:44 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2099.outbound.protection.outlook.com [40.107.100.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857555AE
        for <linux-rdma@vger.kernel.org>; Fri,  7 Apr 2023 09:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfuFdZobBQ0LB9b4Qboop7Wr9IjoaCheQO+caYceSe2HU7rkdVrL62vlZZlEi7b1mOPv3Dwb3Uy97GtyZjf8RVJeTaIpKYawdSSt2cxx5dnRoUVZZmI3hDjv9Y9IGeecHPCRjNzGu0rpIOb8/Rc3Sm4fvugQ+LRKNR6tycBaSZbcKbb2HLMpK84D3Me4vhzwC1i0rbzd1LX71IHKa3z+TjVnuzA9wcYlwxkFQEy3zo6AMx8AVqb9LTsBvFhmrSFlyWAJkj4VDS31v8CV1daockbdgMeKoSS4FiN/SZHkAdtc6FmrlK6Hg3w44tuahnSUa7ZHzPEgBvxJ1B7oPkONgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF4ZhfCr12Z/bU8C2WGNuQrPMXUj6+/zwBjrkUskj1k=;
 b=evtcjWRw6X9BX/zxu466bQgwBc+bc5yAJ/pZf+GAqEGCEcodtscEQ4jn6ceL/TmYS3Pjw+IP7lQ2AqvcTpDoZSrMwelhbqb1bGvY7VVCBgZT5dWyY0ZlUAn09AZqVD0KL9REuX6zbE8m1JVchC7CyKTvzUm6hQp2Coh2CASESxSw968z7XfeZbDe8AYyrs0HOuY7hxQtf7IqjUjVu/8yECAnIMvVJNV0izvrQHVQnZ7pdtifdf2imCOOYBqba0L6bK3h7uFBXwmZ7zfhN1bii5NQ3kOSZDr72V3ewKsIFieg/Y0xXFExbv0KT6zKnUF4LPlnJeUwqghHpJX8/h2yaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF4ZhfCr12Z/bU8C2WGNuQrPMXUj6+/zwBjrkUskj1k=;
 b=aV4wVbFDvDqA+oRN5BV9/EbuuAjnhO3mAVqbI+2s6CcI9bcdglfqpAhLCzLannG5eKr3yrLtw2dAqoSACrEAY4ZIMSQKVpT1+Kq7qR/k+2lYYhDwgZda5DghfUkXE56KK+2VTwpcEyyaLBaH1JOFkRAKoW8r458RU5x+LS/TOvSFfSqD7VSJHOaqcU14Gp083pPcMJqk1e6zVyJURweiDCzNgapDF5oR8onCdbTBhqKHztxrtb+swgCg6UtXk5yB8YF7wNyoSv38eWdmcIBccl38h545HHCQoPmfUnm2cb9uuFcRf/n7iS+bgA67hF7yUv7lu9ObFp6owE26PlQc0Q==
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 BL0PR0102MB3492.prod.exchangelabs.com (2603:10b6:207:1e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.18; Fri, 7 Apr 2023 16:52:35 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::b) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.20 via Frontend
 Transport; Fri, 7 Apr 2023 16:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31 via Frontend Transport; Fri, 7 Apr 2023 16:52:35 +0000
Received: from 252.162.96.66.static.eigbox.net (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 337GqYBa3027384;
        Fri, 7 Apr 2023 12:52:34 -0400
Subject: [PATCH for-next 2/5] IB/hfi1: Suppress useless compiler warnings
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 07 Apr 2023 12:52:34 -0400
Message-ID: <168088635415.3027109.5711716700328939402.stgit@252.162.96.66.static.eigbox.net>
In-Reply-To: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
References: <168088607365.3027109.2194306496858796762.stgit@252.162.96.66.static.eigbox.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|BL0PR0102MB3492:EE_
X-MS-Office365-Filtering-Correlation-Id: 1068add4-1f08-4191-6093-08db37887cc2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9S9KGaB0FI0XeG97TeoIwJfDWqUM0EKPfz/7Mtie/2DVyePgwoUrO7s1aaUMM7YUUq7IGrflnvp4ASCaz5dH30ZkJutjsjCzhDy/lsgUVQ9D4OHM8Oy6Z7nkKGePumivwrl0q7U8U98qXJFvglz4DCmdQRcDus7urc905WmpCY6icKnTjWEloQvVNzz9MP8/g0q7cf5Ca7S1YmQ+enzy3/YHV8eS4Iwxz6+/CjjPtsWwjZHte5dZv6rD9WSUIIUTyHZes/ERNE/jPlO0+61gWkX/DCSCh0eWCTMe0wWvH/5hr3yil/0LGJaDyruSxullWHr35tuG0fCs9NJ0f1GgWx1To/wDrAK97jC7J5cmSp2/+wE8qEYb7G1upt5FRieJI/WFUsozU2hBfPGsovDY6nuqdHtZiO/eGw61db4vrjItNUJvQv8QTardLP0rRgBEHEUPxPSs+w9nP6QZw9l3OxuUQPHvpATijmmo4OS5tKIIj+PivDVqMry14LP6iePaw89CaEaiYBJ0fMliPBrqNTjuv0SvVnjLedi8rD25K3rsj55Ar36BC2O8KF0Oq9kHOj1vuZ0tpKyrQVsblPZNPuyNdnzh44TcfaGSoygP3siWksgOIUvRTWUeYtrg4AzJN+CPJHLYiDoiG4Vi/DiElUeRMHPzSK/Ne4GIF1G4tLUKPLKypatSmW5ERWyq7uz3QuRl5zdR3vDF9sjO3tuJy2vHmZviOxvBx4Q0cqet42cLJ+1AGXpxbsPNi/QvLt9bFwQue9sLbYXDsSfXd0+W9Q==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39840400004)(451199021)(46966006)(36840700001)(44832011)(2906002)(103116003)(41300700001)(316002)(40480700001)(55016003)(4326008)(5660300002)(8676002)(8936002)(83380400001)(47076005)(70586007)(86362001)(70206006)(7696005)(36860700001)(9686003)(26005)(186003)(7126003)(426003)(336012)(478600001)(82310400005)(356005)(81166007)(9916002)(24686002)(36900700001)(102196002);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 16:52:35.0156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1068add4-1f08-4191-6093-08db37887cc2
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3492
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>

These warnings can cause build failure:

In file included from ./include/trace/define_trace.h:102,
                 from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                 from drivers/infiniband/hw/hfi1/trace.h:15,
                 from drivers/infiniband/hw/hfi1/trace.c:6:
drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘trace_event_get_offsets_hfi1_trace_template’:
./include/trace/trace_events.h:261:9: warning: function ‘trace_event_get_offsets_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  struct trace_event_raw_##call __maybe_unused *entry;  \
         ^~~~~~~~~~~~~~~~
drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 ^~~~~~~~~~~~~~~~~~~
In file included from ./include/trace/define_trace.h:102,
                 from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                 from drivers/infiniband/hw/hfi1/trace.h:15,
                 from drivers/infiniband/hw/hfi1/trace.c:6:
drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘trace_event_raw_event_hfi1_trace_template’:
./include/trace/trace_events.h:386:9: warning: function ‘trace_event_raw_event_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  struct trace_event_raw_##call *entry;    \
         ^~~~~~~~~~~~~~~~
drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 ^~~~~~~~~~~~~~~~~~~
In file included from ./include/trace/define_trace.h:103,
                 from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                 from drivers/infiniband/hw/hfi1/trace.h:15,
                 from drivers/infiniband/hw/hfi1/trace.c:6:
drivers/infiniband/hw/hfi1/./trace_dbg.h: In function ‘perf_trace_hfi1_trace_template’:
./include/trace/perf.h:70:9: warning: function ‘perf_trace_hfi1_trace_template’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
  struct hlist_head *head;     \
         ^~~~~~~~~~
drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 ^~~~~~~~~~~~~~~~~~~

Solution adapted here is similar to the one in fbbc95a49d5b0

Signed-off-by: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/trace_dbg.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
index 582b6f68df3d..489395bfb5b3 100644
--- a/drivers/infiniband/hw/hfi1/trace_dbg.h
+++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
@@ -22,6 +22,11 @@
 
 #define MAX_MSG_LEN 512
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 DECLARE_EVENT_CLASS(hfi1_trace_template,
 		    TP_PROTO(const char *function, struct va_format *vaf),
 		    TP_ARGS(function, vaf),
@@ -36,6 +41,8 @@ DECLARE_EVENT_CLASS(hfi1_trace_template,
 			      __get_str(msg))
 );
 
+#pragma GCC diagnostic pop
+
 /*
  * It may be nice to macroize the __hfi1_trace but the va_* stuff requires an
  * actual function to work and can not be in a macro.


