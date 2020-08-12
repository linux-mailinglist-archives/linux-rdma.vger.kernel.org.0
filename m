Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B6B242DE6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Aug 2020 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgHLROV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Aug 2020 13:14:21 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34955 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHLROV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Aug 2020 13:14:21 -0400
Received: by mail-pj1-f67.google.com with SMTP id t6so1470977pjr.0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Aug 2020 10:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eHS6JYFw+sIP71nG7bXZd0SU419jhqort8c6lUr3BeQ=;
        b=T7g0WrfEgV8nArGnKP0n3vSGTAGlf9x8Hb+4OCdvHTtdG5EdnQXethFmjsLOdV9oLv
         CAElFezIKlYdDUkRLQ8Nedv70QbGTgrSy7GdVWHXhbY8vPA4MOeIzmAuiXRFF1l7KBl+
         XasKx9ErUynx5z66EHVV0PhG5l516Xt8q7oBfZHqNIx5SSUXmE4uIs4redlFiMFaXEnu
         JHKAGPa4fJ9pCpsPhfKOIe3qj4CsZxH+vu+enVupvqe9goFEhtQ+lUPt6goufOwYCPTt
         Whz5Zhh/7knPSxzx5hi5cAAhz0AI4SWJlCyAxnD/ZY6/roQlqfQHvHlel5NhmjqveYI5
         YnNA==
X-Gm-Message-State: AOAM532rD5zeVakSmbFNng1SfQf5ai13BoGNbMzaEpwCSUG2eTegKsQG
        HDfer15LWgw1uN+MYZfHnEg=
X-Google-Smtp-Source: ABdhPJzZBzSCrE1m3nNsWMNYDt8oxbPo3Wm2CRVTTU4Wx18cA26B+7ew5r/DKfbexHhpgrB87cEgGg==
X-Received: by 2002:a17:902:fe04:: with SMTP id g4mr380039plj.69.1597252460267;
        Wed, 12 Aug 2020 10:14:20 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id l19sm3095655pff.8.2020.08.12.10.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 10:14:18 -0700 (PDT)
Subject: Re: Is there a simple way to install rdma-core other than making a
 package?
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
References: <75bbc81e-cde9-c8ac-0ba3-04bf17b8d5fa@gmail.com>
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
Message-ID: <23cc5656-882f-f8a8-426c-ff065cb0b969@acm.org>
Date:   Wed, 12 Aug 2020 10:14:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <75bbc81e-cde9-c8ac-0ba3-04bf17b8d5fa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-08-11 20:41, Bob Pearson wrote:
> There doesn't seem to be a documented way to make install rdma-core, at least in the README file. However trying the obvious
> 
> $ bash build.sh
> $ cd build
> $ sudo make install
> 
> seems to work, almost. After a few 100 lines of promising output I get
> 
> CMake Error at librdmacm/cmake_install.cmake:76 (file):
>   file INSTALL cannot find
>   "/home/rpearson/src/rdma-core-git/build/lib/librdmacm.so.1.3.31.0": No such
>   file or directory.

This is how I do this myself:

export EXTRA_CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=Debug -DENABLE_WERROR=1" &&
    mkdir -p build &&
    cd build &&
    cmake -G Ninja CFLAGS="-O0 -g" -DCMAKE_INSTALL_PREFIX=/usr .. &&
    ninja &&
    ninja install

Bart.
