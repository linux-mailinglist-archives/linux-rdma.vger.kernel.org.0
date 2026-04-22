Return-Path: <linux-rdma+bounces-19466-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A3EGcij6GkaOQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19466-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 12:32:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6E444C0B
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 12:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A797301A7C1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB935AC36;
	Wed, 22 Apr 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ItUqCDt5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CFF36A02F
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853957; cv=none; b=NSFGLzLzURin3BDAuyLG2cmBzbx6JqW7KiFrWvkzrrphYK/hKjLPW3VVqM2jqg28PDg1VjqIVATfxH6WYArSKGElGJJGvSKFG/NYGf614ivTV1pBzNTMYFRVZoaj/HUhIU4iYMyeHgZ5HHAZteZUvhdHS1E/5P9/4/oQmCI9ijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853957; c=relaxed/simple;
	bh=PoOO9nfPkmu/ukKHCawxjS1ia7rSUc8iX7t+KFKG7yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVixcYYGg7ptiLHWA0Rf//oO0MpM4RTpSTp7w2V1UlpL/aM0EwOB6DCJDqvH9wdevYWRKsSGb7zSDFwlDFBdwi3e5uIGlFJjPgjoelk7B8xO+fxvVunnYm0gQCoFph9K+UF4s5mI4P6pqs957Quvj05+/aE3QiY2EJ4QpAA19qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ItUqCDt5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7e23defbso3359162f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776853951; x=1777458751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWIPfGVubDnyAhwzz3JLAkLWm0PkXLXxgZ7ClgZlSek=;
        b=ItUqCDt5Mt7PoSzXERoSWUY9GU63/TpM2H3aLlY9O+CpvJVt0HdLYMLI5/df0VYzx3
         RdkiCyxv6xeUmAgWNLU3mcZmH64aCP0vIJSA6o9SP40Vl/LrtiYHszbNtG6xyVPyNECc
         MUqkC1dHDWqZLMo8gd7yErCWe85Pw/NyukVaT9QXOdFTJxGu2bw6oC651zdxtXlYAFeS
         6u/T6tVSD2LSil5fFK06oGEt5crERQ99vQ0dubwi291YsRtWDb49MgoeMjzTA+pDXdfJ
         jKzcTjmQ0N025AQVkFO3om6KTH0gVLSzkn1CSdGMEpi0MAjPPuKH3qlWLdHgX6bqK6yM
         DMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853951; x=1777458751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWIPfGVubDnyAhwzz3JLAkLWm0PkXLXxgZ7ClgZlSek=;
        b=NlK5hXE+9U+GLPJQcps/KfM8sLwL9yRtulgnBVhm9mkLph9mA8nXBNGlVftvWXzyml
         xlQQCrhAGPmGpmd2Xkfkct8jxApAIDLZuBsmt7Xtq3tQ38fXU0HWKsjE8rkpwGCkgltA
         gwSI3+jLqY08ktB4eqlIS6Su6Usc1DfyYaTAlfjNacGmtNR2L6g+XezNwoChwscKmJXR
         aJm8orIVsZnOGSRvxwxlf/K4nPx1QBrMN0hFfo+Cc9oF0oFhApZSinnlZts85jx2g1jQ
         VZvzIT7GdfesKVz+M17SgeuMkojPfKEf1LqWcTi20FgT4hCLFJ2MUhxXpVDS88U8eMAW
         k+qQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p7titwjqbFPu7QcdeVicbNmBPxFbgauzh99Q6Y6/8Epu5onXA6r+OYYiT+P1896dL+qIMsUrztgmF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7kdaITCtGzpZ3avIoxFDfTUSC0pdfTRR4mPJYgWouHrNh5jB/
	7MgZrMz/tSFpAqslnSJUiuU9LxKOzIm3iJ18/vXc352/uh3deHsczDG9AVxe4BiICtw=
X-Gm-Gg: AeBDiesZCc7ZUy0qMnmIN63vM2f/Y5QdoU/EjfVFL7fKYZ2znk3FYGegKfdtQlWwZEn
	byXtX9VwCZZkbfmeb2sEv9cd38np8LgUrteL4MDYK9zoB3HYNMNijzeEWSowMbjRiORGY8PzeGi
	s2JeQctTUcasFgZa+8Ya28XHS2tKLXjsXIO5kR2QzG3QeFDNcdhjWvdCwEp7TpU4yVksTIFhhiv
	Sp8FmlUUZwfHZnc6xY5EQC2Cr2etAj17Rg2Ix9xpBt6PDO6nZucno7juB8WaoTvYTsys5HfpvBZ
	GL/OeMbj75+Fi5GxqK6j1wYJK8btMw8NrVFu4RDwGOCXjWFq656PM099QEQ5XTF50Fv8pc6jMb/
	lcLjHfZJ9ZEFbF1vLQ87zEJ2tXxNKHVcRbB4xTGS73P9N3DHWkNwnTjw9q8Vh0ON3SYsYDQ+7ul
	5Q/Y3Q/gg+vHbLS6VrQcYdJVxiT1PS5kFrStE4OWjYP6/Vxg==
X-Received: by 2002:a05:6000:3101:b0:441:1d3c:f7d6 with SMTP id ffacd0b85a97d-4411d3cf7efmr12081272f8f.9.1776853951302;
        Wed, 22 Apr 2026 03:32:31 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm49557178f8f.37.2026.04.22.03.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:32:30 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:32:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Michael Margolin <mrgolin@amazon.com>, linux-rdma@vger.kernel.org, 
	leon@kernel.org, gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, 
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <3wltr6vsnqqmgopafwjnhfndbbfmsnsxalhvrxjat2qeq72kau@poidixh2jwwm>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260412123322.GA5166@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <fzughzkkr5zkr436pdzu6p2j4sdlphtxpbbpztxoerbms6a37f@4dzcxphdyjg2>
 <20260413160232.GA21984@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <dy6nbf2vibl3aeopeb7im7fksh5436isqcmcarghkm5e2ontoi@unvvimhthp53>
 <20260416121000.GA20519@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260421125212.GF3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125212.GF3611611@ziepe.ca>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19466-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,ziepe.ca:email]
X-Rspamd-Queue-Id: D0A6E444C0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Apr 21, 2026 at 02:52:12PM +0200, jgg@ziepe.ca wrote:
>On Thu, Apr 16, 2026 at 12:10:00PM +0000, Michael Margolin wrote:
>> > >> >> @@ -64,6 +64,7 @@ enum {
>> > >> >>  	UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
>> > >> >>  	UVERBS_ATTR_UHW_OUT,
>> > >> >>  	UVERBS_ID_DRIVER_NS_WITH_UHW,
>> > >> >> +	UVERBS_ATTR_BUFFERS,
>> 
>> I don't think you can add anything here as it overlaps with driver
>> specific attributes. I suggest defining per command attr id and passing
>> it by caller into ib_umem_list_create.
>
>Right, the expectation would be to have a ATTRS_QP_BUFFERS

Okay. I was under impression I can add a generic attr, I was wrong :/

