Return-Path: <linux-rdma+bounces-16128-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNnXOLXfeWm50gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16128-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:06:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F150D9F38E
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1900F305768C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78682D46D9;
	Wed, 28 Jan 2026 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jpGrg6dR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89C2D0625
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594682; cv=none; b=d7qJ6q081a3akec0BmdaO50XBGn+b8N8rn5op9oQNdzjHcpB4HXDrmU1nqA+5EYxoNhHzxUXakTIzd2V+NbOtEK+f/hgy7V1lmkXfJTZhI2//5Oy/5RApqqDhKmBjndNSZH+S39X1GKdmow8Uv+PkDnd0KGSf8zje42ZQQ6woQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594682; c=relaxed/simple;
	bh=6hDNwLOYk+TvmlQ3QflWxfGD1OEpRWMoDTXAthZZU2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKplSAgRwem/nTLtogPnPDolAJwA1gdOIVfpT+GRSl4n2/bm6RKLO2CMVf4/bZnOWNyF6mZjVHjUutxyzcGos14NJN1BtfN6k7spyi4YaNYqgjU34BSFhlK7M2B1z1IbCo4N4eVes5GNXaGrnwSgyWgpi7LNnqiRWcwU/+bd/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jpGrg6dR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2c96215so5800119f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 02:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769594675; x=1770199475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SV7d8BgV8INeTLFFnL9CYmUSnt1BRUmfVARHY+PNCAY=;
        b=jpGrg6dRwy+qNHoQtM2nLgK6UUWSf/kFhOD7a8dZfWtNbnZKTmA3FrwQEU54JrdPii
         QU4xfM55Rod3Pzbxi7HQ5A8vrpP64wl+JpXQkpyT7METAtkZA8N52UVza+jgACJa6AVw
         7VxzNVJoPijiBL5euHZk5sNdoBuoWIAYMVAT/+nFDK29+UkdFZsIHfMDnq6+vPIXTXyg
         ovTGUawUNGljSxD4y4nCynifRj4LjdSJkPLD/i5CS3qwG2EXuYuFLlMUYW4t/BLcOgPs
         W6jzeNrlofz8rNbg0WlrTYXbTOn4RS5HVrdu2AO96KfI3AxEjBnhTrB4SbUKLwKEr0IM
         nJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594675; x=1770199475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV7d8BgV8INeTLFFnL9CYmUSnt1BRUmfVARHY+PNCAY=;
        b=I0yT7sBKpTbp2lDfXnknaDyUAo55pA8bgTdU1sg8TRSfWbohOR+SQsU+kTIlCHnkBu
         7IXxqdDPYWvB/cCkvOSK4rV2s8wHcdTNKGNFOot5Twngx6f/Jm6S57I+Y0hf2+0tTN4Y
         2bToAFFXtbbgspeGhGNSH1vV5dgFE30I16jF+7S95Az2UzpvirPAC+wdUjj8NBYtHr4+
         pMe7RnivzGeiEukfSvjQWNi95RiqA+TSprwItMHdfntQUnZlsglu1K2RFqmzBLyA1n00
         Eb3PGmxJZP3YRwl0U4COtil9W5srobHF6uxMjnrSvAbPp7wKd1tbuLobk8W+dCdD4OUX
         hBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaQxh2Koog+oKapZodTUEkFUWNhnpPLyPN5XT0G+Zzts7SbrDRdCRk9//NdTJTi5M2N5T06WKvbDNu@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgqQUZcTrFz8KmsZ3ig11rL48VTJTuLbLyMybZq9fyYeE9mLa
	JL4c0lNtF8lXMKE46+PbKG2hfhWE1Cg8N9r9zs8k31nr1tH6A8XaGjouOGLXtRjp4Kg7fQmXb0P
	VDMyb
X-Gm-Gg: AZuq6aIdTb8zpOPb5E8TdhGMiLh1smf0+FHzXUcVmFVwZUbqsjtx+1WJGkpZ5dI1jvF
	tZTJcvs5KV9SrLujLzGzyL6FhxQuxFdSI2zBSPfUsx8uFjYGxgyQPWazyRvZ6Tm+siicXGJGB0q
	NWPwHRpM1pwQXdrTJm+eD821bWeojuESeQtkbfjUOGHC7m4Ql22jIDrVG3T9qkniKohNGpaUmfj
	vkjEy4nwJ8NYcZMe7dkTPP5DJ4IVU0lXVjiu/I0WTOEKEJPjSM3fPGuogjNc/zOjhQhrAzxnG42
	WsUd7R9moUBWFqOVkh0TeVeCEXPXnxTM9wyPL4Vr2MNgUd3D8dt+0e5H39aNsaD5wp8CL0GZYzH
	eoC3dGMdfxQL3EvFKRMxgKBNHp47y3eCnf5TDlOp+kCjSJC7KU0u8X4WtOCviGwxYMhDyh3nNYC
	iA7VTCmg3L5wEhDm3kJ195/go=
X-Received: by 2002:a05:6000:2381:b0:430:f437:5a6d with SMTP id ffacd0b85a97d-435dd032b45mr6237181f8f.22.1769594674744;
        Wed, 28 Jan 2026 02:04:34 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cfd4sm5670667f8f.25.2026.01.28.02.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:04:34 -0800 (PST)
Date: Wed, 28 Jan 2026 11:04:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
	leon@kernel.org, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 4/5] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <dfndzxmm5elo7f32dk6jwu5kv2enyzvmxct5nb6gyf7sbw2p54@rxityeylsqor>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-5-sriharsha.basavapatna@broadcom.com>
 <pynbf5lh5azbblvoygivvzxjcmnvffrtdz5zbjzsg4rccbpvud@277svcow3ra4>
 <20260127141545.GE1641016@ziepe.ca>
 <qkqqa6grjmfbkxalfk25w2gliscr3e4erdwae4zvl2oqncwgyn@brkp7gu3ppy6>
 <20260127155603.GF1641016@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127155603.GF1641016@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-16128-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: F150D9F38E
X-Rspamd-Action: no action

Tue, Jan 27, 2026 at 04:56:03PM +0100, jgg@ziepe.ca wrote:
>On Tue, Jan 27, 2026 at 04:07:41PM +0100, Jiri Pirko wrote:
>> Tue, Jan 27, 2026 at 03:15:45PM +0100, jgg@ziepe.ca wrote:
>> >On Tue, Jan 27, 2026 at 01:30:03PM +0100, Jiri Pirko wrote:
>> >> Tue, Jan 27, 2026 at 11:31:08AM +0100, sriharsha.basavapatna@broadcom.com wrote:
>> >> >From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>> >> >
>> >> >The following Direct Verbs (DV) methods have been implemented in
>> >> >this patch.
>> >> >
>> >> >Doorbell Region Direct Verbs:
>> >> >-----------------------------
>> >> >- BNXT_RE_METHOD_DBR_ALLOC:
>> >> >  This will allow the appliation to create extra doorbell regions
>> >> >  and use the associated doorbell page index in DV_CREATE_QP and
>> >> >  use the associated DB address while ringing the doorbell.
>> >> >
>> >> >- BNXT_RE_METHOD_DBR_FREE:
>> >> >  Free the allocated doorbell region.
>> >> >
>> >> >- BNXT_RE_METHOD_GET_DEFAULT_DBR:
>> >> >  Return the default doorbell page index and doorbell page address
>> >> >  associated with the ucontext.
>> >> >
>> >> 
>> >> Similar to CQ/QP, why this is bnxt specific? I know a little about rdma,
>> >> but I believe we use it in mlx5 too, no?
>> >
>> >mlx5 has a specific thing too, the doorbell has enough fairly hw
>> >specific properties and never leaks outside the userspace provider.
>> >
>> >We consolidated the internal code to manage the mmaps, beyond that
>> >there hasn't been a big push to consolidate more.
>> 
>> I'm a bit lost about what this patchset tries to do. The cover letter
>> does not mention dmabuf at all. Not sure why. I understand that create
>> cq/qp is enabled to work with user-passed dma-buf info. So that makes me
>> assume the same for DBR. I guess I'm wrong.
>
>This series doesn't really clearly explain what it is actually for,
>but it is almost certianly about supporting what NCCL calls "GPU
>Initiated Networking (GIN)".
>
>To do this you need a couple of components:
> 1) "DV" verbs to allow direct access to the underlying HW queues
>    under a QP/CQ. This is because you will write a "RDMA provider"
>    that runs on the GPU
> 2) DMABUF support for QP/CQ because you will use DMABUF to place
>    the QP/CQ inside GPU VRAM so that the "RDMA provider" running in
>    the GPU can access the rings at full performance
> 3) A doorebell ring that is compatible with the GPU, usually meaning
>    dedicated doorbell registers because the GPU can't do locking
>    coordinated with the CPU.
>
>Of course there are other ways to use these APIs and DV was first
>invented for DPDK not NCCL..

I see.
Isn't it common to have a clear cover letter like this expressing
motivations for the patchset and each individual patch? Would be much
easier to follow what the author wants to achieve.


