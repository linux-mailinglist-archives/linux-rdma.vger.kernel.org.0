Return-Path: <linux-rdma+bounces-19066-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB3jKeYy1Gm4sAcAu9opvQ
	(envelope-from <linux-rdma+bounces-19066-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 00:25:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC693A7D93
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 00:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E9DD301CA81
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1313947A0;
	Mon,  6 Apr 2026 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ab/Ol9L9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D838C425
	for <linux-rdma@vger.kernel.org>; Mon,  6 Apr 2026 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514244; cv=none; b=aqtYCjPGOvg617BFjuRBg0p+amYNABQ3N3+5BzXACn+YeI655JX+FjZvJAMyV6mglru6mUDyX9Eu5bRikwG++VRdLB9QWyRIbLtWRizvMh1ks+T33ygzILzdLxRzKYXkeknfVlmw5wTAS6wGR9mXw45eYXu/iz0lktK6HZFbOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514244; c=relaxed/simple;
	bh=Y6TIkewA7pr7BU41YN6fsY/qGH3Blpqq6CVa25KcPOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t864s/ZoWuuYc181cd+AHqfvQHjvkEIUITAlp1S4wajkLJpM2CGhR3ilh05WJ1xVxIjiHWQglV/01YLcvtULDG7bcabDW5hvJBGkVb7rsaX9tpNXw+yrB/zIdb3YErby/Ku1o5ji2Z8K8/XFw/xtloJwDRamiHEhtGj4OPaNtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ab/Ol9L9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cfdac74050so539458485a.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Apr 2026 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775514238; x=1776119038; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7JVUGCgs+KhnTdURUUNkr64e5wz2LU5sjCx+P9IT4hE=;
        b=Ab/Ol9L9GUjIw1FJ9g/pm5S9rlTJ1rBkKRYAW/hC5m2LQer6sQ8otKgn4fbf3DvbIb
         NZNWYI1CThPstaFArJvUeQoEw8qz2NRQ1K93tUZYEud7KJR6iwQhvijis/ldUozJGv+a
         N2+DgWlUNjNYHcIGEpSfawX6hQxRo30xNcRIN4ofnVzCrbNVSPf3gRbweQHz2ByOV1lk
         nhNKWoiT+OSwE6abllXKdPSwCb1udQGgMEEGaa6ZMOt2eT6c02hlE8RJwbLh2XWm0va9
         oKoijxpO47zAMO00qY5ufzohwhoKRELv0krobKUy+cZc1sa0sra0C7J9obmKijf1oKHD
         9Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514238; x=1776119038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JVUGCgs+KhnTdURUUNkr64e5wz2LU5sjCx+P9IT4hE=;
        b=akz7UqWdlDm/jwj7BUl43szkUbRQ5q2QIPr1KRJvNfOx14VEEOEZ+cfdFkBB03/ykk
         FGbohnSLCdbqI1grYM7DsOOS3QAEdjAJIMJdvfilRn4AE71TLeFE0b8hJFL1n1dYEPgn
         InRpj8/NnjRyCAokRmPrC2XHkerrP/YrEJ/s/b0tu/dutuTBKczWdkAaiKb4Ti+eC7zF
         8PCnCNACsbTp//nnRMtQdfABPD9Qdol/sRkaFf2oNSj9ReXXT4jY7fg1WrO55MLSmYGA
         cOcPuE1QTl4Uxy0ClU5muk4Sh7vcx/MkUrVCwN+/eOs228V+DWmMtGZJqiRxdUhDmEAs
         bqGg==
X-Forwarded-Encrypted: i=1; AJvYcCX2UX5zAA++ZUL0E2+jRoJdy2d13e8L3O/2NsaOB1QXxwbr4KJF0O7q+oV/4ba19IxP+TFe+2WqyW/X@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnO+PPvH+3UvT4ki0CZ7cXriD5TXIatTaTYfvMpqNnh90pBv4
	sOqGfxyss/DdNr5R9Akr+LRY+/XgdN1zZIDjHTMfjzRgyVj4xa5UqlDe95E21Z6CD/M=
X-Gm-Gg: AeBDieu3EWCfuMlhf5zHhivYtRozXpOQFGpT35fS15AQXSmo7SIK84cJaRwfScILYnG
	Z5OonT49mJRjSWeTEcXKhymvnDPXraqXTfGxL0+zenUFxHAZu8zwutY3erTJbk5gVWZJ4Ns15qq
	H5PiM2OJdrkex4DWkUDo1Hw8Et0wlncNduTHo9xUmMBUqpRbHXFXspXD9jYoUS9aVNR8JL8wagJ
	57cEWcSv0/4IOtQ+f83RV3BN+teqQiWywBvNmgB+NOMmxqJ9jNOKU6rVQveAHPpOjcRibyBZdgX
	Gjpx1/w/DzKNleW3Pz9vnf9T2FCYO4FRITnSZcIGZzdXJetIbdJQQr3Uj7d/jLg6x0QHoIyqqPh
	ZDZNF90ZQTKoVxb8/T8afWT+rXlwZGprKe3if1LiAzksVLDsCx0X02+HesXIIt5Toq5B3YAjWf2
	ei8sKH7Mv7SSdsgzBRM8wPPlz77WbM8fTaoyYjIN2nM1BkRTq6Y66UH/OoWdavhltrh17NtQ==
X-Received: by 2002:a05:620a:2a04:b0:8cb:717e:17bd with SMTP id af79cd13be357-8d41c5a7077mr2034994485a.27.1775514237875;
        Mon, 06 Apr 2026 15:23:57 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03dc6sm154007816d6.34.2026.04.06.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:23:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9sMO-0000000E56V-3Cv0;
	Mon, 06 Apr 2026 19:23:56 -0300
Date: Mon, 6 Apr 2026 19:23:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <galpress@amazon.com>, Mark Bloch <markb@mellanox.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Neta Ostrovsky <netao@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Doug Ledford <dledford@redhat.com>,
	Matan Barak <matanb@mellanox.com>, majd@mellanox.com,
	Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 03/11] RDMA/core: Preserve restrack resource
 ID on reinsertion
Message-ID: <20260406222356.GJ2551565@ziepe.ca>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
 <20260406-security-bug-fixes-v2-3-ee8815fa81b7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406-security-bug-fixes-v2-3-ee8815fa81b7@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19066-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AAC693A7D93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 12:11:14PM +0300, Edward Srouji wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> rdma_restrack_add() currently always allocates a new ID via
> xa_alloc_cyclic(), regardless of whether res->id is already set.
> This change makes sure that the object’s ID remains the same across
> removal and reinsertion to restrack. 

It would be better to somehow pre-delete it so it is still in the
xarray but somehow blocked and then allow un pre-deleting. del/add
pairs are not a good design.

Jason

