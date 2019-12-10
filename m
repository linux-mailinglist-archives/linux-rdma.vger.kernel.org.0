Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70C3118FAF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfLJSWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 13:22:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46517 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfLJSWO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Dec 2019 13:22:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id g18so16319647otj.13
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Vy5gqa14MFPxKZ2ZwVgNPXutvyEa2q5+JvzsiuCuAg=;
        b=j6PH8cK+5VL3VTCnkX8uqFYDQNP+vNIo5nRIc3dY5kMKEbyXH3lqEjI1YbD19X9ESm
         ntY5RDqTWLconEJ5ozxCPH8u5ipKSOQG993WfszwLmZvznzqEI0kBUXy/4VF8eQW+LS/
         /LhswAx3TuV3tHg23/3DWbyfjEbwndcu6r6BOVM23oPLclgr1BW8hMS1Bsn6+rAmew7z
         l+iRDT/xkzmEBvi4Am0I/y6xSGoTw/DJFTmcHPhiR8cEf3WWceWNDr1bIclbLPu1d5ts
         m8/20Hq4ctytg6w3hWGgNZw/t37ddyW5sfjvdZq24Qx20s4o+9+F2NjQPS4ACy3Zyc6R
         UEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Vy5gqa14MFPxKZ2ZwVgNPXutvyEa2q5+JvzsiuCuAg=;
        b=naTqnBqYkGk0x9kQ+W3lM/ipx8eAX2t3mgG9u+7ayjrh6unFF+USaHNIE6i0M6GQOo
         XSwN2+d3RPfw9279tDOQFOKXzw8xDx1NXAH7J9OViS3eeWcMjanmpVk8weJXptQBIsH3
         e2hU9bLVNs6ud1mCtU7rlwNIdieBK5RUe9+QHJoF1nKazp21ii60KBC/Ctc+9SWp86SK
         ucEfkqCe1c2LFxHkyGmJgNS4AVelSK9Xv3nZAJyBWZiqLDNMGCqk9O81YHr7uwnu9SzX
         trIHY8n6RrXlCE7ns7qXCRkV5uSlV2RCWM8RhmiHIQjEB2IhFjsI7RI8X8fUneYzGg4X
         9V7Q==
X-Gm-Message-State: APjAAAVJboBGQ7rHXTq/UkaiQ1ZXEujKtLnia9YZp9Nl30vbwBcK1OsZ
        JOTEYGV0lPRCzspx9aMNi4GQHA==
X-Google-Smtp-Source: APXvYqyULL/mBywFzCzgOFmeDt3apg3fAZfTuiYMXsH82AiDFPXwyKHFirq2I+ej09hTUhvFyioffA==
X-Received: by 2002:a05:6830:18ce:: with SMTP id v14mr24827282ote.254.1576002133249;
        Tue, 10 Dec 2019 10:22:13 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id w72sm1644200oie.49.2019.12.10.10.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 10:22:12 -0800 (PST)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iek9D-00001W-Jp; Tue, 10 Dec 2019 14:22:11 -0400
Date:   Tue, 10 Dec 2019 14:22:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        Dave Ertman <david.m.ertman@intel.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, parav@mellanox.com,
        Kiran Patil <kiran.patil@intel.com>
Subject: Re: [PATCH v3 01/20] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191210182211.GD46@ziepe.ca>
References: <20191209224935.1780117-1-jeffrey.t.kirsher@intel.com>
 <20191209224935.1780117-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209224935.1780117-2-jeffrey.t.kirsher@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 09, 2019 at 02:49:16PM -0800, Jeff Kirsher wrote:

> +#define to_virtbus_dev(x)	(container_of((x), struct virtbus_device, dev))
> +#define to_virtbus_drv(x)	(container_of((x), struct virtbus_driver, \
> +				 driver))

Please use static inlines for things like this, it makes the type
system clearer

> +/**
> + * virtbus_dev_register - add a virtual bus device
> + * @vdev: virtual bus device to add
> + */
> +int virtbus_dev_register(struct virtbus_device *vdev)
> +{
> +	int ret;
> +
> +	device_initialize(&vdev->dev);

I generally try to discourage the pattern where the device_initialize
is inside a function called register.

The kref inside the struct device should be the only kref for this
memory, and the kref system should be setup close to allocating the
memory. Any non-trivial user tends to require access to the kref
before calling register (which should be done last)

> +	/* All device IDs are automatically allocated */
> +	ret = ida_simple_get(&virtbus_dev_ida, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;

Should this be a cyclic allocation?

> +
> +	vdev->id = ret;
> +	dev_set_name(&vdev->dev, "%s.%d", vdev->name, vdev->id);

This is also stuff that can be useful to do early as the driver can
then use functions like dev_warn/etc

> +struct virtbus_object {
> +	struct virtbus_device vdev;
> +	char name[];
> +};

This whole virtbus_object makes no sense to me

> +
> +/**
> + * virtbus_dev_release - Destroy a virtbus device
> + * @vdev: virtual device to release
> + *
> + * Note that the vdev->data which is separately allocated needs to be
> + * separately freed on it own.

How will that happen?

> + */
> +static void virtbus_dev_release(struct device *dev)
> +{
> +	struct virtbus_object *vo = container_of(dev, struct virtbus_object,
> +						 vdev.dev);
> +
> +	ida_simple_remove(&virtbus_dev_ida, vo->vdev.id);
> +	kfree(vo);
> +}

Is something wrong with my search? I couldn't find a user for this?

If the virtbus framework wants to provide a release function then it
should also provide the alloc and require that the virtbus_device be
at offset 0 in the caller's struct so that the above kfree can work.
(ie like netdev does with the whole priv thing)

I have no idea what the virtbus_object is supposed to be doing here.

> +struct virtbus_device {
> +	const char *name;
> +	int id;

id is always positive, should be unsigned

Jason
