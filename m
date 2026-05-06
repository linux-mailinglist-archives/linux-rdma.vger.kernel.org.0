Return-Path: <linux-rdma+bounces-20063-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB66MQYe+2kIWwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20063-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 12:55:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B674D9864
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFFA03029AC8
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF340629B;
	Wed,  6 May 2026 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="c0oSqSOI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1643EE1C5
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064860; cv=none; b=gVqmyPbPy/f59vWGwr6nRT2JzBDvV6IR4bwWkOWuGC5zizv+r1OJFGFi8MSfsclievQRgHEDXMPbpSqO0Yib5hIkJWhp7wtaBlq5LbXyTEprboXnsNP1ddd2S9wpuwvK/RZK6erxtTWtKdA8JEGJzh3hL/Fb3L2rAmP6hvoiMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064860; c=relaxed/simple;
	bh=VBpIwCsEikp419Ex83MRxpG72u7KgVkUg9hGseOo3Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQMTkOUwfMX0pJqOwwzh+EaIBZeGQGfFD3NgHm1dNu4q3NCjQknKHy8YjgjH/D00CRxN85ilyzUtL9h4f4I3vSbYVquq+z87sNYLGE8zUawQl/sv9w6IS20m2r39AjgFWyF2aV2w8vmpNhHN0WmQ10ZUaw6oEV25yg8bU6wEKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=c0oSqSOI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so61223005e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778064853; x=1778669653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy9UMvE2+HI7JBmMDI4enXlAtQjs9s7NLLQt236w2eQ=;
        b=c0oSqSOI/ZJymMlGd6wJszR2jDXoby9yNKT7NG8ToT6zK4NkOF/OT2aX9oY+7iCw9a
         HRpibl4UTyIYpWOZ/tD95XkoIvplkXalKaDoWlfUggTdoRyCyYdQzl318DhwZ7PdPac+
         +MZejspLe9y/tt0odxX4DtWEGEGRJwn+eeYWOwmYZVsWKQPwMPyabFMd0dF51r38x868
         IU4YkCCZMO4dLkSCGWoQNACIi5SMTgtKqHv/9UtI6aZkLjp2THZI64YHoNR2LaUo2ekM
         wZYIZvH9fD77ulPPvjapwsrALZAP2Ml06X+zp7qVAbYE+aG6N6reOPOgWruaxcCUof7f
         +Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778064853; x=1778669653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy9UMvE2+HI7JBmMDI4enXlAtQjs9s7NLLQt236w2eQ=;
        b=aAkW92qBDcdEORrX/8OIXiawQgBDEE/iwvX8xqQvUQeSIDbZQvfRfi76IWwpeVYTNF
         NuKx4i8UO7sQC6L2YoLMjLpt7wsor9TsRqTiVUFNzvDPxSfFIqAOLm1aZoIo2nwNahAN
         PAJNOT6vnMXveGX0jEJHGjVjLrPfb6sZzg0VlgTJoEgMCiqDOuOAiaLEC5p2koQ5QX47
         N9krgKqbgxaSzZ+Pfc3gbDVc1yGg5sqhB4wu9u2PwAW+qilcxWXVt20H+2JGmbEJpr6O
         njPllb3+YnmtcNe7NY99V2r4KqTNoxMv/06nmZ24LuDtsJF1zZd9pCtooirllK9srRgE
         x6Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+v6m85yoleYfiixtM9ntVOnIFueGUyTQvZHnbgIYrjb1QSFdoyja4yKIRYawdqJCQ1wjdKAADhAE4N@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29RbPcUh8Cg1Dqw448hzmr7X7djq3K7ak4QO4zgl9n3wIivaQ
	4AWzTCxyxEQFS0Ikvx8Pg+xkeqdLBeytenTkAQqpc5T59uS7xsp6nLpQLNSvVRoch2c=
X-Gm-Gg: AeBDiet3gC37s8qf7XeAAhk8/McuCt/TbSE0+ICfO1IRTQ05QY3qbPmLlH9gDdh9heQ
	KHpsJ0FY62pTEgZTV8qSJlN0zlLGW45Fqx5E/66VM+kUpbmt8acQwiyd1GK28TDvglqiXMgdNPg
	l3z9DKo0o4C8OcrvagUuOJ5gSh65fKaQ2EhteThlqoxm0ksOrHEu1ClM150gkBbFf8AXeRpnLQH
	DCLxmzj7OP7u3Pxb2BbNqyQZ7U6iCFA+iTbIhy7XlVKhonnM51qjaJqarVWex7Pl0Hk2TeG8z49
	CBNcGJiNnGNwR35OXKbh44ZDbfio9cDJZNgyZLF6t1z6sR44mdjRjqC71Xt9Ql6ASwjAljw2INF
	5PolLVBHM3px56TyszPndKIWEDqD6msK2oZw20MofxsBs9HxYwxHCCrDDc9iCSC75gqhrkft8MM
	H3Vq/W5om/V2YbusdQLHh4Ddd2SMMLenpGgRb2H3K5AAiyYZdJPVshDEOe
X-Received: by 2002:a05:600c:a10d:b0:48a:53ea:13df with SMTP id 5b1f17b1804b1-48e51f21f39mr33500515e9.2.1778064853463;
        Wed, 06 May 2026 03:54:13 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53142043sm14684925e9.27.2026.05.06.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:54:12 -0700 (PDT)
Date: Wed, 6 May 2026 12:54:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, linux-rdma@vger.kernel.org, 
	leon@kernel.org, edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, 
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com, 
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <afsdvIvEdX85iCXE@FV6GYCPJ69>
References: <20260505061149.2361536-1-jiri@resnulli.us>
 <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
 <afoUqiDgZmhE4Kog@ziepe.ca>
 <afsIsW7vKgJtdNA2@FV6GYCPJ69>
 <afsOtEeppBzxOGUB@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afsOtEeppBzxOGUB@ziepe.ca>
X-Rspamd-Queue-Id: 15B674D9864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20063-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

Wed, May 06, 2026 at 11:49:40AM +0200, jgg@ziepe.ca wrote:
>On Wed, May 06, 2026 at 11:25:13AM +0200, Jiri Pirko wrote:
>> Tue, May 05, 2026 at 06:02:50PM +0200, jgg@ziepe.ca wrote:
>> >On Tue, May 05, 2026 at 09:20:01AM -0400, Jacob Moroni wrote:
>> >> Hi,
>> >> 
>> >> Out of curiosity, it seems like we set DMA_ATTR_REQUIRE_COHERENT, so
>> >> would that have caused these registrations to fail anyway since it would
>> >> be trying to use swiotlb if running in a CVM?
>> >
>> >It is supposed to, at least that is the intention. I think that
>> >new attribute overtook Jiri's patch here?
>> 
>> Hmm, don't we want rather -EOPNOTSUPP instead of very wide -EIO in this
>> case? I think that might be better for the user.
>
>Yeah, I would prefer that also, it is a good enough reason for this
>patch.

Good. Will send v2 with updated patch description.

Thanks!

