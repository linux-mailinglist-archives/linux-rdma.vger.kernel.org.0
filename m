Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A24942E1
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 23:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbiASWPQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 17:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiASWPQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 17:15:16 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B9C061574
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 14:15:15 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id r65so8306167ybc.11
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 14:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A85uA/1C++J1YF/VPSs41nzWABmNKPRBS1glaSDJ9hA=;
        b=b/v8aqw9YWMZQOB9ggvbNi1xvRJc+beieLMP9CjeJKnz4vzONVk6/nqfFS9qw2Ueaf
         r/GJSmVxp7n45FipbwOetZ5B4R/iZ5JgvRNlbth3ivbRd1W2BV4VfGfjuLT8CmNca0YJ
         RiHpGu1nxvsJ9Z0PAKy6NhvvnL2zU3tTS0rSBpYskLJbgHdIjhqAC2A6FLHwptR+U2gE
         Z33CtvKoaQpARtAKOf6y00nRp5ptSPac2O7gfUsiE4BDC8cSvQiQzCS+m3BnDBtcIlKM
         X0FlqpnHo48XY3RQ/TSJGExpjunYkPJrg0uOKhQBz/dqD50X41lRou2932hjJq2v1rKf
         r69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A85uA/1C++J1YF/VPSs41nzWABmNKPRBS1glaSDJ9hA=;
        b=GLXiMKfBDpyNehhuYmaOiloQpVWVbe+5yXV4ZqlpxLyH38VKBeidKcnj9VTcZin5Xv
         8xuaIrMvuXAY3GcQZtPzDgnpnouio5oyABorkBHmhpoW0re0DnJMSB5KLEIr+sMuXT1n
         kd8Pe7XT448EZBBJ/ATCb2WDS7dhoiZkO58gLfGnpoPLZ0Um3KOvL2EF8vwF2pCfna5T
         FO6Dh/tiA5cnnv3gS4/ES1qBifbOF9fJWPXkvKFQh9xOA18SRe2ZoWoYOgbBcIZh7n/+
         4beStfFLEQLFP1KzeEK62Ih4wC54ZPixKUP/uPX/GhdEfBu5EQd42IDSieixXOE+AxtN
         kbfA==
X-Gm-Message-State: AOAM53368S2Ltw6qF/crLLX4gpKekqUh32XuFwOr5QpUQjTKPQZcmVEn
        dR8njSce0nCWvGTJtlKFDCaEVQHeFKodw9VZRUE=
X-Google-Smtp-Source: ABdhPJxxmgx8Td5KWfaXRZYNki0/FOBQflr8qoo0YwYU54cnNyqEAW6HnxuzFMWGniqil/oQLQ2DvO4Fx3w3BJwy+rs=
X-Received: by 2002:a5b:5c7:: with SMTP id w7mr43525001ybp.343.1642630514496;
 Wed, 19 Jan 2022 14:15:14 -0800 (PST)
MIME-Version: 1.0
References: <CAGP7Hd4atpB0J-PP-AC6peiUaD=Y75Fdue9Ab7AS8nkQPwdXvQ@mail.gmail.com>
 <YefRGdQHkjnzOxuh@unreal> <A78C931D-4286-45EC-9F82-818FA7967127@redhat.com> <YehSriRd1xjHTF2O@unreal>
In-Reply-To: <YehSriRd1xjHTF2O@unreal>
From:   Christian Blume <chr.blume@gmail.com>
Date:   Thu, 20 Jan 2022 11:15:03 +1300
Message-ID: <CAGP7Hd658dMPRx86aEbQBgQQOOW4B64JqU6k3x7Yp=qbxTB5RA@mail.gmail.com>
Subject: Re: SoftRoCE and OpenSM
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks for clearing that up!

Cheers,
Christian

On Thu, Jan 20, 2022 at 7:04 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Jan 19, 2022 at 12:28:30PM -0500, Doug Ledford wrote:
> > On Jan 19, 2022, at 3:51 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Jan 19, 2022 at 01:41:30PM +1300, Christian Blume wrote:
> > >> Hello!
> > >>
> > >> Is it at all possible for a SoftRoCE node to talk to OpenSM? Can I set
> > >> up OpenSM in such a way that it automatically discovers all SoftRoCE
> > >> nodes on my subnet? Thanks for your help.
> > >
> > > AFAICT, RXE lacks MAD support which is needed for OpenSM.
> >
> >
> > All Ethernet based RDMA technologies lack MAD support required for OpenSM.  OpenSM is a uniquely InfiniBand only thing.
>
> Ahh, sorry, completely forgot about that.
>
> >
> > > Thanks
> > >
> > >>
> > >> Cheers,
> > >> Christian
> > >
> >
