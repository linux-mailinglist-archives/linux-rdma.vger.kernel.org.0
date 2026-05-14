Return-Path: <linux-rdma+bounces-20688-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBBDEseyBWqeZwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20688-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:32:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0E5410C6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E722A300D76F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D40B3C0A02;
	Thu, 14 May 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws+FV6Q6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043843C0607
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758338; cv=pass; b=b2j4hRejKXg9DhfzomG9JxBFr+eSZqMyT75OO0ZCUv1TYnreEXjRauDzZy76kUSaFwqlS+Wn+oj0J4gcuKsyZpziYH0gG9SaPdXqiqhpN1LvviBvVP7BepB/DdjyiLX2mt2I1P0iPUIE/wbPfzsQ4dVjmcG76m33z3we/3bVpaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758338; c=relaxed/simple;
	bh=DwE3eY3Anln+vltSIqo9JzStJ+1xDiqeoz6hnBEtjh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia0y/9ICh0KixyzEGiDwEXcTemHAHmVkuYNHtV49vKSX3kRnOfaQ5cgHfILZGFkGRr+dpjTscjmaG2S/YDN4Jb8laUuODI9DnaS5e+If/v86pRZTuW3zDy0QY0aqWqh83IUM+S6m4NcLf9rxBtIoG/MbAEM59JOI46LVfIAZmKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws+FV6Q6; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65c305f381eso9845532d50.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 04:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778758335; cv=none;
        d=google.com; s=arc-20240605;
        b=kgUwArOYjxeVT/Fsl5gknLBmxl4jNvJf4leZrD4mVBsUTK2CbEpnUDanM85LE5E3NC
         xzzrnrjQR2uQRPTReHdEg/QZ3XlfwlmCzEHQWRSakipqYGN6nlb1UtaI7m7qIoz324py
         w3rF/CJWSOm/dhGroLRpzkX8K8HiokEOU4r3x713ovzRa7qDZsBPnWG6JvGItzEyQ4Ur
         SsNHubV1oysXw6Lt3gaTjUH2UCXxUID8AtTbaVZMUXzJvNd2QTu1ljphDQeXPTOEjzvS
         Ar9mYAcunc59jeSK0b6WbPpoJhSe0o6cfy/Hlx8XKLzIJyUHO5q9bHtRmwi1BdTP0NS3
         1uvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=97ODHD6wOILW/mUVgjTuU9JaWwB0qBG0FN2sbFpyCu4=;
        fh=ipjtbe6JxF10yuEEqBviK4mTCCGk7J0tB6Rbzm1+vvE=;
        b=KiM37/9cnAjNcYAaqEwKy067bufIgAb69TKuWnldqgWjUse8v1qWgJUad/qU5p/oDJ
         fgNs08Z6UkFoXmgMiXWGYZhWioIhqsYb3Zc0fq/ZE+O05KXRv/WsAhVQTS1ZFwYKqGnC
         ISiaagibTrYBPSRLR+1iHPMYr3ec0EH1rAv9m23OlQpxWj6+gdDYQ8OPc9uGaelTEpnR
         BuX1Tff1jSNKTWnOXFOxDIQuAv9onojM7lN/5ZzwBKE0bYnkdNAmFAWPgxyogR9kx2br
         ME/7b3alFE+NxIjDwRdvtx4xzErTuYyUnr5Ks55Kpej9irECba688oLrBzNXKh1RqAEH
         VvmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778758335; x=1779363135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=97ODHD6wOILW/mUVgjTuU9JaWwB0qBG0FN2sbFpyCu4=;
        b=Ws+FV6Q61hp6yYeoGnrhPGRqmA7j3QYfOSI8ZbgzZWXkZ8uIf5buyMFAu+wGMQ6rgo
         5ixAuobLzgutnQKRQzt9MFayec8olN4BYZWVqHFeFmRqVGRs+1hs2W/GsZ2LggqcPt9w
         1oF/+NEySXGhGoKLztD2UQlVGgX4gAOIPnT+U345SvnHM+VaBoE9RyTJE4mWWFWGsxdp
         Nw+DKAGGvO7mtQq6XPlF9xcPNpp/+jcU3isyZbvWU1rhiA3c3RfCsEAQEGCN7shZi1si
         Cca/5Wsz5QAGl3zSoQGRZ3N60N47vo3kYVLPQwy47PEFPFhh67qjuYWKM/b/rabga8DS
         xJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778758335; x=1779363135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97ODHD6wOILW/mUVgjTuU9JaWwB0qBG0FN2sbFpyCu4=;
        b=NY1D9gPiX55PkkjX9f+hh0l7gXGidykLlZZlmX8kmafWzCnbT8r7KS4M9YDDYoRwSa
         2akxypnDTQMjlVP+VOpw3amRdM845KUp1hlE5FfHBpdZYkHh8LDrWJESLINQI2UGgjCt
         m0nN098EZM9xE0BJh6pMlBpgSonzllAn7H+8PslkEuj8bJ1K4XEpAxvDP9mrhwzTkhHk
         KwAbNWYd2efdFIL/rVItFALpAZfmyDS5QAhuQi/Kz7FDOZD5yHBJMUG1NTZFY9hLVYEJ
         k5T9g8LScw2hMl8wyhoh+/DvkAd7Qaq/J3S3QgB5xtYFm5kRpOW61fwVmSZ2Zm6RCWkb
         CEFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CdXBfwifMN92YX6YcGj5NXDxu8k20Y2iboopbBWY3WOqjsdUrF152pUmeOIz7RjByxHis99+r2FeT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrb7mkDBbp+IHReadcdhiLrQ6gLeCPcHAeq8vhFUOYiu/9PIvE
	1Ihw1o7mgCm4z8XJkxA22ZFKu79NvNTAhE8CBSH3gOeUAG76tvz9Y3ZPl2/OZu8cTkOLQIOfix/
	KTRV2sExwkPh31+mXB4bBM6JtEHF0837uE9gmPoaAcA==
X-Gm-Gg: Acq92OE7AnNC95ytTGgW0LjNa3ofF+FCt/H60IngDSNB2fZopeijaejq22hu4/PAXzc
	WD3spX1GUrgep+dzkMMQ+9sHV7tNtRmTgwdyAXEuOB1NdwRW7qX5Ud74PaT5NQqyk2D3xTuvw8j
	nEr24PxL1mB19Sa4m+RsOS3LNeySS588mHpgfNyyxmos4SBaYA47YSdJOfCODHcs9ror5AQ0mKD
	TCGyePgLxmsuh36QtnUO4sgDSPs/u+gnRrFj5RSXgStW7KCyhPzDX+Z7orXQR+ZRg4ehTR0dB6z
	4F3x328y
X-Received: by 2002:a05:690e:1241:b0:65e:18a3:f194 with SMTP id
 956f58d0204a3-65e18a40cc4mr863676d50.20.1778758334643; Thu, 14 May 2026
 04:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511130804.773204-1-lgs201920130244@gmail.com> <20260514071758.GN15586@unreal>
In-Reply-To: <20260514071758.GN15586@unreal>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 14 May 2026 19:31:55 +0800
X-Gm-Features: AVHnY4Lo-0Kgoy-ImJpkMY9907JOkJooeTgxYQUzCo_Dwge7YEuE69-FCOlwnpM
Message-ID: <CANUHTR-vg2mWSoJfvMOvwSuu3=TZ8-KWvvBf1eJT1XguFtZn_g@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs: Fix use-after-free in path files cleanup
To: Leon Romanovsky <leon@kernel.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Vaishali Thakkar <vaishali.thakkar@ionos.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 81E0E5410C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20688-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Leon,

Thanks, I see your point.

On Thu, 14 May 2026 at 15:18, Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 11, 2026 at 09:08:04PM +0800, Guangshuo Li wrote:
> > Once kobject_put() is called on srv_path->kobj, the release callback may be
> > triggered and srv_path may be freed. Therefore, srv_path must not be used
> > after kobject_put(&srv_path->kobj).
> >
> > Both rtrs_srv_create_path_files() and rtrs_srv_destroy_path_files()
> > currently call rtrs_srv_destroy_once_sysfs_root_folders(srv_path) after
> > kobject_put(&srv_path->kobj). Although the call site only passes srv_path
> > as an argument, rtrs_srv_destroy_once_sysfs_root_folders() dereferences it
> > internally to access srv_path->srv. If kobject_put() has already freed
> > srv_path, this results in a use-after-free.
> >
> > Move rtrs_srv_destroy_once_sysfs_root_folders() before kobject_put(), so
> > srv_path remains valid while the helper accesses it.
>
> This still doesn't answer my question: how can you access memory referenced
> by the srv_path pointer after it has been freed?
>
>   1612         rtrs_srv_destroy_path_files(srv_path); <--- you released memory pointed by srv_path here
>   1613
>   1614         /* Notify upper layer if we are the last path */
>   1615         rtrs_srv_path_down(srv_path);          <--- you are accessing memory which was already released.
>   1616
>
> Thanks
>
> >
> > This issue was found by a static analysis tool I am developing.
> >
> > Fixes: ae4c81644e91 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path")
> > Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v2:
> >   - Clarify that the use-after-free happens inside
> >     rtrs_srv_destroy_once_sysfs_root_folders(), which dereferences srv_path
> >     after kobject_put() may have freed it.
> >   - No code changes.
> >
> >  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > index 51727c7d710c..c9ba9d2d0eb3 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > @@ -295,8 +295,8 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
> >  put_kobj:
> >       kobject_del(&srv_path->kobj);
> >  destroy_root:
> > -     kobject_put(&srv_path->kobj);
> >       rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
> > +     kobject_put(&srv_path->kobj);
> >
> >       return err;
> >  }
> > @@ -312,8 +312,8 @@ void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
> >
> >       if (srv_path->kobj.state_in_sysfs) {
> >               sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
> > -             kobject_put(&srv_path->kobj);
> >               rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
> > +             kobject_put(&srv_path->kobj);
> >       }
> >
> >  }
> > --
> > 2.43.0
> >

You are right that in the normal rtrs_srv_destroy_path_files() path,
the kobject_put() there cannot be treated as unconditionally freeing
srv_path; otherwise the following accesses such as rtrs_srv_path_down()
would already be a problem.

The case I intended to fix is the error path in
rtrs_srv_create_path_files().

For example, if rtrs_srv_create_once_sysfs_root_folders() succeeds and
kobject_init_and_add() succeeds, but a later step such as
sysfs_create_group() or rtrs_srv_create_stats_files() fails, the error
path does:

kobject_del(&srv_path->kobj);
kobject_put(&srv_path->kobj);
rtrs_srv_destroy_once_sysfs_root_folders(srv_path);

In this failure path, rtrs_srv_create_path_files() has not returned
success, so the later successful-path reference handling is not reached.
Therefore kobject_put(&srv_path->kobj) may invoke rtrs_srv_release()
and free srv_path. The following call to
rtrs_srv_destroy_once_sysfs_root_folders(srv_path) then dereferences
srv_path internally to access srv_path->srv.

So the UAF I am addressing is in the create failure cleanup path. My v2
commit message was too broad and made it sound as if the normal destroy
path had the same lifetime issue.

I will send a v3 clarifying that, and I can also limit the code change to
the rtrs_srv_create_path_files() error path if you prefer.

Thanks,
Guangshuo

