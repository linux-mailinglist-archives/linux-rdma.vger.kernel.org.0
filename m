Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37871B53EE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfIQRUg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 13:20:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46111 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfIQRUg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 13:20:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so3977710wrv.13
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 10:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rBckLleFLjatJBkoQzBeHMYHcRKemTGYl33t4yHOkqc=;
        b=CL9aBfp7KiHSRxR4WIvtQP3vvwjGTlY+FhaHOHtBzQDI7XiN2qcth2gdxfGq+J5R4r
         FThE846BygL3WB72AKTcLls8HbIPMCS90duZTLirL1IyeIpyvtxjGddo8mOB9l9nDA1W
         IspqUD4Ve2oHEWUA+vs8mUmLGwVa2tPrIrNMHSogBiD6swgNF9LW1O9GdQsc1+7ffj5c
         Vhw74vJkDzb/DKouQWkIE1ycsVluSnAbjQKbnHKKBanLspk0RbGkwRnW1OU+L5kgYdZr
         3vBxMMQvPX9R8eyfPQnyOYfm/2HCJUxzOsjvdX5q/Mguu4cdGxfiYvUOGvIrAY8xsuHi
         8KxA==
X-Gm-Message-State: APjAAAXmaYzl04IuC/Ie818HfXFxm9amqolDFtHM3NLxAt/sCJevGudH
        DM6S4ftPRSCBkZC7XewUCIC1iBfW
X-Google-Smtp-Source: APXvYqw07Kw5UwCk/1lNEyGSc3gDMsP7o+STuLvo/ImXkn85WPdu2DcaxQmRoQd47ZKr0GGECVsyGw==
X-Received: by 2002:adf:cc8a:: with SMTP id p10mr3743735wrj.321.1568740833839;
        Tue, 17 Sep 2019 10:20:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id v7sm2524899wru.87.2019.09.17.10.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 10:20:33 -0700 (PDT)
Subject: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190916162829.GA22329@ziepe.ca>
 <20190904212531.6488-1-sagi@grimberg.me> <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
 <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
 <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
 <20190911155814.GA12639@chelsio.com>
 <OFAEAC1AA7.9611AF4F-ON00258478.002E162F-00258478.0031D798@notes.na.collabserv.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <55ece255-b4e2-9bc4-e1ec-039d92a36273@grimberg.me>
Date:   Tue, 17 Sep 2019 10:20:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <OFAEAC1AA7.9611AF4F-ON00258478.002E162F-00258478.0031D798@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> Date: 09/16/2019 06:28PM
>> Cc: "Steve Wise" <larrystevenwise@gmail.com>, "Bernard Metzler"
>> <BMT@zurich.ibm.com>, "Sagi Grimberg" <sagi@grimberg.me>,
>> "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>> Subject: [EXTERNAL] Re: Re: [PATCH v3] iwcm: don't hold the irq
>> disabled lock on iw_rem_ref
>>
>> On Wed, Sep 11, 2019 at 09:28:16PM +0530, Krishnamraju Eraparaju
>> wrote:
>>> Hi Steve & Bernard,
>>>
>>> Thanks for the review comments.
>>> I will do those formating changes.
>>
>> I don't see anything in patchworks, but the consensus is to drop
>> Sagi's patch pending this future patch?
>>
>> Jason
>>
> This is my impression as well. But consensus should be
> explicit...Sagi, what do you think?

I don't really care, but given the changes from Krishnamraju cause other
problems I'd ask if my version is also offending his test.

In general, I do not think that making resources free routines (both
explict or implicit via ref dec) under a spinlock is not a robust
design.

I would first make it clear and documented what cm_id_priv->lock is
protecting. In my mind, it should protect *its own* mutations of
cm_id_priv and by design leave all the ops calls outside the lock.

I don't understand what is causing the Chelsio issue observed, but
it looks like c4iw_destroy_qp blocks on a completion that depends on a
refcount that is taken also by iwcm, which means that I cannot call
ib_destroy_qp if the cm is not destroyed as well?

If that is madatory, I'd say that instead of blocking on this
completion, we can simply convert c4iw_qp_rem_ref if use a kref
which is not order dependent.
