Return-Path: <linux-rdma+bounces-21468-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJRxC8G7GGoOmwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21468-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 00:03:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 760665FABD7
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 00:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6113C30225D4
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708B8367B86;
	Thu, 28 May 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2D7EM14"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376983346BE
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005761; cv=none; b=gVFNdvhVuE2o/vGRq162GxqPeBqTMAHxJViA8J6vbdlsrcF/aAaX4tQBLKCWEnNjRauJx4Ufqo1yuyWQDU9nY0pVzYHrEf0SbKstEJ96p5YK5mLWPMcx1v2JLMJijrg3VeGhlrDum8FCoxbKNEb7sf2P5N9iQwqNt5dA+Z8KoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005761; c=relaxed/simple;
	bh=LdY5w1w9JKQhpaZBSyVUr8rGqdk+R+saAIJWzDuNvjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8qgJZUGsUAX/YsMJ3DgPMU4owvFiGjhzRUHtgUcucLgy7j1AMQxNDyGs25/JZqergLoSeg1PIgjdUHoCgmOdQ2/dguvLUVXY8vgw72G8Xrki6cz7vq3XglS0p2sHHEGDlooWXqJrDF1PWCjuyQuzpIuLJ5cei9kDRYMbxU+2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2D7EM14; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c822652f82aso10690181a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780005760; x=1780610560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7lu1PeNcCkgTIxgc3W2FpjZdWenBKdIMuLJ/NcoWBc=;
        b=k2D7EM14uT67Nx5njw5i2c8u49cKuK7Cb2//uWlpYS9ifkBAt+EpM6CXhPeK9X0ZTy
         b5G+FENxSxQ/2TON+XfNE/a/pB7HNHNM+2hqXNk0hB45pJZ4wUSnV4jvwLIlwhvfLW72
         7pgEPccVSmOQkp4w2JVkf2GYXc6ODd7jImvOhzlOFfUXfsYBWoDUUHsh9YNTq7EhL1QC
         y4Dq3N3gZrxbaJF1EfCrel9uA+3DFKQ+sbY4TJ/ESeDwIY2a9YzJQ+DY+q0aMcuxdipI
         MeDYS/dh3nIFDmPXdQpjYLDpkGB1eK7Qc6/9YNT4BmAYnr1jw4gtDON4/nbIngeVMMb5
         UgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005760; x=1780610560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7lu1PeNcCkgTIxgc3W2FpjZdWenBKdIMuLJ/NcoWBc=;
        b=m5i1GBg3DQui4dTQ+nwHUOvl0YbMZ4JT1X8eDzy8LqihwiedY1QL9XTZLEptIhmkjh
         PIPXKWqzHYpmAUt0Br97qHX3i/Su4SvYaRjsCrLFQhe6d+poKkrX35FzKCIE4FxvHE4D
         vPTRMaphkXh27PHA5YtaFvfkUCZP1L4Y6COZHvwY3Z/gowMXOSNCZMPY7hhgDpo0Sn54
         BxCxEiRdDUfOvDMIiCoodbzft1OqvUKQ9z+k91vxrUVI+yz/OONz8mS2icDRNBesHOLK
         lg/jaLHpRxJW4riiUv0TZQo84tivww4vFxQ9D9mTU2/MNjT8M6NIFbCiNLEdj06cwO2y
         0ytw==
X-Forwarded-Encrypted: i=1; AFNElJ9Vj7SggxAkk4hHI0e+d9ziIN6IdPPR+2UATFxeltKRpZiPJ9+ACeI+CLh73TCXkZaB82AtR4K+2LIb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+khUemgfEYN1qBNHgg4vaRVaiWVk9WHdU7ubEi8UPRjYLPS0
	u00UppQWfallHrbtI2bmhHMvNIvLmod1p5N1lESZOo3PD3Cn5P6g6UoYZfhb7ABEEA==
X-Gm-Gg: Acq92OGX4ku+vd6YQvhOBaLkUnneEyORaH7en5viBt9oNHJ1LtYZ6f2vaQujsGR5tXj
	YHNO1wQS5uKLZzwB2SGV5RU9hlVa+Dhfwfm+MtrR+RL5EJZ+d5hjK9Zv4+Zh/T2Qy62A7JY8nvJ
	+7XOBs8j4/vr+paXcwR4VyR/sHnY3QGlnrmkT/fb14lXm9QZC32egIeCXhEfuoAYVw2sOZv1pxV
	JHhbrT4geXE/4QbZGx/OrDUri9rRrXLQH8Pp3lT0yEytQBW5wHyy/ho3kh/Gyt7S2emzdOOMqPn
	mLyqHK5n6n5JdWus4EL64a9Sxa+2t3841PTIEUGDwBRT2icc+V825bDCu/nuAH3EY3/J8TCtDQC
	UuP59KCIhkXw5XDCv/IPlSGBPdzycE1aD6wbbJ+t7BM2m4J5pi5Me8nfogKY/vMsKRiXAwNJu2Y
	NBqrAbGLIUPhJJikTGQ7uTcq+xCJvnLwFGc9Q6I65NjPBo766BiGFASRd9yjr/tscE22TcLgi9
X-Received: by 2002:a05:6a21:648f:b0:39b:9644:6e94 with SMTP id adf61e73a8af0-3b40e32b279mr628896637.9.1780005758951;
        Thu, 28 May 2026 15:02:38 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85759af1f5sm31047a12.11.2026.05.28.15.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:02:38 -0700 (PDT)
Date: Thu, 28 May 2026 22:02:35 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 08/11] vfio: selftests: Add dev_dbg
Message-ID: <ahi7e1MEoHwk-rtF@google.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <8-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21468-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 760665FABD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-15 02:30 PM, Jason Gunthorpe wrote:
> Enable it with a #define DEBUG at the top of the file. Allows leaving
> behind debugging prints that are useful in case future changes are
> required.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>

