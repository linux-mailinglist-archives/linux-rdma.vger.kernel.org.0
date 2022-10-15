Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498D15FF92D
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJOImD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 04:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJOImC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 04:42:02 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB7553A42
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 01:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1665823319; i=@fujitsu.com;
        bh=Meg7fNrnLnxuY/Ds7vWZIr2eFdKvbdBl2bg5XfjdXxY=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=mswg03x8+HB03sA0+KuqlEaCJs3XbNszNBlJ4gEyNVftTeDCxKW2hu3Elb3a4BXM1
         FBNyzjde9krmXKT0ifvB1zTns0421b+fBOzCHoN9qrWLWMeaiB6cpTOgJAF30oTGSj
         wvATf4IQcIRYu8ZmOBOj8G9gMGMl+pO094Roswsnq3GLsD60d3XNvJ3bRiZQrhpKt6
         UVp54xomgxDnJgEtEDktvXq5Y4P0PCvg0EqeJKtIPXDq1VhBhJHoIXWDP9T002T8hg
         Hip1idMXFe8+T51JJsDAtnVJXMpkujNanznZRBG7lr/fzuCe45WUGNRNtfjBtNQhT2
         Tapk7XWyatY1A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileJIrShJLcpLzFFi42Kxs+FI1A0r8ko
  26F3Fb3Hl3x5Giym/ljJbPDvUy2LxZeo0Zovzx/rZHVg9ds66y+6xaVUnm0dv8zs2j8+b5AJY
  olgz85LyKxJYM9qmT2ctOCVVMa1vEUsD4zfRLkYuDiGBLYwSc45dYoZwljNJrJrwh72LkRPI2
  cYoMX2FDojNK2An0bNuLhOIzSKgKrF50Rt2iLigxMmZT1hAbFGBJImrG+6ygtjCAg4SF94tZA
  EZKiIwmVHizfRD7CAOs8ArRomtzVcYITZYSsw48hSsm03AUWLerI1sIDangJXE5+ufwGxmAQu
  JxW8OskPY8hLNW2czg9gSAooSbUv+sUPYFRKzZrUxQdhqElfPbWKewCg0C8mBs5CMmoVk1AJG
  5lWMZsWpRWWpRbqGlnpJRZnpGSW5iZk5eolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5yTkpe
  nmpJZsYgVGTUsx2fQfjjGV/9A4xSnIwKYnyZmzxTBbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwX
  sx2ytZSLAoNT21Ii0zBxjBMGkJDh4lEd7MfKA0b3FBYm5xZjpE6hSjopQ47+8CoIQASCKjNA+
  uDZY0LjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5vUGGc+TmVcCNx0YGUA3i/AuPeUGsrgk
  ESEl1cAk9ZG96ZJ9xNkcdnZJ9XdXk66daOH58oqzk0Vqd0Tkn4RZnfoChiy3J6zjro2rKDV9x
  166d5bANc9zn5exvzBn2/21dH3YiuIJ7t7em5e+fniYKfzFrunHp2qHs+VMPfRg7/KbHh5v9y
  6df9N9htfB7+pKITon13wItb/afObZF7Pdc/z3J+hab3FPmDrvVX2WvSv/ovu7HzafUOyQO29
  1p+ON0JtF9/bMfV20Xddyt5v8u4d3b3cmqn9zDRR7OdU89Hu02pE5daG/G583vvEONA7YJyjb
  u0e0SjprS5XyrQMtFptP9e48fLDImOePoazT9J7CwoaSGT+DnS6urIy/vLlj1oTJn+vO+KvOT
  ZZapMRSnJFoqMVcVJwIAH8ZupSVAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-10.tower-587.messagelabs.com!1665823318!92837!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28429 invoked from network); 15 Oct 2022 08:41:58 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-10.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Oct 2022 08:41:58 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C57A5100191;
        Sat, 15 Oct 2022 09:41:57 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B95EC100043;
        Sat, 15 Oct 2022 09:41:57 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 15 Oct 2022 09:41:54 +0100
Message-ID: <bf3bca7e-e6c5-dbc2-a243-6fda5e24b04a@fujitsu.com>
Date:   Sat, 15 Oct 2022 16:41:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 0/8] RDMA/rxe: Add atomic write operation
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        =?UTF-8?B?TGksIFpoaWppYW4v5p2OIOaZuuWdmg==?= 
        <lizhijian@fujitsu.com>,
        =?UTF-8?B?R290b3UsIFlhc3Vub3JpL+S6lOWztiDlurfmloc=?= 
        <y-goto@fujitsu.com>, "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <20221015063648.52285-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, Bob

Thanks a lot for your review. I have updated the patch set according to 
your all comments except the missing kmap issue.

I didn't understand why current iova_to_vaddr() has been broken so I 
hope we can discuss the issue fully and then find a suitable solution.

Best Regards,
Xiao Yang

On 2022/10/15 14:37, Yang, Xiao/杨 晓 wrote:
> The IB SPEC v1.5[1] defined new atomic write operation. This patchset
> makes SoftRoCE support new atomic write on RC service.
> 
> On my rdma-core repository[2], I have introduced atomic write API
> for libibverbs and Pyverbs. I also have provided a rdma_atomic_write
> example and test_qp_ex_rc_atomic_write python test to verify
> the patchset.
> 
> The steps to run the rdma_atomic_write example:
> server:
> $ ./rdma_atomic_write_server -s [server_address] -p [port_number]
> client:
> $ ./rdma_atomic_write_client -s [server_address] -p [port_number]
> 
> The steps to run test_qp_ex_rc_atomic_write test:
> run_tests.py --dev rxe_enp0s3 --gid 1 -v test_qpex.QpExTestCase.test_qp_ex_rc_atomic_write
> test_qp_ex_rc_atomic_write (tests.test_qpex.QpExTestCase) ... ok
> 
> ----------------------------------------------------------------------
> Ran 1 test in 0.008s
> 
> OK
> 
> [1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
> [2]: https://github.com/yangx-jy/rdma-core/tree/new_api_with_point
> 
> v5->v6:
> 1) Rebase on current for-next
> 2) Split the implementation of atomic write into 7 patches
> 3) Replace all "RDMA Atomic Write" with "atomic write"
> 4) Save 8-byte value in struct rxe_dma_info instead
> 5) Remove the print in atomic_write_reply()
> 
> v4->v5:
> 1) Rebase on current wip/jgg-for-next
> 2) Rewrite the implementation on responder
> 
> v3->v4:
> 1) Rebase on current wip/jgg-for-next
> 2) Fix a compiler error on 32-bit arch (e.g. parisc) by disabling RDMA Atomic Write
> 3) Replace 64-bit value with 8-byte array for atomic write
> 
> V2->V3:
> 1) Rebase
> 2) Add RDMA Atomic Write attribute for rxe device
> 
> V1->V2:
> 1) Set IB_OPCODE_RDMA_ATOMIC_WRITE to 0x1D
> 2) Add rdma.atomic_wr in struct rxe_send_wr and use it to pass the atomic write value
> 3) Use smp_store_release() to ensure that all prior operations have completed
> 
> Xiao Yang (8):
>    RDMA: Extend RDMA user ABI to support atomic write
>    RDMA: Extend RDMA kernel ABI to support atomic write
>    RDMA/rxe: Extend rxe user ABI to support atomic write
>    RDMA/rxe: Extend rxe packet format to support atomic write
>    RDMA/rxe: Make requester support atomic write on RC service
>    RDMA/rxe: Make responder support atomic write on RC service
>    RDMA/rxe: Implement atomic write completion
>    RDMA/rxe: Enable atomic write capability for rxe device
> 
>   drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
>   drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++
>   drivers/infiniband/sw/rxe/rxe_opcode.h |  3 +
>   drivers/infiniband/sw/rxe/rxe_param.h  |  5 ++
>   drivers/infiniband/sw/rxe/rxe_req.c    | 15 ++++-
>   drivers/infiniband/sw/rxe/rxe_resp.c   | 84 ++++++++++++++++++++++++--
>   include/rdma/ib_pack.h                 |  2 +
>   include/rdma/ib_verbs.h                |  3 +
>   include/uapi/rdma/ib_user_verbs.h      |  4 ++
>   include/uapi/rdma/rdma_user_rxe.h      |  1 +
>   10 files changed, 132 insertions(+), 7 deletions(-)
> 
