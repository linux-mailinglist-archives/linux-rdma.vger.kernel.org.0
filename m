Return-Path: <linux-rdma+bounces-17893-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CNUMvlhsGloigIAu9opvQ
	(envelope-from <linux-rdma+bounces-17893-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:24:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7AF2565EE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBA493069D4A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA72DC76D;
	Tue, 10 Mar 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dW2GKaP6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B82D8760
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167094; cv=pass; b=BuMYSElN1Wfy5121GgKbwLSPkH7JTdBRqoKP585g6CJnInOK1yd0ULlZR9KVBjaWl3rat7yx9XZEDWPVfPg6WIp2rkQIe7A6ci/QZRLecTucLCQcu2Hyymjugq92eERD9Z/noj5YTSi82bALQpF5Ys9gKtVsRU47nqQfFKbFkmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167094; c=relaxed/simple;
	bh=DNljjTsXDTz9AmTMKJoCY/iqU+57dyRUyrXu/iyiD/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=op5ZAq5/NTohskLwl8WW8aUUo3OkJaZGMLVyu9mPJY6NGm72JPNLA8caF8cMJ8D/vDiaCbs0bMMry2iaw0TSwEDzoDtJZ49weVHEPRLlbpYvKhJvbQtQq9wtFDQ6lw0+cYUVb9MfXLUXO/WYIf0AbLLaRUFOQp+twOZ2RH81DiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dW2GKaP6; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829928e512aso3114332b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 11:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773167093; cv=none;
        d=google.com; s=arc-20240605;
        b=cBbK6Q/WziXmm0nJtsC8xtJESFDKsdqnehsOeOlas2PepkcovobjAHko/UOHSVnJjk
         CQ9BTjNavJvR33Ej4OjDxAQDeeggO8oTdM0difO/6ZEihjd5MPlqaG0N61FhlCSShkXy
         jkqFepFAf0YV3AHq34IlEhwjyXEAqc6Tb2jkvtxvpMAlPNbHPGmVJJkCKTc41FspcmF9
         P39sS8EQMXHaZQ5/dx3dFXX1Py8lYZ1IJt/jPJo6o9EnJlsg7lRr4J7FgP+LPxNeRdJL
         gz3cFtO7w4FY/fH47CzkEz6HaQWfI1kEZULS0moRSNX5iUjeTeA9addWOW3iafAeaPjp
         yiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ow19yV1kpEamONOgB4zylv1tLaNIWkTk676jBhWRO+c=;
        fh=ft7HkOxUvCftD7Hby1sWbPp5UQA7wpNOUHIcFVP3hfA=;
        b=bjKxUR9n1Q6SMvoCQ/WVRHVsFkPLwpqis9UbVH09qErsIK4OALKA/eaaASpkRlMp69
         47JQsu1xnO0HV7nIrYtfWcj45PbEpXP+/pRPVPnIck76WnDEFo0yg5fh59hLlPdAH6pk
         9DK98PA7Z2em/qoFfV0MayFU2VGTQMfbG9LzBp8imfv8CO/8RZsogh5x7ZYg/wS72ily
         ft/zFeBzJP2HibjjM3G0/ywlbJvF02IiuDpRJ2jr8e/OHGXQwGlbKnswTK57698kGfPZ
         Fjic7tFFx6jUNeVYBonvz+BwfC9wqaUwsCwKeQ5Vu7nKhGol93uaJWvUcq0DiXXJOGq8
         5PBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773167093; x=1773771893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow19yV1kpEamONOgB4zylv1tLaNIWkTk676jBhWRO+c=;
        b=dW2GKaP6C4Xh5jwCOkvlNf2RsFsyFhn7kIDaDNyhhxTv4wW2dX9G3sB3B7qUj2R1se
         qYM7SbxmAEpke0lcXjsv5eE+hYERZPCPY+UftYlcX3hJtex9kfplGJny/rzovWrZBPdb
         DOgN4UGI7FnkCp89mG0Eq1U0EHMcRDJxc8SRPJaIP7QHJJCy/laRfc2JV7P+fkMpskUP
         Pdr+cz/Nz+bgpewAskYBrE22SN5V4lrZ5bOFkcUReWlU3G5QrPeYlkf+UbdZnn3NkP4O
         DdNCrkbvPstMRE/svBOL4clE+zOWWhRDwhChyGZgNZVbv1m9uXd2YIaXotxBYYhY4MBQ
         zUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167093; x=1773771893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ow19yV1kpEamONOgB4zylv1tLaNIWkTk676jBhWRO+c=;
        b=cWOeYFdrCOMBg+EN+ZLhur3E9DGZi8Aq3x2MXBWBzt7WF/53sREJ4wirGcURCWMhu/
         p7yCAwbKGSQgkg23oVy/klX1dHinMVhAw8n+TNjmHv3i2q0rIHAWntwgu4uJ7+Wpkg2P
         /VuUaVcgQGRBeckUNUguRbtp7T+aRjQPucn8hxLGnckdxen3Hu8yhmLLe7I30wEpNA+E
         QTyxVaOtwF2EBFiNPKVM6lHx06PgPn9KUKTO2qygaEpi0wDbbfoSLhGOWbTU9UD7PwbG
         P/uyiNDcnZF9G2JwLtvkzKzLHH7gcLVffRJWEPC7NOu+HnSRhmZS4sbwupLxQ6++T3Dz
         c09w==
X-Forwarded-Encrypted: i=1; AJvYcCV/BAFo3vpfgF+0CaGx+rWeZo6NacHIeJI10GlkIT93nV/gUUjdGackWvTJiNE2Xd4S6o9pphKEK1Xr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4C4KOEZ/NTRHL4PWkYgI0dMM+bBLTOR8Ed6zMYH4LqzycWjL
	JSJ4897xLZ1FH9TCfbBZRoHgLn1YsRps1MX7bQwzqa+zjowtHYvLrAYuhc4aHtz7wJxK5m31dky
	N4uSQTtL7KGQSitV4TV4S9BWTj6WoOYQezJIgA4SO
X-Gm-Gg: ATEYQzxhLqyEgFDkLXPGq+P4/OZq1fQBi1iKtbbddxaSDsMveQy/vLMhkoxYM8CJxy/
	IE1cBNlUL41S1HRwhbh/b9/llfiXWOVaUZpBXTdVzbNmYNNfXbkfqTDW7vaWHxc8h19Y+ZP6RxT
	C1UjskucDyQPxbsSa+Pu2elmhjoTf7NPukI7S7A3tFCQyIyREP86akfePgQ43Ogh2aBennTsAJz
	RwX7pXhUFhdpIbVSjYr5RKF3A7+UF5dUBMPg6NrJ7kVHBQWUzHcP/yrE2W8uVmvTgp+nMP5rehw
	KkLZe90=
X-Received: by 2002:a05:6a21:3296:b0:398:4c9f:d970 with SMTP id
 adf61e73a8af0-39858fb5c06mr15668111637.14.1773167092721; Tue, 10 Mar 2026
 11:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal> <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
 <20260310090733.GA12611@unreal>
In-Reply-To: <20260310090733.GA12611@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Mar 2026 14:24:40 -0400
X-Gm-Features: AaiRm50dpMW8dCOCca72DjrFfp-PxzBkUaezLGHSrRR_qVFuX74TYWMkIgzHv8A
Message-ID: <CAHC9VhTKsOYrs8Wh-O548=2gE7N_gkBy+q05+atcR=D+30uQ=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2C7AF2565EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17893-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,paul-moore.com:dkim,paul-moore.com:url]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 5:07=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Mon, Mar 09, 2026 at 07:10:25PM -0400, Paul Moore wrote:
> > On Mon, Mar 9, 2026 at 3:37=E2=80=AFPM Leon Romanovsky <leon@kernel.org=
> wrote:
> > > On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > > > On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leon@kernel=
.org> wrote:

...

> > > > Hi Leon,
> > > >
> > > > At the link below, you'll find guidance on submitting new LSM hooks=
.
> > > > Please take a look and let me know if you have any questions.
> > > >
> > > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#n=
ew-lsm-hooks
> > >
> > > I assume that you are referring to this part:
> >
> > I'm referring to all of the guidance, but yes, at the very least that
> > is something that I think we need to see in a future revision of this
> > patchset.
> >
> > >  * New LSM hooks must demonstrate their usefulness by providing a mea=
ningful
> > >    implementation for at least one in-kernel LSM. The goal is to demo=
nstrate
> > >    the purpose and expected semantics of the hooks. Out of tree kerne=
l code,
> > >    and pass through implementations, such as the BPF LSM, are not eli=
gible
> > >    for LSM hook reference implementations.
> > >
> > > The point is that we are not inspecting a kernel call, but the FW mai=
lbox,
> > > which has very little meaning to the kernel. From the kernel's perspe=
ctive,
> > > all relevant checks have already been performed, but the existing cap=
ability
> > > granularity does not allow us to distinguish between FW_CMD1 and FW_C=
MD2.
> >
> > It might help if you could phrase this differently, as I'm not
> > entirely clear on your argument.  LSMs are not limited to enforcing
> > access controls on requests the kernel understands (see the SELinux
> > userspace object manager concept), and the idea of access controls
> > with greater granularity than capabilities is one of the main reasons
> > people look to LSMs for access control (SELinux, AppArmor, Smack,
> > etc.).
>
> I should note that my understanding of LSM is limited, so some parts of m=
y
> answers may be inaccurate.
>
> What I am referring to is a different level of granularity =E2=80=94 spec=
ifically,
> the internals of the firmware commands. In the proposed approach, BPF
> programs would make decisions based on data passed through the mailbox.
> That mailbox format varies across vendors, and may even differ between
> firmware versions from the same vendor.

That helps, thank you.

> > > Here we propose a generic interface that can be applied to all FWCTL
> > > devices without out-of-tree kernel code at all.
> >
> > I expected to see a patch implementing some meaningful support for
> > access controls using these hooks in one of the existing LSMs, I did
> > not see that in this patchset.
>
> In some cases, the mailbox is forwarded from user space unchanged, but
> in others the kernel modifies it before submitting it to the FW.

Without a standard format, opcode definitions, etc. I suspect
integrating this into an LSM will present a number of challenges.
Instead of performing an LSM access control check before submitting
the firmware command, it might be easier from an LSM perspective to
have the firmware call into the kernel/LSM for an access control
decision before performing a security-relevant action.  This removes
the challenge of parsing/interpreting the arbitrary firmware commands,
but it does add some additional complexity of having to generically
represent the security relevant actions the firmware might request
(this is somewhat similar to how the LSM framework doesn't necessarily
hook the syscalls, but the actions the syscalls perform).  Yes, one
does have to trust the firmware in this approach, but given the
relationship between the firmware and associated hardware, I think
users are implicitly required to trust their firmware in the vast
majority of cases.

--=20
paul-moore.com

