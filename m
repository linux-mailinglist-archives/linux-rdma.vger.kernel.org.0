Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52B21EC64
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEOKuh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 May 2019 06:50:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44323 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEOKuh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 06:50:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so3454386edm.11
        for <linux-rdma@vger.kernel.org>; Wed, 15 May 2019 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nCNWYp2w6Tl48GP0kBwv+o2DolEmxAkLlsEn0Kytpvk=;
        b=FXoEgz40TIaz42Fosrb08GUbhT+o8YKHOE18fJdH7EIIg85EifMfDaB8HgKjAw7Xzs
         AecRs+3Uh6qzO6l8vZkARBGTwNlgD4NP9f4+/8l4XG1MBNXt4N2Jqa/TzwuB/l5jPhgX
         a+UbaFFNjpcab2AT5ORj9CVgP2OjqDD6cYMQPQluLeLovAeHBjYjmEyEMPiJqAtueDj8
         GcaG6Nqlm+cBoapJVPRgsJnVYnUY5QkyC9Alf2Kjno4tbeknRlT4KCY2QeLI7zSjEx0P
         SG7QU3jyBvUDvXWWq/1ikZp1l+AilV6UwaW2pgW10SGotvGpf3rAKi6DzP3ikuRuSObq
         GmhA==
X-Gm-Message-State: APjAAAXjYBQTvpFzxq52QjI7PCPvR/ZOuaxMY063u4EQsNXT/jwvV/Q3
        ToQJKG/6mHXA4ux+aliaoT8T6Bfj
X-Google-Smtp-Source: APXvYqwwWlUzCUqZNcFUbu4zj4FpYau+V7OkwW/hoQjiw3ndrYOBvVrmuQho/i2TEQRS9HJWA6/rTw==
X-Received: by 2002:a50:fa01:: with SMTP id b1mr34521395edq.199.1557917435672;
        Wed, 15 May 2019 03:50:35 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id b48sm657713edb.28.2019.05.15.03.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:50:34 -0700 (PDT)
Subject: Re: [RFC PATCH rdma-next] RDMA/srp: Don't cache device name as part
 of sysfs name
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190515095013.8141-1-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <20587db8-fd08-534b-56d6-98d261c41914@acm.org>
Date:   Wed, 15 May 2019 12:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515095013.8141-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/15/19 11:50 AM, Leon Romanovsky wrote:
> @@ -4089,11 +4093,15 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
> 
>  	host->dev.class = &srp_class;
>  	host->dev.parent = device->dev->dev.parent;
> -	dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
> -		     port);
> +	devnum = find_first_zero_bit(dev_map, SRP_MAX_DEVICES);
> +	if (devnum >= SRP_MAX_DEVICES)
> +		goto free_host;
> +	set_bit(devnum, dev_map);
> +	host->devnum = devnum;
> +	dev_set_name(&host->dev, "srp%d", devnum);
> 
>  	if (device_register(&host->dev))
> -		goto free_host;
> +		goto free_num;
>  	if (device_create_file(&host->dev, &dev_attr_add_target))
>  		goto err_class;
>  	if (device_create_file(&host->dev, &dev_attr_ibdev))

Hi Leon,

Thank you for having root-caused this issue. However, this patch
modifies the ABI between kernel and user space and hence breaks at least
srp_daemon and blktests. Are you aware it is considered completely
unacceptable in the Linux community to break user space? You may have
noticed that the SRP sysfs ABI has been documented in
Documentation/ABI/stable/sysfs-driver-ib_srp.

Bart.

