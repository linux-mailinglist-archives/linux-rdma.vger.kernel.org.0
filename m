Return-Path: <linux-rdma+bounces-16744-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIUVOjdLjGmukgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16744-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 10:26:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E8122B4E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 10:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8B7330066BC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB003557E3;
	Wed, 11 Feb 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsDfem37";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="suuQ43Fb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1D2E62C6
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801973; cv=none; b=mPMdC3TMF92lPO3QmHomeYcXGaFp44Fdid31v9w4QBtQBfRV5X4huO0dPFTCLQ4BnF2T/88X80b9aY1riGBjt7XeIlazQ4WIq7UXmkBpmQa47nWPkfsFpEY5CJGw6tLvd8OJ+xcEgXcSnRl9I4WS5mXaV2F8xihuGHwCrlDfT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801973; c=relaxed/simple;
	bh=jIImnerFM+OYXbMNw14ilawQ5Qs0Xtw1HG2jKfmQETA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNusTlL3DE+5b1yhHcu6I7VK9AE4jkcM0qnOMxhdFy5rNOv9SPK/HpfC34ZRnBEYuFi2XBQNyAM3Vp0Xb2pZ+bVmmrAKcRF+w43f86Tgu2DcUDJzAuMdAvifdDDB2oVksoo5/VapNeyTeT7ayRednihNr8YT76ORjOoO1AD+jdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsDfem37; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=suuQ43Fb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770801970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZuDjmJOY2PmvR2TdGKfik6KPMKtWY5GB6UOVKP4/vI=;
	b=DsDfem37TIXjpWLpmN0qCDYW/PF0OZLEutnnpCAX9VRexW8JmV88pb/kz4gw+I9rQDVIhV
	eMpQOyBqBhC6di4yiGlum6us8FaAFJMGXEI3wq4dzmmwdKMloTltMvYgvJEYNTHSzaYyJ2
	oFYUBOZTtTfCyvQqkbIrjYJON3t2Llg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-TT4RO1ZSPLi-EwKjNGdQEQ-1; Wed, 11 Feb 2026 04:26:09 -0500
X-MC-Unique: TT4RO1ZSPLi-EwKjNGdQEQ-1
X-Mimecast-MFC-AGG-ID: TT4RO1ZSPLi-EwKjNGdQEQ_1770801968
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43771113b3bso1313141f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 01:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770801968; x=1771406768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZuDjmJOY2PmvR2TdGKfik6KPMKtWY5GB6UOVKP4/vI=;
        b=suuQ43FbqvvRWbE8cpzeWAiHR2XgOy5XVzYtwpTXkH2c4O2cOvpiCZS926ne0r75Hs
         NwcD6butJGT/V9kI6SQcqta5QqDaBDmP7og0HTPXsb2f+e/ojMCGKXYM62DZLZ55F4P0
         9/2lznwrWZvlV2M0ua2FT0GDr92Zx1t0hBsb11DDewPDTZm3FXb3Ky/cNbzfAWAlZ2yu
         Xt2FLqtIWYb8t/D1Kf5gw5jlHKQeF1GZw1UXVqaVFbJPbDQ8bKRhir91IEEZHeYXB4zw
         X7CZTBUVJicHUBQDbGjg9Wj+A2FWT3s0hbdfZpq1gGy8Gia3FQTM5dVdOLDpXKx1pL/n
         Uv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770801968; x=1771406768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZuDjmJOY2PmvR2TdGKfik6KPMKtWY5GB6UOVKP4/vI=;
        b=NUu7nJ1wygu/k+HeYbHUwGi8Se3a4rdH9JMsWh+m/yJ+D0tm6fODHtaU2szJtnOrMu
         fsrtJbKkYguylDZwnZsmJg5O0or6S5qjFEU4ZG/yNaN7c5mP68BLUpU0FXdMopYZWSrs
         gGHIDsUE8zb3oWzFt860VFPWRLd1f0g424HDLp2btcM1RS7L3nSRpJ4hbuSGHxf8mbKV
         qPP9j7mLQkj00VTiQ+5wq4BY0W9USPQTF/Pcb012meILXdNN1Wm8VX/X0XeX7c0gZg0h
         0zkLjarsJW/UOz9IeIWnIJjSP9kQ+gKWyB+K5wfdQsv6mc1QqQeb65ksx6XZiK97KlnJ
         kTbg==
X-Forwarded-Encrypted: i=1; AJvYcCUMn8Fozw0UCHBvEbuDyzPF03dZIhrjBZjTwqdsop0hjN520iiGggGOiX3YB/KIxil4ybJAbj0vei1Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2qvczjKOrWjaRl1VAHkvss3CFubPBAfb9HmLI1tvUeMQeU0RM
	eq6tnDT5ZpHYOk/7lWpjOOjXYW4YX+zPu+uVdueIj6E6hVuDH9pCLgfwuIGH3XR634aWD/h3jDm
	iqEdo8cGl7ViLgZw48ptGeEhABW+YcDC+GO1LBh3plc70Vq/+IyHgRo0jB/5v8Ns=
X-Gm-Gg: AZuq6aK/vAufi9GIoDCIlr/wtpzNeNsPa0lnBCFmH9meYJ9PkVjnS1wWgIlCEtiMEcb
	UBk8nYoS323dP88ZUkjWcfcNtk2ckZMzopjkd4tUhfQZMmL8pY1zTfFBiwmFR+w7dgY22l3wr/S
	CsApojc9GgLziIc8xg/VHy0mvL6bblb5rPNB6SB4JnD5iWzMpk6LAf1tKRaak7iT1cucKsqD0PG
	qvj7MAI8jv6TYPrQ9r4zTWfDIjsvCB3nXhjHuUlJX7Sbv51arfT6SY14AA2lrFJ9V9zo9QGAhA/
	WBTMnflXc6R5HVPiMiwQY/56mXSiuHQ6LiybKdUi+Dcjz9CuH7/nSNi2ZX1C47o0rHNnhzfTZvN
	aszKjJ1k3vvPdAtivQHTInEBUAw==
X-Received: by 2002:a05:6000:2382:b0:437:678a:5921 with SMTP id ffacd0b85a97d-437678a5b00mr16264904f8f.1.1770801968466;
        Wed, 11 Feb 2026 01:26:08 -0800 (PST)
X-Received: by 2002:a05:6000:2382:b0:437:678a:5921 with SMTP id ffacd0b85a97d-437678a5b00mr16264831f8f.1.1770801967929;
        Wed, 11 Feb 2026 01:26:07 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d4785fsm3095279f8f.11.2026.02.11.01.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 01:26:07 -0800 (PST)
Message-ID: <2945d029-14f8-47af-a40e-11cc13da4d79@redhat.com>
Date: Wed, 11 Feb 2026 10:26:05 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 5/5] eth: mlx5: Move pause storm errors to
 pause stats
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 kuba@kernel.org, lee@trager.us, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux@armlinux.org.uk, mbloch@nvidia.com, o.rempel@pengutronix.de,
 saeedm@nvidia.com, tariqt@nvidia.com, vadim.fedorenko@linux.dev
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
 <20260207010525.3808842-6-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260207010525.3808842-6-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16744-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 936E8122B4E
X-Rspamd-Action: no action

On 2/7/26 2:05 AM, Mohsin Bashir wrote:
> Report device_stall_critical_watermark_cnt as tx_pause_storm_events in
> the ethtool_pause_stats struct. This counter tracks pause storm error
> events which indicate the NIC has been sending pause frames for an
> extended period due to a stall.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

I think this deserves and explicit ack from someone in Mellanox, and I'm
wrapping-up the net-next PR right now. Unless the ack is very fast, I
fear I'll have to defer this one.

/P


