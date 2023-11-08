Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050EB7E5FC5
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 22:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKHVLz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 16:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjKHVLt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 16:11:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379B2581
        for <linux-rdma@vger.kernel.org>; Wed,  8 Nov 2023 13:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699477864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YORmX9lr2fXkEvC4tyZOL3EX1Fvudq9WFOTSnxqClXM=;
        b=BObYnxOGepS4x8Z6slIOyBNtLvt/dYRXelAHpBpMsJxONK7C90L0m9hYdIJsvP1gTVc9M8
        LiDY4JHrb1tVN44sYCgcQsw3ms8VH4Hmlr+T0e6htbwHQi5kkNleDAfg7lGpDLbjM0UBzB
        ixbWbXvxZqZco2XzxhKVJBVxzGhvetY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-19hEyX1tOtOVyjXyB04iaw-1; Wed, 08 Nov 2023 16:11:02 -0500
X-MC-Unique: 19hEyX1tOtOVyjXyB04iaw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7788ce62d50so11966685a.3
        for <linux-rdma@vger.kernel.org>; Wed, 08 Nov 2023 13:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477861; x=1700082661;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YORmX9lr2fXkEvC4tyZOL3EX1Fvudq9WFOTSnxqClXM=;
        b=pCQd+8i/EnfwRP2Tvgs98bK0oyXoy3i8NdLoledv+cJKa5IUARTg+66otfgiigVVvQ
         dXFJqVolXjPccd2+jrLk0SgTvl8gGTc5tRdpqc8uHAvJcw/ls7M4TuFmVnj2m5SrC3K3
         lZ1JDO0dsuC6E+SDRKBMNAPKkv6Q3FYntlF0e3zJXR1DOKfenyMzMohLNDXoo/aLH5Uv
         jB4m8SxdjxAY6nFYiAwuIjpCCFfnAMmT8hf8WUXHVNMFfrbgcJysCg86LKnuFc1S+y9Q
         r41pnYAzfpl8iOVclPlF2nIin3dKr9RqrXRAl5mrdVjcjVCSKSOAsqDKSAbSJUzUkgDQ
         VAgQ==
X-Gm-Message-State: AOJu0YynVrDlNoSugQ4KCnwdOJl2hImirCxu5g5bndPm+j8mbc+wPNRJ
        5qTQDaZd9d+xZzWrayPkJNQnxvLBebTpShUEDxznEkpC35YDGCBoSd1sBYQnMkISwHpn7eY1MWz
        vZikHof92FtvestJcUeY2d6JD6Z96Sw==
X-Received: by 2002:a05:620a:6508:b0:778:99a0:d105 with SMTP id qb8-20020a05620a650800b0077899a0d105mr3295486qkn.23.1699477860741;
        Wed, 08 Nov 2023 13:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQVJyNkv0GlH9NY/6GEJDe2UFUXlPiJoOOFyBf/i7TlJ6tHSLjne78U0VruI67yQB1gCzd7g==
X-Received: by 2002:a05:620a:6508:b0:778:99a0:d105 with SMTP id qb8-20020a05620a650800b0077899a0d105mr3295467qkn.23.1699477860447;
        Wed, 08 Nov 2023 13:11:00 -0800 (PST)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id po15-20020a05620a384f00b0076cb3690ae7sm1438024qkn.68.2023.11.08.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 13:10:59 -0800 (PST)
Message-ID: <ac4e257ff54c91c30ec2d792cf656cea1d3d741f.camel@redhat.com>
Subject: Re: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2
 kernels and latest 6.6 upstream
From:   Laurence Oberman <loberman@redhat.com>
To:     Mark Lehrer <lehrer@gmail.com>, jpittman@redhat.com,
        chaitanyak@nvidia.com, jmeneghi@redhat.com
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Date:   Wed, 08 Nov 2023 16:10:58 -0500
In-Reply-To: <58dae256881123291880b1df49d99fe9ceb01944.camel@redhat.com>
References: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
         <CADvaNzW1GYMDnD5ffTbB0wgbmWF1HNwgkikbL1=48=B2ouVGHw@mail.gmail.com>
         <27ebfe1ffb5b9e1983466f6ad3a1726b66fc0799.camel@redhat.com>
         <58dae256881123291880b1df49d99fe9ceb01944.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2023-11-08 at 15:55 -0500, Laurence Oberman wrote:
> On Wed, 2023-11-08 at 15:07 -0500, Laurence Oberman wrote:
> > On Wed, 2023-11-08 at 12:57 -0700, Mark Lehrer wrote:
> > > > [=C2=A0 286.547112] nvme nvme4: Connect Invalid Data Parameter,
> > > > cntlid:
> > > > 1
> > > > [=C2=A0 286.555181] nvme nvme4: failed to connect queue: 1 ret=3D16=
770
> > >=20
> > > It looks like the admin queue pair (0) worked at least.=C2=A0 The cod=
e
> > > path
> > > for the two is a bit different.
> > >=20
> > > This error sounds familiar.=C2=A0 I wonder if there's an error code
> > > 16xxx
> > > cheat sheet out there.
> > >=20
> > > We recently had to downgrade a ConnectX firmware version to fix a
> > > similar issue, but on a CX7.=C2=A0 I can't remember the firmware
> > > versions
> > > involved but I could probably dig it up.
> > >=20
> > > Have you tried TCP mode?=C2=A0 Whether TCP works or not will be usefu=
l
> > > information for debugging.
> > >=20
> >=20
> > Hi MArk
> >=20
> > I landed up changing the default kato from 5s to 30 and its working
> > now
> > We don't jump ship too early anymore and it connects fine.
> > See prior response where I answered my own message
> >=20
> > diff -Nurp linux-5.14.0-
> > 284.25.1.el9_2.orig/drivers/nvme/host/nvme.h
> > linux-5.14.0-284.25.1.el9_2/drivers/nvme/host/nvme.h
> > --- linux-5.14.0-
> > 284.25.1.el9_2.orig/drivers/nvme/host/nvme.h=C2=A0=C2=A0=C2=A02023-
> > 07-20 08:42:08.000000000 -0400
> > +++ linux-5.14.0-
> > 284.25.1.el9_2/drivers/nvme/host/nvme.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A02023-
> > 11-08 14:16:37.924155469 -0500
> > @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
> > =C2=A0extern unsigned int admin_timeout;
> > =C2=A0#define NVME_ADMIN_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(admin_ti=
meout * HZ)
> > =C2=A0
> > -#define NVME_DEFAULT_KATO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05
> > +#define NVME_DEFAULT_KATO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A030
> > =C2=A0
> > =C2=A0#ifdef CONFIG_ARCH_NO_SG_CHAIN
> > =C2=A0#define=C2=A0 NVME_INLINE_SG_CNT=C2=A0 0
> >=20
> >=20
> > I will wait for Sagi and Keith and then send a patch
> > I had the wrong email for Keith
> >=20
> > Thanks a lot
> > Laurence
> >=20
>=20
> Hello
>=20
> No fix needed, I was unaware of the -k option in the nvme connect.
> My colleague showed it to me.
> This works now to give the CX6 longer to handle the connection
>=20
> #!/bin/bash
> modprobe nvme-fc
> nvme connect -t rdma -n nqn.2023-10.org.dell -a=C2=A0 172.18.60.2=C2=A0 -=
s 4420
> -
> k 30
>=20
>=20
> Thanks
> So a Heads up for these newer cards I guess, need more time
>=20
> Regards
> Laurence
>=20
>=20
>=20
>=20
>=20

Finalizing this discussion and adding appropriate cc's


No patch needed, I was unaware of the -k option in the nvme connect.
My colleague John Pittman showed it to me. and in fact Mark also
pointed it out in a follow up email.
This works now to give the CX6 longer to handle the connection.
C.K Thanks to you as well for responding

Initiator
#!/bin/bash
modprobe nvme-fc
nvme connect -t rdma -n nqn.2023-10.org.dell -a  172.18.60.2  -s 4420=C2=A0
-k 30

Thanks
So a Heads up for these newer cards I guess, need more time

Learn something new every day

