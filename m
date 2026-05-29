Return-Path: <linux-rdma+bounces-21496-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O0KOwKLGWosxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21496-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 14:48:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5F60271A
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 14:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 046AE30B3385
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59FB21A92F;
	Fri, 29 May 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SiDzvkaI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F514A4CC
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058779; cv=none; b=CqqlPhZxGL7X8SYUDAcrCsU6acBMhktx6hrG6RUYW3tH0kwDbYTUlVzc33g1VNz3AkUovOc3v15WTNWhXWGsBXHbwUytIkH8enjLp9tofDUNCQiwfy+xIbHIINwfrop5q3RRxiJwU19p1HnA3Lr6xqwqdEXuv7lMPCtI5fQ+k/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058779; c=relaxed/simple;
	bh=RGatjCTq0s6ODBYqXaugc6ZnbAdhEsOzrvwF2bDqjzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKykp3gREc/V9iGPeq7xGAvN8rlmiJxefuxmiYR9VNmgM62iBnKO9xd5L8ZzC19Dw2lnKGrDUajWbcMZpl7nsh0h5kJF6SNk0xPMNrWqYJ8br06ah+3TDA/8G1R9iRbMOSpuBbg6VHP8+p9vfvBM6tGecNUi1v3mA/LISPct7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SiDzvkaI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4909def6a21so2900695e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780058777; x=1780663577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVuXTuvU9z6/Xk/ij86jv4B5J+bvOgp3qXIop/gYcXg=;
        b=SiDzvkaI+LvJ5BWeNOu2ooyuT/P1eQLEDIO48GL8EdOE47Z8HfSzbIRT7DEt6eX16d
         a4ictiSQfW9+FfzksU+SzLGX6tmi1Nqvx81UChxyAP9vLxwRKBcIp6VTYNc8Z3xFJrhB
         RMEuXJxkBIq/I+9JW9k8xtAlf/r1q8sDMB8wzCYygaiHJ7GHgp2xshag3A8xnf7lfagJ
         St29ugAfwNCIGL8kfe9MOM5mFMeVN0dTY0RZ5eaqhZ+0SIGP5WUFx191YP7fu9W1RBkP
         uj/CKG3ZlVuZ9mLQQm/ww2Lvd788O23umybdv0fEG6uwy/b4OsZHBIm5pssqSCKRuiPB
         7tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058777; x=1780663577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVuXTuvU9z6/Xk/ij86jv4B5J+bvOgp3qXIop/gYcXg=;
        b=e8PaoEtZkXA5IphHrEqFOW1Bj2SbdrXoL5pEhFl6uioBKVP56E9rDMS2k3RTm61084
         4POrZwsh+QtrD+g/CqJldZ/uNbv+CJQm4ygE3czMzs8acArLcYPFRyrSwDdw6dS5ttrF
         4sGGDFlu1pmf5fYwEDxDfYOhcuWJUgweSWd9GL2XII2NaVRSqmCfSPhji2tYf9JuyxME
         8F2LleZlpt1FfbVIRVwmQsa191AiUcrFPDTAVZ9iKtvhsIkxJJG4GcEl3rxPcTmg2znM
         neac/RCqUZFAG5FrhLUG7tKvSWaGQMq9lXWvZK2ok6vJP9zFnVJYI97gqhEc0z983yQ5
         ODYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Py77vbx/L96SY6syVgqzZRGxhbCPonUl7h96uhRfqofRELZU5cRlfEA8B9lOps/fI0NmT/Nxa2OuC@vger.kernel.org
X-Gm-Message-State: AOJu0YyZz1yRRrQnJQ2tIjQdimvj94I2rB5iNf9JytxcHRpRD8QVUUkq
	O6i2Gtf8WSmKj6d7A9ZaIGhnUdz3UBnEltF4RG15NbZHTyMMpgPTk+g6yxDkTo94nvk=
X-Gm-Gg: Acq92OH+JwD0yPfbkVFgfQCvs2FKF4NdyLCMiK7ABUmMZOO5Xo0FkVWDJzZLyv1Wsjt
	9tMFIAxl9u/MAYQrJr9s43L5ZhtN8kO4062yA6MbcaCJNLBWWkQkwoFJDI7uujXBcoqyeDWvVFv
	VA99YlML2PIx1/K9d90gZsDrmJmqra9DCtzJUI6L7fPKRFkRJqiipyRX2XtOQlyIAgIgWt4ize9
	M00xNGcBEmNlzs9Nth8QIHfJrYy/LqQPresQ8QLjALhxPvWh9MR9mUJjWDoU7pXnyQvFiDutXaG
	OIIRhbzoDUYScuYmrvdfuazQuR16kt1CRhiCTeaFApdxSTANJWpyQ3kgpuycgGlpEg0DIJdCTFF
	e+ttHq7TxQRdtALkKGO2Rt6rscRj9TIo4Tn2KVEIh1HYBHAhjOdj2unntm9h3IT7LxF2f9StDXf
	HbnwrSpHOxYJegC5wNEc02G26hlV6wAs3JZINDdGfj6YPmYwmYVl7iQ/8/7b2dn4s0E23g8Q==
X-Received: by 2002:a05:600c:c16b:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-4909d2e8ff7mr50079895e9.7.1780058776583;
        Fri, 29 May 2026 05:46:16 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7faasm42612135e9.11.2026.05.29.05.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:46:16 -0700 (PDT)
Date: Fri, 29 May 2026 14:46:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, leon@kernel.org, jgg@ziepe.ca, 
	linux-rdma@vger.kernel.org, cgroups@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH rdma-next v2 0/3] cgroup/rdma: add MR memory size
 resource tracking
Message-ID: <ahmG_ualxJT5WU_B@localhost.localdomain>
References: <20260529090733.2242822-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcierihojdco2ko5"
Content-Disposition: inline
In-Reply-To: <20260529090733.2242822-1-cui.tao@linux.dev>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21496-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.com:dkim,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 72D5F60271A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--tcierihojdco2ko5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH rdma-next v2 0/3] cgroup/rdma: add MR memory size
 resource tracking
MIME-Version: 1.0

Hi.

On Fri, May 29, 2026 at 05:07:30PM +0800, Tao Cui <cui.tao@linux.dev> wrote:
> The real scarce resource in multi-tenant
> deployments is pinned memory: how much physical memory gets registered
> through MRs.
> ...
> 3. Overlap with memory cgroup: mr_mem does not count process memory
>    usage; it represents a per-device DMA registration budget: the
>    amount of memory this cgroup may register through a given HCA.
>    This is a different dimension from what memory cgroup tracks.  An
>    administrator might set mr_mem limits differently per device, which
>    memory cgroup cannot express.
>=20
>    In particular, mr_mem tracks the registered memory range associated
>    with the MR rather than exact dynamically pinned pages (e.g. for
>    ODP MRs).  This is a stable, policy-oriented approximation of
>    registration footprint, not an attempt at precise physical page
>    accounting.

IIUC the pinned memory is regular RAM, i.e. it could be controlled with
memcg as needed. Or is there "physical" limit of what can be assigned to
a single device?

BTW, have a look at [1], it'd be good to converge to similar approach
(the current proposal allows distinguishing whether charging should
include or exempt memcg counting). Also it seems, that the dmem
controller could be a one-stop solution for all DMA charges. Please tell
me if there are any distinguishing factors between RDMA devices' memory
and these dmem memory regions.

Thanks,
Michal


[1] https://lore.kernel.org/r/20260519-cgroup-dmem-memcg-double-charge-v2-0=
-db4d1407062b@redhat.com/

--tcierihojdco2ko5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahmKkhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjxUgD+OExioWktiqQ9OzC9IpGL
l3Y0Srts+WHS89yla+uuu2IBALcEs0EwF6hOweZo9WWqnJ8ClpldY8i8TCukjmTp
iTQN
=I1f9
-----END PGP SIGNATURE-----

--tcierihojdco2ko5--

