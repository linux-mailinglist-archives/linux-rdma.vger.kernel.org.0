Return-Path: <linux-rdma+bounces-7019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172FA11834
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 05:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387923A7AB7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB327155333;
	Wed, 15 Jan 2025 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="byA2KpiL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB16F305
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2025 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913716; cv=none; b=LWp1MECaTApn5992oJ8NxU7WXtjl2zo+gDVcpNl/UsEZXLviyasCKGBHoAt8hPDnv6nSrYmHRtu4ytk0LsJ3tsTs3WA/ooXKq2b+SBQQ67EVi/NGRfqDvPtOYTljFWwAE2qL66RorP8ksBrFki+sEWJ6i67uWimkx3zvxg535v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913716; c=relaxed/simple;
	bh=Vwzn1BYlSEnRZTdd7ouckVv3z70uXk/EbBV1SebN718=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDoZKB2XXzWPROqMVW8mMAnZB499wfWO145FSRrlJhkzrxYeltcmioMT7eMV31UYSP03wCOkiNmXmQqLNSGuakWkERY8gt+t7iX83PWZKKvUWIf1EiNv9ZkFQ/dbHuWAimW0En5rgs6EbbNvCVqpeKhixqGYnFqdGmZfCuerEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=byA2KpiL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef748105deso7849222a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 20:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736913714; x=1737518514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPvlu8jmW+AxCZkn4jHHyw+d9Oyq2wufQnTz5veT2fc=;
        b=byA2KpiLLcR96oigKwbg8NP2xVUaPFm/1MHnZxMu8oglaFdXLTOacS0a5GKLO97Kso
         jx4E9xCq31AQWG9RsoQMEH2r5j4Y0oztAbJ3D8yvbeBGiRGBOwi5f3Kc6qL7936508d5
         Vy/kbxQdZg6m45nsG9fmh0jRhVA+MBs3dQC9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736913714; x=1737518514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPvlu8jmW+AxCZkn4jHHyw+d9Oyq2wufQnTz5veT2fc=;
        b=BT4WElrV8OlpF4ZdCsGMe2syNFkar77Vqoz8jVSne1/bRw0j5z9EyxGX6cqrbLlVcV
         YdzdZI+qldwiNgRvHwgZWDgYPSpeOpbaReX6mhxUYJfIyX1D5bJHPte3Cebddr2YmL19
         8u4gHw0VF0kD4FVuxAqC/rrU242rkhvlWbfUcbpD11lVcs9V0D4NDkWYmEf5x+7SZHFO
         mYo9Hb52spvZUT9LoX7OwHUvc0sk+bpF0OdN9Zb9oZz9ML0XNHQFaSgB57gjNLaTwOkc
         9bNNBYF9Ooal83zHsc3Qhl/LXR5fZJ4J1xMcXXFaIK0RxqXZrbpwMDbBOlSZFThoPRWY
         JZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBSBkkpOMp5R71tziu8Nk6hjY92jMM6Fyw6+V4ua+viibyzrjMtVSi+R6JEcyJcDzaOZM8sK9LvI86@vger.kernel.org
X-Gm-Message-State: AOJu0YzkHIPG3/znV79T4r5WOBiJC0kjQQU6Ak7lVMqdvm8v3M6IRlkk
	Et7BUhU4r0+G9xvO4vtCtRTmeYsf02cgoFOY5SHs3FnRCcgQMic8H5DWG9vJRvfMS7H2OC3Ta/K
	k4PJ3WkAupqaNpatkgKibsCL/ZDr5UpH2kysn
X-Gm-Gg: ASbGncsWgHmSb+UKaUn1QCaYDcEtxco+AINczVkmY9uTUz/6qFk1q2Sz/ygDMFJiOS+
	RGQRNev9roQpy8XUXe6NPy9SAK0Fh5XP+kUrawJI=
X-Google-Smtp-Source: AGHT+IHy0TkxhMDSQ+sLU/tJZcOLmVXHzzp4kPEDPOJfRCM/5jdcIDch9qN07B2FHWLWxv9mIxcudLM7KHUOzWZon44=
X-Received: by 2002:a17:90a:fc48:b0:2ee:b2fe:eeeb with SMTP id
 98e67ed59e1d1-2f548eca9dfmr34012593a91.22.1736913714243; Tue, 14 Jan 2025
 20:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com> <20250114090510.GF3146852@unreal>
In-Reply-To: <20250114090510.GF3146852@unreal>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 15 Jan 2025 09:31:42 +0530
X-Gm-Features: AbW1kvY8gAdFOqmz62zmRAgs4EPdxY9YAUkjF6ntLi9gUEr-Q_RPLrkTobxyXW4
Message-ID: <CAH-L+nPYMQAHwb+k=LDaGwUUFs+j4jPc2tC079GhtyS8fQDrNQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 RESEND 0/4] RDMA/bnxt_re: Support for FW
 async event handling
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f69cdf062bb6bc07"

--000000000000f69cdf062bb6bc07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:35=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Jan 07, 2025 at 08:15:48AM +0530, Kalesh AP wrote:
> > This patch series adds support for FW async event handling
> > in the bnxt_re driver.
> >
> > V1->V2:
> > 1. Rebased on top of the latest "for-next" tree.
> > 2. Split Patch#1 into 2 - one for Ethernet driver changes and
> >    another one for RDMA driver changes.
> > 3. Addressed Leon's comments on Patch#1 and Patch #3.
> > V1: https://lore.kernel.org/linux-rdma/1725363051-19268-1-git-send-emai=
l-selvin.xavier@broadcom.com/T/#t
> >
> > Patch #1:
> > 1. Removed BNXT_EN_FLAG_ULP_STOPPED state check from bnxt_ulp_async_eve=
nts().
> >    The ulp_ops are protected by RCU. This means that during bnxt_unregi=
ster_dev(),
> >    Ethernet driver set the ulp_ops pointer to NULL and do RCU sync befo=
re return
> >    to the RDMA driver.
> >    So ulp_ops and the pointers in ulp_ops are always valid or NULL when=
 the
> >    Ethernet driver references ulp_ops. ULP_STOPPED is a state and shoul=
d be
> >    unrelated to async events. It should not affect whether async events=
 should
> >    or should not be passed to the RDMA driver.
> > 2. Changed Author of Ethernet driver changes to Michael Chan.
> > 3. Removed unnecessary export of function bnxt_ulp_async_events.
> >
> > Patch #3:
> > 1. Removed unnecessary flush_workqueue() before destroy_workqueue()
> > 2. Removed unnecessary NULL assignment after free.
> > 3. Changed to use "ibdev_xxx" and reduce level of couple of logs to deb=
ug.
> >
> > Please review and apply.
> >
> > Regards,
> > Kalesh
> >
> >
> > Kalesh AP (3):
> >   RDMA/bnxt_re: Add Async event handling support
> >   RDMA/bnxt_re: Query firmware defaults of CC params during probe
> >   RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
> >
> > Michael Chan (1):
> >   bnxt_en: Add ULP call to notify async events
> >
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   3 +
> >  drivers/infiniband/hw/bnxt_re/main.c          | 156 ++++++++++++++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   1 +
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.c      | 113 +++++++++++++
> >  drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   3 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  28 ++++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   2 +
> >  8 files changed, 307 insertions(+)
>
> Applied with the following fix
>
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw=
/bnxt_re/main.c
> index 1dc305689d7bb..54dee0f5dd3f5 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1802,30 +1802,22 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *=
rdev)
>
>  static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rdev)
>  {
> -       int rc;
> -
>         if (rdev->is_virtfn)
>                 return;
>
>         memset(&rdev->event_bitmap, 0, sizeof(rdev->event_bitmap));
> -       rc =3D bnxt_register_async_events(rdev->en_dev, &rdev->event_bitm=
ap,
> -                                       ASYNC_EVENT_CMPL_EVENT_ID_DCB_CON=
FIG_CHANGE);
> -       if (rc)
> -               ibdev_err(&rdev->ibdev, "Failed to unregister async event=
");
> +       bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
> +                                  ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_C=
HANGE);
>  }
>
>  static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
>  {
> -       int rc;
> -
>         if (rdev->is_virtfn)
>                 return;
>
>         rdev->event_bitmap |=3D (1 << ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFI=
G_CHANGE);
> -       rc =3D bnxt_register_async_events(rdev->en_dev, &rdev->event_bitm=
ap,
> -                                       ASYNC_EVENT_CMPL_EVENT_ID_DCB_CON=
FIG_CHANGE);
> -       if (rc)
> -               ibdev_err(&rdev->ibdev, "Failed to unregister async event=
");
> +       bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
> +                                  ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_C=
HANGE);
>  }
>
>  static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ulp.c
> index 59c280634bc5f..3e17db0a453e0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -373,9 +373,8 @@ void bnxt_ulp_async_events(struct bnxt *bp, struct hw=
rm_async_event_cmpl *cmpl)
>         rcu_read_unlock();
>  }
>
> -int bnxt_register_async_events(struct bnxt_en_dev *edev,
> -                              unsigned long *events_bmap,
> -                              u16 max_id)
> +void bnxt_register_async_events(struct bnxt_en_dev *edev,
> +                               unsigned long *events_bmap, u16 max_id)
>  {
>         struct net_device *dev =3D edev->net;
>         struct bnxt *bp =3D netdev_priv(dev);
> @@ -387,7 +386,6 @@ int bnxt_register_async_events(struct bnxt_en_dev *ed=
ev,
>         smp_wmb();
>         ulp->max_async_event_id =3D max_id;
>         bnxt_hwrm_func_drv_rgtr(bp, events_bmap, max_id + 1, true);
> -       return 0;
>  }
>  EXPORT_SYMBOL(bnxt_register_async_events);
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ulp.h
> index a21294cf197b8..ee6a5b8562c3e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> @@ -126,6 +126,6 @@ int bnxt_register_dev(struct bnxt_en_dev *edev, struc=
t bnxt_ulp_ops *ulp_ops,
>                       void *handle);
>  void bnxt_unregister_dev(struct bnxt_en_dev *edev);
>  int bnxt_send_msg(struct bnxt_en_dev *edev, struct bnxt_fw_msg *fw_msg);
> -int bnxt_register_async_events(struct bnxt_en_dev *edev,
> -                              unsigned long *events_bmap, u16 max_id);
> +void bnxt_register_async_events(struct bnxt_en_dev *edev,
> +                               unsigned long *events_bmap, u16 max_id);
>  #endif

Makes sense and LGTM, thank you Leon!
>
> >
> > --
> > 2.43.5
> >




--
Regards,
Kalesh AP

--000000000000f69cdf062bb6bc07
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
AQkEMSIEIKPc2tsuf8NG/O+iM/AcMD7k6SKFlvzArIoaehXcXW7/MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDExNTA0MDE1NFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB3oDpx8h9r
FZ2WUbiCb7rHdhFY84zHzX2ZEWUW2XRGbwr/SoJRHxA/mTMGduV1a+Etqlg/D5uihl618YdkBhvP
TxhqEDAnHTBw3fRW7us+5xrYy+B1qArrJFWAojY1JUn3yWSvx+0z/b0zk4kJ/vVbyVgS1n2dvQux
P+K0EU+WTAV+MmxEQWzlPVThKSMHGW/FXvuH0lY06F1wXBCWLZ7jWT29FtHjv329m4CGCMq9TvE5
r0tHlv2jBXhQUNfRIrXXmvnP97Tj1gMlH48YCG5tUjrvy+bzlkBEsP5dPAFmwd8LYiEsDEgfNPRP
kIrVtXxxYlzL9isKLoCjVkN28DjU
--000000000000f69cdf062bb6bc07--

