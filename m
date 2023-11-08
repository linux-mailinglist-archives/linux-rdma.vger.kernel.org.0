Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAACD7E5F84
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 21:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKHU4g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 15:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHU4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 15:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46F2113
        for <linux-rdma@vger.kernel.org>; Wed,  8 Nov 2023 12:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699476946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0bdxggE2E6/3xhZA/HOZuteyNb9BWW87tXjb8tIPik=;
        b=JxBniBiGlS/3ycOp2/j5ZjaWpz4Y3gRFos4uCNxeHfHFXR2ARkyRx3kW9PARgGoytZ1cfm
        a4ukKzxV6mSttzVgexLtZazCCpP0a8VKbEyJxg+dxvzRp7rgKz7s13M1hWx8Iw5BXSfaLW
        w0Scm/Cq9vlVt0yIl09xqBmsjyFN5p8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-8h6EL0WNM8C4BrnNgGShqg-1; Wed, 08 Nov 2023 15:55:45 -0500
X-MC-Unique: 8h6EL0WNM8C4BrnNgGShqg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ce25ad9ef2so71810a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 08 Nov 2023 12:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699476944; x=1700081744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0bdxggE2E6/3xhZA/HOZuteyNb9BWW87tXjb8tIPik=;
        b=uTd3AcRIwECH/9e8GknL+Hsj//47ADhkyMYCI3M4cEDxmP+PaAeCHCeTJuHfS4oKRY
         6gU4y6fWx/7SGJU84EF6k8BYL4Pl2+mXhsNxpWPUVFVxCDAeEWs4q1VLkaThqzy9Z1sA
         OjkkLpsC85O2nwImm1R/epnA0zQW0AzRnCaGgWxcONEInbp3nmYI6QXdpYq6yGNSptuo
         +7BiEYXXnFObRfInSpJ+blBWmBJS6YDzwuIZKHpPGvndetQ76mFs5tZvpNzfWsPZvuAl
         pMUmBhgsi5+vEdWJ6qkf0OrkB3GmZRI2UPasDl6MIRHIGuC6+6JcGL6ktonG5AxmrrkF
         WQwg==
X-Gm-Message-State: AOJu0YxR2rysrc3NJ6anXKhXjTX1rvuZCcGgWKoZAQHnccvnI5lJZSMm
        xGIDdrf/DgOhwneFJDLN++VfvapO7nnGNlTpdNiMhB34+c2ha7qNLj9AM06LJddePAMncQCkKkJ
        15JQWvrpaL6tCKvOC3e7duA==
X-Received: by 2002:a9d:7c95:0:b0:6c4:897a:31c4 with SMTP id q21-20020a9d7c95000000b006c4897a31c4mr2702378otn.29.1699476944342;
        Wed, 08 Nov 2023 12:55:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB+Aql6S1shLyEYfYSPWwaq2p/J9LNwwJauXWan0U4h4thD5uXVBWEUdauwH1+YzhWzxrNxg==
X-Received: by 2002:a9d:7c95:0:b0:6c4:897a:31c4 with SMTP id q21-20020a9d7c95000000b006c4897a31c4mr2702370otn.29.1699476944042;
        Wed, 08 Nov 2023 12:55:44 -0800 (PST)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id t2-20020a05622a180200b0041812703b7esm1273372qtc.52.2023.11.08.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 12:55:43 -0800 (PST)
Message-ID: <58dae256881123291880b1df49d99fe9ceb01944.camel@redhat.com>
Subject: Re: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2
 kernels and latest 6.6 upstream
From:   Laurence Oberman <loberman@redhat.com>
To:     Mark Lehrer <lehrer@gmail.com>, jpittman@redhat.com
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Date:   Wed, 08 Nov 2023 15:55:43 -0500
In-Reply-To: <27ebfe1ffb5b9e1983466f6ad3a1726b66fc0799.camel@redhat.com>
References: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
         <CADvaNzW1GYMDnD5ffTbB0wgbmWF1HNwgkikbL1=48=B2ouVGHw@mail.gmail.com>
         <27ebfe1ffb5b9e1983466f6ad3a1726b66fc0799.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2023-11-08 at 15:07 -0500, Laurence Oberman wrote:
> On Wed, 2023-11-08 at 12:57 -0700, Mark Lehrer wrote:
> > > [=C2=A0 286.547112] nvme nvme4: Connect Invalid Data Parameter,
> > > cntlid:
> > > 1
> > > [=C2=A0 286.555181] nvme nvme4: failed to connect queue: 1 ret=3D1677=
0
> >=20
> > It looks like the admin queue pair (0) worked at least.=C2=A0 The code
> > path
> > for the two is a bit different.
> >=20
> > This error sounds familiar.=C2=A0 I wonder if there's an error code
> > 16xxx
> > cheat sheet out there.
> >=20
> > We recently had to downgrade a ConnectX firmware version to fix a
> > similar issue, but on a CX7.=C2=A0 I can't remember the firmware
> > versions
> > involved but I could probably dig it up.
> >=20
> > Have you tried TCP mode?=C2=A0 Whether TCP works or not will be useful
> > information for debugging.
> >=20
>=20
> Hi MArk
>=20
> I landed up changing the default kato from 5s to 30 and its working
> now
> We don't jump ship too early anymore and it connects fine.
> See prior response where I answered my own message
>=20
> diff -Nurp linux-5.14.0-284.25.1.el9_2.orig/drivers/nvme/host/nvme.h
> linux-5.14.0-284.25.1.el9_2/drivers/nvme/host/nvme.h
> --- linux-5.14.0-284.25.1.el9_2.orig/drivers/nvme/host/nvme.h=C2=A0=C2=A0=
=C2=A02023-
> 07-20 08:42:08.000000000 -0400
> +++ linux-5.14.0-284.25.1.el9_2/drivers/nvme/host/nvme.h=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02023-
> 11-08 14:16:37.924155469 -0500
> @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
> =C2=A0extern unsigned int admin_timeout;
> =C2=A0#define NVME_ADMIN_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(admin_time=
out * HZ)
> =C2=A0
> -#define NVME_DEFAULT_KATO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05
> +#define NVME_DEFAULT_KATO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A030
> =C2=A0
> =C2=A0#ifdef CONFIG_ARCH_NO_SG_CHAIN
> =C2=A0#define=C2=A0 NVME_INLINE_SG_CNT=C2=A0 0
>=20
>=20
> I will wait for Sagi and Keith and then send a patch
> I had the wrong email for Keith
>=20
> Thanks a lot
> Laurence
>=20

Hello

No fix needed, I was unaware of the -k option in the nvme connect.
My colleague showed it to me.
This works now to give the CX6 longer to handle the connection

#!/bin/bash
modprobe nvme-fc
nvme connect -t rdma -n nqn.2023-10.org.dell -a  172.18.60.2  -s 4420 -
k 30


Thanks
So a Heads up for these newer cards I guess, need more time

Regards
Laurence





