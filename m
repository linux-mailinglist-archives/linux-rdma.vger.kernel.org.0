Return-Path: <linux-rdma+bounces-23013-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pn8+ELAnUWqfAAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23013-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 19:11:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A373CF14
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 19:11:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=cONAkFV8;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23013-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23013-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3101230CB2C2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5E43E4AB;
	Fri, 10 Jul 2026 16:48:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199947886D
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 16:48:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702114; cv=none; b=RbQtH6JdDY1D9YPURVp6vfGW/TTfE7fQmda2gox6071Vwq/lrjuAgS9sUdMpTfpDz9S281bIW0GaQQa0S2pPn3pBM0GuSRnirEQm6qtEn2XhXmwd5B6HVljWMbXaZKwCek/fMlQSqZ+ex2InZOZO7RbdFntMhCNLBKQmKz1mq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702114; c=relaxed/simple;
	bh=+/fv01wwyYrVmIZh35u1DvA8BWdEZMjEk7LlzZw2uoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHURlsTwbZungZyvLd4xXyoBrM1FCakNyWzMfSDC/oaQOybbxZZ+Z99IYXErrFf2p36TGUXEPcO1t8N7CMMPvlh74u2uXzYsIvLqyd0Dr22R7Dwql3DEU9vNcPp3Ztxdb22+++SiYEBzjsMX5bgg04baFihtm6zPZFgND7ir4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cONAkFV8; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f23e851626so9801206d6.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783702112; x=1784306912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uqcGhN/IqnLY5kn4sQ1A7rwVJCth8mzmpAjiHFK7f+A=;
        b=cONAkFV8nAue3sdSajC9uz3kBobHIPNo2Pke+U6dg/+EKkDCvALATNCqG0l/Itm+ze
         wGjVRZZoNOSDT2F1Wcg98Uen0yKxgGxkNRQx4g6ErTKqdKN2LVoTLuLJRtu1Wat7uYd0
         Fk9zemfBzAAllbTj7NG4MjKrHpnku3OOzeJ5jzbmktDPHbZP+UQhrmb+3TPWAC2RtTDL
         Q23bsMt/IP6MWWXgGRsFBLCj5gUQI/NJg2eiRkTYrxdFCXNA3/v3nlnQlOFZ1PkgR7lo
         WWvsf86DzYZwvZZXpJqP9DCZeGlttQXW2+xL9JGYe0CUnh1DDFP1AHvbVp+hzKbivJ4r
         SfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702112; x=1784306912;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqcGhN/IqnLY5kn4sQ1A7rwVJCth8mzmpAjiHFK7f+A=;
        b=UjtUJ3RzgPjJah3zsMgFpKXsRacAXwxja5ZitAaH6YDorNsx53/V53kCMsBaCP/Tg5
         mXmqsUjwdF8wmvdhvOFXn1r0OEhOVC7YAeYSQYP41H5erpyRPdmHLbCBm+IC+P3I9Ov6
         M5VpdY78Om1wsgDkqGo32svQKPdabcrw9W8oZRmra+T+F7yTjK36bQ4waeGGQbqzRmGX
         IOqAymUQPbI29r3TPfjFQD7fbLPU35+BAERjCqYjwJ8mepu23B1z2G6Ql8ej7Yh7B8Vx
         eQ+cSyEuByrI9PK3bykwiqJ7RMYFQKf3Ce0LtKhW4ameWfAoHm3uOOr1CrolohmxFkND
         r4mA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+7akz+U7dtHyIUt/5tX2HFXfSi1U+WOpvcmUEXAYrxQ65jihbS0FflYWaCmRMvt8HRl7qVZk5EhyJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpYKJ4YbIl+1BIUPHVnzi5urwW8IYwrDgV795mZk6hjV5tGUJ
	r+xTr1qhBmIU0H1TbX3tf/iMB+AWxDDv3dHyykj//SoBxLPTmDeKauOcoiWfnGzjdPc=
X-Gm-Gg: AfdE7cnP0pSolM0LTqljzUaXMWoWBc7sz5RPzNW0kBVGTj9bmmRFppxhrWUwfWh8mF2
	RFHZGq6+SBDWn21Cqb7esHhuKIXGQAxgbk+g+LrvxrznmltYmNRJjlM+LW3s8UaxbCqfqWXrK2R
	59D2V1amX0zHANoh3XUYj0ZKGVupAnf3SPaxzp1o2qEXGg5cRueRw2N9x3rWIEJqYPEzbKvgonx
	HRTCM7QvHPiDQ4z/cYR/SNthrUf7f7dV/fbZ0DNsB+rpLb/Q+yLO3xqOW0oedzcZpXl6MD95Aso
	+Blu4WiVMEco3Aj7+3L0fh1VXxh6Vp+EogQjQKTBUtDG4LOUtcg8N8MBb0hLITDsWEDKrnj+m0w
	VjLQLyEsGoN3Tr1RVshLjU8rqueKdVULNzIOPLLQPwkQcPVoyU2Wlpkzx2KwX
X-Received: by 2002:a05:6214:2a8f:b0:8df:10fd:93f with SMTP id 6a1803df08f44-8fec14a93a2mr150121766d6.12.1783702111533;
        Fri, 10 Jul 2026 09:48:31 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c8d4csm47446776d6.44.2026.07.10.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:48:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEOs-00000007ZF5-0qyR;
	Fri, 10 Jul 2026 13:48:30 -0300
Date: Fri, 10 Jul 2026 13:48:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Dave Chinner <dgc@kernel.org>
Subject: Re: [PATCH 1/5] RDMA/umem: ib_umem_get(): use kmalloc() to allocate
 page array
Message-ID: <20260710164830.GA1803712@ziepe.ca>
References: <20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org>
 <20260630-b4-rdma-v1-1-ab42bcf0de92@kernel.org>
 <20260630123150.GB7525@ziepe.ca>
 <akPaAp-0Zul8uVga@kernel.org>
 <akPaPaCJdYINBEEV@kernel.org>
 <20260630153638.GG7525@ziepe.ca>
 <9cc11eeb-372a-49fb-ba89-486333ac71c4@kernel.org>
 <20260702125516.GO7525@ziepe.ca>
 <aka9vZSViFlzBrwW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aka9vZSViFlzBrwW@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-23013-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:vbabka@kernel.org,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,m:willy@infradead.org,m:mhocko@kernel.org,m:david@kernel.org,m:dgc@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A89A373CF14

On Thu, Jul 02, 2026 at 10:36:29PM +0300, Mike Rapoport wrote:
> On Thu, Jul 02, 2026 at 09:55:16AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 02, 2026 at 02:46:46PM +0200, Vlastimil Babka (SUSE) wrote:
> > > I think this should be discussed more broadly and not block this
> > > change.
> > 
> > Currently all of these get_free_pages ones in this series are this
> > special need, so I'd like to not loose that marking somehow. Maybe a
> > comment or maybe a inline wrapper function.
> 
> Comment is easy :)
> 
> As for an inline wrapper, is there an appropriate rdma header to put it?
> I don't think it belongs to slab.h.

Well, lets go with a comment

Jason

