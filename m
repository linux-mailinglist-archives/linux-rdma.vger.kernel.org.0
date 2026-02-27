Return-Path: <linux-rdma+bounces-17294-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIa+Fs6voWk3vgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17294-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:53:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97771B9436
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D84030DCC2C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15417426D15;
	Fri, 27 Feb 2026 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y79a1mS3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9342982B
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203844; cv=none; b=WNnG2NWrlIAJ9sQ7wL8A/7QoqSyevA9TPqAu3jUKKsAWE/mSCI20NIjblVoFRkn3AZze5HpdI55LHe3TKwhmnGmJEshx7VB3GfKb4ANDHpjYugAfZCt3ccYawFuoczJ46UnQYBxDcoRGpUprFe0dGOb1ggDpVquhhrJEO1TqxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203844; c=relaxed/simple;
	bh=7qMAtlqEERh0QTxOQuOlnbIc1h7SwmcsDK8VFLqTeXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG2NxfJL8lh3A2rTjq9kElkHY5emGjGUGdU3RXVkpaWKPcFGT/fv4ok7HCNf/Pej5RrRj0dFvLmx/H4TpxVy1kaT6FZbD45CcFeTNx1y2kszuDkNTFPbTPa5HIT6itQCRa4c43GY8mP7XSwksR57mh7VakCmTI9auPcbNb8/DZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y79a1mS3; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899c97c5addso25340006d6.3
        for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772203841; x=1772808641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FXPmkuMa+SjC20VO3F6GvvoxqvqIX4Im8uJXcn8ILQ=;
        b=Y79a1mS3nDmHgoPuQwjoWbjatRvTNcq2hxTrgsu+/5wOp6Cb/IL7kscPYOBp7VNRUC
         M8oimFDYU0tcWl+Q3tHyp+zOX6o7ifoW2w2HyQ8oloZ6bGDTj88VTad75OrGl5sjOPMs
         3doNYa7GpBY98kbOaUGAVs/vGezVVhFK/JumGuTNACGXlrv7M66dd68nxHfaO58gVGOS
         IPERi9DSl5L3f9RKMCFv9BNVTtl9WrYrRM9TgzX2j08fW8m5OxPzAjIfGbIEaDZQBGsv
         U3xb/L4LPXnqceainZRAQlrjpC+WtzyllmZpPwu9jg0tUQrjiQ0FRzu/WVP4GtJ6fIv2
         pqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772203841; x=1772808641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FXPmkuMa+SjC20VO3F6GvvoxqvqIX4Im8uJXcn8ILQ=;
        b=RXJvKUkV9CU2HD/C3QsSwTmNVQgC2QYa8q8EMBD0vuiv0cA/NHP5ScGq/iTh3onS99
         YwOtmFbZuXMWYhhqO/PcSide0j8xLI35SGcGTVoh4bsbmBLW7yuXz1bjqSSwrD+nDimJ
         ezSjgouL5S5RZyj0iSqXbgH9Cg4B2SgxkdINA0A6WJS9YSTSEH7e+0gjsrp0tAoMcvYM
         5CAroNfKhRLYkMGzFKLvFiaEALG9z3Z3qEowtiwEUe0IJdVEs+L++TCNgmXpVu95ZRLa
         VzgGg9TS1pb8+wBW/cxeUOTh5EoviMtokymnXImzzpbgDx6RKluqxoRQePWhT4AwJKF6
         XEMA==
X-Forwarded-Encrypted: i=1; AJvYcCXFdzqEfnmA7efDA3Twmbq22ZNCIYpt8qpEFYjzKh1I8cTcOOlg0q9wFsRdmUP9sktWJg6kGxhDxbkN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyax5Bti0S8UHpnq/a+CJgkAmELaMHWznS0RZ5PvCU+/nzTpuBj
	whoBCSuHhCKWS6l2LsdwndCgRbPE8kko7Xg/mwYp2pFySmkdfRwv+EK2cwdqykLn2p4=
X-Gm-Gg: ATEYQzxLTAmv/ScDcwIlIr+TtGYOdrl8+43uEzMWgYrZnBy1t2ZIBnrayQjL1zLW84t
	XgzBOz+kQ/D5JE37ZulIDuZn+CW3XXrjV3fRvumdFzP3TRPI8715tTeydz9Ybh0Z8TH4lV/v4Ug
	n7m8VD9XYKSca1YVOLEKDWcD+ChekWeCdg0g7WwgjugDcO9TsmPuPgc7Bcu5xhUGSAOqSh2yaiM
	PfElD0LER2H+BgpCIUpzgtpGoBnvm/yYlBZe5cELnBmldCrIB1V4fPGB7iAHACy574Vk5zj0InL
	4jNiIRXi6kQjuMJ73f45CXTai6PM92fkCwL/gl1YlK33c7G4ErI2n9/280rB7nsEzo1mSSqOmg2
	n/tzI+aOvvhqu1axsymDVsixMN/Ypc4QTlh1LY2mX7kf29Ox6cbQi1xazlfrnEnDJbB1/Zj8eav
	Zl0qpdWuyIflkF+VUrpgiPEOyFTBL1UeViJzewZYtiV8pAYuUiRlb+orch8tWItAO1dKY72tsaD
	ceYRQG5
X-Received: by 2002:a05:6214:d81:b0:895:3ec:9e6c with SMTP id 6a1803df08f44-899d1da87cfmr43336196d6.1.1772203840715;
        Fri, 27 Feb 2026 06:50:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c73a320dsm44348516d6.52.2026.02.27.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:50:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvzAt-000000016NQ-2j8z;
	Fri, 27 Feb 2026 10:50:39 -0400
Date: Fri, 27 Feb 2026 10:50:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: Leon Romanovsky <leon@kernel.org>, tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/irdma: Add support for revocable
 pinned dmabuf import
Message-ID: <20260227145039.GJ44359@ziepe.ca>
References: <20260225210705.373126-1-jmoroni@google.com>
 <20260225210705.373126-5-jmoroni@google.com>
 <20260226085517.GG12611@unreal>
 <CAHYDg1QLzeQTXpCTeP5ZYcYyYLHG3yhUQtrGec+-5MzaGL-jKA@mail.gmail.com>
 <20260226194149.GM12611@unreal>
 <CAHYDg1QB9sPWLx34heDnnV-K=pMXniqT7qxL_CY95fi7esPTBA@mail.gmail.com>
 <CAHYDg1Snxj5sfFr2ebkacZjbpttgjFyPHGedHXG155MXx0NMEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1Snxj5sfFr2ebkacZjbpttgjFyPHGedHXG155MXx0NMEw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17294-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: C97771B9436
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:44:02AM -0500, Jacob Moroni wrote:
> If IB_MR_REREG_TRANS is specified, then it will drop the umem_dmabuf and
> get a new normal umem based on whatever arguments are provided, which I
> guess makes sense, and I assume I will need to preserve this behavior since
> it's user facing.

Yeah, I think that is where we are at today. You can't rereg into a
new umem that has a dmabuf yet.

> In the case where it is only a PD or access change, I will need to also deny
> the rereg if the umem has been revoked. 

> The buffer has been invalidated,
> unpinned, and unmapped at that point and the rereg would have the side
> effect of re-validating it in HW which I don't think can be allowed.

Right, once revoked the rkey has to remain inoperable and anything
that undoes that is a serious security hole.

Jason

