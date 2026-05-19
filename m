Return-Path: <linux-rdma+bounces-20970-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGBzJHd2DGqihwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20970-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 16:40:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31662580B15
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 16:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12B573012B29
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA524028E4;
	Tue, 19 May 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XIsKF+5K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94068192D97
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201652; cv=none; b=U+PtTh9vgOhwoeB30GIEjKvMfWDYk9HajV6XUYVUazb0f3/8o/XoELxUCaw2HFrLgZ3juB6tK+P8w2FWeJ6L7FbmRnjzIpW4BJWdKe1nV81mnQ8NuR+QzIAkN3o+YvgUAadV3Jp/lsZewwqEfdR2I4HrbPbdTnYwaxOzQ3pmIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201652; c=relaxed/simple;
	bh=Pf48qR6Oir6UXrN9S+EE387hMvS/JCg8jtf4H1qGzh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUYUwZhB5u6sfnU7jOB0L5ImFDxBMS8X5kZKAi1e+OPwjAOmPeWNQyTS2ZUJDVjash6Eb9fvJvJpnb/DIYpD5yXDKqjo8XLYVDjfwWbBhJ/wbAHZ4knyRe43brwgwFlQBxlUF2p48/aNiPf0ij3wmcuvbweBHWGKsP0KggnedPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XIsKF+5K; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so70526736d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201650; x=1779806450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf48qR6Oir6UXrN9S+EE387hMvS/JCg8jtf4H1qGzh4=;
        b=XIsKF+5KDOjqfN012VUCVJ4+AzTd6nboF04oLNU6qbI6xfQ9K8GL+eFQv2u7kzhQi4
         h5E1LbV+WI2La29uyKT0K5lHvCLonO74NxYpWJn+CZ9xoem123/fxl/YD8VHrexUMOH+
         P5A2DJMXIMJsqNvc+js/Pnu5nvBxqpf030NUM+BPGbQC2bi+mSHrgETgWINZ9sFr9Wd5
         HSyLHY0fWtRI7cfoIXHLawb+p2vlQ4QU7+8AZDBp9MiQsP1pMRuKh1BTOZmohQUrean2
         0gKAcBAfAZwFN85ibd2j2ulkSlhojkz6Bi981yt1AaBT0uUt5I8jZl2g+SU4vR2tp6I8
         2Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201650; x=1779806450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf48qR6Oir6UXrN9S+EE387hMvS/JCg8jtf4H1qGzh4=;
        b=qRjcIXACq79q19rl7bl5nCqLAedot8KrKZf5VTUeZX1+dQJisFeAx0ZiZZIflG8axK
         wXiGZLbNfMKAnsuyWe13C/NV4u9dQi3xBlXQGviVswStF5vyw3ELyMMjzkBvSNv3jWAd
         zx8odUw6Rc/Qk+XdrzilrXMH2NElCpTipvpyxNU5SLLYyxlKgygFmoGHouhH7T8MoSOE
         97+uqLEMx8JzTAtdVH8+jraUeIbnAnPxcyfgPp29yx8XXsQY7lpv3nzHQhOV9esoFuw4
         U6nH/us/pJ0sayw5DXSXPseLzMPuEhfnMxRb9lof45D1mQocd6JLO2JN1ve9ZoKr0gCI
         mY6A==
X-Forwarded-Encrypted: i=1; AFNElJ/MavcpHTnveEmnPQ/qsqKQ6xJSYP4mEx43cv4Eo4xaOHXomcRKAQeRbVgjZ/9jmRmAFoQzL6LY+NWf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1p0Dqcji+beKPsL40JDFyPxbaGbmOSuKevdjp8gkOEpo+7tm
	Z1wua6kFkAZAPRk65YQubiqaONKB6hrkqn0HxvgBTJIVnH/aZicn9bsUqDY2mdk5KIE=
X-Gm-Gg: Acq92OHsfoKRMjz1uPP1zeXSDmzHaEeRPPUW+xFIs78mm/ATIkTnjYpOdzDYNEhkiwV
	i6uVSZVia/DJxr75bG8AaflbsL6CESY7CMjaW1/YM+t80aw7lsBKZIOyfNbfFK+uhFVeNgTsdPn
	GJYj//sBZn5b79B2EYhXft7saacOk89UYg8ppXSxXN5bvOFZRbcWWU7Udo3cg//VXJWbFgy0rwv
	T4U7ozA58MRhcIdOj4CE6jX2KHWmyTsDFWAId2KyZrcnkIDlFXJynh3OER1uyHFFQ+iyVk4qP86
	PXaRB6ih2BYViIxgtUz9ZpzS3RmQJUTO7T2w67Vr86+G8zKJ6VaAaLqyRK0XCz2F8Vsgq6GWH4k
	FNT1HKrQwsYrgEjbuNvz2aQCwKLuxR+/GAG7u3tnvi7MaDBWC+8kFCW9zsE7tEv2n1ulnaQteJg
	taNsbwN96h74/bcJd06gyNKAzOQct1CIf0z7RxplNxRaOjhTVDibyYsF9kkVx8CJCNRAlPxdExA
	Omb4w==
X-Received: by 2002:a05:6214:484a:b0:8b6:7f3f:5286 with SMTP id 6a1803df08f44-8ca0f646ef4mr276250086d6.20.1779201650583;
        Tue, 19 May 2026 07:40:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361bcb15sm97839266d6.47.2026.05.19.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:40:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLcn-0000000F8Ky-2K8T;
	Tue, 19 May 2026 11:40:49 -0300
Date: Tue, 19 May 2026 11:40:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 7/9] RDMA/bnxt_re: Enhance dpi lifecycle
 logic in doorbell uapis
Message-ID: <20260519144049.GF7702@ziepe.ca>
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
 <20260518153721.183749-8-sriharsha.basavapatna@broadcom.com>
 <CAHHeUGWK_2RNG=CaHTnNh2JeAXa9mcTam6p_7Qp6eG+6Nip+_w@mail.gmail.com>
 <20260519124600.GX7702@ziepe.ca>
 <CAHHeUGWpp8n1dHAu=MfYiLhntzK=PtvNyRBHhD0W9KkthEgYUw@mail.gmail.com>
 <20260519132730.GZ7702@ziepe.ca>
 <CAHHeUGUeQssyz2fsb_aOzgi=wu2KaCyRJHU7vBC=wk4XRbpgOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGUeQssyz2fsb_aOzgi=wu2KaCyRJHU7vBC=wk4XRbpgOQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20970-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 31662580B15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 07:29:08PM +0530, Sriharsha Basavapatna wrote:
> "Does tying the hardware DPI slot lifecycle to the VMA lifecycle allow
> userspace to exhaust the hardware DPI pool? If a process allocates a
> DBR object, maps it via mmap(), and then immediately destroys the DBR
> object, the uverbs object is freed (replenishing the process's general
> RDMA object quota). Since the active VMA keeps the mmap entry alive,
> bnxt_re_mmap_free() is not called, and the hardware DPI slot is
> leaked. Could a user repeat this process to hoard hardware DPI slots
> until the device's entire DPI table capacity is exhausted?"

Yes that's true, but nothing you can do about this without moving the
lifecycle to the uobject, which we don't have infrastructure for.

> Even without this change, the DBR_ALLOC() uverb allows a process to
> allocate multiple DPIs (that are meant to be distributed across QPs).
> We don't want to restrict it. Again here, the library properly handles
> this by unmapping and destroying each DBR object.

Yes, but there is a cgroup limit on the number of uobjs a driver can
create, so it can be technically limited.

Jason


