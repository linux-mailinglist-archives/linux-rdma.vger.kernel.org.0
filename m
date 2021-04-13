Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2735E05D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbhDMNnO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 09:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhDMNnO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 09:43:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABBEC061574;
        Tue, 13 Apr 2021 06:42:54 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w10so11959852pgh.5;
        Tue, 13 Apr 2021 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1DLw43rm7rrtnsd7xeB6oJxIf0vuC8BRRHLBczry9Zc=;
        b=XBw1SnKtlH/nY/NSd8lv+UTtZIYT22fK1g+iq3vMFWv+AH/MpKYwjhZlq2KTZV/K3c
         SfjE785zPofXoND9v8ZRuLhGGbbzPrxhVNN7Zsz9aIaVi8yx0rRoGp4j6Wv6gOILQQoi
         Y1pMuolHJt/QBG0KUctaw3Fl93DhvbPYmrbGptwE5PsQgI9bFRxNtheQiQYfyzTkfUDh
         ooAElLYg2sjOcYLM0FJJnY2/Ikx/1LGBdZLi3dX3mGePQf6/L3wp2ul/MBuxNCq90Oei
         7s7K8DIT8NjNYIZ2vyQcvcnIqNfiU5iQ3OSo9GhoccaMyVI0qg+t70VzjjQokVCc9xKT
         njqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1DLw43rm7rrtnsd7xeB6oJxIf0vuC8BRRHLBczry9Zc=;
        b=Csfj1HIHNgTCjcn3M/9WrmX73X8vj7OwsEOCcMmeB/6Cyh4Hshex60Yu82NT2iQXeR
         h2N15Tx4rREHpNqw8Tyk4KJD44UHzAGDpKL947OVMKrylK6mm/isw5BNsXv9uG8yZZGK
         D8IKeICUYFnOHlXBDJvEYCz1moAq9PaOD2UvyZCoSI45D3lKcEOumXCZkCTFRHnTWiRy
         d0LTStgoV702BNe+GS0ABshsvYtGTw5jcpKM5YFnHBwOnUbErQYcIxjuSv3skmtyRSqy
         7eOn70HJ2McFuYzL87xBmQqf08XVLcr7pc+oMLOYO9645l6xp8r6LehAueamUhdqa1om
         DAqQ==
X-Gm-Message-State: AOAM5319PdkFLVm7Bukw0I2ZBmIXjaCU2R0i86ghrwzBUMVNG/5mc0We
        5aTyvtMQf8MLaJKeD/nxaBJa/QlQRumtgazeYT7OYVomPRG8JMs=
X-Google-Smtp-Source: ABdhPJzTVa6KlpBwT37FoxqE+zx2hutEJio46lArlk4uAKSiJykOT1TU9ZdwRqvJGvhi/uF7b7XgKt8xz1EqCAC6RJI=
X-Received: by 2002:aa7:88c6:0:b029:250:bf78:a4a3 with SMTP id
 k6-20020aa788c60000b0290250bf78a4a3mr2799678pff.70.1618321374154; Tue, 13 Apr
 2021 06:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
 <20210413133359.GG227011@ziepe.ca>
In-Reply-To: <20210413133359.GG227011@ziepe.ca>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 13 Apr 2021 21:42:43 +0800
Message-ID: <CACkBjsb2QU3+J3mhOT2nb0YRB0XodzKoNTwF3RCufFbSoXNm6A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason Gunthorpe <jgg@ziepe.ca> =E4=BA=8E2021=E5=B9=B44=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 13, 2021 at 11:36:41AM +0800, Hao Sun wrote:
> > Hi
> >
> > When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
> > the Linux kernel, I found two use-after-free bugs which have been
> > reported a long time ago by Syzbot.
> > Although the corresponding patches have been merged into upstream,
> > these two bugs can still be triggered easily.
> > The original information about Syzbot report can be found here:
> > https://syzkaller.appspot.com/bug?id=3D8dc0bcd9dd6ec915ba10b3354740eb42=
0884acaa
> > https://syzkaller.appspot.com/bug?id=3D95f89b8fb9fdc42e28ad586e657fea07=
4e4e719b
>
> Then why hasn't syzbot seen this in a year's time? Seems strange
>

Seems strange to me too, but the fact is that the reproduction program
in attachment can trigger these two bugs quickly.

> > Current report Information:
> > commit:   89698becf06d341a700913c3d89ce2a914af69a2
>
> What commit is this?

The latest commit in the master branch,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
