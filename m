Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035221DF375
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 02:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgEWAYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 20:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbgEWAYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 20:24:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD27C05BD43
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 17:24:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w3so6999276qkb.6
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TcHQrfiShTRKZTaz7JNv49IPyapAGjUyv9OczpKneU8=;
        b=HTaAfMwL3HfzwjrfnivW05szFFiLoxdOYctNTPPGkqqKDjI+uPT7ajJRFl4YQS7Erb
         fURZA//xhe2Pi5OT//RybnnHfyAB6Iq1gzXZ4V8uWtOVfp2ACWdGXFbqedF38gjEWUzp
         pVp0RoNGyrOB1aqLtqmjD+lgW20PRP9ptJUu6NO2SR654lYPAF0f9dBQ43UQdS+ecPpU
         +mEUgq4T/ZAIjV/HdbNGIqpGCXwgenNHNC0pe1bxolnA2CiMm2XTOifHBxYM7jF8yXSa
         AkZ1ovKeeYt7cg1dy04QA5tFPNd88/DzKv9VqTr2Y00zlDW4jJ2YYTwP/jlp2o1SpTEs
         81sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TcHQrfiShTRKZTaz7JNv49IPyapAGjUyv9OczpKneU8=;
        b=HzqeRv981Of0nDhkPzvEspGz286zhDdLPhoaMLRkEDB1Ed4C56qkg0SpULaCRx4mMe
         tDXRpp7zpVNmenh5eafGv6XQywakZYIhZz5HQg7Sd5MRvN/tgcuzWuWI0v50Wqgm7y+u
         0OcDdtvE6UHUiA0MPVa8Wj/LjIXGDdwV0BLERs9dMJf+OLnTz+DNIQB17YyP43sFDjr/
         EKkMffLXBx5R3GRiVAOxuYdhqduhkUhdRmaXG4pV4UQO/6v02ZTIueByIlvhjy7StyGE
         FEa3WdlS1Pioal6x1DVDqff6xhSPKt0P/h5SW4O4LeFXMgL4gKzoJ2Hx6Fm7hquLBfZU
         Gzpg==
X-Gm-Message-State: AOAM531gUtm7EsGgI2d3xuzmy9HJoyIAmLn4ZEJtoaIQfVLiw42NI0ff
        VvCYBBxOQN7NViUB9pswRL8/FQ==
X-Google-Smtp-Source: ABdhPJx01n6WIHC4kBfxx0mE5mC80vwUjCPteRjI+bQumrmjc7Fyq/980buQSlfwbNIRYwedhSycfw==
X-Received: by 2002:a05:620a:142:: with SMTP id e2mr17738749qkn.331.1590193483038;
        Fri, 22 May 2020 17:24:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s55sm9844582qtb.92.2020.05.22.17.24.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 17:24:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jcHxx-0002Ot-Un; Fri, 22 May 2020 21:24:41 -0300
Date:   Fri, 22 May 2020 21:24:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, rdunlap@infradead.org, axboe@kernel.dk,
        bvanassche@acm.org, leon@kernel.org, jinpu.wang@cloud.ionos.com,
        guoqing.jiang@cloud.ionos.com
Subject: Re: [PATCH] rnbd: fix compilation error when CONFIG_MODULES is
 disabled
Message-ID: <20200523002441.GA9180@ziepe.ca>
References: <ca0729a1-2e4d-670d-2519-a175b3035b28@infradead.org>
 <20200521185909.457245-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521185909.457245-1-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 21, 2020 at 08:59:09PM +0200, Danil Kipnis wrote:
> module_is_live function is only defined when CONFIG_MODULES is enabled.
> Use try_module_get instead to check whether the module is being removed.
> 
> When module unload and manuall unmapping is happening in parallel, we can
> try removing the symlink twice: rnbd_client_exit vs. rnbd_clt_unmap_dev_store.
> 
> This is probably not the best way to deal with this race in general, but for
> now this fixes the compilation issue when CONFIG_MODULES is disabled and has
> no functional impact. Regression tests passed.
> 
> Fixes: 1eb54f8f5dd8 ("block/rnbd: client: sysfs interface functions")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> v1->v2 Fix format of the "Fixes:" line
>        Add Acked-by Randy Runlap <rdunlap@infradead.org>
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
> index a4508fcc7ffe..73d7cb40abb3 100644
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -428,12 +428,14 @@ static struct attribute *rnbd_dev_attrs[] = {
>  void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
>  {
>  	/*
> -	 * The module_is_live() check is crucial and helps to avoid annoying
> -	 * sysfs warning raised in sysfs_remove_link(), when the whole sysfs
> -	 * path was just removed, see rnbd_close_sessions().
> +	 * The module unload rnbd_client_exit path is racing with unmapping of the
> +	 * last single device from the sysfs manually i.e. rnbd_clt_unmap_dev_store()
> +	 * leading to a sysfs warning because of sysfs link already was removed already.
>  	 */
> -	if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
> +	if (strlen(dev->blk_symlink_name) && try_module_get(THIS_MODULE)) {
>  		sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
> +		module_put(THIS_MODULE);
> +	}
>  }

This is a really gross thing to do, please fix it properly in future

Applied to for-next

Jason
