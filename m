Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C8239F5B1
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 13:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhFHLzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 07:55:50 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:52769
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232447AbhFHLzr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 07:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI38EH1B+TtsggbiKEnkT1BDNrf4CWoQbtx6LW+rc9rmKt3HeezhdD3YpHSbrFuN+luLfwLDcZ6CX7F1PKtayxZ1nRwN2jN0Xv21ZiqxbPlePKGgY44swrRG6oVNGVvIDkWcE//5sZ+WQJ9/SbkXzMwMEXdzJLf2fdKvI6QQXSJUaKmIEf9vyY87r1+gFxZPJemvHywZD+ydeugGf0zW1Iz4TTrRM2og+w1IBiJSfJ3uumYHohFSGCAvuahcUOO8/bgLLskHYb13/HoU3DATVcKWcM/Pu9rttlkG1Zu+aeSW4mCWSnRmacmrW041f77Luu0EBbwkgqdNT0VHZBUhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uM/6J2uDikIrQoj0iUW1Mwjhgw7OO5FZ4I1HEZEN/0=;
 b=XlYUyBCSJ+7JwgHqA+gNE3d8GMAbgD1uFmQpE5RuzVbsbXf9oRx6zDH2b1NDBBT7TnnyDk+3yisRnPMuMYYSVTo+E3ihDmrXpC88IP+jOGgoa9RMl2nNWDiAqVQeB3h18v3vAMjYGBXEA5WzR42GuP1CzKDhCTBH4/tBZk7iIqInTkbLgmShZbyJ1llBnA6tFfqzkqniiD40KPMMHRJ69yQVdE2uMfSO1dcfe0VRHEVKswvff4tWGoJ5gLz4tFrH0qcVu3bez587VUkSpekPDXT+sE5SzrYAB/qTr/dNnzho59uihyy4gq/QlxWzUkTyfiNID44OnoXjlHyYppd4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uM/6J2uDikIrQoj0iUW1Mwjhgw7OO5FZ4I1HEZEN/0=;
 b=SULMQqrkBguOkrPA2pwX9tIcMkKU6xIZHuFttahPfhPvLKnpjx8aR8pe1fD6ywbUamDHyjkYi10KjUOdn/aJxWXjbJyQGiIkq2O8HqZuOjkc7CKFFHGeNneeY2MBbgf0gdYvg1yrXH2+yJtrr1+jMg24t1T25Mn7LdgV0Jf3K19GYyWPwFeOvpr85NzicHJr5D4HuQlSXE1KO/oBzBdBOnbDEl/o+73p7A9gfCixSfXDBwgqFnHwVco3KNcvflpwyPUurB5y7rFKid2xULUS64QcEXZ8fAiCgN/gMdkwd99mJ3QF95NDLKEGqzA8y2CtqmRuF2v/UndPNe4QZYC77w==
Received: from BN9PR03CA0084.namprd03.prod.outlook.com (2603:10b6:408:fc::29)
 by BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Tue, 8 Jun
 2021 11:53:53 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::cb) by BN9PR03CA0084.outlook.office365.com
 (2603:10b6:408:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 11:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 11:53:53 +0000
Received: from [172.27.15.93] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 11:53:51 +0000
Subject: Re: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
To:     Leon Romanovsky <leon@kernel.org>,
        "Pearson, Robert B" <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
 <YL704NdV9F15CDtQ@unreal> <474ad554-574c-120e-97ba-b617e346f14d@gmail.com>
 <YL8SbuEHsyioU/Ne@unreal>
From:   Edward Srouji <edwards@nvidia.com>
Message-ID: <591f489c-882b-de37-eb1f-d39a71fcbd05@nvidia.com>
Date:   Tue, 8 Jun 2021 14:53:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YL8SbuEHsyioU/Ne@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33025e4d-0095-4bf6-64ce-08d92a7416bd
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:
X-Microsoft-Antispam-PRVS: <BN7PR12MB261117F9A1C03A787D4D6007DA379@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vL9tt89JzGvpMVRNmshdPK/Uv7ipthz/ZaUQZGDrGvTj3N1LmIPuEpgoaWKlVdYxpBq6Pe3bNIU2FMb0blwrBgLqcYxDMspUYvvz36A2pw9ZqHca68U7qPJut1UcQUZzyuQtyUTJYx2C4Zt1kSzl/xvG4jB+nWf65qQm1peL282oj4f27GBidoDNgaLPVZ/x+Xmku4nRzBO+kHVpHUM6tIbi6MPWfjPP9CboRWYAuE41I/wo3u60ydmB5bWlLkATkftKnke4woOMMcbZfHQ8DhoVWsjpXwGF38a9jZ/gNRwylmOxNflNtv6e8UV4fpSZT5RVBz5HfPWDWSggbhouBba+8AL0Ies7JYNk3sZmWkXJPvP0BO8LIWBTqd3Enq6kLOSfSHddJILYi+9EYaR0/aii5zwCvmDB4MuWLuGue2I2mr8iwS6jmUeFAByfT41jrr9mP6Ka+G4LRa6qol/cxbrYHcMbrkfbZDn6Kxb20zsiIKgL1GbeOVQUK+GifHqwD+K51VgjWDgbIj7d26bZ6h/zSokphkWSljNp9OJrgFsXfGJJGXtrWsP2kYjJVgs/G9edJD5C8emqGKwc64YQIMybXDu8ypgQJrIXRueJZdkOOsl4gvW7CeU9B8GGykciONVyU8lEbpqTRhf/aqVoeA9sXm44uvDxSJxnHRBGZ2DIeJWP9ioKhY/j4Kb+zk50
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(478600001)(2616005)(7636003)(36756003)(426003)(26005)(2906002)(36860700001)(6666004)(82740400003)(336012)(31696002)(47076005)(4326008)(356005)(53546011)(82310400003)(31686004)(86362001)(110136005)(16576012)(316002)(36906005)(54906003)(70206006)(70586007)(16526019)(83380400001)(8936002)(186003)(8676002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 11:53:53.3922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33025e4d-0095-4bf6-64ce-08d92a7416bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2021 9:47 AM, Leon Romanovsky wrote:
> On Mon, Jun 07, 2021 at 11:54:29PM -0500, Pearson, Robert B wrote:
>> On 6/7/2021 11:41 PM, Leon Romanovsky wrote:
>>> On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
>>>> sorry/this time without the HTML.
>>>>
>>>> ======================================================================
>>>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
>>>> Verify bind memory window operation using the new post_send API.
>>>> ----------------------------------------------------------------------
>>>> Traceback (most recent call last):
>>>>     File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line 292, in
>>>> test_qp_ex_rc_bind_mw
>>>>       u.poll_cq(server.cq)
>>>>     File "/home/rpearson/src/rdma-core/tests/utils.py", line 538, in poll_cq
>>>>       raise PyverbsRDMAError('Completion status is {s}'.
>>>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory window
>>>> bind error. Errno: 6, No such device or address
>>>>
>>>> This test attempts to bind a type 2 MW to an MR that does not have bind mw
>>>> access set and expects the test to succeed.

You're right, looks like a test bug. I'll send a fix upstream.

Can you please confirm that this solves your issue:

diff --git a/tests/test_qpex.py b/tests/test_qpex.py
index 4b58260f..c2d67ee8 100644
--- a/tests/test_qpex.py
+++ b/tests/test_qpex.py
@@ -149,7 +149,7 @@ class QpExRCBindMw(RCResources):
          create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)

      def create_mr(self):
-        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
+        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE | 
e.IBV_ACCESS_MW_BIND)

>>> Does the test break after your MW series? Or will it break not-merged
>>> code yet?
>>>
>>> Generally speaking, we expect that developers run rdma-core tests and
>>> fixed/extend them prior to the submission.
>>>
>>> Thanks
>>>
>>>> Bob Pearson
>> Nope. I don't have real RNICs at home to test. But (see my note to Zhu) the
>> non extended APIs do set the access flags correctly and the extended test
>> case does not. The wr_bind_mw() function can't fix this for the test case.
>> It has to set the access flags when it creates the MR and it didn't. It is
>> possible that mlx5 doesn't check the bind access flag but that seems
>> unlikely.
> mlx5 devices support MW 1 & 2 and kernel checks that only these types
> can be accepted from the user space. This is why mlx5 doesn't need to
> check access flags again.
>
>     903 static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>     904 {
>
> ....
>
>     927         if (cmd.mw_type != IB_MW_TYPE_1 && cmd.mw_type != IB_MW_TYPE_2) {
>     928                 ret = -EINVAL;
>     929                 goto err_put;
>     930         }
>
>
> Thanks

I see that mlx5 checks the access flags in userspace only if MW_DEBUG is 
turned on (in set_bind_wr()).

I guess that's for the sake of performance, as it's part of the data path.

>> Bob
>>
