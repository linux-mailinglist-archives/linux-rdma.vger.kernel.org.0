Return-Path: <linux-rdma+bounces-2859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9066E8FBCFD
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF832855FB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5782514C582;
	Tue,  4 Jun 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcrQlQdx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE514BFA8;
	Tue,  4 Jun 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531452; cv=none; b=suuXopYSshV3EdqdNaPEPzXTUTjyiJ9irsxQLJZmvTONNWU75TmXaYjsPuz78FMdbYBVI4DzQUZmXeLjAuxStEKKJlU1JZYFjLr5bf6TcReyv+wUz5/VIE4HkW04/HmUuaduLSt4TE3WS04iDeMk/JatZSYs1e2F69IQjHHh4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531452; c=relaxed/simple;
	bh=NoZ60/3I8sWKWSOxRd8whX5XG2JH2IMU+VUKv74CMn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3lkXVsrcM9o6I+3TfCb6C1jjxcaeLdknc2mb0iOJQTUnADad97RxJx3aSWw76tGq9ViOtWMpVWQMC3L9Ia8d/tMMzRM8eQlN20+STaiHYk2bNcQf1Yi9woLEnJJ6ML5aoiiw1opwIfQkkDJD2CNMRsveYSXqbobzwtBcl1P/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcrQlQdx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-702555eb23bso2898599b3a.1;
        Tue, 04 Jun 2024 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717531450; x=1718136250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+24MUcJLTqMTxLtXfNfOk4eUSJDfkxN4hOKkJZ8yq8=;
        b=PcrQlQdxW+q0VtepoOLrwbbTk4J2BYjEYoBprRvFo5faLHwc3DXhuaHVHjqVHeyplY
         y5O2onI4s1eCnefAo6F6hRzKkb6RM0SUsLw8A4Sski51hKAMQHNLYRLIguDSa6wS+RXr
         +Rpi1/RU4VeqoMSLzN9gfBkrPoE8NxZvfDCfs+fifpHDnIaVVgfoLvltfkdxYxaEY7Yz
         AHrkUq/nr/9mw8SkbiIagzyoDsU6GM+9LG4avcNPzmCtTErJNdIysLcEC3LIwhFpFbWN
         6CrUk5dHjt6KsPxLtUQ5bRoRkX+AzQ7qEEu8gMcicqj9wm0JbmOiLzgSi6cnVQ25KSYe
         ojPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717531450; x=1718136250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+24MUcJLTqMTxLtXfNfOk4eUSJDfkxN4hOKkJZ8yq8=;
        b=LyrXA0uSzydxQ6KigYCkWRJslJi211b4C+syWafYEsIJzOr72d1UFx43fV70ykeK+h
         rNairxPCK6BWTBJ6E0CSdMGy9pS8H+S4a39QG7pIaE+XUdirO8TBPwXm2dB/+ufp2doy
         Tb7zbAHCLqpryFjW93RuV9FT/XU6quN5xLBRvBbE4KYfOojSXk/U3z06C+klhOWYUgQP
         U4u35hcSOOFZsv15Sa0nKR9EyZLbvi+Q/CNh7TYtT8VlTd97+vwqXmahTHz1r3v1w+m6
         IcbbD53ZzWDnJCv57Gf+fc9XR0sA4oLTU43GgFG++7nBEkL8Ah64mhgf1L5mkyzGi6rz
         x5bw==
X-Forwarded-Encrypted: i=1; AJvYcCV0G+WQ4U7IU7I6O6ifX4op6QZAYKAqkGK0YXW3hqQnkkbY+8uoxD6yQJKoOD0ruCox0Jmsj2R3BxCRYLUwHWBOlobxqjaf+qE40tuRDP/zKN3s5yu5uEJjhDUOd/J1IiRFrpRWUsjY/g==
X-Gm-Message-State: AOJu0YwhbbdikXz+pmbEMgWLIHk4FgpdgVqdStcQ/YxO07Xeviq3Epoq
	iRpOYlp2Nn+mFRLqSQcWMalrLdqNJWdQL4UGOJuZrOZdHPWZhkgw
X-Google-Smtp-Source: AGHT+IELiEtMOAJZph6bIqKZ/dy/Dy80YTBB9pmkx9dxb+1OVSPKQaenfPO7D+Vdt9pTlBdXvD6LiA==
X-Received: by 2002:a05:6a00:2e13:b0:6f8:f020:af02 with SMTP id d2e1a72fcca58-703e5a498ffmr518330b3a.34.1717531449911;
        Tue, 04 Jun 2024 13:04:09 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242af1288sm7408029b3a.134.2024.06.04.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 13:04:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 4 Jun 2024 10:04:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <Zl9zOH2hUramwNSi@slm.duckdns.org>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
 <Zl4jPImmEeRuYQjz@slm.duckdns.org>
 <20240604105456.1668-1-hdanton@sina.com>
 <20240604113834.GO3884@unreal>
 <Zl9BOaPDsQBc8hSL@slm.duckdns.org>
 <20240604185804.GT3884@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604185804.GT3884@unreal>

Hello,

On Tue, Jun 04, 2024 at 09:58:04PM +0300, Leon Romanovsky wrote:
> But at that point, we didn't add newly created WQ to any list which will execute
> that asynchronous release. Did I miss something?

So, wq itself is not the problem. There are multiple pwq's that get attached
to a wq and each pwq is refcnt'd and released asynchronously. Over time,
during wq init, how the error paths behave diverged - pwq's still take the
async path while wq error path stayed synchronous. The flush is there to
match them. A cleaner solution would be either turning everything async or
sync.

> Anyway, I understand that the lockdep_register_key() corruption comes
> from something else. Do you have any idea what can cause it? How can we
> help debug this issue?

It looks like other guys are already looking at another commit, but focusing
on the backtrace which prematurely freed the reported object (rather than
the backtrace which stumbled upon it while walking shared data structure)
should help finding the actual culprit.

Thanks.

-- 
tejun

