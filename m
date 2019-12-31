Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055C812D526
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 01:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfLaAHc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 19:07:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfLaAHc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 19:07:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so12509912plr.7;
        Mon, 30 Dec 2019 16:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rXSHz6cfTkxeyk09H3vLkoTwTJ3k3wQfS2j82q1+peE=;
        b=Uv3dIOUlykhaI+pwx+2pr4G082B7eby/o7ogpplesG4CivIpCxlekAWfaBzauk5Lgn
         7Fe2XfdxJw6PwFFgeIZdWCqTmzgmGbUutDMgRBBXoXRwWXpcEkSjGpzoOjTtgU3wzANG
         yTjlbF98mmdFMy1ceBxwW7F3buCZY09VVp338J7mvq9I63yFjb/Leg5xmTkRZYqyZesO
         c9hHCdVNlFYunwWjFPNTtQZTFcw2oNYgq4w5rA+kCipHNsi2z2wXTYDn52dSvdIdocJq
         M7tuIai6j79sBp9yAbLsKuQLQ+4bmLAmN2kMVnE6bfsWiov7usq2jpH62IiCwikmsNWF
         9t7g==
X-Gm-Message-State: APjAAAUDNfrtJ3Kr6sQYUbCDC7P281wnsKpppV0Xd2ieyg1Zih7SOtK5
        FIae26h50h7BLrntQ1l0c60=
X-Google-Smtp-Source: APXvYqwKp4Gf4sUVqS/FtQOFLn3L4WFzhCt+bY06eU9e3U6he6kciRN+s3VKmtyLKViOIFs+lgn/Ow==
X-Received: by 2002:a17:90a:840a:: with SMTP id j10mr2415571pjn.35.1577750851792;
        Mon, 30 Dec 2019 16:07:31 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:5d64:b7bb:4214:150f? ([2601:647:4000:10b0:5d64:b7bb:4214:150f])
        by smtp.gmail.com with ESMTPSA id z26sm22848094pfa.90.2019.12.30.16.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 16:07:30 -0800 (PST)
Subject: Re: [PATCH v6 03/25] rtrs: private headers with rtrs protocol structs
 and helpers
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-4-jinpuwang@gmail.com>
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
Message-ID: <1f826dca-86c7-41ab-eef8-0e15f723e993@acm.org>
Date:   Mon, 30 Dec 2019 16:07:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-4-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-12-30 02:29, Jack Wang wrote:
> +static inline u32 rtrs_to_io_rsp_imm(u32 msg_id, int errno, bool w_inval)
> +{
> +	enum rtrs_imm_type type;
> +	u32 payload;
> +
> +	/* 9 bits for errno, 19 bits for msg_id */
> +	payload = (abs(errno) & 0x1ff) << 19 | (msg_id & 0x7ffff);
> +	type = (w_inval ? RTRS_IO_RSP_W_INV_IMM : RTRS_IO_RSP_IMM);
> +
> +	return rtrs_to_imm(type, payload);
> +}
> +
> +static inline void rtrs_from_io_rsp_imm(u32 payload, u32 *msg_id, int *errno)
> +{
> +	/* 9 bits for errno, 19 bits for msg_id */
> +	*msg_id = (payload & 0x7ffff);
> +	*errno = -(int)((payload >> 19) & 0x1ff);
> +}

The above comments mention that 19 bits are used for msg_id. The 0x7ffff
mask however has 23 bits set. Did I see that correctly? If so, does that
mean that the errno and msg_id bitfields overlap partially?

Thanks,

Bart.
