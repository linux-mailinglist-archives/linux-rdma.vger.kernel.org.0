Return-Path: <linux-rdma+bounces-21148-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKs3O9jmD2r+RAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21148-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 07:17:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D085AF099
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 07:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E72B307FB15
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 05:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEBB1A267;
	Fri, 22 May 2026 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="hTqP4+dQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3574364E81
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 05:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779426543; cv=none; b=BPNW4t7d2wZVfwYriJjv7eJRT0UojDS2A/7yDc7F4LxFeIHpUSiTe89U8Nhfw3Oqb5IWLecRpRPv+3ZKk/VLDGXPIVh095eeAW8lN2FBcYsvStED1nprQkDMc4QCZHv++qHRs+1CYqQi1blD7KXzgVkvRGTpYvM26pkwu8+U0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779426543; c=relaxed/simple;
	bh=NkvD/6z5PxHoDeUDNemV6zEaq/cU+OWRVRkadFNVzJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO47Fa72ZIU+NvarFV0c9phC/VPzFjfyVMlTkgLhyzFqwvF3K0oY7MnVAW+uEk2i2Sf3ka/Bdrp5bRB9zPjkT6wEMIjeYhVA46WpUzyRQuXRVD3bzwxWGOzvBxu5O2lAs0ptyKTJZenfMiavBpGKDs+3YtTXwmuLjTx+40s/uek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=hTqP4+dQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 97A453FEAB
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 05:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1779426536;
	bh=60NKKNxtT9Il3Mq63R2ogOWMUGMUCB1FdbJonMkcvks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=hTqP4+dQcMPlQc51WeuXXzSJiV+dfIKv67IbN2KcECr0ZIn1EQuXVRDwlcY0yncg4
	 VU0n3TPrLgJdyL645HzNmZXgAA2Sot8l5Am9SK2TgXapSK+hKBPwbazbpgswNeuOZP
	 WyezuZi1PdmWaifHHJPxzj3+EvB+uqRLiQjLWJQHuxjjtOSMe70KHJaIxXQ6B+/eii
	 NXbTT5hDYz1a2MP48wNBMIBfioV+vfMi+MuKjIUmn6db/7ygkkVHJmiaPKmbXT8JLG
	 TOq8hQWKndeEnDIFiEW7NlrGTUm+8Ph0HFr0JkYP8XavfxInyUMgzm1M8zFjgvyrtu
	 tixNIw4rA2ibQsiA6V5L61CGAtCynkZi0MOkNMqgRrUjIkVfUWgYsjTNCAIpZGBSAY
	 dZF+0qUtB+UXZL4nCBm/9wSeyJNzYt8Z0TvmhVQc0FMjao8kxzKin+t/xsC5u2WXnY
	 enjmn6YSzVGFa4xw4RUis7vvePbmohIkV0BZrPILaXl2vpOam0xAmv+TZwRZUpQrxE
	 ZJmbkG9ByhvMzznaRN1xX8tk5GK9A+NgCAq+odMl2o6htPx7Tx4jPS/82ncyZHwaUS
	 oLXz3x4X2LNNXirV02xphzt9Di8JQpaicdG1knkO6/ZiSU39Th3tQYctv0y4TTjXdD
	 JPgra8TRSryLtsuBjS0LrlxA=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-369467ab5bfso6125539a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 22:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779426535; x=1780031335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60NKKNxtT9Il3Mq63R2ogOWMUGMUCB1FdbJonMkcvks=;
        b=KY6Jijc2wUKhgOxedcZJmspi2EuFBU6OFKGxe1qGNdSR+DNPqQzKDRSDYLdccqVxyD
         emcRSTb4rq24gD+qJA5FXuCn3nY0PgRs99pqiTnGsTPb1O6CDW1uA+b2GZAZ1hNHCSsU
         MBPJWrQPy4jVHSfUb1J7OSmnuZncZM9mKez/GfSIcCzEkSCpSV4+tC2r1dTGibKaQilP
         85gyLy1ws6uJWIDzZPa8n9j5SGT3wx9xparf8l4uf+G01XXWVnYjMUnkQvaLGwFE2Ar7
         rdL47pdlsRAea3Poq5PyBPLudS7TEPRdHU9YQ8+OdiroAnDqFkO7YLFJhOxNKqUkJqKE
         G78g==
X-Gm-Message-State: AOJu0YzdMIK9nIJvN+PUbgmKNerjG0hOZYZ5HCJ3BJH+UBHld+YVWotw
	trK5YHoofJwbmshHeszIh5+XhifxjuzrchquAYweGPbVwbZzu8kY5WGMttWiRUqgUsyFgHzBtS7
	wyfXyFn5IRFL+GhbqItpl444aJOw0r2JVFGVYwOORQdxmdm+TbSE4PdvPAjsZ05m2Z+/1tmVh1R
	44OkBN9GZIzjG5kg==
X-Gm-Gg: Acq92OGh5Md6O/UOc5UPZCWVf4jCqwkffKiU8pAb6hGCDYndpAOyu183FJDy8brdKxd
	ZJ+LpmIrhbWBBa9hh10v9k+C44ENE0G6sgynzWEAAMlUpcPP1HMaR0htd8Itztx3lgzjCtGBFqo
	C9WPnGXvaDeuZuqhHffQt8mM3ztoW7QaKMJjCMksyQwHD6uXbNaizWBO4byN1WJOF3ggDXIj1o3
	X9l5EpICUhyMTGqqyjGR25Q4hkDFa+hvH1fdukv2QeKU4auvKOTL/rD5qwOpCd78QU8yvgjeaQX
	9l+/dxL6e1MX4XtR7wAwVqmjQ0eIG3GqE33adkcQhwKF3Ll1SVCdJSLE9pwe3UnyEyM7Xymk6L/
	kj/i9tUJEqhw/ua6ZvtpFULFKRczAlWBPlE+HZd3Z8g==
X-Received: by 2002:a17:90b:5848:b0:366:16d1:6a26 with SMTP id 98e67ed59e1d1-36a6773c276mr1995032a91.5.1779426535030;
        Thu, 21 May 2026 22:08:55 -0700 (PDT)
X-Received: by 2002:a17:90b:5848:b0:366:16d1:6a26 with SMTP id 98e67ed59e1d1-36a6773c276mr1995012a91.5.1779426534679;
        Thu, 21 May 2026 22:08:54 -0700 (PDT)
Received: from cnode.tail.seyeong.kim ([39.118.66.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4ce6bsm645610a91.11.2026.05.21.22.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:08:54 -0700 (PDT)
From: Seyeong Kim <seyeong.kim@canonical.com>
To: linux-rdma@vger.kernel.org
Cc: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Seyeong Kim <seyeong.kim@canonical.com>
Subject: Re: [RFC PATCH] RDMA/irdma: Suppress PF reset on HMC error
Date: Fri, 22 May 2026 05:08:45 +0000
Message-ID: <20260522050845.406895-1-seyeong.kim@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416071541.3899471-1-seyeong.kim@canonical.com>
References: <20260416071541.3899471-1-seyeong.kim@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21148-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seyeong.kim@canonical.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,canonical.com:mid,canonical.com:dkim]
X-Rspamd-Queue-Id: 56D085AF099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

The patch in the original posting was generated against mainline but
tested on a 6.8 kernel (Ubuntu 24.04). I re-ran that test on mainline
v7.1-rc4: the patch applied unchanged and the result was the same.

Testing details (mainline v7.1-rc4)
-----------------------------------

Tested on:
  Kernel   : 7.1.0-rc4 (mainline)
  Adapter  : Intel E810-XXV for SFP [8086:159b rev02], 2-port
  NVM      : 4.51, fw.mgmt 7.5.4, DDP 1.3.43.0
  Repro    : writel(BIT(26), BAR0 + 0x0016CA00) via /dev/mem
  Workload : ib_write_bw -R -F -q 4 -D 90, 4 QPs, loopback on the
             injected PF; HMC_ERR forced three times during the run

Before the patch, a forced HMC_ERR caused a full PF reset. With an
RDMA workload running, the reset tore down the irdma aux device with
a uverbs file still open, and hit a WARNING at uverbs_destroy_ufile_hw
(rdma_core.c:957, via ice_prepare_for_reset -> ice_unplug_aux_dev).
The ib_write_bw run aborted.

After the patch, each forced HMC_ERR only logged a single "HMC Error:
errinfo=0x00000000 errdata=0x00000000" line - no reset, no WARNING.
The ib_write_bw run completed (8622 MiB/s over 4 QPs).

One difference from the original test: on this newer NVM (4.51) a
single HMC_ERR caused one PF reset, not the cascading resets / DMAR
faults seen on NVM 3.10. The unconditional reset is what the patch
addresses either way.

Thanks,
Seyeong

