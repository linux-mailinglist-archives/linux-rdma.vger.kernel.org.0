Return-Path: <linux-rdma+bounces-19963-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFWlNhMf+Wlw5wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19963-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:34:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C54C46D3
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE84C3034AA0
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C338655A;
	Mon,  4 May 2026 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b474DNHm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6D37C930
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934039; cv=pass; b=IggZwcRaLHpweOgOoU9Iwz5UxgTe/nrZ/k9TmaVFIGxKBZu5nYVitxoQUCpsgfZBlCbgeTwXa7KiTBD6C+6TXzZnZE1f0yLPABfdDohbfz3+mrn2hhXVMe9gRahiCktNdXNBU9luSEWuJBWonzWE//LeQr0U0IX9W1aYIbD70ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934039; c=relaxed/simple;
	bh=SRyzc0UaWv+n7V9qD3GfiNb+SIIGW8GsbwmzjOQHX18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMtD9z8g7ldAxJe4C0x6h0i5BrLcCSTDJH4pYU/VFcAf2KLcvDhkXFDTAjlqXOWTXQu80TgOVtH2sPf8xNONOECEONt45bD/2vRcXSbFMUo+eL0VReVpokZVRs5MZ5CMfv51G1lC3kl5nL/KE2SduORQCikXmaE9BGeyHBH6h/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b474DNHm; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3556047a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 15:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934037; cv=none;
        d=google.com; s=arc-20240605;
        b=YE+f7gUdnB91O67MlpJ26KHJkwGqkU51s0XL7XeNMfqBNP81E3VtafQiR+UR3tKrha
         HdPWM4OzIdVRsMDORPSZ8/ezSZPKabLblh4oYuy+9jDE0XzRzIqguAVe3J0FLuVbKyyq
         wyQroMo+OLB01/A70XADu8UMn54++lLoh1WORSlr7yM3lkcZ2SpvIIXl64jLiVGI1iJN
         a5lMD3Gnxk3Eh2tscvMQrrZeJtUYHwuTGDyJRHnyLHz+FHwOoLD6zsTdynBHh6CKRiYt
         sqYfiNKrsh5uEZhNw969Txa4DmKWqO3FLq6Qehqfa4XxEeJfQCXTqyIehmPDfYUKaTnY
         ardw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        fh=VNGu0jMMd637QfgEaWhlpIKV4xhOBcvXRfJ4fhL/rpw=;
        b=YMnHg7/UYl2K4HcfIknQsP6NM/NhIDd2wP0YCEZBWqJRL0rvwfdJoNMjknz7vF6386
         0ftStHad5zQSGUsBgHt94/bcIlVoiyQyrMA/icCMtMNkz4GME1mN2FlKUVc19Z/IKVsa
         DTZ0S7gsbnmDK80Slv5NbinJD2VuJWwSgnU3z+ncKDsNue73njD+A66PyyK6N+fR0YnV
         IMb+pypvf1Lw8cn9WpQ/JxvQk1KVOXMUNDLer1/xINYbV6ctUtZbatHLeBG7hTkeWa+y
         dV3SSn7ABuxIUPirSUXXZCfWPyIPK0lm/z1zM5K79grJgVIqgpCiRmPmqVWdjvnypqHA
         ANaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777934037; x=1778538837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        b=b474DNHmLbyPnOY4UtiXM5GN+X9I+S0u72RdwKdxeGJHFbyi8dy3N/skGTD8aswwJT
         mQh/fHxQh2XMu0/wXWmILNqAoHVz64tnsQj3uwYrG/nMHnMiR3+62Bg5+hYVAMqGGZa3
         Yhzv530XbxJbU0D0vwHq2/YSke9JUBH34F8cjupFBBSgKFVJDHqdHlHLgKPIsy++DjBg
         CSXKH02/rcKaE2K2wh+4yhWhycJgwprwu1F5I1VKpVbKdHi6Ab35lJlWSVF3M/jPkfFU
         QubU5hVrrXJSyul/eUU6NZH9S3lF2JCWM8rscrobVAwd5+udUgedARCiFdjuMMWnSxUC
         /4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934037; x=1778538837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        b=UdXlZjUK9fb6wocOexzGjM9bNtLM4o+spA6lz8NX0rXzVpgoqJIkSybodzj/35c6c+
         spQX9mJjsOWuHgY46FltNnYKyu4/kJx8LbHAMBY5CQ/Mv5cAP0WN4JBD2eavNbctU3Hi
         mRg1JPpYLp2rTZTWTyNFkolehB3jNOgAA58rA4px+pv051Mtz7t5+8Dgq9D2icbt/yMb
         lAMdHC/4InNo4OHqgnPuKpe9aGehoYacju2Z3wus1D01APVzolLXCwiZFZoFstJw5TAT
         SsepAz+fA8WllbIF0ucOugkaoTdfhJ1kPJVCADQwpWIOhCfTWzG9mnLq8A4zeAaSROot
         2GjA==
X-Forwarded-Encrypted: i=1; AFNElJ90fi0tbPhZTwPsHtOGrkiQgIFZJkRSYFMcmm1rl7M4Q8Ja7iGPZviCp2AVMMFhP5w3SfDQavw5hWr7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxf5boNxp1jnKpFaPSgnwbyYVqGKC64QiGhj7YzupDPPZAB1ys
	mMwwvv3XXTguQOc935096HmUzNW9ySukGCHuvjoo6OOVSRsJ1dAuJCwHrK20zEiT3TXp3VQxrSW
	twd4ZIMCgMYTgXuZLqvx/nK5zrBCiS8Dj9HIqFUcn
X-Gm-Gg: AeBDietLg3/4fWPE/hHkPmXmp0QgVBzpZ6p3McefbxzqLgMSXxpa9kaDEcsFFRLpuLt
	fZVdteTcdUcki25pcn0qIRKEKuiNnsIbCgiyK9KU16Z8Cf/XOrv1busiZ4gPFqofYrSb06D3mlp
	l0Z1DWUiE4h/Y8bXcfWi9F64yKYiSv2ia/2L51mr02xTT3Dss33XaE3WDIaepF1SLvObxH2D0/Q
	22wxAl0zTJrBOnGtXB1Xk+mhkFMGqMJqfvUWIcXfxvsQWySBeKI/o8PJuag+ixnQqEJIPzwhA3y
	ebUwBbKQFNI2T4xRGg==
X-Received: by 2002:a17:90b:1343:b0:35f:bb33:d721 with SMTP id
 98e67ed59e1d1-3650cd08160mr11400198a91.5.1777934037438; Mon, 04 May 2026
 15:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca> <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca> <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
 <20260424143603.GB3611611@ziepe.ca> <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
 <20260424221310.GA804026@ziepe.ca>
In-Reply-To: <20260424221310.GA804026@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 18:33:45 -0400
X-Gm-Features: AVHnY4L0o11c1AyvQPCh6gK_ec0IV1Rogd7iCBcWBXwoMyFuE6qppAiDKI-2lpU
Message-ID: <CAHC9VhTsx6cpKMP8nVgK4F=drXTFJtK3_D9k9pmKr56+ZFUu9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F6C54C46D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19963-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:dkim,paul-moore.com:url]

On Fri, Apr 24, 2026 at 6:13=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> ... I wonder if we are even speaking the same language.

Let's reset the conversation.

As I understand it, based on our discussion in this thread and Leon's
previous patchsets, the basic idea is to enable LSMs to enforce access
control over fwctl requests/commands sent from userspace.  I'm going
to start with that as a basis.

Using the kernel's docs on fwctl, the userspace API appears to consist
mostly of ioctls with some basic sysfs interfaces.  It looks like we
can mostly ignore the sysfs interface and focus on the ioctl side of
the API, do you agree?

https://docs.kernel.org/userspace-api/fwctl/fwctl.html

While normally I would suggest simply using the existing
security_file_ioctl() hook, Leon previously mentioned that the hook is
too early for fwctl as the userspace copy happens much later.  Looking
at the code, it appears that the copy happens in fwctl_fops_ioctl()
for all fwctl ioctls regardless of the device or ioctl, is that
correct?

Assuming the above is correct, how about the following LSM hook,
called after the copy_struct_from_user() in fwctl_fops_ioctl()?

 union fwctl_data {
   struct fwctl_info info;
   struct fwctl_rpc rpc;
 }

 int security_fwctl_ioctl(struct file *filep, unsigned int cmd, union
fwctl_data *arg)

Where @filep is the file/device being sent the ioctl, @cmd is the
ioctl command number (e.g. FWCTL_RPC), and @arg is the copied ioctl
data (e.g. ucmd.cmd in fwctl_fops_ioctl).  In addition to applying
access controls based on the ioctl command number, a capability that
already exists via the security_file_ioctl() hook, LSMs could also
apply access controls based on the RPC scope as well as any other well
defined data in the ioctl payload.

I expect most of the existing LSMs would implement callbacks for this
new hook with the subject being the process submitting the ioctl, the
object being the file/device that is being operated on with the
ioctl() call, and the access/privilege/verb/etc. being something along
the lines of INFO, RPC_CONFIG, RPC_DEBUG_READ, RPC_DEBUG_WRITE, or
RPC_DEBUG_WRITE_FULL.  Of course these are just quick examples to
demonstrate a point, please don't take those names as hard
requirements.  Each LSM is free to characterize the access request
however they like, in a way that best aligns with their security
model.

--=20
paul-moore.com

