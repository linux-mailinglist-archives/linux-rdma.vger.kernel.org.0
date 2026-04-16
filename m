Return-Path: <linux-rdma+bounces-19383-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBiVMsia4GnokAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19383-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 10:16:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C269640B678
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D003188BF4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01D38A72B;
	Thu, 16 Apr 2026 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ZHgb1Pfa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451838F620
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327042; cv=none; b=jAY7zzoL9i4w6Q4Gu9Bwqlgn4qlNGODJfgfDZoZiGp7PBvZvGsGJV0sOvjefmSfZaoIqUJDJ36vbhyUypq1y0JxnHpWjpYgeb9ITP73KUms+OUGs6q/t36WfxP4sAK8IG+navFWw1BPZmNIYXNM1+t869X+UPBbBB5IG9UxqSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327042; c=relaxed/simple;
	bh=jg5zaFaKeUborNApjCd0f5asUfh56T+z7ogxGPEpmqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZGj7X21WYNbMkt0AlxvG/Yugd6vLeC3XoVWavT1IiKME9M3RZNfVxiKSfCRsyXReyWy/GZy5pBDG4u4/MkrBSrRMI4VlaSRQbUhzUZ/0uJ+in6jHnHaNEiu0JciGGCDlsQQkuURd5xQBpeWres2xHjZF3Afkunc/xypSg2ZETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ZHgb1Pfa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso125760635e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776327037; x=1776931837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iia17LFU5lZBgfBQq2iW4nYXKngxri2AJ2e7eZmTBLE=;
        b=ZHgb1PfaeGNQppqb4NpzhX9qyTVN8kpvD1bejGBb470tzNc0++WKgEMg/vr6MiiGqo
         nhkQorMt2OCDzvLzPCjhXetOKtJC+Brdt7Wa4uhB9PFCEDOwJtu43RpQeFGcfghtAn7U
         LjY59q8qozwsVxLOyJhWplzV12w41eBB1DBZDs7TWDAwRR3X83qWIAFYHYVrdudfty+m
         Yi5NEcnD8MoClBRRu1d3oTDzAmJERkY8WzJZFo3PQSgC4/cN8iJ4lEO144wimUVMnbZ0
         BsFYsskDsX813Fd+moj7CRJV6rHKyAVHTIfEErbeaeed6/skx9RRRUKuamhctvzMwJwt
         sk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327037; x=1776931837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iia17LFU5lZBgfBQq2iW4nYXKngxri2AJ2e7eZmTBLE=;
        b=QPvHr/8hxOfWQdZcluYs2HvdgGIiXNx8aN58DPoHqgE/KKK/OTWJK6qxlZLkf9hGso
         J9JWTUYomVys4pkdh149NJipQLZaNw8WThAiytz0El4fUtXei+47R2yYM7YxkOB3ti2X
         EsVabprnT/Q27TjU/wk8qinDLrdaWBk6HjtydVVM97BJWN3M+Vpw7V9eTpdUQqco8jwT
         z7lIaqv2qzsRvlBYCO55XEg/SG5Il+0z9C2sxjI+ShddtSwgXYOXOTi8aYAZidqDwSBE
         +VDF9UeiYQEWaG8P8191QborZD/MTbIXTULwlMzGhcCEColFrjkTmjl0mV+myTb8hkpL
         ihFg==
X-Forwarded-Encrypted: i=1; AFNElJ+VYxKwgmh4u3lE3gsXloPcdNuLbN2cDKWQ6bRHEiMYIgKpEhckFbPPXlUEXGUHPpeNeE0DJF1U85qe@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvi+uZKa/462teh8/W6wHy9AfA7I5swuDUGj35JtfBR+dlG/wr
	sQ58GWlGOu54P6mXbbQ+oqAQl8F1FIS8pM6sSHLsx5nSFlbbC8FLK7Zegyc0o1ose5FUyAphW92
	/nMsc
X-Gm-Gg: AeBDievJLvRyKsKSHEbguuLKEPO5oSpJvsBD47k8CcFP3s8XyYoMo7CbTlvwF6p1onG
	/7BkOQNQoMWzBuuqTZ5E76LD0oziwFnxBZof//SCjICEyra5tJaObU3oNQgHY2qHZJP+2a5mjyi
	QOSm1035eL5iWniNw4Gu0mjM2m7Nc0wa9434xiTKOE3CR7t+gVFADU8PLIUp+pOqef9+Iz5YHWA
	k2MakRM3kT7FAotcSet/TU5GURGCOC9rmgZ822YSMYQfknH2Y2LvdHlYGUVGyS5ymFdx+PdLg9z
	q4bE9RBJDdO/oOfllYWtN1T010OxlaDzkjFRufvf9Hom3mDj3hE1okppgg7/MGXqiGD2O3nzBr+
	lVHcPbyaLThNRz3ehuFwj08AkIo5/0wLN36yyUwInVwE7DaMhn8F3hF+hfwPpm1qnN8hId6VoBY
	9Z7r8oTHLI5mq6lYLx7b1kq2tywM7uOGgv1j3Vy/MypkVjmQ==
X-Received: by 2002:a05:600d:d:b0:488:c14b:201b with SMTP id 5b1f17b1804b1-488d67e737amr268167565e9.10.1776327036805;
        Thu, 16 Apr 2026 01:10:36 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813954sm30409085e9.3.2026.04.16.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:10:36 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:10:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: syzbot <syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com>, 
	jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [syzbot] [rdma?] WARNING in ib_dealloc_device
Message-ID: <ymvuyxjfiyfo2da2cqftjcan3lqr5onofnrcb52cubigsh4pnz@5u7e43rrumdo>
References: <69dc3310.a00a0220.475f0.0018.GAE@google.com>
 <20260413154353.GK21470@unreal>
 <tinnwpbb7kwhfp33lfltl6ryaymuamtimac7xenbqhsbbofiw2@xgfvtcs5yjwk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tinnwpbb7kwhfp33lfltl6ryaymuamtimac7xenbqhsbbofiw2@xgfvtcs5yjwk>
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19383-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,resnulli.us:email,msgid.link:url,appspotmail.com:email,syzkaller.appspot.com:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,03393ff6c35fd2cc43de];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C269640B678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Apr 14, 2026 at 05:57:19PM +0200, jiri@resnulli.us wrote:
>Mon, Apr 13, 2026 at 05:43:53PM +0200, leon@kernel.org wrote:
>>On Sun, Apr 12, 2026 at 05:04:32PM -0700, syzbot wrote:
>>> Hello,
>>> 
>>> syzbot found the following issue on:
>>> 
>>> HEAD commit:    7f87a5ea75f0 Merge tag 'hid-for-linus-2026040801' of git:/..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=11778eba580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=03393ff6c35fd2cc43de
>>> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>>> 
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>> 
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/0f5deca1373e/disk-7f87a5ea.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/6aea6c1c6b6e/vmlinux-7f87a5ea.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/61444b289e96/bzImage-7f87a5ea.xz
>>> 
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com
>>> 
>>> ------------[ cut here ]------------
>>> !xa_empty(&device->compat_devs)
>>> WARNING: drivers/infiniband/core/device.c:682 at ib_dealloc_device+0x187/0x200 drivers/infiniband/core/device.c:682, CPU#0: kworker/u8:37/4856
>>
>>I think that we have only one patch in this area https://patch.msgid.link/20260127093839.126291-1-jiri@resnulli.us
>
>Unable to find a link to this patch. But I don't see a scenario on which
>this WARN can happen either. Very odd.

Was digging a bit more, still unable to find the issue.

