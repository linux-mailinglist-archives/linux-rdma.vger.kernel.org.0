Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10A410102A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 01:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfKSAWv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 19:22:51 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:46058 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbfKSAWv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Nov 2019 19:22:51 -0500
Received: from [192.168.43.114] (unknown [116.236.165.137])
        by mail-app4 (Coremail) with SMTP id cS_KCgAn74jUNdNdVoPlAQ--.63071S3;
        Tue, 19 Nov 2019 08:22:44 +0800 (CST)
Subject: Re: [question]Why our soft-RoCE throughput is quite low compared with
 TCP
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
References: <f97b72b6-4def-2970-c9f6-f11b97d5378e@zju.edu.cn>
 <20191115160707.GG6763@unreal>
 <df9fb9b8-4b1f-2cf7-2498-648627556006@zju.edu.cn>
 <20191118094924.GA52766@unreal>
 <0bb80672-3980-04e7-5cf1-846b517ad53e@zju.edu.cn>
 <20191118122803.GC52766@unreal>
 <b522945c-6995-06de-b22c-9285fbe65d66@zju.edu.cn>
 <20191118144155.GE52766@unreal>
From:   wangqi <3100102071@zju.edu.cn>
Message-ID: <95220ca0-5df5-b70c-8f29-30410fd568c7@zju.edu.cn>
Date:   Tue, 19 Nov 2019 08:22:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118144155.GE52766@unreal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cS_KCgAn74jUNdNdVoPlAQ--.63071S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFykZw15ZFWxGFy3Gw4fuFg_yoW7urWDpF
        WrAF12yF1DJFn8Jw4jyr18X3W8tr9Yyw4UXr1UtrykJFn0yr1Utr18trWY9FyUWrn3Cr1j
        yr1UZry7XF1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
        82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
        Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0
        xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6w1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Zr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU5iL07UUUUU==
X-CM-SenderInfo: qtrqiiyqsqlio62m3hxhgxhubq/
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/11/18 下午10:41, Leon Romanovsky wrote:
> On Mon, Nov 18, 2019 at 08:56:35PM +0800, wangqi wrote:
>> On 2019/11/18 下午8:28, Leon Romanovsky wrote:
>>> On Mon, Nov 18, 2019 at 06:13:07PM +0800, wangqi wrote:
>>>> On 2019/11/18 下午5:49, Leon Romanovsky wrote:
>>>>> On Mon, Nov 18, 2019 at 02:38:19PM +0800, wangqi wrote:
>>>>>> On 2019/11/16 上午12:07, Leon Romanovsky wrote:
>>>>>>
>>>>>>> On Fri, Nov 15, 2019 at 09:26:41PM +0800, QWang wrote:
>>>>>>>> Dear experts on RDMA,
>>>>>>>>       We are sorry to disturb you. Because of a project, we need to
>>>>>>>> integrate soft-RoCE in our system. However ,we are very confused by our
>>>>>>>> soft-RoCE throughput results, which are quite low compared with TCP
>>>>>>>> throughput. The throughput of soft-RoCE in our tests measured by ib_send_bw
>>>>>>>> and ib_read_bw is only 2 Gbps (the net link bandwidth is 100 Gbps and the
>>>>>>>> two Xeon E5 servers with Mellanox ConnectX-4 cards are connected via
>>>>>>>> back-to-back, the OS is ubuntu16.04 with kernel 4.15.0-041500-generic). The
>>>>>>>> throughput of hard-RoCE and TCP are normal, which are 100 Gbps and 20 Gbps,
>>>>>>>> respectively. But in the figure 6 in the attached paper "A Performance
>>>>>>>> Comparison of Container Networking Alternatives", the throughput of
>>>>>>>> soft-RoCE can be up to 23 Gbps.  In our tests, we get the open-source
>>>>>>>> soft-RoCE from github in https://github.com/linux-rdma. Do you know how can
>>>>>>>> we get such high bandwidth? Do we need to configure some OS system settings?
>>>>>>>>       We find that in 2017, someone finds the same problem and he posts all
>>>>>>>> his detailed results on https://bugzilla.kernel.org/show_bug.cgi?id=190951  
>>>>>>>> . But it remains unsolved. His results are nearly the same with our's. For
>>>>>>>> simplicity,  we do not post our results in this email. You can get very
>>>>>>>> detailed information in the web page listed above.
>>>>>>>>       We are very confused by our results. We will very appreciate it if we
>>>>>>>> can receive your early reply. Best wishes,
>>>>>>>> Wang Qi
>>>>>>> Can you please fix your email client?
>>>>>>> The email text looks like one big sentence.
>>>>>>>
>>>>>>> From the perf report attached to this bugzilla, looks like RXE does a
>>>>>>> lot of CRC32 calculations and it is consistent with what Matan said
>>>>>>> a long time ago, RXE "stuck" in ICRC calculations required by spec.
>>>>>>>
>>>>>>> I'm curios what are your CONFIG_CRYPTO_* configs?
>>>>>>>
>>>>>>> ThanksCONFIG_CRYPTO_* configs
>>>>>>>
>>>>>>>
>>>>>> I'm sorry for the editor problem in my last email. Now I use another editor.
>>>>> Now your email has extra line between lines.
>>>>>
>>>>>> We get our rdma-core and perftest from
>>>>>>
>>>>>> https://github.com/linux-rdma/rdma-core/archive/v25.0.tar.gz
>>>>>> and https://github.com/linux-rdma/perftest/archive/4.4-0.8.tar.gz, respectively.
>>>>>>
>>>>>> We attach five files to clarify our problem.
>>>>>>
>>>>>> * The first file "server_tcp_vs_softroce_performance.txt" is the results of TCP
>>>>>>
>>>>>> and softroce throughput in our two servers (connected via back to back).
>>>>>>
>>>>>> * The second file "server_CONFIG_CRYPTO_result.txt" is the
>>>>>>
>>>>>> CONFIG_CRYPTO_* config results in the two servers..
>>>>>>
>>>>>> * The third file "server_perf.txt" is the "ib_send_bw - n 10000 192.168.0.20
>>>>>>
>>>>>> & perf record -ags sleep 10 & wait" results in our two servers (we use
>>>>>>
>>>>>> "perf report --header >perf" to make the file).
>>>>>>
>>>>>> * The fourth file "vm_tcp_vs_softroce_performance.txt" is the results of TCP
>>>>>>
>>>>>> and softroce throughput in two virtual machines with the latest linux kernel
>>>>>>
>>>>>> 5.4.0-rc7
>>>>>>
>>>>>> (we get the kernel from https://github.com/torvalds/linux/archive/v5.4-rc7.zip).
>>>>>>
>>>>>> * The fifth  file "vm_CONFIG_CRYPTO_result.txt" is the result in two virtual
>>>>>>
>>>>>> machines.
>>>>>>
>>>>>> * The sixth file "vm_perf.txt" is the "ib_send_bw - n 10000 192.168.122.228
>>>>>>
>>>>>> & perf record -ags sleep 10 & wait " result in the two virtual machines.
>>>>>>
>>>>>> On the other side, we tried to use the rxe command "rxe_cfg crc disable"
>>>>> I don't see any parsing of "crc disable" in upstream variant of rxe_cfg
>>>>> and there is no such module parameter in the kernel.
>>>>>
>>>>> Thanks
>>>> We get the command "rxe_cfg crc disable" from the following webpages:
>>>>
>>>> https://www.systutorials.com/docs/linux/man/8-rxe_cfg/
>>>>
>>>> https://www.reflectionsofthevoid.com/2011/08/
>>>>
>>>> It may be removed in the present soft-roce edition.
>>> It was never existed in upstream variant and in the kernel you are testing.
>>>
>>>> Can you figure out why our softroce throughput is so low from the six
>>> According to the logs, it is ICRC.
>>>
>>>> files in our last email? We hope to get a much higher softroce throughput,
>>>>
>>>> like 20 Gbps in our systems (now it's only 2 Gbps, and hard-roce can be
>>>>
>>>> up to 100 Gbps in our system).
>>>>
>>>> Qi
>>>>
>>>>
>> We try to use "rxe_cfg icrc disable" and "rxe_cfg ICRC disable", but it
>>
>> seems that the performance doesn't change at all.
> Why are you continuing to try "disable" if your kernel and rdma-core don't support it?
>
> Thanks
>
>> Qi
>>
>>
>>

Thank you.

Can you tell us the edition of OS, kernel and softroce in your system?

So we can install the same edition and make our softroce work well.

By the way, can you tell me the softroce throughput (measured by

ib_send_bw or ib_read_bw) and the TCP throughput (measured by

iperf) in your system?

Qi

