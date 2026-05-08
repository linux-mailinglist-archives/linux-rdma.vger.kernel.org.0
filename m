Return-Path: <linux-rdma+bounces-20242-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFjJHzzz/WlxlAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20242-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 16:29:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4274F7BB3
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006453086A91
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6B3EF643;
	Fri,  8 May 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLvJJ29p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1001175A77
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250215; cv=pass; b=TOjM7P0suDAAv7rqlWwTrO35zXT2lgayZGZT/izVIkn5wg1mZ+wYM4jqXmEYbZovknotQfez2q8Z8oW+g/8buNZx9/byIKxIH7Aiu1zVSiKGOCOycaaxF8uzr+KhhZyfNC0G9El4ihOw7eUvGJT0Ns1PgUmvGM5WkuHJ1ihRooc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250215; c=relaxed/simple;
	bh=ZPAPfL8K1AFmpTtoB+rTBhIdlxBBNlasWHWikCl+RbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5amHDScfi/Y9dhwxJiHMjRgR5YJPCEykmjdqaXaZ3Kjntpgzib+aTq3Psh3KClJ2lRASyh26OmtF57cPsw9epkF9T+O5d0/vLgfIFBVib0fX3f3jzLRpQVqmJmMbGQrnOwJzN47i1O92ieDFhN18rectNNC848h5TOMWn84WoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLvJJ29p; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-366070f71adso1807528a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 07:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778250214; cv=none;
        d=google.com; s=arc-20240605;
        b=a8ICWde+PrXHBZaMDmttBw5czAdrDSAf9U1Wetn2qC3HaDi4wM9+Z87UKi5AIK/6du
         slJZXDKiR53ydc41KldkgY3ORGOq+tYHhWK21+q4dIcLQCTMwu3CeNzmKqA8WLkc9kJG
         qlofODLjW7adV2iVNkKZ5JxZXu+szGcEwK7u2Egs5ZNmdepIKQqeBtkGePwLAHjj5DM+
         /7NYZKFe9O/D4yL9e0tViG4oMUhjPSxKi4Mdykvkt6aT4iEt0ETVbXZKSGwlVCgRJ78a
         6a3TbVxMImq5rL47mPOxemOlRr7od4fs1oGK45lkC0mnKQZjevJszJVap0LsrpgQJTGI
         6I0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RkPfarM/3iW9Yw0Nw4nHkLmfDbEdrCJbUGU926k10+A=;
        fh=Mpcm5Wi76iERSXbOYjL9FqhGwkTEhSsuzlxZrGurQhM=;
        b=S3QCLn+poBxUoFmS5vnr6QH4nwLmHWcXnosUx8tHfBYzy5vYXvrpDfhS8dIAd/RzXT
         AyFfQ0Gw0xuCvnjrjIcTsu5UxFI6FDPd3fKYREv86vgfHQ0Af7I6ZoAnHEAKlL5Pu+20
         5rxrl2vjPGXvgQnv2Qy0sgschehmJeV+PJaDNAFnxF2XGN0wlDyqXOJUyMjDpAgyo1/Q
         l4+sQMevCHa6O1sNRKfpQfd5N+GfpMwnT8SqlnCvXBzgD/PUeqSWD4zVsi766FwbWx5E
         MVFcUs0ZJ2c877A2G6lzZL/JFKzC4K9zZCAMocYNHihcf7Up8RrLDnIz9HAbyIJFmsYw
         Bruw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778250214; x=1778855014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RkPfarM/3iW9Yw0Nw4nHkLmfDbEdrCJbUGU926k10+A=;
        b=JLvJJ29p+PonLA4joLef5DDUEnwA/8ZzcoYpxcWsdJDNk6jH2BvjRLNJKJYqjINvTu
         ZjpJ5x/HZsuO33ANP8O2H//Fo9iZ/NRU8umbFxhV7hILTFjn16BQrqcHIi3wdKcDBIJx
         WJOZYQZ4KEwnhgVyfRpkZnYfC4NrrzSIBaTwShqIBDTeTZJWtiYWXs8DO999EM4U3Zqu
         /L5ZRXf9/WmV7KvOzA7GUWFmsn+ncw17Un5ZYZa/oDjxuyNSHx4h4/2nuplCFM/ZoplL
         mlGMNst8q5XGBT4FNxLE9lYpQsHRwWY1JL0YSh0oQ8sQq603YApIMndGsU5uEGUqH5Ux
         +ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778250214; x=1778855014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkPfarM/3iW9Yw0Nw4nHkLmfDbEdrCJbUGU926k10+A=;
        b=awz8fk26iZoQrI/zduTGNV8uhgdff674xo6IHiH1IPtTo+FL/TmShSU1KjFGpiOfC0
         iujEbB6djij3ivXZMRHYNjJCt32s03WMN39w9YTyt2bNETqhL/Prev1p1f9aY8Wgl4y+
         uvCdJsJaDZSYT9ac/3H1kv+1KWTWDUQTC8vxqhK4rTb+0wHqeBrSZMfYwFSz1IhHx+IZ
         ZG6csdwBfMQ6rb9UXp1p39jHs6FyBKy4M7UMRa6rVrppnqZslwhLbKy5qVWXb/+fOJoe
         OQbpRBM77DTB6gv0tT8TXgKd4vTiphfYzjnTyPGrvZT9J1AWCXET76M5gdrKqSNwuVjZ
         URGg==
X-Forwarded-Encrypted: i=1; AFNElJ9t1ZIA6AzaZdtdz2M9fiChPUumwLrrfy4wKqMOmpko9PNoDJqHtyyVvYW+vrpPhqeLHkM65sk67gpm@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQz0UbkTBjamQdR7P6aGs+X2nzdQlTPDsCx+d3Dos/f5UE2vt
	D+SIhXRHIeiTGuzQkcPaJg1GtVSsNVCuZ29r6ag6ZXybxsIN5AVp+agmmHA+HmsRoW92qzw3d+z
	1i+0I1TPZT4seXmZcTG0nw29f+ekGmMul+R4T/Ek=
X-Gm-Gg: Acq92OGMyyndZvqMG292Rphn1v9NjQAFNoYUhb9t7q109BXKewmtZkDFgZpkeLIFFze
	agr5bt8xVhY8ekmBpRuWJyiipVEZgJnrvjo5O+KFIoTJ8iHXSEuKkQKdI4ENR7HzwlIIbB8hcwx
	TkLj8AA0/rBwB0z/qtI7wpx0wzsGMYl5nBIegRv27t3TODXOm7ns0Vem7F9KeQY5V+NbVqyP/G0
	ghuA5N/xfL7oY/QfrDCm74yDAkplXc2UBRDFXC1HCjO5idhPDVRQzV6INlJcyPAJvFVXdjcI29O
	LssNkjnHq1Uby19nGC8kDX+7p2rK2wEnhKPU5ThLgceAe0Qi1Z/fE17UN021g8Zo+9adimFcklo
	6d1KGHg==
X-Received: by 2002:a17:90b:2691:b0:35f:c729:de9b with SMTP id
 98e67ed59e1d1-365ac281592mr13489917a91.20.1778250213984; Fri, 08 May 2026
 07:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOOd5ej7=KFT8+JO8D3g=QnnhJR2+V--a+JSKcpuxUt=tyGyZw@mail.gmail.com>
 <2026050818-divisible-unlocked-e1f7@gregkh>
In-Reply-To: <2026050818-divisible-unlocked-e1f7@gregkh>
From: Henrik Holmberg <pomzm67@gmail.com>
Date: Fri, 8 May 2026 16:23:20 +0200
X-Gm-Features: AVHnY4LCzAtz_1bHG-cW6lxGh3WwdkZFx5fJelCHXitp2ehvkLXVE30E3F1e1jk
Message-ID: <CAOOd5eiJ5V=M-ta2-f5js_9EaxhKSU=qYGo9U9nPseVuW-=3WA@mail.gmail.com>
Subject: Re: [security] RDMA/bnxt_re: kernel infoleak via uninitialised shpg
 shared page exposed to userspace
To: Greg KH <gregkh@linuxfoundation.org>
Cc: security@kernel.org, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, linux-rdma@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000053a2cb06514f2463"
X-Rspamd-Queue-Id: DB4274F7BB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20242-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pomzm67@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email,keybase.io:url]
X-Rspamd-Action: no action

--00000000000053a2cb06514f2463
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Med v=C3=A4nliga h=C3=A4lsningar

Henrik Holmberg

PGP: https://keybase.io/d313373_m3/pgp_keys.asc

Den fre 8 maj 2026 kl 15:51 skrev Greg KH <gregkh@linuxfoundation.org>:
>
> On Fri, May 08, 2026 at 03:45:13PM +0200, Henrik Holmberg wrote:
> > Suggested fix (one-line)
> > ------------------------
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -4375,7 +4375,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext
> > *ctx, struct ib_udata *udata)
> >
> >         uctx->rdev =3D rdev;
> >
> > -       uctx->shpg =3D (void *)__get_free_page(GFP_KERNEL);
> > +       uctx->shpg =3D (void *)get_zeroed_page(GFP_KERNEL);
> >         if (!uctx->shpg) {
> >                 rc =3D -ENOMEM;
> >                 goto fail;
> >
>
> Can you just turn this into a real patch that can be applied, so you get
> full credit for the fix?  The kernel documentation explains how to do
> this.
>
> thanks,
>
> greg k-h

--00000000000053a2cb06514f2463
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-RDMA-bnxt_re-zero-shared-page-before-exposing-to-use.patch"
Content-Disposition: attachment; 
	filename="0001-RDMA-bnxt_re-zero-shared-page-before-exposing-to-use.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mox08tvd0>
X-Attachment-Id: f_mox08tvd0

RnJvbSA5ZDFjNmVkMmY2Yzg2MjU0MjVhNmUxZDU2MmYzMDUzYjY5YTJiMWQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMb3JkIFVsZiBIZW5yaWsgSG9sbWJlcmcgPGhlbnJpay5ob2xt
YmVyZ0BkZWZlbnNpZnkuc2U+CkRhdGU6IEZyaSwgOCBNYXkgMjAyNiAxNjoxNDo1NyArMDIwMApT
dWJqZWN0OiBbUEFUQ0hdIFJETUEvYm54dF9yZTogemVybyBzaGFyZWQgcGFnZSBiZWZvcmUgZXhw
b3NpbmcgdG8gdXNlcnNwYWNlCgpibnh0X3JlX2FsbG9jX3Vjb250ZXh0KCkgYWxsb2NhdGVzIHVj
dHgtPnNocGcgdmlhCl9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVMKS4gVGhlIGJ1ZGR5IGFsbG9j
YXRvciBkb2VzIG5vdCB6ZXJvIHBhZ2VzCndpdGhvdXQgX19HRlBfWkVSTywgc28gdGhlIHBhZ2Ug
Y29udGFpbnMgc3RhbGUga2VybmVsIGRhdGEgZnJvbQp3aGF0ZXZlciBvYmplY3QgbW9zdCByZWNl
bnRseSBmcmVlZCBpdC4KClRoZSBwYWdlIGlzIHRoZW4gbWFwcGVkIGludG8gdXNlcnNwYWNlIHZp
YSB2bV9pbnNlcnRfcGFnZSgpIHVuZGVyCkJOWFRfUkVfTU1BUF9TSF9QQUdFIGluIGJueHRfcmVf
bW1hcCgpLiBUaGUgZHJpdmVyIG9ubHkgZXZlciB3cml0ZXMKNCBieXRlcyAoYSB1MzIgQVZJRCkg
YXQgb2Zmc2V0IEJOWFRfUkVfQVZJRF9PRkZUICgweDEwKSBpbnNpZGUKYm54dF9yZV9jcmVhdGVf
YWgoKTsgdGhlIHJlbWFpbmluZyA0MDkyIGJ5dGVzIG9mIHRoZSBwYWdlIGFyZSBleHBvc2VkCnRv
IHVzZXJzcGFjZSB1bnNhbml0aXNlZCwgbGVha2luZyBrZXJuZWwgbWVtb3J5IGNvbnRlbnRzLgoK
QW55IHVzZXIgd2l0aCBhY2Nlc3MgdG8gL2Rldi9pbmZpbmliYW5kL3V2ZXJic1ggb24gYSBob3N0
IHdpdGggYQpibnh0X3JlIGRldmljZSAodHlwaWNhbGx5IHJkbWEgZ3JvdXAgbWVtYmVyc2hpcCkg
Y2FuIHJlYWQgdGhpcyBkYXRhCnZpYSBhIHNpbmdsZSBtbWFwKCkgYXQgcGdvZmYgMCBhZnRlciBJ
Ql9VU0VSX1ZFUkJTX0NNRF9HRVRfQ09OVEVYVC4KCk90aGVyIHNoYXJlZCBwYWdlcyBpbiB0aGUg
c2FtZSBmaWxlIGFscmVhZHkgdXNlIGdldF96ZXJvZWRfcGFnZSgpCmNvcnJlY3RseToKCiAgZHJp
dmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUvaWJfdmVyYnMuYwogICAgICBzcnEtPnVjdHhfc3Jx
X3BhZ2UgPSAodm9pZCAqKWdldF96ZXJvZWRfcGFnZShHRlBfS0VSTkVMKTsKICAgICAgY3EtPnVj
dHhfY3FfcGFnZSAgPSAodm9pZCAqKWdldF96ZXJvZWRfcGFnZShHRlBfS0VSTkVMKTsKCnVjdHgt
PnNocGcgaXMgdGhlIG9ubHkgb3V0bGllci4gQnJpbmcgaXQgaW4gbGluZSB3aXRoIHRoZSBleGlz
dGluZwpjb252ZW50aW9uIGJ5IHN3aXRjaGluZyB0byBnZXRfemVyb2VkX3BhZ2UoKS4KCkZpeGVz
OiAxYWM1YTQwNDc5NzUgKCJSRE1BL2JueHRfcmU6IEFkZCBibnh0X3JlIFJvQ0UgZHJpdmVyIikK
U2lnbmVkLW9mZi1ieTogTG9yZCBVbGYgSGVucmlrIEhvbG1iZXJnIDxoZW5yaWsuaG9sbWJlcmdA
ZGVmZW5zaWZ5LnNlPgotLS0KIGRyaXZlcnMvaW5maW5pYmFuZC9ody9ibnh0X3JlL2liX3ZlcmJz
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9pYl92ZXJicy5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRfcmUvaWJfdmVyYnMuYwppbmRleCA3ZWQyOTQ1MTZi
N2UuLjM2NWVjMjc2N2QyNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2JueHRf
cmUvaWJfdmVyYnMuYworKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvYm54dF9yZS9pYl92ZXJi
cy5jCkBAIC00NjM4LDcgKzQ2MzgsNyBAQCBpbnQgYm54dF9yZV9hbGxvY191Y29udGV4dChzdHJ1
Y3QgaWJfdWNvbnRleHQgKmN0eCwgc3RydWN0IGliX3VkYXRhICp1ZGF0YSkKIAogCXVjdHgtPnJk
ZXYgPSByZGV2OwogCi0JdWN0eC0+c2hwZyA9ICh2b2lkICopX19nZXRfZnJlZV9wYWdlKEdGUF9L
RVJORUwpOworCXVjdHgtPnNocGcgPSAodm9pZCAqKWdldF96ZXJvZWRfcGFnZShHRlBfS0VSTkVM
KTsKIAlpZiAoIXVjdHgtPnNocGcpIHsKIAkJcmMgPSAtRU5PTUVNOwogCQlnb3RvIGZhaWw7Ci0t
IAoyLjQ3LjMKCg==
--00000000000053a2cb06514f2463--

