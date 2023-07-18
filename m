Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE375808B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjGRPOK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjGRPOH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 11:14:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B1173B
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 08:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrRb9pqDL8JXhc2xXh4faV0U7Uo/GrOBI/GrljTQ1U1EEmKTYIEUI5atD0Cf0gANAOhv0YzX1JfFqx0eXBNBE/yLit90y4XEv6RtiqMOmmBs6TjgC162jUZ/LCJsCU2aoACE/QsIKpbJaYqrbJIsP2PN3ujJYoJoMv12mBjHaGBJZoadNcqCDwoXJQYjSzdl1L9w4gxs6L69gbYWtNMrUnEcy47+WhhMxPoPZaxpl/ufOMeoDeJQiRRH7C/Ldvu/pC9Eb6Gm9Hg95J+pLbxe1IxJIi5RKRCinmGFi2hwidGkMwyNPlDrYegM3b/oyayhxdZtdjSSiHK1SWPdF70PlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCE/YT9TJgyHfXTCH6fnt8cEZSYU3OEC7euWcKX2Iwg=;
 b=F6JOmn5LuC8O/mA55LptSauIl9w6ylbcwCswDLgKkixON4B8+iDrrg/TnH++vmkcPvK6e6XiSYSYuNBWEYgBJT9TamADKZ39JJ+f3G9/via0n9UsVua+cHp5nzPbxKhXv1OowZoiNRXSTH5L0jJ5nmYOmYKYkO1ULuW1Dd2cASgF8n6GtFMj5d14L2qd+EBFH6YnUl6YD52Jbc3lfJjtfivNJig0W3lbYTT4G6ziGTMBgyYY5QkhR2pPiq+TTUPF/Gr8EL7t+Ri8hc29GPlor89ATUlqWOIqYQbqGdHw3m/UNvDjdWqp3pu39AgbkY0rCGPxtwq1q789/Y9tRGtZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCE/YT9TJgyHfXTCH6fnt8cEZSYU3OEC7euWcKX2Iwg=;
 b=Qq788v3p+L7SzJEtZnQPhn+MG7eY3cYKRp3AxAImUufip+bP/evvSEj/YA5Pvulwk9k1T+GlgAF/DBtGFmTrkofeblwqnWu0wGx5Cau/q/K6gdsOsnrqqhSS3cyS2/WDFzU/20hiQpTlz0MWPlmX/gtgwttvI9G3zSbf/c2ZSJnt541HZWRFTXQdF60043F/QUrZKXkHCTxnmU7db6JNh1DSu6BcZTz6mk+5tO78ZUt4zwqPebC/Kfkr53oq5YOxFnMCO1c1A/ZeTEmp1rSXotO7jG4lVOrIBk/1xNUetHV9N2JBdGyA2W8re0lWMeGj7s82H1v1TjBRk97Bm2ncSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) by
 MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23; Tue, 18 Jul 2023 15:13:55 +0000
Received: from DM4PR12MB6592.namprd12.prod.outlook.com
 ([fe80::c0b5:b74f:6517:929]) by DM4PR12MB6592.namprd12.prod.outlook.com
 ([fe80::c0b5:b74f:6517:929%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:13:55 +0000
Message-ID: <94b33c65-e0b5-663a-f041-3b96df3ef977@nvidia.com>
Date:   Tue, 18 Jul 2023 18:13:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: pyverbs test_resize_cq fails in some cases
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
References: <f218337a-b975-bfa7-635d-bafc42c2df04@gmail.com>
 <b43c8172-a1c3-2ebd-e70e-198ae68248b5@gmail.com>
 <a958a957-dfe3-9348-632f-ee0c9af13238@gmail.com>
Content-Language: en-US
From:   Edward Srouji <edwards@nvidia.com>
In-Reply-To: <a958a957-dfe3-9348-632f-ee0c9af13238@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::12) To DM4PR12MB6592.namprd12.prod.outlook.com
 (2603:10b6:8:8a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6592:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: abd8945d-36ee-4c44-2bc2-08db87a19a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbcUaAdZZJeeKosgP+10a1+IQGDqpbyxhWZr3k5sNTDSy0h7oJsRnS+DZvFs+2/g9v7HV3PsVwsu3uSmzPQUELKsPAg7OKbjp8vLO5C2a+8gTda2Pv4mVbvOkN6+28Gf9MwUGXzEgNwr9ceU0JwT27B12wXAA8HArk1r0yQ5Yc0e2HLbcJdNC59CRo6MfUCrr9LuXyqhL129AU3ogeqB5qN91UJTw9di07oEGXhzjmlGVXwJheW0r7b5OO9wAvYgZyntsAqdXs29xLkP5DqtSnxDXco8arYS6KKcW80ej1o0Ip9fS6VbHxGHJbjtrk9Vtu22R/k6KJYXIi2ft0xQHP/409rI7gxyXeNyYXf9aRDJDz7FsyDJPg1nvjZf5WN8hG/30po53Bs20nl7xOItGhJV8ZUpoMUzhVrSsqbKvGtw8itPxtN0W6Vzf9RqwgqPGrMpr8/oxs66fU8Tky609Xxss3lA8CK9Ori2so6pP0rNWcAAi4mLimcs+0yjqqtSGAHFrIrD9y8diA88b76wyuTB7uVHi3AwvIafqVfkiSr77XcadPuODac1sw8HjpkPLCRbUh0i3jU94yp4c56Ill1sTxiqZerXlxpMTqzbzz2jwoWqTc92KIsrHpnkxyQ0CvmqdPW54AM8Fm+QJREdUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(31686004)(8676002)(8936002)(316002)(66556008)(66476007)(6636002)(5660300002)(66946007)(41300700001)(38100700002)(83380400001)(110136005)(478600001)(2906002)(2616005)(26005)(6506007)(6512007)(6486002)(86362001)(36756003)(186003)(31696002)(6666004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDJlbW9qUEVMRi9nVnNYcGk5ZEpnemRtaTVIQlN5VWE0ZlJJV2RGVDl5U0s1?=
 =?utf-8?B?ek5aL1l3TnYzZVVCbVJCNDBTQmtGcGtnWG0rZGNxb1NnUUN4c3FyRzlNRnpS?=
 =?utf-8?B?S1hlb0tJSFg0T052V3JmMXVmQkVaMmhTUGR4dVRmaHErTU5UNWhSRXlGRzBw?=
 =?utf-8?B?bVdKSUo2VGMvbjBVZjJpL3pIMUpBQ1hnYlQ0Yi95S0E2U2c3TXp4aWZ3dlEx?=
 =?utf-8?B?NkVQQ1Y1MGgrUElsZGR3NCtRSFRoQlNDbEJMWGczd1VaSlR2ellPTWxnV1JN?=
 =?utf-8?B?aFZweEsvczhzTEZRbE1QYXUwdk1PVENRd2VMem53UXh3UGo2OHptU3VMS1d4?=
 =?utf-8?B?MGV4V2lDRDV0Z0RzUVVNblV5eEdOM05QWkZLa2Q3YnU3TDBFT2N4TXFQSjVm?=
 =?utf-8?B?bEJGOVJFdmlESEh1UHNtZHhyMXdpN3F3S3M4dHJsK2NSTm5uK29ITWNXK3Zo?=
 =?utf-8?B?bVdUSjBPTTRXbUdqZjZWOW9wVFpTSTdQWC95TjVIeHJsUVNCV3pxMCszRElZ?=
 =?utf-8?B?ekNwRVMwdGVTNnR1Yml5RnJxb3AzaVkwMlBjUVI0VW5kS01uYW5HRkQxa2s5?=
 =?utf-8?B?UHVzNE11OXNLNDRqVG1vYTZOME0rMzFPd2E3MEt0Y0hMTVFKcWtFV1k1US9I?=
 =?utf-8?B?c29xbVkrU3JKS0VWcm42aVFGdUZQdHM3K3R1T1YvUlVmSHdRYVNQSnNLbTRu?=
 =?utf-8?B?MkNVSEpGS0swOCsyTUZ6bEJUekkzNlhYbFVISzV6UEFiNDBwbDJpdmJlM1Np?=
 =?utf-8?B?L2pVM2kyYTlNMzJORUdiYktXVmJFUE9lMjZvTkFqUW9yaHVKdDJmeEYvcWNn?=
 =?utf-8?B?RDFZM2VGaThDd0ZZWkZYZ01CN1FXTmtnODU4VGQ0VjZ6amhBV0hxR0ZqeEFu?=
 =?utf-8?B?c3hxbjFLMzNmdVJkT1l1c0ZXUGFaaGM5em1Qc1dYeFloLzJ4S09CZzZ3RkZ6?=
 =?utf-8?B?aVdFYVRydjFvb0NlSWZxQnBCbFhXRU4vT0duRkhnbnhqYmFrODh6OHZUaEI4?=
 =?utf-8?B?Z3gwVkxkdU4wZzhrRzdMcXYwRnZqNnpjSzZtejByNkRZV3N4ano2ckpGOXlE?=
 =?utf-8?B?VUgxSTRuTE1FUThrQ0UzYUY4QWlyajU1ZXpjenRSbi9MVm5nUmd5ZzZrVE5W?=
 =?utf-8?B?WnJ1SlZrNFJITG93Kys4ZFRJNHByNERkcWxzM1g5V3Z4QnRacUV5K1FTK0hm?=
 =?utf-8?B?aDZUVDVKOEFNaUppbmxZQkRoUmhmTjlTQzJFWjk1T1JITTJ0cUV4b1lVdEx6?=
 =?utf-8?B?cGlreGNDTTdIMlVVUm5EbVlvSFVna0hQNDJUejgySktrZ2gxRE5LWUhzRGFo?=
 =?utf-8?B?V1JrVFJJRmx3MHhzbzRkTU1DSHRkVmNPSXBJaWtLRXFlRE1SQ2g3bGhvc09t?=
 =?utf-8?B?TWNWamppanBYTU9BVUtSQ3J6cEV1ZjZWaytEcTIyNUZwcmpPczRNZUp5Mkd1?=
 =?utf-8?B?YWVvZFBsUEhjeTJnblNwc1BpL2hGSFNqY3FhK0ZNWVF4dTVCVjVRZ3dyWGxM?=
 =?utf-8?B?ZjNIUnM1NkVkU2JZZDFHZVRJL1lqQ2o2UVlhcjZkaDJlS1ZoRW94T21yRFFN?=
 =?utf-8?B?c0FoSjZMWXNHNlc2djlxM0xYWVEzdmRmS3dkOFNPZHFCZ2N3QXhLSmVxQm9l?=
 =?utf-8?B?V29nbDBlM1lnajlITzN1ckVyOCtycTV2VTlpSitUVUZMQ3F0Zmx5S1pDV0pa?=
 =?utf-8?B?a0NtTVpNd2RLMnZrM1YyemFPcnkyTDNhbksxMkkrcHRBeDhyTzhNS0lROWpD?=
 =?utf-8?B?REtMUXBKSUdLWTVUVXhDekxCTmdnKzZrSHF1QzZRTG51M3NTZ0NQemM1MkFP?=
 =?utf-8?B?N3NTaXlkNjJRM0tYaE5palZ6M1k1U1hkWGtpVDNzZWVxZWZWa3BNVDdSRWNI?=
 =?utf-8?B?WnFPdzBodWtOazUyek02Y3ExVkNwUkxRZnArWmxiQkVNNTdNRVh1YkQ2NG5U?=
 =?utf-8?B?bUhjZmRwL2hMaDBhMlROS2M1elNTRnc1bUxCNGViRWdNQnB2ZUMzTmQ5dkNj?=
 =?utf-8?B?MC9pZGJzdTJsZUc5R0lXZ1BrZ20xRWtsYkNsRG1pd2Y2RE1MQ1lma0hEOU1X?=
 =?utf-8?B?M0hLL1hhNlhxaFB3SnBwU3JPcENSWUtqWXVNTGJiaWJyQ2k1ZGtUZWpwLzFT?=
 =?utf-8?Q?mgRcXs3VsD6VjPXKTbIQV/nDa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd8945d-36ee-4c44-2bc2-08db87a19a0b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6592.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:13:54.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExlVSze2VcWJz2yPm6nOcHqPqBdCYwnK13u08JM7FmsQKi3PQiE7XnlYu1uCPjz3ldlXNv/EI+DkQT9jZLpmAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/18/2023 5:08 AM, Bob Pearson wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/23/23 21:38, Bob Pearson wrote:
>>
>>
>> -------- Forwarded Message --------
>> Subject: pyverbs test_resize_cq fails in some cases
>> Date: Thu, 23 Mar 2023 21:37:28 -0500
>> From: Bob Pearson <rpearsonhpe@gmail.com>
>> To: Edward Srouji <edwards@nvidia.com>
>> CC: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
>>
>> Edward,
>>
>> The pyverbs test: test_resize_cq fails for the rxe driver in some cases.
>>
>> The code is definitely racy:
>>
>> def test_resize_cq(self):
>>          """
>>          Test resize CQ, start with specific value and then increase and decrease
>>          the CQ size. The test also check bad flow of decrease the CQ size when
>>          there are more completions on it than the new value.
>>          """
>>          self.create_players(CQUDResources, cq_depth=3)
>>          # Decrease the CQ size.
>>          new_cq_size = 1
>>          try:
>>              self.client.cq.resize(new_cq_size)
>>          except PyverbsRDMAError as ex:
>>              if ex.error_code == errno.EOPNOTSUPP:
>>                  raise unittest.SkipTest('Resize CQ is not supported')
>>              raise ex
>>          self.assertTrue(self.client.cq.cqe >= new_cq_size,
>>                          f'The actual CQ size ({self.client.cq.cqe}) is less '
>>                          'than guaranteed ({new_cq_size})')
>>
>>          # Increase the CQ size.
>>          new_cq_size = 7
>>          self.client.cq.resize(new_cq_size)
>>          self.assertTrue(self.client.cq.cqe >= new_cq_size,
>>                          f'The actual CQ size ({self.client.cq.cqe}) is less '
>>                          'than guaranteed ({new_cq_size})')
>>
>>          # Fill the CQ entries except one for avoid cq_overrun warnings.
>>          send_wr, _ = u.get_send_elements(self.client, False)
>>          ah_client = u.get_global_ah(self.client, self.gid_index, self.ib_port)
>>          for i in range(self.client.cq.cqe - 1):
>>              u.send(self.client, send_wr, ah=ah_client)
>>
>>        ### This posts 6 send work requests but does not wait for them to complete
>>        ### The following proceeds while the sends are executing in the background
>>        ### and the test can fail. An easy fix is to add the line
>>          time.sleep(1/1000)  ### or maybe something a little larger but this works for me.
>>        ### alternatively you could test the data at the destination.
>>
>>          # Decrease the CQ size to less than the CQ unpolled entries.
>>          new_cq_size = 1
>>          with self.assertRaises(PyverbsRDMAError) as ex:
>>              self.client.cq.resize(new_cq_size)
>>          self.assertEqual(ex.exception.error_code, errno.EINVAL)
>>
>> Bob
> Edward,
>
> This is showing up again. The software drivers are slower than the hardware drivers.
> Now that the send side logic in the rxe driver is handled by a workqueue and if it is
> scheduled instead of running inline this test will fail some percentage of the time.
> Especially when the test is run for the first time but 5-10% of the time after that.
> If you run the send side logic inline it is fast enough that the test doesn't fail but
> that doesn't allow the workqueue tasks to spread out on the available cores so for high
> QP count it is much better to schedule them.
>
> There are a few time.sleep(1) calls in the pyverbs test suite but that is wasteful and
> better is time.sleep(0.001) which works fine for this test and doesn't slow down the
> run time for the whole suite noticeably.

I prefer not to add a sleep (the only sleeps are in mlx5_vfio test which 
is required to wait for the port to become up - but it's not run by 
default until the user specifically configure an mlx5_vfio device).

What if we poll the CQ for one completion, to make sure that the driver 
had the time to publish a CQE (which might be enough "time" for us)?
i.e.

$ git diff
diff --git a/tests/test_cq.py b/tests/test_cq.py
index 98485e3f8..e17676304 100644
--- a/tests/test_cq.py
+++ b/tests/test_cq.py
@@ -123,6 +123,7 @@ class CQTest(RDMATestCase):
          ah_client = u.get_global_ah(self.client, self.gid_index, 
self.ib_port)
          for i in range(self.client.cq.cqe - 1):
              u.send(self.client, send_wr, ah=ah_client)
+        u.poll_cq(self.client.cq)

          # Decrease the CQ size to less than the CQ unpolled entries.
          new_cq_size = 1

Could you try to see if that solves the issue for you?

>
> Bottom line this test case is racy.
>
> If you want I can submit a 2 line patch that does this. Or if you would that would be
> better.
>
> Bob
