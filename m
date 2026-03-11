Return-Path: <linux-rdma+bounces-17969-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHpMKaWFsWmjCwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17969-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 16:09:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493832660E3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 16:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 795F630175D8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D83175A8F;
	Wed, 11 Mar 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL5ZMe+s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB0octQG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB333344A
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241757; cv=pass; b=c9q1OyfoQPvaBiqgWxGewZF/OxXwxAm4gsjYX+5wjjY5xNUyMGJ2uOBCn2Bjm7/1Khw18H0cySYfcD+VK8AAXljZaaDI5liMOtB8FcigX7PcRmuSj9AvDiYRk2Wl2om/1CDxjE0/Q1d7u68L/QuLewpA/zrrWOyaKck8I/UpJbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241757; c=relaxed/simple;
	bh=sr8EJ74h+PCWaP6DpleCKt+jfKdqyljjFBE6im8GNXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJBPdUIe66aWFBg4GP/LRp6ZfAGkjOVjjxQ9R4tD1ZPJNpxYffFuOz4IOKT0uYUl6LVX1Kjxs0sLvvU1SOY07grNJs+ptSOZExT2ZnJJJVqFmNOooq6dra/+fw3s5dWvxcTK8C91mBQAVa4woD1ATlCvfz2NiUlsrPTLXAEVzTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RL5ZMe+s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dB0octQG; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773241753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
	b=RL5ZMe+scySmI6MzfpFmiQ/AUch0/RAQh9a0i8rQMWqLtLFeFIgLPBaXuTDNIaI70t4Ufg
	9xibD2hWALCC5foT0fcUG7nGEiXieH8+0h0/kCadEYcMLXMJBvNXtBJk97jL2zntaf7NJz
	9Qu/BjBGHDwdUlbixoHB4dymApb2qzs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-dxffy1wlP8OlxfNsusYQdg-1; Wed, 11 Mar 2026 11:09:12 -0400
X-MC-Unique: dxffy1wlP8OlxfNsusYQdg-1
X-Mimecast-MFC-AGG-ID: dxffy1wlP8OlxfNsusYQdg_1773241750
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38a4105ad23so182801fa.2
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 08:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773241750; cv=none;
        d=google.com; s=arc-20240605;
        b=KPcNxYGV2OK536PfEjLiEAFxZTYeSZkErfzVUShZoARsx6jw1aUHayo7+0pl0VkYY1
         3thawcGhAM/KADY+hoKJuvSvI/M/VbVyLCxIxEE5/7Zw58/HsxwJ5F2O/UAYdkGbKF3p
         maQXx7O7cJM82TX6E+BYbkfjwclTHJnzQrD72YVJV7spWA0btruiP7M4ab4RDnF4eM9V
         oHQBxAI1NwrabZSvvVbDHbStT+DBnUtg3Ct5poXdyFezDJ0RbNSly1AmC82jV3LFYZtJ
         Kr87v4/nxCq1EcRzxpEldIWPJKhlfajFS2Au/6E+RUT1ldiID7si8TNRgmXNPtNrBs5l
         7Avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
        fh=bE4CQQD7duiBa8WDGGapF2avhApAXOsv8Lkwi42al/s=;
        b=dYP3P2KnDDO+U/grPFrtzM+spv/4wM+h1qgTIpBAb8bNe+fOWIkoG2o1+S3ND6YPUM
         S7DFUgQzkqbXJiQr21K/+zZjRdjFO4nSSPlrv8sKGf3XIPyzHNu+MJFkN6mcQQuRyIC4
         4ZGu9OYtWF0oFPoOaIgvTq6GWUXcA+oMLBjSATL/Xj6LhF5Yi7uRM+iDBwxhyXIK0A8c
         O0V53C2ANTcfcqM+UC4NHduwWty+YrN2Mukayzpv4GI/yv7QrMEUg/Qh/vf20CEragHc
         DRkdbvB0yKNh/qKol89RQdYaH4gfluNCpjkw8KgYxnqojpb70F1+pQRVRH08MHWHJo1E
         ryQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773241750; x=1773846550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
        b=dB0octQGlhykp0hEvoSV8X1man1Mt4I+4ZE/XgE4SjsboNvTB/6bVyWyxaQXB84rsG
         xvF/Z9COgnnl3aKEzf2C6yze/8MdP7aFi9+bn3a5x9pyEHCyjXjSDEO5Vz0GDIXDmN5+
         +VuwxTrHf1g3BvXJcogXBDloLqwS3wQuW0r5MaR/g50LEH/miAXwlMv2Cxxj2zAMaihh
         IiPM+vSqOV3utoJc2Ul0QH9CibmbxZAzZg18Czlk6CobBuwLLmQ+YRZUsbcKOG0oTsM8
         MGkzB6UqkvZbEEXw6Ny8xOLpVtnTC3NZWrJi6bXawOZV67ShUqdL838elWDQsx9O008f
         aDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773241750; x=1773846550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAixbPiqiWKvxfTtqwLl1ZycNxKKR9XvSIdM8Jl9/1M=;
        b=i2kq5Doitf3v8XFOQeXznvTr9DNofTIgDJkUR6Ub1ZljMuA1ybQAIgs7AR5Pg6CnXY
         OTFrqyqy13sDXL1opP70L1y+UmikMfJYqJXvRzxhQtPCj1irva3RkI09KkhLYZB0Oxeq
         ZcrNHlzWD21hofVX1JDjap4QiUfiaY7Qdn7MEIMiUjo+RswXRk9jpkTyFXG0Yy3YdrH+
         0xFuanQESf6ZIk3NY2/xo779ZHOtm0TewVbcQIRycPxjddtb5Pq0cGXhx5sdNhMncDd5
         j/Vxia4zxiWkODQ4ld0xA+6pt00UpfA2ztZUNwsguS51BxOI1F+gdRTrFzkYZxHjXliX
         /xuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaPZ3vRnBAeiw8oQ+J7aNcWS7IDSYTkZk3DZESIPi/NnhCGF+TFQiL7NOEFXPMa2XWpgxPfJDWS86i@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3tkLg4FCnpUFC3LHDGT16laq2TxH8CFTVPi98wAzHlDLgZuB
	SRXpKjebgERiLyD9kwHCqm2vtIbAAnGczLqwmg6IXbP6c3kAhZvQVbD9p5wJOql1YrLF6ciookb
	wa58185iK2wDQHOUkUUDbMr/N5zprKtzfKVwnHJFa85BPuLgTexnZOrJsQgCH0uSAtSWWAV9Qin
	8vE1G+LzX0LZ4Pg6RcQUf8WK76vAw9U9mQdUIwEA==
X-Gm-Gg: ATEYQzyo1cteqn6+8vOBXIFzutt3LSWguE/sODVCr3C1M7gu7tHoKyZGngAugPAC6Jz
	MlXEdJp20Q9rCGb08TRSg6bzEzvwlvMMhFpgM8PTl5wZuOB+kNlSb/qy4aROF8LltpFmLclXSJ8
	QTnbnJViSxfjpzNBvo6h09j2uEb8LtjYEDJF9GuM5uD6D5uJl1Zvmi4F5vkqPBM1AW9Vz7kEeIL
	JwKGAE9geJK2G3HjnlGHHlQF+N78F0PI6m9KpKtZ7p6fHs0Lgc=
X-Received: by 2002:a05:651c:551:b0:389:ee7b:4d4b with SMTP id 38308e7fff4ca-38a67dd60d3mr11561851fa.12.1773241750322;
        Wed, 11 Mar 2026 08:09:10 -0700 (PDT)
X-Received: by 2002:a05:651c:551:b0:389:ee7b:4d4b with SMTP id
 38308e7fff4ca-38a67dd60d3mr11561701fa.12.1773241749845; Wed, 11 Mar 2026
 08:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZ_-cH8euZLySxdD@shinmob> <CAHj4cs8mzSZez+n2qLu5931YAuQ4=RxNt6D6YJCsMEwGrm4UtA@mail.gmail.com>
 <DGZRYXTKC049.1I6QFQSMSD88H@arkamax.eu> <DGZTXRKSHBPC.2B318HF53ZRSN@arkamax.eu>
In-Reply-To: <DGZTXRKSHBPC.2B318HF53ZRSN@arkamax.eu>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 11 Mar 2026 23:08:41 +0800
X-Gm-Features: AaiRm52s-EH5ucY3yGw_WaFk4XtbskkABtsWUN8MID31uF9eSwnbqLdAEQHevQY
Message-ID: <CAHj4cs_nQEbeyvqvos7pwek8k0rLLXCghdoY9EsL4bCgZrxqtA@mail.gmail.com>
Subject: Re: blktests failures with v7.0-rc1 kernel
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17969-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@redhat.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arkamax.eu:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 493832660E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 5:02=E2=80=AFPM Maurizio Lombardi <mlombard@arkamax=
.eu> wrote:
>
> On Wed Mar 11, 2026 at 8:29 AM CET, Maurizio Lombardi wrote:
> > On Wed Mar 11, 2026 at 1:35 AM CET, Yi Zhang wrote:
> >
> > If nvmet_rdma_rw_ctx_init() fails, shouldn't it call
> > nvmet_req_free_sgls() before returning an error?
>
> Possible fix, not tested:
>
Hi Maurizio
The kmemleak still can be reproduced with this patch:

unreferenced object 0xffff88811db23d80 (size 32):
  comm "kworker/16:1H", pid 1360, jiffies 4296118279
  hex dump (first 32 bytes):
    82 3b 85 04 00 ea ff ff 00 00 00 00 00 10 00 00  .;..............
    00 e0 4e 21 81 88 ff ff 00 10 00 00 00 00 00 00  ..N!............
  backtrace (crc 4bb38867):
    __kmalloc_noprof+0x6f1/0xa10
    sgl_alloc_order+0x9e/0x370
    nvmet_req_alloc_sgls+0x294/0x4f0 [nvmet]
    nvmet_rdma_map_sgl_keyed+0x25d/0x9a0 [nvmet_rdma]
    nvmet_rdma_handle_command+0x1ed/0x4e0 [nvmet_rdma]
    __ib_process_cq+0x139/0x4b0 [ib_core]
    ib_cq_poll_work+0x4d/0x160 [ib_core]
    process_one_work+0x8b1/0x15e0
    worker_thread+0x5e9/0xfc0
    kthread+0x36b/0x470
    ret_from_fork+0x5bf/0x910
    ret_from_fork_asm+0x1a/0x30


> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 2d6eb89f98af..79ae743bb405 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -892,7 +892,7 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma=
_rsp *rsp,
>
>         ret =3D nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
>         if (unlikely(ret < 0))
> -               goto error_out;
> +               goto error_free_sgl;
>         rsp->n_rdma +=3D ret;
>
>         if (invalidate)
> @@ -900,6 +900,8 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma=
_rsp *rsp,
>
>         return 0;
>
> +error_free_sgl:
> +       nvmet_req_free_sgls(&rsp->req);
>  error_out:
>         rsp->req.transfer_len =3D 0;
>         return NVME_SC_INTERNAL;
>
> Maurizio
>


--=20
Best Regards,
  Yi Zhang


