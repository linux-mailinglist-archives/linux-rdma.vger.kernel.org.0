Return-Path: <linux-rdma+bounces-18978-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDtAELue0GnD9wYAu9opvQ
	(envelope-from <linux-rdma+bounces-18978-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Apr 2026 07:16:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA5399FC2
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Apr 2026 07:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F5D030268BC
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Apr 2026 05:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149830BB91;
	Sat,  4 Apr 2026 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7VdlZ6n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2642048
	for <linux-rdma@vger.kernel.org>; Sat,  4 Apr 2026 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775279800; cv=pass; b=OD/DX2B2MpNrJRppbg4wMou9Qg0swOPuoeyO93ARhGYug51eahzpfQH8mlH8LJAdtc0OdLJYmP1W0cydDqFjYY30bluCqVqN7BtygemNlUDqmq2VBxaqGqz5nvbRQ2lbt/2EHZguZmCzEUhEjfFksYI6K3IgOfWy6tEcY2dCKNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775279800; c=relaxed/simple;
	bh=/tcMpm2Us3PVP5V2CFtlY6XM43Ta/B+AQMXzsOYH1Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/iBltt4gVSTuPcL7dsuKASNX7JN7DHXV8xXWUzrfSxHrONsSG4t11GgoFYHmexaOw3Y8PohnV6d/jsPR+jHuMvNR1FMeDItXI5QlbiEpWBhT0iCJXiK73QioEG9yRgX+57s2VcpiBFf6eLM6hPXEysCJH3YAFoMi34OT1shkJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7VdlZ6n; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-509069a7a7fso885411cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Apr 2026 22:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775279798; cv=none;
        d=google.com; s=arc-20240605;
        b=BU2+qo9qM/Xuy1r2xtLYw/qbsvZimFIQuvsFOlyRKPAfYBgeMePrgRQjw/tPgO2vpF
         m3Y+afLQSN3i6O6W482rSbb/q7H2w6FFzYJD1FAeN5zp7d74ffSrb68ANkfeT2PLejeD
         eumz9d50eSCwNh2CX80ze742b8aazXcop4dRhLUGIZFp0aBPQg2W579+frj72c7GaX17
         lq5Kb0Sg3jhn/9EG+WK9PxtbBphql0Jig4/Q1hEQeWGapWGYAytWMccy6AoVMyqAXX5x
         I61YYdXjcavkUcV2gLFwGvFD98D/4lwGbEkBJoUdh5REZs/iJ+a7vdMttzDfo8S0E1NU
         083w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yb605lKVp/GZqZOgKkIYclNBctJ6DyMj4RFRGDR1K84=;
        fh=dOAokNBEVzx62Z4BnhAIfursDjnutGj79371qx2fjes=;
        b=EmHmWO+Qrmj7RJD0uVVoBAbPhT91yBgP+rdy5DReJ+HLUW9gCleMQmWopmnKSdZkm6
         7Iils4HPncRI3ETCAfCFgVKJwIqtJNjq2wfbtdidN0f0/fD3oCwDIV0XYBmJNWV5fOW4
         yiNgRPApuVNGQDeTY0Jd+1gJrBB98NTndPeihoH7mxmp+ARUofATL/1A7K8qbao08Irp
         JoYqwuukPm5k6WOWi1ccgSdikJY35EWPRtBCroBkPasTj8d45xhsgODMhGlyjqcwToyz
         4LCXKamBKav9cvgO9f5aGF+iuVo+wrEuvPtMmrDcxyYgs5uzTq3zj6Yfz09dXb/zvXnb
         Pqww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775279798; x=1775884598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb605lKVp/GZqZOgKkIYclNBctJ6DyMj4RFRGDR1K84=;
        b=n7VdlZ6nSZ5FwgVTXA+cHEUX5Ct9zW37+fe2101w+4N9HgajwRnBNFzHg9vEtzlhoT
         BS8t/9y15RzPS3pSJbXVeCJ4BK9j4n+/uR4om4JPfN01Ejkt3zssHVpN2p7fXNUzj/Gu
         IFIpMudPzZY4VpfsjB2IZUm7mpCZ/+Cep+z1NjiD08WQMm3agNMnzouILuJ8er7OOee6
         5El6h/ewwSFUaJ1m69BPS2yA1Il5rb09lOWwyddDlnOaxQyJT6vZ+pxGdaEpDeWdo6IK
         wX12WeKQEhoyjK3HzUS/Ygt6DHYCiB5jXdVfA0oL9Ht5It+XhLUKkCm6v17z1GtQ+zKk
         vQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775279798; x=1775884598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yb605lKVp/GZqZOgKkIYclNBctJ6DyMj4RFRGDR1K84=;
        b=GrwtcttMWrayUruuGijgLmoTtFydJGkhA3cJrxnhkVihyurQCMPUAfGQ9pFyUC6pse
         qe9y0lWUOZUy15MrkQXpDykZQXV5k3D6gDHmessoOzZ2vEh3rdlLVBfKPvjq7xC7uE7/
         FnKfQNDC0tH+/1HE7wRmR/OVfQ25oKZ5uRa2znB14Bi9ADeyghe1KpY1/djS0j5WFqrT
         ArGjcHzUWlckxIVlbUXi0groY/JfhU6UUEK4dllLC/bluiskSf/C1AGgW3MkHJSBFYtd
         JMZV8TLPybMew2WfAaEMG1cx0O/ndqGcFJ+oJEHYa31uxEYRhIHtWsBjvWRGcoMiGXEe
         7WCA==
X-Forwarded-Encrypted: i=1; AJvYcCWDgJy9tAB5CZnmyo43Uuay8zr8o/cC1FJyhecAb75zpn+cd1tdHPdU+2GDTMxt99bUGCGYb7qz/8yn@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1vSBzrysuLmQPyvOmMAF+blS2KaC3zPYsJrcKWbsbw7JN93n
	DUHIrBZSAJ1efqoZHSsHgQ2qetVQtjc0iv3hKtOXF4BNJwWRxuma6NGS34YzC+4I7hLaWmR56z6
	7HBcvuw8dBELVjWf9jkpbiiMPe50tSyA2BS5b6v3j
X-Gm-Gg: AeBDiesheVSPrrGUZhIiV0GYALuO8TejOLjKZB6RUtd8jdRgxZXWKbZAZXvHLjkXh1U
	ANG42g4aPTEvBNy1WqzxxKnEby+AVM9Jyg2sr5P/1dvbknHiuhwONba9WFDxkAB6Bk8McOt/Cae
	QkQ8mBoRhjbBF41zvab7bbD9ueB2Cb6ULvza4swOLxh/MN8K+BLFOF7XtK2heRoKe2ASnnc9jqI
	7zPp9Qsx+5Ub2GWli1WqyBo3EZXDUQt4LF8LM7hJtM61p8er1j2ei3b+3iBFCAY4z/n788+eBo9
	fNus9DuiKaQg5+4OkwFY9R6j8k5pf0+Z4jTeynRpzKR+QdAMI0Q=
X-Received: by 2002:a05:622a:684f:20b0:509:2cd4:b705 with SMTP id
 d75a77b69052e-50d63eb03bemr17889111cf.4.1775279797390; Fri, 03 Apr 2026
 22:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402073001.2039625-1-shivajikant@google.com>
In-Reply-To: <20260402073001.2039625-1-shivajikant@google.com>
From: Shivaji Kant <shivajikant@google.com>
Date: Sat, 4 Apr 2026 10:46:26 +0530
X-Gm-Features: AQROBzDtPFB3LrL89ArMSPFgvkXkqsGeNgFG00L9nKVDphRhkke4IXXiw-IqTvI
Message-ID: <CAMEhMp=zrZ6TmNEP4xu6suES=XtyuRcMQYprntzoJZnorfN9zA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA transport
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>, kch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18978-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivajikant@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A0FA5399FC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 1:00=E2=80=AFPM Shivaji Kant <shivajikant@google.com=
> wrote:
>
> Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> RDMA controller supports it.
>
> This patch depends on the PCI P2PDMA support added in this
> patch [1].
>
> Suggested-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
> [1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/
> ---
>  drivers/nvme/host/rdma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 35c0822edb2d..09eefd7c3ff4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2189,6 +2189,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_=
struct *work)
>         nvme_rdma_reconnect_or_remove(ctrl, ret);
>  }
>
> +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> +{
> +       struct nvme_rdma_ctrl *r_ctrl =3D to_rdma_ctrl(ctrl);
> +
> +       return ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
> +}
> +
>  static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops =3D {
>         .name                   =3D "rdma",
>         .module                 =3D THIS_MODULE,
> @@ -2203,6 +2210,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_op=
s =3D {
>         .get_address            =3D nvmf_get_address,
>         .stop_ctrl              =3D nvme_rdma_stop_ctrl,
>         .get_virt_boundary      =3D nvme_get_virt_boundary,
> +       .supports_pci_p2pdma    =3D nvme_rdma_supports_pci_p2pdma,
>  };
>
>  /*
> --
> 2.53.0.1185.g05d4b7b318-goog
>
JFYI the link to v1 patch:
https://lore.kernel.org/all/20260401103441.1229964-1-shivajikant@google.com=
/

Thanks
Shivaji

