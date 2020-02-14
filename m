Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B285A15D19A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 06:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgBNFZ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 00:25:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45076 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgBNFZ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 00:25:29 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so9190280ioi.12
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 21:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sa1JZm6HgM76QN7UtddnL08nm/7K67WJ2sqwNjqeS+Y=;
        b=YR8oGOr1DHhgKBsU0+BCZS5HelZ8YhJ79J5+HSuHcEdH7AxpJ6reG+MJ5kyyRTvmC2
         yszKbBgKNN1ZtjWdx++j6xzsPiM2+eaMZAnggNC7IMHIt/H4QsmM4bKD9ObFPW7VxfC8
         aEuZxPfBL6+6BugcyMw5mXzIa7M3736JFJjKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sa1JZm6HgM76QN7UtddnL08nm/7K67WJ2sqwNjqeS+Y=;
        b=gi5yV0MQMzhu/ZQap7XDz3lhOvgpxa4JFNtFNinmV0P5YOOFmjhMAN9CApEXQwuoUV
         4IPDaE6bdrVpcnEUcbjzZhl5O6xH67Jwt9D9wKz5q0LHjCt3h9NU4En2nzLJTE+WTJKT
         OHO7tN9s1HkG/mL6v+uAQ5kLhFoDv/jo8d7yFUWcUEfXiY6SEIGuxvJY6s4pP4PMn27O
         Hx9Mjuudc1nGsBwK7unwyPOHIkH1eAqDvVWzrXFGWDiKpfnzhzUeboTFB1cGBZINw7Uy
         yH0KedcVU3zaGXVYUfLol9OMz3ZSECzBmczwEi5/FIp7ymA3LEMuLky+M+/2BnhgwL3Q
         vASw==
X-Gm-Message-State: APjAAAU62F9Jv6LkMLmsQszXyWA9ffEonl9uZKK3lZ1yfXOVgdD4NYl+
        xTLo7MajCeKW3Wq/FvjgiA15SQ+4v2G9XFKCFJKxlg==
X-Google-Smtp-Source: APXvYqz75ALwdOaG6huQhDWNIv5HAMHBUF1OZAwmOGNhcGExaN9/2GnzQz2QoiDc4pXYrSCkRCuN3SrUEA+n/cb/4hI=
X-Received: by 2002:a5e:9246:: with SMTP id z6mr949681iop.232.1581657928709;
 Thu, 13 Feb 2020 21:25:28 -0800 (PST)
MIME-Version: 1.0
References: <1580407982-882-1-git-send-email-devesh.sharma@broadcom.com> <20200213201743.GA24648@ziepe.ca>
In-Reply-To: <20200213201743.GA24648@ziepe.ca>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Fri, 14 Feb 2020 10:54:52 +0530
Message-ID: <CANjDDBh_JTv5T7bdc=+ORtObi7qXDL1YzMpv_6CA40GK6JTXRQ@mail.gmail.com>
Subject: Re: [PATCH V2 for-next 0/8] Refactor control path of bnxt_re driver
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 14, 2020 at 1:47 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jan 30, 2020 at 01:12:54PM -0500, Devesh Sharma wrote:
> > This is the first series out of few more forthcoming series to refactor
> > Broadcom's RoCE driver. This series contains patches to refactor control
> > path. Since this is first series, there may be few code section which may
> > look redundant or overkill but those will be taken care in future patch
> > series.
> >
> > These patches apply clean on tip of for-next branch.
> > Each patch in this series is tested against user and kernel functionality.
>
> These don't apply to for-next, please respin them
>
> Applying: RDMA/bnxt_re: Refactor queue pair creation code
> Applying: RDMA/bnxt_re: Replace chip context structure with pointer
> Applying: RDMA/bnxt_re: Refactor hardware queue memory allocation
> Applying: RDMA/bnxt_re: Refactor net ring allocation function
> Applying: RDMA/bnxt_re: Refactor command queue management code
> Using index info to reconstruct a base tree...
> M       drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> CONFLICT (content): Merge conflict in drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
>
Oops!! okay I let me resolve this conflict and respin the series.
Thanks
> Thanks,
> Jason
