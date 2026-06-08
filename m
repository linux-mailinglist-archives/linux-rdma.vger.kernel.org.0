Return-Path: <linux-rdma+bounces-21980-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1TjBBIUFJ2rJqAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21980-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 20:10:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC66598F2
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 20:10:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=om4WQfHE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21980-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21980-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDBA30B4227
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6541F241686;
	Mon,  8 Jun 2026 17:30:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31021E098
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 17:30:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939855; cv=none; b=WUl6utEluPRtyULYaRk11AAtJrA9tigQTCgDqJ5gCzWJd9x/ndrV1540yAOYVW0K/LjebBTwjVwrITP87S79zQ2/7TXX0w0YTXeKqibGoVDN9xhA90+2BL/gmIs3whneLR96QgTDfDyDib0IrjNa/6IdByj/ibJKAP8Nb5LjqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939855; c=relaxed/simple;
	bh=8kCMTwljED/L2rYr27Y22xXrKDlzMGCGEZr76dtycjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zkb3Nf6RmxI65g8YBhDtkDSGecXO7gKo0ZaTXUDyV+PWmYX2EbNgsPaxGiBTgweKaNVRLtZn0b2wOeZd+KJg3cx7SGa60SNsEVmkJVA39lykeRTZnzNxvv5Ii3XEJefClRPSwU9UkjOIOwnpfi+o+HRmJdPqNGo92siHbXPpkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=om4WQfHE; arc=none smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccf18ef922so66119246d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jun 2026 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780939853; x=1781544653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu8/bo/GD+ueu+T4fB3U+9+0cJ9Sc/+ZCWEG94ix8pc=;
        b=om4WQfHEu/gXtWdtAffkc4eZi85w3lHvVVWRpIRY5GujPf6EK3DeDcmeErpkOdE14J
         H8wHTzThy8Dfj9HhtUGLlo23jyYSzJKor+mQCoAnJmMXWkaML/r5sD70NeizOgfzh4/r
         dU0byJNeGLWKqH9z/eq1/xus4VICLn/Ny4EAM92/4GnNO/wGRGcrTLEr5hx8ITHJNSQF
         OLMKPFcJWs2XhpYY+t74XJIoCbHgVa3FTzh7h1ljg8Z0IFVYhLix8wGCCtoadyzoooL3
         6nPHWu5BFpK8p1eaz+AXe5AzAcmoNqP+8X9QGB8HRhSxo+mDBnGXj96poD9lVyot/ixA
         oiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939853; x=1781544653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu8/bo/GD+ueu+T4fB3U+9+0cJ9Sc/+ZCWEG94ix8pc=;
        b=WFoOZmrDdbcLcCvMbCn2tJlEuCmu/b61e4ifVEpV/12/0nks+JyLEoXTMeix7Hb9hE
         C/lkubd6cbws20ytuQX0znkLZNPBOoIOdZSRwkWtYBOBw1Y0zGcpjwcWwBpaVHNT124T
         GThY3aA3ML09VF66TMMajNVst31UjaHTsDJs3TFQG24aaAaHnvQqbYg++2EaLOJjH0j/
         kCV/lo62G+JNTYwDOMsozLdHTG4fBiESoJhzbKLUaWyjWk3hTffqVuUQa03tEiy2u3lB
         ciwAgovKYSYEV+YTxS8c/V3uAptFbrdsMMkUa/KGN/MpJl2MTtbTgCCOLQY4T38kkqYh
         0Atw==
X-Forwarded-Encrypted: i=1; AFNElJ+nOo6sU6Bp7Hl6APowVfhrUlG5Fdy2IZRFldNtSUG27n8OrcL59RWocqMUG0YAUZLAjUmiIWhisxjo@vger.kernel.org
X-Gm-Message-State: AOJu0YzTIgpNB5OAN7Fq1rogWDucgpSKU0KfswfHPj/9YiL/ZB+5ukuM
	xPpRBXqz4xw5vt71vxjLaLBDXKj6GvhNVbvgo+lth6Vljh864/KBJKOH3Dk9ny5I8xs=
X-Gm-Gg: Acq92OEKuXdYLRAvZmycA/gc3yJ9rHd26vDC+/oD/5BjDAOojl8ZhbJvp8Fc+4iIwXk
	n2G6F095OxckOA8mCttXpq134w7YdPwfTjK+141Uudxw2PyK/LsCdJx232pBmUimfz/OruwvJUP
	HJXdsfkWnCNtd6zw/qvuxZI/G8wRWt6J8hgx9GnPbaQAVlXVqU1YW+TashJeDaYW8Or2BLvNy7T
	1B5kDGBv263PagEFg7RMx13qYQhMM9ebBYm8nMt+ZSJZzi0e4DTSqwpXtPe3HHykfjzNuuCa8Hk
	Q2dxVK50gKmjfOXEcmxAy+l7ogYcVTJhyWzr37Nm++IXQlj61vQ4XMFY8heK125TVB1nHkwRw3C
	meoxiKjNIUK2Vme0oFRZAsnVRMweJva13KvVYZ7VD4gsW8tve60c9hJ/SPnHIAVmkx04stu4PP4
	/vELf2xooZJ31OTHj6dEheha4ojd5MnNwM3zfuGJsMh8X551Nq4vKFX5utECNxpCibAP2C9qv2W
	NItlSGNMs7pT5KegrGYXGpBHUI=
X-Received: by 2002:ac8:59cd:0:b0:517:b68a:8d84 with SMTP id d75a77b69052e-517c22529e3mr30782621cf.56.1780939841127;
        Mon, 08 Jun 2026 10:30:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb9bd6sm187424546d6.13.2026.06.08.10.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:30:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWdo7-00000000BOR-47jj;
	Mon, 08 Jun 2026 14:30:39 -0300
Date: Mon, 8 Jun 2026 14:30:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [for-next v3 5/5] RDMA/mlx5: move mlx5 clock info to common
 struct ib_uverbs_clock_info
Message-ID: <20260608173039.GE2764304@ziepe.ca>
References: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
 <20260606050003.3648306-6-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606050003.3648306-6-abhijit.gangurde@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21980-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:abhijit.gangurde@amd.com,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73AC66598F2

On Sat, Jun 06, 2026 at 10:30:03AM +0530, Abhijit Gangurde wrote:
> Use struct ib_uverbs_clock_info from ib_user_verbs.h for clock info.
> 
> The original struct mlx5_ib_clock_info remains in mlx5-abi.h for
> userspace ABI compatibility.

Please don't do that, we generally don't do compatability for
compilation only, especially in this case where rdma-core is the only
consumer and it has its own version linked copies of all these
headers.

Though it seems like the contents are the same so you could just do:

> +/*
> + * deprecated, see struct ib_uverbs_clock_info from ib_user_verbs.h
> + */

#define mlx5_ib_clock_info ib_uverbs_clock_info

Jason

