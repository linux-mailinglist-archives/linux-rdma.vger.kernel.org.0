Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4223F7D6D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHYU7J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 16:59:09 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:33468 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhHYU7J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 16:59:09 -0400
Received: by mail-pg1-f179.google.com with SMTP id c17so973715pgc.0;
        Wed, 25 Aug 2021 13:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Kow7UKrxVD6AiqRm6eq3NGJVr+sW6S+dcRgPIDl3Ps=;
        b=hBVrlOcY6ahigPoPfG+8ZUApGfg9dZygP9/Zdgv3F/8OA8oPd55PtQNLQLkASQVm45
         YpCpS5z4HNsdCsj1PiLk1sd5bBiv2OMO0hafWb2k6NgEekKCBiiajKvR1zJX8OVx1gzf
         GAGPLEGiSbrhOn9pJRNjz7v5wXWbysRGIImlsVDtqxr5XiE9p8xCKBTCxw5Cp4yJKd1p
         GwFziFS6exDnc5IpXxyKfsBBjZ6Xqn9BhPssZJsDNQEE+TObYssx87e/lfJ/t/lU4jSh
         8G6DVRXIZc76+c+V7OnWS6+59eB79QlkaXUP4gPheIkKdScNFqhpd9jvDQ/zQcT0cB5H
         94Rg==
X-Gm-Message-State: AOAM530BXby5fPyvpMhyBPRXmBvis6qU+LP6goiiFXfpyLBs5j3meQc+
        QhtevaHmPbXzzl+Z4WcnuuHdPGYL6Dk=
X-Google-Smtp-Source: ABdhPJyPwwWl603fmMSJONEgdyLuNWSJDqhAlutv9RuDTPRLMWzGCJBm9pMZZJy3V9+aHqBt378vvA==
X-Received: by 2002:aa7:90c8:0:b029:32c:935f:de5f with SMTP id k8-20020aa790c80000b029032c935fde5fmr318962pfk.79.1629925102005;
        Wed, 25 Aug 2021 13:58:22 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5f7b:5bac:8246:4328])
        by smtp.gmail.com with ESMTPSA id w9sm6588123pjc.14.2021.08.25.13.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 13:58:21 -0700 (PDT)
Subject: Re: v5.14 RXE driver broken?
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
 <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
 <20210825163219.GY543798@ziepe.ca>
 <423ed740-96e7-aebb-3e6f-7416108f5a62@acm.org>
Message-ID: <bac1d404-ae2b-c6cc-a065-de2dab25bea9@acm.org>
Date:   Wed, 25 Aug 2021 13:58:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <423ed740-96e7-aebb-3e6f-7416108f5a62@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/21 11:22 AM, Bart Van Assche wrote:
> On 8/25/21 9:32 AM, Jason Gunthorpe wrote:
>> On Wed, Aug 25, 2021 at 11:02:14AM +0800, Zhu Yanjun wrote:
>>> On Tue, Aug 24, 2021 at 11:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>>
>>>> Hi Bob,
>>>>
>>>> If I run the following test against Linus' master branch then that test
>>>> passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
>>>> headers to staging"")):
>>>>
>>>> # export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
>>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
>>>>      runtime    ...  48.849s
>>>>
>>>> The following test fails:
>>>>
>>>> # export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
>>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
>>>>      runtime  48.849s  ...  15.024s
>>>>      +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
>>>>      @@ -1,2 +1 @@
>>>>       Configured SRP target driver
>>>>      -Passed
>>>
>>> Can this commit "RDMA/rxe: Zero out index member of struct rxe_queue"
>>> in the link https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc
>>> fix this problem?
>>>
>>> And the commit will be merged into linux upstream very soon.
>>
>> Please let me know Bart, if the rxe driver is still broken I will
>> definitely punt all the changes for RXE to the next cycle until it can
>> be fixed.
> 
> Hi Jason,
> 
> Thanks for having offered to revert the RXE changes from this merge window.
> Unfortunately that wouldn't be sufficient. My test results so far for test
> srp/002 in combination with the rdma_rxe driver are as follows:
> * Kernel v5.12: test passes.
> * Kernel v5.13: test fails.
> * Kernel v5.14-rc7: test fails.
> 
> For the rdma_rxe tests for kernel v5.14-rc7 I found the following in the kernel
> log:
> 
> ib_srp:add_target_store: ib_srp: max_sectors = 1024; max_pages_per_mr = 512; mr_page_size = 4096; max_sectors_per_mr = 4096; mr_per_cmd = 2
> ib_srp: enp1s0_rxe: ib_alloc_mr() failed. Try to reduce max_cmd_per_lun, max_sect or ch_count
> 
> There is sufficient memory available in the VM in which I ran the tests. It is
> not clear to me why ib_alloc_mr() fails with these parameters when using the
> rdma_rxe driver? As one can see in srp_alloc_fr_pool() the SRP initiator driver
> respects the max_pages_per_mr RDMA driver limit.

A correction: test srp/002 passes on my setup against kernel v5.13. I probably
selected the wrong kernel from the GRUB boot menu before I sent my previous email.
So the test failure is something that happens with v5.14-rc but not with v5.13.

Applying the following patch on top Linus' master branch did not help:

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 742e6ec93686..643b80e47c82 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -88,7 +88,7 @@ enum rxe_device_param {
  	RXE_MIN_SRQ_INDEX		= 0x00020001,
  	RXE_MAX_SRQ_INDEX		= 0x00040000,

-	RXE_MAX_MR			= 0x00001000,
+	RXE_MAX_MR			= 0x00100000,
  	RXE_MAX_MW			= 0x00001000,
  	RXE_MIN_MR_INDEX		= 0x00000001,
  	RXE_MAX_MR_INDEX		= 0x00010000,

Bart.
