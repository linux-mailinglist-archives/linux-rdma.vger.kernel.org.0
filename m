Return-Path: <linux-rdma+bounces-14750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05758C837D9
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 07:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A588434ABB5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 06:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917F32957C2;
	Tue, 25 Nov 2025 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F32E+5WJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74D292B54
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764052445; cv=none; b=AZrumMRE3xfg53wstNNJvORWSwrWSOk17p4QOxjqrj5JiSO7oSvpyHu+QmR/nKp/YhOfcS9IW6F1WFKufJ/qGaX1R+J4JXzjHvJ/DsNw/r8n5pD61QrBnjaOrOZgOyN/FMeBG9qXVL6Hh9WeK1lb4V3z5XxA5h6N2I6i8VWrcn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764052445; c=relaxed/simple;
	bh=D/fjV/y7xysGg3Tq5j41Gg3VkRVtdCwbKCTS07RKY4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKXPYNBxTptXLPMDJMraCubvdsySAkzf38Pp8tbofAxLyAOIj644vOwzgxIGAWAAeOsYlkX4FMXIP3FIlz2VnLkNfIHUZIpb+gg3DS29yg3g0Rl3AGgnFWNDuF9iqMg59OZXAAQYR3USih4cd8PeLmSxjqcBFNICLEDSFurppps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F32E+5WJ; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29845b06dd2so63813275ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 24 Nov 2025 22:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764052443; x=1764657243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5csvqF9+OHO9csXrS7mtq6mKG9R4UPCem+NVDbjrrU=;
        b=aoX/bFh9gRa91gbYiqN1LvdFmSpicYFef+MVUmM09kmwE9YvwO4xmgRQDajq55Otz1
         mg4isBFc9uQDYZNSx5KXfrWIXXJLDg8QQT+MVgDJfE3ZA4ytjp9ZumqSDqtX/+2sdqFA
         wZ4GPjdYxQZTVq7gynzxxrH3wK9I1ZrspFGGVYTj5hiXH/nS+i+tJUj3yYb+YwSfLGZc
         ItE7OtFzct4WlsYyahFowQg7gwyhBYJvdzxY7JEfXem6/PeVLSld3AGNlGTzoreCaTAZ
         ywRcSUT3Hh2JOj1tBuGP+/uMgHzFqfYlLncI2bN28g5k82vFwyMpKL/8+d6aSSlKOpFP
         A3dg==
X-Forwarded-Encrypted: i=1; AJvYcCXxEoQAxQ14tZlIDHw1waeXiHQJUi1qjnYKpJcK31aKEl1VMSi+TH+7+rlnfly3KTEX21kjA3TozSsX@vger.kernel.org
X-Gm-Message-State: AOJu0YyLytFpQ6P228GqBdmgiMw/vJ61Vk1515aciDSfr7L5uKE1H+0F
	cShVNKKItQuY5RzatJc3F2UFWpe2bgFD2Rp6MiiDiH/S7y/jjS8QjBG8K1tItvQ/sm+wSDNWiH7
	3BaKRScChb7lQr/Hp5oWEvxiShqAOuY0Pjov8tSWxzNPTOtRnmqBxoGf8KVYV6MHPHnfM+uTMV7
	FXEKWK5UekzmC4+k/BT0ksspflw3TTvXIVp5eyfTfSSfYLhT2I47OERbTPguFRhREkOUYq86qqr
	JysoYicNAI6LNA=
X-Gm-Gg: ASbGncs3/xt3wO7pVtr6JtC2gtqMjvLBnCY+AGpUrc/UcL6ScUndfLgDOgF3R/Ot/fL
	6mB9JhA/MH3lM64IP3jrQFhWY8Xq1A0PvcSHt2bZHUDSrlc1mZFJyIg11+4mBNiUzTChiO4WVhS
	xG8ehyus/VsSB2G11M0UtilTTNv+Q8tVqqyhId2p0YWHihA01DoswTqHTLbhnSNvDdKngyfKTuF
	KcjbFypCEtgn4ArcSVgVyjQCbK/26VBgqt6tdVpIy4yb2daCsRFkGzQ6uu18DsHLaIRNjO4bVBc
	uda/wHJNvY1RgaJFGnlCfj16nuSWnznvLnq5VQheMjOhzYchMpwi8KGBRrJrSQ72xndeGJRvqRw
	BxhJhovOqo9FUkSNDm6t1P5D3UFAkjE0XKemdDpBPEYoZ3AEuW8tSNiP3MmhIL29eBZ6VtZXTAR
	/h2y2JK47wAKJ3q34uKrOX3wvwvOBRAf6pz+Nb3peXqVA=
X-Google-Smtp-Source: AGHT+IHoMMRg1ndhp1V7WWRaSW3hPoEeu20f4j+CzQ0eXbohu5w8idhmkbtUoIKmNI0vWAs6hD9qlBJFpCKo
X-Received: by 2002:a17:902:ccca:b0:297:f2e7:96f3 with SMTP id d9443c01a7336-29b6c6b693cmr174167255ad.50.1764052442867;
        Mon, 24 Nov 2025 22:34:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-bd75e9aea8csm656364a12.7.2025.11.24.22.34.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2025 22:34:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34378c914b4so14506161a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 24 Nov 2025 22:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764052441; x=1764657241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e5csvqF9+OHO9csXrS7mtq6mKG9R4UPCem+NVDbjrrU=;
        b=F32E+5WJZ7RQBnEraqtPKxSoDJP9l9n1rKUo+UzJFMW1Pn06Nlcaq9PUS2zgI/azyS
         VEuz374gKZzYxSaGreKOrzufc+Q+vjHTHavDo4TORJaedH/RvJFZ/yA6HDPF8C+VgDLC
         O3HVgOWxZ2uUjtwbKW+u15o9CNJC4EafAR53U=
X-Forwarded-Encrypted: i=1; AJvYcCXSQQeP+SRmS9E03fu98KWt0rxt3FdLMwjI33cMjrQFJcSk+uwGNAYKkFl2gbYCKqul2qSHi07Fb2/+@vger.kernel.org
X-Received: by 2002:a17:90b:4b03:b0:343:747e:2cab with SMTP id 98e67ed59e1d1-34733e2d39emr13620306a91.8.1764052440937;
        Mon, 24 Nov 2025 22:34:00 -0800 (PST)
X-Received: by 2002:a17:90b:4b03:b0:343:747e:2cab with SMTP id
 98e67ed59e1d1-34733e2d39emr13620289a91.8.1764052440513; Mon, 24 Nov 2025
 22:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
 <20251117171136.128193-6-siva.kallam@broadcom.com> <aSSLZZM4vgG_SZcm@horms.kernel.org>
In-Reply-To: <aSSLZZM4vgG_SZcm@horms.kernel.org>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Tue, 25 Nov 2025 12:03:48 +0530
X-Gm-Features: AWmQ_bkS0ys5OB0BJOl2SFQj9HYOHeSM6-qybqzHQolPZ-uE8kALZvwo3pMOxRQ
Message-ID: <CAMet4B6+dUU+2pPhPm7hf08+Q=dpwwq3JeT__Sv8vmktgRvMBg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] RDMA/bng_re: Add infrastructure for enabling
 Firmware channel
To: Simon Horman <horms@kernel.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, usman.ansari@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002152ee064465779d"

--0000000000002152ee064465779d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 10:14=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Mon, Nov 17, 2025 at 05:11:23PM +0000, Siva Reddy Kallam wrote:
>
> ...
>
> > diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniban=
d/hw/bng_re/bng_dev.c
>
> ...
>
> > @@ -105,6 +105,69 @@ static void bng_re_fill_fw_msg(struct bnge_fw_msg =
*fw_msg, void *msg,
> >       fw_msg->timeout =3D timeout;
> >  }
> >
> > +static int bng_re_net_ring_free(struct bng_re_dev *rdev,
> > +                             u16 fw_ring_id, int type)
> > +{
> > +     struct bnge_auxr_dev *aux_dev =3D rdev->aux_dev;
>
> Hi Siva,
>
> rdev is dereferenced unconditionally here...
>
> > +     struct hwrm_ring_free_input req =3D {};
> > +     struct hwrm_ring_free_output resp;
> > +     struct bnge_fw_msg fw_msg =3D {};
> > +     int rc =3D -EINVAL;
> > +
> > +     if (!rdev)
> > +             return rc;
>
> ... but it is assumed that rdev may be NULL here.
>
> This does not seem consistent.
>
> IMHO a good approach would be to drop this check, and the one below,
> and only call bng_re_net_ring_free() in contexts where  rdev
> and aux_dev are not NULL.
>
> But I didn't look carefully to see if that idea matches the rest
> of the code.
>
> Flagged by Smatch.
Thanks Simon, it is a good catch. I will send a patch to fix this.
>
> > +
> > +     if (!aux_dev)
> > +             return rc;
> > +
> > +     bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_FREE);
> > +     req.ring_type =3D type;
> > +     req.ring_id =3D cpu_to_le16(fw_ring_id);
> > +     bng_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&r=
esp,
> > +                         sizeof(resp), BNGE_DFLT_HWRM_CMD_TIMEOUT);
> > +     rc =3D bnge_send_msg(aux_dev, &fw_msg);
> > +     if (rc)
> > +             ibdev_err(&rdev->ibdev, "Failed to free HW ring:%d :%#x",
> > +                       req.ring_id, rc);
> > +     return rc;
> > +}
>
> ...
>
> > diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband=
/hw/bng_re/bng_fw.c
>
> ...
>
> > +static int bng_re_process_qp_event(struct bng_re_rcfw *rcfw,
> > +                                struct creq_qp_event *qp_event,
> > +                                u32 *num_wait)
> > +{
> > +     struct bng_re_hwq *hwq =3D &rcfw->cmdq.hwq;
> > +     struct bng_re_crsqe *crsqe;
> > +     u32 req_size;
> > +     u16 cookie;
> > +     bool is_waiter_alive;
> > +     struct pci_dev *pdev;
> > +     u32 wait_cmds =3D 0;
> > +     int rc =3D 0;
>
> rc is always 0, so it may be slightly nicer to remove this variable and
> simply return 0.
>
> Flagged by Coccinelle.
Thanks Simon. I will send a patch to fix this.
>
> > +
> > +     pdev =3D rcfw->pdev;
> > +     switch (qp_event->event) {
> > +     case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
> > +             dev_err(&pdev->dev, "Received QP error notification\n");
> > +             break;
> > +     default:
> > +             /*
> > +              * Command Response
> > +              * cmdq->lock needs to be acquired to synchronie
> > +              * the command send and completion reaping. This function
> > +              * is always called with creq->lock held. Using
> > +              * the nested variant of spin_lock.
> > +              *
> > +              */
> > +
> > +             spin_lock_nested(&hwq->lock, SINGLE_DEPTH_NESTING);
> > +             cookie =3D le16_to_cpu(qp_event->cookie);
> > +             cookie &=3D BNG_FW_MAX_COOKIE_VALUE;
> > +             crsqe =3D &rcfw->crsqe_tbl[cookie];
> > +
> > +             if (WARN_ONCE(test_bit(FIRMWARE_STALL_DETECTED,
> > +                                    &rcfw->cmdq.flags),
> > +                 "Unreponsive rcfw channel detected.!!")) {
> > +                     dev_info(&pdev->dev,
> > +                              "rcfw timedout: cookie =3D %#x, free_slo=
ts =3D %d",
> > +                              cookie, crsqe->free_slots);
> > +                     spin_unlock(&hwq->lock);
> > +                     return rc;
> > +             }
> > +
> > +             if (crsqe->is_waiter_alive) {
> > +                     if (crsqe->resp) {
> > +                             memcpy(crsqe->resp, qp_event, sizeof(*qp_=
event));
> > +                             /* Insert write memory barrier to ensure =
that
> > +                              * response data is copied before clearin=
g the
> > +                              * flags
> > +                              */
> > +                             smp_wmb();
> > +                     }
> > +             }
> > +
> > +             wait_cmds++;
> > +
> > +             req_size =3D crsqe->req_size;
> > +             is_waiter_alive =3D crsqe->is_waiter_alive;
> > +
> > +             crsqe->req_size =3D 0;
> > +             if (!is_waiter_alive)
> > +                     crsqe->resp =3D NULL;
> > +
> > +             crsqe->is_in_used =3D false;
> > +
> > +             hwq->cons +=3D req_size;
> > +
> > +             spin_unlock(&hwq->lock);
> > +     }
> > +     *num_wait +=3D wait_cmds;
> > +     return rc;
> > +}
>
> ...

--0000000000002152ee064465779d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fyIFUZVWSBcxHWtNNVK4Oi0mqSJut0p/SwfLg6IMaVBU9VdXgVmw35CgcX/9B1ITmih041Oz+Qyo
wTULsXik3lHJuyhYevN9h4259CoDPt+tpaykVaqa4luUmGv8k3F6aC4+fZl83ywHGVun9fBVk/GE
2hmynyIEon1w6Me72fdjaPht4V1tbZBu/76zGxBiBFc13nAKU0dYrvIGPgKN9j0HDuOVC7UhhdTq
Gw+wN3sPJk9D2VtNAzNGw0sa/eJF1wQiBy4RVYG9r0MCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYD
VR0RBBwwGoEYc2l2YS5rYWxsYW1AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBTNBMIvX7vsfxNYWor1Hxth
tmNmHzANBgkqhkiG9w0BAQsFAAOCAgEAJDoTbZO7LdV1ut7GZK90O0jIsqSEJT1CqxcFnoWsIoxV
i/YuVL61y6Pm+Twv6/qzkLprsYs7SNIf/JfosIRPSFz6S7Yuq9sGXNKpdPyCaALMbWtPQDwdNhT7
uJgZw5Rq9FQRZgAJNC9+HBtCdnzIW5GUmw040YclUNHFEKDfycJMKjSPez044QcDoN0T2mIzOM8O
Dt+sJTrC1YJ6+HI6F2H6igZUL79y9qYUz8FNshyITihg/1VBVCiMU9WRK3tNfUlLFzLBuTTr245d
xMh/e75vypL3qDSF4UG6Mpy++Plsnjfwab70KFFyCvNwB2hT1g/y8MLgslfxJl6fCyGdWqOmUB2J
QiuiqbSy8mlnucIPuGWQqqt8VBQjxKYIHdjXtkvw0uVvOHUC2QJWfGWDhMncxF5LFoaRPer4tlXJ
b5zmz9Mn+uQPQQLYUqYzs+EvX1REmGLGUuzlaNwAC20+8CVPY2EkU1mjU78+aW5Zbb2MyjQrLc6J
5IdkekEtk+xjpM992MC/aNMTpWIWhorGq8NmPXbuoUZf9MSi7WrVCaO69ro68FXPTErr/e13lJ/5
GAkwcxdTC+YVPVa/xpdHyAFW03/Oow/7fV8qjy6PAWfqEV97D2Tspc2aEFkbeuFS6UkPRy1OKjGc
/IUTSY4h9roe7Bh1ecqtofP9XL8E88sxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMZ1
5rEk8PUoiZ4JXCoj9QcD9Ho5ZTtZe3PmqcoisOqTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTEyNTA2MzQwMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHxKPouS5Ird00kBzoYa+sI0nxKchkyZo3v35VJK
8qA8t4W67JmCiZ3DIlICiVVHeopI5iCRUwM3VyznRyk5YNqHf8ZpDDZRSQKRn7rre8vRXiJc1EJD
zPLFk2Y1AR+XXpPhgnHtVl0Cr1xPNkRxheqOeq1Q994g9ms8zEGyhwcwO0soegMJP2II0EF3K+eY
aSWuvR9fpOFF+1dMgnEweX5iQRm6YI7CmZ0lvZsB06Tqo6/h/0TUAhWjcG0LRGfJcXTgrU1/VCw1
wVuduMWO01nxkAmFIA0+lCx+folAukS3EyZTOqItYEcFdOPMA5zAVmpn+o+KIblmytSpYFci9GE=
--0000000000002152ee064465779d--

