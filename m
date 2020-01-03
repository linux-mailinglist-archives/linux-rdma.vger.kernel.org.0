Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1F12FF05
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2020 00:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgACXMO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 18:12:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39534 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgACXMO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 18:12:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so35043262qko.6
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 15:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VopHHMQ8fPWQuoa8pKm/msya8uzrRfq6MCT7ziAQPAo=;
        b=hz41WyxlqB6iO5deOHvIkCbe/j25er3HpU//eGsd8+PlWY/Bh/Qa/JRSp4Nz+D+aJm
         s8st4Tm1aW6RBeGPo8UzPtjAVzBh8BJ28cpSzWvCQIPGMGwz7vnzjNHDdzyI2Rl/fEBO
         MzwnNfS1ECBuhz2jaPm4juHwSS27wUxd2Zz2JXXPASgm/hoaexARNNawDZk9RekyCC9k
         +Sa49l0D6rcu88oQXE+qc8KkksIGlKzVONF3A8DXt1MARRaz1uMpUwdhV+/jAQm2HCaD
         Krg5NvrIfSmIywCtsXYKZoUrzrcweqj4uDPlS7tKW4/JZ1IU4i5IdGSPxg9DUv7jfYRK
         qE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VopHHMQ8fPWQuoa8pKm/msya8uzrRfq6MCT7ziAQPAo=;
        b=EmJ/TW7kCTyQS624CxrvWosgDMrXsASgNZwsRSywM+Qdjjt+5TOobKuqtXacn4eYQN
         bDQCaZ2EEym/WxeA10o3EmhNdIvvgDWdFkuyBVcuqF4fWxZY8+K6ZQk6GRYOP3nT0yEq
         QeTqfsgQmchaJHbPqcW6zVcyyAvhwxTkTbvu5V86njLvC8dMB9pHBGYGX0Ee81SPPfLS
         t+YfixYb0eMFsj+Qz980Gmd1tVC7FNlSUtU5eTX+W2EtS3/wlpYiXKAB55mZ59oPUEBQ
         oWxOM+caiFJOnp5qkGzrQ0kZrI7eDXtoyrsEqypftaxTJmT+Qpq1lJzZZXHjhLiZytr9
         xC3w==
X-Gm-Message-State: APjAAAVnVvAXty4TGQ9dBGRZ8RVf3Y0BfkwsbK1CCx2VZVS1fC2eYLwL
        hEs3U8Be9JtVgC9+88QRNrtrBg==
X-Google-Smtp-Source: APXvYqwFL3ZqI4iC5lFf5COv/ibrYiDTOeKBgIM1N3msm8xwVdd+xnYooopiW1AIJ5YKV20p5V7SVA==
X-Received: by 2002:a37:496:: with SMTP id 144mr73277674qke.338.1578093133544;
        Fri, 03 Jan 2020 15:12:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r66sm17130903qkd.125.2020.01.03.15.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 15:12:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inW72-00053j-OY; Fri, 03 Jan 2020 19:12:12 -0400
Date:   Fri, 3 Jan 2020 19:12:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix storing node_desc
Message-ID: <20200103231212.GA18973@ziepe.ca>
References: <20191223093943.17883-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223093943.17883-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 23, 2019 at 11:39:43AM +0200, Kamal Heib wrote:
> When writing to node_desc sysfs using echo a new line symbol will be
> stored at the end of the string, avoid that by dropping the new line

Why do we want to do this? AFAIK technically new line is valid in a
node description.

> symbol and also make sure to return -EINVAL when the supplied string is
> bigger then IB_DEVICE_NODE_DESC_MAX.

This makes sense though

> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index 087682e6969e..2de5f6710c0b 100644
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -1263,12 +1263,21 @@ static ssize_t node_desc_store(struct device *device,
>  {
>  	struct ib_device *dev = rdma_device_to_ibdev(device);
>  	struct ib_device_modify desc = {};
> +	size_t len;
>  	int ret;
>  
>  	if (!dev->ops.modify_device)
>  		return -EOPNOTSUPP;
>  
> -	memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));

> +	if (count > IB_DEVICE_NODE_DESC_MAX)
> +		return -EINVAL;
> +
> +	len = strlen(buf);

Why strlen? The buf is count bytes long.

> +	if (buf[len - 1] == '\n')
> +		len--;

And if it is zero bytes this buffer underflows

> +	strncpy(desc.node_desc, buf, len);

What was the point of switching away from memcpy?

> +	desc.node_desc[len] = 0;
>  	ret = ib_modify_device(dev, IB_DEVICE_MODIFY_NODE_DESC, &desc);
>  	if (ret)
>  		return ret;

Jason
