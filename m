Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4612D51D
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 00:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfL3XxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 18:53:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54944 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfL3XxN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 18:53:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so449883pjb.4;
        Mon, 30 Dec 2019 15:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TT63d9a1sHF8wFQvd4QIUOX/d5chpggNB5tMfzvjsU8=;
        b=YEhdICD5Sx1/Rw4mjr2u+otLqss2p/xkEOir8K5gR+TaDIwvOkLpHBWATTS6X+ykB1
         8p2A5lyxFolcRaOB9uYwRvC47MU2sAdduHJ0H6KXkCDyT6mtOF6C0rCZbM0Oo20QS1zL
         ekwoBL0XHz6YEskO7vjFI9DaLH12z6suAWpzz/00cCnsMS8eExyp9/bngBgI2RbfgTDi
         TzCXbdrPqCtxFcZ/Z4AyIn5MvbAq/QuHgHF0uo2NrbM/aZsre2oFYEdSBPC1fLELw5i5
         ecfX5M7BxyHTlmBhmW3pZTpGTYenSqtpqSdR50tfL7VXy6roEsffxmNyp0n1oSGkPwq0
         2yIw==
X-Gm-Message-State: APjAAAW+rTKRFnJPHJIm+Vb1WM3fG7IMy1zbkhDgJMo+B+2gCsCxEs7L
        zG04wA+jY2oTTI9FIuF7Eyk=
X-Google-Smtp-Source: APXvYqwt49DmF/9aJQlLinJNq/1+jPbu8suif6YRYEhJB8pGtMjB1bDhhe3u8VhfPlZHCdYUOBy0NQ==
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr2291827pjq.81.1577749992494;
        Mon, 30 Dec 2019 15:53:12 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:5d64:b7bb:4214:150f? ([2601:647:4000:10b0:5d64:b7bb:4214:150f])
        by smtp.gmail.com with ESMTPSA id c22sm30983811pfo.50.2019.12.30.15.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 15:53:11 -0800 (PST)
Subject: Re: [PATCH v6 06/25] rtrs: client: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-7-jinpuwang@gmail.com>
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
Message-ID: <e242c08f-68e0-49b7-82e6-924d0124b792@acm.org>
Date:   Mon, 30 Dec 2019 15:53:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-7-jinpuwang@gmail.com>
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

> +MODULE_DESCRIPTION("RTRS Client");

Please spell out RTRS in full.

> +static const struct rtrs_ib_dev_pool_ops dev_pool_ops;

Can this forward declaration be avoided?

> +static struct rtrs_ib_dev_pool dev_pool = {
> +	.ops = &dev_pool_ops
> +};

Can this structure be declared 'const'?

> +static inline struct rtrs_permit *
> +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
> +{
> +	size_t max_depth = clt->queue_depth;
> +	struct rtrs_permit *permit;
> +	int cpu, bit;
> +
> +	cpu = get_cpu();
> +	do {
> +		bit = find_first_zero_bit(clt->permits_map, max_depth);
> +		if (unlikely(bit >= max_depth)) {
> +			put_cpu();
> +			return NULL;
> +		}
> +
> +	} while (unlikely(test_and_set_bit_lock(bit, clt->permits_map)));
> +	put_cpu();

Are the get_cpu() and put_cpu() calls around this loop useful? If not,
please remove these calls. Otherwise please add a comment that explains
the purpose of these calls.

An additional question: is it possible to replace the above loop with an
sbitmap_get() call?

> +static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> +			      bool notify, bool can_wait)
> +{
> +	struct rtrs_clt_con *con = req->con;
> +	struct rtrs_clt_sess *sess;
> +	int err;
> +
> +	if (WARN_ON(!req->in_use))
> +		return;
> +	if (WARN_ON(!req->con))
> +		return;
> +	sess = to_clt_sess(con->c.sess);
> +
> +	if (req->sg_cnt) {
> +		if (unlikely(req->dir == DMA_FROM_DEVICE && req->need_inv)) {
> +			/*
> +			 * We are here to invalidate RDMA read requests
> +			 * ourselves.  In normal scenario server should
> +			 * send INV for all requested RDMA reads, but
> +			 * we are here, thus two things could happen:
> +			 *
> +			 *    1.  this is failover, when errno != 0
> +			 *        and can_wait == 1,
> +			 *
> +			 *    2.  something totally bad happened and
> +			 *        server forgot to send INV, so we
> +			 *        should do that ourselves.
> +			 */

Please document in the protocol documentation when RDMA reads are used.

What does "server forgot to send INV" mean?

Additionally, if I remember correctly Jason considers it very important
that invalidation happens from the submitting context because otherwise
the RDMA retry mechanism can't work.

> +static void process_io_rsp(struct rtrs_clt_sess *sess, u32 msg_id,
> +			   s16 errno, bool w_inval)
> +{
> +	struct rtrs_clt_io_req *req;
> +
> +	if (WARN_ON(msg_id >= sess->queue_depth))
> +		return;
> +
> +	req = &sess->reqs[msg_id];
> +	/* Drop need_inv if server responsed with invalidation */
> +	req->need_inv &= !w_inval;
> +	complete_rdma_req(req, errno, true, false);
> +}

Please document the meaning of the "w_inval" argument. Please also fix
the spelling of "responsed".

Thanks,

Bart.
