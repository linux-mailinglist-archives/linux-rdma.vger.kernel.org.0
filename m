Return-Path: <linux-rdma+bounces-17885-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBCZO8dIsGnFhgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17885-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 17:37:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDC254EF7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA6B9315133A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFAD3C6605;
	Tue, 10 Mar 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIi3EUj+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA053C5DD9
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160196; cv=pass; b=N1A5Ub1fxj+mNgUniUDNKZz5A9MYjHlnwQtPsCOKkxwfhM8KDee5Ocwn4XcxmuY2FeabbQYHlxi3gAGMrXLpq/GmzcMNpq5MPAkgAgQ2M6v79x5xD3VFKzdcZ2cHBouGMn9uzua7gHsHz5TDsxVBwIhfOLYpE9rlzqFGZ10Gb6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160196; c=relaxed/simple;
	bh=GtmCMbObKbjmmDRT3XldbNlZvhgkpoXsfeQtLnlwBSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9C+vGEZycpMdvbvKitUHOItSbcttbvjGTZKkaiPJWQUTL8JVk64wgyaXFVeJtt8HPywidlgDoMuNUCMpoPdMmRfEWv7LaAUuaVmN2WVTIc5moeZCArLar0gj6S1tuKXlXUJopNjg67e19hLUszAXKmkIpUXJ0ua132vVN6x46U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIi3EUj+; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d750eeaec3so754567a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 09:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773160192; cv=none;
        d=google.com; s=arc-20240605;
        b=QzOk16EQN/1QfXRL5NrrZk9aEUYLJw2qVkBlxUowxvZce4mI1uCIBwxwIcvXH/TtHz
         oe8/9ljpztcftSweAfXJvEhHz1Ve37BqhnPa/L1dhk/5QahC5j+vvgj49I0VARONiI0v
         JPoWf5kzNqiafYV2tu9xk+bYquWJXr1iAo4I1FJDgeJ3rBS/XdT49qxfKzDTBxBhdk4C
         VWuEOD2AkqPmB4drnI3wcStsmSm5pNNe9p7wxyMPSzxMfk0dDG8AzMskMSkCkMbIFNdH
         eF1PdSiJrd5tiAvdJUWCpdSxaZfEJh87r2ZZKfyxwvtAvqVYteEYGpH3Z8Z6b1tm7Jyr
         yjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vO7Rn9CkKo7xlP7yq6/bQIjIhq0HvuTasre/UqKYfjw=;
        fh=i9H3syzGySskBv7Kq+OLnvTcjKnW31yyfZbtXcM5HPQ=;
        b=jQ1pat/L/gFrAWu1XFZxtq3VZ+NR+xyTPAJjLHuWhucdugWpapgqyhtb6jRJg/LsEW
         A7H60sF/hgl42pPtMq5Jb9WfgOkyWF2bWARKG3i3mFmIjx2A5AI31bdDW5soVvZpgrU4
         3vGsDionK4ZoVUdOMGc+xUgQVOMiC5mepLj9WaT8MROhwrLLdsMQ1YoAYek3CFizI3iF
         zeQUXuIDsAYo3xseN70eusBDifcjTA1BL8HyfNUQpFBHAXK/8EB6ePA3bdeh+xvOh1tT
         wa0eZK1bLieLMg2xhofK/XSmHrmyAEPpzLFMw+5rOSDujHWgmViJQR8MzrOu4/wL/K0P
         3/hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773160192; x=1773764992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO7Rn9CkKo7xlP7yq6/bQIjIhq0HvuTasre/UqKYfjw=;
        b=aIi3EUj+F3utEyf1EUmD6JJtBYGzA8+LUk70HHFXsOiLpcNTACiRuR+YwM37at+lkD
         lpOP7xxNfmS+zh6Jmf5aaI4WkxBOJCYc+id7acNZzu7xD/bHzGcgn+q+t2hQsc4FFvho
         qzvhyzdVWsDd/7JtY3YOtlhO240WWp+RBng4iWfWEgaFL/+qmNNohdjkL5s0oBUzwntr
         0BJDkxz+HoZqEDr+uwnnDxiS2yaQf286uymt/Z9lCIUnWYvfa0wtk9RAXkteBqXMVljF
         a72IyrKVYOdB9Lthg9biBFnYkLgX1PNmznuT0IwFGcP3k9xTt8nRMx9B8NxAi2+yIUCa
         sO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160192; x=1773764992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vO7Rn9CkKo7xlP7yq6/bQIjIhq0HvuTasre/UqKYfjw=;
        b=euKDBVrfV2AV7qNy/CXohGYdcUwAWFcK9k34I3xJvwtnJp65VwgsLNzuCzZQnnTaHJ
         CDjdREB4Cdqa6N40fpqC1vMjXCIDIEnNBXP117i117b4j0a+Pr5E3IGHaLkQZL66ukT1
         LCpsrCsyUTaaBfeZuYcd5zWjWMg6J6JFpr1tPGCftGikZgldXSe2y27tvtJHnp/z6jwR
         /qDjeCUBUs8+lPROd6YHATObpk2KZERFvr5bzfMlQlkRCNMxQCtmf4DmhfROFrj0gCXt
         y7+WB0LW/6DIhD7wlF+BJGZ3eTxq3j+5YxMiKG83siov4GlCmIjtZN/BSTl90D+bfJI2
         vnew==
X-Forwarded-Encrypted: i=1; AJvYcCVNzKx1vMN9nBDBvMOljwFXqCnufu9pha5SKMMMyUGhH55LOM2mNmdOfUSzmlyxnrXcW6Y8HpUBdJuI@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyjaPKKPfDvgHfqhVdRWmYc7AdDmDcxOzdCQn1B8usePKAVJa
	USgOLerdKhNzJTQZW17eJ9SD7q7FcTtoBOPHPhhbOT3jGS/hd1djexHaGeGgSC5sW2iuGk0NhZW
	BA1jAdnS4Lr3JFo3Z6FJalmgrNrNzcHU=
X-Gm-Gg: ATEYQzx+D7IkGt9cHuB7sfRvMayw3ZfeF++I0Efx/fwWv2r7dLtNi3r58gAJugWUhc6
	dbREhRdKdkfmQjTNpxXcPxJevpkWpPyAtA+JJDqxrJoT5IXULUxCQuIfMG2D5FXhNE30Ebw+0TZ
	P5o7aZHzzwaB5EFMRozkOWPtDIPsad6TugfWofQxLjIQSepr0e4owIvgXZ4+V/brJF+v76Qz8AE
	wX9OYSlp6HdjhjL7PZHi9kcnDw8wD9jKp4L+wnsvNmUI2Ng2iQDw5TGqnf1FC19hJ116JZ5Hckg
	uW7PuSU=
X-Received: by 2002:a05:6820:f028:b0:67b:c122:d2b4 with SMTP id
 006d021491bc7-67bc122d8d7mr1047833eaf.62.1773160192035; Tue, 10 Mar 2026
 09:29:52 -0700 (PDT)
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
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Mar 2026 12:29:40 -0400
X-Gm-Features: AaiRm53wKn-Z9Bfyll-JSQgHDW7M1uOer1Mv0lXwG0F25zaRxhNKjMHX5FTwCwE
Message-ID: <CAEjxPJ4nTmovpgkzC+3=Oh7EAhpi1vHLwJfjezu-vzX_Q2OCug@mail.gmail.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chiara Meiohas <cmeiohas@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, 
	Edward Srouji <edwards@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A9FDC254EF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17885-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephensmalleywork@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,siphos.be:url,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 5:14=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> 1140         MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
> 1141         err =3D security_fw_validate_cmd(cmd_in, cmd_in_len, &dev->i=
b_dev.dev,
> 1142                                        FW_CMD_CLASS_UVERBS, RDMA_DRI=
VER_MLX5);
> 1143         if (err)
> 1144                 return err;
> 1145
> 1146         err =3D mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len, cmd_out, =
cmd_out_len);
>
> Could you point me to the LSM that would be best suited for performing
> checks of this kind?

If you just want to filter on opcodes, then the SELinux extended
permissions (xperms) support may suffice, see:
https://blog.siphos.be/2017/11/selinux-and-extended-permissions/
https://kernsec.org/files/lss2015/vanderstoep.pdf
https://github.com/SELinuxProject/selinux-notebook/blob/main/src/xperm_rule=
s.md

This was originally added to SELinux to support filtering ioctl
commands and later extended to netlink as well.

If you truly need/want filtering of arbitrary variable-length command
buffers, then I'm not sure any LSM does that today.
Might be best suited to Landlock but not sure even of that one.

