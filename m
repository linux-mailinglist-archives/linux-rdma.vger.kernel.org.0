Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83208281CDB
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJBUUj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 16:20:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37931 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBUUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Oct 2020 16:20:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id l126so2071916pfd.5;
        Fri, 02 Oct 2020 13:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PNXMj9wXy59v9qpnujnEiqx2cewwdkt3Afn29BVwn5c=;
        b=I29wWkqJNcWLmuWX8U7PfkZ+rLbSx6rGWjwILVenrRB7D9b4pmC5ehILfcizm1jtzx
         zf2qJRUgrzVHoWMoJBnDeh7Bsr8w+py5wovg6kBNapHrcIn5PaF6q/JsPdhPHcE+MS5w
         FHRZmoaxG2sYCgX/OYHJ3r85SvjsAZ5U1Z9KfmU2WTGzRB4ZrOVbtkW3uyZhrFZCexCm
         yeSo3yra1EQC5GO2stge1sMutnPBOD/l8t4+RDMDUAuC05aZhaQXVKyB7bnPLlDcoCbv
         fXHArTBIuRNRPvu8MxOis5bOseKwfdSC4cQ1ITiIpCrRmPF2JiDKxoL+B8H/M9xp+Bo2
         eR9w==
X-Gm-Message-State: AOAM531LSskMS6awQ3rs1HSwiXujhNaPtd1zUt0S/XM2FJbjiWqmAOTZ
        Gn4KJoxbAxLGw9f8/tnNXCEz9P1jdNg=
X-Google-Smtp-Source: ABdhPJw1scUdnUZRdy3/EYDI1WJHpzUsv5E7oA4yVYCtrzDCdpypISTAeaMWrVX/eBkOYx4+UIzMMw==
X-Received: by 2002:a63:f104:: with SMTP id f4mr3916557pgi.365.1601670038260;
        Fri, 02 Oct 2020 13:20:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1be2:3dfb:f0b7:cc27? ([2601:647:4802:9070:1be2:3dfb:f0b7:cc27])
        by smtp.gmail.com with ESMTPSA id a1sm2388427pjh.2.2020.10.02.13.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:20:37 -0700 (PDT)
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org> <20200929102046.GA14445@lst.de>
 <20200929103549.GE3094@unreal>
 <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
 <20201002064505.GA9593@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <14fab6a7-f7b5-2f9d-e01f-923b1c36816d@grimberg.me>
Date:   Fri, 2 Oct 2020 13:20:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002064505.GA9593@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Yes, basically usage of managed affinity caused people to report
>> regressions not being able to change irq affinity from procfs.
> 
> Well, why would they change it?  The whole point of the infrastructure
> is that there is a single sane affinity setting for a given setup. Now
> that setting needed some refinement from the original series (e.g. the
> current series about only using housekeeping cpus if cpu isolation is
> in use).  But allowing random users to modify affinity is just a receipe
> for a trainwreck.

Well allowing people to mangle irq affinity settings seem to be a hard
requirement from the discussions in the past.

> So I think we need to bring this back ASAP, as doing affinity right
> out of the box is an absolute requirement for sane performance without
> all the benchmarketing deep magic.

Well, it's hard to say that setting custom irq affinity settings is
deemed non-useful to anyone and hence should be prevented. I'd expect
that irq settings have a sane default that works and if someone wants to
change it, it can but there should be no guarantees on optimal
performance. But IIRC this had some dependencies on drivers and some
more infrastructure to handle dynamic changes...
