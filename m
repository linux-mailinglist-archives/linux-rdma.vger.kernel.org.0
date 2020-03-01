Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0572F174A8D
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 01:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCAArQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 19:47:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34961 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCAArP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 19:47:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so2738169plt.2;
        Sat, 29 Feb 2020 16:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=flDymaP4GbZTW8jiT5MmD+iEheUOChfepNKxu4bSQY4=;
        b=Hb8zOFtDwJ80lGQte9Ov5AuxzdbA/xrC6lh71i6kglhxi9DPrljeENTqMuCs3BmF22
         qUvzmtuY1+HZXm4fHLNn4Ad1WCrzsX1zaYKbl2eDeNhgKAOi2AnRT5YYFCfLLlXfiPn7
         MGHVTNML/Fkso5Iw4cN6qFDQSUAWYzrV2dvVZZMgktubxq0wMX7LWzak3wcJ01iS6Nno
         PiiZYI13mpQCeYhHQeUeUxb5Jti3HBj23e9cap2Xu1BSxj0TdggZBR8lfcBsKxDTIvs+
         /O7l5+wQND00jKWu8omNUot7HlDnqPPGFNB5WVSppfKHSnTeZVnWQGp/b/FJVn1UIXIE
         rhHw==
X-Gm-Message-State: APjAAAVHtT1PJkSRGkUfnKT86V7TLZkyM44L0ZbDfCQ3gMwYCglfqpQ9
        icCz4HfWQYQAU3346yeYQzk=
X-Google-Smtp-Source: APXvYqyyItc0xC3Z/DGbLhbj1tFNh2ipBZG7akXkZtvlAKbMg9tsey5MUDa5NjgCsfZqtymcjEU7yg==
X-Received: by 2002:a17:90a:c708:: with SMTP id o8mr13085973pjt.104.1583023634387;
        Sat, 29 Feb 2020 16:47:14 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id y142sm7449224pfb.25.2020.02.29.16.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 16:47:13 -0800 (PST)
Subject: Re: [PATCH v9 04/25] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-5-jinpuwang@gmail.com>
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
Message-ID: <91708531-46f2-3593-ae08-383a36feea5c@acm.org>
Date:   Sat, 29 Feb 2020 16:47:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-5-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:47, Jack Wang wrote:
> +	wr = (struct ib_recv_wr) {
> +	.wr_cqe  = &iu->cqe,
> +	.sg_list = &list,
> +	.num_sge = 1,
> +	};

The indentation of the above code looks weird to me.

> +	wr = (struct ib_recv_wr) {
> +	.wr_cqe  = cqe,
> +	};

Same comment here.

> +	wr = (struct ib_send_wr) {
> +	.wr_cqe     = &iu->cqe,
> +	.sg_list    = &list,
> +	.num_sge    = 1,
> +	.opcode     = IB_WR_SEND,
> +	.send_flags = IB_SEND_SIGNALED,
> +	};

And here.

> +	wr = (struct ib_rdma_wr) {
> +	.wr.wr_cqe	  = &iu->cqe,
> +	.wr.sg_list	  = sge,
> +	.wr.num_sge	  = num_sge,
> +	.rkey		  = rkey,
> +	.remote_addr	  = rdma_addr,
> +	.wr.opcode	  = IB_WR_RDMA_WRITE_WITH_IMM,
> +	.wr.ex.imm_data = cpu_to_be32(imm_data),
> +	.wr.send_flags  = flags,
> +	};

And here too.

> +	/*
> +	 * If one of the sges has 0 size, the operation will fail with an
> +	 * length error
> +	 */

"an length error" -> "a length error"?

> +	wr = (struct ib_send_wr) {
> +	.wr_cqe	= cqe,
> +	.send_flags	= flags,
> +	.opcode	= IB_WR_RDMA_WRITE_WITH_IMM,
> +	.ex.imm_data	= cpu_to_be32(imm_data),
> +	};

Please indent struct members.

> +int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len)
> +{
> +	int cnt;
> +
> +	switch (addr->sa_family) {
> +	case AF_IB:
> +		cnt = scnprintf(buf, len, "gid:%pI6",
> +			&((struct sockaddr_ib *)addr)->sib_addr.sib_raw);
> +		return cnt;
> +	case AF_INET:
> +		cnt = scnprintf(buf, len, "ip:%pI4",
> +			&((struct sockaddr_in *)addr)->sin_addr);
> +		return cnt;
> +	case AF_INET6:
> +		cnt = scnprintf(buf, len, "ip:%pI6c",
> +			  &((struct sockaddr_in6 *)addr)->sin6_addr);
> +		return cnt;
> +	}
> +	cnt = scnprintf(buf, len, "<invalid address family>");
> +	pr_err("Invalid address family\n");
> +	return cnt;
> +}
> +EXPORT_SYMBOL(sockaddr_to_str);

Please remove the 'cnt' variable from the above function.

Thanks,

Bart.
