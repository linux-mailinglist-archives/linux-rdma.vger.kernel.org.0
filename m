Return-Path: <linux-rdma+bounces-23002-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j0e1LDUDUWq/9wIAu9opvQ
	(envelope-from <linux-rdma+bounces-23002-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:35:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED173BC98
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:35:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=BY5ePoUl;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23002-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23002-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F75E3055D50
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A490349CC4;
	Fri, 10 Jul 2026 14:26:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7824677B
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 14:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693566; cv=none; b=tXkPpDUALxzmBvmzLeKjb9JJzoCExkaCF/2ZC6e8ax4bGhUK4PYG2Fd+QCe9+11SVSKa7fPS0ecP13mbeaqUC2kYUmP1+Jt6tcZ2DGy9vsplLXx7fYSyTcqnvaJptB1ITPiphdQEGmSAMDWDpeGqEqy/uXaR8ziiexGd+vsEdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693566; c=relaxed/simple;
	bh=8t+21mUPL8GKvDrejQ4aoUKD0tGuaO1rj5zw7o8shEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/9RNCRY0xV9KEjJND7gXJR8/ft5a9+Rn8I2dN54GzugF0Z8SlqO2lBNH2urVhxIn5bWVylnR2FpCxDE/Kf5+sMyK82GzsX1M/xx+D2tXmGlbnv2oLe9J3FOggZUPqFbjoyhP+DKl4zM/d1qXLofXHXp8tVPZBKp/cFhKrwwbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BY5ePoUl; arc=none smtp.client-ip=209.85.210.100
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7e9dd333d37so417931a34.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 07:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693564; x=1784298364;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fWifXj/GBil/B8308hnWb++AomhHguXaLBynFar9blE=;
        b=eJCJwRC1m5npJ2IihGvHjpCGvyzoqzJlTzmEGEs7GD2qnMB33XkzT447mXnw1ZmQZB
         N/D/gV+bVTMhogVInTSCUIR7696B2e9UDYpySk+vn3eBFYU5cv1L8rEAaKC7pxpCsqDW
         b//LdbqoBuuYZrmwidqXuRrqZWAJkCKXD9GXgCLDgAhF4Sd69h1Ngbtodc7XSfoP+0yQ
         Xg1B8fFMmkpicEZRlnlTO5R802k0fyTe3eoVCUR15Kcxsxz4XRIHnOi2lipFcvVKcDFU
         8OlUUNMCbHJRnfbcbdg3eaM3eRCqdxXZRC4BYMaCFrG5n1WWcWNPcDHt1G5M7rA8Wytp
         0ffA==
X-Forwarded-Encrypted: i=1; AFNElJ88iRXjYW7498ONR/7b3YOQ+sykA4LzvG1/iL8BrZYwvsxeiFcbsGTzzYFImi9mYlW0B/Ck0zd6pEsY@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQ0ZtcijfFndRc1w9wf1vpPVsZagNpRk1nFwwN/sM06rgURgS
	OKTbhST1+ApYUjx9+UdmIMUtSyNymNC+srlrijosdWu1XvOChiZoz7zbeuQP8XEjTSWMmmibE3R
	ZQDSZu8TT3Q4jtY4QO0O4o1o3IBVL3H61Hx8ja/lJKtGl2BWPRJwc2l/h1nWd/OT8I063BrM2j4
	x2QwpzZltHwpSrEWnMzWPSKcJIjao9Usgbs4VtHQxcBSFbWvr741UR1byuB4+64uDUtt+uEE15c
	Uv+mIw50B1UGD4=
X-Gm-Gg: AfdE7cnmxJJvEDiIlKUVIP8Hp8GxbJ1c5z/HgQDJTrmX9Y16cjOcAgEuqmjtHZL+Fqf
	ESv2N/giGoizJjp6rc3wCE3x7ifRmtbi9n9Os4QDjeaNA7sB4MB5MX6HY0WxEW8A9J2iTP6bqJ6
	AV49SgQBfKspkDCY2FGE/IY4r7D+fqVh/QgPWPfHpi3Ap1/KaHNJXXDaWz3YOYAfKTzVX3zkH8T
	DBit2hZy+Gq85B011heewcLV7q4W6idu0hN3C/ZQXgu14oUvH/2bNW+p8Q0SD+xa9t4tQCg8BYe
	GEICG9awZxJ8eudFiaIW87WKpzemR6I2IygPSAiOS100+JpMyg21E/u+eJBjGLps8pvmHK9vQhB
	S6dSMO5yf59cMnMApIGHYtJBIRqzTeKHkDIeSflltWVkMSLqKPJg3hsyA5Nb6vnM9GUoxjYbpeW
	7IKKFHyjZa0SiwrHOvcVORT5uT+Yjk3FC7Vd4yyggQuLDl
X-Received: by 2002:a05:6820:160a:b0:6a1:1fa7:eb49 with SMTP id 006d021491bc7-6a398b29933mr166133eaf.50.1783693563970;
        Fri, 10 Jul 2026 07:26:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6a36a7c48c1sm459473eaf.22.2026.07.10.07.26.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2026 07:26:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-96dacd0ab0aso110582241.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783693563; x=1784298363; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWifXj/GBil/B8308hnWb++AomhHguXaLBynFar9blE=;
        b=BY5ePoUlmXJSyOcqK3dat4rg+antciuR2cdM9VYrreG+YRk7v8+lRW1SI2jrGEknzo
         QPAjGa5eMfnjkGoH1BHDE4JgtANX5EnE4Ey0Gskb7lS+2cnj7m3bxL58v9N+4vF2kpK0
         5MgeLZjE6+MDt4GXNYGPIAd2ieS/PvcuwLnaU=
X-Forwarded-Encrypted: i=1; AHgh+RqVrYKKT8dvK89otnSTLbtTmZPT2nNL9LfgRieA33taDCcJ05BXLVYEmhP+GBEqqWEw6aBEhoOHrtjW@vger.kernel.org
X-Received: by 2002:a05:6122:a0d:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5bf75dca679mr6764606e0c.7.1783693563186;
        Fri, 10 Jul 2026 07:26:03 -0700 (PDT)
X-Received: by 2002:a05:6122:a0d:b0:573:a779:62cf with SMTP id
 71dfb90a1353d-5bf75dca679mr6764590e0c.7.1783693562753; Fri, 10 Jul 2026
 07:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704164747.1995227-1-vikas.gupta@broadcom.com> <c108a5ec-8740-431e-849d-581c136f404d@intel.com>
In-Reply-To: <c108a5ec-8740-431e-849d-581c136f404d@intel.com>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Fri, 10 Jul 2026 19:55:50 +0530
X-Gm-Features: AUfX_mwNTLFcnkINKbEqmfaK4Ay9J6MZJv-HX2NQIXA9unvHfUpLztD5FNK5SII
Message-ID: <CAHLZf_tTVipQZ_MX-gud5GhqHE7KDV=44N=17mZgsrWoJfa_Gw@mail.gmail.com>
Subject: Re: [PATCH net v2] bnge/bng_re: fix ring ID widths
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com, 
	bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com, 
	ajit.khaparde@broadcom.com, Siva Reddy Kallam <siva.kallam@broadcom.com>, 
	Dharmender Garg <dharmender.garg@broadcom.com>, 
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003f13db0656428582"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23002-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[vikas.gupta@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.kitszel@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:from_mime,broadcom.com:dkim,vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AED173BC98

--0000000000003f13db0656428582
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 3:36=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 7/4/26 18:47, Vikas Gupta wrote:
> > Firmware requires more than 16 bits to address TX ring IDs for its
> > internal QP management. Widen the associated HSI ring ID fields to
> > 32 bits. The values firmware assigns remain within 24 bits, bounded
> > by the hardware doorbell XID field.
> >
> > RX, completion, and NQ ring IDs are unaffected and remain 16-bit.
>
> Here you mention Rx is unaffected. But you touch multiple places that
> are Rx specific (some comments below).

The fw_ring_id field belongs to bnge_ring_struct, a common struct
shared by all ring types. Widening it to u32 applies uniformly across
TX, RX, CP, and NQ rings at the struct level.
I believe the commit message is incomplete but the intent was that
firmware assigns values within 16-bit range for all ring types
except TX, which requires the wider field.
Please let me know if this clarifies.

>
> [..]
>
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> > @@ -36,6 +36,7 @@ struct bnge_pf_info {
> >   };
> >
> >   #define INVALID_HW_RING_ID      ((u16)-1)
> > +#define INVALID_HW_RING_ID_32BIT     (U32_MAX)
>
> OK, there is much more usage of INVALID_HW_RING_ID than places touched
> by this patch.

INVALID_HW_RING_ID applies to 16-bit fields such as those in
bnge_ring_grp_info (rx_fw_ring_id, agg_fw_ring_id, nq_fw_ring_id)
and vnic fields.
INVALID_HW_RING_ID_32BIT applies to ring_struct.fw_ring_id (u32),  all
instances of which are updated in this patch.

Thanks,
Vikas
>
> [...]
>
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > @@ -1327,12 +1327,12 @@ static int bnge_alloc_core(struct bnge_net *bn)
> >       return rc;
> >   }
> >
> > -u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr)
> > +u32 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr)
>
> and here you change Rx ring ID width.
>
> >   {
> >       return rxr->rx_cpr->ring_struct.fw_ring_id;
> >   }
> >
> > -u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
> > +u32 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
> >   {
> >       return txr->tx_cpr->ring_struct.fw_ring_id;
> >   }
> > @@ -1375,12 +1375,12 @@ static void bnge_init_nq_tree(struct bnge_net *=
bn)
> >               struct bnge_nq_ring_info *nqr =3D &bn->bnapi[i]->nq_ring;
> >               struct bnge_ring_struct *ring =3D &nqr->ring_struct;
> >
> > -             ring->fw_ring_id =3D INVALID_HW_RING_ID;
> > +             ring->fw_ring_id =3D INVALID_HW_RING_ID_32BIT;
> >               for (j =3D 0; j < nqr->cp_ring_count; j++) {
> >                       struct bnge_cp_ring_info *cpr =3D &nqr->cp_ring_a=
rr[j];
> >
> >                       ring =3D &cpr->ring_struct;
> > -                     ring->fw_ring_id =3D INVALID_HW_RING_ID;
> > +                     ring->fw_ring_id =3D INVALID_HW_RING_ID_32BIT;
> >               }
> >       }
> >   }
> > @@ -1637,7 +1637,7 @@ static void bnge_init_one_rx_ring_rxbd(struct bng=
e_net *bn,
>
> ditto Rx
>
> >
> >       ring =3D &rxr->rx_ring_struct;
> >       bnge_init_rxbd_pages(ring, type);
> > -     ring->fw_ring_id =3D INVALID_HW_RING_ID;
> > +     ring->fw_ring_id =3D INVALID_HW_RING_ID_32BIT;
> >   }
> >
> >   static void bnge_init_one_agg_ring_rxbd(struct bnge_net *bn,
> > @@ -1647,7 +1647,7 @@ static void bnge_init_one_agg_ring_rxbd(struct bn=
ge_net *bn,
>
> ditto Rx, and in some other places too

--0000000000003f13db0656428582
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEICi+yNART8yp
TdOZUQNVb/YYtxwtrqjwE+33n5Np3rJIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDcxMDE0MjYwM1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBABcC18GABmVC4LMhbCYwTYcszNgeKyEP26rCyc0fcdob3pHr
ixpj35F24AO+m8IJUVKLpDICHTyUAYqaxQh/+rnZKqDOWVhd7+Nc2UW+VwdmXogsy+pNe5vLhNc9
L0BrzA1KgY5DTO7oNBcvBHAnr0obXxwSJemyg/W5uAz7bQ37UCrqeaogdwijPLdwcsH4CAs8JaSl
lHgK123YngsaWbPWgaOzFyW+e7v0WWlcVrj7vT5NNzqlhHBRI1naP16A302s1ko6wjJ3oVqX67xB
ibIrZNgjVvq4/Lb/2phJQQgh238wHVLQvVhbSU/p4u1Er9XXov0F0Katu9aGte5WEo4=
--0000000000003f13db0656428582--

