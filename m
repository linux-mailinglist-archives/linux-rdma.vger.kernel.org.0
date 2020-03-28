Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B46419682D
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 18:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgC1RlC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 13:41:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44983 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RlC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 13:41:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id 142so6322474pgf.11;
        Sat, 28 Mar 2020 10:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jkOHlRAoN+j03l4CPBRNAGNX/d7wFgHYyCjnbfVxJCo=;
        b=nhJZgSHH6YTorJ/GV9ldVPVWfZM7xn7Ye4miibqHqtlXSXq0YlpRXwep+VlKS/jfyU
         I8oSDM9W7BEvlOPitqeAlOdR9jFqmdKk464pNuSlXkhdR1sHQLHEghhrh9dkvCmLDBk9
         EFsD7wQr6kCbYVuZ5FWnEMkV9mjYVGN494nsERgBEoJ6NCyynUpouM78xKy1JoDnYT+k
         nEKhO3NDPe9VWKZIHKvDLN8JFrMhrUhitb54NByjnOSDPNTvNIKGD3boor4iLG4OXGhr
         Of/4e/DQ07ZgKp/qq6UmFo4TOWyNaJ2LabWG/C/59HSdyJbVU5ea0+qD5LX/JVNeSG7c
         jhbw==
X-Gm-Message-State: ANhLgQ3POo5YM3g35QT4F54JBlDk9Cqlqy2lvPXQA0Lw8maXayWv6r2y
        GG79iHRRrwrEbfmL5GS+c4M=
X-Google-Smtp-Source: ADFU+vtRxBcXr0Kaz6brD/hFUX6/7V06bPiXPxeOSYVZ/fPqFFdVtV8hndPJyKfJoBnpTLuICnUEiQ==
X-Received: by 2002:a63:67c7:: with SMTP id b190mr5289865pgc.289.1585417260586;
        Sat, 28 Mar 2020 10:41:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:597d:a863:13de:4665? ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id x70sm6158596pgd.37.2020.03.28.10.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 10:40:59 -0700 (PDT)
Subject: Re: [PATCH v11 21/26] block/rnbd: server: main functionality
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-22-jinpu.wang@cloud.ionos.com>
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
Message-ID: <ba7c258f-a169-f2d5-3d62-62a7d09908a4@acm.org>
Date:   Sat, 28 Mar 2020 10:40:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320121657.1165-22-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-20 05:16, Jack Wang wrote:
> +static int __read_mostly port_nr = RTRS_PORT;

Would uint16_t be sufficient for this kernel module parameter?

Is this kernel module parameter used anywhere in the hot path? If not,
should __read_mostly perhaps be left out?

> +module_param_named(port_nr, port_nr, int, 0444);
> +MODULE_PARM_DESC(port_nr,
> +		 "The port number server is listening on (default: "
                                ^^^
                                the?
> +		 __stringify(RTRS_PORT)")");
> +
> +#define DEFAULT_DEV_SEARCH_PATH "/"

> +static void destroy_device(struct rnbd_srv_dev *dev)
> +{
> +	WARN(!list_empty(&dev->sess_dev_list),
> +	     "Device %s is being destroyed but still in use!\n",
> +	     dev->id);

Has it been considered to change WARN() into WARN_ONCE()?

> +static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
> +			     struct rtrs_srv_op *id, int dir,
> +			     void *data, size_t datalen, const void *usr,
> +			     size_t usrlen)
> +{
> +	struct rnbd_srv_session *srv_sess = priv;
> +	const struct rnbd_msg_hdr *hdr = usr;
> +	int ret = 0;
> +	u16 type;
> +
> +	if (WARN_ON(!srv_sess))
> +		return -ENODEV;

Same question here: how about using WARN_ON_ONCE() instead of WARN_ON()?

> +static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
> +				     const char *dev_name)
> +{
> +	char *full_path;
> +	char *a, *b;
> +
> +	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!full_path)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Replace %SESSNAME% with a real session name in order to
> +	 * create device namespace.
> +	 */
> +	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
> +	if (a) {
> +		int len = a - dev_search_path;
> +
> +		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
> +			       dev_search_path, srv_sess->sessname, dev_name);
> +		if (len >= PATH_MAX) {
> +			pr_err("Tooooo looong path: %s, %s, %s\n",
> +			       dev_search_path, srv_sess->sessname, dev_name);
> +			kfree(full_path);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	} else {
> +		snprintf(full_path, PATH_MAX, "%s/%s",
> +			 dev_search_path, dev_name);
> +	}

Has it been considered to use kasprintf() instead of kmalloc() + snprintf()?

Otherwise this patch looks fine to me.

Thanks,

Bart.
