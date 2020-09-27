Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396C8279CFF
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Sep 2020 02:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgI0ADz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 20:03:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36539 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgI0ADy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Sep 2020 20:03:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id x16so4524853pgj.3;
        Sat, 26 Sep 2020 17:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c+v/1vhUED7NCVLTHCvDvlN3BK3YOaivzMidjWkUkwM=;
        b=GbtlLNa2HUF/bKCuLx593HAbBETxJByxOquddkt83muyskoBCgRECZtGMpl86QH0Pf
         cav9GopyhjrOm/O4oPHiqGrVD4k0x68JukUNi4UH6rrKRlkHCLWAX8RmGpX3E1pfEJYR
         aUOJ4K1tEN977Dcs8v0K/WxgjLA2ONUZ61vqB85GDZiuMl8hEew9ohcUikAbTojy4GTT
         FqtanIUhtivqchwkcq5onyDBVJXEHhfXq/VUuNnc/5rjNW2b/p270lGoGLfOM3P0lgLQ
         XyR/JJQR6cfB9xTY7he4IEKGvAJHNAVwp25QWkeyJ+cRIeJQC8juc3jJCvnvtMIqr/ub
         z3Sw==
X-Gm-Message-State: AOAM533JiQewdNZCM5EC8EC6lGikP2CyJEAu5sPiH+SFdZ5V58PeajMu
        HzPcoATVnPtayVssdy7xUS8+ANfr3Pg=
X-Google-Smtp-Source: ABdhPJwVYpgeeAo5D1PiHzFK0TMHdpQVx8TfRfbKfSZHMpgOIsj0YseHpsvQZpPRnOJGdAbsdGe6JQ==
X-Received: by 2002:a63:4b14:: with SMTP id y20mr4220253pga.203.1601165033177;
        Sat, 26 Sep 2020 17:03:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9c9b:4523:362b:c165? ([2601:647:4000:d7:9c9b:4523:362b:c165])
        by smtp.gmail.com with ESMTPSA id g23sm6628924pfh.133.2020.09.26.17.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 17:03:52 -0700 (PDT)
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <3b2f6267-e7a0-4266-867d-b0109d5a7cb4@acm.org>
 <CAHg0HuyGr8BfgBvXUG7N5WYyXKEzyh3i7eA=2XZxbW3zyXLTsA@mail.gmail.com>
 <cc14aa58-254e-5c33-89ab-6f3900143164@acm.org>
 <CAHg0HuxJ-v7WgqbU62zkihquN9Kyc9nPzGhcung+UyFOG7LECQ@mail.gmail.com>
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
Message-ID: <a1446914-1388-40af-4204-5ef8b7618b42@acm.org>
Date:   Sat, 26 Sep 2020 17:03:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuxJ-v7WgqbU62zkihquN9Kyc9nPzGhcung+UyFOG7LECQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-09-09 04:42, Danil Kipnis wrote:
> On Fri, Sep 4, 2020 at 5:33 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> On 2020-09-04 04:35, Danil Kipnis wrote:
>>> On Thu, Sep 3, 2020 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>>> How will it be guaranteed that the resulting software does
>>>> not suffer from the problems that have been solved by the introduction
>>>> of the DRBD activity log
>>>> (https://www.linbit.com/drbd-user-guide/users-guide-drbd-8-4/#s-activity-log)?
>>>
>>> The above would require some kind of activity log also, I'm afraid.
>>
>> How about collaborating with the DRBD team? My concern is that otherwise
>> we will end up with two drivers in the kernel that implement block device
>> replication between servers connected over a network.
> 
> I have two general understanding questions:
> - What is the conceptual difference between DRBD and an md-raid1 with
> one local leg and one remote (imported over srp/nvmeof/rnbd)?

I'm not sure there is a conceptual difference. But there will be a big
difference in recovery speed after a temporary network outage (assuming that
the md-raid write intent bitmap has been disabled).

> - Is this possible to setup an md-raid1 on a client sitting on top of
> two remote DRBD devices, which are configured in "active-active" mode?

I don't think that DRBD supports this. From the DRBD source code:
"this code path is to recover from a situation that "should not happen":
concurrent writes in multi-primary setup."

Bart.
