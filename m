Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1E12D5D1
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 03:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLaCjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 21:39:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32848 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfLaCjD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 21:39:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so18923849pgk.0;
        Mon, 30 Dec 2019 18:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MikzkHh0za+uYxjbFgHfII/aiEKefwUWCBUIacolOKU=;
        b=sw1mJzqCjwD2DhyZzZ7ippZ/a3y6k6Gee/w7AKbVej2FUe5vIZmqRouf47QGK3fkYl
         f3SUaJUeJI/ApdJfUREFuJTj6JW+o6NN5i6kOZmGAXeGqcqtHe5fCqy7qbpfydc84fEc
         LXmWhRzIxT5ROQcSaQCd0ON60shOk7ymglIT56KgqnCvHy6e1VXLps4Oli+eLnmMDzsS
         yGj5NZkVfNMYKt4E7+LTcsdYFgrjtN8LHndvqnEruTiPyh3Xj/scXCwzFUhwg53GnkB3
         t0tdnnV2KRNT2MKa38td315iDtBeEgZYbs1ffEyx2/XXmnKYLcoZ+2nNbAVWVp+Y2b18
         fkSQ==
X-Gm-Message-State: APjAAAWdBaiPSWeR1N2W2BR5XhytepPWfPQ3xAxLXYFX+X5r+qIWY1wW
        dd0Qcd5gtq3dqICTyNe1wvo=
X-Google-Smtp-Source: APXvYqzD5o1mUhbbJN06jtPKf98owUns5FiVMWq0Pnlz2VZhW/5uUBARv0d//MWk8vF7rRv7+9oeRQ==
X-Received: by 2002:a63:7311:: with SMTP id o17mr71845332pgc.29.1577759943053;
        Mon, 30 Dec 2019 18:39:03 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:5d64:b7bb:4214:150f? ([2601:647:4000:10b0:5d64:b7bb:4214:150f])
        by smtp.gmail.com with ESMTPSA id e16sm48009988pgk.77.2019.12.30.18.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 18:39:02 -0800 (PST)
Subject: Re: [PATCH v6 00/25] RTRS (former IBTRS) rdma transport library and
 RNBD (former IBNBD) rdma network block device
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
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
Message-ID: <a56985f4-fbd3-3546-34e1-4185150f4af2@acm.org>
Date:   Mon, 30 Dec 2019 18:39:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-12-30 02:29, Jack Wang wrote:
> here is V6 of the RTRS (former IBTRS) rdma transport library and the
> corresponding RNBD (former IBNBD) rdma network block device.
> 
> Changelog since v5:
> 1 rebased to linux-5.5-rc4
> 2 fix typo in my email address in first patch
> 3 cleanup copyright as suggested by Leon Romanovsky
> 4 remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
> 5 add MAINTAINERS entries in alphabetical order as Gal Pressman suggested

Please always include the full changelog when posting a new version.
Every other Linux kernel patch series I have seen includes a full
changelog in version two and later versions of its cover letter.

Information about how this patch series has been tested would be
welcome. How big were the changes between v4 and v5 and how much testing
have these changes received? Was this patch series tested in the Ionos
data center or is it the out-of-tree version of these drivers that runs
in the Ionos data center?

Thanks,

Bart.
