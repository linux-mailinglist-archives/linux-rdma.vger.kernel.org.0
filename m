Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82DA151D32
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBDP1d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 10:27:33 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35511 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgBDP1d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 10:27:33 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so16235507ild.2
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2020 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZbIwEbMqbQs3SQsx948duL3V5EqylGOcNfUq6G8l5I=;
        b=U47pO+bjKOpGCdcZoIRnvowDoE3DeTJcKP+n94qBZz1uIlHE9abbl767emwWRIVPkV
         4t9PPCDMAY0hKNRPJpEimmNbFkxu9vo/+UdwYajv4t+QTFjj+orVJbbSM2DDnGwUzCQU
         H67x1YshmBFz74BhmJCMNbqjBSITIi/EBkLDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZbIwEbMqbQs3SQsx948duL3V5EqylGOcNfUq6G8l5I=;
        b=hYE0a5PW6mvJmwoxR+earbuxG84i9jHF7HcBR5MvyyeHDPikp2GVWyeKrpeN8Wo+I/
         Hs2SCpCC828nfl7h9i6o1rMnO0oEhkhqKcJCwwUIQ7aCqmgVXT2h6z+SIP37bOoZrhV9
         DPDY334oEw+/gUrwJhcdd/YdCCD8C7Wl/pLCFW03pcyPkxVDAex4aMtwlFjAZGpu8D9p
         KkWgCtMVdH8w9yMK7KslT4uAqkKYm1xYN0Ki3sphnCCV2C0Runn1TTJ/wbQQTTDzDO+y
         9huQPLIBHynRmFiXiqyyyRAOb5bWWnB2uGMY9S3nCzxB/KgwxJI5wPsjtBboYKOUXAC8
         DDxg==
X-Gm-Message-State: APjAAAUKaLkMxDY/H4gmTdd5vIIf8O8nVXTxKmukyzrl4K7Z1pDjXAl4
        Gnek5eumZCYo0Lzl7DgxYenLjBKIHdeYwCblxVDvnQ==
X-Google-Smtp-Source: APXvYqw51B5z5n8gglrImlnICiGed0rER2xbdVL0dHNq4+cofyYstO4Y1FbNg2R998iGaUEKaMVsee7zbXk++ewVBI8=
X-Received: by 2002:a92:5d8d:: with SMTP id e13mr20696655ilg.285.1580830052078;
 Tue, 04 Feb 2020 07:27:32 -0800 (PST)
MIME-Version: 1.0
References: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com> <AM0PR05MB4866F91551DAE20160D39235D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866F91551DAE20160D39235D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 4 Feb 2020 20:56:54 +0530
Message-ID: <CANjDDBhY5EkJpk-_yv1gM76ZidLk92WHokq2nZFAUqOUH_Q-CA@mail.gmail.com>
Subject: Re: [PATCH v6] libibverbs: display gid type in ibv_devinfo
To:     Parav Pandit <parav@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 4, 2020 at 8:01 PM Parav Pandit <parav@mellanox.com> wrote:
>
> Hi Devesh,
>
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Devesh Sharma
> >       phys_state:     LINK_UP (5)
> >       GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> >       GID[  1]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
> >       GID[  1]:       fe80::b226:28ff:fed3:b0f0
> Showing two entries as individual raw like this is surely confusing to user.
> Either all content should be in single raw or as Leon said just single different format for RoCEv2 is fine.
Yes, I liked the single display in new format, I would wait for Jason
to agree/disagree and then send a rev.
>
> >       GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
> >       GID[  3]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
> >       GID[  3]:       ::ffff:192.170.1.101
