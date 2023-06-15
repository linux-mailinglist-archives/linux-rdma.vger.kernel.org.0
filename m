Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B585730F81
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbjFOGjO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 02:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjFOGim (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 02:38:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80FD1FC7
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 23:38:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30fa23e106bso4638869f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686811084; x=1689403084;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OlROm9skOT0uwk1bhV68Ow/KMHB9h/GI1x80uW+Dng=;
        b=KQH3zTzXFfYfFN0e9GWcRTegvuqwYZqUEKhzioFWHkpd1BBhcarwFkEYzIAQ+SDEmS
         3CruKvpiLBnuXHS5ydB5PFsq+qq4E9ShXwoVi/mxgrBJFM6K8rsHGDw8W+cwb+U1r4Ie
         p2vKrrwTs2q5JYjtGne1tZMd9YZsk+ck4NC28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686811084; x=1689403084;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OlROm9skOT0uwk1bhV68Ow/KMHB9h/GI1x80uW+Dng=;
        b=ZTesddl5vAuOZZNfmHQZDwbqj0oDOF0Cx5wUXyJydP5ZoV7AK0PDmK/l285iInmEBj
         6CkHK6gfwmFBJAQDY1ZW1EqJYL/GRGuFyn5+o+nqCWTnYLvKWKziaI36nYvUwAMHSIi9
         HUow3wGceTLtY5mdZj2aQ2DaigYIkp66ER24LwnQP4jx9PnEd5eqiuPvSwSj2YzVLvk7
         hMLFjSumfZ73PEc2dbZx67GA7O1nJIVxJxgLvAT+II8I2owEnIwbeTA0q3I5m6I7PhJY
         Kk0aJ/btRkVfkyu0ROBwlvcU+hqIBNFQ0zKwt1VGEHWbTSPII94R5x7cjRbCaXDyynsQ
         QLAg==
X-Gm-Message-State: AC+VfDx+Q03wMpswhebPyREABT9upU2rd+S1r1ArYC3bd1I6SfXhntXr
        BilVh2+msbNczu1JUsFDDr0WnOmvTG3MwpnePGlo3Q==
X-Google-Smtp-Source: ACHHUZ6aJXgabBMJeqAQXH39rrCFQ9SR5hONlFApYxOLq/i9iSgG+PKNYI4ekpg09wjPW0Sr9hOJfVOSdlXCKrBWK9k=
X-Received: by 2002:adf:f8c8:0:b0:311:180d:cf38 with SMTP id
 f8-20020adff8c8000000b00311180dcf38mr339585wrq.24.1686811084231; Wed, 14 Jun
 2023 23:38:04 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <35e505b9-f174-46b4-9b0d-7d30e5717560@moroto.mountain>
In-Reply-To: <35e505b9-f174-46b4-9b0d-7d30e5717560@moroto.mountain>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG3tSA3UwmXI28TX00JRDuU+NUica/PPHGQ
Date:   Thu, 15 Jun 2023 12:07:31 +0530
Message-ID: <0b40d9b7ba13549a3d905d4490e05cc1@mail.gmail.com>
Subject: RE: [bug report] RDMA/bnxt_re: handle command completions after
 driver detect a timedout
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000080977005fe254ff5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000080977005fe254ff5
Content-Type: text/plain; charset="UTF-8"

> The comments in bnxt_qplib_map_rc() talk about "firmware halt is
detected"
> and "this function will be called when FW already reports a timeout.
> This would be possible only when FW crashes and resets."  The
> __send_message_basic_sanity() function returns -ENXIO in the case of
> ERR_DEVICE_DETACHED and it returns -ETIMEDOUT in the case of
> FIRMWARE_STALL_DETECTED.
>
> Based on the comments, I would have expected this test to be:
>
> 	if (rc)
> 		return rc == -ETIMEDOUT ? bnxt_qplib_map_rc(opcode) : rc;
>
> Presumably the code is correct, but the comments are confusing.

I agree. This comment is not clear. I will address the comment change of "
bnxt_qplib_map_rc"
Logic of the code is correct. Also  I will make minor cleanup so that code
is bit readable (will not do major refactor since I want to address bug
fix).

>
>     492
>     493         rc = __send_message(rcfw, msg);
>     494         if (rc)
>     495                 return rc;
>     496
>     497         cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req,
msg-
> >req_sz))
>     498                                 & RCFW_MAX_COOKIE_VALUE;
>     499
>     500         if (msg->block)
>     501                 rc = __block_for_resp(rcfw, cookie);
>     502         else if (atomic_read(&rcfw->rcfw_intr_enabled))
>     503                 rc = __wait_for_resp(rcfw, cookie);
>     504         else
>     505                 rc = __poll_for_resp(rcfw, cookie);
>     506         if (rc) {
>                 ^^^^^^^^^
> rc is checked here.

This is not required. Below check is correct. As part of rebase, by
mistake this piece of code added. I will address this.
>
>     507                 /* timed out */
>     508                 dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x
timedout
> (%d)msec\n",
>     509                         cookie, opcode, RCFW_CMD_WAIT_TIME_MS);
>     510                 return rc;
>     511         }
>     512
> --> 513         if (rc) {
>                 ^^^^^^^^^
> The patch adds some dead code.

This is required.

Kashyap

--00000000000080977005fe254ff5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
//gyd5clTejfGxz7u6TjAKPT7G/PY9BaxKSEf8zLsYtlHAJMVeCFF20jzwQHb5/L+5h2CkPOrrSB
JSieWyW6UjDpmJdXnnM3sqAtuQHYoZ76TqNQWkummLSqMwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUuFb0TqXOZcrcNo5g7TmU
kbW0uVQwDQYJKoZIhvcNAQELBQADggEBAEpkK1pEFLXwM8dPS+Y+gSbbTOhzvfHfnB1tKMepSjVT
Sh0CvvfRgpBkaqZJv2+/9W5dfZejA+3xFc/G/lurpofq2yVp2Zik+RbO/FjpFfg24MHjkSr2foJm
RImddZVt810u7w3qtY2pQQ/QHCS9fHkLtz5dKfmePAebpPuX2BJ+FmPfFZyHLpLHr4CJwUU9ETgH
GRRQamqDhA+VgD34fZSymk33umJA6SDgqaX9pDs276nwbY0g8TSOZwohc/6eTzU0Gsl1jSuJezXm
/bctt3Fx6+DwYeO9905PrJUE+iBLLHPm5cHBNF9yWCy/FrP9ZMFvsUvcPiWyEWFPYhsVxAMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwQyr9ygXXwrg7q
ph4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO9wIoUaygWMweDdwFvRnOMIyt8c
XxTYFgeXsj7VrfwkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDYxNTA2MzgwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBKXME5Ks0jjunRBo/chIpIoI9qlWzmtd1kKaq39PsB+cTJ
z0gPnlA0Zdf5zPuum6oNoTJvBX0rWtPvpEVyAw6dXbb7RaajTtu+rpw/fWscmlMKxL09SRbB2va6
RYdeUamZ7TsDG77GiYCqDbxM1pnPncHdheWJCe6SJQtlTWF/ZlZ0HkBCr9EHs8edDiPxCYdDWh06
k4y4Hc443uymgJ+1k7GP8spix8lN+XXOntjJBKdEgPgNXexFndMX/9LHhmn9yoVT5Dz9pYSSwgo9
6ZZvMHXn23HrqHs4BvaUh7iosicjqLwRuDynzmFI8M+gtxY8s0bHphuIOkUxpXl0Whhp
--00000000000080977005fe254ff5--
