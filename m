Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5907712D4E0
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 23:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfL3Wvg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 17:51:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45132 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfL3Wvg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 17:51:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so18683777pgk.12;
        Mon, 30 Dec 2019 14:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X7UMZsK19/JCsq+hQSWAWireoAP5gI8TurD1CBiX95c=;
        b=gV8K6dFRVM1arXBvi4eZM9kbKaH21Oaw/Ew4Dre98F8MUQmzrpm3PYGOgP//kQSR8Q
         Dj+qCQcBBWnsOvvnOM+kpnbSrR0VBVYc1Ne6ZWi/6aVmfp6hNBhohQh37LiTInP7k2fp
         fiS2JHwqq5Lw+cKPPKXnoj6+E0FWeyixPIxEl4sIEOH/K3/Z7XehyCe2A4SYBuNCClBO
         bz/9hRjOA6g9nA5TNSE6eUH8trgSFqhB2qkq+QX3K4ejBXpWSmg+jDVR0OwOSyA4sYAm
         sXXMiOR34deR9coZwaxbdaZdP2HKrDdLmdIQ+thDfZpDwbXPCKrFuZGb8VlXj30z7/ej
         64FQ==
X-Gm-Message-State: APjAAAW4/nIbNokilDKUBd4e5XPN9QztdKHh3lIfBVNWe58Bhj7mAHCw
        pkupPqFNiFKk71fXudco2ow=
X-Google-Smtp-Source: APXvYqyDPDn9e2WV9muz5ba8c6BjWKN3zyqN/odYEn84B4EOJ/W090WuvJ6kHNBRVDKfdK7fHjQtxA==
X-Received: by 2002:a63:e4b:: with SMTP id 11mr74920358pgo.5.1577746295350;
        Mon, 30 Dec 2019 14:51:35 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:5d64:b7bb:4214:150f? ([2601:647:4000:10b0:5d64:b7bb:4214:150f])
        by smtp.gmail.com with ESMTPSA id c1sm53891496pfa.51.2019.12.30.14.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 14:51:34 -0800 (PST)
Subject: Re: [PATCH v6 05/25] rtrs: client: private header with client structs
 and functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-6-jinpuwang@gmail.com>
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
Message-ID: <02d1f022-8f60-714c-24c8-e2100984e90f@acm.org>
Date:   Mon, 30 Dec 2019 14:51:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-6-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-12-30 02:29, Jack Wang wrote:
> + * InfiniBand Transport Layer

InfiniBand or RDMA?

> +static inline const char *rtrs_clt_state_str(enum rtrs_clt_state state)
> +{
> +	switch (state) {
> +	case RTRS_CLT_CONNECTING:
> +		return "RTRS_CLT_CONNECTING";
> +	case RTRS_CLT_CONNECTING_ERR:
> +		return "RTRS_CLT_CONNECTING_ERR";
> +	case RTRS_CLT_RECONNECTING:
> +		return "RTRS_CLT_RECONNECTING";
> +	case RTRS_CLT_CONNECTED:
> +		return "RTRS_CLT_CONNECTED";
> +	case RTRS_CLT_CLOSING:
> +		return "RTRS_CLT_CLOSING";
> +	case RTRS_CLT_CLOSED:
> +		return "RTRS_CLT_CLOSED";
> +	case RTRS_CLT_DEAD:
> +		return "RTRS_CLT_DEAD";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}

This function is not in the hot path so it shouldn't be inline.

> +#define MIN_LOG_SG 2
> +#define MAX_LOG_SG 5
> +#define MAX_LIN_SG BIT(MIN_LOG_SG)
> +#define SG_DISTR_SZ (MAX_LOG_SG - MIN_LOG_SG + MAX_LIN_SG + 2)

I think these constants deserve a comment that explains what their
meaning is.

> +/**
> + * rtrs_permit - permits the memory allocation for future RDMA operation
> + */
> +struct rtrs_permit {
> +	enum rtrs_clt_con_type con_type;
> +	unsigned int cpu_id;
> +	unsigned int mem_id;
> +	unsigned int mem_off;
> +};

The comment above this structure is confusing. Please make it more clear.

Thanks,

Bart.
