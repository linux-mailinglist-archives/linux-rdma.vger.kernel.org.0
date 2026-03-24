Return-Path: <linux-rdma+bounces-18548-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L8jIYThwWlhXgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18548-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 01:57:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3D300152
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 01:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F7C431064E1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 00:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B833350A37;
	Tue, 24 Mar 2026 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RjNh3T6q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC134DB61
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313280; cv=pass; b=o4mzcAtBhcYpmffI+O2HIduI2W4ey/l0A2c4OyOJXx5iPqNj3A6SiMm6t6nCPifyiYs9+JFboVrNb7uttdKP58eStxPLGzHPu1+VJl+rZh0dtoXFcuK7ODsRSClcsGN1fnTfCjeHexQqko16JO1vbMW7rct0yeyrNf50aMYfoD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313280; c=relaxed/simple;
	bh=N4e1PLW2eXMeMgOD60hRwj5o4f3sV3Q8z/wIevCs0J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XljP+1aAMebNebQSXR17ot8CUCYY8043hJaUCFHh1zd7BZPZRqF1ZjQUCkokhfoLetT1sCqjAX1JcSXmHCEk5KVmIWH4T863fNHoTSbZszSKiLWCRg+nDHVnqdD/GJWQ8qYKz4YcKAw4W8lLy/G9KTfQMv7GONENcwnJFbm6CQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RjNh3T6q; arc=pass smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c742882d2a4so1403742a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 17:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774313278; x=1774918078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4e1PLW2eXMeMgOD60hRwj5o4f3sV3Q8z/wIevCs0J0=;
        b=YnRG4a8dcQVp0czIp+4YBzVna6YpbZ72fiMIPKhn4k9Y63FOAueErgeFkqbjgYxk19
         kZ4Mwu3Ff+d97GQz6x9VtSfX19C/Oo5pTxgUlKi6Frqy3reFmtouLzYYerfY+vXuhrk5
         WQaaWXSV/AEoaFeMThM61TR5c2mw8ufF4dIVIVdKuXd9W6U6sb33sv8763yG4IEbUtjK
         rbq5C82cbfbWlgLnssNEjEDAo+GrzKjG1hDarprU0IDQzzXSEqNRiTbRrBS0mHKRcW8x
         tBEwFbulp82pjyIc33o4VEZo37GDT5v44acLIkiC65g+/gnB9tflsUaGy5iMEp8EKnaG
         k+Qw==
X-Forwarded-Encrypted: i=2; AJvYcCWrX8oZEKTfvkb+P5g5QQAunG22yGD6J0I+5lT8t8Dyj1yhUDne16qeBVi2NnlYmYin0rInzhAN8hfX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcl113lhFr6NAITv+FlFcuJmC6MaYesY5ZvX7PbeIlR22Rh4bM
	rFDagRXuaNq3Uuwb4O6Ve+JTZtsx3vRCZmLfey0PVXleJ711RlFXEfrfBFw+QKiNWSrX02qEl/+
	/zWbAsnf7WPungL+n7CNvsyL4iDgpoRn+Yr3njCBCIQ1DJczOaHI9QqZ5NJCSBoiYcYt1S46EZG
	4TUpvJft2HZNMNn2+N7ciZ4RGTd8BJk+3tTCt5cSItKCTbKycnxVibvpE2Bud8nDgAfnCV6REgr
	biiyr3vWef9WD2b
X-Gm-Gg: ATEYQzz7zTGzk4ED4Y0ID5V5aJb3xRWSZRPJH7hEvkpqXm51ZrlVN31bcQOcf2KYeiR
	JVr12bcEALWU7qkNmgAmtTTMt4UN6HCtdtLwvA18pFMPnIgVbOZvoRXib41GQitkg6AWc6fPjhl
	xO/UKTW7iJb0YptlMYt4pRjUeQS8T5G/BI2ShkE1NtFK2DLuqay2SIIBZxOsSh2JmF+w7CZyf0+
	cweqBW2NLmqlY48Q189tHGNf6YhVBEDUD85Qm3ygaGC2w/Iik+r1xT3i2jndRxGJNj292lwsR8f
	L8spn+U5G0Hl2A5I5J53wmJ6j3JfpcLSwU0BYlqj3Ny4m4M1hr2Jpa6/XwoHDug8Fc0c/f02GKm
	P9YCbZEwW4PLUetNumQGOJLzWFPnyOlFvuLkGDHbuR0DFdhAosMn1aln+8dZyVdC71SdUeUqeNm
	vMKwzYmNLaoV51Qns3viFoKZiHYhT+w6YQHFdLlWDAWrX9njmPBn8+TgTjxAI=
X-Received: by 2002:a05:6a20:1793:b0:39b:d6e0:305 with SMTP id adf61e73a8af0-39bd6e004f2mr7982878637.26.1774313277946;
        Mon, 23 Mar 2026 17:47:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82b03f94ed3sm1137052b3a.5.2026.03.23.17.47.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2026 17:47:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-662ff83887eso3987267a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 17:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774313276; cv=none;
        d=google.com; s=arc-20240605;
        b=Y5JMZKb2r/C9M9UbSmjd9ATpb7t/dzdSHQwqhQIp4Zc/UiYc3eolig8DnJlSisdH3u
         zOvi4F/QIn9nmkc0D6dep4YNMHzqY0BAYCRFuASzR+5ZQwzJ86c6c/VvG++duw+IvRbt
         kxwE5oRyaxlMkrcMLuvsLmdrUrq6LZN/aXHxfpIts+c34qLYkdGBXEm+pxu2AYnPH7Dc
         7NgaXbTaczwG3fUjjchYumreYRh9lwGySmdeLUqw/ihANOdvKXf9vYMpSlN1maC9a8nY
         s3N4QnGtHRXAZW0DOI8YtmLIUxiL7yQgxaAQ7NkfpYtmNAPm5MeHd0dxeNZG+0oY1bBx
         K5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N4e1PLW2eXMeMgOD60hRwj5o4f3sV3Q8z/wIevCs0J0=;
        fh=fHATgW22D2PxSg/MeJzeqibi5zdWTsAon7Lii7eaNEk=;
        b=KEgH0vjv6nswIyoIGVu8n4j4yJi7ZQtXzDtKF/qQ7GGFUq0ocBtag38g+mUbu3pnh8
         oUSp9izb5h7Mo27G3I0VO8wChIBI2yV0TY+D3cEEZuXzAg9l3+20ZQOJGNlJaO1Bd+CK
         B1Km6zF8JB09J73+JhotDT2tp7tKxPA7932REJi+KgoAUeOR90+hacIs0Rn20oThGUcx
         HDNUxzjZk4/VZdFqWqbul4oPcgdfpzMKTi/zrZPP5DbZinI6aoujpx7Zk/v8K+fop6eL
         LYrF8uUlnV/8Ubk/mJLx4XcL5ERFLXRzhHaFvfXw+ZXNkGqMvXPlQqyjhrC6kdgDf2Lg
         /B/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774313276; x=1774918076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N4e1PLW2eXMeMgOD60hRwj5o4f3sV3Q8z/wIevCs0J0=;
        b=RjNh3T6qDkil7AT6SzxRknTjdTikKA2Amgwz2S+tym/EXr/H3x/s1ioyqu1rqLFFrB
         Y9sew51bQ9VDkfHM9YLrGPxhO0w8Qp7LqlYvaz933QPTDH+RnfVSu/aui+cn5PXOpD4N
         SFVpX5pPYww3O5gU62CsnrjVND9bh2hEbCOYE=
X-Forwarded-Encrypted: i=1; AJvYcCXfEkIXPGzY0tD05RGeGULA75Oo20dcUKBnyYWpVrnxGFLZPr1VkYPKv5ngAXih2LKoERaZXz+DeOGd@vger.kernel.org
X-Received: by 2002:a05:6402:4542:b0:667:ddf7:7d9d with SMTP id 4fb4d7f45d1cf-668c971954bmr7635435a12.10.1774313275826;
        Mon, 23 Mar 2026 17:47:55 -0700 (PDT)
X-Received: by 2002:a05:6402:4542:b0:667:ddf7:7d9d with SMTP id
 4fb4d7f45d1cf-668c971954bmr7635430a12.10.1774313275425; Mon, 23 Mar 2026
 17:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320012501.2033548-1-sdf@fomichev.me> <20260320012501.2033548-8-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-8-sdf@fomichev.me>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 23 Mar 2026 17:47:43 -0700
X-Gm-Features: AQROBzA-_AUUB6-xri1Ls7aYRImwmpFhYIiqzLVvcCXA93ChCnVc1sxi6-ZS8to
Message-ID: <CACKFLimO_K4qRb2Tnio-0xa6U1xmTEbz0Q-rzC7RqygQOBLnpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/13] bnxt: convert to ndo_set_rx_mode_async
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
	boundary="0000000000008b028d064dba809c"
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
	TAGGED_FROM(0.00)[bounces-18548-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,broadcom.com:dkim,broadcom.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45D3D300152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000008b028d064dba809c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 6:25=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Convert bnxt from ndo_set_rx_mode to ndo_set_rx_mode_async.
> bnxt_set_rx_mode, bnxt_mc_list_updated and bnxt_uc_list_updated
> now take explicit uc/mc list parameters and iterate with
> netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.
>
> The bnxt_cfg_rx_mode internal caller passes the real lists under
> netif_addr_lock_bh.
>
> BNXT_RX_MASK_SP_EVENT is still used here, next patch converts to
> the direct call.
>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000008b028d064dba809c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMZh03KTi4m/vsqWZxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDk1NloXDTI3MDYyMTEzNDk1NlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzENMAsGA1UEBBMEQ2hhbjEQMA4GA1UEKhMHTWljaGFlbDEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AKkz4mIH6ZNbrDUlrqM0H0NE6zHUgmbgNWPEYa5BWtS4f4fvWkb+cmAlD+3OIpq0NlrhapVR2ENf
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDQUe5+
MnF5gGNR7DKTscnoSulx7eb9g2hc5867TiEBijAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjQwMDQ3NTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA82A5a/zCgoE7aNYo3a3h9KK5gAHJbcIbIEKXP1UiO
YZ/CuT++ELFmS8Zm05ECPgmPyHK3wyVZjYXmQ17PNTPa+nbuXahezcvHv9lP5b/m/P6wQeQSGZ6W
g/y/XDzfd8yEtjX8KzuVGheMtfzbECTHWSXxhVSOn9AvHFu0OWrW+6Rna+1cuO1CP+5COvpsgUP7
/lknTSHSX8OcA52tbFKwgd8oOu1GiuaULHkEttX5HFrf00ux5IrQqatxpbAfV5avd7G5dY6qQn08
JDIiMsNE304h5G4QGxRzT6OPZ1hXKBMMLUb/aUhlU4wlQ+BptcoZhjgyXEP56fIuGgJGPwjL
--0000000000008b028d064dba809c--

