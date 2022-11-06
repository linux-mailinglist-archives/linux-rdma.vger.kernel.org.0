Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3261E565
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Nov 2022 19:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKFSxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Nov 2022 13:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKFSxj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Nov 2022 13:53:39 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F39962CA
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 10:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldnnD8o2i9arVpD06JhUL+1A+arAoaHojvSzU+3exjcFZzvPIF3C3idtDqWM298FswS5AZUQenjnbQWg15MuJm7TM8N0Z4gJtqKLWvP3c6xoAMTcCKhKQ4/kX6yT4pjJLhzhS9zaPctlrtsIyG9emEj6P7oNpCD0ecLNCXIZ9YyOq2m0tgFFeEIrtubyZaXjmrUq00lw086xjB+pPq0esopUMcl16QN6anSJn+8wLE+WpupwxmYum8n1sAumSyWqS20Rnb7+kK7dV5fZn9jNfA28ccarJJ/+FzBX/Ver3fj3R9Agr+GX52fMIZXE6Oc0wGJvMjVAgfwXn4kZRXQmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRKOvlO10t2FNxE+9lGX8cm7IBgZ3PU9fOHZLpHNHfQ=;
 b=GKV++9ceJYie6CSOhhyuGZGrafILHjNbUn6GR+RylfdfSto9ze50D0ZYJludWtRnJnBq5dzstM48Gf/U8xYoWCMC/hrAteK889NhiH9GHlZJQQOt6mWvlvFG+4raf+ksjOEnIsXq9xA18pX76DfqlAwSZ76u+pviz0OVVg46nBJ2HTVoUH1HH4gP5973U0TfBhznnJ32bSTkhffMGOUFddo+MIx4Uwhe18N/Xnwu1Bm2pSjnvIqvc0XSwZsphcFcSdo5d35ye+GdGKviiskZwfQej7v1RvWhXNCMZ9vpYebJosm0YJaSEl596zQpQL0jrBBl3A+zFmGwwvZfzIkbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=zurich.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRKOvlO10t2FNxE+9lGX8cm7IBgZ3PU9fOHZLpHNHfQ=;
 b=UCXIzawQraaRve2+KD8/jFyTRFG2oCOhmCVuk76gVKxzv60ZK151lCl70ZRn0yrFHoPDV2+EtnLifFyikhzkQXRXuwZC8bsnTYvnQ4X6PemZFmVp7WJYLWLEvuo3cZ5xCiITAa1mbgiYcvKV8WVTaoTgPpR5NxK9ZyrfJjZmpJmAc5BV1tz6YigZ/uhXZ45GXlf84MR3fpqFfxsL/nixZ3m+UPx5BDoTXTYNCMfUqO4qS2PJQk+slI1+qwD5zxX4BlFtm9Avca8AeWOTiI8cYdqbJLNPKDpWYUorq4nTmyB92KneHOVgw5x4jQlHvYlZbJ1mw74zpXVSZbtFGH4/jA==
Received: from BN9PR03CA0952.namprd03.prod.outlook.com (2603:10b6:408:108::27)
 by BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Sun, 6 Nov
 2022 18:53:36 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::46) by BN9PR03CA0952.outlook.office365.com
 (2603:10b6:408:108::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Sun, 6 Nov 2022 18:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Sun, 6 Nov 2022 18:53:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 6 Nov 2022
 10:53:30 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 6 Nov 2022
 10:53:29 -0800
Date:   Sun, 6 Nov 2022 20:53:26 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v2] RDMA/siw: Fix immediate work request flush to
 completion queue.
Message-ID: <Y2gCph5bw1y9zCzF@unreal>
References: <20221102093110.661109-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221102093110.661109-1-bmt@zurich.ibm.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|BL0PR12MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd74f18-32e0-4b02-c544-08dac0283619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0k2HfQ9Gr1ITjYhkW6H3WEvUz5XlPslbMnwJRajKvx5HQWUhBbpTj9I52LKHzgnViabQ/Ru/9m7tQpoDsg3KGx2dv7vyZdlMQ6/92yb6htASKBpm1tkG5VNXYnayj908cSESWiJWxxyTLPXIkUywbodyW8W+m0yVlLtXYnAfAT1VCtEHWzEhDLuyfSedha290s2M5/kqWCsTbt8CBwDk6N01irM9VjtFATrez0uxDhOFMQvIMVUYX/rf/QvOqAsZpixrR+KXZHtsXZUyptVWceaHwwQhUQMaJYWowNMW5qIf5O6ckKNcuqxN05Q4ojsavUd+o8/LTuCG4//uLY6MZURNsu2MUet9wfYjgSouSskmv38ZyQuKfWte5FEJF3dL59qZdk9Y++kfv+fSGTzmdcsY/tHRpzcWzYwC3dS1yLCh7Mpf57IqcMtyKKUaUmmoSI69rg20Iajft9hw406oRhPIjtTt9quo/hJLPkvPPzEmfcsmOAO3cX1Pxa9XNg/7I2rvygvWHleDkz6F3fqGt8jY62FX/n21TVh4v8/L+oiyHH4rkYZ5hOs8CNkEBlMr9H8pP40BKq/a0hc/41XnHMQBO/cgRHUjbLhaCYdSEWmq1nHD9JdJ7ALyCTdQAYN3XbCRSj1SSM45NZxSrVEHCJWV6w9hdJAnvaHJQnUBQ7Vz6bKjtUTqJ+NoiSDidDE414jVdl612ck7qvq2VfUNMHwZz95orAGPjUnMkgw/zIl27a2VmCoePsGdQ3uSsOlAhKLat5zo8xxJ5Cg2yaDF8gomuN0wR3PZLiIr2EqEsQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39850400004)(136003)(396003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(478600001)(41300700001)(8936002)(70586007)(8676002)(4326008)(70206006)(2906002)(5660300002)(40480700001)(54906003)(6916009)(316002)(7636003)(356005)(83380400001)(36860700001)(82740400003)(6666004)(86362001)(40460700003)(336012)(16526019)(186003)(47076005)(426003)(9686003)(26005)(33716001)(82310400005)(14773001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2022 18:53:36.3042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd74f18-32e0-4b02-c544-08dac0283619
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 02, 2022 at 10:31:10AM +0100, Bernard Metzler wrote:
> Correctly set send queue element opcode during immediate work request
> flushing in post sendqueue operation, if the QP is in ERROR state.
> An undefined ocode value results in out-of-bounds access to an array
> for mapping the opcode between siw internal and RDMA core representation
> in work completion generation. It resulted in a KASAN BUG report
> of type 'global-out-of-bounds' during NFSoRDMA testing.
> This patch further fixes a potential case of a malicious user which may
> write undefined values for completion queue elements status or opcode,
> if the CQ is memory mapped to user land. It avoids the same out-of-bounds
> access to arrays for status and opcode mapping as described above.

Please split commit message to paragraphs.

> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
> 

No blank line here

> Reported-by: Olga Kornievskaia <kolga@netapp.com>
> Reviewed-by: Tom Talpey <tom@talpey.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> 
> ----

It should be "---" and not "----" for git to trim changelog.

> v1 -> v2:
> 	Change return code of siw_sq_flush_wr() to -EINVAL
> 	for unexpected opcodes.
> 
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>

Another SOB.

> ---
>  drivers/infiniband/sw/siw/siw_cq.c    | 24 ++++++++++++++--
>  drivers/infiniband/sw/siw/siw_verbs.c | 40 ++++++++++++++++++++++++---
>  2 files changed, 58 insertions(+), 6 deletions(-)

Thanks
