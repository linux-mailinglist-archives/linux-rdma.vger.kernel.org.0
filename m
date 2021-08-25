Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C068D3F7C24
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 20:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhHYSXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 14:23:08 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:41774 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhHYSXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 14:23:07 -0400
Received: by mail-pl1-f172.google.com with SMTP id e15so76934plh.8;
        Wed, 25 Aug 2021 11:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dieBtvpbBQYqiM1LfPaD9SphzvScRdncN26mqrTQt14=;
        b=Ou7mK+82bCRHV/u1NZmGgu3DdvYN3w0mkXASHFA98IXQUuCyKpqdxM9l1dDSBuExcF
         72dy/1y0j+I7pLY3ETYPmYixQ2nrLtQ4jigD+8VSkSaC0/wRgxEZVQ4oFcJF941QCBm8
         IAr0kfIKbDpTe/MZFDXYKzYHxf4yM/+gjSJMJn7c/Qm3bzat+VdmOOCpJDg4UBD75+ye
         esCDk16iRTZ54LmHy8lTVhsU6tsYd4A3x2uvPZp7gdpLxge5WEem3mzoc+zGZ7L9RqyQ
         OsCMjciKAww4gOgZe+R+p/GZgNwfZV5I++eqnbHc1GY7olSw0eRT4QTTuu3J0Uq2OYIc
         Ruug==
X-Gm-Message-State: AOAM5326QOueSzHywlPNHAPV8oWqUqO7q2mKHlf5e+YjMblJbpWwGtFq
        tYbnmILJY4PW92Zzm2+Lel3+LYnTBiM=
X-Google-Smtp-Source: ABdhPJy3Zlt8+QA6rdbyDllwbwgzQvkK+ZD7N3SrpruNrKIZf7sZs0y8drVicz085Ll+WMOy4HpXIw==
X-Received: by 2002:a17:902:d0ce:b0:12d:c570:370c with SMTP id n14-20020a170902d0ce00b0012dc570370cmr39606581pln.40.1629915740884;
        Wed, 25 Aug 2021 11:22:20 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5f7b:5bac:8246:4328])
        by smtp.gmail.com with ESMTPSA id d4sm397678pfo.214.2021.08.25.11.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 11:22:20 -0700 (PDT)
Subject: Re: v5.14 RXE driver broken?
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
 <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
 <20210825163219.GY543798@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <423ed740-96e7-aebb-3e6f-7416108f5a62@acm.org>
Date:   Wed, 25 Aug 2021 11:22:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210825163219.GY543798@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/21 9:32 AM, Jason Gunthorpe wrote:
> On Wed, Aug 25, 2021 at 11:02:14AM +0800, Zhu Yanjun wrote:
>> On Tue, Aug 24, 2021 at 11:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>
>>> Hi Bob,
>>>
>>> If I run the following test against Linus' master branch then that test
>>> passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
>>> headers to staging"")):
>>>
>>> # export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
>>>      runtime    ...  48.849s
>>>
>>> The following test fails:
>>>
>>> # export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
>>>      runtime  48.849s  ...  15.024s
>>>      +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
>>>      @@ -1,2 +1 @@
>>>       Configured SRP target driver
>>>      -Passed
>>
>> Can this commit "RDMA/rxe: Zero out index member of struct rxe_queue"
>> in the link https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc
>> fix this problem?
>>
>> And the commit will be merged into linux upstream very soon.
> 
> Please let me know Bart, if the rxe driver is still broken I will
> definitely punt all the changes for RXE to the next cycle until it can
> be fixed.

Hi Jason,

Thanks for having offered to revert the RXE changes from this merge window.
Unfortunately that wouldn't be sufficient. My test results so far for test
srp/002 in combination with the rdma_rxe driver are as follows:
* Kernel v5.12: test passes.
* Kernel v5.13: test fails.
* Kernel v5.14-rc7: test fails.

For the rdma_rxe tests for kernel v5.14-rc7 I found the following in the kernel
log:

ib_srp:add_target_store: ib_srp: max_sectors = 1024; max_pages_per_mr = 512; mr_page_size = 4096; max_sectors_per_mr = 4096; mr_per_cmd = 2
ib_srp: enp1s0_rxe: ib_alloc_mr() failed. Try to reduce max_cmd_per_lun, max_sect or ch_count

There is sufficient memory available in the VM in which I ran the tests. It is
not clear to me why ib_alloc_mr() fails with these parameters when using the
rdma_rxe driver? As one can see in srp_alloc_fr_pool() the SRP initiator driver
respects the max_pages_per_mr RDMA driver limit.

Thanks,

Bart.
