Return-Path: <linux-rdma+bounces-17835-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LGAG09Ur2mYUQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17835-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 00:14:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A582429BE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 00:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6603B3145B07
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 23:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC763BA24D;
	Mon,  9 Mar 2026 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Di2XWOaz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF2298CB2
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097840; cv=pass; b=MUaxz83XHznKH4iJflUGftvd9bXwP+SiIPvHh69MClVhKonVt3OWHz6iMOkmXsfGwu0jDSbJf7Kj9RijH0Lw1aY0pj6mNKRF1wDvub40PjKtzEIiVB614X8lonazPz49xHodHCec6WgIEghSpgjsgtZ1JLalXmwws8gbrwev/es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097840; c=relaxed/simple;
	bh=guYTRTIV07tIVXdrecWKFPe8mBR75tmplTw1gLdq8E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVrBG2QEkL+FWsWR1lyEn/ryq6gtlaUJJj3ZoctlT2qpZadUPqap88YpjOnJ50L42gK6WjCbVJt7+vveKF7kZMYBwS97frB1LmiAJbJCnFg8vSiNYnWpYXbQtl+QFIPvB8ZmpND+xqxizYNBr3y6nj8qMl20BKu61bZlbocjyEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Di2XWOaz; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adbfab4501so54118695ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2026 16:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773097838; cv=none;
        d=google.com; s=arc-20240605;
        b=N2rwwu+z721goson9Bk6PIt48oLhJuSXYIKSSUd+C96HkinXaqtHI6G6Nx1JpVAHYw
         GTDrmgiaCmNHPF+Zy0pSIHaWb7l2YsgdqDQTjejqwnlHXOx6mH05rm7MKa8dLT5CI0jq
         Q+fN5Evd011JEKEYcJt5+fUdxZBVQD4TTDcHhoZgU75KUP1d7jRrgGA85cxzRjCGg24G
         kpAjIM9V3dqn/ZoCveaf5Or5+7ek+sHMlZFszMVH0ICFGbH3rHEc+283xTLRSgpEpQ/u
         TNjrbG/bFX3berFYIUbQgQAzdLd9VndoJoFCLjRqY/02+U0sLIBsvDZ4MSYvJjg1vPg8
         LEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ganXn/aKh/jYswvsKTbptfBmhWROPWX8eZLsZsMWaX4=;
        fh=JnSOIGs3E7Plru2v5bZ2B4DixXfal3LH0lrW4mTFtK0=;
        b=abj6qgG36OaPVnXRJvMk6aqiAMqhOV0U+/jUcZz7lWSQrzF91qDCVLLxe2tJNXDOem
         3BhHZq8v9M/2oTeo1Dq5Qm7U09FoUpb95kdmwTpgS+DC+g2p/WnH5PknkDcTQpqrABtc
         V7aFsOjSRQxkQlxDR7vaS56zKLf+GsJse99hNJeRlfN2S5D9m/rhUrg7OH8FmF02quhU
         X3Txgv+u5CiTGQuBUcCQQ3MuD+qGF9GbATLpR2ZuC8i3rXda4JbV4vioIgFBiyH4mC0i
         dQ88pVz/QrNR+nOyqXojPtk7bDv7FxxHN/YKanl5yYRYynU3Ty0uBUWIxn9VSoomGAMG
         WW8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773097838; x=1773702638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ganXn/aKh/jYswvsKTbptfBmhWROPWX8eZLsZsMWaX4=;
        b=Di2XWOaz1EvLd+vI95sTWqA8i42y6DJh0I11hubVjLTwKyi4WUCDEkjjx041RCILc9
         pawx47A0jN2Mbf6aKeFytXlgPt6PUXMO7HeRHmfJRVoesArSNPUoQXbV7gPXWuH9Rzrf
         DAOfoxz6NxlCvpIIDQhA7OZ56CbcYamlnOy2uNCnsd/pDBi8B9ODUdvejT2tueGE/G+p
         c+Ll0H1CpM+pZS5hRtQnRZAQSmgt6HNEUMp9m6oPdceP2mekpMrzgpLblEtdMYR8bdBT
         15hVO+ULHsYDb4MiMPtisCM+HZyHNBO9qint1CRcSao2OGIlUi0Z/p9F4xn6ij+6buWt
         kTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097838; x=1773702638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ganXn/aKh/jYswvsKTbptfBmhWROPWX8eZLsZsMWaX4=;
        b=hwhBez9ZKc0Y6tzOGnazSfQuSpHZ302MRnGTNTVci0GyEfdyEcxI6xtjpcRDsRwEQP
         ajlTAGPfY2RDmPkJXKyp/Hi5vCdrLUGqNqjg86yksfg+3suZSoI3w5KNEqnTSAyDUww4
         UzGJ/yjNSyJ5vtC/9KlnVvfA1dRxQoVVM+8ubEfF/6V26Jl3dyGg6BAQX984LYyH9g54
         Synm/+uOIG1fhl/fTcCVOxTnpg+/rhxCMY1ZILoCH5wGxxcr3Q3RHYTtmCfiz+bY5mLZ
         Knsb2NCj7xpnB0JWxsj3nM+hiNome12Aifzl+wm0py89cEmpOsprB2PTTGrBcye8e04T
         b5CA==
X-Forwarded-Encrypted: i=1; AJvYcCVFrZt9myCaoTlK0O9z1aT1BfN5JX5ART2UspWYYWAcXwy2hUZdEhwE9uwijhFfsD1tXPg7y+/kGUY1@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuzWucLG84bEGxldfQnikDqvihchnOknRFpLgsHmq0trsE+cC
	OEikglrJUYSQCCWjtcsrzMTjANCTSiPNbv8zdAHr3TE/EjMDeaMq5B6VkCGN2mtlqSz5lA8KPIO
	ZCNve2vkbVdCvnHfIPBRMSR5BMfxFOVxcyJX8Oyt2
X-Gm-Gg: ATEYQzwOFjVSPaEO38meZb/GfSlOk8ysvgShRFucZQ/2ndMD08tAYtznJ6002oEgYLx
	hbQCra76CwhdzBfpsyujDOFP2SLERoqVBl7g6ipQ+ZgJO4joK5cR7xCGB4Kf5Tbz1s5yUWrtbqO
	0A3XED9c/BtthRRm4t+0l6VQp8Jc+Tdok/ddypAn6RUtICJVwznQgGz6a4YEDpFsQNsgVvPD8Z2
	y9iMF6RCLMtwZpL2mPVeM0IQs0UdQ16PdlIf3/mPlg8WpxpKeHJfbxhVhK2vX9vfPnexBwec/ZW
	jT3dTDNt6lVU1wecjQ==
X-Received: by 2002:a17:902:d2ca:b0:2ae:4445:f39a with SMTP id
 d9443c01a7336-2ae823681demr128912475ad.7.1773097837652; Mon, 09 Mar 2026
 16:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com> <20260309193743.GZ12611@unreal>
In-Reply-To: <20260309193743.GZ12611@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Mar 2026 19:10:25 -0400
X-Gm-Features: AaiRm535xFpxdgvR-5FzqjZOmCULmHkHTB-IpoDK9Z417AAIc646ZPqFW7lnHx4
Message-ID: <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
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
X-Rspamd-Queue-Id: E1A582429BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17835-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 3:37=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
> On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leon@kernel.org=
> wrote:
> > >
> > > From Chiara:
> > >
> > > This patch set introduces a new LSM hook to validate firmware command=
s
> > > triggered by userspace before they are submitted to the device. The h=
ook
> > > runs after the command buffer is constructed, right before it is sent
> > > to firmware.
> > >
> > > The goal is to allow a security module to allow or deny a given comma=
nd
> > > before it is submitted to firmware. BPF LSM can attach to this hook
> > > to implement such policies. This allows fine-grained policies for dif=
ferent
> > > firmware commands.
> > >
> > > In this series, the new hook is called from RDMA uverbs and from the =
fwctl
> > > subsystem. Both the uverbs and fwctl interfaces use ioctl, so an obvi=
ous
> > > candidate would seem to be the file_ioctl hook. However, the userspac=
e
> > > attributes used to build the firmware command buffer are copied from
> > > userspace (copy_from_user()) deep in the driver, depending on various
> > > conditions. As a result, file_ioctl does not have the information req=
uired
> > > to make a policy decision.
> > >
> > > This newly introduced hook provides the command buffer together with =
relevant
> > > metadata (device, command class, and a class-specific device identifi=
er), so
> > > security modules can distinguish between different command classes an=
d devices.
> > >
> > > The hook can be used by other drivers that submit firmware commands v=
ia a command
> > > buffer.
> >
> > Hi Leon,
> >
> > At the link below, you'll find guidance on submitting new LSM hooks.
> > Please take a look and let me know if you have any questions.
> >
> > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-l=
sm-hooks
>
> I assume that you are referring to this part:

I'm referring to all of the guidance, but yes, at the very least that
is something that I think we need to see in a future revision of this
patchset.

>  * New LSM hooks must demonstrate their usefulness by providing a meaning=
ful
>    implementation for at least one in-kernel LSM. The goal is to demonstr=
ate
>    the purpose and expected semantics of the hooks. Out of tree kernel co=
de,
>    and pass through implementations, such as the BPF LSM, are not eligibl=
e
>    for LSM hook reference implementations.
>
> The point is that we are not inspecting a kernel call, but the FW mailbox=
,
> which has very little meaning to the kernel. From the kernel's perspectiv=
e,
> all relevant checks have already been performed, but the existing capabil=
ity
> granularity does not allow us to distinguish between FW_CMD1 and FW_CMD2.

It might help if you could phrase this differently, as I'm not
entirely clear on your argument.  LSMs are not limited to enforcing
access controls on requests the kernel understands (see the SELinux
userspace object manager concept), and the idea of access controls
with greater granularity than capabilities is one of the main reasons
people look to LSMs for access control (SELinux, AppArmor, Smack,
etc.).

> Here we propose a generic interface that can be applied to all FWCTL
> devices without out-of-tree kernel code at all.

I expected to see a patch implementing some meaningful support for
access controls using these hooks in one of the existing LSMs, I did
not see that in this patchset.

--
paul-moore.com

