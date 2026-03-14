Return-Path: <linux-rdma+bounces-18160-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPC/CnX0tGmUuwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18160-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 06:39:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7981228BD09
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 06:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53D6D3053BA3
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9672C34EEFA;
	Sat, 14 Mar 2026 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD5+h/RJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94132694E
	for <linux-rdma@vger.kernel.org>; Sat, 14 Mar 2026 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773466734; cv=none; b=KJKzN5fCdYPhw5rLMQ8Lhb2EtFgmtfP3zYfMl/CoQ0r9iujLq5Qxz+naE0i+pz8Ao7Wvr0w+HSlbM9KMURtuA2Q2SXp5qzDYbFxj4vsmoZgWQTxwbsBGpAmO21UQoqKYNKuYJThXu8OcUWIgBo08xZd5vHdVccXMShmEDXm+XTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773466734; c=relaxed/simple;
	bh=mi27E5zL4aFMoE5WqZos4Uu2VPo1BUll8bS96xoJMhA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W0GpXzoqCxoAQDh0IqidVWzPb9SG88tE5GQxWw86W6LfdPt7oXyUbPnR/Y1G8OeXsx+gSsovWfMlBsW9PLm0BZCU1YPkFwNAw4acob7wSLxbbIZGV0U+GwAg0VDHkDqDizWZZWf073QRQ4/AXT+VnbmQleXj8Bi8qURkFwgO7pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD5+h/RJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79868cde1eeso29954777b3.2
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773466732; x=1774071532; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi27E5zL4aFMoE5WqZos4Uu2VPo1BUll8bS96xoJMhA=;
        b=PD5+h/RJFdMf0xzmkwTDTyhzRF+PVvS3h5JBUDg1dobtW+/rgdWfNt0GRVnKtLLpxb
         GD/xEHFUjKLidlaVD2aHgjnKcOEi3QEs77CkqtP/K1B00yc0s4etTJWXHuH8UzkFVhvj
         icN/bn0lLbl3dMOwq2TRqs2oy2S4NDaICjl9J4jEGm1tztVDLV/J4nJtLFoL2bt8Cp6h
         sP/GM9SFLG9cdjJ274k6Dg/VZaEi8Cn0rc6l696RE8bHLmeU1fIdRy75lRJxDQ3iSR9U
         H/nkLwV/Bc9ZJ2tG2coBs+HZFl6tZNMJlwaj8Imp8ZWDJlSAl2XqPP6O/MpVU8HiO7+M
         8veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773466732; x=1774071532;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mi27E5zL4aFMoE5WqZos4Uu2VPo1BUll8bS96xoJMhA=;
        b=dUd2mBX3mAk4J8Dh6V00dUALWm7I9dZ/se2X+esKnoG3L5hQNVFklG90wedQnihRyW
         tmnrTuta5a5D5xR5L6paIyI8CRtZRqmLZ2vtiy28owel80H+7PWRf29LBtO6SEPDdSdz
         clocTvMCoubN/5wDLGRnmACHU3OAmQbdFA1WQuSCAtxXso3NjoQz+Tkh9MB6EQ5GQdQI
         qMhiSnwVr7k3K8ViJjYoTKxwaFqkPoGGfAP1kFvQiaGC20iD6mzf+yrK6XTHXDavbRDc
         LytuOewb6DIM3cUEBRc+SNOZ5KX4f8aOGFnt7vgtdv8aqrzfYT288rrnpPgQemvJ+k89
         LmNw==
X-Forwarded-Encrypted: i=1; AJvYcCVJIfJoOXjU/4xbLr3OPRzxlZWli6xiNK/6K3p50VjpBT/H+z4H1XqZZOIlO2/55P4nBtNw+pJyuc71@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzc4D8AX5M+7QXrVq5oxYi2ao2grxxqcRMwkWYo0KrYgCwp1Lp
	l8qOenpNeyEuoeqIBXKUENenXYgBvedbSC+6TT7b52aEUzqzQzOEoJII
X-Gm-Gg: ATEYQzxlRsPCO4wdasn6OPapP7d9g2VVY2ercApYvsEUWeRcJN4u6Vmfsa0goqVgGh8
	tfHj/Ejs5G8NT2f+IDYRoNJtMHuzpRSL/d00PlFhSOI2ECfNCxYm+GAHvZs3B+SAVK+aC8WJb9k
	eSeygZlxFx1ggEAhVa8ivQgkev+vpz8hOYjkdaOz+g9GUrm9279ocrHumuKjmch5lquSkej+f2e
	n/Uch2Epie9+K7HVnWE7FWlv/UQhNZJOhBRqp9KGpbBnm8N7mWisuV8QzK0G0mmilfClFf/XZrw
	96wnvzZ87s1+QZ9GiDklDWw4GuJtVfM2ikp5RlZTCyhEInDHz7BG5nSl1Ikt08jZVwb7wdGpoS9
	rJy5YVo2CPkJ72rVFT2rxmyTfYIbJR1FLgKRLUtcPJregP6r7+V2oKKr64ou+5XSCMlvsLFMrYx
	RdIsfK9CGZxERLSlkQwftmuLhulfLgpkIjtaWuCPis9bFUf3QBTLdjPUYQ06oISnqocShrv0wPE
	Xq8fGCf0IGVG2SUHtEPDdxiz38dwKf5
X-Received: by 2002:a05:690c:6612:b0:799:1af1:6c69 with SMTP id 00721157ae682-79a1c117e66mr63306677b3.26.1773466732312;
        Fri, 13 Mar 2026 22:38:52 -0700 (PDT)
Received: from localhost ([2601:7c0:c37c:4c00::5585])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917dec625sm58404857b3.4.2026.03.13.22.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 22:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 00:38:25 -0500
Message-Id: <DH29H950UC56.1SCS13IC5SR8K@gmail.com>
Cc: "Leon Romanovsky" <leon@kernel.org>, "Gal Pressman"
 <gal.pressman@linux.dev>, "Yossi Leybovich" <sleybo@amazon.com>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, "Yonatan Nachum" <ynachum@amazon.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/efa: Fix possible deadlock
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, "Michael Margolin"
 <mrgolin@amazon.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-rdma@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260314045730.1143862-1-ethantidmore06@gmail.com>
In-Reply-To: <20260314045730.1143862-1-ethantidmore06@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18160-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amazon.com,ziepe.ca,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 7981228BD09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri Mar 13, 2026 at 11:57 PM CDT, Ethan Tidmore wrote:
> In the error path for efa_com_alloc_comp_ctx() the lock assigned to
> &aq->avail_cmds is not released.
>
> Add release for &aq->avail_cmds in efa_com_alloc_comp_ctx() error path.

Detected by Smatch:
drivers/infiniband/hw/efa/efa_com.c:662 efa_com_cmd_exec() warn:
inconsistent returns '&aq->avail_cmds'

>
> Fixes: ef3b06742c8a2 ("RDMA/efa: Fix use of completion ctx after free")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---

Forgot to add the Smatch warning, if this version is good please add
this to the commit message.

Thanks,

ET

