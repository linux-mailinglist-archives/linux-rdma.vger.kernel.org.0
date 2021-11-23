Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D13459F59
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhKWJhd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 04:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhKWJhc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Nov 2021 04:37:32 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35BC061574
        for <linux-rdma@vger.kernel.org>; Tue, 23 Nov 2021 01:34:24 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m27so89135945lfj.12
        for <linux-rdma@vger.kernel.org>; Tue, 23 Nov 2021 01:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+fADoCJ99IcYEFNRc5r6KIPsnA/VFPnfJonFx1XAeXA=;
        b=BwTthtJP0TMLQqBFc+5EEwDp1MXvycS+QBn9ViLAMzNO0FDm/Rz/m/55iP1Xlg9C+J
         HR7m/HMczSdrLWMRMDcKhi2lYydMCiIbhjXWn4scHCCI27zvOkpzG7uASgfPnUVwkZtd
         9+Ag8wn/aBCXoOvpq/sueOEaErGzGtpXreU8VH/xrMVWrX43K9q+4UComtL8PBgtN4eB
         L2k4BxEN8/4CN3kcwkj6Wr/qy+cOjBlTqtHjm5MEh0Pd+DjcH5H5mW7F9BxwKm1O4o0F
         g9byjgrHRZv2fFvY0/cT5EV822ox/jR5HQR77ujchFoMvh3fkkW7KxllhblaQRVQjLuS
         UoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+fADoCJ99IcYEFNRc5r6KIPsnA/VFPnfJonFx1XAeXA=;
        b=mNBVJ9Aj9cEUs+Y0XFA9A16BsCZkrGHMZcBAuAQAboq78BWAHh0j6mocmvRLjfA4dR
         8DwyCH+4MxFxJ4hRS5JAbKT8FzGHDN++OmAbdikHXUaVEMdkIhbCUf0nW9fcUHF89zRI
         MgYpmzAONFkUL3XvjBzk1MduHLwZWE+hbeiaA0ThYv7GVbNaGUcRbpM6GCMZNx89vxLW
         jwDR706x1Rl/x2zy4xWwFbhasx1EgSY0Gvt+yZpMOnRhzGSAZcO1LtDKYo/vmcuIrNIF
         iTEUq5nB4fn7OQH/iti0nTt+nyjzo89e5O788bGRjdLEoqeEEntQhkI6MbaV+Xd7f/2D
         /OLA==
X-Gm-Message-State: AOAM531YZM6wSma1VYnxeOiiW12IWjPX3bNin17hKoKisBcD/eNuuIfm
        cWwllJlkQG0Cd6ogY0IzfciswRX9VKXCXRLhor4=
X-Google-Smtp-Source: ABdhPJwuShUrALp8DKpNTkALQoR23GrmL7bpbBPlgIfybypuWYwD4qGb1DeBWe/VDDo9MghsioaV6K/jelCZ+mjZmp4=
X-Received: by 2002:a05:6512:3410:: with SMTP id i16mr3219260lfr.113.1637660062418;
 Tue, 23 Nov 2021 01:34:22 -0800 (PST)
MIME-Version: 1.0
References: <CAGbH50sEwKeB3bH6XHm+C1R_giN85pi6Bqq4fk-rFq-iU3bavg@mail.gmail.com>
 <YZoJrPGtQJ9e3v9K@unreal>
In-Reply-To: <YZoJrPGtQJ9e3v9K@unreal>
From:   Jack Wang <xjtuwjp@gmail.com>
Date:   Tue, 23 Nov 2021 10:34:11 +0100
Message-ID: <CAD+HZHWjAKp2Qht7OQgYT6Uu_MjTrgXf_YEDCLHHeG0hh=yyAQ@mail.gmail.com>
Subject: Re: Two announcements
To:     Doug Ledford <dledford@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Leon Romanovsky <leon@kernel.org> =E4=BA=8E2021=E5=B9=B411=E6=9C=8821=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8810:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 18, 2021 at 02:57:09PM -0600, Doug Ledford wrote:
> > First, many of us have talked in the past about the benefit dedicated
>
> <...>
>
> Thank you Doug for your dedicated work all these years.
+1

Thanks!
>
> >
> > --
> > Doug Ledford <dledford@redhat.com>
> > GPG KeyID: B826A3330E572FDD
> > Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
> >
