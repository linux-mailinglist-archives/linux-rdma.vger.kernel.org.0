Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B64E2353
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 10:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiCUJ3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345278AbiCUJ3e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 05:29:34 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CBD1141
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 02:28:09 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id b19so19756459wrh.11
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 02:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=60W3VtKicpE+IqdqSUpAB/W/auIB9eHgJ1nnojMJZeM=;
        b=5ON107EPH2mWYKWwKaqeG2eUu8osW41CNII8kSKV4SgCd7RjzFhy/jbYuBy529Kx/g
         kge3gZAcFmwipCwYxwxTkZ0LKeqnmz0M+6eoodoSDamueECiGB3ySJrrBFdioMcj5Sxb
         VJZ6Lpn4fMddHh+uk75gkGk5VmkFvtH3WsndvAYWdzn7x7jm8EVLFNP7bk1+bVoMnCt1
         MRJZ65ETFaRuULKJ8jTtTyiqr7PkdekwL6NN4ETdKPLuYWDgz6JeiC52AQ5B1Wp2dTRK
         5OfwPqz0wHP+LU4SrX+km5CN9xv4JXnHqwQFNvLDT55/SABSDs7ArVa+5TUk7VXq7uer
         wV8g==
X-Gm-Message-State: AOAM530/tFOo1uiy9KyvVwb2RSz0AtG2zSS9h5MU7+kM1aY/Eh9NIFvW
        mODrxOs9MxIX8afh+y5EdE0=
X-Google-Smtp-Source: ABdhPJyJ3Nz1OjGr1wfDL+c73fxuMpPQ71qwRRPKYQc1U/BQskIQus8w0OsEi0Fm3YT/jdlRpLChOg==
X-Received: by 2002:adf:d1e5:0:b0:203:d609:38da with SMTP id g5-20020adfd1e5000000b00203d60938damr17252131wrd.675.1647854888318;
        Mon, 21 Mar 2022 02:28:08 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b00203e4c8bdf1sm11326774wrs.93.2022.03.21.02.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 02:28:07 -0700 (PDT)
Message-ID: <94b12c63-7deb-5c62-2c0d-e339fd5e7823@grimberg.me>
Date:   Mon, 21 Mar 2022 11:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
 <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
 <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
 <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
 <CAHj4cs_ff3TGnD2QJSzx3QJQKc1HkF=TJkh_MokqGK3n8NWyQQ@mail.gmail.com>
 <3d3f7b64-1c74-d41c-4c60-055e9fa79080@nvidia.com>
 <7e0abcac-791a-bd71-38c3-4a5490b7f209@grimberg.me>
 <d8283461-8759-39ac-6ef7-a6f5cc739634@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d8283461-8759-39ac-6ef7-a6f5cc739634@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> WDYT ? should we reconsider the "nvme connect --with_metadata" option ?
>>
>> Maybe you can make these lazily allocated?
> 
> You mean something like:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fd4720d37cc0..367ba0bb62ab 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1620,10 +1620,19 @@ int nvme_getgeo(struct block_device *bdev, 
> struct hd_geometry *geo)
>   }
> 
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
> -                               u32 max_integrity_segments)
> +static int nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns)
>   {
>          struct blk_integrity integrity = { };
> +       u16 ms = ns->ms;
> +       u8 pi_type = ns->pi_type;
> +       u32 max_integrity_segments = ns->ctrl->max_integrity_segments;
> +       int ret;
> +
> +       if (ns->ctrl->ops->init_integrity) {
> +               ret = ns->ctrl->ops->init_integrity(ns->ctrl);
> +               if (ret)
> +                       return ret;
> +       }
> 
>          switch (pi_type) {
>          case NVME_NS_DPS_PI_TYPE3:
> @@ -1644,11 +1653,13 @@ static void nvme_init_integrity(struct gendisk 
> *disk, u16 ms, u8 pi_type,
>          integrity.tuple_size = ms;
>          blk_integrity_register(disk, &integrity);
>          blk_queue_max_integrity_segments(disk->queue, 
> max_integrity_segments);
> +
> +       return 0;
>   }
>   #else
> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
> -                               u32 max_integrity_segments)
> +static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns)
>   {
> +       return 0;
>   }
>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
> 
> @@ -1853,8 +1864,8 @@ static void nvme_update_disk_info(struct gendisk 
> *disk,
>          if (ns->ms) {
>                  if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>                      (ns->features & NVME_NS_METADATA_SUPPORTED))
> -                       nvme_init_integrity(disk, ns->ms, ns->pi_type,
> - ns->ctrl->max_integrity_segments);
> +                       if (nvme_init_integrity(disk, ns))
> +                               capacity = 0;
>                  else if (!nvme_ns_has_pi(ns))
>                          capacity = 0;
>          }
> @@ -4395,7 +4406,7 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> 
> 
> and create the resources for the first namespace we find as PI formatted ?
> 
> 

I was thinking more along the lines of allocating it as soon as an I/O
comes with pi... Is there something internal to the driver that can
be done in parallel to expedite the allocation of these extra resources?
