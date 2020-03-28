Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5783D1968F7
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 20:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgC1Tk7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 15:40:59 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:36653 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1Tk6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 15:40:58 -0400
Received: by mail-pj1-f46.google.com with SMTP id nu11so5386421pjb.1;
        Sat, 28 Mar 2020 12:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/hiyPR3j++RxYLUfWCAmCn3U7EqF4ZV+4e7ehaye5mw=;
        b=IFH1FYlRE+VGA4MN4I0YScsPMkw4XfBqpTdIRleTc9jHajXjyZ6BpNLDKm4GP2Zj4W
         ek+hNEIjOTzLyaquPtvRDUzIWyMRXihvEmlUmVx00EwRhPIJgZXjlvyvjfbHQtuqtLX0
         N4T/tUJLSpinpPer8+zUa2IZIXcwl0LT3bfeW63QooKfh+MY88iZDRpnT1/D58/bNph1
         RNAZuDXcsUSnUAk7L3MViMN+qYV0xIa+SjgEmtnhy3Lts/lIX/5HfSQ7SY8LHCbDPwkj
         dOFLslg3PM56bDMCD2nk9UBpFU8QnG7Ib9htlEwRRcnvDwNQdoSt7epr4FZ8g/qo97DH
         A/Uw==
X-Gm-Message-State: ANhLgQ1EDGiXAza31WJgKCWSBLE8Itfo9lm7l7Qci3b9IU5BvFtLSpRz
        8dPUsNeTWKAClPAtqUt03EE=
X-Google-Smtp-Source: ADFU+vswf/IthtMYLQ5bDw0OHjCH3nggf+X8XVyjZvtfH4zftuqbPKrygG/uQbbT1bd9JPy/9iGqLg==
X-Received: by 2002:a17:902:ea83:: with SMTP id x3mr4917488plb.318.1585424457686;
        Sat, 28 Mar 2020 12:40:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:597d:a863:13de:4665? ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id d23sm6698045pfq.210.2020.03.28.12.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 12:40:56 -0700 (PDT)
Subject: Re: [PATCH v11 26/26] MAINTAINERS: Add maintainers for RNBD/RTRS
 modules
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-27-jinpu.wang@cloud.ionos.com>
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
Message-ID: <7e9a4b85-1062-da29-db8e-9298dc71719d@acm.org>
Date:   Sat, 28 Mar 2020 12:40:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320121657.1165-27-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-20 05:16, Jack Wang wrote:
> Danil and I will maintain RNBD/RTRS modules.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
