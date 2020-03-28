Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D11968E8
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 20:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgC1TbN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 15:31:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33451 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1TbM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 15:31:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id j1so6391459pfe.0;
        Sat, 28 Mar 2020 12:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=noIzwJuLliZHQuzVY+AOp3AspAm0g+pmGqKmESWOJsI=;
        b=NPPYouQ1s+f/HvIKgYxj0ZdGtsYNxo0c6CMbqNEhaF47bxBnX9PQiu9FDmU4GA2N9Y
         xLJOkAVLyfjsEzhcQR1PM5DyYYRiYQkFrfzc8dxUaw2gmLUWzR6orHZKUkB9IUoZB8gY
         Pyo8mg3WZCPyCU15i74Fqzs7oPbCODol8ins4bSlU9/KzKwZ463z6pQbSvlQSNwu0juk
         WU5yE5qdfrjaXPnYxAg+5FASYdimaIJabi71is+XFnaLu900kXBhKO9VJUXnCNSwhESz
         k4b8MPqpSAhUoOCvMy+IU9D1Z3uZEEld8bZecrueQBrU3lNxJC7KYQ+RzUHCloIYKGku
         LtBw==
X-Gm-Message-State: ANhLgQ3hEJrlzpwaJchCCrt0c77WJUNg+vw55MPMi2dRYbdTXEjQZy6z
        tQ3lTfOjGYs8R3A8ZLfv1PU=
X-Google-Smtp-Source: ADFU+vvcIKeF3iV6v2EefGwrqyHCoapLTPdFGtNBdxApLk0XGQkaXfEsP+O7HA9b0Y8BocJVBYuROg==
X-Received: by 2002:a62:3305:: with SMTP id z5mr5673621pfz.297.1585423870738;
        Sat, 28 Mar 2020 12:31:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:597d:a863:13de:4665? ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id h64sm6616093pfg.191.2020.03.28.12.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 12:31:09 -0700 (PDT)
Subject: Re: [PATCH v11 23/26] block/rnbd: server: sysfs interface functions
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-24-jinpu.wang@cloud.ionos.com>
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
Message-ID: <8ecc1c47-bad0-dadb-7861-8776b89f0174@acm.org>
Date:   Sat, 28 Mar 2020 12:31:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320121657.1165-24-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-03-20 05:16, Jack Wang wrote:
> This is the sysfs interface to rnbd mapped devices on server side:
> 
>   /sys/devices/virtual/rnbd-server/ctl/devices/<device_name>/
>     |- block_dev
>     |  *** link pointing to the corresponding block device sysfs entry
>     |
>     |- sessions/<session-name>/
>     |  *** sessions directory
>        |
>        |- read_only
>        |  *** is devices mapped as read only
>        |
>        |- mapping_path
>           *** relative device path provided by the client during mapping
> 

> +static struct kobj_type ktype = {
> +	.sysfs_ops	= &kobj_sysfs_ops,
> +};

From Documentation/kobject.txt: "One important point cannot be
overstated: every kobject must have a release() method." I think this is
something that Greg KH feels very strongly about. Please fix this.

> +int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
> +			       struct block_device *bdev,
> +			       const char *dir_name)
> +{
> +	struct kobject *bdev_kobj;
> +	int ret;
> +
> +	ret = kobject_init_and_add(&dev->dev_kobj, &ktype,
> +				   rnbd_devs_kobj, dir_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = kobject_init_and_add(&dev->dev_sessions_kobj,
> +				   &ktype,
> +				   &dev->dev_kobj, "sessions");
> +	if (ret)
> +		goto err;
> +
> +	bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
> +	ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
> +	if (ret)
> +		goto err2;
> +
> +	return 0;
> +
> +err2:
> +	kobject_put(&dev->dev_sessions_kobj);
> +err:
> +	kobject_put(&dev->dev_kobj);
> +	return ret;
> +}

Please choose more descriptive names for the goto labels, e.g.
put_sess_kobj and put_dev_kobj.

> +static ssize_t read_only_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			      char *page)
> +{
> +	struct rnbd_srv_sess_dev *sess_dev;
> +
> +	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
> +
> +	return scnprintf(page, PAGE_SIZE, "%s\n",
> +			 (sess_dev->open_flags & FMODE_WRITE) ? "0" : "1");
> +}

The scnprintf() statement looks overcomplicated. How about the following?

return scnprintf(page, PAGE_SIZE, "%d\n",
                 (sess_dev->open_flags & FMODE_WRITE) != 0);

> +void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev)
> +{
> +	DECLARE_COMPLETION_ONSTACK(sysfs_compl);
> +
> +	sysfs_remove_group(&sess_dev->kobj,
> +			   &rnbd_srv_default_dev_session_attr_group);
> +
> +	sess_dev->sysfs_release_compl = &sysfs_compl;
> +	kobject_del(&sess_dev->kobj);
> +	kobject_put(&sess_dev->kobj);
> +	wait_for_completion(&sysfs_compl);
> +}

Why is there a wait_for_completion() call in the above function? I think
Greg KH strongly disagrees with such calls in functions that remove
sysfs attributes.

> +int rnbd_srv_create_sysfs_files(void)
> +{
> +	int err;
> +
> +	rnbd_dev_class = class_create(THIS_MODULE, "rnbd-server");
> +	if (IS_ERR(rnbd_dev_class))
> +		return PTR_ERR(rnbd_dev_class);
> +
> +	rnbd_dev = device_create(rnbd_dev_class, NULL,
> +				  MKDEV(0, 0), NULL, "ctl");
> +	if (IS_ERR(rnbd_dev)) {
> +		err = PTR_ERR(rnbd_dev);
> +		goto cls_destroy;
> +	}
> +	rnbd_devs_kobj = kobject_create_and_add("devices", &rnbd_dev->kobj);
> +	if (!rnbd_devs_kobj) {
> +		err = -ENOMEM;
> +		goto dev_destroy;
> +	}
> +
> +	return 0;
> +
> +dev_destroy:
> +	device_destroy(rnbd_dev_class, MKDEV(0, 0));
> +cls_destroy:
> +	class_destroy(rnbd_dev_class);
> +
> +	return err;
> +}

Please mention the device class in the description of this patch.

Thanks,

Bart.
