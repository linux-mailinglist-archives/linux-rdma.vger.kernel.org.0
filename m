Return-Path: <linux-rdma+bounces-16433-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DAbDuO6gWm7JAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16433-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:07:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A5D694E
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 977B8304B5B2
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B343921F8;
	Tue,  3 Feb 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Bon9HKi/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17A30C614
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109437; cv=none; b=S0TAObNQuMcVLTIzuAHu2tbZEMV1ZrwKKT7UJuySbL5Po9iz1QyIUpqCVGxfYk67BgbeRRAAO8lSpAWMCbfw09nspkO+MI6l8Xg8TLVzDf7ruufFV3qV+JHucODiviNbsaNTKjgKJ+FKKyVjfb4hvJ9LV2sVnnJtxv6kz1HpohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109437; c=relaxed/simple;
	bh=nWGY+r/Q+JladQWvDVIuXzn5pZPvR9ZJunsjZGPSEhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jizpVZE7CHx2s3o/7qIMxCy9BfS2TGk5I52ljR0IcQH1MiK3Jwbvv4TrSzTHBPaKv47uG/94bhPgFZSWOPOtSJHVZZsdMOmDNlULJd6jCX8s+5fi8Aj037qqJX1PjwEBYEBC6qkvmpaVMX6lsloSs2dOAJp27DNoHIlaaBLC3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Bon9HKi/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480706554beso57446675e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 01:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770109434; x=1770714234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZE0Mn5JpP1qCD8yvONCJqAbTE8xEY/4u2yeRyeHJk0=;
        b=Bon9HKi/Em87iRy8F+uXqonQwWs9G6pgQzMY+o+1zPqJkzFZCYm+MlbtUoqQB8x210
         NTL1cp9DzJk/5pCjgkN7xSgGvJGoctf/+oW5AHTbAbKF08bXlBCPxMr5FijQ2VSC5mFX
         vY/0ZBmBlZOH182ngg9DNgWtZIsS++V04SN4beopDinlVuaGLV7s0j5AE993Y1IKweRf
         I2piMRf2pKuaHjCTlQGAsPXL0fyFcGi3SPCTFDQ8dRBZkKPN6QBfhBgrpGQjG2eh9wan
         9Xh1ysL4godEP3k87adhNNU9fPzQxvomkPLIMuoM30bPA9KOHq9rDxe2Oi4NHUc3YaL+
         hDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109434; x=1770714234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZE0Mn5JpP1qCD8yvONCJqAbTE8xEY/4u2yeRyeHJk0=;
        b=OP+LI6izG7Mb9KcztEMYFEh2ZuAJFcbQ0iiFz4+OV0M51YiJDqybPIqboBuRXDBAl0
         U7/t6bCmCvIxtenQnvVRIodFAL28Gra0JRUudLFp7ZIuViAZDRaPZpSQ1rJ9ZLsLtCn4
         7eK4cY0nMqGsTca3NvW84wf7sYxRQ/Te/HCEm9ca1hDTnDI1m91bJ/ccoKJhNlExFTAz
         6sowWbNmJLaOzgq8q8Sg0nQf7YesBMaeDbsMMirwq2UwObYLMmYcISQC7GzdBCnAMapf
         xG6W28TzaEd+6yaO04960SpH7IvetIpyJONx3cXaG5+p0uxGB2sN+lGaQAEhL88uL6xq
         OAhA==
X-Forwarded-Encrypted: i=1; AJvYcCU6WuPSScG5e1ECEBM6ptLk6JPvoJjs6FtJdX9U/nsMur8WWp/34Q3wqNDKo9OI4DDRdoPmgiojiUUS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GcccCEFyazZpZjpM/c5n5yRkfGKneIuEkIhX/P0zwaxX5LOi
	yoE7PyVgMmvBZ1DZtHsRzJvbxSvUXc+94jycNAzGuCVr4H/PX+1kRIjFf7E0p/Gzeuo=
X-Gm-Gg: AZuq6aIEgMs6l/Rtt58w5X5vlgzZcsSxObNMnzbdIFd73JRcutvAtjUlEiwf9FakWIB
	iROQ4Tb4BkZcYVlMMOfSF7/4LetD6Ak6PhPGuHAZmLxjyDFPh4fIN84WPJg/MYXdeVesV2iBicY
	a39Zqx6MSkH+q9qlo6iQwwjVnEntcUT7WEXRonM0F6hE2hIbRdHf6F3QH7xdUuISZpOykUrVUyZ
	8v3+NWhGS0ywFvqHP3Ax0lfgWHBC5JFIaD7x40tSJglhgQEqOGhO9rOCN4I67ckcpcCOujjQGBv
	xgW9HhdMx/5mqjnj2cxv5ePDrV5IpyjPj5oJ5sAXuSMw7IVGmtHGu4n+sb/65bkAzxH+5FvUJEP
	/DdxkI0YYfDM3v7IOEUpXk7nZ6k76Jz4rbpUH508sKllJq6k1cHhKqMOh4TnGY0Uk8NflpWSSDs
	08OEL3JT6EdVjq0S1Bk73blaFPN0Wz0g==
X-Received: by 2002:a05:600c:1d1b:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-482db493aa8mr182166075e9.22.1770109434423;
        Tue, 03 Feb 2026 01:03:54 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051286e0sm50403535e9.5.2026.02.03.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:03:54 -0800 (PST)
Date: Tue, 3 Feb 2026 10:03:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 6/6] RDMA/bnxt_re: Direct Verbs: Support QP
 verbs
Message-ID: <xhic2uwkvuwxh2v3h4vhbd4nichqhdooo3ew4ju42v3vq3tnc7@sul3tfcmeld4>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-7-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203050049.171026-7-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-16433-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 8E0A5D694E
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 06:00:49AM +0100, sriharsha.basavapatna@broadcom.com wrote:
>The following Direct Verbs have been implemented, by enhancing the
>driver specific udata in existing verbs.
>
>QP Direct Verbs:
>----------------
>- CREATE_QP:
>  Create a QP using the specified udata (struct bnxt_re_qp_req).
>  The driver registers a new device op 'create_qp_umem' that is
>  used to process QP memory allocated by the userspace application.
>  The driver maps/pins the SQ/RQ user memory and registers it
>  with the hardware.
>
>- DESTROY_QP:
>  Unmap SQ/RQ user memory and destroy the QP.

This patch adds direct verbs to create/destroy QP and also it uses the
new umem op. Why you need both? If you need both, could you clearly
describe why and send both approaches as separate patches? I suggest
to more rely on your head than your AI tool :/

Same applies to the previous CQ patch.

