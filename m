Return-Path: <linux-rdma+bounces-20841-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPmxItjJCWropQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20841-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 15:59:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F605616FD
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 15:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A922A300BCB3
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AEB27A462;
	Sun, 17 May 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="kvoXQs0d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397026C3BD
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779026386; cv=none; b=DFK3HpsX366euS0ut4cjFswaGWGofAd5xllF0ettxi7hb4P9Yg9zRYe2bjjRFwSlQIc7RPB5llyILn5DTdJ1UvCUhIaPrcsHuczRJaIW13kQWbCBGtSldtv42ax1dmQNdNLCzAXHUICfTJL/r+FXzJ+LQYfQsFHqPXjpfI4ADkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779026386; c=relaxed/simple;
	bh=e4vjbQKx3VzCVf/21i78D1SVSf4NWVB3mauPw+eo8hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYfg9W2mngVuUb8+CxhKK8w7rYrtVBBpuzOJjYKSHYacgJGEuDrEMk89NzdDfcwzDKK4iJqqCYJmAN3AIxzj0zMDAkitX4FLZaJ/1vXVJiQPs8X1zoytyMGJoYxWxT3WPOjfk2KfqTzUAE+vW0dg82JD5ivPFX4I4U9VAV2N7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=kvoXQs0d; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44a5174670eso628259f8f.1
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779026381; x=1779631181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5eQG8bRGlUg5QqFZ+JWV0xNZ9DyeBuXO4qWIx4rt44=;
        b=kvoXQs0dC8fQNxq1PSYHVzDFZPdEv1Ayl7pKtpws+JJxne4KuTsFhiS5adcdmektHT
         h2ns3/a2HFBIgT9nScEzbaa9PhDcVHt5lp7lAliu4hMuKMN6OamRHPDuEjXIysQzWK5F
         mNXRn+Ryt0OwBacwqc+Pyydgj+1YwNfywG1zopvWUmgHbVuy8+J5svrUN83y/zGrNTIt
         g9FU9k4QOP1rigCwa5vNkLKJjwiIM0AWb0apfAT5989Fu0AtiMk3kA0rgvl4Vx+aRoi5
         kaVqe5u+xpDHuxJ1Ysuf0eR5zJUqHLSp1KnfqsioNsM275P9UqlbpYjbHcG3qfirR5sj
         yQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779026381; x=1779631181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5eQG8bRGlUg5QqFZ+JWV0xNZ9DyeBuXO4qWIx4rt44=;
        b=GcfJUwke9R/rah1rkmtcRX6mPwVyqo47pjV2U3gYwB1kEyYSdFXXIZeLuHEB+5/gmg
         nmUhgjsFTaOGxq7w/QN464vuv0pzJh17G9c4nMT9z120bR/rOmvHndtRaxbu7hIguvNJ
         MzKDdZUUaLXYTcgcmx2kPeAbxykrU1AmSQF8eCA30RkeTS18UYbv0u3Xy0H9Yc6KlE8F
         I0SBvCa/VbVN0vlXYIWKx16djjQtVGNBiSwkFrkJEQmpufRo+MfuefH9Sp/mNZtoZxFE
         sfpVZBjax5EeXKk88ttzvIEtWZhrNPX3HZivZZfCPtfxKc7fzVA3QabEYl4jjTXlvFMB
         an0Q==
X-Gm-Message-State: AOJu0YywyzyM8jvAqYMdRFUhvohIyvegp3m+jrMFgqWqxJSZbItQp/04
	Ke5E0k2DpwEhngJRmtGQl1a5pbKgp7e4vp3DTTMXrMc345kEzwSOosVCQ15cA4CYZH0=
X-Gm-Gg: Acq92OEYlwN3XoMPo83aGM/NveHI3OUfQyEDaBiJEwV3RHtZCjIji/DJdFi/HxPg+wz
	BriPgA4DgsGcbOe9e+UuJ4hE3SuKQ7zQrdrPLzG91RrPlO7m4wsniihvsDMFjQorMomipQzcKm3
	7SGwjAHUQ0Hy1r3BBX+uh/F1q2t0rnDK7lXQ+6mfGgdFA2tm/aTpkQnBmd2Dll0NAqGQR9/8Wsh
	OAKPGf6z4cxnFQzRl0dNfssMhtIxHBqY14jB8+UUysHMH3t8HdCQxgejEJpnTUeHrpNwo0STzW/
	UHkm4ajs19aslPO6pz/Jc+/ZvB3e4u4Pjto0schfOFvqTVcy+FyAKsgN7ppy4iypoID8Jaq7vD4
	9jSoc5MHCdq4r9gI606UcRPQahfU/z4/aVYUP1kDyJ3qEzwxjS2LdUwAaats2wZjrX3Xi5dQPbn
	iC7VSM+Ft18X/BbLLXDNBBJ4joeKk9bDbLpfnCVmfscxM=
X-Received: by 2002:a5d:440f:0:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-45e64b3af65mr8598904f8f.36.1779026380929;
        Sun, 17 May 2026 06:59:40 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:4146:8430:fb4a:baf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767ee0sm27899228f8f.1.2026.05.17.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:59:40 -0700 (PDT)
Date: Sun, 17 May 2026 15:59:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com, 
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com, yishaih@nvidia.com, 
	lirongqing@baidu.com, huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn, 
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <agnJpvWB-tkw-jeg@FV6GYCPJ69>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-3-jiri@resnulli.us>
 <20260512130515.GV15586@unreal>
 <agMzXaCIhX4m7ldo@FV6GYCPJ69>
 <20260514162506.GR15586@unreal>
 <aga5CzHhdQUW2euI@FV6GYCPJ69>
 <20260517115006.GG33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517115006.GG33515@unreal>
X-Rspamd-Queue-Id: D6F605616FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20841-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Sun, May 17, 2026 at 01:50:06PM +0200, leon@kernel.org wrote:
>On Fri, May 15, 2026 at 08:13:17AM +0200, Jiri Pirko wrote:
>> Thu, May 14, 2026 at 06:25:06PM +0200, leon@kernel.org wrote:
>> >On Tue, May 12, 2026 at 04:04:13PM +0200, Jiri Pirko wrote:
>> >> Tue, May 12, 2026 at 03:05:15PM CEST, leon@kernel.org wrote:
>> >> >On Wed, May 06, 2026 at 01:14:47PM +0200, Jiri Pirko wrote:
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> 
>> >> >> When a device requires DMA bounce buffering inside a Confidential
>> >> >> Computing guest, __ib_umem_get_va() cannot work. The DMA mapping layer
>> >> >> redirects all mappings through swiotlb bounce buffers, so the device
>> >> >> receives DMA addresses pointing to bounce buffer memory rather than
>> >> >> the user's pages. Since RDMA devices access registered memory directly
>> >> >> without CPU involvement, there is no opportunity for swiotlb to
>> >> >> synchronize between the bounce buffer and the original pages.
>> >> >> 
>> >> >> The registration would already fail later on, since the umem mapping
>> >> >> is requested with DMA_ATTR_REQUIRE_COHERENT and gets rejected under
>> >> >> is_swiotlb_force_bounce() with -EIO. Fail early with -EOPNOTSUPP
>> >> >> instead, so the user gets a specific error code to react to.
>> >> >
>> >> >DMA_ATTR_REQUIRE_COHERENT was our answer to "layering violation claim".
>> >> 
>> >> I'm not sure I follow. What's the issue you see?
>> >
>> >SWIOTLB is the layer below DMA API, RDMA is the layer above DMA API.
>> >You shouldn't call to SWIOTLB functions in RDMA code.
>> 
>> This patch doesn't do that. The patch description only describes the
>> current situation and how the patch changes the behaviour.
>
>From previous patch:
>+       if (dma_device &&
>+           cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>+           is_swiotlb_force_bounce(dma_device))
>+               device->cc_dma_bounce = 1;
>
>And this patch reads cc_dma_bounce.

Sure, I got that remark from the reply to the previous patch :) Already
removed. Will send next v soon.

Thanks!

