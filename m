Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF631033AB
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 06:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKTFWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 00:22:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40863 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfKTFWi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 00:22:38 -0500
Received: by mail-io1-f68.google.com with SMTP id p6so26200812iod.7
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 21:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtDomop1XIbD4p5986LlwVX8hAAI7jhNEtiui509l+E=;
        b=TI9VRVSDvgtk4b2j64ESNRFqoLzr93YJgj9OcFMs5blCDS+sZzzqR3m04EQWZYdECP
         P6HFTMm4rAKEO6S929CFWK+B0LsskKxBpH1pZ9JhtaXjYokepLzSaSulEvLp5l+eEqp6
         uhhjbJJSJL0D+2iKQAq+MXxQOTsBC3pX8bdck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtDomop1XIbD4p5986LlwVX8hAAI7jhNEtiui509l+E=;
        b=mGhq0Hymr8iYtBHO2p4Fj226BdtI4QmBdm1P2S8m6LG4ciVr4ozblySDhQpQNFvbql
         2Wo0/614Ih+BvZTgWPUXOXv7KLs6kEDsuHFy+ITMFDYqFlfhyOnj6R3oerSh5sc3uNeD
         VjWT3JxCc7tg5M54mZMrdpgdFX9FvIxkrMCnjC46dc7+lgKrhPR8mTw0U9KZshl1/mFG
         RwlSjZQKt3GWfChx1fk6cQfTRrHcBTvpW2Nb1T7nBmtcKy0te5PCzGUMZmy3TpS7PuHy
         n/bh/KuWXGdRL3oKOJlOWS6YYgdCnto8MPxh+k1Y7vWupbJYPHNkFJ/oj/KovFIRhymy
         hDuA==
X-Gm-Message-State: APjAAAXpKHZctmNrgZeIYtwquEhyqRLoS3pfxXPqlM5UW3mISbw27UAf
        irkIhtTS7WckbBZ4InltLEy7w1fHR5FxAG5KPsrRzA==
X-Google-Smtp-Source: APXvYqzHHqeEwetEWl9JakQYAKdoqoR0qVPabCKIdGYa0c6cVR1fgOqx9XOB2vZaL9MRTu0SHUWRIohaMv19ZOuYoKg=
X-Received: by 2002:a05:6602:97:: with SMTP id h23mr559232iob.89.1574227357556;
 Tue, 19 Nov 2019 21:22:37 -0800 (PST)
MIME-Version: 1.0
References: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com> <20191119193809.GG4967@mellanox.com>
In-Reply-To: <20191119193809.GG4967@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 20 Nov 2019 10:52:01 +0530
Message-ID: <CANjDDBg_xUZYirF=zuA7Yn8od4+qzvv3mwKrxRj7Sd3Xx7MX-w@mail.gmail.com>
Subject: Re: [PATCH for-rc 0/3] Broadcom's roce dirver bug fixes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 1:08 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Tue, Nov 19, 2019 at 10:48:48AM -0500, Devesh Sharma wrote:
> > This series contain 3 patches patch 1 and patch 2 are specific to
> > Gen P5 devices. Patch 3 is a generic fix to silence few sparse
> > warnings.
>
> These commit messages are not suitable for -rc, and a sparse warning
> fix is rarely appropriate
>
> You need to describe what the user impact is of these bugs.
>
> -rc is done anyhow unless something urgent comes up.
Got your point. Let's drop sparse fixes patch from this series.

For first patch the impact catastrophic as consumer wont be able to use the
cards as it won't be listed the dev_list.

For second patch the impact is that the end-user won't be able to read
the hardware
stats.

Let me add both points in the commit description respectively.
>
> Jason
