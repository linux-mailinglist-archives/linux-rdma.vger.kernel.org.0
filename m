Return-Path: <linux-rdma+bounces-22112-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2AfFDWSwKmocvAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22112-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:56:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E167212A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:56:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B85w8jOr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22112-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22112-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED60833A53F5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD63FAE19;
	Thu, 11 Jun 2026 12:52:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726033F8ED8;
	Thu, 11 Jun 2026 12:52:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182368; cv=none; b=CSngW5QoszXNP5luQAhKk7DPCZSCMNBAHvQV3YeNdh0mQqnDzfzQmMjp/OUj29xZa3NNaSBjL6QOhjqMEPEbVL00ZXkoVr8ZqRT8AO0rTCqpCPS3Z8Uve+KSrMv+6gtoATV4UtHbDID9LkPhnaiXQEZ8zvuqF/0v81TnxHgBF4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182368; c=relaxed/simple;
	bh=wJgxboTU2zn26QBilNRHyO0OyIuVUSc8LHWxGLP19yQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=I8ZTHeYspjrl6tCQvbbCkNwmPKHUppfrEw7warPZtlw8L3AdWqVMVG9UfmpbjjV42tBL2JNd3guDYtS14AWapL+gOri+UGyHrnwKHErPgOuoLTDSzytb3II5w/WQ4R69ZbdcVwnTEV9dCcU2sFZvD1GMjz8e4HBDNS2wYqXrSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B85w8jOr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEB11F00893;
	Thu, 11 Jun 2026 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182367;
	bh=MhJ79RE83SlPlL09hjhdQ09VcDME15ymYeAZgh8podg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B85w8jOrzbsnuSUc0wtTUgt3jvNR2QIpKZnVHFWzwokn2Xv+TZpQ2+L0gZ0GVf1af
	 U5CHcyJh5xr/QQQy8kRKgFV7SX7qvYgKgZJ8gy4wO+Jd5y/7f9zL8CfKyHm+E8vPxI
	 HA7QufWhaJWLPAOV8zE9jnozmj3+lKT94bmhb5vPYeDfXV6r6vFpNX/h5RzwfhKRbG
	 6SO1dz7PsfIXzBRfWEyujzkEV7o9kXqX5V82tv3BjwKJ3Qs2JfG8GT0lQ/GRWA7o02
	 yTutHfrNBwZP8vuUfvbhRDik5lDOK/9vly3d5Z0hsV75ynQ1Gr3Gkh+1UZ3ji7iS5o
	 cqK5w5JOohyfQ==
Content-Type: multipart/mixed; boundary="------------x0ULY3W347LQLodgOx5sQKT9"
Message-ID: <2e1b0534-a1a0-4eb1-a5e2-d42fcf991188@kernel.org>
Date: Thu, 11 Jun 2026 14:52:36 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3 2/2] rds: convert to getsockopt_iter: manual
 merge
Content-Language: fr
To: Breno Leitao <leitao@debian.org>, Allison Henderson <achender@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Andy Grover <andy.grover@oracle.com>, Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20260608-getsock_more-v3-0-706ecf2ea332@debian.org>
 <20260608-getsock_more-v3-2-706ecf2ea332@debian.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260608-getsock_more-v3-2-706ecf2ea332@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:achender@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:andy.grover@oracle.com,m:broonie@kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[matttbe@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22112-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,linux-rdma@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B4E167212A

This is a multi-part message in MIME format.
--------------x0ULY3W347LQLodgOx5sQKT9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Breno, Allison,

On 08/06/2026 11:44, Breno Leitao wrote:
> Convert RDS socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> The RDS_INFO_* snapshot path in rds_info_getsockopt() used to pin the
> userspace buffer with pin_user_pages_fast() on the raw optval address;
> the info producers then memcpy into those pages under a spinlock via
> kmap_atomic() and so must not fault. Obtain the same page array and
> starting offset from opt->iter_out with iov_iter_extract_pages(), which
> pins for write because iter_out is ITER_DEST.
> 
> The page array is preallocated here (sized with iov_iter_npages()) and
> passed in, so iov_iter_extract_pages() fills it in place rather than
> allocating one for us; RDS therefore keeps ownership of the array on
> every return path and frees it itself. The rds_info_iterator /
> rds_info_copy machinery and all producer callbacks are unchanged.
> 
> Kernel buffers (ITER_KVEC) are not page-backed in a way the info
> producers can use, so the RDS_INFO path returns -EOPNOTSUPP for them;
> this matches the previous behaviour, where a kernel-buffer getsockopt
> hit the WARN_ONCE() path in do_sock_getsockopt() and returned
> -EOPNOTSUPP. The simple RDS_RECVERR and SO_RDS_TRANSPORT options keep
> working for kernel buffers via copy_to_iter().

(...)

> diff --git a/net/rds/info.c b/net/rds/info.c
> index f1b29994934a..499b3774860e 100644
> --- a/net/rds/info.c
> +++ b/net/rds/info.c

(...)

> @@ -230,13 +239,16 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
>  		ret = lens.each;
>  	}
>  
> -	if (put_user(len, optlen))
> -		ret = -EFAULT;
> +	opt->optlen = len;
>  
>  out:
> -	if (pages)
> +	/*
> +	 * iov_iter_extract_pages() pins only user-backed (ubuf) iters;
> +	 * iov_iter_extract_will_pin() reports whether an unpin is owed here.
> +	 */
> +	if (pages && iov_iter_extract_will_pin(&opt->iter_out))
>  		unpin_user_pages(pages, nr_pages);

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  f512db8267b73 ("rds: mark snapshot pages dirty in rds_info_getsockopt()")

and this one from 'net-next':

  6e94eeb2a2a6 ("rds: convert to getsockopt_iter")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side [1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, I took the modification from net-next, but
using unpin_user_pages_dirty_lock() from net.

Rerere cache is available in [2].

Cheers,
Matt

1: https://github.com/multipath-tcp/mptcp_net-next/commit/a8d41e018cc6
2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/88eeb

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------x0ULY3W347LQLodgOx5sQKT9
Content-Type: text/x-patch; charset=UTF-8;
 name="a8d41e018cc69a6546ef6acc4a97bcbeb3e75d43.patch"
Content-Disposition: attachment;
 filename="a8d41e018cc69a6546ef6acc4a97bcbeb3e75d43.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIG5ldC9yZHMvaW5mby5jCmluZGV4IDQ5OWIzNzc0ODYwZSwxNzA2MWY2ZmY3
NGUuLjIxYjMyZWIxNjU1OQotLS0gYS9uZXQvcmRzL2luZm8uYworKysgYi9uZXQvcmRzL2lu
Zm8uYwpAQEAgLTIzOSwxNiAtMjMwLDEzICsyMzksMTYgQEBAIGNhbGxfZnVuYwogIAkJcmV0
ID0gbGVucy5lYWNoOwogIAl9CiAgCiAtCWlmIChwdXRfdXNlcihsZW4sIG9wdGxlbikpCiAt
CQlyZXQgPSAtRUZBVUxUOwogKwlvcHQtPm9wdGxlbiA9IGxlbjsKICAKICBvdXQ6CiAtCWlm
IChwYWdlcykKICsJLyoKICsJICogaW92X2l0ZXJfZXh0cmFjdF9wYWdlcygpIHBpbnMgb25s
eSB1c2VyLWJhY2tlZCAodWJ1ZikgaXRlcnM7CiArCSAqIGlvdl9pdGVyX2V4dHJhY3Rfd2ls
bF9waW4oKSByZXBvcnRzIHdoZXRoZXIgYW4gdW5waW4gaXMgb3dlZCBoZXJlLgogKwkgKi8K
ICsJaWYgKHBhZ2VzICYmIGlvdl9pdGVyX2V4dHJhY3Rfd2lsbF9waW4oJm9wdC0+aXRlcl9v
dXQpKQotIAkJdW5waW5fdXNlcl9wYWdlcyhwYWdlcywgbnJfcGFnZXMpOworIAkJdW5waW5f
dXNlcl9wYWdlc19kaXJ0eV9sb2NrKHBhZ2VzLCBucl9wYWdlcywgdHJ1ZSk7CiAtCWtmcmVl
KHBhZ2VzKTsKICsJa3ZmcmVlKHBhZ2VzKTsKICAKICAJcmV0dXJuIHJldDsKICB9Cg==

--------------x0ULY3W347LQLodgOx5sQKT9--

