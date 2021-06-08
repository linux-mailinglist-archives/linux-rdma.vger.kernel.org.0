Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CEC39FD59
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFHRQv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 13:16:51 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:1632
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231577AbhFHRQu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 13:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkJ6kO7ho/ERT+AB5TPqf7U9q4NiXnLqmAVKCdUfWuRARLWyRUiC5fpjHI9fD4KWFHK+4rEtUhXKt4wRHniladZs0GX/fJ1FHv7TsnA1+Xlitv7XgdsYxbFFnGROwFUywYHXjLlgUJ5lReNZ6O96CTV+HRY9F8jXCAT4EbqLhGdnrQQALXE3hPjt6MCflt8hpDOguGnJqGb5JtFOsJbMsF08PQapJcN8tJsfzzuzaWnLjXHefXGygcnAMA84eE92EZsh+4lQ5YPX1ELoEBaPc7bgYNekIUDXkUNmftmgxDwVcaUWXQ7zPvdr6wO7jOV1CDgRkUcxxT1Nf1glQlnH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OrZiwlOtca3StoL/KKc9OxsOfDyV5n0u50HLyKX3T8=;
 b=aXMmU+ZYP65zH5v09pyT30ToZkfc/9+KwYmeLDD5I+BGdepJtAvZ9syg4IpjmdEdRfotOOp81/7+KsaS1yfFL1Pa5B46WgN8dIqSJXwfjJ59KzYJtAzD3EraO8kn+Vd2SlZEwXh/Slk8Cdv5uZgC2q2yD1bOX/BuNpWoYEDEkJ305cZWsnRCv9lamX0jhxXyfQiiCexz60Dlowai61LlmAPq8KpVvcr1erE3UQmeumIbfsa7//8FRLRub4vDRySY2iWiGO5+lKqLacKd216Vh99KEe8oRZDihcZ6IxItdvFrsr6ufgfOxSyfj+7nEZz0S+RFNdtcDVF0JbQ0A2KjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OrZiwlOtca3StoL/KKc9OxsOfDyV5n0u50HLyKX3T8=;
 b=sacW/pBlP7try1R8H35+avYLEKkCaLkzCWkP4Hk219l/JY0k2rsoiZ6RPO9W5z7StHxwEoiywNauzdN+b2lmY316vpprWZB+4sZdKT4ghO6zW70d1/78/7/uGEFnCqmjNGg+N6SkO2ywFbRgmkBXC1PG1XnACUt+3BHi4LOjXiAnzkGvKm0h6OqmnJvnpwBB3arRPSUCKt9zj/D7bb6i2NuGj5s/u6hRcfEmBRtBxHIeHQPfRPHi4k8yznJFbIexBc2lb+dOR71P2fcyngxGbgIlUvvMrCwEWKwlHYQysgf76ub5xIQ3QGtsejL2LOWrMQ1PCJ5/gjsk4C5FLQOffg==
Received: from DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 8 Jun
 2021 17:14:56 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::6d) by DM5PR04CA0027.outlook.office365.com
 (2603:10b6:3:12b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 8 Jun 2021 17:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 17:14:56 +0000
Received: from [172.27.15.93] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 17:14:54 +0000
Subject: Re: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
 <YL704NdV9F15CDtQ@unreal> <474ad554-574c-120e-97ba-b617e346f14d@gmail.com>
 <YL8SbuEHsyioU/Ne@unreal> <591f489c-882b-de37-eb1f-d39a71fcbd05@nvidia.com>
 <bee1cfd7-09f1-5420-b09f-b6eb9de897e9@gmail.com>
 <90cbdee5-c1f6-0373-8d09-c28e3ad7a6c8@gmail.com>
 <0d5a9421-e2a4-c6a6-2934-500559bfc651@gmail.com>
From:   Edward Srouji <edwards@nvidia.com>
Message-ID: <f1214714-2179-1e7b-d68e-510e643917a3@nvidia.com>
Date:   Tue, 8 Jun 2021 20:14:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <0d5a9421-e2a4-c6a6-2934-500559bfc651@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c461968d-f737-424e-7648-08d92aa0f036
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-Microsoft-Antispam-PRVS: <DM5PR12MB114698A42752C9957A5AE56FDA379@DM5PR12MB1146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8VDvAJPO+umXDyKWJvte5Nps3VER/S7+Klv9d3gvVTNLOmRh9z6/RNLq92ulbyGMTqjHBcH1pc+csBkdPlK+hQHfogipCOl6NEIECtd4A0Atmlke5Lyg2UgKS18s2gMG6yaz/k4fRofh3bPtUTU1zJnlh3GvKAa0QoGNlzSLQotc9aa13yW0o1kM0fNl2+H6Qd82H4YsT+lMGFP2R0HYZto1ZYbuR1KEyt7v/YSLi5AQkJEvOmJL2zEZ3hjxf7EIjMJtBZ1+lHQLkRvSp70ExT5XMb2ps7dAm8jJHTAzpWwCmBTCtgjjjNaPvo9G46s87GIsmJ6mqCzd/zZVFmkMs8HIkErJ6b8Hj10V8skJdqN+RIPI7wzD3QLCocmfaGmvg6+L2JpDhdAyGC6hDQdzcOtCAua0H3hS3glce1F583/OH4pDnSTHgL08nyR1AnSohfirT0VXqIwIO1HkhmDmlaV5zc1duVHcwfDgDd33hnXdWgkbIwMWEPycIXoJ5gfliU+Dvp7HaoRcIBs8hoBsAHruIGqButHFoE7NXU44F7Q1nfkszFKIeiPymotjz/V1a+RQmbTzKBSeiKUmOZtK4fMsKmjCJkY8daXMW/VdyhZCLkueJL1uNxIJXdPI8GS7HNNmKZ2Rg+EuUb1OglzBsiuPxacwWp/BjzitQ9u+hHc8o6qlShpyBobYQcUkpui
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(8676002)(186003)(26005)(82740400003)(16526019)(4326008)(8936002)(356005)(336012)(70206006)(70586007)(426003)(2616005)(31696002)(83380400001)(36906005)(47076005)(31686004)(82310400003)(5660300002)(478600001)(316002)(110136005)(16576012)(6666004)(86362001)(54906003)(2906002)(36860700001)(7636003)(36756003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 17:14:56.0961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c461968d-f737-424e-7648-08d92aa0f036
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2021 7:22 PM, Pearson, Robert B wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/8/2021 11:12 AM, Pearson, Robert B wrote:
>>
>> On 6/8/2021 10:54 AM, Pearson, Robert B wrote:
>>>
>>> On 6/8/2021 6:53 AM, Edward Srouji wrote:
>>>>
>>>> On 6/8/2021 9:47 AM, Leon Romanovsky wrote:
>>>>> On Mon, Jun 07, 2021 at 11:54:29PM -0500, Pearson, Robert B wrote:
>>>>>> On 6/7/2021 11:41 PM, Leon Romanovsky wrote:
>>>>>>> On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
>>>>>>>> sorry/this time without the HTML.
>>>>>>>>
>>>>>>>> ====================================================================== 
>>>>>>>>
>>>>>>>>
>>>>>>>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
>>>>>>>> Verify bind memory window operation using the new post_send API.
>>>>>>>> ---------------------------------------------------------------------- 
>>>>>>>>
>>>>>>>>
>>>>>>>> Traceback (most recent call last):
>>>>>>>>     File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line
>>>>>>>> 292, in
>>>>>>>> test_qp_ex_rc_bind_mw
>>>>>>>>       u.poll_cq(server.cq)
>>>>>>>>     File "/home/rpearson/src/rdma-core/tests/utils.py", line
>>>>>>>> 538, in poll_cq
>>>>>>>>       raise PyverbsRDMAError('Completion status is {s}'.
>>>>>>>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is
>>>>>>>> Memory window
>>>>>>>> bind error. Errno: 6, No such device or address
>>>>>>>>
>>>>>>>> This test attempts to bind a type 2 MW to an MR that does not
>>>>>>>> have bind mw
>>>>>>>> access set and expects the test to succeed.
>>>>
>>>> You're right, looks like a test bug. I'll send a fix upstream.
>>>>
>>>> Can you please confirm that this solves your issue:
>>> Well I get further. I am hitting a seg fault in python at
>>>
>>>         client.qp.wr_rdma_write(new_key, server.mr.buf)
>>>
>>> in test_qp_ex_rc_bind_mw.
>>>
>>> I'm trying to track it down. I'm not very familiar with python and
>>> don't know how to run the test under gdb.
>>>
>>> Thanks for the fix.
>>>
>>> Bob
>>
>> OK got it. In the setup for the test you write
>>
>>     class QpExRCBindMw(RCResources):
>>         def create_qps(self):
>>             create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)
>>
>>         def create_mr(self):
>>             self.mr = u.create_custom_mr(self,
>> e.IBV_ACCESS_REMOTE_WRITE |
>>                             e.IBV_ACCESS_MW_BIND)
>>
>> which asks for qp_ex->wr_bind_mw() to be set but later in the test you
>> write
>>
>>     client.qp.wr_rdma_write(new_key, server.mr.buf)
>>
>> which calls qp_ex->wr_rdma_write() which is not set causing the seg
>> fault. I think you should have written
>>
>>             create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW
>> | e.IBV_QP_EX_WITH_RDMA_WRITE)
>>
>> since you need both extended QP operations.
>>
>> Bob
>
> With this patch the test is now running correctly
>
> diff --git a/tests/test_qpex.py b/tests/test_qpex.py
> index 20288d45..0316bfcb 100644
> --- a/tests/test_qpex.py
> +++ b/tests/test_qpex.py
> @@ -146,10 +146,12 @@ class QpExRCAtomicFetchAdd(RCResources):
>
>  class QpExRCBindMw(RCResources):
>      def create_qps(self):
> -        create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)
> +        create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW |
> +                       e.IBV_QP_EX_WITH_RDMA_WRITE)
>
>      def create_mr(self):
> -        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
> +        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE |
> +                       e.IBV_ACCESS_MW_BIND)
>
>
I've sent a fix patch for upstream (you can see at github).
>  class QpExTestCase(RDMATestCase):
>
>>
>>>
>>>>
>>>> diff --git a/tests/test_qpex.py b/tests/test_qpex.py
>>>> index 4b58260f..c2d67ee8 100644
>>>> --- a/tests/test_qpex.py
>>>> +++ b/tests/test_qpex.py
>>>> @@ -149,7 +149,7 @@ class QpExRCBindMw(RCResources):
>>>>          create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)
>>>>
>>>>      def create_mr(self):
>>>> -        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
>>>> +        self.mr = u.create_custom_mr(self,
>>>> e.IBV_ACCESS_REMOTE_WRITE | e.IBV_ACCESS_MW_BIND)
>>>>
>>>>>>> Does the test break after your MW series? Or will it break
>>>>>>> not-merged
>>>>>>> code yet?
>>>>>>>
>>>>>>> Generally speaking, we expect that developers run rdma-core tests
>>>>>>> and
>>>>>>> fixed/extend them prior to the submission.
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>> Bob Pearson
>>>>>> Nope. I don't have real RNICs at home to test. But (see my note to
>>>>>> Zhu) the
>>>>>> non extended APIs do set the access flags correctly and the
>>>>>> extended test
>>>>>> case does not. The wr_bind_mw() function can't fix this for the
>>>>>> test case.
>>>>>> It has to set the access flags when it creates the MR and it
>>>>>> didn't. It is
>>>>>> possible that mlx5 doesn't check the bind access flag but that seems
>>>>>> unlikely.
>>>>> mlx5 devices support MW 1 & 2 and kernel checks that only these types
>>>>> can be accepted from the user space. This is why mlx5 doesn't need to
>>>>> check access flags again.
>>>>>
>>>>>     903 static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle
>>>>> *attrs)
>>>>>     904 {
>>>>>
>>>>> ....
>>>>>
>>>>>     927         if (cmd.mw_type != IB_MW_TYPE_1 && cmd.mw_type !=
>>>>> IB_MW_TYPE_2) {
>>>>>     928                 ret = -EINVAL;
>>>>>     929                 goto err_put;
>>>>>     930         }
>>>>>
>>>>>
>>>>> Thanks
>>>>
>>>> I see that mlx5 checks the access flags in userspace only if
>>>> MW_DEBUG is turned on (in set_bind_wr()).
>>>>
>>>> I guess that's for the sake of performance, as it's part of the data
>>>> path.
>>>>
>>>>>> Bob
>>>>>>
