Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96D41E7EB0
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgE2N3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgE2N3X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 09:29:23 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F32C03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 06:29:23 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id r16so1030632qvm.6
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IhjCRLuc4096hHqDODXUrHbkgDI43xJRrphYmOLQ/E8=;
        b=JJV7lFTyOJBj4EQeAQALEBsEu+uWvSAy/0OqJRQGyJDzX69ALjbWx/22xils7Xh3jh
         6aiRS3fAUelZL5uEF9CC0Lx0/d3oUwYa0Ukyjfmwo06tH2NrJQcWEOeYyEbJJkkjJtkC
         gf2C/A1Wvfot78+i5nYjDzCDIRgmnIToVwKarC0KGdwq4271zB92OxnuzKWV53XKcwTN
         SliFYsuuvuaU6ADEh72zwMA1RrDXe5qBfrA+25Ti5NxG8w7Xib8kksKkIvvraM8G89/s
         e+TTEEB0MfRQmm+0vqIZ63VMth0r6ZGAUl/lvZa1Mu+gdTjGQTW2QwsUqBuTeMQCVqCc
         n6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IhjCRLuc4096hHqDODXUrHbkgDI43xJRrphYmOLQ/E8=;
        b=WwqoxEGH9Rp/gsCUfg35qJjO5GpHmrbHbhKvhQARTn7idX8EzohR9FLvhs0X7QADAo
         ennNM8liJSHtJS+NtO8xpRkLX5dqAjdtKJKLVe/CcjxX/4pc5PVMzoGnr6BmkrF1zTIV
         zIEN2ta6MlqHzkjVRUyRpAckBNBxjxpcP+tw6Csf1vW1mbMkJ/zWzfMpcFivbXFbXE33
         f/wOcQCHIpZY1rlWsh80efgNRwve6J4Tgdyzr0Y9cb2j8u6pV10KWj2lDEkoSa7mR79D
         ks7yYjgAVZ1uTY/FTJ7wZvA3V2AQ2F7hvgA46tVfXV+eFsPbkbXTShlBb7V4AfJATdua
         4JEA==
X-Gm-Message-State: AOAM530VuSAqJwBz7SPeoIvBJv2HAYOx0DG0G1g0izgJIIHQQp4iFGQZ
        enF4/bgSDmSAo0XGmxiEq9ealBW/zlY=
X-Google-Smtp-Source: ABdhPJwBk/u8BjN2Lsc6KJXrjlC+JoQf/i4zOmXIAyovGLn6ZnPX/loXE9zTynG8SFRWakhghez2eA==
X-Received: by 2002:a05:6214:3ee:: with SMTP id cf14mr8493899qvb.128.1590758962369;
        Fri, 29 May 2020 06:29:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p13sm500215qtk.24.2020.05.29.06.29.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 06:29:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jeelm-0007zu-EH; Fri, 29 May 2020 10:09:54 -0300
Date:   Fri, 29 May 2020 10:09:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+478fd0d54412b8759e0d@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, michal.kalderon@marvell.com,
        syzkaller-bugs@googlegroups.com, yishaih@mellanox.com
Subject: Re: KASAN: use-after-free Read in ib_uverbs_remove_one
Message-ID: <20200529130954.GA21651@ziepe.ca>
References: <00000000000095442505a6b63551@google.com>
 <20200529083126.15808-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529083126.15808-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 29, 2020 at 04:31:26PM +0800, Hillf Danton wrote:
> Hold another grab to dev to prevent it from going home before work gets
> done with it.
> 
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -1152,6 +1152,8 @@ static int ib_uverbs_add_one(struct ib_d
>  		  device->ops.mmap ? &uverbs_mmap_fops : &uverbs_fops);
>  	uverbs_dev->cdev.owner = THIS_MODULE;
>  
> +	/* pair with put_device() in ib_uverbs_remove_one() */
> +	get_device(&uverbs_dev->dev);
>  	ret = cdev_device_add(&uverbs_dev->cdev, &uverbs_dev->dev);
>  	if (ret)
>  		goto err_uapi;

Doesn't look right, the put_device() in uverbs_remove_one() pairs with
the device_initialize() in this function.

The only thing I can think of is we called remove_once twice
somehow or had an extra put on some error path. But I couldn't find
any flow that would do either of those things

Jason
