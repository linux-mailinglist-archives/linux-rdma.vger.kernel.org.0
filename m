Return-Path: <linux-rdma+bounces-5880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629099C2A50
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Nov 2024 06:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AADC1F22255
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Nov 2024 05:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1344DA03;
	Sat,  9 Nov 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JplINCLg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C013AD0;
	Sat,  9 Nov 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731130339; cv=none; b=WgCUqisDxE6/y/jJm2y/8aiZZavuc9a4DxQsAMKixYmu5wXBtrpLzAvVVJp1fu+DDaGzTh9ZFkQAMK0vNIbiCwQZXhYR9ul+IY/2SFylzqatXG+KHAwgi7hQ6du4vRsP0qyjdEMc3qsmO956Rl/zLB41rGf6aEMC2IWGyD1MNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731130339; c=relaxed/simple;
	bh=go6EJHLnFe6ngJ4hdleV0KKVBCur+J/KhNeoZHpz/3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxfFONbI8b4Tg/y5I6GJIhgUIX5KgswnQMcy2Lmj396CE9eEdPiZfDiWwGZTNe5cV6gM3v7auWr1r5EyOjEkSTm34GsoX3ODJbFHtCH95RxVh89X6jQAElM+IrRCy/kdu5AjvGc7EJ7KXmzKV/1Ye363bHOg4sdeosj9FvqsUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JplINCLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE007C4CED6;
	Sat,  9 Nov 2024 05:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731130338;
	bh=go6EJHLnFe6ngJ4hdleV0KKVBCur+J/KhNeoZHpz/3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JplINCLgFXF2H6aXSBzvUZ/z5Zu/FtFsU8ZWKXKd3FVp/RbPjNmlJYVLEdGGW7sov
	 ahiBIhZ28NXpp1pJ13xG5pzDGnm1t+AtzGTZB6PmCivzW2bb64QzfKNW8EyvjMS100
	 OdKoemYTDAhx5/YCMIKRB2DdJOuxIdyZeXkWFbn071WTWndnsTT/8XYHGIauGePhbC
	 XIkyMNclzxDhZjH1wIUC24XhxfB6/dRb0PcGEXmF4lfQQYYki1dKLtvNqmSg1+VBty
	 Xewj21dMT6uEjYLMVHHkF8PXSis11ydZJEUAzc15VTo03gKHpOBXeZAPn3cHWsACaO
	 zCFopkkSzq/DQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71807ad76a8so1740403a34.0;
        Fri, 08 Nov 2024 21:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6MjgEhL+V05DOj4SYkBOw0cu4pxh74cCUeHWQ57BWuyYSqYwSMr7YyqDgptmihv816rZ2Drhpdu134w==@vger.kernel.org, AJvYcCVvtJ5OeIAvZdrriHckG6LB6Jkw+Rf3z80rzQcQ5eIgPce0FnbB/qR2KX+K2wjiPLaPHFjpOwWVsQpD@vger.kernel.org, AJvYcCVyP2Wq1F9Xyk5LZLixLFTc5RBvTynCf9xdcJ6nsTOPpjySyA/A+XYJSsKZAczqQ5edgulnum/X@vger.kernel.org, AJvYcCWlPbodknCrV6gJWbwGzH7PC/EhmKU/UP1hIO1rY7p6V+Ru0NFCCSxd1iR+Mse/lI6PnXZZ7CAlU9S/cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKyJjStwdBwBKqdzCt0LWy2Edg6WM/URKbuPAVuG5EQ4G87EU
	V8F73PwrewLLXYefU7EWoIxMn3Tmt2d9vYC/1iEPcbdbHI11LPrKwAi5/4XSv4T2Pfvn0UBN/oJ
	BST00+P6YXxXMOUwQAHLBlGx3TEc=
X-Google-Smtp-Source: AGHT+IGUk2Aoy8E+a8fBA7UoeDCTvBF9ts9tRUG7ZOLhiQIVcvd2RXZHo0CMHqhVCVLYEd13xSF8vSxYz2RjhcGsHrA=
X-Received: by 2002:a05:6830:6105:b0:717:fe94:40af with SMTP id
 46e09a7af769-71a1c1c417amr5830991a34.3.1731130338076; Fri, 08 Nov 2024
 21:32:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025072356.56093-1-wenjia@linux.ibm.com> <20241027201857.GA1615717@unreal>
 <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com> <20241105112313.GE311159@unreal>
 <20241106102439.4ca5effc.pasic@linux.ibm.com> <20241106135910.GF5006@unreal>
 <20241107125643.04f97394.pasic@linux.ibm.com> <CAKYAXd9QD5N-mYdGv5Sf1Bx6uBUwghCOWfvYC=_PC_2wDvao+w@mail.gmail.com>
 <20241108175906.GB189042@unreal>
In-Reply-To: <20241108175906.GB189042@unreal>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 9 Nov 2024 14:32:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8csLBOYhUOOXWnVDZjiH03KHdwuL68aQKAtF9dFW=YfA@mail.gmail.com>
Message-ID: <CAKYAXd8csLBOYhUOOXWnVDZjiH03KHdwuL68aQKAtF9dFW=YfA@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using ib_device_get_netdev()
To: Leon Romanovsky <leon@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>, 
	Niklas Schnell <schnelle@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	Karsten Graul <kgraul@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, 
	Aswin K <aswin@linux.ibm.com>, linux-cifs@vger.kernel.org, 
	Kangjing Huang <huangkangjing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 2:59=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Fri, Nov 08, 2024 at 08:40:40AM +0900, Namjae Jeon wrote:
> > On Thu, Nov 7, 2024 at 9:00=E2=80=AFPM Halil Pasic <pasic@linux.ibm.com=
> wrote:
> > >
> > > On Wed, 6 Nov 2024 15:59:10 +0200
> > > Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > > > Does  fs/smb/server/transport_rdma.c qualify as inside of RDMA co=
re code?
> > > >
> > > > RDMA core code is drivers/infiniband/core/*.
> > >
> > > Understood. So this is a violation of the no direct access to the
> > > callbacks rule.
> > >
> > > >
> > > > > I would guess it is not, and I would not actually mind sending a =
patch
> > > > > but I have trouble figuring out the logic behind  commit ecce70cf=
17d9
> > > > > ("ksmbd: fix missing RDMA-capable flag for IPoIB device in
> > > > > ksmbd_rdma_capable_netdev()").
> > > >
> > > > It is strange version of RDMA-CM. All other ULPs use RDMA-CM to avo=
id
> > > > GID, netdev and fabric complexity.
> > >
> > > I'm not familiar enough with either of the subsystems. Based on your
> > > answer my guess is that it ain't outright bugous but still a layering
> > > violation. Copying linux-cifs@vger.kernel.org so that
> > > the smb are aware.
> > Could you please elaborate what the violation is ?
>
> There are many, but the most screaming is that ksmbd has logic to
> differentiate IPoIB devices. These devices are pure netdev devices
> and should be treated like that. ULPs should treat them exactly
> as they treat netdev devices.
Okay, I'll discuss with Kangjing if there's another way to avoid this issue=
.
If not, I'll revert the patch.

Thanks.
>
> > I would also appreciate it if you could suggest to me how to fix this.
> >
> > Thanks.
> > >
> > > Thank you very much for all the explanations!
> > >
> > > Regards,
> > > Halil
> > >

