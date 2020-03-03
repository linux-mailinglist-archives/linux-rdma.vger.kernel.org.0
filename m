Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1236177BE7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 17:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgCCQ2S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 11:28:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38571 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgCCQ2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 11:28:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so1767365pgh.5;
        Tue, 03 Mar 2020 08:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FRPv7EX8rscTfejBWP0LjEO2EJEJzeo9jPrIc+yakk8=;
        b=MRcbv2fi1uog0Ljcx07yg8yP8S7r/JDmRMcq6YgzA2y5ERNSVplCYMOKESgD57uLfk
         9yKaxTc5cfuQT45FUhM8SMXebGuVpx6dGzM/pJ9AIDyPXB/nXrmY+/G1DGio9efngNXu
         WF1wBEiefEdECWebucuNm7z1W4bSLhdXUBxtYfpt+ABfzP8zu6F2C2oq4WCFdIATZfNh
         xzprZ4ugci3dLWV0zbjWr7ZVoMbpQLd5JT7cvoMePGd2R5FQbyMDUBo3jZFZZsdzUN+7
         XigGgzvpV+R9ER58cmrn3GPoWubcXNRm8J3HFNjbX9DeNNqTfSWHi28ZHA7LYRFg9/dQ
         tCig==
X-Gm-Message-State: ANhLgQ2F18sO7FQ2LjBrgVtexckniUIyyx3I+6J1+LshHdKP7hfBoHbN
        epu6E/b1n7+TVGofVh9SUTg=
X-Google-Smtp-Source: ADFU+vuFTeoYH4QP5j3Qtfv/cTOFLDtVwhObEWCSOtthPi+ZV0ediEsQqXg5hKF35/NPrqgxkYpMpA==
X-Received: by 2002:a63:5508:: with SMTP id j8mr4702103pgb.170.1583252896735;
        Tue, 03 Mar 2020 08:28:16 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f9sm13170582pfq.24.2020.03.03.08.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:28:15 -0800 (PST)
Subject: Re: [PATCH v9 21/25] block/rnbd: server: functionality for IO
 submission to file or block dev
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-22-jinpuwang@gmail.com>
 <92721a50-158f-3018-39d4-40fce7b0f4d8@acm.org>
 <CAHg0Huy_8hzxxA6R8_EzPNfYd3QN-meUckFStUrjiGeVaGj_Qg@mail.gmail.com>
 <CAMGffEmtJJE8eoMQ4X3MYEJez35M20DaWwTt_3-+hk7i=R-r=w@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4de21393-a65a-f208-a37a-1889f8db5588@acm.org>
Date:   Tue, 3 Mar 2020 08:28:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMGffEmtJJE8eoMQ4X3MYEJez35M20DaWwTt_3-+hk7i=R-r=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/3/20 8:20 AM, Jinpu Wang wrote:
> We tried the above approach and just noticed the bio_map_kern was no
> longer exported since 5.4 kernel.
> We checked target_core_iblock.c and nvme io-cmd-bdev.c, they are open
> coding similar function.
> 
> I guess re-export bio_map_kern will not be accepted?
> Do you have suggestion how should we handle it?

Duplicating code is bad.

The code in drivers/nvme/target/io-cmd-bdev.c and target_core_iblock.c 
is different: it calls bio_add_page() instead of bio_add_pc_page().

Please include a patch in this series that reexports bio_map_kern().

Thanks,

Bart.

