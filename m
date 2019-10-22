Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE13E0E0A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfJVWLo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 18:11:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37961 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJVWLo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 18:11:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so9007297plq.5
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 15:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=60/JKIMLQRUD8JICxT9fVeECAik5M9B7f6BYXlMqdYA=;
        b=LtE05JEez4lIjp+PscdGwXYVq/DX3rqXS4rqUdbuKlz/48Fkehs9+gjxufmUXM6wKl
         Vb5b59tFKPg0huHPQUkeiH7GPR8a4J2mnEPNV7NB4TQRLNdjbRn+VmpV4bAtnx3QQXh0
         pFTo3TA7dAelwYDabBF6KfuqAsfEX7BnybbMz7xpJUTbgwT9BSdNCJToeEnrJl2xtJfc
         YYy5nf3iIGUJQXMJdypTOBie6qfv3Wl8hiaFUwFfeoyy3Mrkm9yUVsVzrjIM1ipkh/LD
         4MxK1YD9/9xBB01x1zipIyygVxHuaZcoPS+2htodNhkjOEoKN0+1Qnk/T2DCyYEoyAw9
         /2tA==
X-Gm-Message-State: APjAAAUKwIlo1GQZiOXcAG443CvnB3h6tJQwQ4bccAhLe6HW8D4eKBF/
        A6Dv++SogJ359eC1/Jmhx+Q=
X-Google-Smtp-Source: APXvYqzIiFWjrpw2l+nlC/gtgtDNeRLK3tP49Ed4xAVWykmpYMIFyAFIzEgmhUph/ovo2SCjlrgxiw==
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr6070473plr.277.1571782303587;
        Tue, 22 Oct 2019 15:11:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:ccbd:2d81:281:ddbd])
        by smtp.gmail.com with ESMTPSA id b3sm20844066pfd.125.2019.10.22.15.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 15:11:42 -0700 (PDT)
Subject: Re: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Adit Ranadive <aditr@vmware.com>,
        Gal Pressman <galpress@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
References: <20191021021030.1037-1-bvanassche@acm.org>
 <20191021021030.1037-3-bvanassche@acm.org> <20191021141039.GC25178@ziepe.ca>
 <61d89948-de40-5e6b-f368-353476292093@acm.org>
 <9DD61F30A802C4429A01CA4200E302A7B6B0D6EE@fmsmsx124.amr.corp.intel.com>
 <4d1fb001-ead8-81ce-893e-1ff94214c389@acm.org>
 <20191022144038.GA23952@ziepe.ca>
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
Message-ID: <73157d2b-d5f1-0b93-3dc8-6e30a4396a2f@acm.org>
Date:   Tue, 22 Oct 2019 15:11:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022144038.GA23952@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-10-22 07:40, Jason Gunthorpe wrote:
> All drivers chop the sgls up into whatever size they support, unlike
> block we don't need the dma mapper to produce sgls in specific formats.

Thanks Jason, this is very useful feedback. I will rework this patch
series based on that feedback.

Bart.
