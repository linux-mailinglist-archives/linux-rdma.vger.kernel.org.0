Return-Path: <linux-rdma+bounces-19356-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA4eNF2n3mlIHAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19356-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 22:45:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 655263FE6DE
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 22:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF88D307AAF5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BCE34D4F9;
	Tue, 14 Apr 2026 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mq38fDxg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63334D384
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199479; cv=pass; b=fGxT3CFCHP8/kkdGldZr6DcIMn50YFQuse+n4hTdShZMCUHVGFoQ9SFnSCHm8foFFnqWOg/BDSP8d1Ud4TFuZTsYJphlDBhH2OsYtWhsB0tY2D/T/DyIgxx0PWduQaO12megEl6Y9jRCmguk4NNTVaNYEc7FgA18bHkQExBnefw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199479; c=relaxed/simple;
	bh=aQ0aNEU1NKIVhrIy+q01cYGQ+H3qfAr9fLe4K4e+a7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSD2V1u7WkCGD3TGVb368F0S+78ihPIjQsktqL60M3INUK9gZY+V/ZPw8OsVgImF+LhzREQBLAcuiwL7B8SKRTtdtbJd2aiMoAuqCHCt84hRAnqT7VQrmN1tg0YfUiaSBPhPgYJtVjF7H3gONEyx247r7lacL+1mRnCN1TWqJlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mq38fDxg; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so3510937a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 13:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776199476; cv=none;
        d=google.com; s=arc-20240605;
        b=OJvG0zGJILZxAU0QzOt+yVQuNdeeNPAY3skyVj5MCb+M2ckeHxB1hrNwK/DyoV8Bzv
         U8AsZUUUdDpiYUKDgD4ETfxi/VWx9N58tb+2McbXtV+QstaT/igd2WJ+C+huuIvI/gJy
         duiqXiqTALa22e65Rw5Wrtd7gZnImJNkR0sCRWF0pIZl9UQt4BKQGPW36WnWHL1ogl31
         NPorAbtrc0tNQEPxPQ0+3phnjJxE+I1KmvJ9HHzr+LtbyCaimXS4cKGXKiHQrtG3gPKC
         SxjY16+ZnEcP9bJ6ry7Veki7PnQzAobOEsvUXaXEDsM4++5zITazLFWqXIxjftA7wzSy
         9MzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NK52TA8NFT/IbeGeLW1RBad6qmXIJT5VQoTcm/weixc=;
        fh=SJVk/pKdwakSWfh2OfmscFg9wStW8NMM9avrIfQCKTc=;
        b=gaYnEpmTDA4opSCdVt1QEOkKeQgWaqtOMfl2mFiooHsgSm2YoTUy34ODwDCJ/OIDMP
         WVTg0Ew1Dc/suxEtsM8bcMYKiIV/I9/GbmV2gRvktieVQ2RDRREF0QmKXRHuvJQG3WTM
         ItpbmAGDPIrT5Fae4aWEOQPS5Hy6RUHquXbFdfgaRK+5aa7LFMlfRfcz7VskdSFMzR3i
         P0F9ytujVtaUIFiMbTCsU4AX6JCB/yqX2/yURzKi5rEssXBzrEhIwZbmCVkBjS1sua5W
         0QOoMpMmSBsXjWigZVgF7bIQQARygv5kn3PDFAk/lg+fdcPgFrgFkC81iQ9Sd6yFHtdl
         3H7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776199476; x=1776804276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK52TA8NFT/IbeGeLW1RBad6qmXIJT5VQoTcm/weixc=;
        b=Mq38fDxgkRfbZriNhJABnogX4gz7zpqK0Au2qqDIFMX2ogbyvFEPsYjnLGTXlpO2Si
         lW1aaS5H/r2peKduY50ri7h0VcaUV0dGMn2HR0TTNrcnMkksZEb+CN4/ZJprW6ZTc4sV
         vDqSqP5yGnHQEepEQe2byxcoIpBgAabX4QoRoIe2qY4uAaWo9Fv/fdL+xrYqespMfRhr
         CepcKaXSgv+DM7QAAW1CNNtc4sdRDzW+5zSK4iYBZ6Nm4drYrkQ5E7YWpiw2IGT81Y8U
         FRklGCDNW+FbZIMM4Va/IH57P7gti6geKYN7jVTnAu2yrwx6o52NsPoEPbRpdXGQpQzN
         XR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776199476; x=1776804276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NK52TA8NFT/IbeGeLW1RBad6qmXIJT5VQoTcm/weixc=;
        b=ESDLba4qSuyyO02boPtWXYf0ieRQfYSog80JPEc12nqdkDLw9zxiYR1rRbbS40FOE/
         n+Nn3LMah0i1Hz39fGN53VdBoueQGmkd0bmj8ixKs7QTbCO85EJQvW2A+3ufdI0fbUmX
         t+iOps4Ahvoq2sILYE7WvciZt19cYG+tM6TLbBy3hu+2poLR1Q5mqBvoG7JMdP/OiMpL
         6tXE7CylLC6WResFQcw5vZJgbkJsVYZxmK2ysZr7K5D6DSC5H6Qoi/PbzpT/zvKyzXE2
         tzo51y/CrMZVIdOtxzrbm4KLjv2XPMu/xGEYN5O/77hFzL170FlM+86M64BJ1hCi2ozE
         eg+g==
X-Forwarded-Encrypted: i=1; AFNElJ+WLWnvBkg+MXfgo/uKIevhojoKEzZVaS1KOJVdAcc0BgWYza8EsA6TuXsz5yhTIwe8ndkYjtrxOVbZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGQRBeQWhYv3oWCjV6fIQDmu90ggemO/jL2Ncx7j8PHsoTMd+
	K3NhmVpupOMDuIkwwynnERFznfQY8GSC1bTEZwid/wmtnozt0PQ2hf1hdrCPWQUHO9gU6zmvZPM
	ZdwG+bK2wAU+eDSVn4VgCVPYSGh6CLfsh+OIQq6N1
X-Gm-Gg: AeBDieuLVWote5c8bG578imYUJ61riWBgmKQ72gD2bWBQ35Q15XEpZvn12k430i6EL8
	1sp4sAtIuFLbtGzNvoA7fQ8W3GhQGNj8poMlNofK77w0ENMqdzRS/ugRcp0AO4Nl5Ukw/GHrCkR
	rKpBeLtfVFQnLcl7VRXH8EUPNbDgJk3/K2v+uuyte/bETLzAslh5xp14po7WMieTP6PxKIUoCaj
	aLe8CvQGLyXiNSQfN16XHLZZuUpGO5QJy2b1vAMJoXB9mhUlXLwNaLyNMqZjSm5t1Pc1S+/K+AJ
	jpbCPps=
X-Received: by 2002:a17:90b:4d0e:b0:35c:b02:b5c1 with SMTP id
 98e67ed59e1d1-35e4254fa24mr18173516a91.2.1776199475615; Tue, 14 Apr 2026
 13:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
 <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com> <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com>
In-Reply-To: <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 16:44:23 -0400
X-Gm-Features: AQROBzCEfz_j_XIQqt_9SrRpougQ4lYANU563js1WLhMuxDlob1XiduX3tGAPf0
Message-ID: <CAHC9VhRoaECt03Rs-ZyoGhW2_qZkA_1weTYYjiXc41Yf5U8A_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19356-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url,schaufler-ca.com:email]
X-Rspamd-Queue-Id: 655263FE6DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 4:10=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 4/14/2026 12:09 PM, Paul Moore wrote:
> > On Tue, Apr 14, 2026 at 1:05=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:

...

> > For those of you who are interested in a more detailed explanation,
> > here ya go ...
> >
> > NetLabel passes security attributes between itself and various LSMs
> > through the netlbl_lsm_secattr struct.  The netlbl_lsm_secattr struct
> > is an abstraction not only for the underlying labeling protocols, e.g.
> > CIPSO and CALIPSO, but also for the LSMs.  Multiple LSMs call into
> > NetLabel for the same inbound packet using netlbl_skbuff_getattr() and
> > then translate the attributes into their own label representation.
> >
> > Outbound traffic is a bit more complicated as it involves changing the
> > state of either a sock, via netlbl_sock_setattr(), or a packet, via
> > netlbl_skbuff_setattr(), but in both cases we are once again dealing
> > with netlbl_lsm_secattr struct, not a LSM specific label.  Since the
> > underlying labeling protocol is configured within the NetLabel
> > subsystem and outside the individual LSMs, there is no worry about
> > different LSMs requesting different protocol configurations (that is a
> > separate system/network management issue). The only concern is that
> > the on-the-wire representation is the same for each LSM that is using
> > NetLabel based labeling.  While some additional work would be
> > required, it shouldn't be that hard to add NetLabel/protocol code to
> > ensure the protocol specific labels are the same, and reject/drop the
> > packet if not.
>
> Indeed, we've discussed this, and I had at one point implemented it.
> The problem is that for any meaningful access control policies you will
> never get the two LSMs to agree on a unified network representation.

That is also not correct.  In the early days when SELinux was first
being used to displace the old CMW/MLS UNIXes NetLabel/CIPSO was used
to interoperate between the systems and it did so quite well despite
the SELinux TE/MLS policy being quite different than the CMW MLS
policies.  Yes, there were aspects of the SELinux policy that made
this easier - it had a MLS component after all - but they were still
*very* different policies.

> SELinux transmits the MLS component of the security context. Smack passes
> the text of its context.

Arguably the NetLabel/CIPSO interoperability challenge between SELinux
and Smack is due more to differences in how Smack encodes its security
labels into MLS attributes than from any inherent interop limitation.
In fact, I thought the "cipso2" Smack interface was intended to
resolve this by allowing admins to control how a Smack/CIPSO
translation so that Smack could interop with MLS systems, is that not
the case?

> Unless the Smack label is completely in step with
> the MLS component of the SELinux context there is no hope of a common
> network representation. If a *very talented* sysadmin could create such a
> policy, you would have to wonder why, because Smack would be duplicating
> the SELinux MLS policy.

Interoperability wouldn't be a problem if everyone the "right" systems :D

> > Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
> > require some additional work to convert over to a lsm_prop instead of
> > a u32/secid, but if you look at the caching code that should be
> > trivial.  It might be as simple as adding a lsm_prop to the
> > netlbl_lsm_secattr::attr struct since the cache stores a full secattr
> > and not just a u32/secid.
>
> Indeed. But with no viable users it seems like a lower priority task.

You need to be very careful about those "viable users" claims ...

> And to be clear, I have no problem with netlabel as written. Multiple tag
> support isn't simple (we did it for Trusted IRIX) and the limited space
> available for IP options make it tricky.

That's an entirely different problem from the LSM and protocol
abstractions, but yeah.

--=20
paul-moore.com

