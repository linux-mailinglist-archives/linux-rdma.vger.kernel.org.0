Return-Path: <linux-rdma+bounces-17362-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGl/AK1UpWnR9AUAu9opvQ
	(envelope-from <linux-rdma+bounces-17362-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 10:13:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F721D55AD
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 10:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2848E302E922
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359A34CFD4;
	Mon,  2 Mar 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AMVKFmcg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F06385503
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442563; cv=none; b=BXgryYYCfMCNFAI1xvvLV9nE4U1onU+1iCaHMRLbMr6vG7nnpk9JzsyLY+UOHQJLBfyiIVSyNvZtUPakdvixOkgMT7uOTMp6fFMXSsLbntceWN4WzhX70rTiNlQzok/AltL9a72TdI3yr4AbdyGn40rWNSvOMkns4jSodP0kE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442563; c=relaxed/simple;
	bh=ilMQGVCasLEyuVKt3xmPGLbzaexBUt4hoMGNq/qop6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrX/NUVqTkxvVxa03Fl/idv1WwMb6rVQd02KLWbF97RIDhrZjdwmAZzcBpX/TAMh/175lDLK6BSlXqUsxkwwSGckwAQ2aBgUJRbGfWUW/QnY8NgwJIfpdYw0dGskIZYrI/heB9QAmYS7v9U1YbstR+KtY7BkSXSpA9SUY8ry1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AMVKFmcg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso36896405e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772442558; x=1773047358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilMQGVCasLEyuVKt3xmPGLbzaexBUt4hoMGNq/qop6c=;
        b=AMVKFmcg4l39oJMarm/bn5uahr/tJ9jjFRlKIlqA9xsQAKkyq4jjrLZRY6EEKLVk8f
         xm7DzBNyWrw6PnPJnMUyxa8fDXWDkd8ikJiYnewReUGwhNSdcPaqzdkTh6nUAvU+XU2T
         xEsQjdgHgZQCq3TBUyCudQXI88B6yGIyRoc08x7bPK6sTBOhcrwOyMpJHJtf9zMxdAEE
         QMiaeRLSCNLbfbu1ATqdUGq80PwNz7MUeHUKzeoLegcsotBwwzziUtrw+eDaOcHeuN51
         U0K225TJgdXRYsu3xyaxvFsHcSPZuouu8gMh5cDO+e0FIFlHLaU7hO2qumGnjIGFVGs0
         1LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442558; x=1773047358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilMQGVCasLEyuVKt3xmPGLbzaexBUt4hoMGNq/qop6c=;
        b=DGtz3x/UTI5sNkecUYLO1ZFh3+Rg850oSl+oVaJfZs4gr/Prt2qdAbm+8xJHvdXM9z
         qe4TEjAXua6iNXjhUfYkffTWjx9T9pRQeMq+tYGtQi9F/qNfs229LckYBfGWJDu4ncsH
         7u+/tRaA7mCv8iYBu+o/qw48O8JYmweXyOyX/o+6P0mvwHcpvXxiIqcAtza3mxdJFhIr
         xoXe24e/bjnc/HkM4dRAZlcELQHg8MixbSVgCVAQ5rfqu7DnW1m+ENnBfR5yjz4xXX15
         fYuNz+rmm0iwNTXbkoBLh7wpvGxFNcS5JRplfibJQ7SSjqtRQxB9QQiO5/tPQqxnHuu8
         ViWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnZKrZRMGtiM7MpPnSVJSfzbkDjDXJ0fjS90ra4sr3ETYvYaTOPLioIhAchtJAZQtlCzRU18XaxY+b@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqZf24ra//1DHRalSkUUFzZxSYTpEVdlhctcLalx6TdH+7kie
	H7B+jF+ebBMXKS5Hv5YVVpV2m9+uxWZ0kydKPerusV0vb8WmVmWbYu0Y14OfbyAGImI=
X-Gm-Gg: ATEYQzyZZciZ/lsRsy9LMS+Niv9hAJ/9TrLNqJtceMwG8hQyLgZPn3CAF7Sed5wfFdD
	2bje/eS6yeTmHiWXLQ4A/aPwp5qAgHzyEUYonNAqcE05aDsLuZn4QuOTdWAOwH7f77RaSY5ywE3
	lr+7LJ80rRc1FCqbKP+V6wY1IaSWpJBqHVAWQi92fBhhYcmyvrqp9QpLJcGwnuxD4NVhR3OLN66
	i941k4udV9lMXhdBufom50fvFV+x7Mv7pdl7yAHHQ3rCq+wZbuuuS3Y9j9/fa8lpesx4vywdSfc
	1+FAVL86OlMqJ5cyaDU61Q0w++zcPT+utBAOoXxox0sLxKQvrzHD88ZkGYoKtFXHL/nR/fIDGfL
	BW5YHaRSV5sGQuMRo+gj2REUETa14XzgUnoOyI7rvLO6wUIDCfiEMdPDj9DbKTQF5zDRMiL3YVb
	mIEVwfroauib2is0mT0e0Ujoe4518DOr/+qu8k1n7nJQIh
X-Received: by 2002:a05:600c:3b18:b0:483:7631:befa with SMTP id 5b1f17b1804b1-483c9bc55d6mr190142375e9.5.1772442558003;
        Mon, 02 Mar 2026 01:09:18 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm633954365e9.0.2026.03.02.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:09:17 -0800 (PST)
Date: Mon, 2 Mar 2026 10:09:15 +0100
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
Subject: Re: [PATCH net-next v2 09/10] documentation: networking: add shared
 devlink documentation
Message-ID: <wukj2sqty6p54lsedkquvija4fm3xjgit53ukomnx4pgymxpsb@pwbyampuhj6k>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-10-jiri@resnulli.us>
 <20260228150558.46f3be36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150558.46f3be36@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-17362-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96F721D55AD
X-Rspamd-Action: no action

Sun, Mar 01, 2026 at 12:05:58AM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:21 +0100 Jiri Pirko wrote:
>> +Shared devlink instances allow multiple physical functions (PFs) on the same
>> +chip to share an additional devlink instance for chip-wide operations. This
>> +is implemented within individual drivers alongside the individual PF devlink
>> +instances, not replacing them.
>
>Sounds like you want to preclude what was the goal in the discussion
>with Przemek you quoted - a shared instance _only_ case. We don't have
>to implement it today, but I think it's an entirely sane direction.
>So the docs should not state otherwise.

Fair enough, I can do it.

