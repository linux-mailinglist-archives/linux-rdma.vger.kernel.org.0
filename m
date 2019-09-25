Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C23BE6F5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfIYVSR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 25 Sep 2019 17:18:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38913 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438188AbfIYVQO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 17:16:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so220085pff.6;
        Wed, 25 Sep 2019 14:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=de3fbBGdSjAywgr/PB5IcxlvkF6ameBKH/JnVp6bWFg=;
        b=PqX0yeyfDbNHfvX8H4fgvxuQHXgHT+R7JMM0nWOhIRf2gtxXP9Fbuz1v9p6bgYY3qD
         RXyVlHreVru4KtWqK6nStMeYslesFlWS8TrleAT2U2+bL4a6m+iNkEfyVfBomL1QohKj
         R7Aer0R64kq4MuebZ/N8ytiYCJJ7CmyuxaB3ycnG4WbgcpugRqYxeHzeDgKcxnmjgJMz
         SgfeZKaUvuLtDonduKf8f8YCqOmWlTnQLrXS1HCBBrUObyi0t5yU0Mtqttwow9LQnFqK
         TgkUR/70gsILoBifI7J+0phGYMPJmL/WZA5B92I2e6BdTVL75JGjTg91y/Z2ZbaByrND
         4aHA==
X-Gm-Message-State: APjAAAUe4j7g7YpBWdS+GzNYxt/FM049GYD6tkrjzuYIh27xTXEcj7tk
        YzLQpbWNaU2czn3ZlPjCCOE=
X-Google-Smtp-Source: APXvYqyNjFPuJdsUXrt7xlRoloWvptMS5FptZ1aB7Hl1UY1rEKxym+yZkZyF1OrxJ2RTyxTPeYqazw==
X-Received: by 2002:aa7:8813:: with SMTP id c19mr297331pfo.101.1569446173633;
        Wed, 25 Sep 2019 14:16:13 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id k66sm21530pjb.11.2019.09.25.14.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 14:16:12 -0700 (PDT)
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
From:   Bart Van Assche <bvanassche@acm.org>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org>
 <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
 <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org>
 <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
 <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org>
Message-ID: <cb7b2fb2-662b-cb20-fdd0-8822eefd9f32@acm.org>
Date:   Wed, 25 Sep 2019 14:16:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/25/19 2:08 PM, Bart Van Assche wrote:
> On 9/25/19 1:50 PM, Danil Kipnis wrote:
>> On Wed, Sep 25, 2019 at 8:55 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>> There is plenty of code under drivers/base that calls get_device() and
>>> put_device(). Are you sure that none of the code under drivers/base will
>>> ever call get_device() and put_device() for the ibtrs client device?
>>
>> You mean how could multiple kernel modules share the same ibtrs
>> session...? I really never thought that far...
> 
> I meant something else: device_register() registers struct device
> instances in multiple lists. The driver core may decide to iterate over
> these lists and to call get_device() / put_device() on the devices it
> finds in these lists.

Examples of such functions are device_pm_add() (which is called
indirectly by device_register()) and dpm_prepare(). Although it is
unlikely that this code will be used in combination with suspend/resume,
I don't think these drivers should be written such that it these are
incompatible with the runtime power management code.

Bart.

