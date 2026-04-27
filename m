Return-Path: <linux-rdma+bounces-19571-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMrWJ+nE7mlfxgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19571-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 04:07:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A146C098
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 04:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1062E300CE68
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 02:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BF32E11D2;
	Mon, 27 Apr 2026 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm0wrPeF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CB2D0605
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255649; cv=pass; b=UL1oMPQT9LQRm7SG5m9OAjqLHXMkZorggJZdK/f5DfrcwkkC4wEBihKcUTMCHZrKFxrVb/BZ/Vo82o6SRHZUO1UfnmUXkaXo8bCBjzwZDpGkkLkvOs45ZAORGXl6xYSg22JbJ/HW6aMrrp7JEtd83W19g0QjPoWh7yxzG81OLK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255649; c=relaxed/simple;
	bh=lOZ8mgwQj60s/PZ30yLs17tPHrIMpiV7JXxWHZRBYm4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R4syQK+aFrPG6l5Bs5yZMSeivE0dcvTlozOdpDX255M4OT1X+wgjU7Q6F4SfwWdvM7AW0cu6PNMh16Rzr0bR6tZw9vaktNAa2bcVLFWQy1bd0zPSMgvKWls509//GETYx9e02s2LJ2koTEENKTK92ESvpl2bhFyselnmDhjtWLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm0wrPeF; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7b186dfc1d0so135824747b3.1
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 19:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777255647; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/noBHM62CQG1ugmkfLgXTuGHp73VQufKDg9JakL29MTWPOHuCQBntPgQq1WDBzMrV
         tLEgZWi9+H0rNQBnBKOROa3GseBUfN9dOE33LHkwrVS8IagEFLq4so/nb44OLDg1I77c
         qcbyp9Obs3f2GmLFLSfVXqbtnOpQHriPQJvB7tIaFQvPNXVJO09JAQn+0IL/qmcwKWa1
         +zJoSzrRmo3KuiyMAO6uf/upa78yTm/Sp9VzULlTVLUHJRqAsfZYt5fNfjUZ/6e3gbMu
         6uOpu/0iHdvdKjL2RvQr+Zd494BqswMhQ6b4fq11/ufZVwh8TudV0MWYiMjX6AK0xFrB
         0HnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5QRAM60M7FQyWzpAzP+yy9ZMIOoe2TTzNNomx2JrlZc=;
        fh=Lit4LFiYsXiyptnZNiESHMwJiSS8Ith6zmuXQf1gNcc=;
        b=h0NEWsWANs7PvHkTZmQH/vIIInily+xwFbOKJhZouejXxQuuZIZ19IwRG/UyTbwMlN
         eZfTkStcz8i0QH7/RtdKvLrYXGjzrA5Xig6OauH9qCYCb8r7P5DNNGwC8RmEeqWeH/zV
         ysCkXGYVSd8vuFLKOr5niVnj/HO1e4dq0FKEWSv4QOTkAUpVlr2YVa4yvXeX0hZt/lIy
         gHSLkADYFezU0PBhdw5+q5cK6svmW8sWBB8Q5vkQqaFnhE0B9z0gfoKs0zl5TgHC3Hp9
         29cPA3nAsMooqxkq4Ytj4xIBVZkSsX9atuuhSOsQvxPOc9rKS1Mi7kmnDB42103S7ZPJ
         Ar6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777255647; x=1777860447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5QRAM60M7FQyWzpAzP+yy9ZMIOoe2TTzNNomx2JrlZc=;
        b=Tm0wrPeFvE3M1JdbjSnW1Yy7SV794DMRFltSYoY/YMfHkb/z+0SmHr3CylZm9CB8x/
         Rv7/2AAHlS5Ek/Q7DtbR5+KjvWftLqOlxOql7xfRogLXMUsJkNRBRIFvbFz1K4QAhnjs
         MTHi04gc7LnSJyIbkpXD6lzPwDSW5dCrty0neAxXiIAE/Otm78n7gQQOAfVGS/QeDwfz
         z2fvPVYL6YmSSs5TEfvMfSDQbv1kppBA67cZF/JD5kOrtpONt9k8Sp9FASQbuRPNcuD4
         L286SlrNjUYvbiuNOBNKNG5rhG3rCfwlula6wjoH3zlkPws8Krvl02Pzd5/j7/QGu5iJ
         Shrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777255647; x=1777860447;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QRAM60M7FQyWzpAzP+yy9ZMIOoe2TTzNNomx2JrlZc=;
        b=RtToib9Y5Tcz1iX062enXseb+GcvSmNvNLVbiSKVJA65b2FEIlbUMFKz061KAB9OMg
         EOSdbjoEoOjcM52iuSGwLr/XvG0f2oOnGcb7AsJF9Grx/PuA9gC4rW4yqiQ3XeDLFC82
         X+n9FIsztsk6VBvn03Sqns0oaA7LI+oQeogAWzSMPjHaeg9VGsqNyPXZ9YIF2PY8I5KO
         cYkV0nZrvwCrSWoWYTKy241/3iDVaFB7FoDGpy6uLrPiNUh6XuOOYUePitZaYpEWu14K
         Ga88Gd0j98biZc35Z6Qnq5vrt6CHvkrBIDl3l2CCshKfSz4XmPLeqxy7i5GHYyLZsKaE
         LZnw==
X-Forwarded-Encrypted: i=1; AFNElJ+EFPuAkye0MnLnJe7rz7t61Vi+f8Ruz1//QPkI6D8S4VWVqRSINbiLRSJjQPIyI3Gb2t4xJkHBZX6a@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Pq6ko8coZ4AM+nqVhvzFnLk2qRI/B1kEA39YxqRtPFll/QS+
	xBfptZuiCZ24lHeWfoLEBpa/mj1pXpYldyoXmY+zR+hP1wcar7Eoiq1hCCfXBhFRxyr0rcrfPqK
	nwLRgsX3un8W4GWmcD8VQn5jYvPReNzM=
X-Gm-Gg: AeBDieu3HV3TUR3sMOx1qYqsqfbCBc5GHHfiody2hpLsm8yeDv9tq5J9AyEy374DsZh
	9f0sxWZZ7OVzX1/D4VtoV/XW2WDMjV3rPxBo7GAgve2ySeyTf5yMvzehsb2ubKoVvTSJgRmG8jx
	udj1Dg2pD2ID8LdpJMzjo1A8xpFmGUadH7etu+41ilMWPATdi9Y4NhiC+bhGM006dnO92tFHLM0
	yexpIpelcy6oKZAUyW6MZS1sGVV+nSxN0z95nna8O/a/LbbBQRNn2iWYtiN4hlXj0fD8swQgQUp
	6c84kxpb+ecGrLtYHQ4c
X-Received: by 2002:a05:690c:e3cb:b0:7a2:ce0e:8641 with SMTP id
 00721157ae682-7b9ed4195admr320557307b3.18.1777255647230; Sun, 26 Apr 2026
 19:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Mon, 27 Apr 2026 10:07:16 +0800
X-Gm-Features: AVHnY4LVq3g8RkFr-vwDbp0lR7Xw7F23pwSb-LP4dwusSK120OTyjqceI9TbG_I
Message-ID: <CAGp+u1bdbe_5Xk6icnDcs70Krbr_6M4yXjhs0HVo8T4953wNSQ@mail.gmail.com>
Subject: [bug report] Potential refcounting
To: tariqt@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3F6A146C098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19571-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Dear Linux kernel maintainers,

My research-based static analyzer found a potential
refcounting/atomicity bug within the
'drivers/net/ethernet/mellanox/mlx4' subsystem, more specifically, in
'drivers/net/ethernet/mellanox/mlx4/cq.c'.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
mlx4_cq_tasklet_cb
     --> if (refcount_dec_and_test(&mcq->refcount))
     --> complete(&mcq->free)

T1:
mlx4_cq_completion
    --> cq->comp(cq);
        --> mlx4_add_cq_to_tasklet(struct mlx4_cq *cq)
            --> spin_lock_irqsave(&tasklet_ctx->lock, flags);
            --> refcount_inc(&cq->refcount);
            --> spin_unlock_irqrestore(&tasklet_ctx->lock, flags);

In T1, the refcounting increment on 'cq->refcount)', although within
the protection range of the 'tasklet_ctx->locl', is not synchronized
against T0 because 'refcount_inc()' does not check whether the
refcount has reached zero in T0. This case is potentially problematic
because T0 decrements he 'mcq->refcount' and can enable the
'mlx4_cq_free()' to proceed.

Thank you for your time and consideration.

Best regards,
Ginger

