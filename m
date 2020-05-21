Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB66B1DD625
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgEUSjz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUSjz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 14:39:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75606C061A0E;
        Thu, 21 May 2020 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=En08B0VmVu+Rrpznv1PvjxQP21WWZNWy251YyWEC4UQ=; b=IWFKsoJvv9I8S0HThzn5lAoAed
        hc/JvIYv7b7AY3Xb0j87M9MQSmks+gmMUyeFdv5bbc2kRH6sxq3b7WqzHHJVoPiKn9D3h9815ZQHH
        npTQ3OwfNK70crTrvFtcsZsVyHevTFCfkq+ipN3SxlmnkC+awYcX4xrRPaEj2r0u6TQ8IYaJulFIS
        TZXYqpaPgaD85Vpsxe2u0T4QsalbzEsGLi67aVsG5Xa4Vm1Zh2efb6J2GeCnR+bonNkBUBQsF74uv
        FdizJqxbq0tfjcg9kV7dC+axTe337TINH6ijGR5TAF6kXtSxVgGtCtXqLhEeaFCNIL6PLTq5vKZ07
        HmJCIyOw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbq6g-0002Um-Pe; Thu, 21 May 2020 18:39:50 +0000
Subject: Re: [PATCH] rnbd: fix compilation error when CONFIG_MODULES is
 disabled
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     axboe@kernel.dk, bvanassche@acm.org, leon@kernel.org,
        jinpu.wang@cloud.ionos.com, guoqing.jiang@cloud.ionos.com
References: <86962843-e786-4a3f-0b85-1e06fbdbd76a@infradead.org>
 <20200521175001.445208-1-danil.kipnis@cloud.ionos.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ca0729a1-2e4d-670d-2519-a175b3035b28@infradead.org>
Date:   Thu, 21 May 2020 11:39:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521175001.445208-1-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/21/20 10:50 AM, Danil Kipnis wrote:
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
> Fixes: 1eb54f8f5dd8 block/rnbd: client: sysfs interface functions

The Fixes: line has a specific expected format. It should be like this:

Fixes: 1eb54f8f5dd8 ("block/rnbd: client: sysfs interface functions")

> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
> index a4508fcc7ffe..73d7cb40abb3 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
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
>  
>  static struct kobj_type rnbd_dev_ktype = {
> 
> base-commit: f11e0ec55f0c80ff47693af2150bad5db0e20387
> 


-- 
~Randy
