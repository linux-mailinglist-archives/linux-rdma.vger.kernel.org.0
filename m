Return-Path: <linux-rdma+bounces-20995-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIDxBPTHDGrAlwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20995-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:28:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3764A584B24
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14CD8302BF4F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F303BADAA;
	Tue, 19 May 2026 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RifF6gnP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D83B9DAC
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222496; cv=none; b=lX4aY0i8M4GBOgmLoebd6FP2Y1ptli+bY3IIxxMNActS4xM2X0IFYdj/aZgZgC7c5/V/c04KnaNKLfGm57aY1M38OV7cpcLFiiZkH1aZdWthhZfwiFpRCbWvdKELNpIpZf+Jc6LVmKKSJwv7G2aOuJwoVzI2pLG7vlf6R0D731k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222496; c=relaxed/simple;
	bh=h+opL5sjrXApX9lhRQJRTMACzgnfsVUGzcENRpKJzAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6NdG3GuO0els7uLQxOEBnekVOxNBLfqabXveBuzVImU1lb6U0eEJqQov6tZS9Qq3byzDicf6FLigRM+aBhov+EhxMXnx+4JIPnB9i+9vwsiMZJOMwZyRbPI3Vr1gPKiVlNWKedkvI7GnjBHQZWBO4SttsGkO16xIDJuGY/EmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RifF6gnP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1844812a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779222494; x=1779827294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8GywxHlqCZI7WpNixXQesnEQTxELbXrTJTNO5sDDRs=;
        b=RifF6gnPi2Y/y8OOPWYOITGNNxQcAl6RWmKIbEYJrOuorcV4sahjfgHc0bpd8yX81/
         lANLKHawpRCiYx/cK8m8gGm44q4YT0nHmRCJNQ31AXoRbhc16+OVxk+RwIKnrV7OprN2
         PbSec+/vpu31nL9Som0L4EXmeL220I0GilUaphzBiQdhOdUoDipK4WbWCosXDBVk7IYu
         ibnQQQ61dWhUwEGpV5SngJPGbIDZ6+oq89DCsSYfDRKQh7z7DFH8XsQWAtX19u1K+ZBv
         FcL2jM6lVZRYwLi5ZMsNthoZfECAEEr/EwiACeLYIsqizPBHrbfnkNiyAqvBfi/BElG5
         1Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222494; x=1779827294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8GywxHlqCZI7WpNixXQesnEQTxELbXrTJTNO5sDDRs=;
        b=YjnSh6aS8jXRUKL7kvuS7I5CZVCTdeyO4n38O1R5Y+io4/Ln1PzRS3DdnapkkteFVQ
         QXOc0o1i+f5CPtCuFTz6ymrc3t6FoeLUw/XGpnZfJC3idOZ89oKGdaSmPiVFSRO5RSK3
         xdhOz78e/hR8NHjqZk78EsW0OlxLjVxYy4aC2ukXXPzuUys/sMoqkDDhF5F2P3fEuZBG
         sbJGKZX+UO5zwO3ryPGSv4LvRiJzal6VM9vyUEVlrdIgaLceGAPYYoUNZ6gPucw1F/iK
         wAOWnMhJ/nn08LC2bMwQ8mzT4I7NdOVtJV2rFJQEdL70Tv9DHlSDpPdJwTbuD7miISUc
         Rp9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/VLU2aETAdk9WVRfbTHkRWf550q8rpiyU/UwCxK90UQRQk1PAgUFk8MTB/waT4TyCS78PLQPisyguc@vger.kernel.org
X-Gm-Message-State: AOJu0YwDriaOjcUOl7msvBM6MoRIrcaCYnrrqosaKNjBTdHgVp2WuIgG
	rP+TK2noZpwh7YAyD5GVSICEs1MDAGfCSZpALl+KdNcZAOL8sc9oJ9Oc
X-Gm-Gg: Acq92OEkaHhkIHIzTjJReZlKk4T9b2CedF0n9tVVd3JQfcf2gLZ6T0dBrpmOeCsagFG
	040ttCtX1dm5GHTGoYFC3GDYzUFHp1OIzTe9ouakDjvDn0w34fmmFVRs41Tb+7zpAqze7p6/IRf
	rScZu0RuRs66eIUsQLFoblYLRkyI6NSODqu7e9QtJfUFYZ8u823GYgTi+htU0Yc434Z7lO9DQSZ
	GfZAXN/ZZxZPUu8K9wX+ppik45mKq8ujINne2V/nElIZz57neGKpO354BxWg0lYEN3ajjxk87M8
	c74OTJeMuprUDOiTTUjEHFivaaQYJ3IgspCrm8zYwUXyPIJfS/F9iFlqPp6Gyc/CESBAl4u8Dct
	YPPTKi65viHA13shIeXpsISPq8HaD97xcHBob7hW9fdsSqVz6WVAfbvokLPpJ0WSK1VegfqZBIm
	iooR4mZrJdYubRPcokTmuturbX3GufM7+4tYZR8cQmTuJjgh8u/M1B7/g+wUA=
X-Received: by 2002:a05:6a21:600d:b0:3b2:6988:a6f5 with SMTP id adf61e73a8af0-3b26988d373mr15231355637.4.1779222494392;
        Tue, 19 May 2026 13:28:14 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82c4031662sm16874478a12.16.2026.05.19.13.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:28:14 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: RDMA/hns: dead empty check on head->root in setup_root_hem?
Date: Wed, 20 May 2026 04:28:09 +0800
Message-Id: <20260519202809.2437430-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20995-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3764A584B24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

While auditing list_first_entry callsites, I noticed a place in
drivers/infiniband/hw/hns/hns_roce_hem.c where the developer
wrote a NULL check for an empty list but used the unsafe API.
The check is dead code. I would appreciate it if you could take
a look and let me know whether this is worth fixing.

The site is setup_root_hem() (linux-7.1-rc1, around line 1270):

    root_hem = list_first_entry(&head->root,
                                struct hns_roce_hem_item, list);
    if (!root_hem)
            return -ENOMEM;

    total = 0;
    for (i = 0; i < region_cnt && total <= max_ba_num; i++) {
            ...
            cpu_base = root_hem->addr + total * BA_BYTE_LEN;
            ...

list_first_entry() returns container_of(&head->root, struct
hns_roce_hem_item, list) when head->root is empty, never NULL.
The -ENOMEM early return is dead code.

With an empty head->root, the fall through pointer aliases
&head->root inside struct hns_roce_hem_head. root_hem->addr is
then read from memory at a fixed offset inside that struct,
producing a garbage DMA base address that is then handed to
the hardware.

head->root is empty if the caller fails to allocate and add the
root item before calling setup_root_hem. A future caller could
also miss that precondition.

A candidate fix is a one liner. Switch to list_first_entry_or_null
so the -ENOMEM early return runs.

Similar dead empty checks after list_first_entry have been
cleaned up in the same shape, for example commit fbb8bc408027
(net: qed: Remove redundant NULL checks after list_first_entry),
commit c708d3fad421 (crypto: atmel: use list_first_entry_or_null
to simplify find_dev) and commit 10379171f346 (ksmbd: use
list_first_entry_or_null for opinfo_get_list). The qed commit
message describes the exact shape we observe here. This hns
site appears to be missed by those cleanups.

If this is intentional or already known, please disregard.
Otherwise I am happy to send a [PATCH] or to leave the fix to
you.

Thanks,
Maoyi Xie
https://maoyixie.com/

