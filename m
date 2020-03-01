Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF2174ADB
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 04:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCADJg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 22:09:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51335 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCADJg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 22:09:36 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so2938522pjb.1;
        Sat, 29 Feb 2020 19:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y3cQT6znesewh2nAGzsIExbrBqeiHXqHjTuBacCGXTc=;
        b=Jxo5bEJBP7aYbufH66AN9nAmOEAAmxDwxphF77wwvY91Rr4l8BbJrAkNZz1pQ+O3He
         qj1msctR2lehXM0yQ+ScO4IrDY2HvoOgrQBQqtrTp4pmWu7xmIRcbF+gDJroqrLxRj7g
         hFyhW9xVJgb8h40nFNVhvDh2ca09FEVUgObziSvvHGci5cjHTpuPxfCqMCCbqbfz91it
         NklEVTeoH/oAV+wnyyHAlhhQH3Izdt2SZEpjdp3R21lNon7XuppgSvX71ivPqaJFizW/
         0GqWdr0GaoF9U+DgXmfKph/A39lmjHa1ezKeQxp6cd3qR7v6wwvOHFod4IXKb15cGBIS
         vuzQ==
X-Gm-Message-State: APjAAAVaGJU6zK7ai4eIyzTz3vAOFJDYN3qbRFgyiqzgq4582C+M+VbQ
        j8WPI0f5Nz+uTDKB26Ln18vEAYzwYH0=
X-Google-Smtp-Source: APXvYqz9pGL8+yVn29CTxlfiNjuVcW8rVeiN1uqjsi4BHCYPOtdii1Map9N1o8q763RaTq2+E9oadA==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr12649861pjs.69.1583032174759;
        Sat, 29 Feb 2020 19:09:34 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id h2sm15320712pgv.40.2020.02.29.19.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 19:09:34 -0800 (PST)
Subject: Re: [PATCH v9 21/25] block/rnbd: server: functionality for IO
 submission to file or block dev
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-22-jinpuwang@gmail.com>
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
Message-ID: <92721a50-158f-3018-39d4-40fce7b0f4d8@acm.org>
Date:   Sat, 29 Feb 2020 19:09:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-22-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:47, Jack Wang wrote:
> +static struct bio *rnbd_bio_map_kern(struct request_queue *q, void *data,
> +				      struct bio_set *bs,
> +				      unsigned int len, gfp_t gfp_mask)
> +{
> +	unsigned long kaddr = (unsigned long)data;
> +	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	unsigned long start = kaddr >> PAGE_SHIFT;
> +	const int nr_pages = end - start;
> +	int offset, i;
> +	struct bio *bio;
> +
> +	bio = bio_alloc_bioset(gfp_mask, nr_pages, bs);
> +	if (!bio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	offset = offset_in_page(kaddr);
> +	for (i = 0; i < nr_pages; i++) {
> +		unsigned int bytes = PAGE_SIZE - offset;
> +
> +		if (len <= 0)
> +			break;
> +
> +		if (bytes > len)
> +			bytes = len;
> +
> +		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
> +				    offset) < bytes) {
> +			/* we don't support partial mappings */
> +			bio_put(bio);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		data += bytes;
> +		len -= bytes;
> +		offset = 0;
> +	}
> +
> +	bio->bi_end_io = bio_put;
> +	return bio;
> +}

The above function is almost identical to bio_map_kern(). Please find a
way to prevent such code duplication.

> +static inline int rnbd_dev_get_logical_bsize(const struct rnbd_dev *dev)
> +{
> +	return bdev_logical_block_size(dev->bdev);
> +}
> +
> +static inline int rnbd_dev_get_phys_bsize(const struct rnbd_dev *dev)
> +{
> +	return bdev_physical_block_size(dev->bdev);
> +}
> +
> +static inline int
> +rnbd_dev_get_max_write_same_sects(const struct rnbd_dev *dev)
> +{
> +	return bdev_write_same(dev->bdev);
> +}

Are you sure that the above functions are useful? Please do not
introduce inline functions for well known functions, especially if their
function name is longer than their implementation.

Thanks,

Bart.
