Return-Path: <linux-rdma+bounces-19203-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NEKEsZZ2GmWcQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19203-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 04:00:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9743D1440
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86686300A3A5
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F1331E85E;
	Fri, 10 Apr 2026 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFrHsGoe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB01230BD5
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786429; cv=none; b=ImW/HEsO7VWmIN+gctoOSPSlw82NpqDWMNOhIEAqN5YqCyUOQq7dwTUPeRDz2yT0KGT2tGJaSv7ecMnAsMzGyiIS7+areeba7vfw3YS6ygagNLUf+FGDKUbXV2qaZqAeG8AxzUN9VjeGv82ErBgi/bUl7HfG8ctsxPbk3xC6RJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786429; c=relaxed/simple;
	bh=q02+w6fVA8fQlZiZYJsvbUg0TeTNTZ6gfTuEjCsRLwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP7kEHD1g7tUYn1gwaAhy6XE4MpY8fobv1j/oXWOUQ0usDLQHWCTFxnL5Aj+/+S6un+9T/BrilqaBnQxsLg7KLdQt1BnGHWs1N/wTubZMOeKV90cPEsFESNVlLbjz7sqZgngrkQjGp1K0U82qFyas0iA8GnMiYgPY6V6krh+ajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFrHsGoe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488971db0fdso15020755e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Apr 2026 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775786426; x=1776391226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bovVPq2Hy5sXrftDQTh1EgPcGL6nK3K2wa+9gcYZYpk=;
        b=DFrHsGoeJ7v3oOgSESVXgmFw3Q3zutj6GNKIhH7QVYHEoLXTYVPZ5s6H4JmY2Wq9yd
         A3XnNnU2emGpnWS3YN0bMALoxg0QB44i65z/oKdVfnesdKEfUD+EwbwWL8InRNhOjnKm
         nTbAQw9idBi/O9/XvBFRrkO/yyicr86WAKDjY7x8qIwZiHPv6UkNXATk6wg6yNyTtDvp
         umUJ0QUFHfemH8c76kYWc0CMRBCDg711xRRR3rwbPg9ujU9pWG1c6PWnMPKhzJEehQNL
         oAleuVlKwILMoOVHtMDfC8ygN2ANgGOiJKU+LDU8r77gtbJEFUo0G4axsSwJOI/r1Z/8
         CAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775786426; x=1776391226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bovVPq2Hy5sXrftDQTh1EgPcGL6nK3K2wa+9gcYZYpk=;
        b=Be4GkjjbcDjvrx3fQCIo+UdxKM2+19+aRyDpoNRoH3HkObMkT1HDkrpJrjOjaRM6CG
         slJJ3AWz6idDw0Roon/wSVkwZCXpp3vFbvI3bkhxH5Xbw8GhWBfpFS/7glWjR5jzr5El
         KtTwyJu8X6LYlR6ki6RXpqINNRaLRAh9Iz7r77TP0RVX9Nkp2VKUAuJ4ydEUl3U/9PSg
         v8va/HVvmC0sU7RGeVySrAGnkNOzxrW+Vq36wShNeIiGfh07P9CBh5phRVrmGYRywURy
         +GDg5DJHHLn7WqeivpmZX0keBHd5Tau/sU12nMlLQ9J7sgGloyzA8quX9h9cvsKAzeoI
         wkcw==
X-Forwarded-Encrypted: i=1; AJvYcCUUIs9VtMBBApdkt9ljv0vcQNsJIuZL3C3nAsaA76tiM8KjBUyAbIai5TBA8Rq759YNb5uUL3gykuZs@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHXZoSoxt8r+195EP+Yzu30tMhqigCo32e+lT+RKs3aue8Jjp
	SYuP3kdUKAPrT2B64DA0xRjnwLze5OWyDWl4Wv9kMmyi/z+3cpp5aGgJ
X-Gm-Gg: AeBDiet9wYaF+ISOblgKJuxG/duJQ0MEgp1SdLuZ/LklkR/vuqJugGui8eCvh8i89qK
	fMEDKNu2U7y9E5qYLeUT3ImaDStAUMfzw3F4rm5S/dJG41fodz/sA/SpKrtao+9wPO64OLKJGWx
	uEqPii6bUa8HBusccsW1wWuqQK5zHdvYle/Y2QPCqqopyFKzhKpauBd0wMJlyft4mm5VMKQV4yG
	Y19JtD4eoYARJR7bRmiVoDDoEFb13sQL1bt5QItW1HjTwGFkMaMWtFyAdSFWlhuiGlWyMYAfCzq
	XlInFTd2iRWiQReH0zjsvhdNGsRqfKz9ZlrOKj7CGSNrJtxsemRRgOVwfI4Wm0hU/nJe3HWtsL4
	oiKG4jC3g7d9p3u+CKoLCdjs91h6zGyKSOxye5uk9rUBUJ+0Ol5/624opH/Ay+M0hj55fiqnt5e
	oS0bNnmH7R5EXDg1WVJMP0QUbspleSklfOfVWV4nWdsepbNF+PuUIrK5bzmoneheP5rjsJUhtoz
	qTaoWv/qrRXY0AJQGAjEMO1oLjpVtEd/VREd0ufp/vQDwbc
X-Received: by 2002:a05:600c:a413:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488d67f39admr9380185e9.11.1775786426068;
        Thu, 09 Apr 2026 19:00:26 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d703c1sm9427005e9.3.2026.04.09.19.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 19:00:25 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: cjubran@nvidia.com
Cc: leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	prathameshdeshpande7@gmail.com,
	richardcochran@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH v2] net/mlx5: Fix OOB access and stack information leak in
Date: Fri, 10 Apr 2026 03:00:25 +0100
Message-ID: <20260410020025.7386-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3a238d0c-4ec1-432d-995a-19d7db3e310e@nvidia.com>
References: <3a238d0c-4ec1-432d-995a-19d7db3e310e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-19203-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB9743D1440
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 17:16 +0300, Carolina Jubran wrote:
> pin is defined as u8 in struct mlx5_eqe_pps, so pin < 0 is dead code.
> 
> As for the upper bound: in order to receive a PPS event on a pin, the 
> user must first configure it via mlx5_ptp_enable, which already 
> validates the index (rq->extts.index >= clock->ptp_info.n_pins returns 
> -EINVAL) and since the mtpps register only defines capabilities for 8 
> pins, so n_pins cannot exceed MAX_PIN_NUM.
> 
> Maybe wrap it with WARN_ON_ONCE instead of silently returning, so if 
> future hardware adds support for more pins we would notice rather than 
> silently dropping events.

Hi Carolina,

Thanks for the feedback. I've removed the redundant pin < 0 check and 
implemented the WARN_ON_ONCE for the upper bound as suggested.

I just submitted a v3 as a fresh thread with these changes and a fix 
for the union corruption bug.

Thanks,
Prathamesh


