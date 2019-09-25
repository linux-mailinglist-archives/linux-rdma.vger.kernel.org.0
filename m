Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673F3BE7F9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 00:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfIYWBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 18:01:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35539 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfIYV5L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 17:57:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so338836pfw.2;
        Wed, 25 Sep 2019 14:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n6T0Rl4EMdxIFYwT1gTtOk2ilvaHejSBU0Z0acOfFoQ=;
        b=KJMZFS4KuAToYZUtpdg6ELOxaPSsX6itaMSl4sAdeebNalITvar55GS+uyjHHC/G1c
         uFxLlA2HSbmVCYHmcKMq+qVcs37a0iudaz7DutbpXkqWUqoPZ1JtMUqekhSBXsUiaAsh
         Mm03MDUNX/K5gPM2B849LfOJ7DCW8L0aPuQRHa+5CXEuE9hvcrPScOVd4tF5ZgCc91JA
         flPNW92c0kz/ldLXLHgw+DB+Q85lvFPToXKIzIMqOzzTamYFcmgRSoJitKPjoSFm1GTK
         O5uZ+qWJcvCO1pZwf6xchKKOYJ6b9FzeB2La/MxAjRYt6ap8wJEhD4lqOK3MyQXsdTx4
         cmxw==
X-Gm-Message-State: APjAAAVko17tPTlrv4r/BuIwVLcvLrqrgSVYKjAp/OeiM+dISYd1Ot4Q
        VrOG1M6lZtYSgL6175JZrVc=
X-Google-Smtp-Source: APXvYqyOLl8hzcVY8EhgnCaq9V0HEyqUQdO6sKN0MTtmEBDJloBDcJWKxIu+p2XrSSVRxrd8yx80Ow==
X-Received: by 2002:a63:e62:: with SMTP id 34mr11161pgo.331.1569448630764;
        Wed, 25 Sep 2019 14:57:10 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z25sm13038pfn.7.2019.09.25.14.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 14:57:09 -0700 (PDT)
Subject: Re: [PATCH v4 03/25] ibtrs: private headers with IBTRS protocol
 structs and helpers
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-4-jinpuwang@gmail.com>
 <7f62b16a-6e6c-ad05-46d4-05514ffaeaba@acm.org>
 <CAHg0HuzsMK1Rg4mpFv2GwOnmsicR843qDMX+LKWDDn4-kV-eew@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4c7c4551-1a07-621c-d67a-b8ed6b0a8885@acm.org>
Date:   Wed, 25 Sep 2019 14:57:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuzsMK1Rg4mpFv2GwOnmsicR843qDMX+LKWDDn4-kV-eew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/25/19 2:45 PM, Danil Kipnis wrote:
> do you think it would make sense we first submit a new patchset for
> IBTRS (with the changes you suggested plus closed security problem)
> and later submit a separate one for IBNBD only?

I'm not sure what others prefer. Personally I prefer to see all the 
code, that means IBTRS and IBNBD.

Thanks,

Bart.
