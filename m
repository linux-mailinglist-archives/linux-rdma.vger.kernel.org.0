Return-Path: <linux-rdma+bounces-20597-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNgCDJ26BGrHNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20597-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:53:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AC7538604
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DAD7300B74A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A04DB57C;
	Wed, 13 May 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRkxBtMp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E044BCB5
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694810; cv=none; b=OB9BXdeSKXSVP+tqKwaEEGZcq/V4lHzfwxfwCIY9tnB+clCpRx5NOJ/JpYqxjUufIUGQjrPySeekEh8u4SMdhY994gSHy5ZSLyj4e3TvvZjYM1CgZ34ZhNeK5j7P2x4qGuNBMiRO7yx+gGoT5QzpqgaiTEgQEzhehTi1QZrM1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694810; c=relaxed/simple;
	bh=kyyEkN8frKyJVc1RJ2k2GYGfNMlRTxtX3Lh4S2uZeZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggB/n/LTjdV1nkaUWB9m8MKAOgGAfVAAIFUfQnV+/3myQxKxJBsz4AAd49ukB/GhsfGsO0ORumk2TIHT/fy6MyGDLRgebIh5EBLbttZAcLWs0pbFw3DSX2GISrpYB/vxW7jPwzKgEGzwnqWH/RFMUEi4q3rOywZZgexdc/a2bTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRkxBtMp; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso92493126d6.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778694808; x=1779299608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABoJbqvWqHjcWf8HMaYBzFu6AOtX8KyytzjO7kAvJdQ=;
        b=CRkxBtMprKm9tGg8vySALuEoH7kEcM9mK5H2UlajMzXkEsxDhsgiE7jtAfW5cBrSO9
         cWbmeauFzGW0rxoYZOCOIdO6illTIRV0mKQ2pRQIHIVPYY7Kfleav4mZakDLcP7UTEwf
         JtPVna6slybpL0/qu2IZulZi3JtrDx3SndeCPVGtvtKc1rsDIqXlQaRsJrWyIIzm3fIY
         pTcqo8DzufPybup7dKMmcGmEE9sggqEp6H+qa7LckTvupVNN5654DnEa1r9a7DGAG3A4
         cGnih4n2beQ6SCqRZW+bzIAgkh0R0/BJgmey4OnkVLNdgbQhbqS6hFr1Hzcpy0ybXOw0
         OwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694808; x=1779299608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABoJbqvWqHjcWf8HMaYBzFu6AOtX8KyytzjO7kAvJdQ=;
        b=CsG+6ie8bSYOSu7UR60VfSDoAEfe64yQKA1cQanVPyLfkHl9pn2L2iQfrKHjXqZjdS
         G//Z0uzqQxvgY5RT8FKqZE/HECWhBNGcvIQvAxxYk+HEGSPzJaHEDMPiRTXxJodX0grD
         WlbTUO+FS9llPcPi2KvStliRYIOU4d+Ugt8uQ+ACi6LFVpBOInU8ghD1UJoUnHgOTd78
         8yomFerOZNvIWWsBw9LwCXe3tN/E92YMnn3WGjuiOl9gUTOgxRNiimSd1cbmeiJlI1gl
         q1+OlIRBThFpxcQZGsPQqCq130eaLJEV65t0S2OGdUEM0J6miYNhlKUNH0jcAA762pXH
         ktmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vbHbXfLsigN1lxHIYGfgyBdZ2X7xGzUm8yHj/h7/bedHlZl3yOAK7Du5SPWmy9tocHP2MSHigMVEb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42wHBXl+omz99Wc8th5MXdmvyUnLHU5RUKd+et7tlONawOXMB
	AXqxxIWT2EjBjsLCJDXZm1f0Kx+fdUn6RcudFb6pdPGf6CR+4WOU6nO8whiE9V1H
X-Gm-Gg: Acq92OF9szmj29ybbXZvReYg/kC7NbXQLhZpijyoUiFVftq5aI5qNtMt5gHXbYTYcBb
	wzCvNntgWlPSJHeVnhBAxGI/qUQzNzOYnn8CKP9BY23RSTCBbbZ6J55pB3aw8K93jehbFBXCpfk
	iy1FMZ5A5tN2AX71fUS8zzBsKO1mKNbabz6lb2sdtB/N2vWOQN0/QRaN8YjyiCQRlAosdYwCZZM
	T0ILq2R/H0nLJjokyXbx62l+V+bhUUTK+yrGrY7Z1wwTe5LY9B7GfWxmyRPuajuSU+QUq+TlR5+
	QMB3MFHlX7/8qAuDOFtnMs4DpuanT8mTxbtZ2gMkdfHAYnKDYjw67WWX6D53xFhQ5IPIpQsB3j5
	t5AKj+xG0vQW065b7oB9fPaEjtlgMAFMfQAIoS4Qo5zIMzR+s/x4aEp9iomL7lFnHzZlcIcVnM/
	VntYvjoUpL08NulkFI83T8vBpoTecIWW51ZzSa0CY7zvGkRvk+jAAKsiIGUK6QU2mKB3mQk1bUv
	iHPIa34szJ5SUpMwPHdj72qUY2Jr6DmAfzqVqDrrElkz6eDO/pdJA==
X-Received: by 2002:a05:6214:328a:b0:8ac:b264:65ed with SMTP id 6a1803df08f44-8c7b9e64d6fmr70189006d6.6.1778694808171;
        Wed, 13 May 2026 10:53:28 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bf6720asm2036946d6.39.2026.05.13.10.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:53:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] RDMA/siw: fix MPA FPDU length underflow + add KUnit coverage
Date: Wed, 13 May 2026 13:53:23 -0400
Message-ID: <20260513175325.2042630-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 96AC7538604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20597-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Action: no action

[1/2] fixes a peer-controlled signed-int underflow in the Soft-iWARP
receive path: c_hdr->mpa_len (16-bit, on-wire, peer-chosen) is never
compared against iwarp_pktinfo[opcode].hdr_len, so a malformed FPDU
makes siw_tcp_rx_data() derive a negative srx->fpdu_part_rem that
flows through siw_proc_write() / siw_proc_rresp() into siw_check_mem()
(which accepts a negative interval against a valid base) and on into
skb_copy_bits() as a signed int copy length.  Under KASAN this fires
as a multi-gigabyte OOB read in the header-copy branch.  Full root
cause and the KASAN call trace are in [1/2]'s commit message.

[2/2] adds the KUnit regression harness used to validate [1/2].  It
is split into its own patch because the test brings new Kconfig
plumbing and a new file in drivers/infiniband/sw/siw/, and so that
maintainers can take [1/2] on its own if they want to defer the test
or treat it differently for stable backport.  The fix in [1/2] is
tagged for stable; [2/2] is not.

The harness has three cases.  Two use a constructed sk_buff: one
asserts the new check rejects an underflowed mpa_len; one is a
regression control with the minimum-valid mpa_len (zero-length
WRITE).  The third opens a loopback AF_INET socketpair via
sock_create_kern() and drives the malformed FPDU through the real
kernel TCP receive path (sk_data_ready in softirq -> tcp_read_sock
-> siw_tcp_rx_data), so the same chain a remote peer would exercise
is covered.

Tested:
  - UML + KASAN (inline) defconfig + KUNIT + RDMA_SIW: all three
    KUnit cases pass with the series applied; the stock tree splats
    in skb_copy_bits with "Read of size 4294967295".
  - x86_64 modular W=1 build clean on drivers/infiniband/sw/siw/.
  - checkpatch.pl --strict clean on both patches (one false-positive
    MAINTAINERS warning on [2/2] because the existing siw entry
    covers drivers/infiniband/sw/siw/ as a directory).
  - git am of the series to a fresh base produces a diff identical
    to the validation worktree.

Bug exists since commit 8b6a361b8c48 ("rdma/siw: receive path") in
2019 (5.3-rc1), so all LTS branches with siw are affected; [1/2]
carries Cc: stable.

Michael Bommarito (2):
  RDMA/siw: reject MPA FPDU length underflow before signed receive math
  RDMA/siw: add KUnit tests for MPA receive parsing

 drivers/infiniband/sw/siw/Kconfig            |  18 +
 drivers/infiniband/sw/siw/Makefile           |   2 +
 drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c | 349 +++++++++++++++++++
 drivers/infiniband/sw/siw/siw_qp_rx.c        |  15 +
 4 files changed, 384 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c

-- 
2.53.0


