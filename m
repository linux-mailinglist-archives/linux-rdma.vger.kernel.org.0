Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117C558AC0F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 16:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiHEOCd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiHEOCc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 10:02:32 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D231F2CE
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 07:02:31 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id d1so1842038qvs.0
        for <linux-rdma@vger.kernel.org>; Fri, 05 Aug 2022 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PFnHGBECzH93Bid1BcKUvOoiH9cK0ZrzfdY2sz0NSVc=;
        b=SRV9cO/VpygIMukey2dbFcaehhdni/hFVT+6U6EAJ6zXrCXpY2RjCF1G/gbePvpWcf
         hRvZC4efs3/TwwkyqqD8+cVnHKa6n+elQw/9p+mZf5Nkn23Vk69lZZrZcW5LJP1gLTCZ
         h4rMejPk9KeoJCUBHKoeLMgmmqjVKThJOIu/l9OgGpKINhozfZt4k3EKL6Lq8tFzrfmQ
         y8oRsvq7yydRdFviNXUw0fvB6t4XjIIggtsjdsidIa7fxkOCE95zFKQQ7v3evzZlz5em
         t+Xa4AqaGoDfXKnoaFkFjEbiGTj6h49hkMiRcK75DSTzvVROSWEJ53JLZPNFdVxD+IoY
         BOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PFnHGBECzH93Bid1BcKUvOoiH9cK0ZrzfdY2sz0NSVc=;
        b=qP9GpzI80Zy/0D4vuwQE1uH1RjhUXCJ9E6+HdPEV19IW7B3mol9R8RVER74Vfi85wC
         jC9lYgafmwU8zPAZGyvJnzAnKZ6WoRh2zFSbQLrWA201kR0CgQRSSNOe//dE4Oz0ffiR
         O4eSTkb6APvXqpW6lX2eyACef46vsrjjo3RzWQo2wEiqoURAunNT8fnL+n29JWSWFRC/
         JkO4eyFxSzk1Ws/e/ZjjAbY1Zrl/ea+esFedJPmJzjZlK0wn3R5ceURcHUblQsuhSNI0
         N3cih1oDfpyWCbftLT2EGuyWURavvlhAEYrHR6/ZGLGeIwzKluvHgcXj9GaYl/f2YdQF
         juhQ==
X-Gm-Message-State: ACgBeo1SybI8WkeZxBq0R4bpCyCE7vm/uiph4sfdYcCj+JfD4udgPGpE
        mistahNd6nRljs8vmvAQo90hxg==
X-Google-Smtp-Source: AA6agR6VQghOT7mgljopZ7UoOiCJqL3A9+aHgoiOMcoOCLa1g0FsLknUdJd1iJM0lc0D33gmfs5nZw==
X-Received: by 2002:a0c:9d01:0:b0:474:4c67:8f96 with SMTP id m1-20020a0c9d01000000b004744c678f96mr5686609qvf.32.1659708150506;
        Fri, 05 Aug 2022 07:02:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006b57b63a8ddsm2974037qkn.122.2022.08.05.07.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:02:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oJxuG-004Tmc-Tj;
        Fri, 05 Aug 2022 11:02:28 -0300
Date:   Fri, 5 Aug 2022 11:02:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bo Liu <liubo03@inspur.com>
Cc:     bvanassche@acm.org, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/srp: Check dev_set_name() return value
Message-ID: <Yu0i9DzLg0kt5Sd9@ziepe.ca>
References: <20220805053434.3944-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805053434.3944-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 05, 2022 at 01:34:34AM -0400, Bo Liu wrote:
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Ah, while you are here can you fix this:

>  	if (device_register(&host->dev))
>  		goto free_host;
[..]
> free_host:
>         kfree(host);

That isn't allowed, you have to do put_device():

/**
 * device_register - register a device with the system.
 * @dev: pointer to the device structure
 *
 * This happens in two clean steps - initialize the device
 * and add it to the system. The two steps can be called
 * separately, but this is the easiest and most common.
 * I.e. you should only call the two helpers separately if
 * have a clearly defined need to use and refcount the device
 * before it is added to the hierarchy.
 *
 * For more information, see the kerneldoc for device_initialize()
 * and device_add().
 *
 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up the
 * reference initialized in this function instead.
 */
int device_register(struct device *dev)

Everyone get this wrong, it is why I think device_register is a
terrible interface. Write it as device_initialize()/device_add() as
seperate steps and never call kfree().

Jason
