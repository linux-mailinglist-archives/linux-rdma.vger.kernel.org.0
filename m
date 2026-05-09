Return-Path: <linux-rdma+bounces-20286-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BtNMQkU/2n/1wAAu9opvQ
	(envelope-from <linux-rdma+bounces-20286-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 13:01:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4844FF70C
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 13:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8EC930074F5
	for <lists+linux-rdma@lfdr.de>; Sat,  9 May 2026 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBE3750A9;
	Sat,  9 May 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAeTUw7R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1288338910
	for <linux-rdma@vger.kernel.org>; Sat,  9 May 2026 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778324477; cv=pass; b=Y3PktnPtzf4Yyw6nOXRAGXeH0MZ4cxDyTQ6mT0WAqZzPPL1MGgpm7DRwsW/rsZ8gZdW9IhCYzGQMIlUYMWKNZrpE9XSkbMjkqJagZfEdMyvPuSxmsSWqt+9U8qwMj/83CklFFdOGyquD5yaIVSyCvUcL8QG2ecJBg3LcEllMTik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778324477; c=relaxed/simple;
	bh=9zJ/Jp0AIo86B4ZPDMd67viV7ao0qHIhk0miTEb1P1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HWeyJw9n7UwJahv+XDmNLBhADY2QX4L3ZWnYVMdOqh46iYTQtONsVOcq5uuY57X+zSK2B/eChCQqfnNLLo7iWESsF2X+yPKLgPhjnr0JF6h4CLhPZ89FamMvrz7MraWzJY6gvWbzmxDtWpc9CVCrKTr5w1hI60W0fqIFG+o9tss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAeTUw7R; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so2734397d50.2
        for <linux-rdma@vger.kernel.org>; Sat, 09 May 2026 04:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778324474; cv=none;
        d=google.com; s=arc-20240605;
        b=bKlNwuBCrxu+SS0Ql3GGJ6YG55AMouqtmK/YKUGCdyv4+w9tjo1AjoZt1/deM/61Mg
         1WzbQ90p4/N53wBj2UN8rj6ciStVXh7ucTKc2xkUnTzskxrZP7Ci45mAZ9NB8O9CNA8B
         dIn/LURJ1FfVtFh17I5xhn98/IR1Me+ZxloU7dYAH9qy2/B+Zx69D8LBa8+PZwUrfP7n
         WONsnUJZ0KzX/hedBAH2dV5aBAprlq2+U7qqThA3mXrp8wzWsAYkuDJkdR2i8NlXcExv
         6kSUKNvcMgUnWZUbXggpDDPugBGBBGGK1Ladne8ltUS36xAqtKtwNYRaEC9yUIhtjCm8
         6+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        fh=wmRTM6gTRMjMSrRsJYj/7iELEIflK0UNzycFx1e/mQ8=;
        b=aiaRZxyKrlk+lBNxo9zIGLOs9rgqLLrbAPIszhjaJfBTCP4dfCM7GDCFVBJloVCgTk
         QaIQOp2dHGtGsxj3vbmkGRnp/rb8woR6VhVymlt7RG8uqRif7Vf39GRxEDERRdUWf33z
         FRpn2gLY+Uaea62beVdAIIwpicLpqYpTMC+pgfES1cs3hcxUywUHJs3ICzWEx0lNUhBY
         00XwQEsGJD01sgqfUth9kwUlPslTGj00yUX+JOQpjjWIMqpW5kyDdngo2V4zlX0xbeV+
         aVYy3y4eV+yi12tkQqeEy2+M+0WJryWvixGKVWGMquQPgYb082SBljASZQAyuV/fiUU4
         4Fmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778324474; x=1778929274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        b=YAeTUw7RdhE+KGH22BJXrVVDLE+iBu3X6MApbDMeMbMfUJF02/AgJ34216Ad9y03mg
         3u5h8QCUUPB7Jd9/v2hcH+R/gGBrPzSSkCXXt1n97Z5q4+tHorLGWCAJvEG9NxCdO8we
         uvI3POV4DDGpHkNM1Fk+LiAiIh5GTc78XpiD0h2Gux1jHC/oIxf0Y8hsRR76aNLKgNfU
         YSRTIhyRfg/jeROS7kWvfn7kXVHfmbs5yY2POhy/Qd/QW7gq+daGRS2OsMRcJmey8hJE
         AEImZxhq5gLKFoId6lAQw3XfTJ7M9iMELP1gg7dSPKiRIbzeRQOngIUyxQ/ewtV/PJUv
         Ah6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778324474; x=1778929274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        b=ZKLkWQLbweQwLGqEFY5hUYN/tVi7KUuq4QXjItrOVHQTvj7kmFKMriTUiXj6SyNAXI
         o9as40G5dGeVQA5FxlnQH29jHbwnceqjK+1YWVrChRlsDG/9TjdQCFyTW910PMFXAqsz
         G+AIsuoXG5IyZsGpiqWiAAvhGTMxTDdgoYB2R4kM4OtJGXRqifslVNjm4q+QDz/0cYYc
         LDUjYwXXcYFRC2YIjrb7JOTtZfE843YFJ4d7Qe7Ot3oRAwDXvMYudcIYyxG64ZZY/2Vl
         oJGUrECuG7SWoKNP8Y3+K/XmKOuVuqBm9cheOhU/YMCazlK82PJqoX8f5kO9ayzUR8g6
         ZLeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+D4K30D+3USie6U+h0Rgkd06SDlgFnzBMgeix2AAHppPdtrY5PEx/vGFd+/Bgj0LOE8S8beQwjFOQ7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Xy3Z3my83NTxYTY/zX5g3FO2basenucUuuKxuOy7DHLJ4XUw
	YPaJtP34+TuRP7z6IL30eSYdQ9lN/YeZTlMjG6ZtLoSiGo9h/ibl+1pIosNh3icnoNgNFTw3T1r
	rV4Exw5OisfkEQoQEX1/S0Rk/CuLiWVM=
X-Gm-Gg: Acq92OE0+3bduJIVWGAC6VvWXDeEUhTdRY8hSeQKdf+OA+Bd+H5vTkmF31/62ZVpwRy
	56QN6S+2nwEWq2Ime4YjE7b4D3adVhTSdSnoQTFdc0S3ZntglMrc68FTIX9SC88TyqNi4pNaocE
	Lc6t6ASevODGvDPcJoN++i4DQV1g85TRgU/CT1TGGCv4wPDjnDiDJGkz4Qlh+GEdvEHLEGyMZLS
	C8GOXJHLSNzA/avPq+JRCHglCnhs53ATssJRxI2iTRMUHmcGMM/kq+pIQluAJ8XrRuUExv2XXJ/
	cRt/G5U=
X-Received: by 2002:a05:690c:e3ed:b0:7bd:6a98:58e4 with SMTP id
 00721157ae682-7c104bb091emr20425757b3.27.1778324474394; Sat, 09 May 2026
 04:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=B2_Coccia?= <n.coccia96@gmail.com>
Date: Sat, 9 May 2026 07:01:02 -0400
X-Gm-Features: AVHnY4JmYlXDKdj4Xp-aA7FtSfefy9b28FYyhJ4KqsK6_4gIiVDKucQbACylHK8
Message-ID: <CALSA8UZaE8FR2K-60fPYE6uSUvUNuLnH=8pPq0Hak2ADQpp1Qw@mail.gmail.com>
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
X-Rspamd-Queue-Id: BA4844FF70C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20286-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by
socket options")
Signed-off-by: Nicol=C3=B2 Coccia <n.coccia96@gmail.com>
---
v1 -> v2:
 - Rebased against netdev/net tree
 - Added Fixes tag

 net/smc/af_smc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 185dbed7de5d..da28652f6810 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3054,18 +3054,17 @@ static int __smc_setsockopt(struct socket
*sock, int level, int optname,

     smc =3D smc_sk(sk);

+    /* pre-fetch user data outside the lock */
+    if (optname =3D=3D SMC_LIMIT_HS) {
+        if (optlen < sizeof(int))
+            return -EINVAL;
+        if (copy_from_sockptr(&val, optval, sizeof(int)))
+            return -EFAULT;
+    }
+
     lock_sock(sk);
     switch (optname) {
     case SMC_LIMIT_HS:
-        if (optlen < sizeof(int)) {
-            rc =3D -EINVAL;
-            break;
-        }
-        if (copy_from_sockptr(&val, optval, sizeof(int))) {
-            rc =3D -EFAULT;
-            break;
-        }
-
         smc->limit_smc_hs =3D !!val;
         rc =3D 0;
         break;
--=20
2.51.0

