Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32BBA77FF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 03:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfIDBIA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 21:08:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46260 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfIDBIA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 21:08:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so18017003wrt.13
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2019 18:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLULUSfeIcuoeiC0U2u87FDXUWow9oS80auyX3MF/YM=;
        b=PDghpylR8wmehJUeMBG18pk2T5gFWavdzoWBwJbuQawHgGvN/RdiKFZceZMiNAbUGP
         dpvmMC5M4bZrTDgaQ7TttJgo7QJakvLpdeGjkPEVMa+n1j3FvJiyDMy+32qf58kkY3AK
         ERzuElNdNtrv4nXMmBWs1QzVMD+RS6i9BrSupgz6MzesAOLIBtAW9H6OuBqcXJm0MIZI
         Qgg6EzuzYWckcS54UAkXLlyt2Fcg8utOJQG0/ot/bzl/2p9mKU9+G2AvOAvu1gEya1CP
         V2KcmcJCKo4SHbFIpVr0h7HPLyj2Zn0cVZrhp+zf42ScO43VoME6aPW4sLS8Q7aqFwWs
         tNJA==
X-Gm-Message-State: APjAAAUu9QXOsgEwDD12fWcVYN3Wjfty+xafKRoSJ32o5kFw0izsVVi5
        jTr5xMe+lrT2CcVbEJ0XOv4=
X-Google-Smtp-Source: APXvYqwMYDCejJu22Uog3ZbC1TzPd4dBNOpcKX6pf/L7dELtFjQxXNWjpV2lw7fJ3xS+t0fXH41YmQ==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr3882557wrv.206.1567559277616;
        Tue, 03 Sep 2019 18:07:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id c6sm31677455wrb.60.2019.09.03.18.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 18:07:56 -0700 (PDT)
Subject: Re: [PATCH] iwcm: don't hold the irq disabled lock on iw_rem_ref
To:     Mark Bloch <markb@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20190903192223.17342-1-sagi@grimberg.me>
 <3859b00b-9963-32c5-b6ed-8433fc4ec409@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <64fab27e-226f-e934-622a-13bf40356d81@grimberg.me>
Date:   Tue, 3 Sep 2019 18:07:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3859b00b-9963-32c5-b6ed-8433fc4ec409@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> This may be the final put on a qp and result in freeing
>> resourcesand should not be done with interrupts disabled.
>>
>> Produce the following warning:
>> --
>> [  317.026048] WARNING: CPU: 1 PID: 443 at kernel/smp.c:425 smp_call_function_many+0xa0/0x260
>> [  317.026131] Call Trace:
>> [  317.026159]  ? load_new_mm_cr3+0xe0/0xe0
>> [  317.026161]  on_each_cpu+0x28/0x50
>> [  317.026183]  __purge_vmap_area_lazy+0x72/0x150
>> [  317.026200]  free_vmap_area_noflush+0x7a/0x90
>> [  317.026202]  remove_vm_area+0x6f/0x80
>> [  317.026203]  __vunmap+0x71/0x210
>> [  317.026211]  siw_free_qp+0x8d/0x130 [siw]
>> [  317.026217]  destroy_cm_id+0xc3/0x200 [iw_cm]
>> [  317.026222]  rdma_destroy_id+0x224/0x2b0 [rdma_cm]
>> [  317.026226]  nvme_rdma_reset_ctrl_work+0x2c/0x70 [nvme_rdma]
>> [  317.026235]  process_one_work+0x1f4/0x3e0
>> [  317.026249]  worker_thread+0x221/0x3e0
>> [  317.026252]  ? process_one_work+0x3e0/0x3e0
>> [  317.026256]  kthread+0x117/0x130
>> [  317.026264]  ? kthread_create_worker_on_cpu+0x70/0x70
>> [  317.026275]  ret_from_fork+0x35/0x40
>> --
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/infiniband/core/iwcm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
>> index 72141c5b7c95..94566271dbff 100644
>> --- a/drivers/infiniband/core/iwcm.c
>> +++ b/drivers/infiniband/core/iwcm.c
>> @@ -427,7 +427,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
>>   		break;
>>   	}
>>   	if (cm_id_priv->qp) {
>> +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>>   		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
>> +		spin_lock_irqsave(&cm_id_priv->lock, flags);
>>   		cm_id_priv->qp = NULL;
> 
> Shouldn't you first do cm_id_priv->qp = NULL and only then
> unlock and destroy the qp?

Probably...
