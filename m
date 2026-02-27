Return-Path: <linux-rdma+bounces-17295-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG7yM9KvoWmOvgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17295-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:53:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED41B943D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D75D73052896
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9842668D;
	Fri, 27 Feb 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ocQDH0m1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F79364936
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203983; cv=none; b=PmK8c9suqL2O3vEQ7goDGdi/U6u/XJIIJUil+I2CxIcXeUf5G51bzlYLu+U8GGo2wLqAOJtJFHHg6SbyzjiIChbRBUSsRpmrLMmo78sOJASfPphImsfJZ2UZA323afjHB81yL3AhHr8VxhffQFD8XCzlsx3MG8yFsouLTetyZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203983; c=relaxed/simple;
	bh=38jzOu0liYPjtYP6BEfdrenY04p+t5k0gXxfaDQNnwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjqCQQNUen9r/V7y4R4TLNCuuV65hEgutlKnCIxKdRDKt8OxBb0JC1yUcopNc37NwBQuWXk3zu7nWoPqVW0E74a9bnEe5Bjdpj0Hol8SakyMAsPSzpbRU8R8sw7WrLVybRKYfaA4dOqtB5Pmsp8ocb67REYsxmCx2ekFE7G77p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ocQDH0m1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506984b6d83so15775041cf.3
        for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772203981; x=1772808781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38jzOu0liYPjtYP6BEfdrenY04p+t5k0gXxfaDQNnwo=;
        b=ocQDH0m1nGyTYjFr0e2NHb4l1W94qAh5DERodklXLeW720zMOfrftTSnZaJcdwZMIe
         ChweAE+kBY7ygKXqWja7bRiKld40qHpOPGUxg9Cy2JPTi+gpPCv3rvnP6E0Dw1kPPKi3
         uPaNfqlVc/wXJiKizOyeLxlzfHTUKS2rNhl5R7AitNm/UoDHPo3SBimSagUur1UT9ffd
         wmipI+mHV9bZSGmWTKKDCWNYwrkOTtRKPf1Kl6HHlMeWnj8WguO4CYMYWgaYb0DD1oQg
         swG9P/ZirZyP1E7749YT8Re0WXfMe1kSzqex9kJZeHYE72CXpgHisA1lu0UbSE9mlwb2
         LvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772203981; x=1772808781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38jzOu0liYPjtYP6BEfdrenY04p+t5k0gXxfaDQNnwo=;
        b=KqIyMxFxFK2lgKXAfUMsRRA2w1z1AcnpqgRPMMVXEUB4rM0EDtgYsLPNyr/tFf6ISF
         qJgAlFdiVnbLhD4LGxmdXW25B4HZuyEYyKNqGqorqXRfQPuOEj8sRrY6PRQYe/pYvgdl
         RLLfwZn48gIttUpE1HHq1I9cH1ylqxaqlNb7DCoSdbPRDuCVfUuGPt4iSrx5C8uU+9a0
         sEbU6FDkiAxC3ByrLi+BYm2bWjgtzdMBBbBgWEU/P7Yf4cB2B3j63jYscvG+K7MqIPjb
         09xG0/E1IHbdN0p1lNuRo2kIE6k1lL5ROmdT48ktLW8uuJy/d+VvWvToTy6R43+vmdB3
         z/6g==
X-Forwarded-Encrypted: i=1; AJvYcCXHR3WJRaf72xcwE6HSxd4csZVDXH6xzBYCE8UIFzi3WOApswZo21GWkPf6/1sCOE4yJpIAVpNEr48Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5WiDTuSsfywd8UXZ9YWStwNDUcihyE9FkR/8EYRsVrHPJOTn
	fi97eNJRimAB//c7aVidcf47zhJQrfE9pUosUvF+AFnFi6R5ZthOX72rEsV+D/B59IY=
X-Gm-Gg: ATEYQzwoxNWLfwDBfvjmJ1rME3GlqccedkcSzOg+Iw3OT/pb+ZCNG4+Dwjk39Jh2MrQ
	3lIDBy8ihz9R/TbDtzKkpS/Ef9NBz0nF7cyR72/F5D3nFH1slV6tFaa5UzsDBRdhb2ivD1r/0Ha
	pV0pTDbMMgy4KDIifYxfcHEqkSs3cJuH9za0+litLgQD+gAd6CZ66362XonsimJ8DLcsosxKJ7H
	hu+O7isz4n0OzGHJDGK4x4pkQ9idLor8eeoeo/SaNAeK0UlfjLC1cM/TVmfAWdYln9L9J9EIrjO
	QBGM5aDMMvoHsvDAhx5elTbl9hQfulQrawMkVEwjV9L3+51t/4VEunNSNgVWxHMW/PG1SLGTdwl
	CAwXaDqpDmbepaE3cMzNcJ4gJ569wo2Hk8OCt1K2yQvQvKGmIuv/dntg/npxiTQ9mrDDiVMGenx
	GOlvOhV/5NVQFsHQ35BMbUXTZYhXGAg0vNa3rCRfD+HMgfy9frKjfqS+jNnYXUbFNLswYNHMyV3
	Ud9SzKy
X-Received: by 2002:a05:622a:406:b0:4ee:441c:dfb2 with SMTP id d75a77b69052e-507528dd496mr38152841cf.32.1772203981179;
        Fri, 27 Feb 2026 06:53:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7159b72sm45370576d6.7.2026.02.27.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:53:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvzDA-000000016OZ-0OId;
	Fri, 27 Feb 2026 10:53:00 -0400
Date: Fri, 27 Feb 2026 10:53:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jacob Moroni <jmoroni@google.com>, tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/irdma: Add support for revocable
 pinned dmabuf import
Message-ID: <20260227145300.GK44359@ziepe.ca>
References: <20260225210705.373126-1-jmoroni@google.com>
 <20260225210705.373126-5-jmoroni@google.com>
 <20260226085517.GG12611@unreal>
 <CAHYDg1QLzeQTXpCTeP5ZYcYyYLHG3yhUQtrGec+-5MzaGL-jKA@mail.gmail.com>
 <20260226194149.GM12611@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226194149.GM12611@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17295-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34ED41B943D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:41:49PM +0200, Leon Romanovsky wrote:

> So, in my view, all drivers should follow the same flow, allowing us to
> perform lock and unlock operations in the core during the call to
> irdma_dereg_mr(). However, it is not clear whether this can actually be
> achieved.

I don't know about this, interlocking with the revoke requires access
to the dma reservation lock in the driver in some way.

Many of the existing drivers don't support revoke so they don't expose
this problem.

Jason

