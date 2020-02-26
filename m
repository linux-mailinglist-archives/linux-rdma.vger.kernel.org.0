Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B51170C7C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 00:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgBZXTp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 18:19:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44525 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXTo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 18:19:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so1333354oia.11
        for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2020 15:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I9MypL6BAsKfZ4rRFkaqekxBpNaZPIdxOAKCi7jlEQ8=;
        b=HFS5a2ecFlDt4koVRYVGtqj/MK09xrUsuIXSga6z65vQp37k+e4qdlLBtVWlDZYBJA
         9NMSCUfRDdaNazfQmGgwSTNoeLQ4vGtaMYIyEiYDrD69Yaz962FowRwpaPDJxuhVuetZ
         beczZurzNs0nVtG7BMPz93tEZDTnQ1YwAu8dEtVWBYLAW0WZSBLdG8QAxiaE7vxIRW1N
         of1wolan7iVEZTxyEMDTOGdsap+QzkL11oCzZVulKqUjP4ynG9dJs5ljhUmlo0uxWhDu
         TGab2jw3g0MO/lVhakenS+zVN0cR+hr+OodH8X/one/OAv148+id6gamzTIAj/dTJKgE
         MYIg==
X-Gm-Message-State: APjAAAVAGf7ntbTncFF3hZnI0DL75llt25934wsKFwILPY02P9hK/6Yn
        ciKUKHdkq/iDUsJFC1H0k0G1SYrI
X-Google-Smtp-Source: APXvYqxuGp5dlmVYcBGCJ8WQnQO59GX2wbuy1BC9+t9iduG0vuM2R2IO77+f/Kvr9LuSuz6480GUqg==
X-Received: by 2002:aca:2315:: with SMTP id e21mr1126185oie.147.1582759184090;
        Wed, 26 Feb 2020 15:19:44 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e206sm1324231oia.24.2020.02.26.15.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:19:43 -0800 (PST)
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <20200226170720.GY31668@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5d883018-0c27-fe1d-3dfb-2ec9de76325b@grimberg.me>
Date:   Wed, 26 Feb 2020 15:19:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226170720.GY31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
>> index 3ec8e50efa16..2d6f2cf1e319 100644
>> +++ b/include/linux/nvme-rdma.h
>> @@ -52,13 +52,15 @@ static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
>>    * @qid:           queue Identifier for the Admin or I/O Queue
>>    * @hrqsize:       host receive queue size to be created
>>    * @hsqsize:       host send queue size to be created
>> + * @hmax_fr_pages: host maximum pages per fast reg
>>    */
>>   struct nvme_rdma_cm_req {
>>   	__le16		recfmt;
>>   	__le16		qid;
>>   	__le16		hrqsize;
>>   	__le16		hsqsize;
>> -	u8		rsvd[24];
>> +	__le32		hmax_fr_pages;
>> +	u8		rsvd[20];
>>   };
> 
> This is an on the wire change - do you need to get approval from some
> standards body?

Yes, this needs to go though the NVMe TWG for sure.
