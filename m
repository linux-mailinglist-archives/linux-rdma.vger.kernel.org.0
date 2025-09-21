Return-Path: <linux-rdma+bounces-13534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A698EB8DA8F
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 14:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609F517845B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298234BA52;
	Sun, 21 Sep 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEVtOKLz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D22AD13
	for <linux-rdma@vger.kernel.org>; Sun, 21 Sep 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457040; cv=none; b=RmPQ4QTX25zjKJxWoOurbE4ShkGn+LaZvYvcRBb0ASYcB4XRpdhwK9A4cV/U7deX5CgMeRnXfimZvgGyHWP5o6anUZYR+PNpxEeNefKaar0cgnuZrUyy0wwub/yFhRNQV7Kc6r3gkDlXCwkfvQKz4UcQWX5w6BXmhbAk9d37ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457040; c=relaxed/simple;
	bh=fPQSGoBLvEr61cvFsTXU/9R4TTh3b0z97fK8UPq3pgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By0WqiDHkF38f1KZCWXT55vBLma5JG/h2UzK8dsUJ1T7VY5VNoQfwtdm0odlXftLU/9/s3hZuR2HdSnuRS73V/IQW4anGwksd3LjcCmSC8SXKz0i//vyPtCkuAk6C2LjBRa72tIoC8YXEHAkVuSCmNFmstAZSa7D7T9qHjpR+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEVtOKLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB90AC4CEE7;
	Sun, 21 Sep 2025 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758457040;
	bh=fPQSGoBLvEr61cvFsTXU/9R4TTh3b0z97fK8UPq3pgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEVtOKLzDv8tUJwERQfxRVbKyeSRR4gr9X8FrTyTw50x2/EXcmqlE11i2aC6/AgBh
	 eqSpY7m+2Vl7evJyhZHARH8e2kQyh3C1LU+u0qiFhHf+JMQxqLgZ8X+7nfJsgpyNiy
	 zPJsS4Hdpk7UMjTcTMsuhoAOf9kTF+SLeLd25ToRl4DK8JjimeVQci+M9+PPcNSzmB
	 2aTJRaY4r8fUFw6JfXaAZeatCxmVVvWKbsFuLTWreIc909Z5bUCWWBcNJX6CMgSvQk
	 UWFiJn7JMtprNSripk8mf8gPVfbyjSzmQeBFuUr1XhyZPc/ClN5UuzrD8lLDlAtlRa
	 Ijemr9FKgY6nw==
Date: Sun, 21 Sep 2025 15:17:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ilya Andronov <ilyaandronov1983@gmail.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: librdmacm infinite loop in rpoll when timeout > 0
Message-ID: <20250921121715.GJ10800@unreal>
References: <CAA9MXNTgdRCg0te=jzEontuLAdbTnfjr7o3cf6en4a=wYJs-Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9MXNTgdRCg0te=jzEontuLAdbTnfjr7o3cf6en4a=wYJs-Qg@mail.gmail.com>

How did you come to this conclusion?

Thanks

On Sat, Sep 20, 2025 at 11:33:32AM +0300, Ilya Andronov wrote:
> index 005bd0be8..32fb30aea 100644
> --- a/librdmacm/rsocket.c
> +++ b/librdmacm/rsocket.c
> @@ -3362,9 +3362,6 @@ int rpoll(struct pollfd *fds, nfds_t nfds, int timeout)
>                 if (ret)
>                         break;
> 
> -               if (rs_poll_enter())
> -                       continue;
> -
>                 if (timeout >= 0) {
>                         timeout -= (int) ((rs_time_us() - start_time) / 1000);
>                         if (timeout <= 0)
> @@ -3374,6 +3371,9 @@ int rpoll(struct pollfd *fds, nfds_t nfds, int timeout)
>                         pollsleep = wake_up_interval;
>                 }
> 
> +               if (rs_poll_enter())
> +                       continue;
> +
>                 ret = poll(rfds, nfds + 1, pollsleep);
>                 if (ret < 0) {
>                         rs_poll_exit();
> 

