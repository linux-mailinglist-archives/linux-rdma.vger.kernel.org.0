Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8825B71B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 01:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBXHS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 19:07:18 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45648 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBXHR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 19:07:17 -0400
Received: by mail-pg1-f173.google.com with SMTP id 67so491043pgd.12;
        Wed, 02 Sep 2020 16:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e7FwOEGGEMeAosXGf3vEt7w+keSrNJPAi/ExRrKOBCU=;
        b=V4k7+7jchMBPctxWlfKyhAvuidJiYqetIm9pvUiyEgG23v35aQrxzCsSEXW90p4e2I
         kogls7hYKKvEOmQm5zGyJVQKA6PJyavt4iiV7l/SvWu5xaNtQdoxnMgPgPWcw6XgWrgm
         5Iz5X/96hHBqOV/tKxwFRxYJvXf9MfVq4pHrqo6Xy0XbYQrZnvgZjLpwai92hbqVrhGX
         BLVxMOfZB68DlZgrMzmFBsAgkBMuulp0sDTlThC5HL5Kl9FGVg/b8AxCrzBlc6Nhk/M/
         sNayhplD6geywI6Uot6BwAa2S7n+lm3jrfRngluGnBThBak21WSDtGijYsd57Yhx8X/Q
         +njQ==
X-Gm-Message-State: AOAM530GL6ERgfYDjsIyuiblgnybQ1iV42rO0yuOzwqS/P/RjOthWUTH
        dVICM722I3//fngeeeHYbqG9zSIDTXA=
X-Google-Smtp-Source: ABdhPJyNwqqk28YnUTSFsctPyYFjKwEJKzMtf3chE0SL+h36TuVZa5+3fkDIsos2ZSLZtqwzZAjlWA==
X-Received: by 2002:a17:902:bcc2:: with SMTP id o2mr604619pls.87.1599088036436;
        Wed, 02 Sep 2020 16:07:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:56b7:d2c3:23c8:7358? ([2601:647:4000:d7:56b7:d2c3:23c8:7358])
        by smtp.gmail.com with ESMTPSA id u15sm437742pjx.50.2020.09.02.16.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 16:07:15 -0700 (PDT)
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
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
Message-ID: <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org>
Date:   Wed, 2 Sep 2020 16:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-09-02 01:04, Danil Kipnis wrote:
> RTRS allows for reliable transmission of sg lists between two hosts
> over rdma. It is optimised for block io. One can implement a client
> and a server module on top of RTRS which would allow for reliable
> transmission to a group of hosts.
> 
> In the networking world this is called reliable multicast. I think one
> can say that reliable multicast is an equivalent to what is called
> "mirror" in the storage world. There is something called XoR network
> coding which seems to be an equivalent of raid5. There is also Reed
> Solomon network coding.
> 
> Having a reliable multicast with coding rdma-based transport layer
> would allow for very flexible and scalable designs of distributed
> replication solutions based on different in-kernel transport, block
> and replication drivers.
> 
> What do you think?

How will the resulting software differ from DRBD (other than that it
uses RDMA)? How will it be guaranteed that the resulting software does
not suffer from the problems that have been solved by the introduction
of the DRBD activity log
(https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?

Thanks,

Bart.
