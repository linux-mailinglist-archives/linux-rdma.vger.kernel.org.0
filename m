Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1121CB2B
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2020 21:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgGLTwG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 15:52:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39075 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgGLTwG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jul 2020 15:52:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9so4526659plx.6;
        Sun, 12 Jul 2020 12:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dO5yhKcx3TVstL15EUrXTrP6cS7pNgdc/FFT2kCEn1c=;
        b=hBwn0QzwlWpUVhcIQdMRKauB4BiExr/UX5wua3ijAMeV2+dcQzQfjwwJZ3QXEpxfML
         6GvOHVdK0EjEFBWShvkFgOsYmukjGxJW7TZATIkrvXTQ9N51P7VcyjvFLqVhoaMWt81C
         Ff8LeHgRLfs8X0u1Nk2p4bqUzECC+e/CJqABIS1t7BpRK165JKJMAH5/Z/X9Rr7jL35u
         pUUcnleRmKOjth9PVKBo6TaOm6m4YbxGNuWamm+qVWK2IExRftPdIqmsWoZCLXzDqB46
         LgT8L319tgti+5ISvEnKnzKeLMKAOYVL/7xNRvJ9GkvyLhiybb5v51TsTyC+4CglHwSQ
         7m8A==
X-Gm-Message-State: AOAM533wYmO8cxTMJbJkQtxRzuzRkVhdTodUycXVuIXK17TSwwC3SEN+
        wD1EQhsyQw2Fky1De/BHh5TcxMtp
X-Google-Smtp-Source: ABdhPJzactO0ejDBhEssTONkZYgUAMe5eHla073wUvRdRBi3CbdjxIjwt/4sLEzjc6B+qeeT9p0QqA==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr17226340pjs.225.1594583524624;
        Sun, 12 Jul 2020 12:52:04 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id x3sm12424283pfn.154.2020.07.12.12.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 12:52:03 -0700 (PDT)
Subject: Re: [PATCH] SCSI RDMA PROTOCOL (SRP) TARGET: Replace HTTP links with
 HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200709194820.27032-1-grandmaster@al2klimov.de>
 <3d230abd-752e-8ac1-e18d-b64561b409ff@acm.org>
 <8fca4633-41ad-7e86-2354-36381bf5c734@al2klimov.de>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <bf85e454-cccc-37ef-d55f-d44a5c5c51df@acm.org>
Date:   Sun, 12 Jul 2020 12:52:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8fca4633-41ad-7e86-2354-36381bf5c734@al2klimov.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-07-10 11:12, Alexander A. Klimov wrote:
> Am 10.07.20 um 16:22 schrieb Bart Van Assche:
>> On 2020-07-09 12:48, Alexander A. Klimov wrote:
>>> diff --git a/drivers/infiniband/ulp/srpt/Kconfig b/drivers/infiniband/ulp/srpt/Kconfig
>>> index 4b5d9b792cfa..f63b34d9ae32 100644
>>> --- a/drivers/infiniband/ulp/srpt/Kconfig
>>> +++ b/drivers/infiniband/ulp/srpt/Kconfig
>>> @@ -10,4 +10,4 @@ config INFINIBAND_SRPT
>>>         that supports the RDMA protocol. Currently the RDMA protocol is
>>>         supported by InfiniBand and by iWarp network hardware. More
>>>         information about the SRP protocol can be found on the website
>>> -      of the INCITS T10 technical committee (http://www.t10.org/).
>>> +      of the INCITS T10 technical committee (https://www.t10.org/).
>>
>> It is not clear to me how modifying an URL in a Kconfig file helps to
>> reduce the attack surface on kernel devs?
>
> Not on all, just on the ones who open it.

Is changing every single HTTP URL in the kernel into a HTTPS URL the best
solution? Is this the only solution? Has it been considered to recommend
kernel developers who are concerned about MITM attacks to install a browser
extension like HTTPS Everywhere instead?

Thanks,

Bart.
