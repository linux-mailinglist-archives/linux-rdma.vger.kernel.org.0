Return-Path: <linux-rdma+bounces-4811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D197050B
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2024 06:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CAC1C2137E
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Sep 2024 04:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D672A8D7;
	Sun,  8 Sep 2024 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VbszXem1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E51B85FC
	for <linux-rdma@vger.kernel.org>; Sun,  8 Sep 2024 04:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725769315; cv=none; b=a0aCNtbT7gwNgRSzeD1jt8Yv/T4hxT/lOonYwxxUu/PiFKw12M+P3Z6sEEyAtQ9GpY8oExiALLfGVgWWgCkXotwEopmtY2E3P7bNRT5ratQPinE8/Tco+Y8D/C2rinrrx7mS77OE3gAfkp5itV6pYHFhWZ6p14PCPiMy7HS1rFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725769315; c=relaxed/simple;
	bh=iNfkM4xTbxXKA4zzM29cUZIJ0AdJOzl/YtRQ6HhrKGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctwxF5x9BvxnZQ9io9H0RZzC9LUzMdHcn7/4gAYsAD45PBppyXPZC1ieiDTJcgo3/UfkaabInW1vmsTIynNMgAI4OlxY0XX89NInuVFerBxnB+dhqsDptwmy7iLphT4BWvC99X6tPxgW6JQL9ipY07DtFGuxtZmPkrQ6iAlmiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VbszXem1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53568ffc525so4431810e87.0
        for <linux-rdma@vger.kernel.org>; Sat, 07 Sep 2024 21:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725769311; x=1726374111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QIUkUayC/7Ewa53fTKFTuZRh10H/sh8KUwApP/gCbc8=;
        b=VbszXem1cFQiTR5/NAbD0jaapgBVzSkICDkweqKE3gJ4vwN5dEyYEdEK/j7rbhOTY7
         UsA4Fgyk7XOQDY5tdphA9EwG2f/NCqfPGCpzn+XPygM2FXIPBjnAbvG69C2jN7fsqwnl
         IcwK/imMSsGPPwLsoasjJln99ZFKhG8q4bFbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725769311; x=1726374111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIUkUayC/7Ewa53fTKFTuZRh10H/sh8KUwApP/gCbc8=;
        b=oIAaeD+GmIQXnsEzmXsDWuttcmq2ubig0S9rtC1bpl7jI/0TV5F7Nw8cz6XBuH3Fap
         pTkAVnVSAHcT3wf1ECd/7DvTDDuXvqjgFoI/C5Ln1TJ/e5Nw3abNVwRRQz5zDRbkeT+O
         OOPSfUTJt/vpC+zDj+ZFKLIYdA2E+wGKpC9urDmBwjIZyvmGqheUddVrNEIrnH6EK5tP
         RZqw66H6suiBKx7hlIIy/fTWW/x5Qf9XQ+i7KUyATtnReiftNWAa2+a5Hfnvx+lLT9tx
         OlPfocVTnJajA8LWeg40H9g2llFSXMMdPnGPovAn8jf8SERo2DVCR9xHAuiShNZVd439
         oZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBtyxxkVHe3uE5IokQAjc91M6qNSj+tR6b0JtXPqXX3ovWkf+RiDmuQ7elZjRzfTzjxsD/ixVT/rsY@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5JTBve9RhRoeU4jwI61usZGmbL9499zl5LMBil8/gWa4M02w
	V+EmKZu1cSBRugENTw1IAQOym26FrTn20S3Z8DyPR67xKvcuW2flZPPkpQQ8wx8EfTNvyb/nNfm
	xi+rqGqbeDjUPtN+kIlbBWDwRNGs+sfhderRf
X-Google-Smtp-Source: AGHT+IGsYPx35J2D3oOobTTqUcVAYJBOg1TlCJ+LGL+l8k0dN3bhZb06EPvvC6LAzepnq5QYCqmTp9MG0skJFP4dC94=
X-Received: by 2002:a05:6512:6cd:b0:533:4560:48b7 with SMTP id
 2adb3069b0e04-536587b4595mr5124532e87.30.1725769311360; Sat, 07 Sep 2024
 21:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907083822.100942-1-zhangzekun11@huawei.com> <20240907083822.100942-2-zhangzekun11@huawei.com>
In-Reply-To: <20240907083822.100942-2-zhangzekun11@huawei.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Sun, 8 Sep 2024 09:51:38 +0530
Message-ID: <CAH-L+nMChUr6N2PY+M=nAtRhDP0jfijKmrao=VZHR4TiGVfxwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] IB/iser: Remove unused declaration in heder file
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: sagi@grimberg.me, mgurtovoy@nvidia.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org, dennis.dalessandro@cornelisnetworks.com, 
	chenjun102@huawei.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cd1f9e062193faa5"

--000000000000cd1f9e062193faa5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Typo in the commit title, s/heder/header

Looks good to me otherwise.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

On Sat, Sep 7, 2024 at 2:22=E2=80=AFPM Zhang Zekun <zhangzekun11@huawei.com=
> wrote:
>
> The definition of iser_finalize_rdma_unaligned_sg() has been removed
> since commit dd0107a08996 ("IB/iser: set block queue_virt_boundary").
> Let's remove the unused declaration in header file.
>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniban=
d/ulp/iser/iscsi_iser.h
> index 68429a5f796d..1d7ac24c4c00 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.h
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
> @@ -507,10 +507,6 @@ void iser_task_rdma_finalize(struct iscsi_iser_task =
*task);
>
>  void iser_free_rx_descriptors(struct iser_conn *iser_conn);
>
> -void iser_finalize_rdma_unaligned_sg(struct iscsi_iser_task *iser_task,
> -                                    struct iser_data_buf *mem,
> -                                    enum iser_data_dir cmd_dir);
> -
>  int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
>                          enum iser_data_dir dir,
>                          bool all_imm);
> --
> 2.17.1
>
>


--=20
Regards,
Kalesh A P

--000000000000cd1f9e062193faa5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIDbrT/dMmpFkNKbjPo7lxMLyCy5nrBkTdnA0QJY7yzMvMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkwODA0MjE1MVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBmsHYxLz6c
d/dK9IA8t8sxhW+9Cr4VazasSvcxCJKlY9gPTCt57J/rKpWQaFTapNOeFrEdKCPY6G25m+y8q5rl
vG/7BvBo6ojj74O73IY3/4OZlSKrQd7UwxK/CAH1FogVKtCEi7W16wU5yfqbaRwwvUfcN4ZHETy1
dxNgu+YchXGuh/MThdgcdrrJUjkGwH+EodplTXW+toDnbT7/H8deg9BmJvFQZFQq/O4yvq0uSc5x
+mrR4aKF2r5zIJqNiS+3L0ms0/QIHtO5RirZGy9VbDlAVjMvNmaUDf4CFGjJyVf/Uz3QQ/Mk5oPX
5mnmotMPqMfF9fYfISfdSTcl4oHH
--000000000000cd1f9e062193faa5--

