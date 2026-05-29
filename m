Return-Path: <linux-rdma+bounces-21521-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YObRAJ7HGWoIzAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21521-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 19:06:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3B66061B2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 19:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A50E1300C387
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C833F888D;
	Fri, 29 May 2026 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiTUy1Op"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50173F8712
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073721; cv=none; b=IZ0ZaERrjYK9lCzY1zaqur9Wi/ql51DVquZdd6PiI5HqE8rQ9nySFfzFyfxJSkA0z61ePilyeyCBckp3oYSb3B7o3wx02Ne6Q/Z2SnltEJMjbGdnAtj+k+/Jmdo2kUXGpD6arttzeXMrRzRBNAogrXxEzjIYS/BCyQ03jeefkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073721; c=relaxed/simple;
	bh=llW4OxFvtKWFyEC9eRxy9VUDdqj1IBqiGVZmNBrPlP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWh+ChPrZfjZouYk1GBckc5L55uPcUHSMr5Kr4eUOMdciXAdF/CKoU6fsKCMogQWHBnXjdg5/fkKj4Ua+++Pe2ar8twwnAOwYe4zTvWy/6RfvaLcH7tTNUd2Dm7TBtYc9Ioad+/EJ/YiGWClWhu4Le3mQvcvn/5nA211WAN5JK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiTUy1Op; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so62369335e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073718; x=1780678518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg88DDtH/8BXfFFdiCpH0Ax+iqDzN9Cpw3OqPjVLSd0=;
        b=aiTUy1Op+lYKoApuLxe7JXrRYO2t/I3uULvMmUsOHz0HkpZGDgZ1iZf97sCp1yHLvu
         0cFlLa4hBdMNEMS4IppVax/VaoCcuiXYFrV6iUupCMRo/7pxUNM/J+AkB9L6yFWBIlvx
         4kJUlQ2ZaPeZXfAqqoyHLvTfRguwpAhCKAPNdV3UtuA8HC7FicRQQM5lUwxOop3dvql8
         loAh1Y6Sto5lfxtAQjA2G+L48fYNc6emeJoUO+JT8W2pvC7jgZA4AzH9qC14GWoU8kgq
         b2VFTb5VW3ECBBPZv2CpkIPqkoZ66dzgC+dQvzLlYbqnAl6H0GQv/2LAdQnXvp7M36bY
         Kepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073718; x=1780678518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kg88DDtH/8BXfFFdiCpH0Ax+iqDzN9Cpw3OqPjVLSd0=;
        b=fVwJghhXaIUENnE0Kl+nsO9ViEDtolbB+aeihC7EKUhwQB8ABAV1BH7ACMtNS4S3/h
         hlE7geJurvdMSDqytEcIghWFfo8dpRqvKOK3X9Iyx4ycAT/mBChLz/CtWM7CiTZW4iAv
         lKzvB5aO7y+gF46PG++bByiRsTQQbL/OpLoliYmYjWGWGxrJeBWyUhAROyR/ChXUT73Y
         jqCO+0AukGEu0Eq9uhzmISXqfb/gvjiH8WAlv0uYxzl5Td4SUTSFueXv6RKtb9LM8CiF
         dwMOJgp2qJAA9nFEmph519FD2XJcZBqrkriDhM+Ysh/VXXYGzSuoH6v4SGZD97WQ6tKk
         Svmw==
X-Forwarded-Encrypted: i=1; AFNElJ+MAVV7bQFKaaV9GmUrVOr0H7CbQ024hlxJaA80MWan39cm8GvUStkmLiTB/St0y0EcHCG/lZpWzmyF@vger.kernel.org
X-Gm-Message-State: AOJu0YyujONBnWKU5buFq2VQWux8hBi0IENSfk+VAYI079f+7LaSh0bk
	DfACxgyu9ekw/Bx4F9pgFDDxvEY1I3T8DfmXCB/PiZTA5YbfgWqvHldGYFG9RGwr
X-Gm-Gg: Acq92OFX1cWDtl8vwcti8+4aKklpPVivIdpoWfQe1nAj2JxpjVmJGGLqm30uTbi7VhB
	KP9/xq4GyzWNcJ/2oA9kojAekE0YH+j7CMdy5GTN8yBMoM4WWLVdH2HNYFpDjwxE19rZRjPjriY
	KF2Ru1JP3W3tMB3rEyF7pTkdBYIdfFmUDPajtGSRPRF2AWDRf9irygeIVN0eqhyOtBaX0d9wUbp
	A0jBOcmrn9snjL95kZeJxQW3KjyAHuVM7EEISbS+je99v6Ww/e52cYjPW03p0k2vpgJcooHMQCb
	AExnnn/JyXEXXZn7KTC9MnjhLP4watRRf1YdfWw1ORYB6j0mvrEMT4eOxXSW7c3NA4RpQ9H9C1N
	yktHrtZ5irreXqqg9KZ0/g8YkXFmmr8xUDHlJHUzU3bRmvC896fW/bBLX20E2diTxC1DqDGP/Yj
	YFwQkiQt5IXfpKviZSYXAReG4puUGPynCviqRdwZX3aMXwp4S+3g28e69BucSpIIipsd7FHfE=
X-Received: by 2002:a7b:c3c3:0:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490a2941d7emr4738915e9.18.1780073717867;
        Fri, 29 May 2026 09:55:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0a89sm68444645e9.7.2026.05.29.09.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:55:17 -0700 (PDT)
Date: Fri, 29 May 2026 17:55:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match
 kernel
Message-ID: <20260529175516.06d5788f@pumpkin>
In-Reply-To: <20260529134947.GA128816@nvidia.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<ahiFxtmspbETiqWw@google.com>
	<20260529134947.GA128816@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21521-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 3A3B66061B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 10:49:47 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 28, 2026 at 06:13:26PM +0000, David Matlack wrote:
> 
> > Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
> > headers are more aligned with the kernel headers, and so that the arm64
> > io.h overrides are done in the same way as the x86 overrides in
> > tools/arch/x86/include/asm/io.h.
> > 
> > Something like this (untested):  
> 
> Okay, the disassembly says it works:
> 
>     1db8:       ca080108        eor     x8, x8, x8
>     1dbc:       b5000008        cbnz    x8, 1dbc <readl+0x58>
>     1dc0:       f9000fe8        str     x8, [sp, #24]

That looks strange, I suspect the C didn't match any usual pattern.
Normally 'tmp' would get thrown away and 'v' would get kept.
But you seem to have discarded 'v' and written 'tmp' to stack.

I'm probably being stupid again, but how does that work?
The cpu can speculate straight through the control dependency into
the following instructions.
An 'eor x1, x8, x8' may not even have a data-dependency on x8.
(Most x86 cpus just generate a zero for the equivalent instruction.)

-- David

> 
> Jason
> 


