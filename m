Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB59B1B9
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfHWORy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 10:17:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41240 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbfHWORy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Aug 2019 10:17:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id m24so9004082ljg.8
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=golem.network; s=google;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tzCi7ejmdr33Lx8YTUwMRmX9I0WBLbrMuyS2XUAys4U=;
        b=BK0j+Q7WocfO2PWy2drxQk1wtzj+/idYcOdCY7lGGH8vZyRr6ZsaayUBVYuUxgQKxp
         pJeERLftwHFHpHpfDYUXuz4S98EykpBctyli8vAFWkXfKmqXWGQbq2ksuOiXmcJ7B5TH
         ZZWDFSD5qb9VbGbeH/aHMISqS40Br145moYxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=tzCi7ejmdr33Lx8YTUwMRmX9I0WBLbrMuyS2XUAys4U=;
        b=oa5rX+FnwF9yXuzyLYn1hNWofsn2SX1G6CeRkpljrREjYdw7smheB/gOf60ihSoWSE
         7qxQgoSRiCzKD/u9G+AfYPVpTzrm5S+uTxk2e6bk2WXdJARiJGAEKX5jmmNaTLopdzuG
         GdK9aZTgbBaoeom48twDGwPNIdxCXzAdMG6UVk2S/1KZOs5Maa7C9aAwZOa470R2fNRG
         smsfwzGQe2cylnJMYeQD0lsaHNwBYDOSWk3LX4fAY2X2ast3gubygXb0ItbZu3ZVKO3/
         yYfRSgTWBVQPoNibNQa3tIXwp9S6BpxPCVbKjVbSUQrdYBKPQjBUFY8AivTCZNYiuckS
         Pj6A==
X-Gm-Message-State: APjAAAXys6VOlnKhpcrMmMCo6zejMKwsncCrGreaQRw6lr7mr3oEIeBb
        9yxuJs21ohqkJ3GmpxH7VAN/zOBv2aY=
X-Google-Smtp-Source: APXvYqw9Lxtfa/Zdc14HyKhQmrlRZNRcOy6yFavy/xQ7P6OaSSIrmALeCBeawchXK8AoLeBMl2nLcw==
X-Received: by 2002:a2e:5c45:: with SMTP id q66mr3048717ljb.197.1566569871346;
        Fri, 23 Aug 2019 07:17:51 -0700 (PDT)
Received: from [10.30.8.152] (5-226-70-4.static.ip.netia.com.pl. [5.226.70.4])
        by smtp.gmail.com with ESMTPSA id w196sm564284lff.80.2019.08.23.07.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 07:17:50 -0700 (PDT)
Subject: Re: Setting up siw devices
From:   Marcin Mielniczuk <marcin@golem.network>
To:     Leon Romanovsky <leon@kernel.org>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     linux-rdma@vger.kernel.org
References: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
 <20190822154323.GA19899@chelsio.com>
 <20190822155228.GH29433@mtr-leonro.mtl.com>
 <b4bf4bc2-8dc7-a2c2-6bd2-ab41d9fbadc9@golem.network>
Openpgp: preference=signencrypt
Autocrypt: addr=marcin@golem.network; prefer-encrypt=mutual; keydata=
 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
Message-ID: <945643c8-198e-f8bf-1e8f-536f77612db0@golem.network>
Date:   Fri, 23 Aug 2019 16:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4bf4bc2-8dc7-a2c2-6bd2-ab41d9fbadc9@golem.network>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While the device is detected by ibv_devices and rping works, I can't get
ibv_rc_pingpong working
(and as far as I understand, RC should be supported by the iWARP driver)

rping works:

    server$  rping -s -a 10.30.10.211 -v
    server ping data: rdma-ping-0:
ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
    server ping data: rdma-ping-1:
BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
    server DISCONNECT EVENT...
    wait for RDMA_READ_ADV state 10

    client$ rping -c -a 10.30.10.211 -C 2 -v
    (output omitted)


But ibv_rc_pingpong doesn't

    server$ ibv_rc_pingpong -d iwp____
      local address:  LID 0x0000, QPN 0x000001, PSN 0xb8aafc, GID ::
    Failed to modify QP to RTS
    Couldn't connect to remote QP
    client$ ibv_rc_pingpong  -d iwp____ 10.30.10.211
      local address:  LID 0x0000, QPN 0x000001, PSN 0x71abc5, GID ::
    client read/write: Protocol not supported
    Couldn't read/write remote address

dmesg says: [   93.957733] iwpm_register_pid: Unable to send a nlmsg
(client = 2)

And OpenMPI/UCX doesn't want to use the transport either:

    [1566564168.338103] [host:23059:0]         select.c:410  UCX  ERROR
no active messages transport to <no debug data>: mm/posix - Destination
is unreachable, mm/sysv - Destination is unreachable, self/self -
Destination is unreachable, rdmacm/sockaddr - no am bcopy, cma/cma - no
am bcopy

Is this a bug or a limitation of siw?
Thanks,
Marcin

On 22.08.2019 18:24, Marcin Mielniczuk wrote:
> Thanks a lot, this did the trick. I think this is worth documenting
> somewhere.
> Would README.md in the rdma-core repo be a good place?
>
> Why
>
> On 22.08.2019 17:52, Leon Romanovsky wrote:
>> On Thu, Aug 22, 2019 at 09:13:25PM +0530, Krishnamraju Eraparaju wrote:
>>> On Thursday, August 08/22/19, 2019 at 17:08:49 +0200, Marcin Mielniczuk wrote:
>>>> Hi,
>>>>
>>>> I'm trying to test the recently merged siw module.
>>>> I'm running kernel 5.3-rc5 (taken from the Ubuntu mainline-kernel
>>>> repository [1]) on Ubuntu 18.04 (bionic).
>>>> I also manually installed rdma-core 25.0 from tarball, using the
>>>> included Debian packaging. I installed all the packages but ibacm.
>>>>
>>>> After booting the new kernel I manually loaded the kernel module by
>>>>
>>>>      modprobe siw
>>>>      modprobe rdma_ucm
>>>>
>>>> Then ibv_devinfo shows: "No IB devices found".
>>>> dmesg only shows:
>>>>      [   29.856751] SoftiWARP attached
>>>>
>>>> According to this tutorial, [2] it should be enough to just load the siw
>>>> module. (unlike RXE, where one needs to use rxe_cfg to set up the
>>>> interface)
>>>> Is this a bug in siw or just a configuration issue on my side?
>>> Have you done "rdma link"?
>>>
>>> rdma link add <NAME> type siw netdev <NETDEV>
>>>
>>> http://man7.org/linux/man-pages/man8/rdma-link.8.html
>> BTW, the same goes for RXE and rxe_cfg is discouraged.
>>
>> Thanks
>>
>>>> Thanks,
>>>> Marcin
>>>>
>>>> [1] https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3-rc5/
>>>> [2] https://budevg.github.io/posts/tutorials/2017/04/29/rdma-101-1.html
>>>>
>

