Return-Path: <linux-rdma+bounces-6976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2CA0B7E6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 14:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1EF188791F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732AF2343AE;
	Mon, 13 Jan 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMhRoY23"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62EA1F94A;
	Mon, 13 Jan 2025 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774141; cv=none; b=Z5tPESCAPbRMH+V6cEDKZomS2yhSHnCd7WtWGPhEeBI/ntVH95vUmlvWxifjLUUjE5wZhcI6OsWDKsiUfb6BZZwSNPNHnCe+cpiGsrQNiBWZrXdgydJVUpKWllWU4sk3ei8zuhrT02lqN5Qif+ciMNzwd3G/6hwifiRoX0i2yRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774141; c=relaxed/simple;
	bh=wSTlN347D1NgX/t2YTCoBuZrKfysu+i497Vg8W0TVxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vqch6JL2NCZnipczXHX1LfOEh1ni7owM2PxO9e+vwwplRSEIZpWwDwTQ2Gi8ZY3srzZZoO1pn7eWCRE0PF/DrpbMaMbKxFv/j/Tiy7hXc7V6tAtoe9LPU9wEnAjJz2ZSn1Ej0XzhmXX8yzUrruqdSkDmDACzKDZsQjgNkyR7MFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMhRoY23; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-5f6b65c89c4so790549eaf.2;
        Mon, 13 Jan 2025 05:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736774138; x=1737378938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSTlN347D1NgX/t2YTCoBuZrKfysu+i497Vg8W0TVxQ=;
        b=QMhRoY23A2UIvHVFWPpWO6UQmAIzDDfRAk8V0+WGtxVLn3TLSjG7di90le101n1niE
         bXwpURJ/jpvfDpYMnl2PzTkkm38Gs0vVzQdD205BQUC2f3K36EVbCqsSFvU48CGh6xxb
         dpSyrcUEMmDE6UHsCiVbdjcrUss00SlDH7KylWJGhEyoXw7xaZPu6Rxe/rA6kyXwRvUH
         E4Mdzq+xRkZwtksbo6mpIEzscvCqNW9bP1P/K2jrcRASw5xV0PZ/3kYGNFjZnu9AfKjT
         E5dXCuRy8KqVpNASjXYPdA+aT7IuMzxVgVmQ8AnCo1daKwW0Yi+FKhQ7y2vL4TWqLfVn
         bPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736774138; x=1737378938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSTlN347D1NgX/t2YTCoBuZrKfysu+i497Vg8W0TVxQ=;
        b=OW6yMwFTCGJvks5gEGZ7iIsL2LiAzFsxP/LHWmnOL6KZymHaUN+pfjZCXhdN2OeMIu
         CqgY3eMSxRYxUwQ/e1Av/4XfCcU2wOafHypzvNQp3059XmJK2/6C+uzu5Dj4DpaWHVeG
         W9M9UbT9vzpGowhbh9aj5TkiB19ruBoMN4voiLrbKGQGiurm5DYO9rnD9xvansBEfz3i
         DSG86DlKVHREJ0U8KYuB0hn/mtIqB7ECOTlTUomKhSk/tPbxxtGVmTlZEmjZ85XdXgtf
         cA+47R4m2U/i8t1LK72pRRpnRZU0MnkhCvO0ysDTE1yYezAo4o8bRJPCiosDfm0ILTti
         QILQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8P9lA8nS3DYQG2331HAT3y1RIZGdLEGS2rpPShqb/YL143vag8CpJkIkbRWikSN1p7hx0MSQhmJFw8O0=@vger.kernel.org, AJvYcCVEU8NO/Xa6VkralvbJFP+JJKIwga0yb81O9yLq21YNc89nHhNdjaWAnq1RndYW4Z5P7XwVmT7myq+pyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6sdAm5jLqioMaUS3w4PItv5owMkMPOa5Yk0P94NJc8mQfQh8
	Tckk5HOz3FkHAr7NlRipfizPOzCtqE7J1Mwk+DvLJ1Ukau5YzHGeddqOPdMjVUSFNrJiXQohoA1
	jvymWyALXl8AK4LUTK3Vs0AvI5z22XFeI
X-Gm-Gg: ASbGnctfgGoPQ7pSJIKl+y2zWVX5sS4yOfxKLBuRp7yV4j0CLrHf9p88aqX4MXw/CNF
	xQCcjX7BfdsNYDAmJ0VR1GJfFatp1sGiGfmRQqw==
X-Google-Smtp-Source: AGHT+IGXJWQkcmBITLAmSjyIbAohferBWQN//9J2eqFSIbYS4qZYAXD8hJ+Twk3Ta7MmUhWxqoi7agorblyvSmrMWK4=
X-Received: by 2002:a05:6871:a692:b0:29f:b09d:d93a with SMTP id
 586e51a60fabf-2aa067107famr10380371fac.16.1736774138523; Mon, 13 Jan 2025
 05:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
 <OS3PR01MB98654FDD5E833D1C409B9C2CE5022@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <OS3PR01MB9865F967A8BE67AE332FC926E5032@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250103150546.GD26854@ziepe.ca> <CAHjRaAfuTDGP9TKqBWVDE32t0JzE3jpL8WPBpO_iMhrgMS6MFQ@mail.gmail.com>
In-Reply-To: <CAHjRaAfuTDGP9TKqBWVDE32t0JzE3jpL8WPBpO_iMhrgMS6MFQ@mail.gmail.com>
From: Joe Klein <joe.klein812@gmail.com>
Date: Mon, 13 Jan 2025 14:15:27 +0100
X-Gm-Features: AbW1kvYJfDg15UUsk_Wd2aPoW3_sr8cVSgHG9HRkSUtSYtEa4hbgI0UKOWST4tI
Message-ID: <CAHjRaAd+x1DapbWu0eMXdFuVru5Jw8jzTHyXo2-+RSZYUK9vgg@mail.gmail.com>
Subject: Re: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>, 
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 6:40=E2=80=AFPM Joe Klein <joe.klein812@gmail.com> w=
rote:
>
> On Fri, Jan 3, 2025 at 4:05=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> >
> > On Tue, Dec 24, 2024 at 08:52:24AM +0000, Daisuke Matsuda (Fujitsu) wro=
te:
> > > On Mon, Dec 23, 2024 10:55 AM Daisuke Matsuda (Fujitsu) <matsuda-dais=
uke@fujitsu.com> wrote:
> > > > On Mon, Dec 23, 2024 2:25 AM Joe Klein <joe.klein812@gmail.com> wro=
te:
> > > > > We have tested this patcheset and had a lot of problems, even wit=
hout using the ODP option in softroce. I don't know if
> > > > others have done similar tests. If we have to merge this patchset i=
nto upstream, is it > possible to add a kernel option to
> > > > enable/disable this patchset?
> > > >
> > > > Hi Joe,
> > > >
> > > > Can you clarify the test and the problems you observed?
> > > > I wonder if you tried the test with the latest tree WITHOUT my patc=
hes.
> > > >
> > > > As far as I know, there is something wrong with the upstream right =
now.
> > > > It does not complete the rdma-core testcases, and 'segmentation fau=
lt' is observed
> > > > in the middle of the full test run, which did not happen before Oct=
ober 2024.
> > >
> > > It appears that the root cause of this issue lies within the userspac=
e components.
> > > My report yesterday was based on experiments conducted on Ubuntu 24.0=
4.1 LTS (x86_64).
> > > It seems to me that rxe is somehow broken regardless of kernel versio=
n
> > > as long as userspace components are provided by Ubuntu 24.04.1 LTS.
> > > I built and tried linux-6.11, linux-6.10, and linux-6.8, and they all=
 failed as I reported.
> > >
> > > I switched to Ubuntu 22.04.5 LTS (aarch64) to test with the older lib=
raries.
> > > All tests available passed using the rdma for-next tree without any p=
roblem.
> > > Then, I applied my ODP patches onto it, and everything is still fine.
> > > ####################
> > > ubuntu@rdma-aarch64:~/rdma-core$ git branch -v
> > > * master fb965e2d0 Merge pull request #1531 from selvintxavier/pbuf_o=
ptimization
> > > ubuntu@rdma-aarch64:~/rdma-core$ ./build/bin/run_tests.py
> > > ..........ss..........ssssssssss..............sssssssssssssssssssssss=
sss.sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss=
ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss...=
.....ssssss..ss....s.sssssss....ss....ss..............s....................=
..ss.............sss...ssss
> > > ---------------------------------------------------------------------=
-
> > > Ran 321 tests in 3.599s
> > >
> > > OK (skipped=3D211)
> > > ubuntu@rdma-aarch64:~/rdma-core$ ./build/bin/run_tests.py -k odp
> > > sssssssss..ss....s.s
> > > ---------------------------------------------------------------------=
-
> > > Ran 20 tests in 0.269s
> > >
> > > OK (skipped=3D13)
> > > ####################
> > >
> > > Possibly, there was a regression in libibverbs between v39.0-1 and v5=
0.0-2build2.
> > > We need to take a closer look to resolve the malfunction of rxe on Ub=
untu 24.04.
> >
> > That's distressing.
> >
> > > In conclusion, I believe there is nothing in my ODP patches that coul=
d cause
> > > the rxe driver to fail. I would appreciate any feedback on potential =
improvements.
> >
> > What am I supposed to do with this though?
> >
> > Joe, can you please answer Daisuke's questions on what problems you
> > observed and if you observe them without the ODP patches?
>
> Will make tests and let you know the result very soon.

Need time to complete the test scenario configurations.

We made tests again. Some memory errors are from RXE ODP.
The whole tests can not be complete with this patch set.
Without this patch set, all the tests can pass.

>
> >
> > Jason

