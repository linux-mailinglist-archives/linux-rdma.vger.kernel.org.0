Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D822034D53C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC2Qfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 12:35:43 -0400
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:56417
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230482AbhC2QfS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 12:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meu2LZtiPh68slb9PUbpSOQPd8YW1ler+BzgsiLKDbnpd10oxIrymgBOqs45GzKF12Jajjz91NGUbfX5Njy0y6DfndZsU3eGYSjTGYD0YP+HEU2Zz2XvS3O2ytfjcaAtRlEOOnefe9cLw2WOwfDOGEYucXF7fu+/aIaGmDYzB30js5+O9IIY5Miy+3mBJ8RzSTKApgdGwnkRoDR18eiuKGOV9ey4ono+2tSoNU+1kG84Qt0E6FW/VRuD7n11v/IG52tuhF7s1AwDSQrUDNWTDNwmSX2PKEWoTfB9xQ5Y0SpwQdvebrXDVbV6mbSQOsWRvF72UrDRTX4sUPP3NFeNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZJe0p5BJTaIGIKE1DVwHG0Uc2y/x/1LaxGLLtx3zuY=;
 b=hZcNGib7aJF7FnIIzyglnQUs7V2lcM0+cWPQrkZfNPI4s14nryXnST/3WVi0Ovj2S8/3Rrvr3JG5QXiRvVAlddXdEfE5VTfIfG1phRol2PPAkT/slWgsBu2Cnj9/hq7Exil+U/xC3jNFo0U9ERanli21c2T6lB7/KT61001Qpx6RGfGEG9WyzmOb9kYLJCTHeupWlrO3997L3RJRRhJVgQUzKfZy4+gGjRUQ1IxgzxqRb3OkYMBKBpAo1G5lGHtC3Y/a3ufFvIFT8uZYhve47PIznNZqND/fnGnlvdBEwLAxIBu6sIVm/41tp8BnjUhkCtZkzNP2O4FfTcKG67k8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZJe0p5BJTaIGIKE1DVwHG0Uc2y/x/1LaxGLLtx3zuY=;
 b=LMG3q+pacmxJTtktRPnfrIRhT+RCQvVKTa4TkHrt1Ea1Oxj5evupC/jI0BsfC8iPn6wAmOfpbf/FL9RIU93TSt35uaCBk9r575HP0QS14gGv726pdGS5NsdwqKH9CHhAdCwTcVxKzfjrsWXzRtXqVPY1xoJVbwfIOlLXln4rorTRb2Wsy7+8UsNWsblS4Tl4BtgIy68XUwkGEJGaBt6Cw4pV5Dcz7rRjaP1w2hDHf4x3cDIrWsdIC9x5ohFMmFYXPpWe95T5m97hFXyK6T1f0uppe0VDcvCr9fX+woAJpkrkHnkLrivW8RYY5YZLKS61JOniAyWjkohjyzu01B9Utg==
Received: from BN6PR13CA0050.namprd13.prod.outlook.com (2603:10b6:404:11::12)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 16:35:16 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::74) by BN6PR13CA0050.outlook.office365.com
 (2603:10b6:404:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14 via Frontend
 Transport; Mon, 29 Mar 2021 16:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 16:35:15 +0000
Received: from [172.27.13.153] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Mar
 2021 16:35:14 +0000
Subject: Re: Fwd: Possible bug in test_mr.py
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c143355e-954a-5953-c67c-c7a9bf451b7b@gmail.com>
 <edbf4d3f-08bc-31a0-a214-c098748697b5@gmail.com>
From:   Edward Srouji <edwards@nvidia.com>
Message-ID: <c8bf0e78-b2d5-2151-2b32-5386ff4566d2@nvidia.com>
Date:   Mon, 29 Mar 2021 19:34:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <edbf4d3f-08bc-31a0-a214-c098748697b5@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96e6e693-8453-4020-753c-08d8f2d0a21e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB268578675C86BEA7BC2E2128DA7E9@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eS3x3MFtqAGCTmcmL7yTfVMG7kqg0tFS/6rmaTaWQILB/TyizHpsTsgMEoKv07t2kQE7mpAoStjFONCDgtNDgbK0fNKqgiWHfX36IVCdLd/hRkbN6qwSs6lA1c9ZNe7KUWw++67x312bELOUwRg0wXWhkXR2RoL55dqz3j3NIXr6OdFUGQKQfsCUrLQzRsl44UY+wZ5VLiEzjVipLdNUsyl3VDDF/MRuj3b44KeUPcFYrGfHHX5BsEwzjZdf0+sYnvuvljmOdEc0ntNkPbujHqOYj5OT8bkdGKNMiSDpM+tI53Vdlp4JgXYgo0Qz48CPNe3YNOx8aCbyQ+/4V4ePDzumefocqaafB1qmMCu1pv8ZP6kqeU4zo7Dw3Xj0B+xherKydLqYDjjT6niIL+6UMiNMWA+YssITqBdiNlQwuuHn0S9SbyLrLzbWyubKrMFgvnI1W0BaD/kCdIpfwmOdg6jnco/Dnf2U7PAVLMWmfiwLoCP+31LrQmj1uyEALi+jEuR3UVJ3VdzDHTMq7R0reGT2yMNC3FkvUKJrE0jweQHCG1qekGKtjUzeE+5noU7ouzxp9ldkU7R8pnk132y4cTxVnJPd5b3ob/Jqsx0Mku1mrwLKyGDyz3hVD+HK3gjBMJtFj/JDdXSugWiS6Nhjupq79EiQQSZBYnH/2HqZgp+F3vv1KI85+Criu0zpiHnf
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(70586007)(186003)(47076005)(8676002)(478600001)(53546011)(2906002)(36756003)(31696002)(16526019)(82310400003)(36860700001)(336012)(316002)(110136005)(5660300002)(16576012)(36906005)(2616005)(7636003)(31686004)(82740400003)(356005)(6666004)(70206006)(83380400001)(86362001)(8936002)(26005)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 16:35:15.8360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e6e693-8453-4020-753c-08d8f2d0a21e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

You're referring to the "test_mr_rereg_access" of test_mr.py, aren't you?
We need to re-sync the rkeys between the two sides, for example by 
calling the sync_remote_attr() after reregistering the MRs.
And if that's the case, and the MR keys could change, maybe it's better 
to re-sync the keys between the two sides after each rereg call.

I'll push a fix - in case I misunderstood you or that's not the point 
you tried to make, please let me know.

Thanks,
Edward.

On 3/29/2021 7:18 AM, Bob Pearson wrote:
>
>
> -------- Forwarded Message --------
> Subject: Possible bug in test_mr.py
> Date: Sun, 28 Mar 2021 22:52:01 -0500
> From: Bob Pearson <rpearsonhpe@gmail.com>
> To: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.linux.org
>
> Testing ibv_rereg_mr() I noticed that the test uses the rkey originally assigned to the MR by ibv_reg_mr() and not
> the rkey subsequently assigned after calling ibv_rereg_mr(). This matters when the original MR did not have remote
> memory access and rkey was set to zero. If the rereg changes access to allow remote memory access then the rkey is set
> when the verb returns. But the test code never looks again after setting up the original MRs.
>
> In rxe setting rkey = lkey always gets the first rereg test case to pass.
>
> bob
