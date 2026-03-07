Return-Path: <linux-rdma+bounces-17670-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B34Ak/Zq2kqhQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17670-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 08:52:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6F22AA75
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 08:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA19E302BEAD
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C23355F48;
	Sat,  7 Mar 2026 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Mzgeg7MI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A68287E
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772869954; cv=none; b=tsYVzhGypOMtH/mWv/jKesTfc9bvVqyxZ3I5wb3MbjBoBFmNfASBTfmFBLIY9oWulmrGJV6E4t50oaQsY/2qSZKa0rrnWeDY+48vBWtB16mAcENBt3VkQxCSuXwgr6/0B9Pobi64tG+2WSeiz24Mzj3srpTThigLb3N+miG4qhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772869954; c=relaxed/simple;
	bh=PLl3ybbEvtBt4usL1tVzzE3ceztfK3Ph05TigYRMy6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvKQWo31YuNk11Sb9jkGEeh4dYIIGjfhPR4Jq12RIuFgwb7a6660g9AktVcNM3whsrLEg9jYSs0YJpZteJww/LrtEtfMADm5QcPTRvoLU4dj+DQywxjtzxt6mdcV6s/mJHXFmc2wassfIDFkdd0WObO6UOgmT62N2oBUeK2pqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Mzgeg7MI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso88405185e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772869949; x=1773474749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82vwVSYqsxgUfO5PF4fV0qSf8sFXrhZ9cxXt5gjXgk=;
        b=Mzgeg7MIOIrjh+c3vI3Akf/UIjsNyGah6a6RbQ11xw0pXsGQ+c9Wsv43WQfpej1Mfo
         dtehQ3GsKzPO+PydcLr/RnoknSaS27Z/tH49od5FsnCCB7MeCkj8qyLutf1JLXc7Fdd7
         ThvyXVsnu+Q7c2an3F+1SjedMiGdA5C3dSfulg93qQwup8IWQ6elfpQlhRQOTAZH1tP6
         P+tdaZ+mC23yQicU1Zdxxf+JCJiq4BYqQ74/jU3PUECHrc1dPph9IWH5Nv+NXSVTl1AT
         cDQz1MeaW1cB5T9aGQK5Xs7tR9qRJPLK5Fki8r80GzKu0VJmH1PfO3WLJzy6zXgIMh7V
         I2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772869949; x=1773474749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q82vwVSYqsxgUfO5PF4fV0qSf8sFXrhZ9cxXt5gjXgk=;
        b=PZV/eidw9feCWXtteK3dAwrreCbctT4zTczt01B560Enm3b7H0VJyMBP7/OdWgkkn/
         3XbDJRI/c7xaj6XHLWsPmlrtzfeczeDwDlhvecy5ldJZRbG4etbmm89k1AaqOtdATSL1
         PiQKWJwyDnkdwNaihektHsE2wt7Gpt8C6L/8k3ow/hmlrAJPe6fCNxnLGJ6K+l/4noby
         ZWi9q5Y30AaFBSkke6KYPhJ5sLfz6aIQ1DanT2wYwdadQPKi3aglPXCZ+ZJTatFVfimv
         xiU9b3Xs1xql7znUovwhuNlPsCM8NoRGVe2/amMRgH3bwsD7bOj+Un+whjG5KU4EWMdO
         Bqeg==
X-Forwarded-Encrypted: i=1; AJvYcCWpW2BdrAq1gUnY52sggQl58d4EKOkRFDILRzArUmygFfZUo6NwzhSx0uggDcAkyjrcVtBHvJgh0R8U@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgpn+umvZwnqNbRWjOzJVNP1c5E8RkdBR2xIPYli/cKUbSNbg
	0EHzFwBexhUjAswXV2jXaYWobfxC6Cwiby1ztE/g/tyNYG+Y3YK4De+YTkD1Rf1HxN4=
X-Gm-Gg: ATEYQzxsFIQpdruR/IuvLqcBlERwqpEM8IEuFCJEwlehjUcZmwejrF/em0HECqd0yHk
	GOIJofmqmWlGZmLHFJKnvRVoCPx3KvS2RScgjlI2bHT+nqKafo0R8JuuoWKOINMZWLTSCB6zxng
	cgRSP9JUrQTOItu3LhaDwabUcj7JocZ3ykXeQPjqPmHeO0yQKeFBMMejM7Q3opkecCiRzTe5B5J
	85j5YQZl0AWvm+rhX3EazORgapq3SytP1YkEH52dAq692NHbSmgQ6nU1KfwuSzRBN/zBUYDjwgt
	I4QhfYWWSlyqTf9pvwEkCj772cdpH+uNdB11tbv7c3e5ITtyKl6dsizy0yo8MSAqJDuROUXBaki
	RkSqxpFEEmFln3LTJYu2iaMNdePln+fIJjab5TvzwsdjU2MkMWgI+QUG7zM8q2Qn+xb3Eo4ycqA
	KitAHvjLuFC1fANc4VhMaz+jdRwTnU8Xc=
X-Received: by 2002:a05:600c:870e:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-48526951415mr82861225e9.19.1772869949098;
        Fri, 06 Mar 2026 23:52:29 -0800 (PST)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852381c61csm36839135e9.11.2026.03.06.23.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 23:52:28 -0800 (PST)
Date: Sat, 7 Mar 2026 08:52:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/13] devlink: expose devlink instance index
 over netlink
Message-ID: <xf2qlcvpmw64zpqsjogibda2ys33vwyectptwo5imdstwtp6a6@qokwax4d2iwn>
References: <20260304160022.6114-1-jiri@resnulli.us>
 <20260304160022.6114-2-jiri@resnulli.us>
 <20260306193253.6d7d2383@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306193253.6d7d2383@kernel.org>
X-Rspamd-Queue-Id: A6E6F22AA75
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
	TAGGED_FROM(0.00)[bounces-17670-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Sat, Mar 07, 2026 at 04:32:53AM +0100, kuba@kernel.org wrote:
>On Wed,  4 Mar 2026 17:00:10 +0100 Jiri Pirko wrote:
>> +      -
>> +        name: index
>> +        type: uint
>> +        doc: Unique devlink instance index.
>
>AI complains on patch 6 that the index is truncated because it's saved
>to a u32. Let's add:
>
>        checks:
>           max: u32-max
>
>here and the policy will take care of the check, you can then remove
>the explicit checks too

Okay. Thanks!

>-- 
>pw-bot: cr

