Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AEDBFD52
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 04:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfI0CuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 22:50:17 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44918 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfI0CuR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 22:50:17 -0400
Received: by mail-pf1-f173.google.com with SMTP id q21so640322pfn.11
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 19:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3nZxZFSYvYCZGrR+dmFUluMIKj4Rnp7jZ77o4sHt3rA=;
        b=UejioMzUo7C9snUTmhrUBkX7iPVovidlEELGe+METp+2yrGkjJTRzxiGZCK5wlsgN5
         mGQL+yt+NisRVX6sbXjCNIbZuvao4As7yodxav/+8yFDZAW16s4b5eFfZoEFSRtyzQvV
         44Shx6Ny0CdkgMPeaMzk+PGiE+ELdREPTS0c8C1AbE74jVMFEFqQzZIbxSsF39GZeIFe
         7O8uzWx/LsfZRXOZY/8uGEUmEJbtrU2wUe6OefA7GJ3Z1SIusdF/YPwoEszNHmLaIbbc
         LKmCOilvq64D2KCpjDn4nZpAA6oipk0RLdAuHjyzC/17wXZ5SDVnRNZMF2ifVq6GCitv
         FsMg==
X-Gm-Message-State: APjAAAW3pO08pSSZc/AfX2XShduN8MkYrXvYCK6XrXdCXiaHO1hUbjWd
        efitQjVs0c2AdMzI5uii3oy7prUd
X-Google-Smtp-Source: APXvYqwOVb3W2LJYX6nVghf2KANIuoeRvNN0OrQ7FTFg6f/xtEMP28UaBzzngSAuawe1dJqF3pzUfQ==
X-Received: by 2002:a62:8142:: with SMTP id t63mr1467662pfd.246.1569552616111;
        Thu, 26 Sep 2019 19:50:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:a9:2083:a241:50c7:8f37])
        by smtp.gmail.com with ESMTPSA id j16sm3877737pje.6.2019.09.26.19.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 19:50:15 -0700 (PDT)
Subject: Re: SRP subnet timeout
To:     Karandeep Chahal <karandeepchahal@gmail.com>,
        linux-rdma@vger.kernel.org
References: <25ca594d-cb80-2796-01f3-50c40155b4de@gmail.com>
 <69ad7ea4-4b2f-8460-8152-ffe3505bea40@acm.org>
 <dbdc27d0-93bf-947c-0c6c-41f4a7d20385@gmail.com>
 <0068b947-a405-fec3-c0e4-6be4c78c7448@acm.org>
 <683077ff-834a-1184-fbd0-28b4e6e3eeda@gmail.com>
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
Message-ID: <26d64d1f-2c73-aa53-233f-7a939266d354@acm.org>
Date:   Thu, 26 Sep 2019 19:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <683077ff-834a-1184-fbd0-28b4e6e3eeda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-09-26 08:24, Karandeep Chahal wrote:
> The problem with adding 2 to SRP CM timeout is that it makes the SRP CM
> timeout value far off the subnet timeout value.
> Now you can either have a reasonable subnet timeout value and an
> unreasonable SRP CM timeout value, or an unreasonable subnet timeout and
> a reasonable SRP CM timeout.

Hi Karan,

Do you have a proposal for how the SRP initiator driver should be
modified (patch)? After a patch is available the next step is to write a
text that describes why that change will work for all users (patch
description).

Thanks,

Bart.
