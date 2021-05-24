Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70E38DFC8
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 05:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhEXDOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 May 2021 23:14:21 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:47024 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhEXDOV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 May 2021 23:14:21 -0400
Received: by mail-pf1-f174.google.com with SMTP id y15so8291285pfn.13
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 20:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+fmVuCuixKGhuXSeUeY2q0JiT53RZOvlkYC00/9tKpI=;
        b=nR2Kj8OAVdtxiM/2LXe83MAp6GaxCR2MiO0P99VJtVozJLuNUJyc6wPpPswar6x8YG
         UNSzo26hlJyP9AT6TgYdqihjQzp08FaSWMe/YgG3d9SH8V4D09/luKrRf0oYvBLPqbZY
         OIPDJIjBQjk8cUBVX8uS3YCQAB8Wffy89KCOTRuOxXSiybiU3rbpLS/GZTeRZtprkSCc
         +gc5tmi9Ke4dPNJJnRy/3kdgEJPahviTzlrfcdTx4Kpr7WZgbdcvT52YAzvYP2pDXbdT
         +BDCPBDLhk7skAX/MQ3eGMj/OvEG5fDGroHEaPdhyTiEl6MvRsiluSTivOB2w6YN3ONl
         p91g==
X-Gm-Message-State: AOAM530O5zqDGxqhyHXe0dcGF6+d/jQW3xfOlZ9JAnL3Xq7JfgwF/pam
        1r/BaFR2CVAB7mH7pC/AxPae8ZPA9GvvMA==
X-Google-Smtp-Source: ABdhPJzQHe/5sAnynAJLSsOSnSp1Z+9mT3xUmd7G2iFfNsu1/AIscI9sP4ZjO9/AV4xbVXGPT/RcaA==
X-Received: by 2002:aa7:8ec4:0:b029:2e6:54e2:3055 with SMTP id b4-20020aa78ec40000b02902e654e23055mr10679523pfr.15.1621825972905;
        Sun, 23 May 2021 20:12:52 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id p19sm7213733pgi.59.2021.05.23.20.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 20:12:52 -0700 (PDT)
Subject: Re: [PATCH 1/5] RDMA/ib_hdrs.h: Remove a superfluous cast
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Don Hiatt <don.hiatt@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-2-bvanassche@acm.org> <YKTTufav7me+Sgic@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b8d4f515-4ec7-0221-f898-308b10331401@acm.org>
Date:   Sun, 23 May 2021 20:12:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKTTufav7me+Sgic@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/21 2:00 AM, Leon Romanovsky wrote:
> On Tue, May 11, 2021 at 08:27:48PM -0700, Bart Van Assche wrote:
>> diff --git a/include/rdma/ib_hdrs.h b/include/rdma/ib_hdrs.h
>> index 57c1ac881d08..82483120539f 100644
>> --- a/include/rdma/ib_hdrs.h
>> +++ b/include/rdma/ib_hdrs.h
>> @@ -208,7 +208,7 @@ static inline u8 ib_get_lver(struct ib_header *hdr)
>>  
>>  static inline u16 ib_get_len(struct ib_header *hdr)
>>  {
>> -	return (u16)(be16_to_cpu(hdr->lrh[2]));
>> +	return be16_to_cpu(hdr->lrh[2]);
>>  }
>>  
>>  static inline u32 ib_get_qkey(struct ib_other_headers *ohdr)
> 
> It is unclear why this function in the header. It is called only once.

That's a good point. I will move it into the .c file that uses this
function.

Thanks,

Bart.

