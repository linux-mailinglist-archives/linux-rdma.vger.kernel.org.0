Return-Path: <linux-rdma+bounces-3000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9CD900A39
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5631F23AA1
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8EC19A2B8;
	Fri,  7 Jun 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ApNOHe6e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE2199EAD
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777508; cv=none; b=g6YrShpyuVBqiSeZ21AtKCk5/8Mbzbvfu02PeBI5+sUBPhrEXos3HuDuKG5iTycnBgUcd9SxppcHWkMeMJLfT/KgRI8lIVRgTrDDUhIUIUdbcBXJRhOgubZ1TC1qtXT9lgK42s9kKhaekbIFum2txe/5Op7RDeWQw4CvRb8mYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777508; c=relaxed/simple;
	bh=UOV7DS9G3oBogSq2tPvqfq+X6p3ol2Q1L+yZ95iYhjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdA8VvYZggUt4YJRJzqZDmbPrc5sYKZBFHo8/+E7SwNI1sC2m5DJPvC6COOqdzAFqzIfkM56XjBowJ9zHBb+FxHmyqI0a9X99g99pNLDdSLSDWpzyzuRQQ60X3K8WuiPttTdmGvIhHpbdl5QEuyZoQro07Afe1L2hOZkUs1DSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ApNOHe6e; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso239357766b.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2024 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717777504; x=1718382304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INlsx8np7RYxS+x/PsMXwLcYpgw9uIOEVBONEyYuKkQ=;
        b=ApNOHe6ewtjg2UwlTn/xJUlNfe/rqjaEknPyIHvMvCtnT5OPPsj1hjr/ql/Kx7elbW
         c5KuAGvSkqEvl4cO/pitk7GaVtUtBSW3i6t/PMntSehaCQcyQRv4xQ2zKZ4NXWTMQMJ+
         TNjENRBNhu1+NSUClMc9eKI1GtTFmKT3MWh5WJkiow1Mf7qEpSStrZnCqDoLea1BuqMf
         TWrTG/2kt38lmOIuDhyFax4CQyt2R/J5YHnLmpWSek9baxR7ctLsZmRoWVnt4mywph/3
         Y7qLngrTZKj0na+oHobtZ5N2F3/C27Bau2pvOF3yo4dcDRwwy9L2XwPONF7s5p/t7BDB
         XXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717777504; x=1718382304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INlsx8np7RYxS+x/PsMXwLcYpgw9uIOEVBONEyYuKkQ=;
        b=Dkhjz4GJtQbndjva1mtYOg2Xqzi1JkSSWjLArq2Ujhl0jOKvsdbv0nnSX4cVZjVzMh
         edas7gR/Xeymgec63lfjvuA4tW+pPu0n/UlUm79cUYXjR3w9y7FXVjriy1x501oBhwy4
         qj/O5xwuu4iJyjWcW0d7QDZn3S4hO4SLMW70bmCVZF1ZK2qA3PRGTpUNoRy1npuDaJPV
         d3o6WqPbBMHcn3ns8A9qIl5EqatBQSwFBV5V7WqjEEKxL0OyAz623ncFmQqgF4uRUqJY
         IwpV886A8KCegMy6am9vyQjuqj3GaD6D8P6uN7F9dlbOswcCLJ83F6NhQodlf4kDN471
         njUw==
X-Forwarded-Encrypted: i=1; AJvYcCVEDoAHM+krPKfiC0lOAuNM56EZRpm9UVRA57H3+Vc3vcGm3cWkaRqES1hkHAf+5mvsWU63oDQ+7il3fEhs22L+MCSuop1Igv2WvQ==
X-Gm-Message-State: AOJu0YwJ4i3sb6swEslygZXlSNoDIHs6MfXlCy5s+1OirKm7vMO0Jwa1
	yPP3M1Sq4QhOHFGQriCiM8HiLSta5T+TD3LM2uSQ9sioixQ1twxU5uVcMGIQPIsTBBQvDXeI1R8
	1jUdU+DiUJ6Da5bbmAXD3PjFFPZ59GZZEIN4OEw==
X-Google-Smtp-Source: AGHT+IE/Ku73Ss6uPK9q17BoWHv/wkU+34sP4blf4t8hH4ZwaxZkxEp51MEqwvs2EEl3EW/1Xv9mPNzsyaQX+R5+l4w=
X-Received: by 2002:a17:906:a5a:b0:a62:b679:3e7b with SMTP id
 a640c23a62f3a-a6cdb2f94c8mr200111966b.61.1717777504087; Fri, 07 Jun 2024
 09:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <20240605035622-mutt-send-email-mst@kernel.org> <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
In-Reply-To: <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Fri, 7 Jun 2024 18:24:52 +0200
Message-ID: <CAHEcVy5psqfipiRFkvTyfONfX1b90SJ1iwZK7Tw+XnQvNDKUDQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Peter Xu <peterx@redhat.com>, 
	Michael Galaxy <mgalaxy@akamai.com>, Jinpu Wang <jinpu.wang@ionos.com>, 
	Elmar Gerdes <elmar.gerdes@ionos.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, zhengchuan <zhengchuan@huawei.com>, 
	"berrange@redhat.com" <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, 
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "lixiao (H)" <lixiao91@huawei.com>, 
	Wangjialin <wangjialin23@huawei.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Gonglei,

Jinpu and I have tested your patchset by using our migration test
cases on the physical RDMA cards. The result is: among 59 migration
test cases, 10 failed. They are successful when using the original
RDMA migration coed, but always fail when using the patchset. The
syslog on the source server shows an error below:

Jun  6 13:35:20 ps402a-43 WARN: Migration failed
uuid=3D"44449999-3333-48dc-9082-1b6950e74ee1"
target=3D2a02:247f:401:2:2:0:a:2c error=3DFailed(Unable to write to
rsocket: Connection reset by peer)

We also tried to compare the migration speed between w/o the patchset.
Without the patchset, a big VM (with 16 cores, 64 GB memory) stressed
with heavy memory workload can be migrated successfully. With the
patchset, only a small idle VM (1-2 cores, 2-4 GB memory) can be
migrated successfully. In each failed migration, the above error is
issued on the source server.

Therefore, I assume that this version is not yet quite capable of
handling heavy load yet. I'm also looking in the code to see if
anything can be improved. We really appreciate your excellent work!

Best regards,
Yu Zhang @ IONOS cloud

On Wed, Jun 5, 2024 at 12:00=E2=80=AFPM Gonglei (Arei) <arei.gonglei@huawei=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Wednesday, June 5, 2024 3:57 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> > mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket =
API
> >
> > On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > > From: Jialin Wang <wangjialin23@huawei.com>
> > >
> > > Hi,
> > >
> > > This patch series attempts to refactor RDMA live migration by
> > > introducing a new QIOChannelRDMA class based on the rsocket API.
> > >
> > > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > > that is a 1-1 match of the normal kernel 'sockets' API, which hides
> > > the detail of rdma protocol into rsocket and allows us to add support
> > > for some modern features like multifd more easily.
> > >
> > > Here is the previous discussion on refactoring RDMA live migration
> > > using the rsocket API:
> > >
> > > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@lina=
r
> > > o.org/
> > >
> > > We have encountered some bugs when using rsocket and plan to submit
> > > them to the rdma-core community.
> > >
> > > In addition, the use of rsocket makes our programming more convenient=
,
> > > but it must be noted that this method introduces multiple memory
> > > copies, which can be imagined that there will be a certain performanc=
e
> > > degradation, hoping that friends with RDMA network cards can help ver=
ify,
> > thank you!
> >
> > So you didn't test it with an RDMA card?
>
> Yep, we tested it by Soft-ROCE.
>
> > You really should test with an RDMA card though, for correctness as muc=
h as
> > performance.
> >
> We will, we just don't have RDMA cards environment on hand at the moment.
>
> Regards,
> -Gonglei
>
> >
> > > Jialin Wang (6):
> > >   migration: remove RDMA live migration temporarily
> > >   io: add QIOChannelRDMA class
> > >   io/channel-rdma: support working in coroutine
> > >   tests/unit: add test-io-channel-rdma.c
> > >   migration: introduce new RDMA live migration
> > >   migration/rdma: support multifd for RDMA migration
> > >
> > >  docs/rdma.txt                     |  420 ---
> > >  include/io/channel-rdma.h         |  165 ++
> > >  io/channel-rdma.c                 |  798 ++++++
> > >  io/meson.build                    |    1 +
> > >  io/trace-events                   |   14 +
> > >  meson.build                       |    6 -
> > >  migration/meson.build             |    3 +-
> > >  migration/migration-stats.c       |    5 +-
> > >  migration/migration-stats.h       |    4 -
> > >  migration/migration.c             |   13 +-
> > >  migration/migration.h             |    9 -
> > >  migration/multifd.c               |   10 +
> > >  migration/options.c               |   16 -
> > >  migration/options.h               |    2 -
> > >  migration/qemu-file.c             |    1 -
> > >  migration/ram.c                   |   90 +-
> > >  migration/rdma.c                  | 4205 +--------------------------=
--
> > >  migration/rdma.h                  |   67 +-
> > >  migration/savevm.c                |    2 +-
> > >  migration/trace-events            |   68 +-
> > >  qapi/migration.json               |   13 +-
> > >  scripts/analyze-migration.py      |    3 -
> > >  tests/unit/meson.build            |    1 +
> > >  tests/unit/test-io-channel-rdma.c |  276 ++
> > >  24 files changed, 1360 insertions(+), 4832 deletions(-)  delete mode
> > > 100644 docs/rdma.txt  create mode 100644 include/io/channel-rdma.h
> > > create mode 100644 io/channel-rdma.c  create mode 100644
> > > tests/unit/test-io-channel-rdma.c
> > >
> > > --
> > > 2.43.0
>

