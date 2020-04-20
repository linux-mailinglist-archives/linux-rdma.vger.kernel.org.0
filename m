Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB18C1B01D2
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 08:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgDTGvl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 02:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTGvl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 02:51:41 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E6FC061A0F
        for <linux-rdma@vger.kernel.org>; Sun, 19 Apr 2020 23:51:41 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b12so9726884ion.8
        for <linux-rdma@vger.kernel.org>; Sun, 19 Apr 2020 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9C3JrepzlEGKADW5HtDCdCafm4wqGu05lhff6+4aJMo=;
        b=Z5dWzW6BfU0AxZMGyd/x/5DWnIt79HKY/2Ig+sWHu3mNttFNGXQUsMaT11ArAmgRYy
         8wqw3/tKMcLttzqIX+rs0RFmqYsj9b40NBk9SwU8c/QkeRJPAmBoRXEXbWHkqwubRnAL
         ZXvkI2tF1yjqERyVlJlzSQQsnqAJ92+fDx9AqV16TPYjnAA6A8ebQxEGVY4bdzwqlF5x
         mpyy8zOJRiXZF4dpK73XfREd7q5bIX19jR5j4RE+u4QdoS16OQBLqw5A2aPYZpxKGH0N
         bVZooo+1yWSAmuiCBOb/QbDjcnHkBoQf3xctjmFrDHVd9oz3dJBRUf/BXBUUiKcnit5D
         o02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9C3JrepzlEGKADW5HtDCdCafm4wqGu05lhff6+4aJMo=;
        b=Ct9lLkzCQGJh/qONWyfGZv77/Rjj4G+xIrh/zD4SjmZrrLkVyJELXf63k2fnEQ5Fty
         9myUfkKjfPKPlg32TVYpVyVQBM5s+Bfo4NtFIINsxdhdU519KV0/kZVJixYq8ApCeAsR
         Tv4wXom1kCHxJ2Tdc/TBmHdSk5VDWgl5juehRgf955MHDilVKRfIQ+SWry54UIficoNz
         ObYQ1Pauu6+0lKNZ+Zv4kQM/hixGd4rhVr41VdQ4gXCtqNoBY3LTa3x0wyn5WXmi8+/n
         +hoVGEN/okIeqNQoj4TL2cLriCa39ledJAItm/uUAfG1qVPdV5fDPJ8zU6sk88CqCjaN
         wh9Q==
X-Gm-Message-State: AGi0Pua2zDnakStSlczVIwVxvQTL0GniAhHDHWo/z++ojD+kGD5GKOyh
        8Qx7eAqJPw3wnJviJ0+TQlNDXd3ugr+33XwL4s3usw==
X-Google-Smtp-Source: APiQypKLPuWd7ZldCVfSRJfvL21fUUq92hk74PDs5Jvylw5blzaJclVs0sMWwxK36H6w5FLLtDy/Unj9IupikBxv29M=
X-Received: by 2002:a6b:b955:: with SMTP id j82mr14375012iof.54.1587365500541;
 Sun, 19 Apr 2020 23:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-16-danil.kipnis@cloud.ionos.com> <d972a2e2-a26d-fa24-d5ba-6beac2ee2b69@acm.org>
In-Reply-To: <d972a2e2-a26d-fa24-d5ba-6beac2ee2b69@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 08:51:32 +0200
Message-ID: <CAMGffE=ji5Qe+-9gbbTou-qxF54tFzt2FXQtsPEKUvJSi8=iMw@mail.gmail.com>
Subject: Re: [PATCH v12 15/25] block/rnbd: private headers with rnbd protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 19, 2020 at 1:01 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > These are common private headers with rnbd protocol structures,
> > logging, sysfs and other helper functions, which are used on
> > both client and server sides.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
