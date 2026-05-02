Return-Path: <linux-rdma+bounces-19843-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LBbLn+O9WmyMQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19843-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 07:41:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086704B10C1
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 07:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CECD73007B15
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 05:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C668E2C1788;
	Sat,  2 May 2026 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO6eNjDr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD93594A;
	Sat,  2 May 2026 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777700471; cv=none; b=FdjHPFCwqk+5Y5rWMFFrkFQG1Zfm35VLTBpTmKdSTMRg/LhGqbcq2yVNLtBBKH5Jry2bYFfQXfVNgvkHX3Hhb17mq13pX95eqkmw7TJWBTWfxKIBGOrB3OxsM6T5O0Q3F4HBDmG9zC6XdjpyuefTWDGgcuzqsQcdme9oHf+yGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777700471; c=relaxed/simple;
	bh=/plK23aRo0ayFf8WWgHy9klYZ9azR4dJCj7ErIpxxQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODJreRXbilrkksSqZW5aNoP6DhO6gHjPc6XIE4y+AsvoaShxH+WTl8VZq69cdMDxQlgSvwQbLG8CIUfEw1Y0kDyHC2ED8S0Brbi9qyQ93E3NVHuIpqJEYuF28qjZhxv7ZKrLVQdEXrFQgn+wllyezmcGTMlXTfUSCbixxtlr3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO6eNjDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC69C19425;
	Sat,  2 May 2026 05:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777700471;
	bh=/plK23aRo0ayFf8WWgHy9klYZ9azR4dJCj7ErIpxxQo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qO6eNjDr8psBgKDgKZq9Jp7cT4JSFxKQsIi1VP1AjenFYtfyasBv8bFhG0CZmEUZx
	 zn3fOHK8zYLouwr3rbwQad4gGLGC11QOidlFCr+hB+dnEAOkGJBsm5/pE29IzZ+Nc/
	 x6Fg6gH/CuW+PkeFKAGEOTqJcrv0mOXjEYOdmdYmwXeF/bQnDJP4alUyA/HCOGP0Va
	 Sk/kJHhmqK3VbxKGHmK/6VQXoHH/3bq9FJq3jy3Gg+R0sPLqzh0kdubb4xUr5tz8Qc
	 tNOpd4WXWVn97+eNfq/bPObZj+NDDKUXbYQUeHiVMuPqGD4FMt2GbqJ9N3J7o3ar6I
	 Qv6Pxaq/zSDuA==
Message-ID: <9958903b1de52cff6d0d5531355da614cb66517e.camel@kernel.org>
Subject: Re: [PATCH net-next v2 6/7] selftests: rds: Collect pcaps on timeout
From: Allison Henderson <achender@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
 horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  shuah@kernel.org
Date: Fri, 01 May 2026 22:41:09 -0700
In-Reply-To: <20260430024207.2452372-1-kuba@kernel.org>
References: <20260428222716.2960871-7-achender@kernel.org>
	 <20260430024207.2452372-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 086704B10C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19843-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, 2026-04-29 at 19:42 -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> selftests: rds: Collect pcaps on timeout
>=20
> This commit updates the RDS selftest to collect network packet captures
> when a timeout occurs. It moves the packet capture cleanup logic into a
> new helper function and calls it from the signal handler before exiting.
>=20
> > diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/se=
lftests/net/rds/test.py
> > --- a/tools/testing/selftests/net/rds/test.py
> > +++ b/tools/testing/selftests/net/rds/test.py
> [ ... ]
> > @@ -70,11 +70,21 @@ def netns_socket(netns, *sock_args):
> >      u1.close()
> >      return socket.fromfd(fds[0], *sock_args)
> > =20
> > +def collect_pcaps():
> > +    """Stop tcpdump processes and move their pcaps into the log dir.""=
"
> > +    print("Stopping network packet captures")
> > +    for proc, tmp_path, dest_path, fno in tcpdump_procs:
> > +        proc.terminate()
> > +        proc.wait()
>=20
> Could this proc.wait() block indefinitely and defeat the test timeout?
>=20
> If a child process is unresponsive, the timeout signal handler will get
> stuck waiting for it. Using proc.wait(timeout=3D...) might ensure the
> timeout path remains robust and doesn't hang the test infrastructure.
Good catch, I will add a timeout

>=20
> > +        os.close(fno)
> > +        shutil.move(tmp_path, dest_path)
>=20
> Can this cause unhandled exceptions if the timeout triggers during or
> after the normal script cleanup phase?
>=20
> Because collect_pcaps() is called from both the normal execution path and
> the timeout signal handler, it might be executed twice. Since it loops
> over the global tcpdump_procs list without clearing processed items, a
> second run will attempt to close already closed file descriptors and move
> already moved files.
>=20
> In Python, this raises OSError (EBADF) and FileNotFoundError, which would
> abort the signal handler with a traceback instead of executing the clean
> sys.exit(1).
I see, I think if we change the for loop to a while loop that pop() items o=
ut of tcpdump_procs,=C2=A0that should make it safe
to call twice, if the timeout fires during or after normal cleanup.


If that sounds good, I can send that in a v3.

Thanks!
Allison



