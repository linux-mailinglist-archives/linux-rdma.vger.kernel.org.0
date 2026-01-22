Return-Path: <linux-rdma+bounces-15897-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /AtyNwaScmkMmQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15897-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 22:09:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1296DA01
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 22:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D323008D0D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B33A641E;
	Thu, 22 Jan 2026 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GQvRSg95"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E1389E0D
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116159; cv=none; b=J4I+M0f+/PEFPWS9oIrtc/6cGnOGLSezKmUBf5l9NqHxLgtssB0987Apx4/UJbLkru3v8j3citm4h3Xpppz83CaRfL9xfD3+BhO5DZkuO4XLS4hUzPiK9oUjH8vOkQm02vtbyLNV66G9Yn1y1DjghBd+xgPa+ZFWQZC/qGq1gio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116159; c=relaxed/simple;
	bh=raGXDYHLzgb8+x8LNmB8xhUu8SD1SWm0FHsv5w+2Zsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6BwW+dSVv8U7wxA1Pi0UfdRT/Qelfo+R83+KrJFfHjv9awBDrvZWzqh5g+S+MVbnVcb0Pds9Y85Th7VvE/Wl+DsmrtTaRvI3+goZ361nO4qXskfWPf9dFcshooSblppzEoAnYtL59L8KUTz38vQlZ/BXpJVXiW095Xk+Os9Bs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GQvRSg95; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8946a794e4fso17403766d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769116152; x=1769720952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGwvu1eEWrGS2Sij4VrgqdZ6baUY9/bBnBj0tMsMFh4=;
        b=GQvRSg95zQpJxWqXPE7LqSFoRzzpc1l4DjiqpUIUrBfUemg8uCfdDbKUEZ44THYF8j
         TcHkgIhO079WYeaudqxwbzsoumI1JFJ4Fffd6f7bZY5AstjgjS8HTEX2cYajyAYZ6rOu
         ZrJ4tkA7ytOCdbPLulu7rGuxURMmGrsyGf9GDjHdkRIKzleJMGO7EicQh0U6zl3ebMX2
         ckfanjVtq9VpBydxYJpr2S4pfu3NXk82HZX8WJNJUQz5KW0Mp4mYD97Jjxajd3vor5wb
         Jrlms8NEoZb/gHUfZPyquqcHSrZiuR/t3tNaztmiqg/e4yvKJ4jUo536mRriFIXSz8+r
         A2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769116152; x=1769720952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGwvu1eEWrGS2Sij4VrgqdZ6baUY9/bBnBj0tMsMFh4=;
        b=Fw09NLsOwDuy+IbHgnyfzvL5wgdO3k34+0efLUjyPaYHCUJ6ONA0O7RYKGWjxtaAp/
         bOp0qfPvUd/9PIGeyjnGatlWa99nPAePgqDL0cQFkzZLdlQzpRojsEe+ML+aliqjf7PW
         vZ1KZ2sSBojaXG9IwJR0ZBTcj3vk15+u8c4UcMy5u+Feut0kpUIr2A9/B5bPVxBD01eH
         wjSGDlhL9r9ipGbBDlDXciRqaBFXw8f47efXKF0iWjQpz+WiGdribnR9hoas66mbbt7y
         nYGe5Fhqr6IAlO04rQzLOIo9dYRWbBPxfK9oAV/HpqtXbgiQq6/aKqBizNHkA3npxxQM
         EA6A==
X-Forwarded-Encrypted: i=1; AJvYcCXrMSJhcJbyGKUXcC3IdiVVJFTHcgGrlT0XVLQfQGgfrF4ZLZHG2eE8sAm20OvIyCuNuSU4Jz1rfQPI@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9XecYMqmznfuvANEPnfvcYkwgt59EnzVKoAjEPqSNEkhmHO3
	DQCrxnrzzh06EixT0PiaMzbwgEauDlPDo1H6AyXx5wAN5CWQGp+neb+o687gtGXIW4o=
X-Gm-Gg: AZuq6aKytYxWlvWy01bfb+KlIphSqe1A514D249xWY9IWA7tBCDcHVAk9n2BIDff6UF
	oUfTwyoLwjX3wv82m3M5sIm5+P/5GfF3N7WGo69Au/GYNRsARgshXQ78itxo/1YNVEM79+pJEPo
	VjxgT7VgEyIL2mwqYY5YPhfrv4r80rlgSpN16QlRlbEdXLpN97/Z7jkk76XayCEswZTE222qJ8w
	KR39u67dhJaCeUL/6OKOwNCNarMv/9KQLqj8WKmpQgwp5EHBwU6H5M6gdvlBt8nMv8broWw7dYc
	FAsScJPOHOvNmji4kUM8RsrLB2io39Lh41iA6MqtXhKuJjBh+Xu++SGP+kn896jG0otylOES0AJ
	5rWEV/mdKtKALKU5njtQ2KCELFQ2pv98eamNE9187t1tsdLjqaaempbnDevdENZ/lx020yARLOU
	MJtft9qSz0bB0UtrE2XTWg5Y0pj9x/BZRJYmAnTWA/msCEQgQsPUst0vLW7lEYOf1ma44Hg0Phr
	Magmw==
X-Received: by 2002:a05:6214:c4d:b0:894:2f5b:fb98 with SMTP id 6a1803df08f44-89490227988mr13607876d6.38.1769116151949;
        Thu, 22 Jan 2026 13:09:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491970046sm2399556d6.57.2026.01.22.13.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 13:09:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vj1vS-00000006fb0-2F2g;
	Thu, 22 Jan 2026 17:09:10 -0400
Date: Thu, 22 Jan 2026 17:09:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260122210910.GK961572@ziepe.ca>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <k3mj4pl3ifyrva44z4bscpzwgmvctr2stgorixsj2xwtvi6sws@7miulfpsl2zw>
 <20260122140742.GI961572@ziepe.ca>
 <CACDg6nWkZTGj=rnHorFBXgTVDoKcb1rPRSgVBnbj9xjh_Uj3Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDg6nWkZTGj=rnHorFBXgTVDoKcb1rPRSgVBnbj9xjh_Uj3Mw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-15897-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B1296DA01
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:36:59PM -0500, Andy Gospodarek wrote:
>    It sounds like Jiri's proposed core changes are the right long-term
>    approach. We would be happy to collaborate with him to accommodate this
>    in the next kernel release.

There are two things here, Jiri pointed out that we already have
create_cq_umem() which bnxt_re_dv_create_qplib_cq() should use instead
of calling into bnxt_re_dv_umem_get().

And the second is Jiri gave you a patch to add a create_qp_umem() to
do the same thing.

We definately need to see the CQ moved over, and I have a strong
preference to see the QP as well given Jiri gave you the code.

I forgot about this new addition the first few times I looked at this,
but I think you guys should have noticed too :\

>    However, based on your comments in the other v8 thread/message, the v8
>    series will still be accepted and added to for-next, correct?

It is only rc6, Linus promised an rc8, I think you have time to adjust
it?

This stuff is important, it is uAPI so we can't exactly fix it later.

Jason

