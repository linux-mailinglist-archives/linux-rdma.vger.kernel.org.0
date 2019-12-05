Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 350E3113893
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2019 01:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfLEAQT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Dec 2019 19:16:19 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:40817 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEAQT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Dec 2019 19:16:19 -0500
Received: by mail-pl1-f172.google.com with SMTP id g6so428420plp.7;
        Wed, 04 Dec 2019 16:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QXOTNbfvt4PQWE1w6GCGy81Vtob2l8oNprwO21T/FYw=;
        b=AUCmDxMl8POPp4XTUrkOvywntVNS/GSITi++pgoQinhP0W/pqLrTm4QhpuhbjCUKXI
         dpHH2pYh/3/poaczzL6Vl5JrWGJEBYI9IT4RAoYe+xMAlVQxpClo9uRQIarpQtnlHpTE
         2aWvmcjnGnuiv0tBOAqolGAhhYnRr8C692inPfaX4MTGh1S2cqI2r1zq/iZcnxVWviZs
         FLx3sq6RUXcQ0mZXA/OGfTQ+fOjYvqKJ4kcn7n1HsToajLfzLOIdwtSmPAlFkoUfVibM
         8SMHuEFq877fQQlkUWh/zGksy6WIzSXtmzfuqDvZakWgiB1ev7pwCJQTsSz0wgbcficB
         jA6A==
X-Gm-Message-State: APjAAAW1o74uLrZIA9tXnUGD/LhS2PzuTCFqBZUnhzE9tswBDC1oGAZP
        AKssTV3Fk5C1KUCqvfd/GuM=
X-Google-Smtp-Source: APXvYqyfQGVYaulKAcmWLg8fai9mIRBmWJGk9hRhnBoL3l1xWDIXRBc1Ryagoc5Iin7/tcdwRgWdAw==
X-Received: by 2002:a17:90a:23a9:: with SMTP id g38mr6397637pje.128.1575504978148;
        Wed, 04 Dec 2019 16:16:18 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s22sm7374112pjr.5.2019.12.04.16.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 16:16:17 -0800 (PST)
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Ming Lei <ming.lei@redhat.com>,
        Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sagi Grimberg <sagi@grimberg.me>,
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
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <683a4567-6b34-ac3b-93ff-74d788ac4242@acm.org>
Date:   Wed, 4 Dec 2019 16:16:15 -0800
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

On 12/4/19 3:02 PM, Ming Lei wrote:
> On Wed, Dec 04, 2019 at 12:23:39PM -0500, Stephen Rust wrote:
>> Presumably non-brd devices, ie: real scsi devices work for these test
>> cases because they accept un-aligned buffers?
> 
> Right, not every driver supports such un-aligned buffer.
> 
> I am not familiar with RDMA, but from the trace we have done so far,
> it is highly related with iser driver.

Hi Stephen,

Do you need the iSER protocol? I think that the NVMeOF and SRP drivers 
also support RoCE and that these align data buffers on a 512 byte boundary.

Bart.
