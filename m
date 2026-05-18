Return-Path: <linux-rdma+bounces-20925-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDpiB2dNC2o7FQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20925-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 19:33:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CD571A81
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 19:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 873F83016D3C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB98C409DE0;
	Mon, 18 May 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCw7nHV/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F02367D9
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125604; cv=pass; b=dGH03/brFr+dibJgUmo4C/yy6PZIhBqAI3Zb2sjIVo5y1r1F99UFsHGAznARPO/913NSBjbfW0exe3jXIMWcR0fKgFhDCQ3y5PA+ZRwxsuGio0qCro6aikms+tB7ax5B5CNN5Ee9sJW5NFvE+5F8WuxbnPvIOjpR3ZdRtDLRq9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125604; c=relaxed/simple;
	bh=LsTXmbjvYgS59kR0+//k+OpD4YfD3cLwvD1nVtqBRq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVggijPci5SIrFdkm42Q2cyXK0mY1hx6m9dXWEkbelJ/4AnvUfbAPigDg6wFP+9j7rza0UFyKD98fMnE7BaY5jTZkWl6+GDX9JRj6n427A4zRTfpqLgEKks+M7SIV5+cj/Gj70Gf+hHSevfI8znUMbN9mlBL9ZPwclNI8RP51Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCw7nHV/; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso35027925e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 10:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125601; cv=none;
        d=google.com; s=arc-20240605;
        b=RPi6Zi4TB5uSpMNpHGTuvKO+TlwYd/yHQzW3YX2QEF9OiAG2cozHJgYLvlkqn6v1Pm
         V9uUqauk+6KwfydoyQ8ejCuirKyHiIL3QPMRzvMRd6P+rXPYP8tvRxeDUiQNLKEBmeRm
         Wo+tKuykAdRcnmqEIYQy0qiVIdbLH1Zd7tMBt536D+gPQt8TbwOuoU4mGXR+d3treB90
         cD7rEIM2FPOtromDn/k5suXSoE/7j9+uQYvfSnjaF43mtzeB//sJR55yK7zTWICQjaHC
         wkrdkMikchFe7zPFEONkdV9FYpfSHFE9/orGbnUON9yTV2SWX8q30QTD+O2KAiSY3Idv
         fyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rjaJpY0MkhhIhfyKnhPGyfPqWCIkOVqOIDgQ5xJDdC4=;
        fh=IYxgtUAHwwvy5nppKUSzvPSayyvvmnxH5FWIic6VsyQ=;
        b=YfyjM8j2zZ1Te8/MFGX/afAUgXMcsL8HpkUEqQ2NcmtIcWmDbiotGxDTG9K0pCuz/q
         WkXfQkq9p3doZzma/P93H2osbOcFBDFaQkkAAuDZqWTmw50vVFQzixT3EZydCrkVSikf
         m9ckeIcadn8vQNZWPREn4yRQ/iyihwduDqHliGZ1v/2sqHxQ9Lw0BNuXk1yqckfRkwjg
         ceIN7HS6m8zQzQU5l+KYXh/IfnWiFky+Nhd6Egdjk974zjUvj/JM/4ryfqpm+FsMKI2R
         1vTx1IT1EMs8ffPzJP+vpWMjm4g9pLMI7SJLW+5EP+Rrx/TwWCvk80EfYCbOzUIiHF7+
         x+4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125601; x=1779730401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjaJpY0MkhhIhfyKnhPGyfPqWCIkOVqOIDgQ5xJDdC4=;
        b=gCw7nHV/SrpLXpjrtGT7ijQ45U2K4LGaLe9T0ol6f64h4wxTHnTjvJ8nLs7ZaM5V7V
         iZN5HMy55AkwGxFkPAW5uLUNxlIIlE89MiMpli8c/Wrhe2tsBRxpTqlcU5WDMZX+k+hJ
         6UEl6u5VEnRsZ13bPy+Y8BfnxrVCK/14NS60OfwEd3W+u2m8apYOJoCMuh8QgYwCj59Q
         wsmejvVrsgbIv3NBK7Y1naWM/17s8mfvKc20HlPhYBZo8dIW4fBNhG8E8tqIQCiB7Ljr
         IL7XP9PukV2UJ74XVI4rL/IefYfjflKvwG49yl+/fhNXtIj4I6tn/fkf4fzNUExGDi/A
         xWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125601; x=1779730401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjaJpY0MkhhIhfyKnhPGyfPqWCIkOVqOIDgQ5xJDdC4=;
        b=EyI3fuZRYE3zmJKKHjHOzya9dj0xIfuVJdc4dM8MPVeMQWBJflhP/kRmeE9HH66zhk
         /aX/MGkbygwA8kQC5Ofd6YrHyBytUdopECD5uqeaCsj8Ua8jUchQJXbOcHNFQr+G+lvS
         poa5MGgOTKhDUfDHB6TRLcOtAiyBx5INtezTBE93sTu8cFmd+5F7LtwOe2ecEwTvN1eM
         A2+g1/06OrV7k49gLbQmnXDJagAwtaDyWKOuFk06VxTFWrRAoZKso3d9hWOhQFkWwP0T
         E5NLDLBOfcPLPJi0w+eqx4HDWA7tWukhGgF87sojSzxJ1qkIN4Tox5DNJ04dc7pv9L0k
         ZRKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dyLzYQ/KJA13f48dPv7inWoaGqBkJGQdDr3jiEgmg4OZ8JCKk48cPfIcKME9ezbSpqo821gdtzTvi@vger.kernel.org
X-Gm-Message-State: AOJu0YxxeBF8KXWJacv29zSRdIeMb/dGoXz1Qm6Pt2+I9i45HFEhj37M
	6KttNXDvw2sWviAJdNOAvFAGcTzum9687nu+k3ZcWfO3PtwaOlFfBXD9VCmcnv6p+UU3TqB35Qa
	l2UX9hyW4o/tKxC6fsbneN6ZMuzipF6o=
X-Gm-Gg: Acq92OGlr8yQ3lLG8TubwijvfWpXUjWO/13+6LjBJM8RuhAMifkBlY8t0p1WRvBz5ne
	7sKLYI3enM3TE2dxlLLj35i7otELZRA2iAnEuNihr/XyU/J6JHlohzxDeMeRqw9f6JklckbmUbN
	2Njm8S/lODwCKp+478UOtC/HuvjpyNUfkS5LDhL2pkAiI9hKmEr4XeoiOtgLbx3Imkhnb1fok10
	+I1lPuzawbhzzRRlXdjG1tsYcBiVZ0r1/1t4jFh593SywKKs6lsWcNAe6419Qlfg9O+whULDKW3
	F/LoQUzn4xilhr5+zE4=
X-Received: by 2002:a05:600c:138f:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-48ff4f4f44dmr173342185e9.14.1779125601353; Mon, 18 May 2026
 10:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513143904.2497520-1-maoyi.xie@ntu.edu.sg> <20260518101531.473574-2-horms@kernel.org>
In-Reply-To: <20260518101531.473574-2-horms@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 19 May 2026 01:33:09 +0800
X-Gm-Features: AVHnY4Ih3y5-5cQ8sTAJKBUKOLhhbW1c_MNepuEQbTw6xT_7_QZ0g98ywqm9uVI
Message-ID: <CAHPEe=GkDxnVxkOfO4KRt8Z8V46xVSYisN6QrAFA-yr_V5jB0A@mail.gmail.com>
Subject: Re: [PATCH net v4] rds: filter RDS_INFO_* getsockopt by caller's netns
To: Simon Horman <horms@kernel.org>
Cc: achender@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, praveen.kakkolangara@aumovio.com, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, maoyi.xie@ntu.edu.sg
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20925-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B71CD571A81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

Confirmed. net/rds/bind.c writes rs_bound_addr at lines 123,
138, and 160 without taking rds_sock_lock. The race is real,
and the len=0 path you described reaches the NULL iter->pages.

v5 caps the second pass at cnt in all four handlers
(rds_sock_info, rds6_sock_info, rds_tcp_tc_info,
rds6_tcp_tc_info):

    unsigned int copied = 0;
    list_for_each_entry(rs, &rds_sock_list, rs_item) {
        if (copied >= cnt)
            break;
        if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
            continue;
        if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
            continue;
        ...
        rds_info_copy(iter, &sinfo, sizeof(sinfo));
        copied++;
    }

Sent as v5 in a separate mail.

Thanks,
Maoyi Xie

