Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48E064C92
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfGJTLW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 15:11:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35109 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfGJTLW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 15:11:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so2523995oii.2;
        Wed, 10 Jul 2019 12:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQsowOAJzdxitXTMpH3lblSmCoy4bvYraioAuVTlH0E=;
        b=ZbA5rjTt/8pELagnPJKbktXwu1A0spTpj+EWh0U6z8UhCzmzyd1w+P2O4CQn+0YcBM
         8WdWmSTYTST6gEHeX8HXk3RPHJl8qh9bEltssWme22uG0cnfwYpaEmJtiq9/OPnXjAMf
         rAjLDGrIJ5gBSwb/4i3YnxfZCayJ910dtxp8F5g6VF9Cs3t4PMP30LMdqFrJ1nUOSdvP
         XSUmsqK0KFznmhthc3KFRUcZx/EFlQvVUyg6ALa7x9hx5cHUg/WcqRZ+faXn5utt+ZOl
         UFT8isp0CBX/YhYRJ85FsGZJ3owygGAIi8l+P2FRg4D7an8DWs0sou4JhjyNce1ghtmC
         emAQ==
X-Gm-Message-State: APjAAAVNEBbGyNpQYNf9M/978UTcuB20//Suo3Sg4CJECuzCmxInMLUJ
        +jlHiMdLC5DsXw3nQ1ScEzM=
X-Google-Smtp-Source: APXvYqzhi60ZA8pBUMOpA7Q5O/i+52Fm54ujejeqfbXfJdwFQBqaZlwX8Hf448W4XQP0ePWxsPbU8A==
X-Received: by 2002:aca:3006:: with SMTP id w6mr4486266oiw.5.1562785881206;
        Wed, 10 Jul 2019 12:11:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o26sm1001874otl.34.2019.07.10.12.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:11:20 -0700 (PDT)
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        dledford@redhat.com, Roman Pen <r.peniaev@gmail.com>,
        gregkh@linuxfoundation.org
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
 <20190710135519.GA4051@ziepe.ca>
 <c49bf227-5274-9d13-deba-a405c75d1358@grimberg.me>
 <20190710172505.GD4051@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <930e0bc6-8c5c-97b5-c500-0bd1706b32c1@grimberg.me>
Date:   Wed, 10 Jul 2019 12:11:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710172505.GD4051@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> I still do not understand why this should give any notice-able
>> performance advantage.
> 
> Usually omitting invalidations gives a healthy bump.
> 
> Also, RDMA WRITE is generally faster than READ at the HW level in
> various ways.

Yes, but this should be essentially identical to running nvme-rdma
with 512KB of immediate-data (the nvme term is in-capsule data).

In the upstream nvme target we have inline_data_size port attribute
that is tunable for that (defaults to PAGE_SIZE).
