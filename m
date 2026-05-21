Return-Path: <linux-rdma+bounces-21107-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL5jL6n5DmoSDwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21107-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 14:25:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A95A4BD9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACCAB303CE22
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061683CC333;
	Thu, 21 May 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP/Yp4Nr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7633ABD9D
	for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365916; cv=none; b=J3YadSohJzfvZdiF+kQ4nOgn4rHsUdJjm6RsBq7VG2Il8W/bKYaX1LP0Wa2zFM60r4PuJnxFo3RDuGfQMU5xexb+4AJ4m2QnmnwU+RTBev3zclHGw0QNIl59lhkAn/oZ3dZfesyqQ/Dbs2F5YZM02ElN5prtR+9/suXAQZiNS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365916; c=relaxed/simple;
	bh=HtwDPG6W/lLqxCTe1skDU9i0E3olOqnVBwuiH5JgP0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pmWz2+UaM3q6dv2jsSTUm60FbGwyhzXA1XgLne2fP+QTa+sHIdvWAxCiIZGLFNHP1zXSfVq1McqyMsurYFVO/4x/DbJepryrjNWrMw680ywZyZ6QQQvCYZ9udV/MQjuxmR1hrzVWySSD7XHmIjVKI2yPTSJd/Ok1MbK6P7JQNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP/Yp4Nr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso3325362f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779365914; x=1779970714; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtwDPG6W/lLqxCTe1skDU9i0E3olOqnVBwuiH5JgP0w=;
        b=VP/Yp4Nry/BXjBN8P6NlW+k25JD3eFLY5lvByN+jqUSmhu04fT6jOKkVr4WYJXC4Zp
         kTN74hVdvxxqI6EhK+Z7Y5At4ZEq5p4fhcHtsAplonmJa+WzySzzbBShhfK2dIXrWPJb
         Zfp8Fs7BLOV3iMuz4lpzQJ9O5ZpgrGgZjMq2mahj1JPdJKWuogAKV9I9h2XS7FSegJ/u
         Mn0lt2+uh3NDww19rSmjx2shc8os35KOyRUfLonOyuzqC/6abe8cdLQYRuOrfFx9SZTn
         3C1dartJNmxrv60Ku6iMINJEWkJpCFTvQTc9lcjwNT3Bk2ioWSAgnYc2RgmyaKx0Ml1W
         +CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779365914; x=1779970714;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HtwDPG6W/lLqxCTe1skDU9i0E3olOqnVBwuiH5JgP0w=;
        b=nYBGwsFRuKBY2m5qEYwXpeOfDOoyFXLpL4xg+1wmqFGHKXaRQs3FqZpJha02u+Sq9H
         wVLPyNqurG8fYOUu38ljsRG34vRMkveL4Eqr1N0JINwQaTaIhD4qPe+Qt9SHZqNAqYRj
         cApfDZurtkwL4zKZW+SZKwlNqVxIJTCNBl6PVajHa2PFopbsWb6+1JQfMVmzoerEoP4d
         FkkBjTSVn+oOzYg/WJjLsLktEdeda9x/r0sf0Pf1JwV95xs7rpNNR9Qml8IhMc5uOPkZ
         91jtrz5VdKE1kuCTmdCrfM5HGEngF226xKzcTxGex3hYbWHbD+F3FID8Er+g21nWhmAY
         7L2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9uIbdd9yoVELFGtLu47nijzwO1CVje/k6uG64XmYwL6dz8gCTuT5JQ0+wdL4UZZVmjLyz/kbjTCoEI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tRXlVxA1WJEqrbYJgQciHMMzFG7IrtqxxRuWPh6JxD8mM5iY
	yC2c8f8PgBK+LemZBL/+H8bmOiXDuqd8jYHgkS3lJxlgAOW+4pMaaiQ=
X-Gm-Gg: Acq92OENW6IAJIlUqg6AhgjvW9gGYMcfeH1iL9fsWoM3kj5WQO485vhoOWC1YkTkpbm
	bq7LrWrEpGwv6XbwPts+ptA0nMrfmnjtjsvkUNna3Oto2iDruVuYRYZFFAbl8BWGKZQz/Rx3zGV
	yafZ/OGc+q1pp1ZRjTiUIK6GZ5z/dbOro78sLNXSVKbrnzLNecaZZHPkwGTyyt/WwX/0oazXH+1
	DnDISU/oSTTpGBGrgFXxqRQhmu50pfnaVawvAgucU9DF+4tgzlorCtP3OJjxmiBL7mRp2xPt3re
	xwS6uhC4QRhPN36EvPUndTL1OC/SPycb/VQBYMkeihbI39e1vtZ4UGZ76frS18cUenuGWe7fIUZ
	uHQ/G4ncj+5Sv6O2Q2knf93ChCSd1R25OdAnpJTPnTlvyFQjrChK7mdP50JJ3zq8r2g==
X-Received: by 2002:a05:6000:18ab:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-45ea4129de0mr4332844f8f.37.1779365913418;
        Thu, 21 May 2026 05:18:33 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cdcc3sm2738049f8f.8.2026.05.21.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:18:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
Date: Thu, 21 May 2026 12:18:32 -0000
Message-ID: <177936591204.388755.5473985581960215738@gmail.com>
In-Reply-To: <47169436-4652-440f-b9f1-325d281f9ed1@linux.dev>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
 <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev>
 <20260519145610.GA33515@unreal> <20260519150042.GL7702@ziepe.ca>
 <6a0ce47d.096dab79.284c84.5b30@mx.google.com>
 <6cb1092d-e3d6-4596-92e3-e0c7030680af@linux.dev>
 <177927858387.523368.14013568639772229181@gmail.com>
 <47169436-4652-440f-b9f1-325d281f9ed1@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21107-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C8A95A4BD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yanjun,

Could you confirm whether your Debian 6.12.86 kernel was built with
CONFIG_KASAN=y and CONFIG_KASAN_VMALLOC=y?

The stock Debian kernel does not include KASAN. Without it, the
out-of-bounds reads are silent -- the kernel reads past the allocation
boundary into adjacent memory with no crash or warning. The reproducer
completed 152 iterations successfully, which means the race fired and
the OOB reads occurred, but a non-KASAN kernel has no way to detect
them.

Rebuilding with CONFIG_KASAN=y, CONFIG_KASAN_INLINE=y, and
CONFIG_KASAN_VMALLOC=y should make the violations visible in dmesg.
I can share my .config if that helps.

Tristan

