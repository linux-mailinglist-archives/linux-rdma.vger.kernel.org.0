Return-Path: <linux-rdma+bounces-20558-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PeMB59ABGokGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20558-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:13:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DDF5305D1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F122030689C6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59AC3E51F8;
	Wed, 13 May 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7ryPilF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266C3E5A0A
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663513; cv=pass; b=LbxDlkbuVGFfSOYTyCOvifRN/6q7FCT+AyWJo8Kr1pU0+fJaACpA6eehOC0gc3jTYySxgnwmUZ/rZx8cVAcLPpjBPRvepxHhOebTOKbkNf4zqgYZNpAoWKyIlbY17wcuWTbgjEZ3HNeiuXxxElSRZ6BoYn3PJk2ZyQvle+92G/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663513; c=relaxed/simple;
	bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDp815g/T0LxDFMgAJlFSWw6PMd99yKJt5gwVu5vOYAWkBB1RZVhwUwjIsyb7U5mVOHPY7JO0MgDaFi0fbdXoa0ZQdJ88nuEx9EVgnj3lKiiYngdeAQSTuZdYEfosr/hv9pZbb0myMBYfPY5AuP8lM9OE4Y+4gZ6b2sngq7VU+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7ryPilF; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a86d384ca6so162e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 02:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778663508; cv=none;
        d=google.com; s=arc-20240605;
        b=CMDZr6JwxXY1LLeucBzzIlPVqxrVRZ+erfY7SCEL2mma72eDxeJDoNSh4bz/ad7LYW
         9pFr1A6v98qHwUgp4A4BPmwhZcuO1fcVPIQrOgzVuHCr1TiEthDTLzTKcxjkjl+jbqLd
         4KWliPaJqg1EGM/5PXPN2sv5yN5F/rBI0f+H0OVH6rqGrHwfABJSoQBOqUbqwoZSk12F
         MUveYiZIt+iKNtPSuMwO7DjSB0eYVM+A1cixW4U0sZvD0DM95dOviqyH+S/2//ItQPIR
         v/s7/d4ysTc0/MCg8pY7j2y6/s931S49Fx8aKNBzYqTnTn4HcmBDA0pyvynGppKngvsU
         tYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
        fh=etmMOMOCv/MuA1X5o+xkYKJVHtOO0taHM7WAkDAE6cU=;
        b=QW/VFp/NAZ3ADU88eQn5HK5eTmXFKswu7Xl9BOsrP5jsmMnLcfc5W1wbLBoz3Z5ShT
         FLTOE4BlXbNf11zo1q7/bOsd211uj29NPPEUeDsFsVszDd55juA9s71CfNu7NtK7hWRF
         b9L+Vfc5W+aUS9Bmof/brFZIHQkku/iuKk9iY9X3+ht53XGpfes2aeMsQ1nufNJKmmx5
         QlAP0wtt6qlOLPFdPglOibPuvwERholRX+wQem2MDdJGOP9V7yxqdQ/omzM2G9e0fMAJ
         Y9PunwQp67rMa1OXnCmX5kMVpEx+Umq/tga1km7ZtlpYKHI8VxSD7K+kY5dzOnuro220
         O4LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778663508; x=1779268308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
        b=S7ryPilFOx0/UAiSqx0Yhty3Eu8rBXOXDy1/PjJlDqDZuwVUEGoYZ+ahFB8pt0j/Te
         7xfUa6fnvFpSYRQdMCS6op4+ZOybEB/KRuEHUQQUHhYFhhjRcsE5mah2RQ4R8au2k3DR
         XPKOTL6TuzW70m4/k857B2eqS8UIalpaqeqV6WNNa/zidj/vIHNQVVFkYvVbh5AuX70E
         XeXTNiKZWZ30LvS8MerGab6bn6pQv+cAitV5TbIEgBgCHGl0WyJVB9U5iUoPenv5vZa0
         wM8z31ab0uzOyJuM7V4Wl8GUqYNEHuJhP2o776ADF9x3/uuD0pHkBHpY0ONYiY41iZs0
         055Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663508; x=1779268308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
        b=TZI3EunjmTgS47snq5nS9QSMhOnIjgLer0EaPjcB/X4Rz6imG8t4Q9z7s8hp4ayb9E
         bQt2q3uZw3sQ/oiMujQpG6tc+5FMhwHSUTzzKGRXTlugbKirMKWx/ooZZbbJpWluOzD6
         tbeHbMw6w+G40022PDs+maOHaxaFnMH4KS766q5yP2k9NW0fuyO4ExELp/2glYbyDunT
         7yVi72hnUjrPpjZ4bMco0XdQj3fiqJJRAu+5ExFFvn04qK8HEbMuGymStVSn1q96epS/
         cRdADILp5sprzkp5zDyswmLUyWasrtYBw1Vmbf7BBttMQF1+vdpFAyv6gme7+WKXG30j
         d3+A==
X-Forwarded-Encrypted: i=1; AFNElJ9qUGkB0DoGyEwOwrYvlgPvThVFSeB1JDAjsjBEBPZOGaTSQF5xaf8Jq3/Xhl0oh2tHa6l67vPkSqjN@vger.kernel.org
X-Gm-Message-State: AOJu0YwKHQ4oeAPs0BgH9nmIvYTPeyt1Bd6JKtNzA/01/kexXtRaXrHb
	GZaPRtf17fDevQy0SzdpsUgy6YWOpOh7pAhmwnRLH5dXfw3675w/PUOS6FI/rECfvOeAICcajEy
	rcPwNwzVcQh8WlYnpaOUycFufxQlSn8KzxMrQbvnl
X-Gm-Gg: Acq92OGYN/1NsxGeIMuq78L0tuEU+DdJnIRaXgjRV5TSaVfcRMRFM1bOnm+rn+cSODv
	fHV72b/GRD7UbLJMgGS5pN4QXQNrpLH1MCLAsRyjZ/L1oSpANShouwa3/V/TJ+Jd/UsFN4emo8I
	MLp8M9W78dFXMKj21Ewq1S5ZqEY8s7I20KrCw8hn8lJ5c41Y+7Hrn9bvU67zsRVGfkqoDOvbCQ9
	Ep3+bwomnr09Iitpt2+gz0Tl9B4nIq+AG9IBDYKVi1tis30sM/7ZI+qw1e07dNL2JD5ANTfaXtV
	QfqNQ/wWYcGOl0xNZrP0a4HAaqBGIPC9J2GBfD8GV+JMXrlw
X-Received: by 2002:a05:6512:1146:b0:5a4:462:a470 with SMTP id
 2adb3069b0e04-5a8f1a27ed7mr127165e87.7.1778663507927; Wed, 13 May 2026
 02:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com> <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
 <20260512140532.f16379be75ab006f2cca4747@linux-foundation.org>
In-Reply-To: <20260512140532.f16379be75ab006f2cca4747@linux-foundation.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 13 May 2026 11:11:34 +0200
X-Gm-Features: AVHnY4JkYKmjfMjoxQK2Kv5dUgGHN1tiwBYPl837ha0neUHazremeoJt4lAaHiI
Message-ID: <CA+i-1C0pUX33A6zPFzk-2UtiQgAZG3hss3-aNcf1RYauUuQUWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Allison Henderson <allison.henderson@oracle.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D7DDF5305D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20558-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,oracle.com,davemloft.net,redhat.com,lists.freedesktop.org,vger.kernel.org,googlegroups.com,kvack.org,oss.oracle.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, 12 May 2026 at 23:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 12 May 2026 12:58:20 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>
> > On Thu Mar 26, 2026 at 12:31 PM UTC, Brendan Jackman wrote:
> > > This patchset used to be about switching gfp_t to unsigned long. That is
> > > probably not gonna happen any more but while writing it I found these
> > > cleanups that seem worthwhile regardless.
> > >
> >
> > ...
> >
> > Any chance someone can take these?
>
> [2/4] is merged into the wireless tree (I assume) and the other three
> are in mm.git's mm-unstable branch.

Oh sorry, I just checked and I did actually receive the notification
when you queued it, I guess I just didn't parse it mentally.

