Return-Path: <linux-rdma+bounces-20973-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMYGCdV7DGoSiQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20973-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:03:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68CF581100
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D11A3001193
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2837A48D;
	Tue, 19 May 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TMjXC17p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8903546F9
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202866; cv=none; b=cd4hQOei3tEVocZXIB+llEtP8MqUQRK9m+jqqFd/qC8RPxOBahzz3ZxP2qXYQVFYso3Daa7xZyz2M80MqS6qOSjZv/g9ljoKnoq08xSXHzvkYohHnkcPPdicfhWF18A41AWkaAXlnQCeuDD52KSHqw3aHwossMeBw9Q23Fduk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202866; c=relaxed/simple;
	bh=HDkhq0lJvFvXDD2JBjy/vZ5FaZKrwhxpJ1/hvpcaI2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFSSoFlKSmqGn6fd+mF/FQCCEP8DXvsEIGqu4BrRTj5wqoVHtevR2jcFheYcavlDtPWsGed4EhUan1sEZb7p7EDeWnVhFg6EjZxa2PXyoeed6JSQVVABDfDArwzE8MfuZIuSXsPcCC/LWxpIR9nOG7NpS5TUaUGo8EmPmNftWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TMjXC17p; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5102582e237so36088631cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779202864; x=1779807664; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7VN7cnF2dC/fym/xChlhjkshvaThtQkBbidf3ldzrpA=;
        b=TMjXC17p6ZeK6xuSJ0JPGMfaEFVtQilhk8R9oWKKKY6PDjYADZEIDRtJKMKZH0qG19
         yhmhC5qICOykXnnPRdArxJqq5GAQLDW3VvA5FvoXgDjpNFLOUdT9mJp5UGWWwt/6wsVs
         A3ZGGikUipqf4XX0D1L0ZiqH+BLhUbO+Ep64Z7Ve2sZk5lEEmj7g+ID1sK8AyxRXVmDf
         ZYl9xKmEG9tW76F7kB2Z5DW1rG8eL9beqtD3Jmjw9Z4vWl6s7h000eOGojpuUnwCjznl
         axa9P7K/EoGlGBlpITuwH7UyYodWwEBRgDae+IXy2utciDLQwiXU/52onsSjLy8C/xgf
         Ud5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202864; x=1779807664;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VN7cnF2dC/fym/xChlhjkshvaThtQkBbidf3ldzrpA=;
        b=pHcwdmczR51hb17lgLnhMzJ/BcPpbFxlLMx+GXvaWbYoqZeU2KP0FsoB98/4kEjooQ
         ZTlsY0DwWqbtmbvQ/2aBhowspgEa+EP1ELDCs4Lz+9mHiwFzfG15reVcZGcA8YtUPYWN
         8fbtJeJtpXQKQJmfffajJIyLr8E8tnVh62L6ucLc6tAVnCAfgRQ1I6HPIB/bipN54B/5
         2pjsdKKBA4HmyOv+TUUaHAR0QkrKdOH9XREzr5Y4Pf1aau0F2QDzVwSVYOvFF52FBuR3
         fkdT2Ao6ZXRrv0BtyMXqYVlI5c9Kl1MQEm1ejUg5YbZ5KyPXuLCvPOVf+6Bp+I/mu9zO
         LNAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HmekP6v+BR+/9WiV6aKVQSTc/1ufB4CMBrkjOZfJgsoGRu6mLzNOljoabwiWp2/g0MQ7fSbzIQ2Pu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2VGTcSalNUZ4/pCuI74tN3K4yfn8DGNplrdkDKKtDCrWc2Vv
	74g0Mxx4tA1j/FalXvREN88DNCOySES0SwDduOGRgB8BVDGl1Snv2WzGwpOxF2WZnG0=
X-Gm-Gg: Acq92OFV2Bx8iE3Qgl1xXKXL2+pU773LuX5zUNXvYlrWDmINenBAdY07WNMMhQg2gcH
	H/C3N4M5BCma7W4C/XK2p5LmaNF9KKuFwA3gIznRbH44kJvVfmREXz1VNsnJePw5fjYbNe/rDAu
	yn/mjOw6UEBj7/EfXTCLwzUWjoQDw6vy9xe+FlaOpTv80mpYwuEbG45q+naJsjK+a/a9/yjmpaV
	yhVmnHZ8Jkp1jdDSnBvEhinIlwlPpbYmHDn2aJFEYgbPi3QRm1fzDlgmNT4jjhy6uZ8z+apgrv4
	elKkrdwCAXxCOnWYssKr7vy4+tVSD7W8NAbnu192U1D/rp4VHTuDZIPpx9m7RxmNuU/VbCoFKNx
	Ve8WNzng8g6BaGBfjBL8WhX9OGGQMGlYDoSerVNtP2k4Bl5UWbtHSN+SoMW4OItG7pvZXAXH++U
	RtnTiLCCL7acwwGqpuHF9B2O3wwgg/psFeRdO6sdR7iuOY6NA81EX06dHOkFmVvKT+ebEV7PZt8
	h/adQ==
X-Received: by 2002:a05:622a:30f:b0:50d:a8f5:d519 with SMTP id d75a77b69052e-5165a035cb6mr283315921cf.14.1779202844100;
        Tue, 19 May 2026 08:00:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm179232661cf.31.2026.05.19.08.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:00:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLw2-0000000FA5i-1YLh;
	Tue, 19 May 2026 12:00:42 -0300
Date: Tue, 19 May 2026 12:00:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Tristan Madani <tristmd@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
Message-ID: <20260519150042.GL7702@ziepe.ca>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
 <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev>
 <20260519145610.GA33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519145610.GA33515@unreal>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20973-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,vger.kernel.org,talencesecurity.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: E68CF581100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 05:56:10PM +0300, Leon Romanovsky wrote:
> On Mon, May 18, 2026 at 07:03:18PM -0700, Zhu Yanjun wrote:
> > 在 2026/5/18 14:50, Tristan Madani 写道:
> > > RXE queue buffers are mapped read-write into userspace. The receive
> > > path reads WQE fields from these shared buffers, which lets a
> > > concurrent userspace thread modify them between validation and use.
> > 
> > To be honest, can you implement the above? If yes, please show us the steps
> > to reproduce this problem.
> 
> It is an imaginary problem. One would need to run RXE (development,
> virtual RNIC), write a buggy userspace application, and then be
> surprised when RXE misbehaves after running it.

Simple misbehave is one thing, but if userspace can hack the kernel
and gain control of it through this shared memory then we have to fix
it.

Jason

