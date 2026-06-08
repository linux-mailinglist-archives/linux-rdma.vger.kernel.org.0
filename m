Return-Path: <linux-rdma+bounces-21974-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8QKqKHXSJmpzlAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21974-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:32:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC7657389
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:32:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ionos.com header.s=google header.b=PkntK9BT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21974-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21974-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ionos.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A23D73091EE4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0703D16F4;
	Mon,  8 Jun 2026 14:21:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E73CC33D
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 14:21:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928511; cv=pass; b=GvpXxktiBPysSPDr6oZTepSLXTk1GQnNkKufkIvnt/Q6ydW7XvIeawf1vW6ZlPlvoLp5bnG58ZNUQ9D8biQ1xcJsgqeNwcc4cmNRv8xJH2oYeGx4t5TQc/ot4ypy0/MmFBjFF5fQfCHqsgZ6fKUV6zIKLqWqIwvXqX6oFycb7/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928511; c=relaxed/simple;
	bh=ABDyuZt88D1DGj1lF3A1JGwQyZo+azgwJ6L0pQsbFXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2IC1ksz5aQzujceM6AvZgSzvqywl/+tKA4/x8+Cia487jAGHB2xg15VYYwfKpOfIOWb6Q9OuqaTCeFXvqdCX1E1s/M/EUKBs5HdbrIQxO6Z5GhMXfdVA17959OGzcPTulcnxgBDlzNkGLKsM5ADvvlElhmrrzU/JJzbLzu6SwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PkntK9BT; arc=pass smtp.client-ip=209.85.208.173
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-396775c26f9so39532561fa.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jun 2026 07:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780928507; cv=none;
        d=google.com; s=arc-20240605;
        b=g+jQG1QA1+Iwq3GGsZyvHiVJI+mowmSSmhW7Qpd7ErF9gPZ4QCsMLlYkEqHJcVw+yZ
         1Jv1dlM3dl4hGrlM4P1dtV/3LAha+aiYoeXrOXulDJdW3hb/0Lkzeod4NAUAkNGTdQFC
         1IUfsRg/mqe5gL4Zcnzijq4UgAz74IZIBFQERzkzG5rSvvMuGa2xJfU6MEhlO2gAU9Px
         c0TSobG7uVFaBl1tjWb8J1o3WVeG1MfhqQhVuxv6uXZcsnvDS7jifBveu/dcfbwAU3BM
         Rcfhnt2eqImPc67MhjRHgakvVuTzHoYNO5KwVJ2mkc5sM4AlU61l/XoQAAavTUWtPKex
         2rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KGAV8vNkjM7lqIzd7+lsQgjeKG/b+qJ9+vToL/ir9ZE=;
        fh=LbgS1SGz2q6Y4vn5dwfXItcmrCcLtPRf05yLsCPdkYo=;
        b=OGSIfdGOfv+2ZVY5Sf8f6S7AbdYIA6o43oISiqp+gCfwT4UTOYUw3z1gkcqMXyySxx
         Q0ji4riXgGsryZQntiStz2e2cHHianjduCYl9uElT9hCosNlK7Z032bQfTQHKETa7MfP
         VBHgn/u88csh+i8ohUL03XcTsPVjzvJsDyWzgAziY/7g8orR4f7cv/rANdM6oC+wBRYS
         w7l0p3tJwKrUzdisEtadN+opiTFh3uh/2PQXhNy7E06+/cbbzTU4FaFk2Z/9XM4O6s+W
         CyU7yDypKfgquc2iXFA+JYtVLRm0H9mKxi9cExaWNXX/qPYJNo+JirjGbTW7QykZu/I2
         B2YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1780928507; x=1781533307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGAV8vNkjM7lqIzd7+lsQgjeKG/b+qJ9+vToL/ir9ZE=;
        b=PkntK9BThNX+2abxIdn05GDeFQOAqJwTe2tCOweYgEaQRjh1uLllIv7Pbv3Mpkolua
         Tor1cccnHXKvP24HLl+Hef7I7pBlQv/jRa+UaFPiobtn/rAIETNqo72bXnakQBvhUbI/
         kT/Ex0UAf0zVuN70GZbWIRzwnB1qc9zF1LT4XMwUttpI7wUlFtADfFFMn2AZ3dAmkrzv
         7lgzJazAlfEyV4fXWsICrZ3CmEJbZMH/uFQSjX2Vof9Z+tALvqumVEApTB2RTnPe+PSW
         95AcdD36p0izpJgDL25QoMIM6E7Orc7kkZKHuO65pvMsBL+k5VpFlYXwsESZD43NtbQT
         dOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928507; x=1781533307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KGAV8vNkjM7lqIzd7+lsQgjeKG/b+qJ9+vToL/ir9ZE=;
        b=oz2DIIEzdrSYlFLoC9EbwNmAkQkz+eDJH7/enaMi+oNwbbpTNO0jejMkjyru2ClMo5
         ok2mh1ULy7ySxtdG0bXqQiuRyndWgkKqFGWAI9tQombe0k+T+SVe6mweHqgum2SjxaLO
         MtLWvtbO4ovb97Zl5utsNBv++bLlgSyofRNQTrtfXGZuI+jwm6f83sgH0bmmcarE/Scl
         jFD5uKCkbRf6bUaFaG/pheWb2YTL1Qq4chrV9f3iUqDOl5MTtube3RgV1rUkRytJ5UpQ
         1kpLnav9IYAilJGg1hc3TKfPvZMSEwkqQvx0AsvpGSUzU+/Fr5iHDUTSjcEemPHVAmer
         kkbw==
X-Gm-Message-State: AOJu0Yx77iLNofCSHX+cnTxprArdsIVwXLgFSvdQ0X//ngK8NYtEGWa8
	JgJl8VV0Av/AFzL9y+pDVKwdGh95pYb1NqwHbww6tvee9titc54VqCBeN20SDhUgT8iH466PWIm
	lId7FjD680Dwrd4MigJmIz9u8PflesNcHQdOjUfQtwQ==
X-Gm-Gg: Acq92OFRrzzks79wCmBCVl7DdSkRMKEjTCMT582ZkexU0UBgcZOo39bCpdkSCXrZncS
	RQ1/WSbbwuhTBeITsQt/LhtI860WmcANqe4K0uYYRNnbITY+80VROVH/A08lJzEF36XLNjj4/dH
	cR7kpUQ4NYd+J6cdRHZ0HMqdMpQw/53z0DBKy23qBapPST+R34aaEQ0BUz7F2OdNn260waJ1JN+
	R6Ugpuz9BIlovdttl1LRjfRlDh1edB+CSgOGSP19fitDLWnipmcUqX2lj/3RqjyfQH5GnoTaEAc
	VRE6M9ZfRc75iCM7qrpZxp6g2IQ9MCWu8XeOfAfcYoDEgPYSTcTsZf9l2DE09MTlUrW9NVgzXec
	t9Jw=
X-Received: by 2002:a05:651c:2229:b0:396:7b8a:3da0 with SMTP id
 38308e7fff4ca-396d096caeamr46337551fa.26.1780928507231; Mon, 08 Jun 2026
 07:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608134802.5019-1-aurelien@hackers.camp>
In-Reply-To: <20260608134802.5019-1-aurelien@hackers.camp>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Mon, 8 Jun 2026 16:21:36 +0200
X-Gm-Features: AVVi8Cdrcr8ifzcXCk_vgrmgrus2Mh-ZMBbWZ2WL-edLWP2jTo7JbgAJed4aR1A
Message-ID: <CAJpMwyitYvHKbNvkWULmNx_8RkuHeCs5Tg-ThJBJWJ3gzek3ag@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: Fix integer underflow in process_read and process_write
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	jinpu.wang@ionos.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aurelien@hackers.camp,m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:jinpu.wang@ionos.com,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21974-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,ionos.com:dkim,ionos.com:email,ionos.com:from_mime,hackers.camp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14FC7657389

On Mon, Jun 8, 2026 at 3:48=E2=80=AFPM Aurelien DESBRIERES
<aurelien@hackers.camp> wrote:
>
> usr_len is read from a network-supplied message field (le16_to_cpu)
> and used to compute data_len =3D off - usr_len without validating that
> usr_len <=3D off. A malicious RDMA client can send usr_len > off causing
> an integer underflow, resulting in data_len wrapping to a huge size_t
> value which is then passed to the rdma_ev callback as a memory length,
> leading to out-of-bounds memory access.
>
> Fix by reading and validating usr_len <=3D off before rtrs_srv_get_ops_id=
s()
> in both process_read() and process_write(), ensuring the early return
> path acquires no reference and has no resource leak.
>
> Reported-by: Aurelien DESBRIERES <aurelien@hackers.camp>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
> Assisted-by: Claude <claude-sonnet-4-6>

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/=
ulp/rtrs/rtrs-srv.c
> index 6482ad859..f2fd80c8a 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1059,6 +1059,11 @@ static void process_read(struct rtrs_srv_con *con,
>                             "Processing read request failed, invalid mess=
age\n");
>                 return;
>         }
> +       usr_len =3D le16_to_cpu(msg->usr_len);
> +       if (usr_len > off) {
> +               pr_debug("rtrs-srv: Invalid usr_len %zu > off %u\n", usr_=
len, off);
> +               return;
> +       }
>         rtrs_srv_get_ops_ids(srv_path);
>         rtrs_srv_update_rdma_stats(srv_path->stats, off, READ);
>         id =3D srv_path->ops_ids[buf_id];
> @@ -1066,7 +1071,6 @@ static void process_read(struct rtrs_srv_con *con,
>         id->dir         =3D READ;
>         id->msg_id      =3D buf_id;
>         id->rd_msg      =3D msg;
> -       usr_len =3D le16_to_cpu(msg->usr_len);
>         data_len =3D off - usr_len;
>         data =3D page_address(srv->chunks[buf_id]);
>         ret =3D ctx->ops.rdma_ev(srv->priv, id, data, data_len,
> @@ -1112,6 +1116,11 @@ static void process_write(struct rtrs_srv_con *con=
,
>                              rtrs_srv_state_str(srv_path->state));
>                 return;
>         }
> +       usr_len =3D le16_to_cpu(req->usr_len);
> +       if (usr_len > off) {
> +               pr_debug("rtrs-srv: Invalid usr_len %zu > off %u\n", usr_=
len, off);
> +               return;
> +       }
>         rtrs_srv_get_ops_ids(srv_path);
>         rtrs_srv_update_rdma_stats(srv_path->stats, off, WRITE);
>         id =3D srv_path->ops_ids[buf_id];
> @@ -1119,7 +1128,6 @@ static void process_write(struct rtrs_srv_con *con,
>         id->dir    =3D WRITE;
>         id->msg_id =3D buf_id;
>
> -       usr_len =3D le16_to_cpu(req->usr_len);
>         data_len =3D off - usr_len;
>         data =3D page_address(srv->chunks[buf_id]);
>         ret =3D ctx->ops.rdma_ev(srv->priv, id, data, data_len,
> --
> 2.43.0
>

