Return-Path: <linux-rdma+bounces-21655-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W1fgC0pTH2oLkgAAu9opvQ
	(envelope-from <linux-rdma+bounces-21655-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 00:03:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A92632524
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 00:03:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eaLtNQJ1;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21655-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21655-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B1E3044B98
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44D317161;
	Tue,  2 Jun 2026 22:03:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE11243964
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 22:03:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437795; cv=none; b=PwiHUNzKyIDbL0ZnKvwzyn0UsStPiS8sEPDR/5whqKIRM5iUEFtQf6RdretmS//2+dMs0wj6y5bm/87b1G/VCWfsMdGu1Fs5Zy8WLxiI+nNDYPGRJjuDFdKR0lEa5yF5a2e7eapriy5vE5CbEiRdtBlEyO2XHttADPUvXfrWSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437795; c=relaxed/simple;
	bh=4+LWbL33ZxVDkQWa87BFPgAAJquvkYn6k9GRc9mrdCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U84u6BYRTwWBuXNIoeLbK26etXWV/bU46YvCyToS/5fyh/8TiStozm7yPmYrlAf15Gif9GSM5zcz6nRUQvWZm5jkOYOS22v8ALa3digD41BSLr0iUnu2uFLWLGu4u1TPH7Cz0kTTgIjvL3Jq1aygmyPgBgbpqb3AYGkqzNhPaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaLtNQJ1; arc=none smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa5e9a64b4so4151515e87.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780437792; x=1781042592; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZowB/Ah72qxuh8AeeExYF2h+hA8m+e7AC7mEVl5yuM=;
        b=eaLtNQJ1Qjby/tWmfYCYn+eIRJQ8x+fUuG3EbqWxTs+Okg1uhuSUp45gbwvz6IAYhJ
         jmv+VAJv3ixNUrfDde8zrNVvEKJ9EMqaC3ZimmZmXaSakSKLRdrxKM8+smPt8jvYKFAb
         cNYLHBAmnt/NVSLAAvxvddt/xIGmPKg94UoY14kxutQ6qAv1vKzof/axVX1+9195A32W
         yLPDvQuYCWjlgY15O9nJ/oew4MRwljKkcvaEV67ndfmSaBa1dck6E65aPUoJDG2d4NyV
         d/yketXFiUW1HhD5UzhzU8+eJ9QB+0t9r9cBGkEdgcxkG45ZWyJHeJROO7laib+brI3Z
         2Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437792; x=1781042592;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZowB/Ah72qxuh8AeeExYF2h+hA8m+e7AC7mEVl5yuM=;
        b=PdzQWuYsx2TYQj+tG6Lpidiw1uoyjw3e5+R7MZnqZhJtl6nBJ8bFic7WB6Zg4TmV5P
         6/85HgNxjFNi4haSfLf62fLf6CQ9K6YSWyANIlpdkd6gCNquid45GOswztBXWLdYqLtH
         S03mDTqMsx/6AA3NDQeRLTZFVM0xorrhTtG3EHOSnqCkL5zd9OEJp/IT33IMl4ooxIaG
         Ese7uacINRRm80u3pfDBi9sOGd1gCqsk+TUx69exWgySfcYse8s5Xfj+Hfj3SE2kA0VG
         1V6HEmI3Z2gRMhNyo0xCB6j2P+yN1/ARnIiko/iS1m7iqqQxLP5d8BrgT6u5hWV5yZ7j
         4IRA==
X-Forwarded-Encrypted: i=1; AFNElJ8npcb9Jt4bPTy90KiVa4jq7Kbru2swlmrO6YByG+ecqxJ5CMekGbAyn7weZ5txZlANw5imD99MLcIP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbb+E2bmjrnoNeRpXxjgC+qduY8ZZQwsLfnd8S/DAcmgICJ9uQ
	/KRf9WEw8JNr/8zowYcAXKFNn+rycjPX73tBTZJJmWHKGQJqcYVhDPPMFspQqg==
X-Gm-Gg: Acq92OGCbXeOKO+Y2jD4/4ZMtII2Oi+8lIafUe8ltQEc4m06Dvo5XjlvbJJ8Ziu7V1V
	SZNkxbGOrblcV9Qk3Lk+e4rRunbd8iAE9ip/DATts1ocDyXH0p5viGi0Pjzbk0OsunP7VfciYyV
	tGUxjkXPi9fDEkywkHZ/YbOje7mxfz1wUBYs2wmgj1vpDDVYH7fQifTpA7fTyCTcGaK96cHKflF
	3t474xp6FKg6xPnwpu7SMe83pFJ83h98v0UulI+u4cvpQiXW+SgE42ARSG9HBZj8KBXYBHHKJZ3
	ftUjPRCQyb8OUtwHm/q7+lwemMeMmAwvYi/arfXbXcuJ6eWda8Nq/FwhXB9wBuY8jXW1aNNPXtW
	Occ0Qc56VmaN0sGyf3NpD8NIdbXXZEFbuK0WNDE+/7CLtkaQx0bN+Cqmtg47RLXmir84jDbM+Pj
	vbKoOlZIypprGRMi150L+uFu0soj8bLJZQUHKMmedL+ENFXw==
X-Received: by 2002:a05:6512:1413:b0:5aa:67ed:68a1 with SMTP id 2adb3069b0e04-5aa7c0a5400mr167157e87.11.1780437792111;
        Tue, 02 Jun 2026 15:03:12 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9904absm203875e87.66.2026.06.02.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:03:11 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 68F6D5A0061; Wed, 03 Jun 2026 01:03:11 +0300 (MSK)
Date: Wed, 3 Jun 2026 01:03:11 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Moroni <jmoroni@google.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
Message-ID: <ah9TH5DNspLIXYWz@grain>
References: <ahjB87k54bYdFbft@grain>
 <CAHYDg1T3m=mn17zLRZp3+zcJq+GeDGcOU_99ZZmWxYasEDKN=g@mail.gmail.com>
 <CAM5jBj4LPZxejjq2VFJZiwPWkZf3_rNxBRcT-8yrnfDXFSot-A@mail.gmail.com>
 <CAHYDg1QH=tMy8xbYn4D-L9iyp9iCVCEU190H9_gFLTWMABqhpw@mail.gmail.com>
 <20260602182503.GI2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602182503.GI2487554@ziepe.ca>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gorcunov@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:jmoroni@google.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21655-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,grain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94A92632524

On Tue, Jun 02, 2026 at 03:25:03PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 02, 2026 at 10:11:46AM -0400, Jacob Moroni wrote:
> > BTW, your fix matches the OOT driver code:
> > https://github.com/intel/ethernet-linux-irdma-and-idpf/blob/main/rdma-driver/src/irdma/utils.c#L3561
> 
> Oh lovely.
> 
> Can I delete irdma then if Intel would prefer to keep functional bug
> fixes out of tree? Hmm?

I guess there are simply not enough man power to keep OOT code in sync with
kernel tree.

	Cyrill

