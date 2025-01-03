Return-Path: <linux-rdma+bounces-6795-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E6A00CFD
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 18:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9BE1883E46
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C679C1B6CE6;
	Fri,  3 Jan 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQl1zJtS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6B11CA0;
	Fri,  3 Jan 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926062; cv=none; b=Y5ue9OhBDUpxanbXRWMvVv1t3KNyln+TCn0O+WBaTgOaApLVfnrRtc+1xeYfwwo+YRe4dETgUVnec/cCB12UZ5UToyIeMl5ecSlD9+3wFzyMybOJE2LbqAGrZUQvl2a1DxgaEFAAIUEhCCb2xxXnbtG3OAMBe9riaDP2+l1gWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926062; c=relaxed/simple;
	bh=znxZ7WhO10sxyeu4QvDup0SoE78oQlfF4GsgEZk5HXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlWRtWK87Pr32BgaNnNMYrwbr6wUB2KRtfePR8nuLb6YuNvoWEkva8WIuuM07J44YEqfPysyUdVEdGojV4TVMSVEmLL36AL3jrDKTI4eVlvlebKVinhq4aQM8Y88km34o7ErQQFMD3kCHbBub1Bu1VpdmCjV6Cmgx1D9XbLW0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQl1zJtS; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-2a01707db44so4262216fac.2;
        Fri, 03 Jan 2025 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735926060; x=1736530860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znxZ7WhO10sxyeu4QvDup0SoE78oQlfF4GsgEZk5HXQ=;
        b=BQl1zJtSL8MYC6pyOajWt7yOd6o+HJes7YPDWH1cusAdxoY3c/TI8nilds31T82/fN
         F1VxsBM5GwyPB8Ln+CiLCzd2FhNDrLz9Zt7UcTNyGD3LnPtbQewut4m4R1CY1o3pswLK
         bkYlY09cSOkd+Ls7yYMJLVu4irzanRvLZHzpd3QYS+xgwkaKrmvG84QXAnU1sMKGUsQQ
         Gu3FRRRep91UAs6xhIxakNienEzGi45HlTVROwoqZfsdcHb56y3UlSlIVp4EDu5WaDCZ
         GqxXY8n0gH8Bjk3vfVTnA/ufwq230TAxVbogAYsFzgCp6HhxITQM3ekECIavAzsVnXXa
         VGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735926060; x=1736530860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znxZ7WhO10sxyeu4QvDup0SoE78oQlfF4GsgEZk5HXQ=;
        b=mITIw2W0xv2v46XmeRRlDcqGyNMLrwqC/9CyuZXuLmyY5LMvBpq88WP3IKD3fjPJGt
         j/F9m8e/z2qzUBdDExY+iUModdVgOUgFfYtpG4WvP7UycR9hbudygL3Km6sijXuBL15X
         MEgVW+2HMh2b4EeurSQWB1K1G2z1ugUn0vY9E8cet5C/1NL/8f/guS+khRzKzLE6M9Da
         A5yj/6V/XWqV6ooDZNrOKZNFCko9ZBNSvr8f821QZUJJmoQnAtaCfXJkO4QXVKkYoWZI
         y1VhUHojJIyE8VHOOnDH3edWkccMtmOiQSkzlmM5b2fmY/xTGhTwhDp/SG8Jm0H6cmOj
         wn3A==
X-Forwarded-Encrypted: i=1; AJvYcCWB6EtLALlWxh6KMn4mZQz4EPebDkhY3dLaafbmqVVl0FlWAK2SWrUsibpsq+7XNde+cRSefptTSeyNPw==@vger.kernel.org, AJvYcCXi/90f6UwTuTIYew6S7BpIKqdhINkoVafWwXqCY+Z7civaHBt+gKTiNBpeKP2blrX2W5u9On52LR6/6yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXDTzhKFtQ7H0PfbrGDgcmNkXY+SxiHln8T8rOeOPuwXkWSoj+
	PIj8DEhrZQ2LKUKOW30kMaAItRja2sGfu7buFN3SgCqBpCJIsY2Aicb7Qa6S6hDI1STL71hhXMp
	S6/JajR7q0eGs0nLLC/EJdx1Hk7I=
X-Gm-Gg: ASbGncu66mjaW+LCWtHWg8QWh+FSKCPOjjancyyf6jyPPC60eKXCW26strXmCXNu9fb
	qItLifGzictJHXJKaMnua7DX5yR3a6AsCZMi43g==
X-Google-Smtp-Source: AGHT+IFT5H6LGEn9TYl5FXzT8azaIbqlJ5CYrxwKlzGqtweiWc8Fgyddx64eROyu20NgTAln74RzV3Y6fmi3bFm76Bk=
X-Received: by 2002:a05:6871:a4c4:b0:29d:c832:8422 with SMTP id
 586e51a60fabf-2a7fb123672mr27509496fac.18.1735926059911; Fri, 03 Jan 2025
 09:40:59 -0800 (PST)
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
 <20250103150546.GD26854@ziepe.ca>
In-Reply-To: <20250103150546.GD26854@ziepe.ca>
From: Joe Klein <joe.klein812@gmail.com>
Date: Fri, 3 Jan 2025 18:40:48 +0100
Message-ID: <CAHjRaAfuTDGP9TKqBWVDE32t0JzE3jpL8WPBpO_iMhrgMS6MFQ@mail.gmail.com>
Subject: Re: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>, 
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 4:05=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Dec 24, 2024 at 08:52:24AM +0000, Daisuke Matsuda (Fujitsu) wrote=
:
> > On Mon, Dec 23, 2024 10:55 AM Daisuke Matsuda (Fujitsu) <matsuda-daisuk=
e@fujitsu.com> wrote:
> > > On Mon, Dec 23, 2024 2:25 AM Joe Klein <joe.klein812@gmail.com> wrote=
:
> > > > We have tested this patcheset and had a lot of problems, even witho=
ut using the ODP option in softroce. I don't know if
> > > others have done similar tests. If we have to merge this patchset int=
o upstream, is it > possible to add a kernel option to
> > > enable/disable this patchset?
> > >
> > > Hi Joe,
> > >
> > > Can you clarify the test and the problems you observed?
> > > I wonder if you tried the test with the latest tree WITHOUT my patche=
s.
> > >
> > > As far as I know, there is something wrong with the upstream right no=
w.
> > > It does not complete the rdma-core testcases, and 'segmentation fault=
' is observed
> > > in the middle of the full test run, which did not happen before Octob=
er 2024.
> >
> > It appears that the root cause of this issue lies within the userspace =
components.
> > My report yesterday was based on experiments conducted on Ubuntu 24.04.=
1 LTS (x86_64).
> > It seems to me that rxe is somehow broken regardless of kernel version
> > as long as userspace components are provided by Ubuntu 24.04.1 LTS.
> > I built and tried linux-6.11, linux-6.10, and linux-6.8, and they all f=
ailed as I reported.
> >
> > I switched to Ubuntu 22.04.5 LTS (aarch64) to test with the older libra=
ries.
> > All tests available passed using the rdma for-next tree without any pro=
blem.
> > Then, I applied my ODP patches onto it, and everything is still fine.
> > ####################
> > ubuntu@rdma-aarch64:~/rdma-core$ git branch -v
> > * master fb965e2d0 Merge pull request #1531 from selvintxavier/pbuf_opt=
imization
> > ubuntu@rdma-aarch64:~/rdma-core$ ./build/bin/run_tests.py
> > ..........ss..........ssssssssss..............sssssssssssssssssssssssss=
s.sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss=
ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss.....=
...ssssss..ss....s.sssssss....ss....ss..............s......................=
ss.............sss...ssss
> > ----------------------------------------------------------------------
> > Ran 321 tests in 3.599s
> >
> > OK (skipped=3D211)
> > ubuntu@rdma-aarch64:~/rdma-core$ ./build/bin/run_tests.py -k odp
> > sssssssss..ss....s.s
> > ----------------------------------------------------------------------
> > Ran 20 tests in 0.269s
> >
> > OK (skipped=3D13)
> > ####################
> >
> > Possibly, there was a regression in libibverbs between v39.0-1 and v50.=
0-2build2.
> > We need to take a closer look to resolve the malfunction of rxe on Ubun=
tu 24.04.
>
> That's distressing.
>
> > In conclusion, I believe there is nothing in my ODP patches that could =
cause
> > the rxe driver to fail. I would appreciate any feedback on potential im=
provements.
>
> What am I supposed to do with this though?
>
> Joe, can you please answer Daisuke's questions on what problems you
> observed and if you observe them without the ODP patches?

Will make tests and let you know the result very soon.

>
> Jason

