Return-Path: <linux-rdma+bounces-16941-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GU5Inr2k2lz+AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16941-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 06:02:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA84A148C08
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 06:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC9A301651F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88F26D4C3;
	Tue, 17 Feb 2026 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FYdvqPVW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0ED1E00B4
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771304564; cv=pass; b=PFrlEKNhdw3wP/c6wvqDphG80dYDu7Vb346SI2uIj9YMBdureKU7ZxlSVRwp2Vj3Ldt9Jmcau87zUML6PBD2tYbkCUiU29CeKwRZb/7M6RVsciTWDJ+lHFhwukYYtuXKSpth24DRWXda4htiYgzpMRfd3zBmlRkxoSrg9ulxLf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771304564; c=relaxed/simple;
	bh=9oqxXNNwRLcjWWXS1c31l4xKkBOGn6iFcJkPhUk5FMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrH/5fCprmsgWkOVP1NI6kZP1uX8G7Wts9vOVOLM3BECmjunnHefNjM2npxIp2XJ+MBXIYJonQiyXh+4uzQ4zi7vPJKv4wXmWq97m1vWpf0atxFBJfGGrWMuJKxasxUQ6Z4IdUAv0GFmmOMWP61LBAjTGfg9BXRrFPyzGfUWcac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FYdvqPVW; arc=pass smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-2b86671f87eso1281194eec.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 21:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771304562; x=1771909362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qM5l1XGxkCoLO5ueO+fKyRWF3FqpMv151RziVymlp8=;
        b=ZnPjKl3okoG3XCyAdrWvaeXRVwK7auGU4z8l+6/bMCrpSTD9h/8KQ4grr24TL7cWO2
         wMZ9Vzj+iaURYOe0ce6NUtJ4p+jc9D3hXtddEDEWkMyf+hNfNfsYdZXon+sdgQbtF7/Z
         ZCccxIfa7zgiXUdE0MFlGF9ffVssjTjdP1nH984XBTLUMVnmLREAeLzemLzdLZRI9wtP
         aq2QkcNjquOiR8Y5+iYZsQ3gX1FI1NnqI3yRCtglY3BHwGUpyeo7tUlLa12Dw4Rpcqz/
         AOCoUrZc78Py0LhIB+MxAVxPNwP/iWN9bNXaDmu8cUgqVhIntfczuRCKKlNSENukZuy8
         plzw==
X-Forwarded-Encrypted: i=2; AJvYcCXuiHbjNeCSBtFStOxGgLE8BRp0GPfbNqwGdB9MldSkTjFtZRi/oMP6RKYrl+A8OFhG61pR2UwzorAz@vger.kernel.org
X-Gm-Message-State: AOJu0YwfE5u9J/YKBiFprZf6RRmBlO5v4jlHoi2MPxYza8SFMWuaSICw
	SV+PMijogD7jtqBIyG4N7yml29MfU3zWIehzcmxV1aCB1UUZVcct24bCO+4fI17tPBY0gP/gwx+
	MEPkG2XllTh9PIzwjZ8/dW9L7g3TMMGMcFj1L84+9PLYKBKsFauWB17fJrLdCyBtfy9rJIVnOQa
	uvDU889UB6qertWZM598nxjiyNfHX91h1tsfIEVJQ1uLb2+AtAFdp5Qc1M+74+dnl4z1AqSrDtX
	GbxFKJudtjlkOQG1g==
X-Gm-Gg: AZuq6aKawFpyYllE6ry6gTtaPsyYkhGL4jNipbqI+GqCIZF7Eq8F6p41xtImxQ0Ql6C
	i0fJkYXOdXH2Dio1rULyzL9jehxCg68Dllw6DcuDVXeV4hQmlenE6RWLs74I3/qw8fVMyDjOty0
	CzFEdaUhfdgROEONSoQw6+7I2TP+Vx291/FkZC8Pb0oC4VNSyYiyX5L8Z7o3ACmOihOw32lA7Wr
	4NRO9o0/xCqqdUPTW/hH6z7+2ltoesnX30RVQwK8iQv8Uxvzm4pIjVV+HjuBSaDGN2DGcRUQOL9
	5mjS2XJEjUwfFDdjJKSyFKF5rDO09jMlOMdY4uLDoU/CrZsOI0GMQRhWuAia4HjLrIGhCFJUfL/
	HWSkflP0JOyYUHQ5It2pRDz9tTQ3gpIOElfQQj3HR5kXQvnrNNHnfZelF4S5oZt7Ms2jrxKiOww
	+rPOyH9sBJL5xnzTErVOr3r6Mn4DfBCiKd08Io/gHSp16k9XdgHnk1VHjEK0pD
X-Received: by 2002:a05:7300:bc08:b0:2ab:ca55:b762 with SMTP id 5a478bee46e88-2babc4bcd74mr5947970eec.41.1771304561528;
        Mon, 16 Feb 2026 21:02:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2bacb412166sm1237556eec.0.2026.02.16.21.02.40
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 21:02:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-65811843ecbso8097663a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 21:02:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771304559; cv=none;
        d=google.com; s=arc-20240605;
        b=Vfwm3ovblwnsAcBkh56ZUGChjO60eNZkoIRAdyi3WyxDhcCiJZD7rIXpH0ndjiSreH
         M8XIdqf6AjprwNItVmMg5c59lRAAoTOFokRdXRLfEXtCyIxeoV0CcofgRXhJwYRwpxUo
         VQycCZsSDlAb6CFQ2HAzPL+/3eSLIEbi/Xx4Y635aEo1cXoPu79xpI5G/65M51TorOOF
         z/f0TcUHhTxH+cZXtKy0n0U85Q7q5DbPWiysBTosKuPIlGyyUUxtJROSsr80nYWSvEEz
         Q/G+Km+YCbMlURpy9br346I3aT4jHJpaIhCHeP4Y+zgYfBVI7QAWfrOD7aB65m7LScNl
         a/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/qM5l1XGxkCoLO5ueO+fKyRWF3FqpMv151RziVymlp8=;
        fh=1E5ODKyj7O5w9oqeBs+o4jTuPLxqzD6QnIoAcA1PDNk=;
        b=cfTkkxTmGqPBJzQccublS8A5/er9IOMNTxTUVCrbSSGpmVJN1Z+iyj0vksM6I3hZyY
         bNFquTy2s54u/pVBRirGDa955362ahqgI8TVVWJJ3jjHN5djY4/zj6ToSq3bgELT3gQ4
         2cColWZL2BEzi7c2PlZ2cq5pgxK95xSH8wO5EQB7dz7w6ZzPutw8vxhSwcrF5QQ8Y+bO
         TmrZIrrxIEVVOED5wsrNor4r+/Kxm9ORRGDB3A1qTxwV0H+b14XxjWUnTAzeTBxGHJ2h
         1D8IUlv4YY+JxoE/wtEwIofztw6d8Nk12+2OCaYsieml1f1Fx5PBF0tkJ5ikiQqR3INn
         Ty3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771304559; x=1771909359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/qM5l1XGxkCoLO5ueO+fKyRWF3FqpMv151RziVymlp8=;
        b=FYdvqPVWJXkYp3UE70jHU80rNn8Kk17DgrcPGXbewkERIxz4iVz+yePExQraMBaCDy
         8o1JricUAmj1WW5K0pcO2xPd5Ac4wbXNWn6Ipv6yHBRlnm2nMOncILxSfmT+t/CSZUDW
         fugemZfcKB+oaTHfMrOLa+hHEmltlYkhnTHiI=
X-Forwarded-Encrypted: i=1; AJvYcCXCq6xCXOOU+r4ToNJ9GhSLHgk8ONEj7ThBbDr17PJOflS8aqCFn8VDG0Mx2Nqch+uNIZwQi1D9x0b4@vger.kernel.org
X-Received: by 2002:a17:907:6090:b0:b8f:e9a7:a8c2 with SMTP id a640c23a62f3a-b8fe9a7d0bdmr438926366b.6.1771304559205;
        Mon, 16 Feb 2026 21:02:39 -0800 (PST)
X-Received: by 2002:a17:907:6090:b0:b8f:e9a7:a8c2 with SMTP id
 a640c23a62f3a-b8fe9a7d0bdmr438923066b.6.1771304558608; Mon, 16 Feb 2026
 21:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com> <CA+sbYW0Gh2bLoPZKzH9u-EcWDTz6mbF3RB=6Q3q=m7YpUpNU6Q@mail.gmail.com>
 <20260216080746.GD12989@unreal>
In-Reply-To: <20260216080746.GD12989@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 17 Feb 2026 10:32:25 +0530
X-Gm-Features: AaiRm53FO0fXlH9Z-AMwChPEUDMP2xOZ6emsM1DFIKEapraRFfYRH7QTZDSi9yU
Message-ID: <CA+sbYW0Ba==5Z5fyqjBS1AH8HE37ese2qMiR4+hoY-i8pajzQg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 42/50] RDMA/bnxt_re: Complete CQ resize in a
 single step
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Michael Margolin <mrgolin@amazon.com>, 
	Gal Pressman <gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>, 
	Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>, 
	Chengchang Tang <tangchengchang@huawei.com>, Junxian Huang <huangjunxian6@hisilicon.com>, 
	Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, 
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Long Li <longli@microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Michal Kalderon <mkalderon@marvell.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	Bernard Metzler <bernard.metzler@linux.dev>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000011d4f6064afdfb4d"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16941-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: DA84A148C08
X-Rspamd-Action: no action

--00000000000011d4f6064afdfb4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 1:37=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Feb 16, 2026 at 09:29:29AM +0530, Selvin Xavier wrote:
> > On Fri, Feb 13, 2026 at 4:31=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > There is no need to defer the CQ resize operation, as it is intended =
to
> > > be completed in one pass. The current bnxt_re_resize_cq() implementat=
ion
> > > does not handle concurrent CQ resize requests, and this will be addre=
ssed
> > > in the following patches.
> > bnxt HW requires that the previous CQ memory be available with the HW u=
ntil
> > HW generates a cut off cqe on the CQ that is being destroyed. This is
> > the reason for
> > polling the completions in the user library after returning the
> > resize_cq call. Once the polling
> > thread sees the expected CQE, it will invoke the driver to free CQ
> > memory.
>
> This flow is problematic. It requires the kernel to trust a user=E2=80=91=
space
> application, which is not acceptable. There is no guarantee that the
> rdma-core implementation is correct or will invoke the interface properly=
.
> Users can bypass rdma-core entirely and issue ioctls directly (syzkaller,
> custom rdma-core variants, etc.), leading to umem leaks, races that overw=
rite
> kernel memory, and access to fields that are now being modified. All of t=
his
> can occur silently and without any protections.
>
> > So ib_umem_release should wait. This patch doesn't guarantee that.
>
> The issue is that it was never guaranteed in the first place. It only app=
eared
> to work under very controlled conditions.
>
> > Do you think if there is a better way to handle this requirement?
>
> You should wait for BNXT_RE_WC_TYPE_COFF in the kernel before returning
> from resize_cq.
The difficulty is that libbnxt_re  in rdma-core has the  queue  the
consumer index used for completion lookup. The driver therefore has to
use copy_from_user to read the queue memory and then check for
BNXT_RE_WC_TYPE_COFF, along with the queue consumer index and the
relevant validity flags. I=E2=80=99ll explore if we have a way to handle th=
is
and get back.
>
> Thanks
>
> >
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 33 +++++++++-------------=
----------
> > >  1 file changed, 9 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infin=
iband/hw/bnxt_re/ib_verbs.c
> > > index d652018c19b3..2aecfbbb7eaf 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > @@ -3309,20 +3309,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, cons=
t struct ib_cq_init_attr *attr,
> > >         return rc;
> > >  }
> > >
> > > -static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
> > > -{
> > > -       struct bnxt_re_dev *rdev =3D cq->rdev;
> > > -
> > > -       bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq=
);
> > > -
> > > -       cq->qplib_cq.max_wqe =3D cq->resize_cqe;
> > > -       if (cq->resize_umem) {
> > > -               ib_umem_release(cq->ib_cq.umem);
> > > -               cq->ib_cq.umem =3D cq->resize_umem;
> > > -               cq->resize_umem =3D NULL;
> > > -               cq->resize_cqe =3D 0;
> > > -       }
> > > -}
> > >
> > >  int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
> > >                       struct ib_udata *udata)
> > > @@ -3387,7 +3373,15 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsi=
gned int cqe,
> > >                 goto fail;
> > >         }
> > >
> > > -       cq->ib_cq.cqe =3D cq->resize_cqe;
> > > +       bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq=
);
> > > +
> > > +       cq->qplib_cq.max_wqe =3D cq->resize_cqe;
> > > +       ib_umem_release(cq->ib_cq.umem);
> > > +       cq->ib_cq.umem =3D cq->resize_umem;
> > > +       cq->resize_umem =3D NULL;
> > > +       cq->resize_cqe =3D 0;
> > > +
> > > +       cq->ib_cq.cqe =3D entries;
> > >         atomic_inc(&rdev->stats.res.resize_count);
> > >
> > >         return 0;
> > > @@ -3907,15 +3901,6 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int n=
um_entries, struct ib_wc *wc)
> > >         struct bnxt_re_sqp_entries *sqp_entry =3D NULL;
> > >         unsigned long flags;
> > >
> > > -       /* User CQ; the only processing we do is to
> > > -        * complete any pending CQ resize operation.
> > > -        */
> > > -       if (cq->ib_cq.umem) {
> > > -               if (cq->resize_umem)
> > > -                       bnxt_re_resize_cq_complete(cq);
> > > -               return 0;
> > > -       }
> > > -
> > >         spin_lock_irqsave(&cq->cq_lock, flags);
> > >         budget =3D min_t(u32, num_entries, cq->max_cql);
> > >         num_entries =3D budget;
> > >
> > > --
> > > 2.52.0
> > >
>
>

--00000000000011d4f6064afdfb4d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
zJH6Ivyz2skA36zh/px/UmF2ORX4Y0CY6GtU8/vxuN2j4rd2medlyifwALUm+KI3SsD782IwKLCf
8bNhYGiw4YxsbyX7dV7O4SNQc5U9ktrSKH3D4SuTnK/xdjca5PiNI2NTcBVmP7+u2bvVLdRqISop
9dpRkJ6xxhGJjxakljIxHdcZLXltxX4YM0Onf3agcjY3boIqnVlDjBwSZX674ZU+YVrcIlcRcqs/
W83e6PmIRFwpkKOhuLNKSpW5mZoEQdpnxGwE9U7qLGECAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2VsdmluLnhhdmllckBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJA9fV7cOoiN64ws5XPC
J5qtayo5MA0GCSqGSIb3DQEBCwUAA4ICAQBFCIF4AxAiXVz6gX5YfFEbIYtbGFifcfe+QGc5cfac
CSzIrQWUPXAYAef3G5WouD2AKwa2tPGJgK2L7n1r2W4NIvr93588EDVnGgfMfWaFsB8VlLsPlH8Y
fLfaTdN3OQPnFFp54yK9wv8AtTIiTQcailMw7QX5x5GE6HVZElxf0V0Ljc2NrUQLoYzHzAU+sysl
6JQzomxjIfuXiIiUfmnWQdhO95kQchRdOUAaguLTV+RRfPZ1p54dRmgGEpJtzjGLdsrLkZ2rCN5j
cOTTXyxJmvlgm9jfT0Uy5SOPHdq1jtZbQyXrNT4fQ07Odmq3xQCUTi+a59IiC+6V7nFJ8zyCSk+p
n/iGouvun/owYzTmFxB6sVLWZcaWz2Ufcm7b6nOYV+pwUS/n6+6oFRKmGLrl0CRCF0AOph5p81aV
kgKuS5oXBoDefJfjKHuu5lJVelBx3n++iMGMW9FWFmXErCHy2d+L42Raai5X2PL8jAmh+lpPRDX4
CT9jL6xWM5QkCBtxyVKuxGxxUY2wczmVcQ1nGh9mGghI04Scs4OtE8Qh9LMOe2PXzxcV6lpF+yay
B3fwJWxl7miwNFjWuu9M6Z+rcjm3JF5srcAu2fp/VzQD4AE5Kq7ywukMvlU4Y3X2t+D2eU1DH8pk
c8mM1CtQWfWUboaoLABVmYmYfihDvTURkzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDDy76dRYp65lyF2c4zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
s5nnd3x2nt2JKtHSezRTun53iSYdT7+EbY17FcA7lHUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMjE3MDUwMjM5WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKeorVScv0W1TsOULkj1u3B81Xn/cWurigNzA
Q7+S0V2kSxOQExKiKWybPd3GAS4AXa8vMwI0NMBptXZzAdDCmyEbYVpdPbWyG4o7pphjG/QAtjcf
soVygdLfPchqOKBxMxKvCRAlWTi0HcNvOByQ8R1YLuItyfC6g7gBf+H87ZF5NK9MgAOGriCd3oS3
+wch5iE72NKkXsmscXIZnOlzh029rYUGJwem7TUcTfP36xx/d9hBrC5bpxasKlhBC87SNRLxUp/F
03sw0dfJJZYPXfwUHsDmA420HwQa+kbs2whAA3u/prD/TuQvHiOwO/f3J48RuGCwQBE1eIvz2tvw
WQ==
--00000000000011d4f6064afdfb4d--

