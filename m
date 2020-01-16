Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4915113DE1B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 15:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgAPOyQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 09:54:16 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:46825 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgAPOyP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 09:54:15 -0500
Received: by mail-il1-f182.google.com with SMTP id t17so18331629ilm.13
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 06:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgyrYhMa/wdaQL5Cirrm7tGJXmXbD7bkOwfd7E43Rds=;
        b=Kj7gutjsLQ9UYZab36H6F+NHFFAsQkxciYGdVs3cFH+orpWwywG0KyGxIqVmMAhOpX
         YbTZcNryMnySNqvrxcbxLdDvI/osaNurfoQ5TdIJbBpueF35looQO/rr4vrf1VIawNs8
         N8g0Bt5zfnPyf9Xwx0I0G76FwbEF1yZheZF6Ip2WE7lMtddkBKO12fu9JPFdAET2Iyzk
         Z0Ugn5F/FlcciueVm9qb4Ac78IYBPfQj74E1Snl4DisX8tLCV6jcxI9LDhYIJ15ZeQ2r
         kha2cySOqQXVkmZBC60bV/B8BHzW7ofIvlnYLuLI1Xj/Da8sJ3qrphmvyfM1uk+I0hpE
         7CCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgyrYhMa/wdaQL5Cirrm7tGJXmXbD7bkOwfd7E43Rds=;
        b=DvWKzSfbpg3E0maZufGINWXWIqDmLQSCaTIudQTDFApof4J0dNui+dz/6SW7IOsZVy
         u4ZnuTwF2IryiOrM7fUjVfFACIzNuu8KiKAAX6gGdH0tw6BaMuYfe1MGdZJdfM5pNnoK
         JchX6gKN/CR7SPV1EVIyvsaEf4qAoOxz2qEz3M7GhQfWkZc82t6ZIratAO2Cgylv1PWh
         X27PctU7utNjSkrMJu9Z7Px6pr5wSDgUTnU9nOP3iW+OfWA7qnZl2T0kjfGKrPJUXhYr
         4k/hUdTxjH8fWTShtI9fJsZdsVRljJJ4iBTM78zFJ8oJl4UllDIVma7RFDsRaNVmG4ze
         4q4A==
X-Gm-Message-State: APjAAAUvz4Hi8oEv3Zr8p6So+c2DLCy6LCiyy26OlMdzkOFI1UJVcDmI
        3seW7n7YQehPo3B6bpCprgA2BpT5l1rZor9xt+B04Q==
X-Google-Smtp-Source: APXvYqzZHU1h+bHJy82S0s84ODkMbsXPrH1P3QeL5kMpJfkw63uJD8hB+9QzZr722BOZo+K6QQhfurlHZ3ZFW25DlfM=
X-Received: by 2002:a05:6e02:f0f:: with SMTP id x15mr3665714ilj.298.1579186454960;
 Thu, 16 Jan 2020 06:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-24-jinpuwang@gmail.com>
 <20200116144005.GB12433@unreal>
In-Reply-To: <20200116144005.GB12433@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 16 Jan 2020 15:54:03 +0100
Message-ID: <CAMGffEmaif+Gc-OT2Dmn+u06A3tryHA0bu52ekroHaixBFZKGg@mail.gmail.com>
Subject: Re: [PATCH v7 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > +obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
> > +obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
> > +
> > +-include $(src)/compat/compat.mk
>
> What is it?
>
> Thanks
quote from Roman
"'
Well, in our production we use same source code and in order not to spoil
sources with 'ifdef' macros for different kernel versions we use compat
layer, which obviously will never go upstream.  This line is the only
clean way to keep sources always up-to-date with latest kernel and still
be compatible with what we have on our servers in production.

'-' prefix at the beginning of the line tells make to ignore it if
file does not exist, so should not rise any error for compilation
against latest kernel.

Here is an example of the compat layer for RNBD block device:
https://github.com/ionos-enterprise/ibnbd/tree/master/rnbd/compat
"'

We will remove it also the one in the makefile for rtrs if we need to
send another round.

Thanks
