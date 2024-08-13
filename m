Return-Path: <linux-rdma+bounces-4344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858FD94FE5E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 09:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86321C22AB6
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 07:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849344C76;
	Tue, 13 Aug 2024 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHKoGOx0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BE3DBB7
	for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532811; cv=none; b=dUSTy/npgd2t8eEryvLrhlRubkqnFBFvVUyfJn+pVzmAzY3FKHvyYYKOfY+QgkvG4LS6eOReJrGva81xX8qjhjwJY1XlcH85XtnMRJFQiq2bYlNTkV02t6Zm4cwaRxHN0aSLBQZp6cynmY5Zdr1wq+N9AS5tNZPDzbwuL2UeMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532811; c=relaxed/simple;
	bh=PeXP4knedHoEKd7rD4ZrwlJk/0EMpRXoty42pyQ40oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCfF9Tt8lNkR0u1WAj5cp+LbqZDPlyqLTrKbYhaUuBRfleJoZgwiLozT8XBwixW70RhX8BQaaGMq9OYvAeI0MZ5itEK78yo4FLSObPYDx+ig3ftxURD0VzWVgMzjMQ0rz0dEo7dyFPkusZVgKqsNavy3412QikOOFu9U4y45X1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHKoGOx0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723532807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLMXoEnXQB4j6uGPV4owlqBBJTVhrRaJGaY0tIh4Xwc=;
	b=BHKoGOx08d9TLA6wZuNzv9ttS9oWEOq4pLLXUWuT+NTN0jJK2/hpXauIR6yhtIMsyb5R4W
	QWdylr8v3GHaDuDZ0w+1HiqMviWi2gI3eYT2mnqPm71M1oz3WEYPG8WB4hVsA2cQA49iXb
	frMa1SJacLCB7m//U0/QMWzGYTfhPwE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-I5Hi6gOhPs-2nF23MpLHTQ-1; Tue, 13 Aug 2024 03:06:46 -0400
X-MC-Unique: I5Hi6gOhPs-2nF23MpLHTQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7acb08471b1so3674176a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 00:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723532805; x=1724137605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLMXoEnXQB4j6uGPV4owlqBBJTVhrRaJGaY0tIh4Xwc=;
        b=Bc+QfvOwvWFA7xLJOvsE4EGBbx0z5srxo6uYwC8RhLSH8EiHj6efb3Ioc8hjsTAzuI
         5ctvo3my4pILvolKbECpUb2ptpTM9iHNRGKgi4p8gm+U58OdjSQtsfYH9/kS5E1T7xvf
         tOwwKXjKWac1eAuhhVs3CFDhGX+Ve1M2xIe62e9tBRuOcoBtgNLsG03BhF2hQg7IUsnt
         KpIwSAWlDDo2tKDXA/S4lLBCtPp6E5iQ8xDSAhmgK2ZuNArxEEeIOtEoP22XfQKSD0Mz
         IrQ0/FbgS84Jvh5XkuokteUNU1DMmSIjq+KsR5nEwDPkcMFfYRQaYgtvgVBQjmELmk+c
         x28Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1kFzffXdYVut+WSvBj8GryDe2Zun75VjXdOZqsIhTiBhjUZvROYSgdzugNmGb54nFCzkzXvHE0rFTaNn5Bi6/HkH1Hk7MyL4LKA==
X-Gm-Message-State: AOJu0YxjXrzGt52cfa7Ijlaa1ltUO4lRF8fKq3ABqzG/sL5pDGIuAmoa
	8h3+gslJ5wYEz9J/TwZLSlIRWKlcasZdXkipCZ5/HtisIx8f5SKmKnquY+BIZUsqfajD24k9WLz
	3G18JpyDe8GSG+b5gcouDSlwTW0zAHTVekyUG7U29uep0lMzarOVecazc32NV1kTZ24wJOXie7i
	xWX46re5/YHAw/Mg3oCHblC6TmMhZK16kKYg==
X-Received: by 2002:a05:6a21:6b0c:b0:1c6:fc2f:40fa with SMTP id adf61e73a8af0-1c8d75c7c32mr3359012637.46.1723532805246;
        Tue, 13 Aug 2024 00:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Sin0HKC9rjncXAyssbzbIMN1oJ/7IXsRidBfNy79BEr7HzyhaxZkC41l5rDTmBxwrSBe3UGPw42vPbsazvE=
X-Received: by 2002:a05:6a21:6b0c:b0:1c6:fc2f:40fa with SMTP id
 adf61e73a8af0-1c8d75c7c32mr3358990637.46.1723532804789; Tue, 13 Aug 2024
 00:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com> <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
 <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
In-Reply-To: <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 13 Aug 2024 15:06:32 +0800
Message-ID: <CAHj4cs-5DPDFuBzm3aymeAi6UWHhgXSYsgaCACKbjXp=i0SyTA@mail.gmail.com>
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 12:49=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 8/2/24 18:04, Shinichiro Kawasaki wrote:
> > CC+: Yi Zhang,
> >
> > On Aug 02, 2024 / 17:46, Nilay Shroff wrote:
> >>
> >>
> >> On 8/2/24 14:39, Shinichiro Kawasaki wrote:
> >>>
> >>> #3: nvme/052 (CKI failure)
> >>>
> >>>    The CKI project reported that nvme/052 fails occasionally [4].
> >>>    This needs further debug effort.
> >>>
> >>>   nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subs=
ystem) [failed]
> >>>       runtime    ...  22.209s
> >>>       --- tests/nvme/052.out        2024-07-30 18:38:29.041716566 -04=
00
> >>>       +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/ker=
nel-tests/-/archive/production/kernel-tests-production.zip/storage/blktests=
/nvme/nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad     2024-07=
-30 18:45:35.438067452 -0400
> >>>       @@ -1,2 +1,4 @@
> >>>        Running nvme/052
> >>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>        Test complete
> >>>
> >>>    [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275
> >>
> >> I just checked the console logs of the nvme/052 and from the logs it's
> >> apparent that all namespaces were created successfully and so it's str=
ange
> >> to see that the test couldn't access "/sys/block/nvme1n2/uuid".
> >
> > I agree that it's strange. I think the "No such file or directory" erro=
r
> > happened in _find_nvme_ns(), and it checks existence of the uuid file b=
efore
> > the cat command. I have no idea why the error happens.
> >
> Yes exactly, and these two operations (checking the existence of uuid
> and cat command) are not atomic. So the only plausible theory I have at t=
his
> time is "if namespace is deleted after checking the existence of uuid but
> before cat command is executed" then this issue may potentially manifests=
.
> Furthermore, as you mentioned, this issue is seen on the test machine
> occasionally, so I asked if there's a possibility of simultaneous blktest
> or some other tests running on this system.

There are no simultaneous tests during the CKI tests running.
I reproduced the failure on that server and always can be reproduced
within 5 times:
# sh a.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D0
nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem) [=
passed]
    runtime  21.496s  ...  21.398s
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D1
nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem) [=
failed]
    runtime  21.398s  ...  21.974s
    --- tests/nvme/052.out 2024-08-10 00:30:06.989814226 -0400
    +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad
2024-08-13 02:53:51.635047928 -0400
    @@ -1,2 +1,5 @@
     Running nvme/052
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
     Test complete
# uname -r
6.11.0-rc3
[root@hpe-rl300gen11-04 blktests]# lsblk
NAME                                MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
zram0                               252:0    0     8G  0 disk [SWAP]
nvme0n1                             259:0    0 447.1G  0 disk
=E2=94=9C=E2=94=80nvme0n1p1                         259:1    0   600M  0 pa=
rt /boot/efi
=E2=94=9C=E2=94=80nvme0n1p2                         259:2    0     1G  0 pa=
rt /boot
=E2=94=94=E2=94=80nvme0n1p3                         259:3    0 445.5G  0 pa=
rt
  =E2=94=94=E2=94=80fedora_hpe--rl300gen11--04-root 253:0    0 445.5G  0 lv=
m  /


>
> Thanks,
> --Nilay
>


--=20
Best Regards,
  Yi Zhang


