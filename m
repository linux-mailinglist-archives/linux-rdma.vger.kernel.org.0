Return-Path: <linux-rdma+bounces-16431-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAEENW24gWm7JAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16431-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:57:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DBBD67B8
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD96830293E4
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A8396B84;
	Tue,  3 Feb 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N1y6CL8o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F4392C4C
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109034; cv=none; b=Gw1/iE15c5XbgNH8NgpVDWHbajj7kD+fS8+0+W6opI1wWU9R2acmkEbluMUxzNEcSOU1663HMBVfK41to48tUuy8UAr6ZiU9Gqx8OHeiqgzHo23iRW+Ys6OWecJGIgmulTOrTHYgFy9fTAqJFckI4+8iIjPy6gawAxlOLX7OEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109034; c=relaxed/simple;
	bh=crBZ5WIC2ojdcL5WCMP1ZEK12YCUbKmswLT+K1hYo6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7cRIYm3Mi3NSC98Tv8AnTP+Z5d5V+AS7i1bW1iIorNUOb6D2x7BWZ9h34zWTDa5y59jVjtLoukno/BceXnXHjfy3tyKswsCAdIJ9Ufw8JsFRbVJdGKSriYQkyIE8UCs6RVbkS+3gngV96FwORi2xFob4XGXVFwyccSPOicJbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=N1y6CL8o; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso40798725e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770109031; x=1770713831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wD5R2slMnbZSZlcYUfM9xwtbVzBe2col6bRw9OwQ4NE=;
        b=N1y6CL8oSSq/cVW7f3AaLzU+xr3igGAt0+oMbW3u9RdlW5sMugIqU7CaO6EIPYCecp
         x0qzMNfpi9C4lakLy2LfT6R2rPLueWo2JEBUeFDeOMRQlWj0cxDUVcqB8Af046WMWNrC
         4zzWmfMBudXE2zCesOWMLiUOvyi0QebAHdBvzPzPsNMSNeGthS/OCmhyA99ko6YFpblD
         NN8DB4cETe0W5bUNUYQE53f3xKNlR1WJo5XmG7FPlAlHl18hUffrAJO2YBXVXYy3fzu2
         HWVNT5+gCiL0CQrI8E7Hjd+1g0gWflD1ra4VoE+Swgx11AjQri2Su87fQ+9/PXXGf2oC
         aP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109031; x=1770713831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wD5R2slMnbZSZlcYUfM9xwtbVzBe2col6bRw9OwQ4NE=;
        b=gCppww2i3o42QAC5VuUl3UeyzwAApxPP5bMmaX9Sytz6HAvhAepxBMUTo5MTOHqnoo
         ExKNLD/8alsUwQHgfIWFR3Ad+hQa2ksi9W0ARfycj41OWw0DOHPhh6eJSItYeIzZLrdb
         98yB807ZmQgx/AZkIyNNojxufxj1leizw4bawKrjcFR0tcaxgnfosacR69VYUnFF1izT
         ordlWh0Ub+Os/ImWTl3mqFYexNrf4+RSs0VRQs/k0yJ1y7ID0MjW4Amy5UewtlOYdMdp
         qDIc+zue+lxVrAjQUwnf3geoZHAfzMbIPTOPuDOnF9S/6Ph5dHlMKFBfOyCcJRd714WF
         unmg==
X-Forwarded-Encrypted: i=1; AJvYcCUl51sBTpY4PPAbEfjJUk6N0N8UaCS7GOygzdTWNmXnPkIBPJZ+hhu0tNVNwlep9OsYOq0arUA+dCyV@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbKKq95XeI5vInZLLvtcbYutGfS/idOa88bsY4HTWvE1d9kHZ
	gjay5/89bg8PaKK+xtWsK93Fn0/rqAtStwKjSyM6I0PII6JxJrcK3vZx0F2cIKkDiOc=
X-Gm-Gg: AZuq6aL+jLlg9SwMA6bMnHcIMWdH++gcrdsGzh2z3oAfCQM7xh1p6RNDyYXCmrwTbtF
	/4lgBUo/QK4csn6lXO6DKOsC8DxP8ZU9anNLNkVY9FiWvLyCaQ2EuWOoIDURCncROiRqInzh2RX
	yHG9zWfyhMSYjJ6mbvRnS1z4q8MAnlzcgSq0fEONSjTR1HKRTxBkFFCjjB/EuqNEZwcPJbjnBzx
	I1TxzYuLCINOfdwl9BJWSX9FYXpP8mdYnkLq4wAY2GFUS/ClxDlkPmrgH5TiaHo+fYhDqhZI7le
	S9LIxiZnTBo+QCkZHbLRcX6nxNjhWlxpm4nyJ/6/qPP/EODupqV0sgVuKlARX5S4kf7vhpOl77I
	69xnMAi16z2JQzPy07OEJIhRICjU2YhOwld6AHbydWWEi/BSpbMSfLuJ8nj9kOM5kZ/BkZHgWMH
	s3PCO7zdyKgwRCMig8W2A=
X-Received: by 2002:a05:600c:4f8a:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-482db456350mr204364215e9.3.1770109030952;
        Tue, 03 Feb 2026 00:57:10 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051379c4sm48518245e9.15.2026.02.03.00.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:57:10 -0800 (PST)
Date: Tue, 3 Feb 2026 09:57:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@nvidia.com>, 
	leon@kernel.org, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 5/5] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <diynzidwh5buv4pnr6smlrgjuog5idjewhqh5cugtqtpknjl7a@eqvfvoybppyk>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-6-sriharsha.basavapatna@broadcom.com>
 <20260128153248.GK1641016@ziepe.ca>
 <CAHHeUGVLi8ZxK3qpJ+nk6DcDd8365fdru-vPmkKtF6k-P4FAcw@mail.gmail.com>
 <CAHHeUGVZCojAmjmqm7yPys2N2TYApPnbMN3dcb4dnWDL_sAA0g@mail.gmail.com>
 <20260128194253.GX1641016@ziepe.ca>
 <CAHHeUGUNzi3x5bAQeHKkMY2Mb3nE7eFJAVF=NHNXoQ3RRLGzcw@mail.gmail.com>
 <20260202174845.GK2328995@ziepe.ca>
 <CAHHeUGW=Jced=QcFK=7+rZdHmVZkzDKdvOZ7beTK2u_xcQ2hfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGW=Jced=QcFK=7+rZdHmVZkzDKdvOZ7beTK2u_xcQ2hfw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-16431-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 34DBBD67B8
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 06:05:48AM +0100, sriharsha.basavapatna@broadcom.com wrote:
>On Mon, Feb 2, 2026 at 11:18 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Mon, Feb 02, 2026 at 07:49:29PM +0530, Sriharsha Basavapatna wrote:
>> > I have the revised patchset ready. Let me know how you want to proceed
>> > -  if I should send it out (without the uverbs kernel patch for QP
>> > umem) or if I should wait for the kernel patch and rebase it before
>> > sending.
>>
>> How about change the Author on that patch to youself and some
>> co-developed & signed-off for Jiri and send it out, I'd at least like
>> to look at the other changes.
>>
>> Jiri said he would send his series, there is still time I can stitch
>> something together.
>Ok, I will include that patch as a placeholder for now and this patch
>series can be rebased when it is ready.

Check out:
https://lore.kernel.org/linux-rdma/20260203085003.71184-11-jiri@resnulli.us/


>Thanks,
>-Harsha
>>
>> Jason



