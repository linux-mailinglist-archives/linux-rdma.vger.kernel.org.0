Return-Path: <linux-rdma+bounces-20770-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIPSMgQKB2oLrAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20770-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 13:56:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3354EE75
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 13:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7903C3008984
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DC48033D;
	Fri, 15 May 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B9L1bv3T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A5481227
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845892; cv=none; b=IrCCU0JI6R/LeIISEE4ZHjUi6sCpj8/ozivoNBZSpEMUEKfabqqN8Q0b54UI0zO+nI8cYPnzJDkNvUkfWPQzKKFXPvhmJu6vdvrymu3WqBSZsvQLh+AHTnwTWLUm6PhqKg2k3fHLHO9qbYTAA0+BJ3/RQEyqXP8/RwUTK/L76Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845892; c=relaxed/simple;
	bh=IXAWDiwJZ1QASVlqz6X2kJrPjiU5LXr+EOy8jYQfQp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cypwx4tmJ5WZFEOqxpVFeFTHLCu1xhb5tq1BBhJHO2Hjd/fJ2rZdXGVoyz7ShTffCVYGP0uas2jk3uol2NchJLy5m573f9mCgH+UsyhtqEyOiv2TSdANnwTwSqVpCS5T1xWluR3fee/PSoidwfhhqvicO47vDTeS7TbtFNoOamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B9L1bv3T; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-911449d9d03so173035685a.1
        for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778845890; x=1779450690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8Qj5JQsv1EWBd2kSvBn8cz0jUbxv6qKtDKlr9fP+AU=;
        b=B9L1bv3TzTgUaNS1HEAGSFven6YCsAEU+r65+VGgZSxztP8RzBuFgz/iS3H54F3IGX
         VpfL7SbIaRWaCrL3fXzjBNL2HB1CRT6gwH6wygsW5Q2uYP8gHUS2tdT2TqO4hF2pLQI6
         A0YEtVAPqIoaW08EZphorJmXUFrUwC38DawCjgCbd7S/1pO+Z8fuP9eaxpK7WdpqKXOm
         L5/zoZ2OHvrYee5r2d13lFQxHwkjr2FFLQgyYl4Lla7T3zTrw8EHb9efWFRcLt2xJQcc
         npvQOoXEA7Va5K91+jJ/6MB5sm3aDh2XDtbIiZg7TI5LIEqIc/nJL3hNBxHm5gbfdU6g
         8v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778845890; x=1779450690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8Qj5JQsv1EWBd2kSvBn8cz0jUbxv6qKtDKlr9fP+AU=;
        b=cXmJ/Bqww4qH5N/pZc+ieoA0H9KA3sxK6NzFWaRiY1/oMcAEyNh+zyE6htQ7gdHi/3
         WxT0/PbSWJ2pFuivty39mEKJ8/uyHzbBOn9Cqrw9FCbLZz/Vy4FaEmb5ANy+b+IhLnOQ
         63I5dErOOVcVP671DVUg5BvAuzlP1sCMssrixoXlhgFk7z3W6r2ymerd/5JsNRmStY8e
         4fC3sMf+ULbsmiUt9UKSTTXUX9AZZSvjmK89VLeath9l3ypQ9w0fj7IbPVRpDTZ3sQs3
         D0wsZymp+UTcxFd0dGlHhnN5/EEWd6CZPN6oLGR0KcdSAvIKocuqDVxQXYrO4wT/lP8k
         T1Vw==
X-Forwarded-Encrypted: i=1; AFNElJ+1sJCBdpvDIRjY0O7ACyJ5V5XnuAr3rAb2DBXEB/UHrk0urSbIYRJ3F9SgThU9vgu8tzb0EWMLAXW3@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7WgQz3cbfIGGY4UDGaYHYbEBtJCdrEl6OZjRvvaSH6KFdWlU
	SRwK16BfnxFYRSz2GOTfs3OyBhtSbHzt3lhbWDe+r7H+uaKAOS5epZIIaLnFj5J9uDE=
X-Gm-Gg: Acq92OGNoZB9LYWC5t8HJONmT8jUAsSQMv95FLHNr34XBpdPeSUU6Enh/1efezuKQU6
	J58zoRpdK7E4Ju7++zxpRIFcCWOo/Bdd4NP1InQD8V/pWgGZnK5FR23xRJy9vLfnKu+5g5WJHrU
	jAucRgsugz+wELjCWJeVEABzK5M25kyiyR/525jaAxqbC+ovIsTYc4n984ZjML78eyGyCvqt8sH
	mrG/e8gFLVjl/yUP6gvSBUC4gpDVbE48Ei/hznB+RtJkNXg4zCjoRA7vNLldbRgind+7U+2VC+v
	vJuBlKuPRi2Lp/Psu2eQ9hcHomVw9NENOWKhBApBAHN/11pd56JmojVZ4ZlvwPbnPEnWY0M8eAC
	Z65ITbqV5KgyfGLUB3FymU/uOpiCB60pHnLpRnjOViwqM4AIR9FMjhdH0OLzKnQQYG2yechDmm5
	Ov85cCfZzvq1jVY8ln+XgjcaLeWiaPsZy/ZBwg74UH/SEbYJX3SiPm23Z9P0tEjzW4V88O2Zz+5
	VMgSQ==
X-Received: by 2002:a05:620a:1725:b0:910:c8f5:3e43 with SMTP id af79cd13be357-911d0e500bamr547302185a.57.1778845890470;
        Fri, 15 May 2026 04:51:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba18132fsm527816485a.6.2026.05.15.04.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:51:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNr4j-00000007GvV-1Jc7;
	Fri, 15 May 2026 08:51:29 -0300
Date: Fri, 15 May 2026 08:51:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] IB/IPoIB: ndo_set_rx_mode_async conversion
Message-ID: <20260515115129.GD7702@ziepe.ca>
References: <20260513124519.3357165-1-dtatulea@nvidia.com>
 <20260514164219.0cb832ff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514164219.0cb832ff@kernel.org>
X-Rspamd-Queue-Id: 6BD3354EE75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20770-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,intel.com,gmail.com,redhat.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 04:42:19PM -0700, Jakub Kicinski wrote:
> On Wed, 13 May 2026 15:45:18 +0300 Dragos Tatulea wrote:
> >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 +++++---
> 
> Since it was tagged for "net" - can we get a stamp from RDMA?

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

