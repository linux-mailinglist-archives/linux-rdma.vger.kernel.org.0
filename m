Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0318476D57D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 19:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjHBRfi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Aug 2023 13:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHBRfW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Aug 2023 13:35:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AFA49DB
        for <linux-rdma@vger.kernel.org>; Wed,  2 Aug 2023 10:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0gw9TMLuUBS8MvAPTg5TZJ9PHfdJnlTxaOaM8ayG4PKc72aKQ2qV0wyDPu+kKD+CXaQgfQ6mCiVZjpV63Pb98jAuErKZAtaflWmVEHtOHdxWOmBxs2Z279JsGwvOhHV45ieTzFCbI3hO0GBlr+a0tD16FEaJ6Ygc0HQp0dn2f5aGCML/+R6dXgIU5w2V+tLxlToN5sACkPe0lUJ/rqDNk0+84L0P/by4q7LAywUoyS1w5ApBplhk3aHUQgBQOe1wj2Uit6Elk4aEXWqm9PNO7w1lO8h0Q5kvslGoKjU1FE9RUMrVpSHf8sN7g7AdQ9dthSaWu8r/BM0F+oLqQMelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28GpwwHD3vWQfVKFAOSdUtgCf04uSItbdGDyUTNFLfU=;
 b=Fstlm2sdMWE+yj+pTLPQGk6hRDYMTyOwZsSOm6o3Ecc4eIstGx5yvJgUWVFzchA/mUpzwI2gt1pp9gKVms3rSCF4sO5NJxkC1IQtgqnsToxvY5YX9O27lmf1x7WoyJQGAxOt1iwfnWGPUI0Mmd1d9gQl5qbHD+Ek1us+0MkcBH5Jm9NAvwZtTotzxdEDdTBqx3qJAtt+E/3JF1zBwnVe2KLXhu9NC1ETKKOgfQP/8nmJdacYBZME4tdR4TcuCNA80M/sK5zH1i+j9edXB5+J6nenXLICHmip6JI6rJA9kkdXTkbNdwGI47MjxvNsnxTjWQCpjyh3BC4uQrXEZ3L7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28GpwwHD3vWQfVKFAOSdUtgCf04uSItbdGDyUTNFLfU=;
 b=AwvTwA9Cs7UYFpmocuse84PEi4/T5TRqgnsDtMj9UqhJi+ev/HrGYy91BMf53VLl9651tq2WOwVxSSyJmMEjXCX/jy4YiVoYfRuzjluyuFaYtHZW6fIzZpmhflH3rY2ixrB26fEhaPkfF2u3ZYRFtQC6pRp712P27xY2HsGuh6j0zv+bSInN5VUt1DVUbJEL/i0QHlHtV1ZJpHxbgOD0msRKIFrrrLoqpE7RurIMhvTfoVYT0jcxF9PQ+Be/SA3+FHs2O6L8hP3OvUcVbw/8TRd5xbjYR5GPbH4GVdpIn7xDEAfCSJ55iDWY8MfWOhlAFaeNb4r6A4Ue3GyyOIFMZw==
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by DS0PR01MB7913.prod.exchangelabs.com (2603:10b6:8:14b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.40; Wed, 2 Aug 2023 17:32:43 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::71) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.10 via Frontend
 Transport; Wed, 2 Aug 2023 17:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 17:32:42 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 372HWfL83927210;
        Wed, 2 Aug 2023 13:32:41 -0400
Subject: [PATCH for-rc] IB/hfi1: Fix possible panic during hotplug remove
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Douglas Miller <doug.miller@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Wed, 02 Aug 2023 13:32:41 -0400
Message-ID: <169099756100.3927190.15284930454106475280.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS0PR01MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ca1363-c328-4e9c-7e45-08db937e7a17
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mPJZ2eztB6k4M/8S2kJjl7CMoR5uHloJTU1f6AQFFYGlLwemiZBVge+8/T/WIkbIDBbn7Z2X9o2P+Nsf/OtcP5SLdsTqeY1D5cB/tN+xyx+k7LN/m9kwcIu0AcPVcZ8neJerEI+z0YEWq1zwYMecRks6/W789Omae4x0qq+bSyQuHr9sF85jDoaRCfrV44nw/Rn14n6eOVmld2wSRPuvNpOKhTbpP7ZQIzvGYlnAOTYb1pwu8sk8/55kW+YLHSaEh3IFHzGB2/j2ajdRaEXIBNGBp7CJxJOIHo/dVlGEDFSpoGH0BMC3ybZXK/FyzSsFElN5vkWX1VxpEQI5M2hSbQGT6tlCAbJSnkSbeCYuteXSL6TkPvXV1KVPW3TpmwSMpNiefWFBi3wYDkrdSuyfZ9eo8lO5FnLqxH2JjIZlPBTITrRZeRVUZsSb4mG6p0Ty80Tn+hb9+xhTXYlO5PvSA3doefnDIGo62KpqAafIppSW+y/Q/4vY84Xx8G32QSW4zDg4AWVrt7mW0Ywc9s0Va9bqu/mGUEaKPBNjOTl79rtmMNC84vQ/Ro/iOtt+jDc5x3bLtto2kLDG/0KfNCt3Dm1xEr9LLwQq/HsPjaNG+GGkKowA31zP8O4ZrTe0W/iHxqobHRSxbjP6C7P42cbc4tK5KLTBb9Cv2gKTlqjsXa3Po+eY/rlyAHapkztBnyxKMH+DGZJAetcWxY7aA8TtCVX60qcoP+9Y9yP6Qu+ZXo=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(376002)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(70206006)(5660300002)(70586007)(44832011)(41300700001)(2906002)(316002)(4326008)(7696005)(8936002)(186003)(26005)(336012)(8676002)(7126003)(83380400001)(426003)(36860700001)(47076005)(356005)(81166007)(478600001)(103116003)(40480700001)(55016003)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:32:42.3923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ca1363-c328-4e9c-7e45-08db937e7a17
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB7913
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Douglas Miller <doug.miller@cornelisnetworks.com>

During hotplug remove it is possible that the update counters work
might be pending, and may run after memory has been freed.
Cancel the update counters work before freeing memory.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/chip.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 9dbb89e9f4af..baaa4406d5e6 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -12307,6 +12307,7 @@ static void free_cntrs(struct hfi1_devdata *dd)
 
 	if (dd->synth_stats_timer.function)
 		del_timer_sync(&dd->synth_stats_timer);
+	cancel_work_sync(&dd->update_cntr_work);
 	ppd = (struct hfi1_pportdata *)(dd + 1);
 	for (i = 0; i < dd->num_pports; i++, ppd++) {
 		kfree(ppd->cntrs);


