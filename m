Return-Path: <linux-rdma+bounces-16460-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKZdFQILgmmCOQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16460-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 15:49:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 684FCDACAD
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A867E3007A63
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A359395264;
	Tue,  3 Feb 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IoUOBKFm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B924394481
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130172; cv=pass; b=tomTLItUPE3YD16TfeihnUeJu0txfk54F3weST/tfhQq6tDeIAv4Mk+nKZ7MMkQ85Rwo1JDCJuL31mNrJq77uQpMGz7mJx/jfoLDcxwAN0Bkr6IxHupRsuuMQAbOSGmD5jL3HzguF5C5yiRH88rb7XIDtmPALSlm/YnlbU9ExKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130172; c=relaxed/simple;
	bh=yxxdKV0ZDNka5/iTzmGXyUj4EfZukA/13oYK7xd54c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdQrnopFsElI5r3BtQ2axXewjkYUn54zB0oKEaWmHH1PcWOxuNXUTw2LpBwLgAuWqudzPgy1HxK0RAotqs3tmkJ52s9bXHARop0Zm23ORDxekiiP838nGL9kgwdPDX32UGAW4WmpLJpPLamtc+nIzO67CWoUvMEpTby+kkIhruY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IoUOBKFm; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a09d981507so6909815ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 06:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130171; x=1770734971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEBE+srXkqq712MK/thLWSEqwU3uILQjfe4Ufdgl8VE=;
        b=MUzc2BN8W5hqit4gV3MMeGK6hXjdUxMe3n/aHuafE0Flc+zmBT/iCyD1aTC4SpYuN9
         Uk6Kun3FJt8+0I6qGSsfpDowQsFuLXLFm5w8mDRpeY/W/lpk7Mq52VXS9jrpBTbRau34
         D8iZEo9BVhR/nBTS8/DVe7PXQR74rEjTw8Si/2gspk/W+v2tl+KDSLyHiwMm7DK6uxX8
         diKW5Ii1njpwLzGTQ6hakok+v7gz2YrX4PIiCSVHBX3kMIzqTjtgGonadJdnKXAiJYa4
         5vg04xo3/S0OFgcsdnq24x3o5EfdmwQCd82synbVqgKBQsPT5iI4P4XKB0RgQyOFTZf6
         2cPg==
X-Forwarded-Encrypted: i=2; AJvYcCXH6sj+eF3v6iTvGWLLlMeFS3VB7FAlS9cXtpIrcpvAO/29tA6HWZrtc3n4VGhFkMh7CySHsyWz3iYj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/5dpOz5PnjELkT4bq0EzDF5ozI/AmqOPg80RK/EWZ8lhLUX5
	dHZpo4o9vmpN2IyY+Dmo3wp2u/ssoiLRZmJRa9LPfAsk18u8/riupN5edprelefDcwsalHjReDn
	+sFYnIrCcRpXim/fxHnQoWq9hzsyN2qAUcxoNtoqJye5uSG7aE65rs63Y/d6ZLlsFfwLAVK7Rc5
	YFKvvE4+ZJhM3eVMKsVp9foGQvUsUiPlC63NkKTtz/80hfC7xYYzY5TyLx+Ot6vLb50bjswnNEI
	/8Z+sn6Nki45yX8F5DEuCH1gwMz
X-Gm-Gg: AZuq6aLo6bT01odfnV9qyD2RizlCxYm7B8ekgdrNvZgwzQfqulZGj4GIOZ3HlXw8t4t
	PNMFmnWgDYXOJDgQ9Ghmls8JRKWWpFtS0P117BEkY/ovAaZBxaahfdhAW5HFkpaVevA4J63OYyp
	Nnljblm1Sgf8yIs7csHCPgSBCjwLqFwTG2npvvCduZBtMk79jk4Z6lLyRVVDkjIjXLkjEZfuuFC
	CdxF+tp9HXwCbMuBbSs5cjbTkNahrAr3Kox98zA3HjkYNt4oNqPBveMZkw0QFnXBt95H0e2kfsa
	qT/8SvTd9gYt/en8ur57uoAkbCTmNnPB8d+DF/lpjZmeCm+FEH89jXhwpWU9arVocuK+uvoTJQH
	/WU6vrWaG20e1ttdb9YrbyjR0CYBaHshXuEe7bCmY14TFZCPpyb9nuY95UYp/MikYC0XfvhFjzR
	K1gt/t//y/lt0xvSKPfDsVwGJM/IRK9/xlHgOf4ICwB1uOmnRCziW5Tg==
X-Received: by 2002:a17:902:ef12:b0:2a7:5f26:aaf9 with SMTP id d9443c01a7336-2a92465d24fmr31305255ad.14.1770130170763;
        Tue, 03 Feb 2026 06:49:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b414152sm25426965ad.15.2026.02.03.06.49.30
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:49:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-436164e7f42so318162f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 06:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770130168; cv=none;
        d=google.com; s=arc-20240605;
        b=IDPv23nxBDRGFOu0QeilFM+RxrAgmFfl1nAffmp1ebBJxlgb99gUf0cuCLaCGCeJqv
         Aa1zkXX/z801wB/k3Xxpm2DtEVzudS5tlXiJUrWraKZzC04NUINZUHfNdCGb6xoIN8B7
         3wSWp741wFVFAzv4fhGW3oer4KcdWhcBnrm2RC0nc4vvD8Z/ec0d/QlEluRwX8uSu7GE
         zNvmzFzkvjzAt80q0Z5AMvt3/cpbL264wsxyzm3RIbaijwHDtQGlkBQWixtcEF8/lW4C
         zjUmbwZDB6Elvo9Rmkdov/h99bY9Sfu/OBNi4eXeg5vQLmUfx7CNJP9XLBY+KQdNoouv
         56Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tEBE+srXkqq712MK/thLWSEqwU3uILQjfe4Ufdgl8VE=;
        fh=3XFlSd6lst1E2rPXfBhkcz3GhkEEl8XKaLrXeYW+N8Q=;
        b=foEYE12+j750T336tlNr2ClPbbY0KPCsjXKinNTe4zJIEmQLx5bcwhgjo8pZD9s24t
         vqrshGfEmYQS4nYAF8jJU/sjO003JsB5jfFuX2ndvpUziUEzPYCm3TVoaJ9qugXWi0V9
         ZqhmjXClThMmgDK7aoQlpiB8Ng+FSkD641uEL4oSP8gFSLr3p5OdckOwvTnAUeq7ECu9
         x2Pwl3DagmwBbWIFGfCtUynoBAvZKpdi1ZJXCq9LSyQAlHgW8sUZMqiYRIcLEQzpeLUo
         qcWEBA8bOXZPcG9/Fccm+pqpokJPlMu5PFsTy7naPoAM5im8fgyE5DLGe5yfFaVRCv2k
         y55A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770130168; x=1770734968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tEBE+srXkqq712MK/thLWSEqwU3uILQjfe4Ufdgl8VE=;
        b=IoUOBKFmRzsG6XrnCgzJ/sjDhML6xWAYYf24Jbc8+9Ybrq54p1z6FK0gwxJdxaxnD0
         fJQ42VAGu6UFgxsl2/ScfRoWmt9YqOdKzRFWip4NxaWanG6TgRVrQO3QXxJKQ1qTT2zF
         2eP5BgOxIiGtQYnYemX/5tlRkn40Dbm7EZB7Y=
X-Forwarded-Encrypted: i=1; AJvYcCU1AkQdfiQobn1EYxXdpiG4jTh10vR9iDh4WKhg7DuoLH1YAg+pINhNCMjuOetbeN/Ugd3GAe/hnVNj@vger.kernel.org
X-Received: by 2002:a05:6000:4205:b0:435:e451:39d4 with SMTP id ffacd0b85a97d-435f3aac921mr22212356f8f.44.1770130167924;
        Tue, 03 Feb 2026 06:49:27 -0800 (PST)
X-Received: by 2002:a05:6000:4205:b0:435:e451:39d4 with SMTP id
 ffacd0b85a97d-435f3aac921mr22212313f8f.44.1770130167442; Tue, 03 Feb 2026
 06:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203085003.71184-1-jiri@resnulli.us> <20260203085003.71184-2-jiri@resnulli.us>
 <20260203100327.GS34749@unreal> <vw3hrr5fsamtsgydvydoewd4fnglas5xzickgfpjgp5y44gxkm@dmmvo36blqtb>
 <20260203122618.GT34749@unreal> <uixv7cu4qe5vqkl3dlsd4smbxvflo3syoseuwtf4v7xhwgziul@gqlnz4geufth>
 <20260203130335.GU34749@unreal> <56arliffs27lqgriymsnysnh672joz7ihndkeffqee32vvwxby@w6qhwezufrrc>
 <CAHHeUGV3W+LbGEnGB_Fbehy1PB2P2y1MkAnu6OTUKTeZC0yxJQ@mail.gmail.com> <ies3tefav42xtqnxbsxrzfiwlvxgrymnpufkzrd3pppxz7a4b6@ib3fouxvl24p>
In-Reply-To: <ies3tefav42xtqnxbsxrzfiwlvxgrymnpufkzrd3pppxz7a4b6@ib3fouxvl24p>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 3 Feb 2026 20:19:15 +0530
X-Gm-Features: AZwV_QjE1A2fAK1TzVOBEdNC692tyMnhNH0xzpL6R_4lQvChh6Dd0fScjH4yq3c
Message-ID: <CAHHeUGVWGbctxrGuq8VhVonQdb7Tbs=6U3=QcKs3aFCT9pLCSQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to ib_umem
To: Jiri Pirko <jiri@resnulli.us>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, jgg@ziepe.ca, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, 
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev, 
	wangliang74@huawei.com, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, 
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com, 
	edwards@nvidia.com, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e5690c0649ec8bb8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16460-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 684FCDACAD
X-Rspamd-Action: no action

--000000000000e5690c0649ec8bb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 7:59=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Feb 03, 2026 at 02:49:33PM +0100, sriharsha.basavapatna@broadcom.com=
 wrote:
> >On Tue, Feb 3, 2026 at 6:50=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Tue, Feb 03, 2026 at 02:03:35PM +0100, leon@kernel.org wrote:
> >> >On Tue, Feb 03, 2026 at 01:46:21PM +0100, Jiri Pirko wrote:
> >> >> Tue, Feb 03, 2026 at 01:26:18PM +0100, leon@kernel.org wrote:
> >> >> >On Tue, Feb 03, 2026 at 11:11:39AM +0100, Jiri Pirko wrote:
> >> >> >> Tue, Feb 03, 2026 at 11:03:27AM +0100, leon@kernel.org wrote:
> >> >> >> >On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> >> >>
> >> >> >> >> Introduce reference counting for ib_umem objects to simplify =
memory
> >> >> >> >> lifecycle management when umem buffers are shared between the=
 core
> >> >> >> >> layer and device drivers.
> >> >> >
> >> >> >The lifecycle should be confined either to the core or to the driv=
er,
> >> >> >but it should not mix responsibilities across both.
> >> >>
> >> >> Okay, I can re-phrase. The point is, the last holding reference act=
ually
> >> >> does the release.
> >> >>
> >> >>
> >> >> >
> >> >> >> >>
> >> >> >> >> When the core RDMA layer allocates an ib_umem and passes it t=
o a driver
> >> >> >> >> (e.g., for CQ or QP creation with external buffers), both lay=
ers need
> >> >> >> >> to manage the umem lifecycle. Without reference counting, thi=
s requires
> >> >> >> >> complex conditional release logic to avoid double-frees on er=
ror paths
> >> >> >> >> and leaks on success paths.
> >> >> >> >
> >> >> >> >This sentence doesn't align with the proposed change.
> >> >> >>
> >> >> >> Hmm, I'm not sure why you think it does not align. It exactly de=
scribes
> >> >> >> the code I had it originally without this path in place :)
> >> >> >
> >> >> >There is no complex conditional release logic which this reference
> >> >> >counting solves. That counting allows delayed, semi-random release=
,
> >> >> >nothing more.
> >> >>
> >> >> Again. Without the refcount, you have to make sure the umem is cons=
umed
> >> >> by the op. Actually, check the existing create_cq_umem. On the erro=
r
> >> >> path, the umem is released by the caller. On success path the owner=
ship
> >> >> is transferred to the calle.
> >> >
> >> >We need to fix it. Exactly right now, I'm working to make sure that u=
mem
> >> >is managed by ib_core and drivers don't call to ib_umem_get() at all.
> >>
> >> Should I wait and rebase?
> >>
> >>
> >> >
> >> >> Consider various error paths in the calle
> >> >> some of which are shared with destroy_cq op, some umems are not act=
ually
> >> >> used etc, it's a nightmare. I had the code written down like this
> >> >> originally, that's why I actually know.
> >> >>
> >> >> Perhaps I'm missing your point. Is is just about the patch descript=
io or
> >> >> about the code itself?
> >> >
> >> >Description and the code. UMEM needs to be created by ib_core and
> >> >ib_core should destroy them.
> >
> >I'm seeing a kernel crash when perftest is stopped, I'm still
> >debugging it, but I'm wondering if it is related to this change. I see
> >this inline comment in the uverbs handler:
> >
> >        /* Driver took a reference, release ours */
> >        ib_umem_release(rq_dbr_umem);
> >        ib_umem_release(sq_dbr_umem);
> >        ib_umem_release(rq_umem);
> >        ib_umem_release(sq_umem);
> >
> >What does it mean by "Driver took a reference"? If the driver returns
> >success from create_qp_umem(), the umem it is still using gets
> >released above? Is there something that the driver should call to hold
> >a reference? It is not obvious from the create_qp_umem() dev op.
>
> Yes, see "RDMA/uverbs: Use umem refcounting for CQ creation with external
> buffer"
>
> [...]
Ok, added ib_umem_get_ref() before returning (success) from
create_cq/qp_umem() and it doesn't crash anymore.
>
> >

--000000000000e5690c0649ec8bb8
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
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBUTX3g4K4X6gF0sjoYZ19bDwFGBds+qi4u
z/TwwCmrNjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDMx
NDQ5MjhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBoOEKpl+lW4yjDhbHVelJYKsyCvnt+3ND+ZPNQkcikNP7w1rtCm8eUS0xrHvK2fKUUMa/6
9byRPPpPim7TwwW01YvBwNmXQpmxIP8tJIygdl8rsqCnsIRzJhKrODWCe7LINzstyIPI/K/OC8gY
b190FE7yZllawqqFW3NPtVM5cWQJPbxVugqm6TlCyvUr53AI22iknyzMrM4R0KiY3UJh0uqjm2SK
pKAYI0Vlf8KRtOk10blCdV6aJ0z+zSwBDEKT92hgk2mRCzUloBHktDlwa7dGK7nwGAtPpxP9kV/d
BBQX8WZR4i9/msnRYQdntRjqX2buoJynrSEWDCH+O6SN
--000000000000e5690c0649ec8bb8--

