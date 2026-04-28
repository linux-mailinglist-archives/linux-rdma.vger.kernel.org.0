Return-Path: <linux-rdma+bounces-19716-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOjkC6858WkmewEAu9opvQ
	(envelope-from <linux-rdma+bounces-19716-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:50:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9CA48CD58
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7B05302D132
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18757382F0D;
	Tue, 28 Apr 2026 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaMwRH+a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0037E319
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416591; cv=none; b=hHTYZzPWn4C/+NjwGp4GuG96gcCdaD+58LDcnIse+BQfBGZ0uXU0yLS+KfEUPRVKOnq5SodmnWSWkr1RHbX1yElFb3eJpKoAwj7IkywHyU+LlEpONvckYri3WXkmTNt2JmfP6lNSV2yUmPUCHWkeyN1uDAC6BjXrBwgbPwy/8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416591; c=relaxed/simple;
	bh=OQEv3vECksF1yg5m1J9iB4Qygwv4grU+j2uR7n6iAuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImXHU9/5+vbZPDU03eF3EbYNdlq18oBnVkA9YVeqXtkqKFRwbLvy4fwfahWqiea/3UobDcxPfQqNgqQXQUXTb7l1miwiDjIg1/4iAsClnM9u9ikenqUbYPY4FexoorjmnnrwTxnLEM8km6b9l4wrqzYKkDrRRIj9dHCgVhUMiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaMwRH+a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so107226915e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416589; x=1778021389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQEv3vECksF1yg5m1J9iB4Qygwv4grU+j2uR7n6iAuE=;
        b=BaMwRH+aHymVnwGfm1l/wIKQDUlKGNyIngtdKBwfbP0TngQI6th+iLD2482rG7jE6r
         2Z5FwF4Qo3Unt1DV4qDiuMzQTgIKNfdd8Ad0cVrMkmmqyJqNVb4FjWnOvw9O5RwAJNcK
         73nzfljYcFegUE2LZ9RpXPhnQ4WXQCoq4r7t8YBNpd3ORFHfeiJNb8OAkuWdPpbPd6I1
         LacDMnI99MWml/HvLsAdw8r0QqTWPVL2Is6VATym4C80MbAu+rlIqLp6y5Pp+l5s+I18
         hL49d5wsG0k+qXhG9xvc7IN8/YwXf+fZp3MJtr9NKQEQvvNtpfYO8RM8ioeYRPYpmwyf
         8AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416589; x=1778021389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQEv3vECksF1yg5m1J9iB4Qygwv4grU+j2uR7n6iAuE=;
        b=SiKkI/V3TARbhVaBNfxmoFhwMEvVjVEpWr2Sa6Wo+AMIpJWmaVb+LpX2ly6F88apKF
         Wi12xToaWU4DnCqxHti7q3wmlGXS98v/s9ooofFASwNwxuwR0JuT6pqNOy2vYs2k3VPz
         O5n8XB6IPzrgtUrFUbkPkz17eq36PUUMURNjx+vRLwJnwfq3EiqrtZxZ+KF/Hp84UArK
         w59f8CXZGmn1+1Y5A0FTYIiGDLN6glDm5/szRPWcpmTKjIzJaz0GemIj0y6FhjGOo+Os
         bYItppponxByibKdA4baahUyWxXZa4UsPP+XB83DD9bbWnkY/F6fz5b/JujPAdD+Znbp
         8qiw==
X-Forwarded-Encrypted: i=1; AFNElJ9ifM5cZYgOykW8GpdrNPkDqa9M6nIA1S62jA3NnHDIoLzyGAsHG0mtiaw77Op12OjkMkvIuc5gugq8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfs3yK8NL1layGzwIGpzwIDCsn1m2JjBkxPROQp7MTI9TUXR2H
	8id3JfYlEqgQPkotwULdYeUsbM5rcocOGBpsPh1TL+jXBTxHfrwqpcN0
X-Gm-Gg: AeBDievMPAx7C1hEi7qiDWERty3+yMblZvduSixZKRn/oEGLWj1TZhuqMo2+IQeLamH
	Z6l4IzT9HRU8EKNTmFVFz+/vaAkLHjdv8xd/0rHnnrQogSXE1JUvx/aZolikGmQpSVTZTrliGdd
	ITN3PM113UGJvQzJDLrxyeziquFnCrQ0FznK52YhRyqKN1MPLnn+/Ku8c1PKqeiFKnecG1yYi/o
	Hcng7LiljcfPWufk89QjScvszTZcOmphjRXRJdePIkgZg0qsquQxbBl2Dj84NcjpngU81r6WtGh
	sPo60+bGxeapqDDoAPmmJlm9/4FWnFy33sacHOHrzhRKSiQHZx2lwEFxuJmEromqYVkgcbx2CWj
	VGL6FCVA5eGu3u6vNjCZ5mgtWWxWUvZoDX0pn5RvE4Rbdd92Fw4MzzNmApin+8evBg7PiPi3At7
	VEGkD/T3gHBQZrcTJfRH/Wk0Nn4ZCNzcqntUDuna/XCdN3u8h16b7g2ifXrfZahoBc/i72B2xws
	Houf6uhCBxvtrHuabjV6454bcwPIPXf/gE1Uu2wGQ==
X-Received: by 2002:a05:6000:200e:b0:43f:dd94:3c30 with SMTP id ffacd0b85a97d-44648b51105mr9146088f8f.14.1777416588909;
        Tue, 28 Apr 2026 15:49:48 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216ed6sm1276715f8f.16.2026.04.28.15.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:49:48 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: yishaih@nvidia.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	prathameshdeshpande7@gmail.com
Subject: Re: [PATCH rdma v1] RDMA/mlx5: Fix devx subscribe-event unwind NULL dereference
Date: Tue, 28 Apr 2026 23:49:27 +0100
Message-ID: <20260428224932.37778-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4cdbb076-59c8-4ed8-b182-2ec644fd97e8@nvidia.com>
References: <4cdbb076-59c8-4ed8-b182-2ec644fd97e8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F9CA48CD58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19716-lists,linux-rdma=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 28 Apr 2026 17:55:22 +0300, Yishai Hadas wrote:
> Can you please come with V2 while addressing it ?

Thanks for the feedback, Yishai. I have sent v2 which addresses these points.

