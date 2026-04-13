Return-Path: <linux-rdma+bounces-19264-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCLTCjBJ3GmbOwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19264-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 03:38:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B73E6AA7
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 03:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8D19300A4D4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 01:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C9212554;
	Mon, 13 Apr 2026 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eKE915kT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827633985
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044330; cv=pass; b=jkVA+bBqYJLNQe1Uk/6mpSDGDjluKG1fU8pLlBI6BV8F7OLYy1Q6PxoT36bGb1Is1sJM9fmhGCNxxpj/znGtjP/UFQXZv6tbSqhpp1yErykZ8FSX1KMLO7Wb0dQal9Xed9Slzcg3NsbhPu4+e2/0rqSmk+/ObcZDmLwNWsv+FMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044330; c=relaxed/simple;
	bh=nFQMxFVF63QIAvOySvI+1iQgD3HbEkVh9BhKaGfv3zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg5DetXYpwDERtGPgKBcteVfcnfT5XQ8Cb8B+UJSvrVGztyUOUJ9kMZw47pTvpRvWSqYGPEtpd2h6M6jUK4tioAo9hVyxq8NQJfTiPYltLytaqgqfvtzjHHMRJc1G1Jgztm+j8a5nOyivPIaTuvQR6Nn2ogofLQZjp9yEVm2Oks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eKE915kT; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-358ed696623so1626187a91.0
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 18:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776044328; cv=none;
        d=google.com; s=arc-20240605;
        b=RL6zRbC5L4QmrWZS0ZDCfoyj4v3k6Vs/XWPcf2peeVMUZrTJMb/eut/BdWOamtWXGX
         b8DHP/1AJvPtxP2LjuSxebxwEwyY6LRP0WHSBlxGeTP2nONwf0pxWcLM+yO8Bs0qYnPp
         3xYY3XdUS4RPh94V55CZ+xAgTsUaaIwLAQ4opVSFHQJXxMvEVTBrx3SS0QTaN5RzywD4
         dqD0fOq9zAUQ+kbrcxGeh3WxQ/caWTmSYaLOXvJN7cvG53M0BNpXsWbfb89iiiu1UsIH
         EKot52qntxNFtFol7u2HD3Zx4MlCv/uf5cP1tZvClnYKQ64bUuv/eu3Lap9lSkpDevKt
         dw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        fh=cy3mHjuoyee+m5JaO5RcFamKr/Aau5XzSvANPmgTws0=;
        b=bBmqIbZKpEpp33hJGzPpp82f0dsZXcw0tvq+lVvTgTUnjgnmW7ZyMwlkJyQUiNf5oQ
         dbcafAeLI2LhPounZjQajRBPE+d70iS5Yh3fCp+qO4PmJrEOFq6SBgis/mwHmV+01SjL
         fdCVY1MBYNdU43FRQMHelgT1a9+xtUN1uCxNenvfIZvf04rvU7Uubgpu0RUsm7ty7Sf0
         WfkW/7OcxmHhkiCIz3dw0iIdBuyLX3WS/nIW92pKd4IyEskeANf12zH2ScN7hnEjdhtm
         QSob7ulyFFobQ6e1grP1wIOHVM6zMnq1gHvWn4KyDM+Uy5kShOPSyOighDBzsgYPFQ3T
         zQLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776044328; x=1776649128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        b=eKE915kT3+S+mLQpSv3WJJllJZL/rf+5tW81dTt/VcQBQmgXELrog27o4zy4CEjsoU
         +v3RHtxTvZeZt2a9GAo4Qmr626+pPtGF3BOBmSlcJ8ZBDxC8LM7kCyz4QShBkEC+5w3f
         hOpDkHeIynke8mnG7Z1NnJXU2fC1A5ZHio1CnH4fR887v4rM26xdrha6gmofMI5Duh/N
         E/CAq+/NIBUNICffAMLYY+17nyxZaBuK31dz9PyF7xfHLF2nrXJ3U+ipmQZYS3/FQSFh
         HhDDtTrE02yaipqxGDhtYhVW8CEBlnX58VdF3oDqn6uaZEj/ruFLfnwN7FnCvdXbEBfN
         Tm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776044328; x=1776649128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        b=iRXi+qCl6YvuObHLZqb1RvnZB2/gu5WSeq9NHSF4hVp9sZE2p1jK68PAEcfMilbBW8
         F7Yb/aJjYutHu5SXIZ+mao00lMGw4Usvt1IEEYXEvyJ8RKltxrjpIDT5GWcXKgkD6qCO
         doiLeOxxT4m+5gffylWDaq0//kjeiiuIdKPtJEwRWzo8+RYKv1qjvGmVjPFDK9npfof2
         C3oLlRUjDhDqp691J6WHQYC22YhQk4CziJ+W+m6IyHQ6/TbX6uIZQNq0XYsTHN8tKwgz
         l9eQ4ivNWk4sioZnrU95gTJbpgupXQNWFhmG/NTeMQA1/n1azpKOigUZV9mPGNpUkLM9
         yxPA==
X-Forwarded-Encrypted: i=1; AFNElJ/lSVJ7YNuoWELvGEXwyjPSCLxTTQW8QK+89h1R6yy53udDYDc835KU7lwzhurw6pc/aNYFhe/pBUOB@vger.kernel.org
X-Gm-Message-State: AOJu0YzQs1DW23dGEqu7mNHrSBdUn3fGLTJrQXP2BSm2yuJ6Yr3kX+vB
	qSj8rymSmEwYRQ/oMfSGnnKSliClHvv3JvAmYJIouwrF5O30yL76t9dZqGTw5rFQqiJNE/D8N8I
	XdtvoKPVb6XV44gUF+47NNJhRVpdkkoxjgwpTRfTI
X-Gm-Gg: AeBDieskvdSewT+bkDAXxX4oFXjnNlunac+Fm7BhEuAkUp7bYrqo5cyspavVuoI2YFL
	yqOLIRIo9zwoyRaeMBzF0iu8bPWH5NuC/EJrZdcXWa5wKCqnbz54cUjSgKxlJukCGJDxkEkq/Yz
	k9OZdVmzG+CUBufj9GcwqncEEIjLRJl7EZDpYXQahAwjx6u7uARk91OTGl/enmkH2ZEdIOaOKWF
	+7Rp0IedX7x+Oo+ud8wZLJpqnjLdL5J3aQ/L0irxqK310rIHcWlmqcwpHN+g3JoKIYcACDb2IAn
	cVeyrZc=
X-Received: by 2002:a17:90a:289:b0:35e:58d3:3286 with SMTP id
 98e67ed59e1d1-35e58d3350cmr2477282a91.24.1776044328031; Sun, 12 Apr 2026
 18:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
In-Reply-To: <20260412090006.GA21470@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Apr 2026 21:38:35 -0400
X-Gm-Features: AQROBzAOzVjdc2Fm0JK51NQkLRAYu7tuztXcHDPMGgqzx6OZVzpwqD1l_OckOpE
Message-ID: <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19264-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[huaweicloud.com,kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 808B73E6AA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 5:00=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Thu, Apr 09, 2026 at 05:04:24PM -0400, Paul Moore wrote:
> > On Thu, Apr 9, 2026 at 8:45=E2=80=AFAM Leon Romanovsky <leon@kernel.org=
> wrote:
> > > On Thu, Apr 09, 2026 at 02:27:43PM +0200, Roberto Sassu wrote:
> > > > On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> > > > > On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:

...

> > > We implemented this approach in v1:
> > > https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidi=
a.com
> > > and were advised to pursue a different direction.
> >
> > I'm assuming you are referring to my comments? If so, that isn't exactl=
y what I said,
> > I mentioned at least one other option besides
> > going directly to BPF.  Ultimately, it is your choice to decide how
> > you want to proceed, but to claim I advised you to avoid a LSM based
> > solution isn't strictly correct.
>
> Yes, this matches how we understood your comments:
> https://lore.kernel.org/all/20260311081955.GS12611@unreal/
>
> In the end, the goal is to build something practical and avoid adding
> unnecessary complexity that brings no real benefit to users.
>
> > Regardless, looking at your v2 patchset, it looks like you've taken an
> > unusual approach of using some of the LSM mechanisms, e.g. LSM_HOOK(),
> > but not actually exposing a LSM hook with proper callbacks.
> > Unfortunately, that's not something we want to support.  If you want
> > to pursue an LSM based solution, complete with a security_XXX() hook,
> > use of LSM_HOOK() macros, etc. then that's fine, I'm happy to work
> > with you on that.
>
> The issue is that the sentence below was the reason we did not merge v1 w=
ith v2:
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm=
-hooks
> "pass through implementations, such as the BPF LSM, are not eligible for
> LSM hook reference implementations."

I can expand on that in a minute, but I'd like to return to your use
of the LSM_HOOK() macro and locating the hook within the BPF LSM as
that is the most concerning issue from my perspective.  One should
only use the LSM_HOOK() macro and locate code within bpf_lsm.c if that
code is part of the BPF LSM, utilizing an LSM hook.  Since this
patchset doesn't use an LSM hook or any part of the LSM framework, the
implementation choices seem odd and are not something we want to
support.  As mentioned in my prior reply, you could do something very
similar though the use of a normal BPF hook similar to what was done
with the update_socket_protocol() BPF hook.

There are multiple reasons why out-of-tree and pass through LSMs are
not considered eligible for reference implementations of LSM hooks.  I
think is most relevant to this patchset is that an out-of-tree hook
implementation doesn't necessarily require a stable interface, and
without a stable interface it is impossible to make a generic API at
the LSM framework layer.  As you mentioned previously, each vendor and
each firmware version brings the possibility of a new
format/interface, and while that may not be a problem for out-of-tree
code which is left to the user/admin to manage, it makes upstream
development difficult.  I did mention at least one approach that might
be a possibility to enable upstream, in-tree support of this, but you
seem to prefer a BPF approach that doesn't require a well defined
format.

> > However, if you've decided that your preferred
> > option is to create a BPF hook you should avoid using things like
> > LSM_HOOK() and locating your hook/code in bpf_lsm.c.
>
> We are not limited to LSM solution, the goal is to intercept commands
> which are submitted to the FW and "security" bucket sounded right to us.

Yes, it does sound "security relevant", but without a well defined
interface/format it is going to be difficult to write a generic LSM to
have any level of granularity beyond a basic "load firmware"
permission.

> > The good news is that there are plenty of other examples of BPF
> > plugable code that you could use as an example, one such thing is the
> > update_socket_protocol() BPF hook that was originally proposed as a
> > LSM hook, but moved to a dedicated BPF hook as we generally want to
> > avoid changing non-LSM kernel objects within the scope of the LSMs.
> > While your proposed case is slightly different, I think the basic idea
> > and mechanism should still be useful.
> >
> > https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com
>
> Thanks

Good luck on whatever you choose, and while I'm guessing it is
unlikely, if you do decide to pursue a LSM based solution please let
us know and we can work with you to try and find ways to make it work.

--=20
paul-moore.com

