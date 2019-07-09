Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B648663D4B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 23:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGIV1p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 17:27:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32972 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfGIV1p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 17:27:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id u15so16549741oiv.0;
        Tue, 09 Jul 2019 14:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFmZc74oeeM35zjBvo4+BukpLYLvklQy3qJm+E2OtJU=;
        b=KlBUku48coRkOcM346aG1N84w+w094WErXhf3NDNsJ8Ev4ofPfyJ84st/VXAHZ+qWN
         hbjUjMNtuFYssDOkZVmwQd3jjZ2aRHB7LzZXMudOMxdKhUXjQvgE99NClgNPIO9Hpbsn
         DIzB9bQbLC40kM7pMc6/KHr5SMVkYeHFCvBdMqfHphhwbUtugNsyLNSNokIRfza2ig2X
         /PMvJE1angF7Z5mFBMnIgt+z1vmKeipku7Z9X8AxWGgPHhFuGAHgyr6b+hgeRoZvAitO
         MaMZtVMtexu/mDiDaPJDmIj/PXEPssl8OybHTMF+x7fDOqDtGMhu4cZlWCM+hLUEM+WA
         /zRg==
X-Gm-Message-State: APjAAAVI9Ye44jivetFVqOZCFmvvH+8LUTdSKcFV7Un8OFJwL0f6DqB6
        JHSlWrWIbWHqb/KJfPSj59g=
X-Google-Smtp-Source: APXvYqxDF0A6yCgF0FCviLWVZqNRm5Hbs7TmfD5YpmIKbBad5iRl8KSOywojmloSncHdk6BuyEh3eg==
X-Received: by 2002:aca:d7d5:: with SMTP id o204mr1337022oig.16.1562707664103;
        Tue, 09 Jul 2019 14:27:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o18sm140782ote.63.2019.07.09.14.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:27:43 -0700 (PDT)
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jinpu Wang <jinpuwang@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com>
 <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
 <20190709120606.GB3436@mellanox.com>
 <CAMGffE=T+FVfVzV5cCtVrm_6ikdJ9pjpFsPgx+t0EUpegoZELQ@mail.gmail.com>
 <20190709131932.GI3436@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1cd86f4b-7cd1-4e00-7111-5c8e09ba06be@grimberg.me>
Date:   Tue, 9 Jul 2019 14:27:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709131932.GI3436@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Thanks Jason for feedback.
>> Can you be  more specific about  "the invalidation model for MR was wrong"
> 
> MR's must be invalidated before data is handed over to the block
> layer. It can't leave MRs open for access and then touch the memory
> the MR covers.

Jason is referring to these fixes:
2f122e4f5107 ("nvme-rdma: wait for local invalidation before completing 
a request")
4af7f7ff92a4 ("nvme-rdma: don't complete requests before a send work 
request has completed")
b4b591c87f2b ("nvme-rdma: don't suppress send completions")
