Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D55662CC4
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 18:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjAIRbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 12:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbjAIRbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 12:31:18 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2103.outbound.protection.outlook.com [40.107.212.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52BCB49B
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 09:31:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3EKVU0WYvABoft4cju/pES2Fe/14xQui++u94deNPpnppyH0DCuQ+NK+EanALmnoGYXJND3d7bqorGaLiTvO2UF7hVcwnCcTPtms1UrAwxnWAaEG1SffU5rnQ8XTjFViBPzANYwTv6h0CRaH7J81lqpgt8FNK8yO0lSPizE3QMitXFUEZVferORq5lG9XmLWp7NhCHB9fkG/MY0r37fZaKoaWNq87bihjosad7uFu79ZJNl3DjqU31JgPRk8NoR+HnRFFSDobXfF5yaMSNw1cJNJDrnP4icjr2H40QeMgV/W+xeoM8Zykei1zlkWTfipgH1YirE5py/qJSAOjwyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFJpYq6cFe0lennKHhnvl7QmBXl65JBFhj72jIEBCzw=;
 b=LeUWEOcizjfL+09On8rDXGCbT5YTUr6SuWiyI6ufrN3xEh/N/tOO+JTanSyCo5Qh6wXSk4RbNKKeC+r2WiMs7QHr/NING4iBd/aRhC4X8Drc20tNsaIFAdkvkUJTR9NYKWMNPY6MvwBA1OauMkWnTHu/xJAk6lL+zvnLfXFaWj6I+ja7cjhp9gWflDpxKN9g5WGmVhh0uYNvFb2cRGgOjgl0cfpNvE2z0sB2KpAD312vEiVrxn6/Rf7y10qMAgm5PZR8Evy4cdbsQLQO1VwANjkdKPISSJ9hq5lJr8m3ZEAxFNFYLXXZDZUV/HfSAfy9afdZlbGWUhtuestjIW6D0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFJpYq6cFe0lennKHhnvl7QmBXl65JBFhj72jIEBCzw=;
 b=Io+LpouGYaG43hBuhQeUk8VC+7/Gl3e0JgxtzVUC3HQd4lkLqnBCCFFFOpoMhe3MYfYkSVnIdNrT0qMjFDpVwzntUVUABPYYx1dYNcBSIgjjbdNO/YaA9z4fse7BG20hErdSOlEztd/bfrhmM8KiFa/KAbqAy4H4l+TCnAWvpCRcFYlt3Il049g7rN1KaGnryAlQq6GVCwmji7IDwubOCmVK0BsqhKh0qczuVqZyG9FXbV5wgR/l0zbPwdAQpkbpC60FLyxGy5qAWKOL3mYpAuuuLjCJY8pKVYHA0Uh8PLFDR5Gd6P6fF45m9Etc6i8V+0uRl6D7KMlmKjy/PaDOkg==
Received: from DM6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:5:1e0::24)
 by DM4PR01MB7690.prod.exchangelabs.com (2603:10b6:8:65::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 17:31:03 +0000
Received: from DS1PEPF0000E651.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::39) by DM6PR08CA0050.outlook.office365.com
 (2603:10b6:5:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 17:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DS1PEPF0000E651.mail.protection.outlook.com (10.167.18.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Mon, 9 Jan 2023 17:31:01 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309HV0MV1472568;
        Mon, 9 Jan 2023 12:31:00 -0500
Subject: [PATCH for-rc 0/6] HFI fixups around expected recv
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 12:31:00 -0500
Message-ID: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E651:EE_|DM4PR01MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: df5e554b-5989-49b5-c147-08daf267478c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbwW+OvGV5DRlO4B8i5dAZucCORa4EqPLpYHcch+zwCC4rp98MeO4MPzHicglNlurDbz7nsUsgRFy/X3XzvI+8SsUBzZw+ZzvHvHLUep7Ix9OHdXah++4NLemBgeYMxZpI0xPtd390haLNuSNQg9H56Z2fPyb5yEham4dXzp6U/fel4EnMy13ZcZ1BxrWo13psmXR5SBemUDVrpXofmEwqfgCYbjPvxxD6ALdrtvHBELiiUj7s+XQqvp/NFNKAQLVCQMZ/QT4xxja2386pIJtcd1V0LWMtnxsonaTFg+IXfEiaEHK3aJg+fUTm98hl+K0SuoVYoMdUNXMHrtaoPCB++TGEZ6FASc+pmnqUWio3nTrupO50OxOYr13N0GeIYUiWM1R9k/ntwFzSmnGbC7BdiVhKa4QzE/CHlDy7ld9bCDEJeJKU6ZykUCXAYZTgvMN2W7WpdJQZQEQDxTKUqnLqleheyw85kP1axyAo+bNiatFmIQUYBqqcFInSZO7sLrYrs7l9Ptf85JC5crDajLfRaqfidSoGj+r4ZgfL8WS8DctaV4sNoRuXuKL5RZXe7KvT3d+Of1ka8q6U2t3RGcN2d+DBOc7nkv3aqyfwsFQEHGDU+hoVQyMHYV76FC1UDtgKHPsaqB8X4Rrsa4vxGJgrWaTbdttHZ2uDjT7UMgW7H+wE00ooNhf8bdFyjTWrHz55yaKwCfaXueuHIt7zVwUQ==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39840400004)(451199015)(46966006)(36840700001)(47076005)(426003)(83380400001)(36860700001)(81166007)(103116003)(2906002)(356005)(44832011)(41300700001)(8936002)(4744005)(5660300002)(82310400005)(55016003)(40480700001)(186003)(8676002)(7126003)(478600001)(336012)(26005)(4326008)(316002)(70586007)(7696005)(70206006)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 17:31:01.9962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5e554b-5989-49b5-c147-08daf267478c
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E651.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While working on a FIXME for next cycle Dean found some other issues that we
should probably try to get in for RC. Mostly in the error/teardown case but this
also has a change to reserve expected TIDs which is the more correc behavior and
enables the follow on patches for the FIXME.

---

Dean Luick (6):
      IB/hfi1: Restore allocated resources on failed copyout
      IB/hfi1: Reject a zero-length user expected buffer
      IB/hfi1: Reserve user expected TIDs
      IB/hfi1: Fix expected receive setup error exit issues
      IB/hfi1: Immediately remove invalid memory from hardware
      IB/hfi1: Remove user expected buffer invalidate race


 drivers/infiniband/hw/hfi1/file_ops.c     |   5 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 200 +++++++++++++++-------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h |   3 +
 3 files changed, 147 insertions(+), 61 deletions(-)

--
-Denny

