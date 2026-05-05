Return-Path: <linux-rdma+bounces-20027-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMF6BUgW+mkMJQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20027-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:09:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B31CD4D0EC8
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2734430CE619
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A14934677D;
	Tue,  5 May 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdamdiJZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2F3B0AF5
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997031; cv=pass; b=PS8q7FePpOfDZtI1eruHa73rGuI2Q8FywPQNvZ+o5vHQ0tgeeRRxn//fWGPeAmtxnqzcWhGRBBX5Cf77EbJu+0stwfZw9h2OmCrGeVsm8fmZLGdxA7EvrFD+ofgaLS2UwfEDXJSedehSPt9SjPLSNOa2rU/jKrnYgSqltseD7vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997031; c=relaxed/simple;
	bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Crw5vUQOT2iU+T6GAOLryWZS5XUtrdq4MU0Z33qBjvLLDRnlU5+oiWxsX9XXt2YZ4Uj2yl0LX5hynDJc8cElIRilr+9v0OpG9Qm7Hdwoz2BY6jVPve9q39VY7+Lk/bmkDJBVblPcK0Id+7IaalKT9R5T7ps/PFoOoshLtXrm+Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdamdiJZ; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c1a170a50so7115349c88.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 09:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777997028; cv=none;
        d=google.com; s=arc-20240605;
        b=cv0q1e4ohC5lSy8esTk0bgZS/ThyXTSxP0JHAgZJb3aLbgkJRhRZO3yqZWOH4lOrbL
         akHBeS+asv2l9WbfvbbHUtGX6UueVd6FhKJqeKMapNjLByZ5ncsRyoNORTXcNr23m/PO
         WyHANFrsz7hREjPqFHf4/oaD9LgEfG0mJVRf80+DQlL+SMv2LA3QzCPU0JVvGTLc3ezf
         Mfmi8ZcWw25lEXdLaE0f/kcFO0sGsF6/pI6FXyf2EDHudJQGa4j1aBoF+ko4l1h0H9od
         BAFDFVLcVgLHud5UvqpOj2jihYMtE0E3HfsmtwMqfPGZV4mAyUwswZtvv6oYPxPUxxUo
         Sgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        fh=uSiWh8DN1ECqH1GVnWvoMofXY065rh48qCpZGKl20Fo=;
        b=NjN3bMxWedJguFTvSUsH48NM6qolTFJ/9mkjEn3sWvX5xtn3QbSyFjhRgnxE2M5HWE
         m20gqher9lKFs0OdkDNRlwrC3mTTvNsDXt3dV1uHaei6/tWov+hYC/etQ02oxgP++uNM
         5/1PESII4KadaR60/VlwwdNq0S7MVT9wiihN11wFg7wHNTlFi4pIkScv3gcTuticcq0N
         Nb4vI+no37F50fPP6sBgMMSRi6JOXXrfGXe557u5WE6R9LA1SvMI1Gh0eFEUVd8D30kM
         cBO69gO6NCPFVHpCin9gafjHfO9OzQd27wnnkvTnK+tITEa41sditxd3RBDTICwN2MJQ
         bV6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777997028; x=1778601828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        b=tdamdiJZ8AIZ26E9sOTTyk5jU1BM7rY1atHf7juQtp4GtWQo2X7xFMAFFaXqis+usC
         3rOop43vEFOgGCM2lvtCWwGpCZd6r8vAhaPGXwFp3uQUG6mMe/g9x6YqrMXZg5OlxsHA
         tDFr5xlKD89TC/QqpPzhkoloRoC5il7rqtZqjrl2y1cI77mU2u/DViFwzy7cuCXvJHoM
         xeHOlDIGsgSvEdI7UJiVxJvEYA2LvyWAhv9xoRmwBi7Kqq2Jl5FVOzD/TDXFPOsAHrTU
         ZIz2AMStuM2F+GMwYJdzBqwmibTYK1T5ShB1lfsvPz8HFg4B9nOYk3PB+gvyJZED4p/U
         AsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997028; x=1778601828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        b=Z2b3fGxVfFHNCMA6D3mGpHrafy/mjEf+IXMHl5hmzPoDMNjFg7DLD3Coj1Zq+AKt0B
         bfPq5gMszVJQVCkVuKEF19EhgsgY953h3m6a3VyiPmGw/WQdR6qNThK01JzfHTr1r+bn
         y0DaHKhA0f0FoISWOJx4izHSEnJch8UoPtrMemb/ZqQOC8y1NdB5gfIM+1dcf7nxsdkb
         QTtOqFVmNu/6x36n5nFrQt/xpQHVD5AQnYVmhQSSXBz2AsY/z1TbKsoptXzhB3Hlj9Jt
         GV5wBWSBayApANLCtcoXTnLHrYd/thhtMwQk+symEiq2DbOrsCPsLJrlkVMgY3kUVxO8
         4EGg==
X-Forwarded-Encrypted: i=1; AFNElJ90aa91foJWZaNAPg+HqBRJWTFfMmJs/ueCZpN5yAII5FNoEMKUlIFL0KCTgEM0SVzjQzHF/gXLD1Xd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/dq9bti3iLDO4W8ZPmWCf70qTg9pKmgxqJoyhvZXVD6woKRs
	Refk0hxA9h3zcyEWgQjInZThoTNofhVW1hjrGqH5T/64/EVeXg8laP7C/VUENM7XvHUaGNfa2ka
	flQmKwIKfrESB8BPS0379UdCNNhBvSfrcrQDkJ5HG
X-Gm-Gg: AeBDievSlyVaHCo0IwRx0WAArnfZWDWl52znm9Z1GfNrQ/51kPVxFYIo0x88lZeYdE6
	1ZvH/RGJODqHWiP4XTiE5LeYDYF2nEVehlYKqghbNj8lZR51aZKQYvMRJRrKdmdl47DupwztTVi
	h46ui5Vpno+9hmbEgqFEIxMlvk6OtPnqRXq73NzhDJ2o8Eb51xYtJaI8g5AzKSOkE4CFaNo5EE8
	TaqRAqb3QY4VCg/yR4Y4W6mOc4AI51BmaEkhamsDr7+JnOqUb2/h2HZhvzQ50E=
X-Received: by 2002:a05:7022:78f:b0:12d:ca32:59f with SMTP id
 a92af1059eb24-12dfd7e5bdbmr7028039c88.11.1777997026608; Tue, 05 May 2026
 09:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <9-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkfP-8UHaoyLd5Y@google.com> <afoQtL6gEN2wUba7@nvidia.com>
In-Reply-To: <afoQtL6gEN2wUba7@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 09:03:19 -0700
X-Gm-Features: AVHnY4LsNmTptv6RYHm1ivIrJui-vL8wanpj85inMj7g24wxtEjU8rbJcAF7qfg
Message-ID: <CALzav=eQcRUNR8FtqDwXsjm+MbMSN-u7GyCj96-NmbDhB17GRQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B31CD4D0EC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20027-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,mail.gmail.com:mid]

On Tue, May 5, 2026 at 8:46=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 10:35:43PM +0000, David Matlack wrote:
> > On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> >
> > > +/*
> > > + * Driver state =E2=80=94 overlaid on device->driver.region.vaddr.
> > > + *
> > > + * Contains both software-only state and HW-visible DMA buffers. HW =
buffers need
> > > + * strict IOVA alignment.
> > > + */
> > > +struct mlx5st_device {
> >
> > Can we do s/mlx5st/mlx5/ on the series?
>
> No, I don't want to do this. Since it is in tree I want to reserve the
> mlx5_ prefix only for the main driver. The driver is huge, I do not
> want to harm or confuse grep - that team will get mad.

git-grep can be scoped to directories, but ok let's keep mlx5st to
avoid disrupting anyone's workflow.

