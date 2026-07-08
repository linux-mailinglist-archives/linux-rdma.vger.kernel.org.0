Return-Path: <linux-rdma+bounces-22893-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iVuDOBEtTmp6EgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22893-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:57:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44B724933
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:57:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Kchoqdpo;
	dkim=pass header.d=redhat.com header.s=google header.b=IiBeau2n;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22893-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22893-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD1A3020025
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5133CB8FF;
	Wed,  8 Jul 2026 10:57:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E437C11F
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 10:57:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508235; cv=none; b=cXpRhIpFAArjYWMe+TxBCrfhHIvQr6FcZEBOTr6M3/xtV5270AarzWr4YWHiSWTWYm9w9s5DWtFLSmQLXPbXQHNDCERxmkv6V9Iv90HCYjbO8JZIaKTHWNUuLbbKJbPNGeNbsoQ6mVfL01R+lXQF4xYBZtp/YPVZG8aF0BmsZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508235; c=relaxed/simple;
	bh=M4cKxG7rn03qGW5kSZE88jYrpIP4zvhW58ZIabmPFvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayDHq8GIqkZY1CtpXnAKA2VeDqOSCxHYWz5NTk2ZU8ATw2puo6wqFcams91n11mzOeZsv59sbfoWYVzG3zSyisffq3S4ozQ7EojX+ooMUDmiVcUUSZDr6NIoQDwho9ZIKFV7vFB7kPNjguFDb1FCorXVlntZwSyMqAmanJ1VGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kchoqdpo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiBeau2n; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783508231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
	b=KchoqdpongJZWdD5sul4eLeyYZ7XRJRHb+k2T40+75Fvl9bAPTBIWpYkqQW7PX6yYf+fHS
	2draiQMSMx05mm4wfpXgQM85hsd48yK4SH7NLAQ2+K5oUXD/dtNFld7gkMYyFMWHD212uq
	LyCNu5oG2X9KajDvTHLamHD53USL+lE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-_LG7x4SKPI2DfEz7uIywxg-1; Wed, 08 Jul 2026 06:57:09 -0400
X-MC-Unique: _LG7x4SKPI2DfEz7uIywxg-1
X-Mimecast-MFC-AGG-ID: _LG7x4SKPI2DfEz7uIywxg_1783508229
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493b786d550so5396905e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jul 2026 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783508228; x=1784113028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
        b=IiBeau2n1BfryWMwc0qCCUjEim+xQwfL8k2wOB8NIKCOenk3RKWofZGJEFB2UpcAbr
         DOXPqCTVfwsyDWxl8P0R3B4GZjj22tNrx1vcRpk7PEvWWSfuRJLTJhlI0KYi5Renx5JJ
         0UFKhCTfY9ZztsT5x5Ly1UfSzsN9doxvZtbTiBN1xoNzaSQAx2FX1hcAnUUEneFgAKzs
         OVUiTYs2/v+PJ9mFcPIM5FjNGEhYb268be2UcZXMBn8C+/8TILpINNiFq8z/WGPZnVgn
         IHDnNMRdVeDOhv5zz3hFiDbHXwjHpMKsvFz3X96+TiPumRQzwvMXWnECxeIsoqQ46jai
         DTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508228; x=1784113028;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nRaQ/pUZXsFDjpZJaNCEg3QzvRcLSiDykic5pLM08Kc=;
        b=VOFgqVDyYhciDJEek4vC62CaYk7lCANz0R2UJDzIAPhQwEOOiWKEuLjEAQFTPfpld9
         DNBDzFMh2vpG3f1e8+YbAtogq9Zu7fX3tDTLXX0K50z77NLY43lfwkO9Xq98DydKUjJI
         3Ia+rOif9E9SK2KPlE32KjTq9ZXREUVXAyNX6FCUi2sR5rZ4T/5PNaQudZZg+rhvnZsJ
         N4DerlbPTwcJnDunwWJcWBszFvsuJnP2uCNdhklkXUvzq67f8Pr9SwZ/34RnyPUIN/F9
         jdI7V6fP3xA9zV84VSNyroAqYzCPnuPOWDTOel26BUot6NNI7K6sf/Tv1iuZvI96E9Lk
         eV7w==
X-Forwarded-Encrypted: i=1; AHgh+RqbbnEahmnM6C5wKHCGHF6Hpi3T+ECZ9/fqf2UGlFJqgaIMOi7JpnjMrms0Qpo/CDxrv0mAyNUFDcP5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OZzkGbUaU6L7r//nbbTEsCRra5mSHg6lnZwYl/ts2ec/7uf2
	LHRjJGloWWh3xsM3rjTSbFsTdCa/D48L2Fk7TfND/cMADUv0ZSxFwx2mh0svdEHJZ/j0RJiSjwo
	P93eOplm7YmTr9hb/s26bZ0BPFFV4/iYy4xjM0mKWL/GbBeooOHQvKi4qPEsSKbU=
X-Gm-Gg: AfdE7ckDnF1vIlJxkHyiIuYSxsKmKH7ebYoGU3+V5enXyQn3ZXxPKg2hYiTDAy1qW/U
	HMJunv00g1GCUs0n78aIFj5eWK5GgbDobJ3phVkm6NrO6L3p4fVmUZ50KDUSUY0k94Qe1/SWr7d
	YckyTmJdP79EEKJmlmqOQC4HDc8G0FRSC8mZTZG0OggeeVaFp9eOXJ5KLY6W1RQNha5iV3Jd+wQ
	QUwZtMcE9FYlXPEjlKuRleNSFTUWjKA9PWTFwHKZlkJ7QafUCl56jW+iQjZJbS5kpN+8+mR/8BL
	UYYZTqfgWGBXfE2XEVsg2XpwjJllj+iO5mfoags0HwtTSrhGgRBcOD2ffXNQO96HfOyPC2+qS97
	hgTR6KOicQivBM65Fkt1TiK5PYaZuslcFQqbwmFQg0fAfDFkZBv0H5pacJyvGgFCRB+5XQagRbJ
	w5xQ/b96+RKfv3
X-Received: by 2002:a05:600c:34c3:b0:493:e79e:daa6 with SMTP id 5b1f17b1804b1-493e79edba5mr17133925e9.33.1783508228714;
        Wed, 08 Jul 2026 03:57:08 -0700 (PDT)
X-Received: by 2002:a05:600c:34c3:b0:493:e79e:daa6 with SMTP id 5b1f17b1804b1-493e79edba5mr17133315e9.33.1783508228188;
        Wed, 08 Jul 2026 03:57:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm211634515e9.13.2026.07.08.03.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:57:07 -0700 (PDT)
Message-ID: <d359508d-76a8-4df8-87ef-2767fe7fb40d@redhat.com>
Date: Wed, 8 Jul 2026 12:57:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: mana: Validate the packet length reported
 by the NIC
To: Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, longli@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kotaranov@microsoft.com, horms@kernel.org,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, kees@kernel.org,
 jacob.e.keller@intel.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260702041237.617719-1-decui@microsoft.com>
 <20260702041237.617719-2-decui@microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702041237.617719-2-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22893-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:decui@microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A44B724933

On 7/2/26 6:12 AM, Dexuan Cui wrote:
> Validate the packet length reported in the RX CQE before passing it
> to skb processing. The CQE is supplied by the NIC device and should
> not be blindly trusted.
> 
> Cc: stable@vger.kernel.org

This need a Fixes: tag, to help stable team backport.

No need to repost: just reply here, and I'll add it while applying the
patch.

Thanks,

Paolo


