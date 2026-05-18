Return-Path: <linux-rdma+bounces-20876-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN9ICtClCmpy4wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20876-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:38:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A665665A6
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 07:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7321232C8E10
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 05:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8613A380C;
	Mon, 18 May 2026 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="NSoOpmdf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260343A1693
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779082002; cv=pass; b=piNJS+jQ74O9RDVst4pgU7Bjh/SPLZz5hH0n23u8h6wg75VctnEEM0Fg8i8OKOw0pb6PZmfyI0LoLAayXu4/ag96wVEcUs4D9zS9oUCk1xQNGQWSoTNXRkjO8MSSn/Y/j+7PGD+51A61wFPVbrR5rpemJUWW2iRxeulkG5pXavk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779082002; c=relaxed/simple;
	bh=6mld/fwCl0781+nplbcVK5Q+Atqveim/XuEkZHQqRYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSsZAYQM/fNB+QQVeTobY16Lr5Psq5qAcf9o7Q42pVju9lC1twZuwl13XDNIcxqj7zMCmL9idemNT78QyDcVRzbj0soNnjQ6zLZ9Rw5sMvejyUbYIVEF1lDKz1+zBA/lH5xTxSl4ZcBC4zvUu5qpEOQ9nOGMiU7Un7e53hhFZIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NSoOpmdf; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so666145b3a.2
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 22:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779081992; cv=none;
        d=google.com; s=arc-20240605;
        b=jlFoZSwfBpvSCL9q+H+gk7VZjnPa+BSMiht79+gEpt4i2YSOvm6kyVPggyH/p19bto
         1v+iBSdH5xNHbYIlsw7EpbQOfIwcA8Skz0faOFu5J1uydhES3RJmWn6KT48r6/VFijtc
         GCyFcPFEzeUUn7dA4+xDRLNVaZOy0+TTEcB2Gb3Xvw0kz17Gf7+RxsI8pFOH4KG7FVaI
         H5biGpxNMQ01HG3Zgh5eqsHWSSQP9eSSawyeDM5AsveeSGfLE8rXZZ7/gNwxslgpzAAD
         e/zryzfFmvgn9Q5X1UzKKuatUO7wn0eWrSkpThileVRob7qA/0yHazW4blhRHqhWS3lv
         Kt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        fh=yDvfNWvXQx2YaT9wKzmXNkd9tHg0YKSmsPgSCMK4qfY=;
        b=Z55a/jgTzOVwKIk0Kk/LFZILQ+G2b8boE9XC8ZjXUF75hMhVhTroLYoWsWc9/6KjZW
         PBwuagErEV6IkLsHvk+drCdI2x5ewZioo55HPgUD2twWMo3HQlUI4LDE+PP46f+Kdsqb
         bt2Z5+cyIbrto+Wu5EkB9bcOuho62TLe+FKqtos7mbKgbLznzLuzZh5yw/bKv5CtB1SC
         xBU2LfNMUO+VgVHFQ4r1yaUxHbDTDG9+OxNWePReiAYX/nT1L3kkJLnk5WHIkEoYdYCp
         kEf6Aucx3hWA5IGin0ux6U0uIgiQ6x5QfJqtvpRzY7Vybe+Dnvjyd3y5YweYVfwWD+Vv
         e/tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1779081992; x=1779686792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        b=NSoOpmdfwayFqmHQKPsw/9vrUhwTmX9yxO/FPGTUQApyXhQNoGQ73AqSFIAYn9GMoA
         LVG5BV/FsxtaHQvRITGnZWqMoaKlvHsMotPk1VB9XhyIyQC9daAR3OxTbcTSSwkC7Fyw
         DYDkjttYMbTWlvq21vGa0Sjp4oYbIFTS+5Qinbaxc78yGaLwMpZ/HhwmM0fpr5MTe5AY
         1eQp1mYvGfYTsrnhpsP7C6fp9vgo2t9tYOoBsyypTsL44uwl9tcNYmSmKg8QwY7lpcN/
         A0PuClruV7Uz4omIeeCPaMpCp5Ps85LqcMcmyU4vT6+vxEhmJv9RF4j59AjB6Eb7hmZD
         uhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779081992; x=1779686792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        b=Fc8bLkNxjPZAGjNngaMFLiJRmqDGbL3g9kpkZNZZlzDj4uftIGRIJjD/qES6WH3Idj
         CFHr37LqxE/MzYRXr8Sd4+o2teOOq9Gp69bO9ia8rycFgx2YPVa47TVrYTM6hpsq/LYv
         HGUXwLE8OD1wipXnsaIi2SyfCe+VWfzycEatj3ESseVuQVG9l7a/9UwUx/Au5E66bK7P
         5Gw1o2/iimxa4MPcEZWuoTD8V8JFtcm58TVN//mRnqweHdE1HuDNqKzWtIATjupZ5/wg
         /IPZH9HHzpWZvdFQBvqBLTTkokw7hhe8G+kWWCSLjFP6hQQVZ2/3VWel+NbDI0p+iZcr
         bzeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NUz8d05YYxmPUWlxtYjMGmZqNG2kviCOo9MBBeDUue8/wVSqLfZMsczqs8cET+mbiljOsp0jTj4L6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EM2j1rmmeTeQDJgpIewZa0I4+nkF1LTVpJaMtqpmVRjLiMJt
	ICK+pT5ao3mJzFu5liq+iWPXQrhy93rAAq+78/G0Z5Nh9RshvoK//DmxFD47Gwb2OVaBZwEbPE/
	2Rw8UKGYd/isCgxQn+xSwJFNqZ2vYvdnPT6VuWRmv
X-Gm-Gg: Acq92OHh1hi2AvLz8AzPazNvTcAJ0QEmse49ZANrBWUqxm52cn9ASwUdsuofRePxUSi
	FojYrpMmXTKeqeOZOqaoqBIS1EmS35Vlsmmyqktqu4hVCPbsZt0lp97IDJPjm3gXVmaAurkXUc6
	LaUCLGfPGIaFtZbFSAW4DuQ8n1P7yaHhKipTI0j3xvpz39i6FwMHSi4eLhaQ1vpE4MtoPekyyuS
	0Q/9R/b6ZKEXrK23LUW7Im/cbrzkXtXsTGOPDP/99D346AMCDW6qp4nUyN4Bqqeb85OCzRRsOY6
	4atBg1gexgBcJ04KJw==
X-Received: by 2002:a05:6a00:4c19:b0:838:af72:fb35 with SMTP id
 d2e1a72fcca58-83f33c32d51mr13485269b3a.10.1779081992086; Sun, 17 May 2026
 22:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511062138.2839584-1-xmei5@asu.edu> <deb3e868-456c-43a6-886f-9d882d23975f@redhat.com>
 <agW4kfDB5JjpPD-r@linux.alibaba.com>
In-Reply-To: <agW4kfDB5JjpPD-r@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 17 May 2026 22:26:20 -0700
X-Gm-Features: AVHnY4I5pKhATjXOWintNEChLSk7L138mcEGY8bdVrCg4bjT2d8_2rfJtytM1cw
Message-ID: <CAPpSM+Q+pZkKFv97+1R0kYZud6Mjz-v8qMKP+dg4TO=W=LfauA@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
To: dust.li@linux.alibaba.com
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, alibuda@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, ubraun@linux.ibm.com, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 71A665665A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux.alibaba.com,linux.ibm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-20876-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,asu.edu:email,asu.edu:dkim]
X-Rspamd-Action: no action

Thanks for the information. I just got back from a trip, and I'll send
a v2 after checking the UAF issue.

On Thu, May 14, 2026 at 4:57=E2=80=AFAM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2026-05-14 12:19:46, Paolo Abeni wrote:
> >On 5/11/26 8:21 AM, Xiang Mei wrote:
> >> On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
> >> reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
> >> populates V2 entries starting at index 1, so when no V1 device is
> >> selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] =3D=
=3D
> >> NULL and ism_chid[0] =3D=3D 0.
> >>
> >> smc_v2_determine_accepted_chid() then matches the peer's CHID against
> >> the array starting from index 0 using the CHID alone. A malicious
> >> peer replying to a SMC-Dv2-only proposal with d1.chid =3D=3D 0 matches
> >> the empty slot, ini->ism_selected becomes 0, and the subsequent
> >> ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
> >> offsetof(struct smcd_dev, lgr_lock) =3D=3D 0x68:
> >>
> >>   BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
> >>   Write of size 4 at addr 0000000000000068 by task exploit/144
> >>   Call Trace:
> >>    _raw_spin_lock_bh
> >>    smc_conn_create (net/smc/smc_core.c:1997)
> >>    __smc_connect (net/smc/af_smc.c:1447)
> >>    smc_connect (net/smc/af_smc.c:1720)
> >>    __sys_connect
> >>    __x64_sys_connect
> >>    do_syscall_64
> >>
> >> Require ism_dev[i] to be non-NULL before accepting a CHID match.
> >>
> >> Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
> >> Reported-by: Weiming Shi <bestswngs@gmail.com>
> >> Assisted-by: Claude:claude-opus-4-7
> >> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >> ---
> >>  net/smc/af_smc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >> index 185dbed7de5d..12ea3b6dbc64 100644
> >> --- a/net/smc/af_smc.c
> >> +++ b/net/smc/af_smc.c
> >> @@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_ms=
g_accept_confirm *aclc,
> >>      int i;
> >>
> >>      for (i =3D 0; i < ini->ism_offered_cnt + 1; i++) {
> >> -            if (ini->ism_chid[i] =3D=3D ntohs(aclc->d1.chid)) {
> >> +            if (ini->ism_dev[i] &&
> >> +                ini->ism_chid[i] =3D=3D ntohs(aclc->d1.chid)) {
> >>                      ini->ism_selected =3D i;
> >>                      return 0;
> >>              }
> >
> >Patch LGTM, thanks!
> >
> >@smc maintainers, please note that sashiko reviews:
> >
> >https://sashiko.dev/#/patchset/20260511062138.2839584-1-xmei5%40asu.edu
> >
> >pointed to another pre-existing issue in this area you may want to addre=
ss.
> >
> >/P
>
> I agree. Apologies, I overlooked your comments prior to replying to
> Xiang Mei's patch.
>
> Best regards,
> Dust

