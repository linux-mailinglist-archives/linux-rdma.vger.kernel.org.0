Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266B6389252
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhESPOc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 11:14:32 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:36374 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhESPOc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 11:14:32 -0400
Received: by mail-pl1-f177.google.com with SMTP id a11so7213900plh.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 May 2021 08:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwBW+98p32ERsG+4hfWJ0+sbVFdVPcYWgtfWFWHjbx4=;
        b=CaBQyckQA/snYSulPburkdweZiZVTYEGL6To5QcWjbW5q15dVT4HjrVREVZmq2k6mp
         JZcs9DRdmkniqhspo3Y7GsjZSxnXEEteaoDYq7UphfRNBl3aI/QWVgDU/l2DDFXY0INk
         wxvrl7kzkBBlcEAsktOKzm6GTlVC0LJcgu4KccX1B/Zfx8qnJP4gyTs/bJsEGdD/6c4L
         FE4cHNyeZPGpwRvYR1SZb6KHEecdI++CdzR4TUFS7zRwg/ObsakdB1lhLb16iMyPwtxj
         Aq1wxMVzGyrEXTCv3LUdFzq2qZ3cR313HjmplnmszVY5BqPACAvzzyyrP9/vWYRXXbg5
         zMrQ==
X-Gm-Message-State: AOAM5317KP/LRdK8FPz+kuWLRLb+RtNoPpMbK9UWVI49vaBmkjzYf9EA
        zFyivx9h5V5j62bxRZGuOxs=
X-Google-Smtp-Source: ABdhPJySBAa9B5exJckvfJE0HYPKKKxMLYcJZn5xVbbofKbu72pPf1CPI9LuSbqv+MSUr3FM425Hvg==
X-Received: by 2002:a17:902:bcc7:b029:ed:6f73:ffc4 with SMTP id o7-20020a170902bcc7b02900ed6f73ffc4mr11429054pls.1.1621437192265;
        Wed, 19 May 2021 08:13:12 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:db5a:2bf3:3617:be1c? ([2601:647:4000:d7:db5a:2bf3:3617:be1c])
        by smtp.gmail.com with ESMTPSA id a16sm14598466pfc.37.2021.05.19.08.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 08:13:11 -0700 (PDT)
Subject: Re: [PATCH 5/5] RDMA/srp: Make struct scsi_cmnd and struct
 srp_request adjacent
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-6-bvanassche@acm.org> <YKTV1RKf4Ms+Zzx0@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7a66efb0-7195-aed1-7085-02374028f079@acm.org>
Date:   Wed, 19 May 2021 08:13:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKTV1RKf4Ms+Zzx0@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/21 2:09 AM, Leon Romanovsky wrote:
> On Tue, May 11, 2021 at 08:27:52PM -0700, Bart Van Assche wrote:
>> -static void srp_free_req_data(struct srp_target_port *target,
>> -			      struct srp_rdma_ch *ch)
>> +static int srp_exit_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
>>  {
>> +	struct srp_target_port *target = host_to_target(shost);
>>  	struct srp_device *dev = target->srp_host->srp_dev;
>>  	struct ib_device *ibdev = dev->dev;
>> -	struct srp_request *req;
>> -	int i;
>> +	struct srp_request *req = scsi_cmd_priv(cmd);
>>  
>> -	if (!ch->req_ring)
>> -		return;
>> -
>> -	for (i = 0; i < target->req_ring_size; ++i) {
>> -		req = &ch->req_ring[i];
>> -		if (dev->use_fast_reg)
>> -			kfree(req->fr_list);
>> -		if (req->indirect_dma_addr) {
>> -			ib_dma_unmap_single(ibdev, req->indirect_dma_addr,
>> -					    target->indirect_size,
>> -					    DMA_TO_DEVICE);
>> -		}
>> -		kfree(req->indirect_desc);
>> +	if (dev->use_fast_reg)
>> +		kfree(req->fr_list);
> 
> Isn't cleaner will be to ensure that fr_list is NULL for !dev->use_fast_reg path?
> In patch #4 https://lore.kernel.org/linux-rdma/20210512032752.16611-5-bvanassche@acm.org

Hi Leon,

I think that per-request private data is zero-initialized and hence that
it is not necessary to clear req->fr_list explicitly. blk_mq_alloc_rqs()
 passes __GFP_ZERO to alloc_pages_node(). blk_mq_alloc_rqs() does not
only allocate block layer requests (struct request) but also per-request
private data (set->cmd_size).

Thanks,

Bart.


