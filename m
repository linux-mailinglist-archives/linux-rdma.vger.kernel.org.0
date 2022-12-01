Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA34963F008
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 12:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLAL7B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 06:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiLAL7A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 06:59:00 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C791B9793E
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 03:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669895934; i=@fujitsu.com;
        bh=fnyPTTNyX7LUsAgFz1F/CQokYHNKXxje3DdQeoiMRcI=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=RgRQQb5BX3oIh+ZgkCnFXauPEJzM0/XSyW7BSih09f10irpZVO/ZKxOco/uL9p1Gf
         O+iR9BlOYTcVSE0H+N8Dm2U8pIZbHynC93jaCT28zN5cJzAgTQicxEUZ/VJgoBm4As
         LnTH/f93cuYroSnJ6IdEiup70/oU53YXmv0t6h2PZj6tT8cvRSryKUCEw9wlrR0Mvy
         T2av4THe4IWSFWYQVfxLpkZ7BympYqX1xdNPiWpyiSlDWJEXTG8gH8mRnMFzBWQaRX
         QYjfAoFuB0/janoWCQJYAfXGfqmh4AOwJnCSYidJdsmm7MEDtp/eqUuK0f3sUsAZSN
         1NKX6iP+ci34w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42Kxs+HYrPtvWke
  ywYILHBZX/u1htJjyaymzxbNDvSwWX6ZOY7Y4f6yf3YHVY+esu+wem1Z1snn0Nr9j8/i8SS6A
  JYo1My8pvyKBNaNzZTNrwQP+ii8Xn7I0MO7m7WLk4hAS2MgosW/7IxYIZwmTxILmG1DOVkaJs
  /uPMXYxcnLwCthJvF/wnB3EZhFQkVjSuZYZIi4ocXLmExYQW1QgSeLqhrusILawgIPEhXcLwe
  IiQPUnTpxhBxnKLLAIaMPRHWDNQgIREm3XfzGB2GwCahI7p78EauDg4BTQklhz1RwkzCxgIbH
  4zUF2CFteYvvbOWCtEgKKEm1L/rFD2BUSs2a1MUHYahJXz21insAoNAvJebOQjJqFZNQCRuZV
  jGbFqUVlqUW6hpZ6SUWZ6RkluYmZOXqJVbqJeqmluuWpxSW6RnqJ5cV6qcXFesWVuck5KXp5q
  SWbGIExk1KsuG4H4/Rlf/QOMUpyMCmJ8lZ3diQL8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuBtng
  qUEyxKTU+tSMvMAcYvTFqCg0dJhNcMJM1bXJCYW5yZDpE6xagoJc5rAJIQAElklObBtcFSxiV
  GWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrzhE4Gm8GTmlcBNfwW0mAlocaRYG8jikkSElFQD
  k/3teO21MeLek25MPHHkydG/Nc0SldNFcl6yGLEYfXpQv/nOScdb3EdWPesw5lDn+7b34cbyZ
  XKlDdJrksOEJtj2iaRylbAX1VzrSeFryxYJ/X7cee7M1yynCrxOd0qsTXRu51xfrLNV/CbLpE
  fq8rcnBJtx3Dgo7Ltrt/JGoT9fjAI/zG48JXl60UYp446lfc+Ohey55KPnP5EnX3F3Q/nTSSv
  +lRxNX+6n6NpuI7NqjvozTfZUbT3DSK+vde6ZFSbyywy38PJfX2R1g4XNYUtLRcoUl9tFTQqb
  Qv51uZSJiJY/aeBznc/kvX2/89SZzXeFfuzYcElWmGNl4baVvE9S4j5N3X2v+k3DWu9NSizFG
  YmGWsxFxYkAwzV7PJQDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-11.tower-548.messagelabs.com!1669895933!58508!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2789 invoked from network); 1 Dec 2022 11:58:54 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-11.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 11:58:54 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id D0717159;
        Thu,  1 Dec 2022 11:58:53 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id C3D1B153;
        Thu,  1 Dec 2022 11:58:53 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 11:58:50 +0000
Message-ID: <c10c62d4-fee9-4824-1383-8c6cdcf1c71c@fujitsu.com>
Date:   Thu, 1 Dec 2022 19:58:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 0/8] RDMA/rxe: Add atomic write operation
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
 <Y30o/2LDLO5bw+tA@nvidia.com>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <Y30o/2LDLO5bw+tA@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/11/23 3:54, Jason Gunthorpe wrote:
> On Sat, Oct 15, 2022 at 06:37:03AM +0000, yangx.jy@fujitsu.com wrote:
>> The IB SPEC v1.5[1] defined new atomic write operation. This patchset
>> makes SoftRoCE support new atomic write on RC service.
>>
>> On my rdma-core repository[2], I have introduced atomic write API
>> for libibverbs and Pyverbs. I also have provided a rdma_atomic_write
>> example and test_qp_ex_rc_atomic_write python test to verify
>> the patchset.
>>
>> The steps to run the rdma_atomic_write example:
>> server:
>> $ ./rdma_atomic_write_server -s [server_address] -p [port_number]
>> client:
>> $ ./rdma_atomic_write_client -s [server_address] -p [port_number]
>>
>> The steps to run test_qp_ex_rc_atomic_write test:
>> run_tests.py --dev rxe_enp0s3 --gid 1 -v test_qpex.QpExTestCase.test_qp_ex_rc_atomic_write
>> test_qp_ex_rc_atomic_write (tests.test_qpex.QpExTestCase) ... ok
>>
>> ----------------------------------------------------------------------
>> Ran 1 test in 0.008s
>>
>> OK
>>
>> [1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
>> [2]: https://github.com/yangx-jy/rdma-core/tree/new_api_with_point
>>
>> v5->v6:
>> 1) Rebase on current for-next
>> 2) Split the implementation of atomic write into 7 patches
>> 3) Replace all "RDMA Atomic Write" with "atomic write"
>> 4) Save 8-byte value in struct rxe_dma_info instead
>> 5) Remove the print in atomic_write_reply()
> 
> I think this looked OK, please fix the enum thing and also resolve all
> the remarks on the github and rebase/repost/retest both series.
Hi Jason,

Thanks for your reminder. I will do it soon.
In addition, I have resolved all remarks except the following one on github:
EdwardSro: "keep an empty line at EoF"
I: "I wonder why we need to add an empty line at EoF? I think there is 
no empty line at EOF in other files."

I hope you or EdwardSro can answer my question. ^_^

Best Regards,
Xiao Yang
> 
> Thanks,
> Jason
