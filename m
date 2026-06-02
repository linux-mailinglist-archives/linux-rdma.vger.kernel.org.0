Return-Path: <linux-rdma+bounces-21619-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3DnaDIi/HmrRMgAAu9opvQ
	(envelope-from <linux-rdma+bounces-21619-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 13:33:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198562D940
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 13:33:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QWDREzUc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21619-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21619-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C698E3021B5C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2C3D333D;
	Tue,  2 Jun 2026 11:21:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9439184A
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 11:21:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399271; cv=none; b=IMa5KGZNcADvGVs+puC5umHcybJJs7Wbt6m/5BmJQLYFRm3j5A/dqg9cgsLxq6VHm9VmjdFMtu2AJgyUYHmj51mVi/LX8whd668dvfBbG8kEYqPk0BFNn6JKMFA+9lwltGq6WAfCG1/Fa1OM4cDVakH/Q4kpLCDwYgHkqCU5fgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399271; c=relaxed/simple;
	bh=mdyShz2Hb1nhbf16JMmhzAI3lw9uTjlKGNRSkU4NhIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZfQ2UUV2IRh2VvIEjVdQ3/904Z47y0INRv7948fXK4r1r560OrL5VTI3L9aoR95H74NgBC4bqQ8OqF0Uz5x12CbUs/g/8krp3dhBLgnOrF7/LFvVykCXKewvoWUenp5jT5Xy+65LS3xs5s6Gb6Al4j6diAOr6gwdUUExzbgNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWDREzUc; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso101484145e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780399269; x=1781004069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+Mx9qxe5Noh2BseN2qEXUEhNI+HpIudHixhjkzy9lQ=;
        b=QWDREzUcNvwFfuiuy45CUK0AXWlgdkktBJ+GtFJ8FBXCqyxwgJFlKRhsPar2d2ZSS/
         wF+OEbhaLwx7LV28ZPNWspdgAJm9xUvN96CZwuoAtPTffSCzW/4Fpr6/Mbt9enzRoXPK
         A8vQoiFTbt5B2mNhEoq1uAz7t7WnR63xJyAs9Jqz6Qq8pOBKts+L5/hKYYv7x9LFkOQk
         hLy4CUB02VWElNjR5IpQWxMuofdoGXhNgBfSxRh30zfh3WNMYPoKoGEmTte5sN9ugr58
         IEZwZrfmGvoplpLC/y3c2bT2VXy/rXJ4VUqMPgGRnElRSiMysIq4uug9vXoy1EJesNkh
         bggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780399269; x=1781004069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+Mx9qxe5Noh2BseN2qEXUEhNI+HpIudHixhjkzy9lQ=;
        b=QpYhZRVaRuYp1jqAT2HE1bP2cjFQZ8gSGb4FN6xIso3rG/NRCRI9zHYFBj1rvAdAP6
         j9+0dRbEnMhNHlWwSlKTfNoF1h0jpzYsxm85lBirGxYLtvPddhqmXRTdlKLbhUaQiniM
         YOiJezAqoYDtcxEql1zLAW7/AYiy/qgS3wDBlL+iY25mgCJ+Iooq8hd/NIA4C5OEXV5B
         MWqlj49Isyv9XzLkpmzrTQwbl4QruyzkY2Ed48vyqduxZtq7c6QNKwAuepkoClD2DQxH
         64Q52YQ9USP1kfARgh0vROAh4WdukcGVT6CaGmZXG82/N+xQobEVYXaGgsm1FnYtUFwg
         FgbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6ZlN1AbeX8lPd4eXqH0gaFROBPy/D/uO4HxWFUnevrdk1wQFYgmr9qrDAEfpHd7JjbtvLkG0jcRSY@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMLKlwzZQl4LS/5Ow0QyCz/wfSaMratSGurmz0cYWmnK+yh5W
	U3nKf5IS3InB3qCWJB7STvKkKeIUckN3RHxeBsjpexykOkH28WaawRxx
X-Gm-Gg: Acq92OGUcJvsXJnTrdWS7ip1uUm4TljcCRdl3vnBOVd75akILImEXyEClDPCP87lbbt
	iknv7cH9qSjTdLYnDJZGl+HsB8s+fgHV4CPZZqKTEU/PtBJAy2ikqsuGaaNPca6lh/z7l4j8pFT
	LAmxuY6IAZGet/6VSbPOXU0sqMSqBi21rtW/xCKQwz1owXy7F9dSc77XyZ+642pjstnt6d0NPJe
	qKu+FG4Qx1eaSaGqd8P1WZqZGIAPt2qCKMSCIHvAeLGjd7s9arB2iZTssCZ1kMr4y/w/G4wJ9Ck
	Fxr8HuhiNEHzwPHMnMeA/31Qrnx1kZy2MPZbRDI0tXcwSagG+nxff3E1Z2hQCYUIZ5HoSQtzdMU
	MoqerRdbIF3q+UrKPbix6xYml2k6DpuCyTjrlOh25r5kYkbUgUO1C0mqj2Jn2KHAYkYvQAGkI8B
	FR7WMz4RpOeQBeDcv3QKAgupO+92tadUcRXHJmmBxxFaB6Pm6N8PnzI/f+EaEGCka1wPZJcng=
X-Received: by 2002:a05:600c:46d1:b0:490:a7ab:bbe3 with SMTP id 5b1f17b1804b1-490a7abbd7fmr206981415e9.0.1780399268568;
        Tue, 02 Jun 2026 04:21:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3559645sm31033836f8f.26.2026.06.02.04.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:21:08 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:21:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, mkalderon@marvell.com, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
 sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
 jinpu.wang@ionos.com, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
 anna@kernel.org, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, ebadger@purestorage.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260602122104.20afa8b4@pumpkin>
In-Reply-To: <ah6gtquGDMvEXjcb@ashevche-desk.local>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
	<5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
	<ah6gtquGDMvEXjcb@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21619-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[acm.org,linux.microsoft.com,marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:bvanassche@acm.org,m:ernis@linux.microsoft.com,m:mkalderon@marvell.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.or
 acle.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[209.85.128.44:received,100.90.174.1:received,2600:3c15:e001:75::12fc:5321:from,82.69.66.36:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.128.44:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,pumpkin:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3198562D940

On Tue, 2 Jun 2026 12:21:58 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Jun 01, 2026 at 08:51:40AM -0700, Bart Van Assche wrote:
> > On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:  
> 
> ...
> 
> > > -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > > +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);  
> > 
> > min_t() shouldn't be used if there is an alternative available. For the
> > SRP drivers, please make sure that both arguments of min() are unsigned
> > instead of using min_t().  
> 
> Ah, I just answered in similar way against v5. I also mentioned clamp() there.
> 

IMHO it is also best to do min(value, 255) not min(255, value).
Like an 'if' put the value you are comparing against second.

The min_t(u8, x, y) you've removed are usually broken.

Maybe I should change clamp() to allow clamp(int_var, 0, unsigned_var).
That will need the order of the compares swapping (to do the low bound
first).
I think they used to be that way around, got changed by a commit that
said it didn't change it!
Correct code shouldn't care.

-- David

