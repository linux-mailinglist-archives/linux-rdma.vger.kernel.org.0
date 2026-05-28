Return-Path: <linux-rdma+bounces-21467-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMfGMtG3GGqkmQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21467-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 23:46:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABAE5FA8A7
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 23:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C895301752A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2333C18E;
	Thu, 28 May 2026 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFUEc5VX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF97175A95
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004811; cv=none; b=G8cA57M19FSRT9R85+gZAApXZ+zabOSESWWQl7mLKzfvoJmJGhfuxl2p+eD5r5it67XxBoMU8e3AEIlo4TVGPS7Te54mJ4WXIc49zsnc4nBMybrhyBJ/qoKYq/Vd4wAMlA19F5qzqfnmNu6KHulVXjLvLMe8HqHtQx7Ihm/V2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004811; c=relaxed/simple;
	bh=ovgoNz4TuR/ZTuzxAU2sReZ3xQQXWraYBrj8gQ8ROTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/xMXZ5WBXuAtkZ//eVVaRSdRdgnl7WtyfdGzkaTgHrqxfNaSNFraLi6DZi6TKvQmlCVb3Sa3r8apY6sXDJsNTXx6Hc4GgS9OpNtwvTvozYzQtEV0mIee6bj0IvEGycvSYbKyg9pmaTDheBIcY2chjxvqHIBYX6LAdgtVmjOjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFUEc5VX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891b0786beso88566445e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780004809; x=1780609609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edKhjHtcEermvxsv2IrFEfp49ix/Z7E0xHHdqmcPnNw=;
        b=iFUEc5VXLH7Otl86TECB+tbTlvSvf/LV4966Da+ZXX6hDhMP7eVONoLTXs780g44R5
         wXWCqGRs6Cej6vmyLNcbiXGU6ehocxJq+yJJ05NZenXEkPI7Ff8Ylq2krxiZ8L345+9d
         eYnsLhQnzmSL/Bsvdp1dLFljp80mY/x+cF0m29/V2beAl1xShNeBms+0hEB1i8ZOzItw
         pzRcRuGUqFn4dEMnuCidwdDVROcWScwlVSon7K3LmHQHGLRopIyCO4HRYccBXPtFnJxD
         DZ310utf70ahBrMt+8VWPR52LavkaF7C9c+ik77maxSKyuf2P2+t3kHEjhpk/Kuhtjqa
         1GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780004809; x=1780609609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edKhjHtcEermvxsv2IrFEfp49ix/Z7E0xHHdqmcPnNw=;
        b=oVpR68XfjAiPTB9jtdAzqtQi673nbgeCmeyHAhgBXV1QLwtmVwEQPyeP4CjuzIPTeJ
         U24KbLhaPUxPk/6PekEhoGdORH4y3jTffjjea7MEvG1MQXrzb7SXBVNk6At79rTHr800
         bWkXZyoD9oaAm6OCZg8EniDd+5GcmmxZIQ+J5tblB3kggSCBiCQS9TuSPnlDWgAFXhRD
         p+7dqzwUSprvKSs+66eYcH2piJtiZhlRECTpJNv5mARN8c9vhQDE1ZEPnwFppL33WmGH
         wLuTXnRD+eUP1K9+STl8MVPJQkleCLwacZ5RPdMGa8rxuA6NAYhgzf0dY480IEVJWdeG
         06QQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qqHkEeF11r5PV5TJ110j07oeMAdNwYFOBKOGCLM54eRuXawIW8sQ8UNS1GfKN2Nozs/weEf/5lKKh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Ynj0D88BKCwGZ0izdv269TY/iK1976DwD5GpUBSUZB2pZvJd
	qWoNWhXzXsJ9Ud45lwPnLcygQZL/GGryUJqqn5vlb8FJ6zxLr3CSu3s=
X-Gm-Gg: Acq92OH9G9Jy4fbrEYYgXW0n8VUKDgvIdKfztLHlwUcr4qpMGrgduDT/Xc38+jAIS9B
	hGhsmXZcJlbX61nLK9abldyVb7ei4sAE7QKz9gifIUae7n0UC6h2PprWZ1kh4Hg6gGtm/kOtIWu
	98JYKyaHLbZ0uWLAlrMmhBMVl8gfysqMLoCUqkF0/2rxCD9UdzSzezqm3fuxei3CXsqgHTh1XAf
	zaYGt9ZekdTiloKy2B1aSlsqpu0WPP08UXBW81+UljThsjTVMRhW92Wm9NfC6s8CRdXxtXP4C91
	s2IlcVtE5SM3zmIJhiUQU2A32dwLljvjYLcJKvxHXh0dkFjNrpHCFWWuxilLz9X7ARD09SDRLtV
	Y/xzDL6BeYxsx9y7BI/eK5hyN7lspcRX6lZZZ69RpxlVMTs6brKuOHWZMue5pwLgtSuhDjvSm0G
	yQzDwVk4H4TGMGFy4QE8leC0O01nM=
X-Received: by 2002:a05:600c:3f14:b0:490:9699:4428 with SMTP id 5b1f17b1804b1-4909c0c2d66mr3596445e9.26.1780004808532;
        Thu, 28 May 2026 14:46:48 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a296bsm15698601f8f.21.2026.05.28.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:46:47 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	linux-rdma@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
Date: Thu, 28 May 2026 21:46:47 +0000
Message-ID: <20260528214647.2930600-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b49f99f3-ff34-422e-9e74-d31f7b539d14@linux.dev>
References: <20260518215040.1598586-1-tristan@talencesecurity.com> <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev> <20260519145610.GA33515@unreal> <20260519150042.GL7702@ziepe.ca> <6a0ce47d.096dab79.284c84.5b30@mx.google.com> <6cb1092d-e3d6-4596-92e3-e0c7030680af@linux.dev> <177927858387.523368.14013568639772229181@gmail.com> <47169436-4652-440f-b9f1-325d281f9ed1@linux.dev> <177936591204.388755.5473985581960215738@gmail.com> <b49f99f3-ff34-422e-9e74-d31f7b539d14@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21467-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,gmail.com,vger.kernel.org,talencesecurity.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 7ABAE5FA8A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yanjun,

Your config shows:

  # CONFIG_KASAN_VMALLOC is not set

The RXE queue buffers are allocated with vmalloc_user() in
rxe_queue_init(). Without CONFIG_KASAN_VMALLOC=y, KASAN does not
instrument vmalloc regions -- the out-of-bounds reads into adjacent
vmalloc pages are completely invisible.

Could you enable CONFIG_KASAN_VMALLOC=y, rebuild, and re-run?

Thanks,
Tristan

