Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60E12D41B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 20:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfL3Tsa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 14:48:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42560 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfL3Tsa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 14:48:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so18701432pfz.9;
        Mon, 30 Dec 2019 11:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uNViMZmh5LhULoDD6aH25yjCL/0Vaq95EzZj7IWZ7ew=;
        b=rQBJUFd1BtO5A5EOrSh0JxdR5ix56ZWoogwPTs5SXQbYqSnpQQCDbLLGq84b9+2rsn
         ZJCoITuOaurxGC9kjvjgH/O5sseNCdLfHvQ5PePchsc4VuUtflP/h8NdE/C/BURPH9CO
         xDT6ObIf9dykuFinuGoM/sVzD5TXb962wWUDf0D2Ss+xeBGIcZr1+Ksw8RZT/sqwym68
         NClWA7Cn5QfgYFXpfZSFDKvQinXCwamBuniUTSYNb1Jbub5/pBLkomB4tcrQTfZ2DjGK
         2BlR4DSaPRHkgG8DMNbZX9V4y361MXPW3hfvCl2GzhMmrQDVqRC8pxzs88m8lP0486IV
         TTFg==
X-Gm-Message-State: APjAAAUwLGpggbHmeKlMHMMV7m6WTsqnMaHIVz8n3DSeNYCxGi4KVwPj
        bAbcEAnuUhVYJ/Sntm1kWUw=
X-Google-Smtp-Source: APXvYqyxTQ1LBFhxVp0E+ifbvWpsFooOcLL4M62TivJC+01A14YThQmbG9YS3Q7aegUPXnXXq0N2gQ==
X-Received: by 2002:a63:a54d:: with SMTP id r13mr73430331pgu.138.1577735309132;
        Mon, 30 Dec 2019 11:48:29 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:5d64:b7bb:4214:150f? ([2601:647:4000:10b0:5d64:b7bb:4214:150f])
        by smtp.gmail.com with ESMTPSA id d27sm48590209pgm.53.2019.12.30.11.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 11:48:28 -0800 (PST)
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
Message-ID: <b13eccdd-09a2-70d5-1c78-3c4dbf1aefe8@acm.org>
Date:   Mon, 30 Dec 2019 11:48:26 -0800
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
> + * InfiniBand Transport Layer

Is RTRS an InfiniBand or an RDMA transport layer?

> +#define rtrs_prefix(obj) (obj->sessname)

Is it really worth it to introduce a macro for accessing a single member
of a single pointer?

> + * InfiniBand Transport Layer

Same question here: is RTRS an InfiniBand or an RDMA transport layer?

> +enum {
> +	SERVICE_CON_QUEUE_DEPTH = 512,

What is a service connection?

> +	/*
> +	 * With the current size of the tag allocated on the client, 4K
> +	 * is the maximum number of tags we can allocate.  This number is
> +	 * also used on the client to allocate the IU for the user connection
> +	 * to receive the RDMA addresses from the server.
> +	 */

What does the word 'tag' mean in the context of the RTRS protocol?

> +struct rtrs_ib_dev;

What does the "rtrs_ib_dev" data structure represent? Additionally, I
think it's confusing that a single name has an "r" that refers to "RDMA"
and "ib" that refers to InfiniBand.

> +struct rtrs_ib_dev_pool {
> +	struct mutex		mutex;
> +	struct list_head	list;
> +	enum ib_pd_flags	pd_flags;
> +	const struct rtrs_ib_dev_pool_ops *ops;
> +};

What is the purpose of an rtrs_ib_dev_pool and what does it contain?

> +struct rtrs_iu {

A comment that explains what the "iu" abbreviation stands for would be
welcome.

> +/**
> + * enum rtrs_msg_types - RTRS message types.
> + * @RTRS_MSG_INFO_REQ:		Client additional info request to the server
> + * @RTRS_MSG_INFO_RSP:		Server additional info response to the client
> + * @RTRS_MSG_WRITE:		Client writes data per RDMA to server
> + * @RTRS_MSG_READ:		Client requests data transfer from server
> + * @RTRS_MSG_RKEY_RSP:		Server refreshed rkey for rbuf
> + */

What is "additional info" in this context?

> +/**
> + * struct rtrs_msg_conn_req - Client connection request to the server
> + * @magic:	   RTRS magic
> + * @version:	   RTRS protocol version
> + * @cid:	   Current connection id
> + * @cid_num:	   Number of connections per session
> + * @recon_cnt:	   Reconnections counter
> + * @sess_uuid:	   UUID of a session (path)
> + * @paths_uuid:	   UUID of a group of sessions (paths)
> + *
> + * NOTE: max size 56 bytes, see man rdma_connect().
> + */
> +struct rtrs_msg_conn_req {
> +	u8		__cma_version; /* Is set to 0 by cma.c in case of
> +					* AF_IB, do not touch that.
> +					*/
> +	u8		__ip_version;  /* On sender side that should be
> +					* set to 0, or cma_save_ip_info()
> +					* extract garbage and will fail.
> +					*/

The above two fields and the comments next to it look suspicious to me.
Does RTRS perhaps try to generate CMA-formatted messages without using
the CMA to format these messages?

> +	u8		reserved[12];

Please leave out the reserved data. If future versions of the protocol
would need any of these bytes it is easy to add more data to this structure.

> +/**
> + * struct rtrs_msg_conn_rsp - Server connection response to the client
> + * @magic:	   RTRS magic
> + * @version:	   RTRS protocol version
> + * @errno:	   If rdma_accept() then 0, if rdma_reject() indicates error
> + * @queue_depth:   max inflight messages (queue-depth) in this session
> + * @max_io_size:   max io size server supports
> + * @max_hdr_size:  max msg header size server supports
> + *
> + * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accept().
> + */
> +struct rtrs_msg_conn_rsp {
> +	__le16		magic;
> +	__le16		version;
> +	__le16		errno;
> +	__le16		queue_depth;
> +	__le32		max_io_size;
> +	__le32		max_hdr_size;
> +	__le32		flags;
> +	u8		reserved[36];
> +};

Same comment here: please leave out the "reserved[]" array. Sending a
bunch of zero-bytes at the end of a message over the wire is not useful.

> +static inline void rtrs_from_imm(u32 imm, u32 *type, u32 *payload)
> +{
> +	*payload = (imm & MAX_IMM_PAYL_MASK);
> +	*type = (imm >> MAX_IMM_PAYL_BITS);
> +}

Please do not use parentheses when not necessary. Such superfluous
parentheses namely hurt readability of the code.

> +	type = (w_inval ? RTRS_IO_RSP_W_INV_IMM : RTRS_IO_RSP_IMM);

Same comment here: I think the parentheses can be left out from the
above statement.

> +static inline void rtrs_from_io_rsp_imm(u32 payload, u32 *msg_id, int *errno)
> +{
> +	/* 9 bits for errno, 19 bits for msg_id */
> +	*msg_id = (payload & 0x7ffff);

Are the parentheses in the above expression necessary?

> +	*errno = -(int)((payload >> 19) & 0x1ff);

Is the '(int)' cast useful in the above expression? Can it be left out?

> +#define STAT_ATTR(type, stat, print, reset)				\
> +STAT_STORE_FUNC(type, stat, reset)					\
> +STAT_SHOW_FUNC(type, stat, print)					\
> +static struct kobj_attribute stat##_attr =				\
> +		__ATTR(stat, 0644,					\
> +		       stat##_show,					\
> +		       stat##_store)

Is the above use of __ATTR() perhaps an open-coded version of __ATTR_RW()?

Thanks,

Bart.
