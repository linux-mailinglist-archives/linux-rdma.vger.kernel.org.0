Return-Path: <linux-rdma+bounces-20261-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOrnNCs7/mkroAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20261-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 21:36:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 514684FB2F9
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 21:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 621E43073749
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB3413220;
	Fri,  8 May 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boZEVMj8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1C359A8B
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268804; cv=pass; b=NARBU0Up/1DhyDy5q3njV2ZoEGCaJvjgwICXLWRRia03SQ2/aZWmxMtN6YcWaI/QvaP6wQpfdxYIAFhgBww0/xx1XbtMDGZ1hxY+MYvLOKz8G4pWYPWxlN8xGvlNrwjlGLKs/uSnA8RPLb0A9z3S507l5XwGfTps1uudq3YLqCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268804; c=relaxed/simple;
	bh=KOz2CthW9DZTi9DtDOS4s6UwKiyzP3Sh6aGujr/riF4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ipRl6JophdGQwdREHLXYJd/J7KKK/bZ3mYg8hYn95wcdQZUWU/I21XpZeMkIj5UkEHk7yu7D6Wkb3JdC3jzJb1ENJrjvXTxYjrmszdwlF2xD/fy1E5boAKz2g8q+2k1Xz8jFF9XnJCFwchHdC9BmluWYu/Kl5yRbYXXuraRgkkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boZEVMj8; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b41fdf9de2so19894797b3.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 12:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778268801; cv=none;
        d=google.com; s=arc-20240605;
        b=dbDE4++6oVq6qHGFS1FYTkHzYsOJo5ZilCTdbKJyo6NNduSbVSsJi2WENlUoyHJURv
         nq4E9nkvvd9BrMwTRmZcYHJEx8CckVG34EMvv7gK+qz0UEoPeaL+4dHNmMESMTFvzwYL
         xWbEXepQt0N0akrI9pWjl+jmNh8n4yAXYEqliUENSQPnfWwfMzrJ/vi0TvX+zrBN+tVf
         ktkB2I4ryhxwbSBQm0sDbqCeBuji/visPXz8TsSVMRTprOHA+8EGCL0oK84pwZvZsqQK
         qLvs6MosO7SIw3nk5MomOlDWt6XmDDPGuak5Z0pqCN8GqR8fxiDnbI+c3wcXeIIxWo0D
         lHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        fh=yA4wItC9o4lISoOEQyoAXxWbD5yleO/j+k+P8x+kadw=;
        b=ABNgC0tMbDAAkX+m79C7rMPdWYCx2k4AwQqW6YDp9YRk4UYPwsG++yZn8kA7Nmk/26
         X8/foPE4dG2uIMukWxa97FllokGodzSFd+h1oRg772A0Oy7+4uQ0Xjn3svME81IiThtf
         eMdzQdHZpxuOFpI0h6zyvbjo0gx/2E0MLHJ3YApxuWa6uAHdl6RpSqfRH7Rk8a1p6Jiq
         TSYd6H6V+08zar2QoBFVKCnB0BdCewyApmNAj9iA/8G56JpqpWCRzxR9NmKxGOsERsD8
         WVvkvhhU+vfkX81jDEDGRIJycjafU+CvDxhP3B21HCdiNkXojWJMA6u/U2+v1W+okaC8
         1Drg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778268801; x=1778873601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        b=boZEVMj8RhGvjAkdwEjwq5DtKyLdb9sXKJONA4I5PbKTihIXgsrRXpNDO8d5NtFw/5
         hlrNB7nLNpOzjtWGfzvMjznhLPmDGL2sRWh3gMOrWgWser5ZBcsI5vUJ0rBok96sFnSH
         AyShRTK0PZxIy5aKMQetKrJ23HQjckcDYNwtOkXbRt3nuBIPLh/U1TgEwZ10aMXTusK4
         YNr2sEBFvgLlNSXvACQCrA6OlSh8PaASTxrZSGA+2dsA7PDOqGba7h0qv/gDyHMJ/wA+
         kcvJ1ZA84TT0HTIihx8m9tcA6/7AboezqcaLjtmCiyubuBEYOCTszGtDeyBhkTDMjvuc
         ETYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268801; x=1778873601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        b=a5RaWNKYhN05BNCRy9P2q7QZzOBbZQ0I7Nt+/jMqPWNbwtbn4wE4lH4ZaeTFT3GNOl
         YlTz0uuuJJlCqwr/iYygo3mBqq+Xf0GKTSG0yrbB5P1RLE6CZe213Herzm3CNMfIP5wh
         uuxEj+m++WpV3t5BUbecuR6c8glMQlVeXJdm407s7Wk8so6ibtAHXIXze+vEg6xMY5uH
         2imCu0XmGOCd49Xtu0AfNyM1GtV+lrFkuFXvAm2zI3KY5kSSsvXkVigUnWupmGD6zT8Q
         SaeYXV6wXMHlIASPEaapaeGSHJ/ULozA+TxvKUpZWc6VSwSWHSJUDflqHuE+oqCDIvKW
         Paxg==
X-Forwarded-Encrypted: i=1; AFNElJ91sN3ZKMc/MGh9NQQhkGx9gTjFqbe88CJDMB1oF2MfYBCN8r8WtNTysI+fIqYqbL+sSn8VL2zlJr/i@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6mhTCSp3Yc8CVy5zLy0wywnoajGQ645Lj5DEbyV62ugiIcfHP
	WUKwGEFwETXA5kebh8+wSrTn8QhopDlKZQI55K1dG5IYYnu9rijGwU1VUGjwp7uNzW7VqUheEJE
	bGK/3won4EO4ez+97wSlvsDQQML06olY=
X-Gm-Gg: Acq92OE5ffmKYrn7oAyn8EhCNbtT9YQVHhT/6zC2v/5ITVO6/wvTNuD3UIgXkCwBR9N
	8QDF/VVgQ0a0J5eSa1HpN+YnctpGU2LlUYn7D3j6XeH/HCYtd37GOBdWvk8kPxFcCyDSj7ytNSH
	r2ylLROqoWtsNtG/01U4n+iuMPRqo5oKlnBXGLeIid3FhInxrPmK1hlGmjgi4SpZsyEVhcdmxhK
	qWT9G3Re0abZCdjHzVw1i2KV4fFiXbyAmYR4ixIoSG7wFQKzRAtdXLryBtMXZoTGCF3tw22CBBh
	A2UCUxAzNY3ni/IoO0o5p6jKO4LbpS/pdIYN0Nu6CIcuq7TqDs4Ug3OtvAqrdg==
X-Received: by 2002:a05:690c:3482:b0:7ba:eefe:9f9c with SMTP id
 00721157ae682-7bfb93b91bfmr36362517b3.23.1778268801312; Fri, 08 May 2026
 12:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=B2_Coccia?= <n.coccia96@gmail.com>
Date: Fri, 8 May 2026 21:33:10 +0200
X-Gm-Features: AVHnY4IhlBncjhRtEcRWNeScfK7pKvEfB82Sn4DdDRYZUjuTlbimERLOeRjk1Nw
Message-ID: <CALSA8UaEKUHRqYaYqKFYbUQb4KHipDBDHfgMZHj2Tq0D1Ah7zw@mail.gmail.com>
Subject: [PATCH net] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mjambigi@linux.ibm.com, 
	=?UTF-8?Q?Nicol=C3=B2_Coccia?= <nicolo.coccia@leonardo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 514684FB2F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20261-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncoccia96@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Signed-off-by: Nicol=C3=B2 Coccia nicolo.coccia@leonardo.com>
---
 net/smc/af_smc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -XXXX,X +XXXX,X @@ static int __smc_setsockopt(struct socket *sock,
int level, int optname,

  smc =3D smc_sk(sk);

+ /* pre-fetch user data outside the lock */
+ if (optname =3D=3D SMC_LIMIT_HS) {
+ if (optlen < sizeof(int))
+ return -EINVAL;
+ if (copy_from_sockptr(&val, optval, sizeof(int)))
+ return -EFAULT;
+ }
+
  lock_sock(sk);
  switch (optname) {
  case SMC_LIMIT_HS:
- if (optlen < sizeof(int)) {
- rc =3D -EINVAL;
- break;
- }
- if (copy_from_sockptr(&val, optval, sizeof(int))) {
- rc =3D -EFAULT;
- break;
- }
-
  smc->limit_smc_hs =3D !!val;
  rc =3D 0;
  break;

