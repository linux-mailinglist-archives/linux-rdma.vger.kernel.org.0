Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60463C21
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 21:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfGITqB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 15:46:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39315 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGITqB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 15:46:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id m202so16295663oig.6;
        Tue, 09 Jul 2019 12:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qM3i82qaJzPdPQ1QKhtsBhG9j6T7uOCTBb84AUQwmw=;
        b=A493FvIVQQrIKhxO1QxOINFe4XgSR1tTS0sXeAEspOk43z7BKF6tyAzER9S31hAfG1
         mUb2D2QHpBDupfWOJz5lydxc08a1DMQVk2edu1BP4witP3vNod810DZP4xtE5mXUm5Wy
         7p8nWPT92AOYxB8zHfwt1mHKNmnWh98K62xmE2SfPO/6LLh8ZUm09G7VcPD6xoRZ3N9g
         uPMxMkERDtvU1dynn+eECgAjZYTP23/IP/CwlSX4kra/Guqy7ikwzSSjJbWi2SKY47z/
         bvPl5KUUeGPiChViirmucXMNXGYmwz9LjlUPf143EnZCDT4D/ou7nizgoRX+gSIV6fYl
         KHyQ==
X-Gm-Message-State: APjAAAWhf1WpRQ8zlV7aGanTlhHKLDxAYeitSy9a/da4Y/RBSKkG1XDu
        q7CGhe81dDYu1C/7vDGdIU0=
X-Google-Smtp-Source: APXvYqzo6p+6SStIQ+IoTvFpt0PopksiDPZF6pv8ez8wqni0GmAiXqymsiRMqFbyayhRxfG6vvmsRg==
X-Received: by 2002:aca:ea41:: with SMTP id i62mr1004031oih.144.1562701560031;
        Tue, 09 Jul 2019 12:46:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id n26sm22491otq.10.2019.07.09.12.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 12:45:59 -0700 (PDT)
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>, gregkh@linuxfoundation.org
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
Date:   Tue, 9 Jul 2019 12:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Danil and Jack,

> Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> 
> Could you please provide some feedback to the IBNBD driver and the
> IBTRS library?
> So far we addressed all the requests provided by the community

That is not exactly correct AFAIR,

My main issues which were raised before are:
- IMO there isn't any justification to this ibtrs layering separation
   given that the only user of this is your ibnbd. Unless you are
   trying to submit another consumer, you should avoid adding another
   subsystem that is not really general purpose.

- ibtrs in general is using almost no infrastructure from the existing
   kernel subsystems. Examples are:
   - tag allocation mechanism (which I'm not clear why its needed)
   - rdma rw abstraction similar to what we have in the core
   - list_next_or_null_rr_rcu ??
   - few other examples sprinkled around..

Another question, from what I understand from the code, the client
always rdma_writes data on writes (with imm) from a remote pool of
server buffers dedicated to it. Essentially all writes are immediate (no
rdma reads ever). How is that different than using send wrs to a set of
pre-posted recv buffers (like all others are doing)? Is it faster?

Also, given that the server pre-allocate a substantial amount of memory
for each connection, is it documented the requirements from the server
side? Usually kernel implementations (especially upstream ones) will
avoid imposing such large longstanding memory requirements on the system
by default. I don't have a firm stand on this, but wanted to highlight
this as you are sending this for upstream inclusion.

  and
> continue to maintain our code up-to-date with the upstream kernel
> while having an extra compatibility layer for older kernels in our
> out-of-tree repository.

Overall, while I absolutely support your cause to lower your maintenance
overhead by having this sit upstream, I don't see why this can be
helpful to anyone else in the rdma community. If instead you can
crystallize why/how ibnbd is faster than anything else, and perhaps
contribute a common infrastructure piece (or enhance an existing one)
such that other existing ulps can leverage, it will be a lot more
compelling to include it upstream.

> I understand that SRP and NVMEoF which are in the kernel already do
> provide equivalent functionality for the majority of the use cases.
> IBNBD on the other hand is showing higher performance and more
> importantly includes the IBTRS - a general purpose library to
> establish connections and transport BIO-like read/write sg-lists over
> RDMA,

But who needs it? Can other ulps use it or pieces of it? I keep failing
to understand why is this a benefit if its specific to your ibnbd?
