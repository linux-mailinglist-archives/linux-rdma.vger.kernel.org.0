Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2CEDDD58
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 10:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfJTIsx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 04:48:53 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41844 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJTIsx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Oct 2019 04:48:53 -0400
Received: by mail-yw1-f67.google.com with SMTP id 129so3807917ywb.8
        for <linux-rdma@vger.kernel.org>; Sun, 20 Oct 2019 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbIx6CHDAefJQsTHRHtiy5rd8wPV0RDXlZA/M+sT3qk=;
        b=CVI9xl2cnQ0zRKGGXcW4ZO5TgWPb30PtGk3uDFVf9MkF2MOSF2VyQYlv6vfmsK6zW+
         21t+Vf2Q2kSQDDghS9eh/HSCXyAUhKFGqKUQaX5BG46O+Jtd6qYpM7kWEgTQ/t7xriOE
         ZGkd7X4w6AeepqSmxqODJJLMVFPB8JD6T2gthWOLTSqaFSzLnqU/7JnDuUITyVQFWbvi
         izTPPNICn9p/vsdrSYIRGWuD8LKnKLT25ksnDyl6owa2fo87YwMlIS70hjQ+C3+Veb3a
         TnEhYc5QD4hmrdmfrdhTMLb12P4CknexGIr/MO7biM1HoEjA7TN52x4e5n9Kxg0MXnnc
         ueEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbIx6CHDAefJQsTHRHtiy5rd8wPV0RDXlZA/M+sT3qk=;
        b=Vw8cvfNc95dZjwW/K/G7D/nYk72FUr+JU+Gla5lFl+FVFyR1JfXoDZLRfD0NY+kusF
         kK5DoZfN8bvaY47itz+AE+AMd10RsvbGzVdBBqVB6WhbeoJLf/PgGeVYmdULobonod8D
         ySpd/ps7WAX3keL3oSjeb31wzkYCU5o7ZvEUHDGXPK4F7bRRcs15npdmL83BsKA1fwul
         WcPKo77wGjDIsDk60GfP14osaQdsYhtVhnagGoGFm8Dm/eFxwNRtu41ee4qCRd9BfXKU
         rLdtO+EqyOr5E59wlHpaSXtKdKw/XiWitVSFA8w6EZwD9+aPVFd4y5ZrWYvPzpVxghIj
         teMA==
X-Gm-Message-State: APjAAAVDIVMF84ucaioOVgwvhOvXKgDxPBQrrFpQNhoz97Y6odvhd2oB
        Zv+l8An6Ob15XFpqPFjDBqvqdbC+oqXaw2YFbTg=
X-Google-Smtp-Source: APXvYqxEQqTybHDIMxbAjBQ9pdx0d7WgWwHXjNkF5a/8+Xt/ZvB3j+RgLxZuOL/O+o+JqpytPzHx/nVG6eArTu/QeXA=
X-Received: by 2002:a81:242:: with SMTP id 63mr4530517ywc.73.1571561330612;
 Sun, 20 Oct 2019 01:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191020071559.9743-1-leon@kernel.org> <20191020071559.9743-5-leon@kernel.org>
In-Reply-To: <20191020071559.9743-5-leon@kernel.org>
From:   Or Gerlitz <gerlitz.or@gmail.com>
Date:   Sun, 20 Oct 2019 11:48:39 +0300
Message-ID: <CAJ3xEMjmTnmdzaUoHreZVYyVMxwKi6W9qOGsweisO1uyzfVnKg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 4/6] RDMA/cm: Delete useless QPN masking
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 10:18 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@mellanox.com>
>
> QPN is supplied by kernel users who controls and creates valid QPs,

AFAIK this can also arrive from user-space, agree?

> such flow ensures that QPN is limited to 24bits and no need to mask
> already valid QPN.
