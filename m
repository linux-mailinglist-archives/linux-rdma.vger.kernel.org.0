Return-Path: <linux-rdma+bounces-5848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E8B9C12AB
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 00:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B0DB21B4E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 23:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F526219CAE;
	Thu,  7 Nov 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFztN0vO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18D21894F;
	Thu,  7 Nov 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022853; cv=none; b=ZVgims8g1X8AiOjKLc5FLIApDDq2KFtgvDfkoTR3G/EgrCNCdWCFIT2za0GcmunWdbxZ81KIGtuIuAysxRDmyGHql7uiH2Jwjsnu0ympbuW7tNJMgV559csZOdbVDoAuCphObJ417qjPZd+dnu6uA5gonq0LSog56xwkFoTF71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022853; c=relaxed/simple;
	bh=DU9V5JYhXP+PMdlObqy5XmJcfEODdIQrQccapJcPRGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBqfRP+Onv15LR+UnmDNph9UTw7mI7WZ7KSACjwvtIoU/NSPEVRfXxnaP73rSMIPC7drYEdTK5z6LBybSbu9Xrhcg2KXclIxr0IsCXc6W5KeCRc9vg3Tj9UyQtekEMCO+b1jUGxxO7dW0P9rwfBrXhdaaFKizDW64LZFYnZ2zL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFztN0vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520CDC4CED3;
	Thu,  7 Nov 2024 23:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731022852;
	bh=DU9V5JYhXP+PMdlObqy5XmJcfEODdIQrQccapJcPRGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZFztN0vOaOSU/SRUgi3fmXi2XcjiJt33UXKGf1eFQb4o2O6sLIrkS6+1zAzeOKTnz
	 JvEx3K2Xvd5mgw0vfFxYXx5ZVVpgZpk5VLkQ86MItoDv06AGZB4/JWrBaC50yJ4YW9
	 CTH5kHW/ST2rdbVPvBtYrBPg3dxcyy3IeOAsDKYXk825LdAHcj0waE2JRY+Fopplf5
	 upLUrak1OYR3irbS5sQMtNvaW/+5eynFwQDM6dN14yDjyiU2mXKoU8F+9mtEv/jdeT
	 AjGuEE0BD0ErwoSrkWgUyszCsMsdy3XxLexKeuknhV/vT4Q9G3VSMXtO3gNlYVS4CG
	 Y8mux/1O1KbIg==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7181b86a749so856635a34.3;
        Thu, 07 Nov 2024 15:40:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVc20CmDnCCymDNcuZ2/pNHxvkW6tLiVQbBPi6gmMccxU1+iWm90Btb0J4vIl6hu9M+SfQe+t46@vger.kernel.org, AJvYcCVkVxuSJcpcl6wr+s+lA5vDUQJfv3cif43lx2pWbuxz1bXp+erQ9MdjFgRRw5CL8KADFl0UDK1ps405kw==@vger.kernel.org, AJvYcCWmg46jAsWBCyqKpEtyx2/BNLt7A9WFOsaouH7KaLWWtgbz7G1FZvfxAe/ocrYJAsBT1g6/KIQtn5m4@vger.kernel.org, AJvYcCXy0iWVMcfGXKn3LTB9U5p9UDM1pXYYwXM/dxXaaaoVSAbtw53xnNOSO5pPRz3CMgfqwbjeqrWdF/OXmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVsjOOi7TiwxGPjpDn2QaZf7g1Zl6oSOO/yXfCcV8oSClUO9g
	36KoXH4FQgFhykHY9Lbzzi+FEWO7/Cw4teDzbg5j8I9DNsdqv0ftiYn2SrPaercM03tfZsPiapl
	7cpHfu1XnqICV5PMamyhb+Hi2UxI=
X-Google-Smtp-Source: AGHT+IHKWuBlWup528YXRtoYDX3ha+KeikwAxO/glZHcWGp2+SJF85FWw3Rbw60HdVZKTtvogILp9/cn0Dmbxxn3nHo=
X-Received: by 2002:a05:6870:96a4:b0:286:f74a:93cc with SMTP id
 586e51a60fabf-295600990eamr909683fac.2.1731022851213; Thu, 07 Nov 2024
 15:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025072356.56093-1-wenjia@linux.ibm.com> <20241027201857.GA1615717@unreal>
 <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com> <20241105112313.GE311159@unreal>
 <20241106102439.4ca5effc.pasic@linux.ibm.com> <20241106135910.GF5006@unreal> <20241107125643.04f97394.pasic@linux.ibm.com>
In-Reply-To: <20241107125643.04f97394.pasic@linux.ibm.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 8 Nov 2024 08:40:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9QD5N-mYdGv5Sf1Bx6uBUwghCOWfvYC=_PC_2wDvao+w@mail.gmail.com>
Message-ID: <CAKYAXd9QD5N-mYdGv5Sf1Bx6uBUwghCOWfvYC=_PC_2wDvao+w@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using ib_device_get_netdev()
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>, 
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

On Thu, Nov 7, 2024 at 9:00=E2=80=AFPM Halil Pasic <pasic@linux.ibm.com> wr=
ote:
>
> On Wed, 6 Nov 2024 15:59:10 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
>
> > > Does  fs/smb/server/transport_rdma.c qualify as inside of RDMA core c=
ode?
> >
> > RDMA core code is drivers/infiniband/core/*.
>
> Understood. So this is a violation of the no direct access to the
> callbacks rule.
>
> >
> > > I would guess it is not, and I would not actually mind sending a patc=
h
> > > but I have trouble figuring out the logic behind  commit ecce70cf17d9
> > > ("ksmbd: fix missing RDMA-capable flag for IPoIB device in
> > > ksmbd_rdma_capable_netdev()").
> >
> > It is strange version of RDMA-CM. All other ULPs use RDMA-CM to avoid
> > GID, netdev and fabric complexity.
>
> I'm not familiar enough with either of the subsystems. Based on your
> answer my guess is that it ain't outright bugous but still a layering
> violation. Copying linux-cifs@vger.kernel.org so that
> the smb are aware.
Could you please elaborate what the violation is ?
I would also appreciate it if you could suggest to me how to fix this.

Thanks.
>
> Thank you very much for all the explanations!
>
> Regards,
> Halil
>

