Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E523408B0B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbhIMM3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbhIMM3j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Sep 2021 08:29:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01B5C061762
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 05:28:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so6362205pjq.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :in-reply-to;
        bh=JZTda74Kq3QYhEYCjgTieCET7EnLc4yv6QvggaYEMvw=;
        b=Alp8c6IX/+e+lh2JIL4+l7d92Lpt3gYPQ43NhFVvGyjavQ8Bleot8u/CFYToO2ULEV
         tRqdk1MRtO6Imabi30mdJQn7YrzLnQJq7L1ouxbzmak/GtEDKOx0r5c2i1ozDlHnTNk5
         BsBlKm/b3AS5T3C/llZA/pfHxj8d7QCwGLstk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:in-reply-to;
        bh=JZTda74Kq3QYhEYCjgTieCET7EnLc4yv6QvggaYEMvw=;
        b=k/YnQZgG2DJU0RBqrl9iyCrRaKyvZEfe3nXcYI8T9tkUjLyE/BQWnRjJgEOoobH/2H
         GZfKajovetQVjRqzWhgEXd9t92rBA7h6gHbtE93T5Yk8dDcTY7xcxgi2GsoW8gyySWCh
         jDhw8U2c//b0YSJ+9a7kUpVleA+SPHfyCI6J1ebsiTX2smRI8QBhWHfz3Re75npYeotJ
         uLyT+eFh33bilvJfsDhOsH386oR+hcFFQ8sR7dH6vK7GfJ8BIicoLKQ/at3fBBANdR0+
         IpIAolx4hplbYK6ztqsvwE1B1SzFw5DDL8CABTNin4BAXhW1n+yyOAvuoPAgH18qUY3Q
         paBw==
X-Gm-Message-State: AOAM533tZV07YSNhjIxReM9YrQNsH02QcrfoeOFnxXGUWuz8Xtv7yDOq
        0+4my+7P/D8IM1K90F1KLeFZBQ==
X-Google-Smtp-Source: ABdhPJydyUrdgn2GkOaooDUqNmi5BiXG9Aad6nJKd9OkmSSDBR0CmT9FUSjiUokWBFOs2eF+mHQltA==
X-Received: by 2002:a17:902:bd42:b0:138:d3ca:c387 with SMTP id b2-20020a170902bd4200b00138d3cac387mr10302804plx.51.1631536102943;
        Mon, 13 Sep 2021 05:28:22 -0700 (PDT)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x22sm7060823pfm.102.2021.09.13.05.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 05:28:22 -0700 (PDT)
From:   Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date:   Mon, 13 Sep 2021 08:28:11 -0400
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Felix.Kuehling@amd.com, Shaoyun.Liu@amd.com, Jay.Cornwall@amd.com,
        andrew.gospodarek@broadcom.com, michael.chan@broadcom.com
Subject: Re: [PATCH] PCI: Do not enable pci atomics on VFs
Message-ID: <YT9D25ix7jCOkZ0T@C02YVCJELVCG.dhcp.broadcom.net>
References: <1631354585-16597-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1631354585-16597-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e2f19c05cbdf99ab"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000e2f19c05cbdf99ab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 11, 2021 at 03:03:05AM -0700, Selvin Xavier wrote:
> Host crashes when pci_enable_atomic_ops_to_root is called for VFs
> with virtual buses. The virtual buses added to SR-IOV has bus->self
> set to  NULL and host crashes due to this.
	^^ I _hate_ to say this, but the extra space isn't ideal.  Not
sure if the maintainers will want to hold-up the submission for this (or
if they can fix while committing), but something to look out for next
time.

> 
> PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
>  #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
>  #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
>  #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
>  #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
>  #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
>  #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
>  #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
>     [exception RIP: pcie_capability_read_dword+28]
>     RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
>     RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 0000000000000000
>     RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 0000000000000000
>     RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f8
>     R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab000
>     R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c8
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at ffffffffb95359a6
>  #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at ffffffffc08c1a33 [bnxt_re]
>  #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
>     RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
>     RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
>     RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
>     R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
>     R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
>     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
> 
> AtomicOp Requester Enable bit in the Device Control 2 register
> is reserved for VFs and drivers shouldn't enable it for VFs.
> Adding a check to return EINVAL if pci_enable_atomic_ops_to_root
> is called with VF pci device.
> 
> Fixes: 35f5ace5dea4 ("RDMA/bnxt_re: Enable global atomic ops if platform supports")
> Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>

Thanks for this, Selvin.  Technically this looks like a good fix.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575..d968a36 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3702,6 +3702,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  	struct pci_dev *bridge;
>  	u32 cap, ctl2;
>  
> +	/*
> +	 * As per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable
> +	 * bit in the Device Control 2 register is reserved in VFs and the PF
> +	 * value applies to all associated VFs. Return -EINVAL if called for VFs.
> +	 */
> +	if (dev->is_virtfn)
> +		return -EINVAL;
> +
>  	if (!pci_is_pcie(dev))
>  		return -EINVAL;
>  
> -- 
> 2.5.5
> 

--000000000000e2f19c05cbdf99ab
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
XzCCBVkwggRBoAMCAQICDBPdG+g0KtOPKKsBCTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxNDAyMzhaFw0yMjA5MjIxNDExNTVaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGDAWBgNVBAMTD0FuZHkgR29zcG9kYXJlazEtMCsGCSqGSIb3
DQEJARYeYW5kcmV3Lmdvc3BvZGFyZWtAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAp9JFtMqwgpbnvA3lNVCpnR5ehv0kWK9zMpw2VWslbEZq4WxlXr1zZLZEFo9Y
rdIZ0jlxwJ4QGYCvxE093p9easqc7NMemeMg7JpF63hhjCksrGnsxb6jCVUreXPSpBDD0cjaE409
9yo/J5OQORNPelDd4Ihod6g0XlcxOLtlTk1F0SOODSjBZvaDm0zteqiVZb+7xgle3NOSZm3kiCby
iRuyS0gMTdQN3gdgwal9iC3cSXHMZFBXyQz+JGSHomhPC66L6j4t6dUqSTdSP07wg38ZPV6ct/Sv
/O2HcK+E/yYkdMXrDBgcOelO4t8AYHhmedCIvFVp4pFb2oit9tBuFQIDAQABo4IB3zCCAdswDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDApBgNVHREEIjAggR5hbmRyZXcuZ29zcG9kYXJla0Bicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKARn7Ud
RlGu+rBdUDirYE+Ee4TeMA0GCSqGSIb3DQEBCwUAA4IBAQAcWqh4fdwhDN0+MKyH7Mj0vS10E7xg
mDetQhQ+twwKk5qPe3tJXrjD/NyZzrUgguNaE+X97jRsEbszO7BqdnM0j5vLDOmzb7d6qeNluJvk
OYyzItlqZk9cJPoP9sD8w3lr2GRcajj5JCKV4pd2PX/i7r30Qco0VnloXpiesFmNTXQqD6lguUyn
nb7IGM3v/Nb7NTFH8/KUVg33xw829ztuGrOvfrHfBbeVcUoOHEHObXoaofYOJjtmSOQdMeJIiBgP
XEpJG8/HB8t4FF6A8W++4cHhv0+ayyEnznrbOCn6WUmIvV2WiJymRpvRG7Hhdlk0zA97MRpqK5yn
ai3dQ6VvMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIM
E90b6DQq048oqwEJMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDSimZqB73truhX
IrP/ymjC4a2mg8o7hnr+PDzqW/Bk8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMTA5MTMxMjI4MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAmtCv1mWbQwryzTm35CgNhPr5wtNu78lZ
XIf4MYxtkSjShJ9Akdx8FOQuWJeEgkhV7bkT4xAQoxI0dyqViFEGx2N6So7CJOL5QxBD3wdFKsFa
ku/g7xA/yzeZKjQUSDCm83MwSd1H6iz40c/fjA/7HNC/RufRW+T0VOqmsQj8M7kt/X+LQyL5K3pX
fZMdvaxpbONMV9gWZKLVD6h56gibTe8nSRP3v/bwdNyt1WCIVFiFwgPTLZyAYkNLNIwVtlpyKERH
2s9Z5OtoaBOam01V3tOmgD7EQdbGg2D9qwCcMeOJ52A9k+NndO0yw/pqj+8BBrddHoRat4thWQ/L
JcJt9Q==
--000000000000e2f19c05cbdf99ab--
