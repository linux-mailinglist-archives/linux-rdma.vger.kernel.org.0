Return-Path: <linux-rdma+bounces-20061-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF9HOqsJ+2mbVQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20061-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:28:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A21C4D89AB
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00957300615E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D93E3DA0;
	Wed,  6 May 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="l31fB+wT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAE3DA5BC
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059522; cv=none; b=UbpxC3YY6kPmbhK/tVSP0wS91zFx0kb2UaitTSBdsnil9Jf1osHJH/PY+8s8tJFQVsIZ0Zza91TotNeXhSSByY82/d7gP0IAjhpp+HdXSq6pVCrZA9ORglkm62G2596clQ8uXCYHmJ8JRvdkIcyKwo1PTQl31bE8davjlwrxqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059522; c=relaxed/simple;
	bh=sPzvgcbl2PYg2rwa94APsabPTgf2GtMyq0qHC8mtJuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1wewT1M7AdJI9mkMYJnLMIE1Z2Af6DhabrsYEG/ZbX+uai6HQ4SwRzgHkBF55vOVQo3r7A53RHUs8v8pOw9nJbtYV6aCvV+5uV3z2Lcc+9b96kyN9nXISxHZmzX86s1HwnRfwg2i6KoBdQSS4vVPl1Q56aalNklEVvaq9WcTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=l31fB+wT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so78233565e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778059516; x=1778664316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5EV3DxjgEKvqBbROhIn7Y2DPgnYHSL37i/QOZyEcLU=;
        b=l31fB+wTF4k8Fl33QdSjmMr9NMZyquV6tE9GGVZIFGi5hI94muA44/nmSanvAkG5Zg
         aNCraoY0mP3ANuCG32DH/yLLJk5AtzncGEVNcnYris1IfSjZ8YSflMtj+LEyrO8Jm3Gv
         HQkAjVwlm+tGRTCgtMVK/nbbbVRC/FuQ/FcMu4p1SE66tWcvAvjVC2rO8hvh3s4MjN5t
         siSgTsJYRQnCPOKZE7EnJE3N/JFUFa2dkfXvA2LOxV97+z9h8ZhZGuE1gV828O/rgEV1
         9OHNpWgsD+qBzUXA2V/05QFEcKRVLmMVvwgpBLIIQgrExd9qUWI8LGUsu9zCKska9CCP
         hzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059516; x=1778664316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5EV3DxjgEKvqBbROhIn7Y2DPgnYHSL37i/QOZyEcLU=;
        b=dFiMcYnvAZmNNZAwwgGevPIns875vFW90ifyqxb9T5EvwB53NlrAzl0MlmeS6Ljww2
         lUUCHZszTrysEk83qEpMGxRB+wqucl84WidIP/zbaK58pSbbb5d6BDTlD2lwGshRltsh
         AOaJQF5sn+a6ozzpGmKK/+k6KWLOh8Omr2Woga7BgXrLehjJDw/0Vi4TtqTYQipSfHav
         vGR2bLqqoLZ770Y9OY/OJ8c9zedNeyyuvHle2zJQxSe4BIs72QiZo08MWPKR+yPtRVj2
         6I4Nw+CgryoUrwOHkZnZZTkVL1edT8tFbGQQUUGozy6aFp0z8XXOWR9u9KVvvOsrOU9R
         8c2A==
X-Forwarded-Encrypted: i=1; AFNElJ+J1UrcN6/Yq57rAM78yrsOGYgwPThYPk5j6PpPfXWxw2NY0TCkacCA2kp+LTUvQCekvsRy133j3GNV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnu4iRDBUoxfh5raZ90cU42RtlfoqWIbSoJ3BgOMUsxeEhELxQ
	gBY0Jw80iEWOq1jMwxhMxYZKeaPjvmoy9Ix6Ax1XZXTebYtxVZFMBoMEsLUA+pkKlVw=
X-Gm-Gg: AeBDiet6jH2J86NA0snqLpk+Tdl/8TRfSGQM970TLfP0ggegUXp7rKbQyovQXz5nyLr
	T1ZOrmfmgdvspSkLJPyNVRJ1kpg64si7o3VBwtmsIQ3siN79ljz+wVINfkFQSbxmNNRWqtBV9KL
	SCCKgMPvdq/89OXT6oIbE5I2CWMFf3u7wN5qGMA3JRp3wy0zpGwgbJqqY/hOlu9bsHBrcIDC1Gt
	wqa6MK8+BGtRBc3H4+QsGH5+tC9sYF1fbuMwx4lb54SVCH9tuhq47WgSF9DOMi/LH6k+usEY1EM
	ixe6HaVJ4yWuKj0anw39Y+pVf6V8IP51kInLXm6IjsafVIlBWxzgUxKIUX22IT8oFWxBTppzCtc
	ID5dhz/Svx3P11Jfm/x2rAO31pKw2zeWZyG3DQ8TVOcM7JoaCKa0jeS+IOfj7ovpiBwBkM7Q8qm
	GF4y7HUZeILHEOIQiGSeoo6NQx+yUvx7DOUIX+5yZ8mg==
X-Received: by 2002:a05:600c:a118:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48e51f37363mr33775185e9.17.1778059515792;
        Wed, 06 May 2026 02:25:15 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895f0asm36508775e9.2.2026.05.06.02.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:25:15 -0700 (PDT)
Date: Wed, 6 May 2026 11:25:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, linux-rdma@vger.kernel.org, 
	leon@kernel.org, edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, 
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com, 
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <afsIsW7vKgJtdNA2@FV6GYCPJ69>
References: <20260505061149.2361536-1-jiri@resnulli.us>
 <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
 <afoUqiDgZmhE4Kog@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoUqiDgZmhE4Kog@ziepe.ca>
X-Rspamd-Queue-Id: 4A21C4D89AB
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
	TAGGED_FROM(0.00)[bounces-20061-lists,linux-rdma=lfdr.de];
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

Tue, May 05, 2026 at 06:02:50PM +0200, jgg@ziepe.ca wrote:
>On Tue, May 05, 2026 at 09:20:01AM -0400, Jacob Moroni wrote:
>> Hi,
>> 
>> Out of curiosity, it seems like we set DMA_ATTR_REQUIRE_COHERENT, so
>> would that have caused these registrations to fail anyway since it would
>> be trying to use swiotlb if running in a CVM?
>
>It is supposed to, at least that is the intention. I think that
>new attribute overtook Jiri's patch here?

Hmm, don't we want rather -EOPNOTSUPP instead of very wide -EIO in this
case? I think that might be better for the user.

