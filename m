Return-Path: <linux-rdma+bounces-4053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86193ED8D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 08:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973E7B20A8C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11784052;
	Mon, 29 Jul 2024 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Si2IDFmp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0064D
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235147; cv=none; b=PXIH3iIfIFm1Pm8GFQxjtXYnzHIcHW/p8+jOagd7sNQ/1sUnzN3AqxJyvYCqFiDinH3aAEwyFPxf4bOFWvQxHz7gU55PtWBBuX+17Ety1Lxepma6O34V5zdD0vtkDfxuF2rEJOKy3O6MPCTFN8ynpr6KQZT4rcgBGhstcvrjS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235147; c=relaxed/simple;
	bh=33CRYvg206fqcoDBqXooBxR1jsQEE1AVN2/DFE59Ee4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDWUCXvM6TUplBT8lY+ueWgxJvK4BuZSchAREAhVHjrdMLauacIZPd2IxI7JUD1BQWZWjTgc8/gcvDsc1W+YBIylqJVQ/3duYIZILXIgNjiuay/3wgNIeY7LMSxs7FtSYUai0x8vqpLlwV4a3B5R7L9zSo9h/0kt82e72GkgTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Si2IDFmp; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4ef33a09a3aso704250e0c.2
        for <linux-rdma@vger.kernel.org>; Sun, 28 Jul 2024 23:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722235144; x=1722839944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=owIp+8mTFJ9wvwYLNWGBUr/AUeTJ2ujicPnhWwml894=;
        b=Si2IDFmpxVKdzjs3Kcb5QCx/8psVyK+2cH2oYRju3aJDA/btQqBwt94v50P82BIsbk
         euX4ljWhkCBrHdGmjfYvzie7ihuVoH2GmWnZL66AEzimUbkDdBIjC6yxginQlLnhBKAq
         +C6dh4KdgDFCuJGcX0z/A4oPknpNdLdjEyEQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722235144; x=1722839944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owIp+8mTFJ9wvwYLNWGBUr/AUeTJ2ujicPnhWwml894=;
        b=reiued1xvRM8nRaTAzaUB2NAPKi/zH4ddSrhBo7yrzQTkLI5kCy7S6u3llturdjtfJ
         1c9UpW6McMls+QZpl8wAw3O5eWOvgfpBoWsHzbA4CqtJ6NySflmHK1tkX4xSm6OugRt1
         s+kpi5+JILxqGtsWbZxroUUhmYcUgr/5UA+qJIulUYcpvjMeLOLd2JUVv1Fecqh4b7IY
         mmXxLPEPlN4skrkygl3eAQENytKTHB6QfQJq4vwBrwGKacqcSAN3Tu9sXawLtDhGGMyz
         hc62+opMCthKjW9XKh0JAuqayJcfe85W0ZmfPjyiSvdu3sANF2P05t8lzIxmWty68YKO
         APSw==
X-Forwarded-Encrypted: i=1; AJvYcCUz2vw1wdq+2r0j4cfFQ6p5siMh3ixAKRCaSW8EvAWR4v4vimvC+vDUnzPmj0tj+fx3Lf/GqRnYhJdo3o2vavoWrFjcDD+EA+/4Jw==
X-Gm-Message-State: AOJu0YysR6FmUEVgdRHZaN4MXuh/mfR87q7Fyd+fntpiQ+N5UiwlpRBQ
	MIk55pe0p3Y3WHE3jZHu5YsqhUl5oNcMMCP4ibMNvUYVDpO8kQU9yk/xZDHREiscizWI/Gy4ryT
	XNlZXTUr3hkMUdq1ILcx1EXQ0urH5XoL/KIt7OsT7IdBwisH6bQ==
X-Google-Smtp-Source: AGHT+IF0X2py/U2mKrKA76kM6cuVDKTBjs4tlKAVLJbuZQQJzrCIJ6+EmyyDHTXrY/hl1IS4CCl8YBQuPqEKpSqiARM=
X-Received: by 2002:a05:6122:311b:b0:4f5:199b:2a7f with SMTP id
 71dfb90a1353d-4f6e68e211cmr3143255e0c.8.1722235143854; Sun, 28 Jul 2024
 23:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722110325.195085-1-saravanan.vajravel@broadcom.com>
 <20240728073811.GA4296@unreal> <CAKDTOZAjQ12UB3tqkTv-yXgR+in-k7SdYnWk3XjpwrhbWng58Q@mail.gmail.com>
 <20240729061018.GA5669@unreal>
In-Reply-To: <20240729061018.GA5669@unreal>
From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Date: Mon, 29 Jul 2024 12:08:52 +0530
Message-ID: <CAKDTOZDfxPCfS=5oOu56cfd+TPicr24ARXY3ed3iLS5qU-o_Qw@mail.gmail.com>
Subject: Re: [PATCH for-rc] rdma-core/mad: Improve handling of timed out WRs
 of mad agent
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ff1d09061e5d1d62"

--000000000000ff1d09061e5d1d62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:40=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Mon, Jul 29, 2024 at 09:27:35AM +0530, Saravanan Vajravel wrote:
> > On Sun, Jul 28, 2024 at 1:08=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Mon, Jul 22, 2024 at 04:33:25PM +0530, Saravanan Vajravel wrote:
> > > > Current timeout handler of mad agent aquires/releases mad_agent_pri=
v
> > > > lock for every timed out WRs. This causes heavy locking contention
> > > > when higher no. of WRs are to be handled inside timeout handler.
> > > >
> > > > This leads to softlockup with below trace in some use cases where
> > > > rdma-cm path is used to establish connection between peer nodes
> > > >
> > > > Trace:
> > > > -----
> > > >  BUG: soft lockup - CPU#4 stuck for 26s! [kworker/u128:3:19767]
> > > >  CPU: 4 PID: 19767 Comm: kworker/u128:3 Kdump: loaded Tainted: G OE
> > > >      -------  ---  5.14.0-427.13.1.el9_4.x86_64 #1
> > > >  Hardware name: Dell Inc. PowerEdge R740/01YM03, BIOS 2.4.8 11/26/2=
019
> > > >  Workqueue: ib_mad1 timeout_sends [ib_core]
> > > >  RIP: 0010:__do_softirq+0x78/0x2ac
> > > >  RSP: 0018:ffffb253449e4f98 EFLAGS: 00000246
> > > >  RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 000000000000001f
> > > >  RDX: 000000000000001d RSI: 000000003d1879ab RDI: fff363b66fd3a86b
> > > >  RBP: ffffb253604cbcd8 R08: 0000009065635f3b R09: 0000000000000000
> > > >  R10: 0000000000000040 R11: ffffb253449e4ff8 R12: 0000000000000000
> > > >  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000040
> > > >  FS:  0000000000000000(0000) GS:ffff8caa1fc80000(0000) knlGS:000000=
0000000000
> > > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >  CR2: 00007fd9ec9db900 CR3: 0000000891934006 CR4: 00000000007706e0
> > > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > >  PKRU: 55555554
> > > >  Call Trace:
> > > >   <IRQ>
> > > >   ? show_trace_log_lvl+0x1c4/0x2df
> > > >   ? show_trace_log_lvl+0x1c4/0x2df
> > > >   ? __irq_exit_rcu+0xa1/0xc0
> > > >   ? watchdog_timer_fn+0x1b2/0x210
> > > >   ? __pfx_watchdog_timer_fn+0x10/0x10
> > > >   ? __hrtimer_run_queues+0x127/0x2c0
> > > >   ? hrtimer_interrupt+0xfc/0x210
> > > >   ? __sysvec_apic_timer_interrupt+0x5c/0x110
> > > >   ? sysvec_apic_timer_interrupt+0x37/0x90
> > > >   ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > >   ? __do_softirq+0x78/0x2ac
> > > >   ? __do_softirq+0x60/0x2ac
> > > >   __irq_exit_rcu+0xa1/0xc0
> > > >   sysvec_call_function_single+0x72/0x90
> > > >   </IRQ>
> > > >   <TASK>
> > > >   asm_sysvec_call_function_single+0x16/0x20
> > > >  RIP: 0010:_raw_spin_unlock_irq+0x14/0x30
> > > >  RSP: 0018:ffffb253604cbd88 EFLAGS: 00000247
> > > >  RAX: 000000000001960d RBX: 0000000000000002 RCX: ffff8cad2a064800
> > > >  RDX: 000000008020001b RSI: 0000000000000001 RDI: ffff8cad5d39f66c
> > > >  RBP: ffff8cad5d39f600 R08: 0000000000000001 R09: 0000000000000000
> > > >  R10: ffff8caa443e0c00 R11: ffffb253604cbcd8 R12: ffff8cacb8682538
> > > >  R13: 0000000000000005 R14: ffffb253604cbd90 R15: ffff8cad5d39f66c
> > > >   cm_process_send_error+0x122/0x1d0 [ib_cm]
> > > >   timeout_sends+0x1dd/0x270 [ib_core]
> > > >   process_one_work+0x1e2/0x3b0
> > > >   ? __pfx_worker_thread+0x10/0x10
> > > >   worker_thread+0x50/0x3a0
> > > >   ? __pfx_worker_thread+0x10/0x10
> > > >   kthread+0xdd/0x100
> > > >   ? __pfx_kthread+0x10/0x10
> > > >   ret_from_fork+0x29/0x50
> > > >   </TASK>
> > > >
> > > > Simplified timeout handler by creating local list of timed out WRs
> > > > and invoke send handler post creating the list. The new method acqu=
ires/
> > > > releases lock once to fetch the list and hence helps to reduce lock=
ing
> > > > contetiong when processing higher no. of WRs
> > > >
> > > > Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> > > > ---
> > > >  drivers/infiniband/core/mad.c | 14 ++++++++------
> > > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/cor=
e/mad.c
> > > > index 674344eb8e2f..58befbaaf0ad 100644
> > > > --- a/drivers/infiniband/core/mad.c
> > > > +++ b/drivers/infiniband/core/mad.c
> > > > @@ -2616,14 +2616,16 @@ static int retry_send(struct ib_mad_send_wr=
_private *mad_send_wr)
> > > >
> > > >  static void timeout_sends(struct work_struct *work)
> > > >  {
> > > > +     struct ib_mad_send_wr_private *mad_send_wr, *n;
> > > >       struct ib_mad_agent_private *mad_agent_priv;
> > > > -     struct ib_mad_send_wr_private *mad_send_wr;
> > > >       struct ib_mad_send_wc mad_send_wc;
> > > > +     struct list_head local_list;
> > > >       unsigned long flags, delay;
> > > >
> > > >       mad_agent_priv =3D container_of(work, struct ib_mad_agent_pri=
vate,
> > > >                                     timed_work.work);
> > > >       mad_send_wc.vendor_err =3D 0;
> > > > +     INIT_LIST_HEAD(&local_list);
> > > >
> > > >       spin_lock_irqsave(&mad_agent_priv->lock, flags);
> > > >       while (!list_empty(&mad_agent_priv->wait_list)) {
> > > > @@ -2641,13 +2643,16 @@ static void timeout_sends(struct work_struc=
t *work)
> > > >                       break;
> > > >               }
> > > >
> > > > -             list_del(&mad_send_wr->agent_list);
> > > > +             list_del_init(&mad_send_wr->agent_list);
> > > >               if (mad_send_wr->status =3D=3D IB_WC_SUCCESS &&
> > > >                   !retry_send(mad_send_wr))
> > > >                       continue;
> > > >
> > > > -             spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> > > > +             list_add_tail(&mad_send_wr->agent_list, &local_list);
> > > > +     }
> > > > +     spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> > > >
> > > > +     list_for_each_entry_safe(mad_send_wr, n, &local_list, agent_l=
ist) {
> > > >               if (mad_send_wr->status =3D=3D IB_WC_SUCCESS)
> > > >                       mad_send_wc.status =3D IB_WC_RESP_TIMEOUT_ERR=
;
> > > >               else
> > > > @@ -2655,11 +2660,8 @@ static void timeout_sends(struct work_struct=
 *work)
> > > >               mad_send_wc.send_buf =3D &mad_send_wr->send_buf;
> > > >               mad_agent_priv->agent.send_handler(&mad_agent_priv->a=
gent,
> > > >                                                  &mad_send_wc);
> > >
> > > I understand the problem, but I'm not sure that this is safe to do. H=
ow
> > > can we be sure that this is safe to call the send_handler on entry in
> > > wait_list without the locking?
> > >
> > > Thanks
> >
> > Per existing implementation, the send_handler is invoked without lockin=
g.
> > I didn't change that design. Existing implementation was acquiring and
> > releasing the lock for every Work Request (WR) that it handles inside
> > timeout_handler.
> > I improved it in such a way that once lock is acquired to fetch list
> > of WR to be handled
> > and process all fetched WRs outside the scope of lock. In both implemen=
tations,
> > send_handler is always called without lock. This patch aims to reduce l=
ocking
> > contention
>
> Indeed send_handler is called without lock, but not on the wait_list.
> I've asked explicitly about operations on the wait_list.
>
> Thanks

The entry in wait_list is removed under the scope of mad_agent_priv->lock.
It is then added to local_list declared inside timeout_sends() handler
under the same
lock. Once all such entries are removed and added to the local_list,
this timeout_handler
processes each entry from the local_list and it invokes send_handler.
This local_list
doesn't need any locking as there is no possibility of race condition.

Existing implementation also removed entry from wait_list and invoked
send_handler.
So operation on the wait_list should not change in the new patch

Thanks,

> > >
> > > > -
> > > >               deref_mad_agent(mad_agent_priv);
> > > > -             spin_lock_irqsave(&mad_agent_priv->lock, flags);
> > > >       }
> > > > -     spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> > > >  }
> > > >
> > > >  /*
> > > > --
> > > > 2.39.3
> > > >
>
>

--000000000000ff1d09061e5d1d62
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfwYJKoZIhvcNAQcCoIIQcDCCEGwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3WMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
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
MDIwAgwz1tXFZ7RRpYwmQDswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINM+SeVc
30xdGenVLkAccD/hYhFl+GPst2ZrU4acIbNeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MDcyOTA2MzkwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBMFV32i3Gkgc1ULby6j89Xc6N9
K7ZQxtGZNPaGAIXGf8JBe3yhFbY5LBel7zB5BiOKEu+9Mkmxd+a4kMXkGta0GPerKglXRy1SCYT2
NTCUKDTV2I5l3G8tnLiYuGnjo0L7LzZ9vBYPvqZ47MAyBG5KmLCIquMF0ApY9QLVhDqQBh0Ayhnj
MkcGHOqAOUxv/S4GAYfU6arjyjJrdEXRcnTpgpEvLZya+Dv5lLxzyTr2OgYncFELpQ80Fp5C/4iX
PM48hIi6H2s/+Q28Iw/PmWTnE3jLFhkStpQRzOINN1QyDe/sFI8Qph+FvB+bJzIawiLRBdpiGaFY
RRCGdWleZDNt
--000000000000ff1d09061e5d1d62--

