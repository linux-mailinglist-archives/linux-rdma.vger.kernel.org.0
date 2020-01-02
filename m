Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF35512EA2B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 20:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgABTLs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 14:11:48 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53247 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABTLs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 14:11:48 -0500
Received: by mail-wm1-f41.google.com with SMTP id p9so6461557wmc.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=photodiagnostic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b04a7j6o6CGlwPdVHcIdhCl2spP0vHixHKPGjoTQ/yg=;
        b=PXwJwETtksJ24CFfeC+DebTr+sASlB7dYtp8sS18kb8di+50u9hypljiAZru0qY2Or
         cLfRKkprcH+wrjQlIiVWpNhYot7QfmAE1+MDwum1vu6qK8zTlYFmkRLucubSmoHOFs4Q
         v5SVCrYb5D4AQJtqwcyG4ooqHGZc2zvB/yYumkEEbIADy59/egfwixkxmZunvhbwAiqK
         ODF1mLSNeipZEhS6hU5w0Qk890Oucx/ImmJc1ZPSvW9Urr04e79DJOXxYSbhjg/U8SNX
         E3/eHRr+E5x0Ww/d0uk81tnasmOLEf0QJEiwMx5SWsmkCZB4pFIbcfaIjouM8orMoFTp
         NAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b04a7j6o6CGlwPdVHcIdhCl2spP0vHixHKPGjoTQ/yg=;
        b=dwiajKNp11khLHJ8HOzvpU78YeF6FOBqIj6/5KgZnbUgAzz4CtUi6WQn4aWeJuVHLr
         o4TuZKRmeeEZhiGGx6N4IsUyDOMv1fbjVT7jWtMy02FCRIVA+jbZnmk7uXh3Px1kDxnX
         nIftZdOVSC6Zk+afvz2KVXH6hLE2epra6j8Lt7hGofFGHwwCnoS/OSvbILg7PbP0mbj7
         ZCBfn1eTjJf/yd3SuvpTNqtcDttC9VyTqkntnaQ58pVYu6lcmEU0QZmhoDwnPa1T4qqR
         jvUtEfsdDGfzROzvQujICdfcPXwQRqXD/OjTe8L1ijOxOARbHSkB1XRd8xo6n0t9Ph/C
         vngA==
X-Gm-Message-State: APjAAAWp351P4kp62NpQRdlaphC7S8vkZRlWI29SDvHlAwhDo+E7zJWV
        xUjgrehXM+2G22ldcZkWoleApq3Oi+LCRV2ZEUb7EhwlKwEBsg==
X-Google-Smtp-Source: APXvYqwNyNtSo7nKFROsY5vfPM6yBK8Xu/olvM/A6a7qwq5ZiieK0+YJCIMhOhv7MoGN64s6RJvPD5Qjry0EnfvewXM=
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr15722142wmk.50.1577992306450;
 Thu, 02 Jan 2020 11:11:46 -0800 (PST)
MIME-Version: 1.0
References: <CADw-U9BHcoHy3WJ8iSdYjAw3RxQf2vhkOKyL7k0yJdR3mP7Mug@mail.gmail.com>
 <20200102182937.GG9282@ziepe.ca>
In-Reply-To: <20200102182937.GG9282@ziepe.ca>
From:   Terry Toole <toole@photodiagnostic.com>
Date:   Thu, 2 Jan 2020 14:11:35 -0500
Message-ID: <CADw-U9BTH1-2FztrKnC=tTTH93wOZg3FM2qJgjneNz-6-kywiw@mail.gmail.com>
Subject: Re: Is it possible to transfer a large file between two computers
 using RDMA UD?
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 2, 2020 at 1:29 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jan 02, 2020 at 09:47:06AM -0500, Terry Toole wrote:
> > Hi,
> > Is it possible to transfer a large file, say 25GB, between two computers using
> > RDMA UD, and have an exact copy of the original file on the receiving side? My
> > understanding is that the order of the messages is not guaranteed with UD.
> > But I thought that if I only use one QP I could ensure that the ordering of the
> > data will be predictable.
>
> It is not guaranteed to be in order.
>
> Why would you do this anyhow? The overhead to use RC is pretty small
>
So even if I am using only 1 QP, it is still not guaranteed to be in
order. Ok. Thanks.

The reason I am interested in doing this is that I am working on a
project where we
want to transfer data between an FPGA and a computer. Memory needs to be added
on the FPGA side to buffer data for retries when RC is used. Adding
memory makes
the electronics on the sending side more complex. If we could transfer
the data in UD mode, it may simplify other aspects of the project.

Thanks again for your response,

Terry
