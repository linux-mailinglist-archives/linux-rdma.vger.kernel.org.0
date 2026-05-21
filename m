Return-Path: <linux-rdma+bounces-21079-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHDtOLW8DmrXBwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21079-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 10:05:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A0E5A09F4
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6657F3007BA8
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 08:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377A384CE8;
	Thu, 21 May 2026 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrOTN9TJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91D23EA8A
	for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350705; cv=none; b=DiGMU+tFxclJr34CRWnsKC19BHOAWDCXq5/cADp2bHMNqaao8pmoPs6WVEHTMO2FunXe6XYRBV+IWfS+ZzcJwAS/H7K4Wygs1Y/EH4tVk8yptKBUev+Kc2QVpzbZdgDLWUbOZ51Dy9hAMJmkFclOtjY0cwHIW5bYWKH5x1mgOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350705; c=relaxed/simple;
	bh=hJ3CaDGNadDBABONrqGykRXqLs/LbvemhSSg9rFqzjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tdlkNwBeazxhwFbQQ6Qw2EV/069hzcFrxJaldBG6m3ZgoaOtP+5VWHrUlJXXTWe1jT3idUx3bjBeVl4gEy5oi+naawgxirbEnt6JWn9kpM8rTmkodyutZmE/MczP7wzaSNhENwk1CFitaJYfoWnLGPrghjw24CWHcYK0EwYhxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrOTN9TJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48e82c23840so46649415e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350702; x=1779955502; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7AmOEO0RXkvVI2F/Htf0K4Nc+ca8waSi/IfMmz4X+o=;
        b=UrOTN9TJBVdJtiYt1fS8NBjISbSx5nQ3FjR8JY6zRxIq2aHCOKzeZ9uOlhNiLF9ka/
         i5N4uMTwNKPGSQ4CRFtCqwEiEL5N9yGTZ2lHIXCIrkGmxJlUasilw5Bv7HWwcMSWsamC
         ykkvAkHxG6vDdoP9smek0kdzmAmPRzOLuza6aj+0NUi1pQkQXhNC+0NkMwcOt1j0JSUP
         LZRlEO0nXPrQitbQCrBVCDtKYzPEE+DgGbPMXrbJu8R5H/DeInz4Zj70znBkV6ndJyxO
         pEmyz9j6AdHwfe/8bcOrjSCO9JnAEZwq6QCFcnMPkpNk550QuS2fr3KwFRi+kZLktORK
         lm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350702; x=1779955502;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7AmOEO0RXkvVI2F/Htf0K4Nc+ca8waSi/IfMmz4X+o=;
        b=Yf4xbz/yvmArsyF2bHQhi3uMvxL7OqtBv03k5MiAZw1p+tDH3OK3dnUpZB4YBH+sIj
         W3w+YnnQy/mBKitij2sA10b4v4brRHO21oLR7U/mdsbV9mqDn1DjNP8yDlRTEr9Bdupe
         ksBgSsciz1CBdrqdYQ0AFTd5BmBp5uF1OFiJfiPWkvS7IWc/7MguBhjGyX4fENcZ5NFx
         lGnlT4ewZR+l7bySxmBp3QL1V1NgHHRy4UUIULz5dxTKZPAq4JQ3JS44e0BCFmG/1Vzv
         7DuFqXSexp4sRZu6syc6CIAoZUSJPb03AAvM1l2nIuXeP4CiRsfYzXcl7SpSBHBJdvnW
         Ujsw==
X-Gm-Message-State: AOJu0Yw1GtqWBJrndRhtFzrtm3d2XPALyIBPMpDvLH5/QmzCOGt2VjB0
	QpcebuENC1e8ayS2MW0eV0r0wGs7tm/YClk5ViV0wqTY5TYgpHt3XsQw
X-Gm-Gg: Acq92OHANAPuW6YTMZn/DHM5ksjsrqq17NutEuDBmExDblVWjHJQK1JzVvWkxzzvd1G
	RAo5v5tQ2P8HoAdpUK3m+Cg3Z5xl7OY/jMOZOq6vqdNRlNQ1ykDGoepvkaDirPz/QEyAQ+2x58J
	NfYDL8EnXD9fz7oVnXhdAd+BwmTTlnaEH1+FSW+yZJKtBhzjKA1avXt3qUt/h3pBuoIcg2y7FEF
	lL5yf/quB6tRU3xf+37Di2qbddcbbfGAmTj0aTXw/xP6BKDwlgP3huBlNz7Kz8OA8A+MHAt8+/n
	H4NmFPqQZb5JTkv7k3L4HCwfniGcKpxVqo4tHFNkOgC9vqManBgd9Ti0gZzxjWsoav5sff/9qLX
	HWUsdn8lHsxbn2xNT5WGVkfaVwTA4tXpQNjfM+nuBwbDEL8k8wL5ITXT/qXYbil8RLTSIeDMyOT
	KFswxhluAoc89Xz+vlPwiF7wD1g4L9iT3Jqg==
X-Received: by 2002:a05:600c:1547:b0:48f:fb0d:8d86 with SMTP id 5b1f17b1804b1-490360f3d25mr25156305e9.32.1779350702018;
        Thu, 21 May 2026 01:05:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903c995f13sm8261425e9.3.2026.05.21.01.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:05:01 -0700 (PDT)
Date: Thu, 21 May 2026 11:04:58 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/core: Introduce a DMAH object and its alloc/free
 APIs
Message-ID: <ag68qoAW3P04J7pT@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21079-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 86A0E5A09F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Yishai Hadas,

Commit d83edab562a4 ("RDMA/core: Introduce a DMAH object and its
alloc/free APIs") from Jul 17, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/infiniband/core/uverbs_std_types_dmah.c:50 ib_uverbs_handler_UVERBS_METHOD_DMAH_ALLOC()
	error: passing untrusted data 'dmah->cpu_id' to 'cpumask_test_cpu()'

drivers/infiniband/core/uverbs_std_types_dmah.c
    40         dmah = rdma_zalloc_drv_obj(ib_dev, ib_dmah);
    41         if (!dmah)
    42                 return -ENOMEM;
    43 
    44         if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_CPU_ID)) {
    45                 ret = uverbs_copy_from(&dmah->cpu_id, attrs,
                                              ^^^^^^^^^^^^^
cpu_id is untrusted data.

    46                                        UVERBS_ATTR_ALLOC_DMAH_CPU_ID);
    47                 if (ret)
    48                         goto err;
    49 
--> 50                 if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
                                             ^^^^^^^^^^^^
You can't pass untrusted data to cpumask_test_cpu() or it results in
possibly a WARN_ON() (most people have reboot on WARN enabled) and
and out of bounds access.

    51                         ret = -EPERM;
    52                         goto err;
    53                 }
    54 
    55                 dmah->valid_fields |= BIT(IB_DMAH_CPU_ID_EXISTS);
    56         }
    57 
    58         if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE)) {
    59                 dmah->mem_type = uverbs_attr_get_enum_id(attrs,
    60                                         UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE);

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

