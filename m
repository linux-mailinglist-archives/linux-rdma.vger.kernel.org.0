Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481D3174AD2
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 03:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgCACry (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 21:47:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37718 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCACry (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 21:47:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so3775441pfn.4;
        Sat, 29 Feb 2020 18:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Gw0IFR/EUVDvXUV1xeXzzcWx/laBmQxFf4M2NtXCOlw=;
        b=Pc0LEan4nR0GK7LOKw7jNwDnTjxFRdIYgUfglGGffPKvK468FCIE6Mldx3bc5IXVe8
         xDHeW6AMi0dzV6Qdoc0uYLkDHAu2KZmNx34q6RXrt9TOAYqMLbfFtrVEdfsoGc3yhfMp
         Ygc/YddQ1F0GfkZR7u3zq0lVg8gyqICJ4bfKA8TRtafCJ4YxZfdtu5qOp4+kuJlNDGVu
         m93pgyQFdXnGiO9kqqHyX99V70YPd7/le11xsTKwXBzDxRhbn65MIxzEA4kHQPupaQF9
         iW85w2M62UfJpl5viyUgg2FYxhYWdagjYShd3CQ8SIJu0c9Igc3QNZwAUpqi3Uu+rGcR
         KxcA==
X-Gm-Message-State: ANhLgQ2zgkPJCQ67YiUE8YmQSBsmBaO+G4jgAILn3Mxre+HryajdAtLO
        2pT1D7aHR+e4tq5QW5zItfM=
X-Google-Smtp-Source: ADFU+vuw3ydrZK53gC3kBrUb9DecjBZQsh7sKIUxKfrT4n7HdfoPw5AUhJu6cxHpGG/AT3Dd3EHk+Q==
X-Received: by 2002:a63:5465:: with SMTP id e37mr8803521pgm.411.1583030873476;
        Sat, 29 Feb 2020 18:47:53 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id s23sm6999907pjq.17.2020.02.29.18.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 18:47:52 -0800 (PST)
Subject: Re: [PATCH v9 19/25] block/rnbd: server: private header with server
 structs and functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-20-jinpuwang@gmail.com>
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
Message-ID: <c32d59b7-6cd5-2e9b-0faa-3dee29a26a91@acm.org>
Date:   Sat, 29 Feb 2020 18:47:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-20-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:47, Jack Wang wrote:
> +/* Structure which binds N devices and N sessions */
> +struct rnbd_srv_sess_dev {
> +	/* Entry inside rnbd_srv_dev struct */
> +	struct list_head		dev_list;
> +	/* Entry inside rnbd_srv_session struct */
> +	struct list_head		sess_list;
> +	struct rnbd_dev		*rnbd_dev;
> +	struct rnbd_srv_session        *sess;
> +	struct rnbd_srv_dev		*dev;
> +	struct kobject                  kobj;
> +	struct completion		*sysfs_release_compl;
> +	u32                             device_id;
> +	fmode_t                         open_flags;
> +	struct kref			kref;
> +	struct completion               *destroy_comp;
> +	char				pathname[NAME_MAX];
> +	enum rnbd_access_mode		access_mode;
> +};
Please indent structure members consistently. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
