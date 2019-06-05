Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1636853
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFEXrD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:47:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34006 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFEXrD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 19:47:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id z24so299005oto.1
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 16:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F6vE5BlUHGBhD/Firq0EgqUSRQ2/R4FdT9tBRt+8VME=;
        b=KzyqY4gS7oJuRCfqDpImfL/VacZcIgesBKbdFvJA1XCjbaAWxMxT/8YwHLJpb2yFb0
         /q71l3G2KClwFyuiHbauRj5F1a1PrnxQqeNgEK2UgNmbUqd/oLN/ttGQyP276tAS1Z5G
         185bIFy24w2Ygm1Wd9MeXofH1QsTjbWuIogGtcHJgRvw6yWn0VufCFZwKFa7DOj452Ko
         Vi3ZWyNcN7M8FDFscETWtB/hE4pp/6LQ65TDr7NX+hQ7Q7MkfGfX6TQIiI7z8q3XMp8+
         TwR7c1ZUvneAXqwujX2Ls8RjS7ty44Y1HrheIRkneyHcFL/q/oC6aDwGuUAOROrCXpCJ
         irmg==
X-Gm-Message-State: APjAAAUg4u/PyDzxhdJaj7DBAH1VHZUSjSuRBOAaCZ1XZ6FVtyW5Ab+m
        f/KJeI9rUFZhqt3z73jb3yCxaZvD
X-Google-Smtp-Source: APXvYqwUUpr7Uo3lEQ15MpQJPG1TQtjMejqAIQkxBOgFVOr0fsnjwuXVuEOUWIhH2n+3w8OXoVL7Og==
X-Received: by 2002:a9d:2f41:: with SMTP id h59mr11945400otb.359.1559778422785;
        Wed, 05 Jun 2019 16:47:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id g8sm61616otj.49.2019.06.05.16.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:47:02 -0700 (PDT)
Subject: Re: [PATCH 16/20] RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
To:     Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, bvanassche@acm.org, israelr@mellanox.com,
        idanb@mellanox.com, oren@mellanox.com, vladimirk@mellanox.com,
        shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-17-git-send-email-maxg@mellanox.com>
 <20190604075336.GS15680@lst.de>
 <e67e80cd-a2ed-b76d-21c5-1189b682b7fa@grimberg.me>
 <bae07b08-6712-3e97-7d7d-8e8c8187ef08@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <17b1f92d-c53e-9942-b757-d02b0d1f4af5@grimberg.me>
Date:   Wed, 5 Jun 2019 16:47:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bae07b08-6712-3e97-7d7d-8e8c8187ef08@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>> + memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct 
>>>> ib_sig_attrs));
>>>
>>> Why do we need to do a struct copy here instead of setting up a pointer?
>>
>> Yea, can't we use the mr->sig_attrs directly?
> 
> No, the MR is internal to RW API and the sig_attrs comes from isert. I 
> don't want to loose the pointer I've allocated. it will cause a leak.

Yes, that makes sense Max.
