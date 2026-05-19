Return-Path: <linux-rdma+bounces-20961-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOqaAltmDGo9hAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20961-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:32:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5E57FB5F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A0C730EAC22
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7240961A;
	Tue, 19 May 2026 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cvAQy/Li"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229740960A
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196855; cv=none; b=uUABnrNK29SWoEq11Gimeps3NnyPMXGiBzbUJEa7YqTynwhdJe4KSgrrJsba3SLfgMjh3QtMqgytf4z2WINcFRAqkRoxRMGoIuJfwQSEw6OXHGewDTXWpO+nRasuos0IWas/T9uxouJOiFo52+OaNghR5W8bcnRUr3KR43heE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196855; c=relaxed/simple;
	bh=GHuQkrM6lgbbQwN+458ZAUNIRPduv/2+yiGcKgBTBzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTM2JQ1JVblqLbTT7vlyIreSIJq8I7r+gSwuGS//cZjxWrMYVIUuK2EH4rA8OYEBZ1MVyIGVP4fll0ypF40akVgQHFB1g92J3/YYLYGMV9b9wHFpB99TXLg4TDG33Ir5NfanGkH89t5Aha2ANw2JOMHvoE7GDpduoqFBKbx3C5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cvAQy/Li; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-9116861f004so857676185a.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 06:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196853; x=1779801653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvDoTENedhkKm5CvMakLIL63WoCd4wnemSkIrfEsEMc=;
        b=qkJyJ/NkbH8mvb0O+u/cr+PKjHPkuOwdxXo9L5hIHLgFH6kmL2MaLWkcgReI4xAx8D
         rbnWO7jk3J6TeePR5aLvjbthITva8tFbxF6uxpsgWqKx6WNenT/oosROXspqDPNEXMcZ
         X0LDG9M9i34/nM9JhTXp28q+5mGU+8KgUZ2fDPiJD96bepaZ7iU3xM2JIzC8k5776XNr
         BH7ROim+/bppFfQ/kZbvXJDTJw9XVbHwTVRttaosl0tELbhPNBOk1FNkKi0z0btwW71x
         Be08VChk5MtKAU8bGPn7lZ8C2YC1LLU/HboJQxFMzPvLQcbwPt6oOYryDrjKs6qTlwmP
         Ek+w==
X-Forwarded-Encrypted: i=1; AFNElJ992qommUVNBxKRA8/xX1FRnqpj+oa6CpQVRTttj0kOZdhB+uUGWYIL7mGf8VcHB4D5/VKrNCpTxep8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0htIhZ/7azAUUVDDkYWX73x4lSILXaYLmQpCz7mI54o3eoQhT
	Zee/aWPxbFjb/EuDRHnolNSBQAOBZc/W75rvVnEZUxHSNSm9euCbGmrjjSuoUMKgn2Ft0Xwxedz
	MASRNE/5WhiQoPepU0GgZQtB/PT669xuQUBIip6q7DoSdlOUd8N9//lbCPzhYwgHiQW22slw3x2
	K5slXx7s8Hzz37pMzDogJihtmPhdRlqS4zYVj31/hTrSgsLUXXwTiQ1lSyZ3504wcmdfaeF2vn5
	z37YyIycr43A2jlGz5Zoze3oq4c
X-Gm-Gg: Acq92OH4uudyUVjFZ5Fp9tWKVixBJOTps1ZQCLLPFPGHZew0+xwkXV6Rjo7UrGkUzcj
	wnlCwsBV4BQVvph3DTRUOw/ekA94kBngpsWUtethxQI0J4IbCgkiIYtY20v7/TsOYvX5Pm/lHHo
	hjSwoOhWlSJj+UQVfkF3JwGdzSAG6ZkwMuLRkTp1A3jJW/7bBtPuFT1XFxDn0nIyVQ56HEuTSeV
	d7Bxkel5M9o9ZgF8CODlvvOodm2gpogJjJqNytLb8zAEjaBsmP5VzQ44afXqhVpQZfaZcwbBkqt
	GWTAnGxSvjGtQlSGyM0byhMtZOczgJQhbpt4d30qlxMrdxQq/yl5zETcZlr/u05FA0y/ZYREYd8
	kCHHWn3U0zevQTR25m/a/RgyCQc2M83Hstv5kLNfDJqz0QZh217G0IGXUiWMjllQLiyCziJirLp
	qBWZ9UxJ6eQlVcNGli3KOrbDR1JyPAfnvh8+uPgEAU5t3qu2Krg9dgnlBWa51hNxpM9hnB
X-Received: by 2002:a05:620a:2904:b0:913:e5bb:3db2 with SMTP id af79cd13be357-913e5bb5427mr1338299885a.41.1779196852216;
        Tue, 19 May 2026 06:20:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-910bb283a4csm95492785a.4.2026.05.19.06.20.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 06:20:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45b7ff2140eso3131109f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779196851; x=1779801651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MvDoTENedhkKm5CvMakLIL63WoCd4wnemSkIrfEsEMc=;
        b=cvAQy/LiYmFxgn5n28vJbNfYkMmleXmlI/YISPuG0fEexP8V+avIvQtWcSU7LONCIi
         fgv38SbIGzgrzM9kSe0DO8Sx3KSaJoeRUkuEsLXen2Wblu0iq9BrMwz8Sw+5Zfmygqe/
         K0y54f0+W3Q9oRZ071004BKV7i4p4iSFXfuco=
X-Forwarded-Encrypted: i=1; AFNElJ8CUQmtGt9Q1q3ob6CyFEireBCW9tNGpoaci/1ZF/lqE2oODr1eV44kTjeO3rA37kE9XmI6xQQqmaWp@vger.kernel.org
X-Received: by 2002:a05:6000:310c:b0:43e:a73e:cc8a with SMTP id ffacd0b85a97d-45e5c5d88fcmr33162226f8f.36.1779196850655;
        Tue, 19 May 2026 06:20:50 -0700 (PDT)
X-Received: by 2002:a05:6000:310c:b0:43e:a73e:cc8a with SMTP id
 ffacd0b85a97d-45e5c5d88fcmr33162179f8f.36.1779196850234; Tue, 19 May 2026
 06:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
 <20260518153721.183749-8-sriharsha.basavapatna@broadcom.com>
 <CAHHeUGWK_2RNG=CaHTnNh2JeAXa9mcTam6p_7Qp6eG+6Nip+_w@mail.gmail.com> <20260519124600.GX7702@ziepe.ca>
In-Reply-To: <20260519124600.GX7702@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 19 May 2026 18:50:38 +0530
X-Gm-Features: AVHnY4KkC2QTRRc4LpUYgUI21h7teZvrTR_KbPE0-YqwCwoM0C7k21_BDhFuq74
Message-ID: <CAHHeUGWpp8n1dHAu=MfYiLhntzK=PtvNyRBHhD0W9KkthEgYUw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v6 7/9] RDMA/bnxt_re: Enhance dpi lifecycle
 logic in doorbell uapis
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004a21c506522b8c37"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20961-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 77D5E57FB5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000004a21c506522b8c37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 6:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 19, 2026 at 02:57:16PM +0530, Sriharsha Basavapatna wrote:
> > On Mon, May 18, 2026 at 9:17=E2=80=AFPM Sriharsha Basavapatna
> > <sriharsha.basavapatna@broadcom.com> wrote:
> > >
> > > If the DPI is freed when the dbr object is freed, but if the
> > > process has not unmapped the page yet, then the DPI slot could
> > > get reallocated to another process while the original process
> > > still has it mapped. To prevent this, save the DPI info in the
> > > mmap entry during dbr allocation and free the DPI slot from
> > > bnxt_re_mmap_free(), which enures that there are no references
> > > to it.
> > >
> > > This change is needed to support doorbell allocation to QPs
> > > in the next patch.
> > >
> > > Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.=
com>
> > > Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c |  4 ++++
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
> > >  drivers/infiniband/hw/bnxt_re/uapi.c     | 12 ++++++++++--
> > >  3 files changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infin=
iband/hw/bnxt_re/ib_verbs.c
> > > index 9fd85d81bcea..b8e46feafee7 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > @@ -4943,6 +4943,10 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_e=
ntry *rdma_entry)
> > >         bnxt_entry =3D container_of(rdma_entry, struct bnxt_re_user_m=
map_entry,
> > >                                   rdma_entry);
> > >
> > > +       if (bnxt_entry->mmap_flag =3D=3D BNXT_RE_MMAP_UC_DB && bnxt_e=
ntry->uctx)
> > > +               bnxt_qplib_free_uc_dpi(&bnxt_entry->uctx->rdev->qplib=
_res,
> > > +                                      &bnxt_entry->dpi);
> > > +
> > >         kfree(bnxt_entry);
> > >  }
> > There's a sashiko warning on this change:
> >
> > "Also, does this introduce a use-after-free during device hot-unplug?
> > During hot-unplug, the RDMA core tears down the ib_ucontext (which
> > embeds bnxt_re_ucontext) synchronously. However, active VMAs outlive
> > the ucontext because hot-unplug only zaps the PTEs without closing the
> > VMAs. When the process later exits or manually unmaps the memory,
> > bnxt_re_mmap_free() is triggered. Will dereferencing
> > bnxt_entry->uctx->rdev->qplib_res result in a use-after-free since the
> > uctx has already been freed?"
>
> Hmm! That is a pretty reasonable assumption..
>
> > ufile_destroy_ucontext(reason =3D=3D RDMA_REMOVE_DRIVER_REMOVE) -->
> > uverbs_user_mmap_disassociate() --> rdma_user_mmap_entry_put() -->
> > rdma_user_mmap_entry_free() --> ucontext->device->ops.mmap_free()
>
> Yes, that's right. The disassociate removes the references from all
> the VMAs so it should always eventually call free.
Ok, so disassociate() triggers mmap free in the driver while
ib_ucontext is still valid, right?  The use-after-free concern raised
above, where uctx has been freed, shouldn't occur?
>
> However, it would be best if we didn't have this code in the free
> callback at all, ideally the destruction of the object will happen in
> the uobject destructor not the mmap free. However, I think we lack the
> ability to do that right now.
>
I had to move it into mmap_free() because a prior concern pointed out
that the dpi could be reallocated to another process, while the
original process's mmap is still active.  Although the bnxt_re library
unmaps first and then destroys the dbr object (i.e in the right
sequence), I still tried to address that concern by moving it into
mmap free context.
> Jason

Thanks,
-Harsha

--0000000000004a21c506522b8c37
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBmZFnBcrL7VYXPQgkmJnTqL4/zQgypAdV3
INSPggksKjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkx
MzIwNTFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCC5HHnxT1FErhoLkGH2CuDdzfK/dzHMlw7nGli/MtTNDx54Fl2Z/MQHdV0Jgg3ojCsVqjd
ZszR9492yxeYQlRTE9qVNdltt+6adiZJ9KQO4U7vXfLn2/MuitikZZGe3JVIflUoZMEE4cIydUA8
1oIfnoclYwmGLEZp6nM9h7ZqrB1HKgRV+5qsH+WxMcAif+PDVx18Z1TcGWJPi4U5zauW3GwELQQz
AfrGNuBRvo9iSZ4I3a34z2175Qd8U+B3M9MDAt9eAW/4Anjk1TuRcr4GAg8YdbAO73AK+BIbskZK
YauQfMrNNKHZAn0oNTdd9toyPyPfXbeARxH1C0dG7l5p
--0000000000004a21c506522b8c37--

