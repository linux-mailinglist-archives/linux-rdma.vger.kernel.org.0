Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE6BE518
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfIYSuc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 14:50:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45657 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfIYSuc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 14:50:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so8106465wrm.12
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jGWWEDcIEH+mcbEz6KfmksJKZdf0560UqpBnTRqgW7w=;
        b=p2DCHzx0HPMOIPd1EnQMShfjDwFd0pQcJByq5mzIJ9vvejcAM+dGEFwP3gtiF/Cwo3
         1NLaKGCnHus27EXwC5LpiFSUbyIAmPWMyFHN4hEBhw01jHTe3AB/ZPSooKehT4M6ZSuA
         l2XZ9/8KO+dIf4Hxv3dDZYGStNuU5CYkMEXVFe2e3SblrwfBGAxcFyFUaI7zlnP6IX9G
         8Sfxka26+eJ2n9Cug2mKOyRYPg14rxgCEsQkIr97ULNkVWQ9JZcrBIOTpmM3fMeyBYfW
         9AcBIq3g1C8OMihlynkKg52qZOZcZ+2P4trqkjmJSg6QI+Y2fLWOSvvN2kMJNQOjbc1h
         1l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jGWWEDcIEH+mcbEz6KfmksJKZdf0560UqpBnTRqgW7w=;
        b=q6yRt/nfqhHT4Wfr9CMEmeb9/1sbqskn9vUi6fwPHhVuCcnPh/VLEPDF5KnS+Fhrf1
         pXrzjPQtXpWEySKyHLxaZQU7Sf0J6o3S7jIWAiqjuJU5jnKyw1BTowEdCbW0N2IPc9hr
         7Jwo2ck7KpxLYNhm/Z6xkT/rr8ka5rofKORIfdCmwVQhAaara4ivTolavxX9o12tNJAG
         xkHvm+3sa4sIjY6Z/x2bentPse7kCOfGpi20kMTpl1xWoLtE4FQghIUU90XjhopkpS3m
         DMEkymRItP7bN5C6ooM1v3MjWfc6HF1cdVJNgito9P+6sNs4dA2Ib2wYcee3AZ/fRsTi
         Txdg==
X-Gm-Message-State: APjAAAWJjnCgc0uY2HE9kZD2EqZsk7QM29PmaSPD2wlnBWEEpgry/MVK
        4oZUKnYfxghcMMmFhCOLgZg5btX3
X-Google-Smtp-Source: APXvYqwJ8Jakpx5JGcFoJwRdAcehOZSBvx3nTa1vtqEcAdROKiFOUvd5Mfb2DcLyEbzijF3szbGRjw==
X-Received: by 2002:adf:f343:: with SMTP id e3mr10665754wrp.268.1569437430328;
        Wed, 25 Sep 2019 11:50:30 -0700 (PDT)
Received: from [192.168.1.108] (bzq-79-181-41-92.red.bezeqint.net. [79.181.41.92])
        by smtp.gmail.com with ESMTPSA id y5sm5610361wma.14.2019.09.25.11.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 11:50:29 -0700 (PDT)
Subject: Re: [PATCH for-5.4] RDMA/i40iw: Associate ibdev to netdev before IB
 device registration
To:     Shiraz Saleem <shiraz.saleem@intel.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20190925164524.856-1-shiraz.saleem@intel.com>
From:   Kamal Heib <kamalheib1@gmail.com>
Message-ID: <327441aa-3991-b55b-aa71-7deff4ad6ed2@gmail.com>
Date:   Wed, 25 Sep 2019 21:50:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925164524.856-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/25/19 7:45 PM, Shiraz Saleem wrote:
> From: "Shiraz, Saleem" <shiraz.saleem@intel.com>
> 
> i40iw IB device registration fails with ENODEV.
> 
> ib_register_device
>  setup_device/setup_port_data
>   i40iw_port_immutable
>    ib_query_port
>      iw_query_port
>       ib_device_get_netdev(ENODEV)
> 
> ib_device_get_netdev() does not have a netdev associated
> with the ibdev and thus fails.
> Use ib_device_set_netdev() to associate netdev to ibdev
> in i40iw before IB device registration.
> 
> Fixes: 4929116bdf72 ("RDMA/core: Add common iWARP query port")
> Signed-off-by: Shiraz, Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index 8056930..cd9ee166 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -2773,6 +2773,10 @@ int i40iw_register_rdma_device(struct i40iw_device *iwdev)
>  		return -ENOMEM;
>  	iwibdev = iwdev->iwibdev;
>  	rdma_set_device_sysfs_group(&iwibdev->ibdev, &i40iw_attr_group);
> +	ret = ib_device_set_netdev(&iwibdev->ibdev, iwdev->netdev, 1);
> +	if (ret)
> +		goto error;
> +
>  	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d");
>  	if (ret)
>  		goto error;
> 

Thanks!

Reviewed-by: Kamal Heib <kamalheib1@gmail.com>
