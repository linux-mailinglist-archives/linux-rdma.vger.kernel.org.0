Return-Path: <linux-rdma+bounces-4050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C70893EC0B
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 05:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4724F281D59
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960980BEC;
	Mon, 29 Jul 2024 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L/Aq9Zbv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BEE2AD15
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2024 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722225470; cv=none; b=sNRqpwZev5T+A09A9RCg2cN8AWPkVqX8OrCbmhd4kTaqS+ty8EO56FGyJEjCma2OGaoC19KrGZbsqcygTlP2dm0tT+DOz6kzppMjb4OHoaYpi8pqOcXS5K6WR6GA8HCcq00OtsGeEI0mBnTCYdEbk8RSYanTi0g9YZYPwbm5tP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722225470; c=relaxed/simple;
	bh=CVLjKt0vshmH4ElvngpW0FVDjGKFHSu+jbqqzlEtRzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCeC4AzyI06UoPF3CLm0T6jw7BoCcSJM8UasZw3jIhwPJNdLVm8R30fEY0DqYp1JqRXVLl+bPcH31yTlAVE6aMJX+9Lnlx5lcsQGrZcO2nEthBbSJMHkmBZk5MkVxqL+g7/UHJiBZc+KGL/jV1VoKMDARi3dEqyDkCpoq2KbKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L/Aq9Zbv; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4ef33a09a3aso674744e0c.2
        for <linux-rdma@vger.kernel.org>; Sun, 28 Jul 2024 20:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722225467; x=1722830267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SbjQ9YhDp8hTTCz9jB8JCdbUmyQymNwBYAGZbtvjxt8=;
        b=L/Aq9Zbvqxe5dde7Ovb/aV30wIDoJ7K6/sBYRn1Z+E8FkeN329hEhgerJb1t1Tsk98
         mAHbVWW2+N1FI+JXfPbgKmdvY97sgzn8OYGKh6XHtREKhlh2PdVMShIqH7B4K58kirSR
         QJ87YClUhRThJXMck3CpqupLDALb4EbzN55Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722225467; x=1722830267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbjQ9YhDp8hTTCz9jB8JCdbUmyQymNwBYAGZbtvjxt8=;
        b=ioaW6O4k/pT14QW+HWFKrSXB+53DfwX/vGOivrHZmVGHE50ut9PKH0FRegi+/EQH/P
         Hvgk56WVjBOYyzuIbxS0J5PEfIHBIJAchEmw+b408W4/dR/5ExAX8uyT2nSeuTmzQfr6
         LaIqdu4E+Ep3aFH83vtVsmafDBZWfiY5ZAvMNJKaBDPNMurlFXjAPnIrFmYdCvR6POqU
         GNcugmSkiapnsL/y29u4bbrEtdwuuqCL/tW3FSO1JevF3Ik4pIKIbPZjX3aAhqc8cUBg
         Zn4w7V0c8S2SFjGQaueiZXNNs3pBt0uS1oCzs39OWKTym++0jVxoOWbMwV7XoYisSvak
         prQA==
X-Forwarded-Encrypted: i=1; AJvYcCUnhV9MwNbH7aOZ4HqVVvj5RTd2yMgJ17FeA6RDzUb1lv/r3+Q7v9dDXK/dVwldNcsX+X+UMjykIYzKk25Ur+ne56ujzdcAAIcnSA==
X-Gm-Message-State: AOJu0YyxRORy6+lNA6Ot3Nt7076bfRdr6zG8HEZGq62jxoL7iH5TLt3C
	mnSTOqcAb+q4oVxpeIT/LMihUvRn0lSgnMtD/wk0UoTqmkYq418mjmx8/Q1EkGMJonldDfEEwN2
	MaoD16nVg8TLr7Yg/xfCjiJNF3Dzv9z9U0aBZ9IFtVCjsj6k=
X-Google-Smtp-Source: AGHT+IFlMBiAvOqsnatmIwWXcaLewBZcipjArBF56YA5CK4hwuN8Sr4PCAIy9Zx7pleQqX4SY5wKCcczWGx0NUfiiFY=
X-Received: by 2002:a05:6122:311b:b0:4f5:199b:2a7f with SMTP id
 71dfb90a1353d-4f6e68e211cmr2897951e0c.8.1722225466673; Sun, 28 Jul 2024
 20:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722110325.195085-1-saravanan.vajravel@broadcom.com> <20240728073811.GA4296@unreal>
In-Reply-To: <20240728073811.GA4296@unreal>
From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Date: Mon, 29 Jul 2024 09:27:35 +0530
Message-ID: <CAKDTOZAjQ12UB3tqkTv-yXgR+in-k7SdYnWk3XjpwrhbWng58Q@mail.gmail.com>
Subject: Re: [PATCH for-rc] rdma-core/mad: Improve handling of timed out WRs
 of mad agent
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000320399061e5add9a"

--000000000000320399061e5add9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 1:08=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Jul 22, 2024 at 04:33:25PM +0530, Saravanan Vajravel wrote:
> > Current timeout handler of mad agent aquires/releases mad_agent_priv
> > lock for every timed out WRs. This causes heavy locking contention
> > when higher no. of WRs are to be handled inside timeout handler.
> >
> > This leads to softlockup with below trace in some use cases where
> > rdma-cm path is used to establish connection between peer nodes
> >
> > Trace:
> > -----
> >  BUG: soft lockup - CPU#4 stuck for 26s! [kworker/u128:3:19767]
> >  CPU: 4 PID: 19767 Comm: kworker/u128:3 Kdump: loaded Tainted: G OE
> >      -------  ---  5.14.0-427.13.1.el9_4.x86_64 #1
> >  Hardware name: Dell Inc. PowerEdge R740/01YM03, BIOS 2.4.8 11/26/2019
> >  Workqueue: ib_mad1 timeout_sends [ib_core]
> >  RIP: 0010:__do_softirq+0x78/0x2ac
> >  RSP: 0018:ffffb253449e4f98 EFLAGS: 00000246
> >  RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 000000000000001f
> >  RDX: 000000000000001d RSI: 000000003d1879ab RDI: fff363b66fd3a86b
> >  RBP: ffffb253604cbcd8 R08: 0000009065635f3b R09: 0000000000000000
> >  R10: 0000000000000040 R11: ffffb253449e4ff8 R12: 0000000000000000
> >  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000040
> >  FS:  0000000000000000(0000) GS:ffff8caa1fc80000(0000) knlGS:0000000000=
000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007fd9ec9db900 CR3: 0000000891934006 CR4: 00000000007706e0
> >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >  PKRU: 55555554
> >  Call Trace:
> >   <IRQ>
> >   ? show_trace_log_lvl+0x1c4/0x2df
> >   ? show_trace_log_lvl+0x1c4/0x2df
> >   ? __irq_exit_rcu+0xa1/0xc0
> >   ? watchdog_timer_fn+0x1b2/0x210
> >   ? __pfx_watchdog_timer_fn+0x10/0x10
> >   ? __hrtimer_run_queues+0x127/0x2c0
> >   ? hrtimer_interrupt+0xfc/0x210
> >   ? __sysvec_apic_timer_interrupt+0x5c/0x110
> >   ? sysvec_apic_timer_interrupt+0x37/0x90
> >   ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> >   ? __do_softirq+0x78/0x2ac
> >   ? __do_softirq+0x60/0x2ac
> >   __irq_exit_rcu+0xa1/0xc0
> >   sysvec_call_function_single+0x72/0x90
> >   </IRQ>
> >   <TASK>
> >   asm_sysvec_call_function_single+0x16/0x20
> >  RIP: 0010:_raw_spin_unlock_irq+0x14/0x30
> >  RSP: 0018:ffffb253604cbd88 EFLAGS: 00000247
> >  RAX: 000000000001960d RBX: 0000000000000002 RCX: ffff8cad2a064800
> >  RDX: 000000008020001b RSI: 0000000000000001 RDI: ffff8cad5d39f66c
> >  RBP: ffff8cad5d39f600 R08: 0000000000000001 R09: 0000000000000000
> >  R10: ffff8caa443e0c00 R11: ffffb253604cbcd8 R12: ffff8cacb8682538
> >  R13: 0000000000000005 R14: ffffb253604cbd90 R15: ffff8cad5d39f66c
> >   cm_process_send_error+0x122/0x1d0 [ib_cm]
> >   timeout_sends+0x1dd/0x270 [ib_core]
> >   process_one_work+0x1e2/0x3b0
> >   ? __pfx_worker_thread+0x10/0x10
> >   worker_thread+0x50/0x3a0
> >   ? __pfx_worker_thread+0x10/0x10
> >   kthread+0xdd/0x100
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0x29/0x50
> >   </TASK>
> >
> > Simplified timeout handler by creating local list of timed out WRs
> > and invoke send handler post creating the list. The new method acquires=
/
> > releases lock once to fetch the list and hence helps to reduce locking
> > contetiong when processing higher no. of WRs
> >
> > Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> > ---
> >  drivers/infiniband/core/mad.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/ma=
d.c
> > index 674344eb8e2f..58befbaaf0ad 100644
> > --- a/drivers/infiniband/core/mad.c
> > +++ b/drivers/infiniband/core/mad.c
> > @@ -2616,14 +2616,16 @@ static int retry_send(struct ib_mad_send_wr_pri=
vate *mad_send_wr)
> >
> >  static void timeout_sends(struct work_struct *work)
> >  {
> > +     struct ib_mad_send_wr_private *mad_send_wr, *n;
> >       struct ib_mad_agent_private *mad_agent_priv;
> > -     struct ib_mad_send_wr_private *mad_send_wr;
> >       struct ib_mad_send_wc mad_send_wc;
> > +     struct list_head local_list;
> >       unsigned long flags, delay;
> >
> >       mad_agent_priv =3D container_of(work, struct ib_mad_agent_private=
,
> >                                     timed_work.work);
> >       mad_send_wc.vendor_err =3D 0;
> > +     INIT_LIST_HEAD(&local_list);
> >
> >       spin_lock_irqsave(&mad_agent_priv->lock, flags);
> >       while (!list_empty(&mad_agent_priv->wait_list)) {
> > @@ -2641,13 +2643,16 @@ static void timeout_sends(struct work_struct *w=
ork)
> >                       break;
> >               }
> >
> > -             list_del(&mad_send_wr->agent_list);
> > +             list_del_init(&mad_send_wr->agent_list);
> >               if (mad_send_wr->status =3D=3D IB_WC_SUCCESS &&
> >                   !retry_send(mad_send_wr))
> >                       continue;
> >
> > -             spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> > +             list_add_tail(&mad_send_wr->agent_list, &local_list);
> > +     }
> > +     spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> >
> > +     list_for_each_entry_safe(mad_send_wr, n, &local_list, agent_list)=
 {
> >               if (mad_send_wr->status =3D=3D IB_WC_SUCCESS)
> >                       mad_send_wc.status =3D IB_WC_RESP_TIMEOUT_ERR;
> >               else
> > @@ -2655,11 +2660,8 @@ static void timeout_sends(struct work_struct *wo=
rk)
> >               mad_send_wc.send_buf =3D &mad_send_wr->send_buf;
> >               mad_agent_priv->agent.send_handler(&mad_agent_priv->agent=
,
> >                                                  &mad_send_wc);
>
> I understand the problem, but I'm not sure that this is safe to do. How
> can we be sure that this is safe to call the send_handler on entry in
> wait_list without the locking?
>
> Thanks

Per existing implementation, the send_handler is invoked without locking.
I didn't change that design. Existing implementation was acquiring and
releasing the lock for every Work Request (WR) that it handles inside
timeout_handler.
I improved it in such a way that once lock is acquired to fetch list
of WR to be handled
and process all fetched WRs outside the scope of lock. In both implementati=
ons,
send_handler is always called without lock. This patch aims to reduce locki=
ng
contention

Thanks,
>
> > -
> >               deref_mad_agent(mad_agent_priv);
> > -             spin_lock_irqsave(&mad_agent_priv->lock, flags);
> >       }
> > -     spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> >  }
> >
> >  /*
> > --
> > 2.39.3
> >

--000000000000320399061e5add9a
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
XzCCBV4wggRGoAMCAQICDDPW1cVntFGljCZAOzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTE0NTZaFw0yNTA5MTAwOTE0NTZaMIGa
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGzAZBgNVBAMTElNhcmF2YW5hbiBWYWpyYXZlbDEuMCwGCSqG
SIb3DQEJARYfc2FyYXZhbmFuLnZhanJhdmVsQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOWUDY8+1Pq6qzzsf5oTzGO7etyb0HT08NkGz7Ymb6gL2BcSxf00xj2f
fgOR3x1R5vZCQL+NXGnk27IMYe6P1jT2e49wq24CtJxpjbdCgiY+wM0iowrqj+xHJyGEyFK7BEOB
1cEV+/7fNvlT+wzsiB6LI7YO2jnJoqRyxiuCXWXQteLT5u5dJd79gUxenL2sOdzc9QDElI3VQMfh
lU2WOYSpsHwmuzI2n56f4qqAd0KTzesYpT4jUkHrpARqokmK62nwak/mVjpP1xxKkerBRTDplTRj
PPaP6wQe1OY7fOWrqgKUrMkQ8uzH68KFHiA/+zIzyFmYwY+S3kdoi+SvK08CAwEAAaOCAeAwggHc
MA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
dDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFs
c2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+
oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcmwwKgYDVR0RBCMwIYEfc2FyYXZhbmFuLnZhanJhdmVsQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
0Bq3qvsz+PB5FAu5iL1KRdtSBTgwDQYJKoZIhvcNAQELBQADggEBAHXOk8r6/lLV2Fb8uE3tUP2E
MFD67H9X0roxhLywKzY+SM6abiUqsRxlcBwNgp0r/SwFG1o+frLlj7gynwfkzfsRzLRf//DYTUOF
qs8Os28DFCa/KvX0e56+c7xOOP9cwgHO3Tl2ri3MAGpxEB5r4PcgmWd4f9zmlmBGE9oNyoyntToB
pb/Gi74xj8wc5zCrVpXS1UNVJ8B6Jib+vas1cAtL6RFi0RDtFbUXe9U4wB07Ker1yMtBA6QzfZW2
d0VRyjqv9NL22cjJ4ffotr8ZKbiSVEHbnDRxAgeuMxkkpjQQk/y1S1fk0wDOYNfV0zIkWtVMNBzY
Ttmt2pp+/hwLYVAxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgwz1tXFZ7RRpYwmQDswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKLpdT2f
WRsg0p23uEopwfYnayNdEgqinCiYed1KwBqxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MDcyOTAzNTc0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBV0hDdgTgKRe9C8eHTuZU6x81s
xIjpiqDCZ76bhFHGMhb1Grh9CW9GOh63sSqI9diHYIJG7jBkWi5U54GdYJyFPFgyTE8o0XGutwqW
Inp+iCNgiF/lCJpuzGysABIFHDnnh0PeMe4Rffe14pSaePUQAIqgeMRwcj6BZ8X37QRDfCym4N58
ZhOl7CPvTkCpK9maEpiXKYjgEuTIvV3XSEYUz+JhYKOBtu1hgyCmqHe6kKmmLJXTlZCdjlbyN4Qt
Y+X3x2zyKAtFYvHtFr2LNvuuvWykzIONlFK1oRDjf0ILyNzwU+q/fK1QBkA7ldSfNbd2zCQ7Ockj
Ty/QFrGrGe2L
--000000000000320399061e5add9a--

