Return-Path: <linux-rdma+bounces-22817-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIPRFevaTGriqwEAu9opvQ
	(envelope-from <linux-rdma+bounces-22817-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 12:54:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C371AAC8
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 12:54:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=PGqb7fNJ;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22817-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22817-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30026307F363
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D43C1977;
	Tue,  7 Jul 2026 10:53:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753F3ACA45
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 10:52:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421584; cv=none; b=WeSqC8na4iegyVxTMktCaV/OHKw3aIXi7Jr3Y339leHSLtWvCcwCslMA9lNzBw0XUXkF/7G70YdH553+JdSzmqRHG534QlwUxKfXyr7r3A2JJbYX1DWAzoEYzAhKT0O268ASMsMJjPIbcE4SEFE55oWrJWdzwxAdjd8LAtwpinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421584; c=relaxed/simple;
	bh=P8Kwl9xspylCUyn94HEtRD7Ke3PQdZxuCTnfVWCsoMA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=G8jBqQoC4L+9QaqdKWVUBIzLJCOmq/7oAtBoW2ktmWOkqkSRUMr9z8AjNaOsPA/PAm5uBIgC1KyneIkaM9cZJ8DozaUp4OQt3QRcmSFuvCX15fF/r46e5QvGi5aZAHySQN9hxdJGrYinVQnBy+RjmAmBIE3VC6m5gRKmNRGbz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PGqb7fNJ; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47c2ae992beso232762f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2026 03:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783421577; x=1784026377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:autocrypt:content-language
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YvNq2C6FQIRLKHhNJAdfRtbq01JnpKA4Yt4kOrUSkes=;
        b=PGqb7fNJT8WdPcDIefPWczMgBXOK4ECSqXgWi2kTnKx4x2y1r4SL4OUXZyB7mB8iIj
         mkM1WF/cCJYpFgq4U9v7g40AV7EmX30CWzrfV55KG8wqzOwfgnvLlT+9F7jDLhYkM64x
         8qtLa8WCN4atBRK8dfqpvvT3wy3Xm+h80Tplo6peJgb4nk8qpwTxfn0Hvsdr81Gl7K/v
         e/TsYYwI7YFnrdNzmaOlqpndvifPaOoUM/gcJkxa1sweW7+cTUk+MVfpiadlsAdSxeql
         QoYdkzCOULcckw7WaZsq9Vo0aMs7oD0bpMqD3dr3hRXXG70vCVdWo82wanU+5mKW5Ss8
         xg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421577; x=1784026377;
        h=content-transfer-encoding:content-type:autocrypt:content-language
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvNq2C6FQIRLKHhNJAdfRtbq01JnpKA4Yt4kOrUSkes=;
        b=orvqGgZV4n7k9kT2wopI3fqE/ZFGh/9wHd7fwWO2KgidYfeXJ0uuyWVs3G7N6l5JCr
         wobbmfO56VylcfDWzb+ffkqnYGX8Zezs/wlPThYFMe4KkaRGqUzdRJe5vX7ErxXHZGjy
         cm03Dkswx8K+DxNw1+CWAaKiesr6DL3goQla2MTd++RfP+qC7MeGo08fGGrLWuf6J8/N
         hgIXP0aNRrc6rMHL1G4Q4v6zOdbrMID7U8eSff9FrkADzgrM1GaeDY89zdH3JqSvoEKY
         tUk5BMbO+yLj2PMDGPOmykmtFlhkQNWYcG+YYscB/eeIEAefe1bcovmEsMxo0pFYkU5T
         vxbQ==
X-Gm-Message-State: AOJu0Yy9sxy3nHx74QtVdNjByxlBYB9l4au+BmgLrH9RzczxfZznt1gu
	IHIpfL4QuELGV/j3rD0mJNpT+2TxogOVepi9J2u3ulDXu4303LLTeGWsyC3Ysdqh5HNPD2Z5MeF
	NsGoQdGc=
X-Gm-Gg: AfdE7ckToDgBpAWgBnKi28lRvxtaNbXGT4rlqVuu+j0jvb0GbopBWjjtjHo832U1LEC
	+iJWDWWOR4jLpFDhzp93G5+sDdz9d6ORRc8zSdAYGn6pwsWl5TJOv7ppM3RGB1F1Ofr1MP8JQO1
	AlXqSrrUCfeRPsXCJZblP4SZ67XeBS+a1l5CPaz3UbBBkSfHsK4iTi/ogkmwkAF0JgMFb7ABrax
	ou8bMNWxdUquOHuyMTvn5rmI/CpDmWgRdzlb0coLNP1Tnf0Bq8q3IuPwkK4elzlJ3qSU87dChxe
	OsvCUTXJDzzJoy1+rKHVOauGg09lpNyMIYw2KTigXkROt/fHsyUDIC1cw1FfKweqF6rGCMevHGL
	Jq9S9xZZcrFPxOSSJ3U1qYLqws/kcv/tyC+XCnxJ0VEEgiu/QUd2/nt2rSFmZwQDhb2dqTQLBSQ
	kxs9yBCRO7ZLb5cVXYV+n1kJhT1CvCvaDAvIWJwMqVHur6TqLcGQn3q6Lq
X-Received: by 2002:adf:e18d:0:b0:46f:7d90:8124 with SMTP id ffacd0b85a97d-47aa9d653c7mr9603121f8f.2.1783421576959;
        Tue, 07 Jul 2026 03:52:56 -0700 (PDT)
Received: from [10.20.0.128] (lfbn-ann-1-199-252.w86-200.abo.wanadoo.fr. [86.200.161.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960b06sm32129272f8f.28.2026.07.07.03.52.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 03:52:55 -0700 (PDT)
Message-ID: <35ea0291-d319-442e-af92-725c1028d478@suse.com>
Date: Tue, 7 Jul 2026 12:52:54 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nicolas Morey <nmorey@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To: linux-rdma@vger.kernel.org
Content-Language: fr
Autocrypt: addr=nmorey@suse.com; keydata=
 xsBNBFjZETwBCADEkoe7QWAXzd9xpSiPbQK6P2F4wKdxyTp6r0aN4I0O+4fc8xWXvmwOrCjF
 UsuoGZ3CxJaHgdB/3ueW/IhMO5Ldz7pylhKVlG/moUh4CBK2eRUdaG7mHID01GyJMtR3VQqu
 22hJhHPYy0erpYViyr+I4MzQA9QZLoQhSxn4imjZOZPcj20JE+lRfXppNv9g7vQiRLMcXjTi
 KcnrqG5owOi6Cn1sZ201YfdeztGxKA+jvjWO+6absTTlorIlZNGUf85s2+caGDsqa31u2DPs
 hVv5UUTy1g/5aP2wacSWI3Qm4n2MWl1aCnHN2h737PCXXfBk5iGJsgBUnSQULgdgEAt1ABEB
 AAHNH05pY29sYXMgTW9yZXkgPG5tb3JleUBzdXNlLmNvbT7CwI4EEwEIADgWIQRC0lOFwaHA
 K4sbHG+AG924JZiPZAUCY5G8SAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCAG924
 JZiPZMZiB/9QkcGfH248qvFUWZig3jssK5IgijfOFDKB0YK4e844M5C8LVSuWpu7Z+lM+cql
 3mbrikW6mlZjPEusrQ/KGvT6TdfOM9VCQWjlshMzt7uiRDdzufHGtE5hhk/67UnkEVjmplpD
 k8cb1O0VsBfGym7e0nySHTlDWqr++9EcwgV3uo4psYYEqm6Aon1yKqjbmj+vfl/C5iW3V4lq
 DhBk8w21AvNS+tdEqJzhruxuXkEDZZ07wYFS7m8OxLNb4sMzn/Nz9x/NXeweBWx2ujIERtAq
 1e/hh0ZAcoPVR3CfO2QTmfTfrzVdpZrZ8F54337ze3+BUNnrFGObQhlNe26NqNYWzsBNBFjZ
 ETwBCAC9zAzCRlTgzyO9siVLQYwbRUhcL1TUJU/FiOQWQTmL3uDdBc6MgVBs+hp82RwPbbXT
 v4W4rghBYPKdmFXvRN+jvGDLq1f2hsuCSiE1ckTMzFV+sKoWRIEC12tEpw5ncEFGm+1k/rJR
 Lk9eHxuqn+yRjPryN8CK6tK4+b4tZ2urKlP29XG+T3l/mbUSoqfjqvyeKaW6xw7ku89EX2Xo
 QWP/pm92RxUd6VDU9vpVW/T7qPZRl0wtUnDnO2wePoZmvUfEr5Osh3MNvm1myG+v4EV2Hgva
 NT6pa27IptrUq06cA6dDsIKwPtMuThJQp8/xumgl5Q9A/ErQoJTrB9rclIm7ABEBAAHCwF8E
 GAECAAkFAljZETwCGwwACgkQgBvduCWYj2QwNwf/eOIpFB67cKoUJvcm3JWcvnagZOuyasCw
 xwH9a0o9jORcq+nsJoynS/DpjUKGyZagy7+F7sBrF7Xx0cXF2f5Bo42XNNiQDE5P/VLwvgn9
 62AJ3q0dp4O7oQI8UgNmdsocQhNaBHHCoOabLGrgNobDTaLBeb9zaOZqz8CBuAiZ0bVABEpg
 50hDEYTHp4jCgWpadhAsp/eCgm93Tc+Y+e1fqtE3FmoOLxyhFa6evhn0Q1iX0kCasMZwlzse
 zqLZjTM1Koqn6+UIHXE3QaULyFKD1GDhisXxyolOB6P2TXsyfvitYdIZ3CCtI7PVDxzmX2Xk
 kvEz9bMtStoMpse9qAsmHQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22817-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nmorey@suse.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nmorey@suse.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D99C371AAC8

These version were tagged/released:
 * v40.13 (last stable release on this branch)
 * v41.13 (last stable release on this branch)
 * v42.13
 * v43.12
 * v44.12
 * v45.11
 * v46.10
 * v47.9
 * v48.8
 * v49.8
 * v50.7
 * v51.7
 * v52.6
 * v53.6
 * v54.5
 * v55.4
 * v56.4
 * v57.3
 * v58.2
 * v59.2
 * v60.2
 * v61.1
 * v62.1
 * v63.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v40.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:20 2026 +0200

rdma-core-40.13:

Updates from version 40.12
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Q6
Pgf+N4dIWcAtiP+TSwKfKt/lelU8TnPaCynRqUBY5Z5ezPZr9hWxbFfrlKogumji
FawTV1zdziMian59W0QVPO8h9pGFyWSZssDxV9ggAfzSRYZK3c1YSb83eE7EPKKz
pb+XNHmDvV4BjDG9pRCW0H3yDEkscWSaxVwASgNBST4j+VQBHJG2HNp+ZO1f9ZUf
8Pn9LhXUD/mjY3u3hhYwUkg7kon/cC4w2N+LfTSTg9dn15EUGu3pdskNGaT/4JJT
KDzDAgpJIkYLS8RzUyTF0BKHrUudBbMi6eG+Ky8wpVVwJ2KexYdasRT5dMmdtNAY
uAKBJN2EpE3ocLgToq7HUHJ1/g==
=8r/V
-----END PGP SIGNATURE-----

tag v41.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:23 2026 +0200

rdma-core-41.13:

Updates from version 41.12
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2TU
gwf/YOmphWaqJhSWWPqDQDfsSDRHu7m7pWYiNyDtQgkTZEGeW5Efio/C/LM9nx4X
3SUfxpeRWL+ae3DFkLGvxTxqGguHCS2HMvWCD15XbfItuDKu6F+tLJ2CJGOJVJI5
A5AzHUQBIMjNY9T2z/bIuxAyO1adl3vE5htObrxl/35+uuT27dyFuLWJZ1zm9BSd
J7A0ll7+O0pu1NewUuThyxkPWZLVDWDXSl3bEXEkENxoLNUEEONocoSpxE8KyZL7
osBn8QbuA4DeJvWnWz/O13wTIfeIsyOrWshf0xLrHci9VXp7O5Hu2WZO4gwNYz1W
iwVtSFZ/DB2X6BbH1xwkMlP6Zw==
=hzri
-----END PGP SIGNATURE-----

tag v42.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:23 2026 +0200

rdma-core-42.13:

Updates from version 42.12
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2RK
DwgAhxYmPfqqaDcZlq+g3XU4d64hQ8lb+SCn6cs8oteiXgUsncX1P/FH47DIywn7
WtnVGsQad9wVn6/lWmDP2hvkTaqRvAJXHVq3KXpt2fwmPqULohuPStIeuzfVdgmH
oXmORn8K6+V//WXfdhgBFNcNwOyOW4RDOO/G0PIaH1zlVcdkS6806RxERozEFsYy
fKdpRkObFwK6crAC8LsoDcemaJm4f9XMhZZ2RwrywntEFsjMo0TXA+ePd7N48827
BqS4utG0K/4kTOP63rfux5WxN4XLZORSvdAdl6wv8z3di6cnvOo07wMHLAHbEK75
gf+ENmAIrQ80KdcBcAOx/xzipA==
=OCQ2
-----END PGP SIGNATURE-----

tag v43.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:23 2026 +0200

rdma-core-43.12:

Updates from version 43.11
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Q5
0wgAr0RiVoNKjhvB/rMPRE7Hxm15w3loDGzPsFsxdw2ujvbT/IJ/YM9ssWEs4d8P
PccpRrJVD5b1vmF5wJ/0fCDtQM6bAsdlhskzQdOsZ9Gnqlkxbke6LPD7nxCpPQrj
XIXKCPJxZiSnZilfueBI1dtuK610EgRIJgf0JoibSZJKoblmnb4mCTIT5oAoYDLx
8iLWdq2kZh8iwSwgR7N9aG3ATxhNCBfYt3FY0t5LeuMTR4MdAqSt94Q1mc16K601
6SILkOLpHAxSfSsQ6AzevvC/6l6mJZjc1JCMNt3K9kWEyGEr/KWYh5Ar4IPx/ajK
Y7QkTqbozMPVOg3bbRQGPjNDvg==
=ByCn
-----END PGP SIGNATURE-----

tag v44.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:23 2026 +0200

rdma-core-44.12:

Updates from version 44.11
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2St
dwf+M7rkENrXjfASfWgkEtpx7GS75WmMdXWGkmOsn4abuWbpnIpbJg9ZtrJTwgeh
VRhpeoz5/AGdXTw4yI4KdbyjKi0Wj9W1V2rPiYepHYF2rb6pQCHZU5TIkgLndy2B
2XgFDWL1prs9SYSXDgC8JD62/aCIb4P5gwtDtI3KZppqao91LaZx8xHQo/1khbPw
BMpb1UzxbzIVrF2lHGbGATM9dyPsfsPYerW2xtU81VRWEPDTKTeSQUuVOk0M5tNO
xZjrztf2ybUt6tdUmLwV1eKVo3aROadEzzoQUJfU64tKdWYAs9k1xVrA1v5wb7gi
L9hEYrgsXFEEG+ptK72yxGjA9Q==
=ZcPq
-----END PGP SIGNATURE-----

tag v45.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:24 2026 +0200

rdma-core-45.11:

Updates from version 45.10
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2SW
eggAuZk3rJAPxINxnsOafneZzcHLruJnihY7OOnFkPZEJanpnlLGmyoLChsJZzum
Rb3rzzgfoiHJEdyAuAUFKXNoG2Z1Q3ruj1KosIozA0jNSnekm9UAA+eACxiKLc4i
8L+ckqk8ioQSrAtEYb/YT0y3yJ8+r3ke1wOOcl/glz9UuYqD5lg9ifdaQRMRTdnO
9jbfu06/Zhpufs4d9a2mwTjam2V5b2STW87/+/6KtHts15RTR/7taseA5PE4sfGB
wfl7Zdxucz/vvYjHFI2DVfFIgBuTs96UOdPRbyzlboHhGjHwqAo2Z/Mu7IWOAvTV
Wd++xJrih4y/N0vuL0F9y3Q+tA==
=l88o
-----END PGP SIGNATURE-----

tag v46.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:24 2026 +0200

rdma-core-46.10:

Updates from version 46.9
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qp
Fwf/adjwRuU9lQ6siTZelHVHO+BHI8pK6FfY/fFVQCVz6iXw22ecV0m1wSX1ifQa
VOc+1vn1v5zQT0lmfxkZHLP4GK5l4GiUgbnu3OUOlwWyF6FEbwVJ3twe59DzUiVr
WmWphvAyxOv4XCRqF29cl7W1Z55RohHUibOnHedGHW1wmcVGWU2ucBQ/oHYP1GLg
RMEk/oOPObXbTGx8LJ9UoNpoO1u8zEgzlIDPX9dKPdQosPeBhnz12AEGYyV48lii
Hw8jrwdhRYNxlGN88MD5D6gmK4G9CuCzjZ4GfM0Vrz2bF9byhoanQy+7Ejwi8rGj
s2FFaaPhExXjxMcSK4CXGZU/uw==
=hH0E
-----END PGP SIGNATURE-----

tag v47.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:24 2026 +0200

rdma-core-47.9:

Updates from version 47.8
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2RP
FQf/VFqBVfjw1XkNLzZu9nlpMFROHPYRILxQRu1wSwzn0YgMsabu2QzrWUWvOu78
Pb98WaJBqjR+rLNP80E5xDtew9LtJhktBShS+MffRirzxmTaeb8FDH77SP4iSAGB
uzIvW+48MyA/qJhl2oDkLpjfonvE2iO8J2ZtrS1q2WoKbWdIEzQ05M39r0vEQrX7
ZfANLkxXWfjWrhZOIbbkpzRq49DFypuvS0xt4TgG8HI6YaGxl3xlMPhzveMMLKQ7
oaLQ9sZZwVJtYpyT7hw7CKo6RRfjMxI5hiucQ7jLB3BKzozCA+Lk5UAnZ/f2kglG
zZ6kHl+Y6uwkkUax6DnN5qriHQ==
=tx4l
-----END PGP SIGNATURE-----

tag v48.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:24 2026 +0200

rdma-core-48.8:

Updates from version 48.7
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2TF
TAgAhEhNwzzL4LTJ04ExG0iRyS8NVz+1cuKim8L8DgaEK+lA9aIh+YJeZ7ZVcPt4
10SrWEwuAWitxvBmoAg7pjAMSuTPlCnzGPwe6/gCuPqZY6Bh/onjNcagH7OWapoz
GLukrwPuhxffl+IoB30zfBeJmq3H+tC+N/vuJPV/VRtprsLv9YkRaUaFmlKoWrdm
1/YQVCaBFVuEiLHBhJk0NlbHecV4a9obe9WYTShdyHkUXFhdeL/Y2uxG8z4X+SQM
cwVGNEhPcMhGSMlACeXbggVnuuiB9QewZJU+x/KmCJwfDbJcSMrFGEDFODKJc4jh
heQl0NV6+KT7q3gHXbFKEmW4tQ==
=08zS
-----END PGP SIGNATURE-----

tag v49.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:24 2026 +0200

rdma-core-49.8:

Updates from version 49.7
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * pyverbs: Fix compilation error in Fedora 39
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2QK
UAf9HgEhbryNkhQPaMeupQ/HkHU3pVWxAL94g6DTjNsAC5IR2sUTxiMDVLjzA8yl
Z7g7UQmFjy/+G2tl3CO7q/SorBdTG+CPiwamJanaMBqx9eQlaPp8kqYQGUXrAV8I
16NRCiwRTh9n15/Q8l6Bcl4ypkbfLpE9h17FQ3Ct5ToLhfZRff96scBiV7ODSCZ/
KA9XTzPZOC3SjWDVlFfN6cTBzcMxPNp9aET2EyW13vIRrTT2iunX0pCPjet4caoQ
iJgA2C7AhyXIkJQN2LJ4Vdk9oc3Df1+YKxBKyT+YRy7QMsmeitbkBqHa10bcwvqZ
qWHv9QBnaaxJi1AKEeaFnvIEog==
=tpzH
-----END PGP SIGNATURE-----

tag v50.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:24 2026 +0200

rdma-core-50.7:

Updates from version 50.6
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * bnxt_re/lib: Fix the flush CQE handling
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Rb
YQgArHyTUr2/nkm4HfxFlPj/FScoKr+xxFd4pG0y2OWdA+lwM6mg27U33bl1G94b
dYdqf4xpz769T1X2BVNwXXNOwEia3a9Cr0rbE63Q+YevwoywbBudBP4yQByt8JN4
7r8+PEpj9GRUG2YxiXWy4zNb93XuYz610zT2hJ9HURnlzdIJUtEJSJNNAqSH5owv
VzR2oOcW+R2Uqpt8ZyRfjuSkdxFRx/nUGQAD+e4U7tppna/3mRXwShzaj+R6eGIE
/A/kNY7wz0WOxNzaxI6MV3uhIqBa7qRwiqk2DyDngUya+GkMODYtvEW1swwWnY2a
kH6evWixpugaPKIIDchS7uaYRg==
=lmJM
-----END PGP SIGNATURE-----

tag v51.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:24 2026 +0200

rdma-core-51.7:

Updates from version 51.6
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * bnxt_re/lib: Fix the flush CQE handling
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Ra
pQf/YZU3IJJLxmerRTduBIpbuqkbNC0hL3DG7DaXr91k4gTJWrzUZeujld62CDk4
Ger5rjdMlqQ1koJbJQ8eZClvPATk5QiS8CAPjiLoiburDNROzUaWCMYZ5n3tzP59
a0h9u5i4opjihSK6ZkrFqnXBTEx+kOEPV2K5aR7zcLjaXAIG3b93z3o3fFZ3fTKu
N3V+yxN3I/0qknV3iOKVC1IkOjSSKCSVUi9gMb212mGjxo6uy02TrRcbQkMih6E8
+6TEFLno31Z1OyfbK8VvqEcd0hqBEmTePQcvtTFG+R+qV1bYycPNGteV3wB5rhOJ
QNZhDAcEVmHyigOCW7w7ATaMgw==
=iypc
-----END PGP SIGNATURE-----

tag v52.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:24 2026 +0200

rdma-core-52.6:

Updates from version 52.5
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * bnxt_re/lib: Fix the flush CQE handling
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qw
cAgAjMs6z55kV8ohypgKCyKGTbVlKfcydZtzS2641JfrLpDu3FXtxiLy0hrPHIIb
PfVZI70ayQZxRXSqwHsNQEyve0fIfVCV4Hg7ntOv+9aQrngQe6zhF2LA1KPxRxff
QvbXaFBj5mS/HtmD3LgJjhk7trqNASBvaqrhLy/8H8uaKlJDauB2n7rkaIfwKDTO
4C4nklIlWmwj/p2M02mzNZ+J58QTNncHvoXFUr+j3oGkgq8bZRTZ+5+/aU2u0GiB
9C+0VIgXRaFz12Vv6dwYJLXR+9O5810NJ7ThNnrMt2WdD6zKULd2069Siwhg4dLn
xnm0TALVibM5bU93SLLASLOF6Q==
=KBcc
-----END PGP SIGNATURE-----

tag v53.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-53.6:

Updates from version 53.5
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * bnxt_re/lib: Fix the flush CQE handling
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2TL
ogf+IlYSJ9ac3Wdh9ol8d7AmlBonU2cGDXBFszUIyfWKTNEQ7Esi6IibnCsRS/uy
to3MxXjW9sBswsJE+EzMQSDpVN0iJcz2tBTtJnFUJqpDtJxpoJ9/DIDh46jiWPEi
L2n4MyjaWKVNBGsbNwL58y8cf8ImJ1ppTthbXMnHYhvKa2izm6hPpC3XK2r9qHP8
lUu+jgM/su1urXmxSQzEMD9hG0MUgNdgoTEZmHO5Rwfk5E0M5B7d1Vo4xSuESOhI
YAtc2t+qwsNzk3UGZEIIbllxyzziMYsLr03bAxtNTkJ5OW0rT4ly9tObE8/D4PMi
G6/5hLLm8CgRXJDA1dObkfPDBA==
=4sIw
-----END PGP SIGNATURE-----

tag v54.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-54.5:

Updates from version 54.4
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * bnxt_re/lib: Fix the flush CQE handling
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2TL
Mwf+P09h7jm/ON2ghdyiG9ceeaDUUNVPRE7yfn/FFy5Cc1NrNIBxbYpZDk/sRH5f
EStfWb2WpxCvMV0G6zwzB+53ImJ6FyXBw+WPh44k7nAk0zNpeH+DN0G0T5Dhpcc9
/8zm9ZadV2pXIGSUWMLFWTg4g0nw2tVUwjRdktppq7YWtRzhKeKxbdNwRfV3ML4W
aAmNBuGerzEr0TA6A7sbWlNbqy59oE4DC9N6ryevd8793mPeGbLSwi1z+R1aGCEo
Mf/YRCL5k0r72BlS1nb/4JuCBJO9VnsD4Cqz8k9bbOuDkfriunWUNweZXL5kW+Qp
OHgd0pmcPUsOpQafQJMYFh69mg==
=BiiC
-----END PGP SIGNATURE-----

tag v55.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-55.4:

Updates from version 55.3
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * bnxt_re/lib: Fix the flush CQE handling
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Tm
7gf9EBdFbjYH+1MFdn0ONO8hBZwdu3XJ+15QqLsFrPLADERwVeQcZ2fEaX547f4s
LXtoZjYFT+bLdAkpM69bnEG036RiEDsirNPfOAdoO3NAmh6Z5OInDoz6REJkDbHf
PPtLM1ZB6tpoHDib0upcKJeFveod6QJy97AssauxnL56uR72x9qnSBc2Ft6d1+E+
G93qL9+dGaWZnjvoB/Z15714vQlB6CfiGv1e2wRN08cnnUN9l/dGUYPCgn7Tok6S
RqI8mXtLFzD2pXuRXPiocDqDg0TMWx4kjACSjBFmRL4JvKv1gq0T/c45g4kcnD6k
8M9vpSgUqzkmuaLDLlkgtGm3eA==
=Uv+u
-----END PGP SIGNATURE-----

tag v56.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-56.4:

Updates from version 56.3
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the flush CQE handling
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Fix memcpy size in bnxt_re_create_qp
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Sf
pwf/alzY2D7HQcsLxEvrkW8u4EiKUtJIKZEcgNDeN0VtG9hPhXf8bwpYyoScB24P
/kih2t9W5fx6Aelu22b9147MIvsI4pc5WzBPcpj7/1ZJ/7kmzmAGJrQSXTsN8vFF
KLEXZsuR8tWENCcmrZf0OXSKxGeHsgPgLeG1XeQoENNvOU+0jtY6xEN6/rGvTwLj
zQrjzYnAYpOe/WT+HGdRkOx7YNLAnKUelBvawu+pMUc6kW0yfxJWO+UAOyjuFrD8
B4XKVgC/X0RGjsll14glGXiccG5iJ6a6qNJUqJVykZ/p7Sv9ylcwidKumWz3DASe
952lxkSgTGoQ3CxP6aXRCyP68A==
=Yc+S
-----END PGP SIGNATURE-----

tag v57.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-57.3:

Updates from version 57.2
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the flush CQE handling
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Fix memcpy size in bnxt_re_create_qp
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2RE
Zgf/Z19lvnbE7UDuo9jVEcozvpGw6eCdaq703Ul0ewjFooKY8/iaFHZgLgCXke/K
e9uHyl5LoeAgoUbAP5GD/DfDXlmudwlW5rUcFztDAIkAybPL3ACoW2UJEVhUXDPa
U+nB2wuOlOmB2dXpng2dEVkIWl7TvgguUromOe8aeVAwo7t+Gi6Qdk/FRMeVu4F1
I4Cp+4Xv6K3YP/vYZ8RLrCFK1tJGn7Ymf4H0FynZubULunzaOjn4x3IQqSYZmaR0
eFY4XWM/HgyI9P4XxpmNDScjKJMjuIM77OnCpF8A7UqVTnBhvmmvJBJ3LXje8lbo
SIc5KgDP5U5+dnzKXwwknMP1Lw==
=ErPZ
-----END PGP SIGNATURE-----

tag v58.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-58.2:

Updates from version 58.1
 * Backport fixes:
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the flush CQE handling
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Fix memcpy size in bnxt_re_create_qp
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Ty
qAgAwEP7SPBmUXvsMC+2PzNea4ngTHQsp2I7BmEYo8IEt4yW+ufv6UHA6AG9vywC
4UM/9A8f1aG71STD61ScqZtuH1qn0bllra5kFLE00NetmmrSFIq7iw83Y6idwnmA
wIM9YinPwFQ9s2PUVg9e7M3TCFmunp96eS0mZ+HqyTsn/YEZ7cVZ9maGB/Ajohh+
zKE1oEGgcE6ExneBezI8PBHXhOS89GgYIrceV1sFDCUzQXtveSi1zHzKpprM7o1x
zEaFmMLmEhfcG5Njlslnms3jHBQpchmWhXjy4oMRpHupZ/0aP6WrfdZupPP8zNWR
SDBNEeebh5Pj+Q7g4wlirdqSkw==
=fpja
-----END PGP SIGNATURE-----

tag v59.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-59.2:

Updates from version 59.1
 * Backport fixes:
   * libibverbs: Set vmr->access in ibv_cmd_reg_mr_ex()
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the flush CQE handling
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Fix memcpy size in bnxt_re_create_qp
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
   * libibverbs: Avoid memcpy from NULL in fill_attr_in()
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Tt
tggAggfxh2GE1JjsvC258XSJuy6dpByNdOCMFI6SLKCkKicf8U9v7xDmWP6ms3dq
E4b+B/eHhpGgU8ps2SA9g/JvUJ0lKwQsWX2/IlXGt4gcKfAX8hdT8SWduVNqfQRp
68JpXm/zMA3ZGfGHud1PbFUvT38oWPDsOb104k0E609zGctof8YTVwNAgiQ858hz
jC9BMdlYRwXSH3ZBjXV5EpuQOtoPBFT7ZLzQlH//jxXeBzK+iYIpJVDmeF4Vybi0
OU3tZrFUyh/aKGmh+2gy74Wxaav2vQFDkUgT4wpvoYH2yllhgBt+guoPzPpWJE7f
il3XWVQSzFNCp7QicRIuX2RNsA==
=J3oJ
-----END PGP SIGNATURE-----

tag v60.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-60.2:

Updates from version 60.1
 * Backport fixes:
   * libibverbs: Set vmr->access in ibv_cmd_reg_mr_ex()
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * efa: Verify QP number on CQE process
   * mlx5: Fix byte_count type in umr_sg_list_create
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the flush CQE handling
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Fix memcpy size in bnxt_re_create_qp
   * buildlib: disable symbol version check
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * dump_fts: Change lft type in dump_fts to uint8_t
   * mlx5: Fix mlx5dv_create_flow to keep legacy ABI
   * libibverbs: Avoid memcpy from NULL in fill_attr_in()
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2Qx
1Qf/YCQYMEkOkDSCKoi5Xx/xBfBiv38WXwu5vK/du9kjG5FqGvCpEy6bU8I2ME3p
IpxdanBE6HbLngPIU+PDczEfq8C5N02iQPOoLW0dSFSx3LFhDsXRPIgn3NLFv7mA
m9OrUHpwpCGBz5XHHOOfOvzeDM6w9EqxHUnN8y9Bce2CrkZOCNLB/DuP/qae7SQM
P0038mVyVC1Xy6M7+ik7j1EARzkUJGgsNKABD1qfP0IvA3uBa7jn75VIOhcnwKe4
yaa7IPWf2xW25TkJFxpD6+c2aU0Yv6YmDJQeuqLX7U0nlaIormJoSGL5F77obnCI
Jxm90mm+dSKGBToVvRKaX6V4OA==
=sMso
-----END PGP SIGNATURE-----

tag v61.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:25 2026 +0200

rdma-core-61.1:

Updates from version 61.0
 * Backport fixes:
   * libibverbs: Set vmr->access in ibv_cmd_reg_mr_ex()
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * pyverbs: Replace WeakSet.pop() with list cleanup
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * tests/test_cq: Prevent CQ overflows by introducing a delay before resize
   * tests: Fix memory leak in test_mlx5_crypto
   * providers/mana: do not check cqid on creation
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the flush CQE handling
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Fix memcpy size in bnxt_re_create_qp
   * buildlib: disable symbol version check
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * ionic: Honor sq_sig_all for signaled completions
   * dump_fts: Change lft type in dump_fts to uint8_t
   * mlx5: Fix mlx5dv_create_flow to keep legacy ABI
   * libibverbs: Avoid memcpy from NULL in fill_attr_in()
   * debian: correct symbol version of new ibverbs 1.15 functions
   * libhns: Fix CQ clean when CQ record doorbell enabled
   * libhns: Fix wrong WQE data in new post send API when QP wraps around
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2QH
PQf/f9zmdSLs87S9yIaOLC5ndErImwjfvYeHzJ3i+NIdYGb7eD1Bncx3hLvwerDd
4sYOw+GxZvEL29tSEuDnh8D4HTM0ER0MBJV1goZMY6R+Ho8vY1abWk5i4e56FWfG
SmLyzu3rT/joXGrZ5SOyTW1svn1+IZVXpF4Ey2erT/ueRsv52bTsnVIskoWrX/RX
BVkyGjttiZOBKSbad1WXNIax6KtGcIiimctH+g2dwGg+M6MBk7nVgJkRI3Bonilm
vve7KCae8kGgF8kQwTfpf/T9YcjU1ioDkKqstNcj/SuSAbPdVC6S5AAQLxZyRUEM
LQtGHm08etlQFWn9qNKUqYiM8A==
=ckO3
-----END PGP SIGNATURE-----

tag v62.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:26 2026 +0200

rdma-core-62.1:

Updates from version 62.0
 * Backport fixes:
   * libibverbs: Set vmr->access in ibv_cmd_reg_mr_ex()
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm: Change wake-up timeout from rpoll
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * librdmacm: Fix rpoll in case of timeout
   * librdmacm: Fix rfcntl to keep fs flags separately
   * mlx5/vfio: Avoid warning for unused count variable
   * ibstat: ignore non-RDMA endpoint devices when umad_get_ca() fails
   * librdmacm: Add rsocket to connect service on success too
   * librdmacm: Fix select function
   * librdmacm: Fix SOCK_STREAM and SOCK_DGRAM types
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the flush CQE handling
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Fix memcpy size in bnxt_re_create_qp
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * ionic: Honor sq_sig_all for signaled completions
   * dump_fts: Change lft type in dump_fts to uint8_t
   * CMakeLists: Fix LTTNG trace build
   * mlx5: Fix mlx5dv_create_flow to keep legacy ABI
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2SE
FQf/RsojpeGICKoJ876m7OYcjCHa5W79g0px+zDGNXkZ1LJmd2+rwTFnXYO+TO6y
DsKBTYMwrPK+UaNQNP7vJX89FykZ21ybIXdszqpyKVvWJYQfwwDL5R/0Z8YUakes
mh+T2f5blweAtrfJASqKCip7sKya1m577OCclU4nFjcCZUbd+YMM/cHzVCgIm7qu
EC37LjnTvMnUGOu+ysmiUdSbbOQfB+/pVUp8fSSUZcPDCp2Dtgx4+YpDNp9YL8Ms
3ZIcy8S6OEo79bJZrBrLuAKioYgo55kLm9zUA01JMMHMgaTXJozmU6WTKEIPJW6K
2yBMqsyCmTCIq5UZOnuYskOs3w==
=+SsM
-----END PGP SIGNATURE-----

tag v63.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Jul 6 16:08:26 2026 +0200

rdma-core-63.1:

Updates from version 63.0
 * Backport fixes:
   * libibverbs: Set vmr->access in ibv_cmd_reg_mr_ex()
   * libibnetdisc: keep cache loadable after port timeouts
   * libibnetdisc: guard against NULL remoteport in chassis grouping
   * librdmacm/preload.c: fix duplicate LFS symbols definitions
   * rxe: Fix dma.length computation in wr_set_sge_list
   * util: Fix node name map duplicate issue
   * providers/rxe: Avoid 32-bit overflow when validating inline send length
   * providers/rxe: Fix missing length accumulation in wr_set_inline_data_list
   * providers/efa: Fix build failure when LTTNG is enabled
   * libhns: Fix UD 0 msg length err using new post send
   * mlx5: Fix inline-scatter source address on 128B CQE REQ completions
   * bnxt_re/lib: Fix the flush CQE handling
   * bnxt_re/lib: Fix the num_attrs used in bnxt_re_get_toggle_mem uapi
   * bnxt_re/lib: Report vendor_err as zero for all flush completions.
   * bnxt_re/lib: Fix memcpy size in bnxt_re_create_qp
   * bnxt_re/lib: Initialize the SRQ request structure
   * bnxt_re/lib: Initialize the request structures
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFgBAABCABKFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmpLttobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEBxubW9yZXlAc3VzZS5jb20ACgkQgBvduCWYj2QB
8gf+NUk+cr8D3wY7jHfpq+oS/MJN7Uij0/KpARXYUA5KLTBg0z7CcwpMoe/gftgx
lPkyFYZymc1WWy4Y5NVZ+3B9EaH1MycNYCJDBxAqfCD+HAok/QmkBlc2eLOL6Fts
obHo/9wnAw86DRilHJT05v3Lk6JtJwip3IxzmGGJCxI+UzXr53Ci6bGbpMXZCjgB
YWNOv7YcSMEQkx5vQS7whaxj7Ki+TKWeT5D8Sqe/k3xOArNwrBm1hGaHFqRMjIo5
yoaej3okm5oDORgRQZbA8eznpnIXkZZzgJU6sDU+2WQBfamfR9I5RvCpbJe2JDSd
EJ5E5rHloOQMwfaUwADu9dCNhg==
=uDXX
-----END PGP SIGNATURE-----


