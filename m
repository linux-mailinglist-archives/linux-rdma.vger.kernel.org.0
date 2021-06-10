Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9BE3A2F78
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhFJPkY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 11:40:24 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:43560 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhFJPkM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 11:40:12 -0400
Received: by mail-qv1-f46.google.com with SMTP id e18so14910079qvm.10
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jun 2021 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPxcjQcI/vSf+qsu9KO8gJcNPP4lYMJEJRccmHhUYOs=;
        b=KsUIip82nLHAvUFoUFK0ENtl8Z4brWFSha3feNqoRQ+GbtRkEzXkWiqCeCnGCLLI1D
         INi6VQmsXi6cu9wiEayLatL/ZTObfyc+/mbuE8tTxxw9pI4pWwHwGJB/KhW+Uh6Eol6a
         Clmqayn3SwjV7/v9zEsKzduSxRhUy3qJBfqtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPxcjQcI/vSf+qsu9KO8gJcNPP4lYMJEJRccmHhUYOs=;
        b=Cdm2x5uQ7yHSXvsUr9mlTxJjLIJW6jN8bKQrWmR1VGqz/CGrs9oTuEBkl1qv+dzkFG
         XsjL5g2bpO9+P2xyTVVXYqeo7N1X9pyi603KcW6ptxSQS1r7mG6ouy65NSvqIulNKNdk
         rQdH2e/3c/9O523jyS2gEN03F8ODSQnqIuNxJu5hLo4hF80uKmMtVAcakfCELUnxGMUb
         hadeMLewENQAeD3frSj2+qeFQ+u84+1bd5vlko1pQ24iXQ2l+4+5M9kcJre9GMjA/QBT
         piHAzWe9irJW7/1MruAc+4w8hYf1CQvoqQ1mcZODgzs3hRGnTf0wvC4obPHC2q5q88AH
         80qQ==
X-Gm-Message-State: AOAM530u8UP2M65wKb6kot3RsZOHgWMO8KRTk3fMUktuGqcdEwAj/Et2
        sb0pw9RI9bFD+JL+QyVn2lQ7Cdb9b2W/bQzf5keENQ==
X-Google-Smtp-Source: ABdhPJz96zok4YWTjQ55FJqLb8HJe2Vx1CTSzOAFRflldOEft948RrGV+y09bQoL0vqrTwKlWZcl27riYDuigdW4FL8=
X-Received: by 2002:a0c:f085:: with SMTP id g5mr201539qvk.18.1623339435912;
 Thu, 10 Jun 2021 08:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210610104910.1147756-1-devesh.sharma@broadcom.com>
 <20210610104910.1147756-4-devesh.sharma@broadcom.com> <05C8B5D1-B086-47CB-BE2F-891FA7BB9EBC@oracle.com>
In-Reply-To: <05C8B5D1-B086-47CB-BE2F-891FA7BB9EBC@oracle.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 10 Jun 2021 21:06:40 +0530
Message-ID: <CANjDDBjhQB-GJPc1U-W6bti2DKEsRbAAeDAXAsfCFtBA5P7G9g@mail.gmail.com>
Subject: Re: [PATCH V4 rdma-core 3/5] bnxt_re/lib: add a function to
 initialize software queue
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000074a2de05c46b2ac5"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000074a2de05c46b2ac5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 6:20 PM Haakon Bugge <haakon.bugge@oracle.com> wrot=
e:
>
>
>
> > On 10 Jun 2021, at 12:49, Devesh Sharma <devesh.sharma@broadcom.com> wr=
ote:
> >
> > Splitting the shadow software queue initialization into
> > a separate function. Same is being called for both RQ and
> > SQ during create QP.
> >
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> > providers/bnxt_re/main.h  |  3 ++
> > providers/bnxt_re/verbs.c | 65 ++++++++++++++++++++++++---------------
> > 2 files changed, 44 insertions(+), 24 deletions(-)
> >
> > diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
> > index dc8166f2..94d42958 100644
> > --- a/providers/bnxt_re/main.h
> > +++ b/providers/bnxt_re/main.h
> > @@ -96,7 +96,10 @@ struct bnxt_re_wrid {
> >       uint64_t wrid;
> >       uint32_t bytes;
> >       int next_idx;
> > +     uint32_t st_slot_idx;
> > +     uint8_t slots;
> >       uint8_t sig;
> > +
>
> Unintentional blank line?
yup, I guess.
>
> > };
> >
> > struct bnxt_re_qpcap {
> > diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
> > index 11c01574..e0e6e045 100644
> > --- a/providers/bnxt_re/verbs.c
> > +++ b/providers/bnxt_re/verbs.c
> > @@ -847,9 +847,27 @@ static void bnxt_re_free_queues(struct bnxt_re_qp =
*qp)
> >       bnxt_re_free_aligned(qp->jsqq->hwque);
> > }
> >
> > +static int bnxt_re_alloc_init_swque(struct bnxt_re_joint_queue *jqq, i=
nt nwr)
> > +{
> > +     int indx;
> > +
> > +     jqq->swque =3D calloc(nwr, sizeof(struct bnxt_re_wrid));
> > +     if (!jqq->swque)
> > +             return -ENOMEM;
> > +     jqq->start_idx =3D 0;
> > +     jqq->last_idx =3D nwr - 1;
> > +     for (indx =3D 0; indx < nwr; indx++)
> > +             jqq->swque[indx].next_idx =3D indx + 1;
> > +     jqq->swque[jqq->last_idx].next_idx =3D 0;
> > +     jqq->last_idx =3D 0;
> > +
> > +     return 0;
> > +}
> > +
> > static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
> >                               struct ibv_qp_init_attr *attr,
> > -                             uint32_t pg_size) {
> > +                             uint32_t pg_size)
> > +{
>
> Not related to commit
This is a fix for warning, as asked by the maintainer.
>
> >       struct bnxt_re_psns_ext *psns_ext;
> >       struct bnxt_re_wrid *swque;
> >       struct bnxt_re_queue *que;
> > @@ -857,22 +875,23 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp=
 *qp,
> >       uint32_t psn_depth;
> >       uint32_t psn_size;
> >       int ret, indx;
> > +     uint32_t nswr;
> >
> >       que =3D qp->jsqq->hwque;
> >       que->stride =3D bnxt_re_get_sqe_sz();
> >       /* 8916 adjustment */
> > -     que->depth =3D roundup_pow_of_two(attr->cap.max_send_wr + 1 +
> > -                                     BNXT_RE_FULL_FLAG_DELTA);
> > -     que->diff =3D que->depth - attr->cap.max_send_wr;
> > +     nswr  =3D roundup_pow_of_two(attr->cap.max_send_wr + 1 +
> > +                                BNXT_RE_FULL_FLAG_DELTA);
> > +     que->diff =3D nswr - attr->cap.max_send_wr;
> >
> >       /* psn_depth extra entries of size que->stride */
> >       psn_size =3D bnxt_re_is_chip_gen_p5(qp->cctx) ?
> >                                       sizeof(struct bnxt_re_psns_ext) :
> >                                       sizeof(struct bnxt_re_psns);
> > -     psn_depth =3D (que->depth * psn_size) / que->stride;
> > -     if ((que->depth * psn_size) % que->stride)
> > +     psn_depth =3D (nswr * psn_size) / que->stride;
> > +     if ((nswr * psn_size) % que->stride)
> >               psn_depth++;
> > -     que->depth +=3D psn_depth;
> > +     que->depth =3D nswr + psn_depth;
> >       /* PSN-search memory is allocated without checking for
> >        * QP-Type. Kenrel driver do not map this memory if it
> >        * is UD-qp. UD-qp use this memory to maintain WC-opcode.
> > @@ -884,44 +903,42 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp=
 *qp,
> >       /* exclude psns depth*/
> >       que->depth -=3D psn_depth;
> >       /* start of spsn space sizeof(struct bnxt_re_psns) each. */
> > -     psns =3D (que->va + que->stride * que->depth);
> > +     psns =3D (que->va + que->stride * nswr);
> >       psns_ext =3D (struct bnxt_re_psns_ext *)psns;
> > -     swque =3D calloc(que->depth, sizeof(struct bnxt_re_wrid));
> > -     if (!swque) {
> > +
> > +     ret =3D bnxt_re_alloc_init_swque(qp->jsqq, nswr);
> > +     if (ret) {
> >               ret =3D -ENOMEM;
> >               goto fail;
> >       }
> >
> > -     for (indx =3D 0 ; indx < que->depth; indx++, psns++)
> > +     swque =3D qp->jsqq->swque;
> > +     for (indx =3D 0 ; indx < nswr; indx++, psns++)
>
> no space in "0 ;"
yup!
>
> >               swque[indx].psns =3D psns;
> >       if (bnxt_re_is_chip_gen_p5(qp->cctx)) {
> > -             for (indx =3D 0 ; indx < que->depth; indx++, psns_ext++) =
{
> > +             for (indx =3D 0 ; indx < nswr; indx++, psns_ext++) {
>
> ditto
>
> >                       swque[indx].psns_ext =3D psns_ext;
> >                       swque[indx].psns =3D (struct bnxt_re_psns *)psns_=
ext;
> >               }
> >       }
> > -     qp->jsqq->swque =3D swque;
> > -
> > -     qp->cap.max_swr =3D que->depth;
> > +     qp->cap.max_swr =3D nswr;
> >       pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
> >
> >       if (qp->jrqq) {
> >               que =3D qp->jrqq->hwque;
> >               que->stride =3D bnxt_re_get_rqe_sz();
> > -             que->depth =3D roundup_pow_of_two(attr->cap.max_recv_wr +=
 1);
> > -             que->diff =3D que->depth - attr->cap.max_recv_wr;
> > +             nswr =3D roundup_pow_of_two(attr->cap.max_recv_wr + 1);
> > +             que->depth =3D nswr;
> > +             que->diff =3D nswr - attr->cap.max_recv_wr;
> >               ret =3D bnxt_re_alloc_aligned(que, pg_size);
> >               if (ret)
> >                       goto fail;
> > -             pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
> >               /* For RQ only bnxt_re_wri.wrid is used. */
> > -             qp->jrqq->swque =3D calloc(que->depth,
> > -                                      sizeof(struct bnxt_re_wrid));
> > -             if (!qp->jrqq->swque) {
> > -                     ret =3D -ENOMEM;
> > +             ret =3D bnxt_re_alloc_init_swque(qp->jrqq, nswr);
> > +             if (ret)
> >                       goto fail;
>
> Here you have not "ret =3D -ENOMEM;". You have that above, unnecessary.
true.
>
>
> Thxs, H=C3=A5kon
>
>
> > -             }
> > -             qp->cap.max_rwr =3D que->depth;
> > +             pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
> > +             qp->cap.max_rwr =3D nswr;
> >       }
> >
> >       return 0;
> > --
> > 2.25.1
> >
>


--=20
-Regards
Devesh

--00000000000074a2de05c46b2ac5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDjfMRrWpvFgSfjP9RM+Q979fX/a
1QcsbdeQqPqsU9QOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYxMDE1MzcxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCSrZ/IHMVJyfENuVaknCNdsm+yjnnQsZVxW4ojzGNggvwK
eTuX3k2pulVGt1WVVKV8K5Dub6pAhjCDTcKojOe6FlYSZnm7bAQ0v/Gxu9MrSIhM3ASCRtVrfKYi
m6vK2qwBPNb5Zc8VKZB6lBYF706SSzNP0mBurdVngK2MR649MQB7K7ARd6g91vBjOH0VH/zBx4K3
+cC4Rr9rf+a6jPQRHj0TXE3F/OMIApWXT2Sd14nW0rCQ4PPQVKx5TQsKAcjUDovYKEQm+RKc6q5/
WSISkAN2sF7iH39vfHrUS1S+P7MOYwxil79rQzaAtG5ocFyze0xPxY45YSsCYK8j8oJR
--00000000000074a2de05c46b2ac5--
