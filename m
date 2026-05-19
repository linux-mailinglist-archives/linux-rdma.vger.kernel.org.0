Return-Path: <linux-rdma+bounces-20958-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEngNNYxDGrdZAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20958-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 11:48:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB7857B99D
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 11:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F1B23019950
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215D3E559B;
	Tue, 19 May 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="al354sdi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3E1DE8BB
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182855; cv=none; b=WlNmEznpX/8lAYzJRax8gYJPmmlxH8h9g+2V1V1O/WkpW+heHJj503EkQQDOpvaUdqNuzPO85yUHYJ8A1zGbSbxfV2k4xnjXa4dAgqTUmFjPR0V3RjipIJAcCtJg1xWx7HejYEjUkVxIKQVf8oKwjnvmEuch3rWzhAxFIfs/How=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182855; c=relaxed/simple;
	bh=1N1/0Si/gEkPGwL0d3dh1tWkkj6g87OLJtMnF24IhFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoRHHVjYy5QkhMnXjXxEQBqQeJ3EKFHpOkNBZRSW10wN1korgmLqaX7HKUQesboe4NKGww+7FW3yIUrOMTTXMt6nElj4brbbSK0tAsRPQoS+VozHoLhyUeeDJyx8/vAhrIVa9P9oNb7hqkIBB7/+hBGP8aUtpadxdOFO5CkwJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=al354sdi; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-69d2e3b45a1so1022395eaf.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 02:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182852; x=1779787652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB9l7Ge20GpsgGv+evWhPbrhAHOdVWX6A/UzIZE2y2s=;
        b=MqZt4tv4a0bmmDSTgnBe+d+Vi5Hzm0t3H3zqq9tGjYkZ2c29zGPLenXSH84qcQA121
         aaNZI2SbCUlfqXwI2MLop1qK/aI0ZV6LBnF81/yUFoCploTrppaN4OoYDE3v0HFQ6nv4
         C2JXVfcgmUtW0RFQGQteUTVDKk9qrpnCmcG5P6H9jd4iVc3JirOiyIny0Vc4dL9zwswT
         esPSkc//K1zY0E+NzYp3HEBV+tQ1hIBVHCPZ+DsnEpw8pNF5lgobyC/FC5rGEixuof5C
         FA2JkPZonmS9ry2GXrC7O8qiNemhuU2H7AgTOGbad3z8QABv87DUhjBUhha99OlqRH24
         uQjw==
X-Gm-Message-State: AOJu0YxNguLPMuFh0SV3oxXG+sHZ1ryWpLe182BjakfQWspNXYpO4TED
	P02slme9v6wmNZ9xFEcpwaHrSJRyGQR9cYU75QSca83015OpKaalimODw9UiBfwMTguCb0UroLL
	MGhZvbPtxWdlnrtSfUfRRM2Sq54GyTJ3+e3rFv+j7CWf0aKC2TU83WQ6HgxU+vKLGNwiH3RmFJW
	QmMtuWjh5cAH3C37vFhqwHXqfwTeba1C7sUb1L/uFJn0ARoePZ42RxB0ReUChSnTxRaa0si6qZQ
	ScrOohOnPiv+AwFJR5UoSuyNHmx
X-Gm-Gg: Acq92OEfkfxyZK/hG2WyRMowF1VY8s7JlOdtjZ1PCPNQxP/6JlfGfAfeFzkw5C5TDSJ
	tHLTt9lcMH/JSBr9VvrqSmLvExmcwyW+mlSOcDpwPfZs9F148ota1qO6MrlSWpj22nJoErTeNFo
	THplstivg8XUBJA005j3YooJd3kIkIBn75HuR03l/xcrSdf3FeAsZ4CY2fT5paQuamed/zvpPmI
	zB7FDGkDYB3nYkSdkImehfFr2LKNngvpl2oEAknXWUubcQhQcPe3Pxgmbo4031k78okVBQ4SdvN
	Hzo7xu4eAjz63xwTdSoen/Fe3LurpHRTRR9g6o2zjYwFVDqtjaPiNh58GhhbQUDSREDy3+2ti0B
	B0Wr/O8rhqtzNUA0pFzoLE8w4gYwKvt6eJ01P7wxpd81R/7EvjoEZCjLkPJSXNoFqtmogGXeBdv
	vChEovrqI/AQE02b3b3ustP+zTTuQ/irqgKmHOihSlgbiLE0wX0c/yPWIr0ICJr6T7vyh/
X-Received: by 2002:a05:6820:8185:b0:696:6440:9e33 with SMTP id 006d021491bc7-69c9457dd4fmr11035831eaf.43.1779182852302;
        Tue, 19 May 2026 02:27:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69d048cf4a4sm670708eaf.28.2026.05.19.02.27.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 02:27:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45e81291d62so1624992f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779182850; x=1779787650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AB9l7Ge20GpsgGv+evWhPbrhAHOdVWX6A/UzIZE2y2s=;
        b=al354sdiPLGyzcGTSuwjL8STAqdT5UJB8rt6hWSkORPQ9oOyT/LZyBZj3TsUlHWlaJ
         9GHiLhzStLU3tUu+ZVcxmt2P4pw8AuLKrrHjlLeplgsqG8qe0/dONTZMCF6Jz2RmNx16
         U0BwpNhbdjYOWWpfHRbBOd4psGS2UoEtaHSMo=
X-Received: by 2002:a5d:5f49:0:b0:446:96b1:f53 with SMTP id ffacd0b85a97d-45e5c6000acmr30279265f8f.26.1779182849592;
        Tue, 19 May 2026 02:27:29 -0700 (PDT)
X-Received: by 2002:a5d:5f49:0:b0:446:96b1:f53 with SMTP id
 ffacd0b85a97d-45e5c6000acmr30279211f8f.26.1779182849053; Tue, 19 May 2026
 02:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com> <20260518153721.183749-8-sriharsha.basavapatna@broadcom.com>
In-Reply-To: <20260518153721.183749-8-sriharsha.basavapatna@broadcom.com>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 19 May 2026 14:57:16 +0530
X-Gm-Features: AVHnY4LbWN-9r4yBwo0aznZnKVl7dAbr0783cM8bR3zkllAwk5GckY-YjfMUS5Y
Message-ID: <CAHHeUGWK_2RNG=CaHTnNh2JeAXa9mcTam6p_7Qp6eG+6Nip+_w@mail.gmail.com>
Subject: Re: [PATCH rdma-next v6 7/9] RDMA/bnxt_re: Enhance dpi lifecycle
 logic in doorbell uapis
To: leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c42edb06522849cf"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20958-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: DBB7857B99D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000c42edb06522849cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:17=E2=80=AFPM Sriharsha Basavapatna
<sriharsha.basavapatna@broadcom.com> wrote:
>
> If the DPI is freed when the dbr object is freed, but if the
> process has not unmapped the page yet, then the DPI slot could
> get reallocated to another process while the original process
> still has it mapped. To prevent this, save the DPI info in the
> mmap entry during dbr allocation and free the DPI slot from
> bnxt_re_mmap_free(), which enures that there are no references
> to it.
>
> This change is needed to support doorbell allocation to QPs
> in the next patch.
>
> Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c |  4 ++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
>  drivers/infiniband/hw/bnxt_re/uapi.c     | 12 ++++++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index 9fd85d81bcea..b8e46feafee7 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -4943,6 +4943,10 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_entry=
 *rdma_entry)
>         bnxt_entry =3D container_of(rdma_entry, struct bnxt_re_user_mmap_=
entry,
>                                   rdma_entry);
>
> +       if (bnxt_entry->mmap_flag =3D=3D BNXT_RE_MMAP_UC_DB && bnxt_entry=
->uctx)
> +               bnxt_qplib_free_uc_dpi(&bnxt_entry->uctx->rdev->qplib_res=
,
> +                                      &bnxt_entry->dpi);
> +
>         kfree(bnxt_entry);
>  }
There's a sashiko warning on this change:

"Also, does this introduce a use-after-free during device hot-unplug?
During hot-unplug, the RDMA core tears down the ib_ucontext (which
embeds bnxt_re_ucontext) synchronously. However, active VMAs outlive
the ucontext because hot-unplug only zaps the PTEs without closing the
VMAs. When the process later exits or manually unmaps the memory,
bnxt_re_mmap_free() is triggered. Will dereferencing
bnxt_entry->uctx->rdev->qplib_res result in a use-after-free since the
uctx has already been freed?"

But reviewing the uverbs code, it does look like VMA mappings are
removed during hot-unplug. Also, ib_ucontext seems valid for the
driver to access during this process because dealloc_ucontext() is the
last step in this sequence (called after
uverbs_user_mmap_disassociate()).

ufile_destroy_ucontext(reason =3D=3D RDMA_REMOVE_DRIVER_REMOVE) -->
uverbs_user_mmap_disassociate() --> rdma_user_mmap_entry_put() -->
rdma_user_mmap_entry_free() --> ucontext->device->ops.mmap_free()

Let me know if I'm missing something here.

Thanks,
-Harsha
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.h
> index 13dac48ed453..1caef68a5c38 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -161,6 +161,7 @@ struct bnxt_re_user_mmap_entry {
>         struct bnxt_re_ucontext *uctx;
>         u64 mem_offset;
>         u8 mmap_flag;
> +       struct bnxt_qplib_dpi dpi;
>  };
>
>  struct bnxt_re_dbr_obj {
> diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw=
/bnxt_re/uapi.c
> index b8fc8bfba2ad..866df9206f5a 100644
> --- a/drivers/infiniband/hw/bnxt_re/uapi.c
> +++ b/drivers/infiniband/hw/bnxt_re/uapi.c
> @@ -368,6 +368,12 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(=
struct uverbs_attr_bundle *a
>                 goto free_dpi;
>         }
>
> +       /* Save DPI info to the mmap entry so that bnxt_re_mmap_free()
> +        * can free the DPI slot only after the last reference to the
> +        * mmap entry is released.
> +        */
> +       obj->entry->dpi =3D *dpi;
> +
>         obj->rdev =3D rdev;
>         kref_init(&obj->usecnt);
>         uobj->object =3D obj;
> @@ -396,10 +402,12 @@ void bnxt_re_dbr_kref_release(struct kref *ref)
>  {
>         struct bnxt_re_dbr_obj *obj =3D
>                 container_of(ref, struct bnxt_re_dbr_obj, usecnt);
> -       struct bnxt_re_dev *rdev =3D obj->rdev;
>
> +       /* Drop the driver's reference to the mmap entry (_remove()).
> +        * The DPI slot gets freed from bnxt_re_mmap_free() only
> +        * when there's no VMA mapping reference to it.
> +        */
>         rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
> -       bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
>         kfree(obj);
>  }
>
> --
> 2.51.2.636.ga99f379adf
>

--000000000000c42edb06522849cf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVfQYJKoZIhvcNAQcCoIIVbjCCFWoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLqMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBtjhfzjdPvjfliyW7ek8QLVshjSshq+M0w
PggjOyqM8jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkw
OTI3MzBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBfZ4EzUjZJycd2yW4grg1Y1JJ5zKLB499CvbVCHoe8mKOR8liYD6QZowCYIsSieYq6pJD6
VIspRXBGY2gLv8gA81PQPnKXJ2dpRnYubOf6nLslSUCXhMwzwyjUHOjRSPA4owgVRWEnCri0jBpq
1vnpMSOrxKY+0t/7QHvEDupl42HytrQz5Bge94jBf6Pu6kaidjef5aNuTTea6727aZN9FQK5h5cF
ZgPboVcC6ydzl+EFK3PuT4Sq+2Bu114Tm2tt70ATExjoD9cyU1xilcYolzVf4Y3PZ26xjmFfBaaG
7olFMLmGRaZ5RbG3Juqpnb+29akY5rO8gCc6ntVroj+b
--000000000000c42edb06522849cf--

