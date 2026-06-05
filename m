Return-Path: <linux-rdma+bounces-21881-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uzIQKXJPI2pOowEAu9opvQ
	(envelope-from <linux-rdma+bounces-21881-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 00:36:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EF864BAC1
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 00:36:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=foRgoUBh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21881-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21881-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39DCF308113E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D9C3D3489;
	Fri,  5 Jun 2026 22:31:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF34071ED;
	Fri,  5 Jun 2026 22:31:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698669; cv=none; b=Kiqn0hrsE1aMncg/rjKUnmqp9cQkqlWOMBtlD7filOKVW3wYGydvKXb8jvIGEqEo49ogeIdU4DUWKGYn0aBryEKkUk4bJXiDOV9jsTI6IkOO/DjldM4Dl/xFBl2E7Niuc7QOT3VKMgFvw+aFZz4PmBR3JbOxil6HYmxM6F+p33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698669; c=relaxed/simple;
	bh=oS/imHgJFQmasaMDY83aTgTx0F4liiVGF/WWNjRYshA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkzWJYVxxC2Q4e0nje4SbkO7pNLx5ffvpSbDAXWpWGjTZaiOp7VWQ69V4ZGKMo8cLeGw11sczcPzLoyljPWMoRKii44OBixZKWwdZcbbzjAduo7vpy0vWfOYIB+50ebXO4uaryXZqVwWXwReLz6JiXaEeylhf0Q/nBDoctEHZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foRgoUBh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99EC1F00893;
	Fri,  5 Jun 2026 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780698667;
	bh=dhNkD28k4gIF8dZzKDY6vQSarf32neZrorpP8kTpsuw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=foRgoUBhpDtYsl+hais6gsy6rGlR+EZVF+PbR+gccJtQ+OmXmD02rQrzEPxrUWRKl
	 3PK3oji8jbu/pCiL/6X/UnNZ59NKto88b7+j/+f+6lYqxBQfj2BAW7PTejuADkQRQs
	 mBAOyavxqlfjHqg/g0VK1suYKAhlejYOMi9Rw9izzE6jTcD805MO8+7hQY44vSxS76
	 xnuyM1hkWe/FIBqND6zwOH9v+cCD2bZx/rC2XW/qyOezbJoUp1Y7CvtT8e/wPp3Z0k
	 qWz2JLGLlA2SFcvvklf/M5Mj6YCF+gvoX0W3JOIeAGdvmituxgUEJGr4hgwR+3o5sy
	 dfO7Xg7XC39ag==
Message-ID: <c46e42f947c1d88e77860ec3db9f61b5df23962d.camel@kernel.org>
Subject: Re: [PATCH net-next v2 3/3] rds: convert to getsockopt_iter
From: Allison Henderson <achender@kernel.org>
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Date: Fri, 05 Jun 2026 15:31:06 -0700
In-Reply-To: <20260605-getsock_more-v2-3-80f38cdb8706@debian.org>
References: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
	 <20260605-getsock_more-v2-3-80f38cdb8706@debian.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-21881-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01EF864BAC1

On Fri, 2026-06-05 at 03:31 -0700, Breno Leitao wrote:
> Convert RDS socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
>=20
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
>=20
> The RDS_INFO_* snapshot path in rds_info_getsockopt() used to pin the
> userspace buffer with pin_user_pages_fast() on the raw optval address;
> the info producers then memcpy into those pages under a spinlock via
> kmap_atomic() and so must not fault. Obtain the same page array and
> starting offset from opt->iter_out with iov_iter_extract_pages(), which
> pins for write because iter_out is ITER_DEST.
>=20
> The page array is preallocated here (sized with iov_iter_npages()) and
> passed in, so iov_iter_extract_pages() fills it in place rather than
> allocating one for us; RDS therefore keeps ownership of the array on
> every return path and frees it itself. The rds_info_iterator /
> rds_info_copy machinery and all producer callbacks are unchanged.
>=20
> Kernel buffers (ITER_KVEC) are not page-backed in a way the info
> producers can use, so the RDS_INFO path returns -EOPNOTSUPP for them;
> this matches the previous behaviour, where a kernel-buffer getsockopt
> hit the WARN_ONCE() path in do_sock_getsockopt() and returned
> -EOPNOTSUPP. The simple RDS_RECVERR and SO_RDS_TRANSPORT options keep
> working for kernel buffers via copy_to_iter().
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Looks good, thanks for the quick turn around.
Reviewed-by: Allison Henderson <achender@kernel.org>
> ---
>  net/rds/af_rds.c | 36 +++++++++++++++------------
>  net/rds/info.c   | 76 ++++++++++++++++++++++++++++++++------------------=
------
>  net/rds/info.h   |  3 +--
>  3 files changed, 65 insertions(+), 50 deletions(-)
>=20
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 6f4f9cf352bd..d5defe9172e3 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -37,6 +37,7 @@
>  #include <linux/in.h>
>  #include <linux/ipv6.h>
>  #include <linux/poll.h>
> +#include <linux/uio.h>
>  #include <net/sock.h>
> =20
>  #include "rds.h"
> @@ -485,35 +486,36 @@ static int rds_setsockopt(struct socket *sock, int =
level, int optname,
>  }
> =20
>  static int rds_getsockopt(struct socket *sock, int level, int optname,
> -			  char __user *optval, int __user *optlen)
> +			  sockopt_t *opt)
>  {
>  	struct rds_sock *rs =3D rds_sk_to_rs(sock->sk);
>  	int ret =3D -ENOPROTOOPT, len;
>  	int trans;
> +	int val;
> =20
>  	if (level !=3D SOL_RDS)
>  		goto out;
> =20
> -	if (get_user(len, optlen)) {
> -		ret =3D -EFAULT;
> -		goto out;
> -	}
> +	len =3D opt->optlen;
> =20
>  	switch (optname) {
>  	case RDS_INFO_FIRST ... RDS_INFO_LAST:
> -		ret =3D rds_info_getsockopt(sock, optname, optval,
> -					  optlen);
> +		ret =3D rds_info_getsockopt(sock, optname, opt);
>  		break;
> =20
>  	case RDS_RECVERR:
> -		if (len < sizeof(int))
> +		if (len < sizeof(int)) {
>  			ret =3D -EINVAL;
> -		else
> -		if (put_user(rs->rs_recverr, (int __user *) optval) ||
> -		    put_user(sizeof(int), optlen))
> +			break;
> +		}
> +		val =3D rs->rs_recverr;
> +		if (copy_to_iter(&val, sizeof(int), &opt->iter_out) !=3D
> +		    sizeof(int)) {
>  			ret =3D -EFAULT;
> -		else
> +		} else {
> +			opt->optlen =3D sizeof(int);
>  			ret =3D 0;
> +		}
>  		break;
>  	case SO_RDS_TRANSPORT:
>  		if (len < sizeof(int)) {
> @@ -522,11 +524,13 @@ static int rds_getsockopt(struct socket *sock, int =
level, int optname,
>  		}
>  		trans =3D (rs->rs_transport ? rs->rs_transport->t_type :
>  			 RDS_TRANS_NONE); /* unbound */
> -		if (put_user(trans, (int __user *)optval) ||
> -		    put_user(sizeof(int), optlen))
> +		if (copy_to_iter(&trans, sizeof(int), &opt->iter_out) !=3D
> +		    sizeof(int)) {
>  			ret =3D -EFAULT;
> -		else
> +		} else {
> +			opt->optlen =3D sizeof(int);
>  			ret =3D 0;
> +		}
>  		break;
>  	default:
>  		break;
> @@ -653,7 +657,7 @@ static const struct proto_ops rds_proto_ops =3D {
>  	.listen =3D	sock_no_listen,
>  	.shutdown =3D	sock_no_shutdown,
>  	.setsockopt =3D	rds_setsockopt,
> -	.getsockopt =3D	rds_getsockopt,
> +	.getsockopt_iter =3D	rds_getsockopt,
>  	.sendmsg =3D	rds_sendmsg,
>  	.recvmsg =3D	rds_recvmsg,
>  	.mmap =3D		sock_no_mmap,
> diff --git a/net/rds/info.c b/net/rds/info.c
> index 17061f6ff74e..21b32eb16559 100644
> --- a/net/rds/info.c
> +++ b/net/rds/info.c
> @@ -35,6 +35,7 @@
>  #include <linux/slab.h>
>  #include <linux/proc_fs.h>
>  #include <linux/export.h>
> +#include <linux/uio.h>
> =20
>  #include "rds.h"
> =20
> @@ -144,60 +145,68 @@ void rds_info_copy(struct rds_info_iterator *iter, =
void *data,
>  EXPORT_SYMBOL_GPL(rds_info_copy);
> =20
>  /*
> - * @optval points to the userspace buffer that the information snapshot
> - * will be copied into.
> - *
> - * @optlen on input is the size of the buffer in userspace.  @optlen
> - * on output is the size of the requested snapshot in bytes.
> + * @opt->iter_out describes the buffer that the information snapshot wil=
l be
> + * copied into, and @opt->optlen is the size of that buffer on input.  O=
n
> + * output @opt->optlen is set to the size of the requested snapshot in b=
ytes.
>   *
>   * This function returns -errno if there is a failure, particularly -ENO=
SPC
> - * if the given userspace buffer was not large enough to fit the snapsho=
t.
> - * On success it returns the positive number of bytes of each array elem=
ent
> - * in the snapshot.
> + * if the given buffer was not large enough to fit the snapshot.  On suc=
cess
> + * it returns the positive number of bytes of each array element in the
> + * snapshot.
>   */
> -int rds_info_getsockopt(struct socket *sock, int optname, char __user *o=
ptval,
> -			int __user *optlen)
> +int rds_info_getsockopt(struct socket *sock, int optname, sockopt_t *opt=
)
>  {
>  	struct rds_info_iterator iter;
>  	struct rds_info_lengths lens;
>  	unsigned long nr_pages =3D 0;
> -	unsigned long start;
>  	rds_info_func func;
>  	struct page **pages =3D NULL;
> +	size_t offset0 =3D 0;
> +	int npages =3D 0;
>  	int ret;
>  	int len;
>  	int total;
> =20
> -	if (get_user(len, optlen)) {
> -		ret =3D -EFAULT;
> -		goto out;
> -	}
> +	len =3D opt->optlen;
> =20
>  	/* check for all kinds of wrapping and the like */
> -	start =3D (unsigned long)optval;
> -	if (len < 0 || len > INT_MAX - PAGE_SIZE + 1 || start + len < start) {
> +	if (len < 0 || len > INT_MAX - PAGE_SIZE + 1) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> =20
> +	/* The info producers write into the pages with kmap_atomic() while
> +	 * holding a spinlock, so they need a genuine page-backed user buffer.
> +	 */
> +	if (!user_backed_iter(&opt->iter_out)) {
> +		ret =3D -EOPNOTSUPP;
> +		goto out;
> +	}
> +
>  	/* a 0 len call is just trying to probe its length */
>  	if (len =3D=3D 0)
>  		goto call_func;
> =20
> -	nr_pages =3D (PAGE_ALIGN(start + len) - (start & PAGE_MASK))
> -			>> PAGE_SHIFT;
> -
> -	pages =3D kmalloc_objs(struct page *, nr_pages);
> +	/*
> +	 * Preallocate the page array and pass it in so that
> +	 * iov_iter_extract_pages() fills it in place rather than allocating
> +	 * one for us.  Handing it a non-NULL array keeps ownership of the
> +	 * array with us on every return path, instead of depending on the
> +	 * iterator code to allocate and hand it back.
> +	 */
> +	npages =3D iov_iter_npages(&opt->iter_out, INT_MAX);
> +	pages =3D kvmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
>  	if (!pages) {
>  		ret =3D -ENOMEM;
>  		goto out;
>  	}
> -	ret =3D pin_user_pages_fast(start, nr_pages, FOLL_WRITE, pages);
> -	if (ret !=3D nr_pages) {
> -		if (ret > 0)
> -			nr_pages =3D ret;
> -		else
> -			nr_pages =3D 0;
> +
> +	ret =3D iov_iter_extract_pages(&opt->iter_out, &pages, len, npages,
> +				     0, &offset0);
> +	if (ret < 0)
> +		goto out;
> +	nr_pages =3D DIV_ROUND_UP(offset0 + ret, PAGE_SIZE);
> +	if (ret !=3D len) {
>  		ret =3D -EAGAIN; /* XXX ? */
>  		goto out;
>  	}
> @@ -213,7 +222,7 @@ int rds_info_getsockopt(struct socket *sock, int optn=
ame, char __user *optval,
> =20
>  	iter.pages =3D pages;
>  	iter.addr =3D NULL;
> -	iter.offset =3D start & (PAGE_SIZE - 1);
> +	iter.offset =3D offset0;
> =20
>  	func(sock, len, &iter, &lens);
>  	BUG_ON(lens.each =3D=3D 0);
> @@ -230,13 +239,16 @@ int rds_info_getsockopt(struct socket *sock, int op=
tname, char __user *optval,
>  		ret =3D lens.each;
>  	}
> =20
> -	if (put_user(len, optlen))
> -		ret =3D -EFAULT;
> +	opt->optlen =3D len;
> =20
>  out:
> -	if (pages)
> +	/*
> +	 * iov_iter_extract_pages() pins only user-backed (ubuf) iters;
> +	 * iov_iter_extract_will_pin() reports whether an unpin is owed here.
> +	 */
> +	if (pages && iov_iter_extract_will_pin(&opt->iter_out))
>  		unpin_user_pages_dirty_lock(pages, nr_pages, true);
> -	kfree(pages);
> +	kvfree(pages);
> =20
>  	return ret;
>  }
> diff --git a/net/rds/info.h b/net/rds/info.h
> index a069b51c4679..1aab62ab6d00 100644
> --- a/net/rds/info.h
> +++ b/net/rds/info.h
> @@ -21,8 +21,7 @@ typedef void (*rds_info_func)(struct socket *sock, unsi=
gned int len,
> =20
>  void rds_info_register_func(int optname, rds_info_func func);
>  void rds_info_deregister_func(int optname, rds_info_func func);
> -int rds_info_getsockopt(struct socket *sock, int optname, char __user *o=
ptval,
> -			int __user *optlen);
> +int rds_info_getsockopt(struct socket *sock, int optname, sockopt_t *opt=
);
>  void rds_info_copy(struct rds_info_iterator *iter, void *data,
>  		   unsigned long bytes);
>  void rds_info_iter_unmap(struct rds_info_iterator *iter);
>=20


