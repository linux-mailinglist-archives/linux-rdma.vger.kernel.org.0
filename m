Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085E0131DC7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 03:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgAGC4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 21:56:45 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:54753 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGC4p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jan 2020 21:56:45 -0500
Received: by mail-pj1-f46.google.com with SMTP id kx11so8363940pjb.4;
        Mon, 06 Jan 2020 18:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iJ76xh6dRGBK5I51/f7xLqV7Am1vCLOQtohVIzZUhs0=;
        b=tcUBXVYW0iXGzle7lOQb3gX116Nm9GYntDNCYARuncmzEiMceoOxXE/XcWnt2hau1C
         pnSaxr8diGPWZvp0ThQrGYt3paJSvGvRiCcUftYKm8QQELTT1BAAJdo/EfC5HgfBMq0L
         CK3t7CoIT6DTExRkPj/8nFRayUdEsaLVhHs+wjI4AcXCpqLY002IgwRcuein9C6gJOnk
         qWcWbth6MHuWCetGqMhjFHDkacRYq6L51C6uYVFl63oE9RBqI6+6WS/Ul5PXWVAMYId0
         iSYdNl+4K6o5hVutswVrUDXg3xdjyzcitDqYaHI5h74bZ+/K7s74RJZ+Y8DT5rItWfwl
         6UtA==
X-Gm-Message-State: APjAAAV61e64ikBR8hb60fpwuGHdhzv5QCZKr9i44KVFEXmhRt5Q2Q0M
        wJS4YPfab90KzduulgNm5NbGzam0
X-Google-Smtp-Source: APXvYqxripukSjQGamAIrAP694EGXArjWAZ6wHH+sB0hky5ju4qvObN+j805Tw0b8pvZdsGCy/GrCA==
X-Received: by 2002:a17:90a:b106:: with SMTP id z6mr47155130pjq.91.1578365803636;
        Mon, 06 Jan 2020 18:56:43 -0800 (PST)
Received: from ?IPv6:2601:647:4000:13e0:859b:a532:8457:1042? ([2601:647:4000:13e0:859b:a532:8457:1042])
        by smtp.gmail.com with ESMTPSA id p17sm77626935pfn.31.2020.01.06.18.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 18:56:42 -0800 (PST)
Subject: Re: Recent trace observed in target code during iSer testing
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
References: <MWHPR1101MB2271A83D246FAE4710E47BB2863C0@MWHPR1101MB2271.namprd11.prod.outlook.com>
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
Message-ID: <3b724797-275a-9a14-1503-1778780a5872@acm.org>
Date:   Mon, 6 Jan 2020 18:56:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <MWHPR1101MB2271A83D246FAE4710E47BB2863C0@MWHPR1101MB2271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-01-06 10:23, Marciniszyn, Mike wrote:
> Seeing the following trace in some target testing for IB ulps:
> 
> [28630.870878] ------------[ cut here ]------------
> [28630.876936] percpu_ref_kill_and_confirm called more than once on target_release_sess_cmd_refcnt [target_core_mod]!

A candidate fix has been posted but needs review and/or a Tested-by. See
also https://www.spinics.net/lists/target-devel/msg17981.html.

Thanks,

Bart.
