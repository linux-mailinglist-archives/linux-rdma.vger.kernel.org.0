Return-Path: <linux-rdma+bounces-17730-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNfPEpDXrWl+8AEAu9opvQ
	(envelope-from <linux-rdma+bounces-17730-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 21:09:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5FF232150
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F5C230086A9
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 20:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497153876D0;
	Sun,  8 Mar 2026 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/uAk1WJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3A329E56
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773000586; cv=pass; b=N7kWyljeqW4CLWU4jf8p+SKE7IvQ2h3yJdsNc13zGoG9nLOFjSx83O1Ro8I0e6pvZ6RDpWZT1N42MNhm2PVDmyryJG3Sku2w+tNblat/ELstgzs3h2qxeIp7OE474PztTbVhgyiwS2BQf9QrKndiNje45lNEu+RebYWZ6SZQtxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773000586; c=relaxed/simple;
	bh=4A09aHx0OcSl3350jjdiiToLVF9TkB24Ro1o2DX9+EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdMjOboohOr4t47y1jS/fbHXrjC16sBeg0Cj9rcZ/Ct3TSs6T1sYKpiou35QNYXDNU3bVDMr+U9v3fN40maQx6KDs8Zc1KM0w2/BNd+i42chZNECVCYVU6XdWYLwKS/yTbzk8buJqDJQchhBmgHOsf5dxlJEXMHeEU0XdLTwKhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/uAk1WJ; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b96d7053073so184843966b.1
        for <linux-rdma@vger.kernel.org>; Sun, 08 Mar 2026 13:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773000583; cv=none;
        d=google.com; s=arc-20240605;
        b=dVrgOTJ3hBSep7SzFUt9pg8stkpMa204/PUxwLiqTeUL/LMtPsD2KDKlLKOId0sei8
         0pV/Pz1cOyoJGJ6SYxC+LIiuaDdGif8SX+qjRF5YTMLYAGn29cYfm+zqgqOBuFi7xGZv
         O/HYVFiGDvfIFF0T+HCf/TVr+9cVo6K9sqauyjhTYsQ2h/4LodNhGEMXvkRvNWzxGY9T
         yUgPjyAF699IwSmwUJrA97nTuqGREs4cJbQeDC73SWl2A5JI5Y0y6PUf5IvZZi3Q9nkJ
         t22FozUkiMPeT4RFcIpY9cxQzLx9rLMGIDtt59uAgWDl1Ot1pRtjxTTxSU20AdRpg9/8
         vVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Tycv5FoJZx2dSo/XFPLGOTYrMuBDHqvJ5rkTtVQiz4=;
        fh=E5ysNppEn2He3NW3bpWslo/CX5vy6Bt+6rFNlUv2UKY=;
        b=djS6bi8EzHHFOQEtCXwH/zisL2Uak1qKm6gfb2gDgWQUKrCz6KSUsOCP5JgXMW5/FV
         Oqk5SSd/g/w9DGgIp3uoRJ+Pjp5XldPH2R17HpZ9W09E5YovzqzY+A4zw2VfvLHYCtqP
         xCjTe66kQ1jYIx70ESZhj9giU15syhHSzqFykBw5JF4BxEPGSS/Spx7cbCRXkaJdbhcI
         pVGYDV+GTgNm/H57LPyxa5N/m62lvqhmwNxnk8OCwVA5ILKSM9JkQaOQnag5h/MQBKGe
         Vnn0D0bJJ2W+jkWrdHUGmCSyRRbl/BJhpQxvxTSPFgwdOmecT6XrRRnkLZ9dH3oP/WIr
         +ivA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773000583; x=1773605383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Tycv5FoJZx2dSo/XFPLGOTYrMuBDHqvJ5rkTtVQiz4=;
        b=a/uAk1WJb0SAhTHGpfh+oR7c1EEyPDb38PTTCjVlPg9kunbeVaYeX8DxlCxtU/tN6U
         KAxLu1ifNC0YwXduCRt/dAHtviXRfcG1oucvRLD+ArnvWAglGA44bGUmBrhkRtpq+zK/
         y4505qunb23l4mXly0AWf0uZ0cc5nw19moWQsLubSaY4KtKC1IdlJdCK4k3FTroDEdmv
         E1lHCPfjpW9ou5oupQd6MkcliUpjJZuiIS2gelYnHEusO22/m7hoE0iVQj3jAi9Ahn6A
         FDOUPxYnac8tvMZswrhIBMuh/E1E68lBkYhxGQ4YFC8Bnj6c5Fudv9lgQIqtoDtbb6N4
         MicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773000583; x=1773605383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Tycv5FoJZx2dSo/XFPLGOTYrMuBDHqvJ5rkTtVQiz4=;
        b=H2OnA9Vkq2oQ7xqcgYVl61wGKGCSmWZExGMhuk4F4VZJfHmTiTfupV7VJ2Tg4whYPi
         mA3PkeQ2BDFTbnTlAflHUUGOt9nAMeGqFfeObIlwlS39s8GvERPSZSW598z2onfUL1Qr
         kTK4GTX8xwOpkyLNK0Ljqk8UebXCtKT+gdC3yhTrSCSgm4JFb2Pvkhxt3UmFcrRg2gLx
         JqC0jeq0MBFpslSyk+v5e66BhR/xmuxPeeqZ2Tlts3oFvfNiNzEpmB1e2McQ20cOcjqB
         LnHVIxx+WkBgkmVPQPPYk4vy3Rk/Ti+M4a/zO0hQo1BT3BbJidinhZxPbKji7DQNVAs2
         nH8Q==
X-Gm-Message-State: AOJu0YyeBjeJthvnttg6fGozQzyvyBfh7uudJPlxWPswSH3sSraNqMKq
	YM4n0oyzrcLoLVDOCSYaZZ5BMXDintgogib2cfMsptZA2RFNdpRWWwSDxeEH66wMfQpJ9EK+fPH
	SUmbqQMClhEArUQUzLI/GnPu/0ui8JJ/8uJI4
X-Gm-Gg: ATEYQzzbdiWgmEzn4iRzdhans2Ch/4S/Rqf8IKTF8AbbaS/E27oElyYHyqGRco1nAw6
	oIVzQguGQ0HAakD+38UsZ0PgCeYWelrMw5kmbgrD2DnW6TDQREFqHWeGdLBHsj36ghvNDHM/TmS
	Yv1vJ6nGlzAJemISGT2VwiMYeYKBrwEuOEbqLThe/5FNDFVRHi4W6DBk0UledS+xjamT6f+ZGLN
	UHNhnMGamYfy+Zopr7qLKEYo6r6sutDSAp4NUBN1BlRpVn/eA85uBggdq+Qsz5NtERdewXW6Z0I
	gz5Cq5oFWyDmUX8pZUrORL+UiJng2TVYY+QZZ1YxdGVOfhkho1v2KZzJLQqLrmVBvRipYAjboEt
	HtFVNszmheRlxC+Gz
X-Received: by 2002:a17:907:7f87:b0:b96:eae4:e49 with SMTP id
 a640c23a62f3a-b96eae41258mr142013966b.6.1773000582790; Sun, 08 Mar 2026
 13:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308031957.90900-1-rosenp@gmail.com> <20260308155955.GQ12611@unreal>
In-Reply-To: <20260308155955.GQ12611@unreal>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 8 Mar 2026 13:09:31 -0700
X-Gm-Features: AaiRm51OTQiCpQ6fsleTOq7l6ej-X16rffbIJn9LEa0TMIE19Ts-Gq_TErXo2bk
Message-ID: <CAKxU2N_3dmBQPyD84GkyecxO=+5mQVVmSgY0jfGSugFtXvZ4UQ@mail.gmail.com>
Subject: Re: [PATCH] IB/hfi1: kzalloc to kzalloc_flex
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, linux-hardening@vger.kernel.org, 
	gustavoars@kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4D5FF232150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17730-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.876];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 9:00=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Sat, Mar 07, 2026 at 07:19:56PM -0800, Rosen Penev wrote:
> > Combine kzalloc and kcalloc with a flexible array member. Avoids having
> > to free separately.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/infiniband/hw/hfi1/user_exp_rcv.c | 10 +---------
> >  drivers/infiniband/hw/hfi1/user_exp_rcv.h |  2 +-
> >  2 files changed, 2 insertions(+), 10 deletions(-)
>
> This patch needs to be rebased to latest rdma-next, due to the conflict
> with already merged 94ff7c59cdfd ("RDMA: Complete k[z|m|c]alloc-to-k[z|m]=
alloc_obj conversion").
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/=
?id=3D94ff7c59cdfd

Notice: this object is not reachable from any branch.

I'll take your word for it and rebase based on that.
>
> Thanks

