Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8241D3207
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgENOCJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 10:02:09 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:33668 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENOCJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 10:02:09 -0400
Received: by mail-pf1-f170.google.com with SMTP id x77so1363083pfc.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2020 07:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+uel9ExbS2NJJmk7+xmqf74dBJXQznmdSLUw2zgddsQ=;
        b=lIfOjo1xXXjUNo+nG+fRoyoNst53WSQbFEywkKJNnQi4790AupdDPKjlVnkNBFKYBP
         DblaQ7q4lEKVn3HdCSilv/CcxjZ3ns0fH4fKWR/vGQrliCvIe8DaTM2sfFDBoJVg26i/
         e4syBUFzzPsGRuCSGAwSaCIz1IUptbrWJrUBtKNlMtu5/qhaCWRpUSdE4yfvw/lWGnWQ
         bnGaWjuD0lBZt86uKNgzXAOy1zA5f3wRLQfsNsXGIEjo9aM1aWkfzmWqvmL4ieoTLdpX
         +lWt1R3sl54ypfbkiJPqS/CwRtffULhdsepPDwJRIoYvzuO3IaA8GuhWpMDO0jlHlpsh
         7NLQ==
X-Gm-Message-State: AOAM530VHmvWmGMC70Mqo6Rwp8pYzeCNotSR2cIxEj9Va4WvLTYIcOZE
        wieVrwejvFrYnpibfTTlAko=
X-Google-Smtp-Source: ABdhPJyzGdTCvGh5Q78E19OP84c9Nbyki8Ru6B+bCiXYXdA7YAoINeFwr9DP4aHfIuOAKS1WNhd6gA==
X-Received: by 2002:aa7:9532:: with SMTP id c18mr4616839pfp.255.1589464927094;
        Thu, 14 May 2020 07:02:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6c16:7f27:8c37:e02d? ([2601:647:4000:d7:6c16:7f27:8c37:e02d])
        by smtp.gmail.com with ESMTPSA id c10sm2430543pfm.50.2020.05.14.07.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 07:02:06 -0700 (PDT)
Subject: Re: [PATCH 6/8] RDMA/srp: remove support for FMR memory registration
To:     Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org
Cc:     sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <20200514120305.189738-7-maxg@mellanox.com>
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
Message-ID: <c1ef3df5-525d-d8c3-f84e-07bf3b6adc44@acm.org>
Date:   Thu, 14 May 2020 07:02:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514120305.189738-7-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-14 05:03, Max Gurtovoy wrote:
> FMR is not supported on most recent RDMA devices (that use fast memory
> registration mechanism). Also, FMR was recently removed from NFS/RDMA
> ULP.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
