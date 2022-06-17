Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D0A54FB40
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jun 2022 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383328AbiFQQdQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jun 2022 12:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383322AbiFQQdP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jun 2022 12:33:15 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925333A20;
        Fri, 17 Jun 2022 09:33:15 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id i15so4322030plr.1;
        Fri, 17 Jun 2022 09:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZFZOF4kIZf5haKivlSJCFlw6yEpj+kTMN6wkZ1f2sSk=;
        b=UHKJifPL4xtbAPNhZJFcnltd6jefCSYR2N/M5Y1xYH2yEqSp0ILwoWgRqfiPbUeVJR
         CUmoeAkFkffjR55X2hEAzyJhGKUkYG4XXrbdMG0q6UT0UrviPRpKCq1VM4SPKhLEtmId
         doxy2Yv0geHiF9h3DgciEi+TAfbCYv0j4pvzEweA0rF+PXN7CrudIY/hCtG5sO5OfrDP
         +vtWrZ/oDJ7GynpOXShFl2aDSX3qfBA1p4468SO9R+u923F6QQfl/gPoRy5Ai1VYxslw
         lrhNCLdqClGwjGU8x9zuHdX/LzEPgrxXtUk6egFN40C9S7kQv0pSIKQeifFR+q5Nl5dH
         BDjw==
X-Gm-Message-State: AJIora8n/J8+pw/Re3/RiZZuZOMfBMUC/2fCV/aMTnlsT7gTNfFtDYT7
        3GXoEIahyZ7muafrvugIydE=
X-Google-Smtp-Source: AGRyM1tFt6HG3OqcSvJKpLgUFiFTa/8qOGRuw+HZNz8Qnbyh9yDTQ+C2yWV2UI5DfkTd9FHmrT3DIw==
X-Received: by 2002:a17:902:7886:b0:167:5c8c:4d3e with SMTP id q6-20020a170902788600b001675c8c4d3emr10521665pll.74.1655483594617;
        Fri, 17 Jun 2022 09:33:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b00163d4c3ffabsm3774192plr.304.2022.06.17.09.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:33:13 -0700 (PDT)
Message-ID: <017cae1e-b45f-04fd-d34c-22ae736b28e5@acm.org>
Date:   Fri, 17 Jun 2022 09:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5/5] blk-mq: Drop 'reserved' member of busy_tag_iter_fn
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-6-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655463320-241202-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/22 03:55, John Garry wrote:
> We no longer use the 'reserved' member in for any iter function so it
                                          ^^^^^^
One of these two words probably should be removed.

> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 2dcd738c6952..b8cc8b41553f 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -266,7 +266,6 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
>   	struct request_queue *q = iter_data->q;
>   	struct blk_mq_tag_set *set = q->tag_set;
> -	bool reserved = iter_data->reserved;
>   	struct blk_mq_tags *tags;
>   	struct request *rq;
>   	bool ret = true;
> @@ -276,7 +275,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	else
>   		tags = hctx->tags;
>   
> -	if (!reserved)
> +	if (!iter_data->reserved)
>   		bitnr += tags->nr_reserved_tags;
>   	/*
>   	 * We can hit rq == NULL here, because the tagging functions

Is the above change really necessary?

> @@ -337,12 +336,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   {
>   	struct bt_tags_iter_data *iter_data = data;
>   	struct blk_mq_tags *tags = iter_data->tags;
> -	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
>   	struct request *rq;
>   	bool ret = true;
>   	bool iter_static_rqs = !!(iter_data->flags & BT_TAG_ITER_STATIC_RQS);
>   
> -	if (!reserved)
> +	if (!(iter_data->flags & BT_TAG_ITER_RESERVED))
>   		bitnr += tags->nr_reserved_tags;
>   
>   	/*

Same question here: is the above change really necessary?

Thanks,

Bart.
