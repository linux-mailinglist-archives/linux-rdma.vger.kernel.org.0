Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA13878C0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbhERMbc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 08:31:32 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:45483
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243225AbhERMba (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 08:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYGMUKr7JawMmJoZfvGQoBRLNLBhHliE2IPvxMK9FUmq8gChfWc/HhKQXbmKjSjEMEsDsP1tXNQxTkffLVWPV7M3d02dK2EqT21Oo7Tj7MIpxFCH1EE89HiGkhpflrhRAyBRH8autXP7H8Im0njYi8vK7BL3aaG+Xv7QjeB8L4HAHPzTaTV0gbfGoig1iCscopyLHQxuBbGTgjcIDRY1lh6NraQbm/SmpV6y4aIROa2x4+RJQV/QLi15lH8hPYru7tSIMTeXfYZjC6epy5p9LSc5gA6gqIu9790z2rVjA/96q6Q/FBDSTN1ENcoWscLCfQKs4izD6lKPRzTG7zDxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJt4s2G/cxYbdFa4g0Dz11T/lMLX+lPX9vCcGr7Ky0M=;
 b=Xg2/3L7sE0BhnHoXS+FxcjyDfjvJuSQTzyPOG8pkZX/j9j81PBg3Wy8FOGStrRmrcbCp/pEF1l6baKxLQVXzvLd9kc+fEszoKus/zVFMwnzNpC169eyw7jetq9bizcPpSAbi6rKB741gIXWiDnWqLRJtmFTWTagEc5+9fCxgrw5sVxkSE/jaoX62UPMDr9CjdVJPdzaCBnu7LmHGivGzMI60J0Ju8B+63HnPI4sCuxf0Lr+7cKsczEIYrrH7vA6j3vXt9KhNlgbZR0QMF4oPaS0XlC0AdMMNBBTHdEVLzsacnRRayALK27NHYkxJt9YT7hRa56fqr+4GbDmNecr8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ucloud.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJt4s2G/cxYbdFa4g0Dz11T/lMLX+lPX9vCcGr7Ky0M=;
 b=juoJVg4Hy1hlqevGiibwaojJ5to6WyAoSZuy3rmzmD9gk1kmkmBJoEVYHgLGMG67pSFagz0CE5s0xd3q3/VhNVk1Qop0DYyBduvFfdsDjkjlSVnIHj4ZfKf3QHduPzEeZU1AUwQfd8aDhNeD9+h5SWDfg4K5Me902cSFtc6OMvLzl92lixnvFlseA8TbNOVR+sDKUCo/2fR13FRmMTeZN7C61vb0vrVvh2KCjyumBw1h0qxCD3G/A3TIeCziczZFSGDsrjCHGziUKdr/aDOpCxtClVnBDPqt/kj5cc40mqL7i+1jp0Tb55XgcdhWvqKriVQGZXBqRmpmUNewcg6Bzg==
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 12:30:11 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::13) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Tue, 18 May 2021 12:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ucloud.cn; dkim=none (message not signed)
 header.d=none;ucloud.cn; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 12:30:10 +0000
Received: from [172.27.8.102] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May
 2021 12:30:07 +0000
Subject: Re: Mellanox CX6DX switchdev mode VF fails rdma-core
 tests.test_mlx5_dc.DCTest
To:     WANG Chao <chao.wang@ucloud.cn>, <linux-rdma@vger.kernel.org>
References: <20210518092537.mzlmqn7eua4ugztu@MacBook-Air.local>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <13a4c4a3-0914-c8c9-1873-da83ca0177ed@nvidia.com>
Date:   Tue, 18 May 2021 20:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518092537.mzlmqn7eua4ugztu@MacBook-Air.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba7dc101-e039-468c-4c05-08d919f8adfa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4619FE0D729AB82D3AAE86B0C72C9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzj8KPcyiwtlZDXUK9rkIggo32eH45KHiXDCACENf4w2OeuAIQ11R4RphlJokEkM38gr9XbGmM/5AiqPGs+RPtm9dJIv1Ougdd+YTQVRFr+OO3qYzLx24ExDYC/Uidsv0ufAxX9fn8A7cS2Kvm5erZNhrUBsat1NBbGpkVamw9/S/qJt5ZCJWlfZE9cSs3BUnIP1M/yf9mnFIATSJ9L2YLYhM3ytsUJxGO+DRcMGe8DRsLY1q7OluHQ7O4G6Wq5NnObqpD4CyQMz3rO+IGEKw/Jg+dE3EryHHCFx5Xk4AhF9KhtCpttmRG4xKDExorcMPV1C+KVh/tG2msbkwhpnQSXrpluOqPEIyZ93YgDfAGGtDeiP6wM/S759qylfgnx2ECgajGASskQYRdMnbdfkMNS5bzSopvhGZ0msrT4jq63RvLwW+FLuyRcsO/Wu+j9h9Q1D7o1gvnjieyOsl6WSskb/BR9Jbno/G+Bb+X660WXm82kFlazntc7XHr2zeRe8mWq0Ki6VXTcJJi3nQhhtbFAM9LKtL1kTYT2fAQRjaPUAoY9YVkJH/U6+5rF2L4kLdcy2siAkPsPmrqsvN9ygIcrZ8l0sy00ldJobrmjHVU3p6wjNWrmIkuA8ik/37GuDprycqewlwj0NAqnzsk9qiXMQ8Odmn4jYmEjetAC33RATvfuhEi4lJo4dZfAU+WJh+6+thxAuBGGV6Sb7TirOfP0wFvhRhdy3IDcTq9/eXAvHG9acPIi0eDh4VTGiAhST/ku+nBD4iXOHDSiHcyrMlKMhqHrvcPZHsS0S+NfH5xc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(46966006)(36860700001)(36756003)(47076005)(5660300002)(7636003)(356005)(83380400001)(53546011)(82310400003)(82740400003)(31686004)(86362001)(26005)(966005)(16526019)(186003)(6666004)(8936002)(31696002)(478600001)(70206006)(426003)(2906002)(336012)(36906005)(16576012)(110136005)(8676002)(2616005)(70586007)(316002)(32563001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 12:30:10.9242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7dc101-e039-468c-4c05-08d919f8adfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/2021 5:25 PM, WANG Chao wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi All
> 
> I'm running tests from https://github.com/linux-rdma/rdma-core/tree/master and
> got the following errors from all tests.test_mlx5_dc.DCTest tests:
> 
> build/bin/run_tests.py --dev mlx5_2 --port 1 tests.test_mlx5_dc.DCTest.test_dc_rdma_write
> E
> ======================================================================
> ERROR: test_dc_rdma_write (tests.test_mlx5_dc.DCTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 62, in test_dc_rdma_write
>      send_ops_flags=e.IBV_QP_EX_WITH_RDMA_WRITE)
>    File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 53, in create_players
>      self.client.pre_run(self.server.psns, self.server.qps_num)
>    File "/data/rdma-core.master/tests/mlx5_base.py", line 36, in pre_run
>      self.to_rts()
>    File "/data/rdma-core.master/tests/mlx5_base.py", line 31, in to_rts
>      self.dct_qp.to_rtr(attr)
>    File "qp.pyx", line 1113, in pyverbs.qp.QP.to_rtr
> pyverbs.pyverbs_error.PyverbsRDMAError: Failed to modify QP state to RTR. Errno: 22, Invalid argument
> 
> ----------------------------------------------------------------------
> Ran 1 test in 0.051s
> 
> FAILED (errors=1)
> 
> ===
> Additional information:
> 
> - VF is LAG and VF binds to host.
> - DC tests fail when NIC is in switchdev mode while legacy mode is fine.
> - Tested on 5.12 inbox driver or OFED 5.3, neither is working.
> - 5f:00.0 Ethernet controller [0200]: Mellanox Technologies MT2892 Family [ConnectX-6 Dx] [15b3:101d]
> - firmware-version: 22.30.1004 (MT_0000000536)
> 
> I worked a bit tracepoint on 5.12 inbox driver. It seems like there's a firmware
> command error for CREATE_DCT.
> 
> I can provide more information if you ask.
> 
> Thanks
> WANG Chao
> 
Is there any syndrome in kernel log? Try to reproduce with debug log 
enabled:
echo -n "func mlx5_cmd_check +p" > /sys/kernel/debug/dynamic_debug/control

