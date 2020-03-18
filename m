Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06A118A0DB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 17:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCRQtL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 12:49:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37933 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRQtL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 12:49:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so14208022pfn.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 09:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/G3r/xeCxGZTAlVzP2ub1+8AEE5sUfY+MvfaFPM87ow=;
        b=tpwuQFYF2sWBAj3l1eKIW4uEw1u00IBWUuMnor2fkh6Svlq3gRjgvvXBceutVY4FEU
         DSwQlpm0chwXVVtiGmHAMIdgqDwa51enii+lXdJfelwiK2p/xjfO5GFPLtzRnA3Sj8Wg
         xhUugu8hgVCuFnrtlhpYF3s3itccLh+llAK/KrvDTPpdkNsjs9nCX5M7tgiPzMgx8N7G
         ADf1xNUAoT3Y1/w1D1bXnWmKYBA6pnTHXMKAlbabgwmA319zFYONcdUKRvIVmCMmsaWq
         VHLMikz1sCdvASrTPc4RmvM/xGj+FpkS5ViCLlA9GBECMK4XOJhqt1Mp4q8zCFKkzIc5
         2xTw==
X-Gm-Message-State: ANhLgQ3/5ANZNzIFih2khXHvRKBURuhWE7Uv7D6YhNwxf0S7gZT/gpLx
        vtqMd0jhd54sNav800bs+CtDqLoN
X-Google-Smtp-Source: ADFU+vvwR+K0XSg40QhsT41OAeaL5MRi1vcoN72jKymd26IUNJ5jsDPS3mCfVQMpyI5Jogbg4ZHdrA==
X-Received: by 2002:a62:6244:: with SMTP id w65mr5291995pfb.89.1584550149943;
        Wed, 18 Mar 2020 09:49:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:dc11:3a20:fec0:f648? ([2601:647:4802:9070:dc11:3a20:fec0:f648])
        by smtp.gmail.com with ESMTPSA id f8sm7070999pfd.57.2020.03.18.09.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 09:49:09 -0700 (PDT)
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com> <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
 <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
 <20200317203152.GA14946@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3f42f881-0309-b86a-4b70-af23c58960fc@grimberg.me>
Date:   Wed, 18 Mar 2020 09:49:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200317203152.GA14946@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Thanks Krishna,
>>
>> I assume that this makes the issue go away?
>> --
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 11e10fe1760f..cc93e1949b2c 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -889,7 +889,7 @@ static int nvme_tcp_try_send_data(struct
>> nvme_tcp_request *req)
>>                          flags |= MSG_MORE;
>>
>>                  /* can't zcopy slab pages */
>> -               if (unlikely(PageSlab(page))) {
>> +               if (unlikely(PageSlab(page)) || queue->data_digest) {
>>                          ret = sock_no_sendpage(queue->sock, page,
>> offset, len,
>>                                          flags);
>>                  } else {
>> --
> 
> Unfortunately, issue is still occuring with this patch also.
> 
> Looks like the integrity of the data buffer right after the CRC
> computation(data digest) is what causing this issue, despite the
> buffer being sent via sendpage or no_sendpage.

I assume this happens with iSCSI as well? There is nothing special
we are doing with respect to digest.
