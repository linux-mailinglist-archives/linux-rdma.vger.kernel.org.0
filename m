Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC43F4614
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhHWHx7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbhHWHx4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 03:53:56 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C43FC061756
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 00:53:14 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso2401364otv.12
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fhbq2/abxYXzkMU0QUXWEbc9H+P74AmWaWw/g6ifL8I=;
        b=GOVT2Tox2PhiQgLOv0jnAulASb3VzWaQiKRUBFttGj6atGFaqs1JjRsDLiOFJ8EZP1
         NK84GPOoEZn+IjXoUnU6TS0uci1ki18t76KVgVIGolnWW4s68FFk1cxwDQB9zZfYJ+eg
         1NtIz1UfK1siDOwg9pcTylU65bOTQcv3cILS/TJXok4pYzVKIX//4BjgXg0tYDd7pU2z
         wnInkGuViNZV4CtL3ghxGyPyD/2g+8kQi7svDyQYq2hEza73ycsUcYm4e66wik8I6E+1
         7FY2ERKupGDFithNpVYVGvdtYmXrGFzEHBmsgKAUJYNvnzdZ+tY1svb804TdIRzlWmht
         Ae2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fhbq2/abxYXzkMU0QUXWEbc9H+P74AmWaWw/g6ifL8I=;
        b=pDUG+qQT4lRl8PmlH93NSKfsIZs+qbLiHmihbhkt1wsZTNH2GH8nC0BNfvTzymmYoD
         FIrVZQl2eKWUpSuldUDvAQ4ycL0Ni0rx33jvIZ1ynFTHECzO4WwSSywAWTm2APig+qP8
         gaHtze/hPerbo32YzldMXiIOffJU02nfmksLM7LupOCvZBYOuyYkGgUm8BkIgCnCTkYq
         pQHFbwhI70tIRbEIveOwNB77uRLqGK4qxVmoshjZpatEUSnJqKo+P1Zn+4gwRQFOMqi/
         u7sNIUg8L+s3bfiNL31hY+C5rFMT3a0RJItFOHqHvNQHRCuEQV5F0dzcxWQ9T3MQsZSm
         1ZLg==
X-Gm-Message-State: AOAM532dB87pxBSZolNoR87D+KahsZa1C9M208bt/78TfMYGgCiHn2AN
        DygzD/0vFHJrY0ng3WQKLFTXL+4hWDRLYEh5ENI=
X-Google-Smtp-Source: ABdhPJwsHbUWU+GieSw1/N+h+gHXaT96F6RIZYGzeDubFsjRzjOd8kblhnBGHCk4MmwdWeeKZuuHLzXng37jlhjJUMg=
X-Received: by 2002:aca:2216:: with SMTP id b22mr10216674oic.163.1629705193663;
 Mon, 23 Aug 2021 00:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <YQmF9506lsmeaOBZ@unreal>
In-Reply-To: <YQmF9506lsmeaOBZ@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 23 Aug 2021 15:53:02 +0800
Message-ID: <CAD=hENdad8RGTLo82UBf3k+koQVX1oHSXMz6HfRvUxrL4dttsw@mail.gmail.com>
Subject: Re: RXE status in the upstream rping using rxe
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 4, 2021 at 2:07 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> Hi,
>
> Can you please help me to understand the RXE status in the upstream?

Hi, all

On the Ubuntu 20.04, kernel: 5.4.0-80, with the latest rdma-core,

"
root@xxx:~/rdma-core# cat /etc/issue
Ubuntu 20.04.2 LTS \n \l
root@xxx:~/rdma-core# uname -a
Linux 5.4.0-80-generic #90-Ubuntu SMP Fri Jul 9 22:49:44 UTC 2021
x86_64 x86_64 x86_64 GNU/Linux
root@xxx:~/rdma-core# git log -1 --oneline
206a0cfd (HEAD -> master, origin/master, origin/HEAD) Merge pull
request #1047 from yishaih/mlx5_misc
"

Run run_tests.py, I got the following errors.

Not sure if it is a problem. Please comment on it.

It is easy to reproduce on Ubuntu 20.04 + 5.4.0-80.

"
.............sssssssss..FFF........sssssssssssssss.sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss.ssssssssssssssssssssssssss....s...ss..........s....s..s.......ssReceived
the following exceptions: {'active': BrokenBarrierError()}
EReceived the following exceptions: {'active': BrokenBarrierError()}
E........ss
======================================================================
ERROR: test_rdmacm_async_ex_multicast_traffic (tests.test_rdmacm.CMTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/utils.py", line 976, in inner
    return func(instance)
  File "/root/rdma-core/tests/test_rdmacm.py", line 42, in
test_rdmacm_async_ex_multicast_traffic
    self.two_nodes_rdmacm_traffic(CMAsyncConnection,
  File "/root/rdma-core/tests/base.py", line 368, in two_nodes_rdmacm_traffic
    raise(res)
threading.BrokenBarrierError

======================================================================
ERROR: test_rdmacm_async_multicast_traffic (tests.test_rdmacm.CMTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/utils.py", line 976, in inner
    return func(instance)
  File "/root/rdma-core/tests/test_rdmacm.py", line 36, in
test_rdmacm_async_multicast_traffic
    self.two_nodes_rdmacm_traffic(CMAsyncConnection,
  File "/root/rdma-core/tests/base.py", line 368, in two_nodes_rdmacm_traffic
    raise(res)
threading.BrokenBarrierError

======================================================================
FAIL: test_phys_port_cnt_ex (tests.test_device.DeviceTest)
Test phys_port_cnt_ex
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_device.py", line 222, in
test_phys_port_cnt_ex
    self.assertEqual(phys_port_cnt, phys_port_cnt_ex,
AssertionError: 1 != 0 : phys_port_cnt_ex and phys_port_cnt should be
equal if number of ports is less than 256

======================================================================
FAIL: test_query_device (tests.test_device.DeviceTest)
Test ibv_query_device()
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_device.py", line 63, in test_query_device
    self.verify_device_attr(attr, dev)
  File "/root/rdma-core/tests/test_device.py", line 187, in verify_device_attr
    assert attr.vendor_id != 0
AssertionError

======================================================================
FAIL: test_query_device_ex (tests.test_device.DeviceTest)
Test ibv_query_device_ex()
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/rdma-core/tests/test_device.py", line 206, in test_query_device_ex
    self.verify_device_attr(attr_ex.orig_attr, dev)
  File "/root/rdma-core/tests/test_device.py", line 187, in verify_device_attr
    assert attr.vendor_id != 0
AssertionError

----------------------------------------------------------------------
Ran 205 tests in 40.112s

FAILED (failures=3, errors=2, skipped=137)
Traceback (most recent call last):
  File "device.pyx", line 170, in pyverbs.device.Context.close
AttributeError: 'NoneType' object has no attribute 'debug'
Exception ignored in: 'pyverbs.device.Context.__dealloc__'
Traceback (most recent call last):
  File "device.pyx", line 170, in pyverbs.device.Context.close
AttributeError: 'NoneType' object has no attribute 'debug'
"


>
> Does we still have crashes/interop issues/e.t.c?
>
> Latest commit is:
> 20da44dfe8ef ("RDMA/mlx5: Drop in-driver verbs object creations")
>
> Thanks
