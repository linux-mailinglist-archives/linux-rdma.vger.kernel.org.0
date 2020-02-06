Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CE1540E6
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFJKp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 04:10:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35139 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBFJKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 04:10:45 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so5510084iob.2
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2020 01:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efu6JRqxHJ4upE4Nrs6EE1wRjNEsmSbS5KDCNaRbT58=;
        b=Jq2WiQPdVyDTTSH9foVLelSN/x2a2fBAovyfOfnXOqAHBJBucPZqvJiA75nrs6O7hj
         RJRqC7FaNUggmcDNCuBcWD6LJLGcgo6MkZjat1sugUNvQ4KwUm7kkpYsZHxXuBc8U3qO
         SFSqVL5dwKXZZfFGGGxVQgZDg9nES9481QHOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efu6JRqxHJ4upE4Nrs6EE1wRjNEsmSbS5KDCNaRbT58=;
        b=Wr97Xe3FF29fAqprnqlBBmGRZ5sxoQnCPr9OPlAot9PqfUgagcAZ8hj6UbFu606KGl
         vSyMee1+1XgFy9N5LalPyZ1T0KpLbgI6k43zrHi/gbq35unT53Ux+PoGxQ9z27SAkpmk
         qEBykJqYCj7J/CJQ2Ejsk4V/d0FYnZygfjaNQXFAW/B4va6VrX6YwRq7CSMqtk+LDvu2
         9wvdBONShHy5NPodpZJW+y8QoXMI8kNusC4u2lQxxzXlsaDqaw2NB58EOeNUFX6mH81A
         48ebGZ5e113Z9U84HemL8dAewIFnnm7gDydp/si1B/76U5sZrN/SOqKHPzENHgqBrrVN
         WhjQ==
X-Gm-Message-State: APjAAAX3LFPP/EwiDtQDCxxMzZ/wTZRdCsJnVH/Qe/puUaorIJPIv1Jb
        /FYqV+naqHAXxVsi8RiPxdW3k5WrWXyIIl/ZqWGhZA==
X-Google-Smtp-Source: APXvYqzYal5zZNLoqExDcioLn4TGjRBa/iRfSn+muc7eniCWX07ju8VVqscVqWUepJRavjNxAU59/JDpaDWkt7mo5Zw=
X-Received: by 2002:a02:13c2:: with SMTP id 185mr33552532jaz.0.1580980243192;
 Thu, 06 Feb 2020 01:10:43 -0800 (PST)
MIME-Version: 1.0
References: <1580967842-11220-1-git-send-email-devesh.sharma@broadcom.com> <20200206083807.GD414821@unreal>
In-Reply-To: <20200206083807.GD414821@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 6 Feb 2020 14:40:06 +0530
Message-ID: <CANjDDBj8L_aj=qeyBo9mqR7JnRRF36O4B9B2P0xueRjaZvAMUg@mail.gmail.com>
Subject: Re: [PATCH v7] libibverbs: display gid type in ibv_devinfo
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 6, 2020 at 2:08 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Feb 06, 2020 at 12:44:02AM -0500, Devesh Sharma wrote:
> > It becomes difficult to make out from the output of ibv_devinfo
> > if a particular gid index is RoCE v2 or not.
> >
> > Adding a string to the output of ibv_devinfo -v to display the
> > gid type at the end of gid.
> >
> > The output would look something like below:
> > $ ibv_devinfo -v -d bnxt_re2
> > hca_id: bnxt_re2
> >  transport:             InfiniBand (0)
> >  fw_ver:                216.0.220.0
> >  node_guid:             b226:28ff:fed3:b0f0
> >  sys_image_guid:        b226:28ff:fed3:b0f0
> >   .
> >   .
> >   .
> >   .
> >       phys_state:     LINK_UP (5)
> >       GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> >       GID[  1]:       fe80::b226:28ff:fed3:b0f0, RoCE v2
> >       GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
> >       GID[  3]:       ::ffff:192.170.1.101, RoCE v2
> > $
> > $
> > $
> >
> > Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
> > Reviewed-by: Leon Romanovsky <leon@kernel.org>
>
> Please don't add my Reviewed-by, before I explicitly wrote it.
>
Noted!
>
> Thanks
