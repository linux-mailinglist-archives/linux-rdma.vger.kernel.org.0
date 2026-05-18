Return-Path: <linux-rdma+bounces-20927-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IvgIWFTC2qYFgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20927-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 19:58:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CC4571D10
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 19:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79E753018D74
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78A34BA42;
	Mon, 18 May 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J8lDZYtj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF01332604
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127135; cv=none; b=BXodkOh2Pas7rf0W0w5XqWhOwkyYigQaX93oPkVy2GN6J3MFTIPuPD66gQ+MbDeOJ75AGIemg6vNQlCaoBdgvmJA2gvrsxe7AtWZH5ZBz/2E9sW2LNeYYaJOKTh0wvXEipFECna7EEhNVTBfpuCxuofW72FQs6lWHciEcX0Y6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127135; c=relaxed/simple;
	bh=W3zKcI8m9WHVIYCv0N374MO2p5Myt+6caNXcDZXJmMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHsq6dXYmfMFSf3C5S5Kq7MIlIgllBM67egSAofXDkYOUdha127hAAEzuOEjDnrBWHRrnyaQDuFjTzusvdCuc4COW3roBHZRn3VwfDbKyPLTXNE4uVHChfBr5C6GyUU1qpX7D1Q2k2X20QP1G6UBqfkS8mNav0ftiTojtmmi8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J8lDZYtj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90ca6f20872so460855085a.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779127133; x=1779731933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5WngXBzZs4gZ5FtwPfUk02e1f8V640R56VkIFEwKLYY=;
        b=J8lDZYtjVxcG2m091PMHjGCR4wOJNNumx9S2hu50EpEmw9eoZZTZlY319xslbnFMWi
         9ucfY1dq805TMUmXISDnBZXxNNvIPtqERpjMCNbyhY3gccV7qbvoP/v9/IH5p6pZwJAs
         6vY5ZtNih5FRACknuPj/aeOq+pJBkqXcANdaP+dFPdFw9Wl86lSUF7n9zQjlZSecaOwb
         3fXLqnhI7EO0l8L8Utx+sKYokMS0y2l4xP3i0nTivvUDt6qYs4CGYm39iaTN4MYhxWs7
         oM+43vDtCSjEgoBoS8hPgIcbBihL5dMwMvKaUJmqXWiNU6tWSSIO1LMPHUNYUC5lGQ8f
         3atA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127133; x=1779731933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WngXBzZs4gZ5FtwPfUk02e1f8V640R56VkIFEwKLYY=;
        b=OSfg+84mxQ/0m7fSf4URWf2JXwerIWSXbO5K8DkO7cy5mJJ7ONtnAWxkKfdFppX0Jk
         PcNyjIl+OYy0n5MDhdXTwVuaIx8ejH52tGGdqb6xycl92euiqMNzLT8iSEwYNiFRNcxN
         /TnkxHfYu+Yz043Thv+ySngQ1f3jBQx8WAOwVmPT7pjmhnKWNlIfE5DdK60aPbmC9Z4q
         Ht5qk5eYNcYEUevhVbEtVJDsoJWS5VjEFyI7SM78X0coghcW/MZTmIuqZ4I51VguN3mY
         qgXQtbqzHq9Hl/VszJYHN7vS3hhHCiSAiQmRZGGl5Sf4wgn3O+H55iM32xw4W8pLdWSG
         i//g==
X-Forwarded-Encrypted: i=1; AFNElJ9qvuowmVnI4g3T1G9rFNNF0qWaZvTeIwZNk3/lRfDhriDzzoy+VEhXWMdMLZXnf5Qigh1wVwce26+/@vger.kernel.org
X-Gm-Message-State: AOJu0YwKo1zYELHPsm05/tjIPYv+ksK3Rk3EIdJZw1mvi5civ9nWeOEu
	67d5GfaLCI+IEXUVTF8RjSzIgy351ozD1Gpztuq2ilHOMCpsYnc9vsDqiaParSZ2uxmVhkMUlf5
	ZY+ZG
X-Gm-Gg: Acq92OHV3IxSgY2+cVdJIy/y6iF12b5qnbzH9oQb1UO7hZ5fxPGIxWbDXVyjpPnqBRp
	C69edJPLx/HPiQIBIZ9ICIVbhzVTciY0qs/CUK8JwSYuqXP/iPQ1miJppPm9RN7b7OUH4dJHKX8
	Ef1S24vkE8WELOgAONhuqvXxymeF8gyYqTzGAczdvikYSxIjG+0Gp4ZGhii+KTJXuvJa+Ekk7oa
	snp49mHjRKtpxYh2gYbGXphaSNIZNHov+cLxyRsoJII19W0O0MzCK1Le5BeP1D9HTrmWkA3T5F/
	fvIu/CxrBUMVUknRWUOkV31tneUoGINJOwgD65toGCvW2l9qu2dCaYo/U+I2PQ4GhLntJUp9lW2
	4wi1ZKGhhdcfvmbE817PxSikPUfOyrZuOgY1oM2n5JFjes0bzbvEH+dLppR3p/eI10V3Ssldz4+
	cYu15d2mS1ZLbYY2TSUGan5hSNQc6pv983SY3pbJCY8n2sT11DLVsZ27P7pTlWc3+XAzQqhX4N2
	20T8g==
X-Received: by 2002:a05:620a:3941:b0:8cf:d80c:5ab0 with SMTP id af79cd13be357-911cf3f9243mr2224999085a.17.1779127132849;
        Mon, 18 May 2026 10:58:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf353b9sm1614913085a.35.2026.05.18.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:58:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wP2Et-0000000DVJk-0kLT;
	Mon, 18 May 2026 14:58:51 -0300
Date: Mon, 18 May 2026 14:58:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Leon Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>,
	Etienne AUJAMES <eaujames@ddn.com>,
	zhenwei pi <zhenwei.pi@linux.dev>, Jiri Pirko <jiri@resnulli.us>,
	Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/cache: Check GID table references before attempting
 deletion
Message-ID: <20260518175851.GU7702@ziepe.ca>
References: <20260513080707.3929955-1-zhaochenguang@kylinos.cn>
 <20260517103240.GC33515@unreal>
 <a7c17297-6c80-48c1-aa8c-c729afc84f30@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7c17297-6c80-48c1-aa8c-c729afc84f30@kylinos.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-20927-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 29CC4571D10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:36:57AM +0800, Chenguang Zhao wrote:
>  After calling kref_put(&entry->kref) in put_gid_entry_locked(), the reference count does not drop to zero.
> This is because the GID entry is still held by NFS via call paths such as
> cma_acquire_dev_by_src_ip() -> cma_validate_port() -> rdma_find_gid_by_port() -> get_gid_entry().
> Consequently, the GID entry cannot be freed. Meanwhile, the corresponding GID has already been removed 
> from hardware/driver layer via ib_dev->ops.del_gid(). Subsequent ifup attempts keep inserting new entries
>  into the GID table, and repeated cycles of ifdown and ifup eventually exhaust the entire GID table space.

This is a bug in NFS/etc to hold on to GID entries forever.

> To resolve this issue, we add a check before removing GID entries in the driver. We forbid the deletion
> operation if entry->kref is not equal to 1 (the initial reference count value). With this constraint, existing 
> valid entries will be detected and reused after ifup, avoiding redundant insertion into the GID table.

Definately no, you cannot keep GID entries alive that are removed from
the netdev.

Jason

