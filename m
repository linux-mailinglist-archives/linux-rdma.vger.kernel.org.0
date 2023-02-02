Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102CD687730
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjBBIU6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 03:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjBBIU5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 03:20:57 -0500
X-Greylist: delayed 23979 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 00:20:55 PST
Received: from out-242.mta1.migadu.com (out-242.mta1.migadu.com [IPv6:2001:41d0:203:375::f2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842F84B74
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 00:20:55 -0800 (PST)
Message-ID: <3e3fd166-6a71-cec8-7d85-6d6b2515d7f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675326053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUivNFXjv8moUaUjEogbM+eU3r3jETmBMqQBNTfTjgA=;
        b=iaPbxOxJv1my76gfF2mKmO3Aa7Fbl6hRurWZVKqWhtaa2av/E9JIITQE1850MUBjirL3JX
        IlDRJBnjMVA53TvYoeUJiYGAP2Tl2iWGg3N38IFeJtYxl/letInvEZcPMXvYeI1a6h6iV1
        rqXog+PgBIdxPG82FvTgdZJE9OA0sg8=
Date:   Thu, 2 Feb 2023 16:20:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1675261833-2-1-git-send-email-lizhijian@fujitsu.com>
 <6bcba397-f4f1-26df-f8cd-1dbebf111932@linux.dev>
 <d1751eec-3d48-a8c9-1e3b-3263a4a043a3@fujitsu.com>
 <b82cfec2-b679-7c5a-06fe-a540fddda0f3@linux.dev>
 <fe563b74-efff-2799-ceff-af7af7bf9171@fujitsu.com>
 <42e231f5-63bb-e145-ce80-d9651a9afee1@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <42e231f5-63bb-e145-ce80-d9651a9afee1@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/2/23 15:59, lizhijian@fujitsu.com wrote:
> 6af4609c18b3 seems make senses, so i don't want to revert it entirely if possible.
>
> I have a update for this path like below, i am no longer get problem with this new update.
>
> index c76ba29da1e2..5adba0f754b6 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -312,9 +312,8 @@ void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
>    
>           if (srv_path->kobj.state_in_sysfs) {
>                   sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
> -               kobject_del(&srv_path->kobj);
>                   kobject_put(&srv_path->kobj);
> +               rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
>           }
>    
> -       rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
>    }

Hmm, I overlooked the kobject hierarchy 😅.

        err = kobject_init_and_add(&srv_path->kobj, &ktype, 
srv->kobj_paths,
"%s", str);

Pls send a formal patch, and feel free to add my Acked-by.

Thanks,
Guoqing


