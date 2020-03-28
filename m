Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6B319689E
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 19:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1Sjx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 14:39:53 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37347 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgC1Sjw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 14:39:52 -0400
Received: by mail-pj1-f67.google.com with SMTP id o12so5311624pjs.2;
        Sat, 28 Mar 2020 11:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XerZ3Gorggp6JfGE9WxhW/P41bOToikN7aDIdEAHasU=;
        b=Fgi4zVB+S6Cs2sFQrf5/FkaaH2k2EpnLgL4hyzJK825ASyIblcL03S8wATdRC0CBmk
         r+QCrRLOEqrxwvPAtdHmxPNS4bW75VC+AuhFycmewDAG32wLqdp2vfMejj2q+14ptkP+
         hOG1GVNPLDbYc1xbpYiApcPPrdj6UnOLir77sMEWog3QvBPCMi4JW57/d5hj+cu0FYmF
         Nef0Q4KmrS5hFRLNw9126VX5glK9wLuAN5eURyBiJTaWBtkMnhshZFW9eGgsDxK4Y3fv
         pAdsB2HJwBpJPOQRfpW6MrJ9SVZ+d4S2I/+3y7wvTLTZMVHsaY4F43XPB8+6NAR0eMN4
         ElhA==
X-Gm-Message-State: ANhLgQ1rBvWbFipSzJ6Vk2SykX2WQu14Ts4avsgG0ejzGcuieAlpiOIg
        TIT5hKjcFAw1NL4YUPkcF0E=
X-Google-Smtp-Source: ADFU+vsYYKjO2+LiH7X1NsG9tMzGqwyerZnbgfYC0fuyGOSYCllpNPIdjpiLvHCBdUAzbn/j4tW/Jg==
X-Received: by 2002:a17:90a:37c6:: with SMTP id v64mr6441101pjb.20.1585420791214;
        Sat, 28 Mar 2020 11:39:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:597d:a863:13de:4665? ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id k20sm6216119pgn.62.2020.03.28.11.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 11:39:50 -0700 (PDT)
Subject: Re: [PATCH v11 22/26] block/rnbd: server: functionality for IO
 submission to file or block dev
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-23-jinpu.wang@cloud.ionos.com>
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
Message-ID: <cfe1dba2-04f7-f74d-af90-c70dce4d85cf@acm.org>
Date:   Sat, 28 Mar 2020 11:39:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320121657.1165-23-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-20 05:16, Jack Wang wrote:
> This provides helper functions for IO submission to file or block dev.

Regarding the title of this patch: is file I/O still supported? Wasn't
that support removed some time ago?

> +struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
> +			       void (*io_cb)(void *priv, int error))
> +{
> +	struct rnbd_dev *dev;
> +	int ret;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev->blk_open_flags = flags;
> +	dev->bdev = blkdev_get_by_path(path, flags, THIS_MODULE);
> +	ret = PTR_ERR_OR_ZERO(dev->bdev);
> +	if (ret)
> +		goto err;
> +
> +	dev->blk_open_flags	= flags;
> +	dev->io_cb		= io_cb;
> +	bdevname(dev->bdev, dev->name);
> +
> +	return dev;
> +
> +err:
> +	kfree(dev);
> +	return ERR_PTR(ret);
> +}

This function only has one caller so io_cb is always equal to the
argument passed by that single caller, namely rnbd_endio. If that
argument and also dev->io_cb would be removed, would that make the hot
path faster?

> +int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
> +			size_t len, u32 bi_size, enum rnbd_io_flags flags,
> +			short prio, void *priv)
> +{
> +	struct request_queue *q = bdev_get_queue(dev->bdev);
> +	struct rnbd_dev_blk_io *io;
> +	struct bio *bio;
> +
> +	/* check if the buffer is suitable for bdev */
> +	if (WARN_ON(!blk_rq_aligned(q, (unsigned long)data, len)))
> +		return -EINVAL;

The blk_rq_aligned() check looks weird to me. bio_map_kern() can handle
data buffers that do not match the DMA alignment requirements, so why to
refuse data buffers that are not satisfy DMA alignment requirements?

> +	/* Generate bio with pages pointing to the rdma buffer */
> +	bio = bio_map_kern(q, data, len, GFP_KERNEL);
> +	if (IS_ERR(bio))
> +		return PTR_ERR(bio);
> +
> +	io = kmalloc(sizeof(*io), GFP_KERNEL);
> +	if (unlikely(!io)) {
> +		bio_put(bio);
> +		return -ENOMEM;
> +	}
> +
> +	io->dev		= dev;
> +	io->priv	= priv;
> +
> +	bio->bi_end_io		= rnbd_dev_bi_end_io;
> +	bio->bi_private		= io;
> +	bio->bi_opf		= rnbd_to_bio_flags(flags);
> +	bio->bi_iter.bi_sector	= sector;
> +	bio->bi_iter.bi_size	= bi_size;
> +	bio_set_prio(bio, prio);
> +	bio_set_dev(bio, dev->bdev);

I think Jason strongly prefers to have a single space at the left of the
assignment operator.

Thanks,

Bart.
