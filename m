Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09994175D57
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCBOhy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 09:37:54 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37143 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCBOhx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 09:37:53 -0500
Received: by mail-io1-f65.google.com with SMTP id c17so11757478ioc.4
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmChl07tCnnnsdQkbYOcsmPILzyShLh33qBmgjXyxkA=;
        b=jWhtjW8byNV5i6zYn7TLRszuxZRXo+KsJDCRQNqMJxy4mxFW6SnjBqFPbllWCdiz1Z
         vSZtoEf4aWL9hhjLep45IC4+bNTaq9pt5eKC+7nuCeFX4LdBjvaVVZYOKBto5dDPmc+T
         ApyO6v+VFuYhFl9pSTY5dcurg8VNvxgwjDPcQQzBC3ydlusa+PlxEggxirhemmvaspww
         fJvqe0xyjFt8IX75KsbYqUodLnB1+D7tUCfuLt7iLqbBoM1gvEDYAArmW/dIVo6votI7
         onnLTrXtd0ivQoMl0j1nvFrpMKbS4PY52CbGZ5FhNEgTkJ5KFzYSyzINWwRgMG06rjZi
         mncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmChl07tCnnnsdQkbYOcsmPILzyShLh33qBmgjXyxkA=;
        b=uAlDMOOoZxYwLvtAN4a8Ex5con3e+UhhPcJallC3ZLi3wuqvvhQ21LmfPw6VBnyrPl
         l7JKjQzgvpMccJ2DnehAjjqYJkKD0IIr9suSJxb/kcLVRiUm6/hjSIhyWbeLFBVbZtHC
         W4sdn14i+eNEMoeHl8Z2gNDBkUkh7LrSBjzVx9oAigdyjJ1wK7M6oHgEi1eS3rzQL51O
         ZpStmjvagiblVV6dJA0/8mLiHp9364mwf08SOU2VqWkp6MYiEGXgOWZaX43GVx+pVtJi
         pAV+yk43UMgRDpfjWF0LEJ5m66kvBnPmIeVjnVtHVTKfFwcECnL7ALTmnBV7c3EcFEgb
         Yysw==
X-Gm-Message-State: APjAAAWvo7Xh5wXdsWIHs46KSYHxAJQ+yVJtUQTOYQgpChdanQjq14HI
        0srv39ZpEYHhjuCga4bBhHsoppvRaijMBFfwA2w7Qw==
X-Google-Smtp-Source: APXvYqwpTrVreRlhOJstucnPx7hIH1xJIKArYs7wGfkg+h8SN/KzbOrQMY8TYI6vLJO0hKUh/OE4DxkfB83yk2X5bx4=
X-Received: by 2002:a6b:5a06:: with SMTP id o6mr12550360iob.54.1583159871960;
 Mon, 02 Mar 2020 06:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-2-jinpuwang@gmail.com>
 <8131773d-cf6e-9c1d-faad-a250f7135432@acm.org>
In-Reply-To: <8131773d-cf6e-9c1d-faad-a250f7135432@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:37:41 +0100
Message-ID: <CAMGffEn5tPDCsGZNMO9wZE6RGJ+VKM4mTp4ynjW13CKrv+Fh3Q@mail.gmail.com>
Subject: Re: [PATCH v9 01/25] sysfs: export sysfs_remove_file_self()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 1, 2020 at 1:24 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:46, Jack Wang wrote:
> > Function is going to be used in transport over RDMA module
> > in subsequent patches, so export it to GPL modules.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
