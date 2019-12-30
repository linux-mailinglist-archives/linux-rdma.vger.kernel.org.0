Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAABD12D3E1
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 20:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfL3TZT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 14:25:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41990 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TZS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 14:25:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so14988750plk.9;
        Mon, 30 Dec 2019 11:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vU3brm+z2xDyfqy1yFcCcYxfRE+MOfwS/wPTAm9qYg4=;
        b=kJwR/S+89obZi2LebbxOqXbYey0CJ17/EX15bBhGV6Xz7dwMokViuedluWA3DTcsIi
         F0okDMg4GUoEagru8IfT2DhAeBeq+0o76E4cwcnBoB19j1p0piVc2MbNGGNI+hI4E7aa
         KGFwdKbkzk9ftaDjjzcPVo6efI/riSsKQuchqA9aVGXJAf/AeB0Wy204hHcUb7ciU386
         890wg0kag8AS51TCBOT0ftKJRXpBADBoOmBFRGJ6VUbminSzDPxxOydvbnusOCGAqKoD
         Ad5Ml63uU4f/hn+LndYjlcPP4oOpCGEplkubNaj10R+QKgJRg8kE/WIlJ3VHdQsoHsOk
         Jixw==
X-Gm-Message-State: APjAAAViafLUc8xoPHV+lGJ/VKHAuYf7C28/voKXakP9s4pmPMZM2Ucc
        TreHVsQKDZ87VX/yryc1w18=
X-Google-Smtp-Source: APXvYqxuCGDUmzVGxpA2og4Q7oYmdIFUYlnFoxgxouoq8lexLcwNAQCv58vfoVcScZVQ3BPSowt72w==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr852076pji.63.1577733918002;
        Mon, 30 Dec 2019 11:25:18 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:5d64:b7bb:4214:150f? ([2601:647:4000:10b0:5d64:b7bb:4214:150f])
        by smtp.gmail.com with ESMTPSA id q199sm52962236pfq.163.2019.12.30.11.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:25:16 -0800 (PST)
Subject: Re: [PATCH v6 02/25] rtrs: public interface header to establish RDMA
 connections
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-3-jinpuwang@gmail.com>
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
Message-ID: <cc66bb26-68da-8add-6813-a330dc23facd@acm.org>
Date:   Mon, 30 Dec 2019 11:25:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-3-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-12-30 02:29, Jack Wang wrote:
> +/*
> + * Here goes RTRS client API
> + */

A comment that explains what the abbreviation "RTRS" stands for would be
welcome here. Additionally, I think that "Here goes" can be left out.

> +/**
> + * rtrs_clt_open() - Open a session to an RTRS server
> + * @priv: User supplied private data.
> + * @link_ev: Event notification for connection state changes

Please mention that @link_ev is a callback function.

> + *	@priv: User supplied data that was passed to rtrs_clt_open()
> + *	@ev: Occurred event

Is this patch series W=1 clean? @link_ev arguments should be documented
above the link_clt_ev_fn typedef.

> + * @path_cnt: Number of elemnts in the @paths array

elemnts -> elements?

> + * Starts session establishment with the rtrs_server. The function can block
> + * up to ~2000ms until it returns.

until -> before?

> +struct rtrs_clt *rtrs_clt_open(void *priv, link_clt_ev_fn *link_ev,
> +				 const char *sessname,
> +				 const struct rtrs_addr *paths,
> +				 size_t path_cnt, short port,
> +				 size_t pdu_sz, u8 reconnect_delay_sec,
> +				 u16 max_segments,
> +				 s16 max_reconnect_attempts);

Since the range for port numbers is 1..65535, please change "short port"
into "u16 port".

> +/**
> + * enum rtrs_clt_con_type() type of ib connection to use with a given permit

What is a "permit"?

> + * @vec:	Message that is send to server together with the request.

send -> sent?

> + *		Sum of len of all @vec elements limited to <= IO_MSG_SIZE.
> + *		Since the msg is copied internally it can be allocated on stack.
> + * @nr:		Number of elements in @vec.
> + * @len:	length of data send to/from server

send -> sent?

> +/**
> + * link_ev_fn():	Events about connective state changes

connective -> connection?

> +/**
> + * rtrs_srv_open() - open RTRS server context
> + * @ops:		callback functions
> + *
> + * Creates server context with specified callbacks.
> + *
> + * Return a valid pointer on success otherwise PTR_ERR.
> + */
> +struct rtrs_srv_ctx *rtrs_srv_open(rdma_ev_fn *rdma_ev, link_ev_fn *link_ev,
> +				     unsigned int port);

Is this patch series W=1 clean? The documented argument does not match
the actual argument list.

Bart.
