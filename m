Return-Path: <linux-rdma+bounces-21825-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qJzAF5qdImr9awEAu9opvQ
	(envelope-from <linux-rdma+bounces-21825-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 11:57:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C04926471BE
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 11:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kio0Un4P;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21825-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21825-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6AC4301E7D9
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506CA3E317F;
	Fri,  5 Jun 2026 09:56:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE093D0C12;
	Fri,  5 Jun 2026 09:56:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653378; cv=none; b=Yak7NLD/Uhc/impq5cKcj6cZewRjFlCOA1T0UeWTvyzCO1+cJEtH8HHVjFgCFlSsmjWa59Ntl9HoGXeNG32uHOboO8B8RD3fpcWOYFjcmqEhqRIsmUopUdDwotYcbtgwTmUq2IE/Y0cfscOQi4LtssrBsB6VQGC2YoCA+C2peZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653378; c=relaxed/simple;
	bh=ebx2eOoRfodw4FjM3aTndhII1xk2ScvNBV1BYPRHfu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gueB96PPBgTh/5yd86/d+pjImbeRbsTtTcIcv685Uaa7CAj8P9BuC4fSh8nhr9f0WF7cqs+VCdwTPjnMn0SCmy6BRZ0GBFQ07c0KYGnQ1bFhPaUVHBi6edlEK1rVIH1ype+JYdYRBBiekGxO+ci/G8OZXbnYpYcl7wNI0yk9YtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kio0Un4P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A495D1F00893;
	Fri,  5 Jun 2026 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653376;
	bh=BUfEQxhjOu8G3jt69U+LgJt/XEj0OlJFMZlUeTVC9fI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kio0Un4PfaU/SXyNE8jwmEmw254Z8DLHgGB0XiNVo+KSGfRRKIG6yrLk4QTEIjc7D
	 3aUg49zXdCNDuqvg5r4EQaUyeNfAxQydmiucDjckbdqc3lezBQHRGoWxVVqFuCcAiH
	 X2MlKZc35uFNNIQ5CLt6sLgaTVLp7R/TlUd9x9v/LpHL2pwjJsEdm7U3z6Cmor5RaI
	 wH+L3gMxvJw77fCVvEago6IETawENhnSEwVKj31GV8wxIM7QsFf2h747ciCID8/7VF
	 ruwDCsCemy54CjAQ9fPjnyJ6PGDcmsyrNYKXJVZ9+UZflK29qx89dzc0sHYtCzcxKN
	 vxkyknCTE+qhg==
Message-ID: <134c50a1ca2d2f2bc06336072c89ff011a9842cb.camel@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: net: rds: add getsockopt()
 conversion test
From: Allison Henderson <achender@kernel.org>
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Date: Fri, 05 Jun 2026 02:56:09 -0700
In-Reply-To: <20260603-getsock_more-v1-2-43b8d40c8849@debian.org>
References: <20260603-getsock_more-v1-0-43b8d40c8849@debian.org>
	 <20260603-getsock_more-v1-2-43b8d40c8849@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21825-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,include.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C04926471BE

On Wed, 2026-06-03 at 09:11 -0700, Breno Leitao wrote:
> Add a kselftest that exercises the RDS getsockopt() paths converted to
> the getsockopt_iter() / sockopt_t callback:
>=20
> - RDS_RECVERR and SO_RDS_TRANSPORT, which return their int value through
>   copy_to_iter() and report the written length in opt->optlen.
>=20
> - RDS_INFO_*, which obtains the userspace buffer pages with
>   iov_iter_extract_pages() (including a non-zero starting page offset)
>   and lets the info producers copy the snapshot in under a spinlock.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Hi Breno,

Thanks for working on this.  Your test covers a lot of socket behavior that=
 the
existing packet test doesn't get into, so I definitely think it's worth add=
ing.
I ran it locally under vng and it passes for me.  I did notice one nit belo=
w, but
otherwise I think it looks really good.


> ---
>  tools/testing/selftests/net/rds/.gitignore   |   1 +
>  tools/testing/selftests/net/rds/Makefile     |   4 +
>  tools/testing/selftests/net/rds/getsockopt.c | 201 +++++++++++++++++++++=
++++++
>  3 files changed, 206 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/rds/.gitignore b/tools/testing/s=
elftests/net/rds/.gitignore
> index 1c6f04e2aa11..7ca4b1440f51 100644
> --- a/tools/testing/selftests/net/rds/.gitignore
> +++ b/tools/testing/selftests/net/rds/.gitignore
> @@ -1 +1,2 @@
>  include.sh
> +getsockopt
> diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/sel=
ftests/net/rds/Makefile
> index fe363be8e358..0700d8298eec 100644
> --- a/tools/testing/selftests/net/rds/Makefile
> +++ b/tools/testing/selftests/net/rds/Makefile
> @@ -5,6 +5,8 @@ all:
> =20
>  TEST_PROGS :=3D run.sh
> =20
> +TEST_GEN_PROGS :=3D getsockopt
> +
>  TEST_FILES :=3D \
>  	include.sh \
>  	settings \
> @@ -16,4 +18,6 @@ EXTRA_CLEAN :=3D \
>  	/tmp/rds_logs \
>  # end of EXTRA_CLEAN
> =20
> +CFLAGS +=3D $(KHDR_INCLUDES)
> +
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/rds/getsockopt.c b/tools/testing=
/selftests/net/rds/getsockopt.c
> new file mode 100644
> index 000000000000..a82ffe4871c2
> --- /dev/null
> +++ b/tools/testing/selftests/net/rds/getsockopt.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Exercise the RDS getsockopt() paths that were converted to the
> + * getsockopt_iter() / sockopt_t callback.
> + *
> + * Three distinct paths are covered:
> + *
> + *   - RDS_RECVERR and SO_RDS_TRANSPORT, which now return their int valu=
e
> + *     through copy_to_iter() and report the written length in opt->optl=
en.
> + *
> + *   - RDS_INFO_*, which pins the userspace buffer with
> + *     iov_iter_extract_pages() (including a non-zero starting page offs=
et)
> + *     and lets the info producers memcpy the snapshot in under a spinlo=
ck.
> + *
> + * The kvec (in-kernel buffer) -> -EOPNOTSUPP path of rds_info_getsockop=
t()
> + * is not reachable from a userspace getsockopt() and so is not tested h=
ere.
> + */
> +#include <errno.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/socket.h>
> +#include <linux/rds.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#ifndef AF_RDS
> +#define AF_RDS 21
> +#endif
> +
> +FIXTURE(rds) {
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(rds)
> +{
> +	self->fd =3D socket(AF_RDS, SOCK_SEQPACKET, 0);
> +	if (self->fd < 0)
> +		SKIP(return, "AF_RDS unavailable (errno %d) - load the rds module",
> +		     errno);
> +}
> +
> +FIXTURE_TEARDOWN(rds)
> +{
> +	if (self->fd >=3D 0)
> +		close(self->fd);
> +}
> +
> +/* RDS_RECVERR defaults to 0 and is reported back as a 4-byte int. */
> +TEST_F(rds, recverr_default)
> +{
> +	socklen_t len =3D sizeof(int);
> +	int val =3D 0xdeadbeef;
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_RDS, RDS_RECVERR, &val, &len));
> +	EXPECT_EQ(sizeof(int), len);
> +	EXPECT_EQ(0, val);
> +}
> +
> +/* A value set via setsockopt() must be readable back unchanged. */
> +TEST_F(rds, recverr_set_get)
> +{
> +	socklen_t len =3D sizeof(int);
> +	int val =3D 1;
> +
> +	ASSERT_EQ(0, setsockopt(self->fd, SOL_RDS, RDS_RECVERR, &val, len));
> +
> +	val =3D 0;
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_RDS, RDS_RECVERR, &val, &len));
> +	EXPECT_EQ(sizeof(int), len);
> +	EXPECT_EQ(1, val);
> +}
> +
> +/* A buffer smaller than an int is rejected with EINVAL, not silently. *=
/
> +TEST_F(rds, recverr_short_buffer)
> +{
> +	socklen_t len =3D sizeof(int) - 1;
> +	char buf[sizeof(int)];
> +
> +	EXPECT_EQ(-1, getsockopt(self->fd, SOL_RDS, RDS_RECVERR, buf, &len));
> +	EXPECT_EQ(EINVAL, errno);
> +}
> +
> +/* An unbound socket reports RDS_TRANS_NONE for SO_RDS_TRANSPORT. */
> +TEST_F(rds, transport_unbound)
> +{
> +	socklen_t len =3D sizeof(int);
> +	int val =3D 0;
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_RDS, SO_RDS_TRANSPORT, &val,
> +				&len));
> +	EXPECT_EQ(sizeof(int), len);
> +	EXPECT_EQ(RDS_TRANS_NONE, (unsigned int)val);
> +}
> +
> +TEST_F(rds, transport_short_buffer)
> +{
> +	socklen_t len =3D sizeof(int) - 1;
> +	char buf[sizeof(int)];
> +
> +	EXPECT_EQ(-1, getsockopt(self->fd, SOL_RDS, SO_RDS_TRANSPORT, buf,
> +				 &len));
> +	EXPECT_EQ(EINVAL, errno);
> +}
> +
> +/*
> + * RDS_INFO_COUNTERS with a zero-length buffer is the "probe" call: it m=
ust
> + * fail with ENOSPC and report the required snapshot size in optlen.
> + */
> +TEST_F(rds, info_counters_probe)
> +{
> +	socklen_t len =3D 0;
> +
> +	EXPECT_EQ(-1, getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, NULL,
> +				 &len));
> +	EXPECT_EQ(ENOSPC, errno);
> +	EXPECT_GT(len, 0);
> +	/* The snapshot is an array of fixed-size counter records. */
> +	EXPECT_EQ(0, len % (socklen_t)sizeof(struct rds_info_counter));
> +}
> +
> +/*
> + * A real snapshot into an unaligned userspace buffer exercises the
> + * iov_iter_extract_pages() path, including the non-zero offset0 handlin=
g
> + * that the patch reworked. Place the buffer at a non-page-aligned addre=
ss
> + * spanning into the next page to make sure multi-page pinning works too=
.
> + */
> +TEST_F(rds, info_counters_snapshot)
> +{
> +	struct rds_info_counter *ctr;
> +	socklen_t need =3D 0, len;
> +	long pagesz =3D sysconf(_SC_PAGESIZE);
> +	unsigned int i, n;
> +	char *region, *buf;
> +	int ret;
> +
> +	/* Probe for the required size. */
> +	getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, NULL, &need);
> +	ASSERT_GT(need, 0);
> +
> +	region =3D mmap(NULL, 2 * pagesz, PROT_READ | PROT_WRITE,
> +		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

The 2-page mapping (and the ASSERT_LE guarding it) ties the test to the sna=
pshot
fitting in two pages.  This works right now, but ideally the region here sh=
ould
account for the number of counters that come back from RDS_INFO_COUNTERS so=
 that
if the total number of counters were to grow later, we don't overrun a regi=
on
that's set to a fixed number of pages.  So in this case, we'd want the need=
 + offset,
and then page align that so we can mmap it:

	offset	=3D pagesz - 64;=20
	map_len	=3D ((offset + need + pagesz - 1) / pagesz) * pagesz;  /* round (o=
ff+need) up to whole pages */
	region  =3D mmap(NULL, map_len, ...);                =20


> +	ASSERT_NE(MAP_FAILED, region);
> +
> +	/* Unaligned start that runs past the first page boundary. */
> +	buf =3D region + pagesz - 64;
Then this simplifies to:
	buf =3D region + offset;

> +	ASSERT_LE(need, (socklen_t)(pagesz + 64));
And then the ASSERT here can be removed

> +
> +	/*
> +	 * On success the RDS_INFO path returns the positive per-element size
> +	 * (lens.each) rather than 0, and writes the full snapshot length back
> +	 * into optlen.
> +	 */
> +	len =3D need;
> +	ret =3D getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, buf, &len);
> +	ASSERT_GE(ret, 0) {
> +		TH_LOG("getsockopt snapshot failed: errno %d", errno);
> +	}
> +	EXPECT_EQ(sizeof(struct rds_info_counter), ret);
> +	EXPECT_EQ(need, len);
> +
> +	/* The counter names must be NUL-terminated, non-empty strings. */
> +	ctr =3D (struct rds_info_counter *)buf;
> +	n =3D len / sizeof(*ctr);
> +	ASSERT_GT(n, 0);
> +	for (i =3D 0; i < n; i++) {
> +		size_t namelen =3D strnlen((char *)ctr[i].name,
> +					 sizeof(ctr[i].name));
> +
> +		EXPECT_GT(namelen, 0);
> +		EXPECT_LT(namelen, sizeof(ctr[i].name));
> +	}
> +
> +	munmap(region, 2 * pagesz);

Finally this turns into:
        munmap(region, map_len);

That's the only thing that really stood out.  I think the rest of it looks =
really good.  Thanks for putting this
together!

Allison
> +}
> +
> +/*
> + * A non-zero but too-small buffer must report ENOSPC and the full requi=
red
> + * length, without corrupting memory past the buffer.
> + */
> +TEST_F(rds, info_counters_short_buffer)
> +{
> +	socklen_t need =3D 0, len;
> +	char small[sizeof(struct rds_info_counter)];
> +
> +	getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, NULL, &need);
> +	ASSERT_GT(need, 0);
> +
> +	/* Ask with a buffer guaranteed smaller than the full snapshot. */
> +	if (need <=3D (socklen_t)sizeof(small))
> +		SKIP(return, "snapshot fits in one record; nothing to test");
> +
> +	len =3D 1; /* < sizeof(struct rds_info_counter) */
> +	EXPECT_EQ(-1, getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, small,
> +				 &len));
> +	EXPECT_EQ(ENOSPC, errno);
> +	EXPECT_EQ(need, len);
> +}
> +
> +TEST_HARNESS_MAIN
>=20


