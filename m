Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C139196394
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 05:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgC1Ep7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 00:45:59 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39597 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgC1Ep6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 00:45:58 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so4152777pjr.4;
        Fri, 27 Mar 2020 21:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l6C6ZBe+UtdZKYs2sL2qwQh0u+MiZxDhGlUcxqRdTiU=;
        b=q/xlYjh/xeEqXMJUVNPOE6wkQwLLVhE6Lh/xaj2UflvBwS1+Tm1IrqjBjVOS7FHaZg
         ENRkx01f3Xd+uiM/4QOQnS61ihIjJ+lPjui5Hty7qzGgsrJeyXU2kqQ0Ebp2SSv4sjsb
         66TTgvw9Rf25m01iRjg50rWt7Qql+WvVAWz47FXCfHIrs1Z5Y1LQA+IWjypif3IGUZVm
         OOpAwK33Zn4ZIjdZK7e5NP5CWhmyVmUI8mSMQjRiLDe7O5hJYQQRZasfXPrR4ruAooK2
         z8rfn3Lpkx6BCpgJyNnsg63PXzpL07Fs0QWR0ekEyCRyGdAV04t/mXAcl24id9k5pYvK
         8RDA==
X-Gm-Message-State: ANhLgQ02G4L8XC+Va6baJB8mNr41nIm+/yKaVwVLJtvXbc4PGGtqpww0
        StWSHn42y3d1hCeyGoHeqgA=
X-Google-Smtp-Source: ADFU+vuX8N8R/1MK1iZSNCs9CPwL080thby0bli9GdRE+Me1zNNk++7qFmAyVNGSjfwgBI97mUrbaQ==
X-Received: by 2002:a17:90a:be0b:: with SMTP id a11mr3076357pjs.56.1585370756886;
        Fri, 27 Mar 2020 21:45:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3563:edda:f4cf:995c? ([2601:647:4000:d7:3563:edda:f4cf:995c])
        by smtp.gmail.com with ESMTPSA id j96sm4340242pje.32.2020.03.27.21.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 21:45:56 -0700 (PDT)
Subject: Re: [PATCH v11 18/26] block/rnbd: client: main functionality
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-19-jinpu.wang@cloud.ionos.com>
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
Message-ID: <198cd2da-cbf8-17b0-3ee5-5dec366a43e2@acm.org>
Date:   Fri, 27 Mar 2020 21:45:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320121657.1165-19-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-20 05:16, Jack Wang wrote:
> +static void rnbd_clt_put_dev(struct rnbd_clt_dev *dev)
> +{
> +	might_sleep();
> +
> +	if (refcount_dec_and_test(&dev->refcount)) {
> +		mutex_lock(&ida_lock);
> +		ida_simple_remove(&index_ida, dev->clt_device_id);
> +		mutex_unlock(&ida_lock);
> +		kfree(dev->hw_queues);
> +		rnbd_clt_put_sess(dev->sess);
> +		mutex_destroy(&dev->lock);
> +		kfree(dev);
> +	}
> +}

Please use the coding style that is used elsewhere in the kernel, namely
return early to keep the indentation level low.

> +enum {
> +	RNBD_DELAY_10ms   = 10,
> +	RNBD_DELAY_IFBUSY = -1,
> +};

How about removing the RNBD_DELAY_10ms constant and using 10/*ms*/ instead?

> +enum {
> +	NO_WAIT = 0,
> +	WAIT    = 1
> +};
> +
> +static int send_usr_msg(struct rtrs_clt *rtrs, int dir,
> +			struct rnbd_iu *iu, struct kvec *vec, size_t nr,
> +			size_t len, struct scatterlist *sg, unsigned int sg_len,
> +			void (*conf)(struct work_struct *work),
> +			int *errno, bool wait)

Are the NO_WAIT and WAIT perhaps values that are passed as the last
argument to send_usr_msg()? If so, please use a proper enumeration type
instead of 'bool'.

> +static int rnbd_client_getgeo(struct block_device *block_device,
> +			       struct hd_geometry *geo)
> +{
> +	u64 size;
> +	struct rnbd_clt_dev *dev;
> +
> +	dev = block_device->bd_disk->private_data;
> +	size = dev->size * (dev->logical_block_size / SECTOR_SIZE);
> +	geo->cylinders	= (size & ~0x3f) >> 6;	/* size/64 */
> +	geo->heads	= 4;
> +	geo->sectors	= 16;
> +	geo->start	= 0;
> +
> +	return 0;
> +}

Is the "& ~0x3f" in the above function perhaps superfluous?

> +static void rnbd_clt_dev_kick_mq_queue(struct rnbd_clt_dev *dev,
> +					struct blk_mq_hw_ctx *hctx,
> +					int delay)
> +{
> +	struct rnbd_queue *q = hctx->driver_data;
> +
> +	if (delay != RNBD_DELAY_IFBUSY)
> +		blk_mq_delay_run_hw_queue(hctx, delay);
> +	else if (unlikely(!rnbd_clt_dev_add_to_requeue(dev, q)))
> +		/*
> +		 * If session is not busy we have to restart
> +		 * the queue ourselves.
> +		 */
> +		blk_mq_delay_run_hw_queue(hctx, RNBD_DELAY_10ms);
> +}

I think the above code will be easier to read if RNBD_DELAY_10ms is
changed into 10/*ms*/.

> +static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
> +				   const struct blk_mq_queue_data *bd)
> +{
> +	struct request *rq = bd->rq;
> +	struct rnbd_clt_dev *dev = rq->rq_disk->private_data;
> +	struct rnbd_iu *iu = blk_mq_rq_to_pdu(rq);
> +	int err;
> +
> +	if (unlikely(dev->dev_state != DEV_STATE_MAPPED))
> +		return BLK_STS_IOERR;
> +
> +	iu->permit = rnbd_get_permit(dev->sess, RTRS_IO_CON,
> +				      RTRS_PERMIT_NOWAIT);
> +	if (unlikely(!iu->permit)) {
> +		rnbd_clt_dev_kick_mq_queue(dev, hctx, RNBD_DELAY_IFBUSY);
> +		return BLK_STS_RESOURCE;
> +	}
> +
> +	blk_mq_start_request(rq);
> +	err = rnbd_client_xfer_request(dev, rq, iu);
> +	if (likely(err == 0))
> +		return BLK_STS_OK;
> +	if (unlikely(err == -EAGAIN || err == -ENOMEM)) {
> +		rnbd_clt_dev_kick_mq_queue(dev, hctx, RNBD_DELAY_10ms);
> +		rnbd_put_permit(dev->sess, iu->permit);
> +		return BLK_STS_RESOURCE;
> +	}
> +
> +	rnbd_put_permit(dev->sess, iu->permit);
> +	return BLK_STS_IOERR;
> +}

Would it be possible to use the .get_budget / .put_budget callbacks for
obtaining / releasing a "permit" object? I'm asking this because it was
really tricky to get the .get_budget / .put_budget calls right in the
block layer core. See also commit 0bca799b9280 ("blk-mq: order getting
budget and driver tag") # v4.17.

Thanks,

Bart.
