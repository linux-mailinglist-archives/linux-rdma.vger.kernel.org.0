Return-Path: <linux-rdma+bounces-20548-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFrcEt8XBGpLDgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20548-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:19:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C16E52E05B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB7030512B6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD23D34B7;
	Wed, 13 May 2026 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4VqkFNV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A53AA1A8
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653127; cv=pass; b=uUuTjQ6EqsOZBmXQREYAxLf0hnWB/Ebd13IAtwKhmQsiBCdhyKnhvddUgYrD7nH51rk0j2K4HzrVL9GNcs3hktAuUSZ+AYCRk7SypLmPd3lEVyY17eIfSAtyMF+6/mBE/eqmRC/FpM71tVBcUl1fTNwCmUPeJB9v3qT4JSUQOdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653127; c=relaxed/simple;
	bh=WrY2hZPMMxxQ1LWP6MgclBD3iRLMofj8yrbwp/ZI7kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UflOfcUcO8jkcJtRJJt8u9g3lG80u05Hx3z+HjBUpRT/Nm1rxk4vRcYgmML4r6HAX5Bjr2Iny+k62rR1VYvcdSlHMcyVEHB4DoHAuc/vuE36SeDWo6SCe0mUs2A/8HZwVLr5CXswjpUjpNHV83BKSvaBwT7LLm6k2VLFcGjedco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4VqkFNV; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ae6a0e523so986428f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 23:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778653124; cv=none;
        d=google.com; s=arc-20240605;
        b=NBG1ZOZ+m8SXo5kThPoqRYlsHFk4oHQHB6QDF2HVUGjzCJrw5UO54Cb4xtUv16ywEc
         8bD3Y6980lp12s44mAVtkTeMJn0QMt0KcH68c7UWUPN/nbvEfFBj/cbVjGEN2ARZMA/i
         b1iO0W/ciwbNqlGDWd+ffaCifkH/juydjNmqdmYOKPappLmcDZNYlaHmpauHr4U8lCXh
         SmynO3JItYsZqEQQodghCsGkPeJl9Mv4lpXAp8Vm86LZHm6DPhXaW8X8BPOKrKqWAAcf
         /ypFyukeN0XFerlgfgqH1Y1bCsac1214K9XD8y1Y9HZecQxmWHTH/Vmnu2S1ct82l6xd
         QX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WrY2hZPMMxxQ1LWP6MgclBD3iRLMofj8yrbwp/ZI7kY=;
        fh=JmBC/lP7JXIH07RShZ744APT6/LwgKZU4U61lJgeHzw=;
        b=RRauWVG/y4vsQ1qWAs7r/2372fKp56sPQsDZ4iEwJdMC3xUCM+eQI4dRWic9bPdk8Z
         0wCJIbzUs8x+M9S0Zr50MRXjiq9Eik7mqgDliUcTGrp7eK1mNQA45w3dSqZ8JSrPM8Hb
         xBXdvn7h3GjFxcMo2x/N/Kr9Egl/O2P5R4amHwQCZA4sS1kRKDMdZOVxzD+KSi1d2vxn
         li9TP0Z3fstBiHfo1YXv3Cv5g9aMoKJ9FHJ3KgPk0hXJnj3OMYnhGw8wFH/aDwBBtk9m
         E9bPWh5rxaPNzp3GsN9DfgRuX1N9vZjci3aa5zRQkQFu6FtxmMmEJ0UoingKN8M//3Ag
         wd+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778653124; x=1779257924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WrY2hZPMMxxQ1LWP6MgclBD3iRLMofj8yrbwp/ZI7kY=;
        b=L4VqkFNVw7lQg5Wv+6QgazCzrAZt2c3hwqn4QSKnF0XObuHGJSIXFtwwtYU2elGr2S
         2Mzs/VIdbRkXhxvWIg9JboEKYzKmC7V5vq0CFEr6Pjru89GMD7miYJD+DRSukE320XJx
         a9f29VfxTWWWYCzavbnOFocc3+NnXAAZ/VWgqLMKS0ZXCAPwmXeyHKoeDMZWD/Q4Z/h6
         oK62kfckBon4TjMHI2vAMGJZDwrVZl9W1AWkD0nas+wOVzcdCsmpZOfdG03928pIgYE8
         BzHiUnBkebOzqU1uj5+t4mL/icxCcqtZdjQAWletIhlS2w8SBj5g1FgN56msmRne/XG4
         IAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778653124; x=1779257924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrY2hZPMMxxQ1LWP6MgclBD3iRLMofj8yrbwp/ZI7kY=;
        b=nn7LDqx79PM5DSsRW3cvesXzgpOrahkeotYgwR1L0LLoArJ/zOUmBLMbjRhrrTa5bw
         mqnchidlylAdyIpFpB+yWAUILH8e5ea2i33XbZOTR8xYfM1mVna2vTpFTQrvfniCDnPO
         vZ6Pubk7r7b5PNT75kjEg0hnhMLd6safHm1qigYIOtvF+bGv1+DnW9/F6RhFmgSf22sB
         mkhsyItHIIhcg5SEq8xBOqLaWuaBDszfaKE8TW+LBhybZOHqZW7xSUyQn36NTR9Z+wUx
         TRyeTwogGd9jYG/ial7n6K/5PxvYUTk09MtkL/jJuem71Wi6insR7SaM+mH1Pnl1xyAd
         pn9g==
X-Forwarded-Encrypted: i=1; AFNElJ8leqyZzZ49Scx6eKDF67EvaZEB82K4+XppLLNmOckHJp70Cpfo4Qf+gzTRr1FlxHcQsu66iusDqycc@vger.kernel.org
X-Gm-Message-State: AOJu0YzDh2qP6m4lkX4thIQERsgN/K7Mm01alWMkKJtzddoOTwTb7cHo
	B9sKdQ/ManjNmNP8tqCjOxaDaUOZnK8Bde6Va++la2Yr9S549KTXFMIaK2x+j9P36D8YLnmGKhK
	L3RVP2Dstj3iUF++7KWrJESvqWzXWZAM=
X-Gm-Gg: Acq92OHGpJBRuDQlqNx0tuUNEfKlmz9saIgwlLW7OZNobUmfFlhdHUjtPZLRvUAe3r3
	W8BkWwOCtgFGplVO3df7/v2ktNkec+abzbvr3KIc9TWHRvenB9wGlKDi/8NohpEGgVfeBcs6hqV
	fhQG0y7LuLigtNFCA5SLPhZghTg51FObn9FtGjjo1d04MGfwjT5KRuY0MgiHyJdMtzYzCeroeRY
	DPj9cc/71r878XUY6C50ry7Y0tAizDrKzzKWMaIjfH+KuIr3qt1iPUFkhdyU+2ihiHrYNhfjqAb
	sNVcOLHvYGoc1jqNTA==
X-Received: by 2002:a05:600c:a48:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48fc9a0ef80mr25793175e9.11.1778653124195; Tue, 12 May 2026
 23:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511070211.1033178-1-maoyi.xie@ntu.edu.sg> <9b6148b29f57728d97a9fea8a400e87a3f6a1526.camel@kernel.org>
In-Reply-To: <9b6148b29f57728d97a9fea8a400e87a3f6a1526.camel@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Wed, 13 May 2026 14:18:31 +0800
X-Gm-Features: AVHnY4IcN0Jh7DC42BSM0bqJQ3RvCnFtHU0k-WlbQCijrYUbo8dXtGmCYJeD58E
Message-ID: <CAHPEe=HK5=T6OwozBwKR_i_ULNPbWC2k6PNhBfJLX6_gK76+qw@mail.gmail.com>
Subject: Re: [PATCH net v3] rds: filter RDS_INFO_* getsockopt by caller's netns
To: Allison Henderson <achender@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org, 
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9C16E52E05B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20548-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Allison,

Thanks for the v3 confirmation.

One small follow-up: kernel test robot reported -Wunused-but-set-global
for rds_sock_count, rds_tcp_tc_count, and rds6_tcp_tc_count after v3.
They became unused once v3 replaced the precheck with the per-ns
count. I plan to send v4 dropping these three globals (delete-only,
same files as v3) and carrying your Reviewed-by forward.

Best,
Maoyi

