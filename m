Return-Path: <linux-rdma+bounces-13168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFAB49D99
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 01:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243373A1441
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 23:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1430B51F;
	Mon,  8 Sep 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNEDlFNZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4B3EA8D;
	Mon,  8 Sep 2025 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375398; cv=none; b=ZJpoZTtqAgatLFivCnG5GJG6RZy2+ygvRAKpLtA/FMuNUwpZOHDraWdMiZgdJCX8XM2YF6XyNzg1vAX+vLJvijLoNTnmLLYOcE6AJ1HGjmLuBidb2eRUZwP/f+WRihnWPsxAtOim1WdTONq+IOPmgmSx3PI78nAeXQc25hcthM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375398; c=relaxed/simple;
	bh=mTHhFjwx67T5cZggeXioncQ5Z5pNfVAaSNJfNKn+EjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJTgwxsdxEBAG7BHOd34v0+b49eTyIHDBheF77whOFqUX1C7K+JPYzVZIzV/JHZLO1uCxLahJ4GQj0KWlZ4DOeYvzGInnClGfzav/h/oT1D0Zu4k+hNYy1UR8i/0t13Hib3W8jZrWNhWD+ERx/N7jL7RmK0CP3wubQWIWIz6BpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNEDlFNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1205C4CEF7;
	Mon,  8 Sep 2025 23:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757375397;
	bh=mTHhFjwx67T5cZggeXioncQ5Z5pNfVAaSNJfNKn+EjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rNEDlFNZq+oSe7d12DDTIKSlFCntaekoWN/DoCna8Taumeuz17fSiJV/fJwAmVyaU
	 1hNmeg4vGpmpZzbX3c4MPNgIIGgVrE/UUmTC5ej/OLQhfgp/RSGkjP/hex/YSQaID/
	 lUjMOe8/ESIpCDqI2Gmc1bJF8AAlpEsnPRCW08ZhsoYh2If1Zn7BXC5UzIWe7ZNYGF
	 WHOz3gRO5n+LYwp0w0TzviZwv4QggbXY6hg2IUyx6llKmiHFVygKhJCHk7E/QUwF7t
	 h0lakoeQn+K8EDRLeIu8xm1CfgCQPWbIEc94Ney1e8+Ewj4Dv3mJjwTc9FOf8XXjfv
	 JTeexEcitCcWQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso8004134a12.2;
        Mon, 08 Sep 2025 16:49:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/l6+F7n2tz2qyGP1mA1yeSEC3cUzv26x4D/H/4AUEnbTv8048wmaslLWq7y46Qr7WQCmi/2+/ahKB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+N1+SC5jCu6yauvPIkGALXUkiZRGA5TTX4/TrXT64UvXYNCRa
	aZh9zUmtyZ56XqovYKNU6sSgZZvki7M2JItEGArE9tV1/r9CuYxameB9tBqKA1X+9OD9Gu9vX7S
	3KRUSHyvPby79dRXugphQsSv6V0nVvXo=
X-Google-Smtp-Source: AGHT+IF0vDLrKfIOYBdnMhc8vs1WK7t5IsPpYoj/HNM9PMAcfcDeg36yoUW0Kj8rAa9gNHHKNw5jkqfheCoV/5taOgw=
X-Received: by 2002:a05:6402:274d:b0:62b:4e83:e13 with SMTP id
 4fb4d7f45d1cf-62b4e925357mr2284585a12.26.1757375396258; Mon, 08 Sep 2025
 16:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904181059.1594876-1-metze@samba.org>
In-Reply-To: <20250904181059.1594876-1-metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 9 Sep 2025 08:49:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-pm1zbf7cHiC5Z9EsDYpYYpP7XdPLwcrMEC=rmDHm90A@mail.gmail.com>
X-Gm-Features: AS18NWDWnPRi4SnE4bDJZ0suDXPkVol1xCIuN9zUkmkpwdDsqv80qp9Zu6zklMg
Message-ID: <CAKYAXd-pm1zbf7cHiC5Z9EsDYpYYpP7XdPLwcrMEC=rmDHm90A@mail.gmail.com>
Subject: Re: [PATCH] smb: server: let smb_direct_writev() respect SMB_DIRECT_MAX_SEND_SGES
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:11=E2=80=AFAM Stefan Metzmacher <metze@samba.org> =
wrote:
>
> We should not use more sges for ib_post_send() than we told the rdma
> device in rdma_create_qp()!
>
> Otherwise ib_post_send() will return -EINVAL, so we disconnect the
> connection. Or with the current siw.ko we'll get 0 from ib_post_send(),
> but will never ever get a completion for the request. I've already sent a
> fix for siw.ko...
>
> So we need to make sure smb_direct_writev() limits the number of vectors
> we pass to individual smb_direct_post_send_data() calls, so that we
> don't go over the queue pair limits.
>
> Commit 621433b7e25d ("ksmbd: smbd: relax the count of sges required")
> was very strange and I guess only needed because
> SMB_DIRECT_MAX_SEND_SGES was 8 at that time. It basically removed the
> check that the rdma device is able to handle the number of sges we try
> to use.
>
> While the real problem was added by commit ddbdc861e37c ("ksmbd: smbd:
> introduce read/write credits for RDMA read/write") as it used the
> minumun of device->attrs.max_send_sge and device->attrs.max_sge_rd, with
> the problem that device->attrs.max_sge_rd is always 1 for iWarp. And
> that limitation should only apply to RDMA Read operations. For now we
> keep that limitation for RDMA Write operations too, fixing that is a
> task for another day as it's not really required a bug fix.
>
> Commit 2b4eeeaa9061 ("ksmbd: decrease the number of SMB3 smbdirect
> server SGEs") lowered SMB_DIRECT_MAX_SEND_SGES to 6, which is also used
> by our client code. And that client code enforces
> device->attrs.max_send_sge >=3D 6 since commit d2e81f92e5b7 ("Decrease th=
e
> number of SMB3 smbdirect client SGEs") and (briefly looking) only the
> i40w driver provides only 3, see I40IW_MAX_WQ_FRAGMENT_COUNT. But
> currently we'd require 4 anyway, so that would not work anyway, but now
> it fails early.
>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Cc: linux-rdma@vger.kernel.org
> Fixes: 0626e6641f6b ("cifsd: add server handler for central processing an=
d tranport layers")
> Fixes: ddbdc861e37c ("ksmbd: smbd: introduce read/write credits for RDMA =
read/write")
> Fixes: 621433b7e25d ("ksmbd: smbd: relax the count of sges required")
> Fixes: 2b4eeeaa9061 ("ksmbd: decrease the number of SMB3 smbdirect server=
 SGEs")
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
Applied it to #ksmbd-for-next-next.
Thanks!

