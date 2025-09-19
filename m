Return-Path: <linux-rdma+bounces-13508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C221B8784B
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 02:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145A81B23148
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739634BA2F;
	Fri, 19 Sep 2025 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDR3x2Qa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B61C1F05
	for <linux-rdma@vger.kernel.org>; Fri, 19 Sep 2025 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242510; cv=none; b=EW0ThtiUMnlSgfxrcdAFIdQl8xa3YtfpBc5VU0MNeyMBx3mfRYEDBILlu4xvbvW1O8f2LeAbPQ3C7DiN26q+gJ7tba8JCHEml+t6Awkh8Dtq2OkmN5Kr9jXruDUSfTF6vVTjeVFezOl/b6FbedKvNTs1NKVS06ehzqCt31vWfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242510; c=relaxed/simple;
	bh=b3Koa84Sqg7Vzrvj1FW0/AYhqspEsBMTPOZnuTagtQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRyk39s3ewQ2gIRRQB+pYglE/hIiLdHeh0UNV7M7iD+F3shlefjSED/k15xkbaQFV3dzpkCWlGhOZEygWphecR1I7AeTrSfjUv9Qpapj9pcMWUtHcUJpJq8UUbUa1rvO5lb7Lb2EEKU3XxwEP0ytjpIAjyRkgpqrVZUmGmFg3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDR3x2Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E70C4CEFD
	for <linux-rdma@vger.kernel.org>; Fri, 19 Sep 2025 00:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758242509;
	bh=b3Koa84Sqg7Vzrvj1FW0/AYhqspEsBMTPOZnuTagtQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WDR3x2QaaLzcSAYGLXd4vzPFmM3M9+2dfJ6fubtD5PQMrOnVM0MIqorcJ+9fpvaJ8
	 hgZMbIxGf48l9eJAWwmJiAIb0xGclBg6Bj8qf+AJuUk0FPHoQArieey/vBrdhVwvgD
	 iSgylbRIIFj1vaH4KtSvTmpv02MqfEztbZgi6C/QvyQimSCMe6UBrSi966IPDMs8Ke
	 kvslH4DKk17PQ3OgnorzY8g/brKboWP2fLUciDU8ACp+c+zqoQKo1olmHmcKtvopf+
	 ZDlG/1l079ru9DZ5AXNl/y4EramCVbb/q/FzSnkgftIn1Sx8uxGDuAuqEapesLCjcl
	 naOrBP7MV0Prg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb097eso618600a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Sep 2025 17:41:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1kzS79dAZEJ92cPGQIczIBxOdaJpyBG9T6uVoggNHFxavyWAjeEq5BrkQopHEHm0jgrIHvHRfFzyf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1oaAvjYK0KwddHCl5rdM+EVOzyV8ay6vbbYiQGoq85Ks87vA
	QSnIwk2twvAUdje/2+M1OwVe/odHuXLUMBdE8XCALf/UrUcxVhs1LiURmkjVnh92p5RSD5G5k41
	nw5i4YaUh1wnWvAbckVOw0o7zK8R3SFg=
X-Google-Smtp-Source: AGHT+IGB6E2+3TfBy5R8J+GmoRVyU8wDVB8w+Gi0nRE0tAVlr/D6tOnqwSS+SWOtopx1szu2rQXgqwVPPQm2oVE3Q9w=
X-Received: by 2002:a05:6402:21da:b0:628:410f:4978 with SMTP id
 4fb4d7f45d1cf-62fc0ace301mr966836a12.31.1758242508181; Thu, 18 Sep 2025
 17:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152644.1245030-1-metze@samba.org>
In-Reply-To: <20250918152644.1245030-1-metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 19 Sep 2025 09:41:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8wojz_==YTumm=yS9=QsS2fBAifhv17LcXLyRuaE-bKQ@mail.gmail.com>
X-Gm-Features: AS18NWAv2YtXjDqYYnVSMZiCpl-KzafCkajoYmeeMLGMDr6ywius2NcmlteAs0E
Message-ID: <CAKYAXd8wojz_==YTumm=yS9=QsS2fBAifhv17LcXLyRuaE-bKQ@mail.gmail.com>
Subject: Re: [PATCH v3] smb: server: fix IRD/ORD negotiation with the client
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>, linux-rdma@vger.kernel.org, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 12:27=E2=80=AFAM Stefan Metzmacher <metze@samba.org=
> wrote:
>
> Already do real negotiation in smb_direct_handle_connect_request()
> where we see the requested initiator_depth and responder_resources
> from the client.
>
> We should should detect legacy iwarp clients using MPA v1
> with the custom IRD/ORD negotiation.
>
> We need to send the custom IRD/ORD in big endian,
> but we need to try to let clients with broken requests
> using little endian (older cifs.ko) to work.
>
> Note the reason why this uses u8 for
> initiator_depth and responder_resources is
> that the rdma layer also uses it.
>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Cc: linux-rdma@vger.kernel.org
> Fixes: 0626e6641f6b ("cifsd: add server handler for central processing an=
d tranport layers")
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
Applied it to #ksmbd-for-next-next.
Thanks!

