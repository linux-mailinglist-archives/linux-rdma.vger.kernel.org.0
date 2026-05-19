Return-Path: <linux-rdma+bounces-20997-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BpgKB/aDGrhoQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20997-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 23:46:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DDB585499
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 23:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4BF330454CA
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A858A3EC2E0;
	Tue, 19 May 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH/zNhS6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862C382F39
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227164; cv=pass; b=VfUum7fO2xQI+1CcgfKELRIE3rE3KsJV0JrdfvouIn9RjMnr0Tg0JST93AlMNqNkrpm1rmrmn8rDuYrBdagmZIX6pqHm7jtBtM+FZ2uG1VPlqLmbynbvWbYR9kTK/3wT9P56DATWcHk9JdcMnXPfaxpea9wcCvInuDUeYII1SH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227164; c=relaxed/simple;
	bh=E+tTTb2GqI1vaGquqP1jTXz6HThVzWgXkisHH8EuO8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9GJwMFEQNSHzQC9LdB7AsI8X1I7l+skllFK9YmWTVFq00kQEP0aXrGHYumuShDxYdiA2uMMnoWSCKpR2hctgMCIVF1mOkv/8yxfiEMr+tUIyHOIt+wAlucQ4NU0kWDszeqLjoahDFeIth+BN7eP/zJB0oUOMgDzPx6cw2j33n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH/zNhS6; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd21ffaca79so856913866b.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 14:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779227160; cv=none;
        d=google.com; s=arc-20240605;
        b=CBlsamvcP18k5FO9N4Bv0G/xtDt7iCBjUX4XuDC5UM4wXJ6sQ4ne5pxwgDcc0cU/M9
         kBrGmvEoX24LcqlMygPNoD2mCfhV7+ztlTcUTVLESwsBSlEDUO0axsc5uphBLdIZHPFK
         76JrXqiTJVs9FCWGXnorjfW8kGXql2hcu2XnQTzGcvSE68XysPWM7/82B05ewrl/9qZf
         OYv2Onf5BZr/ltQSaiweP0ZJEbKMIEDYkvadJ9U5NeOsak3mudirUyfDs5offGCeN1PA
         UJ424kI96fTmm0IGYE1GZfymfs8/ExiKYO0XpoYL34QdKanvhrNcmfV7ivqKR9b6+gXb
         cUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        fh=E+YmcX0N631O5QvtZVNJVvwGDFuzapZscuxrAzq6cQU=;
        b=ASmnPZdYC/Xlu+VRTBYriT5+LQuBgEc4AoAbD8MsvqhRmYAyvPbAEPM/lfhR5qXCeo
         YcnU6YR8EIT6esayo71rI09zlMKh1B2vxIuU72KCenFKblPHsfi0neEkOt69e8DuaAvQ
         g2xVlN9MkIh+MG42TwNStweeZbUPsVzRk4J8s7SqKLbGXxGyttiNS7sbXU2pSp7tGZGo
         1E9G+/M0SJEjXkl7wiql81RKDxN2dIb4Qc6nWU0nE42p66ntsezAd/ifLbOLdx3dYuLY
         knVRun4qNU9I/9QwgMLdmxRJBbw+FjKPQeHP4ODdCLAvPKHNZl4dD8NI4GtZtv8upQMr
         3t+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779227160; x=1779831960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        b=qH/zNhS6SIUfjxARuMltjUodOjqSlRYKcR0o+zLMBNogXSHqlZQEMROvOJeC4f+f2E
         vLiEwZ0KUkgNGb+zoOfElkOVC713+DtaP4WZV9waekz+vU46a7NoDVWILgMsoDCezKT8
         FSHAz7tLZ3pD2vhTmhUfY6KiKSKdQ4x9dvtDvX6LI85Q6P96xQCCBLJizkqXaw5OtLRj
         jdafE8d7/JlkF70wStQuo26FL+txH1Ro8Fgth/OhWw+uenQEwgf0lMncusjGt0qbig8u
         jOEMJttZd/ZNnsssN5mDfT7QEI1QsqUGrOKAcLYyGfZKDPRihUu1MlMA6ZmuGeSyMXkC
         Irnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227160; x=1779831960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        b=ocKAF1c5utUaoujn0S9+0xcSptVbtiIzRoIMI7pBShJar2MCSwWhLQvIPCLsWxz8pY
         9oB19osvi0uWHbKjvPuQYYCsMkdD4uMGWuaSvaEunAuQ9nGewJ6OxC2qRaHonKrUa00w
         Ff8N3+0RyBk6rXVwzGUT8MSZ1ozhRPkfM7miJ5D4ORRNFLXaLZWekDDqyHbyPG5JwFgo
         iIAWbc0EB/a8LIR2zXWmttW15WC3OJeB4+fHgrrWzxGDsJzi0LJhi3iIyNwN+rfoe3CK
         J3jQMdhycFqj+zcQk+wPq3zKyYU7epOtpISpAkg4d9WTbxHzYNLwbSS8F7Wg5vxszi6K
         oVDg==
X-Gm-Message-State: AOJu0Ywy2rU6dBpicLueK6bmKezrUCaTOX1sYhRFxD4ACZOGWlGh14kS
	LBK6kMM/NgqIK0du56nJ/mj/Qwm0ocYz8QQXhfuRtPsVmGSwsiJHgqSPciFgQtK5Yp/hEUxqOFJ
	6tUw++sERtZcuMNTRt4Fc9jzmjgKENu/T30/DxMc=
X-Gm-Gg: Acq92OE4dJGTJE8h81gnJM04xo4HccWb75E8HbgFRejLZfISqqyXPzl6byDbkPZG0rV
	jfZVD5Om4kJ0vXiXmAssSu5L7fTME4Nxqfnm6tT+3GYRRALp0IyqKQY062pDth1H9HK7GUekzFT
	KGpraNOlp1VDoghp1W9rDB726rDQOvtzsqwmRl8+LtZtqxwPzinMLZJWZdwKEOV987m5ukmR/vS
	IkCDKyqpCESEXgXPMRlt2GAp1/iVTgGpf9+kZlG8S+DokHCONk6+yErTIRX01/0zzdHL9SumJ4V
	rlAnynLZ9GU1Kl1VPlDnipsWKHXAgMDl/FnNnW/Kiz+rDGNOQVEJPI2QZqB1k8BFMNyEdQNHDZe
	VyvJxrIzJpHe2ihkIypdHICr8INKskjrqunpQUhlGQ39EoVukp1Y0+6hH0cVBw803Nps6
X-Received: by 2002:a17:907:c10:b0:bd1:f09f:f819 with SMTP id
 a640c23a62f3a-bd4f34bd039mr1176086066b.25.1779227159626; Tue, 19 May 2026
 14:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519005206.628071-1-rosenp@gmail.com> <0b4cff6d-b9e7-4c34-9279-93bec10bcc9d@linux.ibm.com>
In-Reply-To: <0b4cff6d-b9e7-4c34-9279-93bec10bcc9d@linux.ibm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 19 May 2026 14:45:47 -0700
X-Gm-Features: AVHnY4L2A3cissyWzUYO1tXUDK8qIVjkmnbUtyGij0zc_S6K7Z3Goo3Q7aTrmVA
Message-ID: <CAKxU2N8_JhZhsSqm15DxFBkXv=ZBYQXQJ7xdw6SHrwG9dsWZVg@mail.gmail.com>
Subject: Re: [PATCH] smc: Use flexible array for SMCD connections
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: linux-rdma@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20997-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 48DDB585499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 1:57=E2=80=AFAM Alexandra Winter <wintera@linux.ibm=
.com> wrote:
>
>
>
> On 19.05.26 02:52, Rosen Penev wrote:
> > Store the per-DMB connection pointers in the SMCD device allocation
> > instead of allocating a separate connection array.
> >
> > This keeps the connection table tied to the SMCD device lifetime and
> > simplifies the allocation and cleanup paths.
> >
> > Assisted-by: Codex:GPT-5.5
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> I don't think GPT did a good job here.
> There are many other instances, where smcd->conn is freed,
> those would need adoption as well afaiu.
git grep kfree | grep \\\-\>conn\)
drivers/media/dvb-core/dvbdev.c: kfree(dvbdev->adapter->conn);
net/wireless/sme.c: kfree(wdev->conn);
net/wireless/sme.c: kfree(wdev->conn);

I assume you mean net/wireless/sme.c
>
> I am also not sure that there is enough improvement in the idea
> to warrant a patch, but I leave that to the SMC maintainers.
>
>
>
> >  include/net/smc.h |  2 +-
> >  net/smc/smc_ism.c | 10 ++--------
> >  2 files changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/smc.h b/include/net/smc.h
> > index bfdc4c41f019..a2bc3ab88075 100644
> > --- a/include/net/smc.h
> > +++ b/include/net/smc.h
> > @@ -40,7 +40,6 @@ struct smcd_dev {
> >       struct dibs_dev *dibs;
> >       struct list_head list;
> >       spinlock_t lock;
> > -     struct smc_connection **conn;
> >       struct list_head vlan;
> >       struct workqueue_struct *event_wq;
> >       u8 pnetid[SMC_MAX_PNETID_LEN];
> > @@ -50,6 +49,7 @@ struct smcd_dev {
> >       atomic_t lgr_cnt;
> >       wait_queue_head_t lgrs_deleted;
> >       u8 going_away : 1;
> > +     struct smc_connection *conn[];
> >  };
> >
> >  #define SMC_HS_CTRL_NAME_MAX 16
> > diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> > index e0dba2c7b6e3..bde938c5eb39 100644
> > --- a/net/smc/smc_ism.c
> > +++ b/net/smc/smc_ism.c
> > @@ -467,17 +467,14 @@ static struct smcd_dev *smcd_alloc_dev(const char=
 *name, int max_dmbs)
> >  {
> >       struct smcd_dev *smcd;
> >
> > -     smcd =3D kzalloc_obj(*smcd);
> > +     smcd =3D kzalloc_flex(*smcd, conn, max_dmbs);
> >       if (!smcd)
> >               return NULL;
> > -     smcd->conn =3D kzalloc_objs(struct smc_connection *, max_dmbs);
> > -     if (!smcd->conn)
> > -             goto free_smcd;
> >
> >       smcd->event_wq =3D alloc_ordered_workqueue("ism_evt_wq-%s)",
> >                                                WQ_MEM_RECLAIM, name);
> >       if (!smcd->event_wq)
> > -             goto free_conn;
> > +             goto free_smcd;
> >
> >       spin_lock_init(&smcd->lock);
> >       spin_lock_init(&smcd->lgr_lock);
> > @@ -486,8 +483,6 @@ static struct smcd_dev *smcd_alloc_dev(const char *=
name, int max_dmbs)
> >       init_waitqueue_head(&smcd->lgrs_deleted);
> >       return smcd;
> >
> > -free_conn:
> > -     kfree(smcd->conn);
> >  free_smcd:
> >       kfree(smcd);
> >       return NULL;
> > @@ -557,7 +552,6 @@ static void smcd_unregister_dev(struct dibs_dev *di=
bs)
> >       list_del_init(&smcd->list);
> >       mutex_unlock(&smcd_dev_list.mutex);
> >       destroy_workqueue(smcd->event_wq);
> > -     kfree(smcd->conn);
> >       kfree(smcd);
> >  }
> >
>

