Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6E54FBAF
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jun 2022 18:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382587AbiFQQzj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jun 2022 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382738AbiFQQzi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jun 2022 12:55:38 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EAA15801;
        Fri, 17 Jun 2022 09:55:37 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id t2so4360695pld.4;
        Fri, 17 Jun 2022 09:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NQvpbNnhd1Hb0j8v30FPXqT+MFqFElEXEqSS6ck3brY=;
        b=aCyqpQX7dhesop7GetkwFHh8dcccktPV24/VIY3oi+Tzas62t+A1YHIjj0QufjxfDz
         QBQYzKzZrc3NSnlM0d7OKLXOCj0C7pcm4gc+IJ7UldmYe/Zi5x8yq1vKRfIvj4gGP28L
         XCYVrFA8Cn8i3Ydrk71gisuIMbLRM5SaaWbHdMq044aUbaYF8TV2kzUp+qtZtlF4BoHm
         Tqn2DJvJX/XvIcePhAZBdgT4/bfIOuhQpT12JW1Z4amhh5Ax3gCMdv3UHxy64fn36IYg
         RmI7ik9MM7z+KtFlPPfCphUGmXT6cCxZuEDk7tv1P9GpLtFUYvp/aaw3T3k5QUvbJDLV
         q2aQ==
X-Gm-Message-State: AJIora+ix3kQrVLYkT4FEQX0u8Iq4xujKRk1b2yGA0mReu7QRyBAt+wb
        6OdOIq2e89u/pGzG9Vr67/w=
X-Google-Smtp-Source: AGRyM1uVwwnPkhP6RYNzI5TunYKnnEx27Gq+Jz+noCToEfYq5XweGJSbPYfjWq1VJ+qXOBF2dFKLpw==
X-Received: by 2002:a17:90a:784f:b0:1ea:fa7d:7013 with SMTP id y15-20020a17090a784f00b001eafa7d7013mr7943869pjl.222.1655484936639;
        Fri, 17 Jun 2022 09:55:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b001690b65b2absm3014083pln.175.2022.06.17.09.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:55:35 -0700 (PDT)
Message-ID: <c6a0eb8d-ad51-01b1-bc17-758acc37f216@acm.org>
Date:   Fri, 17 Jun 2022 09:55:34 -0700
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
 <017cae1e-b45f-04fd-d34c-22ae736b28e5@acm.org>
 <a18fa379-5a9b-ff45-3be4-b253efd96a50@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a18fa379-5a9b-ff45-3be4-b253efd96a50@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/22 09:42, John Garry wrote:
> On 17/06/2022 17:33, Bart Van Assche wrote:
>> On 6/17/22 03:55, John Garry wrote:
>>> @@ -276,7 +275,7 @@ static bool bt_iter(struct sbitmap *bitmap, 
>>> unsigned int bitnr, void *data)
>>>       else
>>>           tags = hctx->tags;
>>> -    if (!reserved)
>>> +    if (!iter_data->reserved)
>>>           bitnr += tags->nr_reserved_tags;
>>>       /*
>>>        * We can hit rq == NULL here, because the tagging functions
>>
>> Is the above change really necessary?
> 
> It's not totally necessary. Since local variable 'reserved' would now 
> only be used once I thought it was better to get rid of it.
> 
> I can keep it if you really think that is better.

I'd prefer that these changes are either left out or that these are 
moved into a separate patch. I think that will make this patch series 
easier to review.

Thanks,

Bart.
