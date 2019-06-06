Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79736C81
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 08:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfFFGr0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 02:47:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33109 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGr0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 02:47:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so535110plq.0;
        Wed, 05 Jun 2019 23:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WPf/+Ec6XD2NJwS+WuJwGcBhY4O7tg8bwCx2+7XcVtY=;
        b=ZEdSg4LKKDjq/btsZHPuKaeMc2wqnxhdUFVDtZxa+tdjajqlxv3x0JKqQvl3aZu1dq
         uFWpR2+qS1epXMN0pXVfFCDMSv0icoNp321auCEsJWX7/uzbjEQXXmEaA3DxVqidtqtr
         ufaZtw6ICchVS1BEmsdL/qroAfoXdbtu9j5U7yR5yb//0Uq+kxpQAo+XO8DvPlt7uBEU
         fNOiKmvS3P4BHovUsX7r00kli0z0qVYrcyAnVDkm9dk8HhzyhaWQw3OGrTB3Lz5oJJzh
         YmGguEp0kRfQAIAqFh1jxY+LQERfmadyaALx9RLRiISw5fdOnYyqinOxk9YNaca7ctlP
         yhjw==
X-Gm-Message-State: APjAAAWisPO7n2Jjt2QyLSzNVqSCX2Cs1QIk7pdLTVCEzsEIUumIAQpq
        G8ifQ/J1H5KYqFtVNI4i7kqTaHhJdY4=
X-Google-Smtp-Source: APXvYqwwzEgFacSOy5lBObqVx659/0dp2Vvew435YbpssOVPqAJ3BZRIQKOSQbhlCgfelEUdxbxi3w==
X-Received: by 2002:a17:902:8648:: with SMTP id y8mr50224257plt.30.1559803645405;
        Wed, 05 Jun 2019 23:47:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:d85c:2df7:72d9:ea63? ([2601:647:4800:973f:d85c:2df7:72d9:ea63])
        by smtp.gmail.com with ESMTPSA id o192sm1047967pgo.74.2019.06.05.23.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 23:47:24 -0700 (PDT)
Subject: Re: [PATCH] IB/iser: explicitly set shost max_segment_size
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20190606000209.26086-1-sagi@grimberg.me>
 <20190606063600.GB27033@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ae65c220-193c-e526-57da-17b50820b015@grimberg.me>
Date:   Wed, 5 Jun 2019 23:47:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606063600.GB27033@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
>> index 56848232eb81..2984a366dd7d 100644
>> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
>> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
>> @@ -653,6 +653,7 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
>>   						   SHOST_DIX_GUARD_CRC);
>>   		}
>>   
>> +		shost->max_segment_size = ib_dma_max_seg_size(ib_dev);
>>   		if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
>>   			shost->virt_boundary_mask = ~MASK_4K;
> 
> We only really need this settings in the IB_DEVICE_SG_GAPS_REG case,
> as the segement size is unlimited on the PRP-like scheme used by the
> other MR types anyway, and set as such by the block layer.  I.e.g this
> should become:
> 
>   		if (ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
> 			shost->max_segment_size = ib_dma_max_seg_size(ib_dev);
> 		else
>    			shost->virt_boundary_mask = ~MASK_4K;

Not sure I understand.

max_segment_size and virt_boundary_mask are related how?
