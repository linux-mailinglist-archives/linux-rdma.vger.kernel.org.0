Return-Path: <linux-rdma+bounces-19207-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDKLGj3l2GnHjAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19207-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 13:55:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CE33D66ED
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 13:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D93830561C2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0613BC684;
	Fri, 10 Apr 2026 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa6KAugo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F430BF5C
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821988; cv=pass; b=e4BrT9YU9ynfSM4XDxYnfRuydBDpGdWyUx3R2TimvnZw/S8bESdp/gVs6DRH4kR6g3hFzWa0LdyOE/mRQ+FE+yyfSO3z+wEQ39H5uzEb6c3k9Pv3q7Af8Vl2uroxv3xMESTAG099uv6zySSTbwuSE14GoFpZyQVIgVSF5Co9gBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821988; c=relaxed/simple;
	bh=w5oaDzsKKx0oq8rgJvbelTx+A473kYnf5G9L0c8dWPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGkDUWKpno3BsHTDD2W2sMus4ye35hzbAG9YIorjkfSZ99ExsisABrjUaOKiZlgJZbRLXBIfuYX/lmdulBmuMYvSSxBS1XmRr/wmH71OjxPvnHFVPRRretcLqRdCqkcNThofrc+iU6hQ7Ok6ZRcvvD5p1ELRcSTny8+MR1nKlEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa6KAugo; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7a17bc5745eso19737327b3.1
        for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 04:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775821986; cv=none;
        d=google.com; s=arc-20240605;
        b=R1ZptbqlTmiXVCkvRhobmcDfSnX3/t2mmbH1iWiPJilXtZdHIiJFUpv3A4l/KZCaCS
         aCbwy1cW9TFhw3rGn1GiIoxsunQaKFmLt0HeM1u/Dt8qFFfxU1/XwfjJ0x0a93BpLGWL
         dw6VFZHapbDCEt48ZCDHg0ezAP7uu2JXBt+uBlOzwsN6JejvvWvUq4Rv8dnbe/E0XxBG
         8tLYZKZfF48Nq1CBVhhbFl186QhJWHomyfkCig2F6dMueWhlmdJt/jXy0X1AYTGf+5bi
         31+6y/C9AWFAWaJX95moJtbcbiXJCImEiCPW4ey7jktZs5bmxGmuLHIJcVV43/ZTw4fb
         2Pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ss8cJUMQIxtdwnxHwbUYEOsfeWTlnhxmBIcCMYBw4Y0=;
        fh=rC+MSupMjoHk8mdBLtUvuRnDVj+MLJyTRfE9eB39XEE=;
        b=cWGk/O+TSdGEOND68qr5Z7nELRCeTGdTZdNjZwuw4BnvedFXsckjswZw1Xa41gdmIr
         yD/XHUpQdGinUTqjW9XGdSobpZc9aGM/A3FTsYIVB9Oti9F608q4H8jZPnMtKm/eeO62
         N3N+qZtdMWpLiV726fHtRa7RIaOBJJ5PQoCTPjHMcewTfFA5zy50g6teRgntMFdsGqyD
         gbvvEwjwHXkvUFwP22mQkSrhzRez0bQCXd8FsU6ie8QRngwVVAVu7qDsJq9HRqOUJrUq
         MqEPIjORtiSJYsWXqeCOvG32hBTgxkBGOIa35ALZHY78sJunWxgE10scH2FkXMfLw7Lo
         /wzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775821986; x=1776426786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss8cJUMQIxtdwnxHwbUYEOsfeWTlnhxmBIcCMYBw4Y0=;
        b=aa6KAugoKI4XDcdvjxYfJ5WiWI3vGEsqPKu+v367CLdhB9o7c16LtmI9yD7nSyMrRi
         RM4XL9mhvQSZspbSZ8UOJt2H0+d5s8qY8+OIAiv9r9KeCadFYh4DLPpmUTWrXlgUnRWP
         xFhlDYeACq7FuaQVvvD66b+q0zYmw+qNuB6TuO0oOHANe4x7gz51mGPXq5pTkBHHRZOa
         X4cpFmavDCUNtxX5RA8D7Lr/5yS4JTrxViEUUo2AquBYj1vSy391tieBgk3+o3hrPtCT
         WOSGhr/zecxCyMBZN4H01cI2iVrxRk0C3aprDlpiTmGsmnWTlp2PL0t2lLnHRumSw2wI
         7fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775821986; x=1776426786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ss8cJUMQIxtdwnxHwbUYEOsfeWTlnhxmBIcCMYBw4Y0=;
        b=d5M0c9Av+z9z81e62h8vOkI07HoZ85HrbaTEE6l5vsEvGEmIPobZLFbNpSgbjvZmoN
         e7i+JhFHrDAqqcAD+RhOU6Oe4sCgWMc4nttnqwkTMpVVl1F36RZpemi7tFqZUj9NyyBY
         gspQqaU2sK9dex1pN+zzSbir4KBruWRq/OUam9zJnqbmsPvw+rSAG5ESrgG6kLPK15Nd
         msF5FymkrfwCx1WZZUftAeeV5VvorlUWYaedz0bthDKpigY11kVIEjKNcBklnHhb6kbJ
         /REur6LaqnVFJCSyIvO0mnkdEHDM0MiWf1lyfYoylqflBgLKhCOBBdootj2fT7dnXMnO
         E3zw==
X-Forwarded-Encrypted: i=1; AJvYcCXEpq/+vA3GM0k7ej2L7+ZMevzyjOyOD5bcDoUisMujYFgUlujqw2hIBkPyaZAWUV+PW4yDnEGCs2+3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZkAp92P6xHFCASCzcrxrnVUmeLim7L6I6KibEMGsgns+1Dlw
	qAyK415gSAKC7upGsKhlnvB3oIxFwlzIGrEVkabKWelScgRnqe9TzyLBHVsZB06AaCC/q3ZhuLJ
	TEkh67v5+j5bVnT4fBn9Uiu25cL+kssY=
X-Gm-Gg: AeBDiesWAfnzmZ9oerh6UitcuaaSyVvzxec0z8o9VpJfabnB7c4P28pJ1HGH9xfKXQa
	k/GKfNjbwp5N3U9omsZl8r5i0ZW4p4m7ugXJ02k24TaAAfinhGWkH12W68hr3+AD81J3RKsVOtv
	dKze5B67mBDsQaIBC8dsfz4AkJDeWPPDvNXPmi4hM3YkpZo/bBN3o5ap4dmRsa/ddZFJ0/kJEkl
	b/esfBJTj8bXrV6ZRYWsBs6B1CK6GNEpXhYOeeRkGYYiB7b3oVlPz/Aw4fXa+mWP4E/IcZjy0Zb
	q0IzL7vMDxUEYevAtj7mq2en39Vns1nZhpnj0ISMdCHKcY0Q1qDmk6tNew05iuxUzV2f7r/NauJ
	sjdwfLEs=
X-Received: by 2002:a05:690c:c1cc:b0:7a1:a31a:bfce with SMTP id
 00721157ae682-7af715776famr23319487b3.32.1775821986024; Fri, 10 Apr 2026
 04:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401012810.11876-1-kartikey406@gmail.com>
In-Reply-To: <20260401012810.11876-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 10 Apr 2026 17:22:54 +0530
X-Gm-Features: AQROBzDdA97VZRnDdx785Eeg6dGkTcF6aEOTOlB3TPS8UgHX5Sj9Gb8HU2VfYHI
Message-ID: <CADhLXY4B7zkBQUv1ayicHXuSopy5AG0HrOPuNqcynPzs7R5CxA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/cache: fix invalid-free of flex-array data_vec in release_gid_table
To: jgg@ziepe.ca, leon@kernel.org
Cc: kees@kernel.org, eaujames@ddn.com, parav@nvidia.com, maorg@nvidia.com, 
	rosenp@gmail.com, jiri@resnulli.us, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,ddn.com,nvidia.com,gmail.com,resnulli.us,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19207-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-rdma,4334f9a250019c1b79b4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0CE33D66ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 6:58=E2=80=AFAM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> Commit 74e2711bb2af ("RDMA/core: Use kzalloc_flex for GID table")
> converted alloc_gid_table() to use kzalloc_flex(), which allocates
> the ib_gid_table struct and its trailing data_vec flex array member
> in a single contiguous slab block.
>
> However, release_gid_table() was not updated accordingly and still
> calls kfree(table->data_vec), passing a pointer that points 216 bytes
> into the middle of the slab object rather than its head. This is an
> invalid free which KASAN catches as:
>
>   BUG: KASAN: invalid-free in release_gid_table+0x384/0x470
>
> Since data_vec is now a flex array member of ib_gid_table, it is
> freed implicitly when kfree(table) is called. Remove the redundant
> and invalid kfree(table->data_vec).
>
> Fixes: 74e2711bb2af ("RDMA/core: Use kzalloc_flex for GID table")
> Reported-by: syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4334f9a250019c1b79b4
> Tested-by: syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/infiniband/core/cache.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/ca=
che.c
> index 896486fa6185..647a547e2d7f 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -801,7 +801,6 @@ static void release_gid_table(struct ib_device *devic=
e,
>         }
>
>         mutex_destroy(&table->lock);
> -       kfree(table->data_vec);
>         kfree(table);
>  }
>
> --
> 2.43.0
>

Gentle ping on this patch. Please let me know the status of this patch.

Thanks

Deepanshu Kartikey

