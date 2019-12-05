Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91298113DA2
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2019 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfLEJRp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 04:17:45 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33826 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEJRo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Dec 2019 04:17:44 -0500
Received: by mail-pj1-f67.google.com with SMTP id t21so1059494pjq.1;
        Thu, 05 Dec 2019 01:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpsG86sd4T09I7P2DAlwBFPfPNyOEVYKwWpez6CRCnc=;
        b=UdPGYpCdM1uBV5D00GLTYXGydw1GfjbQBf502M5VBJN/gCJUoZKrRQck4lWVzj0nEb
         doOk7OtjuJkT6rJTvnfdYhkUoXPKSPEPg5UMinvSi6WfPNwFqt4hor/pKNZQZz7pGA3c
         RhDWPoRhkV/TD1sW0J3ksoDzom57mccLCee2d1svMRFYMZZjfp2iWtVOOcGzJq7KZYGX
         nVFxw7pqiMldnStBnEGYxKNuulLrH5XBM8qZfnqHkTsIN6U15Y5qnAxsCYq0sqrkTNyT
         XoB02vk9iOI3pu7VpLDAONgrygcB5lh3E5Pso0NGPLWVAHg30Ddz/5VJanyjjwp4ohnH
         bZ5Q==
X-Gm-Message-State: APjAAAUZhuNZu0xICrjDz9N/r2fHpXNRUzPOGXRsf70K0yBzdJ2xezsK
        HZ6epnugYfxt5GM5z8Z3p48=
X-Google-Smtp-Source: APXvYqxfaFK3+QfEn193+C425meNjKEK0ariotT0uyS1f9F1Pn7ElWgYYXA5GpaPRCcHYVBQUI8zKQ==
X-Received: by 2002:a17:902:7448:: with SMTP id e8mr7401226plt.299.1575537464051;
        Thu, 05 Dec 2019 01:17:44 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8dfa:c3a5:24e2:57ab? ([2601:647:4802:9070:8dfa:c3a5:24e2:57ab])
        by smtp.gmail.com with ESMTPSA id i16sm10887509pfo.12.2019.12.05.01.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 01:17:43 -0800 (PST)
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Ming Lei <ming.lei@redhat.com>,
        Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p>
 <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p>
 <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p>
 <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p>
 <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d9d39d10-d3f3-f2d8-b32e-96896ba0cdb2@grimberg.me>
Date:   Thu, 5 Dec 2019 01:17:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204230225.GA26189@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Hi Ming,
>>
>> I have tried your latest "workaround" patch in brd including the fix
>> for large offsets, and it does appear to work. I tried the same tests
>> and the data was written correctly for all offsets I tried. Thanks!
>>
>> I include the updated additional bpftrace below.
>>
>>> So firstly, I'd suggest to investigate from RDMA driver side to see why
>>> un-aligned buffer is passed to block layer.
>>>
>>> According to previous discussion, 512 aligned buffer should be provided
>>> to block layer.
>>>
>>> So looks the driver needs to be fixed.
>>
>> If it does appear to be an RDMA driver issue, do you know who we
>> should follow up with directly from the RDMA driver side of the world?
>>
>> Presumably non-brd devices, ie: real scsi devices work for these test
>> cases because they accept un-aligned buffers?
> 
> Right, not every driver supports such un-aligned buffer.
> 
> I am not familiar with RDMA, but from the trace we have done so far,
> it is highly related with iser driver.

Hi guys,

Just got this one (Thanks for CCing me Ming, been extremely busy
lately).

So it looks from the report that this is the immediate-data and
unsolicited data-out flows, which indeed seem to violate the alignment
assumption. The reason is that isert post recv a contig rx_desc which
has both the headers and the data, and when it gets immediate_data it
will set the data sg to rx_desc+offset (which are the headers).

Stephen,
As a work-around for now, you should turn off immediate-data in your LIO
target. I'll work on a fix.

Thanks for reporting!
