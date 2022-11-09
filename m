Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51845622C5D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Nov 2022 14:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKIN26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Nov 2022 08:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKIN25 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Nov 2022 08:28:57 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC1140AD
        for <linux-rdma@vger.kernel.org>; Wed,  9 Nov 2022 05:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjqDh+rd0imeCJN496g+pDIScE3ExWzRhs5k9aQ2ZfVAMPGs8O7bj8OJqes1DJC6Oews6yzd+YqsRPuSNhKGwfrVFPpFsNOaTa3R7Ux8KRcIS+QSAPGqNN50FOxV2rRc/T9BAyTaGqo0+WWK/bt2sdPa1nsn9wWGV302egRSSCAYwndpiULayGO2+t9GhMd5GKik4+Pb/apR0CytrA6TtrBdxcbcwM27lyzZyRP9u49Kjbupx2kWjw0k9vXQtL6ZQG1CoU9T9+Mg3UcVkAhVJiAVHvv0xcQSzCmL2dPb0oqLQ9nUnnUJ7JpUy19o8H/auE0x63ocJTSMyXLpuPgp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUqFPGEv2QWv4sQVg2p00KzVhJj2xxRmMOOoP1BCKr0=;
 b=Frbon0PDWz1xnswSXWkf1PQu9PlCtsNk4yPHhPNloQXtYWp9uUhcb6VFxMe9cyw7TDODLhqnN6bHcCHLVAuQ9S+Uk6GAtY4+Gru8SNn7A1ZlQOBv9pe49fgiYnRa5rB6LcBvSrAfvv3xcEbc3yZCXVg0Z6v9lDXrIvp4ek7hznwDJxIoQxxwD1vQD7pmsrJ24abKTr1LC1k8Ky03hw3jHCbmAvhXkpk+evZLMklAB4ixWP2NLR7wP5rMGfNm8mtcCaxqsE/KrqVcjo7evIU7JQ2ic2ibCPqsa4JNRzym/ucacwXT8+UAUoGTPqiF2s8zhilUFebCUn/jKDBz1AacEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=zurich.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUqFPGEv2QWv4sQVg2p00KzVhJj2xxRmMOOoP1BCKr0=;
 b=eS+1UMK6Tlp3F69RwhlPnn9x2KTc1KGVW27dlDYAmnRcVvDuYHAi0ZsHSM44JPwqAJTmvyvni7eZVwE3DCa9P1Saww4SmxGzMxe3TBf1iLT+6t9VWBFESjItduqpyoPi+TqGnqr5PFPPfBMQSiYxpxerUpVq4x/VCRY+CBIUto2qzt2seUs0gP0XpgVTOo8yeBtO4s1mAUWVU0//FqnPgpqILszSUef/f3xA8SLfh6VLejEootoadFNoCqocwTQriK4+rdoM1dI87UY1qM/2D3MglsAJ8Sxoa0YDjcoyLEBOXE0vkqUgPM8KcFPT4PiD/vYjyoTZnq2jC318JqcDjw==
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 13:28:54 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::82) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Wed, 9 Nov 2022 13:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 13:28:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 05:28:46 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 9 Nov 2022
 05:28:45 -0800
Date:   Wed, 9 Nov 2022 15:28:41 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v3] RDMA/siw: Fix immediate work request flush to
 completion queue.
Message-ID: <Y2urCSWTEpRmBddD@unreal>
References: <20221107145057.895747-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221107145057.895747-1-bmt@zurich.ibm.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: db369e65-4d77-469b-efb0-08dac256590f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3nfjRUcUT5T67OThGbRcZ0Y7lm9A0U6cwjeUxQGjTQx2OTlmbPyzrF4q8RBss372DYc+gIgUZ7OdiRmw9Eie3LU1Br0IQD0Hbnv4F+a1HiPLQK7GVHPdMiAdE+OPpD5AbMmOFLcwKY3yxC9aIcTR1qCxdMEou2E6qDPtq3rMyrfpiQRN51CSnEyZbDUyb6KKq4mF6TpJAWt0i6felzmRAyaNuXjqsMgQQyuWWA1sbZbmiy9nftPUByLA2OCLhJvuA/Op8KQHopL3g1uX0E1bFR3XTqAae1p/MHCtJTMHCqflvawNx/bJLTVR0cDEk+d9oUxL7ZnZaey/BI66vgyRI9hAldjb0X/gYFOPkp3QuRIvPlxK0JfiOYjrolRdbe+7arD0H7ciApUuiiByOF02i1PbZDlwK7M9QI35KF63y2NZ+VYLmSmWuAJWGjG1K07TdNJvVEThbRO4FvGFS2CWoxqFEJtIbdubSiBiVg7L2/y53ZA2GM3uYBwDiKDtXCENJnV58mhzQGH5vD7kiCaN3dmP31EkTOhMYgai2qH2YvbXRTMjDWUkTmoPtorUjdra4BOQDrmmey+DFl44/eWVz7YZ8MusxrJ2cBQZWiDleNDK80fNHpofVyhMZqTlNMNuWECy2NDtqRUGLVzChp5o0x3Qp/oar4eHtWB+z0Ls1ybgZGBPjPXf2FvKbfEh9KaBuVArQ89dTMVSEsiSKyQiGI5S+eRm35q4N56clNBRDYPu/8nsokebyob5NWnfdDjTqz0vEHN7FoO4p6tMT87xYffNfgxJaL/nXIZ2FCUojo=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(83380400001)(86362001)(33716001)(70586007)(82310400005)(7636003)(16526019)(356005)(478600001)(8936002)(5660300002)(6916009)(70206006)(4326008)(40480700001)(8676002)(41300700001)(316002)(54906003)(9686003)(47076005)(426003)(2906002)(336012)(6666004)(186003)(26005)(40460700003)(36860700001)(14773001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:28:54.2132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db369e65-4d77-469b-efb0-08dac256590f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 07, 2022 at 03:50:57PM +0100, Bernard Metzler wrote:
> Correctly set send queue element opcode during immediate work request
> flushing in post sendqueue operation, if the QP is in ERROR state.
> An undefined ocode value results in out-of-bounds access to an array
> for mapping the opcode between siw internal and RDMA core representation
> in work completion generation. It resulted in a KASAN BUG report
> of type 'global-out-of-bounds' during NFSoRDMA testing.
> 
> This patch further fixes a potential case of a malicious user which may
> write undefined values for completion queue elements status or opcode,
> if the CQ is memory mapped to user land. It avoids the same out-of-bounds
> access to arrays for status and opcode mapping as described above.
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
> Reported-by: Olga Kornievskaia <kolga@netapp.com>
> Reviewed-by: Tom Talpey <tom@talpey.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>

Please don't add dot at the end of the title. I fixed it locally.

Thanks
