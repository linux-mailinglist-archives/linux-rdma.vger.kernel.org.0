Return-Path: <linux-rdma+bounces-16501-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMyyFBPygmmWfQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16501-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:15:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CBE2935
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D14333038165
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8062EC0A1;
	Wed,  4 Feb 2026 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cIJum6Pe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C904238C03
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189325; cv=none; b=mmpWXSmIqfhI5NDpKup+jSb0t7Gr/qGjZMMkUAAfTXLDt+gFrc8PLkF1DmYWmOzW1wLuyVWx9VGaC7kPvT/ryyX2401h/kQIUFQ/bwD0EGdOUMb1pnmx6BP4v79nYeFxtcltrhHKWUls6qW/KFNF4go8oiFvybwg578ZPDUtzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189325; c=relaxed/simple;
	bh=i7SHrii2V9xume0ZQ/Ds3fTYY3TfRh3hjqvbzH/xuv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur/mmMm2sROAoT0jnH9q0r8hLkq3HLnCTxkksnm7+2/hyCHjfrjE7Ilf0JWaw3/yp/zt5KooaW5Pc+WfzfBtyClYsJoGHrZF2E7BYWvXc8DTyknZ3011yVRMD1LmlfTaobT4BrpIibM3+ZAb90bh8rT48VD4iqzas9+ZazD9Ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cIJum6Pe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359a302794so4421462f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 23:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770189323; x=1770794123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x92saUYYugyMtUj3313uzdtAS5z3eKHI07XSbNMRFLo=;
        b=cIJum6PezYHw4GB41rtyZVwGO7yKbwtAJlwIMnsUa6leV32Qk/ylJqxd0rLLxgBAo7
         iKFUey2n2S1tnBs6ETVCsQozDPsRo7LZKZZ8tQYQOgZJyD8XMINxRgCcDWs/XmZdP8d9
         EI981owvyMWYXff+bHyw5GFz3LJZCj0bBJP3iPG8wng/6AIlX5mmSTiGBNeEQ1UJfGfm
         hmiKhkaa1VhoSU8JEHWtt+7+1HdFqyC6iBz3JoI7VMIJtCHjVK8owPRYc8LRLZOhjwSv
         itCnUNAQMe7T/a0PhAhwBS+yaSXkTx394g32NxHY0U6k3QAr4SgsC7JcBsgSR+JyqOwl
         aUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770189323; x=1770794123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x92saUYYugyMtUj3313uzdtAS5z3eKHI07XSbNMRFLo=;
        b=n+3B1A664lVLKRKxXtujzplHEua6Wn3dlenYuqR0ByKtJY0VbUm9UGAbRSM3ZyYQ5N
         vr2F32n0uD1PNwkvxOam+7G0mcrfiEPh8MKYCjOpGxmXHMiSyPrwV4BU2DvfI9kGsOH4
         JmRtgUnXNN/skPcG8BXTbSp0keXCcCJxBTebkrNnlbGB0I8/qCM/dx/6xfXYAv97kxDH
         QSXotYysJqnpTJd79Ai9kYhMjSuymzKUhasm7sN8SoBUenxaNzPw/XHVPQERUBBVImZH
         IKX2bDJe+vbNFF0aLCPZ0JmJIgQdv3blr+STpf84RroRVEHdbUeVHEkWr7shrtRU/50c
         lc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQJ8dlBpxFGemSCNAdZYn2N2lcszHCf2viFAIOsoLJ3NL9eSRv7QjeIKG4/0/YycGnPVod9oFlI6lp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbsa5RabBv/5gSmP5tzAu68ZC1dcWODqofaUKz96XMylPXXfVI
	I5esd2V2odcJGyTe5tJg9C4OUKugCUs1JMmld7vSeWJD8Q3z/XImitG7WpUxclVm6Us=
X-Gm-Gg: AZuq6aLlbW+FQCUgjx00r79qE3rVWjoSU1c9hpPEMSSGOnm1pY+JypQbtRRRyxP2/yg
	1k41ejXHZqVzeXIjoDqlw+9TkIc6UmXfLgzv4HvPL2FGBfE2vsGzjj7Eyg4lPJ5p7uFOqnb7yjB
	BrCl4zGf9UE6Opx8V+NNFeOwomEIpFe11lMNHTBR0T8OJo9vIP/zH1oF+vwn3lxoYcMfa2/CXnk
	TgWUskIqGxJhA2twqponqaCQqnjYBngtIFLTe9m/uvUst8xAwWpazz5fQyQqtkM0apypefsf5Vp
	Pzn6Oy6Bg2BsmxX8WSMS+TnRdBF4uE2bXWguv4bvbmSxsUhO6aTGrnBo4HBOneazaOfXA2l47MZ
	GWZYqBbUNRAqeHxd+Bksgx5U1S0BVGHOtwAuGNrRU0cm8Izub2qEkeoLNfhk0XrMbAnV0GR44vI
	dVWIs/o9xlK6p4gMYgBiIIE9aDou+Brm4=
X-Received: by 2002:a05:600c:4e0f:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-4830e98f6fbmr24165955e9.35.1770189323508;
        Tue, 03 Feb 2026 23:15:23 -0800 (PST)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:9519:b02d:f49f:3f52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483108e3ed5sm19055735e9.5.2026.02.03.23.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:15:23 -0800 (PST)
Date: Wed, 4 Feb 2026 08:15:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 02/14] devlink: introduce shared devlink
 instance for PFs on same chip
Message-ID: <y2q4usbmebqm6vpu32is6m3ga3f3xs5xe3jbk2g5n7l7fmt2eu@4m3guiuc3uuz>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
 <20260128112544.1661250-3-tariqt@nvidia.com>
 <20260202194946.64555356@kernel.org>
 <wdkd7yelgosii7bklmahxf5t6xnn2vydnwiiruiwqpyue722dj@yjnkcdctzeav>
 <20260203184200.216bb426@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203184200.216bb426@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16501-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org,infradead.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F04CBE2935
X-Rspamd-Action: no action

Wed, Feb 04, 2026 at 03:42:00AM +0100, kuba@kernel.org wrote:
>On Tue, 3 Feb 2026 10:44:16 +0100 Jiri Pirko wrote:
>> >> +/* This structure represents a shared devlink instance,
>> >> + * there is one created per identifier (e.g., serial number).
>> >> + */
>> >> +struct devlink_shd {
>> >> +	struct list_head list; /* Node in shd list */
>> >> +	const char *id; /* Identifier string (e.g., serial number) */  
>> >
>> >Why does this have to be a string? The identifier should be irrelevant,
>> >and if something like serial number exists it can be reported in dev
>> >info for the shared instance?  
>> 
>> String gives drivers flexibility to use anything. Perhaps I'm missing
>> your point. Are you againts free-form or just string and buf+buf_len
>> would be fine?
>
>I was thinking binary buf+len is fine, and we shouldn't really expose
>this to user space in any shape or form (hence no concern about free
>form).

How you imagine to name faux device then? I'm sensing that you want to
get rid of busname/devname handle for things like this and rely on some
randomly generated index. But the whole ecosystem is bases on
busname/devname handle. Any idea how to overcome that?

