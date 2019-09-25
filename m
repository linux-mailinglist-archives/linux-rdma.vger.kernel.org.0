Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C1BE6E6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 23:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393596AbfIYVId convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 25 Sep 2019 17:08:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33234 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390506AbfIYVIZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 17:08:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id i30so10328pgl.0;
        Wed, 25 Sep 2019 14:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hhty3hfj9co1W2Y1zwU/Sdv8qgF9FQVBpAsoOtDHETA=;
        b=q06TUdVdSIiZyyCqfBOLNhaM+DZ2v0b9mpVvdT2y82yLxMQ0Akl3D+BvyWVVKrJWZZ
         JkBYTDVIvSEVl3lSFh3oyVBqnCflCthFOed7cf6NI6dXOns0gRl19yNMfnr3+yXc7Oc/
         +NTuqKB1RoiSAkuC+ukN+SJdmQtm4UBF/Rd2JhfqjY8TF2mDHdzMKC/wx0YzEcClH10o
         Qh0eaqUYuEWBlRFDVs4AOCrKme5XjqaB/Wv5HXTPAw11r8jpMb2x6Yz7W1hLQv75b+QG
         dtiDSRn4p/gns49pWB8IduAf6D+PdCYQ1QgPWNkjjqT/OyClZ2X16G0AttjA4SFM09iK
         sGdw==
X-Gm-Message-State: APjAAAXNTXm5rnUyIXGbITYhDZEa3JbHsGcE9X22kLaNILQnKHaUMljs
        WQbGJlJHhcgC0OYg2yRwcRs=
X-Google-Smtp-Source: APXvYqwE0sf24k4ycy1RHwGwXSheoMpVcNG9OT4khU9O4siT+DT64MTn7z8SJC1CqQAfxtY7ANciHg==
X-Received: by 2002:a63:31d8:: with SMTP id x207mr1349193pgx.428.1569445704537;
        Wed, 25 Sep 2019 14:08:24 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id v5sm6773224pfv.76.2019.09.25.14.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 14:08:23 -0700 (PDT)
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
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
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org>
Date:   Wed, 25 Sep 2019 14:08:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/25/19 1:50 PM, Danil Kipnis wrote:
> On Wed, Sep 25, 2019 at 8:55 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> There is plenty of code under drivers/base that calls get_device() and
>> put_device(). Are you sure that none of the code under drivers/base will
>> ever call get_device() and put_device() for the ibtrs client device?
>
> You mean how could multiple kernel modules share the same ibtrs
> session...? I really never thought that far...

I meant something else: device_register() registers struct device
instances in multiple lists. The driver core may decide to iterate over
these lists and to call get_device() / put_device() on the devices it
finds in these lists.

Bart.

