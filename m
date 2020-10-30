Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8B2A0CBB
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 18:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgJ3Rp4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 13:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgJ3Rpz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 13:45:55 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE55C0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 10:45:55 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id f97so6285094otb.7
        for <linux-rdma@vger.kernel.org>; Fri, 30 Oct 2020 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mdx+3I688rv0S3407gWwp35R3hJHBV32h8LKZm2EvE=;
        b=ZVJX8Zb3mYfNGEAUSXrf9H8XwHZRpgtjt7vjJZ8x+6C9o2T9fEioo7UfVQb8l7px5H
         XUXufMJMLVG/qS3nXEahERL0y7fsp5NOu/T82aqG12dtFdM1Es8D4K9FzOnOh0Y5ynDP
         emWzAdmtp7uybLkkMRrnKKY78qVzVvV1zxypcsaA5DuPsHP+b/kAkvCoev83TJy9Ojfe
         PWO6bUCQlMkKFfcWRLL3G+MWRmUDkh5b0X8YeFyuTYVtyC8RxwHss2Hc4kvXRhrT2sCF
         YZXety1OY21ryqtpBeZvD8Sz+XQfh3SCSwxDdNwQIVKoKnd/rOV/2F+ohPV6ypcNz0Bm
         XQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mdx+3I688rv0S3407gWwp35R3hJHBV32h8LKZm2EvE=;
        b=qICGAQXVvApfdG3/FH1ZYjzdCH4XnHf0900vaKvSlMzJCU711oYwe7Fk3cVYLhLKw8
         WfkW4xAH6udZPaI+rA86ulrY8+zb4BG3HlpLTMRtWf37EIn0wI1rPRr2gZxKBZFiVUAJ
         wMulfWbXjYYl5Y8c0QMvmFFRI5k7Euy1YL7+tW52koB+4OYnAqbXyGlq80qmONWtdgD2
         x0gTauHhbuRmVyFOPdLuBnxo3PonNm1kqpeM1sZCjbeik1L7OyJZjpCQL7CYyMgFGzvE
         8hFhiGWGHd9mUTdZYKqrpA9TDaG1SVefBM+Su7dhz59l3iCBJCy6EOWqZeAo3ajBxR12
         FQCQ==
X-Gm-Message-State: AOAM5313/ezSOEtLjHkivce/bEctVKZG3SLAkt8xw1GYAiYcQdV1g/Y+
        Suhw+bypTpC8VbhV/LK4zTtwyYdRiEM=
X-Google-Smtp-Source: ABdhPJzPhA4J1ZfleoTJqNaUxTab++heTHImWXBDYzMZurGf0drLglnhpbKwmryJOWk/egGuyo0QxA==
X-Received: by 2002:a9d:72c8:: with SMTP id d8mr2660746otk.370.1604079955113;
        Fri, 30 Oct 2020 10:45:55 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:9ab5:99a7:d140:ecf9? (2603-8081-140c-1a00-9ab5-99a7-d140-ecf9.res6.spectrum.com. [2603:8081:140c:1a00:9ab5:99a7:d140:ecf9])
        by smtp.gmail.com with ESMTPSA id z8sm1438302otm.45.2020.10.30.10.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 10:45:54 -0700 (PDT)
Subject: Re: [PATCH for-next v2] RDMA/rxe: fix regression caused by recent
 patch
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
References: <20201030171106.4191-1-rpearson@hpe.com>
 <20201030173615.GG2620339@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <73f63f73-d422-db8c-db9f-7780b1f3c3b1@gmail.com>
Date:   Fri, 30 Oct 2020 12:45:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201030173615.GG2620339@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/30/20 12:36 PM, Jason Gunthorpe wrote:
> On Fri, Oct 30, 2020 at 12:11:07PM -0500, Bob Pearson wrote:
>> The commit referenced below performs additional checking on
>> devices used for DMA. Specifically it checks that
>>
>> device->dma_mask != NULL
>>
>> Rdma_rxe uses this device when pinning MR memory but did not
>> set the value of dma_mask. In fact rdma_rxe does not perform
>> any DMA operations so the value is never used but is checked.
>>
>> This patch gives dma_mask a valid value extracted from the device
>> backing the ndev used by rxe.
>>
>> Without this patch rdma_rxe does not function.
>>
>> N.B. This patch needs to be applied before the recent fix to add back
>> IB_USER_VERBS_CMD_POST_SEND to uverbs_cmd_mask.
>>
>> Dennis Dallesandro reported that Parav's similar patch did not apply
>> cleanly to rxe. This one does to for-next head of tree as of yesterday.
>>
>> Fixes: f959dcd6ddfd2 ("dma-direct: Fix potential NULL pointer dereference")
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>>  drivers/infiniband/sw/rxe/rxe_verbs.c | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index 7652d53af2c1..c857e83323ed 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -1128,19 +1128,32 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>>  	int err;
>>  	struct ib_device *dev = &rxe->ib_dev;
>>  	struct crypto_shash *tfm;
>> +	u64 dma_mask;
>>  
>>  	strlcpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
>>  
>>  	dev->node_type = RDMA_NODE_IB_CA;
>>  	dev->phys_port_cnt = 1;
>>  	dev->num_comp_vectors = num_possible_cpus();
>> -	dev->dev.parent = rxe_dma_device(rxe);
>>  	dev->local_dma_lkey = 0;
>>  	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
>>  			    rxe->ndev->dev_addr);
>>  	dev->dev.dma_parms = &rxe->dma_parms;
>>  	dma_set_max_seg_size(&dev->dev, UINT_MAX);
>> -	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
>> +
>> +	/* rdma_rxe never does real DMA but does rely on
>> +	 * pinning user memory in MRs to avoid page faults
>> +	 * in responder and completer tasklets. This code
>> +	 * supplies a valid dma_mask from the underlying
>> +	 * network device. It is never used but is checked.
>> +	 */
>> +	dev->dev.parent = rxe_dma_device(rxe);
> 
> Oh! This is another bug, the parent of an ib_device should never be
> set to a net_device!! This is probably why we get all those mysterious
> syzkaller faults :| Just leave it NULL
> 
>> +	dma_mask = *(dev->dev.parent->dma_mask);
>> +	err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);
> 
> Why not use Parav's logic?
> 
> Jason
> 

It's not the network device. It is the parent of the network device.
On 64 bit machines it gives 0xffffffffffffffff as dma_mask.

struct device *rxe_dma_device(struct rxe_dev *rxe)
{
        struct net_device *ndev;

        ndev = rxe->ndev;

        if (is_vlan_dev(ndev))
                ndev = vlan_dev_real_dev(ndev);

        return ndev->dev.parent;
}

His should work too. They will behave the same at the end of the day.
I don't really know what the rxe_dma_device() code was trying to do in the
first place so I didn't change it. But it was a handy place to get a dma_mask
that should work on any architecture. If there is no reason to set dev.parent
I can get rid of rxe_dma_device.

Bob
