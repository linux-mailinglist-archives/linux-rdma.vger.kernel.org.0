Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3919838796A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhERNBx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 09:01:53 -0400
Received: from mail-bn8nam08on2075.outbound.protection.outlook.com ([40.107.100.75]:56602
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231294AbhERNBx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 09:01:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCNIICjDk1CLI0ecYn0wRILC7GSiTnfrC1SjKSazSfQE9n5viD/03BN7/qT/LgMlbG/aJ16XhxxP39HX9sClCuzED5sYu6FiyqiLayQwBVNLILwh6dEJuoHNHIPxBlaiwOSq61LDNoK1CtevR5R9gT590fGXZkqg1l37+jxlTMKUgAvrcnmilzVA3hO67oxm+SeOzL7oBBYbAOVjtZAl//5wnr6l+6q5lQZtmR2q2Am37vYmnnTqvSZoIpVYQX+9A+WFivXq2m5ANqcdUsOhsHNWMpgXUZ+SUKhYPOazn+QLXCedt+ZpWq6dD+j88DDRgsLcd9mw6Zt5cNBTuoXxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkNGPQOmJe6/T7YDxyFBNxYwFzMU1gEJdpmMJRuFZNE=;
 b=oNdhk3+VvVHq+GBzZDC6I5VuTbL3qEYQcb2jdEyuprYHMyM3uxCoXnVdld+pga8GAVTGHqZdBtuFwj8TgKm5i3KMQsAl6frhmynWzsc6d+b2MeEgBPrwpvCzYJA8vmsGHaRFjAbwDAdRg1oHHL6fWTX6/CZM3HjDX0OKt3ITinooT+reFDH1v24Fi4ZN6QYFWVdtV7VZaGIXG9GNjDhEbblZWr4Um+cpDGV4kr1j07HcoTwJ6VHISjAOFEqNyY5fO92QLXEnLVGRuAOcq2J+CgHu8Abzj8RKoeDQeCu3+BqIgHCajsueMuZ3PeJQYVdqFskqc0E2sQXc4nZFhLkM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ucloud.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkNGPQOmJe6/T7YDxyFBNxYwFzMU1gEJdpmMJRuFZNE=;
 b=mh25jTkzUapvCSffjtbmHIUJuTpIKQMshOsijUOTaAYpla6AjuAopHHNWFY7qxHnsvCv9DcJkh8CA8DRUNahWiRH8q+rXBNSRVuQX4lgzhf9OD1a9xaxfjgkuga+71cNWHpQsIp3rQjI5f2kKw2ayOCqCe/LG6xPf/33ercPzLqRJDQcm+1tEK5mcjDNyjq2N9CigibzWY7vU5tN4+xdx534t/SQ027JmeeFwC34pIQyZAC6LArlvwYQa152KJ2Qfdgq4TvWHWIG1DvSk447uwx+nZri0tQw1J/nSGthabjcoeOLK9d9FqDRElSQWf/jR9jUIBhN9c93Wi+X3xDNDg==
Received: from MW2PR2101CA0023.namprd21.prod.outlook.com (2603:10b6:302:1::36)
 by DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 13:00:34 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::9a) by MW2PR2101CA0023.outlook.office365.com
 (2603:10b6:302:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.2 via Frontend
 Transport; Tue, 18 May 2021 13:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ucloud.cn; dkim=none (message not signed)
 header.d=none;ucloud.cn; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 13:00:33 +0000
Received: from [172.27.8.102] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May
 2021 13:00:32 +0000
Subject: Re: Mellanox CX6DX switchdev mode VF fails rdma-core
 tests.test_mlx5_dc.DCTest
To:     WANG Chao <chao.wang@ucloud.cn>
CC:     <linux-rdma@vger.kernel.org>
References: <20210518092537.mzlmqn7eua4ugztu@MacBook-Air.local>
 <13a4c4a3-0914-c8c9-1873-da83ca0177ed@nvidia.com>
 <20210518124411.vps2uyjfzo4ikjjz@MacBook-Air.local>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <4eb5c13e-6e9a-5d79-da7d-bd4219eef447@nvidia.com>
Date:   Tue, 18 May 2021 21:00:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518124411.vps2uyjfzo4ikjjz@MacBook-Air.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d22ba170-e274-4296-ee92-08d919fcec6a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2826:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2826EEC6FDB7927A042C7C88C72C9@DM6PR12MB2826.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fi8uIMP7ieIES663ywRhHgq4fviOISCNW5xEchuWKPRh68edGabos0unhzpHsKExEjsNAuQGkW9aIpCQ/xDGVzriYHRGOi5cYwRdhGsfNYAmbLOFYdjtYIMSQCBvVyHDMRv52wkNSCqXpRRobWwRcChvQ+Eg8cUGHIxPFMfabED2h12geM6qnTN6mvOXxhApkF+qZUO/UUt6mZqaBCWVfY9bFZJakq5Jh6HQcNfvXAVB/HDFFGulLXNrozVh7RqJ5E97PyZZioYFgf7K0Q3zBYXQZEeVR8SzolQbeMeg8BG4O9I/HB5+mIyJ1NpYiEFzQpG2JVXu9zhkUiDP1fWlWK7q8VcrFcftLYOzgWiHHPknxW588scFeKb9h6n0dp4dgyhh/MazJbbOkyJQUynWEQQrM3+Y+k/E7AGnI47KVjeh25tCovs6bIv4QZddNwj2M9T3atRSaDMPwarQ8VtCzajs/n+eXHvp3WmgTrSrJcgMx8czwb1LOG2aq8NR1k12LAtXn0ciZVZmKWYL22zvtA+KKkTcjMruUPZ8gIX0kKWgPw4MF9Bxk2LNK3DF/7cV8Xlnz7zb9pHLpggMu5aOPySW8SieWLtjJH6dDhZvd3QbqkvWA+bfyyMnxMn0n/2cIdwRoMHwj13Qwm8ws11TXGhQQB+Lr3ITbGHIam/+WR2v15Ma4mhFyYfAJGFdqbCnE+IhnZ6KOf3qMRi6nPp9ddqbUm9+tM5xGCHXYkHcT+bD55b24PgayRKvzGWBrEbb034akLyHO4bwVuadjD6v0Cw2sUFRTieczfdyFNmrj2E=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(8936002)(316002)(478600001)(7636003)(82310400003)(83380400001)(2616005)(47076005)(36756003)(36860700001)(53546011)(82740400003)(86362001)(336012)(356005)(6916009)(966005)(70206006)(36906005)(31696002)(31686004)(26005)(16526019)(426003)(8676002)(5660300002)(16576012)(70586007)(2906002)(6666004)(4326008)(186003)(32563001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 13:00:33.7460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22ba170-e274-4296-ee92-08d919fcec6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/2021 8:44 PM, WANG Chao wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 05/18/21 at 08:30P, Mark Zhang wrote:
>> On 5/18/2021 5:25 PM, WANG Chao wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi All
>>>
>>> I'm running tests from https://github.com/linux-rdma/rdma-core/tree/master and
>>> got the following errors from all tests.test_mlx5_dc.DCTest tests:
>>>
>>> build/bin/run_tests.py --dev mlx5_2 --port 1 tests.test_mlx5_dc.DCTest.test_dc_rdma_write
>>> E
>>> ======================================================================
>>> ERROR: test_dc_rdma_write (tests.test_mlx5_dc.DCTest)
>>> ----------------------------------------------------------------------
>>> Traceback (most recent call last):
>>>     File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 62, in test_dc_rdma_write
>>>       send_ops_flags=e.IBV_QP_EX_WITH_RDMA_WRITE)
>>>     File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 53, in create_players
>>>       self.client.pre_run(self.server.psns, self.server.qps_num)
>>>     File "/data/rdma-core.master/tests/mlx5_base.py", line 36, in pre_run
>>>       self.to_rts()
>>>     File "/data/rdma-core.master/tests/mlx5_base.py", line 31, in to_rts
>>>       self.dct_qp.to_rtr(attr)
>>>     File "qp.pyx", line 1113, in pyverbs.qp.QP.to_rtr
>>> pyverbs.pyverbs_error.PyverbsRDMAError: Failed to modify QP state to RTR. Errno: 22, Invalid argument
>>>
>>> ----------------------------------------------------------------------
>>> Ran 1 test in 0.051s
>>>
>>> FAILED (errors=1)
>>>
>>> ===
>>> Additional information:
>>>
>>> - VF is LAG and VF binds to host.
>>> - DC tests fail when NIC is in switchdev mode while legacy mode is fine.
>>> - Tested on 5.12 inbox driver or OFED 5.3, neither is working.
>>> - 5f:00.0 Ethernet controller [0200]: Mellanox Technologies MT2892 Family [ConnectX-6 Dx] [15b3:101d]
>>> - firmware-version: 22.30.1004 (MT_0000000536)
>>>
>>> I worked a bit tracepoint on 5.12 inbox driver. It seems like there's a firmware
>>> command error for CREATE_DCT.
>>>
>>> I can provide more information if you ask.
>>>
>>> Thanks
>>> WANG Chao
>>>
>> Is there any syndrome in kernel log? Try to reproduce with debug log
>> enabled:
>> echo -n "func mlx5_cmd_check +p" > /sys/kernel/debug/dynamic_debug/control
> 
> [26538.391991] mlx5_core 0000:5f:00.2: mlx5_cmd_check:820:(pid 27332): CREATE_DCT(0x710) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xa22b82)
> 
This syndrome indicates DCT is not supported in VF LAG mode here.
