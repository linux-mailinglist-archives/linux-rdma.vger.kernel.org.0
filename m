Return-Path: <linux-rdma+bounces-23000-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cdWbJeHrUGrj8QIAu9opvQ
	(envelope-from <linux-rdma+bounces-23000-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 14:56:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E5D73AF5F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 14:56:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=AydgSSaH;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23000-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23000-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D6FB3055791
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E64C41227D;
	Fri, 10 Jul 2026 12:52:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D36CA6B
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 12:52:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687958; cv=none; b=qvjfj5kk7DClDTr13521ykDCFcwgrsvzcs48OS5MvGltcCE/y5mSek8xhFsNltQRhJ9rZjT1tuY6KCf/rkG6sj9IW1xQVG3UR5NLH2rcLk6InxnF1ExfAnia8U3J1GcGXG6zfnR5RjFBum7O/hwJPoNROjswsliQBHtx6IowqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687958; c=relaxed/simple;
	bh=RvuTfYBYq4+An7h8RGp7T9Wr2If88HFmr6sWzQCjttE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apQcYiuL6yfPzvu2AaTL04PlkQka9bPUCPl9JvBG7MI1vtmxksLvjc+YuF/89tMa3XYXeJydXmyASMWctiAW4VIWsiNe7L9mzPnLNx68KZ2ax19bULcCcbMY62Fdp+Y44+o6BJuHY6Efw9ALDLgWWVOXzjk4+yaGMMy/tcuEGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AydgSSaH; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8eefd4a8057so11337976d6.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783687955; x=1784292755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9a3+449cm8MGnIDiFu5KmKBBC+232LbzC7IoKmFpvdY=;
        b=AydgSSaHO0q+Gw6rYkaFYjAYqRfy6+cNfzkh1Bga1R3n1M006H/UsyumJikjtZXAHm
         2gBi7qsUTZw8sFIZXQSIvId8Vyodvc00MrOpO9h0GO54GiuZSpqvCGMdRiCoCc/At74l
         NKXB3i12zwjihfCHqHsS1KgsTgFCcpDQru/f06jvLYTD0ndoY+GrXnTfungALH7qdQb2
         tSgAoOy82PyIqNVKAWhC8CveUgmmvepjo4Ly2bQd8nfiXVy6C1LPIxwuP9rHOF/zm12V
         5AH/G2tKIXzCDoXriRmNeccU6H+HxvIpZphJf8g5TPs8zifq6Jooa/iFyTGG1YROP9YP
         VawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783687955; x=1784292755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9a3+449cm8MGnIDiFu5KmKBBC+232LbzC7IoKmFpvdY=;
        b=HkfGvwk9LmCLrGjACsaiyOjWa/qJysdw6TvvBHzlWc1AgKgMTQOrHPDaJ8x4E0hiWz
         s89sNCjSd9gP6WSQlopKvnHRuJoAgIgPrCJX2yYz4TGHD90I0Ow5tHSM2KvGvjkAycgT
         i+ykM73Z+zhf1f8kvIGvsDk+NlPaR+jfzWK/dwiHFfTLf/rkxkPJQW9l++LikEzxRrZ4
         ArsfR3bNXuG6r87KqAvWG/V99+9eoN/6TFkIShBvSCqvfI3KhbR9eohSWxPeKWuGXOSH
         hQPPI1EYe8HXbl+6DV7TJcGJkFloTIgKbhXaDHJC6Gk+3OyqreJ96we5fg4HZTvtMfh5
         Rm9g==
X-Forwarded-Encrypted: i=1; AHgh+RqugpLwx3uc6IrlCC9TMVSNmd2VhLithw9dSaLsM2r3Xm8O6q6YprYiPkMDkfeH3FGN7ap0j90uubxZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XyrF8WHSetBQ1C6pEJSaRh1xZsS21xwXmhQTL6dm4z5rstpc
	nWRy2vSk71fBrc770RIIgJC+6Aue9+n2UFO4YiswCddAMzvKETYWSso7QOaAK3yddjk=
X-Gm-Gg: AfdE7cnKvFJtc9csged+ZiDT6GZ41ARSyZUFiPzUamlSQEXRK8uHLD0PiVZFjaiWCfE
	/XiNXSi9DYlw3kByhu/8gZu6g6HAOqoDRxTrUPFTtlueuyeclxTsWmHeAkhA91Hgcp/hEeqcrAr
	//zkHS9zcoEMSjZPWnUHkuUXRrSJgqy24Z8nKsa6aI4R62tlpUm9COC+K0tW2tQEciOnqOauhZW
	+LX4Snxe+db5XgT3pmeW2pQ0Sm8drNXBy03O2JQV7EvQzip5qTfMzkJBNKRN3OdUAR3bQ1L//if
	f2/iEsbr2A2/s9tzH6izVCv7VvfwtYKTY8Z7IJPEl9/zHWM4omV23Ijkh6HrPQSvooQ0yM5fBrB
	Mat9IJnA2aVGwM7645mLdG5jecSrqGnM3FQ2Ij4edgPgeIZc2m7H2c1v/Bvk34jHsKGHdxME=
X-Received: by 2002:ad4:4ea4:0:b0:8fd:6dc5:94b with SMTP id 6a1803df08f44-8fec3a05028mr123145186d6.64.1783687955236;
        Fri, 10 Jul 2026 05:52:35 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fe009sm40142286d6.38.2026.07.10.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:52:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiAiX-00000006sit-2xhr;
	Fri, 10 Jul 2026 09:52:33 -0300
Date: Fri, 10 Jul 2026 09:52:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"shirazsaleem@microsoft.com" <shirazsaleem@microsoft.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Message-ID: <20260710125233.GN118978@ziepe.ca>
References: <20260623114444.1429042-1-kotaranov@linux.microsoft.com>
 <20260702180158.GU7525@ziepe.ca>
 <PAWPR83MB0984EFB0540738E4393837BEB4FD2@PAWPR83MB0984.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWPR83MB0984EFB0540738E4393837BEB4FD2@PAWPR83MB0984.EURPRD83.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23000-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@microsoft.com,m:kotaranov@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:longli@microsoft.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03E5D73AF5F

On Fri, Jul 10, 2026 at 08:54:03AM +0000, Konstantin Taranov wrote:
> 
> > On Tue, Jun 23, 2026 at 04:44:43AM -0700, Konstantin Taranov wrote:
> > 
> > > +struct mana_ib_uctx_req {
> > > +	__aligned_u64 client_caps1;
> > > +	__aligned_u64 client_caps2;
> > > +	__aligned_u64 client_caps3;
> > > +	__aligned_u64 client_caps4;
> > > +	__aligned_u64 comp_mask;
> > > +};
> > 
> > I think Jacob has it right, This is looking pretty gross.
> > 
> 
> Jason, I sent a response to Jacob earlier. I am not sure you saw it.
> The problem of enforcing robust udata on alloc user context is that it blocks
> any future additions to the request. Since it is the first IOCTL there is no way
> to negotiate the request format. And that is why I wanted to reserve some fields now.

With the udata system you can't implement a scheme where you send
unknown bits into the kernel and it returns back the ones it
understands. That protocol just isn't supported in the 'zero means
backwards compat' semantic we are using for udata.

So I'd rather not see deviation from that normal protocol (I know a
few other places have but lets not grow)

> > If you want such a complex protocol then use the new ioctl format and
> > declare sensible driver specific attributes. Nobody has converted
> > alloc_ucontext yet, but that is usually not hard to do.
> 
> I have a question. If I add now ib_is_udata_in_empty() to alloc user
> context, would I be able to adopt new ioctl format and extend the
> udata for alloc user context?

Yep, they are orthogonal things. the "udata" is only the legacly uhw
in/out structs. The ioctl mechanism is uattrs based and completely
different.

So you can set an optional client_caps uattr and implement this
protocol there.

Jason

