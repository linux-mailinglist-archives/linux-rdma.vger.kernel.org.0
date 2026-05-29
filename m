Return-Path: <linux-rdma+bounces-21477-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAwvFVAHGWr7pggAu9opvQ
	(envelope-from <linux-rdma+bounces-21477-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 05:26:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3C95FCBA9
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 05:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4F673054047
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 03:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F95369D74;
	Fri, 29 May 2026 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNKex7Ss"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97234A78F
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025048; cv=pass; b=uW+Y9fb01/7zKMkz+CT1Udwj0gcMUw+AdcuSGLyqUpw/UNyZd8nmV3L3UKiAKTX95ptOwqeJ+c2+X6gjoySYSUDlTr7uR75V28zgp2B0D003mmsLHLSpLM1/HsVxabNZ11iC3AsHSegusaBRgVrXJtPOYKrYSzb3744sH1vtOnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025048; c=relaxed/simple;
	bh=XdOEnlBG7iyZw49QgNoHj6fX5UlJPTZrY2VroCGjdTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRvcun/IaH7bLQy3J7tgo5g6xNwo7I8IeiygBS4tqqrmbIycY+yy0tSWvYjkJeB7fd8f3MIHLr2ajbwEv9/g5LAFEuVpmz8S/SiEa33FDb8iRIQ/mmax10u3KcbyxNbZq+LRMtK08BaY9LpG6E7deRgg/puZHL+54Vt4f/AIqF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNKex7Ss; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso12022201a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 20:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780025045; cv=none;
        d=google.com; s=arc-20240605;
        b=HASXRWgeZb7zuNd1InFxs5vx20La0tdZZ6PbaCwCpN4Ll9fO40F9JXXH4Lz9/gxnvR
         MMnMuGr6lE56I43NC52pO0G2g1buz3HuGnhFDuvFduNhbit7FGVxlWQqVVzsXMUSVtZ8
         DAt0TYVWRN8uCRrbQspsuJ1VBMKHRVSb9wHFgUVbrLl4tbQ3IHyUCKYkXTiBnV7ffM5k
         pPIvZ7AkhTfyW0ozs+i4y3TY52uoPI1Yx5VEeagAB7QY1xWMRdi3rB/G3kUG7fsVJsVu
         NOxjtNDS3u4wXoOSMlEfEzbGU08thxpkLMnBlMKEztsWxRk2aniqs867cxjfBWF7v4u0
         RsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XdOEnlBG7iyZw49QgNoHj6fX5UlJPTZrY2VroCGjdTw=;
        fh=+ufTOiN7qlo3WrU4Mw5RpdK2Tsk0kxRwKlcWXVcbyns=;
        b=lfMGrDbPjXGcXUu41ba2iwh6382byUSSXKIp2cz76ZQOWcV2q/KmNDms44iRE02yZm
         KaWyfEa8vN6CAaBnwi+sY+oQkSS3r7mlMV/MsNW35YTstkAkS5QmQ0v8Lc6iRjTB0qz8
         fFdQY8Yzonxr7I1gQhxXWGXv72lPZ+tvEDKes79E6iLQMDlD+Zi0JGAPUaF5BUbmd+tK
         /MZpQicPm3wfs5XoQv9o5S37V7vrBYa/XOvFWDysa+qZabg3MWQh+/lCGgP6v9B/lMu0
         PxgGcRIt+9jqwxaSA2ozjBOKw/tC1nm7zsXNX9kH+k4jyef2HsbZtUPvzNpLzh2Fdf7D
         mIjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780025045; x=1780629845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XdOEnlBG7iyZw49QgNoHj6fX5UlJPTZrY2VroCGjdTw=;
        b=XNKex7SsfiOZp1yO2xmXAyvA6WvNf7HsFZo+bqdJaRl/c314oZBtc8k9xhf0pAihOk
         rH8wHKR6jZWUVXTwvRaliwo5JI4FxUcN12GmbhVkTDr5KPr5i7O3NI5Y0E90xEH+dwln
         AmVv3SSfnkyf92qKN2ZO7imgRNv1eZ6f7NEtEH5H6LeVDfOTrVbVV38MCSJIC0VrqgvW
         HhG0F7WtMCaSsBnjM3J/U1mRLjvp6gonukSAwv5SkYk4N1ou3VVxeGmtMLwvz7PDP/WA
         keG8XPu3pjuiOhJv40zoh1Ag1RAYZZZnxqP9HFIFXG4sgZFFl45HEDK6wmbuu8C3sFIf
         AyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780025045; x=1780629845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdOEnlBG7iyZw49QgNoHj6fX5UlJPTZrY2VroCGjdTw=;
        b=cl0NYHPRQT/U7cDBUDJ3gv/Wn2F7vARVCalAmJUMEi5DDhP7rMvUCeD81Df/Z4WHR7
         stGOd0ey3qmxIn9P9fB7quNAwV707uCF1ULO0ADHCk7S7rqEUMynldVHlYMFgXgYW4ak
         9c5F+RtvQ5htqL/xRfn3bLx7KId7Ix0o78M1o533r3EcB6wpwj/xl6O1T60LnhY1EjCa
         LlbhG/PDv4upSh/CcfECIOn8LtCqa+gS/P1f0tBFe3FjSQ/deVz6d+KZqpCli+kP99YF
         /a/4Nhq3ODjanzgsZP2g80R2s2zu1S/vMAmtnuuCER2SFO8ua+6387EQqj5en02L6m0y
         MoAw==
X-Gm-Message-State: AOJu0Yzm1L3e/ugR8VjAgfEkG45j1aaFGoAHga9+rRlKAw9v6DUsCSGF
	gaeJVtX7QROoEQ8nQvj9+iCYXzKvCottx7mAT4UlhY6N/7u0YEXObQDRmLTjEpXJDqGJmnOr8Ad
	QLPuzbYoITzUOjNf7NhjF8DUypnrwlEYfxUrWc+BS2W7R30bYGmsj+rM9kuI=
X-Gm-Gg: Acq92OGpuiEmdcS++hG3ITdG8qd/RUrA6TPEBsjCna0zdS6j7QtdmNlKSmZPX40LH0T
	kCn7EEojZsQKmx2Af9NIg/vzysu7DR52AuTDoMdu8GpYpqg5PFzOqpCO+723zPuRkGi/f6gkPVO
	7SjpZ4gesAAHyLPdc2BWCTCAR4RboQusw62lNoWrekEMj8XFVVv/x4iiflYWhgnEngAVGsr3f7f
	ofCR1aXhTZdqwlu16ib0mSVFGdD0W34ZtNSiLj4l8cEG9RgSuUCtPbZVGgwvs08nWLiKtBJrJHZ
	5lpy6PMn3o7YtrxUdDU=
X-Received: by 2002:a05:6820:6ae3:b0:69d:e4fa:c3e1 with SMTP id
 006d021491bc7-69e0408d102mr640511eaf.59.1780025044663; Thu, 28 May 2026
 20:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahjB87k54bYdFbft@grain>
In-Reply-To: <ahjB87k54bYdFbft@grain>
From: Jacob Moroni <jmoroni@google.com>
Date: Thu, 28 May 2026 23:23:53 -0400
X-Gm-Features: AVHnY4KkFffzc3Z0oCD2YCiKoAb2m15Zt9oaX6Ygff0r-Wfv0bM4VBp1_jglZgY
Message-ID: <CAHYDg1T3m=mn17zLRZp3+zcJq+GeDGcOU_99ZZmWxYasEDKN=g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21477-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EF3C95FCBA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Hopefully I didn't miss something obvious here, found it while been
> fighting with unrelated issue.

Nice find. I took a look and your fix seems valid to me.

I guess prior to this fix, it could potentially generate flush
completions for the NOP/pad WQEs which I can see being
a problem since the WR ID would be totally bogus.

Reviewed-by: Jacob Moroni <jmoroni@google.com>

