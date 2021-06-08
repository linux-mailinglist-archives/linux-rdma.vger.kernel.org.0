Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D9C39FC1E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhFHQNN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 12:13:13 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:9697
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232093AbhFHQMG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 12:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBrSbhpbxxJBbsDQGL8DOktYnMdruW9xvAxBn8nNoPr1D4DhUpFa++exy3DS00v89t9QeFc8yK8GUBcSJ5pnViZKBjPl/HRH1WtCdyjBNKYJ78IoilrxkXc8DnodIOUyAnkPJ1qJCTEQQku8uRjqqPLdeyJHFv2QZN7MsHss7PD7byD9bm1dYKOqq0vRFnjtB5M/yjy66Qu1bizGfFXA8FRsvLdjlvk4dfHBfI/xotb3F+vl1kW8bQ0Dp+pIXw8bA3vtqZf3yc0jneHj1M4NoO0fioiLdzu0YVjBOK4SjX4vm6KPS5OTt/iPR2rl88wxk5zOt2gGp8L3X258SE6ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVjJ3zjMcwLe5uIdZVsR5YAn0+klf64fVSYTIFgeXmY=;
 b=JPT0Q4kUDm9oOxS32I/owv/RVZSWPx1aj7qHd9qh+bDY2HmqXQGVqyS0N5tLy7qAVgncYcS0awwt3gSG5dc2EJVHwkGPo4Kxs9hVAge8qS3SW/M9jbRiDUhmm267O1LMtFED9yGSEo9l7Z6K06/RMxEAS2FY2HxtQs9AXsyB4OqdOcy6jt8nBejLn42/yA7+VoJ2ppF15CXCN096N3NBl7cG32Ntz8lkslWsqB9v0Ed97QqThM5jO8MV9jcrLkfG8B/tsf4DawVQrlOayUuZaNh4kMAniNzNZLpptpEoApqgqpoixfrSyLJirkTTyQWTGvL46RMPFpLZfKWKGKQ0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVjJ3zjMcwLe5uIdZVsR5YAn0+klf64fVSYTIFgeXmY=;
 b=JBjzeOpLHJ4Qv1Amq3ZgccuVbDRCCrqf7N+Kh11CacqN5fB7FyCtlXlS5IaymdXNtgQC+UQm+X54ojcCxtzBXYo87o2l//Xd3vQSFC3UN3UgyHUxhPBg5Vth6z9tjtk1NdWvcTQTjRM3W6uoe087MLHsWIZzcQYQYcZ60nh2uP1PJU9ZhZn7ugc2R5VoiLrK2PaDcqc6hl9TEZiRQoQCIlaiweIDJidwa+uBHR9ZaLyDiTuUv+abTIuRFvLAA/z8yjH+8e03kJ3FCvzKYKeeji+xyo8c9ZaWld9FQOqGyRfRlXDMyM8R9sdyVW4oKfJC7OJvkZvieGMIiqMl1kekgg==
Received: from DM3PR08CA0018.namprd08.prod.outlook.com (2603:10b6:0:52::28) by
 BYAPR12MB2951.namprd12.prod.outlook.com (2603:10b6:a03:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 16:10:11 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::a8) by DM3PR08CA0018.outlook.office365.com
 (2603:10b6:0:52::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Tue, 8 Jun 2021 16:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 16:10:10 +0000
Received: from [172.27.15.93] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 16:10:09 +0000
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
From:   Edward Srouji <edwards@nvidia.com>
Message-ID: <48ca9473-0fbf-d62f-72cd-fbb3de885b46@nvidia.com>
Date:   Tue, 8 Jun 2021 19:10:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <bee1cfd7-09f1-5420-b09f-b6eb9de897e9@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c995b44c-90b3-42cc-7814-08d92a97e452
X-MS-TrafficTypeDiagnostic: BYAPR12MB2951:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29514B4451575AAD77950947DA379@BYAPR12MB2951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8828cZ3rChJq4GMePRYfu3MIvcwkLzrHqt2w2PRC+PPniA2Qd4b4gGlbX+mWbNgsFkO9PC4LGhg2jt0p3xSwXQG+4y4CYxGk6tsQ9H2rVKWyNmrDnJx9zoTnbD1xF99J/fNPbMWOr0qwP2U3YnO588uflS/hQmNoikxpGtJQxKWuwLSo1+1vyCG+J45F6ZRGtID71rfNRrW6bo3nsxzzfMLHbErRIz3Fi3lIbhNVj+w5Xnoo8XWt8YHPGoEcq8jAnWOrI7X4HnVb+1fDqoBHvLEt2qrwD2Fe5koTDUqPUY5y42c6HgbN5TR9rZwMxnjtr1TRWjn7xjHW5HX5AkvM1hisDkSGMnx5b2U3zYt1j0HCqE/ajgsQdqNpxBY7uWBHN891epbDBphqk7NVMxi1KFE8oJ6I8Brctqz/VWVg8zd3myfIFFQUTbp+24aD5t4i3yPLEz8FWiH6Kb59lHePddqPs0jVyKDiESe3dTZ4I38+nO4osMO/Qh8phqJ5I/kd3ikkq6fYvbTtS+g8PdzBEMNVxJxB+Dl6Z8b0Y0IZCkXswAMtrcv8mEmuIWr1blzsOZ1lnyzpWE1gxJc629Ghknvq1HwU+FIY3q8OJFMeCpf8oCeK5UVM7cfsSyb7nuTwW1EZdnSOf/jVqUaTZJCbMsxR+mmn72VymksIM6AI+idTEzYWOCTZ6HkMahz8LQZG
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(110136005)(6666004)(82310400003)(5660300002)(426003)(54906003)(16576012)(16526019)(53546011)(186003)(83380400001)(82740400003)(47076005)(478600001)(356005)(336012)(4326008)(2616005)(70586007)(8676002)(316002)(2906002)(7636003)(31696002)(36756003)(36860700001)(31686004)(26005)(86362001)(70206006)(8936002)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 16:10:10.7614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c995b44c-90b3-42cc-7814-08d92a97e452
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2951
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2021 6:54 PM, Pearson, Robert B wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/8/2021 6:53 AM, Edward Srouji wrote:
>>
>> On 6/8/2021 9:47 AM, Leon Romanovsky wrote:
>>> On Mon, Jun 07, 2021 at 11:54:29PM -0500, Pearson, Robert B wrote:
>>>> On 6/7/2021 11:41 PM, Leon Romanovsky wrote:
>>>>> On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
>>>>>> sorry/this time without the HTML.
>>>>>>
>>>>>> ====================================================================== 
>>>>>>
>>>>>>
>>>>>> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
>>>>>> Verify bind memory window operation using the new post_send API.
>>>>>> ---------------------------------------------------------------------- 
>>>>>>
>>>>>>
>>>>>> Traceback (most recent call last):
>>>>>>     File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line
>>>>>> 292, in
>>>>>> test_qp_ex_rc_bind_mw
>>>>>>       u.poll_cq(server.cq)
>>>>>>     File "/home/rpearson/src/rdma-core/tests/utils.py", line 538,
>>>>>> in poll_cq
>>>>>>       raise PyverbsRDMAError('Completion status is {s}'.
>>>>>> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is
>>>>>> Memory window
>>>>>> bind error. Errno: 6, No such device or address
>>>>>>
>>>>>> This test attempts to bind a type 2 MW to an MR that does not have
>>>>>> bind mw
>>>>>> access set and expects the test to succeed.
>>
>> You're right, looks like a test bug. I'll send a fix upstream.
>>
>> Can you please confirm that this solves your issue:
> Well I get further. I am hitting a seg fault in python at
>
>         client.qp.wr_rdma_write(new_key, server.mr.buf)
>
> in test_qp_ex_rc_bind_mw.
>
> I'm trying to track it down. I'm not very familiar with python and don't
> know how to run the test under gdb.
>
I don't see the issue on mlx devices / rxe.

You can use gdb for python using: "gdb python"

Then : "run <program>" e.g.: "run tests/run_tests.py -k 
test_qp_ex_rc_bind_mw" (if you ran the command from the rdma-core root dir).

You can set breakpoints for C functions as you regularly do. If you want 
to add a breakpoint to the python test, I suggest you do "import pdb; 
pdb.set_trace()" at the line you want to set the bp at.

Good luck.

> Thanks for the fix.
>
> Bob
>
>>
>> diff --git a/tests/test_qpex.py b/tests/test_qpex.py
>> index 4b58260f..c2d67ee8 100644
>> --- a/tests/test_qpex.py
>> +++ b/tests/test_qpex.py
>> @@ -149,7 +149,7 @@ class QpExRCBindMw(RCResources):
>>          create_qp_ex(self, e.IBV_QPT_RC, e.IBV_QP_EX_WITH_BIND_MW)
>>
>>      def create_mr(self):
>> -        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE)
>> +        self.mr = u.create_custom_mr(self, e.IBV_ACCESS_REMOTE_WRITE
>> | e.IBV_ACCESS_MW_BIND)
>>
>>>>> Does the test break after your MW series? Or will it break not-merged
>>>>> code yet?
>>>>>
>>>>> Generally speaking, we expect that developers run rdma-core tests and
>>>>> fixed/extend them prior to the submission.
>>>>>
>>>>> Thanks
>>>>>
>>>>>> Bob Pearson
>>>> Nope. I don't have real RNICs at home to test. But (see my note to
>>>> Zhu) the
>>>> non extended APIs do set the access flags correctly and the extended
>>>> test
>>>> case does not. The wr_bind_mw() function can't fix this for the test
>>>> case.
>>>> It has to set the access flags when it creates the MR and it didn't.
>>>> It is
>>>> possible that mlx5 doesn't check the bind access flag but that seems
>>>> unlikely.
>>> mlx5 devices support MW 1 & 2 and kernel checks that only these types
>>> can be accepted from the user space. This is why mlx5 doesn't need to
>>> check access flags again.
>>>
>>>     903 static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>>>     904 {
>>>
>>> ....
>>>
>>>     927         if (cmd.mw_type != IB_MW_TYPE_1 && cmd.mw_type !=
>>> IB_MW_TYPE_2) {
>>>     928                 ret = -EINVAL;
>>>     929                 goto err_put;
>>>     930         }
>>>
>>>
>>> Thanks
>>
>> I see that mlx5 checks the access flags in userspace only if MW_DEBUG
>> is turned on (in set_bind_wr()).
>>
>> I guess that's for the sake of performance, as it's part of the data
>> path.
>>
>>>> Bob
>>>>
