Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C19B2905
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 02:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbfINAAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Sep 2019 20:00:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46083 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbfINAAO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Sep 2019 20:00:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so19034574pfg.13;
        Fri, 13 Sep 2019 17:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j2n2CYJQ+wWs3A9XKyhuQT+gCv9bgNheQuxHK3HuVBM=;
        b=mNbnZYTYngz5XpnsLcbZj7b+V3axOFK3g65+MgfoJIQ361e7EmdzcCCLpsg5PgdESc
         w/ncaPckz5fHauHkFKu6nfKwjtC9zC9OnOWfZtyWwTQp7TssFv05EOzmXg3W0Tu2ARUi
         fan5CH08dZch1yAOSVAeEzvkdBPvewCQg94Yn3PrtY98yBOHJ2s2hrRmtD2exjW1D+cL
         NDuYK5Rh1I0+l483rEd2FQVTPfnbu1itftyWGsvgbrbTSPlaTSKFx1r3q9eGji1TC9qH
         hJEYa0+Dk+blvceMmagihJfk6AVzWA3wtXlBDjsCSqmiFdh0RztWnbUz8RuaQnutKbr9
         05Qw==
X-Gm-Message-State: APjAAAU5u0fHu44KcT2R+PNslERA4FvxEGNrAajO46Qy0ksQJlMs9JxL
        i1qg7RswLAQNql/z4YdcAxI=
X-Google-Smtp-Source: APXvYqx/j4WwzYf/D5Dv9AnkZ9sCVuQxSHeAXQxVVVGM7uEh2xUdZ5ubulHqBo8Aob4FPOYdp4lsWg==
X-Received: by 2002:a62:e216:: with SMTP id a22mr5278118pfi.249.1568419214173;
        Fri, 13 Sep 2019 17:00:14 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id k31sm3238177pjb.14.2019.09.13.17.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 17:00:13 -0700 (PDT)
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-18-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ec0f9bf2-87a2-27f6-5178-1d12a0c13b09@acm.org>
Date:   Fri, 13 Sep 2019 17:00:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-18-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> From: Roman Pen <roman.penyaev@profitbricks.com>

A "From" address should be a valid email address. For the above address 
I got the following reply:

550 5.1.1 The email account that you tried to reach does not exist. 
Please try double-checking the recipient's email address for typos or 
unnecessary spaces.

Bart.
