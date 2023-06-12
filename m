Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAFB72B9AC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjFLIEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 04:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjFLIEJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 04:04:09 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46584468B
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 01:02:24 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39c4c3da9cbso2124271b6e.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686556927; x=1689148927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/qSkIvWYjP8X0VQ1H6dbg9dF0btgVY3RDmPK6ZhCCw=;
        b=gUptiYrFD+ijO7Pgs+Vgeh0qNxnZnxSR2pNeEAK71VSIg1876MkmUmFZk54mS5EEJl
         KR/VP8E3zMC3D+6N1CMKQsIKms4buv6rbdhxOrq45srXllRbYii6+xQTHJ7B+Gc7cki6
         x/9BVFYHvbFQZp61KXnZX4qtHCAI66Nh067D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556927; x=1689148927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/qSkIvWYjP8X0VQ1H6dbg9dF0btgVY3RDmPK6ZhCCw=;
        b=VSCxZBrmUP37RV8lu49srK5mr8RGUWrEwgq0UwlsK6+uTqF8Pt/AfUblbWZAibyrxE
         Jn0JuQ1VOb6QFfNgwFf4q7maYjBcB5IgMmZpK7rlwrOqBUmq8JhZcY+u2iIpWROvdg3P
         b68G7L8iUj+JPBgIMeHzGwBfZUrOKt9VSPYRas5YZIlpi924QY6helCpSVm7VhQmb5xV
         iQXVWgClSvOXhvg5HgSNXL1XOLAZ5sDGuvvIHNo+3axdloYYoNaKblbYl5CVfA+qgp8V
         HM2LnjEA8W3/kJdd1cd8A/e14GNqF+mXhk1Ec+rBxqF/OVp8XKt1lSDEJTQTdZALGS8r
         II+Q==
X-Gm-Message-State: AC+VfDztk6GAdPThKofnYaweAXkgF+//6E8SELPQ4H9D/B/uf6M4DTPR
        pLMYVuZTLgeyzOkx7+rhIqDbCA2tINvwiTOzq6DDFQ==
X-Google-Smtp-Source: ACHHUZ4N3SjLld1U4cLg7p7jfOVJs56BUWlhHSAWs5IZUBhYVU1QghqZoL5dtPm/5EqyqlRtF8Kq5cl0EF8JB4UppL8=
X-Received: by 2002:aca:1009:0:b0:39a:a99a:21a2 with SMTP id
 9-20020aca1009000000b0039aa99a21a2mr3359253oiq.40.1686556927045; Mon, 12 Jun
 2023 01:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
 <1686308514-11996-10-git-send-email-selvin.xavier@broadcom.com> <20230612070417.GO12152@unreal>
In-Reply-To: <20230612070417.GO12152@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 12 Jun 2023 13:31:54 +0530
Message-ID: <CA+sbYW3jNWcD+PwKy-KNukVmEsJu3Q0JA-hCeGj329e6Ob=5cQ@mail.gmail.com>
Subject: Re: [PATCH v2 for-next 09/17] RDMA/bnxt_re: add helper function __poll_for_resp
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com, kashyap.desai@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008fbbe105fdea22d1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000008fbbe105fdea22d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 12:34=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Fri, Jun 09, 2023 at 04:01:46AM -0700, Selvin Xavier wrote:
> > From: Kashyap Desai <kashyap.desai@broadcom.com>
> >
> > This interface will be used if the driver has not enabled interrupt
> > and/or interrupt is disabled for a short period of time.
> > Completion is not possible from interrupt so this interface does
> > self-polling.
> >
> > Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 44 ++++++++++++++++++++++=
+++++++-
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  1 +
> >  2 files changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infin=
iband/hw/bnxt_re/qplib_rcfw.c
> > index 15f6793..3215f8a 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> > @@ -260,6 +260,44 @@ static int __send_message(struct bnxt_qplib_rcfw *=
rcfw,
> >       return 0;
> >  }
> >
> > +/**
> > + * __poll_for_resp   -       self poll completion for rcfw command
> > + * @rcfw      -   rcfw channel instance of rdev
> > + * @cookie    -   cookie to track the command
> > + * @opcode    -   rcfw submitted for given opcode
> > + *
> > + * It works same as __wait_for_resp except this function will
> > + * do self polling in sort interval since interrupt is disabled.
> > + * This function can not be called from non-sleepable context.
> > + *
> > + * Returns:
> > + * -ETIMEOUT if command is not completed in specific time interval.
> > + * 0 if command is completed by firmware.
> > + */
> > +static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
> > +                        u8 opcode)
> > +{
> > +     struct bnxt_qplib_cmdq_ctx *cmdq =3D &rcfw->cmdq;
> > +     unsigned long issue_time;
> > +     u16 cbit;
> > +
> > +     cbit =3D cookie % rcfw->cmdq_depth;
> > +     issue_time =3D jiffies;
> > +
> > +     do {
> > +             if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
> > +                     return bnxt_qplib_map_rc(opcode);
> > +
> > +             usleep_range(1000, 1001);
> > +
> > +             bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
> > +             if (!test_bit(cbit, cmdq->cmdq_bitmap))
> > +                     return 0;
> > +             if (jiffies_to_msecs(jiffies - issue_time) > 10000)
> > +                     return -ETIMEDOUT;
> > +     } while (true);
> > +};
> > +
> >  static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
> >                                      struct bnxt_qplib_cmdqmsg *msg)
> >  {
> > @@ -328,8 +366,10 @@ static int __bnxt_qplib_rcfw_send_message(struct b=
nxt_qplib_rcfw *rcfw,
> >
> >       if (msg->block)
> >               rc =3D __block_for_resp(rcfw, cookie, opcode);
> > -     else
> > +     else if (atomic_read(&rcfw->rcfw_intr_enabled))
>
> Why atomic_t? It doesn't eliminate the need of locking and if locking
> exists, you don't need atomic_t.
The intent of rcfw_intr_enabled was to avoid the locks.  But I agree
that it will not help. We will  refactor this
code and move it under a better locking scheme. Will remove atomic
variables in this path.
Thanks
>
> >               rc =3D __wait_for_resp(rcfw, cookie, opcode);
> > +     else
> > +             rc =3D __poll_for_resp(rcfw, cookie, opcode);
> >       if (rc) {
> >               /* timed out */
> >               dev_err(&rcfw->pdev->dev, "cmdq[%#x]=3D%#x timedout (%d)m=
sec\n",
> > @@ -796,6 +836,7 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcf=
w *rcfw, bool kill)
> >       kfree(creq->irq_name);
> >       creq->irq_name =3D NULL;
> >       creq->requested =3D false;
> > +     atomic_set(&rcfw->rcfw_intr_enabled, 0);
> >  }
> >
> >  void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
> > @@ -857,6 +898,7 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcf=
w *rcfw, int msix_vector,
> >       creq->requested =3D true;
> >
> >       bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, res->cctx, true);
> > +     atomic_inc(&rcfw->rcfw_intr_enabled);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infin=
iband/hw/bnxt_re/qplib_rcfw.h
> > index b7bbbae..089e616 100644
> > --- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
> > @@ -221,6 +221,7 @@ struct bnxt_qplib_rcfw {
> >       u64 oos_prev;
> >       u32 init_oos_stats;
> >       u32 cmdq_depth;
> > +     atomic_t rcfw_intr_enabled;
> >       struct semaphore rcfw_inflight;
> >  };
> >
> > --
> > 2.5.5
> >
>
>

--0000000000008fbbe105fdea22d1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPHntWKzGCRD
QCEUM9AcSjuxhmujombn3UCBqx2W27isMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYxMjA4MDIwN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCmyjxEm5Wv9Rpz+4Cm1AyMrwiN7vi7
XlffQs76yQqiMVe0S4BHr1GnpslmMdXcVg9Qzu+jBIATDTzDVxUypZJWeVOgkgdgm3zYXuXECohH
qskiGuLLl8vX85dcv/fMn0Ri43YFf8mWdTF7n++4ce111xY/i2LJbET3IufTC9Kufdb5Fcwc0NIJ
hEVYTY5nP/Iwa4BhOQUiU6FiJ+RmaqIEf3dcy/g50Scljs6Rsqp+kmJAq4LHJt3kNQ7/nkCSSdTd
84hwwjevfUCQfrlI2BwCdB/uTHr0lq6yavkPmbWVyWHtjdPaVyAFEa5HEoKGTEdnLNVLJiakjZvt
z+QVFBop
--0000000000008fbbe105fdea22d1--
