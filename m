Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA8F4ACB8D
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2019 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfIHIZE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Sep 2019 04:25:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46791 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfIHIZE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Sep 2019 04:25:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so9824055qkd.13;
        Sun, 08 Sep 2019 01:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaQ63NtAxqwHK4xTDUWbmOw1jK7uOrCrWnm8XarMV5k=;
        b=g/cg51IZZ0klTptjL9fCYAM5Lj0TQcwmItZJrz+szF4P+zgklxigRdxsGI392qJpQB
         DLfyoMllILkUpEhK6ioZ86krV2uNrhH+0Eiy6TCLHz8H2d30FNnXzL7ZOJ9EYpEpVegd
         pNzF8dd/49yeUaQYPHkH9VtcG0SI7OlViyKwv4PfmMOPgnZ955LaRsSD7Llneu3YjKuU
         C9x0kxE2UwPja5h597u9S9UKxa530wP3sHgezuILJ7Q+s4cjB0DJ9zciACIxMbNn3MQs
         UoLSTROwnLbkmkV9n5fqMObHXU1fxl3sSZPUhMCD3jb21PfR/8Q6mIJEcCIOcsxCVRME
         O5qg==
X-Gm-Message-State: APjAAAUEKl1mZZ+BAaU38J8jsOqdlfatq1oGAfNbvkDoRcqYpp1tiPlV
        /PjFHyTtWSM1m9Q5/SEFip7y26XVHC9kxaPRt40=
X-Google-Smtp-Source: APXvYqwqFALvmetqBzu/1tm7tKbbZp+CVEOqVcsvvWtKSZ29qdhHzMFKWbuSMAMIsD6eeaGkqnHTpOL8S6V6d6DoGFc=
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr17267142qka.3.1567931103659;
 Sun, 08 Sep 2019 01:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190906154243.2282560-1-arnd@arndb.de> <20190908081022.GD26697@unreal>
In-Reply-To: <20190908081022.GD26697@unreal>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 8 Sep 2019 10:24:44 +0200
Message-ID: <CAK8P3a2Rbn=of3=1G9kfmL8ZJOJriCAk-M6xy6u3K82PykVUFA@mail.gmail.com>
Subject: Re: [PATCH] ib_umem: fix type mismatch
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 8, 2019 at 10:10 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> On Fri, Sep 06, 2019 at 05:42:37PM +0200, Arnd Bergmann wrote:
>
> I had slightly different fix in my submission queue, which I think is
> better because it leaves length to be size_t.
>
> https://lore.kernel.org/linux-rdma/20190908080726.30017-1-leon@kernel.org/T/#u

Ok, I'm dropping my patch from my local test tree in favor of that one then.

       Arnd
