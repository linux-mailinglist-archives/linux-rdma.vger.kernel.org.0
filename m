Return-Path: <linux-rdma+bounces-17916-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFn0OTuQsGkukgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17916-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:42:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E72586B2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A993230F3A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1213D88EE;
	Tue, 10 Mar 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UlqSAmZr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD43EF65E
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178816; cv=pass; b=NJkdUO9JXz6lsu25xGvK7mJTD9C6gMxKm5rj5r1inlWToskE3JEYyuBGXJaWcIHZzdnswNrxwN8jDEGoTrSrSKofqA2LAyBatdkf1Z6C/Ycqmrp8TtTq9IWa/KENrhzYT/Irr5LTfdvTYeo+BBlxr9MsMc8bO+pmePz7x2/XShE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178816; c=relaxed/simple;
	bh=Ur/oOiJioVSUtc+YFvCGlJNcWs35D1mOgLE4Auf4bWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv2uvPNSLLJ6NitWta/b/4E2aPrsedGnOsCaZAb6gqzPHixMcw2sEGyGyaDB1I2LQy9ej5V6lbt77vFM2EKB6CoRyCyAlBZl7GOQ1VeHJcuLsxmCI89XxtAxBmkAVAXKRlS6rj2M3cGyPl9G8lyGwee1GHE8prZsURLfdCHw3jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UlqSAmZr; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aae146b604so95337185ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 14:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773178815; cv=none;
        d=google.com; s=arc-20240605;
        b=a7xlhbfzSVrdYins4ugYLgjConmBeyWj+0eLbYHJN2RdfUOwhyeFDt5KbCj1Xzaazu
         ypBdTw0ravlGXX/yA7Bm2J5WM+ftXK74Xq8OeW9KpUUJbT03FWX5M+mhUCN/B5AaVO7h
         2v5KcNrKQWZUCA+KTFNo0ZMMIp9oYvbGTXZrwiK49uHGlog0Goo+finB4+gFQtiiiUuv
         Fw0yEmUNoAQl0OZSZrelNN/e5ZlvcpeFezzyUr6NK0xc0vSeqfYmpM+slZKM37zSoTMa
         9oUmoGwTwL8FMr4TgR4tXhzQzCrm9zyZMsvO8MMKrgi7E+U6/ZkXCQkFEi+3FNFc4HCJ
         8OQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LwDQFIDEcznEldWRxVlmfk0rWnU3Lda6oDe6A/JW9p0=;
        fh=8ub4skd/eUMobos0NYWmtUBFnVgQTCNA96EpTgK8IhI=;
        b=dgJ7KoWP5FMG32msbEbErtV1KJbgsQBLPIuf2kx/y+/ltCJE/4xZwX4v+srhBAVheG
         hyKFbNbVHHbl8ITn9e9fzzgqJtkKIybAbigh+ZHj+t79Hs/UEgPK+D11Ov+XZGEV4k2t
         srt8iPzsVOUKMjDssypPWR+ona0QQ5ufmx22SfjOGvFaMR8u75VbMznUjYno1ndrErjA
         RMekF3zfrapMmckP/heubq3o1S353gtVm/9qzOtHwnon8bpJ89e0rGkZpBtNMUjEmTXG
         Dejba9+9U+mJiOGHR+iygtZ85gSb6I4fN7rrjuGQ71LIshtvNCWhe3lOZ09CXSAHwqAK
         jk3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773178815; x=1773783615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwDQFIDEcznEldWRxVlmfk0rWnU3Lda6oDe6A/JW9p0=;
        b=UlqSAmZrFRrtMkBjswVwK6LLEn3veVJRlG9ROVv52vZpkUhC8jpuF6QuQFa8JiWK90
         /WuF1DHlUb50R4KC/o6Ez1FUPXdUCLdTiHAZrCD1YWwXpz/jDhfd7bel+8M9tJVT3HZP
         ZTWBjQB/wy7HKlDRorKA9a35RgpN50mKai96f6HARJUoPRVHlptumH+z3GIrtlEgSaTK
         e1PbSVK6DKgChne/4RTyPtvRMGoojU7Z08lilMIrMZ5lpwhtYNIVQn65rg3vhB0us67V
         tpJOb+rQXDsGJqsSSEsCEvDF54IKPq+wADxBGJlFx9GIXwwlzoarcIKkuRkOpQkjVK9a
         mkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178815; x=1773783615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LwDQFIDEcznEldWRxVlmfk0rWnU3Lda6oDe6A/JW9p0=;
        b=rhVcFcLO86/aUo0t5B3KhC6TwVWdCUtp3XlMxDRYkUafszrbzGoj+rpc/VbMZ4h5Fa
         H6qmirzfgXMX0fxawKP18VMjcVbof7AmpOwL6CBB/G93vZ8yygT0SjTLtl8d++vmko9c
         8JgAWqNgJU+6rajE4TK3039t/7V7QgzBIZCF+ZMPVHwxGpVz4MbwFYIoHAvq2WyPSm/f
         Mu+a572un8dHXBaBJTvk7ir3Dbn687QIA0Eoss6P7sORgvNh6hgLP/HNkJ5dV0SmVFPP
         YT7hRCKmouL3xjkEM4TbRTFzJyTElbAsrXe4i4aB5ACMA8Q/0oosHOK1S5eIU0MaW4+G
         46sg==
X-Forwarded-Encrypted: i=1; AJvYcCU65l9tbz1QWXYGvTdyeJPs8b3/ei3gEc7WMe1I6SYtO2VjeLwICkBgkLk05k+gPZToManiHRygEKHk@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnwjssaPIMoATflYnpIZlJs3bgMDsvct7eVESZGA7J0DKmZit
	BEko5HL3UPFFAvTUEit4A+3kwOEwQsJTKkmfAIX9SqTFO7afPuFC2HnHKqrtPSuVwuwcUUpLBt9
	CmsGD1IQJ0ZcxaX5rCqwS8j3AivZY/3oNHwTg1Zjx5yWaPOvac9Y=
X-Gm-Gg: ATEYQzztVGMh5bvk0gj3ZrpiE+jKPH+KC8daHkbvCL5U6ZWqIch49V6JV839FKvQH++
	ROLmKZFmjr1/NgvHXHl5SYGheC23gZqF38JOxZP1YgL/AmCer6DyfqkqlLyNyG7JBvF87y5+Q7C
	boqBMEMF++/Sq4uKY/QZQwqhwm6ay6b37iLw/C+MLB6eOlfstwdK7r9VdY9pq3i/gF8dc1gsc1D
	u79qikhlib052BF/s8geyBt5u0PGqrmr9+Ulno8sxb9O33C3Iuyw6r8AzQW6rVt2zcFkcgaWdLy
	6LuWR+M=
X-Received: by 2002:a17:902:cec1:b0:2ae:5426:da3f with SMTP id
 d9443c01a7336-2aeae8588demr2810015ad.28.1773178814554; Tue, 10 Mar 2026
 14:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal> <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
 <20260310090733.GA12611@unreal> <CAHC9VhTKsOYrs8Wh-O548=2gE7N_gkBy+q05+atcR=D+30uQ=w@mail.gmail.com>
 <20260310193000.GM12611@unreal>
In-Reply-To: <20260310193000.GM12611@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Mar 2026 17:40:02 -0400
X-Gm-Features: AaiRm52Jj19K4Bao4t5KT5PLu-pdK7gUrebczrdDo6_ONMvwkckflBrJZIIsFNk
Message-ID: <CAHC9VhSh8A+yGHT_+BqFGaLNqsZDcaz_cuqf9A+neRQQ3PMY4A@mail.gmail.com>
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
X-Rspamd-Queue-Id: 604E72586B2
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
	TAGGED_FROM(0.00)[bounces-17916-lists,linux-rdma=lfdr.de];
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

On Tue, Mar 10, 2026 at 3:30=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Tue, Mar 10, 2026 at 02:24:40PM -0400, Paul Moore wrote:
> > On Tue, Mar 10, 2026 at 5:07=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > > On Mon, Mar 09, 2026 at 07:10:25PM -0400, Paul Moore wrote:
> > > > On Mon, Mar 9, 2026 at 3:37=E2=80=AFPM Leon Romanovsky <leon@kernel=
.org> wrote:
> > > > > On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > > > > > On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leon@ke=
rnel.org> wrote:
> >
> > ...
> >
> > > > > > Hi Leon,
> > > > > >
> > > > > > At the link below, you'll find guidance on submitting new LSM h=
ooks.
> > > > > > Please take a look and let me know if you have any questions.
> > > > > >
> > > > > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.=
md#new-lsm-hooks
> > > > >
> > > > > I assume that you are referring to this part:
> > > >
> > > > I'm referring to all of the guidance, but yes, at the very least th=
at
> > > > is something that I think we need to see in a future revision of th=
is
> > > > patchset.
> > > >
> > > > >  * New LSM hooks must demonstrate their usefulness by providing a=
 meaningful
> > > > >    implementation for at least one in-kernel LSM. The goal is to =
demonstrate
> > > > >    the purpose and expected semantics of the hooks. Out of tree k=
ernel code,
> > > > >    and pass through implementations, such as the BPF LSM, are not=
 eligible
> > > > >    for LSM hook reference implementations.
> > > > >
> > > > > The point is that we are not inspecting a kernel call, but the FW=
 mailbox,
> > > > > which has very little meaning to the kernel. From the kernel's pe=
rspective,
> > > > > all relevant checks have already been performed, but the existing=
 capability
> > > > > granularity does not allow us to distinguish between FW_CMD1 and =
FW_CMD2.
> > > >
> > > > It might help if you could phrase this differently, as I'm not
> > > > entirely clear on your argument.  LSMs are not limited to enforcing
> > > > access controls on requests the kernel understands (see the SELinux
> > > > userspace object manager concept), and the idea of access controls
> > > > with greater granularity than capabilities is one of the main reaso=
ns
> > > > people look to LSMs for access control (SELinux, AppArmor, Smack,
> > > > etc.).
> > >
> > > I should note that my understanding of LSM is limited, so some parts =
of my
> > > answers may be inaccurate.
> > >
> > > What I am referring to is a different level of granularity =E2=80=94 =
specifically,
> > > the internals of the firmware commands. In the proposed approach, BPF
> > > programs would make decisions based on data passed through the mailbo=
x.
> > > That mailbox format varies across vendors, and may even differ betwee=
n
> > > firmware versions from the same vendor.
> >
> > That helps, thank you.
> >
> > > > > Here we propose a generic interface that can be applied to all FW=
CTL
> > > > > devices without out-of-tree kernel code at all.
> > > >
> > > > I expected to see a patch implementing some meaningful support for
> > > > access controls using these hooks in one of the existing LSMs, I di=
d
> > > > not see that in this patchset.
> > >
> > > In some cases, the mailbox is forwarded from user space unchanged, bu=
t
> > > in others the kernel modifies it before submitting it to the FW.
> >
> > Without a standard format, opcode definitions, etc. I suspect
> > integrating this into an LSM will present a number of challenges.
>
> The opcode is relatively easy to extract from the mailbox and pass to the=
 LSM.
> All drivers implement some variant of mlx5ctl_validate_rpc()/devx_is_gene=
ral_cmd()
> to validate the opcode. The problem is that this check alone is not suffi=
cient.
>
> > Instead of performing an LSM access control check before submitting
> > the firmware command, it might be easier from an LSM perspective to
> > have the firmware call into the kernel/LSM for an access control
> > decision before performing a security-relevant action.
>
> Ultimately, the LSM must make a decision for each executed firmware
> command. This will need to be handled one way or another, and will
> likely require parsing the mailbox again.

As it's unlikely that parsing the mailbox is something that a LSM will
want to handle, my suggestion was to leverage the existing mailbox
parsing in the firmware and require the firmware to call into the LSM
when authorization is needed.

> > This removes the challenge of parsing/interpreting the arbitrary firmwa=
re commands,
> > but it does add some additional complexity of having to generically
> > represent the security relevant actions the firmware might request
>
> The difference here is that the proposed LSM hook is intended to disable
> certain functionality provided by the firmware, effectively depending on
> the operator=E2=80=99s preferences.

My suggestion would also allow a LSM hook to disable certain firmware
functionality; however, the firmware itself would need to call the LSM
to check if the functionality is authorized.

--=20
paul-moore.com

