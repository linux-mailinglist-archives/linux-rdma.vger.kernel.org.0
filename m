Return-Path: <linux-rdma+bounces-18549-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP+cIKXkwWnLXgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18549-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 02:11:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F061130050A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 02:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C53F7302810E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DA829C327;
	Tue, 24 Mar 2026 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EPMu8dT4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40D309F1D
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314548; cv=pass; b=Ibk9Jz6DdnQlqWgurQb/uoo/c/xVYn9twJlWd5dM1Cp7cPlRuvmrTkpSC6hHIiaCJ07A513teZb+TxyKh7ytIBeUFKrwh8W1jCSZt316x2Im9hIu8lakEbxw6b6ZF7MWfzI/zDwe9cXbA6Ug1/LqNQRM14vifUz6XrXSGwijYfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314548; c=relaxed/simple;
	bh=h/SG0nn3UrxqxKWz/cWIZ0MaPc4fBvFi4FT8hqY8k+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRXBAHOYC9M1vI3syrm1o9FhRq6s5nPjR3C0k4OHjPWYkzDtF/eVZ9l3AKYGDEF2LDKx2tUE3AlC0+mOaLtd0jJ1ElMlZ9GN33yn36acL/XDVZHRv1fsjn7Wr3Fnvn8TFHGLjD5MRlfPvPOHLRjNT5zbTiOWgTd9JPeGQFjBf70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EPMu8dT4; arc=pass smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso2199513241.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 18:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774314546; x=1774919346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X29wZFX1ug7cbbAzj91zOTiGW5q8hwTJM4rHqSAqDDs=;
        b=rcrlz74rXbNDcKEVvuPkUqFY8jhgMG4+X2Bsb3O6mbvnXPeqzYb3l4EFChLLFo57vU
         AwCSNdreJnYpgcXu7lL1vTnqdepCF4B6Mt3ZEkC/WGxwU6CaMobZcvWM7qNwl8tC8NjG
         LMGMlBz44nroAffNNEC/7o0SknyEGrZNpYsE4s5kfSEgRl/PynF29snwjoEKcuIQ4kJI
         z8IGDS+Ept0CwVBSf97lyhYOM6JGTiI6q3XUSRAfUhJoC+bMU+FEqoKXE5a5r5JSQtez
         O1BpiBInpTEji8R8gLaszzrnbrh/4Dlx6G4sNe7+443W8orUIwiuEtYd8fzrLs3HjtH1
         NsNA==
X-Forwarded-Encrypted: i=2; AJvYcCXfJnoUszHcQhjaL+XEw3ld42F0lfUmwayRQ0yCmbc5o7qkzaqMQaEIAK97LNl0URdVF/YBYDKAUo1v@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9tgrnpPy0Bn1PsXH1x4e65FAjyYobF7ZGbf4tPrfgYzU5BRO
	a9ykIORHX+4UOdrmfLwwk1LP8zez2riVKjyVLqrmjHBobm2XhA13j8PECH7cbeA8eOuviN/7YsI
	wAIYQpVEx+EEg0JA1g6pbmGrL+BbeoX70GwrBkqBcITzfW8GOlpZiy5FG1t262GdvsBDQD7fn7v
	qgLVyTn2K2l2u+x+66ryIiTWt4jEoRz+9HjPpDw6v+FQncEd7jQY9FteIKSA2vL8fJIlKgws3xc
	nz5WGgqbvfMbL8C
X-Gm-Gg: ATEYQzw3cen80w4HRUHTO622dsNMGLmjXGl1EfU5eypW5uRcxRevtf8zHHvkeUvI2bI
	fhmrjBrEx/3yd/ZfgsJtt1PlgV1zn4RD6+zzfLwScu++32wsNBuMaJNO875f72T7tRPSHBNkau9
	i53CqiMQyQCUYQPi3kmfSqrxmUuCUNAaJuLHGmUfJcAknp8nXynvWnA1LwOxsgsW0Cuik97ABOe
	BEfDLZ+UDYgv34MjlvMwzTVA1S6VO2Oo+88ZPDVC0sHpjBQ0TzTIP570lp4m1ZRAxXI261LcB+I
	elivbcp+ZlYVmTscRM1STmXvktM+E6ihYPr0VsiUNFfAgOLXdoqnP5Vo+GZvrQcGFevVgA3txu/
	pRpmYOtwpEGpZubjwfhHa+ved28lf7LoHi0mJRUYaPNnD1QzwVWbWZxppiDE8CtMuvqcP8lP9Bu
	0ycCG8MGPMXR75cQCzxjPBpaGfu2LTQz3jG2cvb/e4xocVo5o33YuXm03kLOs=
X-Received: by 2002:a05:6102:441a:b0:5ff:cd6e:85ed with SMTP id ada2fe7eead31-602aedafb02mr7129266137.35.1774314545359;
        Mon, 23 Mar 2026 18:09:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-602afc3f3casm1085073137.5.2026.03.23.18.09.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2026 18:09:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b940da8ec09so83018166b.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 18:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774314544; cv=none;
        d=google.com; s=arc-20240605;
        b=gVBZaj/eS/HM02qUaQzl0uB7YputOwXKXsXm2UpvHCSPewzEt42X2owYyQ1aF8NV7E
         TWyIPbjlXxyHfVb4MGmvjSTMiL2E6tlPvGXzS636Vfcq4w/uDyWWbjP083a2A4otkNc0
         pLmXw/uZzEOvPtm3nIn0zT5Ihau4rPVEZVRHqheLyE6IzI/e1dYhmFXYdx4wEWjya55D
         YMUfzdux55iGZ5QhTYOOfR3BR2FfxTxLK/U/oOYDjnhTt14TzcJu/6KbGofiTUqQOTPA
         vyRd9dtJ1c0j+eBNkX6xxdi1CLlD9XnHQsQvr5mn0JcMtQysY36auF1FFCjeOttoc+aC
         w6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X29wZFX1ug7cbbAzj91zOTiGW5q8hwTJM4rHqSAqDDs=;
        fh=HeDLsOeOF3KeGi8pKsAc4V31L8Z1POo+e6XEm0Beljk=;
        b=aOuRjYy7V2NYpqWGqptsOzLsxix5TbkSdEkG61Y/MF5kguJOdLyKKVILSTZE95Q7cD
         SA4QM7rasQK1qF/ZTEYxCEC6FNNIHJZ6I2MsLBJbNxBtPwk/VGnFjw9yVerX5TEtY9sI
         hPShxx0L/wAbqKyL+Tqiu2KfTJz2btMRz1LKSeMADSQMPsrVp5bf+6c7sgfVgbN8JfHJ
         gd6X6Kw7a0kNGTV4cmy444Yak2As+u9o1fHDFdDbK5/IDPNgjurJRwYlKMr2B1r7iOd/
         Hu6EMp08mQgwDp4rmNU1jRLpQFu+bfY5pwl3gIvMsTrmFd2RteNckjLqBAlHQrbiiFQc
         SWeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774314544; x=1774919344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X29wZFX1ug7cbbAzj91zOTiGW5q8hwTJM4rHqSAqDDs=;
        b=EPMu8dT46cHPslbkrBGrGLYxN+7w3UQrkWdz0uJ/ZlCHbXY97aFxiAepK0NwCsrgBz
         ULDRh6bzbP9en+v5KeKBwRy0sjT7B3EykHgFHWeiI2RW7pIDOiYJOH4jIV5GT5ITUxbT
         uSkT65V7rVMCtuCbSI6rSHN3Ub9jDMaZ9JtcE=
X-Forwarded-Encrypted: i=1; AJvYcCUSUBKUjUIOV9OKFdXlUDZrum23fZPEOVWjwPZ3N4XODRNKzHgu5SjlSdZJoAk7k89fvJ9p2CPYbsLA@vger.kernel.org
X-Received: by 2002:a17:907:6b0e:b0:b96:db93:5d0e with SMTP id a640c23a62f3a-b982f4e6533mr1073949166b.41.1774314543390;
        Mon, 23 Mar 2026 18:09:03 -0700 (PDT)
X-Received: by 2002:a17:907:6b0e:b0:b96:db93:5d0e with SMTP id
 a640c23a62f3a-b982f4e6533mr1073945666b.41.1774314542785; Mon, 23 Mar 2026
 18:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320012501.2033548-1-sdf@fomichev.me> <20260320012501.2033548-9-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-9-sdf@fomichev.me>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 23 Mar 2026 18:08:51 -0700
X-Gm-Features: AQROBzBKAHCpXL_0uNaZPLnOtADU_LCPjRl7n7D8OXK2y_iwcTGmn-vseoYacPQ
Message-ID: <CACKFLi=j7DO_d46jwZnmZ=OfmkoFA3AXUoX4nmF0tQuYt5Y3UQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 08/13] bnxt: use snapshot in bnxt_cfg_rx_mode
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, alexanderduyck@fb.com, 
	kernel-team@meta.com, johannes@sipsolutions.net, sd@queasysnail.net, 
	jianbol@nvidia.com, dtatulea@nvidia.com, mohsin.bashr@gmail.com, 
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com, 
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001f8f63064dbacc6e"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18549-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: F061130050A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000001f8f63064dbacc6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 6:25=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> With the introduction of ndo_set_rx_mode_async (as discussed in [0])
> we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to
> use uc/mc snapshots and move its call in bnxt_sp_task to the
> section that resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
> bnxt_set_rx_mode.
>
> 0: https://lore.kernel.org/netdev/CACKFLi=3D5vj8hPqEUKDd8RTw3au5G+zRgQEqj=
F+6NZnyoNm90KA@mail.gmail.com/
>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 225217b32e4b..12265bd7fda4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -11039,7 +11039,8 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *b=
p)
>         return rc;
>  }
>
> -static int bnxt_cfg_rx_mode(struct bnxt *);
> +static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *,
> +                           struct netdev_hw_addr_list *);
>  static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
>                                  const struct netdev_hw_addr_list *);
>
> @@ -11135,7 +11136,7 @@ static int bnxt_init_chip(struct bnxt *bp, bool i=
rq_re_init)
>                 vnic->rx_mask |=3D mask;
>         }
>
> -       rc =3D bnxt_cfg_rx_mode(bp);
> +       rc =3D bnxt_cfg_rx_mode(bp, &bp->dev->uc, &bp->dev->mc);
>         if (rc)
>                 goto err_out;
>
> @@ -13610,11 +13611,12 @@ static void bnxt_set_rx_mode(struct net_device =
*dev,
>         if (mask !=3D vnic->rx_mask || uc_update || mc_update) {
>                 vnic->rx_mask =3D mask;
>
> -               bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
> +               bnxt_cfg_rx_mode(bp, uc, mc);
>         }
>  }
>
> -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list =
*uc,
> +                           struct netdev_hw_addr_list *mc)
>  {
>         struct net_device *dev =3D bp->dev;
>         struct bnxt_vnic_info *vnic =3D &bp->vnic_info[BNXT_VNIC_DEFAULT]=
;
> @@ -13623,7 +13625,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
>         bool uc_update;
>
>         netif_addr_lock_bh(dev);
> -       uc_update =3D bnxt_uc_list_updated(bp, &dev->uc);
> +       uc_update =3D bnxt_uc_list_updated(bp, uc);

Will the uc list snapshot change between bnxt_set_rx_mode() and
bnxt_cfg_rx_mode() with the direct call now?  In the original deferred
update implementation, the uc list can change and that's why we check
in both functions.

--0000000000001f8f63064dbacc6e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCR33Mw
/YA8D9hJe2rawnAotsSH69SPoOptXJYmGQDmvjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjQwMTA5MDRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAQOx+UbIRCbXG+rxl5x3Whxy0Cs6Pe2Xip04Vzl45M
XXuljLg0TCiHF6lVhhANdbPDHQHQNosXZT4FIx4xpQPj+wkyBDL+MvZYwA+1gI9htuPNE0Ffkyqr
btKMX2u7Wgy6rs+gYVPiiL+UOGxONjzREoSXNpAPHrFxOXQ1ientcpNvkE2edWZeNhY43NtHFL5Z
lHhmoqkc3xzfhWvJQHSBa3aV5XEXyh/3TASEHRX0HpAMrsD8gmvblIjf/uACWpp8LRq7Hc0/93sK
BjbRsSEcMRGACyWrhtEpjIbrhl067YWozCc/A9knVdrfJCeOjVtPzrkwzhRaFDc+1l4QcNMT
--0000000000001f8f63064dbacc6e--

