Return-Path: <linux-rdma+bounces-17366-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBuDH/pkpWmx+wUAu9opvQ
	(envelope-from <linux-rdma+bounces-17366-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 11:22:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 148731D665E
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 11:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35BCF3016BA1
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D639527E;
	Mon,  2 Mar 2026 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d6z7L2r5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A111379EDF
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446967; cv=pass; b=ap3PSzDT9ExObTktw+Kg4t3aGPtTndiNYVW/FXq+UIIQUs53C4TkLMJJ9z/2GGoQF/34xWGTt/pengoFFD3qmYTR0A3bRYvd3WzLDgNIem7RKbXc+l+1r5XuL1QTP5/fT8UySAfenBG5hA2sJvpGitGw26UTUPF72IFgC1+aFWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446967; c=relaxed/simple;
	bh=RTF2xoAst9yByrLvGquYq2UG3egtJ/TtTLiv5aK47mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQv06ZPYkvws7v8/lgz3vWFeLqMs/+fTOU1h+wAYhxm6gnuP/f+89zfXpTTg2M7eayPyP7QzotMGLTq8qLrzJr+QfXvf/ozoX4jGuDm4bL+lcIDYuVN+Y81FWpDHfkb0Tr/Eggcps8VK3r5KPyHM+4fT9gmY35Yc6wqceoQzy8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d6z7L2r5; arc=pass smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64acd19e1dfso3753512d50.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 02:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772446965; x=1773051765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgDzCWOEL6hACPwa6eR6Lb/v/X/HgnmIyVaihMbwWE8=;
        b=VukBbmj/zNDabXTXuiUdqv35TDgqKZqs2tzBgA+LQGyh2qKwdoP8Vv1iB0plNSZdfl
         MtPPmzNdu7o4SbXTaPPNTmI0VZFo1QsqxMvuQ/pjzRQ7bsevPhqsOmI6L3dCPMK2TXcC
         TIzmjygO5BLk7Nzrls1Tg8JbeH2K0E4NcIqHaPkZaLYZzX44NtG+J2+l/zwVGpQF51a0
         pLuXRJd0eBBVl0z/R4sG024+B04fFEpoV984O3hXjgZ4g6mAwEX4qjdXnLVgiaWihLa9
         hGuc+SZEbigAdEyXm8U12KOMV0KQ/wtV/g2fYFQI9LxHUPlpJHoyjBEQK9TMo9j9nCOk
         rTQg==
X-Forwarded-Encrypted: i=2; AJvYcCX+chYUTDehyrHmU7c9mCQleQ8MyAXMWLiBPkUUpfX2XLrj241GefruMazUSy0UZMB7OyrMC511Wifz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18Pr9IY6umLxukQw5thj7UHf8hTN2kL3yiNt2SxnbDGSomg+5
	kl8FbV636+dm9JXrcHQQQHOOIPyWvLV+28c2NYJxtSp125Ljh+G2WJYCwp9Gv/cgV7sYa1B3dok
	viWijmjAjP4Bwno7Qg9HuZj+w/xCm0J+tF4nEBZH92XXlxI2qwNSwPdLckVFznyGfeVy9Xymsb4
	IGcJo0dEn5hGpKqHacpqCnSTpJ8j+LmzpW44Gbrl1F0HqbklTIHfHP0ybKfa58CKcQNLN4jbQZA
	gGnyIfgXbzPZOY=
X-Gm-Gg: ATEYQzzCJdPyjF3o+pT5OF58cvfLeBwIxAkJ/eiudvUtWfjlJElP7wxj6Nz7QNowJKt
	sgn1t5BEcxxDeg6710ZuYrphelnAdFK/qAie0XCGv3zbvqyQA+zu43OgBsA/bMiXL7ZU7PHO7fq
	c3fJB7ATg7RiLD6M//EzY/DTN1G+LLMUGppK6Ss/ojmxbE8etlpptE3RqhdlqOQWZ6MCKQN1pFv
	+0GvjMkgHIQbb4tu3VIBAISpeO4dfFvn5wikji93+yk2WXRRRNLOBeM+57hyvp3m1URFPfWyg1Q
	C4Hn48BZffjmDfhN2G7QF2gyovZvUlOI0GPDHUk3StvBavFq1aDCaLvpTDFPd23bUOEr0mCUb7I
	TyVH38VsWuKsiI6viR+g1o/+kFJ6G02VuB5Pu+6Ht3bT58pFWDBlKCn8dblNokPJSrjuHMOgXZq
	VhtHfDDaZwtlS4BsTtDUh3lTnJv98SN1Rf4lYYBbK/DPB5WthNewFbilXl5A==
X-Received: by 2002:a05:690e:6cb:b0:64a:f275:a4d1 with SMTP id 956f58d0204a3-64cc201e310mr8035784d50.6.1772446965044;
        Mon, 02 Mar 2026 02:22:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64cb75fb6b0sm1217304d50.7.2026.03.02.02.22.44
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 02:22:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae50463c39so8513065ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 02:22:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772446964; cv=none;
        d=google.com; s=arc-20240605;
        b=YQ2RgTAz8gLBbL62qYVVUd+OwQwwH8krnUSKRzUZSiNzvl+AlrVYG71AnL3+K1FatE
         hO/Tktf8XeRXWAdeCEljKuLbzXgp0bSb4mNKOoLM+4Z95DEvopJe8+zheHUUT1iVW6LN
         uwPp8IJrwsI3j0jI94DOfqBZEl5y27Q0Gc7JKb2WhIWg7A5Ja47rp2lM7doYwhG2xFWO
         l38IVuxMYdbUExB8NWAJZMa1/66+nR5RhynwMqAzkNv/wu9IQ2Zo6j6H5M0lquWYGFb0
         YR5FjI3xk7pugAuBH1c0c9kdZS80hKoJCqa9PihHDwVAjgXJvVyMWrARZkHZuPkoUqTt
         VnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CgDzCWOEL6hACPwa6eR6Lb/v/X/HgnmIyVaihMbwWE8=;
        fh=CS8+oqsBL7shCjX3C6DhXJLVFtAsoJkIl5rWn8PL01o=;
        b=bD8rZLc+IpowVcDCklsAYJJx3/wkYHfOMbsKIcbEQHKylSuacXg2ZTNybYZ5XxIh5+
         kAq5fc7jxIWrvrNJr7XFNxRLT9olnoB21zN2LnSfmKjXs5E8pPYUWpktFmZ7xvFhasrs
         RI/3giI+MSmGr2ZaQQ6hS93WWXlwEphW8np2YDp1zY51bolT6oKH9DRPCDy6DM5nTVC+
         0UgiHek7Ye3CLglN1Z65A+EmtQNbDY4qr7OpTzTWyhE+P0BROf736GExEDEuBAl2vsmp
         fBCRpAMCWML1gqOIejjapCP4bc9Yk2mJ8TiAajN/99XmbekulHah6C+cFvaGyhEYz6YI
         tw+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772446964; x=1773051764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CgDzCWOEL6hACPwa6eR6Lb/v/X/HgnmIyVaihMbwWE8=;
        b=d6z7L2r5iN1yVl2GF6Xko+vqS68MTpiaV7LZqAdmqsr+J7tNZH1Z5HsWad0/+7N0Hl
         B5LmUSTacYam1FsXWzrOtOr6MuSbyGVYgdDOdcwIDyiqk7GRpLSN+C3883ArAkHTBYxD
         mI0S48np/60LEsSbIhyABErrb6CstuDnQpY18=
X-Forwarded-Encrypted: i=1; AJvYcCWWoBBVhO82mI6rBmVjD2xQELVEuDkw6gIxOYqNbPJCftgvqkJFafOnZtawg4lE1nWORyi3z72QDyGS@vger.kernel.org
X-Received: by 2002:a17:903:1aee:b0:297:cf96:45bd with SMTP id d9443c01a7336-2ae2e40a1a2mr108186805ad.19.1772446963780;
        Mon, 02 Mar 2026 02:22:43 -0800 (PST)
X-Received: by 2002:a17:903:1aee:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-2ae2e40a1a2mr108186535ad.19.1772446963345; Mon, 02 Mar 2026
 02:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227154002.71038-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260227154002.71038-1-alok.a.tiwari@oracle.com>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 2 Mar 2026 15:52:31 +0530
X-Gm-Features: AaiRm50krAjoGLXp2guY9E_Z3DOHFgaRo4KSuf06Ohkxcz8vfu0axfVKS2rLpyg
Message-ID: <CAMet4B6KSw2+0g6RD5Gq=KwGY9vRFspJwBCZCUMW4f5oU5=cJw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bng_re: Fix CREQ BAR base validity check in bng_re_map_creq_db
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: usman.ansari@broadcom.com, leon@kernel.org, jgg@ziepe.ca, 
	kalesh-anakkur.purayil@broadcom.com, vikas.gupta@broadcom.com, 
	bhargava.marreddy@broadcom.com, linux-rdma@vger.kernel.org, 
	alok.a.tiwarilinux@gmail.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ade704064c07f709"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,ziepe.ca,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17366-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 148731D665E
X-Rspamd-Action: no action

--000000000000ade704064c07f709
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 9:10=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> bng_re_map_creq_db() initializes creq_db->reg.bar_id to the fixed BAR
> index used for the CREQ doorbell, then reads the BAR start address via
> pci_resource_start().
>
> The existing code checked !bar_id, which is not a validity test for the
> PCI resource start. Check !bar_base instead and log an error when the
> BAR start address is 0.
>
> Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmwa=
re channel")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>

> ---
>  drivers/infiniband/hw/bng_re/bng_fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/h=
w/bng_re/bng_fw.c
> index 17d7cc3aa11d..92e7fa4dcf1a 100644
> --- a/drivers/infiniband/hw/bng_re/bng_fw.c
> +++ b/drivers/infiniband/hw/bng_re/bng_fw.c
> @@ -581,7 +581,7 @@ static int bng_re_map_creq_db(struct bng_re_rcfw *rcf=
w, u32 reg_offt)
>         creq_db->dbinfo.flags =3D 0;
>         creq_db->reg.bar_id =3D BNG_FW_COMM_CONS_PCI_BAR_REGION;
>         creq_db->reg.bar_base =3D pci_resource_start(pdev, creq_db->reg.b=
ar_id);
> -       if (!creq_db->reg.bar_id)
> +       if (!creq_db->reg.bar_base)
>                 dev_err(&pdev->dev,
>                         "CREQ BAR region %d resc start is 0!",
>                         creq_db->reg.bar_id);
> --
> 2.50.1
>

--000000000000ade704064c07f709
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWwYJKoZIhvcNAQcCoIIVTDCCFUgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLIMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGkTCCBHmg
AwIBAgIMaDrISNCBkfmhggl5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDQ1NFoXDTI3MDYyMTEzNDQ1NFowgdoxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGS2FsbGFtMRMwEQYDVQQqEwpTaXZhIFJlZGR5MRYwFAYDVQQKEw1CUk9B
RENPTSBJTkMuMSEwHwYDVQQDDBhzaXZhLmthbGxhbUBicm9hZGNvbS5jb20xJzAlBgkqhkiG9w0B
CQEWGHNpdmEua2FsbGFtQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBANW6xYdzQHMOlXaC3uNwVMTzlpl+DKeCRXUyBs7g1OpCUSj02n1WEwCoNJXQrmoVYTD6lTHL
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
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIE74
fWD/Hhwlymm2yysYERnWIhs7nQVpjLQrhS9ETVJ4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDMwMjEwMjI0NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAky+bIS29V/H2tIDcyQTA3U0cXaBjr+LdLmYBl7
GDfEOosDV6qbtgqqlLYdGDZONPLjx/ojgO2ax7ieYk2PblyGG3GaspgCeg11iKtdUeQguSjWdq9l
uCRyQMcXmW6E1HUTrftNUE8G4cXlBUzJxMP7AVXgxctxj342nP2JWR3+8Mhc+qbJGZ3p3N64CKIV
CQMORIv0ea7XJ/FqxwcveNQGedFI1Vq+8T/3k8OAoqbcg6B2fnQhNV+EUWK1IUAoU64oXR/4C+pD
+wgS8+RZnDFblCgtqNbGCljypwmUjJmS7xaFGluRFNu7kRYzyHW6mQT5HG6wl6mRdDBTrSAxAdc=
--000000000000ade704064c07f709--

