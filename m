Return-Path: <linux-rdma+bounces-17641-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yERzFuteq2mmcQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17641-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 00:10:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E33222888E
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 00:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64020300BC81
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0F35C1AD;
	Fri,  6 Mar 2026 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wsg+1JCV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFA33D4FE
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838629; cv=none; b=MaeX2nHlI1lngTUFG9wLu1NQf5pYe7SQ3bZ0LYukKp83jsZyvu70j9Q5A1dpFB2bUKzcpcr0ys7sn+Ql6xCiHZDwiPLq5E1nIBYA3dHfHFSqmckdvntbEc80ldnLVL/+m4dPC76xLjZwljrsDs00EioBuo9Vq6rN1MQDHOpwqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838629; c=relaxed/simple;
	bh=+Wo2K/X+Cq11I5YoP13/K61MVEHaQ70AgPIyYdTnDro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGXSQe/UPAJhWHF+U/txasAvFL4RC88WMD9OQTtd5EOUGCv2akhXmWzGPSX8+Y8B1Vlb6H/P1zA11C/W/71Gnyx+Iz4VS89buTcO0UzKE6xrqsbGoXB3IT1G5kEKLT37YSBe17c37TtfopVGuiYaqorbMw4JUcw++1tX4VFUCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Wsg+1JCV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5062fc5d86aso85548621cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772838626; x=1773443426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X8xiVcJi/2j0+t3xwC2rYaGHbViIQdp0Z+nSHzUs3cI=;
        b=Wsg+1JCVrTec4XkcLEFsr9/nUlMWupW7x2g3G1YUHiDimWJ77Yg6+qfbLvAAaUk2SW
         vkP4fZhatWRyjQ3Fvq+pKs5TALFNAMK4wDFqo3aqiOpGiXINJ7ErRJy+E54PaiMmSomB
         +WmlTB6RyNlxDd3GPsklgNbgCLdA9wFdb4xAFw0I4hFGhw8EKHUvMH+Pf6Olqj1iKJCq
         4OxPR2+3s6SWyTRqPz4x2C4hbqF/8YZ/2JZxNKbQ/NWATHTHPxY0Pt9lk1NP45z3qldq
         kXOYHO6y0EaFBu0gEsAN1i7cd4x+DAmBLq5R0yicZ3nc8F7e+IXOa+P5bHLm29VUQVfK
         2rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838626; x=1773443426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8xiVcJi/2j0+t3xwC2rYaGHbViIQdp0Z+nSHzUs3cI=;
        b=PM+7vf/qn6O2cE/ATyYitNXeKWEZnWRv5hO2UNsPXiTHVLi2DwEs15SaXWiAK917JT
         Z/RVezo/ljUzP3pvHKsjmBn+W8bYC0xOgVKI5Y9R7+RAJyUsixb+QuF7DB/Gs4jLc/Wt
         Vi4ywG/FvdtcxhFHAr7F+yWtBMdEyN8XKmp8pSVTN08TxJ3DFYcsOQjBWoO8Gs6/01uP
         ORWQnqw3X/EL5b3LBqncejH/Z6I3B8Aw+JZydP8O3wdsZ/e48umgIrDo/InyG35gtQcJ
         0e/MHUPWCn8KXz598fgL+TddzRo6YAE0o376fifDU5qO3EXGjV/l3BPKVrDAOch+Z0Y3
         nsIw==
X-Forwarded-Encrypted: i=1; AJvYcCXevesiO2W4ajZdOSeZ3MHgHB3oSMxo4/3B3uPnRrAyaGQUs352YTOxQV72YEaXhJXu3hdqCc/Pt1sM@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzMOX5hFz81ys2xh5uLQsU0FqUrI0lKX6sps3N7eGLHBCRpGB
	WKoEKjJZC2DdsS86b/YfOVuP0GnqKoTwN8TKfsBKusOLgj95JPIzky2HC43LD2qoWDo=
X-Gm-Gg: ATEYQzzO8J4S621aUWrA6b24Lux3DlBB0X+lNaiNHDDiwoBUpvVK2WYKhbojOeldNmG
	RHXKJrHnYtt0qlzenyjEhzEIef2Yqzik80X9q0bW+vzj9VgEd7zphdot+wTCUzWZtaPGcfup2wt
	edE4MY0Uof0a9HYpnH+lxlVGLNckuDjr3O7ePxsxQcWnrGF2kS78k6OR3k4MFLvgXT3MiBCPzzV
	Zm2BQs1Q5zQMepbHz9UHd4yPot6PDhdu0JzcIifg5u6Wmh2QekOQz8NZZ/J7qj/HNMYxolbxJFu
	THWnWsYzEn7FK7CoIhHovMfhptiDkdoPQitkg+rM2cbPrPXafQU6lx1N5jViTxwOPC4bkOZs2Ny
	iWJVMTVYEJeyrtuY/6TCQTjRsMFbjxUJsoslYWYrWvQGkK19HffQ9OFtR+97uvsXOr3WswfUfCG
	XNNAPJwzxwPHnW2bEKhTVLos8yu38SjuCNRQnKC5K4JBCO+7t3iSw1d0dQDANnXyr5rpXlHvf8I
	dIREtpO
X-Received: by 2002:a05:622a:11c1:b0:506:9b96:6283 with SMTP id d75a77b69052e-508f49980eemr54331101cf.66.1772838626596;
        Fri, 06 Mar 2026 15:10:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66ce03esm18225341cf.27.2026.03.06.15.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:10:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vyeJM-0000000FcSI-0t9y;
	Fri, 06 Mar 2026 19:10:24 -0400
Date: Fri, 6 Mar 2026 19:10:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Praveen Kannoju <praveen.kannoju@oracle.com>
Cc: "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Anand Khoje <anand.a.khoje@oracle.com>
Subject: Re: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Message-ID: <20260306231024.GF1687929@ziepe.ca>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
 <20260304201151.GI964116@ziepe.ca>
 <CH3PR10MB7704DD1E6B9A671796FC6B528C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306003217.GB1687929@ziepe.ca>
 <CH3PR10MB7704ABC8F3909C60FFDFB1188C7AA@CH3PR10MB7704.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR10MB7704ABC8F3909C60FFDFB1188C7AA@CH3PR10MB7704.namprd10.prod.outlook.com>
X-Rspamd-Queue-Id: 5E33222888E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-17641-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 02:19:09PM +0000, Praveen Kannoju wrote:
> 
> > On Thu, Mar 05, 2026 at 05:08:52PM +0000, Praveen Kannoju wrote:
> >
> > >    Regardless of the underlying causes, which may include IRQ loss
> > >    or EQ re-arming failure, the TX queue becomes stuck, and the
> > >    timeout handler is only triggered once the queue is declared
> > >    full. In scenarios where only specialized packets, such as
> > >    heartbeat packets, are sent through the queue, it takes
> > >    significantly longer for the queue to fill and be identified as
> > >    stuck. A proven solution for this issue is polling the EQ
> > >    immediately after the corresponding IRQ migration, which allows
> > >    for earlier recovery and prevents the transmission queue from
> > >    becoming stuck.
> >
> > I undersand all of this, but for upstreaming we want the root cause, not
> > bodges like this.
> >
> > There is no reason to do what this patch does, the IRQ system is not supposed
> > to loose interrupts on migration, if that is happening on your systems it is a
> > serious bug that must be root caused.
> 
> Thank you, Jason.
> We'll evaluate more on it.

If this is in a VM running under qemu - qemu does Lots Of Stuff
whenever a MSI-X is changed and that stuff has been buggy before and
resulted in lost things.

If it is bare metal, I'm shocked. Maybe an IOMMU driver bug in the
interrupt remapping?

Jason

