Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0021C3C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2019 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfEQRK4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 13:10:56 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:45965 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQRKz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 May 2019 13:10:55 -0400
Received: by mail-io1-f46.google.com with SMTP id b3so6025342iob.12
        for <linux-rdma@vger.kernel.org>; Fri, 17 May 2019 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1swqt5fs0EGXVDh7hKlflA2AsyKj7YMZZLZ6ABlYgc=;
        b=nczyohcuTcTlcyT++tYXzEA1HWVF1Lq6QMpauV7U5yy5zTnFx3Mat4tE+SqQefW5nI
         vbeiTpy9yKJMP7TLqmJw8vNNiZJZu8+eMEtGca5hXBbjk/5F2aG6B46ifsxbJpPethzc
         b6vngDkxaHeysCZjEA0zJYsNWn9whZHv94dF/k2auvkeQ06MjESYIszcIupCqTC4B7pZ
         oeClbohWYgTD0Q1qUVLBGbDabW2Ls15XvuXKJIGUWUbbNZd93N70lBrURM6jjMf2wekd
         /me6hnHmSzypY/VixdHRVwiRzQzo9DhShR3dbmV6zK9MooCl+gpl3ZJF5VPPHx+OPf6F
         meMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1swqt5fs0EGXVDh7hKlflA2AsyKj7YMZZLZ6ABlYgc=;
        b=hWMOwCU1IuYkhg8mphD10eS4evm8BwhTr9Xa35xkrepbmsA2UbnQq/SYH6tRnwjmrw
         fa4rzi93gcS/4q3uoIL01Yh7IQCo9M04mmpk2wScg4+T6MKsh5cKGS3V8R8I12gJnsmr
         oXD/NvdCO/b8CzmMx8ZPLagIpJGF/5Fs/aprq8ADzv/QlX/h3HDvejwacH/ReuQayY4r
         mQFneFqztbJantJnFMiiLey2CNkcH32w4ZEipEKBbPQ5yRi4ARJAUAaKRCcsCSIbf8Sh
         ySuUA92ePoSc7BFzKVS4eQYMukFIT6HUb4JJF8bb3ThDOR4XWwM52jrrJ4tLND6aHobL
         VQxw==
X-Gm-Message-State: APjAAAX0F7oZbbwS96ESaMdX2PaJoAh7CVgp2CvrAuA1ehf9p+NT6lrK
        TYamMUMKAQIFgC306+DsjB2xCCOMZviwFeacB5ZulQ==
X-Google-Smtp-Source: APXvYqzsbBeNSDPkwmVLWjriL7I0sRlmj1iOFa1x0tOVfgx7AEhlwvwXP8xWDRTwnwSWDbdv71STFSHWmONlktbKrKI=
X-Received: by 2002:a5d:9c55:: with SMTP id 21mr14168947iof.123.1558113054953;
 Fri, 17 May 2019 10:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
 <1774023a-1767-9884-7322-281e6873e167@oracle.com>
In-Reply-To: <1774023a-1767-9884-7322-281e6873e167@oracle.com>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Fri, 17 May 2019 12:10:44 -0500
Message-ID: <CADmRdJe5fzpMN71U_8fa6Wm81_2ZJdPrTdj+dhk1SsNGx2zG1w@mail.gmail.com>
Subject: Re: rdma-core debian packages
To:     Yanjun Zhu <yanjun.zhu@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 17, 2019 at 10:42 AM Yanjun Zhu <yanjun.zhu@oracle.com> wrote:
>
>
> On 2019/5/17 22:14, Steve Wise wrote:
> > Hey,
> >
> > Is there a how-to somewhere on building the Debian rdma-core packages?
>
> Which rdma-core version do you need?
>
> Zhu Yanjun

The latest released version + some changes I've made. So I just don't
want the pre-built packages, I need to learn how to create them from
the git repo.  I know how to do that for the redhat packaging using
rpmbuild for example.  But I've never played with Debian based
tools...

Steve.
