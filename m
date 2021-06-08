Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1839F478
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhFHLCn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 07:02:43 -0400
Received: from mail-dm3nam07on2042.outbound.protection.outlook.com ([40.107.95.42]:20225
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230522AbhFHLCn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 07:02:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJcYiEHVdsHFGgNZL5iiQ+so5/3BB1Hrza7I3T05jPwHgoam9S6Ttvs0jgdckoEDH44UPouhAA4pRQ5BgJqstVVP2QxSXDnlPqNRQSm2xAE947fci615UPuLCpcTBhHAYgbUYw3REUizi3S0pswoRxADyWTGleESGfKwYUENjNrqDAmdxoiSPDFngKDjg8pLUMWAnuIvPIqVLyTakDe6s3jo8KDF6P1NczYdyqT2vi7iJipRm7YctgWJoB2r1JarTaDQOLKeycGVB+Ifn3oHLxw1X3HtNety9CNl7GV0jjYw0tIe/cIVD7rJ5tEGHQ8/TvecWeRmszTag6CkibfGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sJeZwduu48VXOW4CjUL7pMJT0nHatPbo0aFYoBnQPs=;
 b=Qt3gkpl4ckRjUahlEYZILIw13cwHuNKY7XoxKygRM95HPjjXZszYfmO7sUJt9ZOg+QvpP1gJvVECq7LOpIiN7OGAox293pLCw8Iwn8WGkNqDVd/b5pBP0FqhqurdKYqFA1Y639qm8oLnSalN5qujPAP1kdF+ZKoq1UG1JoG4kYwbPLJ2IGUYGhHLF6Lq6Il7WM0a0S9Xz1LGo/Ik+t44t/em5tvhW8KgUfroKpTZKxpCBM34bHraK58xMe2r3oeolcTlLjG8fpCoUu67E9VI8uGbUyfM69GSdQ1WXBby6vzoaSkGMuIxiPYF2ug0P/xG0NYPcA0VzBAdb3HnrOG/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sJeZwduu48VXOW4CjUL7pMJT0nHatPbo0aFYoBnQPs=;
 b=EHEDLXTFT/hy2kdspPhQgzIu124f+d4U1QWEk74CYpqE7Zh4yPncWL7mPr47sz7k6cy0a/6o/NgaFke+dJhMDR49CZI6bwlUf16IgEyKpiRqcRI94V60wDdvwgnBIVvEzuVWXagdg6c39ulIXsSDOfpQu1H1GJAccd+N6i9pwOVctDd96WGDBHvbVcg6w51fbls5pZg36vY8Vmqe4cw6YXMa3qeIuzH4u8MTLwz0wvfz0KucxUFTpcYg1Sxqsc67XTPjuycSWCLvDphtLtwedkFnXN5v3l7sORXscoap5gali+rlDVFfp4H/QQuXAIb8tRmrO1NjAaWDdT2KUUCOjw==
Received: from DM5PR12CA0064.namprd12.prod.outlook.com (2603:10b6:3:103::26)
 by DM5PR12MB1914.namprd12.prod.outlook.com (2603:10b6:3:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 11:00:49 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::f0) by DM5PR12CA0064.outlook.office365.com
 (2603:10b6:3:103::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 11:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 11:00:49 +0000
Received: from [10.222.163.45] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 11:00:47 +0000
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Kamal Heib <kheib@redhat.com>
CC:     <israelr@nvidia.com>, <alaa@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>, <linux-rdma@vger.kernel.org>,
        <jgg@nvidia.com>
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
 <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
 <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
 <b62e5d29-025a-0827-ecad-a48812114220@redhat.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <e6623d9e-0122-ea0c-e148-f739bd15b0bb@nvidia.com>
Date:   Tue, 8 Jun 2021 14:00:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b62e5d29-025a-0827-ecad-a48812114220@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a9a26a6-15fd-4151-f506-08d92a6cad0b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1914:
X-Microsoft-Antispam-PRVS: <DM5PR12MB19142248CF9241D17958CB01DE379@DM5PR12MB1914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaHQ0lQf2OVRiK51x8P+gk9Kky1UKtpS2M/dkOu3oMN1W8IZIQr/73F1J0OK6OnBRiWwnRv42aFQudqMUd2N6uP6aWlOxOlLafkvG3vm57i9UlEjgsOY7elIiTwUD+iHhliv39jcgq3ppkHyldm0xM5S59FhNokNVi58wFBFSvXuNAvguWAAwYjHpA1lDwMrTiFNnpDN2ftdxdw2FDbaTr8vAy+5t9pAU/bFZEBIa5BnTn/mDGJ+7OMePcDXWCA1xrmoU09xFJNlJ13f4s1/tQN/f/WG/LnNNBbtvFvOJgyhSDkxMBa24DAXF5p1Hzo7zVEfPV6k1F+zOOaVhfpc0KqPU4fEBL/svJo2S2oO7O/jspeaK8GgjECvySc8Hc/OP5yHrxQkjltLr91gLLESRH2Rw0n2/btu1VCr4vTu5dcA4m8g404wL+AhYmu7zOah0zd6YaPsU5WyEH6dwCJmlof23Wmh0jMbq2HtQ9rCzcqgWXO1pDJ8Zp6mmJteVbCKLN0iIspCrQ02tpcfZwh6OPOn0ze9jv6vwTiPTVkwBX9fhYNiNsPOQPAxZZvX/E3j9uDa8dWZNNYyKqy5zAfaBjnepyhB6xY58zq7J3PTJU65o6p4Z83Dxb4Ep3K14fuQxYBzPz+hFnTB7IJoxR6nD2QfZ+X3JN97vw7OpPe8TJyyPyV54OLYnXawOVtVYy2j
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(36906005)(316002)(16576012)(83380400001)(6666004)(70586007)(36860700001)(16526019)(7636003)(4326008)(36756003)(5660300002)(186003)(336012)(70206006)(2616005)(54906003)(426003)(8936002)(6916009)(53546011)(356005)(8676002)(82310400003)(2906002)(82740400003)(31696002)(31686004)(86362001)(26005)(107886003)(478600001)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 11:00:49.6649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9a26a6-15fd-4151-f506-08d92a6cad0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2021 1:24 PM, Kamal Heib wrote:
>
> On 5/25/21 7:22 PM, Max Gurtovoy wrote:
>> On 5/25/2021 6:54 PM, Sagi Grimberg wrote:
>>>> Since the Linux iser initiator default max I/O size set to 512KB and
>>>> since there is no handshake procedure for this size in iser protocol,
>>>> set the default max IO size of the target to 512KB as well.
>>>>
>>>> For changing the default values, there is a module parameter for both
>>>> drivers.
>>> Is this solving a bug?
>> No. Only OOB for some old connect-IB devices.
>>
>> I think it's reasonable to align initiator and target defaults anyway.
>>
>>
> Actually, this patch is solving a bug when trying iser over Connect-IB, We see
> the following failure when trying to do discovery:

You can work around this using the ib_isert sg_tablesize module param 
and set it to 128.

So it's more OOB behavior than a bug.

Anyway, This is good practice to be able to establish connections also 
for old devices without WAs and we also aligning to the sg_table size in 
the initiator side.

Jason/Sagi,

can you comment on this patch for 5.14 ?


>
> Server:
> [  124.264648] infiniband mlx5_0: create_qp:2783:(pid 83): Create QP type 2 failed
> [  124.298598] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
> [  124.364768] isert: isert_cma_handler: failed handle connect request -12
> [  128.271609] infiniband mlx5_0: create_qp:2783:(pid 890): Create QP type 2 failed
> [  128.311450] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
> [  128.378995] isert: isert_cma_handler: failed handle connect request -12
> [  130.668362] infiniband mlx5_0: create_qp:2783:(pid 81): Create QP type 2 failed
> [  130.705869] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
> [  130.777306] isert: isert_cma_handler: failed handle connect request -12
> [  132.671161] infiniband mlx5_0: create_qp:2783:(pid 86): Create QP type 2 failed
> [  132.707807] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
> [  132.778867] isert: isert_cma_handler: failed handle connect request -12
> [  132.810653] infiniband mlx5_0: create_qp:2783:(pid 19): Create QP type 2 failed
> [  132.845691] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
> [  132.912706] isert: isert_cma_handler: failed handle connect request -12
> [  134.681936] infiniband mlx5_0: create_qp:2783:(pid 83): Create QP type 2 failed
> [  134.718932] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
> [  134.788804] isert: isert_cma_handler: failed handle connect request -12
> [  136.678428] infiniband mlx5_0: create_qp:2783:(pid 86): Create QP type 2 failed
> [  136.715859] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
> [  136.785058] isert: isert_cma_handler: failed handle connect request -12
> [  136.817414] infiniband mlx5_0: create_qp:2783:(pid 727): Create QP type 2 failed
> [  136.854583] isert: isert_create_qp: rdma_create_qp failed for cma_id -12
> [  136.922975] isert: isert_cma_handler: failed handle connect request -12
>
>
> Client:
> $ iscsiadm -m discovery -t sendtargets -p 172.31.0.6 -I iser
> iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
> connection failure
> iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
> connection failure
> iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
> connection failure
> iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
> connection failure
> iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
> connection failure
> iscsiadm: Connection to discovery portal 172.31.0.6 failed: encountered
> connection failure
> iscsiadm: connection login retries (reopen_max) 5 exceeded
> iscsiadm: Could not perform SendTargets discovery: iSCSI PDU timed out
>
>
> Thanks,
> Kamal
>
