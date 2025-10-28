Return-Path: <linux-rdma+bounces-14087-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9BC12D1E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 04:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0A874EF61D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 03:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D9E28750F;
	Tue, 28 Oct 2025 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="feJJ498C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC9283FF8
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623939; cv=none; b=WgjycsSguwwh9dlccd+ZKMf6eVyTbEvwBRfIlo9oOREMTHpJmo61res42mq9B85lU3HDMcKwiL+ZdOYBJhm5SEpZ6gTzau2FbmYjbzgDcVQfv5217Z1cQjvm8mwn9mLB4kw/wkbK5wVhMbIuwpjqmjaWwHBvXIb4XGD/vtM+LAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623939; c=relaxed/simple;
	bh=uAU5rqywjjVMmk/njwoHZ6s9HWKxnD7OIiGh7+e6Kws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwIkqrSz5ao9Yl2kI7jYWAApk21QMdDr57FQd6TmLgduinDCOvBKiqXLuCI9MtoB2mDlkr6eW1l/2aKBeYpld+CorAOkMBx9ViNyH18CnChNChd1NOWlQ8VI0wAdbyGR4zWbe7Fr0I7VjRAsQIgaUxDGsyLUcMHLMvrh8oYgWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=feJJ498C; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-934e0a174d2so487909241.0
        for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 20:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761623937; x=1762228737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A2D8rYiHad+tyvTAl/VTygrP9sn1H1RNYGYl5dkI7t0=;
        b=MY33QwVyJmgy5i7UmC7CI87ViCMIYXdG2Ozu7AtYTOuZtEGOpvFuMgvG7iSBCBOAUE
         eiCHCCQyLQ6XQ9+YiEjAPJfs6qODRT7FNM7kmvdh+AvCqdSVmoUlgeOiwS6bJ8fA4hMb
         dld9c+9qZBztyqgcD4reinDhccfycndQ7EkpJZ+qYaddgOwumcGMiaXsc3ddd7moxOPY
         /ffiKXMoqFq+CqETNicFoHu/ZxSWXoq4HUuhq7SA+gzgXqorO0L+57Q9RZ5MynznH0vk
         KI8DwqK0X6ir8rvx8UvFmwfk+lP5r9ilKdZ/YamlWZ+oBjoMw/qbhj6Ikod8YmMDHSI8
         WTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4RxQ0vP8kNn8g40Ccdf/rrsPbZg87Cy2aYgtxbNnVZEkgwOfjUQ/d+nk/3KWx9NatgONsNw6bTwY4@vger.kernel.org
X-Gm-Message-State: AOJu0YziYvcaLKyybDXZM76hPx8PEHd4lnkbiwM5ab+D9b8evM5MAUlD
	3Sn1JgzyGgAefDUuDm1CPKO+uqhRIFN6G2kBoraBfzzFJAdgn3bTeZ5+1OkTjLZFBmLfd9HtIX1
	HBY2+nN7AG8bJQj310w0JMaGxuk7/4rnRvDrl2DPDu2V8acyaxwoNQ0w3PzaCKIxj+nXCggfwN2
	6kUmKYFR9tmYSOo3eXvTFkxbnvn/rNFbw2FsiTk7NWVi2avYtIEfPNed7p/vHlHc5nihlVgdzkv
	XEa705026TcyUtV
X-Gm-Gg: ASbGncssl0n+GhUdnNIy7QQ6RMLtNFiPGkM1XFPHMFQcxeWEh3dhSvje87m+Lu84LRi
	DjfIEMF27zrWQQJCugKkVKSayWNFAVu15BgOO9wrv5nm24Zq3Gg+G5vWrZfIJd8X/HnzD5lq+Co
	dZZ4wxOQQcSQgneA71+Vmxf5qrHJtGytbuhBV0oS7PA45dwwZDjd/2M3lKF3u3ZqD2tRQaQzuDQ
	D6RDCG7vzfuDGrj5aU3zYZ2rD37cdArWtKibPmjOV22Sq7tgAQdWi8Z/EQm0mmYO2nD1imKPF8U
	E0Qnr5RxOrCBYPB9uYHEjNDMObaRsUVXPyS3qTMncaSV74QpmURKsxQvn8y+qwwitbqzY7zz8PJ
	LXfVSnE5mdA+eBss8PLDX9OarLpMgBLnyKGdpqQU1rLo9QuMeI6Ld/DT3+09uG/0hl6A6NqXkYs
	8H2Tf0OvHc2v6pT/Spnp7PlQmK6oayqrGAzQ==
X-Google-Smtp-Source: AGHT+IFNV5txrCUAHQ2HbayzQFRWvZFl1KJZeABC+N3gp+c/dXIv+1e5rnHVdVhS1asKiQtz7WFraBN20VLK
X-Received: by 2002:a05:6122:8c23:b0:552:2c5a:c057 with SMTP id 71dfb90a1353d-5580357dfcfmr691611e0c.13.1761623936906;
        Mon, 27 Oct 2025 20:58:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-557ddaef536sm1103306e0c.2.2025.10.27.20.58.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2025 20:58:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-286a252bfbfso127958195ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761623936; x=1762228736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A2D8rYiHad+tyvTAl/VTygrP9sn1H1RNYGYl5dkI7t0=;
        b=feJJ498CZ0OiEX1ojmBWgTvXOLsqP5Qr4zwd0SVMNlBYf5DYirNPTXj6GdB32fYjza
         0/KcS91xpX96sgfiI0tI6pKo8bhFnjj6Rhd5k71HGeLz8mZEeXqojCFnXupvWkWOzWHq
         mn5PIobD1ivFPAHAKRME4xADd6Q6ryJy8WVvs=
X-Forwarded-Encrypted: i=1; AJvYcCUBeUzVuKKhbqws1v6BrueQfQEegosvdoyf1zzdiYuDLRcokJajuj+e44G5v83rxbLvLR1IrNLBzO3V@vger.kernel.org
X-Received: by 2002:a17:903:2a8c:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-294cb65b9bemr24860775ad.58.1761623935690;
        Mon, 27 Oct 2025 20:58:55 -0700 (PDT)
X-Received: by 2002:a17:903:2a8c:b0:24c:cb60:f6f0 with SMTP id
 d9443c01a7336-294cb65b9bemr24860555ad.58.1761623935350; Mon, 27 Oct 2025
 20:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027201351.GA8995@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20251027201351.GA8995@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 28 Oct 2025 09:28:43 +0530
X-Gm-Features: AWmQ_bl75f7dqjFbUVPcV9v4im1W7jAziU_Y-4tInbqHdouUMsSEqWvfCXgRlgk
Message-ID: <CALs4sv2_rXfTonX2E6Ny_SWb6p-R4_WkDpr+gaFK4yWOVO4s_A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com, 
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f063c70642300818"

--000000000000f063c70642300818
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:45=E2=80=AFAM Dipayaan Roy
<dipayanroy@linux.microsoft.com> wrote:
>
> Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detecte=
d
> and a device-controlled port reset for all queues can be scheduled to a
> ordered workqueue. The reset for all queues on stall detection is
> recomended by hardware team.
>
> The change introduces a single ordered workqueue
> ("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
> queues exactly one work_struct per port onto it. This achieves:
>
>   * Global FIFO across all port reset requests (alloc_ordered_workqueue).
>   * Natural per-port de-duplication: the same work_struct cannot be
>     queued twice while pending/running.
>   * Avoids hogging a per-CPU kworker for long, may-sleep reset paths
>     (WQ_UNBOUND).
>   * Guarantees forward progress during memory pressure
>     (WQ_MEM_RECLAIM rescuer).
>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
> Changes in v2:
>   - Fixed cosmetic changes.
> ---

You must wait at least 24 hours before posting a new revision.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--000000000000f063c70642300818
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCH3NRa
DhmYA6nz0B6GgDpg+RwxgnkGYwYslnA434tOaTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMjgwMzU4NTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCrxaE0+7Uh3Aht0IMqpCfQp7/IT1APCC76QOwQwLq2
ENzlAEK47KkDD2H6YqHiUOnEF6jUlpRv+aGhf7dh+koRTCH5p4BYDSCXL60I3R0bdKEabjo0wAth
lSmG0/YcfY/YVj4AKGY+91kXMUZlaRCljO6Hk87MP/lQlpytaby9Zb40M7taNHXe/E96jr3L5FU/
93NAzTcfyrY4jjebmSpUM8c37io70U/rH3MiIxwgv0VFADFYfyaYkArjw7wKw+rtB4P2tR1rRgUF
5hAR3uQ5AG/fShpAo6puHVPmOp+1QvKiJvxYJtFTBXcXb3LZ9t81AZEPv3vhnHzH4ixlv/1C
--000000000000f063c70642300818--

