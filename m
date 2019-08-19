Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717ED94AC9
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfHSQsa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 12:48:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46695 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfHSQsa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 12:48:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so1221195plz.13
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 09:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F63iNPc0Oexd6AUh4x/BYfGPuPUXD9wScU+N6Iz1h70=;
        b=UcJuI5JeyImBAAOMC5UhBtj2DX/Zj+5X6xmDZt8W4HbImSiRQyvH3dpUZtg+Y5g1N8
         D9Z3lrlHj2aZrNmxmtvQNMrza35FSwfkCVPWnc/zk0JYgTtUDBe2VngvUgiir0WGML9C
         m2VXF6JaIesOOeK4epnZSZeQLD3XTIhZ6EQvfiDEs026z2S3h6jSnQyGmE7fPM2l6WOm
         bRlUcvLbrQ5dJMRGRfnDewSPYFqoTCGguu31gedebL1IIWFV+X8kB2C+KyjW6CzFRfMJ
         vY1doI4i8ciMzxu8A8xxQ0H0JGYpy3//eYbMA3bFUNGLn2rUnwhX5MfTz06gve5V0aWg
         9g3A==
X-Gm-Message-State: APjAAAVf/Iq7GwM3blpZ2YQ0+Lymz1zkkRrFEOT7LNM+nFOuNe7BQaU0
        XXvDAamRO+xGMdy+d4XaeV4=
X-Google-Smtp-Source: APXvYqwORBX7KwY1Jehvk/USW9PVP00s55WaTJj8Ril8EWo8PJbBIvCWBdKs87XaUEENZEiB2pzItA==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr23222370plp.262.1566233309522;
        Mon, 19 Aug 2019 09:48:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u1sm15103661pgi.28.2019.08.19.09.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:48:28 -0700 (PDT)
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hal Rosenstock <hal@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
References: <20190814151507.140572-1-bvanassche@acm.org>
 <20190819122126.GA6509@ziepe.ca>
 <d2429292-be75-ee67-2cce-081d9d0aa676@acm.org>
 <20190819151722.GG5080@mellanox.com>
 <ad0d3211-bf70-d349-7e14-e4b515bb3e98@acm.org>
 <20190819161658.GJ5058@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6cd489d0-6af1-38e8-3d69-d95b7df03452@acm.org>
Date:   Mon, 19 Aug 2019 09:48:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819161658.GJ5058@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/19/19 9:16 AM, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2019 at 08:45:58AM -0700, Bart Van Assche wrote:
>> On 8/19/19 8:17 AM, Jason Gunthorpe wrote:
>>> On Mon, Aug 19, 2019 at 08:11:21AM -0700, Bart Van Assche wrote:
>>>> Does uniqueness of the I/O controller GUID only matter in InfiniBand
>>>> networks or does it also matter in other RDMA networks?
>>>>
>>>> How about using 0 as default value for the srpt_service_guid in RoCE
>>>> networks?
>>>
>>> How does SRP connection management even work on RoCE?? The CM MADs
>>> still carry a service_id? How do the sides exchange the service ID to
>>> start the connection? Or is it ultimately overriden in the CM to use
>>> an IP port based service ID?
>>
>> The ib_srpt kernel driver would have to set id_ext to a unique value if
>> srpt_service_guid would be zero since the SRP initiator kernel driver uses
>> the IOC GUID + id_ext + initiator_ext combination in its connection
>> uniqueness check (srp_conn_unique()).
> 
> Sounds like you should just generate something random for RDMA/CM mode ?
> 
> Still a bit confused how this is usable though if the initiating side
> needs the service ID?

Hi Jason,

When I read Lijun Ou's e-mails for the first time I was assuming that my 
patch had been tested on top of a recent kernel. After having reread 
these e-mails I think my patch had been tested on top of kernel v4.14 
and is not necessary for more recent kernels. So I think we can drop the 
patch at the start of this e-mail thread.

Bart.

