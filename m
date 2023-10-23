Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC397D3EFE
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 20:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjJWSTY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjJWSTX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 14:19:23 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6199
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:19:20 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5845213c583so1035471eaf.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698085160; x=1698689960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yhnxnJ0EZnskjvE/QTX7vSmqovRzfbb8ia1T/C3p/w=;
        b=NyvvKiLGkDipoUL+ktH5jSIOJQ7BjzCz/p4tcrLcYT25HeQx2iZzxeo+EQbcRNJWZv
         1F5fqWQ507lJTujJPuPYnj2vEX/UsbaSYldUCBKL2+hQypZG6TMGxLtaMmBSTjTRGUQB
         zRMDjZkMtVck9txkdna0lhf/Ve/EK1PFB6qZQEsZHdEMGujYXNju0BgEBw0CIW/xyZcr
         KneBTqOvNWPsUW6NuxHMS10GZopv2hyKQMvRN1pc2rblJWY4NMf0K4zyCkLV4wtxSuxb
         3eL4Iok9kMl917iJ+aMFbjerKOwrf112D5zLT2/Q5q/dxweZYq4WnKZnoTGMNREXDnFA
         8cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085160; x=1698689960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yhnxnJ0EZnskjvE/QTX7vSmqovRzfbb8ia1T/C3p/w=;
        b=WuMGHs+LYox++R8GQ6ai2YOUXBg1EstYHpJJyU71fUge4TAAedMyVnb1aHX/yPuo2H
         TIz784ZZt65WX4ECdG8Cn3B+azrtfjJ59nu4/N1ztEZhL/Q4/hnfX5n8yJYyFlX87FDo
         g55MUPl6hQ0SMDWr2pcCMcGVnB6UPfGDYA9llz2kHeVYte1dsBvAgrkWJoe9+vsdhLjY
         kOGXOEv0ZWgf6Qp4yREcAJWIqih+XOMNuQF+Erh2FpiUZjfs0ctzQ0sG8Xgv2gNpdTHW
         akYstei7L3Fv98LfXKoYX0kOTHBvJ3WYitHp/97aumwykCjQ/AZjr3nb01LVW/IP+FAF
         OYSQ==
X-Gm-Message-State: AOJu0YwL6rKIgIsIxs8KcillCvyXss15gv2WK2ufaqjaq8AtneM5AsPQ
        ia6xnq2NoZB4Fi076tgBTS9rOLrNQyBn0I5KrnU=
X-Google-Smtp-Source: AGHT+IGdDXmlG8NU9SWCpEcJVTGZGo8oiVXha6x2olGHUS9he9wLHOzuwKgBBQJwmlQ8KyiRplOMwA==
X-Received: by 2002:a4a:e782:0:b0:56e:466c:7393 with SMTP id x2-20020a4ae782000000b0056e466c7393mr9638941oov.5.1698085159795;
        Mon, 23 Oct 2023 11:19:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id y22-20020a4ade16000000b0057b38a94f38sm1591165oot.12.2023.10.23.11.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:19:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1quzWI-003jPw-9O;
        Mon, 23 Oct 2023 15:19:18 -0300
Date:   Mon, 23 Oct 2023 15:19:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     sharmaajay@linuxonhyperv.com
Cc:     Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v7 2/5] RDMA/mana_ib: Register Mana IB  device with
 Management SW
Message-ID: <20231023181918.GJ691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-3-git-send-email-sharmaajay@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697494322-26814-3-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 16, 2023 at 03:11:59PM -0700, sharmaajay@linuxonhyperv.com wrote:

> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index 083f27246ba8..ea4c8c8fc10d 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -78,22 +78,34 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  	mib_dev->ib_dev.num_comp_vectors = 1;
>  	mib_dev->ib_dev.dev.parent = mdev->gdma_context->dev;
>  
> -	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
> -				 mdev->gdma_context->dev);
> +	ret = mana_gd_register_device(&mib_dev->gc->mana_ib);
>  	if (ret) {
> -		ib_dealloc_device(&mib_dev->ib_dev);
> -		return ret;
> +		ibdev_err(&mib_dev->ib_dev, "Failed to register device, ret %d",
> +			  ret);
> +		goto free_ib_device;
>  	}
>  
> +	ret = ib_register_device(&mib_dev->ib_dev, "mana_%d",
> +				 mdev->gdma_context->dev);
> +	if (ret)
> +		goto deregister_device;
> +
>  	dev_set_drvdata(&adev->dev, mib_dev);
>  
>  	return 0;
> +
> +deregister_device:
> +	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
> +free_ib_device:
> +	ib_dealloc_device(&mib_dev->ib_dev);
> +	return ret;
>  }
>  
>  static void mana_ib_remove(struct auxiliary_device *adev)
>  {
>  	struct mana_ib_dev *mib_dev = dev_get_drvdata(&adev->dev);
>  
> +	mana_gd_deregister_device(&mib_dev->gc->mana_ib);
>  	ib_unregister_device(&mib_dev->ib_dev);
>  	ib_dealloc_device(&mib_dev->ib_dev);
>  }

That's definitely in the wrong order

Are you shure these things should just be part of
ops->enable_driver/dealloc_driver?

> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 189e774cdab6..2c4e3c496644 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -8,7 +8,7 @@
>  void mana_ib_uncfg_vport(struct mana_ib_dev *mib_dev, struct mana_ib_pd *pd,
>  			 u32 port)
>  {
> -	struct gdma_dev *gd = mib_dev->gdma_dev;
> +	struct gdma_dev *gd = &mib_dev->gc->mana;

What is this stuff doing in this patch? Make another patch if you want
to remove gdma_dev

Jason
